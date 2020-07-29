Return-Path: <SRS0=g5yc=BI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4D566C433E0
	for <linux-kernel@archiver.kernel.org>; Wed, 29 Jul 2020 12:58:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2551E2083B
	for <linux-kernel@archiver.kernel.org>; Wed, 29 Jul 2020 12:58:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="CH7YDNUz"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726560AbgG2M6S (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 29 Jul 2020 08:58:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45576 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726353AbgG2M6S (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Jul 2020 08:58:18 -0400
Received: from merlin.infradead.org (merlin.infradead.org [IPv6:2001:8b0:10b:1231::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 32DFDC061794
        for <linux-kernel@vger.kernel.org>; Wed, 29 Jul 2020 05:58:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=merlin.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=DRXfqwwDeUly+kRvqYsw11Rt3/TZjw0rr4u8zuHz294=; b=CH7YDNUz7YReX1UolTC/KTlSas
        YhuVNsZGUCL9njHVW4aXOIbVWHKDXtXABE8sKCPKwTfgOfi6v+cND5hyg8Yb5fi3AuBKCOTR9HakL
        CB/jo39N6qW9sCbL/c3/YC9j10VlqHWvoH5xDO5O1cMzeIcZqHP6OkOjqscVxokruK11ghLefWfUk
        o/sziKBz/I9Vvf4I+QreUDHg2bgVkMBnZsX8TUF3W56MeGx+npa19SkuRm/SY4BrwNhV1ctOEfQPf
        Ur4YCReilGWjzIpjZF+ZyxZ7rT3hlOJhv7yElR7ogtxqDcjOtWMmLSggxf3FZ11/eehQiaXZel/Fr
        D3nKwHAw==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by merlin.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1k0leu-0001sg-Mf; Wed, 29 Jul 2020 12:58:13 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 7933A300238;
        Wed, 29 Jul 2020 14:58:11 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 5D717201CB85F; Wed, 29 Jul 2020 14:58:11 +0200 (CEST)
Date:   Wed, 29 Jul 2020 14:58:11 +0200
From:   peterz@infradead.org
To:     syzbot <syzbot+cb3b69ae80afd6535b0e@syzkaller.appspotmail.com>
Cc:     fweisbec@gmail.com, linux-kernel@vger.kernel.org, mingo@kernel.org,
        syzkaller-bugs@googlegroups.com, tglx@linutronix.de
Subject: Re: INFO: rcu detected stall in smp_call_function
Message-ID: <20200729125811.GA70158@hirez.programming.kicks-ass.net>
References: <000000000000903d5805ab908fc4@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <000000000000903d5805ab908fc4@google.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jul 29, 2020 at 01:44:15AM -0700, syzbot wrote:
> Hello,
> 
> syzbot found the following issue on:
> 
> HEAD commit:    6ba1b005 Merge tag 'asm-generic-fixes-5.8' of git://git.ke..

Bit useless, having git://git.ke... there, that doesn't really narrow
things down.

> git tree:       upstream
> console output: https://syzkaller.appspot.com/x/log.txt?x=14da5522900000
> kernel config:  https://syzkaller.appspot.com/x/.config?x=812bbfcb6ae2cd60
> dashboard link: https://syzkaller.appspot.com/bug?extid=cb3b69ae80afd6535b0e
> compiler:       clang version 10.0.0 (https://github.com/llvm/llvm-project/ c2443155a0fb245c8f17f2c1c72b6ea391e86e81)
> 
> Unfortunately, I don't have any reproducer for this issue yet.
> 
> IMPORTANT: if you fix the issue, please add the following tag to the commit:
> Reported-by: syzbot+cb3b69ae80afd6535b0e@syzkaller.appspotmail.com
> 
> rcu: INFO: rcu_preempt detected stalls on CPUs/tasks:
> rcu: 	Tasks blocked on level-0 rcu_node (CPUs 0-1):
> ------------[ cut here ]------------
> IRQs not enabled as expected
> WARNING: CPU: 0 PID: 32297 at kernel/sched/core.c:2701 try_invoke_on_locked_down_task+0x18b/0x320 kernel/sched/core.c:2701
> Kernel panic - not syncing: panic_on_warn set ...
> CPU: 0 PID: 32297 Comm: syz-executor.2 Not tainted 5.8.0-rc7-syzkaller #0
> Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 01/01/2011
> Call Trace:
>  <IRQ>
>  __dump_stack lib/dump_stack.c:77 [inline]
>  dump_stack+0x1f0/0x31e lib/dump_stack.c:118
>  panic+0x264/0x7a0 kernel/panic.c:231
>  __warn+0x227/0x250 kernel/panic.c:600
>  report_bug+0x1b1/0x2e0 lib/bug.c:198
>  handle_bug+0x42/0x80 arch/x86/kernel/traps.c:235
>  exc_invalid_op+0x16/0x40 arch/x86/kernel/traps.c:255
>  asm_exc_invalid_op+0x12/0x20 arch/x86/include/asm/idtentry.h:540
> RIP: 0010:try_invoke_on_locked_down_task+0x18b/0x320 kernel/sched/core.c:2701
> Code: 48 89 df e8 f7 35 09 00 4c 89 f7 e8 df b5 cf 06 e9 b5 00 00 00 c6 05 34 82 38 08 01 48 c7 c7 8c d7 07 89 31 c0 e8 a5 a9 f5 ff <0f> 0b e9 15 ff ff ff 48 c7 c1 30 71 8d 89 80 e1 07 80 c1 03 38 c1
> RSP: 0018:ffffc90000007c50 EFLAGS: 00010046
> RAX: 1aaa08be6903c500 RBX: ffff888085d16ac8 RCX: ffff888085d16240
> RDX: 0000000000010004 RSI: 0000000000010004 RDI: 0000000000000000
> RBP: ffff888085d16b0c R08: ffffffff815dd389 R09: ffffed1015d041c3
> R10: ffffed1015d041c3 R11: 0000000000000000 R12: 0000000000000000
> R13: ffff8880a8bac140 R14: ffff8880a8bac4c0 R15: dffffc0000000000
>  rcu_print_task_stall kernel/rcu/tree_stall.h:269 [inline]
>  print_other_cpu_stall kernel/rcu/tree_stall.h:477 [inline]

Ha, that calls it with IRQs already disabled,

So I'm thinking we want something like so?

---

diff --git a/kernel/sched/core.c b/kernel/sched/core.c
index 2142c6767682..3182caf14844 100644
--- a/kernel/sched/core.c
+++ b/kernel/sched/core.c
@@ -2694,12 +2694,11 @@ try_to_wake_up(struct task_struct *p, unsigned int state, int wake_flags)
  */
 bool try_invoke_on_locked_down_task(struct task_struct *p, bool (*func)(struct task_struct *t, void *arg), void *arg)
 {
-	bool ret = false;
 	struct rq_flags rf;
+	bool ret = false;
 	struct rq *rq;
 
-	lockdep_assert_irqs_enabled();
-	raw_spin_lock_irq(&p->pi_lock);
+	raw_spin_lock_irqsave(&p->pi_lock, rf.flags);
 	if (p->on_rq) {
 		rq = __task_rq_lock(p, &rf);
 		if (task_rq(p) == rq)
@@ -2716,7 +2715,7 @@ bool try_invoke_on_locked_down_task(struct task_struct *p, bool (*func)(struct t
 				ret = func(p, arg);
 		}
 	}
-	raw_spin_unlock_irq(&p->pi_lock);
+	raw_spin_unlock_irqrestore(&p->pi_lock, rf.flags);
 	return ret;
 }
 
