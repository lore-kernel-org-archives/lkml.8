Return-Path: <SRS0=aedO=3O=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.8 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 32B36C35243
	for <linux-kernel@archiver.kernel.org>; Sat, 25 Jan 2020 10:43:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0901E24695
	for <linux-kernel@archiver.kernel.org>; Sat, 25 Jan 2020 10:43:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729899AbgAYKn1 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 25 Jan 2020 05:43:27 -0500
Received: from Galois.linutronix.de ([193.142.43.55]:44263 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729526AbgAYKnJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 25 Jan 2020 05:43:09 -0500
Received: from [5.158.153.53] (helo=tip-bot2.lab.linutronix.de)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tip-bot2@linutronix.de>)
        id 1ivIu9-00007d-V2; Sat, 25 Jan 2020 11:43:06 +0100
Received: from [127.0.1.1] (localhost [IPv6:::1])
        by tip-bot2.lab.linutronix.de (Postfix) with ESMTP id E6D1B1C1A89;
        Sat, 25 Jan 2020 11:42:51 +0100 (CET)
Date:   Sat, 25 Jan 2020 10:42:51 -0000
From:   "tip-bot2 for Paul E. McKenney" <tip-bot2@linutronix.de>
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: core/rcu] rcutorture: Complete threading rcu_fwd pointers
 through functions
Cc:     "Paul E. McKenney" <paulmck@kernel.org>, x86 <x86@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <157994897174.396.9283979990858429624.tip-bot2@tip-bot2>
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

Commit-ID:     6764100bd2927060aae91b40fce015f39fc4fd87
Gitweb:        https://git.kernel.org/tip/6764100bd2927060aae91b40fce015f39fc4fd87
Author:        Paul E. McKenney <paulmck@kernel.org>
AuthorDate:    Wed, 06 Nov 2019 08:20:20 -08:00
Committer:     Paul E. McKenney <paulmck@kernel.org>
CommitterDate: Mon, 09 Dec 2019 13:00:28 -08:00

rcutorture: Complete threading rcu_fwd pointers through functions

This commit threads pointers to rcu_fwd structures through the remaining
functions using rcu_fwds directly, namely rcu_torture_fwd_prog_cbfree(),
rcutorture_oom_notify() and rcu_torture_fwd_prog_init().

Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
---
 kernel/rcu/rcutorture.c | 39 +++++++++++++++++++++------------------
 1 file changed, 21 insertions(+), 18 deletions(-)

diff --git a/kernel/rcu/rcutorture.c b/kernel/rcu/rcutorture.c
index 6f540fe..394baac 100644
--- a/kernel/rcu/rcutorture.c
+++ b/kernel/rcu/rcutorture.c
@@ -1754,23 +1754,23 @@ static void rcu_torture_fwd_prog_cond_resched(unsigned long iter)
  * Free all callbacks on the rcu_fwd_cb_head list, either because the
  * test is over or because we hit an OOM event.
  */
-static unsigned long rcu_torture_fwd_prog_cbfree(void)
+static unsigned long rcu_torture_fwd_prog_cbfree(struct rcu_fwd *rfp)
 {
 	unsigned long flags;
 	unsigned long freed = 0;
 	struct rcu_fwd_cb *rfcp;
 
 	for (;;) {
-		spin_lock_irqsave(&rcu_fwds.rcu_fwd_lock, flags);
-		rfcp = rcu_fwds.rcu_fwd_cb_head;
+		spin_lock_irqsave(&rfp->rcu_fwd_lock, flags);
+		rfcp = rfp->rcu_fwd_cb_head;
 		if (!rfcp) {
-			spin_unlock_irqrestore(&rcu_fwds.rcu_fwd_lock, flags);
+			spin_unlock_irqrestore(&rfp->rcu_fwd_lock, flags);
 			break;
 		}
-		rcu_fwds.rcu_fwd_cb_head = rfcp->rfc_next;
-		if (!rcu_fwds.rcu_fwd_cb_head)
-			rcu_fwds.rcu_fwd_cb_tail = &rcu_fwds.rcu_fwd_cb_head;
-		spin_unlock_irqrestore(&rcu_fwds.rcu_fwd_lock, flags);
+		rfp->rcu_fwd_cb_head = rfcp->rfc_next;
+		if (!rfp->rcu_fwd_cb_head)
+			rfp->rcu_fwd_cb_tail = &rfp->rcu_fwd_cb_head;
+		spin_unlock_irqrestore(&rfp->rcu_fwd_lock, flags);
 		kfree(rfcp);
 		freed++;
 		rcu_torture_fwd_prog_cond_resched(freed);
@@ -1926,7 +1926,7 @@ static void rcu_torture_fwd_prog_cr(struct rcu_fwd *rfp)
 	cver = READ_ONCE(rcu_torture_current_version) - cver;
 	gps = rcutorture_seq_diff(cur_ops->get_gp_seq(), gps);
 	cur_ops->cb_barrier(); /* Wait for callbacks to be invoked. */
-	(void)rcu_torture_fwd_prog_cbfree();
+	(void)rcu_torture_fwd_prog_cbfree(rfp);
 
 	if (!torture_must_stop() && !READ_ONCE(rcu_fwd_emergency_stop) &&
 	    !shutdown_time_arrived()) {
@@ -1952,20 +1952,22 @@ static void rcu_torture_fwd_prog_cr(struct rcu_fwd *rfp)
 static int rcutorture_oom_notify(struct notifier_block *self,
 				 unsigned long notused, void *nfreed)
 {
+	struct rcu_fwd *rfp = &rcu_fwds;
+
 	WARN(1, "%s invoked upon OOM during forward-progress testing.\n",
 	     __func__);
-	rcu_torture_fwd_cb_hist(&rcu_fwds);
-	rcu_fwd_progress_check(1 + (jiffies - READ_ONCE(rcu_fwds.rcu_fwd_startat)) / 2);
+	rcu_torture_fwd_cb_hist(rfp);
+	rcu_fwd_progress_check(1 + (jiffies - READ_ONCE(rfp->rcu_fwd_startat)) / 2);
 	WRITE_ONCE(rcu_fwd_emergency_stop, true);
 	smp_mb(); /* Emergency stop before free and wait to avoid hangs. */
 	pr_info("%s: Freed %lu RCU callbacks.\n",
-		__func__, rcu_torture_fwd_prog_cbfree());
+		__func__, rcu_torture_fwd_prog_cbfree(rfp));
 	rcu_barrier();
 	pr_info("%s: Freed %lu RCU callbacks.\n",
-		__func__, rcu_torture_fwd_prog_cbfree());
+		__func__, rcu_torture_fwd_prog_cbfree(rfp));
 	rcu_barrier();
 	pr_info("%s: Freed %lu RCU callbacks.\n",
-		__func__, rcu_torture_fwd_prog_cbfree());
+		__func__, rcu_torture_fwd_prog_cbfree(rfp));
 	smp_mb(); /* Frees before return to avoid redoing OOM. */
 	(*(unsigned long *)nfreed)++; /* Forward progress CBs freed! */
 	pr_info("%s returning after OOM processing.\n", __func__);
@@ -2008,6 +2010,8 @@ static int rcu_torture_fwd_prog(void *args)
 /* If forward-progress checking is requested and feasible, spawn the thread. */
 static int __init rcu_torture_fwd_prog_init(void)
 {
+	struct rcu_fwd *rfp = &rcu_fwds;
+
 	if (!fwd_progress)
 		return 0; /* Not requested, so don't do it. */
 	if (!cur_ops->stall_dur || cur_ops->stall_dur() <= 0 ||
@@ -2022,14 +2026,13 @@ static int __init rcu_torture_fwd_prog_init(void)
 		WARN_ON(1); /* Make sure rcutorture notices conflict. */
 		return 0;
 	}
-	spin_lock_init(&rcu_fwds.rcu_fwd_lock);
-	rcu_fwds.rcu_fwd_cb_tail = &rcu_fwds.rcu_fwd_cb_head;
+	spin_lock_init(&rfp->rcu_fwd_lock);
+	rfp->rcu_fwd_cb_tail = &rfp->rcu_fwd_cb_head;
 	if (fwd_progress_holdoff <= 0)
 		fwd_progress_holdoff = 1;
 	if (fwd_progress_div <= 0)
 		fwd_progress_div = 4;
-	return torture_create_kthread(rcu_torture_fwd_prog,
-				      &rcu_fwds, fwd_prog_task);
+	return torture_create_kthread(rcu_torture_fwd_prog, rfp, fwd_prog_task);
 }
 
 /* Callback function for RCU barrier testing. */
