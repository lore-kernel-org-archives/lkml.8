Return-Path: <SRS0=aedO=3O=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.8 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E2CDEC2D0DB
	for <linux-kernel@archiver.kernel.org>; Sat, 25 Jan 2020 10:46:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C343924687
	for <linux-kernel@archiver.kernel.org>; Sat, 25 Jan 2020 10:46:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730492AbgAYKqg (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 25 Jan 2020 05:46:36 -0500
Received: from Galois.linutronix.de ([193.142.43.55]:44136 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729159AbgAYKmv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 25 Jan 2020 05:42:51 -0500
Received: from [5.158.153.53] (helo=tip-bot2.lab.linutronix.de)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tip-bot2@linutronix.de>)
        id 1ivItq-0008NZ-R6; Sat, 25 Jan 2020 11:42:46 +0100
Received: from [127.0.1.1] (localhost [IPv6:::1])
        by tip-bot2.lab.linutronix.de (Postfix) with ESMTP id BA99A1C1A77;
        Sat, 25 Jan 2020 11:42:43 +0100 (CET)
Date:   Sat, 25 Jan 2020 10:42:43 -0000
From:   "tip-bot2 for Lai Jiangshan" <tip-bot2@linutronix.de>
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: core/rcu] rcu: Rename some instance of CONFIG_PREEMPTION to
 CONFIG_PREEMPT_RCU
Cc:     Lai Jiangshan <jiangshanlai@gmail.com>,
        Lai Jiangshan <laijs@linux.alibaba.com>,
        "Paul E. McKenney" <paulmck@kernel.org>, x86 <x86@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <157994896357.396.12909607905434566210.tip-bot2@tip-bot2>
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

Commit-ID:     c130d2dc93cd03323494d82dbe7b5fb0d101ab62
Gitweb:        https://git.kernel.org/tip/c130d2dc93cd03323494d82dbe7b5fb0d101ab62
Author:        Lai Jiangshan <jiangshanlai@gmail.com>
AuthorDate:    Tue, 15 Oct 2019 10:28:48 
Committer:     Paul E. McKenney <paulmck@kernel.org>
CommitterDate: Fri, 24 Jan 2020 10:26:28 -08:00

rcu: Rename some instance of CONFIG_PREEMPTION to CONFIG_PREEMPT_RCU

CONFIG_PREEMPTION and CONFIG_PREEMPT_RCU are always identical,
but some code depends on CONFIG_PREEMPTION to access to
rcu_preempt functionality. This patch changes CONFIG_PREEMPTION
to CONFIG_PREEMPT_RCU in these cases.

Signed-off-by: Lai Jiangshan <jiangshanlai@gmail.com>
Signed-off-by: Lai Jiangshan <laijs@linux.alibaba.com>
Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
---
 kernel/rcu/tree.c       | 4 ++--
 kernel/rcu/tree_stall.h | 6 +++---
 2 files changed, 5 insertions(+), 5 deletions(-)

diff --git a/kernel/rcu/tree.c b/kernel/rcu/tree.c
index c9dbb05..5445da2 100644
--- a/kernel/rcu/tree.c
+++ b/kernel/rcu/tree.c
@@ -1934,7 +1934,7 @@ rcu_report_unblock_qs_rnp(struct rcu_node *rnp, unsigned long flags)
 	struct rcu_node *rnp_p;
 
 	raw_lockdep_assert_held_rcu_node(rnp);
-	if (WARN_ON_ONCE(!IS_ENABLED(CONFIG_PREEMPTION)) ||
+	if (WARN_ON_ONCE(!IS_ENABLED(CONFIG_PREEMPT_RCU)) ||
 	    WARN_ON_ONCE(rcu_preempt_blocked_readers_cgp(rnp)) ||
 	    rnp->qsmask != 0) {
 		raw_spin_unlock_irqrestore_rcu_node(rnp, flags);
@@ -2294,7 +2294,7 @@ static void force_qs_rnp(int (*f)(struct rcu_data *rdp))
 		mask = 0;
 		raw_spin_lock_irqsave_rcu_node(rnp, flags);
 		if (rnp->qsmask == 0) {
-			if (!IS_ENABLED(CONFIG_PREEMPTION) ||
+			if (!IS_ENABLED(CONFIG_PREEMPT_RCU) ||
 			    rcu_preempt_blocked_readers_cgp(rnp)) {
 				/*
 				 * No point in scanning bits because they
diff --git a/kernel/rcu/tree_stall.h b/kernel/rcu/tree_stall.h
index c0b8c45..a6652ef 100644
--- a/kernel/rcu/tree_stall.h
+++ b/kernel/rcu/tree_stall.h
@@ -163,7 +163,7 @@ static void rcu_iw_handler(struct irq_work *iwp)
 //
 // Printing RCU CPU stall warnings
 
-#ifdef CONFIG_PREEMPTION
+#ifdef CONFIG_PREEMPT_RCU
 
 /*
  * Dump detailed information for all tasks blocking the current RCU
@@ -215,7 +215,7 @@ static int rcu_print_task_stall(struct rcu_node *rnp)
 	return ndetected;
 }
 
-#else /* #ifdef CONFIG_PREEMPTION */
+#else /* #ifdef CONFIG_PREEMPT_RCU */
 
 /*
  * Because preemptible RCU does not exist, we never have to check for
@@ -233,7 +233,7 @@ static int rcu_print_task_stall(struct rcu_node *rnp)
 {
 	return 0;
 }
-#endif /* #else #ifdef CONFIG_PREEMPTION */
+#endif /* #else #ifdef CONFIG_PREEMPT_RCU */
 
 /*
  * Dump stacks of all tasks running on stalled CPUs.  First try using
