Return-Path: <SRS0=aedO=3O=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.8 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 11A59C2D0DB
	for <linux-kernel@archiver.kernel.org>; Sat, 25 Jan 2020 10:43:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D59892468C
	for <linux-kernel@archiver.kernel.org>; Sat, 25 Jan 2020 10:43:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729950AbgAYKnd (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 25 Jan 2020 05:43:33 -0500
Received: from Galois.linutronix.de ([193.142.43.55]:44295 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729616AbgAYKnN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 25 Jan 2020 05:43:13 -0500
Received: from [5.158.153.53] (helo=tip-bot2.lab.linutronix.de)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tip-bot2@linutronix.de>)
        id 1ivIuB-00009P-Nx; Sat, 25 Jan 2020 11:43:07 +0100
Received: from [127.0.1.1] (localhost [IPv6:::1])
        by tip-bot2.lab.linutronix.de (Postfix) with ESMTP id CFF611C1A7D;
        Sat, 25 Jan 2020 11:42:52 +0100 (CET)
Date:   Sat, 25 Jan 2020 10:42:52 -0000
From:   "tip-bot2 for Paul E. McKenney" <tip-bot2@linutronix.de>
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: core/rcu] rcutorture: Pull callback forward-progress data into
 rcu_fwd struct
Cc:     "Paul E. McKenney" <paulmck@kernel.org>, x86 <x86@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <157994897261.396.1073561460672627761.tip-bot2@tip-bot2>
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

Commit-ID:     a289e608b3e740c15f623148c26cdec2d6698ce0
Gitweb:        https://git.kernel.org/tip/a289e608b3e740c15f623148c26cdec2d6698ce0
Author:        Paul E. McKenney <paulmck@kernel.org>
AuthorDate:    Tue, 05 Nov 2019 08:31:56 -08:00
Committer:     Paul E. McKenney <paulmck@kernel.org>
CommitterDate: Mon, 09 Dec 2019 13:00:27 -08:00

rcutorture: Pull callback forward-progress data into rcu_fwd struct

Now that RCU behaves reasonably well with the current single-kthread
call_rcu() forward-progress testing, it is time to add more kthreads.
This commit takes a first step towards that goal by wrapping what
will be the per-kthread data into a new rcu_fwd structure.

Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
---
 kernel/rcu/rcutorture.c | 103 +++++++++++++++++++++------------------
 1 file changed, 58 insertions(+), 45 deletions(-)

diff --git a/kernel/rcu/rcutorture.c b/kernel/rcu/rcutorture.c
index dee043f..22a75a4 100644
--- a/kernel/rcu/rcutorture.c
+++ b/kernel/rcu/rcutorture.c
@@ -1663,23 +1663,34 @@ struct rcu_fwd_cb {
 	struct rcu_fwd_cb *rfc_next;
 	int rfc_gps;
 };
-static DEFINE_SPINLOCK(rcu_fwd_lock);
-static struct rcu_fwd_cb *rcu_fwd_cb_head;
-static struct rcu_fwd_cb **rcu_fwd_cb_tail = &rcu_fwd_cb_head;
-static long n_launders_cb;
-static unsigned long rcu_fwd_startat;
-static bool rcu_fwd_emergency_stop;
+
 #define MAX_FWD_CB_JIFFIES	(8 * HZ) /* Maximum CB test duration. */
 #define MIN_FWD_CB_LAUNDERS	3	/* This many CB invocations to count. */
 #define MIN_FWD_CBS_LAUNDERED	100	/* Number of counted CBs. */
 #define FWD_CBS_HIST_DIV	10	/* Histogram buckets/second. */
+#define N_LAUNDERS_HIST (2 * MAX_FWD_CB_JIFFIES / (HZ / FWD_CBS_HIST_DIV))
+
 struct rcu_launder_hist {
 	long n_launders;
 	unsigned long launder_gp_seq;
 };
-#define N_LAUNDERS_HIST (2 * MAX_FWD_CB_JIFFIES / (HZ / FWD_CBS_HIST_DIV))
-static struct rcu_launder_hist n_launders_hist[N_LAUNDERS_HIST];
-static unsigned long rcu_launder_gp_seq_start;
+
+struct rcu_fwd {
+	spinlock_t rcu_fwd_lock;
+	struct rcu_fwd_cb *rcu_fwd_cb_head;
+	struct rcu_fwd_cb **rcu_fwd_cb_tail;
+	long n_launders_cb;
+	unsigned long rcu_fwd_startat;
+	struct rcu_launder_hist n_launders_hist[N_LAUNDERS_HIST];
+	unsigned long rcu_launder_gp_seq_start;
+};
+
+struct rcu_fwd rcu_fwds = {
+	.rcu_fwd_lock = __SPIN_LOCK_UNLOCKED(rcu_fwds.rcu_fwd_lock),
+	.rcu_fwd_cb_tail = &rcu_fwds.rcu_fwd_cb_head,
+};
+
+bool rcu_fwd_emergency_stop;
 
 static void rcu_torture_fwd_cb_hist(void)
 {
@@ -1688,16 +1699,17 @@ static void rcu_torture_fwd_cb_hist(void)
 	int i;
 	int j;
 
-	for (i = ARRAY_SIZE(n_launders_hist) - 1; i > 0; i--)
-		if (n_launders_hist[i].n_launders > 0)
+	for (i = ARRAY_SIZE(rcu_fwds.n_launders_hist) - 1; i > 0; i--)
+		if (rcu_fwds.n_launders_hist[i].n_launders > 0)
 			break;
 	pr_alert("%s: Callback-invocation histogram (duration %lu jiffies):",
-		 __func__, jiffies - rcu_fwd_startat);
-	gps_old = rcu_launder_gp_seq_start;
+		 __func__, jiffies - rcu_fwds.rcu_fwd_startat);
+	gps_old = rcu_fwds.rcu_launder_gp_seq_start;
 	for (j = 0; j <= i; j++) {
-		gps = n_launders_hist[j].launder_gp_seq;
+		gps = rcu_fwds.n_launders_hist[j].launder_gp_seq;
 		pr_cont(" %ds/%d: %ld:%ld",
-			j + 1, FWD_CBS_HIST_DIV, n_launders_hist[j].n_launders,
+			j + 1, FWD_CBS_HIST_DIV,
+			rcu_fwds.n_launders_hist[j].n_launders,
 			rcutorture_seq_diff(gps, gps_old));
 		gps_old = gps;
 	}
@@ -1714,17 +1726,17 @@ static void rcu_torture_fwd_cb_cr(struct rcu_head *rhp)
 
 	rfcp->rfc_next = NULL;
 	rfcp->rfc_gps++;
-	spin_lock_irqsave(&rcu_fwd_lock, flags);
-	rfcpp = rcu_fwd_cb_tail;
-	rcu_fwd_cb_tail = &rfcp->rfc_next;
+	spin_lock_irqsave(&rcu_fwds.rcu_fwd_lock, flags);
+	rfcpp = rcu_fwds.rcu_fwd_cb_tail;
+	rcu_fwds.rcu_fwd_cb_tail = &rfcp->rfc_next;
 	WRITE_ONCE(*rfcpp, rfcp);
-	WRITE_ONCE(n_launders_cb, n_launders_cb + 1);
-	i = ((jiffies - rcu_fwd_startat) / (HZ / FWD_CBS_HIST_DIV));
-	if (i >= ARRAY_SIZE(n_launders_hist))
-		i = ARRAY_SIZE(n_launders_hist) - 1;
-	n_launders_hist[i].n_launders++;
-	n_launders_hist[i].launder_gp_seq = cur_ops->get_gp_seq();
-	spin_unlock_irqrestore(&rcu_fwd_lock, flags);
+	WRITE_ONCE(rcu_fwds.n_launders_cb, rcu_fwds.n_launders_cb + 1);
+	i = ((jiffies - rcu_fwds.rcu_fwd_startat) / (HZ / FWD_CBS_HIST_DIV));
+	if (i >= ARRAY_SIZE(rcu_fwds.n_launders_hist))
+		i = ARRAY_SIZE(rcu_fwds.n_launders_hist) - 1;
+	rcu_fwds.n_launders_hist[i].n_launders++;
+	rcu_fwds.n_launders_hist[i].launder_gp_seq = cur_ops->get_gp_seq();
+	spin_unlock_irqrestore(&rcu_fwds.rcu_fwd_lock, flags);
 }
 
 // Give the scheduler a chance, even on nohz_full CPUs.
@@ -1751,16 +1763,16 @@ static unsigned long rcu_torture_fwd_prog_cbfree(void)
 	struct rcu_fwd_cb *rfcp;
 
 	for (;;) {
-		spin_lock_irqsave(&rcu_fwd_lock, flags);
-		rfcp = rcu_fwd_cb_head;
+		spin_lock_irqsave(&rcu_fwds.rcu_fwd_lock, flags);
+		rfcp = rcu_fwds.rcu_fwd_cb_head;
 		if (!rfcp) {
-			spin_unlock_irqrestore(&rcu_fwd_lock, flags);
+			spin_unlock_irqrestore(&rcu_fwds.rcu_fwd_lock, flags);
 			break;
 		}
-		rcu_fwd_cb_head = rfcp->rfc_next;
-		if (!rcu_fwd_cb_head)
-			rcu_fwd_cb_tail = &rcu_fwd_cb_head;
-		spin_unlock_irqrestore(&rcu_fwd_lock, flags);
+		rcu_fwds.rcu_fwd_cb_head = rfcp->rfc_next;
+		if (!rcu_fwds.rcu_fwd_cb_head)
+			rcu_fwds.rcu_fwd_cb_tail = &rcu_fwds.rcu_fwd_cb_head;
+		spin_unlock_irqrestore(&rcu_fwds.rcu_fwd_lock, flags);
 		kfree(rfcp);
 		freed++;
 		rcu_torture_fwd_prog_cond_resched(freed);
@@ -1804,8 +1816,8 @@ static void rcu_torture_fwd_prog_nr(int *tested, int *tested_tries)
 	sd = cur_ops->stall_dur() + 1;
 	sd4 = (sd + fwd_progress_div - 1) / fwd_progress_div;
 	dur = sd4 + torture_random(&trs) % (sd - sd4);
-	WRITE_ONCE(rcu_fwd_startat, jiffies);
-	stopat = rcu_fwd_startat + dur;
+	WRITE_ONCE(rcu_fwds.rcu_fwd_startat, jiffies);
+	stopat = rcu_fwds.rcu_fwd_startat + dur;
 	while (time_before(jiffies, stopat) &&
 	       !shutdown_time_arrived() &&
 	       !READ_ONCE(rcu_fwd_emergency_stop) && !torture_must_stop()) {
@@ -1864,23 +1876,23 @@ static void rcu_torture_fwd_prog_cr(void)
 	/* Loop continuously posting RCU callbacks. */
 	WRITE_ONCE(rcu_fwd_cb_nodelay, true);
 	cur_ops->sync(); /* Later readers see above write. */
-	WRITE_ONCE(rcu_fwd_startat, jiffies);
-	stopat = rcu_fwd_startat + MAX_FWD_CB_JIFFIES;
+	WRITE_ONCE(rcu_fwds.rcu_fwd_startat, jiffies);
+	stopat = rcu_fwds.rcu_fwd_startat + MAX_FWD_CB_JIFFIES;
 	n_launders = 0;
-	n_launders_cb = 0;
+	rcu_fwds.n_launders_cb = 0; // Hoist initialization for multi-kthread
 	n_launders_sa = 0;
 	n_max_cbs = 0;
 	n_max_gps = 0;
-	for (i = 0; i < ARRAY_SIZE(n_launders_hist); i++)
-		n_launders_hist[i].n_launders = 0;
+	for (i = 0; i < ARRAY_SIZE(rcu_fwds.n_launders_hist); i++)
+		rcu_fwds.n_launders_hist[i].n_launders = 0;
 	cver = READ_ONCE(rcu_torture_current_version);
 	gps = cur_ops->get_gp_seq();
-	rcu_launder_gp_seq_start = gps;
+	rcu_fwds.rcu_launder_gp_seq_start = gps;
 	tick_dep_set_task(current, TICK_DEP_BIT_RCU);
 	while (time_before(jiffies, stopat) &&
 	       !shutdown_time_arrived() &&
 	       !READ_ONCE(rcu_fwd_emergency_stop) && !torture_must_stop()) {
-		rfcp = READ_ONCE(rcu_fwd_cb_head);
+		rfcp = READ_ONCE(rcu_fwds.rcu_fwd_cb_head);
 		rfcpn = NULL;
 		if (rfcp)
 			rfcpn = READ_ONCE(rfcp->rfc_next);
@@ -1888,7 +1900,7 @@ static void rcu_torture_fwd_prog_cr(void)
 			if (rfcp->rfc_gps >= MIN_FWD_CB_LAUNDERS &&
 			    ++n_max_gps >= MIN_FWD_CBS_LAUNDERED)
 				break;
-			rcu_fwd_cb_head = rfcpn;
+			rcu_fwds.rcu_fwd_cb_head = rfcpn;
 			n_launders++;
 			n_launders_sa++;
 		} else {
@@ -1910,7 +1922,7 @@ static void rcu_torture_fwd_prog_cr(void)
 		}
 	}
 	stoppedat = jiffies;
-	n_launders_cb_snap = READ_ONCE(n_launders_cb);
+	n_launders_cb_snap = READ_ONCE(rcu_fwds.n_launders_cb);
 	cver = READ_ONCE(rcu_torture_current_version) - cver;
 	gps = rcutorture_seq_diff(cur_ops->get_gp_seq(), gps);
 	cur_ops->cb_barrier(); /* Wait for callbacks to be invoked. */
@@ -1921,7 +1933,8 @@ static void rcu_torture_fwd_prog_cr(void)
 		WARN_ON(n_max_gps < MIN_FWD_CBS_LAUNDERED);
 		pr_alert("%s Duration %lu barrier: %lu pending %ld n_launders: %ld n_launders_sa: %ld n_max_gps: %ld n_max_cbs: %ld cver %ld gps %ld\n",
 			 __func__,
-			 stoppedat - rcu_fwd_startat, jiffies - stoppedat,
+			 stoppedat - rcu_fwds.rcu_fwd_startat,
+			 jiffies - stoppedat,
 			 n_launders + n_max_cbs - n_launders_cb_snap,
 			 n_launders, n_launders_sa,
 			 n_max_gps, n_max_cbs, cver, gps);
@@ -1943,7 +1956,7 @@ static int rcutorture_oom_notify(struct notifier_block *self,
 	WARN(1, "%s invoked upon OOM during forward-progress testing.\n",
 	     __func__);
 	rcu_torture_fwd_cb_hist();
-	rcu_fwd_progress_check(1 + (jiffies - READ_ONCE(rcu_fwd_startat)) / 2);
+	rcu_fwd_progress_check(1 + (jiffies - READ_ONCE(rcu_fwds.rcu_fwd_startat)) / 2);
 	WRITE_ONCE(rcu_fwd_emergency_stop, true);
 	smp_mb(); /* Emergency stop before free and wait to avoid hangs. */
 	pr_info("%s: Freed %lu RCU callbacks.\n",
