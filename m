Return-Path: <SRS0=tn8d=5J=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.8 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B0E40C54FCE
	for <linux-kernel@archiver.kernel.org>; Tue, 24 Mar 2020 09:16:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 940B12080C
	for <linux-kernel@archiver.kernel.org>; Tue, 24 Mar 2020 09:16:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727130AbgCXJQb (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 24 Mar 2020 05:16:31 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:43854 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726818AbgCXJQa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 Mar 2020 05:16:30 -0400
Received: from [5.158.153.53] (helo=tip-bot2.lab.linutronix.de)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tip-bot2@linutronix.de>)
        id 1jGfff-0007tz-57; Tue, 24 Mar 2020 10:16:27 +0100
Received: from [127.0.1.1] (localhost [IPv6:::1])
        by tip-bot2.lab.linutronix.de (Postfix) with ESMTP id A3DD81C0470;
        Tue, 24 Mar 2020 10:16:26 +0100 (CET)
Date:   Tue, 24 Mar 2020 09:16:26 -0000
From:   "tip-bot2 for Paul E. McKenney" <tip-bot2@linutronix.de>
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: core/rcu] rcu: Mark rcu_state.gp_seq to detect concurrent writes
Cc:     "Paul E. McKenney" <paulmck@kernel.org>, x86 <x86@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <158504138633.28353.3396536353132335945.tip-bot2@tip-bot2>
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

Commit-ID:     0f11ad323dd3d316830152de63b5737a6261ad14
Gitweb:        https://git.kernel.org/tip/0f11ad323dd3d316830152de63b5737a6261ad14
Author:        Paul E. McKenney <paulmck@kernel.org>
AuthorDate:    Mon, 10 Feb 2020 09:58:37 -08:00
Committer:     Paul E. McKenney <paulmck@kernel.org>
CommitterDate: Sat, 21 Mar 2020 16:13:39 -07:00

rcu: Mark rcu_state.gp_seq to detect concurrent writes

The rcu_state structure's gp_seq field is only to be modified by the RCU
grace-period kthread, which is single-threaded.  This commit therefore
enlists KCSAN's help in enforcing this restriction.

Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
---
 kernel/rcu/tree.c | 22 ++++++++--------------
 1 file changed, 8 insertions(+), 14 deletions(-)

diff --git a/kernel/rcu/tree.c b/kernel/rcu/tree.c
index 6c62481..739788f 100644
--- a/kernel/rcu/tree.c
+++ b/kernel/rcu/tree.c
@@ -1209,7 +1209,7 @@ static bool rcu_start_this_gp(struct rcu_node *rnp_start, struct rcu_data *rdp,
 		trace_rcu_this_gp(rnp, rdp, gp_seq_req, TPS("NoGPkthread"));
 		goto unlock_out;
 	}
-	trace_rcu_grace_period(rcu_state.name, READ_ONCE(rcu_state.gp_seq), TPS("newreq"));
+	trace_rcu_grace_period(rcu_state.name, rcu_state.gp_seq, TPS("newreq"));
 	ret = true;  /* Caller must wake GP kthread. */
 unlock_out:
 	/* Push furthest requested GP to leaf node and rcu_data structure. */
@@ -1657,8 +1657,7 @@ static void rcu_gp_fqs_loop(void)
 			WRITE_ONCE(rcu_state.jiffies_kick_kthreads,
 				   jiffies + (j ? 3 * j : 2));
 		}
-		trace_rcu_grace_period(rcu_state.name,
-				       READ_ONCE(rcu_state.gp_seq),
+		trace_rcu_grace_period(rcu_state.name, rcu_state.gp_seq,
 				       TPS("fqswait"));
 		rcu_state.gp_state = RCU_GP_WAIT_FQS;
 		ret = swait_event_idle_timeout_exclusive(
@@ -1672,13 +1671,11 @@ static void rcu_gp_fqs_loop(void)
 		/* If time for quiescent-state forcing, do it. */
 		if (ULONG_CMP_GE(jiffies, rcu_state.jiffies_force_qs) ||
 		    (gf & RCU_GP_FLAG_FQS)) {
-			trace_rcu_grace_period(rcu_state.name,
-					       READ_ONCE(rcu_state.gp_seq),
+			trace_rcu_grace_period(rcu_state.name, rcu_state.gp_seq,
 					       TPS("fqsstart"));
 			rcu_gp_fqs(first_gp_fqs);
 			first_gp_fqs = false;
-			trace_rcu_grace_period(rcu_state.name,
-					       READ_ONCE(rcu_state.gp_seq),
+			trace_rcu_grace_period(rcu_state.name, rcu_state.gp_seq,
 					       TPS("fqsend"));
 			cond_resched_tasks_rcu_qs();
 			WRITE_ONCE(rcu_state.gp_activity, jiffies);
@@ -1689,8 +1686,7 @@ static void rcu_gp_fqs_loop(void)
 			cond_resched_tasks_rcu_qs();
 			WRITE_ONCE(rcu_state.gp_activity, jiffies);
 			WARN_ON(signal_pending(current));
-			trace_rcu_grace_period(rcu_state.name,
-					       READ_ONCE(rcu_state.gp_seq),
+			trace_rcu_grace_period(rcu_state.name, rcu_state.gp_seq,
 					       TPS("fqswaitsig"));
 			ret = 1; /* Keep old FQS timing. */
 			j = jiffies;
@@ -1782,7 +1778,7 @@ static void rcu_gp_cleanup(void)
 		WRITE_ONCE(rcu_state.gp_flags, RCU_GP_FLAG_INIT);
 		WRITE_ONCE(rcu_state.gp_req_activity, jiffies);
 		trace_rcu_grace_period(rcu_state.name,
-				       READ_ONCE(rcu_state.gp_seq),
+				       rcu_state.gp_seq,
 				       TPS("newreq"));
 	} else {
 		WRITE_ONCE(rcu_state.gp_flags,
@@ -1801,8 +1797,7 @@ static int __noreturn rcu_gp_kthread(void *unused)
 
 		/* Handle grace-period start. */
 		for (;;) {
-			trace_rcu_grace_period(rcu_state.name,
-					       READ_ONCE(rcu_state.gp_seq),
+			trace_rcu_grace_period(rcu_state.name, rcu_state.gp_seq,
 					       TPS("reqwait"));
 			rcu_state.gp_state = RCU_GP_WAIT_GPS;
 			swait_event_idle_exclusive(rcu_state.gp_wq,
@@ -1815,8 +1810,7 @@ static int __noreturn rcu_gp_kthread(void *unused)
 			cond_resched_tasks_rcu_qs();
 			WRITE_ONCE(rcu_state.gp_activity, jiffies);
 			WARN_ON(signal_pending(current));
-			trace_rcu_grace_period(rcu_state.name,
-					       READ_ONCE(rcu_state.gp_seq),
+			trace_rcu_grace_period(rcu_state.name, rcu_state.gp_seq,
 					       TPS("reqwaitsig"));
 		}
 
