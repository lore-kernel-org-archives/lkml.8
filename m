Return-Path: <SRS0=aedO=3O=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.8 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 48BAEC2D0DB
	for <linux-kernel@archiver.kernel.org>; Sat, 25 Jan 2020 10:45:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 25DB922522
	for <linux-kernel@archiver.kernel.org>; Sat, 25 Jan 2020 10:45:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729221AbgAYKpA (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 25 Jan 2020 05:45:00 -0500
Received: from Galois.linutronix.de ([193.142.43.55]:44349 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729794AbgAYKnU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 25 Jan 2020 05:43:20 -0500
Received: from [5.158.153.53] (helo=tip-bot2.lab.linutronix.de)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tip-bot2@linutronix.de>)
        id 1ivIuM-0000Fc-T1; Sat, 25 Jan 2020 11:43:19 +0100
Received: from [127.0.1.1] (localhost [IPv6:::1])
        by tip-bot2.lab.linutronix.de (Postfix) with ESMTP id ABC1D1C1A80;
        Sat, 25 Jan 2020 11:42:57 +0100 (CET)
Date:   Sat, 25 Jan 2020 10:42:57 -0000
From:   "tip-bot2 for Paul E. McKenney" <tip-bot2@linutronix.de>
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: core/rcu] rcu: Rename sync_rcu_preempt_exp_done() to
 sync_rcu_exp_done()
Cc:     "Paul E. McKenney" <paulmck@kernel.org>, x86 <x86@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <157994897747.396.6589643149912732458.tip-bot2@tip-bot2>
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

Commit-ID:     6c7d7dbf5b7f965eda0d39fbbb8fee005b08f340
Gitweb:        https://git.kernel.org/tip/6c7d7dbf5b7f965eda0d39fbbb8fee005b08f340
Author:        Paul E. McKenney <paulmck@kernel.org>
AuthorDate:    Wed, 27 Nov 2019 13:59:37 -08:00
Committer:     Paul E. McKenney <paulmck@kernel.org>
CommitterDate: Mon, 09 Dec 2019 12:24:58 -08:00

rcu: Rename sync_rcu_preempt_exp_done() to sync_rcu_exp_done()

Now that the RCU flavors have been consolidated, there is one common
function for checking to see if an expedited RCU grace period has
completed, namely sync_rcu_preempt_exp_done().  Because this function is
no longer specific to RCU-preempt, this commit removes the "_preempt" from
its name.  This commit also changes sync_rcu_preempt_exp_done_unlocked()
to sync_rcu_exp_done_unlocked() for the same reason.

Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
---
 kernel/rcu/tree_exp.h    | 19 +++++++++----------
 kernel/rcu/tree_plugin.h |  4 ++--
 2 files changed, 11 insertions(+), 12 deletions(-)

diff --git a/kernel/rcu/tree_exp.h b/kernel/rcu/tree_exp.h
index 7a1f093..3923c07 100644
--- a/kernel/rcu/tree_exp.h
+++ b/kernel/rcu/tree_exp.h
@@ -148,7 +148,7 @@ static void __maybe_unused sync_exp_reset_tree(void)
  *
  * Caller must hold the specificed rcu_node structure's ->lock
  */
-static bool sync_rcu_preempt_exp_done(struct rcu_node *rnp)
+static bool sync_rcu_exp_done(struct rcu_node *rnp)
 {
 	raw_lockdep_assert_held_rcu_node(rnp);
 
@@ -157,17 +157,16 @@ static bool sync_rcu_preempt_exp_done(struct rcu_node *rnp)
 }
 
 /*
- * Like sync_rcu_preempt_exp_done(), but this function assumes the caller
- * doesn't hold the rcu_node's ->lock, and will acquire and release the lock
- * itself
+ * Like sync_rcu_exp_done(), but this function assumes the caller doesn't
+ * hold the rcu_node's ->lock, and will acquire and release the lock itself
  */
-static bool sync_rcu_preempt_exp_done_unlocked(struct rcu_node *rnp)
+static bool sync_rcu_exp_done_unlocked(struct rcu_node *rnp)
 {
 	unsigned long flags;
 	bool ret;
 
 	raw_spin_lock_irqsave_rcu_node(rnp, flags);
-	ret = sync_rcu_preempt_exp_done(rnp);
+	ret = sync_rcu_exp_done(rnp);
 	raw_spin_unlock_irqrestore_rcu_node(rnp, flags);
 
 	return ret;
@@ -191,7 +190,7 @@ static void __rcu_report_exp_rnp(struct rcu_node *rnp,
 	unsigned long mask;
 
 	for (;;) {
-		if (!sync_rcu_preempt_exp_done(rnp)) {
+		if (!sync_rcu_exp_done(rnp)) {
 			if (!rnp->expmask)
 				rcu_initiate_boost(rnp, flags);
 			else
@@ -471,9 +470,9 @@ static void synchronize_sched_expedited_wait(void)
 	for (;;) {
 		ret = swait_event_timeout_exclusive(
 				rcu_state.expedited_wq,
-				sync_rcu_preempt_exp_done_unlocked(rnp_root),
+				sync_rcu_exp_done_unlocked(rnp_root),
 				jiffies_stall);
-		if (ret > 0 || sync_rcu_preempt_exp_done_unlocked(rnp_root))
+		if (ret > 0 || sync_rcu_exp_done_unlocked(rnp_root))
 			return;
 		WARN_ON(ret < 0);  /* workqueues should not be signaled. */
 		if (rcu_cpu_stall_suppress)
@@ -507,7 +506,7 @@ static void synchronize_sched_expedited_wait(void)
 			rcu_for_each_node_breadth_first(rnp) {
 				if (rnp == rnp_root)
 					continue; /* printed unconditionally */
-				if (sync_rcu_preempt_exp_done_unlocked(rnp))
+				if (sync_rcu_exp_done_unlocked(rnp))
 					continue;
 				pr_cont(" l=%u:%d-%d:%#lx/%c",
 					rnp->level, rnp->grplo, rnp->grphi,
diff --git a/kernel/rcu/tree_plugin.h b/kernel/rcu/tree_plugin.h
index fa08d55..6dbea4b 100644
--- a/kernel/rcu/tree_plugin.h
+++ b/kernel/rcu/tree_plugin.h
@@ -485,7 +485,7 @@ rcu_preempt_deferred_qs_irqrestore(struct task_struct *t, unsigned long flags)
 		empty_norm = !rcu_preempt_blocked_readers_cgp(rnp);
 		WARN_ON_ONCE(rnp->completedqs == rnp->gp_seq &&
 			     (!empty_norm || rnp->qsmask));
-		empty_exp = sync_rcu_preempt_exp_done(rnp);
+		empty_exp = sync_rcu_exp_done(rnp);
 		smp_mb(); /* ensure expedited fastpath sees end of RCU c-s. */
 		np = rcu_next_node_entry(t, rnp);
 		list_del_init(&t->rcu_node_entry);
@@ -509,7 +509,7 @@ rcu_preempt_deferred_qs_irqrestore(struct task_struct *t, unsigned long flags)
 		 * Note that rcu_report_unblock_qs_rnp() releases rnp->lock,
 		 * so we must take a snapshot of the expedited state.
 		 */
-		empty_exp_now = sync_rcu_preempt_exp_done(rnp);
+		empty_exp_now = sync_rcu_exp_done(rnp);
 		if (!empty_norm && !rcu_preempt_blocked_readers_cgp(rnp)) {
 			trace_rcu_quiescent_state_report(TPS("preempt_rcu"),
 							 rnp->gp_seq,
