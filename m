Return-Path: <SRS0=jpuI=BA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 391BAC433E0
	for <linux-kernel@archiver.kernel.org>; Tue, 21 Jul 2020 21:06:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id F220620729
	for <linux-kernel@archiver.kernel.org>; Tue, 21 Jul 2020 21:06:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1595365587;
	bh=Of21Zx44eJ3+BiVmOHhdmi5eCrKkVi9mx6g9Ey1ukIo=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:List-ID:From;
	b=1uFRDmEj7RMqgnnbqj73HNqbO9jlCK0LfXWPOS6kURodJlLm01z0QIJnjlRJTmaOO
	 2PiKSUaSY57SVOjdVZf/POY1FIkxask1bwE5nJBDOlxbDz4FEzvGweZ5dioUzS/tWu
	 EU56Yy/5xoue7MzTAbh379L/7yrMIFunsz+a0HvU=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731037AbgGUVGZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 21 Jul 2020 17:06:25 -0400
Received: from mail.kernel.org ([198.145.29.99]:58336 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726658AbgGUVGZ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Jul 2020 17:06:25 -0400
Received: from localhost.localdomain (c-73-231-172-41.hsd1.ca.comcast.net [73.231.172.41])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 4DD0420720;
        Tue, 21 Jul 2020 21:06:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1595365584;
        bh=Of21Zx44eJ3+BiVmOHhdmi5eCrKkVi9mx6g9Ey1ukIo=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=lUqSuK/FU0haktmsriAtMyoaHI6DGRllsu5QTmn6QALtr9H2vcNZ4tkrSn02gEqJ7
         Ktbj+f7KKUFeMWNDzXmZrDhcRmo+nhb471sps1c0djME/6w1oZzEZDchMTBucHtgpv
         Od7cOzeDkrAhqEv7w1BchY3UscvufBdMjhTzH3Ic=
Date:   Tue, 21 Jul 2020 14:06:23 -0700
From:   Andrew Morton <akpm@linux-foundation.org>
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     linux-kernel@vger.kernel.org, luto@amacapital.net, axboe@kernel.dk,
        keescook@chromium.org, torvalds@linux-foundation.org,
        jannh@google.com, will@kernel.org, hch@lst.de, npiggin@gmail.com,
        mathieu.desnoyers@efficios.com
Subject: Re: [PATCH v3] mm: Fix kthread_use_mm() vs TLB invalidate
Message-Id: <20200721140623.4e8ecc6ef5d5ff42115d68fc@linux-foundation.org>
In-Reply-To: <20200721154106.GE10769@hirez.programming.kicks-ass.net>
References: <20200721154106.GE10769@hirez.programming.kicks-ass.net>
X-Mailer: Sylpheed 3.5.1 (GTK+ 2.24.31; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 21 Jul 2020 17:41:06 +0200 Peter Zijlstra <peterz@infradead.org> wrote:

> 
> For SMP systems using IPI based TLB invalidation, looking at
> current->active_mm is entirely reasonable. This then presents the
> following race condition:
> 
> 
>   CPU0			CPU1
> 
>   flush_tlb_mm(mm)	use_mm(mm)
>     <send-IPI>
> 			  tsk->active_mm = mm;
> 			  <IPI>
> 			    if (tsk->active_mm == mm)
> 			      // flush TLBs
> 			  </IPI>
> 			  switch_mm(old_mm,mm,tsk);
> 
> 
> Where it is possible the IPI flushed the TLBs for @old_mm, not @mm,
> because the IPI lands before we actually switched.
> 
> Avoid this by disabling IRQs across changing ->active_mm and
> switch_mm().
> 
> [ There are all sorts of reasons this might be harmless for various
> architecture specific reasons, but best not leave the door open at
> all. ]

Can we give the -stable maintainers (and others) more explanation of
why they might choose to merge this?

> ...
>
> --- a/kernel/kthread.c
> +++ b/kernel/kthread.c
> @@ -1241,13 +1241,15 @@ void kthread_use_mm(struct mm_struct *mm)
>  	WARN_ON_ONCE(tsk->mm);
>  
>  	task_lock(tsk);
> +	local_irq_disable();

A bare local_irq_disable() is one of those "what the heck is this
protecting" things.  It's the new lock_kernel().

So a little comment will help readers to understand why we did it. 
Something like this?

--- a/kernel/kthread.c~mm-fix-kthread_use_mm-vs-tlb-invalidate-fix
+++ a/kernel/kthread.c
@@ -1239,6 +1239,7 @@ void kthread_use_mm(struct mm_struct *mm
 	WARN_ON_ONCE(tsk->mm);
 
 	task_lock(tsk);
+	/* Hold off tlb flush IPIs while switching mm's */
 	local_irq_disable();
 	active_mm = tsk->active_mm;
 	if (active_mm != mm) {
_

>  	active_mm = tsk->active_mm;
>  	if (active_mm != mm) {
>  		mmgrab(mm);
>  		tsk->active_mm = mm;
>  	}
>  	tsk->mm = mm;
> -	switch_mm(active_mm, mm, tsk);
> +	switch_mm_irqs_off(active_mm, mm, tsk);
> +	local_irq_enable();
>  	task_unlock(tsk);
>  #ifdef finish_arch_post_lock_switch
>  	finish_arch_post_lock_switch();
>
> ...
>
