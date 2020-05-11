Return-Path: <SRS0=ABJN=6Z=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.8 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4344EC54E4B
	for <linux-kernel@archiver.kernel.org>; Mon, 11 May 2020 21:03:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2A68D2078A
	for <linux-kernel@archiver.kernel.org>; Mon, 11 May 2020 21:03:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732450AbgEKVDU (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 11 May 2020 17:03:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44080 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1731912AbgEKU7y (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 May 2020 16:59:54 -0400
Received: from Galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 04037C061A0C;
        Mon, 11 May 2020 13:59:54 -0700 (PDT)
Received: from [5.158.153.53] (helo=tip-bot2.lab.linutronix.de)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tip-bot2@linutronix.de>)
        id 1jYFWi-0005uB-AI; Mon, 11 May 2020 22:59:52 +0200
Received: from [127.0.1.1] (localhost [IPv6:::1])
        by tip-bot2.lab.linutronix.de (Postfix) with ESMTP id 1701D1C084B;
        Mon, 11 May 2020 22:59:35 +0200 (CEST)
Date:   Mon, 11 May 2020 20:59:34 -0000
From:   "tip-bot2 for Paul E. McKenney" <tip-bot2@linutronix.de>
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: core/rcu] rcu: Add per-task state to RCU CPU stall warnings
Cc:     "Paul E. McKenney" <paulmck@kernel.org>, x86 <x86@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <158923077499.390.3671187670079796419.tip-bot2@tip-bot2>
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

Commit-ID:     5bef8da66a9c45d3c371d74463894f1fc31dfdda
Gitweb:        https://git.kernel.org/tip/5bef8da66a9c45d3c371d74463894f1fc31dfdda
Author:        Paul E. McKenney <paulmck@kernel.org>
AuthorDate:    Wed, 11 Mar 2020 17:35:46 -07:00
Committer:     Paul E. McKenney <paulmck@kernel.org>
CommitterDate: Mon, 27 Apr 2020 11:03:50 -07:00

rcu: Add per-task state to RCU CPU stall warnings

Currently, an RCU-preempt CPU stall warning simply lists the PIDs of
those tasks holding up the current grace period.  This can be helpful,
but more can be even more helpful.

To this end, this commit adds the nesting level, whether the task
thinks it was preempted in its current RCU read-side critical section,
whether RCU core has asked this task for a quiescent state, whether the
expedited-grace-period hint is set, and whether the task believes that
it is on the blocked-tasks list (it must be, or it would not be printed,
but if things are broken, best not to take too much for granted).

Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
---
 kernel/rcu/tree_stall.h | 38 ++++++++++++++++++++++++++++++++++++--
 1 file changed, 36 insertions(+), 2 deletions(-)

diff --git a/kernel/rcu/tree_stall.h b/kernel/rcu/tree_stall.h
index 119ed6a..c65c975 100644
--- a/kernel/rcu/tree_stall.h
+++ b/kernel/rcu/tree_stall.h
@@ -192,14 +192,40 @@ static void rcu_print_detail_task_stall_rnp(struct rcu_node *rnp)
 	raw_spin_unlock_irqrestore_rcu_node(rnp, flags);
 }
 
+// Communicate task state back to the RCU CPU stall warning request.
+struct rcu_stall_chk_rdr {
+	int nesting;
+	union rcu_special rs;
+	bool on_blkd_list;
+};
+
+/*
+ * Report out the state of a not-running task that is stalling the
+ * current RCU grace period.
+ */
+static bool check_slow_task(struct task_struct *t, void *arg)
+{
+	struct rcu_node *rnp;
+	struct rcu_stall_chk_rdr *rscrp = arg;
+
+	if (task_curr(t))
+		return false; // It is running, so decline to inspect it.
+	rscrp->nesting = t->rcu_read_lock_nesting;
+	rscrp->rs = t->rcu_read_unlock_special;
+	rnp = t->rcu_blocked_node;
+	rscrp->on_blkd_list = !list_empty(&t->rcu_node_entry);
+	return true;
+}
+
 /*
  * Scan the current list of tasks blocked within RCU read-side critical
  * sections, printing out the tid of each.
  */
 static int rcu_print_task_stall(struct rcu_node *rnp)
 {
-	struct task_struct *t;
 	int ndetected = 0;
+	struct rcu_stall_chk_rdr rscr;
+	struct task_struct *t;
 
 	if (!rcu_preempt_blocked_readers_cgp(rnp))
 		return 0;
@@ -208,7 +234,15 @@ static int rcu_print_task_stall(struct rcu_node *rnp)
 	t = list_entry(rnp->gp_tasks->prev,
 		       struct task_struct, rcu_node_entry);
 	list_for_each_entry_continue(t, &rnp->blkd_tasks, rcu_node_entry) {
-		pr_cont(" P%d", t->pid);
+		if (!try_invoke_on_locked_down_task(t, check_slow_task, &rscr))
+			pr_cont(" P%d", t->pid);
+		else
+			pr_cont(" P%d/%d:%c%c%c%c",
+				t->pid, rscr.nesting,
+				".b"[rscr.rs.b.blocked],
+				".q"[rscr.rs.b.need_qs],
+				".e"[rscr.rs.b.exp_hint],
+				".l"[rscr.on_blkd_list]);
 		ndetected++;
 	}
 	pr_cont("\n");
