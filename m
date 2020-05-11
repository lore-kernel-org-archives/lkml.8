Return-Path: <SRS0=ABJN=6Z=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.8 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0AFEAC54E4B
	for <linux-kernel@archiver.kernel.org>; Mon, 11 May 2020 21:00:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E4B6B24960
	for <linux-kernel@archiver.kernel.org>; Mon, 11 May 2020 21:00:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732147AbgEKVAR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 11 May 2020 17:00:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44106 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1732045AbgEKU76 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 May 2020 16:59:58 -0400
Received: from Galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 33DABC061A0C;
        Mon, 11 May 2020 13:59:58 -0700 (PDT)
Received: from [5.158.153.53] (helo=tip-bot2.lab.linutronix.de)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tip-bot2@linutronix.de>)
        id 1jYFWk-0005vV-Bv; Mon, 11 May 2020 22:59:54 +0200
Received: from [127.0.1.1] (localhost [IPv6:::1])
        by tip-bot2.lab.linutronix.de (Postfix) with ESMTP id 300FD1C085B;
        Mon, 11 May 2020 22:59:37 +0200 (CEST)
Date:   Mon, 11 May 2020 20:59:37 -0000
From:   "tip-bot2 for Lai Jiangshan" <tip-bot2@linutronix.de>
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: core/rcu] rcu: Don't use negative nesting depth in __rcu_read_unlock()
Cc:     Lai Jiangshan <laijs@linux.alibaba.com>,
        "Paul E. McKenney" <paulmck@kernel.org>, x86 <x86@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <158923077713.390.2338442580919915831.tip-bot2@tip-bot2>
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

Commit-ID:     5f5fa7ea89dc82d34ed458f4d7a8634e8e9eefce
Gitweb:        https://git.kernel.org/tip/5f5fa7ea89dc82d34ed458f4d7a8634e8e9eefce
Author:        Lai Jiangshan <laijs@linux.alibaba.com>
AuthorDate:    Sat, 15 Feb 2020 15:23:26 -08:00
Committer:     Paul E. McKenney <paulmck@kernel.org>
CommitterDate: Mon, 27 Apr 2020 11:03:50 -07:00

rcu: Don't use negative nesting depth in __rcu_read_unlock()

Now that RCU flavors have been consolidated, an RCU-preempt
rcu_read_unlock() in an interrupt or softirq handler cannot possibly
end the RCU read-side critical section.  Consider the old vulnerability
involving rcu_read_unlock() being invoked within such a handler that
interrupted an __rcu_read_unlock_special(), in which a wakeup might be
invoked with a scheduler lock held.  Because rcu_read_unlock_special()
no longer does wakeups in such situations, it is no longer necessary
for __rcu_read_unlock() to set the nesting level negative.

This commit therefore removes this recursion-protection code from
__rcu_read_unlock().

[ paulmck: Let rcu_exp_handler() continue to call rcu_report_exp_rdp(). ]
[ paulmck: Adjust other checks given no more negative nesting. ]
Signed-off-by: Lai Jiangshan <laijs@linux.alibaba.com>
Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
---
 kernel/rcu/tree_exp.h    | 31 +++++--------------------------
 kernel/rcu/tree_plugin.h | 22 +++++++---------------
 2 files changed, 12 insertions(+), 41 deletions(-)

diff --git a/kernel/rcu/tree_exp.h b/kernel/rcu/tree_exp.h
index 1a617b9..0e5ccb3 100644
--- a/kernel/rcu/tree_exp.h
+++ b/kernel/rcu/tree_exp.h
@@ -639,6 +639,7 @@ static void wait_rcu_exp_gp(struct work_struct *wp)
  */
 static void rcu_exp_handler(void *unused)
 {
+	int depth = rcu_preempt_depth();
 	unsigned long flags;
 	struct rcu_data *rdp = this_cpu_ptr(&rcu_data);
 	struct rcu_node *rnp = rdp->mynode;
@@ -649,7 +650,7 @@ static void rcu_exp_handler(void *unused)
 	 * critical section.  If also enabled or idle, immediately
 	 * report the quiescent state, otherwise defer.
 	 */
-	if (!rcu_preempt_depth()) {
+	if (!depth) {
 		if (!(preempt_count() & (PREEMPT_MASK | SOFTIRQ_MASK)) ||
 		    rcu_dynticks_curr_cpu_in_eqs()) {
 			rcu_report_exp_rdp(rdp);
@@ -673,7 +674,7 @@ static void rcu_exp_handler(void *unused)
 	 * can have caused this quiescent state to already have been
 	 * reported, so we really do need to check ->expmask.
 	 */
-	if (rcu_preempt_depth() > 0) {
+	if (depth > 0) {
 		raw_spin_lock_irqsave_rcu_node(rnp, flags);
 		if (rnp->expmask & rdp->grpmask) {
 			rdp->exp_deferred_qs = true;
@@ -683,30 +684,8 @@ static void rcu_exp_handler(void *unused)
 		return;
 	}
 
-	/*
-	 * The final and least likely case is where the interrupted
-	 * code was just about to or just finished exiting the RCU-preempt
-	 * read-side critical section, and no, we can't tell which.
-	 * So either way, set ->deferred_qs to flag later code that
-	 * a quiescent state is required.
-	 *
-	 * If the CPU is fully enabled (or if some buggy RCU-preempt
-	 * read-side critical section is being used from idle), just
-	 * invoke rcu_preempt_deferred_qs() to immediately report the
-	 * quiescent state.  We cannot use rcu_read_unlock_special()
-	 * because we are in an interrupt handler, which will cause that
-	 * function to take an early exit without doing anything.
-	 *
-	 * Otherwise, force a context switch after the CPU enables everything.
-	 */
-	rdp->exp_deferred_qs = true;
-	if (!(preempt_count() & (PREEMPT_MASK | SOFTIRQ_MASK)) ||
-	    WARN_ON_ONCE(rcu_dynticks_curr_cpu_in_eqs())) {
-		rcu_preempt_deferred_qs(t);
-	} else {
-		set_tsk_need_resched(t);
-		set_preempt_need_resched();
-	}
+	// Finally, negative nesting depth should not happen.
+	WARN_ON_ONCE(1);
 }
 
 /* PREEMPTION=y, so no PREEMPTION=n expedited grace period to clean up after. */
diff --git a/kernel/rcu/tree_plugin.h b/kernel/rcu/tree_plugin.h
index f31c599..088e84e 100644
--- a/kernel/rcu/tree_plugin.h
+++ b/kernel/rcu/tree_plugin.h
@@ -345,9 +345,7 @@ static int rcu_preempt_blocked_readers_cgp(struct rcu_node *rnp)
 	return READ_ONCE(rnp->gp_tasks) != NULL;
 }
 
-/* Bias and limit values for ->rcu_read_lock_nesting. */
-#define RCU_NEST_BIAS INT_MAX
-#define RCU_NEST_NMAX (-INT_MAX / 2)
+/* limit value for ->rcu_read_lock_nesting. */
 #define RCU_NEST_PMAX (INT_MAX / 2)
 
 static void rcu_preempt_read_enter(void)
@@ -355,9 +353,9 @@ static void rcu_preempt_read_enter(void)
 	current->rcu_read_lock_nesting++;
 }
 
-static void rcu_preempt_read_exit(void)
+static int rcu_preempt_read_exit(void)
 {
-	current->rcu_read_lock_nesting--;
+	return --current->rcu_read_lock_nesting;
 }
 
 static void rcu_preempt_depth_set(int val)
@@ -390,21 +388,15 @@ void __rcu_read_unlock(void)
 {
 	struct task_struct *t = current;
 
-	if (rcu_preempt_depth() != 1) {
-		rcu_preempt_read_exit();
-	} else {
+	if (rcu_preempt_read_exit() == 0) {
 		barrier();  /* critical section before exit code. */
-		rcu_preempt_depth_set(-RCU_NEST_BIAS);
-		barrier();  /* assign before ->rcu_read_unlock_special load */
 		if (unlikely(READ_ONCE(t->rcu_read_unlock_special.s)))
 			rcu_read_unlock_special(t);
-		barrier();  /* ->rcu_read_unlock_special load before assign */
-		rcu_preempt_depth_set(0);
 	}
 	if (IS_ENABLED(CONFIG_PROVE_LOCKING)) {
 		int rrln = rcu_preempt_depth();
 
-		WARN_ON_ONCE(rrln < 0 && rrln > RCU_NEST_NMAX);
+		WARN_ON_ONCE(rrln < 0 || rrln > RCU_NEST_PMAX);
 	}
 }
 EXPORT_SYMBOL_GPL(__rcu_read_unlock);
@@ -556,7 +548,7 @@ static bool rcu_preempt_need_deferred_qs(struct task_struct *t)
 {
 	return (__this_cpu_read(rcu_data.exp_deferred_qs) ||
 		READ_ONCE(t->rcu_read_unlock_special.s)) &&
-	       rcu_preempt_depth() <= 0;
+	       rcu_preempt_depth() == 0;
 }
 
 /*
@@ -692,7 +684,7 @@ static void rcu_flavor_sched_clock_irq(int user)
 	} else if (rcu_preempt_need_deferred_qs(t)) {
 		rcu_preempt_deferred_qs(t); /* Report deferred QS. */
 		return;
-	} else if (!rcu_preempt_depth()) {
+	} else if (!WARN_ON_ONCE(rcu_preempt_depth())) {
 		rcu_qs(); /* Report immediate QS. */
 		return;
 	}
