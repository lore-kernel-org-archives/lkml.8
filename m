Return-Path: <SRS0=mfLo=CD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EE76EC433DF
	for <linux-kernel@archiver.kernel.org>; Tue, 25 Aug 2020 15:48:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C34D62076C
	for <linux-kernel@archiver.kernel.org>; Tue, 25 Aug 2020 15:48:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1598370524;
	bh=b/OlB3yHHAuCyTewNVL4ofig7ljf7P9LSJBqCIuKNb4=;
	h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:List-ID:
	 From;
	b=cfwFLkvUfHxOTu4isg0IoMnWngk/nYFCni2+su9SrRsyV4DLZB82ZqGImWBXtaPsI
	 gk9k+9U/S+2oKKXoQ9SvE84EodZ7R12KQCHWvSK/ICUyH1gQ0mJVPAzyvcFVb2xyFM
	 HOaqB4JvFhIxvq6SYSlhvZ65Oam0sk0chYw1tiqw=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726740AbgHYPsn (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 25 Aug 2020 11:48:43 -0400
Received: from mail.kernel.org ([198.145.29.99]:60794 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726149AbgHYPsm (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Aug 2020 11:48:42 -0400
Received: from paulmck-ThinkPad-P72.home (unknown [50.45.173.55])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 77B6C2067C;
        Tue, 25 Aug 2020 15:48:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1598370521;
        bh=b/OlB3yHHAuCyTewNVL4ofig7ljf7P9LSJBqCIuKNb4=;
        h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
        b=QlyjpbVnsFiEyGuZ8xOOTyzEDlwpd0A8J76Lgu+dbUpd8hu9GB3UhfqjUZE7UTzah
         Iveq8Yc9tNIkRCwJdHy0Ull0N9xV5WuhM16of9Bwv7eirRTDx/h07uOu2l/eYB4zGg
         20Dq5tTY//nvA7et5jRr9g8q155DJ1E3PukPhOEQ=
Received: by paulmck-ThinkPad-P72.home (Postfix, from userid 1000)
        id 5581935226AE; Tue, 25 Aug 2020 08:48:41 -0700 (PDT)
Date:   Tue, 25 Aug 2020 08:48:41 -0700
From:   "Paul E. McKenney" <paulmck@kernel.org>
To:     peterz@infradead.org
Cc:     syzbot <syzbot+cb3b69ae80afd6535b0e@syzkaller.appspotmail.com>,
        fweisbec@gmail.com, linux-kernel@vger.kernel.org, mingo@kernel.org,
        syzkaller-bugs@googlegroups.com, tglx@linutronix.de
Subject: Re: INFO: rcu detected stall in smp_call_function
Message-ID: <20200825154841.GQ2855@paulmck-ThinkPad-P72>
Reply-To: paulmck@kernel.org
References: <000000000000903d5805ab908fc4@google.com>
 <20200729125811.GA70158@hirez.programming.kicks-ass.net>
 <20200825132411.GR35926@hirez.programming.kicks-ass.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200825132411.GR35926@hirez.programming.kicks-ass.net>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Aug 25, 2020 at 03:24:11PM +0200, peterz@infradead.org wrote:
> 
> +Cc Paul, who was weirdly forgotten last time
> 
> And one additional question below, which made me remember this thing.
> 
> On Wed, Jul 29, 2020 at 02:58:11PM +0200, peterz@infradead.org wrote:
> 
> > > rcu: INFO: rcu_preempt detected stalls on CPUs/tasks:
> > > rcu: 	Tasks blocked on level-0 rcu_node (CPUs 0-1):
> > > ------------[ cut here ]------------
> > > IRQs not enabled as expected
> > > WARNING: CPU: 0 PID: 32297 at kernel/sched/core.c:2701 try_invoke_on_locked_down_task+0x18b/0x320 kernel/sched/core.c:2701
> > > Kernel panic - not syncing: panic_on_warn set ...
> > > CPU: 0 PID: 32297 Comm: syz-executor.2 Not tainted 5.8.0-rc7-syzkaller #0
> > > Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 01/01/2011
> > > Call Trace:
> > >  <IRQ>
> > >  __dump_stack lib/dump_stack.c:77 [inline]
> > >  dump_stack+0x1f0/0x31e lib/dump_stack.c:118
> > >  panic+0x264/0x7a0 kernel/panic.c:231
> > >  __warn+0x227/0x250 kernel/panic.c:600
> > >  report_bug+0x1b1/0x2e0 lib/bug.c:198
> > >  handle_bug+0x42/0x80 arch/x86/kernel/traps.c:235
> > >  exc_invalid_op+0x16/0x40 arch/x86/kernel/traps.c:255
> > >  asm_exc_invalid_op+0x12/0x20 arch/x86/include/asm/idtentry.h:540
> > > RIP: 0010:try_invoke_on_locked_down_task+0x18b/0x320 kernel/sched/core.c:2701
> > > Code: 48 89 df e8 f7 35 09 00 4c 89 f7 e8 df b5 cf 06 e9 b5 00 00 00 c6 05 34 82 38 08 01 48 c7 c7 8c d7 07 89 31 c0 e8 a5 a9 f5 ff <0f> 0b e9 15 ff ff ff 48 c7 c1 30 71 8d 89 80 e1 07 80 c1 03 38 c1
> > > RSP: 0018:ffffc90000007c50 EFLAGS: 00010046
> > > RAX: 1aaa08be6903c500 RBX: ffff888085d16ac8 RCX: ffff888085d16240
> > > RDX: 0000000000010004 RSI: 0000000000010004 RDI: 0000000000000000
> > > RBP: ffff888085d16b0c R08: ffffffff815dd389 R09: ffffed1015d041c3
> > > R10: ffffed1015d041c3 R11: 0000000000000000 R12: 0000000000000000
> > > R13: ffff8880a8bac140 R14: ffff8880a8bac4c0 R15: dffffc0000000000
> > >  rcu_print_task_stall kernel/rcu/tree_stall.h:269 [inline]
> > >  print_other_cpu_stall kernel/rcu/tree_stall.h:477 [inline]
> > 
> > Ha, that calls it with IRQs already disabled,

I clearly failed to test stall warnings with lockdep enabled.  :-/

Good catch!

> > So I'm thinking we want something like so?
> > 
> > ---
> > 
> > diff --git a/kernel/sched/core.c b/kernel/sched/core.c
> > index 2142c6767682..3182caf14844 100644
> > --- a/kernel/sched/core.c
> > +++ b/kernel/sched/core.c
> > @@ -2694,12 +2694,11 @@ try_to_wake_up(struct task_struct *p, unsigned int state, int wake_flags)
> >   */
> >  bool try_invoke_on_locked_down_task(struct task_struct *p, bool (*func)(struct task_struct *t, void *arg), void *arg)
> >  {
> > -	bool ret = false;
> >  	struct rq_flags rf;
> > +	bool ret = false;
> >  	struct rq *rq;
> >  
> > -	lockdep_assert_irqs_enabled();
> > -	raw_spin_lock_irq(&p->pi_lock);
> > +	raw_spin_lock_irqsave(&p->pi_lock, rf.flags);
> >  	if (p->on_rq) {
> >  		rq = __task_rq_lock(p, &rf);
> >  		if (task_rq(p) == rq)
> > @@ -2716,7 +2715,7 @@ bool try_invoke_on_locked_down_task(struct task_struct *p, bool (*func)(struct t
> >  				ret = func(p, arg);
> >  		}
> >  	}
> > -	raw_spin_unlock_irq(&p->pi_lock);
> > +	raw_spin_unlock_irqrestore(&p->pi_lock, rf.flags);
> >  	return ret;
> >  }
> 
> Paul, I wanted to use this function, but found it has very weird
> semantics.
> 
> Why do you need it to (remotely) call @func when p is current? The user
> in rcu_print_task_stall() explicitly bails in this case, and the other
> in rcu_wait_for_one_reader() will attempt an IPI.

Good question.  Let me look at the invocations:

o	trc_wait_for_one_reader() bails on current before
	invoking try_invoke_on_locked_down_task():

	if (t == current) {
		t->trc_reader_checked = true;
		trc_del_holdout(t);
		WARN_ON_ONCE(t->trc_reader_nesting);
		return;
	}

o	rcu_print_task_stall() might well invoke on the current task,
	low though the probability of this happening might be.	(The task
	has to be preempted within an RCU read-side critical section
	and resume in time for the scheduling-clock irq that will report
	the RCU CPU stall to interrupt it.)

	And you are right, no point in an IPI in this case.

> Would it be possible to change this function to:
> 
>  - blocked task: call @func with p->pi_lock held
>  - queued, !running task: call @func with rq->lock held
>  - running task: fail.
> 
> ?

Why not a direct call in the current-task case, perhaps as follows,
including your change above?  This would allow the RCU CPU stall
case to work naturally and without the IPI.

Would that work for your use case?

							Thanx, Paul

------------------------------------------------------------------------

diff --git a/kernel/sched/core.c b/kernel/sched/core.c
index 8471a0f..3c9f044 100644
--- a/kernel/sched/core.c
+++ b/kernel/sched/core.c
@@ -2997,7 +2997,7 @@ try_to_wake_up(struct task_struct *p, unsigned int state, int wake_flags)
  * state while invoking @func(@arg).  This function can use ->on_rq and
  * task_curr() to work out what the state is, if required.  Given that
  * @func can be invoked with a runqueue lock held, it had better be quite
- * lightweight.
+ * lightweight.  Note that the current task is implicitly locked down.
  *
  * Returns:
  *	@false if the task slipped out from under the locks.
@@ -3006,12 +3006,13 @@ try_to_wake_up(struct task_struct *p, unsigned int state, int wake_flags)
  */
 bool try_invoke_on_locked_down_task(struct task_struct *p, bool (*func)(struct task_struct *t, void *arg), void *arg)
 {
-	bool ret = false;
 	struct rq_flags rf;
+	bool ret = false;
 	struct rq *rq;
 
-	lockdep_assert_irqs_enabled();
-	raw_spin_lock_irq(&p->pi_lock);
+	if (p == current)
+		return func(p, arg);
+	raw_spin_lock_irqsave(&p->pi_lock, rf.flags);
 	if (p->on_rq) {
 		rq = __task_rq_lock(p, &rf);
 		if (task_rq(p) == rq)
@@ -3028,7 +3029,7 @@ bool try_invoke_on_locked_down_task(struct task_struct *p, bool (*func)(struct t
 				ret = func(p, arg);
 		}
 	}
-	raw_spin_unlock_irq(&p->pi_lock);
+	raw_spin_unlock_irqrestore(&p->pi_lock, rf.flags);
 	return ret;
 }
 
