Return-Path: <SRS0=ABJN=6Z=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.8 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7E777C47255
	for <linux-kernel@archiver.kernel.org>; Mon, 11 May 2020 21:04:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 609DE2078A
	for <linux-kernel@archiver.kernel.org>; Mon, 11 May 2020 21:04:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732504AbgEKVET (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 11 May 2020 17:04:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43998 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1731914AbgEKU7i (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 May 2020 16:59:38 -0400
Received: from Galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F133DC061A0E;
        Mon, 11 May 2020 13:59:37 -0700 (PDT)
Received: from [5.158.153.53] (helo=tip-bot2.lab.linutronix.de)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tip-bot2@linutronix.de>)
        id 1jYFWS-0005p6-EJ; Mon, 11 May 2020 22:59:36 +0200
Received: from [127.0.1.1] (localhost [IPv6:::1])
        by tip-bot2.lab.linutronix.de (Postfix) with ESMTP id 0694A1C001F;
        Mon, 11 May 2020 22:59:29 +0200 (CEST)
Date:   Mon, 11 May 2020 20:59:28 -0000
From:   "tip-bot2 for Paul E. McKenney" <tip-bot2@linutronix.de>
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: core/rcu] rcu-tasks: Add RCU tasks to rcutorture writer stall output
Cc:     "Paul E. McKenney" <paulmck@kernel.org>, x86 <x86@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <158923076894.390.569638969266996481.tip-bot2@tip-bot2>
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

Commit-ID:     e21408ceec2de5be418efa39feb1e2c00f824a72
Gitweb:        https://git.kernel.org/tip/e21408ceec2de5be418efa39feb1e2c00f824a72
Author:        Paul E. McKenney <paulmck@kernel.org>
AuthorDate:    Mon, 16 Mar 2020 11:01:55 -07:00
Committer:     Paul E. McKenney <paulmck@kernel.org>
CommitterDate: Mon, 27 Apr 2020 11:03:51 -07:00

rcu-tasks: Add RCU tasks to rcutorture writer stall output

This commit adds state for each RCU-tasks flavor to the rcutorture
writer stall output.  The initial state is minimal, but you have to
start somewhere.

Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
[ paulmck: Fixes based on feedback from kbuild test robot. ]
---
 kernel/rcu/rcu.h        |  1 +-
 kernel/rcu/tasks.h      | 45 ++++++++++++++++++++++++++++++++++++++--
 kernel/rcu/tree_stall.h |  2 +-
 3 files changed, 45 insertions(+), 3 deletions(-)

diff --git a/kernel/rcu/rcu.h b/kernel/rcu/rcu.h
index 7290386..e1089fd 100644
--- a/kernel/rcu/rcu.h
+++ b/kernel/rcu/rcu.h
@@ -431,6 +431,7 @@ bool rcu_gp_is_expedited(void);  /* Internal RCU use. */
 void rcu_expedite_gp(void);
 void rcu_unexpedite_gp(void);
 void rcupdate_announce_bootup_oddness(void);
+void show_rcu_tasks_gp_kthreads(void);
 void rcu_request_urgent_qs_task(struct task_struct *t);
 #endif /* #else #ifdef CONFIG_TINY_RCU */
 
diff --git a/kernel/rcu/tasks.h b/kernel/rcu/tasks.h
index b7e3e1d..e4f8942 100644
--- a/kernel/rcu/tasks.h
+++ b/kernel/rcu/tasks.h
@@ -219,6 +219,16 @@ static void __init rcu_tasks_bootup_oddness(void)
 
 #endif /* #ifndef CONFIG_TINY_RCU */
 
+/* Dump out rcutorture-relevant state common to all RCU-tasks flavors. */
+static void show_rcu_tasks_generic_gp_kthread(struct rcu_tasks *rtp, char *s)
+{
+	pr_info("%s %c%c %s\n",
+		rtp->kname,
+		".k"[!!data_race(rtp->kthread_ptr)],
+		".C"[!!data_race(rtp->cbs_head)],
+		s);
+}
+
 #ifdef CONFIG_TASKS_RCU
 
 ////////////////////////////////////////////////////////////////////////
@@ -482,7 +492,14 @@ static int __init rcu_spawn_tasks_kthread(void)
 }
 core_initcall(rcu_spawn_tasks_kthread);
 
-#endif /* #ifdef CONFIG_TASKS_RCU */
+static void show_rcu_tasks_classic_gp_kthread(void)
+{
+	show_rcu_tasks_generic_gp_kthread(&rcu_tasks, "");
+}
+
+#else /* #ifdef CONFIG_TASKS_RCU */
+static void show_rcu_tasks_classic_gp_kthread(void) { }
+#endif /* #else #ifdef CONFIG_TASKS_RCU */
 
 #ifdef CONFIG_TASKS_RUDE_RCU
 
@@ -578,7 +595,14 @@ static int __init rcu_spawn_tasks_rude_kthread(void)
 }
 core_initcall(rcu_spawn_tasks_rude_kthread);
 
-#endif /* #ifdef CONFIG_TASKS_RUDE_RCU */
+static void show_rcu_tasks_rude_gp_kthread(void)
+{
+	show_rcu_tasks_generic_gp_kthread(&rcu_tasks_rude, "");
+}
+
+#else /* #ifdef CONFIG_TASKS_RUDE_RCU */
+static void show_rcu_tasks_rude_gp_kthread(void) {}
+#endif /* #else #ifdef CONFIG_TASKS_RUDE_RCU */
 
 ////////////////////////////////////////////////////////////////////////
 //
@@ -982,10 +1006,27 @@ static int __init rcu_spawn_tasks_trace_kthread(void)
 }
 core_initcall(rcu_spawn_tasks_trace_kthread);
 
+static void show_rcu_tasks_trace_gp_kthread(void)
+{
+	char buf[32];
+
+	sprintf(buf, "N%d", atomic_read(&trc_n_readers_need_end));
+	show_rcu_tasks_generic_gp_kthread(&rcu_tasks_trace, buf);
+}
+
 #else /* #ifdef CONFIG_TASKS_TRACE_RCU */
 void exit_tasks_rcu_finish_trace(struct task_struct *t) { }
+static inline void show_rcu_tasks_trace_gp_kthread(void) {}
 #endif /* #else #ifdef CONFIG_TASKS_TRACE_RCU */
 
+void show_rcu_tasks_gp_kthreads(void)
+{
+	show_rcu_tasks_classic_gp_kthread();
+	show_rcu_tasks_rude_gp_kthread();
+	show_rcu_tasks_trace_gp_kthread();
+}
+
 #else /* #ifdef CONFIG_TASKS_RCU_GENERIC */
 static inline void rcu_tasks_bootup_oddness(void) {}
+void show_rcu_tasks_gp_kthreads(void) {}
 #endif /* #else #ifdef CONFIG_TASKS_RCU_GENERIC */
diff --git a/kernel/rcu/tree_stall.h b/kernel/rcu/tree_stall.h
index c65c975..e1c68a7 100644
--- a/kernel/rcu/tree_stall.h
+++ b/kernel/rcu/tree_stall.h
@@ -649,7 +649,7 @@ void show_rcu_gp_kthreads(void)
 		if (rcu_segcblist_is_offloaded(&rdp->cblist))
 			show_rcu_nocb_state(rdp);
 	}
-	/* sched_show_task(rcu_state.gp_kthread); */
+	show_rcu_tasks_gp_kthreads();
 }
 EXPORT_SYMBOL_GPL(show_rcu_gp_kthreads);
 
