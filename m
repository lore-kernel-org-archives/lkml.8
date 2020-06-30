Return-Path: <SRS0=mvbx=AL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 70321C433DF
	for <linux-kernel@archiver.kernel.org>; Tue, 30 Jun 2020 11:10:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 463D020771
	for <linux-kernel@archiver.kernel.org>; Tue, 30 Jun 2020 11:10:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="HlrgKG2D"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732902AbgF3LKY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 30 Jun 2020 07:10:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51138 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728534AbgF3LKX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Jun 2020 07:10:23 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 83CA6C061755
        for <linux-kernel@vger.kernel.org>; Tue, 30 Jun 2020 04:10:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=FvrrK/Zy4oNMNTQ5mQ1U736JPljSAmF+qXchxQYaclg=; b=HlrgKG2DC8paN+LTqvuSqXgqzM
        1Q3pMnqS9M+QZbcY0XO+hxZAcEqzdUAXVqKltiwH4WyW5DDGnmZluzl5Q8kkWj1nu9JrzWxeEyDMa
        SlETLdDc2+dz5jfJ058pX1SC7B6OfNIMrVJCJmOwVnk42RaLQy3eY6vwFU13+1AT0RRPPLgBHWadq
        6FT6UiqILV1Si8CSTRjAWn7lq6Es5xHSkNksHzg3iAiuRmWn7pDJCZ2dO1vZyCEKFu+OTNffz/WMO
        RvMdkor0Ty0VrrArNpD3Kx7VmOxQEAKOjkdLoLC+lrGdbKeh6NRNSVKpACtsehpqnoPJugQjv71XS
        JFMxnqIA==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by casper.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1jqE9X-0000UB-55; Tue, 30 Jun 2020 11:10:15 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 8BE2230015A;
        Tue, 30 Jun 2020 13:10:12 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 690DF2140512D; Tue, 30 Jun 2020 13:10:12 +0200 (CEST)
Date:   Tue, 30 Jun 2020 13:10:12 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Cc:     linux-kernel@vger.kernel.org, Andy Lutomirski <luto@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        x86@kernel.org, "H . Peter Anvin " <hpa@zytor.com>
Subject: Re: [PATCH 1/2] x86/entry: Use should_resched() in
 idtentry_exit_cond_resched()
Message-ID: <20200630111012.GM4800@hirez.programming.kicks-ass.net>
References: <20200630102209.1143072-1-bigeasy@linutronix.de>
 <20200630102209.1143072-2-bigeasy@linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200630102209.1143072-2-bigeasy@linutronix.de>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jun 30, 2020 at 12:22:08PM +0200, Sebastian Andrzej Siewior wrote:
> The TIF_NEED_RESCHED bit is inlined on x86 into the preemption counter.
> So instead checking the preemption counter against zero via
> preempt_count() and later checking the TIF_NEED_RESCHED bit via
> need_resched() we could use should_resched() which does both checks in
> one go.
> The functional difference is that we don't enter the if statement with
> preempt_count == 0 and TIF_NEED_RESCHED not set.
> 
> Use should_resched() instead need_resched() + preempt_count().
> 
> Signed-off-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
> ---
>  arch/x86/entry/common.c | 5 ++---
>  1 file changed, 2 insertions(+), 3 deletions(-)
> 
> diff --git a/arch/x86/entry/common.c b/arch/x86/entry/common.c
> index bd3f14175193c..212382f61b8e4 100644
> --- a/arch/x86/entry/common.c
> +++ b/arch/x86/entry/common.c
> @@ -612,13 +612,12 @@ bool noinstr idtentry_enter_cond_rcu(struct pt_regs *regs)
>  
>  static void idtentry_exit_cond_resched(struct pt_regs *regs, bool may_sched)
>  {
> -	if (may_sched && !preempt_count()) {
> +	if (may_sched && should_resched(0)) {
>  		/* Sanity check RCU and thread stack */
>  		rcu_irq_exit_check_preempt();
>  		if (IS_ENABLED(CONFIG_DEBUG_ENTRY))
>  			WARN_ON_ONCE(!on_thread_stack());

This was done on purpose, your change avoids hitting this WARN.

The thing is, if we could preempt (but not nessecarily have to) we want
to validate we're on the thread stack.

> -		if (need_resched())
> -			preempt_schedule_irq();
> +		preempt_schedule_irq();
>  	}
>  	/* Covers both tracing and lockdep */
>  	trace_hardirqs_on();
> -- 
> 2.27.0
> 
