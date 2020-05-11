Return-Path: <SRS0=ABJN=6Z=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.8 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1698AC54E4B
	for <linux-kernel@archiver.kernel.org>; Mon, 11 May 2020 21:04:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id F1EF02078A
	for <linux-kernel@archiver.kernel.org>; Mon, 11 May 2020 21:04:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732511AbgEKVEa (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 11 May 2020 17:04:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43984 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1731894AbgEKU7f (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 May 2020 16:59:35 -0400
Received: from Galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E98BDC061A0E;
        Mon, 11 May 2020 13:59:34 -0700 (PDT)
Received: from [5.158.153.53] (helo=tip-bot2.lab.linutronix.de)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tip-bot2@linutronix.de>)
        id 1jYFWP-0005nr-D0; Mon, 11 May 2020 22:59:33 +0200
Received: from [127.0.1.1] (localhost [IPv6:::1])
        by tip-bot2.lab.linutronix.de (Postfix) with ESMTP id 18C201C07EB;
        Mon, 11 May 2020 22:59:27 +0200 (CEST)
Date:   Mon, 11 May 2020 20:59:27 -0000
From:   "tip-bot2 for Paul E. McKenney" <tip-bot2@linutronix.de>
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: core/rcu] rcu-tasks: Split ->trc_reader_need_end
Cc:     "Paul E. McKenney" <paulmck@kernel.org>, x86 <x86@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <158923076703.390.6550904402071606798.tip-bot2@tip-bot2>
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

Commit-ID:     276c410448dbca357a2bc3539acfe04862e5f172
Gitweb:        https://git.kernel.org/tip/276c410448dbca357a2bc3539acfe04862e5f172
Author:        Paul E. McKenney <paulmck@kernel.org>
AuthorDate:    Tue, 17 Mar 2020 16:02:06 -07:00
Committer:     Paul E. McKenney <paulmck@kernel.org>
CommitterDate: Mon, 27 Apr 2020 11:03:52 -07:00

rcu-tasks: Split ->trc_reader_need_end

This commit splits ->trc_reader_need_end by using the rcu_special union.
This change permits readers to check to see if a memory barrier is
required without any added overhead in the common case where no such
barrier is required.  This commit also adds the read-side checking.
Later commits will add the machinery to properly set the new
->trc_reader_special.b.need_mb field.

This commit also makes rcu_read_unlock_trace_special() tolerate nested
read-side critical sections within interrupt and NMI handlers.

Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
---
 include/linux/rcupdate_trace.h | 11 +++++++----
 include/linux/sched.h          |  4 ++--
 init/init_task.c               |  1 +-
 kernel/fork.c                  |  1 +-
 kernel/rcu/tasks.h             | 33 ++++++++++++++++++++-------------
 5 files changed, 31 insertions(+), 19 deletions(-)

diff --git a/include/linux/rcupdate_trace.h b/include/linux/rcupdate_trace.h
index ed97e10..c42b365 100644
--- a/include/linux/rcupdate_trace.h
+++ b/include/linux/rcupdate_trace.h
@@ -31,7 +31,7 @@ static inline int rcu_read_lock_trace_held(void)
 
 #ifdef CONFIG_TASKS_TRACE_RCU
 
-void rcu_read_unlock_trace_special(struct task_struct *t);
+void rcu_read_unlock_trace_special(struct task_struct *t, int nesting);
 
 /**
  * rcu_read_lock_trace - mark beginning of RCU-trace read-side critical section
@@ -50,6 +50,8 @@ static inline void rcu_read_lock_trace(void)
 	struct task_struct *t = current;
 
 	WRITE_ONCE(t->trc_reader_nesting, READ_ONCE(t->trc_reader_nesting) + 1);
+	if (t->trc_reader_special.b.need_mb)
+		smp_mb(); // Pairs with update-side barriers
 	rcu_lock_acquire(&rcu_trace_lock_map);
 }
 
@@ -69,10 +71,11 @@ static inline void rcu_read_unlock_trace(void)
 
 	rcu_lock_release(&rcu_trace_lock_map);
 	nesting = READ_ONCE(t->trc_reader_nesting) - 1;
-	WRITE_ONCE(t->trc_reader_nesting, nesting);
-	if (likely(!READ_ONCE(t->trc_reader_need_end)) || nesting)
+	if (likely(!READ_ONCE(t->trc_reader_special.s)) || nesting) {
+		WRITE_ONCE(t->trc_reader_nesting, nesting);
 		return;  // We assume shallow reader nesting.
-	rcu_read_unlock_trace_special(t);
+	}
+	rcu_read_unlock_trace_special(t, nesting);
 }
 
 void call_rcu_tasks_trace(struct rcu_head *rhp, rcu_callback_t func);
diff --git a/include/linux/sched.h b/include/linux/sched.h
index 864f60e..9437b53 100644
--- a/include/linux/sched.h
+++ b/include/linux/sched.h
@@ -613,7 +613,7 @@ union rcu_special {
 		u8			blocked;
 		u8			need_qs;
 		u8			exp_hint; /* Hint for performance. */
-		u8			pad; /* No garbage from compiler! */
+		u8			need_mb; /* Readers need smp_mb(). */
 	} b; /* Bits. */
 	u32 s; /* Set of bits. */
 };
@@ -727,7 +727,7 @@ struct task_struct {
 #ifdef CONFIG_TASKS_TRACE_RCU
 	int				trc_reader_nesting;
 	int				trc_ipi_to_cpu;
-	bool				trc_reader_need_end;
+	union rcu_special		trc_reader_special;
 	bool				trc_reader_checked;
 	struct list_head		trc_holdout_list;
 #endif /* #ifdef CONFIG_TASKS_TRACE_RCU */
diff --git a/init/init_task.c b/init/init_task.c
index e8b3740..825972d 100644
--- a/init/init_task.c
+++ b/init/init_task.c
@@ -143,6 +143,7 @@ struct task_struct init_task
 #endif
 #ifdef CONFIG_TASKS_TRACE_RCU
 	.trc_reader_nesting = 0,
+	.trc_reader_special.s = 0,
 	.trc_holdout_list = LIST_HEAD_INIT(init_task.trc_holdout_list),
 #endif
 #ifdef CONFIG_CPUSETS
diff --git a/kernel/fork.c b/kernel/fork.c
index 72e9396..96eb4b5 100644
--- a/kernel/fork.c
+++ b/kernel/fork.c
@@ -1685,6 +1685,7 @@ static inline void rcu_copy_process(struct task_struct *p)
 #endif /* #ifdef CONFIG_TASKS_RCU */
 #ifdef CONFIG_TASKS_TRACE_RCU
 	p->trc_reader_nesting = 0;
+	p->trc_reader_special.s = 0;
 	INIT_LIST_HEAD(&p->trc_holdout_list);
 #endif /* #ifdef CONFIG_TASKS_TRACE_RCU */
 }
diff --git a/kernel/rcu/tasks.h b/kernel/rcu/tasks.h
index eeac4a1..17b1b9a 100644
--- a/kernel/rcu/tasks.h
+++ b/kernel/rcu/tasks.h
@@ -723,10 +723,17 @@ DEFINE_RCU_TASKS(rcu_tasks_trace, rcu_tasks_wait_gp, call_rcu_tasks_trace,
 		 "RCU Tasks Trace");
 
 /* If we are the last reader, wake up the grace-period kthread. */
-void rcu_read_unlock_trace_special(struct task_struct *t)
+void rcu_read_unlock_trace_special(struct task_struct *t, int nesting)
 {
-	WRITE_ONCE(t->trc_reader_need_end, false);
-	if (atomic_dec_and_test(&trc_n_readers_need_end))
+	int nq = t->trc_reader_special.b.need_qs;
+
+	if (t->trc_reader_special.b.need_mb)
+		smp_mb(); // Pairs with update-side barriers.
+	// Update .need_qs before ->trc_reader_nesting for irq/NMI handlers.
+	if (nq)
+		WRITE_ONCE(t->trc_reader_special.b.need_qs, false);
+	WRITE_ONCE(t->trc_reader_nesting, nesting);
+	if (nq && atomic_dec_and_test(&trc_n_readers_need_end))
 		wake_up(&trc_wait);
 }
 EXPORT_SYMBOL_GPL(rcu_read_unlock_trace_special);
@@ -777,8 +784,8 @@ static void trc_read_check_handler(void *t_in)
 	// Get here if the task is in a read-side critical section.  Set
 	// its state so that it will awaken the grace-period kthread upon
 	// exit from that critical section.
-	WARN_ON_ONCE(t->trc_reader_need_end);
-	WRITE_ONCE(t->trc_reader_need_end, true);
+	WARN_ON_ONCE(t->trc_reader_special.b.need_qs);
+	WRITE_ONCE(t->trc_reader_special.b.need_qs, true);
 
 reset_ipi:
 	// Allow future IPIs to be sent on CPU and for task.
@@ -804,8 +811,8 @@ static bool trc_inspect_reader(struct task_struct *t, void *arg)
 	// exit from that critical section.
 	if (unlikely(t->trc_reader_nesting)) {
 		atomic_inc(&trc_n_readers_need_end); // One more to wait on.
-		WARN_ON_ONCE(t->trc_reader_need_end);
-		WRITE_ONCE(t->trc_reader_need_end, true);
+		WARN_ON_ONCE(t->trc_reader_special.b.need_qs);
+		WRITE_ONCE(t->trc_reader_special.b.need_qs, true);
 	}
 	return true;
 }
@@ -884,7 +891,7 @@ static void rcu_tasks_trace_pregp_step(void)
 static void rcu_tasks_trace_pertask(struct task_struct *t,
 				    struct list_head *hop)
 {
-	WRITE_ONCE(t->trc_reader_need_end, false);
+	WRITE_ONCE(t->trc_reader_special.b.need_qs, false);
 	WRITE_ONCE(t->trc_reader_checked, false);
 	t->trc_ipi_to_cpu = -1;
 	trc_wait_for_one_reader(t, hop);
@@ -916,7 +923,7 @@ static void show_stalled_task_trace(struct task_struct *t, bool *firstreport)
 		 ".i"[is_idle_task(t)],
 		 ".N"[cpu > 0 && tick_nohz_full_cpu(cpu)],
 		 t->trc_reader_nesting,
-		 " N"[!!t->trc_reader_need_end],
+		 " N"[!!t->trc_reader_special.b.need_qs],
 		 cpu);
 	sched_show_task(t);
 }
@@ -980,11 +987,11 @@ static void rcu_tasks_trace_postgp(struct rcu_tasks *rtp)
 			break;  // Count reached zero.
 		// Stall warning time, so make a list of the offenders.
 		for_each_process_thread(g, t)
-			if (READ_ONCE(t->trc_reader_need_end))
+			if (READ_ONCE(t->trc_reader_special.b.need_qs))
 				trc_add_holdout(t, &holdouts);
 		firstreport = true;
 		list_for_each_entry_safe(t, g, &holdouts, trc_holdout_list)
-			if (READ_ONCE(t->trc_reader_need_end)) {
+			if (READ_ONCE(t->trc_reader_special.b.need_qs)) {
 				show_stalled_task_trace(t, &firstreport);
 				trc_del_holdout(t);
 			}
@@ -1003,8 +1010,8 @@ void exit_tasks_rcu_finish_trace(struct task_struct *t)
 	WRITE_ONCE(t->trc_reader_checked, true);
 	WARN_ON_ONCE(t->trc_reader_nesting);
 	WRITE_ONCE(t->trc_reader_nesting, 0);
-	if (WARN_ON_ONCE(READ_ONCE(t->trc_reader_need_end)))
-		rcu_read_unlock_trace_special(t);
+	if (WARN_ON_ONCE(READ_ONCE(t->trc_reader_special.b.need_qs)))
+		rcu_read_unlock_trace_special(t, 0);
 }
 
 /**
