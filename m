Return-Path: <SRS0=ABJN=6Z=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.8 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8B72BC54E4B
	for <linux-kernel@archiver.kernel.org>; Mon, 11 May 2020 21:05:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6D98C20836
	for <linux-kernel@archiver.kernel.org>; Mon, 11 May 2020 21:05:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732389AbgEKVFI (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 11 May 2020 17:05:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43936 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1731843AbgEKU71 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 May 2020 16:59:27 -0400
Received: from Galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 650DBC061A0C;
        Mon, 11 May 2020 13:59:27 -0700 (PDT)
Received: from [5.158.153.53] (helo=tip-bot2.lab.linutronix.de)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tip-bot2@linutronix.de>)
        id 1jYFWH-0005jw-SU; Mon, 11 May 2020 22:59:25 +0200
Received: from [127.0.1.1] (localhost [IPv6:::1])
        by tip-bot2.lab.linutronix.de (Postfix) with ESMTP id 3AD671C04CC;
        Mon, 11 May 2020 22:59:22 +0200 (CEST)
Date:   Mon, 11 May 2020 20:59:22 -0000
From:   "tip-bot2 for Paul E. McKenney" <tip-bot2@linutronix.de>
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: core/rcu] rcu-tasks: Allow standalone use of TASKS_{TRACE_,}RCU
Cc:     "Paul E. McKenney" <paulmck@kernel.org>, x86 <x86@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <158923076214.390.16365922587319898600.tip-bot2@tip-bot2>
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

Commit-ID:     25246fc83155b254534ce579fb713828fb5e621a
Gitweb:        https://git.kernel.org/tip/25246fc83155b254534ce579fb713828fb5e621a
Author:        Paul E. McKenney <paulmck@kernel.org>
AuthorDate:    Sun, 05 Apr 2020 20:49:13 -07:00
Committer:     Paul E. McKenney <paulmck@kernel.org>
CommitterDate: Mon, 27 Apr 2020 11:03:53 -07:00

rcu-tasks: Allow standalone use of TASKS_{TRACE_,}RCU

This commit allows TASKS_TRACE_RCU to be used independently of TASKS_RCU
and vice versa.

[ paulmck: Fix conditional compilation per kbuild test robot feedback. ]
Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
---
 kernel/rcu/tasks.h | 54 +++++++++++++++++++++++++--------------------
 1 file changed, 30 insertions(+), 24 deletions(-)

diff --git a/kernel/rcu/tasks.h b/kernel/rcu/tasks.h
index 0a580ef..ce23f6c 100644
--- a/kernel/rcu/tasks.h
+++ b/kernel/rcu/tasks.h
@@ -244,27 +244,6 @@ static void __init rcu_spawn_tasks_kthread_generic(struct rcu_tasks *rtp)
 	smp_mb(); /* Ensure others see full kthread. */
 }
 
-/* Do the srcu_read_lock() for the above synchronize_srcu().  */
-void exit_tasks_rcu_start(void) __acquires(&tasks_rcu_exit_srcu)
-{
-	preempt_disable();
-	current->rcu_tasks_idx = __srcu_read_lock(&tasks_rcu_exit_srcu);
-	preempt_enable();
-}
-
-static void exit_tasks_rcu_finish_trace(struct task_struct *t);
-
-/* Do the srcu_read_unlock() for the above synchronize_srcu().  */
-void exit_tasks_rcu_finish(void) __releases(&tasks_rcu_exit_srcu)
-{
-	struct task_struct *t = current;
-
-	preempt_disable();
-	__srcu_read_unlock(&tasks_rcu_exit_srcu, t->rcu_tasks_idx);
-	preempt_enable();
-	exit_tasks_rcu_finish_trace(t);
-}
-
 #ifndef CONFIG_TINY_RCU
 
 /*
@@ -303,7 +282,9 @@ static void show_rcu_tasks_generic_gp_kthread(struct rcu_tasks *rtp, char *s)
 		s);
 }
 
-#ifdef CONFIG_TASKS_RCU
+static void exit_tasks_rcu_finish_trace(struct task_struct *t);
+
+#if defined(CONFIG_TASKS_RCU) || defined(CONFIG_TASKS_TRACE_RCU)
 
 ////////////////////////////////////////////////////////////////////////
 //
@@ -374,6 +355,10 @@ static void rcu_tasks_wait_gp(struct rcu_tasks *rtp)
 	rtp->postgp_func(rtp);
 }
 
+#endif /* #if defined(CONFIG_TASKS_RCU) || defined(CONFIG_TASKS_TRACE_RCU) */
+
+#ifdef CONFIG_TASKS_RCU
+
 ////////////////////////////////////////////////////////////////////////
 //
 // Simple variant of RCU whose quiescent states are voluntary context
@@ -577,8 +562,29 @@ static void show_rcu_tasks_classic_gp_kthread(void)
 	show_rcu_tasks_generic_gp_kthread(&rcu_tasks, "");
 }
 
+/* Do the srcu_read_lock() for the above synchronize_srcu().  */
+void exit_tasks_rcu_start(void) __acquires(&tasks_rcu_exit_srcu)
+{
+	preempt_disable();
+	current->rcu_tasks_idx = __srcu_read_lock(&tasks_rcu_exit_srcu);
+	preempt_enable();
+}
+
+/* Do the srcu_read_unlock() for the above synchronize_srcu().  */
+void exit_tasks_rcu_finish(void) __releases(&tasks_rcu_exit_srcu)
+{
+	struct task_struct *t = current;
+
+	preempt_disable();
+	__srcu_read_unlock(&tasks_rcu_exit_srcu, t->rcu_tasks_idx);
+	preempt_enable();
+	exit_tasks_rcu_finish_trace(t);
+}
+
 #else /* #ifdef CONFIG_TASKS_RCU */
 static void show_rcu_tasks_classic_gp_kthread(void) { }
+void exit_tasks_rcu_start(void) { }
+void exit_tasks_rcu_finish(void) { exit_tasks_rcu_finish_trace(current); }
 #endif /* #else #ifdef CONFIG_TASKS_RCU */
 
 #ifdef CONFIG_TASKS_RUDE_RCU
@@ -1075,7 +1081,7 @@ static void rcu_tasks_trace_postgp(struct rcu_tasks *rtp)
 }
 
 /* Report any needed quiescent state for this exiting task. */
-void exit_tasks_rcu_finish_trace(struct task_struct *t)
+static void exit_tasks_rcu_finish_trace(struct task_struct *t)
 {
 	WRITE_ONCE(t->trc_reader_checked, true);
 	WARN_ON_ONCE(t->trc_reader_nesting);
@@ -1170,7 +1176,7 @@ static void show_rcu_tasks_trace_gp_kthread(void)
 }
 
 #else /* #ifdef CONFIG_TASKS_TRACE_RCU */
-void exit_tasks_rcu_finish_trace(struct task_struct *t) { }
+static void exit_tasks_rcu_finish_trace(struct task_struct *t) { }
 static inline void show_rcu_tasks_trace_gp_kthread(void) {}
 #endif /* #else #ifdef CONFIG_TASKS_TRACE_RCU */
 
