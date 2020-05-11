Return-Path: <SRS0=ABJN=6Z=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.8 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DB220C54E4B
	for <linux-kernel@archiver.kernel.org>; Mon, 11 May 2020 20:59:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C171124981
	for <linux-kernel@archiver.kernel.org>; Mon, 11 May 2020 20:59:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732000AbgEKU7u (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 11 May 2020 16:59:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43982 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1731893AbgEKU7e (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 May 2020 16:59:34 -0400
Received: from Galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BE4D2C061A0C;
        Mon, 11 May 2020 13:59:34 -0700 (PDT)
Received: from [5.158.153.53] (helo=tip-bot2.lab.linutronix.de)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tip-bot2@linutronix.de>)
        id 1jYFWN-0005mM-F1; Mon, 11 May 2020 22:59:31 +0200
Received: from [127.0.1.1] (localhost [IPv6:::1])
        by tip-bot2.lab.linutronix.de (Postfix) with ESMTP id C1EC71C07B4;
        Mon, 11 May 2020 22:59:25 +0200 (CEST)
Date:   Mon, 11 May 2020 20:59:25 -0000
From:   "tip-bot2 for Paul E. McKenney" <tip-bot2@linutronix.de>
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: core/rcu] rcu-tasks: Avoid IPIing userspace/idle tasks if
 kernel is so built
Cc:     Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        "Paul E. McKenney" <paulmck@kernel.org>, x86 <x86@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <158923076568.390.6166862966280462110.tip-bot2@tip-bot2>
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

Commit-ID:     7d0c9c50c5a109acd7a5cf589fc5563f9ef7149a
Gitweb:        https://git.kernel.org/tip/7d0c9c50c5a109acd7a5cf589fc5563f9ef7149a
Author:        Paul E. McKenney <paulmck@kernel.org>
AuthorDate:    Thu, 19 Mar 2020 15:33:12 -07:00
Committer:     Paul E. McKenney <paulmck@kernel.org>
CommitterDate: Mon, 27 Apr 2020 11:03:52 -07:00

rcu-tasks: Avoid IPIing userspace/idle tasks if kernel is so built

Systems running CPU-bound real-time task do not want IPIs sent to CPUs
executing nohz_full userspace tasks.  Battery-powered systems don't
want IPIs sent to idle CPUs in low-power mode.  Unfortunately, RCU tasks
trace can and will send such IPIs in some cases.

Both of these situations occur only when the target CPU is in RCU
dyntick-idle mode, in other words, when RCU is not watching the
target CPU.  This suggests that CPUs in dyntick-idle mode should use
memory barriers in outermost invocations of rcu_read_lock_trace()
and rcu_read_unlock_trace(), which would allow the RCU tasks trace
grace period to directly read out the target CPU's read-side state.
One challenge is that RCU tasks trace is not targeting a specific
CPU, but rather a task.  And that task could switch from one CPU to
another at any time.

This commit therefore uses try_invoke_on_locked_down_task()
and checks for task_curr() in trc_inspect_reader_notrunning().
When this condition holds, the target task is running and cannot move.
If CONFIG_TASKS_TRACE_RCU_READ_MB=y, the new rcu_dynticks_zero_in_eqs()
function can be used to check if the specified integer (in this case,
t->trc_reader_nesting) is zero while the target CPU remains in that same
dyntick-idle sojourn.  If so, the target task is in a quiescent state.
If not, trc_read_check_handler() must indicate failure so that the
grace-period kthread can take appropriate action or retry after an
appropriate delay, as the case may be.

With this change, given CONFIG_TASKS_TRACE_RCU_READ_MB=y, if a given
CPU remains idle or a given task continues executing in nohz_full mode,
the RCU tasks trace grace-period kthread will detect this without the
need to send an IPI.

Suggested-by: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
---
 kernel/rcu/rcu.h         |  2 ++
 kernel/rcu/tasks.h       | 36 ++++++++++++++++++++++++++----------
 kernel/rcu/tree.c        | 24 ++++++++++++++++++++++++
 kernel/rcu/tree.h        |  2 ++
 kernel/rcu/tree_plugin.h | 18 ++++++++++++++++++
 5 files changed, 72 insertions(+), 10 deletions(-)

diff --git a/kernel/rcu/rcu.h b/kernel/rcu/rcu.h
index e1089fd..296f926 100644
--- a/kernel/rcu/rcu.h
+++ b/kernel/rcu/rcu.h
@@ -501,6 +501,7 @@ void srcutorture_get_gp_data(enum rcutorture_type test_type,
 #endif
 
 #ifdef CONFIG_TINY_RCU
+static inline bool rcu_dynticks_zero_in_eqs(int cpu, int *vp) { return false; }
 static inline unsigned long rcu_get_gp_seq(void) { return 0; }
 static inline unsigned long rcu_exp_batches_completed(void) { return 0; }
 static inline unsigned long
@@ -510,6 +511,7 @@ static inline void show_rcu_gp_kthreads(void) { }
 static inline int rcu_get_gp_kthreads_prio(void) { return 0; }
 static inline void rcu_fwd_progress_check(unsigned long j) { }
 #else /* #ifdef CONFIG_TINY_RCU */
+bool rcu_dynticks_zero_in_eqs(int cpu, int *vp);
 unsigned long rcu_get_gp_seq(void);
 unsigned long rcu_exp_batches_completed(void);
 unsigned long srcu_batches_completed(struct srcu_struct *sp);
diff --git a/kernel/rcu/tasks.h b/kernel/rcu/tasks.h
index 4147857..a9e8ecb 100644
--- a/kernel/rcu/tasks.h
+++ b/kernel/rcu/tasks.h
@@ -806,22 +806,38 @@ reset_ipi:
 /* Callback function for scheduler to check locked-down task.  */
 static bool trc_inspect_reader(struct task_struct *t, void *arg)
 {
-	if (task_curr(t))
-		return false;  // It is running, so decline to inspect it.
+	int cpu = task_cpu(t);
+	bool in_qs = false;
+
+	if (task_curr(t)) {
+		// If no chance of heavyweight readers, do it the hard way.
+		if (!IS_ENABLED(CONFIG_TASKS_TRACE_RCU_READ_MB))
+			return false;
+
+		// If heavyweight readers are enabled on the remote task,
+		// we can inspect its state despite its currently running.
+		// However, we cannot safely change its state.
+		if (!rcu_dynticks_zero_in_eqs(cpu, &t->trc_reader_nesting))
+			return false; // No quiescent state, do it the hard way.
+		in_qs = true;
+	} else {
+		in_qs = likely(!t->trc_reader_nesting);
+	}
 
 	// Mark as checked.  Because this is called from the grace-period
 	// kthread, also remove the task from the holdout list.
 	t->trc_reader_checked = true;
 	trc_del_holdout(t);
 
-	// If the task is in a read-side critical section, set up its
-	// its state so that it will awaken the grace-period kthread upon
-	// exit from that critical section.
-	if (unlikely(t->trc_reader_nesting)) {
-		atomic_inc(&trc_n_readers_need_end); // One more to wait on.
-		WARN_ON_ONCE(t->trc_reader_special.b.need_qs);
-		WRITE_ONCE(t->trc_reader_special.b.need_qs, true);
-	}
+	if (in_qs)
+		return true;  // Already in quiescent state, done!!!
+
+	// The task is in a read-side critical section, so set up its
+	// state so that it will awaken the grace-period kthread upon exit
+	// from that critical section.
+	atomic_inc(&trc_n_readers_need_end); // One more to wait on.
+	WARN_ON_ONCE(t->trc_reader_special.b.need_qs);
+	WRITE_ONCE(t->trc_reader_special.b.need_qs, true);
 	return true;
 }
 
diff --git a/kernel/rcu/tree.c b/kernel/rcu/tree.c
index 0bbcbf3..573fd78 100644
--- a/kernel/rcu/tree.c
+++ b/kernel/rcu/tree.c
@@ -252,6 +252,7 @@ static void rcu_dynticks_eqs_enter(void)
 	 * critical sections, and we also must force ordering with the
 	 * next idle sojourn.
 	 */
+	rcu_dynticks_task_trace_enter();  // Before ->dynticks update!
 	seq = atomic_add_return(RCU_DYNTICK_CTRL_CTR, &rdp->dynticks);
 	// RCU is no longer watching.  Better be in extended quiescent state!
 	WARN_ON_ONCE(IS_ENABLED(CONFIG_RCU_EQS_DEBUG) &&
@@ -278,6 +279,7 @@ static void rcu_dynticks_eqs_exit(void)
 	 */
 	seq = atomic_add_return(RCU_DYNTICK_CTRL_CTR, &rdp->dynticks);
 	// RCU is now watching.  Better not be in an extended quiescent state!
+	rcu_dynticks_task_trace_exit();  // After ->dynticks update!
 	WARN_ON_ONCE(IS_ENABLED(CONFIG_RCU_EQS_DEBUG) &&
 		     !(seq & RCU_DYNTICK_CTRL_CTR));
 	if (seq & RCU_DYNTICK_CTRL_MASK) {
@@ -350,6 +352,28 @@ static bool rcu_dynticks_in_eqs_since(struct rcu_data *rdp, int snap)
 }
 
 /*
+ * Return true if the referenced integer is zero while the specified
+ * CPU remains within a single extended quiescent state.
+ */
+bool rcu_dynticks_zero_in_eqs(int cpu, int *vp)
+{
+	struct rcu_data *rdp = per_cpu_ptr(&rcu_data, cpu);
+	int snap;
+
+	// If not quiescent, force back to earlier extended quiescent state.
+	snap = atomic_read(&rdp->dynticks) & ~(RCU_DYNTICK_CTRL_MASK |
+					       RCU_DYNTICK_CTRL_CTR);
+
+	smp_rmb(); // Order ->dynticks and *vp reads.
+	if (READ_ONCE(*vp))
+		return false;  // Non-zero, so report failure;
+	smp_rmb(); // Order *vp read and ->dynticks re-read.
+
+	// If still in the same extended quiescent state, we are good!
+	return snap == (atomic_read(&rdp->dynticks) & ~RCU_DYNTICK_CTRL_MASK);
+}
+
+/*
  * Set the special (bottom) bit of the specified CPU so that it
  * will take special action (such as flushing its TLB) on the
  * next exit from an extended quiescent state.  Returns true if
diff --git a/kernel/rcu/tree.h b/kernel/rcu/tree.h
index 9dc2ec0..29ba799 100644
--- a/kernel/rcu/tree.h
+++ b/kernel/rcu/tree.h
@@ -454,6 +454,8 @@ static void rcu_bind_gp_kthread(void);
 static bool rcu_nohz_full_cpu(void);
 static void rcu_dynticks_task_enter(void);
 static void rcu_dynticks_task_exit(void);
+static void rcu_dynticks_task_trace_enter(void);
+static void rcu_dynticks_task_trace_exit(void);
 
 /* Forward declarations for tree_stall.h */
 static void record_gp_stall_check_time(void);
diff --git a/kernel/rcu/tree_plugin.h b/kernel/rcu/tree_plugin.h
index 37e0281..4cef7e3 100644
--- a/kernel/rcu/tree_plugin.h
+++ b/kernel/rcu/tree_plugin.h
@@ -2552,3 +2552,21 @@ static void rcu_dynticks_task_exit(void)
 	WRITE_ONCE(current->rcu_tasks_idle_cpu, -1);
 #endif /* #if defined(CONFIG_TASKS_RCU) && defined(CONFIG_NO_HZ_FULL) */
 }
+
+/* Turn on heavyweight RCU tasks trace readers on idle/user entry. */
+static void rcu_dynticks_task_trace_enter(void)
+{
+#ifdef CONFIG_TASKS_RCU_TRACE
+	if (IS_ENABLED(CONFIG_TASKS_TRACE_RCU_READ_MB))
+		current->trc_reader_special.b.need_mb = true;
+#endif /* #ifdef CONFIG_TASKS_RCU_TRACE */
+}
+
+/* Turn off heavyweight RCU tasks trace readers on idle/user exit. */
+static void rcu_dynticks_task_trace_exit(void)
+{
+#ifdef CONFIG_TASKS_RCU_TRACE
+	if (IS_ENABLED(CONFIG_TASKS_TRACE_RCU_READ_MB))
+		current->trc_reader_special.b.need_mb = false;
+#endif /* #ifdef CONFIG_TASKS_RCU_TRACE */
+}
