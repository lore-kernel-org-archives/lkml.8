Return-Path: <SRS0=CUu6=46=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 11CB4C10DCE
	for <linux-kernel@archiver.kernel.org>; Fri, 13 Mar 2020 10:13:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E95262074A
	for <linux-kernel@archiver.kernel.org>; Fri, 13 Mar 2020 10:13:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726464AbgCMKN2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 13 Mar 2020 06:13:28 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:46219 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726216AbgCMKN2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 Mar 2020 06:13:28 -0400
Received: from localhost ([127.0.0.1] helo=vostro.local)
        by Galois.linutronix.de with esmtp (Exim 4.80)
        (envelope-from <john.ogness@linutronix.de>)
        id 1jChJf-0001vT-F0; Fri, 13 Mar 2020 11:13:19 +0100
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
        <87h7zcjkxy.fsf@linutronix.de>
        <20200304150805.yzda34paahstageq@pathway.suse.cz>
Date:   Fri, 13 Mar 2020 11:13:16 +0100
Message-ID: <87ftecy343.fsf@linutronix.de>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.4 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

This is quite a long response. I can summarize here:

- Several new memory barrier pairs were identified.

- The placement of a memory barrier was incorrect.

There are now quite a few changes queued up for v2. I will try to get
this posted soon. Also, I believe we've now identified the cmpxchg's
that really need the full memory barriers. So I will be folding all the
memory barriers into cmpxchg() calls where applicable and include the
appropriate memory barrier documentation.

And now my response...

On 2020-03-04, Petr Mladek <pmladek@suse.com> wrote:
>>>> diff --git a/kernel/printk/printk_ringbuffer.c b/kernel/printk/printk_ringbuffer.c
>>>> new file mode 100644
>>>> index 000000000000..796257f226ee
>>>> --- /dev/null
>>>> +++ b/kernel/printk/printk_ringbuffer.c
>>>> +/*
>>>> + * Take a given descriptor out of the committed state by attempting
>>>> + * the transition from committed to reusable. Either this task or some
>>>> + * other task will have been successful.
>>>> + */
>>>> +static void desc_make_reusable(struct prb_desc_ring *desc_ring,
>>>> +			       unsigned long id)
>>>> +{
>>>> +	struct prb_desc *desc = to_desc(desc_ring, id);
>>>> +	atomic_long_t *state_var = &desc->state_var;
>>>> +	unsigned long val_committed = id | DESC_COMMITTED_MASK;
>>>> +	unsigned long val_reusable = val_committed | DESC_REUSE_MASK;
>>>> +
>>>> +	atomic_long_cmpxchg_relaxed(state_var, val_committed,
>>>> val_reusable);
>>>
>>> IMHO, we should add smp_wmb() here to make sure that the reusable
>>> state is written before we shuffle the desc_ring->tail_id/head_id.
>>>
>>> It would pair with the read part of smp_mb() in desc_reserve()
>>> before the extra check if the descriptor is really in reusable state.
>> 
>> Yes. Now that we added the extra state checking in desc_reserve(),
>> this ordering has become important.
>> 
>> However, for this case I would prefer to instead place a full memory
>> barrier immediately before @tail_id is incremented (in
>> desc_push_tail()). The tail-incrementing-task must have seen the
>> reusable state (even if it is not the one that set it) and an
>> incremented @tail_id must be visible to the task recycling a
>> descriptor.
>
> I agree that this is exactly the place when the full barrier will be
> needed. This write can happen on any CPU and the write depending on
> this value might be done on another CPU.
>
> Also I agree that desc_push_tail() looks like the right place
> for the full barrier because some actions there are done only
> when the descriptor is invalidated.
>
> I just wonder if it should be even before data_push_tail()
> calls. It will make sure that everyone sees the reusable state
> before we move the data_ring borders.

You are correct. The reader is only ordering data reads against the
state of the _descriptor that is being read_. The reader may not yet see
that its descriptor has transitioned to reusable while a writer may have
already recycled the data block (associated with a _different_
descriptor) and started writing something new.

The problem is a missing ordering between setting the descriptor to
reusable and any possibilty of data block recycling (e.g. the data tail
is pushed). Inserting a full memory barrier after setting the state to
reusable and before pushing the data tail will fix that. Then if the
reader reads newer data, it must see that its descriptor state is no
longer committed.

Changing the cmpxchg_relaxed() in data_push_tail() to cmpxchg() will add
the needed full memory barrier. I felt uneasy about making that
cmpxchg() relaxed but couldn't prove why. Thanks for seeing it!

>>>> +}
>>>> +
>>>> +/*
>>>> + * For a given data ring (text or dict) and its current tail lpos:
>>>> + * for each data block up until @lpos, make the associated descriptor
>>>> + * reusable.
>>>> + *
>>>> + * If there is any problem making the associated descriptor reusable,
>>>> + * either the descriptor has not yet been committed or another writer
>>>> + * task has already pushed the tail lpos past the problematic data
>>>> + * block. Regardless, on error the caller can re-load the tail lpos
>>>> + * to determine the situation.
>>>> + */
>>>> +static bool data_make_reusable(struct printk_ringbuffer *rb,
>>>> +			       struct prb_data_ring *data_ring,
>>>> +			       unsigned long tail_lpos, unsigned long lpos,
>>>> +			       unsigned long *lpos_out)
>>>> +{
>>>> +	struct prb_desc_ring *desc_ring = &rb->desc_ring;
>>>> +	struct prb_data_blk_lpos *blk_lpos;
>>>> +	struct prb_data_block *blk;
>>>> +	enum desc_state d_state;
>>>> +	struct prb_desc desc;
>>>> +	unsigned long id;
>>>> +
>>>> +	/*
>>>> +	 * Using the provided @data_ring, point @blk_lpos to the correct
>>>> +	 * blk_lpos within the local copy of the descriptor.
>>>> +	 */
>>>> +	if (data_ring == &rb->text_data_ring)
>>>> +		blk_lpos = &desc.text_blk_lpos;
>>>> +	else
>>>> +		blk_lpos = &desc.dict_blk_lpos;
>>>> +
>>>> +	/* Loop until @tail_lpos has advanced to or beyond @lpos. */
>>>> +	while ((lpos - tail_lpos) - 1 < DATA_SIZE(data_ring)) {
>>>> +		blk = to_block(data_ring, tail_lpos);
>>>> +		id = READ_ONCE(blk->id);
>
> This brings the question whether the smp_rmb() would make sense here
> to make sure that desc_read() see the descriptor state that allowed
> allocating this space.
>
> It would pair with smp_wmb() in desc_reserve() right after
> setting desc->state_var to the newly reserved descriptor id.
> It is the barrier that will allow to modify the reserved space,
> including writing the reserved id into the later reserved blk->id.
>
> Note that desc_read() does not have smp_rmb() before the first
> read of the state_var. It might theoretically see an outdated
> value.

The descriptor read in desc_read() has an address dependency on the @id
argument, and thus an address dependency on the READ_ONCE(blk->id)
above. With that we have an implicit smp_rmb(). (The CPU cannot load the
descriptor without first loading the index for that descriptor.)

However, this deserves some comments describing the relied ordering. (An
explicit smp_rmb() will probably be added here anyway for other
reasons. See below.)

>>>> +
>>>> +		d_state = desc_read(desc_ring, id,
>>>> +				    &desc); /* LMM(data_make_reusable:A) */
>>>> +
>>>> +		switch (d_state) {
>>>> +		case desc_miss:
>>>> +			return false;
>>>> +		case desc_reserved:
>>>> +			return false;
>>>> +		case desc_committed:
>>>> +			/*
>>>> +			 * This data block is invalid if the descriptor
>>>> +			 * does not point back to it.
>>>> +			 */
>>>> +			if (blk_lpos->begin != tail_lpos)
>>>> +				return false;
>>>> +			desc_make_reusable(desc_ring, id);
>>>> +			break;
>>>> +		case desc_reusable:
>>>> +			/*
>>>> +			 * This data block is invalid if the descriptor
>>>> +			 * does not point back to it.
>>>> +			 */
>>>> +			if (blk_lpos->begin != tail_lpos)
>>>> +				return false;
>>>> +			break;
>>>> +		}
>>>> +
>>>> +		/* Advance @tail_lpos to the next data block. */
>>>> +		tail_lpos = blk_lpos->next;
>>>> +	}
>>>> +
>>>> +	*lpos_out = tail_lpos;
>>>> +
>>>> +	return true;
>>>> +}
>>>> +
>>>> +/*
>>>> + * Advance the data ring tail to at least @lpos. This function puts all
>>>> + * descriptors into the reusable state if the tail will be pushed beyond
>>>> + * their associated data block.
>>>> + */
>>>> +static bool data_push_tail(struct printk_ringbuffer *rb,
>>>> +			   struct prb_data_ring *data_ring,
>>>> +			   unsigned long lpos)
>>>> +{
>>>> +	unsigned long tail_lpos;
>>>> +	unsigned long next_lpos;
>>>> +
>>>> +	/* If @lpos is not valid, there is nothing to do. */
>>>> +	if (lpos == INVALID_LPOS)
>>>> +		return true;
>>>> +
>>>> +	tail_lpos = atomic_long_read(&data_ring->tail_lpos);
>>>> +
>>>> +	do {
>>>> +		/* If @lpos is no longer valid, there is nothing to do. */
>>>> +		if (lpos - tail_lpos >= DATA_SIZE(data_ring))
>>>> +			break;
>>>> +
>>>> +		/*
>>>> +		 * Make all descriptors reusable that are associated with
>>>> +		 * data blocks before @lpos.
>>>> +		 */
>>>> +		if (!data_make_reusable(rb, data_ring, tail_lpos, lpos,
>>>> +					&next_lpos)) {
>>>> +			/*
>>>> +			 * data_make_reusable() performed state loads. Make
>>>> +			 * sure they are loaded before reloading the tail lpos
>>>> +			 * in order to see a new tail in the case that the
>>>> +			 * descriptor has been recycled. This pairs with
>>>> +			 * desc_reserve:A.
>>>> +			 */
>>>> +			smp_rmb(); /* LMM(data_push_tail:A) */
>>>> +
>>>> +			/*
>>>> +			 * Reload the tail lpos.
>>>> +			 *
>>>> +			 * Memory barrier involvement:
>>>> +			 *
>>>> +			 * No possibility of missing a recycled descriptor.
>>>> +			 * If data_make_reusable:A reads from desc_reserve:B,
>>>> +			 * then data_push_tail:B reads from desc_push_tail:A.
>>>> +			 *
>>>> +			 * Relies on:
>>>> +			 *
>>>> +			 * MB from desc_push_tail:A to desc_reserve:B
>>>> +			 *    matching
>>>> +			 * RMB from data_make_reusable:A to data_push_tail:B
>>>> +			 */
>>>> +			next_lpos = atomic_long_read(&data_ring->tail_lpos
>>>> +						); /* LMM(data_push_tail:B) */
>>>> +			if (next_lpos == tail_lpos)
>>>> +				return false;
>>>> +
>>>> +			/* Another task pushed the tail. Try again. */
>>>> +			tail_lpos = next_lpos;
>>>> +		}
>>>> +	} while (!atomic_long_try_cmpxchg_relaxed(&data_ring->tail_lpos,
>>>> +			&tail_lpos, next_lpos)); /* can be relaxed? */
>>>
>>> IMHO, we need smp_wmb() here so that others see the updated
>>> data_ring->tail_lpos before this thread allocates the space
>>> by pushing head_pos.
>>>
>>> It would be paired with a read barrier in data_alloc() between
>>> reading head_lpos and tail_lpos, see below.
>> 
>> data_push_tail() is the only function that concerns itself with
>> @tail_lpos. Its cmpxchg-loop will prevent any unintended consequences.
>> And it uses the memory barrier pair data_push_tail:A/desc_reserve:A to
>> make sure that @tail_lpos reloads will successfully identify a changed
>> @tail_lpos due to descriptor recycling (which is the only reason that
>> @tail_lpos changes).
>> 
>> Why is it a problem if the movement of @head_lpos is seen before the
>> movement of @tail_lpos? Please explain.
>
> This was again motivated by the idea that cmpxchg_relaxed() is week
> and it should be more safe to synchronize other variables.
>
> OK, "tail_pos" and "head_pos" are closely related. The question is
> how they are synchronized.
>
> Hmm, there is the read barrier in LMM(data_push_tail:A) that probably
> solves many problems. But what about the following scenario:
>
> CPU0				  CPU1
>
> data_alloc()
>   begin_lpos = dr->head_lpos
> 				  data+alloc()
> 				    begin_lpos = dr->head_lpos
> 				    data_push_tail()
> 				      lpos = dr->tail_lpos
> 				      id = blk->id
> 				      date_make_reusable()
> 				      next_lpos = ...
> 				      cmpxchg(dr->tail_lpos, next_lpos)
> 				    cmpxchg(dr->head_lpos)
>
> 				    blk->id = id;
>
>   data_push_tail()
>     lpos = dr->tail_lpos
>     # read old tail_lpos because of missing smp_rmb() amd wmb()
>     id = blk->id
>     # read new id because the CPU see its new state
>     data_make_reusable()
>     # fail because id points to the newly allocated block that
>     # is still in reserved state [*]
>     smp_rmb()
>     next_lpos = dr->tail_lpos
>     # reading still outdated tail_lpos because there is no smp_wmb()
>     # between updating tail_lpos and head_lpos
>
> BANG:
>
>     data_push_tail() would wrongly return false
>     => data_alloc() would fail
>
> This won't happen if there was the proposed smp_wmb() at this
> location.

Changing the @tail_lpos update to a full barrier cmpxchg() (as mentioned
above) will solve this problem.

> [*] Another problem would be when data_make_reusable() see the new
>     data already in the commited state. It would make fresh new
>     data reusable.
>
>     I mean the following:
>
> CPU0				CPU1
>
> data_alloc()
>   begin_lpos = dr->head_lpos
>   data_push_tail()
>     lpos = dr->tail_lpos
> 				prb_reserve()
> 				  # reserve the location of current
> 				  # dr->tail_lpos
> 				prb_commit()
>
>     id = blk->id
>     # read id for the freshly written data on CPU1
>     # and happily make them reusable
>     data_make_reusable()

Ouch.

> => We should add a check into data_make_reusable() that
>    we are invalidating really the descriptor pointing to
>    the given lpos and not a freshly reused one!

The issue is that data_make_reusable() is not seeing that the tail has
moved.

What about if data_make_reusable() does something like:

    id = READ_ONCE(blk->id);
    smp_rmb();
    ... code to check if tail has moved beyond @tail_lpos ...
    d_state = desc_read()
    
The smp_rmb() would pair with the full barrier cmpxchg() of pushing the
data tail (to be added, as mentioned already). So if a new ID in the
block is seen then a new tail must also be visible.

>>>> +
>>>> +	return true;
>>>> +}
>>>> +
>>>> +/*
>>>> + * Advance the desc ring tail. This function advances the tail by one
>>>> + * descriptor, thus invalidating the oldest descriptor. Before advancing
>>>> + * the tail, the tail descriptor is made reusable and all data blocks up to
>>>> + * and including the descriptor's data block are invalidated (i.e. the data
>>>> + * ring tail is pushed past the data block of the descriptor being made
>>>> + * reusable).
>>>> + */
>>>> +static bool desc_push_tail(struct printk_ringbuffer *rb,
>>>> +			   unsigned long tail_id)
>>>> +{
>>>> +	struct prb_desc_ring *desc_ring = &rb->desc_ring;
>>>> +	enum desc_state d_state;
>>>> +	struct prb_desc desc;
>>>> +
>>>> +	d_state = desc_read(desc_ring, tail_id, &desc);
>>>> +
>>>> +	switch (d_state) {
>>>> +	case desc_miss:
>>>> +		/*
>>>> +		 * If the ID is exactly 1 wrap behind the expected, it is
>>>> +		 * in the process of being reserved by another writer and
>>>> +		 * must be considered reserved.
>>>> +		 */
>>>> +		if (DESC_ID(atomic_long_read(&desc.state_var)) ==
>>>> +		    DESC_ID_PREV_WRAP(desc_ring, tail_id)) {
>>>> +			return false;
>>>> +		}
>>>> +		return true;
>>>> +	case desc_reserved:
>>>> +		return false;
>>>> +	case desc_committed:
>>>> +		desc_make_reusable(desc_ring, tail_id);
>>>> +		break;
>>>> +	case desc_reusable:
>>>> +		break;
>>>> +	}
>>>> +
>>>> +	/*
>>>> +	 * Data blocks must be invalidated before their associated
>>>> +	 * descriptor can be made available for recycling. Invalidating
>>>> +	 * them later is not possible because there is no way to trust
>>>> +	 * data blocks once their associated descriptor is gone.
>>>> +	 */
>>>> +
>>>> +	if (!data_push_tail(rb, &rb->text_data_ring, desc.text_blk_lpos.next))
>>>> +		return false;
>>>> +	if (!data_push_tail(rb, &rb->dict_data_ring, desc.dict_blk_lpos.next))
>>>> +		return false;
>>>> +
>>>> +	/* The data ring tail(s) were pushed: LMM(desc_push_tail:A) */
>>>> +
>>>> +	/*
>>>> +	 * Check the next descriptor after @tail_id before pushing the tail to
>>>> +	 * it because the tail must always be in a committed or reusable
>>>> +	 * state. The implementation of prb_first_seq() relies on this.
>>>> +	 *
>>>> +	 * A successful read implies that the next descriptor is less than or
>>>> +	 * equal to @head_id so there is no risk of pushing the tail past the
>>>> +	 * head.
>>>> +	 */
>>>> +	d_state = desc_read(desc_ring, DESC_ID(tail_id + 1),
>>>> +			    &desc); /* LMM(desc_push_tail:B) */
>>>> +	if (d_state == desc_committed || d_state == desc_reusable) {
>>>> +		atomic_long_cmpxchg_relaxed(&desc_ring->tail_id, tail_id,
>>>> +			DESC_ID(tail_id + 1)); /* LMM(desc_push_tail:C) */
>>>
>>> IMHO, we need smp_wmb() here so that everyone see updated
>>> desc_ring->tail_id before we push the head as well.
>>>
>>> It would pair with read barrier in desc_reserve() between reading
>>> tail_id and head_id.
>> 
>> Good catch! This secures probably the most critical point in your
>> design: when desc_reserve() recognizes that it needs to push the
>> descriptor tail.
>
> Sigh, I moved into another mode. I wonder whether we need more
> full smp_mb() barriers.
>
> The tail might be pushed by one CPU and the head moved on another CPU.

Correct. You just made me realize that I wasn't using enough tasks in my
litmus tests here. :-/

> Do we need smp_mb() before moving head instead?

Yes. I wrote a litmus test to verify it (below). It includes _3_
identical tasks that are doing the critical tail/head checking and
pushing from desc_reserve(). 3 tasks are needed in order to establish
the scenario that one CPU "relax pushed" the head and another CPU "relax
pushed" the tail. The third CPU then has the danger that it sees the
head pushed, but not the tail (i.e. the head has wrapped over the
tail). And in that case it will skip the tail push and successfully push
the head.

In the litmus test I used variable names similar to the actual code. I
think it makes the litmus test harder to read, but probably easier to
verify that it is representing the code.

(There probably is a way of specifying functions or specifing that a
task should run in parallel. But I don't know it. So you will have to
excuse the copy/pasting in the litmus test. Sorry.)

>>>> +	} else {
>>>> +		/*
>>>> +		 * Guarantee the last state load from desc_read() is before
>>>> +		 * reloading @tail_id in order to see a new tail in the case
>>>> +		 * that the descriptor has been recycled. This pairs with
>>>> +		 * desc_reserve:A.
>>>> +		 */
>>>> +		smp_rmb(); /* LMM(desc_push_tail:D) */
>>>> +
>>>> +		/*
>>>> +		 * Re-check the tail ID. The descriptor following @tail_id is
>>>> +		 * not in an allowed tail state. But if the tail has since
>>>> +		 * been moved by another task, then it does not matter.
>>>> +		 *
>>>> +		 * Memory barrier involvement:
>>>> +		 *
>>>> +		 * No possibility of missing a pushed tail.
>>>> +		 * If desc_push_tail:B reads from desc_reserve:B, then
>>>> +		 * desc_push_tail:E reads from desc_push_tail:C.
>>>> +		 *
>>>> +		 * Relies on:
>>>> +		 *
>>>> +		 * MB from desc_push_tail:C to desc_reserve:B
>>>> +		 *    matching
>>>> +		 * RMB from desc_push_tail:B to desc_push_tail:E
>>>> +		 */
>>>> +		if (atomic_long_read(&desc_ring->tail_id) ==
>>>> +					tail_id) { /* LMM(desc_push_tail:E) */
>>>> +			return false;
>>>> +		}
>>>> +	}
>>>> +
>>>> +	return true;
>>>> +}
>>>> +
>>>> +/* Reserve a new descriptor, invalidating the oldest if necessary. */
>>>> +static bool desc_reserve(struct printk_ringbuffer *rb, unsigned long *id_out)
>>>> +{
>>>> +	struct prb_desc_ring *desc_ring = &rb->desc_ring;
>>>> +	unsigned long prev_state_val;
>>>> +	unsigned long id_prev_wrap;
>>>> +	struct prb_desc *desc;
>>>> +	unsigned long head_id;
>>>> +	unsigned long id;
>>>> +
>>>> +	head_id = atomic_long_read(&desc_ring->head_id);
>>>> +
>>>> +	do {
>>>> +		desc = to_desc(desc_ring, head_id);
>>>> +
>>>> +		id = DESC_ID(head_id + 1);
>>>> +		id_prev_wrap = DESC_ID_PREV_WRAP(desc_ring, id);
>>>
>>> IMHO, we need smp_rmb() here to to guarantee reading head_id before
>>> desc_ring->tail_id.
>>>
>>> It would pair with write barrier in desc_push_tail() after updating
>>> tail_id, see above.
>> 
>> Ack. Critical.
>> 
>>>> +
>>>> +		if (id_prev_wrap == atomic_long_read(&desc_ring->tail_id)) {
>>>> +			/*
>>>> +			 * Make space for the new descriptor by
>>>> +			 * advancing the tail.
>>>> +			 */
>>>> +			if (!desc_push_tail(rb, id_prev_wrap))
>>>> +				return false;
>>>> +		}
>
> So, I wonder whether we actually need smp_mb() already here.
> It would make sure that all CPUs see the updated tail_id before
> head_id is updated. They both might be updated on different CPUs.

As written above, yes.

>>>> +	} while (!atomic_long_try_cmpxchg_relaxed(&desc_ring->head_id,
>>>> +						  &head_id, id));
>>>> +
>>>> +	/*
>>>> +	 * Guarantee any data ring tail changes are stored before recycling
>>>> +	 * the descriptor. A full memory barrier is needed since another
>>>> +	 * task may have pushed the data ring tails. This pairs with
>>>> +	 * data_push_tail:A.
>>>> +	 *
>>>> +	 * Guarantee a new tail ID is stored before recycling the descriptor.
>>>> +	 * A full memory barrier is needed since another task may have pushed
>>>> +	 * the tail ID. This pairs with desc_push_tail:D and prb_first_seq:C.
>>>> +	 */
>>>> +	smp_mb(); /* LMM(desc_reserve:A) */

> Now, I came up with the idea that the full smp_mb() barrier should be
> earlier (before head_id update).

As written above, yes.

> Then smp_wmb() might be enough here. It would synchronize write to
> desc_ring->head_id and desc->state_var. They both happen on the same
> CPU by design.

The smp_mb() here is not responsible for any ordering between storing a
new head ID and setting the new descriptor state. When we move the
smp_mb() up before the head ID update, it will suffice.

> Well, the full barrier smp_mb() might actually still be needed here
> because of the paranoid prev_state_val check. It is a read and checks
> against potential races with another CPUs.

Here is the same. The smp_mb() here is not responsible for any ordering
between reading a new head ID and reading the new descriptor state. When
we move the smp_mb() up before the head ID update, it will suffice.

>>>> +
>>>> +	desc = to_desc(desc_ring, id);
>>>> +
>>>> +	/* If the descriptor has been recycled, verify the old state val. */
>>>> +	prev_state_val = atomic_long_read(&desc->state_var);
>>>> +	if (prev_state_val && prev_state_val != (id_prev_wrap |
>>>> +						 DESC_COMMITTED_MASK |
>>>> +						 DESC_REUSE_MASK)) {
>>>> +		WARN_ON_ONCE(1);
>>>> +		return false;
>>>> +	}
>>>> +
>>>> +	/* Assign the descriptor a new ID and set its state to reserved. */
>>>> +	if (!atomic_long_try_cmpxchg_relaxed(&desc->state_var,
>>>> +			&prev_state_val, id | 0)) { /* LMM(desc_reserve:B) */
>>>> +		WARN_ON_ONCE(1);
>>>> +		return false;
>>>> +	}
>>>> +
>>>> +	/*
>>>> +	 * Guarantee the new descriptor ID and state is stored before making
>>>> +	 * any other changes. This pairs with desc_read:D.
>>>> +	 */
>>>> +	smp_wmb(); /* LMM(desc_reserve:C) */
>>>> +
>>>> +	/* Now data in @desc can be modified: LMM(desc_reserve:D) */
>>>> +
>>>> +	*id_out = id;
>>>> +	return true;
>>>> +}
>>>> +
>>>> +/*
>>>> + * Allocate a new data block, invalidating the oldest data block(s)
>>>> + * if necessary. This function also associates the data block with
>>>> + * a specified descriptor.
>>>> + */
>>>> +static char *data_alloc(struct printk_ringbuffer *rb,
>>>> +			struct prb_data_ring *data_ring, unsigned long size,
>>>> +			struct prb_data_blk_lpos *blk_lpos, unsigned long id)
>>>> +{
>>>> +	struct prb_data_block *blk;
>>>> +	unsigned long begin_lpos;
>>>> +	unsigned long next_lpos;
>>>> +
>>>> +	if (!data_ring->data || size == 0) {
>>>> +		/* Specify a data-less block. */
>>>> +		blk_lpos->begin = INVALID_LPOS;
>>>> +		blk_lpos->next = INVALID_LPOS;
>>>> +		return NULL;
>>>> +	}
>>>> +
>>>> +	size = to_blk_size(size);
>>>> +
>>>> +	begin_lpos = atomic_long_read(&data_ring->head_lpos);
>>>> +
>>>> +	do {
>>>> +		next_lpos = get_next_lpos(data_ring, begin_lpos, size);
>>>> +
>>>
>>> IMHO, we need smp_rmb() here to read begin_lpos before we read
>>> tail_lpos in data_push_tail()
>>>
>>> It would pair with a write barrier in data_push_tail() after
>>> updating data_ring->tail_lpos.
>> 
>> Please explain why this pair is necessary. What is the scenario that
>> needs to be avoided?
>
> What about this:
>
> CPU0				  CPU1
>
> data_alloc()
>
>   begin_lpos = dr->head_lpos
> 				  data+alloc() (long message)
> 				    begin_lpos = dr->head_lpos
> 				    data_push_tail()
> 				      lpos = dr->tail_lpos
> 				      id = blk->id
> 				      date_make_reusable()
> 				      next_lpos = ...
> 				      cmpxchg(dr->tail_lpos, next_lpos)
> 				    cmpxchg(dr->head_lpos)
>
>   begin_lpos = dr->head_lpos
>     # reading new head
>     data_push_tail()
>       lpos = dr->tail_lpos
>       # read old tail_lpos because of missing smp_rmb() amd wmb()
>       data_make_reusable()
>       # success because already done;
>       cmpxchg(dr->tail_lpos, next_lpos)
>       # fail because it sees the updated tail_lpos
>
> OK, we repeat the cycle with the righ tail_lpos. So the only problem
> is the extra cycle that might be prevented by the barrier.
>
> Well, I still feel that the code will be much cleaner and rebust when
> we do not rely on these things. In the current state, we rely on the
> fact that data_make_reusable() is rebust enough to do not touch
> outdated/reused descriptor.
>
> Anyway, there is well defined order in which tail/head pos are read and
> written. And it is just a call for problems when we do not synchronize
> the reads and writers by barriers.

It would be a barrier that only optimizes a very particular case,
penalizing the main case. There are other reasons that the cmpxchg()
could fail and the loop repeat, even with an smp_rmb() here. And in most
cases, the cmpxchg() will not fail anyway.

It adds complexity by declaring yet another barrier pair. IMHO it is not
a "call for problems" to rely on cmpxchg() failing if the expected value
changed. I think it is more important to keep the barrier pairs to a
minimal set of _necessary_ barriers.

>>>> +		if (!data_push_tail(rb, data_ring,
>>>> +				    next_lpos - DATA_SIZE(data_ring))) {
>>>> +			/* Failed to allocate, specify a data-less block. */
>>>> +			blk_lpos->begin = INVALID_LPOS;
>>>> +			blk_lpos->next = INVALID_LPOS;
>>>> +			return NULL;
>>>> +		}
>>>> +	} while (!atomic_long_try_cmpxchg_relaxed(&data_ring->head_lpos,
>>>> +						  &begin_lpos, next_lpos));
>>>> +
>>>
>>> IMHO, we need smp_wmb() here to guarantee that others see the updated
>>> data_ring->head_lpos before we write anything into the data buffer.
>>>
>>> It would pair with a read barrier in data_make_reusable
>>> between reading tail_lpos and blk->id in data_make_reusable().
>> 
>> Please explain why this pair is necessary. What is the scenario that
>> needs to be avoided?
>
> This code looks very similar to desc_reserve(). We are pushing
> tail/head and writing into to allocated space. Why do we need less
> barriers here?

The memory barrier pairing in desc_reserve() is necessary to order
descriptor reading with descriptor tail changes. For data we do not need
such a synchronization because data validity is guaranteed by the
descriptor states, not the data tail.

Note that above I talked about changing the cmpxchg_relaxed() in
data_push_tail() to cmpxchg() to deal with a data validity issue that
you discovered. That probably covers your gut feeling that we need
something here.

>>>> +	blk = to_block(data_ring, begin_lpos);
>>>> +	blk->id = id;
>>>> +
>>>> +	if (DATA_WRAPS(data_ring, begin_lpos) !=
>>>> +	    DATA_WRAPS(data_ring, next_lpos)) {
>>>> +		/* Wrapping data blocks store their data at the beginning. */
>>>> +		blk = to_block(data_ring, 0);
>>>> +		blk->id = id;
>>>> +	}
>>>> +
>>>> +	blk_lpos->begin = begin_lpos;
>>>> +	blk_lpos->next = next_lpos;
>>>> +
>>>> +	return &blk->data[0];
>>>> +}
>
> Anyway, I am not sure how responsible I would be during
> the following days. My both hands are aching (Carpal tunnel
> syndrome or so) and it is getting worse. I have to visit
> a doctor. I hope that I will be able to work with some
> bandage but...

Please take care of yourself!

Here is the litmust test I talked about above, showing that smp_rb()
together with the smp_mb() before the head ID update does indeed avoid
the fail case.

------ begin desc-reserve.litmus ------
C desc-reserve

(*
 * Result: Never
 *
 * Make sure the head ID can never be pushed past the tail ID.
 *)

{
	dr_head_id = 0;
	dr_tail_id = 1;
}

P0(int *dr_head_id, int *dr_tail_id)
{
	int tail_id_next;
	int id_prev_wrap;
	int head_id;
	int tail_id;
	int r0;
	int r1;

	head_id = READ_ONCE(*dr_head_id);
	id_prev_wrap = head_id + 1;

	// Guarantee the head ID is read before reading the tail ID.
	smp_rmb();

	tail_id = READ_ONCE(*dr_tail_id);

	if (id_prev_wrap == tail_id) {
		// Make space for the new descriptor by advancing the tail.
		tail_id_next = tail_id + 1;
		r0 = cmpxchg_relaxed(dr_tail_id, tail_id, tail_id_next);
	}

	// Guarantee a new tail ID is stored before recycling the descriptor.
	smp_mb();

	r1 = cmpxchg_relaxed(dr_head_id, head_id, id_prev_wrap);
}

// identical to P0
P1(int *dr_head_id, int *dr_tail_id)
{
	int tail_id_next;
	int id_prev_wrap;
	int head_id;
	int tail_id;
	int r0;
	int r1;

	head_id = READ_ONCE(*dr_head_id);
	id_prev_wrap = head_id + 1;

	// Guarantee the head ID is read before reading the tail ID.
	smp_rmb();

	tail_id = READ_ONCE(*dr_tail_id);

	if (id_prev_wrap == tail_id) {
		// Make space for the new descriptor by advancing the tail.
		tail_id_next = tail_id + 1;
		r0 = cmpxchg_relaxed(dr_tail_id, tail_id, tail_id_next);
	}

	// Guarantee a new tail ID is stored before recycling the descriptor.
	smp_mb();

	r1 = cmpxchg_relaxed(dr_head_id, head_id, id_prev_wrap);
}

// identical to P0
P2(int *dr_head_id, int *dr_tail_id)
{
	int tail_id_next;
	int id_prev_wrap;
	int head_id;
	int tail_id;
	int r0;
	int r1;

	head_id = READ_ONCE(*dr_head_id);
	id_prev_wrap = head_id + 1;

	// Guarantee the head ID is read before reading the tail ID.
	smp_rmb();

	tail_id = READ_ONCE(*dr_tail_id);

	if (id_prev_wrap == tail_id) {
		// Make space for the new descriptor by advancing the tail.
		tail_id_next = tail_id + 1;
		r0 = cmpxchg_relaxed(dr_tail_id, tail_id, tail_id_next);
	}

	// Guarantee a new tail ID is stored before recycling the descriptor.
	smp_mb();

	r1 = cmpxchg_relaxed(dr_head_id, head_id, id_prev_wrap);
}

exists (dr_head_id=2 /\ dr_tail_id=2)
------ end desc-reserve.litmus ------

$ herd7 -conf linux-kernel.cfg desc-reserve.litmus 
Test desc-reserve Allowed
States 3
dr_head_id=1; dr_tail_id=2;
dr_head_id=2; dr_tail_id=3;
dr_head_id=3; dr_tail_id=4;
No
Witnesses
Positive: 0 Negative: 138
Condition exists (dr_head_id=2 /\ dr_tail_id=2)
Observation desc-reserve Never 0 138
Time desc-reserve 490.62
Hash=4198247b011ab3db1ac8ff48152bbb18


Note that if the smp_mb() is _not_ moved up (even with an added
smp_rmb() in desc_reserve()), the fail case will happen:


$ herd7 -conf linux-kernel.cfg desc-reserve-bad.litmus 
Test desc-reserve Allowed
States 4
dr_head_id=1; dr_tail_id=2;
dr_head_id=2; dr_tail_id=2;  <---- head overtakes tail!
dr_head_id=2; dr_tail_id=3;
dr_head_id=3; dr_tail_id=4;
Ok
Witnesses
Positive: 24 Negative: 162
Condition exists (dr_head_id=2 /\ dr_tail_id=2)
Observation desc-reserve Sometimes 24 162
Time desc-reserve 515.87
Hash=1e80a5d56c53a87355d8a34a850cb7f5

The smp_mb() happens too late. Moving it before pushing the head ID
fixes the problem.

John Ogness
