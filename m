Return-Path: <SRS0=ABJN=6Z=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.8 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 77689C54E4B
	for <linux-kernel@archiver.kernel.org>; Mon, 11 May 2020 21:04:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5A0112078A
	for <linux-kernel@archiver.kernel.org>; Mon, 11 May 2020 21:04:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732500AbgEKVEG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 11 May 2020 17:04:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44020 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1731938AbgEKU7m (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 May 2020 16:59:42 -0400
Received: from Galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0C078C061A0C;
        Mon, 11 May 2020 13:59:42 -0700 (PDT)
Received: from [5.158.153.53] (helo=tip-bot2.lab.linutronix.de)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tip-bot2@linutronix.de>)
        id 1jYFWW-0005ob-DL; Mon, 11 May 2020 22:59:40 +0200
Received: from [127.0.1.1] (localhost [IPv6:::1])
        by tip-bot2.lab.linutronix.de (Postfix) with ESMTP id 397621C0852;
        Mon, 11 May 2020 22:59:28 +0200 (CEST)
Date:   Mon, 11 May 2020 20:59:28 -0000
From:   "tip-bot2 for Paul E. McKenney" <tip-bot2@linutronix.de>
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: core/rcu] rcu-tasks: Make RCU Tasks Trace make use of RCU
 scheduler hooks
Cc:     "Paul E. McKenney" <paulmck@kernel.org>, x86 <x86@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <158923076815.390.17355421080045490813.tip-bot2@tip-bot2>
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

Commit-ID:     43766c3eadcf6033c92eb953f88801aebac0f785
Gitweb:        https://git.kernel.org/tip/43766c3eadcf6033c92eb953f88801aebac0f785
Author:        Paul E. McKenney <paulmck@kernel.org>
AuthorDate:    Mon, 16 Mar 2020 20:38:29 -07:00
Committer:     Paul E. McKenney <paulmck@kernel.org>
CommitterDate: Mon, 27 Apr 2020 11:03:52 -07:00

rcu-tasks: Make RCU Tasks Trace make use of RCU scheduler hooks

This commit makes the calls to rcu_tasks_qs() detect and report
quiescent states for RCU tasks trace.  If the task is in a quiescent
state and if ->trc_reader_checked is not yet set, the task sets its own
->trc_reader_checked.  This will cause the grace-period kthread to
remove it from the holdout list if it still remains there.

[ paulmck: Fix conditional compilation per kbuild test robot feedback. ]
Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
---
 include/linux/rcupdate.h | 44 ++++++++++++++++++++++++++++++++-------
 include/linux/rcutiny.h  |  2 +-
 kernel/rcu/tasks.h       |  5 ++--
 kernel/rcu/tree_plugin.h |  6 +----
 4 files changed, 43 insertions(+), 14 deletions(-)

diff --git a/include/linux/rcupdate.h b/include/linux/rcupdate.h
index 2be97a8..659cbfa 100644
--- a/include/linux/rcupdate.h
+++ b/include/linux/rcupdate.h
@@ -131,20 +131,50 @@ static inline void rcu_init_nohz(void) { }
  * This is a macro rather than an inline function to avoid #include hell.
  */
 #ifdef CONFIG_TASKS_RCU_GENERIC
-#define rcu_tasks_qs(t) \
-	do { \
-		if (READ_ONCE((t)->rcu_tasks_holdout)) \
-			WRITE_ONCE((t)->rcu_tasks_holdout, false); \
+
+# ifdef CONFIG_TASKS_RCU
+# define rcu_tasks_classic_qs(t, preempt)				\
+	do {								\
+		if (!(preempt) && READ_ONCE((t)->rcu_tasks_holdout))	\
+			WRITE_ONCE((t)->rcu_tasks_holdout, false);	\
 	} while (0)
-#define rcu_note_voluntary_context_switch(t) rcu_tasks_qs(t)
 void call_rcu_tasks(struct rcu_head *head, rcu_callback_t func);
 void synchronize_rcu_tasks(void);
+# else
+# define rcu_tasks_classic_qs(t, preempt) do { } while (0)
+# define call_rcu_tasks call_rcu
+# define synchronize_rcu_tasks synchronize_rcu
+# endif
+
+# ifdef CONFIG_TASKS_RCU_TRACE
+# define rcu_tasks_trace_qs(t)						\
+	do {								\
+		if (!likely(READ_ONCE((t)->trc_reader_checked)) &&	\
+		    !unlikely(READ_ONCE((t)->trc_reader_nesting))) {	\
+			smp_store_release(&(t)->trc_reader_checked, true); \
+			smp_mb(); /* Readers partitioned by store. */	\
+		}							\
+	} while (0)
+# else
+# define rcu_tasks_trace_qs(t) do { } while (0)
+# endif
+
+#define rcu_tasks_qs(t, preempt)					\
+do {									\
+	rcu_tasks_classic_qs((t), (preempt));				\
+	rcu_tasks_trace_qs((t));					\
+} while (0)
+
+# ifdef CONFIG_TASKS_RUDE_RCU
 void call_rcu_tasks_rude(struct rcu_head *head, rcu_callback_t func);
 void synchronize_rcu_tasks_rude(void);
+# endif
+
+#define rcu_note_voluntary_context_switch(t) rcu_tasks_qs(t, false)
 void exit_tasks_rcu_start(void);
 void exit_tasks_rcu_finish(void);
 #else /* #ifdef CONFIG_TASKS_RCU_GENERIC */
-#define rcu_tasks_qs(t)	do { } while (0)
+#define rcu_tasks_qs(t, preempt) do { } while (0)
 #define rcu_note_voluntary_context_switch(t) do { } while (0)
 #define call_rcu_tasks call_rcu
 #define synchronize_rcu_tasks synchronize_rcu
@@ -161,7 +191,7 @@ static inline void exit_tasks_rcu_finish(void) { }
  */
 #define cond_resched_tasks_rcu_qs() \
 do { \
-	rcu_tasks_qs(current); \
+	rcu_tasks_qs(current, false); \
 	cond_resched(); \
 } while (0)
 
diff --git a/include/linux/rcutiny.h b/include/linux/rcutiny.h
index 045c28b..d77e111 100644
--- a/include/linux/rcutiny.h
+++ b/include/linux/rcutiny.h
@@ -49,7 +49,7 @@ static inline void rcu_softirq_qs(void)
 #define rcu_note_context_switch(preempt) \
 	do { \
 		rcu_qs(); \
-		rcu_tasks_qs(current); \
+		rcu_tasks_qs(current, (preempt)); \
 	} while (0)
 
 static inline int rcu_needs_cpu(u64 basemono, u64 *nextevt)
diff --git a/kernel/rcu/tasks.h b/kernel/rcu/tasks.h
index c93fb29..6f8a404 100644
--- a/kernel/rcu/tasks.h
+++ b/kernel/rcu/tasks.h
@@ -180,7 +180,7 @@ static int __noreturn rcu_tasks_kthread(void *arg)
 
 		/* Pick up any new callbacks. */
 		raw_spin_lock_irqsave(&rtp->cbs_lock, flags);
-		smp_mb__after_unlock_lock(); // Order updates vs. GP.
+		smp_mb__after_spinlock(); // Order updates vs. GP.
 		list = rtp->cbs_head;
 		rtp->cbs_head = NULL;
 		rtp->cbs_tail = &rtp->cbs_head;
@@ -874,7 +874,7 @@ static void rcu_tasks_trace_pertask(struct task_struct *t,
 				    struct list_head *hop)
 {
 	WRITE_ONCE(t->trc_reader_need_end, false);
-	t->trc_reader_checked = false;
+	WRITE_ONCE(t->trc_reader_checked, false);
 	t->trc_ipi_to_cpu = -1;
 	trc_wait_for_one_reader(t, hop);
 }
@@ -983,6 +983,7 @@ static void rcu_tasks_trace_postgp(struct rcu_tasks *rtp)
 		pr_err("\t%d holdouts\n", atomic_read(&trc_n_readers_need_end));
 	}
 	smp_mb(); // Caller's code must be ordered after wakeup.
+		  // Pairs with pretty much every ordering primitive.
 }
 
 /* Report any needed quiescent state for this exiting task. */
diff --git a/kernel/rcu/tree_plugin.h b/kernel/rcu/tree_plugin.h
index 4f34c32..37e0281 100644
--- a/kernel/rcu/tree_plugin.h
+++ b/kernel/rcu/tree_plugin.h
@@ -331,8 +331,7 @@ void rcu_note_context_switch(bool preempt)
 	rcu_qs();
 	if (rdp->exp_deferred_qs)
 		rcu_report_exp_rdp(rdp);
-	if (!preempt)
-		rcu_tasks_qs(current);
+	rcu_tasks_qs(current, preempt);
 	trace_rcu_utilization(TPS("End context switch"));
 }
 EXPORT_SYMBOL_GPL(rcu_note_context_switch);
@@ -841,8 +840,7 @@ void rcu_note_context_switch(bool preempt)
 	this_cpu_write(rcu_data.rcu_urgent_qs, false);
 	if (unlikely(raw_cpu_read(rcu_data.rcu_need_heavy_qs)))
 		rcu_momentary_dyntick_idle();
-	if (!preempt)
-		rcu_tasks_qs(current);
+	rcu_tasks_qs(current, preempt);
 out:
 	trace_rcu_utilization(TPS("End context switch"));
 }
