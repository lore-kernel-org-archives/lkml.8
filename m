Return-Path: <SRS0=aedO=3O=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.8 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B0173C2D0DB
	for <linux-kernel@archiver.kernel.org>; Sat, 25 Jan 2020 10:44:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 834CA22522
	for <linux-kernel@archiver.kernel.org>; Sat, 25 Jan 2020 10:44:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729999AbgAYKnh (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 25 Jan 2020 05:43:37 -0500
Received: from Galois.linutronix.de ([193.142.43.55]:44285 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729602AbgAYKnO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 25 Jan 2020 05:43:14 -0500
Received: from [5.158.153.53] (helo=tip-bot2.lab.linutronix.de)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tip-bot2@linutronix.de>)
        id 1ivIuE-00008a-5B; Sat, 25 Jan 2020 11:43:10 +0100
Received: from [127.0.1.1] (localhost [IPv6:::1])
        by tip-bot2.lab.linutronix.de (Postfix) with ESMTP id 8784D1C1A8A;
        Sat, 25 Jan 2020 11:42:52 +0100 (CET)
Date:   Sat, 25 Jan 2020 10:42:52 -0000
From:   "tip-bot2 for Paul E. McKenney" <tip-bot2@linutronix.de>
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: core/rcu] rcutorture: Thread rcu_fwd pointer through
 forward-progress functions
Cc:     "Paul E. McKenney" <paulmck@kernel.org>, x86 <x86@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <157994897236.396.12656838958020816616.tip-bot2@tip-bot2>
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

Commit-ID:     6b1b832546067caac8c5833abf88fa082d253b2f
Gitweb:        https://git.kernel.org/tip/6b1b832546067caac8c5833abf88fa082d253b2f
Author:        Paul E. McKenney <paulmck@kernel.org>
AuthorDate:    Tue, 05 Nov 2019 09:08:58 -08:00
Committer:     Paul E. McKenney <paulmck@kernel.org>
CommitterDate: Mon, 09 Dec 2019 13:00:28 -08:00

rcutorture: Thread rcu_fwd pointer through forward-progress functions

In order to add multiple kthreads, it will be necessary to allow
the various functions to operate on a pointer to their kthread's
rcu_fwd structure.  This commit therefore starts the process of
adding the needed "struct rcu_fwd" parameters and arguments to the
various callback forward-progress functions.

Note that rcutorture_oom_notify() and rcu_torture_fwd_cb_hist() will
eventually need to iterate over all kthreads' rcu_fwd structures.

Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
---
 kernel/rcu/rcutorture.c | 78 +++++++++++++++++++++-------------------
 1 file changed, 41 insertions(+), 37 deletions(-)

diff --git a/kernel/rcu/rcutorture.c b/kernel/rcu/rcutorture.c
index 22a75a4..cc88ce9 100644
--- a/kernel/rcu/rcutorture.c
+++ b/kernel/rcu/rcutorture.c
@@ -1661,6 +1661,7 @@ static void rcu_torture_fwd_prog_cb(struct rcu_head *rhp)
 struct rcu_fwd_cb {
 	struct rcu_head rh;
 	struct rcu_fwd_cb *rfc_next;
+	struct rcu_fwd *rfc_rfp;
 	int rfc_gps;
 };
 
@@ -1692,24 +1693,24 @@ struct rcu_fwd rcu_fwds = {
 
 bool rcu_fwd_emergency_stop;
 
-static void rcu_torture_fwd_cb_hist(void)
+static void rcu_torture_fwd_cb_hist(struct rcu_fwd *rfp)
 {
 	unsigned long gps;
 	unsigned long gps_old;
 	int i;
 	int j;
 
-	for (i = ARRAY_SIZE(rcu_fwds.n_launders_hist) - 1; i > 0; i--)
-		if (rcu_fwds.n_launders_hist[i].n_launders > 0)
+	for (i = ARRAY_SIZE(rfp->n_launders_hist) - 1; i > 0; i--)
+		if (rfp->n_launders_hist[i].n_launders > 0)
 			break;
 	pr_alert("%s: Callback-invocation histogram (duration %lu jiffies):",
-		 __func__, jiffies - rcu_fwds.rcu_fwd_startat);
-	gps_old = rcu_fwds.rcu_launder_gp_seq_start;
+		 __func__, jiffies - rfp->rcu_fwd_startat);
+	gps_old = rfp->rcu_launder_gp_seq_start;
 	for (j = 0; j <= i; j++) {
-		gps = rcu_fwds.n_launders_hist[j].launder_gp_seq;
+		gps = rfp->n_launders_hist[j].launder_gp_seq;
 		pr_cont(" %ds/%d: %ld:%ld",
 			j + 1, FWD_CBS_HIST_DIV,
-			rcu_fwds.n_launders_hist[j].n_launders,
+			rfp->n_launders_hist[j].n_launders,
 			rcutorture_seq_diff(gps, gps_old));
 		gps_old = gps;
 	}
@@ -1723,20 +1724,21 @@ static void rcu_torture_fwd_cb_cr(struct rcu_head *rhp)
 	int i;
 	struct rcu_fwd_cb *rfcp = container_of(rhp, struct rcu_fwd_cb, rh);
 	struct rcu_fwd_cb **rfcpp;
+	struct rcu_fwd *rfp = rfcp->rfc_rfp;
 
 	rfcp->rfc_next = NULL;
 	rfcp->rfc_gps++;
-	spin_lock_irqsave(&rcu_fwds.rcu_fwd_lock, flags);
-	rfcpp = rcu_fwds.rcu_fwd_cb_tail;
-	rcu_fwds.rcu_fwd_cb_tail = &rfcp->rfc_next;
+	spin_lock_irqsave(&rfp->rcu_fwd_lock, flags);
+	rfcpp = rfp->rcu_fwd_cb_tail;
+	rfp->rcu_fwd_cb_tail = &rfcp->rfc_next;
 	WRITE_ONCE(*rfcpp, rfcp);
-	WRITE_ONCE(rcu_fwds.n_launders_cb, rcu_fwds.n_launders_cb + 1);
-	i = ((jiffies - rcu_fwds.rcu_fwd_startat) / (HZ / FWD_CBS_HIST_DIV));
-	if (i >= ARRAY_SIZE(rcu_fwds.n_launders_hist))
-		i = ARRAY_SIZE(rcu_fwds.n_launders_hist) - 1;
-	rcu_fwds.n_launders_hist[i].n_launders++;
-	rcu_fwds.n_launders_hist[i].launder_gp_seq = cur_ops->get_gp_seq();
-	spin_unlock_irqrestore(&rcu_fwds.rcu_fwd_lock, flags);
+	WRITE_ONCE(rfp->n_launders_cb, rfp->n_launders_cb + 1);
+	i = ((jiffies - rfp->rcu_fwd_startat) / (HZ / FWD_CBS_HIST_DIV));
+	if (i >= ARRAY_SIZE(rfp->n_launders_hist))
+		i = ARRAY_SIZE(rfp->n_launders_hist) - 1;
+	rfp->n_launders_hist[i].n_launders++;
+	rfp->n_launders_hist[i].launder_gp_seq = cur_ops->get_gp_seq();
+	spin_unlock_irqrestore(&rfp->rcu_fwd_lock, flags);
 }
 
 // Give the scheduler a chance, even on nohz_full CPUs.
@@ -1786,7 +1788,8 @@ static unsigned long rcu_torture_fwd_prog_cbfree(void)
 }
 
 /* Carry out need_resched()/cond_resched() forward-progress testing. */
-static void rcu_torture_fwd_prog_nr(int *tested, int *tested_tries)
+static void rcu_torture_fwd_prog_nr(struct rcu_fwd *rfp,
+				    int *tested, int *tested_tries)
 {
 	unsigned long cver;
 	unsigned long dur;
@@ -1816,8 +1819,8 @@ static void rcu_torture_fwd_prog_nr(int *tested, int *tested_tries)
 	sd = cur_ops->stall_dur() + 1;
 	sd4 = (sd + fwd_progress_div - 1) / fwd_progress_div;
 	dur = sd4 + torture_random(&trs) % (sd - sd4);
-	WRITE_ONCE(rcu_fwds.rcu_fwd_startat, jiffies);
-	stopat = rcu_fwds.rcu_fwd_startat + dur;
+	WRITE_ONCE(rfp->rcu_fwd_startat, jiffies);
+	stopat = rfp->rcu_fwd_startat + dur;
 	while (time_before(jiffies, stopat) &&
 	       !shutdown_time_arrived() &&
 	       !READ_ONCE(rcu_fwd_emergency_stop) && !torture_must_stop()) {
@@ -1852,7 +1855,7 @@ static void rcu_torture_fwd_prog_nr(int *tested, int *tested_tries)
 }
 
 /* Carry out call_rcu() forward-progress testing. */
-static void rcu_torture_fwd_prog_cr(void)
+static void rcu_torture_fwd_prog_cr(struct rcu_fwd *rfp)
 {
 	unsigned long cver;
 	unsigned long flags;
@@ -1876,23 +1879,23 @@ static void rcu_torture_fwd_prog_cr(void)
 	/* Loop continuously posting RCU callbacks. */
 	WRITE_ONCE(rcu_fwd_cb_nodelay, true);
 	cur_ops->sync(); /* Later readers see above write. */
-	WRITE_ONCE(rcu_fwds.rcu_fwd_startat, jiffies);
-	stopat = rcu_fwds.rcu_fwd_startat + MAX_FWD_CB_JIFFIES;
+	WRITE_ONCE(rfp->rcu_fwd_startat, jiffies);
+	stopat = rfp->rcu_fwd_startat + MAX_FWD_CB_JIFFIES;
 	n_launders = 0;
-	rcu_fwds.n_launders_cb = 0; // Hoist initialization for multi-kthread
+	rfp->n_launders_cb = 0; // Hoist initialization for multi-kthread
 	n_launders_sa = 0;
 	n_max_cbs = 0;
 	n_max_gps = 0;
-	for (i = 0; i < ARRAY_SIZE(rcu_fwds.n_launders_hist); i++)
-		rcu_fwds.n_launders_hist[i].n_launders = 0;
+	for (i = 0; i < ARRAY_SIZE(rfp->n_launders_hist); i++)
+		rfp->n_launders_hist[i].n_launders = 0;
 	cver = READ_ONCE(rcu_torture_current_version);
 	gps = cur_ops->get_gp_seq();
-	rcu_fwds.rcu_launder_gp_seq_start = gps;
+	rfp->rcu_launder_gp_seq_start = gps;
 	tick_dep_set_task(current, TICK_DEP_BIT_RCU);
 	while (time_before(jiffies, stopat) &&
 	       !shutdown_time_arrived() &&
 	       !READ_ONCE(rcu_fwd_emergency_stop) && !torture_must_stop()) {
-		rfcp = READ_ONCE(rcu_fwds.rcu_fwd_cb_head);
+		rfcp = READ_ONCE(rfp->rcu_fwd_cb_head);
 		rfcpn = NULL;
 		if (rfcp)
 			rfcpn = READ_ONCE(rfcp->rfc_next);
@@ -1900,7 +1903,7 @@ static void rcu_torture_fwd_prog_cr(void)
 			if (rfcp->rfc_gps >= MIN_FWD_CB_LAUNDERS &&
 			    ++n_max_gps >= MIN_FWD_CBS_LAUNDERED)
 				break;
-			rcu_fwds.rcu_fwd_cb_head = rfcpn;
+			rfp->rcu_fwd_cb_head = rfcpn;
 			n_launders++;
 			n_launders_sa++;
 		} else {
@@ -1912,6 +1915,7 @@ static void rcu_torture_fwd_prog_cr(void)
 			n_max_cbs++;
 			n_launders_sa = 0;
 			rfcp->rfc_gps = 0;
+			rfcp->rfc_rfp = rfp;
 		}
 		cur_ops->call(&rfcp->rh, rcu_torture_fwd_cb_cr);
 		rcu_torture_fwd_prog_cond_resched(n_launders + n_max_cbs);
@@ -1922,7 +1926,7 @@ static void rcu_torture_fwd_prog_cr(void)
 		}
 	}
 	stoppedat = jiffies;
-	n_launders_cb_snap = READ_ONCE(rcu_fwds.n_launders_cb);
+	n_launders_cb_snap = READ_ONCE(rfp->n_launders_cb);
 	cver = READ_ONCE(rcu_torture_current_version) - cver;
 	gps = rcutorture_seq_diff(cur_ops->get_gp_seq(), gps);
 	cur_ops->cb_barrier(); /* Wait for callbacks to be invoked. */
@@ -1933,12 +1937,11 @@ static void rcu_torture_fwd_prog_cr(void)
 		WARN_ON(n_max_gps < MIN_FWD_CBS_LAUNDERED);
 		pr_alert("%s Duration %lu barrier: %lu pending %ld n_launders: %ld n_launders_sa: %ld n_max_gps: %ld n_max_cbs: %ld cver %ld gps %ld\n",
 			 __func__,
-			 stoppedat - rcu_fwds.rcu_fwd_startat,
-			 jiffies - stoppedat,
+			 stoppedat - rfp->rcu_fwd_startat, jiffies - stoppedat,
 			 n_launders + n_max_cbs - n_launders_cb_snap,
 			 n_launders, n_launders_sa,
 			 n_max_gps, n_max_cbs, cver, gps);
-		rcu_torture_fwd_cb_hist();
+		rcu_torture_fwd_cb_hist(rfp);
 	}
 	schedule_timeout_uninterruptible(HZ); /* Let CBs drain. */
 	tick_dep_clear_task(current, TICK_DEP_BIT_RCU);
@@ -1955,7 +1958,7 @@ static int rcutorture_oom_notify(struct notifier_block *self,
 {
 	WARN(1, "%s invoked upon OOM during forward-progress testing.\n",
 	     __func__);
-	rcu_torture_fwd_cb_hist();
+	rcu_torture_fwd_cb_hist(&rcu_fwds);
 	rcu_fwd_progress_check(1 + (jiffies - READ_ONCE(rcu_fwds.rcu_fwd_startat)) / 2);
 	WRITE_ONCE(rcu_fwd_emergency_stop, true);
 	smp_mb(); /* Emergency stop before free and wait to avoid hangs. */
@@ -1980,6 +1983,7 @@ static struct notifier_block rcutorture_oom_nb = {
 /* Carry out grace-period forward-progress testing. */
 static int rcu_torture_fwd_prog(void *args)
 {
+	struct rcu_fwd *rfp = args;
 	int tested = 0;
 	int tested_tries = 0;
 
@@ -1991,8 +1995,8 @@ static int rcu_torture_fwd_prog(void *args)
 		schedule_timeout_interruptible(fwd_progress_holdoff * HZ);
 		WRITE_ONCE(rcu_fwd_emergency_stop, false);
 		register_oom_notifier(&rcutorture_oom_nb);
-		rcu_torture_fwd_prog_nr(&tested, &tested_tries);
-		rcu_torture_fwd_prog_cr();
+		rcu_torture_fwd_prog_nr(rfp, &tested, &tested_tries);
+		rcu_torture_fwd_prog_cr(rfp);
 		unregister_oom_notifier(&rcutorture_oom_nb);
 
 		/* Avoid slow periods, better to test when busy. */
@@ -2027,7 +2031,7 @@ static int __init rcu_torture_fwd_prog_init(void)
 	if (fwd_progress_div <= 0)
 		fwd_progress_div = 4;
 	return torture_create_kthread(rcu_torture_fwd_prog,
-				      NULL, fwd_prog_task);
+				      &rcu_fwds, fwd_prog_task);
 }
 
 /* Callback function for RCU barrier testing. */
