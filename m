Return-Path: <SRS0=aedO=3O=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.7 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 83FD7C35244
	for <linux-kernel@archiver.kernel.org>; Sat, 25 Jan 2020 10:46:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 625D0218AC
	for <linux-kernel@archiver.kernel.org>; Sat, 25 Jan 2020 10:46:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729360AbgAYKm6 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 25 Jan 2020 05:42:58 -0500
Received: from Galois.linutronix.de ([193.142.43.55]:44146 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729186AbgAYKmx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 25 Jan 2020 05:42:53 -0500
Received: from [5.158.153.53] (helo=tip-bot2.lab.linutronix.de)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tip-bot2@linutronix.de>)
        id 1ivItt-0008Pe-VJ; Sat, 25 Jan 2020 11:42:50 +0100
Received: from [127.0.1.1] (localhost [IPv6:::1])
        by tip-bot2.lab.linutronix.de (Postfix) with ESMTP id 3AF9A1C1A7A;
        Sat, 25 Jan 2020 11:42:45 +0100 (CET)
Date:   Sat, 25 Jan 2020 10:42:45 -0000
From:   "tip-bot2 for Joel Fernandes" <tip-bot2@linutronix.de>
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: core/rcu] rcu: Make kfree_rcu() use a non-atomic ->monitor_todo
Cc:     Joel Fernandes <joel@joelfernandes.org>,
        "Paul E. McKenney" <paulmck@kernel.org>, x86 <x86@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <157994896504.396.2565516660484596487.tip-bot2@tip-bot2>
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

Commit-ID:     569d767087ef56a59bc2d1d5f25ee447eeae442a
Gitweb:        https://git.kernel.org/tip/569d767087ef56a59bc2d1d5f25ee447eeae442a
Author:        Joel Fernandes <joel@joelfernandes.org>
AuthorDate:    Sun, 22 Sep 2019 10:49:57 -07:00
Committer:     Paul E. McKenney <paulmck@kernel.org>
CommitterDate: Fri, 24 Jan 2020 10:24:31 -08:00

rcu: Make kfree_rcu() use a non-atomic ->monitor_todo

Because the ->monitor_todo field is always protected by krcp->lock,
this commit downgrades from xchg() to non-atomic unmarked assignment
statements.

Signed-off-by: Joel Fernandes <joel@joelfernandes.org>
[ paulmck: Update to include early-boot kick code. ]
Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
---
 kernel/rcu/tree.c | 16 ++++++++++------
 1 file changed, 10 insertions(+), 6 deletions(-)

diff --git a/kernel/rcu/tree.c b/kernel/rcu/tree.c
index 0af016f..6106b9e 100644
--- a/kernel/rcu/tree.c
+++ b/kernel/rcu/tree.c
@@ -2708,7 +2708,7 @@ struct kfree_rcu_cpu {
 	struct rcu_head *head_free;
 	spinlock_t lock;
 	struct delayed_work monitor_work;
-	int monitor_todo;
+	bool monitor_todo;
 	bool initialized;
 };
 
@@ -2765,6 +2765,7 @@ static inline void kfree_rcu_drain_unlock(struct kfree_rcu_cpu *krcp,
 					  unsigned long flags)
 {
 	// Attempt to start a new batch.
+	krcp->monitor_todo = false;
 	if (queue_kfree_rcu_work(krcp)) {
 		// Success! Our job is done here.
 		spin_unlock_irqrestore(&krcp->lock, flags);
@@ -2772,8 +2773,8 @@ static inline void kfree_rcu_drain_unlock(struct kfree_rcu_cpu *krcp,
 	}
 
 	// Previous RCU batch still in progress, try again later.
-	if (!xchg(&krcp->monitor_todo, true))
-		schedule_delayed_work(&krcp->monitor_work, KFREE_DRAIN_JIFFIES);
+	krcp->monitor_todo = true;
+	schedule_delayed_work(&krcp->monitor_work, KFREE_DRAIN_JIFFIES);
 	spin_unlock_irqrestore(&krcp->lock, flags);
 }
 
@@ -2788,7 +2789,7 @@ static void kfree_rcu_monitor(struct work_struct *work)
 						 monitor_work.work);
 
 	spin_lock_irqsave(&krcp->lock, flags);
-	if (xchg(&krcp->monitor_todo, false))
+	if (krcp->monitor_todo)
 		kfree_rcu_drain_unlock(krcp, flags);
 	else
 		spin_unlock_irqrestore(&krcp->lock, flags);
@@ -2837,8 +2838,10 @@ void kfree_call_rcu(struct rcu_head *head, rcu_callback_t func)
 
 	// Set timer to drain after KFREE_DRAIN_JIFFIES.
 	if (rcu_scheduler_active == RCU_SCHEDULER_RUNNING &&
-	    !xchg(&krcp->monitor_todo, true))
+	    !krcp->monitor_todo) {
+		krcp->monitor_todo = true;
 		schedule_delayed_work(&krcp->monitor_work, KFREE_DRAIN_JIFFIES);
+	}
 
 	if (krcp->initialized)
 		spin_unlock(&krcp->lock);
@@ -2855,10 +2858,11 @@ void __init kfree_rcu_scheduler_running(void)
 		struct kfree_rcu_cpu *krcp = per_cpu_ptr(&krc, cpu);
 
 		spin_lock_irqsave(&krcp->lock, flags);
-		if (!krcp->head || xchg(&krcp->monitor_todo, true)) {
+		if (!krcp->head || krcp->monitor_todo) {
 			spin_unlock_irqrestore(&krcp->lock, flags);
 			continue;
 		}
+		krcp->monitor_todo = true;
 		schedule_delayed_work(&krcp->monitor_work, KFREE_DRAIN_JIFFIES);
 		spin_unlock_irqrestore(&krcp->lock, flags);
 	}
