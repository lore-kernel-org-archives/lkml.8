Return-Path: <SRS0=kGB5=CE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 697C5C433DF
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Aug 2020 14:07:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4359F2078D
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Aug 2020 14:07:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1598450867;
	bh=CW3ET0nSECTYGqqMM8aQQ5O+97kyrZkhTGoMjySb5I4=;
	h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:List-ID:
	 From;
	b=A5FORO3ahGZayX5pxDV1K4AkM8If8C3InjfGGHbuDHenPx5L7H6POIf5qb8Ak7O4l
	 6nUx6LerASxgCZGPZrbpaxr63JmyPIncW0mtwbLtNMKPjtlOFZ6GPprZVGBfVBqyaF
	 UugkY0Z4ErALdncqDHWGSjtp6bzQwWDpG2ctU/Fc=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730463AbgHZOHp (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 26 Aug 2020 10:07:45 -0400
Received: from mail.kernel.org ([198.145.29.99]:40928 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726851AbgHZOHh (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Aug 2020 10:07:37 -0400
Received: from paulmck-ThinkPad-P72.home (unknown [50.45.173.55])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 488702078D;
        Wed, 26 Aug 2020 14:07:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1598450853;
        bh=CW3ET0nSECTYGqqMM8aQQ5O+97kyrZkhTGoMjySb5I4=;
        h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
        b=aX6ETimyCOT0RH3P+ja5amiQaxLFhthtdXD6sHGTUGS6GoQVwfT98dsBNVjN5F6a2
         p1o7Ut5wzo2CQgwsAc/V92dI1TC3zADL+0gNTsSwtzzM9Eqx5FeVKWfHx7OTm2c+lB
         V3aGvQ7Fu3amMi1pWBsHN0j/+EX6n2XTy39KLn1Y=
Received: by paulmck-ThinkPad-P72.home (Postfix, from userid 1000)
        id 297123522612; Wed, 26 Aug 2020 07:07:33 -0700 (PDT)
Date:   Wed, 26 Aug 2020 07:07:33 -0700
From:   "Paul E. McKenney" <paulmck@kernel.org>
To:     peterz@infradead.org
Cc:     syzbot <syzbot+cb3b69ae80afd6535b0e@syzkaller.appspotmail.com>,
        fweisbec@gmail.com, linux-kernel@vger.kernel.org, mingo@kernel.org,
        syzkaller-bugs@googlegroups.com, tglx@linutronix.de
Subject: Re: INFO: rcu detected stall in smp_call_function
Message-ID: <20200826140733.GM2855@paulmck-ThinkPad-P72>
Reply-To: paulmck@kernel.org
References: <000000000000903d5805ab908fc4@google.com>
 <20200729125811.GA70158@hirez.programming.kicks-ass.net>
 <20200825132411.GR35926@hirez.programming.kicks-ass.net>
 <20200825154841.GQ2855@paulmck-ThinkPad-P72>
 <20200826095144.GD1362448@hirez.programming.kicks-ass.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200826095144.GD1362448@hirez.programming.kicks-ass.net>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Aug 26, 2020 at 11:51:44AM +0200, peterz@infradead.org wrote:
> On Tue, Aug 25, 2020 at 08:48:41AM -0700, Paul E. McKenney wrote:
> 
> > > Paul, I wanted to use this function, but found it has very weird
> > > semantics.
> > > 
> > > Why do you need it to (remotely) call @func when p is current? The user
> > > in rcu_print_task_stall() explicitly bails in this case, and the other
> > > in rcu_wait_for_one_reader() will attempt an IPI.
> > 
> > Good question.  Let me look at the invocations:
> > 
> > o	trc_wait_for_one_reader() bails on current before
> > 	invoking try_invoke_on_locked_down_task():
> > 
> > 	if (t == current) {
> > 		t->trc_reader_checked = true;
> > 		trc_del_holdout(t);
> > 		WARN_ON_ONCE(t->trc_reader_nesting);
> > 		return;
> > 	}
> > 
> > o	rcu_print_task_stall() might well invoke on the current task,
> > 	low though the probability of this happening might be.	(The task
> > 	has to be preempted within an RCU read-side critical section
> > 	and resume in time for the scheduling-clock irq that will report
> > 	the RCU CPU stall to interrupt it.)
> > 
> > 	And you are right, no point in an IPI in this case.
> > 
> > > Would it be possible to change this function to:
> > > 
> > >  - blocked task: call @func with p->pi_lock held
> > >  - queued, !running task: call @func with rq->lock held
> > >  - running task: fail.
> > > 
> > > ?
> > 
> > Why not a direct call in the current-task case, perhaps as follows,
> > including your change above?  This would allow the RCU CPU stall
> > case to work naturally and without the IPI.
> > 
> > Would that work for your use case?
> 
> It would in fact, but at this point I'd almost be inclined to stick the
> IPI in as well. But small steps I suppose. So yes.

If interrupts are disabled, won't a self-IPI deadlock?

But good point that the current-task case could be the only case invoking
the function with interrupts enabled, which now that you mention it does
sound like an accident waiting to happen.  So how about the following
instead?

							Thanx, Paul

------------------------------------------------------------------------

diff --git a/kernel/sched/core.c b/kernel/sched/core.c
index 8471a0f..f8ed04c 100644
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
@@ -3006,12 +3006,17 @@ try_to_wake_up(struct task_struct *p, unsigned int state, int wake_flags)
  */
 bool try_invoke_on_locked_down_task(struct task_struct *p, bool (*func)(struct task_struct *t, void *arg), void *arg)
 {
-	bool ret = false;
 	struct rq_flags rf;
+	bool ret = false;
 	struct rq *rq;
 
-	lockdep_assert_irqs_enabled();
-	raw_spin_lock_irq(&p->pi_lock);
+	if (p == current) {
+		local_irq_save(rf.flags);
+		ret = func(p, arg);
+		local_irq_restore(rf.flags);
+		return ret;
+	}
+	raw_spin_lock_irqsave(&p->pi_lock, rf.flags);
 	if (p->on_rq) {
 		rq = __task_rq_lock(p, &rf);
 		if (task_rq(p) == rq)
@@ -3028,7 +3033,7 @@ bool try_invoke_on_locked_down_task(struct task_struct *p, bool (*func)(struct t
 				ret = func(p, arg);
 		}
 	}
-	raw_spin_unlock_irq(&p->pi_lock);
+	raw_spin_unlock_irqrestore(&p->pi_lock, rf.flags);
 	return ret;
 }
 
