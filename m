Return-Path: <SRS0=aedO=3O=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.7 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3C2E4C2D0DB
	for <linux-kernel@archiver.kernel.org>; Sat, 25 Jan 2020 10:45:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 10E0524125
	for <linux-kernel@archiver.kernel.org>; Sat, 25 Jan 2020 10:45:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730122AbgAYKpN (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 25 Jan 2020 05:45:13 -0500
Received: from Galois.linutronix.de ([193.142.43.55]:44328 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729710AbgAYKnR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 25 Jan 2020 05:43:17 -0500
Received: from [5.158.153.53] (helo=tip-bot2.lab.linutronix.de)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tip-bot2@linutronix.de>)
        id 1ivIuH-0000C2-4z; Sat, 25 Jan 2020 11:43:13 +0100
Received: from [127.0.1.1] (localhost [IPv6:::1])
        by tip-bot2.lab.linutronix.de (Postfix) with ESMTP id E75D91C1A7B;
        Sat, 25 Jan 2020 11:42:54 +0100 (CET)
Date:   Sat, 25 Jan 2020 10:42:54 -0000
From:   "tip-bot2 for Lai Jiangshan" <tip-bot2@linutronix.de>
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: core/rcu] rcu: Make PREEMPT_RCU be a modifier to TREE_RCU
Cc:     Lai Jiangshan <laijs@linux.alibaba.com>,
        Lai Jiangshan <jiangshanlai@gmail.com>,
        "Joel Fernandes (Google)" <joel@joelfernandes.org>,
        "Paul E. McKenney" <paulmck@kernel.org>, x86 <x86@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <157994897474.396.3275710540045479906.tip-bot2@tip-bot2>
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

Commit-ID:     b3e627d3d5092a87fc9b9e37e341610cfecfbfdc
Gitweb:        https://git.kernel.org/tip/b3e627d3d5092a87fc9b9e37e341610cfecfbfdc
Author:        Lai Jiangshan <laijs@linux.alibaba.com>
AuthorDate:    Tue, 15 Oct 2019 02:55:57 
Committer:     Paul E. McKenney <paulmck@kernel.org>
CommitterDate: Mon, 09 Dec 2019 12:37:51 -08:00

rcu: Make PREEMPT_RCU be a modifier to TREE_RCU

Currently PREEMPT_RCU and TREE_RCU are mutually exclusive Kconfig
options.  But PREEMPT_RCU actually specifies a kind of TREE_RCU,
namely a preemptible TREE_RCU. This commit therefore makes PREEMPT_RCU
be a modifer to the TREE_RCU Kconfig option.  This has the benefit of
simplifying several of the #if expressions that formerly needed to
check both, but now need only check one or the other.

Signed-off-by: Lai Jiangshan <laijs@linux.alibaba.com>
Signed-off-by: Lai Jiangshan <jiangshanlai@gmail.com>
Reviewed-by: Joel Fernandes (Google) <joel@joelfernandes.org>
Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
---
 include/linux/rcupdate.h   |  4 ++--
 include/trace/events/rcu.h |  4 ++--
 kernel/rcu/Kconfig         | 13 +++++++------
 kernel/rcu/Makefile        |  1 -
 kernel/rcu/rcu.h           |  2 +-
 kernel/rcu/update.c        |  2 +-
 kernel/sysctl.c            |  2 +-
 7 files changed, 14 insertions(+), 14 deletions(-)

diff --git a/include/linux/rcupdate.h b/include/linux/rcupdate.h
index 0b75063..70a41cd 100644
--- a/include/linux/rcupdate.h
+++ b/include/linux/rcupdate.h
@@ -167,7 +167,7 @@ do { \
  * TREE_RCU and rcu_barrier_() primitives in TINY_RCU.
  */
 
-#if defined(CONFIG_TREE_RCU) || defined(CONFIG_PREEMPT_RCU)
+#if defined(CONFIG_TREE_RCU)
 #include <linux/rcutree.h>
 #elif defined(CONFIG_TINY_RCU)
 #include <linux/rcutiny.h>
@@ -601,7 +601,7 @@ do {									      \
  * read-side critical section that would block in a !PREEMPT kernel.
  * But if you want the full story, read on!
  *
- * In non-preemptible RCU implementations (TREE_RCU and TINY_RCU),
+ * In non-preemptible RCU implementations (pure TREE_RCU and TINY_RCU),
  * it is illegal to block while in an RCU read-side critical section.
  * In preemptible RCU implementations (PREEMPT_RCU) in CONFIG_PREEMPTION
  * kernel builds, RCU read-side critical sections may be preempted,
diff --git a/include/trace/events/rcu.h b/include/trace/events/rcu.h
index 6612260..85019cf 100644
--- a/include/trace/events/rcu.h
+++ b/include/trace/events/rcu.h
@@ -41,7 +41,7 @@ TRACE_EVENT(rcu_utilization,
 	TP_printk("%s", __entry->s)
 );
 
-#if defined(CONFIG_TREE_RCU) || defined(CONFIG_PREEMPT_RCU)
+#if defined(CONFIG_TREE_RCU)
 
 /*
  * Tracepoint for grace-period events.  Takes a string identifying the
@@ -432,7 +432,7 @@ TRACE_EVENT_RCU(rcu_fqs,
 		  __entry->cpu, __entry->qsevent)
 );
 
-#endif /* #if defined(CONFIG_TREE_RCU) || defined(CONFIG_PREEMPT_RCU) */
+#endif /* #if defined(CONFIG_TREE_RCU) */
 
 /*
  * Tracepoint for dyntick-idle entry/exit events.  These take a string
diff --git a/kernel/rcu/Kconfig b/kernel/rcu/Kconfig
index 7644eda..0303934 100644
--- a/kernel/rcu/Kconfig
+++ b/kernel/rcu/Kconfig
@@ -7,7 +7,7 @@ menu "RCU Subsystem"
 
 config TREE_RCU
 	bool
-	default y if !PREEMPTION && SMP
+	default y if SMP
 	help
 	  This option selects the RCU implementation that is
 	  designed for very large SMP system with hundreds or
@@ -17,6 +17,7 @@ config TREE_RCU
 config PREEMPT_RCU
 	bool
 	default y if PREEMPTION
+	select TREE_RCU
 	help
 	  This option selects the RCU implementation that is
 	  designed for very large SMP systems with hundreds or
@@ -78,7 +79,7 @@ config TASKS_RCU
 	  user-mode execution as quiescent states.
 
 config RCU_STALL_COMMON
-	def_bool ( TREE_RCU || PREEMPT_RCU )
+	def_bool TREE_RCU
 	help
 	  This option enables RCU CPU stall code that is common between
 	  the TINY and TREE variants of RCU.  The purpose is to allow
@@ -86,13 +87,13 @@ config RCU_STALL_COMMON
 	  making these warnings mandatory for the tree variants.
 
 config RCU_NEED_SEGCBLIST
-	def_bool ( TREE_RCU || PREEMPT_RCU || TREE_SRCU )
+	def_bool ( TREE_RCU || TREE_SRCU )
 
 config RCU_FANOUT
 	int "Tree-based hierarchical RCU fanout value"
 	range 2 64 if 64BIT
 	range 2 32 if !64BIT
-	depends on (TREE_RCU || PREEMPT_RCU) && RCU_EXPERT
+	depends on TREE_RCU && RCU_EXPERT
 	default 64 if 64BIT
 	default 32 if !64BIT
 	help
@@ -112,7 +113,7 @@ config RCU_FANOUT_LEAF
 	int "Tree-based hierarchical RCU leaf-level fanout value"
 	range 2 64 if 64BIT
 	range 2 32 if !64BIT
-	depends on (TREE_RCU || PREEMPT_RCU) && RCU_EXPERT
+	depends on TREE_RCU && RCU_EXPERT
 	default 16
 	help
 	  This option controls the leaf-level fanout of hierarchical
@@ -187,7 +188,7 @@ config RCU_BOOST_DELAY
 
 config RCU_NOCB_CPU
 	bool "Offload RCU callback processing from boot-selected CPUs"
-	depends on TREE_RCU || PREEMPT_RCU
+	depends on TREE_RCU
 	depends on RCU_EXPERT || NO_HZ_FULL
 	default n
 	help
diff --git a/kernel/rcu/Makefile b/kernel/rcu/Makefile
index 020e8b6..82d5fba 100644
--- a/kernel/rcu/Makefile
+++ b/kernel/rcu/Makefile
@@ -9,6 +9,5 @@ obj-$(CONFIG_TINY_SRCU) += srcutiny.o
 obj-$(CONFIG_RCU_TORTURE_TEST) += rcutorture.o
 obj-$(CONFIG_RCU_PERF_TEST) += rcuperf.o
 obj-$(CONFIG_TREE_RCU) += tree.o
-obj-$(CONFIG_PREEMPT_RCU) += tree.o
 obj-$(CONFIG_TINY_RCU) += tiny.o
 obj-$(CONFIG_RCU_NEED_SEGCBLIST) += rcu_segcblist.o
diff --git a/kernel/rcu/rcu.h b/kernel/rcu/rcu.h
index ab504fb..eabafde 100644
--- a/kernel/rcu/rcu.h
+++ b/kernel/rcu/rcu.h
@@ -454,7 +454,7 @@ enum rcutorture_type {
 	INVALID_RCU_FLAVOR
 };
 
-#if defined(CONFIG_TREE_RCU) || defined(CONFIG_PREEMPT_RCU)
+#if defined(CONFIG_TREE_RCU)
 void rcutorture_get_gp_data(enum rcutorture_type test_type, int *flags,
 			    unsigned long *gp_seq);
 void do_trace_rcu_torture_read(const char *rcutorturename,
diff --git a/kernel/rcu/update.c b/kernel/rcu/update.c
index 1861103..34a7452 100644
--- a/kernel/rcu/update.c
+++ b/kernel/rcu/update.c
@@ -435,7 +435,7 @@ struct debug_obj_descr rcuhead_debug_descr = {
 EXPORT_SYMBOL_GPL(rcuhead_debug_descr);
 #endif /* #ifdef CONFIG_DEBUG_OBJECTS_RCU_HEAD */
 
-#if defined(CONFIG_TREE_RCU) || defined(CONFIG_PREEMPT_RCU) || defined(CONFIG_RCU_TRACE)
+#if defined(CONFIG_TREE_RCU) || defined(CONFIG_RCU_TRACE)
 void do_trace_rcu_torture_read(const char *rcutorturename, struct rcu_head *rhp,
 			       unsigned long secs,
 			       unsigned long c_old, unsigned long c)
diff --git a/kernel/sysctl.c b/kernel/sysctl.c
index 7066593..d396aaa 100644
--- a/kernel/sysctl.c
+++ b/kernel/sysctl.c
@@ -1268,7 +1268,7 @@ static struct ctl_table kern_table[] = {
 		.proc_handler	= proc_do_static_key,
 	},
 #endif
-#if defined(CONFIG_TREE_RCU) || defined(CONFIG_PREEMPT_RCU)
+#if defined(CONFIG_TREE_RCU)
 	{
 		.procname	= "panic_on_rcu_stall",
 		.data		= &sysctl_panic_on_rcu_stall,
