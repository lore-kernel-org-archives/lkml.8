Return-Path: <SRS0=NqQd=7Y=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1899AC433E0
	for <linux-kernel@archiver.kernel.org>; Thu, 11 Jun 2020 23:06:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E7D4520720
	for <linux-kernel@archiver.kernel.org>; Thu, 11 Jun 2020 23:06:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726381AbgFKXGi (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 11 Jun 2020 19:06:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55090 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726270AbgFKXGi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 11 Jun 2020 19:06:38 -0400
Received: from Galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 28E4EC08C5C1
        for <linux-kernel@vger.kernel.org>; Thu, 11 Jun 2020 16:06:38 -0700 (PDT)
Received: from localhost ([127.0.0.1] helo=vostro)
        by Galois.linutronix.de with esmtps (TLS1.2:RSA_AES_256_CBC_SHA1:256)
        (Exim 4.80)
        (envelope-from <john.ogness@linutronix.de>)
        id 1jjWHH-0008Ah-R0; Fri, 12 Jun 2020 01:06:32 +0200
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
        <87d068utbg.fsf@vostro.fn.ogness.net>
        <20200611120107.GD6581@linux-b0ei>
Date:   Fri, 12 Jun 2020 01:06:28 +0200
In-Reply-To: <20200611120107.GD6581@linux-b0ei> (Petr Mladek's message of
        "Thu, 11 Jun 2020 14:01:08 +0200")
Message-ID: <87bllpyzgr.fsf@vostro.fn.ogness.net>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2020-06-11, Petr Mladek <pmladek@suse.com> wrote:
> All this relies on the fact the the full barrier is called in
> data_push_tail() and data_push_tail() is called right above.
> But there are two situations where the barrier is not called.
> It is when:
>
>   1. desc.text_blk_lpos.next already is behind data_ring->tail_lpos.
>
>      This is safe.

Yes, and I have since expanded the comment above the data_push_tail()
while loop to mention that:

	/*
	 * Loop until the tail lpos is at or beyond @lpos. This condition
	 * may already be satisfied, resulting in no full memory barrier
	 * from data_push_tail:C being performed. However, since this CPU
	 * sees the new tail lpos, any descriptor states that transitioned to
	 * the reusable state must already be visible.
	 */

>   2. desc.text_blk_lpos == INVALID_LPOS.
>
>      It seems that this is not synchronized and other CPUs might see
>      the old state.

Great catch! This could trigger the WARN_ON at desc_reserve:F and lead
to prb_reserve() unnecessarily failing.

> The question is what to do with the empty data case. I see three
> possibilities:
>
>   1. Ignore the case with empty block because it (probably) does not
>      cause real problems.

It could cause dropped messages.

>   2. Call the full barrier in data_push_tail() even when the data
>      block is empty.

This is the common case, since most records will not have dictionary
data.

>   3. Call the full barrier also in desc_push_tail() as I suggested.
>
> My opinion:
>
> I prefer 3rd solution.

Agreed. For my next version I am folding all smp_mb() and smp_wmb()
calls into their neighboring cmpxchg_relaxed(). This would apply here as
well, changing desc_push_tail:B to a full cmpxchg().

We still need the full memory barrier at data_push_tail:C. Readers rely
on it to be able to verify if their copied data is still valid:

CPU0 (writer0)        CPU1 (writer1)       CPU2 (reader)
                                           desc_read->committed
desc_make_reusable
smp_mb
data_push_tail
                      read new data tail
                      data_push_head
                      smp_mb
                      write new data
                                           read garbage new data
                                           desc_read->reusable

John Ogness
