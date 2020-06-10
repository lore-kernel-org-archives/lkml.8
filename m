Return-Path: <SRS0=CVC0=7X=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 36D5DC433DF
	for <linux-kernel@archiver.kernel.org>; Wed, 10 Jun 2020 07:53:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 18B96206C3
	for <linux-kernel@archiver.kernel.org>; Wed, 10 Jun 2020 07:53:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726624AbgFJHxW (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 10 Jun 2020 03:53:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58648 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726081AbgFJHxV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 Jun 2020 03:53:21 -0400
Received: from Galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5FB81C03E96B
        for <linux-kernel@vger.kernel.org>; Wed, 10 Jun 2020 00:53:21 -0700 (PDT)
Received: from localhost ([127.0.0.1] helo=vostro)
        by Galois.linutronix.de with esmtps (TLS1.2:RSA_AES_256_CBC_SHA1:256)
        (Exim 4.80)
        (envelope-from <john.ogness@linutronix.de>)
        id 1jivXx-0007m8-Hv; Wed, 10 Jun 2020 09:53:17 +0200
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
Subject: Re: data_ring head_lpos and tail_lpos synchronization: was [PATCH v2 2/3] printk: add lockless buffer
References: <20200501094010.17694-1-john.ogness@linutronix.de>
        <20200501094010.17694-3-john.ogness@linutronix.de>
        <20200609143811.GF23752@linux-b0ei>
Date:   Wed, 10 Jun 2020 09:53:16 +0200
In-Reply-To: <20200609143811.GF23752@linux-b0ei> (Petr Mladek's message of
        "Tue, 9 Jun 2020 16:38:11 +0200")
Message-ID: <87wo4fpdar.fsf@vostro.fn.ogness.net>
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
>> + * Advance the data ring tail to at least @lpos. This function puts
>> + * descriptors into the reusable state if the tail is pushed beyond
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
>
> Hmm, I wonder whether data_ring->tail_lpos and data_ring->head_lpos
> are synchronized enough between each other.
>
> I feel that there should be read barrier here. But it seems that more
> barriers are missing. For example, let's have:
>
>
> CPU0				CPU1
>
> data_alloc()
>   begin_lpos = atomic_read(data_ring->head_lpos);
>
> 				data_alloc()
> 				  data_push_tail()
> 				    cmpxchg(data_ring->tail_lpos);
> 				    // A: no barrier
> 				  cmpxchg(data_ring->head_lpos);
>
>   data_push_tail()
>     // B: no barrier
>     tail_lpos = atomic_read(data_ring->tail_lpos);
>
> Problem 1:
>
>    CPU0 might see random ordering of data_ring->tail_lpos and
>    head_lpos values modified by CPU1. There are missing both
>    write and read barriers.

You need to explain why this is a problem. CPU0 saw some head and some
tail. Both values are at least the current values (i.e. there is no
danger that it sees a tail that is further than the tail really is).

CPU0 then uses the head/tail values to determine how far to advance the
tail and how far to advance the head. Both of these advances use
cmpxchg_relaxed(). So there is no danger of random head/tail
modifications. Upon cmpxchg_relaxed() failure, the new current values
are loaded and it retries based on the new values.

The only issue is if data_push_tail()/data_make_reusable() are able to
recognize that a data area is already recycled. And both functions have
memory barriers in place for that.

> Problem 2:
>
>    There might be still a chance because CPU0 does:
>
>      if (!data_make_reusable())
>        smp_rmb()
>        tail_lpos = atomic_read(data_ring->tail_lpos);
>
>    But CPU0 might still see old data_ring->tail because CPU1 did not
>    do write barrier.

I claim that it does not matter. The smp_rmb() here pairs with the full
memory barrier LMM(desc_reserve:D). The reasoning:

	 * Guarantee any data ring tail changes are stored before
	 * recycling the descriptor. Data ring tail changes can happen
	 * via desc_push_tail()->data_push_tail(). A full memory
	 * barrier is needed since another task may have pushed the
	 * data ring tails. This pairs with data_push_tail:A.

So if data_make_reusable() failed due to a descriptor already being
recycled, we know CPU0 will be able to read an updated tail value (and
try again with the new value).

John Ogness
