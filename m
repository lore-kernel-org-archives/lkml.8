Return-Path: <SRS0=1210=4J=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 66717C35647
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Feb 2020 11:54:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 303EB208C4
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Feb 2020 11:54:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727978AbgBULyV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 21 Feb 2020 06:54:21 -0500
Received: from mx2.suse.de ([195.135.220.15]:35416 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727137AbgBULyV (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Feb 2020 06:54:21 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx2.suse.de (Postfix) with ESMTP id DC046ACF2;
        Fri, 21 Feb 2020 11:54:16 +0000 (UTC)
Date:   Fri, 21 Feb 2020 12:54:16 +0100
From:   Petr Mladek <pmladek@suse.com>
To:     John Ogness <john.ogness@linutronix.de>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Sergey Senozhatsky <sergey.senozhatsky.work@gmail.com>,
        Sergey Senozhatsky <sergey.senozhatsky@gmail.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Andrea Parri <parri.andrea@gmail.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        kexec@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: more barriers: Re: [PATCH 1/2] printk: add lockless buffer
Message-ID: <20200221115416.wo6ovakxt2c7hgkc@pathway.suse.cz>
References: <20200128161948.8524-1-john.ogness@linutronix.de>
 <20200128161948.8524-2-john.ogness@linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200128161948.8524-2-john.ogness@linutronix.de>
User-Agent: NeoMutt/20170912 (1.9.0)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

the new full barrier in desc_reserve() made me to think more about
the existing ones.

If I get it correctly, the used cmpxchg_relaxed() variants does
not provide full barriers. They are just able to prevent parallel
manipulation of the modified variable.

Because of this, I think that we need some more barriers to synchronize
reads and writes of the tail/head values of the three ring buffers.
See below for more details.

It is possible that some of the barriers are superfluous because
some read barriers are hidden in desc_read(). But I think that
barriers are sometimes needed even before the first read or
after the last read in desc_read().


On Tue 2020-01-28 17:25:47, John Ogness wrote:
> Introduce a multi-reader multi-writer lockless ringbuffer for storing
> the kernel log messages. Readers and writers may use their API from
> any context (including scheduler and NMI). This ringbuffer will make
> it possible to decouple printk() callers from any context, locking,
> or console constraints. It also makes it possible for readers to have
> full access to the ringbuffer contents at any time and context (for
> example from any panic situation).
> 
> diff --git a/kernel/printk/printk_ringbuffer.c b/kernel/printk/printk_ringbuffer.c
> new file mode 100644
> index 000000000000..796257f226ee
> --- /dev/null
> +++ b/kernel/printk/printk_ringbuffer.c
> +/*
> + * Take a given descriptor out of the committed state by attempting
> + * the transition from committed to reusable. Either this task or some
> + * other task will have been successful.
> + */
> +static void desc_make_reusable(struct prb_desc_ring *desc_ring,
> +			       unsigned long id)
> +{
> +	struct prb_desc *desc = to_desc(desc_ring, id);
> +	atomic_long_t *state_var = &desc->state_var;
> +	unsigned long val_committed = id | DESC_COMMITTED_MASK;
> +	unsigned long val_reusable = val_committed | DESC_REUSE_MASK;
> +
> +	atomic_long_cmpxchg_relaxed(state_var, val_committed,
> val_reusable);

IMHO, we should add smp_wmb() here to make sure that the reusable
state is written before we shuffle the desc_ring->tail_id/head_id.

It would pair with the read part of smp_mb() in desc_reserve()
before the extra check if the descriptor is really in reusable state.


> +}
> +
> +/*
> + * For a given data ring (text or dict) and its current tail lpos:
> + * for each data block up until @lpos, make the associated descriptor
> + * reusable.
> + *
> + * If there is any problem making the associated descriptor reusable,
> + * either the descriptor has not yet been committed or another writer
> + * task has already pushed the tail lpos past the problematic data
> + * block. Regardless, on error the caller can re-load the tail lpos
> + * to determine the situation.
> + */
> +static bool data_make_reusable(struct printk_ringbuffer *rb,
> +			       struct prb_data_ring *data_ring,
> +			       unsigned long tail_lpos, unsigned long lpos,
> +			       unsigned long *lpos_out)
> +{
> +	struct prb_desc_ring *desc_ring = &rb->desc_ring;
> +	struct prb_data_blk_lpos *blk_lpos;
> +	struct prb_data_block *blk;
> +	enum desc_state d_state;
> +	struct prb_desc desc;
> +	unsigned long id;
> +
> +	/*
> +	 * Using the provided @data_ring, point @blk_lpos to the correct
> +	 * blk_lpos within the local copy of the descriptor.
> +	 */
> +	if (data_ring == &rb->text_data_ring)
> +		blk_lpos = &desc.text_blk_lpos;
> +	else
> +		blk_lpos = &desc.dict_blk_lpos;
> +
> +	/* Loop until @tail_lpos has advanced to or beyond @lpos. */
> +	while ((lpos - tail_lpos) - 1 < DATA_SIZE(data_ring)) {
> +		blk = to_block(data_ring, tail_lpos);

IMHO, we need smp_rmb() here to make sure that we read blk->id
that we written after pushing the tail_lpos.

It would pair with the write barrier in data_alloc() before
before writing blk->id. It is there after updating head_lpos.
But head_lpos could be updated only after updating tail_lpos.
See the comment in data_alloc() below.

> +		id = READ_ONCE(blk->id);


> +
> +		d_state = desc_read(desc_ring, id,
> +				    &desc); /* LMM(data_make_reusable:A) */
> +
> +		switch (d_state) {
> +		case desc_miss:
> +			return false;
> +		case desc_reserved:
> +			return false;
> +		case desc_committed:
> +			/*
> +			 * This data block is invalid if the descriptor
> +			 * does not point back to it.
> +			 */
> +			if (blk_lpos->begin != tail_lpos)
> +				return false;
> +			desc_make_reusable(desc_ring, id);
> +			break;
> +		case desc_reusable:
> +			/*
> +			 * This data block is invalid if the descriptor
> +			 * does not point back to it.
> +			 */
> +			if (blk_lpos->begin != tail_lpos)
> +				return false;
> +			break;
> +		}
> +
> +		/* Advance @tail_lpos to the next data block. */
> +		tail_lpos = blk_lpos->next;
> +	}
> +
> +	*lpos_out = tail_lpos;
> +
> +	return true;
> +}
> +
> +/*
> + * Advance the data ring tail to at least @lpos. This function puts all
> + * descriptors into the reusable state if the tail will be pushed beyond
> + * their associated data block.
> + */
> +static bool data_push_tail(struct printk_ringbuffer *rb,
> +			   struct prb_data_ring *data_ring,
> +			   unsigned long lpos)
> +{
> +	unsigned long tail_lpos;
> +	unsigned long next_lpos;
> +
> +	/* If @lpos is not valid, there is nothing to do. */
> +	if (lpos == INVALID_LPOS)
> +		return true;
> +
> +	tail_lpos = atomic_long_read(&data_ring->tail_lpos);
> +
> +	do {
> +		/* If @lpos is no longer valid, there is nothing to do. */
> +		if (lpos - tail_lpos >= DATA_SIZE(data_ring))
> +			break;
> +
> +		/*
> +		 * Make all descriptors reusable that are associated with
> +		 * data blocks before @lpos.
> +		 */
> +		if (!data_make_reusable(rb, data_ring, tail_lpos, lpos,
> +					&next_lpos)) {
> +			/*
> +			 * data_make_reusable() performed state loads. Make
> +			 * sure they are loaded before reloading the tail lpos
> +			 * in order to see a new tail in the case that the
> +			 * descriptor has been recycled. This pairs with
> +			 * desc_reserve:A.
> +			 */
> +			smp_rmb(); /* LMM(data_push_tail:A) */
> +
> +			/*
> +			 * Reload the tail lpos.
> +			 *
> +			 * Memory barrier involvement:
> +			 *
> +			 * No possibility of missing a recycled descriptor.
> +			 * If data_make_reusable:A reads from desc_reserve:B,
> +			 * then data_push_tail:B reads from desc_push_tail:A.
> +			 *
> +			 * Relies on:
> +			 *
> +			 * MB from desc_push_tail:A to desc_reserve:B
> +			 *    matching
> +			 * RMB from data_make_reusable:A to data_push_tail:B
> +			 */
> +			next_lpos = atomic_long_read(&data_ring->tail_lpos
> +						); /* LMM(data_push_tail:B) */
> +			if (next_lpos == tail_lpos)
> +				return false;
> +
> +			/* Another task pushed the tail. Try again. */
> +			tail_lpos = next_lpos;
> +		}
> +	} while (!atomic_long_try_cmpxchg_relaxed(&data_ring->tail_lpos,
> +			&tail_lpos, next_lpos)); /* can be relaxed? */

IMHO, we need smp_wmb() here so that others see the updated
data_ring->tail_lpos before this thread allocates the space
by pushing head_pos.

It would be paired with a read barrier in data_alloc() between
reading head_lpos and tail_lpos, see below.

> +
> +	return true;
> +}
> +
> +/*
> + * Advance the desc ring tail. This function advances the tail by one
> + * descriptor, thus invalidating the oldest descriptor. Before advancing
> + * the tail, the tail descriptor is made reusable and all data blocks up to
> + * and including the descriptor's data block are invalidated (i.e. the data
> + * ring tail is pushed past the data block of the descriptor being made
> + * reusable).
> + */
> +static bool desc_push_tail(struct printk_ringbuffer *rb,
> +			   unsigned long tail_id)
> +{
> +	struct prb_desc_ring *desc_ring = &rb->desc_ring;
> +	enum desc_state d_state;
> +	struct prb_desc desc;
> +
> +	d_state = desc_read(desc_ring, tail_id, &desc);
> +
> +	switch (d_state) {
> +	case desc_miss:
> +		/*
> +		 * If the ID is exactly 1 wrap behind the expected, it is
> +		 * in the process of being reserved by another writer and
> +		 * must be considered reserved.
> +		 */
> +		if (DESC_ID(atomic_long_read(&desc.state_var)) ==
> +		    DESC_ID_PREV_WRAP(desc_ring, tail_id)) {
> +			return false;
> +		}
> +		return true;
> +	case desc_reserved:
> +		return false;
> +	case desc_committed:
> +		desc_make_reusable(desc_ring, tail_id);
> +		break;
> +	case desc_reusable:
> +		break;
> +	}
> +
> +	/*
> +	 * Data blocks must be invalidated before their associated
> +	 * descriptor can be made available for recycling. Invalidating
> +	 * them later is not possible because there is no way to trust
> +	 * data blocks once their associated descriptor is gone.
> +	 */
> +
> +	if (!data_push_tail(rb, &rb->text_data_ring, desc.text_blk_lpos.next))
> +		return false;
> +	if (!data_push_tail(rb, &rb->dict_data_ring, desc.dict_blk_lpos.next))
> +		return false;
> +
> +	/* The data ring tail(s) were pushed: LMM(desc_push_tail:A) */
> +
> +	/*
> +	 * Check the next descriptor after @tail_id before pushing the tail to
> +	 * it because the tail must always be in a committed or reusable
> +	 * state. The implementation of prb_first_seq() relies on this.
> +	 *
> +	 * A successful read implies that the next descriptor is less than or
> +	 * equal to @head_id so there is no risk of pushing the tail past the
> +	 * head.
> +	 */
> +	d_state = desc_read(desc_ring, DESC_ID(tail_id + 1),
> +			    &desc); /* LMM(desc_push_tail:B) */
> +	if (d_state == desc_committed || d_state == desc_reusable) {
> +		atomic_long_cmpxchg_relaxed(&desc_ring->tail_id, tail_id,
> +			DESC_ID(tail_id + 1)); /* LMM(desc_push_tail:C) */

IMHO, we need smp_wmb() here so that everyone see updated
desc_ring->tail_id before we push the head as well.

It would pair with read barrier in desc_reserve() between reading
tail_id and head_id.

> +	} else {
> +		/*
> +		 * Guarantee the last state load from desc_read() is before
> +		 * reloading @tail_id in order to see a new tail in the case
> +		 * that the descriptor has been recycled. This pairs with
> +		 * desc_reserve:A.
> +		 */
> +		smp_rmb(); /* LMM(desc_push_tail:D) */
> +
> +		/*
> +		 * Re-check the tail ID. The descriptor following @tail_id is
> +		 * not in an allowed tail state. But if the tail has since
> +		 * been moved by another task, then it does not matter.
> +		 *
> +		 * Memory barrier involvement:
> +		 *
> +		 * No possibility of missing a pushed tail.
> +		 * If desc_push_tail:B reads from desc_reserve:B, then
> +		 * desc_push_tail:E reads from desc_push_tail:C.
> +		 *
> +		 * Relies on:
> +		 *
> +		 * MB from desc_push_tail:C to desc_reserve:B
> +		 *    matching
> +		 * RMB from desc_push_tail:B to desc_push_tail:E
> +		 */
> +		if (atomic_long_read(&desc_ring->tail_id) ==
> +					tail_id) { /* LMM(desc_push_tail:E) */
> +			return false;
> +		}
> +	}
> +
> +	return true;
> +}
> +
> +/* Reserve a new descriptor, invalidating the oldest if necessary. */
> +static bool desc_reserve(struct printk_ringbuffer *rb, unsigned long *id_out)
> +{
> +	struct prb_desc_ring *desc_ring = &rb->desc_ring;
> +	unsigned long prev_state_val;
> +	unsigned long id_prev_wrap;
> +	struct prb_desc *desc;
> +	unsigned long head_id;
> +	unsigned long id;
> +
> +	head_id = atomic_long_read(&desc_ring->head_id);
> +
> +	do {
> +		desc = to_desc(desc_ring, head_id);
> +
> +		id = DESC_ID(head_id + 1);
> +		id_prev_wrap = DESC_ID_PREV_WRAP(desc_ring, id);

IMHO, we need smp_rmb() here to to guarantee reading head_id before
desc_ring->tail_id.

It would pair with write barrier in desc_push_tail() after updating
tail_id, see above.

> +
> +		if (id_prev_wrap == atomic_long_read(&desc_ring->tail_id)) {
> +			/*
> +			 * Make space for the new descriptor by
> +			 * advancing the tail.
> +			 */
> +			if (!desc_push_tail(rb, id_prev_wrap))
> +				return false;
> +		}
> +	} while (!atomic_long_try_cmpxchg_relaxed(&desc_ring->head_id,
> +						  &head_id, id));
> +
> +	/*
> +	 * Guarantee any data ring tail changes are stored before recycling
> +	 * the descriptor. A full memory barrier is needed since another
> +	 * task may have pushed the data ring tails. This pairs with
> +	 * data_push_tail:A.
> +	 *
> +	 * Guarantee a new tail ID is stored before recycling the descriptor.
> +	 * A full memory barrier is needed since another task may have pushed
> +	 * the tail ID. This pairs with desc_push_tail:D and prb_first_seq:C.
> +	 */
> +	smp_mb(); /* LMM(desc_reserve:A) */

I am a bit confused by the full barrier here. The description is not
clear. All the three tags (data_push_tail:A, desc_push_tail:D and
prb_first_seq:C) refers read barriers. This would suggest that write
barrier would be enough here.

OK, this barrier is between writing desc_ring->head_id and
reading/writing desc->state_var.

A write barrier here would require a code that reads
desc->state_var before reading head_id, tail_id of desc
or data rings when they check if the descriptor was
reused before. It seems that all the mentioned paring
read barriers are correct. So the above description of
the write barrier part looks correct.

Now, the question is why the read barrier would be needed
here. The only reason might be the check of the desc->state_var.
The pairing write barrier should allow reusing of the descriptor.
For this, we might need to add a write barrier either into
prb_commit() or desc_make_reusable() after updating
the state variable.

We check here if the descriptor is really reusable. So it should
be enough to add write barrier into desc_make_reusable().


> +
> +	desc = to_desc(desc_ring, id);
> +
> +	/* If the descriptor has been recycled, verify the old state val. */
> +	prev_state_val = atomic_long_read(&desc->state_var);
> +	if (prev_state_val && prev_state_val != (id_prev_wrap |
> +						 DESC_COMMITTED_MASK |
> +						 DESC_REUSE_MASK)) {
> +		WARN_ON_ONCE(1);
> +		return false;
> +	}
> +
> +	/* Assign the descriptor a new ID and set its state to reserved. */
> +	if (!atomic_long_try_cmpxchg_relaxed(&desc->state_var,
> +			&prev_state_val, id | 0)) { /* LMM(desc_reserve:B) */
> +		WARN_ON_ONCE(1);
> +		return false;
> +	}
> +
> +	/*
> +	 * Guarantee the new descriptor ID and state is stored before making
> +	 * any other changes. This pairs with desc_read:D.
> +	 */
> +	smp_wmb(); /* LMM(desc_reserve:C) */
> +
> +	/* Now data in @desc can be modified: LMM(desc_reserve:D) */
> +
> +	*id_out = id;
> +	return true;
> +}
> +
> +/*
> + * Allocate a new data block, invalidating the oldest data block(s)
> + * if necessary. This function also associates the data block with
> + * a specified descriptor.
> + */
> +static char *data_alloc(struct printk_ringbuffer *rb,
> +			struct prb_data_ring *data_ring, unsigned long size,
> +			struct prb_data_blk_lpos *blk_lpos, unsigned long id)
> +{
> +	struct prb_data_block *blk;
> +	unsigned long begin_lpos;
> +	unsigned long next_lpos;
> +
> +	if (!data_ring->data || size == 0) {
> +		/* Specify a data-less block. */
> +		blk_lpos->begin = INVALID_LPOS;
> +		blk_lpos->next = INVALID_LPOS;
> +		return NULL;
> +	}
> +
> +	size = to_blk_size(size);
> +
> +	begin_lpos = atomic_long_read(&data_ring->head_lpos);
> +
> +	do {
> +		next_lpos = get_next_lpos(data_ring, begin_lpos, size);
> +

IMHO, we need smp_rmb() here to read begin_lpos before we read
tail_lpos in data_push_tail()

It would pair with a write barrier in data_push_tail() after
updating data_ring->tail_lpos.

> +		if (!data_push_tail(rb, data_ring,
> +				    next_lpos - DATA_SIZE(data_ring))) {
> +			/* Failed to allocate, specify a data-less block. */
> +			blk_lpos->begin = INVALID_LPOS;
> +			blk_lpos->next = INVALID_LPOS;
> +			return NULL;
> +		}
> +	} while (!atomic_long_try_cmpxchg_relaxed(&data_ring->head_lpos,
> +						  &begin_lpos, next_lpos));
> +

IMHO, we need smp_wmb() here to guarantee that others see the updated
data_ring->head_lpos before we write anything into the data buffer.

It would pair with a read barrier in data_make_reusable
between reading tail_lpos and blk->id in data_make_reusable().


> +	blk = to_block(data_ring, begin_lpos);
> +	blk->id = id;
> +
> +	if (DATA_WRAPS(data_ring, begin_lpos) !=
> +	    DATA_WRAPS(data_ring, next_lpos)) {
> +		/* Wrapping data blocks store their data at the beginning. */
> +		blk = to_block(data_ring, 0);
> +		blk->id = id;
> +	}
> +
> +	blk_lpos->begin = begin_lpos;
> +	blk_lpos->next = next_lpos;
> +
> +	return &blk->data[0];
> +}

Best Regards,
Petr
