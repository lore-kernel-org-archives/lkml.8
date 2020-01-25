Return-Path: <SRS0=aedO=3O=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.8 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C17A6C35243
	for <linux-kernel@archiver.kernel.org>; Sat, 25 Jan 2020 10:44:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A16C722522
	for <linux-kernel@archiver.kernel.org>; Sat, 25 Jan 2020 10:44:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730185AbgAYKoS (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 25 Jan 2020 05:44:18 -0500
Received: from Galois.linutronix.de ([193.142.43.55]:44400 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729889AbgAYKn2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 25 Jan 2020 05:43:28 -0500
Received: from [5.158.153.53] (helo=tip-bot2.lab.linutronix.de)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tip-bot2@linutronix.de>)
        id 1ivIuQ-0000FU-Jm; Sat, 25 Jan 2020 11:43:22 +0100
Received: from [127.0.1.1] (localhost [IPv6:::1])
        by tip-bot2.lab.linutronix.de (Postfix) with ESMTP id 63D8A1C1A92;
        Sat, 25 Jan 2020 11:42:57 +0100 (CET)
Date:   Sat, 25 Jan 2020 10:42:57 -0000
From:   "tip-bot2 for Paul E. McKenney" <tip-bot2@linutronix.de>
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: core/rcu] rcu: Update tree_exp.h function-header comments
Cc:     "Paul E. McKenney" <paulmck@kernel.org>, x86 <x86@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <157994897720.396.162877417793088703.tip-bot2@tip-bot2>
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

Commit-ID:     de8cd0a533bfb57ff4ec6c85e3bdca013a5adcb7
Gitweb:        https://git.kernel.org/tip/de8cd0a533bfb57ff4ec6c85e3bdca013a5adcb7
Author:        Paul E. McKenney <paulmck@kernel.org>
AuthorDate:    Wed, 27 Nov 2019 14:20:41 -08:00
Committer:     Paul E. McKenney <paulmck@kernel.org>
CommitterDate: Mon, 09 Dec 2019 12:24:58 -08:00

rcu: Update tree_exp.h function-header comments

The function-header comments in kernel/rcu/tree_exp.h have gotten a bit
out of date, so this commit updates a number of them.

Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
---
 kernel/rcu/tree_exp.h | 25 +++++++++++++------------
 1 file changed, 13 insertions(+), 12 deletions(-)

diff --git a/kernel/rcu/tree_exp.h b/kernel/rcu/tree_exp.h
index 3923c07..1eafbcd 100644
--- a/kernel/rcu/tree_exp.h
+++ b/kernel/rcu/tree_exp.h
@@ -21,7 +21,7 @@ static void rcu_exp_gp_seq_start(void)
 }
 
 /*
- * Return then value that expedited-grace-period counter will have
+ * Return the value that the expedited-grace-period counter will have
  * at the end of the current grace period.
  */
 static __maybe_unused unsigned long rcu_exp_gp_seq_endval(void)
@@ -39,7 +39,9 @@ static void rcu_exp_gp_seq_end(void)
 }
 
 /*
- * Take a snapshot of the expedited-grace-period counter.
+ * Take a snapshot of the expedited-grace-period counter, which is the
+ * earliest value that will indicate that a full grace period has
+ * elapsed since the current time.
  */
 static unsigned long rcu_exp_gp_seq_snap(void)
 {
@@ -143,22 +145,18 @@ static void __maybe_unused sync_exp_reset_tree(void)
  * Return non-zero if there is no RCU expedited grace period in progress
  * for the specified rcu_node structure, in other words, if all CPUs and
  * tasks covered by the specified rcu_node structure have done their bit
- * for the current expedited grace period.  Works only for preemptible
- * RCU -- other RCU implementation use other means.
- *
- * Caller must hold the specificed rcu_node structure's ->lock
+ * for the current expedited grace period.
  */
 static bool sync_rcu_exp_done(struct rcu_node *rnp)
 {
 	raw_lockdep_assert_held_rcu_node(rnp);
-
 	return rnp->exp_tasks == NULL &&
 	       READ_ONCE(rnp->expmask) == 0;
 }
 
 /*
- * Like sync_rcu_exp_done(), but this function assumes the caller doesn't
- * hold the rcu_node's ->lock, and will acquire and release the lock itself
+ * Like sync_rcu_exp_done(), but where the caller does not hold the
+ * rcu_node's ->lock.
  */
 static bool sync_rcu_exp_done_unlocked(struct rcu_node *rnp)
 {
@@ -180,8 +178,6 @@ static bool sync_rcu_exp_done_unlocked(struct rcu_node *rnp)
  * which the task was queued or to one of that rcu_node structure's ancestors,
  * recursively up the tree.  (Calm down, calm down, we do the recursion
  * iteratively!)
- *
- * Caller must hold the specified rcu_node structure's ->lock.
  */
 static void __rcu_report_exp_rnp(struct rcu_node *rnp,
 				 bool wake, unsigned long flags)
@@ -189,6 +185,7 @@ static void __rcu_report_exp_rnp(struct rcu_node *rnp,
 {
 	unsigned long mask;
 
+	raw_lockdep_assert_held_rcu_node(rnp);
 	for (;;) {
 		if (!sync_rcu_exp_done(rnp)) {
 			if (!rnp->expmask)
@@ -452,6 +449,10 @@ static void sync_rcu_exp_select_cpus(void)
 			flush_work(&rnp->rew.rew_work);
 }
 
+/*
+ * Wait for the expedited grace period to elapse, issuing any needed
+ * RCU CPU stall warnings along the way.
+ */
 static void synchronize_sched_expedited_wait(void)
 {
 	int cpu;
@@ -781,7 +782,7 @@ static int rcu_print_task_exp_stall(struct rcu_node *rnp)
  * implementations, it is still unfriendly to real-time workloads, so is
  * thus not recommended for any sort of common-case code.  In fact, if
  * you are using synchronize_rcu_expedited() in a loop, please restructure
- * your code to batch your updates, and then Use a single synchronize_rcu()
+ * your code to batch your updates, and then use a single synchronize_rcu()
  * instead.
  *
  * This has the same semantics as (but is more brutal than) synchronize_rcu().
