Return-Path: <SRS0=tn8d=5J=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.8 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 79F7CC41621
	for <linux-kernel@archiver.kernel.org>; Tue, 24 Mar 2020 09:17:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5523820A8B
	for <linux-kernel@archiver.kernel.org>; Tue, 24 Mar 2020 09:17:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727901AbgCXJRT (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 24 Mar 2020 05:17:19 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:44098 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727675AbgCXJRK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 Mar 2020 05:17:10 -0400
Received: from [5.158.153.53] (helo=tip-bot2.lab.linutronix.de)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tip-bot2@linutronix.de>)
        id 1jGfgF-0008Ba-I1; Tue, 24 Mar 2020 10:17:03 +0100
Received: from [127.0.1.1] (localhost [IPv6:::1])
        by tip-bot2.lab.linutronix.de (Postfix) with ESMTP id 49AD91C04DF;
        Tue, 24 Mar 2020 10:16:48 +0100 (CET)
Date:   Tue, 24 Mar 2020 09:16:47 -0000
From:   "tip-bot2 for Paul E. McKenney" <tip-bot2@linutronix.de>
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: core/rcu] rcu: Don't flag non-starting GPs before GP kthread is running
Cc:     Qian Cai <cai@lca.pw>, "Paul E. McKenney" <paulmck@kernel.org>,
        x86 <x86@kernel.org>, LKML <linux-kernel@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <158504140797.28353.607331076665025873.tip-bot2@tip-bot2>
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

Commit-ID:     5648d6591230c811972543ff146ce969babdd732
Gitweb:        https://git.kernel.org/tip/5648d6591230c811972543ff146ce969babdd732
Author:        Paul E. McKenney <paulmck@kernel.org>
AuthorDate:    Tue, 21 Jan 2020 12:30:22 -08:00
Committer:     Paul E. McKenney <paulmck@kernel.org>
CommitterDate: Thu, 20 Feb 2020 15:58:23 -08:00

rcu: Don't flag non-starting GPs before GP kthread is running

Currently rcu_check_gp_start_stall() complains if a grace period takes
too long to start, where "too long" is roughly one RCU CPU stall-warning
interval.  This has worked well, but there are some debugging Kconfig
options (such as CONFIG_EFI_PGT_DUMP=y) that can make booting take a
very long time, so much so that the stall-warning interval has expired
before RCU's grace-period kthread has even been spawned.

This commit therefore resets the rcu_state.gp_req_activity and
rcu_state.gp_activity timestamps just before the grace-period kthread
is spawned, and modifies the checks and adds ordering to ensure that
if rcu_check_gp_start_stall() sees that the grace-period kthread
has been spawned, that it will also see the resets applied to the
rcu_state.gp_req_activity and rcu_state.gp_activity timestamps.

Reported-by: Qian Cai <cai@lca.pw>
Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
[ paulmck: Fix whitespace issues reported by Qian Cai. ]
Tested-by: Qian Cai <cai@lca.pw>
[ paulmck: Simplify grace-period wakeup check per Steve Rostedt feedback. ]
---
 kernel/rcu/tree.c       | 28 ++++++++++++++++------------
 kernel/rcu/tree_stall.h |  7 ++++---
 2 files changed, 20 insertions(+), 15 deletions(-)

diff --git a/kernel/rcu/tree.c b/kernel/rcu/tree.c
index 62383ce..4a4a975 100644
--- a/kernel/rcu/tree.c
+++ b/kernel/rcu/tree.c
@@ -1202,7 +1202,7 @@ static bool rcu_start_this_gp(struct rcu_node *rnp_start, struct rcu_data *rdp,
 	trace_rcu_this_gp(rnp, rdp, gp_seq_req, TPS("Startedroot"));
 	WRITE_ONCE(rcu_state.gp_flags, rcu_state.gp_flags | RCU_GP_FLAG_INIT);
 	WRITE_ONCE(rcu_state.gp_req_activity, jiffies);
-	if (!rcu_state.gp_kthread) {
+	if (!READ_ONCE(rcu_state.gp_kthread)) {
 		trace_rcu_this_gp(rnp, rdp, gp_seq_req, TPS("NoGPkthread"));
 		goto unlock_out;
 	}
@@ -1237,12 +1237,13 @@ static bool rcu_future_gp_cleanup(struct rcu_node *rnp)
 }
 
 /*
- * Awaken the grace-period kthread.  Don't do a self-awaken (unless in
- * an interrupt or softirq handler), and don't bother awakening when there
- * is nothing for the grace-period kthread to do (as in several CPUs raced
- * to awaken, and we lost), and finally don't try to awaken a kthread that
- * has not yet been created.  If all those checks are passed, track some
- * debug information and awaken.
+ * Awaken the grace-period kthread.  Don't do a self-awaken (unless in an
+ * interrupt or softirq handler, in which case we just might immediately
+ * sleep upon return, resulting in a grace-period hang), and don't bother
+ * awakening when there is nothing for the grace-period kthread to do
+ * (as in several CPUs raced to awaken, we lost), and finally don't try
+ * to awaken a kthread that has not yet been created.  If all those checks
+ * are passed, track some debug information and awaken.
  *
  * So why do the self-wakeup when in an interrupt or softirq handler
  * in the grace-period kthread's context?  Because the kthread might have
@@ -1252,10 +1253,10 @@ static bool rcu_future_gp_cleanup(struct rcu_node *rnp)
  */
 static void rcu_gp_kthread_wake(void)
 {
-	if ((current == rcu_state.gp_kthread &&
-	     !in_irq() && !in_serving_softirq()) ||
-	    !READ_ONCE(rcu_state.gp_flags) ||
-	    !rcu_state.gp_kthread)
+	struct task_struct *t = READ_ONCE(rcu_state.gp_kthread);
+
+	if ((current == t && !in_irq() && !in_serving_softirq()) ||
+	    !READ_ONCE(rcu_state.gp_flags) || !t)
 		return;
 	WRITE_ONCE(rcu_state.gp_wake_time, jiffies);
 	WRITE_ONCE(rcu_state.gp_wake_seq, READ_ONCE(rcu_state.gp_seq));
@@ -3554,7 +3555,10 @@ static int __init rcu_spawn_gp_kthread(void)
 	}
 	rnp = rcu_get_root();
 	raw_spin_lock_irqsave_rcu_node(rnp, flags);
-	rcu_state.gp_kthread = t;
+	WRITE_ONCE(rcu_state.gp_activity, jiffies);
+	WRITE_ONCE(rcu_state.gp_req_activity, jiffies);
+	// Reset .gp_activity and .gp_req_activity before setting .gp_kthread.
+	smp_store_release(&rcu_state.gp_kthread, t);  /* ^^^ */
 	raw_spin_unlock_irqrestore_rcu_node(rnp, flags);
 	wake_up_process(t);
 	rcu_spawn_nocb_kthreads();
diff --git a/kernel/rcu/tree_stall.h b/kernel/rcu/tree_stall.h
index 488b71d..16ad7ad 100644
--- a/kernel/rcu/tree_stall.h
+++ b/kernel/rcu/tree_stall.h
@@ -578,6 +578,7 @@ void show_rcu_gp_kthreads(void)
 	unsigned long jw;
 	struct rcu_data *rdp;
 	struct rcu_node *rnp;
+	struct task_struct *t = READ_ONCE(rcu_state.gp_kthread);
 
 	j = jiffies;
 	ja = j - READ_ONCE(rcu_state.gp_activity);
@@ -585,8 +586,7 @@ void show_rcu_gp_kthreads(void)
 	jw = j - READ_ONCE(rcu_state.gp_wake_time);
 	pr_info("%s: wait state: %s(%d) ->state: %#lx delta ->gp_activity %lu ->gp_req_activity %lu ->gp_wake_time %lu ->gp_wake_seq %ld ->gp_seq %ld ->gp_seq_needed %ld ->gp_flags %#x\n",
 		rcu_state.name, gp_state_getname(rcu_state.gp_state),
-		rcu_state.gp_state,
-		rcu_state.gp_kthread ? rcu_state.gp_kthread->state : 0x1ffffL,
+		rcu_state.gp_state, t ? t->state : 0x1ffffL,
 		ja, jr, jw, (long)READ_ONCE(rcu_state.gp_wake_seq),
 		(long)READ_ONCE(rcu_state.gp_seq),
 		(long)READ_ONCE(rcu_get_root()->gp_seq_needed),
@@ -633,7 +633,8 @@ static void rcu_check_gp_start_stall(struct rcu_node *rnp, struct rcu_data *rdp,
 
 	if (!IS_ENABLED(CONFIG_PROVE_RCU) || rcu_gp_in_progress() ||
 	    ULONG_CMP_GE(READ_ONCE(rnp_root->gp_seq),
-			 READ_ONCE(rnp_root->gp_seq_needed)))
+			 READ_ONCE(rnp_root->gp_seq_needed)) ||
+	    !smp_load_acquire(&rcu_state.gp_kthread)) // Get stable kthread.
 		return;
 	j = jiffies; /* Expensive access, and in common case don't get here. */
 	if (time_before(j, READ_ONCE(rcu_state.gp_req_activity) + gpssdelay) ||
