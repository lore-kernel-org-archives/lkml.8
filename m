Return-Path: <SRS0=ABJN=6Z=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.8 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 113F6C47255
	for <linux-kernel@archiver.kernel.org>; Mon, 11 May 2020 21:03:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E3F082078A
	for <linux-kernel@archiver.kernel.org>; Mon, 11 May 2020 21:03:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732445AbgEKVDG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 11 May 2020 17:03:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44100 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1732034AbgEKU74 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 May 2020 16:59:56 -0400
Received: from Galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6A8B6C061A0C;
        Mon, 11 May 2020 13:59:56 -0700 (PDT)
Received: from [5.158.153.53] (helo=tip-bot2.lab.linutronix.de)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tip-bot2@linutronix.de>)
        id 1jYFWj-0005x4-KZ; Mon, 11 May 2020 22:59:53 +0200
Received: from [127.0.1.1] (localhost [IPv6:::1])
        by tip-bot2.lab.linutronix.de (Postfix) with ESMTP id 795B61C086B;
        Mon, 11 May 2020 22:59:39 +0200 (CEST)
Date:   Mon, 11 May 2020 20:59:39 -0000
From:   "tip-bot2 for Joel Fernandes (Google)" <tip-bot2@linutronix.de>
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: core/rcu] rcu/tree: Count number of batched kfree_rcu() locklessly
Cc:     "Joel Fernandes (Google)" <joel@joelfernandes.org>,
        "Paul E. McKenney" <paulmck@kernel.org>, x86 <x86@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <158923077939.390.4370771202419476177.tip-bot2@tip-bot2>
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

Commit-ID:     a6a82ce18ba443186545d3fefbee8b9419a859dc
Gitweb:        https://git.kernel.org/tip/a6a82ce18ba443186545d3fefbee8b9419a859dc
Author:        Joel Fernandes (Google) <joel@joelfernandes.org>
AuthorDate:    Mon, 16 Mar 2020 12:32:28 -04:00
Committer:     Paul E. McKenney <paulmck@kernel.org>
CommitterDate: Mon, 27 Apr 2020 11:02:50 -07:00

rcu/tree: Count number of batched kfree_rcu() locklessly

We can relax the correctness of counting of number of queued objects in
favor of not hurting performance, by locklessly sampling per-cpu
counters. This should be Ok since under high memory pressure, it should not
matter if we are off by a few objects while counting. The shrinker will
still do the reclaim.

Signed-off-by: Joel Fernandes (Google) <joel@joelfernandes.org>
[ paulmck: Remove unused "flags" variable. ]
Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
---
 kernel/rcu/tree.c | 10 ++++------
 1 file changed, 4 insertions(+), 6 deletions(-)

diff --git a/kernel/rcu/tree.c b/kernel/rcu/tree.c
index e299cd0..3f1f574 100644
--- a/kernel/rcu/tree.c
+++ b/kernel/rcu/tree.c
@@ -2939,7 +2939,7 @@ static inline bool queue_kfree_rcu_work(struct kfree_rcu_cpu *krcp)
 				krcp->head = NULL;
 			}
 
-			krcp->count = 0;
+			WRITE_ONCE(krcp->count, 0);
 
 			/*
 			 * One work is per one batch, so there are two "free channels",
@@ -3077,7 +3077,7 @@ void kfree_call_rcu(struct rcu_head *head, rcu_callback_t func)
 		krcp->head = head;
 	}
 
-	krcp->count++;
+	WRITE_ONCE(krcp->count, krcp->count + 1);
 
 	// Set timer to drain after KFREE_DRAIN_JIFFIES.
 	if (rcu_scheduler_active == RCU_SCHEDULER_RUNNING &&
@@ -3097,15 +3097,13 @@ static unsigned long
 kfree_rcu_shrink_count(struct shrinker *shrink, struct shrink_control *sc)
 {
 	int cpu;
-	unsigned long flags, count = 0;
+	unsigned long count = 0;
 
 	/* Snapshot count of all CPUs */
 	for_each_online_cpu(cpu) {
 		struct kfree_rcu_cpu *krcp = per_cpu_ptr(&krc, cpu);
 
-		spin_lock_irqsave(&krcp->lock, flags);
-		count += krcp->count;
-		spin_unlock_irqrestore(&krcp->lock, flags);
+		count += READ_ONCE(krcp->count);
 	}
 
 	return count;
