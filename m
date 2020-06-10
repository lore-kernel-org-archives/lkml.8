Return-Path: <SRS0=CVC0=7X=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AA12DC433DF
	for <linux-kernel@archiver.kernel.org>; Wed, 10 Jun 2020 13:55:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8E524206F4
	for <linux-kernel@archiver.kernel.org>; Wed, 10 Jun 2020 13:55:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729584AbgFJNzH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 10 Jun 2020 09:55:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58322 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726449AbgFJNzH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 Jun 2020 09:55:07 -0400
Received: from Galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CCCADC03E96B
        for <linux-kernel@vger.kernel.org>; Wed, 10 Jun 2020 06:55:06 -0700 (PDT)
Received: from localhost ([127.0.0.1] helo=vostro)
        by Galois.linutronix.de with esmtps (TLS1.2:RSA_AES_256_CBC_SHA1:256)
        (Exim 4.80)
        (envelope-from <john.ogness@linutronix.de>)
        id 1jj1C1-0005zZ-Ex; Wed, 10 Jun 2020 15:55:01 +0200
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
Subject: Re: blk->id read race: was: [PATCH v2 2/3] printk: add lockless buffer
References: <20200501094010.17694-1-john.ogness@linutronix.de>
        <20200501094010.17694-3-john.ogness@linutronix.de>
        <20200609071030.GA23752@linux-b0ei>
        <87tuzkuxtw.fsf@vostro.fn.ogness.net>
        <20200610084248.GA4311@linux-b0ei>
Date:   Wed, 10 Jun 2020 15:55:00 +0200
In-Reply-To: <20200610084248.GA4311@linux-b0ei> (Petr Mladek's message of
        "Wed, 10 Jun 2020 10:42:48 +0200")
Message-ID: <87k10fowjv.fsf@vostro.fn.ogness.net>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2020-06-10, Petr Mladek <pmladek@suse.com> wrote:
>>>> --- /dev/null
>>>> +++ b/kernel/printk/printk_ringbuffer.c
>>>> +/*
>>>> + * Given a data ring (text or dict), put the associated descriptor of each
>>>> + * data block from @lpos_begin until @lpos_end into the reusable state.
>>>> + *
>>>> + * If there is any problem making the associated descriptor reusable, either
>>>> + * the descriptor has not yet been committed or another writer task has
>>>> + * already pushed the tail lpos past the problematic data block. Regardless,
>>>> + * on error the caller can re-load the tail lpos to determine the situation.
>>>> + */
>>>> +static bool data_make_reusable(struct printk_ringbuffer *rb,
>>>> +			       struct prb_data_ring *data_ring,
>>>> +			       unsigned long lpos_begin,
>>>> +			       unsigned long lpos_end,
>>>> +			       unsigned long *lpos_out)
>>>> +{
>>>> +	struct prb_desc_ring *desc_ring = &rb->desc_ring;
>>>> +	struct prb_data_blk_lpos *blk_lpos;
>>>> +	struct prb_data_block *blk;
>>>> +	unsigned long tail_lpos;
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
>>>> +	/* Loop until @lpos_begin has advanced to or beyond @lpos_end. */
>>>> +	while ((lpos_end - lpos_begin) - 1 < DATA_SIZE(data_ring)) {
>>>> +		blk = to_block(data_ring, lpos_begin);
>>>> +		id = READ_ONCE(blk->id); /* LMM(data_make_reusable:A) */
>>>
>>> This would deserve some comment:
>
> I wonder if the comment might look like:
>
> /*
>  * No barrier is needed between reading tail_lpos and the related
>  * blk->id. Only CPU that modifies tail_lpos via cmpxchg is allowed
>  * to modify the related blk->id. CPUs that see the moved tail_lpos
>  * are looking at another block related to the new tail_lpos.
>  * It does not mater when the previous winner modifies the previous
>  * block.
>  */

Sorry, but this comment does not make sense for me. The tail is pushed
_before_ the block ID is modified. So any kind of barrier here (where we
read the tail, then the block ID, i.e. the same order) would be
inappropriate anyway.

Also, this comment only talks about when a new value is seen, but not
about when the old value is seen. IMO it is seeing the old value that is
worthy of a comment since that is the only case with a data race.

In preparation for my next version I have added the following comment:

        blk = to_block(data_ring, lpos_begin);

        /*
         * When going from lpos to block pointer, the wrap around
         * feature of the lpos value is lost. Since another CPU could
         * invalidate this data area at any time, the data tail must
         * be re-checked after the block ID has been read.
         */

        id = blk->id; /* LMM(data_make_reusable:A) */

I think this comment also helps to further clarify "why" the following
data tail check occurs.

John Ogness
