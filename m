Return-Path: <SRS0=tn8d=5J=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.8 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 71734C41621
	for <linux-kernel@archiver.kernel.org>; Tue, 24 Mar 2020 09:16:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2FF3920724
	for <linux-kernel@archiver.kernel.org>; Tue, 24 Mar 2020 09:16:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727570AbgCXJQt (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 24 Mar 2020 05:16:49 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:43958 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727534AbgCXJQr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 Mar 2020 05:16:47 -0400
Received: from [5.158.153.53] (helo=tip-bot2.lab.linutronix.de)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tip-bot2@linutronix.de>)
        id 1jGffw-00080C-H6; Tue, 24 Mar 2020 10:16:44 +0100
Received: from [127.0.1.1] (localhost [IPv6:::1])
        by tip-bot2.lab.linutronix.de (Postfix) with ESMTP id 1451A1C04CE;
        Tue, 24 Mar 2020 10:16:36 +0100 (CET)
Date:   Tue, 24 Mar 2020 09:16:35 -0000
From:   "tip-bot2 for Paul E. McKenney" <tip-bot2@linutronix.de>
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: core/rcu] rcutorture: Allow boottime stall warnings to be suppressed
Cc:     "Paul E. McKenney" <paulmck@kernel.org>, x86 <x86@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <158504139573.28353.2863144742667336213.tip-bot2@tip-bot2>
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

Commit-ID:     58c53360b36d2077cbb843e7ad2bf75f0498271c
Gitweb:        https://git.kernel.org/tip/58c53360b36d2077cbb843e7ad2bf75f0498271c
Author:        Paul E. McKenney <paulmck@kernel.org>
AuthorDate:    Thu, 05 Dec 2019 11:29:01 -08:00
Committer:     Paul E. McKenney <paulmck@kernel.org>
CommitterDate: Thu, 20 Feb 2020 16:03:30 -08:00

rcutorture: Allow boottime stall warnings to be suppressed

In normal production, an RCU CPU stall warning at boottime is often
just as bad as at any other time.  In fact, given the desire for fast
boot, any sort of long-term stall at boot is a bad idea.  However,
heavy rcutorture testing on large hyperthreaded systems can generate
boottime RCU CPU stalls as a matter of course.  This commit therefore
provides a kernel boot parameter that suppresses reporting of boottime
RCU CPU stall warnings and similarly of rcutorture writer stalls.

Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
---
 Documentation/admin-guide/kernel-parameters.txt |  6 ++++++-
 kernel/rcu/rcu.h                                | 17 ++++++++++++++++-
 kernel/rcu/rcutorture.c                         |  2 +-
 kernel/rcu/tree_exp.h                           |  2 +-
 kernel/rcu/tree_stall.h                         |  6 +++---
 kernel/rcu/update.c                             |  8 +++++++-
 6 files changed, 35 insertions(+), 6 deletions(-)

diff --git a/Documentation/admin-guide/kernel-parameters.txt b/Documentation/admin-guide/kernel-parameters.txt
index dbc22d6..ee007b5 100644
--- a/Documentation/admin-guide/kernel-parameters.txt
+++ b/Documentation/admin-guide/kernel-parameters.txt
@@ -4195,6 +4195,12 @@
 	rcupdate.rcu_cpu_stall_suppress= [KNL]
 			Suppress RCU CPU stall warning messages.
 
+	rcupdate.rcu_cpu_stall_suppress_at_boot= [KNL]
+			Suppress RCU CPU stall warning messages and
+			rcutorture writer stall warnings that occur
+			during early boot, that is, during the time
+			before the init task is spawned.
+
 	rcupdate.rcu_cpu_stall_timeout= [KNL]
 			Set timeout for RCU CPU stall warning messages.
 
diff --git a/kernel/rcu/rcu.h b/kernel/rcu/rcu.h
index 05f936e..1779cbf 100644
--- a/kernel/rcu/rcu.h
+++ b/kernel/rcu/rcu.h
@@ -198,6 +198,13 @@ static inline void debug_rcu_head_unqueue(struct rcu_head *head)
 }
 #endif	/* #else !CONFIG_DEBUG_OBJECTS_RCU_HEAD */
 
+extern int rcu_cpu_stall_suppress_at_boot;
+
+static inline bool rcu_stall_is_suppressed_at_boot(void)
+{
+	return rcu_cpu_stall_suppress_at_boot && !rcu_inkernel_boot_has_ended();
+}
+
 #ifdef CONFIG_RCU_STALL_COMMON
 
 extern int rcu_cpu_stall_ftrace_dump;
@@ -205,6 +212,11 @@ extern int rcu_cpu_stall_suppress;
 extern int rcu_cpu_stall_timeout;
 int rcu_jiffies_till_stall_check(void);
 
+static inline bool rcu_stall_is_suppressed(void)
+{
+	return rcu_stall_is_suppressed_at_boot() || rcu_cpu_stall_suppress;
+}
+
 #define rcu_ftrace_dump_stall_suppress() \
 do { \
 	if (!rcu_cpu_stall_suppress) \
@@ -218,6 +230,11 @@ do { \
 } while (0)
 
 #else /* #endif #ifdef CONFIG_RCU_STALL_COMMON */
+
+static inline bool rcu_stall_is_suppressed(void)
+{
+	return rcu_stall_is_suppressed_at_boot();
+}
 #define rcu_ftrace_dump_stall_suppress()
 #define rcu_ftrace_dump_stall_unsuppress()
 #endif /* #ifdef CONFIG_RCU_STALL_COMMON */
diff --git a/kernel/rcu/rcutorture.c b/kernel/rcu/rcutorture.c
index 08fa4ef..16c84ec 100644
--- a/kernel/rcu/rcutorture.c
+++ b/kernel/rcu/rcutorture.c
@@ -1479,7 +1479,7 @@ rcu_torture_stats_print(void)
 	if (cur_ops->stats)
 		cur_ops->stats();
 	if (rtcv_snap == rcu_torture_current_version &&
-	    rcu_torture_current != NULL) {
+	    rcu_torture_current != NULL && !rcu_stall_is_suppressed()) {
 		int __maybe_unused flags = 0;
 		unsigned long __maybe_unused gp_seq = 0;
 
diff --git a/kernel/rcu/tree_exp.h b/kernel/rcu/tree_exp.h
index a72d16e..c28d9f0 100644
--- a/kernel/rcu/tree_exp.h
+++ b/kernel/rcu/tree_exp.h
@@ -518,7 +518,7 @@ static void synchronize_rcu_expedited_wait(void)
 	for (;;) {
 		if (synchronize_rcu_expedited_wait_once(jiffies_stall))
 			return;
-		if (rcu_cpu_stall_suppress)
+		if (rcu_stall_is_suppressed())
 			continue;
 		panic_on_rcu_stall();
 		pr_err("INFO: %s detected expedited stalls on CPUs/tasks: {",
diff --git a/kernel/rcu/tree_stall.h b/kernel/rcu/tree_stall.h
index 55f9b84..7ee8a1c 100644
--- a/kernel/rcu/tree_stall.h
+++ b/kernel/rcu/tree_stall.h
@@ -383,7 +383,7 @@ static void print_other_cpu_stall(unsigned long gp_seq)
 
 	/* Kick and suppress, if so configured. */
 	rcu_stall_kick_kthreads();
-	if (rcu_cpu_stall_suppress)
+	if (rcu_stall_is_suppressed())
 		return;
 
 	/*
@@ -452,7 +452,7 @@ static void print_cpu_stall(void)
 
 	/* Kick and suppress, if so configured. */
 	rcu_stall_kick_kthreads();
-	if (rcu_cpu_stall_suppress)
+	if (rcu_stall_is_suppressed())
 		return;
 
 	/*
@@ -504,7 +504,7 @@ static void check_cpu_stall(struct rcu_data *rdp)
 	unsigned long js;
 	struct rcu_node *rnp;
 
-	if ((rcu_cpu_stall_suppress && !rcu_kick_kthreads) ||
+	if ((rcu_stall_is_suppressed() && !rcu_kick_kthreads) ||
 	    !rcu_gp_in_progress())
 		return;
 	rcu_stall_kick_kthreads();
diff --git a/kernel/rcu/update.c b/kernel/rcu/update.c
index feaaec5..085f08a 100644
--- a/kernel/rcu/update.c
+++ b/kernel/rcu/update.c
@@ -476,13 +476,19 @@ EXPORT_SYMBOL_GPL(rcutorture_sched_setaffinity);
 #ifdef CONFIG_RCU_STALL_COMMON
 int rcu_cpu_stall_ftrace_dump __read_mostly;
 module_param(rcu_cpu_stall_ftrace_dump, int, 0644);
-int rcu_cpu_stall_suppress __read_mostly; /* 1 = suppress stall warnings. */
+int rcu_cpu_stall_suppress __read_mostly; // !0 = suppress stall warnings.
 EXPORT_SYMBOL_GPL(rcu_cpu_stall_suppress);
 module_param(rcu_cpu_stall_suppress, int, 0644);
 int rcu_cpu_stall_timeout __read_mostly = CONFIG_RCU_CPU_STALL_TIMEOUT;
 module_param(rcu_cpu_stall_timeout, int, 0644);
 #endif /* #ifdef CONFIG_RCU_STALL_COMMON */
 
+// Suppress boot-time RCU CPU stall warnings and rcutorture writer stall
+// warnings.  Also used by rcutorture even if stall warnings are excluded.
+int rcu_cpu_stall_suppress_at_boot __read_mostly; // !0 = suppress boot stalls.
+EXPORT_SYMBOL_GPL(rcu_cpu_stall_suppress_at_boot);
+module_param(rcu_cpu_stall_suppress_at_boot, int, 0444);
+
 #ifdef CONFIG_TASKS_RCU
 
 /*
