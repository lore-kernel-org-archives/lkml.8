Return-Path: <SRS0=pusq=BO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4B91EC433DF
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Aug 2020 14:35:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 302F82065C
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Aug 2020 14:35:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="OAw9HpV5"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726722AbgHDOfb (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 4 Aug 2020 10:35:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58150 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726233AbgHDOeg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Aug 2020 10:34:36 -0400
Received: from merlin.infradead.org (merlin.infradead.org [IPv6:2001:8b0:10b:1231::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6922EC061757
        for <linux-kernel@vger.kernel.org>; Tue,  4 Aug 2020 07:34:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=merlin.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=rT1zFsCcNBoed+cS0r1O3dipNS0y2QkGY3nkVRu0WAs=; b=OAw9HpV59MhEsoHgDkBvOcukmI
        NDt0vxY+zFXXjizuSMkBlgRFrZbzdx6DNiYZlUwURrgSCkbqtR/xcwVWoGwVlICuNtGbqVvRzatuS
        mAtRO2kzcqS9TjEGnY7A7rHX34GbkzrCcFhPxo5+xZeqELZi39jrIIXJwF6EzvY55i34nK2StIx5F
        bv5TKmWmC8WAmcHMuJOlKmwRUFJ3r9lFnVCW21VZ66NDJOCEBhC48LmbXb7ilPKhdqvzNDvy4CWL+
        sPpSfn5uPYa0owzt9ukedFbCrxOlGp8F+/wYwhG8xEU7CSnWo5K76TpdSwfA9KNoP6U8Puw9iJMgE
        Y8qfvHdg==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by merlin.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1k2y1F-0006yi-UK; Tue, 04 Aug 2020 14:34:22 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 4ADA5301E02;
        Tue,  4 Aug 2020 16:34:19 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 369FB2B7C12A4; Tue,  4 Aug 2020 16:34:19 +0200 (CEST)
Date:   Tue, 4 Aug 2020 16:34:19 +0200
From:   peterz@infradead.org
To:     Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Cc:     linux-kernel@vger.kernel.org, Will Deacon <will@kernel.org>,
        "Paul E . McKenney" <paulmck@kernel.org>,
        Nicholas Piggin <npiggin@gmail.com>,
        Andy Lutomirski <luto@amacapital.net>,
        Thomas Gleixner <tglx@linutronix.de>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Alan Stern <stern@rowland.harvard.edu>, linux-mm@kvack.org
Subject: Re: [RFC PATCH 1/2] sched: Fix exit_mm vs membarrier
Message-ID: <20200804143419.GL2657@hirez.programming.kicks-ass.net>
References: <20200728160010.3314-1-mathieu.desnoyers@efficios.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200728160010.3314-1-mathieu.desnoyers@efficios.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jul 28, 2020 at 12:00:09PM -0400, Mathieu Desnoyers wrote:
> exit_mm should issue memory barriers after user-space memory accesses,
> before clearing current->mm, to order user-space memory accesses
> performed prior to exit_mm before clearing tsk->mm, which has the
> effect of skipping the membarrier private expedited IPIs.
> 
> The membarrier system call can be issued concurrently with do_exit
> if we have thread groups created with CLONE_VM but not CLONE_THREAD.

I'm still wonder what the exact failure case is though; exit_mm() is on
the exit path (as the name very much implies) and the thread is about to
die. The context switch that follows guarantees a full barrier before we
run anything else again.

> The following comment in exit_mm() seems rather puzzling though:
> 
>         /* more a memory barrier than a real lock */
>         task_lock(current);
> 
> So considering that spinlocks are not full memory barriers nowadays,
> some digging into the origins of this comment led me to 2002, at the
> earliest commit tracked by Thomas Gleixner's bitkeeper era's history
> at https://git.kernel.org/pub/scm/linux/kernel/git/tglx/history.git/
> 
> At that point, this comment was followed by:
> 
> +               /* more a memory barrier than a real lock */
> +               task_lock(tsk);
> +               tsk->mm = NULL;
> +               task_unlock(tsk);
> 
> Which seems to indicate that grabbing the lock is really about acting as
> a memory barrier, but I wonder if it is meant to be a full barrier or
> just an acquire.
> 
> If a full memory barrier happens to be needed even without membarrier,
> perhaps this fix also corrects other issues ? It unclear from the
> comment what this memory barrier orders though. Is it the chain
> exit -> waitpid, or is it related to entering lazy TLB ?

I'm as puzzled by that comment as are you.

It does seem to be required for glorious stuff like get_task_mm()
though.

> Signed-off-by: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
> Cc: Peter Zijlstra (Intel) <peterz@infradead.org>
> Cc: Will Deacon <will@kernel.org>
> Cc: Paul E. McKenney <paulmck@kernel.org>
> Cc: Nicholas Piggin <npiggin@gmail.com>
> Cc: Andy Lutomirski <luto@amacapital.net>
> Cc: Thomas Gleixner <tglx@linutronix.de>
> Cc: Linus Torvalds <torvalds@linux-foundation.org>
> Cc: Alan Stern <stern@rowland.harvard.edu>
> Cc: linux-mm@kvack.org
> ---
>  kernel/exit.c | 8 ++++++++
>  1 file changed, 8 insertions(+)
> 
> diff --git a/kernel/exit.c b/kernel/exit.c
> index 727150f28103..ce272ec55cdc 100644
> --- a/kernel/exit.c
> +++ b/kernel/exit.c
> @@ -474,6 +474,14 @@ static void exit_mm(void)
>  	BUG_ON(mm != current->active_mm);
>  	/* more a memory barrier than a real lock */
>  	task_lock(current);
> +	/*
> +	 * When a thread stops operating on an address space, the loop
> +	 * in membarrier_{private,global}_expedited() may not observe
> +	 * that tsk->mm, and not issue an IPI. Membarrier requires a
> +	 * memory barrier after accessing user-space memory, before
> +	 * clearing tsk->mm.
> +	 */
> +	smp_mb();

So like stated above, I'm not sure how missing that IPI is going to be a
problem, we're dying...

>  	current->mm = NULL;
>  	mmap_read_unlock(mm);
>  	enter_lazy_tlb(mm, current);
> -- 
> 2.11.0
> 
