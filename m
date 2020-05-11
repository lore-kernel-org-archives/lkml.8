Return-Path: <SRS0=ABJN=6Z=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.8 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A68AEC54E8D
	for <linux-kernel@archiver.kernel.org>; Mon, 11 May 2020 21:04:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 93B7424955
	for <linux-kernel@archiver.kernel.org>; Mon, 11 May 2020 21:04:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732531AbgEKVEs (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 11 May 2020 17:04:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43958 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1731868AbgEKU7a (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 May 2020 16:59:30 -0400
Received: from Galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 750A4C061A0C;
        Mon, 11 May 2020 13:59:30 -0700 (PDT)
Received: from [5.158.153.53] (helo=tip-bot2.lab.linutronix.de)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tip-bot2@linutronix.de>)
        id 1jYFWL-0005ik-17; Mon, 11 May 2020 22:59:29 +0200
Received: from [127.0.1.1] (localhost [IPv6:::1])
        by tip-bot2.lab.linutronix.de (Postfix) with ESMTP id E9A9D1C074B;
        Mon, 11 May 2020 22:59:20 +0200 (CEST)
Date:   Mon, 11 May 2020 20:59:20 -0000
From:   "tip-bot2 for Paul E. McKenney" <tip-bot2@linutronix.de>
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: core/rcu] rcu: When GP kthread is starved, tag idle threads as
 false positives
Cc:     "Paul E. McKenney" <paulmck@kernel.org>, x86 <x86@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <158923076089.390.14423351111207950924.tip-bot2@tip-bot2>
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

Commit-ID:     88375825171c7de5f1e68ac6fd5d35d3b831da3c
Gitweb:        https://git.kernel.org/tip/88375825171c7de5f1e68ac6fd5d35d3b831da3c
Author:        Paul E. McKenney <paulmck@kernel.org>
AuthorDate:    Tue, 31 Mar 2020 19:00:52 -07:00
Committer:     Paul E. McKenney <paulmck@kernel.org>
CommitterDate: Mon, 27 Apr 2020 11:04:37 -07:00

rcu: When GP kthread is starved, tag idle threads as false positives

If the grace-period kthread is starved, idle threads' extended quiescent
states are not reported.  These idle threads thus wrongly appear to
be blocking the current grace period.  This commit therefore tags such
idle threads as probable false positives when the grace-period kthread
is being starved.

Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
---
 kernel/rcu/tree_stall.h | 24 +++++++++++++++++++-----
 1 file changed, 19 insertions(+), 5 deletions(-)

diff --git a/kernel/rcu/tree_stall.h b/kernel/rcu/tree_stall.h
index 119ed6a..4da41a6 100644
--- a/kernel/rcu/tree_stall.h
+++ b/kernel/rcu/tree_stall.h
@@ -299,6 +299,16 @@ static const char *gp_state_getname(short gs)
 	return gp_state_names[gs];
 }
 
+/* Is the RCU grace-period kthread being starved of CPU time? */
+static bool rcu_is_gp_kthread_starving(unsigned long *jp)
+{
+	unsigned long j = jiffies - READ_ONCE(rcu_state.gp_activity);
+
+	if (jp)
+		*jp = j;
+	return j > 2 * HZ;
+}
+
 /*
  * Print out diagnostic information for the specified stalled CPU.
  *
@@ -313,6 +323,7 @@ static const char *gp_state_getname(short gs)
 static void print_cpu_stall_info(int cpu)
 {
 	unsigned long delta;
+	bool falsepositive;
 	char fast_no_hz[72];
 	struct rcu_data *rdp = per_cpu_ptr(&rcu_data, cpu);
 	char *ticks_title;
@@ -333,7 +344,9 @@ static void print_cpu_stall_info(int cpu)
 	}
 	print_cpu_stall_fast_no_hz(fast_no_hz, cpu);
 	delta = rcu_seq_ctr(rdp->mynode->gp_seq - rdp->rcu_iw_gp_seq);
-	pr_err("\t%d-%c%c%c%c: (%lu %s) idle=%03x/%ld/%#lx softirq=%u/%u fqs=%ld %s\n",
+	falsepositive = rcu_is_gp_kthread_starving(NULL) &&
+			rcu_dynticks_in_eqs(rcu_dynticks_snap(rdp));
+	pr_err("\t%d-%c%c%c%c: (%lu %s) idle=%03x/%ld/%#lx softirq=%u/%u fqs=%ld %s%s\n",
 	       cpu,
 	       "O."[!!cpu_online(cpu)],
 	       "o."[!!(rdp->grpmask & rdp->mynode->qsmaskinit)],
@@ -345,8 +358,9 @@ static void print_cpu_stall_info(int cpu)
 	       rcu_dynticks_snap(rdp) & 0xfff,
 	       rdp->dynticks_nesting, rdp->dynticks_nmi_nesting,
 	       rdp->softirq_snap, kstat_softirqs_cpu(RCU_SOFTIRQ, cpu),
-	       READ_ONCE(rcu_state.n_force_qs) - rcu_state.n_force_qs_gpstart,
-	       fast_no_hz);
+	       data_race(rcu_state.n_force_qs) - rcu_state.n_force_qs_gpstart,
+	       fast_no_hz,
+	       falsepositive ? " (false positive?)" : "");
 }
 
 /* Complain about starvation of grace-period kthread.  */
@@ -355,8 +369,7 @@ static void rcu_check_gp_kthread_starvation(void)
 	struct task_struct *gpk = rcu_state.gp_kthread;
 	unsigned long j;
 
-	j = jiffies - READ_ONCE(rcu_state.gp_activity);
-	if (j > 2 * HZ) {
+	if (rcu_is_gp_kthread_starving(&j)) {
 		pr_err("%s kthread starved for %ld jiffies! g%ld f%#x %s(%d) ->state=%#lx ->cpu=%d\n",
 		       rcu_state.name, j,
 		       (long)rcu_seq_current(&rcu_state.gp_seq),
@@ -364,6 +377,7 @@ static void rcu_check_gp_kthread_starvation(void)
 		       gp_state_getname(rcu_state.gp_state), rcu_state.gp_state,
 		       gpk ? gpk->state : ~0, gpk ? task_cpu(gpk) : -1);
 		if (gpk) {
+			pr_err("\tUnless %s kthread gets sufficient CPU time, OOM is now expected behavior.\n", rcu_state.name);
 			pr_err("RCU grace-period kthread stack dump:\n");
 			sched_show_task(gpk);
 			wake_up_process(gpk);
