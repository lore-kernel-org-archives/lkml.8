Return-Path: <SRS0=ABJN=6Z=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.8 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 62D6BC54E4B
	for <linux-kernel@archiver.kernel.org>; Mon, 11 May 2020 21:00:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 42F6E24965
	for <linux-kernel@archiver.kernel.org>; Mon, 11 May 2020 21:00:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732115AbgEKVAJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 11 May 2020 17:00:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44072 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1732005AbgEKU7v (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 May 2020 16:59:51 -0400
Received: from Galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5DDCDC061A0C;
        Mon, 11 May 2020 13:59:51 -0700 (PDT)
Received: from [5.158.153.53] (helo=tip-bot2.lab.linutronix.de)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tip-bot2@linutronix.de>)
        id 1jYFWc-0005sv-21; Mon, 11 May 2020 22:59:46 +0200
Received: from [127.0.1.1] (localhost [IPv6:::1])
        by tip-bot2.lab.linutronix.de (Postfix) with ESMTP id 50C991C0859;
        Mon, 11 May 2020 22:59:34 +0200 (CEST)
Date:   Mon, 11 May 2020 20:59:34 -0000
From:   "tip-bot2 for Paul E. McKenney" <tip-bot2@linutronix.de>
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: core/rcu] rcu-tasks: Create struct to hold state information
Cc:     "Paul E. McKenney" <paulmck@kernel.org>, x86 <x86@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <158923077426.390.17696249483033292650.tip-bot2@tip-bot2>
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

Commit-ID:     07e105158d97b4969891e844f318d16f6cef566c
Gitweb:        https://git.kernel.org/tip/07e105158d97b4969891e844f318d16f6cef566c
Author:        Paul E. McKenney <paulmck@kernel.org>
AuthorDate:    Mon, 02 Mar 2020 15:16:57 -08:00
Committer:     Paul E. McKenney <paulmck@kernel.org>
CommitterDate: Mon, 27 Apr 2020 11:03:50 -07:00

rcu-tasks: Create struct to hold state information

This commit creates an rcu_tasks struct to hold state information for
RCU Tasks.  This is a preparation commit for adding additional flavors
of Tasks RCU, each of which would have its own rcu_tasks struct.

Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
---
 kernel/rcu/tasks.h | 73 ++++++++++++++++++++++++++++-----------------
 1 file changed, 46 insertions(+), 27 deletions(-)

diff --git a/kernel/rcu/tasks.h b/kernel/rcu/tasks.h
index be8d179..5ccfe0d 100644
--- a/kernel/rcu/tasks.h
+++ b/kernel/rcu/tasks.h
@@ -7,6 +7,30 @@
 
 #ifdef CONFIG_TASKS_RCU
 
+/**
+ * Definition for a Tasks-RCU-like mechanism.
+ * @cbs_head: Head of callback list.
+ * @cbs_tail: Tail pointer for callback list.
+ * @cbs_wq: Wait queue allowning new callback to get kthread's attention.
+ * @cbs_lock: Lock protecting callback list.
+ * @kthread_ptr: This flavor's grace-period/callback-invocation kthread.
+ */
+struct rcu_tasks {
+	struct rcu_head *cbs_head;
+	struct rcu_head **cbs_tail;
+	struct wait_queue_head cbs_wq;
+	raw_spinlock_t cbs_lock;
+	struct task_struct *kthread_ptr;
+};
+
+#define DEFINE_RCU_TASKS(name)						\
+static struct rcu_tasks name =						\
+{									\
+	.cbs_tail = &name.cbs_head,					\
+	.cbs_wq = __WAIT_QUEUE_HEAD_INITIALIZER(name.cbs_wq),		\
+	.cbs_lock = __RAW_SPIN_LOCK_UNLOCKED(name.cbs_lock),		\
+}
+
 /*
  * Simple variant of RCU whose quiescent states are voluntary context
  * switch, cond_resched_rcu_qs(), user-space execution, and idle.
@@ -18,12 +42,7 @@
  * rates from multiple CPUs.  If this is required, per-CPU callback lists
  * will be needed.
  */
-
-/* Global list of callbacks and associated lock. */
-static struct rcu_head *rcu_tasks_cbs_head;
-static struct rcu_head **rcu_tasks_cbs_tail = &rcu_tasks_cbs_head;
-static DECLARE_WAIT_QUEUE_HEAD(rcu_tasks_cbs_wq);
-static DEFINE_RAW_SPINLOCK(rcu_tasks_cbs_lock);
+DEFINE_RCU_TASKS(rcu_tasks);
 
 /* Track exiting tasks in order to allow them to be waited for. */
 DEFINE_STATIC_SRCU(tasks_rcu_exit_srcu);
@@ -33,8 +52,6 @@ DEFINE_STATIC_SRCU(tasks_rcu_exit_srcu);
 static int rcu_task_stall_timeout __read_mostly = RCU_TASK_STALL_TIMEOUT;
 module_param(rcu_task_stall_timeout, int, 0644);
 
-static struct task_struct *rcu_tasks_kthread_ptr;
-
 /**
  * call_rcu_tasks() - Queue an RCU for invocation task-based grace period
  * @rhp: structure to be used for queueing the RCU updates.
@@ -57,17 +74,18 @@ void call_rcu_tasks(struct rcu_head *rhp, rcu_callback_t func)
 {
 	unsigned long flags;
 	bool needwake;
+	struct rcu_tasks *rtp = &rcu_tasks;
 
 	rhp->next = NULL;
 	rhp->func = func;
-	raw_spin_lock_irqsave(&rcu_tasks_cbs_lock, flags);
-	needwake = !rcu_tasks_cbs_head;
-	WRITE_ONCE(*rcu_tasks_cbs_tail, rhp);
-	rcu_tasks_cbs_tail = &rhp->next;
-	raw_spin_unlock_irqrestore(&rcu_tasks_cbs_lock, flags);
+	raw_spin_lock_irqsave(&rtp->cbs_lock, flags);
+	needwake = !rtp->cbs_head;
+	WRITE_ONCE(*rtp->cbs_tail, rhp);
+	rtp->cbs_tail = &rhp->next;
+	raw_spin_unlock_irqrestore(&rtp->cbs_lock, flags);
 	/* We can't create the thread unless interrupts are enabled. */
-	if (needwake && READ_ONCE(rcu_tasks_kthread_ptr))
-		wake_up(&rcu_tasks_cbs_wq);
+	if (needwake && READ_ONCE(rtp->kthread_ptr))
+		wake_up(&rtp->cbs_wq);
 }
 EXPORT_SYMBOL_GPL(call_rcu_tasks);
 
@@ -169,10 +187,12 @@ static int __noreturn rcu_tasks_kthread(void *arg)
 	struct rcu_head *list;
 	struct rcu_head *next;
 	LIST_HEAD(rcu_tasks_holdouts);
+	struct rcu_tasks *rtp = arg;
 	int fract;
 
 	/* Run on housekeeping CPUs by default.  Sysadm can move if desired. */
 	housekeeping_affine(current, HK_FLAG_RCU);
+	WRITE_ONCE(rtp->kthread_ptr, current); // Let GPs start!
 
 	/*
 	 * Each pass through the following loop makes one check for
@@ -183,17 +203,17 @@ static int __noreturn rcu_tasks_kthread(void *arg)
 	for (;;) {
 
 		/* Pick up any new callbacks. */
-		raw_spin_lock_irqsave(&rcu_tasks_cbs_lock, flags);
-		list = rcu_tasks_cbs_head;
-		rcu_tasks_cbs_head = NULL;
-		rcu_tasks_cbs_tail = &rcu_tasks_cbs_head;
-		raw_spin_unlock_irqrestore(&rcu_tasks_cbs_lock, flags);
+		raw_spin_lock_irqsave(&rtp->cbs_lock, flags);
+		list = rtp->cbs_head;
+		rtp->cbs_head = NULL;
+		rtp->cbs_tail = &rtp->cbs_head;
+		raw_spin_unlock_irqrestore(&rtp->cbs_lock, flags);
 
 		/* If there were none, wait a bit and start over. */
 		if (!list) {
-			wait_event_interruptible(rcu_tasks_cbs_wq,
-						 READ_ONCE(rcu_tasks_cbs_head));
-			if (!rcu_tasks_cbs_head) {
+			wait_event_interruptible(rtp->cbs_wq,
+						 READ_ONCE(rtp->cbs_head));
+			if (!rtp->cbs_head) {
 				WARN_ON(signal_pending(current));
 				schedule_timeout_interruptible(HZ/10);
 			}
@@ -211,7 +231,7 @@ static int __noreturn rcu_tasks_kthread(void *arg)
 		 *
 		 * This synchronize_rcu() also dispenses with the
 		 * need for a memory barrier on the first store to
-		 * ->rcu_tasks_holdout, as it forces the store to happen
+		 * t->rcu_tasks_holdout, as it forces the store to happen
 		 * after the beginning of the grace period.
 		 */
 		synchronize_rcu();
@@ -278,7 +298,7 @@ static int __noreturn rcu_tasks_kthread(void *arg)
 			firstreport = true;
 			WARN_ON(signal_pending(current));
 			list_for_each_entry_safe(t, t1, &rcu_tasks_holdouts,
-						rcu_tasks_holdout_list) {
+						 rcu_tasks_holdout_list) {
 				check_holdout_task(t, needreport, &firstreport);
 				cond_resched();
 			}
@@ -325,11 +345,10 @@ static int __init rcu_spawn_tasks_kthread(void)
 {
 	struct task_struct *t;
 
-	t = kthread_run(rcu_tasks_kthread, NULL, "rcu_tasks_kthread");
+	t = kthread_run(rcu_tasks_kthread, &rcu_tasks, "rcu_tasks_kthread");
 	if (WARN_ONCE(IS_ERR(t), "%s: Could not start Tasks-RCU grace-period kthread, OOM is now expected behavior\n", __func__))
 		return 0;
 	smp_mb(); /* Ensure others see full kthread. */
-	WRITE_ONCE(rcu_tasks_kthread_ptr, t);
 	return 0;
 }
 core_initcall(rcu_spawn_tasks_kthread);
