Return-Path: <SRS0=ABJN=6Z=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.8 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CE773C47255
	for <linux-kernel@archiver.kernel.org>; Mon, 11 May 2020 21:04:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id AF1292078A
	for <linux-kernel@archiver.kernel.org>; Mon, 11 May 2020 21:04:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731976AbgEKVEF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 11 May 2020 17:04:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44026 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1731941AbgEKU7m (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 May 2020 16:59:42 -0400
Received: from Galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 33CCEC061A0E;
        Mon, 11 May 2020 13:59:42 -0700 (PDT)
Received: from [5.158.153.53] (helo=tip-bot2.lab.linutronix.de)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tip-bot2@linutronix.de>)
        id 1jYFWW-0005rB-JB; Mon, 11 May 2020 22:59:40 +0200
Received: from [127.0.1.1] (localhost [IPv6:::1])
        by tip-bot2.lab.linutronix.de (Postfix) with ESMTP id 7CDD71C04D6;
        Mon, 11 May 2020 22:59:31 +0200 (CEST)
Date:   Mon, 11 May 2020 20:59:31 -0000
From:   "tip-bot2 for Paul E. McKenney" <tip-bot2@linutronix.de>
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: core/rcu] rcu-tasks: Further refactor RCU-tasks to allow adding
 more variants
Cc:     "Paul E. McKenney" <paulmck@kernel.org>, x86 <x86@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <158923077144.390.5976766857276176042.tip-bot2@tip-bot2>
X-Mailer: tip-git-log-daemon
Robot-ID: <tip-bot2.linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Linutronix-Spam-Score: -1.0
X-Linutronix-Spam-Level: -
X-Linutronix-Spam-Status: No , -1.0 points, 5.0 required,  ALL_TRUSTED=-1,SHORTCIRCUIT=-0.0001
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following commit has been merged into the core/rcu branch of tip:

Commit-ID:     e4fe5dd6f26f74233e217d9dd351adc3e5165bb9
Gitweb:        https://git.kernel.org/tip/e4fe5dd6f26f74233e217d9dd351adc3e5165bb9
Author:        Paul E. McKenney <paulmck@kernel.org>
AuthorDate:    Wed, 04 Mar 2020 17:31:43 -08:00
Committer:     Paul E. McKenney <paulmck@kernel.org>
CommitterDate: Mon, 27 Apr 2020 11:03:51 -07:00

rcu-tasks: Further refactor RCU-tasks to allow adding more variants

This commit refactors RCU tasks to allow variants to be added.  These
variants will share the current Tasks-RCU tasklist scan and the holdout
list processing.

Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
---
 kernel/rcu/tasks.h | 166 ++++++++++++++++++++++++++++----------------
 1 file changed, 108 insertions(+), 58 deletions(-)

diff --git a/kernel/rcu/tasks.h b/kernel/rcu/tasks.h
index 9ca83c6..344426e 100644
--- a/kernel/rcu/tasks.h
+++ b/kernel/rcu/tasks.h
@@ -12,6 +12,11 @@
 
 struct rcu_tasks;
 typedef void (*rcu_tasks_gp_func_t)(struct rcu_tasks *rtp);
+typedef void (*pregp_func_t)(void);
+typedef void (*pertask_func_t)(struct task_struct *t, struct list_head *hop);
+typedef void (*postscan_func_t)(void);
+typedef void (*holdouts_func_t)(struct list_head *hop, bool ndrpt, bool *frptp);
+typedef void (*postgp_func_t)(void);
 
 /**
  * Definition for a Tasks-RCU-like mechanism.
@@ -21,6 +26,11 @@ typedef void (*rcu_tasks_gp_func_t)(struct rcu_tasks *rtp);
  * @cbs_lock: Lock protecting callback list.
  * @kthread_ptr: This flavor's grace-period/callback-invocation kthread.
  * @gp_func: This flavor's grace-period-wait function.
+ * @pregp_func: This flavor's pre-grace-period function (optional).
+ * @pertask_func: This flavor's per-task scan function (optional).
+ * @postscan_func: This flavor's post-task scan function (optional).
+ * @holdout_func: This flavor's holdout-list scan function (optional).
+ * @postgp_func: This flavor's post-grace-period function (optional).
  * @call_func: This flavor's call_rcu()-equivalent function.
  * @name: This flavor's textual name.
  * @kname: This flavor's kthread name.
@@ -32,6 +42,11 @@ struct rcu_tasks {
 	raw_spinlock_t cbs_lock;
 	struct task_struct *kthread_ptr;
 	rcu_tasks_gp_func_t gp_func;
+	pregp_func_t pregp_func;
+	pertask_func_t pertask_func;
+	postscan_func_t postscan_func;
+	holdouts_func_t holdouts_func;
+	postgp_func_t postgp_func;
 	call_rcu_func_t call_func;
 	char *name;
 	char *kname;
@@ -113,6 +128,7 @@ static int __noreturn rcu_tasks_kthread(void *arg)
 
 		/* Pick up any new callbacks. */
 		raw_spin_lock_irqsave(&rtp->cbs_lock, flags);
+		smp_mb__after_unlock_lock(); // Order updates vs. GP.
 		list = rtp->cbs_head;
 		rtp->cbs_head = NULL;
 		rtp->cbs_tail = &rtp->cbs_head;
@@ -207,6 +223,49 @@ static void __init rcu_tasks_bootup_oddness(void)
 // rates from multiple CPUs.  If this is required, per-CPU callback lists
 // will be needed.
 
+/* Pre-grace-period preparation. */
+static void rcu_tasks_pregp_step(void)
+{
+	/*
+	 * Wait for all pre-existing t->on_rq and t->nvcsw transitions
+	 * to complete.  Invoking synchronize_rcu() suffices because all
+	 * these transitions occur with interrupts disabled.  Without this
+	 * synchronize_rcu(), a read-side critical section that started
+	 * before the grace period might be incorrectly seen as having
+	 * started after the grace period.
+	 *
+	 * This synchronize_rcu() also dispenses with the need for a
+	 * memory barrier on the first store to t->rcu_tasks_holdout,
+	 * as it forces the store to happen after the beginning of the
+	 * grace period.
+	 */
+	synchronize_rcu();
+}
+
+/* Per-task initial processing. */
+static void rcu_tasks_pertask(struct task_struct *t, struct list_head *hop)
+{
+	if (t != current && READ_ONCE(t->on_rq) && !is_idle_task(t)) {
+		get_task_struct(t);
+		t->rcu_tasks_nvcsw = READ_ONCE(t->nvcsw);
+		WRITE_ONCE(t->rcu_tasks_holdout, true);
+		list_add(&t->rcu_tasks_holdout_list, hop);
+	}
+}
+
+/* Processing between scanning taskslist and draining the holdout list. */
+void rcu_tasks_postscan(void)
+{
+	/*
+	 * Wait for tasks that are in the process of exiting.  This
+	 * does only part of the job, ensuring that all tasks that were
+	 * previously exiting reach the point where they have disabled
+	 * preemption, allowing the later synchronize_rcu() to finish
+	 * the job.
+	 */
+	synchronize_srcu(&tasks_rcu_exit_srcu);
+}
+
 /* See if tasks are still holding out, complain if so. */
 static void check_holdout_task(struct task_struct *t,
 			       bool needreport, bool *firstreport)
@@ -239,55 +298,63 @@ static void check_holdout_task(struct task_struct *t,
 	sched_show_task(t);
 }
 
+/* Scan the holdout lists for tasks no longer holding out. */
+static void check_all_holdout_tasks(struct list_head *hop,
+				    bool needreport, bool *firstreport)
+{
+	struct task_struct *t, *t1;
+
+	list_for_each_entry_safe(t, t1, hop, rcu_tasks_holdout_list) {
+		check_holdout_task(t, needreport, firstreport);
+		cond_resched();
+	}
+}
+
+/* Finish off the Tasks-RCU grace period. */
+static void rcu_tasks_postgp(void)
+{
+	/*
+	 * Because ->on_rq and ->nvcsw are not guaranteed to have a full
+	 * memory barriers prior to them in the schedule() path, memory
+	 * reordering on other CPUs could cause their RCU-tasks read-side
+	 * critical sections to extend past the end of the grace period.
+	 * However, because these ->nvcsw updates are carried out with
+	 * interrupts disabled, we can use synchronize_rcu() to force the
+	 * needed ordering on all such CPUs.
+	 *
+	 * This synchronize_rcu() also confines all ->rcu_tasks_holdout
+	 * accesses to be within the grace period, avoiding the need for
+	 * memory barriers for ->rcu_tasks_holdout accesses.
+	 *
+	 * In addition, this synchronize_rcu() waits for exiting tasks
+	 * to complete their final preempt_disable() region of execution,
+	 * cleaning up after the synchronize_srcu() above.
+	 */
+	synchronize_rcu();
+}
+
 /* Wait for one RCU-tasks grace period. */
 static void rcu_tasks_wait_gp(struct rcu_tasks *rtp)
 {
 	struct task_struct *g, *t;
 	unsigned long lastreport;
-	LIST_HEAD(rcu_tasks_holdouts);
+	LIST_HEAD(holdouts);
 	int fract;
 
-	/*
-	 * Wait for all pre-existing t->on_rq and t->nvcsw transitions
-	 * to complete.  Invoking synchronize_rcu() suffices because all
-	 * these transitions occur with interrupts disabled.  Without this
-	 * synchronize_rcu(), a read-side critical section that started
-	 * before the grace period might be incorrectly seen as having
-	 * started after the grace period.
-	 *
-	 * This synchronize_rcu() also dispenses with the need for a
-	 * memory barrier on the first store to t->rcu_tasks_holdout,
-	 * as it forces the store to happen after the beginning of the
-	 * grace period.
-	 */
-	synchronize_rcu();
+	rtp->pregp_func();
 
 	/*
 	 * There were callbacks, so we need to wait for an RCU-tasks
 	 * grace period.  Start off by scanning the task list for tasks
 	 * that are not already voluntarily blocked.  Mark these tasks
-	 * and make a list of them in rcu_tasks_holdouts.
+	 * and make a list of them in holdouts.
 	 */
 	rcu_read_lock();
-	for_each_process_thread(g, t) {
-		if (t != current && READ_ONCE(t->on_rq) && !is_idle_task(t)) {
-			get_task_struct(t);
-			t->rcu_tasks_nvcsw = READ_ONCE(t->nvcsw);
-			WRITE_ONCE(t->rcu_tasks_holdout, true);
-			list_add(&t->rcu_tasks_holdout_list,
-				 &rcu_tasks_holdouts);
-		}
-	}
+	for_each_process_thread(g, t)
+		rtp->pertask_func(t, &holdouts);
 	rcu_read_unlock();
 
-	/*
-	 * Wait for tasks that are in the process of exiting.  This
-	 * does only part of the job, ensuring that all tasks that were
-	 * previously exiting reach the point where they have disabled
-	 * preemption, allowing the later synchronize_rcu() to finish
-	 * the job.
-	 */
-	synchronize_srcu(&tasks_rcu_exit_srcu);
+	rtp->postscan_func();
 
 	/*
 	 * Each pass through the following loop scans the list of holdout
@@ -303,9 +370,8 @@ static void rcu_tasks_wait_gp(struct rcu_tasks *rtp)
 		bool firstreport;
 		bool needreport;
 		int rtst;
-		struct task_struct *t1;
 
-		if (list_empty(&rcu_tasks_holdouts))
+		if (list_empty(&holdouts))
 			break;
 
 		/* Slowly back off waiting for holdouts */
@@ -320,31 +386,10 @@ static void rcu_tasks_wait_gp(struct rcu_tasks *rtp)
 			lastreport = jiffies;
 		firstreport = true;
 		WARN_ON(signal_pending(current));
-		list_for_each_entry_safe(t, t1, &rcu_tasks_holdouts,
-					 rcu_tasks_holdout_list) {
-			check_holdout_task(t, needreport, &firstreport);
-			cond_resched();
-		}
+		rtp->holdouts_func(&holdouts, needreport, &firstreport);
 	}
 
-	/*
-	 * Because ->on_rq and ->nvcsw are not guaranteed to have a full
-	 * memory barriers prior to them in the schedule() path, memory
-	 * reordering on other CPUs could cause their RCU-tasks read-side
-	 * critical sections to extend past the end of the grace period.
-	 * However, because these ->nvcsw updates are carried out with
-	 * interrupts disabled, we can use synchronize_rcu() to force the
-	 * needed ordering on all such CPUs.
-	 *
-	 * This synchronize_rcu() also confines all ->rcu_tasks_holdout
-	 * accesses to be within the grace period, avoiding the need for
-	 * memory barriers for ->rcu_tasks_holdout accesses.
-	 *
-	 * In addition, this synchronize_rcu() waits for exiting tasks
-	 * to complete their final preempt_disable() region of execution,
-	 * cleaning up after the synchronize_srcu() above.
-	 */
-	synchronize_rcu();
+	rtp->postgp_func();
 }
 
 void call_rcu_tasks(struct rcu_head *rhp, rcu_callback_t func);
@@ -413,6 +458,11 @@ EXPORT_SYMBOL_GPL(rcu_barrier_tasks);
 
 static int __init rcu_spawn_tasks_kthread(void)
 {
+	rcu_tasks.pregp_func = rcu_tasks_pregp_step;
+	rcu_tasks.pertask_func = rcu_tasks_pertask;
+	rcu_tasks.postscan_func = rcu_tasks_postscan;
+	rcu_tasks.holdouts_func = check_all_holdout_tasks;
+	rcu_tasks.postgp_func = rcu_tasks_postgp;
 	rcu_spawn_tasks_kthread_generic(&rcu_tasks);
 	return 0;
 }
