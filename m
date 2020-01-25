Return-Path: <SRS0=aedO=3O=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.7 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CD9D3C35244
	for <linux-kernel@archiver.kernel.org>; Sat, 25 Jan 2020 10:46:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id ABB0E218AC
	for <linux-kernel@archiver.kernel.org>; Sat, 25 Jan 2020 10:46:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730088AbgAYKqH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 25 Jan 2020 05:46:07 -0500
Received: from Galois.linutronix.de ([193.142.43.55]:44181 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727215AbgAYKm4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 25 Jan 2020 05:42:56 -0500
Received: from [5.158.153.53] (helo=tip-bot2.lab.linutronix.de)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tip-bot2@linutronix.de>)
        id 1ivItx-0008Of-IW; Sat, 25 Jan 2020 11:42:53 +0100
Received: from [127.0.1.1] (localhost [IPv6:::1])
        by tip-bot2.lab.linutronix.de (Postfix) with ESMTP id B1B6F1C1A79;
        Sat, 25 Jan 2020 11:42:44 +0100 (CET)
Date:   Sat, 25 Jan 2020 10:42:44 -0000
From:   "tip-bot2 for Joel Fernandes (Google)" <tip-bot2@linutronix.de>
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: core/rcu] rcu: Add support for debug_objects debugging for kfree_rcu()
Cc:     "Joel Fernandes (Google)" <joel@joelfernandes.org>,
        "Paul E. McKenney" <paulmck@kernel.org>, x86 <x86@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <157994896449.396.2829071003515065139.tip-bot2@tip-bot2>
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

Commit-ID:     e99637becb2e684bee2b9117f817f4d1346b8353
Gitweb:        https://git.kernel.org/tip/e99637becb2e684bee2b9117f817f4d1346b8353
Author:        Joel Fernandes (Google) <joel@joelfernandes.org>
AuthorDate:    Sun, 22 Sep 2019 13:03:17 -07:00
Committer:     Paul E. McKenney <paulmck@kernel.org>
CommitterDate: Fri, 24 Jan 2020 10:24:31 -08:00

rcu: Add support for debug_objects debugging for kfree_rcu()

This commit applies RCU's debug_objects debugging to the new batched
kfree_rcu() implementations.  The object is queued at the kfree_rcu()
call and dequeued during reclaim.

Tested that enabling CONFIG_DEBUG_OBJECTS_RCU_HEAD successfully detects
double kfree_rcu() calls.

Signed-off-by: Joel Fernandes (Google) <joel@joelfernandes.org>
[ paulmck: Fix IRQ per kbuild test robot <lkp@intel.com> feedback. ]
Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
---
 kernel/rcu/tree.c | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/kernel/rcu/tree.c b/kernel/rcu/tree.c
index a40fd58..0512221 100644
--- a/kernel/rcu/tree.c
+++ b/kernel/rcu/tree.c
@@ -2749,6 +2749,7 @@ static void kfree_rcu_work(struct work_struct *work)
 	for (; head; head = next) {
 		next = head->next;
 		// Potentially optimize with kfree_bulk in future.
+		debug_rcu_head_unqueue(head);
 		__rcu_reclaim(rcu_state.name, head);
 		cond_resched_tasks_rcu_qs();
 	}
@@ -2855,6 +2856,12 @@ void kfree_call_rcu(struct rcu_head *head, rcu_callback_t func)
 		spin_lock(&krcp->lock);
 
 	// Queue the object but don't yet schedule the batch.
+	if (debug_rcu_head_queue(head)) {
+		// Probable double kfree_rcu(), just leak.
+		WARN_ONCE(1, "%s(): Double-freed call. rcu_head %p\n",
+			  __func__, head);
+		goto unlock_return;
+	}
 	head->func = func;
 	head->next = krcp->head;
 	krcp->head = head;
@@ -2866,6 +2873,7 @@ void kfree_call_rcu(struct rcu_head *head, rcu_callback_t func)
 		schedule_delayed_work(&krcp->monitor_work, KFREE_DRAIN_JIFFIES);
 	}
 
+unlock_return:
 	if (krcp->initialized)
 		spin_unlock(&krcp->lock);
 	local_irq_restore(flags);
