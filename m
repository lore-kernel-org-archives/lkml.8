Return-Path: <SRS0=F/Af=7W=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 937BCC433DF
	for <linux-kernel@archiver.kernel.org>; Tue,  9 Jun 2020 14:18:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 75D47206D5
	for <linux-kernel@archiver.kernel.org>; Tue,  9 Jun 2020 14:18:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730143AbgFIOSt (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 9 Jun 2020 10:18:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36924 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726967AbgFIOSs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 9 Jun 2020 10:18:48 -0400
Received: from Galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 051FDC05BD1E
        for <linux-kernel@vger.kernel.org>; Tue,  9 Jun 2020 07:18:47 -0700 (PDT)
Received: from localhost ([127.0.0.1] helo=vostro)
        by Galois.linutronix.de with esmtps (TLS1.2:RSA_AES_256_CBC_SHA1:256)
        (Exim 4.80)
        (envelope-from <john.ogness@linutronix.de>)
        id 1jif5N-0002Lk-Jo; Tue, 09 Jun 2020 16:18:41 +0200
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
Date:   Tue, 09 Jun 2020 16:18:35 +0200
In-Reply-To: <20200609071030.GA23752@linux-b0ei> (Petr Mladek's message of
        "Tue, 9 Jun 2020 09:10:30 +0200")
Message-ID: <87tuzkuxtw.fsf@vostro.fn.ogness.net>
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
>> + * Given a data ring (text or dict), put the associated descriptor of each
>> + * data block from @lpos_begin until @lpos_end into the reusable state.
>> + *
>> + * If there is any problem making the associated descriptor reusable, either
>> + * the descriptor has not yet been committed or another writer task has
>> + * already pushed the tail lpos past the problematic data block. Regardless,
>> + * on error the caller can re-load the tail lpos to determine the situation.
>> + */
>> +static bool data_make_reusable(struct printk_ringbuffer *rb,
>> +			       struct prb_data_ring *data_ring,
>> +			       unsigned long lpos_begin,
>> +			       unsigned long lpos_end,
>> +			       unsigned long *lpos_out)
>> +{
>> +	struct prb_desc_ring *desc_ring = &rb->desc_ring;
>> +	struct prb_data_blk_lpos *blk_lpos;
>> +	struct prb_data_block *blk;
>> +	unsigned long tail_lpos;
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
>> +	/* Loop until @lpos_begin has advanced to or beyond @lpos_end. */
>> +	while ((lpos_end - lpos_begin) - 1 < DATA_SIZE(data_ring)) {
>> +		blk = to_block(data_ring, lpos_begin);
>> +		id = READ_ONCE(blk->id); /* LMM(data_make_reusable:A) */
>
> This would deserve some comment:
>
> 1. Compiler could not optimize out the read because there is a data
>    dependency on lpos_begin.
>
> 2. Compiler could not postpone the read because it is followed by
>    smp_rmb().
>
> So, is READ_ONCE() realy needed?

I agree that it is not needed. Both the READ_ONCE() and its countering
WRITE_ONCE() (data_alloc:B) only document the lockless shared access. I
will remove both for the next version.

Do we still need a comment? Is it not obvious that there is a data
dependency on @lpos_begin?

        blk = to_block(data_ring, lpos_begin);
        id = blk->id;

> Well, blk->id clearly can be modified in parallel so we need to be
> careful. There is smp_rmb() right below. Do we needed smp_rmb() also
> before?
>
> What about the following scenario?:
>
>
> CPU0						CPU1
>
> 						data_alloc()
> 						  data_push_tail()
>
> 						blk = to_block(data_ring, begin_lpos)
> 						WRITE_ONCE(blk->id, id); /* LMM(data_alloc:B) */
>
> desc_push_tail()
>   data_push_tail()
>
>     tail_lpos = data_ring->tail_lpos;
>     // see data_ring->tail_lpos already updated by CPU1
>
>     data_make_reusable()
>
>       // lpos_begin = tail_lpos via parameter
>       blk = to_block(data_ring, lpos_begin);
>       id = blk->id
>
> Now: CPU0 might see outdated blk->id before CPU1 wrote new value
>      because there is no read barrier betwen reading tail_lpos
>      and blk->id here.

In your example, CPU1 is pushing the tail and then setting the block ID
for the _newly_ allocated block, that is located is _before_ the new
tail. If CPU0 sees the new tail already, it is still reading a valid
block ID, which is _not_ from the block that CPU1 is in the process of
writing.

John Ogness
