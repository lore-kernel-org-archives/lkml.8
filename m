Return-Path: <SRS0=pusq=BO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5AFA9C433DF
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Aug 2020 14:52:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3C17922B42
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Aug 2020 14:52:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="nfkXdB+U"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729159AbgHDOv6 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 4 Aug 2020 10:51:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60864 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728819AbgHDOvx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Aug 2020 10:51:53 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2533CC06174A
        for <linux-kernel@vger.kernel.org>; Tue,  4 Aug 2020 07:51:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=C2oXE0j06qehfdGgGodDM8y+EbLEHkil7gNNb2dpU3U=; b=nfkXdB+UvbFAZl6JTw7xFwTeRc
        6SlSX2ELlgiJ3R3AuybkdsI8hW/Au5neKCaScKweQ08YEpeZztUP60B31ZSGjOl862Tlckukyvh45
        kHPCmwZBThqYDpRe6FUQLadskiijsYmnA+J5QCtkScmdwvb/qGo4xwRlK/9E/gn+9Uclq7HGcvkxZ
        4pDqwnjQyF3dUQ5ik0tzPpD2UBTPZm7D4W8HO9176iW7uufk/TeCcQRMU1Z8/ag+zI/wNN2T62E0t
        ELRRvzR/fPjV1uwyK2w4gHlq6ZqN9zKRZXRxiGCWxCUFJgL4Cg49eKbIHkwz/IxQuFFapmx9N4Vjk
        bOkjg/Aw==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by casper.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1k2yI7-0006hB-1s; Tue, 04 Aug 2020 14:51:47 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id BE166300F7A;
        Tue,  4 Aug 2020 16:51:45 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id A7A452B7C12CF; Tue,  4 Aug 2020 16:51:45 +0200 (CEST)
Date:   Tue, 4 Aug 2020 16:51:45 +0200
From:   peterz@infradead.org
To:     Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Cc:     linux-kernel@vger.kernel.org, Will Deacon <will@kernel.org>,
        "Paul E . McKenney" <paulmck@kernel.org>,
        Nicholas Piggin <npiggin@gmail.com>,
        Andy Lutomirski <luto@amacapital.net>,
        Andrew Morton <akpm@linux-foundation.org>
Subject: Re: [RFC PATCH 2/2] sched: membarrier: cover kthread_use_mm
Message-ID: <20200804145145.GM2657@hirez.programming.kicks-ass.net>
References: <20200728160010.3314-1-mathieu.desnoyers@efficios.com>
 <20200728160010.3314-2-mathieu.desnoyers@efficios.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200728160010.3314-2-mathieu.desnoyers@efficios.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jul 28, 2020 at 12:00:10PM -0400, Mathieu Desnoyers wrote:
> Add comments and memory barrier to kthread_use_mm and kthread_unuse_mm
> to allow the effect of membarrier(2) to apply to kthreads accessing
> user-space memory as well.
> 
> Given that no prior kthread use this guarantee and that it only affects
> kthreads, adding this guarantee does not affect user-space ABI.
> 
> Refine the check in membarrier_global_expedited to exclude runqueues
> running the idle thread rather than all kthreads from the IPI cpumask.
> 
> This patch applies on top of this patch from Peter Zijlstra:
> "mm: fix kthread_use_mm() vs TLB invalidate" currently in Andrew
> Morton's tree.
> 
> Signed-off-by: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
> Cc: Peter Zijlstra (Intel) <peterz@infradead.org>
> Cc: Will Deacon <will@kernel.org>
> Cc: Paul E. McKenney <paulmck@kernel.org>
> Cc: Nicholas Piggin <npiggin@gmail.com>
> Cc: Andy Lutomirski <luto@amacapital.net>
> Cc: Andrew Morton <akpm@linux-foundation.org>
> ---
>  kernel/kthread.c          | 19 +++++++++++++++++++
>  kernel/sched/membarrier.c |  8 ++------
>  2 files changed, 21 insertions(+), 6 deletions(-)
> 
> diff --git a/kernel/kthread.c b/kernel/kthread.c
> index 48925b17920e..ef2435517f14 100644
> --- a/kernel/kthread.c
> +++ b/kernel/kthread.c
> @@ -1258,8 +1258,19 @@ void kthread_use_mm(struct mm_struct *mm)
>  	finish_arch_post_lock_switch();
>  #endif
>  
> +	/*
> +	 * When a kthread starts operating on an address space, the loop
> +	 * in membarrier_{private,global}_expedited() may not observe
> +	 * that tsk->mm, and not issue an IPI. Membarrier requires a
> +	 * memory barrier after storing to tsk->mm, before accessing
> +	 * user-space memory. A full memory barrier for membarrier
> +	 * {PRIVATE,GLOBAL}_EXPEDITED is implicitly provided by
> +	 * mmdrop().
> +	 */
>  	if (active_mm != mm)
>  		mmdrop(active_mm);
> +	else
> +		smp_mb();
>  
>  	to_kthread(tsk)->oldfs = get_fs();
>  	set_fs(USER_DS);
> @@ -1280,6 +1291,14 @@ void kthread_unuse_mm(struct mm_struct *mm)
>  	set_fs(to_kthread(tsk)->oldfs);
>  
>  	task_lock(tsk);
> +	/*
> +	 * When a kthread stops operating on an address space, the loop
> +	 * in membarrier_{private,global}_expedited() may not observe
> +	 * that tsk->mm, and not issue an IPI. Membarrier requires a
> +	 * memory barrier after accessing user-space memory, before
> +	 * clearing tsk->mm.
> +	 */
> +	smp_mb();
>  	sync_mm_rss(mm);
>  	local_irq_disable();

Would it make sense to put the smp_mb() inside the IRQ disable region?

>  	tsk->mm = NULL;
> diff --git a/kernel/sched/membarrier.c b/kernel/sched/membarrier.c
> index 168479a7d61b..8a294483074d 100644
> --- a/kernel/sched/membarrier.c
> +++ b/kernel/sched/membarrier.c
> @@ -100,13 +100,9 @@ static int membarrier_global_expedited(void)
>  		    MEMBARRIER_STATE_GLOBAL_EXPEDITED))
>  			continue;
>  
> -		/*
> -		 * Skip the CPU if it runs a kernel thread. The scheduler
> -		 * leaves the prior task mm in place as an optimization when
> -		 * scheduling a kthread.
> -		 */
> +		/* Skip the CPU if it runs the idle thread. */
>  		p = rcu_dereference(cpu_rq(cpu)->curr);
> -		if (p->flags & PF_KTHREAD)
> +		if (is_idle_task(p))
>  			continue;

Do we want to add a:

	WARN_ON_ONCE(current->mm);

in play_idle_precise() ?

Because, if I read this right, we rely on the idle thread not having an
mm.
