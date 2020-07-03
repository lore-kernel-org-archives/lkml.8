Return-Path: <SRS0=gItQ=AO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 70E75C433DF
	for <linux-kernel@archiver.kernel.org>; Fri,  3 Jul 2020 13:33:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 39ED120782
	for <linux-kernel@archiver.kernel.org>; Fri,  3 Jul 2020 13:33:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="WFu8h708"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726178AbgGCNdI (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 3 Jul 2020 09:33:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34420 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726022AbgGCNdI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 Jul 2020 09:33:08 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 10179C08C5C1
        for <linux-kernel@vger.kernel.org>; Fri,  3 Jul 2020 06:33:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Type:MIME-Version:Message-ID:
        Subject:Cc:To:From:Date:Sender:Reply-To:Content-Transfer-Encoding:Content-ID:
        Content-Description:In-Reply-To:References;
        bh=9YDdy6Foed3LJXpWF6Eundonrr2l5x5JakjSR+t7Iso=; b=WFu8h708ot95yZTtVzcZ7KZpRf
        H1dNMDIZnFt6ipWd5LHrBFgiQ1RFhzuXwfwC5G/+0yr32bo+1NnBkVyVazMVRKvGENxwoxX8cwxJU
        bzhVyBIkiXuPQL/U7G5rBFO7NAo5XvHI6Ew8St7acdS5+hwxy0GMhjVDwrvUUsAtw+8B74cKE0EyY
        t28zQNckajpCkykNR4Ea5h1dg5DKXyRLzhjldBV2/UEmyIyRd4+dxov/DQBmrCrAo2lfluxdhUsF1
        9s4E6+spLqUQAItIXSygE3tUb4OYF65DzipdiEBHh7d5Jz9LallLaDvls5buYY9gVbMiUVI8M5fiJ
        wi8o6LJQ==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by casper.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1jrLoK-0004TD-1B; Fri, 03 Jul 2020 13:33:01 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 6398330377D;
        Fri,  3 Jul 2020 15:32:59 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 45447203C0A3A; Fri,  3 Jul 2020 15:32:59 +0200 (CEST)
Date:   Fri, 3 Jul 2020 15:32:59 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Ingo Molnar <mingo@kernel.org>
Cc:     linux-kernel@vger.kernel.org, vincent.guittot@linaro.org,
        mgorman@suse.de, Oleg Nesterov <oleg@redhat.com>,
        david@fromorbit.com, pauld@redhat.com, valentin.schneider@arm.com,
        dietmar.eggemann@arm.com
Subject: [PATCH] sched: Better document ttwu()
Message-ID: <20200703133259.GE4781@hirez.programming.kicks-ass.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


Dave hit the problem fixed by commit:

  b6e13e85829f ("sched/core: Fix ttwu() race")

and failed to understand much of the code involved. Per his request a
few comments to (hopefully) clarify things.

Requested-by: Dave Chinner <david@fromorbit.com>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
---
 include/linux/sched.h |   12 +--
 kernel/sched/core.c   |  196 +++++++++++++++++++++++++++++++++++++++++++-------
 kernel/sched/sched.h  |   10 ++
 3 files changed, 187 insertions(+), 31 deletions(-)

--- a/include/linux/sched.h
+++ b/include/linux/sched.h
@@ -158,24 +158,24 @@ struct task_group;
  *
  *   for (;;) {
  *	set_current_state(TASK_UNINTERRUPTIBLE);
- *	if (!need_sleep)
- *		break;
+ *	if (CONDITION)
+ *	   break;
  *
  *	schedule();
  *   }
  *   __set_current_state(TASK_RUNNING);
  *
  * If the caller does not need such serialisation (because, for instance, the
- * condition test and condition change and wakeup are under the same lock) then
+ * CONDITION test and condition change and wakeup are under the same lock) then
  * use __set_current_state().
  *
  * The above is typically ordered against the wakeup, which does:
  *
- *   need_sleep = false;
+ *   CONDITION = 1;
  *   wake_up_state(p, TASK_UNINTERRUPTIBLE);
  *
- * where wake_up_state() executes a full memory barrier before accessing the
- * task state.
+ * where wake_up_state()/try_to_wake_up() executes a full memory barrier before
+ * accessing p->state.
  *
  * Wakeup will do: if (@state & p->state) p->state = TASK_RUNNING, that is,
  * once it observes the TASK_UNINTERRUPTIBLE store the waking CPU can issue a
--- a/kernel/sched/core.c
+++ b/kernel/sched/core.c
@@ -79,6 +79,100 @@ __read_mostly int scheduler_running;
  */
 int sysctl_sched_rt_runtime = 950000;
 
+
+/*
+ * Serialization rules:
+ *
+ * Lock order:
+ *
+ *   p->pi_lock
+ *     rq->lock
+ *       hrtimer_cpu_base->lock (hrtimer_start() for bandwidth controls)
+ *
+ *  rq1->lock
+ *    rq2->lock  where: rq1 < rq2
+ *
+ * Regular state:
+ *
+ * Normal scheduling state is serialized by rq->lock. __schedule() takes the
+ * local CPU's rq->lock, it optionally removes the task from the runqueue and
+ * always looks at the local rq data structures to find the most elegible task
+ * to run next.
+ *
+ * Task enqueue is also under rq->lock, possibly taken from another CPU.
+ * Wakeups from another LLC domain might use an IPI to transfer the enqueue to
+ * the local CPU to avoid bouncing the runqueue state around [ see
+ * ttwu_queue_wakelist() ]
+ *
+ * Task wakeup, specifically wakeups that involve migration, are horribly
+ * complicated to avoid having to take two rq->locks.
+ *
+ * Special state:
+ *
+ * System-calls and anything external will use task_rq_lock() which acquires
+ * both p->pi_lock and rq->lock. As a consequence the state they change is
+ * stable while holding either lock:
+ *
+ *  - sched_setaffinity()/
+ *    set_cpus_allowed_ptr():	p->cpus_ptr, p->nr_cpus_allowed
+ *  - set_user_nice():		p->se.load, p->*prio
+ *  - __sched_setscheduler():	p->sched_class, p->policy, p->*prio,
+ *				p->se.load, p->rt_priority,
+ *				p->dl.dl_{runtime, deadline, period, flags, bw, density}
+ *  - sched_setnuma():		p->numa_preferred_nid
+ *  - sched_move_task()/
+ *    cpu_cgroup_fork():	p->sched_task_group
+ *  - uclamp_update_active()	p->uclamp*
+ *
+ * p->state <- TASK_*:
+ *
+ *   is changed locklessly using set_current_state(), __set_current_state() or
+ *   set_special_state(), see their respective comments, or by
+ *   try_to_wake_up(). This latter uses p->pi_lock to serialize against
+ *   concurrent self.
+ *
+ * p->on_rq <- { 0, 1 = TASK_ON_RQ_QUEUED, 2 = TASK_ON_RQ_MIGRATING }:
+ *
+ *   is set by activate_task() and cleared by deactivate_task(), under
+ *   rq->lock. Non-zero indicates the task is runnable, the special
+ *   ON_RQ_MIGRATING state is used for migration without holding both
+ *   rq->locks. It indicates task_cpu() is not stable, see task_rq_lock().
+ *
+ * p->on_cpu <- { 0, 1 }:
+ *
+ *   is set by prepare_task() and cleared by finish_task() such that it will be
+ *   set before p is scheduled-in and cleared after p is scheduled-out, both
+ *   under rq->lock. Non-zero indicates the task is running on its CPU.
+ *
+ *   [ The astute reader will observe that it is possible for two tasks on one
+ *     CPU to have ->on_cpu = 1 at the same time. ]
+ *
+ * task_cpu(p): is changed by set_task_cpu(), the rules are:
+ *
+ *  - Don't call set_task_cpu() on a blocked task:
+ *
+ *    We don't care what CPU we're not running on, this simplifies hotplug,
+ *    the CPU assignment of blocked tasks isn't required to be valid.
+ *
+ *  - for try_to_wake_up(), called under p->pi_lock:
+ *
+ *    This allows try_to_wake_up() to only take one rq->lock, see its comment.
+ *
+ *  - for migration called under rq->lock:
+ *    [ see task_on_rq_migrating() in task_rq_lock() ]
+ *
+ *    o move_queued_task()
+ *    o detach_task()
+ *
+ *  - for migration called under double_rq_lock():
+ *
+ *    o __migrate_swap_task()
+ *    o push_rt_task() / pull_rt_task()
+ *    o push_dl_task() / pull_dl_task()
+ *    o dl_task_offline_migration()
+ *
+ */
+
 /*
  * __task_rq_lock - lock the rq @p resides on.
  */
@@ -1549,8 +1643,7 @@ static struct rq *move_queued_task(struc
 {
 	lockdep_assert_held(&rq->lock);
 
-	WRITE_ONCE(p->on_rq, TASK_ON_RQ_MIGRATING);
-	dequeue_task(rq, p, DEQUEUE_NOCLOCK);
+	deactivate_task(rq, p, DEQUEUE_NOCLOCK);
 	set_task_cpu(p, new_cpu);
 	rq_unlock(rq, rf);
 
@@ -1558,8 +1651,7 @@ static struct rq *move_queued_task(struc
 
 	rq_lock(rq, rf);
 	BUG_ON(task_cpu(p) != new_cpu);
-	enqueue_task(rq, p, 0);
-	p->on_rq = TASK_ON_RQ_QUEUED;
+	activate_task(rq, p, 0);
 	check_preempt_curr(rq, p, 0);
 
 	return rq;
@@ -2324,12 +2416,31 @@ ttwu_do_activate(struct rq *rq, struct t
 }
 
 /*
- * Called in case the task @p isn't fully descheduled from its runqueue,
- * in this case we must do a remote wakeup. Its a 'light' wakeup though,
- * since all we need to do is flip p->state to TASK_RUNNING, since
- * the task is still ->on_rq.
+ * Consider @p being inside a wait loop:
+ *
+ *   for (;;) {
+ *      set_current_state(TASK_UNINTERRUPTIBLE);
+ *
+ *      if (CONDITION)
+ *         break;
+ *
+ *      schedule();
+ *   }
+ *   __set_current_state(TASK_RUNNING);
+ *
+ * between set_current_state() and schedule(). In this case @p is still
+ * runnable, so all that needs doing is change p->state back to TASK_RUNNING in
+ * an atomic manner.
+ *
+ * By taking task_rq(p)->lock we serialize against schedule(), if @p->on_rq
+ * then schedule() must still happen and p->state can be changed to
+ * TASK_RUNNING. Otherwise we lost the race, schedule() has happened, and we
+ * need to do a full wakeup with enqueue.
+ *
+ * Returns: %true when the wakeup is done,
+ *          %false otherwise.
  */
-static int ttwu_remote(struct task_struct *p, int wake_flags)
+static int ttwu_runnable(struct task_struct *p, int wake_flags)
 {
 	struct rq_flags rf;
 	struct rq *rq;
@@ -2470,6 +2581,14 @@ static bool ttwu_queue_wakelist(struct t
 
 	return false;
 }
+
+#else /* !CONFIG_SMP */
+
+static inline bool ttwu_queue_wakelist(struct task_struct *p, int cpu, int wake_flags)
+{
+	return false;
+}
+
 #endif /* CONFIG_SMP */
 
 static void ttwu_queue(struct task_struct *p, int cpu, int wake_flags)
@@ -2477,10 +2596,8 @@ static void ttwu_queue(struct task_struc
 	struct rq *rq = cpu_rq(cpu);
 	struct rq_flags rf;
 
-#if defined(CONFIG_SMP)
 	if (ttwu_queue_wakelist(p, cpu, wake_flags))
 		return;
-#endif
 
 	rq_lock(rq, &rf);
 	update_rq_clock(rq);
@@ -2536,8 +2653,8 @@ static void ttwu_queue(struct task_struc
  * migration. However the means are completely different as there is no lock
  * chain to provide order. Instead we do:
  *
- *   1) smp_store_release(X->on_cpu, 0)
- *   2) smp_cond_load_acquire(!X->on_cpu)
+ *   1) smp_store_release(X->on_cpu, 0)   -- finish_task()
+ *   2) smp_cond_load_acquire(!X->on_cpu) -- try_to_wake_up()
  *
  * Example:
  *
@@ -2577,15 +2694,41 @@ static void ttwu_queue(struct task_struc
  * @state: the mask of task states that can be woken
  * @wake_flags: wake modifier flags (WF_*)
  *
- * If (@state & @p->state) @p->state = TASK_RUNNING.
+ * Conceptually does:
+ *
+ *   If (@state & @p->state) @p->state = TASK_RUNNING.
  *
  * If the task was not queued/runnable, also place it back on a runqueue.
  *
- * Atomic against schedule() which would dequeue a task, also see
- * set_current_state().
+ * This function is atomic against schedule() which would dequeue the task.
  *
- * This function executes a full memory barrier before accessing the task
- * state; see set_current_state().
+ * It issues a full memory barrier before accessing @p->state, see the comment
+ * with set_current_state().
+ *
+ * Uses p->pi_lock to serialize against concurrent wake-ups.
+ *
+ * Relies on p->pi_lock stabilizing:
+ *  - p->sched_class
+ *  - p->cpus_ptr
+ *  - p->sched_task_group
+ * in order to do migration, see its use of select_task_rq()/set_task_cpu().
+ *
+ * Tries really hard to only take one task_rq(p)->lock for performance.
+ * Takes rq->lock in:
+ *  - ttwu_runnable()    -- old rq, unavoidable, see comment there;
+ *  - ttwu_queue()       -- new rq, for enqueue of the task;
+ *  - psi_ttwu_dequeue() -- much sadness :-( accounting will kill us.
+ *
+ * As a consequence we race really badly with just about everything. See the
+ * many memory barriers and their comments for details. The basic order of
+ * reading things is:
+ *
+ *   LOAD p->state
+ *   RMB
+ *   LOAD p->on_rq
+ *   RMB
+ *   LOAD-ACQUIRE p->on_cpu
+ *   LOAD task_cpu()
  *
  * Return: %true if @p->state changes (an actual wakeup was done),
  *	   %false otherwise.
@@ -2601,7 +2744,7 @@ try_to_wake_up(struct task_struct *p, un
 		/*
 		 * We're waking current, this means 'p->on_rq' and 'task_cpu(p)
 		 * == smp_processor_id()'. Together this means we can special
-		 * case the whole 'p->on_rq && ttwu_remote()' case below
+		 * case the whole 'p->on_rq && ttwu_runnable()' case below
 		 * without taking any locks.
 		 *
 		 * In particular:
@@ -2622,8 +2765,8 @@ try_to_wake_up(struct task_struct *p, un
 	/*
 	 * If we are going to wake up a thread waiting for CONDITION we
 	 * need to ensure that CONDITION=1 done by the caller can not be
-	 * reordered with p->state check below. This pairs with mb() in
-	 * set_current_state() the waiting thread does.
+	 * reordered with p->state check below. This pairs with smp_store_mb()
+	 * in set_current_state() that the waiting thread does.
 	 */
 	raw_spin_lock_irqsave(&p->pi_lock, flags);
 	smp_mb__after_spinlock();
@@ -2658,7 +2801,7 @@ try_to_wake_up(struct task_struct *p, un
 	 * A similar smb_rmb() lives in try_invoke_on_locked_down_task().
 	 */
 	smp_rmb();
-	if (p->on_rq && ttwu_remote(p, wake_flags))
+	if (p->on_rq && ttwu_runnable(p, wake_flags))
 		goto unlock;
 
 	if (p->in_iowait) {
@@ -3217,8 +3360,10 @@ static inline void prepare_task(struct t
 	/*
 	 * Claim the task as running, we do this before switching to it
 	 * such that any running task will have this set.
+	 *
+	 * See the ttwu() WF_ON_CPU case and its ordering comment.
 	 */
-	next->on_cpu = 1;
+	WRITE_ONCE(next->on_cpu, 1);
 #endif
 }
 
@@ -3226,8 +3371,9 @@ static inline void finish_task(struct ta
 {
 #ifdef CONFIG_SMP
 	/*
-	 * After ->on_cpu is cleared, the task can be moved to a different CPU.
-	 * We must ensure this doesn't happen until the switch is completely
+	 * This must be the very last reference to @prev from this CPU. After
+	 * p->on_cpu is cleared, the task can be moved to a different CPU. We
+	 * must ensure this doesn't happen until the switch is completely
 	 * finished.
 	 *
 	 * In particular, the load of prev->state in finish_task_switch() must
--- a/kernel/sched/sched.h
+++ b/kernel/sched/sched.h
@@ -1203,6 +1203,16 @@ struct rq_flags {
 #endif
 };
 
+/*
+ * Lockdep annotation that avoids accidental unlocks; it's like a
+ * sticky/continuous lockdep_assert_held().
+ *
+ * This avoids code that has access to 'struct rq *rq' (basically everything in
+ * the scheduler) from accidentally unlocking the rq if they do not also have a
+ * copy of the (on-stack) 'struct rq_flags rf'.
+ *
+ * Also see Documentation/locking/lockdep-design.rst.
+ */
 static inline void rq_pin_lock(struct rq *rq, struct rq_flags *rf)
 {
 	rf->cookie = lockdep_pin_lock(&rq->lock);
