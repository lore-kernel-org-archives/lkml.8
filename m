Return-Path: <SRS0=NqQd=7Y=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 210ADC433DF
	for <linux-kernel@archiver.kernel.org>; Thu, 11 Jun 2020 12:01:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 06883206C3
	for <linux-kernel@archiver.kernel.org>; Thu, 11 Jun 2020 12:01:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728010AbgFKMBN (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 11 Jun 2020 08:01:13 -0400
Received: from mx2.suse.de ([195.135.220.15]:52058 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726697AbgFKMBN (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 11 Jun 2020 08:01:13 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx2.suse.de (Postfix) with ESMTP id CDBC1ACB8;
        Thu, 11 Jun 2020 12:01:12 +0000 (UTC)
Date:   Thu, 11 Jun 2020 14:01:08 +0200
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
        kexec@lists.infradead.org, linux-kernel@vger.kernel.org,
        Paul McKenney <paulmck@kernel.org>
Subject: Re: Barrier before pushing desc_ring tail: was [PATCH v2 2/3]
 printk: add lockless buffer
Message-ID: <20200611120107.GD6581@linux-b0ei>
References: <20200501094010.17694-1-john.ogness@linutronix.de>
 <20200501094010.17694-3-john.ogness@linutronix.de>
 <20200609113751.GD23752@linux-b0ei>
 <87d068utbg.fsf@vostro.fn.ogness.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <87d068utbg.fsf@vostro.fn.ogness.net>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue 2020-06-09 17:56:03, John Ogness wrote:
> On 2020-06-09, Petr Mladek <pmladek@suse.com> wrote:
> >> --- /dev/null
> >> +++ b/kernel/printk/printk_ringbuffer.c
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
> >> +
> >> +		/*
> >> +		 * The ID has changed. Another writer must have pushed the
> >> +		 * tail and recycled the descriptor already. Success is
> >> +		 * returned because the caller is only interested in the
> >> +		 * specified tail being pushed, which it was.
> >> +		 */
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
> >> +	/*
> >> +	 * Check the next descriptor after @tail_id before pushing the tail
> >> +	 * to it because the tail must always be in a committed or reusable
> >> +	 * state. The implementation of prb_first_seq() relies on this.
> >> +	 *
> >> +	 * A successful read implies that the next descriptor is less than or
> >> +	 * equal to @head_id so there is no risk of pushing the tail past the
> >> +	 * head.
> >> +	 */
> >> +	d_state = desc_read(desc_ring, DESC_ID(tail_id + 1),
> >> +			    &desc); /* LMM(desc_push_tail:A) */
> >> +	if (d_state == desc_committed || d_state == desc_reusable) {
> >> +		/*
> >> +		 * Any CPU that loads the new tail ID, must see that the
> >> +		 * descriptor at @tail_id is in the reusable state. See the
> >> +		 * read memory barrier part of desc_reserve:D for details.
> >> +		 */
> >> +		atomic_long_cmpxchg_relaxed(&desc_ring->tail_id, tail_id,
> >> +			DESC_ID(tail_id + 1)); /* LMM(desc_push_tail:B) */
> >
> > I was quite confused by the above comment. Does it mean that we need
> > a barrier here? Or does it explain why the cmpxchg has its own
> > LMM marker?
> 
> This LMM marker is referenced quite often, but since it is a relaxed
> cmpxchg(), its significance is not immediately clear. I was hoping to
> add some hints as to why it is significant. The comment that it is
> referring to is:
> 
> 	/*
> 	 * Guarantee the tail ID is read before validating the
> 	 * recycled descriptor state. A read memory barrier is
> 	 * sufficient for this. This pairs with data_push_tail:C.
> 	 *
> 	 * Memory barrier involvement:
> 	 *
> 	 * If desc_reserve:C reads from desc_push_tail:B, then
> 	 * desc_reserve:F reads from desc_make_reusable:A.
> 	 *
> 	 * Relies on:
> 	 *
> 	 * MB from desc_make_reusable:A to desc_push_tail:B
> 	 *    matching
> 	 * RMB from desc_reserve:C to desc_reserve:F
> 	 *
> 	 * Note: desc_make_reusable:A, desc_push_tail:B, and
> 	 *       data_push_tail:C can all be different CPUs. However,
> 	 *       the desc_push_tail:B CPU must have previously seen
> 	 *       data_push_tail:D and the data_push_tail:D CPU (which
> 	 *       performs the full memory barrier) must have
> 	 *       previously seen desc_make_reusable:A.
> 	 */
> 
> English translation:
> 
> In order to push the data tail, a CPU must first see that the associated
> descriptor is in the reusable state. Since a full memory barrier is
> performed after that sighting and before doing the data tail push, _any_
> CPU that sees the pushed data tail will be able to see that the
> associated descriptor is in the reusable state.
> 
> In order to push the descriptor tail, a CPU must first see that the
> associated data tail has been pushed. Therefore, that CPU would also see
> that the associated descriptor is in the reusable state.

Thanks a lot for this detailed description. It helped a lot.

Let me try another description from slightly different angle:

All this relies on the fact the the full barrier is called in
data_push_tail() and data_push_tail() is called right above.
But there are two situations where the barrier is not called.
It is when:

  1. desc.text_blk_lpos.next already is behind data_ring->tail_lpos.

     This is safe.

     It might happen when there was a race in the past. CPU1 reserved
     a descriptor before CPU2 and CPU2 was able to allocate data block
     before CPU1.

     As a result, both descriptors and both data blocks were moved
     into reusable state when the earlier descriptor was reused.
     It is because it pointed to newer data block and the older data
     block must have been invalidated together with the newer
     descriptor.

     Now, the full barrier was called before tail_lpos was moved.
     Both descriptors must have been in the reusable state already.


  2. desc.text_blk_lpos == INVALID_LPOS.

     It seems that this is not synchronized and other CPUs might see
     the old state.

     It happens for data blocks that do not have any data. So it
     probably does not cause real problems but ...



> > I think that we actually need a full barrier here to make sure that
> > all CPUs see the changes made by data_push_tail() before we
> > allow to rewrite the descriptor. The changes in data_push_tail() might
> > be done on different CPUs.
> 
> How so? That memory barrier exists to make sure the reusable descriptor
> state is stored before pushing the data tail. This is important for
> readers (which start from the data tail) so they can notice if the
> descriptor has since been invalidated (reusable state).
> 
> But where is it important that the data tail change is seen before the
> descriptor tail change? How are the data tail and descriptor tail
> significantly related to each other?

I have to admit that I did not think about it deeply enough. It was
more about feeling and seeing similar pattern.

You have a point. The state value of the descriptor is the central
point. It is used to synchronize operations with both desc_ring and
data_ring.

The state is modified only once. So one (full) memory barrier should
be enough to synchronize all CPUs.

The state has to be modified before the data block could be reused.
Therefore the full barrier has to be already in the data_ring code.

The question is what to do with the empty data case. I see three
possibilities:

  1. Ignore the case with empty block because it (probably) does not
     cause real problems.

  2. Call the full barrier in data_push_tail() even when the data
     block is empty.

  3. Call the full barrier also in desc_push_tail() as I suggested.


My opinion:

I prefer 3rd solution. The barrier would be superfluous in the most
common situation. But it would create more error-proof code.
We could always optimize it when it causes problems.

Anyway, I would feel very uneasy about the the 1st solution. And the
2nd solution is weird. It would be hard to explain.


Best Regards,
Petr

PS: I start feeling more confident about the code. The more barriers
the less possible races ;-)
