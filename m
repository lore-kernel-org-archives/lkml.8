Return-Path: <SRS0=tn8d=5J=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.8 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 435DFC4332B
	for <linux-kernel@archiver.kernel.org>; Tue, 24 Mar 2020 09:17:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1362220A8B
	for <linux-kernel@archiver.kernel.org>; Tue, 24 Mar 2020 09:17:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727462AbgCXJRz (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 24 Mar 2020 05:17:55 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:44115 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727805AbgCXJRM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 Mar 2020 05:17:12 -0400
Received: from [5.158.153.53] (helo=tip-bot2.lab.linutronix.de)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tip-bot2@linutronix.de>)
        id 1jGfgM-0008Gk-Kb; Tue, 24 Mar 2020 10:17:10 +0100
Received: from [127.0.1.1] (localhost [IPv6:::1])
        by tip-bot2.lab.linutronix.de (Postfix) with ESMTP id 980AE1C04D5;
        Tue, 24 Mar 2020 10:16:52 +0100 (CET)
Date:   Tue, 24 Mar 2020 09:16:52 -0000
From:   "tip-bot2 for Paul E. McKenney" <tip-bot2@linutronix.de>
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: core/rcu] rcu: Add *_ONCE() for grace-period progress indicators
Cc:     "Paul E. McKenney" <paulmck@kernel.org>, x86 <x86@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <158504141230.28353.12723701512850417791.tip-bot2@tip-bot2>
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

Commit-ID:     8ff37290d6622e130553a38ec2662a728e46cdba
Gitweb:        https://git.kernel.org/tip/8ff37290d6622e130553a38ec2662a728e46cdba
Author:        Paul E. McKenney <paulmck@kernel.org>
AuthorDate:    Sat, 04 Jan 2020 11:33:17 -08:00
Committer:     Paul E. McKenney <paulmck@kernel.org>
CommitterDate: Thu, 20 Feb 2020 15:58:22 -08:00

rcu: Add *_ONCE() for grace-period progress indicators

The various RCU structures' ->gp_seq, ->gp_seq_needed, ->gp_req_activity,
and ->gp_activity fields are read locklessly, so they must be updated with
WRITE_ONCE() and, when read locklessly, with READ_ONCE().  This commit makes
these changes.

This data race was reported by KCSAN.  Not appropriate for backporting
due to failure being unlikely.

Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
---
 kernel/rcu/tree.c        | 14 +++++++-------
 kernel/rcu/tree_plugin.h |  2 +-
 kernel/rcu/tree_stall.h  | 26 +++++++++++++++-----------
 3 files changed, 23 insertions(+), 19 deletions(-)

diff --git a/kernel/rcu/tree.c b/kernel/rcu/tree.c
index 346321a..53946b1 100644
--- a/kernel/rcu/tree.c
+++ b/kernel/rcu/tree.c
@@ -1175,7 +1175,7 @@ static bool rcu_start_this_gp(struct rcu_node *rnp_start, struct rcu_data *rdp,
 					  TPS("Prestarted"));
 			goto unlock_out;
 		}
-		rnp->gp_seq_needed = gp_seq_req;
+		WRITE_ONCE(rnp->gp_seq_needed, gp_seq_req);
 		if (rcu_seq_state(rcu_seq_current(&rnp->gp_seq))) {
 			/*
 			 * We just marked the leaf or internal node, and a
@@ -1210,8 +1210,8 @@ static bool rcu_start_this_gp(struct rcu_node *rnp_start, struct rcu_data *rdp,
 unlock_out:
 	/* Push furthest requested GP to leaf node and rcu_data structure. */
 	if (ULONG_CMP_LT(gp_seq_req, rnp->gp_seq_needed)) {
-		rnp_start->gp_seq_needed = rnp->gp_seq_needed;
-		rdp->gp_seq_needed = rnp->gp_seq_needed;
+		WRITE_ONCE(rnp_start->gp_seq_needed, rnp->gp_seq_needed);
+		WRITE_ONCE(rdp->gp_seq_needed, rnp->gp_seq_needed);
 	}
 	if (rnp != rnp_start)
 		raw_spin_unlock_rcu_node(rnp);
@@ -1423,7 +1423,7 @@ static bool __note_gp_changes(struct rcu_node *rnp, struct rcu_data *rdp)
 	}
 	rdp->gp_seq = rnp->gp_seq;  /* Remember new grace-period state. */
 	if (ULONG_CMP_LT(rdp->gp_seq_needed, rnp->gp_seq_needed) || rdp->gpwrap)
-		rdp->gp_seq_needed = rnp->gp_seq_needed;
+		WRITE_ONCE(rdp->gp_seq_needed, rnp->gp_seq_needed);
 	WRITE_ONCE(rdp->gpwrap, false);
 	rcu_gpnum_ovf(rnp, rdp);
 	return ret;
@@ -3276,12 +3276,12 @@ int rcutree_prepare_cpu(unsigned int cpu)
 	rnp = rdp->mynode;
 	raw_spin_lock_rcu_node(rnp);		/* irqs already disabled. */
 	rdp->beenonline = true;	 /* We have now been online. */
-	rdp->gp_seq = rnp->gp_seq;
-	rdp->gp_seq_needed = rnp->gp_seq;
+	rdp->gp_seq = READ_ONCE(rnp->gp_seq);
+	rdp->gp_seq_needed = rdp->gp_seq;
 	rdp->cpu_no_qs.b.norm = true;
 	rdp->core_needs_qs = false;
 	rdp->rcu_iw_pending = false;
-	rdp->rcu_iw_gp_seq = rnp->gp_seq - 1;
+	rdp->rcu_iw_gp_seq = rdp->gp_seq - 1;
 	trace_rcu_grace_period(rcu_state.name, rdp->gp_seq, TPS("cpuonl"));
 	raw_spin_unlock_irqrestore_rcu_node(rnp, flags);
 	rcu_prepare_kthreads(cpu);
diff --git a/kernel/rcu/tree_plugin.h b/kernel/rcu/tree_plugin.h
index c6ea81c..b5ba148 100644
--- a/kernel/rcu/tree_plugin.h
+++ b/kernel/rcu/tree_plugin.h
@@ -753,7 +753,7 @@ dump_blkd_tasks(struct rcu_node *rnp, int ncheck)
 	raw_lockdep_assert_held_rcu_node(rnp);
 	pr_info("%s: grp: %d-%d level: %d ->gp_seq %ld ->completedqs %ld\n",
 		__func__, rnp->grplo, rnp->grphi, rnp->level,
-		(long)rnp->gp_seq, (long)rnp->completedqs);
+		(long)READ_ONCE(rnp->gp_seq), (long)rnp->completedqs);
 	for (rnp1 = rnp; rnp1; rnp1 = rnp1->parent)
 		pr_info("%s: %d:%d ->qsmask %#lx ->qsmaskinit %#lx ->qsmaskinitnext %#lx\n",
 			__func__, rnp1->grplo, rnp1->grphi, rnp1->qsmask, rnp1->qsmaskinit, rnp1->qsmaskinitnext);
diff --git a/kernel/rcu/tree_stall.h b/kernel/rcu/tree_stall.h
index 55f9b84..43dc688 100644
--- a/kernel/rcu/tree_stall.h
+++ b/kernel/rcu/tree_stall.h
@@ -592,21 +592,22 @@ void show_rcu_gp_kthreads(void)
 		(long)READ_ONCE(rcu_get_root()->gp_seq_needed),
 		READ_ONCE(rcu_state.gp_flags));
 	rcu_for_each_node_breadth_first(rnp) {
-		if (ULONG_CMP_GE(rcu_state.gp_seq, rnp->gp_seq_needed))
+		if (ULONG_CMP_GE(READ_ONCE(rcu_state.gp_seq),
+				 READ_ONCE(rnp->gp_seq_needed)))
 			continue;
 		pr_info("\trcu_node %d:%d ->gp_seq %ld ->gp_seq_needed %ld\n",
-			rnp->grplo, rnp->grphi, (long)rnp->gp_seq,
-			(long)rnp->gp_seq_needed);
+			rnp->grplo, rnp->grphi, (long)READ_ONCE(rnp->gp_seq),
+			(long)READ_ONCE(rnp->gp_seq_needed));
 		if (!rcu_is_leaf_node(rnp))
 			continue;
 		for_each_leaf_node_possible_cpu(rnp, cpu) {
 			rdp = per_cpu_ptr(&rcu_data, cpu);
 			if (rdp->gpwrap ||
-			    ULONG_CMP_GE(rcu_state.gp_seq,
-					 rdp->gp_seq_needed))
+			    ULONG_CMP_GE(READ_ONCE(rcu_state.gp_seq),
+					 READ_ONCE(rdp->gp_seq_needed)))
 				continue;
 			pr_info("\tcpu %d ->gp_seq_needed %ld\n",
-				cpu, (long)rdp->gp_seq_needed);
+				cpu, (long)READ_ONCE(rdp->gp_seq_needed));
 		}
 	}
 	for_each_possible_cpu(cpu) {
@@ -631,7 +632,8 @@ static void rcu_check_gp_start_stall(struct rcu_node *rnp, struct rcu_data *rdp,
 	static atomic_t warned = ATOMIC_INIT(0);
 
 	if (!IS_ENABLED(CONFIG_PROVE_RCU) || rcu_gp_in_progress() ||
-	    ULONG_CMP_GE(rnp_root->gp_seq, rnp_root->gp_seq_needed))
+	    ULONG_CMP_GE(READ_ONCE(rnp_root->gp_seq),
+			 READ_ONCE(rnp_root->gp_seq_needed)))
 		return;
 	j = jiffies; /* Expensive access, and in common case don't get here. */
 	if (time_before(j, READ_ONCE(rcu_state.gp_req_activity) + gpssdelay) ||
@@ -642,7 +644,8 @@ static void rcu_check_gp_start_stall(struct rcu_node *rnp, struct rcu_data *rdp,
 	raw_spin_lock_irqsave_rcu_node(rnp, flags);
 	j = jiffies;
 	if (rcu_gp_in_progress() ||
-	    ULONG_CMP_GE(rnp_root->gp_seq, rnp_root->gp_seq_needed) ||
+	    ULONG_CMP_GE(READ_ONCE(rnp_root->gp_seq),
+			 READ_ONCE(rnp_root->gp_seq_needed)) ||
 	    time_before(j, READ_ONCE(rcu_state.gp_req_activity) + gpssdelay) ||
 	    time_before(j, READ_ONCE(rcu_state.gp_activity) + gpssdelay) ||
 	    atomic_read(&warned)) {
@@ -655,9 +658,10 @@ static void rcu_check_gp_start_stall(struct rcu_node *rnp, struct rcu_data *rdp,
 		raw_spin_lock_rcu_node(rnp_root); /* irqs already disabled. */
 	j = jiffies;
 	if (rcu_gp_in_progress() ||
-	    ULONG_CMP_GE(rnp_root->gp_seq, rnp_root->gp_seq_needed) ||
-	    time_before(j, rcu_state.gp_req_activity + gpssdelay) ||
-	    time_before(j, rcu_state.gp_activity + gpssdelay) ||
+	    ULONG_CMP_GE(READ_ONCE(rnp_root->gp_seq),
+			 READ_ONCE(rnp_root->gp_seq_needed)) ||
+	    time_before(j, READ_ONCE(rcu_state.gp_req_activity) + gpssdelay) ||
+	    time_before(j, READ_ONCE(rcu_state.gp_activity) + gpssdelay) ||
 	    atomic_xchg(&warned, 1)) {
 		if (rnp_root != rnp)
 			/* irqs remain disabled. */
