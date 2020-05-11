Return-Path: <SRS0=ABJN=6Z=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.8 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 24ACCC54E4B
	for <linux-kernel@archiver.kernel.org>; Mon, 11 May 2020 21:03:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 010B92078A
	for <linux-kernel@archiver.kernel.org>; Mon, 11 May 2020 21:03:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732489AbgEKVDx (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 11 May 2020 17:03:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44042 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1731978AbgEKU7p (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 May 2020 16:59:45 -0400
Received: from Galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BF6F9C061A0E;
        Mon, 11 May 2020 13:59:45 -0700 (PDT)
Received: from [5.158.153.53] (helo=tip-bot2.lab.linutronix.de)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tip-bot2@linutronix.de>)
        id 1jYFWY-0005s3-KJ; Mon, 11 May 2020 22:59:42 +0200
Received: from [127.0.1.1] (localhost [IPv6:::1])
        by tip-bot2.lab.linutronix.de (Postfix) with ESMTP id B675A1C07F8;
        Mon, 11 May 2020 22:59:32 +0200 (CEST)
Date:   Mon, 11 May 2020 20:59:32 -0000
From:   "tip-bot2 for Paul E. McKenney" <tip-bot2@linutronix.de>
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: core/rcu] rcu-tasks: Add an RCU-tasks rude variant
Cc:     Steven Rostedt <rostedt@goodmis.org>,
        "Paul E. McKenney" <paulmck@kernel.org>, x86 <x86@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <158923077261.390.5180423158279992234.tip-bot2@tip-bot2>
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

Commit-ID:     c84aad765406c4c7573ce449e8a9977ebb8f4cb9
Gitweb:        https://git.kernel.org/tip/c84aad765406c4c7573ce449e8a9977ebb8f4cb9
Author:        Paul E. McKenney <paulmck@kernel.org>
AuthorDate:    Mon, 02 Mar 2020 21:06:43 -08:00
Committer:     Paul E. McKenney <paulmck@kernel.org>
CommitterDate: Mon, 27 Apr 2020 11:03:51 -07:00

rcu-tasks: Add an RCU-tasks rude variant

This commit adds a "rude" variant of RCU-tasks that has as quiescent
states schedule(), cond_resched_tasks_rcu_qs(), userspace execution,
and (in theory, anyway) cond_resched().  In other words, RCU-tasks rude
readers are regions of code with preemption disabled, but excluding code
early in the CPU-online sequence and late in the CPU-offline sequence.
Updates make use of IPIs and force an IPI and a context switch on each
online CPU.  This variant is useful in some situations in tracing.

Suggested-by: Steven Rostedt <rostedt@goodmis.org>
[ paulmck: Apply EXPORT_SYMBOL_GPL() feedback from Qiujun Huang. ]
Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
[ paulmck: Apply review feedback from Steve Rostedt. ]
---
 include/linux/rcupdate.h |  3 +-
 kernel/rcu/Kconfig       | 11 +++-
 kernel/rcu/tasks.h       | 98 +++++++++++++++++++++++++++++++++++++++-
 3 files changed, 111 insertions(+), 1 deletion(-)

diff --git a/include/linux/rcupdate.h b/include/linux/rcupdate.h
index 5523145..2be97a8 100644
--- a/include/linux/rcupdate.h
+++ b/include/linux/rcupdate.h
@@ -37,6 +37,7 @@
 /* Exported common interfaces */
 void call_rcu(struct rcu_head *head, rcu_callback_t func);
 void rcu_barrier_tasks(void);
+void rcu_barrier_tasks_rude(void);
 void synchronize_rcu(void);
 
 #ifdef CONFIG_PREEMPT_RCU
@@ -138,6 +139,8 @@ static inline void rcu_init_nohz(void) { }
 #define rcu_note_voluntary_context_switch(t) rcu_tasks_qs(t)
 void call_rcu_tasks(struct rcu_head *head, rcu_callback_t func);
 void synchronize_rcu_tasks(void);
+void call_rcu_tasks_rude(struct rcu_head *head, rcu_callback_t func);
+void synchronize_rcu_tasks_rude(void);
 void exit_tasks_rcu_start(void);
 void exit_tasks_rcu_finish(void);
 #else /* #ifdef CONFIG_TASKS_RCU_GENERIC */
diff --git a/kernel/rcu/Kconfig b/kernel/rcu/Kconfig
index 38475d0..6ee6372 100644
--- a/kernel/rcu/Kconfig
+++ b/kernel/rcu/Kconfig
@@ -71,7 +71,7 @@ config TREE_SRCU
 	  This option selects the full-fledged version of SRCU.
 
 config TASKS_RCU_GENERIC
-	def_bool TASKS_RCU
+	def_bool TASKS_RCU || TASKS_RUDE_RCU
 	select SRCU
 	help
 	  This option enables generic infrastructure code supporting
@@ -84,6 +84,15 @@ config TASKS_RCU
 	  only voluntary context switch (not preemption!), idle, and
 	  user-mode execution as quiescent states.  Not for manual selection.
 
+config TASKS_RUDE_RCU
+	def_bool 0
+	help
+	  This option enables a task-based RCU implementation that uses
+	  only context switch (including preemption) and user-mode
+	  execution as quiescent states.  It forces IPIs and context
+	  switches on all online CPUs, including idle ones, so use
+	  with caution.
+
 config RCU_STALL_COMMON
 	def_bool TREE_RCU
 	help
diff --git a/kernel/rcu/tasks.h b/kernel/rcu/tasks.h
index d77921e..7f9ed20 100644
--- a/kernel/rcu/tasks.h
+++ b/kernel/rcu/tasks.h
@@ -180,6 +180,9 @@ static void __init rcu_tasks_bootup_oddness(void)
 	else
 		pr_info("\tTasks RCU enabled.\n");
 #endif /* #ifdef CONFIG_TASKS_RCU */
+#ifdef CONFIG_TASKS_RUDE_RCU
+	pr_info("\tRude variant of Tasks RCU enabled.\n");
+#endif /* #ifdef CONFIG_TASKS_RUDE_RCU */
 }
 
 #endif /* #ifndef CONFIG_TINY_RCU */
@@ -410,3 +413,98 @@ static int __init rcu_spawn_tasks_kthread(void)
 core_initcall(rcu_spawn_tasks_kthread);
 
 #endif /* #ifdef CONFIG_TASKS_RCU */
+
+#ifdef CONFIG_TASKS_RUDE_RCU
+
+////////////////////////////////////////////////////////////////////////
+//
+// "Rude" variant of Tasks RCU, inspired by Steve Rostedt's trick of
+// passing an empty function to schedule_on_each_cpu().  This approach
+// provides an asynchronous call_rcu_tasks_rude() API and batching
+// of concurrent calls to the synchronous synchronize_rcu_rude() API.
+// This sends IPIs far and wide and induces otherwise unnecessary context
+// switches on all online CPUs, whether idle or not.
+
+// Empty function to allow workqueues to force a context switch.
+static void rcu_tasks_be_rude(struct work_struct *work)
+{
+}
+
+// Wait for one rude RCU-tasks grace period.
+static void rcu_tasks_rude_wait_gp(struct rcu_tasks *rtp)
+{
+	schedule_on_each_cpu(rcu_tasks_be_rude);
+}
+
+void call_rcu_tasks_rude(struct rcu_head *rhp, rcu_callback_t func);
+DEFINE_RCU_TASKS(rcu_tasks_rude, rcu_tasks_rude_wait_gp, call_rcu_tasks_rude);
+
+/**
+ * call_rcu_tasks_rude() - Queue a callback rude task-based grace period
+ * @rhp: structure to be used for queueing the RCU updates.
+ * @func: actual callback function to be invoked after the grace period
+ *
+ * The callback function will be invoked some time after a full grace
+ * period elapses, in other words after all currently executing RCU
+ * read-side critical sections have completed. call_rcu_tasks_rude()
+ * assumes that the read-side critical sections end at context switch,
+ * cond_resched_rcu_qs(), or transition to usermode execution.  As such,
+ * there are no read-side primitives analogous to rcu_read_lock() and
+ * rcu_read_unlock() because this primitive is intended to determine
+ * that all tasks have passed through a safe state, not so much for
+ * data-strcuture synchronization.
+ *
+ * See the description of call_rcu() for more detailed information on
+ * memory ordering guarantees.
+ */
+void call_rcu_tasks_rude(struct rcu_head *rhp, rcu_callback_t func)
+{
+	call_rcu_tasks_generic(rhp, func, &rcu_tasks_rude);
+}
+EXPORT_SYMBOL_GPL(call_rcu_tasks_rude);
+
+/**
+ * synchronize_rcu_tasks_rude - wait for a rude rcu-tasks grace period
+ *
+ * Control will return to the caller some time after a rude rcu-tasks
+ * grace period has elapsed, in other words after all currently
+ * executing rcu-tasks read-side critical sections have elapsed.  These
+ * read-side critical sections are delimited by calls to schedule(),
+ * cond_resched_tasks_rcu_qs(), userspace execution, and (in theory,
+ * anyway) cond_resched().
+ *
+ * This is a very specialized primitive, intended only for a few uses in
+ * tracing and other situations requiring manipulation of function preambles
+ * and profiling hooks.  The synchronize_rcu_tasks_rude() function is not
+ * (yet) intended for heavy use from multiple CPUs.
+ *
+ * See the description of synchronize_rcu() for more detailed information
+ * on memory ordering guarantees.
+ */
+void synchronize_rcu_tasks_rude(void)
+{
+	synchronize_rcu_tasks_generic(&rcu_tasks_rude);
+}
+EXPORT_SYMBOL_GPL(synchronize_rcu_tasks_rude);
+
+/**
+ * rcu_barrier_tasks_rude - Wait for in-flight call_rcu_tasks_rude() callbacks.
+ *
+ * Although the current implementation is guaranteed to wait, it is not
+ * obligated to, for example, if there are no pending callbacks.
+ */
+void rcu_barrier_tasks_rude(void)
+{
+	/* There is only one callback queue, so this is easy.  ;-) */
+	synchronize_rcu_tasks_rude();
+}
+EXPORT_SYMBOL_GPL(rcu_barrier_tasks_rude);
+
+static int __init rcu_spawn_tasks_rude_kthread(void)
+{
+	rcu_spawn_tasks_kthread_generic(&rcu_tasks_rude);
+	return 0;
+}
+core_initcall(rcu_spawn_tasks_rude_kthread);
+
+#endif /* #ifdef CONFIG_TASKS_RUDE_RCU */
