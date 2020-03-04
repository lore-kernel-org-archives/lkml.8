Return-Path: <SRS0=idZ5=4V=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D8706C3F2CD
	for <linux-kernel@archiver.kernel.org>; Wed,  4 Mar 2020 15:08:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9894624658
	for <linux-kernel@archiver.kernel.org>; Wed,  4 Mar 2020 15:08:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729156AbgCDPIM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 4 Mar 2020 10:08:12 -0500
Received: from mx2.suse.de ([195.135.220.15]:48758 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726981AbgCDPIL (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Mar 2020 10:08:11 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx2.suse.de (Postfix) with ESMTP id CD249AF8C;
        Wed,  4 Mar 2020 15:08:05 +0000 (UTC)
Date:   Wed, 4 Mar 2020 16:08:05 +0100
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
Subject: Re: more barriers: Re: [PATCH 1/2] printk: add lockless buffer
Message-ID: <20200304150805.yzda34paahstageq@pathway.suse.cz>
References: <20200128161948.8524-1-john.ogness@linutronix.de>
 <20200128161948.8524-2-john.ogness@linutronix.de>
 <20200221115416.wo6ovakxt2c7hgkc@pathway.suse.cz>
 <87h7zcjkxy.fsf@linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <87h7zcjkxy.fsf@linutronix.de>
User-Agent: NeoMutt/20170912 (1.9.0)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu 2020-02-27 13:04:09, John Ogness wrote:
> On 2020-02-21, Petr Mladek <pmladek@suse.com> wrote:
> > If I get it correctly, the used cmpxchg_relaxed() variants does not
> > provide full barriers. They are just able to prevent parallel
> > manipulation of the modified variable.
> 
> Correct.
> 
> I purposely avoided the full barriers of a successful cmpxchg() so that
> we could clearly specify what we needed and why. As Andrea pointed out
> [0], we need to understand if/when we require those memory barriers.
> 
> Once we've identified these, we may want to fold some of those barriers
> back in, going from cmpxchg_relaxed() back to cmpxchg(). In particular
> when we see patterns like:
> 
>     do {
>         ....
>     } while (!try_cmpxchg_relaxed());
>     smp_mb();
> 
> or possibly:
> 
>     smp_mb();
>     cmpxchg_relaxed(); /* no return value check */

It seems that we need more barriers than I expected. If we are able to
get rid of them by using cmpxchg() instead of cmpxchg_relaxed() then
it might be quite some simplification.

I have to admit that my understanding of barriers is more incomplete
than I have hooped for. I am less and less convinced that my ack is
enough to merge this patch. It would be great when PeterZ or another
expert on barriers might give it a cycle (or maybe wait for the next
version of this patch?).

Alternative solution is to do quite some testing and push it into
linux-next to give it even more testing. It seems that the main
danger is that some messages might get lost. But it should
not crash. Well, I would feel much more comfortable if I wasn't
the only reviewer.

> > On Tue 2020-01-28 17:25:47, John Ogness wrote:
> >> diff --git a/kernel/printk/printk_ringbuffer.c b/kernel/printk/printk_ringbuffer.c
> >> new file mode 100644
> >> index 000000000000..796257f226ee
> >> --- /dev/null
> >> +++ b/kernel/printk/printk_ringbuffer.c
> >> +/*
> >> + * Take a given descriptor out of the committed state by attempting
> >> + * the transition from committed to reusable. Either this task or some
> >> + * other task will have been successful.
> >> + */
> >> +static void desc_make_reusable(struct prb_desc_ring *desc_ring,
> >> +			       unsigned long id)
> >> +{
> >> +	struct prb_desc *desc = to_desc(desc_ring, id);
> >> +	atomic_long_t *state_var = &desc->state_var;
> >> +	unsigned long val_committed = id | DESC_COMMITTED_MASK;
> >> +	unsigned long val_reusable = val_committed | DESC_REUSE_MASK;
> >> +
> >> +	atomic_long_cmpxchg_relaxed(state_var, val_committed,
> >> val_reusable);
> >
> > IMHO, we should add smp_wmb() here to make sure that the reusable
> > state is written before we shuffle the desc_ring->tail_id/head_id.
> >
> > It would pair with the read part of smp_mb() in desc_reserve()
> > before the extra check if the descriptor is really in reusable state.
> 
> Yes. Now that we added the extra state checking in desc_reserve(), this
> ordering has become important.
> 
> However, for this case I would prefer to instead place a full memory
> barrier immediately before @tail_id is incremented (in
> desc_push_tail()). The tail-incrementing-task must have seen the
> reusable state (even if it is not the one that set it) and an
> incremented @tail_id must be visible to the task recycling a descriptor.

Ah, the below mentioned litmus tests for the full barrier in
desc_reserve() opened my eyes to see why full barrier is sometimes
needed instead of the write barrier.

I agree that this is exactly the place when the full barrier will be
needed. This write can happen on any CPU and the write
depending on this value might be done on another CPU.

Also I agree that desc_push_tail() looks like the right place
for the full barrier because some actions there are done only
when the descriptor is invalidated.

I just wonder if it should be even before data_push_tail()
calls. It will make sure that everyone sees the reusable state
before we move the data_ring borders.

Also I wonder whether we need even more full barriers in the code.
There are many more dependent actions that can be done on different
CPUs in parallel.

> >> +}
> >> +
> >> +/*
> >> + * For a given data ring (text or dict) and its current tail lpos:
> >> + * for each data block up until @lpos, make the associated descriptor
> >> + * reusable.
> >> + *
> >> + * If there is any problem making the associated descriptor reusable,
> >> + * either the descriptor has not yet been committed or another writer
> >> + * task has already pushed the tail lpos past the problematic data
> >> + * block. Regardless, on error the caller can re-load the tail lpos
> >> + * to determine the situation.
> >> + */
> >> +static bool data_make_reusable(struct printk_ringbuffer *rb,
> >> +			       struct prb_data_ring *data_ring,
> >> +			       unsigned long tail_lpos, unsigned long lpos,
> >> +			       unsigned long *lpos_out)
> >> +{
> >> +	struct prb_desc_ring *desc_ring = &rb->desc_ring;
> >> +	struct prb_data_blk_lpos *blk_lpos;
> >> +	struct prb_data_block *blk;
> >> +	enum desc_state d_state;
> >> +	struct prb_desc desc;
> >> +	unsigned long id;
> >> +
> >> +	/*
> >> +	 * Using the provided @data_ring, point @blk_lpos to the correct
> >> +	 * blk_lpos within the local copy of the descriptor.
> >> +	 */
> >> +	if (data_ring == &rb->text_data_ring)
> >> +		blk_lpos = &desc.text_blk_lpos;
> >> +	else
> >> +		blk_lpos = &desc.dict_blk_lpos;
> >> +
> >> +	/* Loop until @tail_lpos has advanced to or beyond @lpos. */
> >> +	while ((lpos - tail_lpos) - 1 < DATA_SIZE(data_ring)) {
> >> +		blk = to_block(data_ring, tail_lpos);
> >
> > IMHO, we need smp_rmb() here to make sure that we read blk->id
> > that we written after pushing the tail_lpos.
> >
> > It would pair with the write barrier in data_alloc() before
> > before writing blk->id. It is there after updating head_lpos.
> > But head_lpos could be updated only after updating tail_lpos.
> > See the comment in data_alloc() below.
> 
> I do not understand. @blk->id has a data dependency on the provided
> @tail_lpos. A random @tail_lpos value could be passed to this function
> and it will only make a descriptor state change if the associated
> descriptor is in the committed state and points back to that @tail_lpos
> value. That is always legal.
> 
> If the old @blk->id value is read (just before data_alloc() writes it),
> then the following desc_read() will return with desc_miss. That is
> correct. If the new @blk->id value is read (just after data_alloc()
> writes it), desc_read() will return with desc_reserved. This is also
> correct. Why would this code care about @head_lpos or @tail_lpos
> ordering to @blk->id? Please explain.

OK, my proposal does not make much sense. You know, I felt that there
should be smp_wmb() after each atomic_long_try_cmpxchg_relaxed() to
synchronize changes in the other variables.

I added smp_wmb() after the cmpxchg() in data_alloc() and then looked
where might be the related smp_rmb(). This looked promissing because
it was the only location where we read blk->id ;-)

But it does not make sense. The smp_wmb() in data_alloc() was before
writing blk->id. So the corresponding smp_rmb() should be after
reading blk->id.

> >> +		id = READ_ONCE(blk->id);

This brings the question whether the smp_rmb() would make sense here
to make sure that desc_read() see the descriptor state that allowed
allocating this space.

It would pair with smp_wmb() in desc_reserve() right after
setting desc->state_var to the newly reserved descriptor id.
It is the barrier that will allow to modify the reserved space,
including writing the reserved id into the later reserved blk->id.

Note that desc_read() does not have smp_rmb() before the first
read of the state_var. It might theoretically see an outdated
value.

> >> +
> >> +		d_state = desc_read(desc_ring, id,
> >> +				    &desc); /* LMM(data_make_reusable:A) */
> >> +
> >> +		switch (d_state) {
> >> +		case desc_miss:
> >> +			return false;
> >> +		case desc_reserved:
> >> +			return false;
> >> +		case desc_committed:
> >> +			/*
> >> +			 * This data block is invalid if the descriptor
> >> +			 * does not point back to it.
> >> +			 */
> >> +			if (blk_lpos->begin != tail_lpos)
> >> +				return false;
> >> +			desc_make_reusable(desc_ring, id);
> >> +			break;
> >> +		case desc_reusable:
> >> +			/*
> >> +			 * This data block is invalid if the descriptor
> >> +			 * does not point back to it.
> >> +			 */
> >> +			if (blk_lpos->begin != tail_lpos)
> >> +				return false;
> >> +			break;
> >> +		}
> >> +
> >> +		/* Advance @tail_lpos to the next data block. */
> >> +		tail_lpos = blk_lpos->next;
> >> +	}
> >> +
> >> +	*lpos_out = tail_lpos;
> >> +
> >> +	return true;
> >> +}
> >> +
> >> +/*
> >> + * Advance the data ring tail to at least @lpos. This function puts all
> >> + * descriptors into the reusable state if the tail will be pushed beyond
> >> + * their associated data block.
> >> + */
> >> +static bool data_push_tail(struct printk_ringbuffer *rb,
> >> +			   struct prb_data_ring *data_ring,
> >> +			   unsigned long lpos)
> >> +{
> >> +	unsigned long tail_lpos;
> >> +	unsigned long next_lpos;
> >> +
> >> +	/* If @lpos is not valid, there is nothing to do. */
> >> +	if (lpos == INVALID_LPOS)
> >> +		return true;
> >> +
> >> +	tail_lpos = atomic_long_read(&data_ring->tail_lpos);
> >> +
> >> +	do {
> >> +		/* If @lpos is no longer valid, there is nothing to do. */
> >> +		if (lpos - tail_lpos >= DATA_SIZE(data_ring))
> >> +			break;
> >> +
> >> +		/*
> >> +		 * Make all descriptors reusable that are associated with
> >> +		 * data blocks before @lpos.
> >> +		 */
> >> +		if (!data_make_reusable(rb, data_ring, tail_lpos, lpos,
> >> +					&next_lpos)) {
> >> +			/*
> >> +			 * data_make_reusable() performed state loads. Make
> >> +			 * sure they are loaded before reloading the tail lpos
> >> +			 * in order to see a new tail in the case that the
> >> +			 * descriptor has been recycled. This pairs with
> >> +			 * desc_reserve:A.
> >> +			 */
> >> +			smp_rmb(); /* LMM(data_push_tail:A) */
> >> +
> >> +			/*
> >> +			 * Reload the tail lpos.
> >> +			 *
> >> +			 * Memory barrier involvement:
> >> +			 *
> >> +			 * No possibility of missing a recycled descriptor.
> >> +			 * If data_make_reusable:A reads from desc_reserve:B,
> >> +			 * then data_push_tail:B reads from desc_push_tail:A.
> >> +			 *
> >> +			 * Relies on:
> >> +			 *
> >> +			 * MB from desc_push_tail:A to desc_reserve:B
> >> +			 *    matching
> >> +			 * RMB from data_make_reusable:A to data_push_tail:B
> >> +			 */
> >> +			next_lpos = atomic_long_read(&data_ring->tail_lpos
> >> +						); /* LMM(data_push_tail:B) */
> >> +			if (next_lpos == tail_lpos)
> >> +				return false;
> >> +
> >> +			/* Another task pushed the tail. Try again. */
> >> +			tail_lpos = next_lpos;
> >> +		}
> >> +	} while (!atomic_long_try_cmpxchg_relaxed(&data_ring->tail_lpos,
> >> +			&tail_lpos, next_lpos)); /* can be relaxed? */
> >
> > IMHO, we need smp_wmb() here so that others see the updated
> > data_ring->tail_lpos before this thread allocates the space
> > by pushing head_pos.
> >
> > It would be paired with a read barrier in data_alloc() between
> > reading head_lpos and tail_lpos, see below.
> 
> data_push_tail() is the only function that concerns itself with
> @tail_lpos. Its cmpxchg-loop will prevent any unintended consequences.
> And it uses the memory barrier pair data_push_tail:A/desc_reserve:A to
> make sure that @tail_lpos reloads will successfully identify a changed
> @tail_lpos due to descriptor recycling (which is the only reason that
> @tail_lpos changes).
> 
> Why is it a problem if the movement of @head_lpos is seen before the
> movement of @tail_lpos? Please explain.

This was again motivated by the idea that cmpxchg_relaxed() is week
and it should be more safe to synchronize other variables.

OK, "tail_pos" and "head_pos" are closely related. The question is
how they are synchronized.

Hmm, there is the read barrier in LMM(data_push_tail:A) that probably
solves many problems. But what about the following scenario:

CPU0				  CPU1

data_alloc()
  begin_lpos = dr->head_lpos
				  data+alloc()
				    begin_lpos = dr->head_lpos
				    data_push_tail()
				      lpos = dr->tail_lpos
				      id = blk->id
				      date_make_reusable()
				      next_lpos = ...
				      cmpxchg(dr->tail_lpos, next_lpos)
				    cmpxchg(dr->head_lpos)

				    blk->id = id;

  data_push_tail()
    lpos = dr->tail_lpos
    # read old tail_lpos because of missing smp_rmb() amd wmb()
    id = blk->id
    # read new id because the CPU see its new state
    data_make_reusable()
    # fail because id points to the newly allocated block that
    # is still in reserved state [*]
    smp_rmb()
    next_lpos = dr->tail_lpos
    # reading still outdated tail_lpos because there is no smp_wmb()
    # between updating tail_lpos and head_lpos

BANG:

    data_push_tail() would wrongly return false
    => data_alloc() would fail

This won't happen if there was the proposed smp_wmb() at this
location.


[*] Another problem would be when data_make_reusable() see the new
    data already in the commited state. It would make fresh new
    data reusable.

    I mean the following:

CPU0				CPU1

data_alloc()
  begin_lpos = dr->head_lpos
  data_push_tail()
    lpos = dr->tail_lpos
				prb_reserve()
				  # reserve the location of current
				  # dr->tail_lpos
				prb_commit()

    id = blk->id
    # read id for the freshly written data on CPU1
    # and happily make them reusable
    data_make_reusable()


=> We should add a check into data_make_reusable() that
   we are invalidating really the descriptor pointing to
   the given lpos and not a freshly reused one!


> >> +
> >> +	return true;
> >> +}
> >> +
> >> +/*
> >> + * Advance the desc ring tail. This function advances the tail by one
> >> + * descriptor, thus invalidating the oldest descriptor. Before advancing
> >> + * the tail, the tail descriptor is made reusable and all data blocks up to
> >> + * and including the descriptor's data block are invalidated (i.e. the data
> >> + * ring tail is pushed past the data block of the descriptor being made
> >> + * reusable).
> >> + */
> >> +static bool desc_push_tail(struct printk_ringbuffer *rb,
> >> +			   unsigned long tail_id)
> >> +{
> >> +	struct prb_desc_ring *desc_ring = &rb->desc_ring;
> >> +	enum desc_state d_state;
> >> +	struct prb_desc desc;
> >> +
> >> +	d_state = desc_read(desc_ring, tail_id, &desc);
> >> +
> >> +	switch (d_state) {
> >> +	case desc_miss:
> >> +		/*
> >> +		 * If the ID is exactly 1 wrap behind the expected, it is
> >> +		 * in the process of being reserved by another writer and
> >> +		 * must be considered reserved.
> >> +		 */
> >> +		if (DESC_ID(atomic_long_read(&desc.state_var)) ==
> >> +		    DESC_ID_PREV_WRAP(desc_ring, tail_id)) {
> >> +			return false;
> >> +		}
> >> +		return true;
> >> +	case desc_reserved:
> >> +		return false;
> >> +	case desc_committed:
> >> +		desc_make_reusable(desc_ring, tail_id);
> >> +		break;
> >> +	case desc_reusable:
> >> +		break;
> >> +	}
> >> +
> >> +	/*
> >> +	 * Data blocks must be invalidated before their associated
> >> +	 * descriptor can be made available for recycling. Invalidating
> >> +	 * them later is not possible because there is no way to trust
> >> +	 * data blocks once their associated descriptor is gone.
> >> +	 */
> >> +
> >> +	if (!data_push_tail(rb, &rb->text_data_ring, desc.text_blk_lpos.next))
> >> +		return false;
> >> +	if (!data_push_tail(rb, &rb->dict_data_ring, desc.dict_blk_lpos.next))
> >> +		return false;
> >> +
> >> +	/* The data ring tail(s) were pushed: LMM(desc_push_tail:A) */
> >> +
> >> +	/*
> >> +	 * Check the next descriptor after @tail_id before pushing the tail to
> >> +	 * it because the tail must always be in a committed or reusable
> >> +	 * state. The implementation of prb_first_seq() relies on this.
> >> +	 *
> >> +	 * A successful read implies that the next descriptor is less than or
> >> +	 * equal to @head_id so there is no risk of pushing the tail past the
> >> +	 * head.
> >> +	 */
> >> +	d_state = desc_read(desc_ring, DESC_ID(tail_id + 1),
> >> +			    &desc); /* LMM(desc_push_tail:B) */
> >> +	if (d_state == desc_committed || d_state == desc_reusable) {
> >> +		atomic_long_cmpxchg_relaxed(&desc_ring->tail_id, tail_id,
> >> +			DESC_ID(tail_id + 1)); /* LMM(desc_push_tail:C) */
> >
> > IMHO, we need smp_wmb() here so that everyone see updated
> > desc_ring->tail_id before we push the head as well.
> >
> > It would pair with read barrier in desc_reserve() between reading
> > tail_id and head_id.
> 
> Good catch! This secures probably the most critical point in your
> design: when desc_reserve() recognizes that it needs to push the
> descriptor tail.

Sigh, I moved into another mode. I wonder whether we need more
full smp_mb() barriers.

The tail might be pushed by one CPU and the head moved on another CPU.
Do we need smp_mb() before moving head instead?

> >> +	} else {
> >> +		/*
> >> +		 * Guarantee the last state load from desc_read() is before
> >> +		 * reloading @tail_id in order to see a new tail in the case
> >> +		 * that the descriptor has been recycled. This pairs with
> >> +		 * desc_reserve:A.
> >> +		 */
> >> +		smp_rmb(); /* LMM(desc_push_tail:D) */
> >> +
> >> +		/*
> >> +		 * Re-check the tail ID. The descriptor following @tail_id is
> >> +		 * not in an allowed tail state. But if the tail has since
> >> +		 * been moved by another task, then it does not matter.
> >> +		 *
> >> +		 * Memory barrier involvement:
> >> +		 *
> >> +		 * No possibility of missing a pushed tail.
> >> +		 * If desc_push_tail:B reads from desc_reserve:B, then
> >> +		 * desc_push_tail:E reads from desc_push_tail:C.
> >> +		 *
> >> +		 * Relies on:
> >> +		 *
> >> +		 * MB from desc_push_tail:C to desc_reserve:B
> >> +		 *    matching
> >> +		 * RMB from desc_push_tail:B to desc_push_tail:E
> >> +		 */
> >> +		if (atomic_long_read(&desc_ring->tail_id) ==
> >> +					tail_id) { /* LMM(desc_push_tail:E) */
> >> +			return false;
> >> +		}
> >> +	}
> >> +
> >> +	return true;
> >> +}
> >> +
> >> +/* Reserve a new descriptor, invalidating the oldest if necessary. */
> >> +static bool desc_reserve(struct printk_ringbuffer *rb, unsigned long *id_out)
> >> +{
> >> +	struct prb_desc_ring *desc_ring = &rb->desc_ring;
> >> +	unsigned long prev_state_val;
> >> +	unsigned long id_prev_wrap;
> >> +	struct prb_desc *desc;
> >> +	unsigned long head_id;
> >> +	unsigned long id;
> >> +
> >> +	head_id = atomic_long_read(&desc_ring->head_id);
> >> +
> >> +	do {
> >> +		desc = to_desc(desc_ring, head_id);
> >> +
> >> +		id = DESC_ID(head_id + 1);
> >> +		id_prev_wrap = DESC_ID_PREV_WRAP(desc_ring, id);
> >
> > IMHO, we need smp_rmb() here to to guarantee reading head_id before
> > desc_ring->tail_id.
> >
> > It would pair with write barrier in desc_push_tail() after updating
> > tail_id, see above.
> 
> Ack. Critical.
> 
> >> +
> >> +		if (id_prev_wrap == atomic_long_read(&desc_ring->tail_id)) {
> >> +			/*
> >> +			 * Make space for the new descriptor by
> >> +			 * advancing the tail.
> >> +			 */
> >> +			if (!desc_push_tail(rb, id_prev_wrap))
> >> +				return false;
> >> +		}

So, I wonder whether we actually need smp_mb() already here.
It would make sure that all CPUs see the updated tail_id before
head_id is updated. They both might be updated on different CPUs.

> >> +	} while (!atomic_long_try_cmpxchg_relaxed(&desc_ring->head_id,
> >> +						  &head_id, id));
> >> +
> >> +	/*
> >> +	 * Guarantee any data ring tail changes are stored before recycling
> >> +	 * the descriptor. A full memory barrier is needed since another
> >> +	 * task may have pushed the data ring tails. This pairs with
> >> +	 * data_push_tail:A.
> >> +	 *
> >> +	 * Guarantee a new tail ID is stored before recycling the descriptor.
> >> +	 * A full memory barrier is needed since another task may have pushed
> >> +	 * the tail ID. This pairs with desc_push_tail:D and prb_first_seq:C.
> >> +	 */
> >> +	smp_mb(); /* LMM(desc_reserve:A) */
> >
> > I am a bit confused by the full barrier here. The description is not
> > clear. All the three tags (data_push_tail:A, desc_push_tail:D and
> > prb_first_seq:C) refers read barriers. This would suggest that write
> > barrier would be enough here.
> 
> The above comment section states twice why a full memory barrier is
> needed: those writes may not have come from this task. We are not only
> ordering the visible writes that this task performed, we are also
> ordering the visible writes that this task has observed. Here is a
> litmus test demonstrating this:
> 
> C full-mb-test
> 
> {}
> 
> P0(int *x, int *y)
> {
> 	WRITE_ONCE(*x, 1);
> }
> 
> P1(int *x, int *y)
> {
> 	int tmp_x;
> 
> 	tmp_x = READ_ONCE(*x);
> 	if (tmp_x) {
> 		smp_mb();
> 		WRITE_ONCE(*y, 1);
> 	}
> }
> 
> P2(int *x, int *y)
> {
> 	int tmp_x;
> 	int tmp_y;
> 
> 	tmp_y = READ_ONCE(*y);
> 	smp_rmb();
> 	tmp_x = READ_ONCE(*x);
> }
> 
> exists (2:tmp_x=0 /\ 2:tmp_y=1)

Thanks a lot for this Litmus test. I have read several articles about
barrier and the memory model. But I forgot everything that I did not
use in practice.

I still have to shake my head about it.

Now, I came up with the idea that the full smp_mb() barrier should be
earlier (before head_id update). Then smp_wmb() might be enough here.
It would synchronize write to desc_ring->head_id and
desc->state_var. They both happen on the same CPU
by design.

Well, the full barrier smp_mb() might actually still be needed here
because of the paranoid prev_state_val check. It is a read and checks
against potential races with another CPUs.


> As mentioned above, I would put the smp_mb() before updating the
> @tail_id. That would pair with this smp_mb() and avoid the false
> positive on the @state_var check.

I am not comletely sure what you mean. Feel free to use your best
judgement in the next version of the patch. It seems that few more
barriers are needed and it is getting complicated to discuss
changes based on other changes wihtout seeing the code ;-)

> >> +
> >> +	desc = to_desc(desc_ring, id);
> >> +
> >> +	/* If the descriptor has been recycled, verify the old state val. */
> >> +	prev_state_val = atomic_long_read(&desc->state_var);
> >> +	if (prev_state_val && prev_state_val != (id_prev_wrap |
> >> +						 DESC_COMMITTED_MASK |
> >> +						 DESC_REUSE_MASK)) {
> >> +		WARN_ON_ONCE(1);
> >> +		return false;
> >> +	}
> >> +
> >> +	/* Assign the descriptor a new ID and set its state to reserved. */
> >> +	if (!atomic_long_try_cmpxchg_relaxed(&desc->state_var,
> >> +			&prev_state_val, id | 0)) { /* LMM(desc_reserve:B) */
> >> +		WARN_ON_ONCE(1);
> >> +		return false;
> >> +	}
> >> +
> >> +	/*
> >> +	 * Guarantee the new descriptor ID and state is stored before making
> >> +	 * any other changes. This pairs with desc_read:D.
> >> +	 */
> >> +	smp_wmb(); /* LMM(desc_reserve:C) */
> >> +
> >> +	/* Now data in @desc can be modified: LMM(desc_reserve:D) */
> >> +
> >> +	*id_out = id;
> >> +	return true;
> >> +}
> >> +
> >> +/*
> >> + * Allocate a new data block, invalidating the oldest data block(s)
> >> + * if necessary. This function also associates the data block with
> >> + * a specified descriptor.
> >> + */
> >> +static char *data_alloc(struct printk_ringbuffer *rb,
> >> +			struct prb_data_ring *data_ring, unsigned long size,
> >> +			struct prb_data_blk_lpos *blk_lpos, unsigned long id)
> >> +{
> >> +	struct prb_data_block *blk;
> >> +	unsigned long begin_lpos;
> >> +	unsigned long next_lpos;
> >> +
> >> +	if (!data_ring->data || size == 0) {
> >> +		/* Specify a data-less block. */
> >> +		blk_lpos->begin = INVALID_LPOS;
> >> +		blk_lpos->next = INVALID_LPOS;
> >> +		return NULL;
> >> +	}
> >> +
> >> +	size = to_blk_size(size);
> >> +
> >> +	begin_lpos = atomic_long_read(&data_ring->head_lpos);
> >> +
> >> +	do {
> >> +		next_lpos = get_next_lpos(data_ring, begin_lpos, size);
> >> +
> >
> > IMHO, we need smp_rmb() here to read begin_lpos before we read
> > tail_lpos in data_push_tail()
> >
> > It would pair with a write barrier in data_push_tail() after
> > updating data_ring->tail_lpos.
> 
> Please explain why this pair is necessary. What is the scenario that
> needs to be avoided?

What about this:

CPU0				  CPU1

data_alloc()

  begin_lpos = dr->head_lpos
				  data+alloc() (long message)
				    begin_lpos = dr->head_lpos
				    data_push_tail()
				      lpos = dr->tail_lpos
				      id = blk->id
				      date_make_reusable()
				      next_lpos = ...
				      cmpxchg(dr->tail_lpos, next_lpos)
				    cmpxchg(dr->head_lpos)

  begin_lpos = dr->head_lpos
    # reading new head
    data_push_tail()
      lpos = dr->tail_lpos
      # read old tail_lpos because of missing smp_rmb() amd wmb()
      data_make_reusable()
      # success because already done;
      cmpxchg(dr->tail_lpos, next_lpos)
      # fail because it sees the updated tail_lpos

OK, we repeat the cycle with the righ tail_lpos. So the only problem
is the extra cycle that might be prevented by the barrier.

Well, I still feel that the code will be much cleaner and rebust when
we do not rely on these things. In the current state, we rely on the
fact that data_make_reusable() is rebust enough to do not touch
outdated/reused descriptor.

Anyway, there is well defined order in which tail/head pos are read and
written. And it is just a call for problems when we do not synchronize
the reads and writers by barriers.


> >> +		if (!data_push_tail(rb, data_ring,
> >> +				    next_lpos - DATA_SIZE(data_ring))) {
> >> +			/* Failed to allocate, specify a data-less block. */
> >> +			blk_lpos->begin = INVALID_LPOS;
> >> +			blk_lpos->next = INVALID_LPOS;
> >> +			return NULL;
> >> +		}
> >> +	} while (!atomic_long_try_cmpxchg_relaxed(&data_ring->head_lpos,
> >> +						  &begin_lpos, next_lpos));
> >> +
> >
> > IMHO, we need smp_wmb() here to guarantee that others see the updated
> > data_ring->head_lpos before we write anything into the data buffer.
> >
> > It would pair with a read barrier in data_make_reusable
> > between reading tail_lpos and blk->id in data_make_reusable().
> 
> Please explain why this pair is necessary. What is the scenario that
> needs to be avoided?

Uff, I would need to take a day off before I think about this.
But I want to send this mail today, see below.

So I will just write a question. This code looks very similar to
desc_reserve(). We are pushing tail/head and writing into to
allocated space. Why do we need less barriers here?

> >> +	blk = to_block(data_ring, begin_lpos);
> >> +	blk->id = id;
> >> +
> >> +	if (DATA_WRAPS(data_ring, begin_lpos) !=
> >> +	    DATA_WRAPS(data_ring, next_lpos)) {
> >> +		/* Wrapping data blocks store their data at the beginning. */
> >> +		blk = to_block(data_ring, 0);
> >> +		blk->id = id;
> >> +	}
> >> +
> >> +	blk_lpos->begin = begin_lpos;
> >> +	blk_lpos->next = next_lpos;
> >> +
> >> +	return &blk->data[0];
> >> +}

I hope that the mail makes some sense. I feel that I still do not
understand it enough. I am not sure if it would be better to
discuss the things more, or see an updated version, or get
opinion from another person.

Anyway, I am not sure how responsible I would be during
the following days. My both hands are aching (Carpal tunnel
syndrome or so) and it is getting worse. I have to visit
a doctor. I hope that I will be able to work with some
bandage but...

Best Regards,
Petr
