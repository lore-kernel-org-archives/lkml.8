Return-Path: <SRS0=tn8d=5J=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.8 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2BE40C41621
	for <linux-kernel@archiver.kernel.org>; Tue, 24 Mar 2020 09:18:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0A0FC20A8B
	for <linux-kernel@archiver.kernel.org>; Tue, 24 Mar 2020 09:18:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728047AbgCXJSW (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 24 Mar 2020 05:18:22 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:44069 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727571AbgCXJRE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 Mar 2020 05:17:04 -0400
Received: from [5.158.153.53] (helo=tip-bot2.lab.linutronix.de)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tip-bot2@linutronix.de>)
        id 1jGfgE-0008F1-Ol; Tue, 24 Mar 2020 10:17:02 +0100
Received: from [127.0.1.1] (localhost [IPv6:::1])
        by tip-bot2.lab.linutronix.de (Postfix) with ESMTP id E32471C070D;
        Tue, 24 Mar 2020 10:16:50 +0100 (CET)
Date:   Tue, 24 Mar 2020 09:16:50 -0000
From:   "tip-bot2 for Paul E. McKenney" <tip-bot2@linutronix.de>
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: core/rcu] rcu: Add *_ONCE() to rcu_node ->boost_kthread_status
Cc:     "Paul E. McKenney" <paulmck@kernel.org>, x86 <x86@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <158504141057.28353.4752019178570064910.tip-bot2@tip-bot2>
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

Commit-ID:     3ca3b0e2cbe0050d1777a22b7fc13cad620eb2ba
Gitweb:        https://git.kernel.org/tip/3ca3b0e2cbe0050d1777a22b7fc13cad620eb2ba
Author:        Paul E. McKenney <paulmck@kernel.org>
AuthorDate:    Wed, 08 Jan 2020 20:12:59 -08:00
Committer:     Paul E. McKenney <paulmck@kernel.org>
CommitterDate: Thu, 20 Feb 2020 15:58:22 -08:00

rcu: Add *_ONCE() to rcu_node ->boost_kthread_status

The rcu_node structure's ->boost_kthread_status field is accessed
locklessly, so this commit causes all updates to use WRITE_ONCE() and
all reads to use READ_ONCE().

This data race was reported by KCSAN.  Not appropriate for backporting
due to failure being unlikely.

Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
---
 kernel/rcu/tree_plugin.h | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/kernel/rcu/tree_plugin.h b/kernel/rcu/tree_plugin.h
index b5ba148..0f8b714 100644
--- a/kernel/rcu/tree_plugin.h
+++ b/kernel/rcu/tree_plugin.h
@@ -1032,18 +1032,18 @@ static int rcu_boost_kthread(void *arg)
 
 	trace_rcu_utilization(TPS("Start boost kthread@init"));
 	for (;;) {
-		rnp->boost_kthread_status = RCU_KTHREAD_WAITING;
+		WRITE_ONCE(rnp->boost_kthread_status, RCU_KTHREAD_WAITING);
 		trace_rcu_utilization(TPS("End boost kthread@rcu_wait"));
 		rcu_wait(rnp->boost_tasks || rnp->exp_tasks);
 		trace_rcu_utilization(TPS("Start boost kthread@rcu_wait"));
-		rnp->boost_kthread_status = RCU_KTHREAD_RUNNING;
+		WRITE_ONCE(rnp->boost_kthread_status, RCU_KTHREAD_RUNNING);
 		more2boost = rcu_boost(rnp);
 		if (more2boost)
 			spincnt++;
 		else
 			spincnt = 0;
 		if (spincnt > 10) {
-			rnp->boost_kthread_status = RCU_KTHREAD_YIELDING;
+			WRITE_ONCE(rnp->boost_kthread_status, RCU_KTHREAD_YIELDING);
 			trace_rcu_utilization(TPS("End boost kthread@rcu_yield"));
 			schedule_timeout_interruptible(2);
 			trace_rcu_utilization(TPS("Start boost kthread@rcu_yield"));
@@ -1082,7 +1082,7 @@ static void rcu_initiate_boost(struct rcu_node *rnp, unsigned long flags)
 			rnp->boost_tasks = rnp->gp_tasks;
 		raw_spin_unlock_irqrestore_rcu_node(rnp, flags);
 		rcu_wake_cond(rnp->boost_kthread_task,
-			      rnp->boost_kthread_status);
+			      READ_ONCE(rnp->boost_kthread_status));
 	} else {
 		raw_spin_unlock_irqrestore_rcu_node(rnp, flags);
 	}
