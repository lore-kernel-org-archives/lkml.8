Return-Path: <SRS0=BMk7=4P=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5B8E9C4BA3B
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Feb 2020 12:04:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 110D124692
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Feb 2020 12:04:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729292AbgB0MET (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 27 Feb 2020 07:04:19 -0500
Received: from Galois.linutronix.de ([193.142.43.55]:34096 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728964AbgB0MET (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Feb 2020 07:04:19 -0500
Received: from localhost ([127.0.0.1] helo=vostro.local)
        by Galois.linutronix.de with esmtp (Exim 4.80)
        (envelope-from <john.ogness@linutronix.de>)
        id 1j7Htj-0000GL-MA; Thu, 27 Feb 2020 13:04:11 +0100
From:   John Ogness <john.ogness@linutronix.de>
To:     Petr Mladek <pmladek@suse.com>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Sergey Senozhatsky <sergey.senozhatsky.work@gmail.com>,
        Sergey Senozhatsky <sergey.senozhatsky@gmail.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Andrea Parri <parri.andrea@gmail.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        kexec@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: more barriers: Re: [PATCH 1/2] printk: add lockless buffer
References: <20200128161948.8524-1-john.ogness@linutronix.de>
        <20200128161948.8524-2-john.ogness@linutronix.de>
        <20200221115416.wo6ovakxt2c7hgkc@pathway.suse.cz>
Date:   Thu, 27 Feb 2020 13:04:09 +0100
Message-ID: <87h7zcjkxy.fsf@linutronix.de>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.4 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2020-02-21, Petr Mladek <pmladek@suse.com> wrote:
> If I get it correctly, the used cmpxchg_relaxed() variants does not
> provide full barriers. They are just able to prevent parallel
> manipulation of the modified variable.

Correct.

I purposely avoided the full barriers of a successful cmpxchg() so that
we could clearly specify what we needed and why. As Andrea pointed out
[0], we need to understand if/when we require those memory barriers.

Once we've identified these, we may want to fold some of those barriers
back in, going from cmpxchg_relaxed() back to cmpxchg(). In particular
when we see patterns like:

    do {
        ....
    } while (!try_cmpxchg_relaxed());
    smp_mb();

or possibly:

    smp_mb();
    cmpxchg_relaxed(); /* no return value check */

> On Tue 2020-01-28 17:25:47, John Ogness wrote:
>> diff --git a/kernel/printk/printk_ringbuffer.c b/kernel/printk/printk_ringbuffer.c
>> new file mode 100644
>> index 000000000000..796257f226ee
>> --- /dev/null
>> +++ b/kernel/printk/printk_ringbuffer.c
>> +/*
>> + * Take a given descriptor out of the committed state by attempting
>> + * the transition from committed to reusable. Either this task or some
>> + * other task will have been successful.
>> + */
>> +static void desc_make_reusable(struct prb_desc_ring *desc_ring,
>> +			       unsigned long id)
>> +{
>> +	struct prb_desc *desc = to_desc(desc_ring, id);
>> +	atomic_long_t *state_var = &desc->state_var;
>> +	unsigned long val_committed = id | DESC_COMMITTED_MASK;
>> +	unsigned long val_reusable = val_committed | DESC_REUSE_MASK;
>> +
>> +	atomic_long_cmpxchg_relaxed(state_var, val_committed,
>> val_reusable);
>
> IMHO, we should add smp_wmb() here to make sure that the reusable
> state is written before we shuffle the desc_ring->tail_id/head_id.
>
> It would pair with the read part of smp_mb() in desc_reserve()
> before the extra check if the descriptor is really in reusable state.

Yes. Now that we added the extra state checking in desc_reserve(), this
ordering has become important.

However, for this case I would prefer to instead place a full memory
barrier immediately before @tail_id is incremented (in
desc_push_tail()). The tail-incrementing-task must have seen the
reusable state (even if it is not the one that set it) and an
incremented @tail_id must be visible to the task recycling a descriptor.

>> +}
>> +
>> +/*
>> + * For a given data ring (text or dict) and its current tail lpos:
>> + * for each data block up until @lpos, make the associated descriptor
>> + * reusable.
>> + *
>> + * If there is any problem making the associated descriptor reusable,
>> + * either the descriptor has not yet been committed or another writer
>> + * task has already pushed the tail lpos past the problematic data
>> + * block. Regardless, on error the caller can re-load the tail lpos
>> + * to determine the situation.
>> + */
>> +static bool data_make_reusable(struct printk_ringbuffer *rb,
>> +			       struct prb_data_ring *data_ring,
>> +			       unsigned long tail_lpos, unsigned long lpos,
>> +			       unsigned long *lpos_out)
>> +{
>> +	struct prb_desc_ring *desc_ring = &rb->desc_ring;
>> +	struct prb_data_blk_lpos *blk_lpos;
>> +	struct prb_data_block *blk;
>> +	enum desc_state d_state;
>> +	struct prb_desc desc;
>> +	unsigned long id;
>> +
>> +	/*
>> +	 * Using the provided @data_ring, point @blk_lpos to the correct
>> +	 * blk_lpos within the local copy of the descriptor.
>> +	 */
>> +	if (data_ring == &rb->text_data_ring)
>> +		blk_lpos = &desc.text_blk_lpos;
>> +	else
>> +		blk_lpos = &desc.dict_blk_lpos;
>> +
>> +	/* Loop until @tail_lpos has advanced to or beyond @lpos. */
>> +	while ((lpos - tail_lpos) - 1 < DATA_SIZE(data_ring)) {
>> +		blk = to_block(data_ring, tail_lpos);
>
> IMHO, we need smp_rmb() here to make sure that we read blk->id
> that we written after pushing the tail_lpos.
>
> It would pair with the write barrier in data_alloc() before
> before writing blk->id. It is there after updating head_lpos.
> But head_lpos could be updated only after updating tail_lpos.
> See the comment in data_alloc() below.

I do not understand. @blk->id has a data dependency on the provided
@tail_lpos. A random @tail_lpos value could be passed to this function
and it will only make a descriptor state change if the associated
descriptor is in the committed state and points back to that @tail_lpos
value. That is always legal.

If the old @blk->id value is read (just before data_alloc() writes it),
then the following desc_read() will return with desc_miss. That is
correct. If the new @blk->id value is read (just after data_alloc()
writes it), desc_read() will return with desc_reserved. This is also
correct. Why would this code care about @head_lpos or @tail_lpos
ordering to @blk->id? Please explain.

>> +		id = READ_ONCE(blk->id);
>> +
>> +		d_state = desc_read(desc_ring, id,
>> +				    &desc); /* LMM(data_make_reusable:A) */
>> +
>> +		switch (d_state) {
>> +		case desc_miss:
>> +			return false;
>> +		case desc_reserved:
>> +			return false;
>> +		case desc_committed:
>> +			/*
>> +			 * This data block is invalid if the descriptor
>> +			 * does not point back to it.
>> +			 */
>> +			if (blk_lpos->begin != tail_lpos)
>> +				return false;
>> +			desc_make_reusable(desc_ring, id);
>> +			break;
>> +		case desc_reusable:
>> +			/*
>> +			 * This data block is invalid if the descriptor
>> +			 * does not point back to it.
>> +			 */
>> +			if (blk_lpos->begin != tail_lpos)
>> +				return false;
>> +			break;
>> +		}
>> +
>> +		/* Advance @tail_lpos to the next data block. */
>> +		tail_lpos = blk_lpos->next;
>> +	}
>> +
>> +	*lpos_out = tail_lpos;
>> +
>> +	return true;
>> +}
>> +
>> +/*
>> + * Advance the data ring tail to at least @lpos. This function puts all
>> + * descriptors into the reusable state if the tail will be pushed beyond
>> + * their associated data block.
>> + */
>> +static bool data_push_tail(struct printk_ringbuffer *rb,
>> +			   struct prb_data_ring *data_ring,
>> +			   unsigned long lpos)
>> +{
>> +	unsigned long tail_lpos;
>> +	unsigned long next_lpos;
>> +
>> +	/* If @lpos is not valid, there is nothing to do. */
>> +	if (lpos == INVALID_LPOS)
>> +		return true;
>> +
>> +	tail_lpos = atomic_long_read(&data_ring->tail_lpos);
>> +
>> +	do {
>> +		/* If @lpos is no longer valid, there is nothing to do. */
>> +		if (lpos - tail_lpos >= DATA_SIZE(data_ring))
>> +			break;
>> +
>> +		/*
>> +		 * Make all descriptors reusable that are associated with
>> +		 * data blocks before @lpos.
>> +		 */
>> +		if (!data_make_reusable(rb, data_ring, tail_lpos, lpos,
>> +					&next_lpos)) {
>> +			/*
>> +			 * data_make_reusable() performed state loads. Make
>> +			 * sure they are loaded before reloading the tail lpos
>> +			 * in order to see a new tail in the case that the
>> +			 * descriptor has been recycled. This pairs with
>> +			 * desc_reserve:A.
>> +			 */
>> +			smp_rmb(); /* LMM(data_push_tail:A) */
>> +
>> +			/*
>> +			 * Reload the tail lpos.
>> +			 *
>> +			 * Memory barrier involvement:
>> +			 *
>> +			 * No possibility of missing a recycled descriptor.
>> +			 * If data_make_reusable:A reads from desc_reserve:B,
>> +			 * then data_push_tail:B reads from desc_push_tail:A.
>> +			 *
>> +			 * Relies on:
>> +			 *
>> +			 * MB from desc_push_tail:A to desc_reserve:B
>> +			 *    matching
>> +			 * RMB from data_make_reusable:A to data_push_tail:B
>> +			 */
>> +			next_lpos = atomic_long_read(&data_ring->tail_lpos
>> +						); /* LMM(data_push_tail:B) */
>> +			if (next_lpos == tail_lpos)
>> +				return false;
>> +
>> +			/* Another task pushed the tail. Try again. */
>> +			tail_lpos = next_lpos;
>> +		}
>> +	} while (!atomic_long_try_cmpxchg_relaxed(&data_ring->tail_lpos,
>> +			&tail_lpos, next_lpos)); /* can be relaxed? */
>
> IMHO, we need smp_wmb() here so that others see the updated
> data_ring->tail_lpos before this thread allocates the space
> by pushing head_pos.
>
> It would be paired with a read barrier in data_alloc() between
> reading head_lpos and tail_lpos, see below.

data_push_tail() is the only function that concerns itself with
@tail_lpos. Its cmpxchg-loop will prevent any unintended consequences.
And it uses the memory barrier pair data_push_tail:A/desc_reserve:A to
make sure that @tail_lpos reloads will successfully identify a changed
@tail_lpos due to descriptor recycling (which is the only reason that
@tail_lpos changes).

Why is it a problem if the movement of @head_lpos is seen before the
movement of @tail_lpos? Please explain.

>> +
>> +	return true;
>> +}
>> +
>> +/*
>> + * Advance the desc ring tail. This function advances the tail by one
>> + * descriptor, thus invalidating the oldest descriptor. Before advancing
>> + * the tail, the tail descriptor is made reusable and all data blocks up to
>> + * and including the descriptor's data block are invalidated (i.e. the data
>> + * ring tail is pushed past the data block of the descriptor being made
>> + * reusable).
>> + */
>> +static bool desc_push_tail(struct printk_ringbuffer *rb,
>> +			   unsigned long tail_id)
>> +{
>> +	struct prb_desc_ring *desc_ring = &rb->desc_ring;
>> +	enum desc_state d_state;
>> +	struct prb_desc desc;
>> +
>> +	d_state = desc_read(desc_ring, tail_id, &desc);
>> +
>> +	switch (d_state) {
>> +	case desc_miss:
>> +		/*
>> +		 * If the ID is exactly 1 wrap behind the expected, it is
>> +		 * in the process of being reserved by another writer and
>> +		 * must be considered reserved.
>> +		 */
>> +		if (DESC_ID(atomic_long_read(&desc.state_var)) ==
>> +		    DESC_ID_PREV_WRAP(desc_ring, tail_id)) {
>> +			return false;
>> +		}
>> +		return true;
>> +	case desc_reserved:
>> +		return false;
>> +	case desc_committed:
>> +		desc_make_reusable(desc_ring, tail_id);
>> +		break;
>> +	case desc_reusable:
>> +		break;
>> +	}
>> +
>> +	/*
>> +	 * Data blocks must be invalidated before their associated
>> +	 * descriptor can be made available for recycling. Invalidating
>> +	 * them later is not possible because there is no way to trust
>> +	 * data blocks once their associated descriptor is gone.
>> +	 */
>> +
>> +	if (!data_push_tail(rb, &rb->text_data_ring, desc.text_blk_lpos.next))
>> +		return false;
>> +	if (!data_push_tail(rb, &rb->dict_data_ring, desc.dict_blk_lpos.next))
>> +		return false;
>> +
>> +	/* The data ring tail(s) were pushed: LMM(desc_push_tail:A) */
>> +
>> +	/*
>> +	 * Check the next descriptor after @tail_id before pushing the tail to
>> +	 * it because the tail must always be in a committed or reusable
>> +	 * state. The implementation of prb_first_seq() relies on this.
>> +	 *
>> +	 * A successful read implies that the next descriptor is less than or
>> +	 * equal to @head_id so there is no risk of pushing the tail past the
>> +	 * head.
>> +	 */
>> +	d_state = desc_read(desc_ring, DESC_ID(tail_id + 1),
>> +			    &desc); /* LMM(desc_push_tail:B) */
>> +	if (d_state == desc_committed || d_state == desc_reusable) {
>> +		atomic_long_cmpxchg_relaxed(&desc_ring->tail_id, tail_id,
>> +			DESC_ID(tail_id + 1)); /* LMM(desc_push_tail:C) */
>
> IMHO, we need smp_wmb() here so that everyone see updated
> desc_ring->tail_id before we push the head as well.
>
> It would pair with read barrier in desc_reserve() between reading
> tail_id and head_id.

Good catch! This secures probably the most critical point in your
design: when desc_reserve() recognizes that it needs to push the
descriptor tail.

>> +	} else {
>> +		/*
>> +		 * Guarantee the last state load from desc_read() is before
>> +		 * reloading @tail_id in order to see a new tail in the case
>> +		 * that the descriptor has been recycled. This pairs with
>> +		 * desc_reserve:A.
>> +		 */
>> +		smp_rmb(); /* LMM(desc_push_tail:D) */
>> +
>> +		/*
>> +		 * Re-check the tail ID. The descriptor following @tail_id is
>> +		 * not in an allowed tail state. But if the tail has since
>> +		 * been moved by another task, then it does not matter.
>> +		 *
>> +		 * Memory barrier involvement:
>> +		 *
>> +		 * No possibility of missing a pushed tail.
>> +		 * If desc_push_tail:B reads from desc_reserve:B, then
>> +		 * desc_push_tail:E reads from desc_push_tail:C.
>> +		 *
>> +		 * Relies on:
>> +		 *
>> +		 * MB from desc_push_tail:C to desc_reserve:B
>> +		 *    matching
>> +		 * RMB from desc_push_tail:B to desc_push_tail:E
>> +		 */
>> +		if (atomic_long_read(&desc_ring->tail_id) ==
>> +					tail_id) { /* LMM(desc_push_tail:E) */
>> +			return false;
>> +		}
>> +	}
>> +
>> +	return true;
>> +}
>> +
>> +/* Reserve a new descriptor, invalidating the oldest if necessary. */
>> +static bool desc_reserve(struct printk_ringbuffer *rb, unsigned long *id_out)
>> +{
>> +	struct prb_desc_ring *desc_ring = &rb->desc_ring;
>> +	unsigned long prev_state_val;
>> +	unsigned long id_prev_wrap;
>> +	struct prb_desc *desc;
>> +	unsigned long head_id;
>> +	unsigned long id;
>> +
>> +	head_id = atomic_long_read(&desc_ring->head_id);
>> +
>> +	do {
>> +		desc = to_desc(desc_ring, head_id);
>> +
>> +		id = DESC_ID(head_id + 1);
>> +		id_prev_wrap = DESC_ID_PREV_WRAP(desc_ring, id);
>
> IMHO, we need smp_rmb() here to to guarantee reading head_id before
> desc_ring->tail_id.
>
> It would pair with write barrier in desc_push_tail() after updating
> tail_id, see above.

Ack. Critical.

>> +
>> +		if (id_prev_wrap == atomic_long_read(&desc_ring->tail_id)) {
>> +			/*
>> +			 * Make space for the new descriptor by
>> +			 * advancing the tail.
>> +			 */
>> +			if (!desc_push_tail(rb, id_prev_wrap))
>> +				return false;
>> +		}
>> +	} while (!atomic_long_try_cmpxchg_relaxed(&desc_ring->head_id,
>> +						  &head_id, id));
>> +
>> +	/*
>> +	 * Guarantee any data ring tail changes are stored before recycling
>> +	 * the descriptor. A full memory barrier is needed since another
>> +	 * task may have pushed the data ring tails. This pairs with
>> +	 * data_push_tail:A.
>> +	 *
>> +	 * Guarantee a new tail ID is stored before recycling the descriptor.
>> +	 * A full memory barrier is needed since another task may have pushed
>> +	 * the tail ID. This pairs with desc_push_tail:D and prb_first_seq:C.
>> +	 */
>> +	smp_mb(); /* LMM(desc_reserve:A) */
>
> I am a bit confused by the full barrier here. The description is not
> clear. All the three tags (data_push_tail:A, desc_push_tail:D and
> prb_first_seq:C) refers read barriers. This would suggest that write
> barrier would be enough here.

The above comment section states twice why a full memory barrier is
needed: those writes may not have come from this task. We are not only
ordering the visible writes that this task performed, we are also
ordering the visible writes that this task has observed. Here is a
litmus test demonstrating this:

C full-mb-test

{}

P0(int *x, int *y)
{
	WRITE_ONCE(*x, 1);
}

P1(int *x, int *y)
{
	int tmp_x;

	tmp_x = READ_ONCE(*x);
	if (tmp_x) {
		smp_mb();
		WRITE_ONCE(*y, 1);
	}
}

P2(int *x, int *y)
{
	int tmp_x;
	int tmp_y;

	tmp_y = READ_ONCE(*y);
	smp_rmb();
	tmp_x = READ_ONCE(*x);
}

exists (2:tmp_x=0 /\ 2:tmp_y=1)

Running it yields:

$ herd7 -conf linux-kernel.cfg full-mb-test.litmus 
Test full-mb-test Allowed
States 3
2:tmp_x=0; 2:tmp_y=0;
2:tmp_x=1; 2:tmp_y=0;
2:tmp_x=1; 2:tmp_y=1;
No
Witnesses
Positive: 0 Negative: 5
Condition exists (2:tmp_x=0 /\ 2:tmp_y=1)
Observation full-mb-test Never 0 5
Time full-mb-test 0.00
Hash=3a3ae98db0154d29a2854b01ed30ec81

> OK, this barrier is between writing desc_ring->head_id and
> reading/writing desc->state_var.
>
> A write barrier here would require a code that reads
> desc->state_var before reading head_id, tail_id of desc
> or data rings when they check if the descriptor was
> reused before. It seems that all the mentioned paring
> read barriers are correct. So the above description of
> the write barrier part looks correct.
>
> Now, the question is why the read barrier would be needed
> here.

What read barrier? This is a full barrier. A full barrier is _not_
equivalent to:

    smp_wmb();
    smp_rmb();

If the smp_mb() in the above litmus test is changed to smp_wmb(), the
test error-condition would exist. Adding an additional smp_rmb() would
still result in the error-condition. A full memory barrier is needed
here. (An acquire/release would be more efficient, but I am avoiding
those on purpose, sticking with the "better understood" memory
barriers.)

> The only reason might be the check of the desc->state_var.
> The pairing write barrier should allow reusing of the descriptor.
> For this, we might need to add a write barrier either into
> prb_commit() or desc_make_reusable() after updating
> the state variable.
>
> We check here if the descriptor is really reusable. So it should
> be enough to add write barrier into desc_make_reusable().

As mentioned above, I would put the smp_mb() before updating the
@tail_id. That would pair with this smp_mb() and avoid the false
positive on the @state_var check.

>> +
>> +	desc = to_desc(desc_ring, id);
>> +
>> +	/* If the descriptor has been recycled, verify the old state val. */
>> +	prev_state_val = atomic_long_read(&desc->state_var);
>> +	if (prev_state_val && prev_state_val != (id_prev_wrap |
>> +						 DESC_COMMITTED_MASK |
>> +						 DESC_REUSE_MASK)) {
>> +		WARN_ON_ONCE(1);
>> +		return false;
>> +	}
>> +
>> +	/* Assign the descriptor a new ID and set its state to reserved. */
>> +	if (!atomic_long_try_cmpxchg_relaxed(&desc->state_var,
>> +			&prev_state_val, id | 0)) { /* LMM(desc_reserve:B) */
>> +		WARN_ON_ONCE(1);
>> +		return false;
>> +	}
>> +
>> +	/*
>> +	 * Guarantee the new descriptor ID and state is stored before making
>> +	 * any other changes. This pairs with desc_read:D.
>> +	 */
>> +	smp_wmb(); /* LMM(desc_reserve:C) */
>> +
>> +	/* Now data in @desc can be modified: LMM(desc_reserve:D) */
>> +
>> +	*id_out = id;
>> +	return true;
>> +}
>> +
>> +/*
>> + * Allocate a new data block, invalidating the oldest data block(s)
>> + * if necessary. This function also associates the data block with
>> + * a specified descriptor.
>> + */
>> +static char *data_alloc(struct printk_ringbuffer *rb,
>> +			struct prb_data_ring *data_ring, unsigned long size,
>> +			struct prb_data_blk_lpos *blk_lpos, unsigned long id)
>> +{
>> +	struct prb_data_block *blk;
>> +	unsigned long begin_lpos;
>> +	unsigned long next_lpos;
>> +
>> +	if (!data_ring->data || size == 0) {
>> +		/* Specify a data-less block. */
>> +		blk_lpos->begin = INVALID_LPOS;
>> +		blk_lpos->next = INVALID_LPOS;
>> +		return NULL;
>> +	}
>> +
>> +	size = to_blk_size(size);
>> +
>> +	begin_lpos = atomic_long_read(&data_ring->head_lpos);
>> +
>> +	do {
>> +		next_lpos = get_next_lpos(data_ring, begin_lpos, size);
>> +
>
> IMHO, we need smp_rmb() here to read begin_lpos before we read
> tail_lpos in data_push_tail()
>
> It would pair with a write barrier in data_push_tail() after
> updating data_ring->tail_lpos.

Please explain why this pair is necessary. What is the scenario that
needs to be avoided?

>> +		if (!data_push_tail(rb, data_ring,
>> +				    next_lpos - DATA_SIZE(data_ring))) {
>> +			/* Failed to allocate, specify a data-less block. */
>> +			blk_lpos->begin = INVALID_LPOS;
>> +			blk_lpos->next = INVALID_LPOS;
>> +			return NULL;
>> +		}
>> +	} while (!atomic_long_try_cmpxchg_relaxed(&data_ring->head_lpos,
>> +						  &begin_lpos, next_lpos));
>> +
>
> IMHO, we need smp_wmb() here to guarantee that others see the updated
> data_ring->head_lpos before we write anything into the data buffer.
>
> It would pair with a read barrier in data_make_reusable
> between reading tail_lpos and blk->id in data_make_reusable().

Please explain why this pair is necessary. What is the scenario that
needs to be avoided?

>> +	blk = to_block(data_ring, begin_lpos);
>> +	blk->id = id;
>> +
>> +	if (DATA_WRAPS(data_ring, begin_lpos) !=
>> +	    DATA_WRAPS(data_ring, next_lpos)) {
>> +		/* Wrapping data blocks store their data at the beginning. */
>> +		blk = to_block(data_ring, 0);
>> +		blk->id = id;
>> +	}
>> +
>> +	blk_lpos->begin = begin_lpos;
>> +	blk_lpos->next = next_lpos;
>> +
>> +	return &blk->data[0];
>> +}

John Ogness

[0] https://lkml.kernel.org/r/20191221142235.GA7824@andrea
