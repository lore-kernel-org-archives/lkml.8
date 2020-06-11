Return-Path: <SRS0=NqQd=7Y=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A122BC433E0
	for <linux-kernel@archiver.kernel.org>; Thu, 11 Jun 2020 20:25:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7DB2E20720
	for <linux-kernel@archiver.kernel.org>; Thu, 11 Jun 2020 20:25:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726290AbgFKUZL (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 11 Jun 2020 16:25:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58456 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725869AbgFKUZK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 11 Jun 2020 16:25:10 -0400
Received: from Galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9B50FC08C5C2
        for <linux-kernel@vger.kernel.org>; Thu, 11 Jun 2020 13:25:10 -0700 (PDT)
Received: from localhost ([127.0.0.1] helo=vostro)
        by Galois.linutronix.de with esmtps (TLS1.2:RSA_AES_256_CBC_SHA1:256)
        (Exim 4.80)
        (envelope-from <john.ogness@linutronix.de>)
        id 1jjTl5-0005Yc-Ps; Thu, 11 Jun 2020 22:25:07 +0200
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
Subject: Re: redundant check in make_data_reusable(): was [PATCH v2 2/3] printk: add lockless buffer
References: <20200501094010.17694-1-john.ogness@linutronix.de>
        <20200501094010.17694-3-john.ogness@linutronix.de>
        <20200609093103.GB23752@linux-b0ei>
        <87lfkwuwg1.fsf@vostro.fn.ogness.net>
        <20200610093835.GB4311@linux-b0ei>
        <87o8prp6bi.fsf@vostro.fn.ogness.net>
        <20200611135509.GE6581@linux-b0ei>
Date:   Thu, 11 Jun 2020 22:25:06 +0200
In-Reply-To: <20200611135509.GE6581@linux-b0ei> (Petr Mladek's message of
        "Thu, 11 Jun 2020 15:55:09 +0200")
Message-ID: <87pna5mjtp.fsf@vostro.fn.ogness.net>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2020-06-11, Petr Mladek <pmladek@suse.com> wrote:
>>>>>> --- /dev/null
>>>>>> +++ b/kernel/printk/printk_ringbuffer.c
>>>>>> +/*
>>>>>> + * Given a data ring (text or dict), put the associated descriptor of each
>>>>>> + * data block from @lpos_begin until @lpos_end into the reusable state.
>>>>>> + *
>>>>>> + * If there is any problem making the associated descriptor reusable, either
>>>>>> + * the descriptor has not yet been committed or another writer task has
>>>>>> + * already pushed the tail lpos past the problematic data block. Regardless,
>>>>>> + * on error the caller can re-load the tail lpos to determine the situation.
>>>>>> + */
>>>>>> +static bool data_make_reusable(struct printk_ringbuffer *rb,
>>>>>> +			       struct prb_data_ring *data_ring,
>>>>>> +			       unsigned long lpos_begin,
>>>>>> +			       unsigned long lpos_end,
>>>>>> +			       unsigned long *lpos_out)
>>>>>> +{
>>>>>> +	struct prb_desc_ring *desc_ring = &rb->desc_ring;
>>>>>> +	struct prb_data_blk_lpos *blk_lpos;
>>>>>> +	struct prb_data_block *blk;
>>>>>> +	unsigned long tail_lpos;
>>>>>> +	enum desc_state d_state;
>>>>>> +	struct prb_desc desc;
>>>>>> +	unsigned long id;
>>>>>> +
>>>>>> +	/*
>>>>>> +	 * Using the provided @data_ring, point @blk_lpos to the correct
>>>>>> +	 * blk_lpos within the local copy of the descriptor.
>>>>>> +	 */
>>>>>> +	if (data_ring == &rb->text_data_ring)
>>>>>> +		blk_lpos = &desc.text_blk_lpos;
>>>>>> +	else
>>>>>> +		blk_lpos = &desc.dict_blk_lpos;
>>>>>> +
>>>>>> +	/* Loop until @lpos_begin has advanced to or beyond @lpos_end. */
>>>>>> +	while ((lpos_end - lpos_begin) - 1 < DATA_SIZE(data_ring)) {
>>>>>> +		blk = to_block(data_ring, lpos_begin);
>>>>>> +		id = READ_ONCE(blk->id); /* LMM(data_make_reusable:A) */
>>>>>> +
>>>>>> +		/*
>>>>>> +		 * Guarantee the block ID is loaded before checking the tail
>>>>>> +		 * lpos. The loaded block ID can only be considered valid if
>>>>>> +		 * the tail lpos has not overtaken @lpos_begin. This pairs
>>>>>> +		 * with data_alloc:A.
>>>>>> +		 *
>>>>>> +		 * Memory barrier involvement:
>>>>>> +		 *
>>>>>> +		 * If data_make_reusable:A reads from data_alloc:B, then
>>>>>> +		 * data_make_reusable:C reads from data_push_tail:D.
>>>>>> +		 *
>>>>>> +		 * Relies on:
>>>>>> +		 *
>>>>>> +		 * MB from data_push_tail:D to data_alloc:B
>>>>>> +		 *    matching
>>>>>> +		 * RMB from data_make_reusable:A to data_make_reusable:C
>>>>>> +		 *
>>>>>> +		 * Note: data_push_tail:D and data_alloc:B can be different
>>>>>> +		 *       CPUs. However, the data_alloc:B CPU (which performs
>>>>>> +		 *       the full memory barrier) must have previously seen
>>>>>> +		 *       data_push_tail:D.
>>>>>> +		 */
>>>>>> +		smp_rmb(); /* LMM(data_make_reusable:B) */
>>>>>> +
>>>>>> +		tail_lpos = atomic_long_read(&data_ring->tail_lpos
>>>>>> +					); /* LMM(data_make_reusable:C) */
>>>>>> +
>>>>>> +		/*
>>>>>> +		 * If @lpos_begin has fallen behind the tail lpos, the read
>>>>>> +		 * block ID cannot be trusted. Fast forward @lpos_begin to the
>>>>>> +		 * tail lpos and try again.
>>>>>> +		 */
>>>>>> +		if (lpos_begin - tail_lpos >= DATA_SIZE(data_ring)) {
>>>>>> +			lpos_begin = tail_lpos;
>>>>>> +			continue;
>>>>>> +		}
>>>>>
>>>>> I am sorry if we have had this discussion already in past.
>>>> 
>>>> We have [0]. (Search for "Ouch.")
>>>
>>> I see. Thanks a lot for the pointer.
>>>
>>>>> Well, it would just prove that it really needs a comment why this
>>>>> check is necessary.
>>>> 
>>>> The comment says why it is necessary. The previous read of the block ID
>>>> cannot be trusted if the the tail has been pushed beyond it.
>>>
>>> Not really. The comment describes what the check does. But it does not
>>> explain why it is needed. The reason might be described be something like:
>>>
>>> 		* Make sure that the id read from tail_lpos is really
>>> 		* pointing to this lpos. The block might have been
>>> 		* reused in the meantime. Make sure to do not make
>>> 		* the new owner reusable.
>> 
>> That is _not_ what this check is doing. I recommend looking closely at
>> the example you posted. This is not about whether or not a descriptor is
>> pointing to this lpos. In your example you showed that ID, state, and
>> lpos values could all look good, but it is for the _new_ record and we
>> should _not_ invalidate that one.
>
> OK, let's make sure that we are talking about the same example.
> I was talking about this one from
> https://lore.kernel.org/lkml/87ftecy343.fsf@linutronix.de/
>
> % [*] Another problem would be when data_make_reusable() see the new
> %     data already in the committed state. It would make fresh new
> %     data reusable.
> %
> %     I mean the following:
> %
> % CPU0				CPU1
> %
> % data_alloc()
> %   begin_lpos = dr->head_lpos
> %   data_push_tail()
> %     lpos = dr->tail_lpos
> %				prb_reserve()
> %				  # reserve the location of current
> %				  # dr->tail_lpos
> %				prb_commit()
> %
> %     id = blk->id
> %     # read id for the freshly written data on CPU1
> %     # and happily make them reusable
> %     data_make_reusable()
>
> Sigh, sigh, sigh, there is a hugely misleading comment in the example:
>
> %				  # reserve the location of current
> %				  # dr->tail_lpos
>
> It is true that it reserves part of this location. But it will use
> data_ring->head_lpos for the related desc->text_blk_lpos.begin !!!

Aaargh! You are right!

> If blk->id comes from the new descriptor written by CPU1 then
> blk_lpos->begin is based on the old data_ring->head_lpos.
> Then it is different from lpos_begin.
>
> Let's put it another way. The state of the descriptor defines validity
> of the data. Descriptor in committed state _must not_ point to invalid
> data block!!!
>
> If a descriptor in committed state point to lpos that was in invalid
> range before reading the descriptor then we have a huge hole in the
> design.
>
> This is why I believe that the check of the descriptor must be enough.

You are right. The smp_rmb (data_make_reusable:B) and its following tail
check are not needed. Since data_make_reusable:A can read garbage even
if we pass the tail check, we might as well always allow garbage and
rely on the descriptor/lpos checks to catch it. (Actually, that was the
design!)

However, the pairing smp_mb (data_alloc:A) is still needed, but it will
then pair with data_push_tail:A. If data_make_reusable() reads garbage
(maybe newly written garbage), it is important that a new data tail is
visible.

The comment for data_alloc:A would change to something like:

	/*
	 * Guarantee any updated tail lpos is stored before modifying
	 * the newly allocated data area. Another context may be in
	 * data_make_reusable() and is reading a block ID from this
	 * area. data_make_reusable() can handle reading a garbage block
	 * ID value, but then it must be able to load a new tail lpos.
	 * This pairs with data_push_tail:A.
	 */
	smp_mb(); /* LMM(data_alloc:A) */

John Ogness
