Return-Path: <SRS0=IaiW=7B=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.8 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B6524C433E0
	for <linux-kernel@archiver.kernel.org>; Tue, 19 May 2020 19:52:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7FDA02075F
	for <linux-kernel@archiver.kernel.org>; Tue, 19 May 2020 19:52:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726999AbgESTwl (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 19 May 2020 15:52:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50972 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726333AbgESTwk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 May 2020 15:52:40 -0400
Received: from Galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E27D0C08C5C0;
        Tue, 19 May 2020 12:52:39 -0700 (PDT)
Received: from [5.158.153.53] (helo=tip-bot2.lab.linutronix.de)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tip-bot2@linutronix.de>)
        id 1jb8Hx-0007pE-G7; Tue, 19 May 2020 21:52:33 +0200
Received: from [127.0.1.1] (localhost [IPv6:::1])
        by tip-bot2.lab.linutronix.de (Postfix) with ESMTP id 14D2D1C047E;
        Tue, 19 May 2020 21:52:33 +0200 (CEST)
Date:   Tue, 19 May 2020 19:52:33 -0000
From:   "tip-bot2 for Thomas Gleixner" <tip-bot2@linutronix.de>
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: core/rcu] rcu/tree: Mark the idle relevant functions noinstr
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Alexandre Chartre <alexandre.chartre@oracle.com>,
        Peter Zijlstra <peterz@infradead.org>,
        "Paul E. McKenney" <paulmck@kernel.org>, x86 <x86@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
In-Reply-To: <20200505134100.575356107@linutronix.de>
References: <20200505134100.575356107@linutronix.de>
MIME-Version: 1.0
Message-ID: <158991795300.17951.11897222265664137612.tip-bot2@tip-bot2>
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

Commit-ID:     ff5c4f5cad33061b07c3fb9187506783c0f3cb66
Gitweb:        https://git.kernel.org/tip/ff5c4f5cad33061b07c3fb9187506783c0f3cb66
Author:        Thomas Gleixner <tglx@linutronix.de>
AuthorDate:    Fri, 13 Mar 2020 17:32:17 +01:00
Committer:     Thomas Gleixner <tglx@linutronix.de>
CommitterDate: Tue, 19 May 2020 15:51:20 +02:00

rcu/tree: Mark the idle relevant functions noinstr

These functions are invoked from context tracking and other places in the
low level entry code. Move them into the .noinstr.text section to exclude
them from instrumentation.

Mark the places which are safe to invoke traceable functions with
instrumentation_begin/end() so objtool won't complain.

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Reviewed-by: Alexandre Chartre <alexandre.chartre@oracle.com>
Acked-by: Peter Zijlstra <peterz@infradead.org>
Acked-by: Paul E. McKenney <paulmck@kernel.org>
Link: https://lkml.kernel.org/r/20200505134100.575356107@linutronix.de


---
 kernel/rcu/tree.c        | 83 +++++++++++++++++++++------------------
 kernel/rcu/tree_plugin.h |  4 +-
 kernel/rcu/update.c      |  3 +-
 3 files changed, 49 insertions(+), 41 deletions(-)

diff --git a/kernel/rcu/tree.c b/kernel/rcu/tree.c
index f288477..0713ef3 100644
--- a/kernel/rcu/tree.c
+++ b/kernel/rcu/tree.c
@@ -88,9 +88,6 @@
  */
 #define RCU_DYNTICK_CTRL_MASK 0x1
 #define RCU_DYNTICK_CTRL_CTR  (RCU_DYNTICK_CTRL_MASK + 1)
-#ifndef rcu_eqs_special_exit
-#define rcu_eqs_special_exit() do { } while (0)
-#endif
 
 static DEFINE_PER_CPU_SHARED_ALIGNED(struct rcu_data, rcu_data) = {
 	.dynticks_nesting = 1,
@@ -242,7 +239,7 @@ void rcu_softirq_qs(void)
  * RCU is watching prior to the call to this function and is no longer
  * watching upon return.
  */
-static void rcu_dynticks_eqs_enter(void)
+static noinstr void rcu_dynticks_eqs_enter(void)
 {
 	struct rcu_data *rdp = this_cpu_ptr(&rcu_data);
 	int seq;
@@ -267,7 +264,7 @@ static void rcu_dynticks_eqs_enter(void)
  * called from an extended quiescent state, that is, RCU is not watching
  * prior to the call to this function and is watching upon return.
  */
-static void rcu_dynticks_eqs_exit(void)
+static noinstr void rcu_dynticks_eqs_exit(void)
 {
 	struct rcu_data *rdp = this_cpu_ptr(&rcu_data);
 	int seq;
@@ -285,8 +282,6 @@ static void rcu_dynticks_eqs_exit(void)
 	if (seq & RCU_DYNTICK_CTRL_MASK) {
 		atomic_andnot(RCU_DYNTICK_CTRL_MASK, &rdp->dynticks);
 		smp_mb__after_atomic(); /* _exit after clearing mask. */
-		/* Prefer duplicate flushes to losing a flush. */
-		rcu_eqs_special_exit();
 	}
 }
 
@@ -314,7 +309,7 @@ static void rcu_dynticks_eqs_online(void)
  *
  * No ordering, as we are sampling CPU-local information.
  */
-static bool rcu_dynticks_curr_cpu_in_eqs(void)
+static __always_inline bool rcu_dynticks_curr_cpu_in_eqs(void)
 {
 	struct rcu_data *rdp = this_cpu_ptr(&rcu_data);
 
@@ -603,7 +598,7 @@ EXPORT_SYMBOL_GPL(rcutorture_get_gp_data);
  * the possibility of usermode upcalls having messed up our count
  * of interrupt nesting level during the prior busy period.
  */
-static void rcu_eqs_enter(bool user)
+static noinstr void rcu_eqs_enter(bool user)
 {
 	struct rcu_data *rdp = this_cpu_ptr(&rcu_data);
 
@@ -618,12 +613,14 @@ static void rcu_eqs_enter(bool user)
 	}
 
 	lockdep_assert_irqs_disabled();
+	instrumentation_begin();
 	trace_rcu_dyntick(TPS("Start"), rdp->dynticks_nesting, 0, atomic_read(&rdp->dynticks));
 	WARN_ON_ONCE(IS_ENABLED(CONFIG_RCU_EQS_DEBUG) && !user && !is_idle_task(current));
 	rdp = this_cpu_ptr(&rcu_data);
 	do_nocb_deferred_wakeup(rdp);
 	rcu_prepare_for_idle();
 	rcu_preempt_deferred_qs(current);
+	instrumentation_end();
 	WRITE_ONCE(rdp->dynticks_nesting, 0); /* Avoid irq-access tearing. */
 	// RCU is watching here ...
 	rcu_dynticks_eqs_enter();
@@ -660,7 +657,7 @@ void rcu_idle_enter(void)
  * If you add or remove a call to rcu_user_enter(), be sure to test with
  * CONFIG_RCU_EQS_DEBUG=y.
  */
-void rcu_user_enter(void)
+noinstr void rcu_user_enter(void)
 {
 	lockdep_assert_irqs_disabled();
 	rcu_eqs_enter(true);
@@ -693,19 +690,23 @@ static __always_inline void rcu_nmi_exit_common(bool irq)
 	 * leave it in non-RCU-idle state.
 	 */
 	if (rdp->dynticks_nmi_nesting != 1) {
+		instrumentation_begin();
 		trace_rcu_dyntick(TPS("--="), rdp->dynticks_nmi_nesting, rdp->dynticks_nmi_nesting - 2,
 				  atomic_read(&rdp->dynticks));
 		WRITE_ONCE(rdp->dynticks_nmi_nesting, /* No store tearing. */
 			   rdp->dynticks_nmi_nesting - 2);
+		instrumentation_end();
 		return;
 	}
 
+	instrumentation_begin();
 	/* This NMI interrupted an RCU-idle CPU, restore RCU-idleness. */
 	trace_rcu_dyntick(TPS("Startirq"), rdp->dynticks_nmi_nesting, 0, atomic_read(&rdp->dynticks));
 	WRITE_ONCE(rdp->dynticks_nmi_nesting, 0); /* Avoid store tearing. */
 
 	if (irq)
 		rcu_prepare_for_idle();
+	instrumentation_end();
 
 	// RCU is watching here ...
 	rcu_dynticks_eqs_enter();
@@ -721,7 +722,7 @@ static __always_inline void rcu_nmi_exit_common(bool irq)
  * If you add or remove a call to rcu_nmi_exit(), be sure to test
  * with CONFIG_RCU_EQS_DEBUG=y.
  */
-void rcu_nmi_exit(void)
+void noinstr rcu_nmi_exit(void)
 {
 	rcu_nmi_exit_common(false);
 }
@@ -745,7 +746,7 @@ void rcu_nmi_exit(void)
  * If you add or remove a call to rcu_irq_exit(), be sure to test with
  * CONFIG_RCU_EQS_DEBUG=y.
  */
-void rcu_irq_exit(void)
+void noinstr rcu_irq_exit(void)
 {
 	lockdep_assert_irqs_disabled();
 	rcu_nmi_exit_common(true);
@@ -774,7 +775,7 @@ void rcu_irq_exit_irqson(void)
  * allow for the possibility of usermode upcalls messing up our count of
  * interrupt nesting level during the busy period that is just now starting.
  */
-static void rcu_eqs_exit(bool user)
+static void noinstr rcu_eqs_exit(bool user)
 {
 	struct rcu_data *rdp;
 	long oldval;
@@ -792,12 +793,14 @@ static void rcu_eqs_exit(bool user)
 	// RCU is not watching here ...
 	rcu_dynticks_eqs_exit();
 	// ... but is watching here.
+	instrumentation_begin();
 	rcu_cleanup_after_idle();
 	trace_rcu_dyntick(TPS("End"), rdp->dynticks_nesting, 1, atomic_read(&rdp->dynticks));
 	WARN_ON_ONCE(IS_ENABLED(CONFIG_RCU_EQS_DEBUG) && !user && !is_idle_task(current));
 	WRITE_ONCE(rdp->dynticks_nesting, 1);
 	WARN_ON_ONCE(rdp->dynticks_nmi_nesting);
 	WRITE_ONCE(rdp->dynticks_nmi_nesting, DYNTICK_IRQ_NONIDLE);
+	instrumentation_end();
 }
 
 /**
@@ -828,7 +831,7 @@ void rcu_idle_exit(void)
  * If you add or remove a call to rcu_user_exit(), be sure to test with
  * CONFIG_RCU_EQS_DEBUG=y.
  */
-void rcu_user_exit(void)
+void noinstr rcu_user_exit(void)
 {
 	rcu_eqs_exit(1);
 }
@@ -876,28 +879,35 @@ static __always_inline void rcu_nmi_enter_common(bool irq)
 			rcu_cleanup_after_idle();
 
 		incby = 1;
-	} else if (irq && tick_nohz_full_cpu(rdp->cpu) &&
-		   rdp->dynticks_nmi_nesting == DYNTICK_IRQ_NONIDLE &&
-		   READ_ONCE(rdp->rcu_urgent_qs) &&
-		   !READ_ONCE(rdp->rcu_forced_tick)) {
-		// We get here only if we had already exited the extended
-		// quiescent state and this was an interrupt (not an NMI).
-		// Therefore, (1) RCU is already watching and (2) The fact
-		// that we are in an interrupt handler and that the rcu_node
-		// lock is an irq-disabled lock prevents self-deadlock.
-		// So we can safely recheck under the lock.
-		raw_spin_lock_rcu_node(rdp->mynode);
-		if (rdp->rcu_urgent_qs && !rdp->rcu_forced_tick) {
-			// A nohz_full CPU is in the kernel and RCU
-			// needs a quiescent state.  Turn on the tick!
-			WRITE_ONCE(rdp->rcu_forced_tick, true);
-			tick_dep_set_cpu(rdp->cpu, TICK_DEP_BIT_RCU);
+	} else if (irq) {
+		instrumentation_begin();
+		if (tick_nohz_full_cpu(rdp->cpu) &&
+		    rdp->dynticks_nmi_nesting == DYNTICK_IRQ_NONIDLE &&
+		    READ_ONCE(rdp->rcu_urgent_qs) &&
+		    !READ_ONCE(rdp->rcu_forced_tick)) {
+			// We get here only if we had already exited the
+			// extended quiescent state and this was an
+			// interrupt (not an NMI).  Therefore, (1) RCU is
+			// already watching and (2) The fact that we are in
+			// an interrupt handler and that the rcu_node lock
+			// is an irq-disabled lock prevents self-deadlock.
+			// So we can safely recheck under the lock.
+			raw_spin_lock_rcu_node(rdp->mynode);
+			if (rdp->rcu_urgent_qs && !rdp->rcu_forced_tick) {
+				// A nohz_full CPU is in the kernel and RCU
+				// needs a quiescent state.  Turn on the tick!
+				WRITE_ONCE(rdp->rcu_forced_tick, true);
+				tick_dep_set_cpu(rdp->cpu, TICK_DEP_BIT_RCU);
+			}
+			raw_spin_unlock_rcu_node(rdp->mynode);
 		}
-		raw_spin_unlock_rcu_node(rdp->mynode);
+		instrumentation_end();
 	}
+	instrumentation_begin();
 	trace_rcu_dyntick(incby == 1 ? TPS("Endirq") : TPS("++="),
 			  rdp->dynticks_nmi_nesting,
 			  rdp->dynticks_nmi_nesting + incby, atomic_read(&rdp->dynticks));
+	instrumentation_end();
 	WRITE_ONCE(rdp->dynticks_nmi_nesting, /* Prevent store tearing. */
 		   rdp->dynticks_nmi_nesting + incby);
 	barrier();
@@ -906,11 +916,10 @@ static __always_inline void rcu_nmi_enter_common(bool irq)
 /**
  * rcu_nmi_enter - inform RCU of entry to NMI context
  */
-void rcu_nmi_enter(void)
+noinstr void rcu_nmi_enter(void)
 {
 	rcu_nmi_enter_common(false);
 }
-NOKPROBE_SYMBOL(rcu_nmi_enter);
 
 /**
  * rcu_irq_enter - inform RCU that current CPU is entering irq away from idle
@@ -934,7 +943,7 @@ NOKPROBE_SYMBOL(rcu_nmi_enter);
  * If you add or remove a call to rcu_irq_enter(), be sure to test with
  * CONFIG_RCU_EQS_DEBUG=y.
  */
-void rcu_irq_enter(void)
+noinstr void rcu_irq_enter(void)
 {
 	lockdep_assert_irqs_disabled();
 	rcu_nmi_enter_common(true);
@@ -979,7 +988,7 @@ static void rcu_disable_urgency_upon_qs(struct rcu_data *rdp)
  * if the current CPU is not in its idle loop or is in an interrupt or
  * NMI handler, return true.
  */
-bool notrace rcu_is_watching(void)
+bool rcu_is_watching(void)
 {
 	bool ret;
 
@@ -1031,12 +1040,12 @@ bool rcu_lockdep_current_cpu_online(void)
 
 	if (in_nmi() || !rcu_scheduler_fully_active)
 		return true;
-	preempt_disable();
+	preempt_disable_notrace();
 	rdp = this_cpu_ptr(&rcu_data);
 	rnp = rdp->mynode;
 	if (rdp->grpmask & rcu_rnp_online_cpus(rnp))
 		ret = true;
-	preempt_enable();
+	preempt_enable_notrace();
 	return ret;
 }
 EXPORT_SYMBOL_GPL(rcu_lockdep_current_cpu_online);
diff --git a/kernel/rcu/tree_plugin.h b/kernel/rcu/tree_plugin.h
index 50caa3f..3522236 100644
--- a/kernel/rcu/tree_plugin.h
+++ b/kernel/rcu/tree_plugin.h
@@ -2539,7 +2539,7 @@ static void rcu_bind_gp_kthread(void)
 }
 
 /* Record the current task on dyntick-idle entry. */
-static void rcu_dynticks_task_enter(void)
+static void noinstr rcu_dynticks_task_enter(void)
 {
 #if defined(CONFIG_TASKS_RCU) && defined(CONFIG_NO_HZ_FULL)
 	WRITE_ONCE(current->rcu_tasks_idle_cpu, smp_processor_id());
@@ -2547,7 +2547,7 @@ static void rcu_dynticks_task_enter(void)
 }
 
 /* Record no current task on dyntick-idle exit. */
-static void rcu_dynticks_task_exit(void)
+static void noinstr rcu_dynticks_task_exit(void)
 {
 #if defined(CONFIG_TASKS_RCU) && defined(CONFIG_NO_HZ_FULL)
 	WRITE_ONCE(current->rcu_tasks_idle_cpu, -1);
diff --git a/kernel/rcu/update.c b/kernel/rcu/update.c
index 3ce63a9..84843ad 100644
--- a/kernel/rcu/update.c
+++ b/kernel/rcu/update.c
@@ -284,13 +284,12 @@ struct lockdep_map rcu_callback_map =
 	STATIC_LOCKDEP_MAP_INIT("rcu_callback", &rcu_callback_key);
 EXPORT_SYMBOL_GPL(rcu_callback_map);
 
-int notrace debug_lockdep_rcu_enabled(void)
+noinstr int notrace debug_lockdep_rcu_enabled(void)
 {
 	return rcu_scheduler_active != RCU_SCHEDULER_INACTIVE && debug_locks &&
 	       current->lockdep_recursion == 0;
 }
 EXPORT_SYMBOL_GPL(debug_lockdep_rcu_enabled);
-NOKPROBE_SYMBOL(debug_lockdep_rcu_enabled);
 
 /**
  * rcu_read_lock_held() - might we be in RCU read-side critical section?
