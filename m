Return-Path: <SRS0=ABJN=6Z=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.8 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 39BAFC47255
	for <linux-kernel@archiver.kernel.org>; Mon, 11 May 2020 21:01:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1649620836
	for <linux-kernel@archiver.kernel.org>; Mon, 11 May 2020 21:01:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732237AbgEKVBD (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 11 May 2020 17:01:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44166 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1732103AbgEKVAH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 May 2020 17:00:07 -0400
Received: from Galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 76B6EC05BD0A;
        Mon, 11 May 2020 14:00:07 -0700 (PDT)
Received: from [5.158.153.53] (helo=tip-bot2.lab.linutronix.de)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tip-bot2@linutronix.de>)
        id 1jYFWv-00064I-N7; Mon, 11 May 2020 23:00:05 +0200
Received: from [127.0.1.1] (localhost [IPv6:::1])
        by tip-bot2.lab.linutronix.de (Postfix) with ESMTP id A00861C0873;
        Mon, 11 May 2020 22:59:46 +0200 (CEST)
Date:   Mon, 11 May 2020 20:59:46 -0000
From:   "tip-bot2 for Paul E. McKenney" <tip-bot2@linutronix.de>
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: core/rcu] rcu: Add *_ONCE() and data_race() to rcu_node
 ->exp_tasks plus locking
Cc:     "Paul E. McKenney" <paulmck@kernel.org>, x86 <x86@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <158923078653.390.10878959698132594636.tip-bot2@tip-bot2>
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

Commit-ID:     314eeb43e5f22856b281c91c966e51e5782a3498
Gitweb:        https://git.kernel.org/tip/314eeb43e5f22856b281c91c966e51e5782a3498
Author:        Paul E. McKenney <paulmck@kernel.org>
AuthorDate:    Fri, 03 Jan 2020 14:18:12 -08:00
Committer:     Paul E. McKenney <paulmck@kernel.org>
CommitterDate: Mon, 27 Apr 2020 11:01:15 -07:00

rcu: Add *_ONCE() and data_race() to rcu_node ->exp_tasks plus locking

There are lockless loads from the rcu_node structure's ->exp_tasks field,
so this commit causes all stores to use WRITE_ONCE() and all lockless
loads to use READ_ONCE() or data_race(), with the latter for debug
prints.  This code also did a unprotected traversal of the linked list
pointed into by ->exp_tasks, so this commit also acquires the rcu_node
structure's ->lock to properly protect this traversal.  This list was
traversed unprotected only when printing an RCU CPU stall warning for
an expedited grace period, so the odds of seeing this in production are
not all that high.

This data race was reported by KCSAN.

Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
---
 kernel/rcu/tree_exp.h    | 19 +++++++++++--------
 kernel/rcu/tree_plugin.h |  8 ++++----
 2 files changed, 15 insertions(+), 12 deletions(-)

diff --git a/kernel/rcu/tree_exp.h b/kernel/rcu/tree_exp.h
index 1a617b9..c2b04da 100644
--- a/kernel/rcu/tree_exp.h
+++ b/kernel/rcu/tree_exp.h
@@ -150,7 +150,7 @@ static void __maybe_unused sync_exp_reset_tree(void)
 static bool sync_rcu_exp_done(struct rcu_node *rnp)
 {
 	raw_lockdep_assert_held_rcu_node(rnp);
-	return rnp->exp_tasks == NULL &&
+	return READ_ONCE(rnp->exp_tasks) == NULL &&
 	       READ_ONCE(rnp->expmask) == 0;
 }
 
@@ -373,7 +373,7 @@ static void sync_rcu_exp_select_node_cpus(struct work_struct *wp)
 	 * until such time as the ->expmask bits are cleared.
 	 */
 	if (rcu_preempt_has_tasks(rnp))
-		rnp->exp_tasks = rnp->blkd_tasks.next;
+		WRITE_ONCE(rnp->exp_tasks, rnp->blkd_tasks.next);
 	raw_spin_unlock_irqrestore_rcu_node(rnp, flags);
 
 	/* IPI the remaining CPUs for expedited quiescent state. */
@@ -542,8 +542,8 @@ static void synchronize_rcu_expedited_wait(void)
 		}
 		pr_cont(" } %lu jiffies s: %lu root: %#lx/%c\n",
 			jiffies - jiffies_start, rcu_state.expedited_sequence,
-			READ_ONCE(rnp_root->expmask),
-			".T"[!!rnp_root->exp_tasks]);
+			data_race(rnp_root->expmask),
+			".T"[!!data_race(rnp_root->exp_tasks)]);
 		if (ndetected) {
 			pr_err("blocking rcu_node structures:");
 			rcu_for_each_node_breadth_first(rnp) {
@@ -553,8 +553,8 @@ static void synchronize_rcu_expedited_wait(void)
 					continue;
 				pr_cont(" l=%u:%d-%d:%#lx/%c",
 					rnp->level, rnp->grplo, rnp->grphi,
-					READ_ONCE(rnp->expmask),
-					".T"[!!rnp->exp_tasks]);
+					data_race(rnp->expmask),
+					".T"[!!data_race(rnp->exp_tasks)]);
 			}
 			pr_cont("\n");
 		}
@@ -721,17 +721,20 @@ static void sync_sched_exp_online_cleanup(int cpu)
  */
 static int rcu_print_task_exp_stall(struct rcu_node *rnp)
 {
-	struct task_struct *t;
+	unsigned long flags;
 	int ndetected = 0;
+	struct task_struct *t;
 
-	if (!rnp->exp_tasks)
+	if (!READ_ONCE(rnp->exp_tasks))
 		return 0;
+	raw_spin_lock_irqsave_rcu_node(rnp, flags);
 	t = list_entry(rnp->exp_tasks->prev,
 		       struct task_struct, rcu_node_entry);
 	list_for_each_entry_continue(t, &rnp->blkd_tasks, rcu_node_entry) {
 		pr_cont(" P%d", t->pid);
 		ndetected++;
 	}
+	raw_spin_unlock_irqrestore_rcu_node(rnp, flags);
 	return ndetected;
 }
 
diff --git a/kernel/rcu/tree_plugin.h b/kernel/rcu/tree_plugin.h
index 097635c..35d77db 100644
--- a/kernel/rcu/tree_plugin.h
+++ b/kernel/rcu/tree_plugin.h
@@ -226,7 +226,7 @@ static void rcu_preempt_ctxt_queue(struct rcu_node *rnp, struct rcu_data *rdp)
 		WARN_ON_ONCE(rnp->completedqs == rnp->gp_seq);
 	}
 	if (!rnp->exp_tasks && (blkd_state & RCU_EXP_BLKD))
-		rnp->exp_tasks = &t->rcu_node_entry;
+		WRITE_ONCE(rnp->exp_tasks, &t->rcu_node_entry);
 	WARN_ON_ONCE(!(blkd_state & RCU_GP_BLKD) !=
 		     !(rnp->qsmask & rdp->grpmask));
 	WARN_ON_ONCE(!(blkd_state & RCU_EXP_BLKD) !=
@@ -500,7 +500,7 @@ rcu_preempt_deferred_qs_irqrestore(struct task_struct *t, unsigned long flags)
 		if (&t->rcu_node_entry == rnp->gp_tasks)
 			WRITE_ONCE(rnp->gp_tasks, np);
 		if (&t->rcu_node_entry == rnp->exp_tasks)
-			rnp->exp_tasks = np;
+			WRITE_ONCE(rnp->exp_tasks, np);
 		if (IS_ENABLED(CONFIG_RCU_BOOST)) {
 			/* Snapshot ->boost_mtx ownership w/rnp->lock held. */
 			drop_boost_mutex = rt_mutex_owner(&rnp->boost_mtx) == t;
@@ -761,7 +761,7 @@ dump_blkd_tasks(struct rcu_node *rnp, int ncheck)
 			__func__, rnp1->grplo, rnp1->grphi, rnp1->qsmask, rnp1->qsmaskinit, rnp1->qsmaskinitnext);
 	pr_info("%s: ->gp_tasks %p ->boost_tasks %p ->exp_tasks %p\n",
 		__func__, READ_ONCE(rnp->gp_tasks), rnp->boost_tasks,
-		rnp->exp_tasks);
+		READ_ONCE(rnp->exp_tasks));
 	pr_info("%s: ->blkd_tasks", __func__);
 	i = 0;
 	list_for_each(lhp, &rnp->blkd_tasks) {
@@ -1036,7 +1036,7 @@ static int rcu_boost_kthread(void *arg)
 	for (;;) {
 		WRITE_ONCE(rnp->boost_kthread_status, RCU_KTHREAD_WAITING);
 		trace_rcu_utilization(TPS("End boost kthread@rcu_wait"));
-		rcu_wait(rnp->boost_tasks || rnp->exp_tasks);
+		rcu_wait(rnp->boost_tasks || READ_ONCE(rnp->exp_tasks));
 		trace_rcu_utilization(TPS("Start boost kthread@rcu_wait"));
 		WRITE_ONCE(rnp->boost_kthread_status, RCU_KTHREAD_RUNNING);
 		more2boost = rcu_boost(rnp);
