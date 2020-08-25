Return-Path: <SRS0=mfLo=CD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BF7CCC433DF
	for <linux-kernel@archiver.kernel.org>; Tue, 25 Aug 2020 13:24:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8EF2520639
	for <linux-kernel@archiver.kernel.org>; Tue, 25 Aug 2020 13:24:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="bvPqMmSC"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726104AbgHYNYY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 25 Aug 2020 09:24:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51316 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725792AbgHYNYS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Aug 2020 09:24:18 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4E37EC061574
        for <linux-kernel@vger.kernel.org>; Tue, 25 Aug 2020 06:24:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=D7yNlST9+Ie1ZaB8ShnxwmiJKTHeGMZrg5NndDmtOAU=; b=bvPqMmSCC/SID42Nl8M60SKemq
        syoLBSAqJBRL08m6kRhLWzxulcJ+neCYpLp34PjJ9ZR9e7wvUfENg277BHlyJZL66wlwZtcL4JwwB
        Pxh7BtM5SEoUnyk95cXXapR9c9AKruexeiZM76aBaULMytuiXsQL4xAr4DAcbA3eGV2uZEoLpyUNg
        cwQaW5PXeAY0on2O8DbloZnvzdIK+Xklr9ximb1uqr4lj4q+zHyfwoqwTIkm4m1iDBZ8rO4spoEn2
        tXHxjtsrfyp5wY8GJzAbEbKX4m62ILgG10TU0Rn5aAemSmeaa8X5G2h5GWsJtyZ8YI01wzFirteHx
        WYvYYPfA==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by casper.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1kAYvu-0006qt-4L; Tue, 25 Aug 2020 13:24:15 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id DB3A130015A;
        Tue, 25 Aug 2020 15:24:11 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id C167D2BF6F281; Tue, 25 Aug 2020 15:24:11 +0200 (CEST)
Date:   Tue, 25 Aug 2020 15:24:11 +0200
From:   peterz@infradead.org
To:     syzbot <syzbot+cb3b69ae80afd6535b0e@syzkaller.appspotmail.com>
Cc:     fweisbec@gmail.com, linux-kernel@vger.kernel.org, mingo@kernel.org,
        syzkaller-bugs@googlegroups.com, tglx@linutronix.de,
        Paul McKenney <paulmck@kernel.org>
Subject: Re: INFO: rcu detected stall in smp_call_function
Message-ID: <20200825132411.GR35926@hirez.programming.kicks-ass.net>
References: <000000000000903d5805ab908fc4@google.com>
 <20200729125811.GA70158@hirez.programming.kicks-ass.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200729125811.GA70158@hirez.programming.kicks-ass.net>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


+Cc Paul, who was weirdly forgotten last time

And one additional question below, which made me remember this thing.

On Wed, Jul 29, 2020 at 02:58:11PM +0200, peterz@infradead.org wrote:

> > rcu: INFO: rcu_preempt detected stalls on CPUs/tasks:
> > rcu: 	Tasks blocked on level-0 rcu_node (CPUs 0-1):
> > ------------[ cut here ]------------
> > IRQs not enabled as expected
> > WARNING: CPU: 0 PID: 32297 at kernel/sched/core.c:2701 try_invoke_on_locked_down_task+0x18b/0x320 kernel/sched/core.c:2701
> > Kernel panic - not syncing: panic_on_warn set ...
> > CPU: 0 PID: 32297 Comm: syz-executor.2 Not tainted 5.8.0-rc7-syzkaller #0
> > Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 01/01/2011
> > Call Trace:
> >  <IRQ>
> >  __dump_stack lib/dump_stack.c:77 [inline]
> >  dump_stack+0x1f0/0x31e lib/dump_stack.c:118
> >  panic+0x264/0x7a0 kernel/panic.c:231
> >  __warn+0x227/0x250 kernel/panic.c:600
> >  report_bug+0x1b1/0x2e0 lib/bug.c:198
> >  handle_bug+0x42/0x80 arch/x86/kernel/traps.c:235
> >  exc_invalid_op+0x16/0x40 arch/x86/kernel/traps.c:255
> >  asm_exc_invalid_op+0x12/0x20 arch/x86/include/asm/idtentry.h:540
> > RIP: 0010:try_invoke_on_locked_down_task+0x18b/0x320 kernel/sched/core.c:2701
> > Code: 48 89 df e8 f7 35 09 00 4c 89 f7 e8 df b5 cf 06 e9 b5 00 00 00 c6 05 34 82 38 08 01 48 c7 c7 8c d7 07 89 31 c0 e8 a5 a9 f5 ff <0f> 0b e9 15 ff ff ff 48 c7 c1 30 71 8d 89 80 e1 07 80 c1 03 38 c1
> > RSP: 0018:ffffc90000007c50 EFLAGS: 00010046
> > RAX: 1aaa08be6903c500 RBX: ffff888085d16ac8 RCX: ffff888085d16240
> > RDX: 0000000000010004 RSI: 0000000000010004 RDI: 0000000000000000
> > RBP: ffff888085d16b0c R08: ffffffff815dd389 R09: ffffed1015d041c3
> > R10: ffffed1015d041c3 R11: 0000000000000000 R12: 0000000000000000
> > R13: ffff8880a8bac140 R14: ffff8880a8bac4c0 R15: dffffc0000000000
> >  rcu_print_task_stall kernel/rcu/tree_stall.h:269 [inline]
> >  print_other_cpu_stall kernel/rcu/tree_stall.h:477 [inline]
> 
> Ha, that calls it with IRQs already disabled,
> 
> So I'm thinking we want something like so?
> 
> ---
> 
> diff --git a/kernel/sched/core.c b/kernel/sched/core.c
> index 2142c6767682..3182caf14844 100644
> --- a/kernel/sched/core.c
> +++ b/kernel/sched/core.c
> @@ -2694,12 +2694,11 @@ try_to_wake_up(struct task_struct *p, unsigned int state, int wake_flags)
>   */
>  bool try_invoke_on_locked_down_task(struct task_struct *p, bool (*func)(struct task_struct *t, void *arg), void *arg)
>  {
> -	bool ret = false;
>  	struct rq_flags rf;
> +	bool ret = false;
>  	struct rq *rq;
>  
> -	lockdep_assert_irqs_enabled();
> -	raw_spin_lock_irq(&p->pi_lock);
> +	raw_spin_lock_irqsave(&p->pi_lock, rf.flags);
>  	if (p->on_rq) {
>  		rq = __task_rq_lock(p, &rf);
>  		if (task_rq(p) == rq)
> @@ -2716,7 +2715,7 @@ bool try_invoke_on_locked_down_task(struct task_struct *p, bool (*func)(struct t
>  				ret = func(p, arg);
>  		}
>  	}
> -	raw_spin_unlock_irq(&p->pi_lock);
> +	raw_spin_unlock_irqrestore(&p->pi_lock, rf.flags);
>  	return ret;
>  }

Paul, I wanted to use this function, but found it has very weird
semantics.

Why do you need it to (remotely) call @func when p is current? The user
in rcu_print_task_stall() explicitly bails in this case, and the other
in rcu_wait_for_one_reader() will attempt an IPI.

Would it be possible to change this function to:

 - blocked task: call @func with p->pi_lock held
 - queued, !running task: call @func with rq->lock held
 - running task: fail.

?
