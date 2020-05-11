Return-Path: <SRS0=ABJN=6Z=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.8 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4E105C47255
	for <linux-kernel@archiver.kernel.org>; Mon, 11 May 2020 21:01:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 308602078A
	for <linux-kernel@archiver.kernel.org>; Mon, 11 May 2020 21:01:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732303AbgEKVBe (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 11 May 2020 17:01:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44146 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1731956AbgEKVAE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 May 2020 17:00:04 -0400
Received: from Galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 83484C061A0C;
        Mon, 11 May 2020 14:00:04 -0700 (PDT)
Received: from [5.158.153.53] (helo=tip-bot2.lab.linutronix.de)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tip-bot2@linutronix.de>)
        id 1jYFWs-00061l-RJ; Mon, 11 May 2020 23:00:02 +0200
Received: from [127.0.1.1] (localhost [IPv6:::1])
        by tip-bot2.lab.linutronix.de (Postfix) with ESMTP id 4348F1C0845;
        Mon, 11 May 2020 22:59:44 +0200 (CEST)
Date:   Mon, 11 May 2020 20:59:44 -0000
From:   "tip-bot2 for Paul E. McKenney" <tip-bot2@linutronix.de>
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: core/rcu] rcu: Expedite first two FQS scans under
 callback-overload conditions
Cc:     "Paul E. McKenney" <paulmck@kernel.org>, x86 <x86@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <158923078420.390.1907320308978977444.tip-bot2@tip-bot2>
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

Commit-ID:     1fca4d12f46371a34bf90af87f49548dd026c3ca
Gitweb:        https://git.kernel.org/tip/1fca4d12f46371a34bf90af87f49548dd026c3ca
Author:        Paul E. McKenney <paulmck@kernel.org>
AuthorDate:    Sat, 22 Feb 2020 20:07:09 -08:00
Committer:     Paul E. McKenney <paulmck@kernel.org>
CommitterDate: Mon, 27 Apr 2020 11:01:16 -07:00

rcu: Expedite first two FQS scans under callback-overload conditions

Even if some CPUs have excessive numbers of callbacks, RCU's grace-period
kthread will still wait normally between successive force-quiescent-state
scans.  The first two are the most important, as they are the ones that
enlist aid from the scheduler when overloaded.  This commit therefore
omits the wait before the first and the second force-quiescent-state
scan under callback-overload conditions.

This approach was inspired by a discussion with Jeff Roberson.

Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
---
 kernel/rcu/tree.c | 19 +++++++++++++++----
 kernel/rcu/tree.h |  1 +
 2 files changed, 16 insertions(+), 4 deletions(-)

diff --git a/kernel/rcu/tree.c b/kernel/rcu/tree.c
index c88240a..0132bc6 100644
--- a/kernel/rcu/tree.c
+++ b/kernel/rcu/tree.c
@@ -1624,12 +1624,16 @@ static bool rcu_gp_fqs_check_wake(int *gfp)
 {
 	struct rcu_node *rnp = rcu_get_root();
 
-	/* Someone like call_rcu() requested a force-quiescent-state scan. */
+	// If under overload conditions, force an immediate FQS scan.
+	if (*gfp & RCU_GP_FLAG_OVLD)
+		return true;
+
+	// Someone like call_rcu() requested a force-quiescent-state scan.
 	*gfp = READ_ONCE(rcu_state.gp_flags);
 	if (*gfp & RCU_GP_FLAG_FQS)
 		return true;
 
-	/* The current grace period has completed. */
+	// The current grace period has completed.
 	if (!READ_ONCE(rnp->qsmask) && !rcu_preempt_blocked_readers_cgp(rnp))
 		return true;
 
@@ -1667,13 +1671,15 @@ static void rcu_gp_fqs(bool first_time)
 static void rcu_gp_fqs_loop(void)
 {
 	bool first_gp_fqs;
-	int gf;
+	int gf = 0;
 	unsigned long j;
 	int ret;
 	struct rcu_node *rnp = rcu_get_root();
 
 	first_gp_fqs = true;
 	j = READ_ONCE(jiffies_till_first_fqs);
+	if (rcu_state.cbovld)
+		gf = RCU_GP_FLAG_OVLD;
 	ret = 0;
 	for (;;) {
 		if (!ret) {
@@ -1698,7 +1704,11 @@ static void rcu_gp_fqs_loop(void)
 			trace_rcu_grace_period(rcu_state.name, rcu_state.gp_seq,
 					       TPS("fqsstart"));
 			rcu_gp_fqs(first_gp_fqs);
-			first_gp_fqs = false;
+			gf = 0;
+			if (first_gp_fqs) {
+				first_gp_fqs = false;
+				gf = rcu_state.cbovld ? RCU_GP_FLAG_OVLD : 0;
+			}
 			trace_rcu_grace_period(rcu_state.name, rcu_state.gp_seq,
 					       TPS("fqsend"));
 			cond_resched_tasks_rcu_qs();
@@ -1718,6 +1728,7 @@ static void rcu_gp_fqs_loop(void)
 				j = 1;
 			else
 				j = rcu_state.jiffies_force_qs - j;
+			gf = 0;
 		}
 	}
 }
diff --git a/kernel/rcu/tree.h b/kernel/rcu/tree.h
index 9dc2ec0..44edd0a 100644
--- a/kernel/rcu/tree.h
+++ b/kernel/rcu/tree.h
@@ -359,6 +359,7 @@ struct rcu_state {
 /* Values for rcu_state structure's gp_flags field. */
 #define RCU_GP_FLAG_INIT 0x1	/* Need grace-period initialization. */
 #define RCU_GP_FLAG_FQS  0x2	/* Need grace-period quiescent-state forcing. */
+#define RCU_GP_FLAG_OVLD 0x4	/* Experiencing callback overload. */
 
 /* Values for rcu_state structure's gp_state field. */
 #define RCU_GP_IDLE	 0	/* Initial state and no GP in progress. */
