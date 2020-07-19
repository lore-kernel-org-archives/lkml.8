Return-Path: <SRS0=EKp2=A6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 869A4C433DF
	for <linux-kernel@archiver.kernel.org>; Sun, 19 Jul 2020 13:20:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5CC8E21775
	for <linux-kernel@archiver.kernel.org>; Sun, 19 Jul 2020 13:20:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="wFp2H43h";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="NKrErDvl"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726446AbgGSNTH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 19 Jul 2020 09:19:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50300 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725836AbgGSNTG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 19 Jul 2020 09:19:06 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4ADBBC0619D2
        for <linux-kernel@vger.kernel.org>; Sun, 19 Jul 2020 06:19:06 -0700 (PDT)
Date:   Sun, 19 Jul 2020 13:18:11 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1595164744;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:  references:references;
        bh=+kmDVi3C7GOfiUhs70fP7OvB5FmTXvUfvcUti57Xoj8=;
        b=wFp2H43hn1I0SjzLilDAS0+op7yogic13pciaN76db8y6LRYf4fmULaaqTMCaYevYO/lSs
        RkKaQs4GJuSiJt4DrsfAUmu2Z7QMmpLlGouRhtHtZeW7zN2GAK8E8QrFGDkDaGZF7XfLta
        mwhcpcVeLAqj6pvsAcTMREIVkbafcY3AHfZeOFeIBIQaxZ85KmXjUFYN0uR1bQHJ+hYQzI
        GkiiCEn5DZhHdrxfIqHm36t5AkpZqgoJ7/OzyvEqsdaGM0V3ZMaOfCkMTTmOvv6VnZzFlV
        lkvGuOfT3yD8b+rczcuEByA+dy/FdfhLu4eHa3vuAlKZT/7QPSLjcs0Jah1Njw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1595164744;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:  references:references;
        bh=+kmDVi3C7GOfiUhs70fP7OvB5FmTXvUfvcUti57Xoj8=;
        b=NKrErDvlDQeiYklUrb++64Eg38NlCC2pTr0hY4O1eguP91vOyzzSSPEzo1xj++Tab0mCU4
        8/1OnCfyzbDQU2AQ==
From:   Thomas Gleixner <tglx@linutronix.de>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     linux-kernel@vger.kernel.org, x86@kernel.org
Subject: [GIT pull] sched/urgent for v5.8-rc6
References: <159516469014.4147.6471285397574034610.tglx@nanos.tec.linutronix.de>
Message-ID: <159516469134.4147.3024788666121647415.tglx@nanos.tec.linutronix.de>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Linus,

please pull the latest sched/urgent branch from:

   git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git sched-urgent-2020-07-19

up to:  01cfcde9c26d: sched/fair: handle case of task_h_load() returning 0

A set of scheduler fixes:

 - Plug a load average accounting race which was introduced with a recent
   optimization casing load average to show bogus numbers.

 - Fix the rseq CPU id initialization for new tasks. sched_fork() does not
   update the rseq CPU id so the id is the stale id of the parent task,
   which can cause user space data corruption.

 - Handle a 0 return value of task_h_load() correctly in the load balancer,
   which does not decrease imbalance and therefore pulls until the maximum
   number of loops is reached, which might be all tasks just created by a
   fork bomb.

Thanks,

	tglx

------------------>
Mathieu Desnoyers (1):
      sched: Fix unreliable rseq cpu_id for new tasks

Peter Zijlstra (1):
      sched: Fix loadavg accounting race

Vincent Guittot (1):
      sched/fair: handle case of task_h_load() returning 0


 include/linux/sched.h |  4 ---
 kernel/sched/core.c   | 69 +++++++++++++++++++++++++++++++++++++++------------
 kernel/sched/fair.c   | 15 +++++++++--
 3 files changed, 66 insertions(+), 22 deletions(-)

diff --git a/include/linux/sched.h b/include/linux/sched.h
index 692e327d7455..683372943093 100644
--- a/include/linux/sched.h
+++ b/include/linux/sched.h
@@ -114,10 +114,6 @@ struct task_group;
 
 #define task_is_stopped_or_traced(task)	((task->state & (__TASK_STOPPED | __TASK_TRACED)) != 0)
 
-#define task_contributes_to_load(task)	((task->state & TASK_UNINTERRUPTIBLE) != 0 && \
-					 (task->flags & PF_FROZEN) == 0 && \
-					 (task->state & TASK_NOLOAD) == 0)
-
 #ifdef CONFIG_DEBUG_ATOMIC_SLEEP
 
 /*
diff --git a/kernel/sched/core.c b/kernel/sched/core.c
index ca5db40392d4..e15543cb8481 100644
--- a/kernel/sched/core.c
+++ b/kernel/sched/core.c
@@ -1311,9 +1311,6 @@ static inline void dequeue_task(struct rq *rq, struct task_struct *p, int flags)
 
 void activate_task(struct rq *rq, struct task_struct *p, int flags)
 {
-	if (task_contributes_to_load(p))
-		rq->nr_uninterruptible--;
-
 	enqueue_task(rq, p, flags);
 
 	p->on_rq = TASK_ON_RQ_QUEUED;
@@ -1323,9 +1320,6 @@ void deactivate_task(struct rq *rq, struct task_struct *p, int flags)
 {
 	p->on_rq = (flags & DEQUEUE_SLEEP) ? 0 : TASK_ON_RQ_MIGRATING;
 
-	if (task_contributes_to_load(p))
-		rq->nr_uninterruptible++;
-
 	dequeue_task(rq, p, flags);
 }
 
@@ -2236,10 +2230,10 @@ ttwu_do_activate(struct rq *rq, struct task_struct *p, int wake_flags,
 
 	lockdep_assert_held(&rq->lock);
 
-#ifdef CONFIG_SMP
 	if (p->sched_contributes_to_load)
 		rq->nr_uninterruptible--;
 
+#ifdef CONFIG_SMP
 	if (wake_flags & WF_MIGRATED)
 		en_flags |= ENQUEUE_MIGRATED;
 #endif
@@ -2583,7 +2577,7 @@ try_to_wake_up(struct task_struct *p, unsigned int state, int wake_flags)
 	 * A similar smb_rmb() lives in try_invoke_on_locked_down_task().
 	 */
 	smp_rmb();
-	if (p->on_rq && ttwu_remote(p, wake_flags))
+	if (READ_ONCE(p->on_rq) && ttwu_remote(p, wake_flags))
 		goto unlock;
 
 	if (p->in_iowait) {
@@ -2592,9 +2586,6 @@ try_to_wake_up(struct task_struct *p, unsigned int state, int wake_flags)
 	}
 
 #ifdef CONFIG_SMP
-	p->sched_contributes_to_load = !!task_contributes_to_load(p);
-	p->state = TASK_WAKING;
-
 	/*
 	 * Ensure we load p->on_cpu _after_ p->on_rq, otherwise it would be
 	 * possible to, falsely, observe p->on_cpu == 0.
@@ -2613,8 +2604,20 @@ try_to_wake_up(struct task_struct *p, unsigned int state, int wake_flags)
 	 *
 	 * Pairs with the LOCK+smp_mb__after_spinlock() on rq->lock in
 	 * __schedule().  See the comment for smp_mb__after_spinlock().
+	 *
+	 * Form a control-dep-acquire with p->on_rq == 0 above, to ensure
+	 * schedule()'s deactivate_task() has 'happened' and p will no longer
+	 * care about it's own p->state. See the comment in __schedule().
 	 */
-	smp_rmb();
+	smp_acquire__after_ctrl_dep();
+
+	/*
+	 * We're doing the wakeup (@success == 1), they did a dequeue (p->on_rq
+	 * == 0), which means we need to do an enqueue, change p->state to
+	 * TASK_WAKING such that we can unlock p->pi_lock before doing the
+	 * enqueue, such as ttwu_queue_wakelist().
+	 */
+	p->state = TASK_WAKING;
 
 	/*
 	 * If the owning (remote) CPU is still in the middle of schedule() with
@@ -2962,6 +2965,7 @@ int sched_fork(unsigned long clone_flags, struct task_struct *p)
 	 * Silence PROVE_RCU.
 	 */
 	raw_spin_lock_irqsave(&p->pi_lock, flags);
+	rseq_migrate(p);
 	/*
 	 * We're setting the CPU for the first time, we don't migrate,
 	 * so use __set_task_cpu().
@@ -3026,6 +3030,7 @@ void wake_up_new_task(struct task_struct *p)
 	 * as we're not fully set-up yet.
 	 */
 	p->recent_used_cpu = task_cpu(p);
+	rseq_migrate(p);
 	__set_task_cpu(p, select_task_rq(p, task_cpu(p), SD_BALANCE_FORK, 0));
 #endif
 	rq = __task_rq_lock(p, &rf);
@@ -4097,6 +4102,7 @@ static void __sched notrace __schedule(bool preempt)
 {
 	struct task_struct *prev, *next;
 	unsigned long *switch_count;
+	unsigned long prev_state;
 	struct rq_flags rf;
 	struct rq *rq;
 	int cpu;
@@ -4113,12 +4119,22 @@ static void __sched notrace __schedule(bool preempt)
 	local_irq_disable();
 	rcu_note_context_switch(preempt);
 
+	/* See deactivate_task() below. */
+	prev_state = prev->state;
+
 	/*
 	 * Make sure that signal_pending_state()->signal_pending() below
 	 * can't be reordered with __set_current_state(TASK_INTERRUPTIBLE)
-	 * done by the caller to avoid the race with signal_wake_up().
+	 * done by the caller to avoid the race with signal_wake_up():
+	 *
+	 * __set_current_state(@state)		signal_wake_up()
+	 * schedule()				  set_tsk_thread_flag(p, TIF_SIGPENDING)
+	 *					  wake_up_state(p, state)
+	 *   LOCK rq->lock			    LOCK p->pi_state
+	 *   smp_mb__after_spinlock()		    smp_mb__after_spinlock()
+	 *     if (signal_pending_state())	    if (p->state & @state)
 	 *
-	 * The membarrier system call requires a full memory barrier
+	 * Also, the membarrier system call requires a full memory barrier
 	 * after coming from user-space, before storing to rq->curr.
 	 */
 	rq_lock(rq, &rf);
@@ -4129,10 +4145,31 @@ static void __sched notrace __schedule(bool preempt)
 	update_rq_clock(rq);
 
 	switch_count = &prev->nivcsw;
-	if (!preempt && prev->state) {
-		if (signal_pending_state(prev->state, prev)) {
+	/*
+	 * We must re-load prev->state in case ttwu_remote() changed it
+	 * before we acquired rq->lock.
+	 */
+	if (!preempt && prev_state && prev_state == prev->state) {
+		if (signal_pending_state(prev_state, prev)) {
 			prev->state = TASK_RUNNING;
 		} else {
+			prev->sched_contributes_to_load =
+				(prev_state & TASK_UNINTERRUPTIBLE) &&
+				!(prev_state & TASK_NOLOAD) &&
+				!(prev->flags & PF_FROZEN);
+
+			if (prev->sched_contributes_to_load)
+				rq->nr_uninterruptible++;
+
+			/*
+			 * __schedule()			ttwu()
+			 *   prev_state = prev->state;	  if (READ_ONCE(p->on_rq) && ...)
+			 *   LOCK rq->lock		    goto out;
+			 *   smp_mb__after_spinlock();	  smp_acquire__after_ctrl_dep();
+			 *   p->on_rq = 0;		  p->state = TASK_WAKING;
+			 *
+			 * After this, schedule() must not care about p->state any more.
+			 */
 			deactivate_task(rq, prev, DEQUEUE_SLEEP | DEQUEUE_NOCLOCK);
 
 			if (prev->in_iowait) {
diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
index 658aa7a2ae6f..04fa8dbcfa4d 100644
--- a/kernel/sched/fair.c
+++ b/kernel/sched/fair.c
@@ -4039,7 +4039,11 @@ static inline void update_misfit_status(struct task_struct *p, struct rq *rq)
 		return;
 	}
 
-	rq->misfit_task_load = task_h_load(p);
+	/*
+	 * Make sure that misfit_task_load will not be null even if
+	 * task_h_load() returns 0.
+	 */
+	rq->misfit_task_load = max_t(unsigned long, task_h_load(p), 1);
 }
 
 #else /* CONFIG_SMP */
@@ -7638,7 +7642,14 @@ static int detach_tasks(struct lb_env *env)
 
 		switch (env->migration_type) {
 		case migrate_load:
-			load = task_h_load(p);
+			/*
+			 * Depending of the number of CPUs and tasks and the
+			 * cgroup hierarchy, task_h_load() can return a null
+			 * value. Make sure that env->imbalance decreases
+			 * otherwise detach_tasks() will stop only after
+			 * detaching up to loop_max tasks.
+			 */
+			load = max_t(unsigned long, task_h_load(p), 1);
 
 			if (sched_feat(LB_MIN) &&
 			    load < 16 && !env->sd->nr_balance_failed)

