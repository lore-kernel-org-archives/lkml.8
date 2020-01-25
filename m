Return-Path: <SRS0=aedO=3O=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.8 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6AA98C2D0DB
	for <linux-kernel@archiver.kernel.org>; Sat, 25 Jan 2020 10:46:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3E27D246A4
	for <linux-kernel@archiver.kernel.org>; Sat, 25 Jan 2020 10:46:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730247AbgAYKqx (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 25 Jan 2020 05:46:53 -0500
Received: from Galois.linutronix.de ([193.142.43.55]:44108 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729008AbgAYKms (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 25 Jan 2020 05:42:48 -0500
Received: from [5.158.153.53] (helo=tip-bot2.lab.linutronix.de)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tip-bot2@linutronix.de>)
        id 1ivIto-0008Ln-2Z; Sat, 25 Jan 2020 11:42:44 +0100
Received: from [127.0.1.1] (localhost [IPv6:::1])
        by tip-bot2.lab.linutronix.de (Postfix) with ESMTP id B343E1C1A72;
        Sat, 25 Jan 2020 11:42:42 +0100 (CET)
Date:   Sat, 25 Jan 2020 10:42:42 -0000
From:   "tip-bot2 for Lai Jiangshan" <tip-bot2@linutronix.de>
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: core/rcu] rcu: Provide wrappers for uses of ->rcu_read_lock_nesting
Cc:     Lai Jiangshan <laijs@linux.alibaba.com>,
        "Paul E. McKenney" <paulmck@kernel.org>, x86 <x86@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <157994896248.396.15169661003351967632.tip-bot2@tip-bot2>
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

Commit-ID:     77339e61aa309310a535bd01eb3388f7a27b36f9
Gitweb:        https://git.kernel.org/tip/77339e61aa309310a535bd01eb3388f7a27b36f9
Author:        Lai Jiangshan <laijs@linux.alibaba.com>
AuthorDate:    Fri, 15 Nov 2019 14:08:53 -08:00
Committer:     Paul E. McKenney <paulmck@kernel.org>
CommitterDate: Fri, 24 Jan 2020 10:27:33 -08:00

rcu: Provide wrappers for uses of ->rcu_read_lock_nesting

This commit provides wrapper functions for uses of ->rcu_read_lock_nesting
to improve readability and to ease future changes to support inlining
of __rcu_read_lock() and __rcu_read_unlock().

Signed-off-by: Lai Jiangshan <laijs@linux.alibaba.com>
Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
---
 kernel/rcu/tree_exp.h    |  4 +--
 kernel/rcu/tree_plugin.h | 53 +++++++++++++++++++++++++--------------
 2 files changed, 36 insertions(+), 21 deletions(-)

diff --git a/kernel/rcu/tree_exp.h b/kernel/rcu/tree_exp.h
index 98d078c..d8da6b1 100644
--- a/kernel/rcu/tree_exp.h
+++ b/kernel/rcu/tree_exp.h
@@ -610,7 +610,7 @@ static void rcu_exp_handler(void *unused)
 	 * critical section.  If also enabled or idle, immediately
 	 * report the quiescent state, otherwise defer.
 	 */
-	if (!t->rcu_read_lock_nesting) {
+	if (!rcu_preempt_depth()) {
 		if (!(preempt_count() & (PREEMPT_MASK | SOFTIRQ_MASK)) ||
 		    rcu_dynticks_curr_cpu_in_eqs()) {
 			rcu_report_exp_rdp(rdp);
@@ -634,7 +634,7 @@ static void rcu_exp_handler(void *unused)
 	 * can have caused this quiescent state to already have been
 	 * reported, so we really do need to check ->expmask.
 	 */
-	if (t->rcu_read_lock_nesting > 0) {
+	if (rcu_preempt_depth() > 0) {
 		raw_spin_lock_irqsave_rcu_node(rnp, flags);
 		if (rnp->expmask & rdp->grpmask) {
 			rdp->exp_deferred_qs = true;
diff --git a/kernel/rcu/tree_plugin.h b/kernel/rcu/tree_plugin.h
index 698a7f1..ebdbdec 100644
--- a/kernel/rcu/tree_plugin.h
+++ b/kernel/rcu/tree_plugin.h
@@ -290,8 +290,8 @@ void rcu_note_context_switch(bool preempt)
 
 	trace_rcu_utilization(TPS("Start context switch"));
 	lockdep_assert_irqs_disabled();
-	WARN_ON_ONCE(!preempt && t->rcu_read_lock_nesting > 0);
-	if (t->rcu_read_lock_nesting > 0 &&
+	WARN_ON_ONCE(!preempt && rcu_preempt_depth() > 0);
+	if (rcu_preempt_depth() > 0 &&
 	    !t->rcu_read_unlock_special.b.blocked) {
 
 		/* Possibly blocking in an RCU read-side critical section. */
@@ -348,6 +348,21 @@ static int rcu_preempt_blocked_readers_cgp(struct rcu_node *rnp)
 #define RCU_NEST_NMAX (-INT_MAX / 2)
 #define RCU_NEST_PMAX (INT_MAX / 2)
 
+static void rcu_preempt_read_enter(void)
+{
+	current->rcu_read_lock_nesting++;
+}
+
+static void rcu_preempt_read_exit(void)
+{
+	current->rcu_read_lock_nesting--;
+}
+
+static void rcu_preempt_depth_set(int val)
+{
+	current->rcu_read_lock_nesting = val;
+}
+
 /*
  * Preemptible RCU implementation for rcu_read_lock().
  * Just increment ->rcu_read_lock_nesting, shared state will be updated
@@ -355,9 +370,9 @@ static int rcu_preempt_blocked_readers_cgp(struct rcu_node *rnp)
  */
 void __rcu_read_lock(void)
 {
-	current->rcu_read_lock_nesting++;
+	rcu_preempt_read_enter();
 	if (IS_ENABLED(CONFIG_PROVE_LOCKING))
-		WARN_ON_ONCE(current->rcu_read_lock_nesting > RCU_NEST_PMAX);
+		WARN_ON_ONCE(rcu_preempt_depth() > RCU_NEST_PMAX);
 	barrier();  /* critical section after entry code. */
 }
 EXPORT_SYMBOL_GPL(__rcu_read_lock);
@@ -373,19 +388,19 @@ void __rcu_read_unlock(void)
 {
 	struct task_struct *t = current;
 
-	if (t->rcu_read_lock_nesting != 1) {
-		--t->rcu_read_lock_nesting;
+	if (rcu_preempt_depth() != 1) {
+		rcu_preempt_read_exit();
 	} else {
 		barrier();  /* critical section before exit code. */
-		t->rcu_read_lock_nesting = -RCU_NEST_BIAS;
+		rcu_preempt_depth_set(-RCU_NEST_BIAS);
 		barrier();  /* assign before ->rcu_read_unlock_special load */
 		if (unlikely(READ_ONCE(t->rcu_read_unlock_special.s)))
 			rcu_read_unlock_special(t);
 		barrier();  /* ->rcu_read_unlock_special load before assign */
-		t->rcu_read_lock_nesting = 0;
+		rcu_preempt_depth_set(0);
 	}
 	if (IS_ENABLED(CONFIG_PROVE_LOCKING)) {
-		int rrln = t->rcu_read_lock_nesting;
+		int rrln = rcu_preempt_depth();
 
 		WARN_ON_ONCE(rrln < 0 && rrln > RCU_NEST_NMAX);
 	}
@@ -539,7 +554,7 @@ static bool rcu_preempt_need_deferred_qs(struct task_struct *t)
 {
 	return (__this_cpu_read(rcu_data.exp_deferred_qs) ||
 		READ_ONCE(t->rcu_read_unlock_special.s)) &&
-	       t->rcu_read_lock_nesting <= 0;
+	       rcu_preempt_depth() <= 0;
 }
 
 /*
@@ -552,16 +567,16 @@ static bool rcu_preempt_need_deferred_qs(struct task_struct *t)
 static void rcu_preempt_deferred_qs(struct task_struct *t)
 {
 	unsigned long flags;
-	bool couldrecurse = t->rcu_read_lock_nesting >= 0;
+	bool couldrecurse = rcu_preempt_depth() >= 0;
 
 	if (!rcu_preempt_need_deferred_qs(t))
 		return;
 	if (couldrecurse)
-		t->rcu_read_lock_nesting -= RCU_NEST_BIAS;
+		rcu_preempt_depth_set(rcu_preempt_depth() - RCU_NEST_BIAS);
 	local_irq_save(flags);
 	rcu_preempt_deferred_qs_irqrestore(t, flags);
 	if (couldrecurse)
-		t->rcu_read_lock_nesting += RCU_NEST_BIAS;
+		rcu_preempt_depth_set(rcu_preempt_depth() + RCU_NEST_BIAS);
 }
 
 /*
@@ -672,7 +687,7 @@ static void rcu_flavor_sched_clock_irq(int user)
 	if (user || rcu_is_cpu_rrupt_from_idle()) {
 		rcu_note_voluntary_context_switch(current);
 	}
-	if (t->rcu_read_lock_nesting > 0 ||
+	if (rcu_preempt_depth() > 0 ||
 	    (preempt_count() & (PREEMPT_MASK | SOFTIRQ_MASK))) {
 		/* No QS, force context switch if deferred. */
 		if (rcu_preempt_need_deferred_qs(t)) {
@@ -682,13 +697,13 @@ static void rcu_flavor_sched_clock_irq(int user)
 	} else if (rcu_preempt_need_deferred_qs(t)) {
 		rcu_preempt_deferred_qs(t); /* Report deferred QS. */
 		return;
-	} else if (!t->rcu_read_lock_nesting) {
+	} else if (!rcu_preempt_depth()) {
 		rcu_qs(); /* Report immediate QS. */
 		return;
 	}
 
 	/* If GP is oldish, ask for help from rcu_read_unlock_special(). */
-	if (t->rcu_read_lock_nesting > 0 &&
+	if (rcu_preempt_depth() > 0 &&
 	    __this_cpu_read(rcu_data.core_needs_qs) &&
 	    __this_cpu_read(rcu_data.cpu_no_qs.b.norm) &&
 	    !t->rcu_read_unlock_special.b.need_qs &&
@@ -709,11 +724,11 @@ void exit_rcu(void)
 	struct task_struct *t = current;
 
 	if (unlikely(!list_empty(&current->rcu_node_entry))) {
-		t->rcu_read_lock_nesting = 1;
+		rcu_preempt_depth_set(1);
 		barrier();
 		WRITE_ONCE(t->rcu_read_unlock_special.b.blocked, true);
-	} else if (unlikely(t->rcu_read_lock_nesting)) {
-		t->rcu_read_lock_nesting = 1;
+	} else if (unlikely(rcu_preempt_depth())) {
+		rcu_preempt_depth_set(1);
 	} else {
 		return;
 	}
