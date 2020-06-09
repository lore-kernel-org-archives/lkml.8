Return-Path: <SRS0=F/Af=7W=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8E11EC433DF
	for <linux-kernel@archiver.kernel.org>; Tue,  9 Jun 2020 15:56:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 66D122072F
	for <linux-kernel@archiver.kernel.org>; Tue,  9 Jun 2020 15:56:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731025AbgFIP4K (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 9 Jun 2020 11:56:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51996 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728888AbgFIP4J (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 9 Jun 2020 11:56:09 -0400
Received: from Galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 84C23C05BD1E
        for <linux-kernel@vger.kernel.org>; Tue,  9 Jun 2020 08:56:08 -0700 (PDT)
Received: from localhost ([127.0.0.1] helo=vostro)
        by Galois.linutronix.de with esmtps (TLS1.2:RSA_AES_256_CBC_SHA1:256)
        (Exim 4.80)
        (envelope-from <john.ogness@linutronix.de>)
        id 1jigbe-00044i-C0; Tue, 09 Jun 2020 17:56:06 +0200
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
        kexec@lists.infradead.org, linux-kernel@vger.kernel.org,
        Paul McKenney <paulmck@kernel.org>
Subject: Re: Barrier before pushing desc_ring tail: was [PATCH v2 2/3] printk: add lockless buffer
References: <20200501094010.17694-1-john.ogness@linutronix.de>
        <20200501094010.17694-3-john.ogness@linutronix.de>
        <20200609113751.GD23752@linux-b0ei>
Date:   Tue, 09 Jun 2020 17:56:03 +0200
In-Reply-To: <20200609113751.GD23752@linux-b0ei> (Petr Mladek's message of
        "Tue, 9 Jun 2020 13:37:51 +0200")
Message-ID: <87d068utbg.fsf@vostro.fn.ogness.net>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2020-06-09, Petr Mladek <pmladek@suse.com> wrote:
>> --- /dev/null
>> +++ b/kernel/printk/printk_ringbuffer.c
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
>> +
>> +		/*
>> +		 * The ID has changed. Another writer must have pushed the
>> +		 * tail and recycled the descriptor already. Success is
>> +		 * returned because the caller is only interested in the
>> +		 * specified tail being pushed, which it was.
>> +		 */
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
>> +	/*
>> +	 * Check the next descriptor after @tail_id before pushing the tail
>> +	 * to it because the tail must always be in a committed or reusable
>> +	 * state. The implementation of prb_first_seq() relies on this.
>> +	 *
>> +	 * A successful read implies that the next descriptor is less than or
>> +	 * equal to @head_id so there is no risk of pushing the tail past the
>> +	 * head.
>> +	 */
>> +	d_state = desc_read(desc_ring, DESC_ID(tail_id + 1),
>> +			    &desc); /* LMM(desc_push_tail:A) */
>> +	if (d_state == desc_committed || d_state == desc_reusable) {
>> +		/*
>> +		 * Any CPU that loads the new tail ID, must see that the
>> +		 * descriptor at @tail_id is in the reusable state. See the
>> +		 * read memory barrier part of desc_reserve:D for details.
>> +		 */
>> +		atomic_long_cmpxchg_relaxed(&desc_ring->tail_id, tail_id,
>> +			DESC_ID(tail_id + 1)); /* LMM(desc_push_tail:B) */
>
> I was quite confused by the above comment. Does it mean that we need
> a barrier here? Or does it explain why the cmpxchg has its own
> LMM marker?

This LMM marker is referenced quite often, but since it is a relaxed
cmpxchg(), its significance is not immediately clear. I was hoping to
add some hints as to why it is significant. The comment that it is
referring to is:

	/*
	 * Guarantee the tail ID is read before validating the
	 * recycled descriptor state. A read memory barrier is
	 * sufficient for this. This pairs with data_push_tail:C.
	 *
	 * Memory barrier involvement:
	 *
	 * If desc_reserve:C reads from desc_push_tail:B, then
	 * desc_reserve:F reads from desc_make_reusable:A.
	 *
	 * Relies on:
	 *
	 * MB from desc_make_reusable:A to desc_push_tail:B
	 *    matching
	 * RMB from desc_reserve:C to desc_reserve:F
	 *
	 * Note: desc_make_reusable:A, desc_push_tail:B, and
	 *       data_push_tail:C can all be different CPUs. However,
	 *       the desc_push_tail:B CPU must have previously seen
	 *       data_push_tail:D and the data_push_tail:D CPU (which
	 *       performs the full memory barrier) must have
	 *       previously seen desc_make_reusable:A.
	 */

English translation:

In order to push the data tail, a CPU must first see that the associated
descriptor is in the reusable state. Since a full memory barrier is
performed after that sighting and before doing the data tail push, _any_
CPU that sees the pushed data tail will be able to see that the
associated descriptor is in the reusable state.

In order to push the descriptor tail, a CPU must first see that the
associated data tail has been pushed. Therefore, that CPU would also see
that the associated descriptor is in the reusable state.

> I think that we actually need a full barrier here to make sure that
> all CPUs see the changes made by data_push_tail() before we
> allow to rewrite the descriptor. The changes in data_push_tail() might
> be done on different CPUs.

There needs to be a reason why the ordering of data tail pushing and
descriptor tail pushing is important.

> It is similar like the full barrier in data_push_tail() before changing
> data_ring->tail_lpos.

How so? That memory barrier exists to make sure the reusable descriptor
state is stored before pushing the data tail. This is important for
readers (which start from the data tail) so they can notice if the
descriptor has since been invalidated (reusable state).

But where is it important that the data tail change is seen before the
descriptor tail change? How are the data tail and descriptor tail
significantly related to each other?

John Ogness
