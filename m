Return-Path: <SRS0=8dav=5Y=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.8 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 25088C2BA2B
	for <linux-kernel@archiver.kernel.org>; Wed,  8 Apr 2020 12:20:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0306F206F7
	for <linux-kernel@archiver.kernel.org>; Wed,  8 Apr 2020 12:20:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728588AbgDHMUt (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 8 Apr 2020 08:20:49 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:49666 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728447AbgDHMUj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Apr 2020 08:20:39 -0400
Received: from [5.158.153.53] (helo=tip-bot2.lab.linutronix.de)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tip-bot2@linutronix.de>)
        id 1jM9gz-00065U-S0; Wed, 08 Apr 2020 14:20:30 +0200
Received: from [127.0.1.1] (localhost [IPv6:::1])
        by tip-bot2.lab.linutronix.de (Postfix) with ESMTP id 5E2F31C047B;
        Wed,  8 Apr 2020 14:20:26 +0200 (CEST)
Date:   Wed, 08 Apr 2020 12:20:25 -0000
From:   "tip-bot2 for Huaixin Chang" <tip-bot2@linutronix.de>
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: sched/urgent] sched/fair: Fix race between runtime distribution
 and assignment
Cc:     Ben Segall <bsegall@google.com>,
        Huaixin Chang <changhuaixin@linux.alibaba.com>,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>,
        Ingo Molnar <mingo@kernel.org>, x86 <x86@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <158634842599.28353.15465936535048490509.tip-bot2@tip-bot2>
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

The following commit has been merged into the sched/urgent branch of tip:

Commit-ID:     26a8b12747c975b33b4a82d62e4a307e1c07f31b
Gitweb:        https://git.kernel.org/tip/26a8b12747c975b33b4a82d62e4a307e1c07f31b
Author:        Huaixin Chang <changhuaixin@linux.alibaba.com>
AuthorDate:    Fri, 27 Mar 2020 11:26:25 +08:00
Committer:     Ingo Molnar <mingo@kernel.org>
CommitterDate: Wed, 08 Apr 2020 11:35:19 +02:00

sched/fair: Fix race between runtime distribution and assignment

Currently, there is a potential race between distribute_cfs_runtime()
and assign_cfs_rq_runtime(). Race happens when cfs_b->runtime is read,
distributes without holding lock and finds out there is not enough
runtime to charge against after distribution. Because
assign_cfs_rq_runtime() might be called during distribution, and use
cfs_b->runtime at the same time.

Fibtest is the tool to test this race. Assume all gcfs_rq is throttled
and cfs period timer runs, slow threads might run and sleep, returning
unused cfs_rq runtime and keeping min_cfs_rq_runtime in their local
pool. If all this happens sufficiently quickly, cfs_b->runtime will drop
a lot. If runtime distributed is large too, over-use of runtime happens.

A runtime over-using by about 70 percent of quota is seen when we
test fibtest on a 96-core machine. We run fibtest with 1 fast thread and
95 slow threads in test group, configure 10ms quota for this group and
see the CPU usage of fibtest is 17.0%, which is far more than the
expected 10%.

On a smaller machine with 32 cores, we also run fibtest with 96
threads. CPU usage is more than 12%, which is also more than expected
10%. This shows that on similar workloads, this race do affect CPU
bandwidth control.

Solve this by holding lock inside distribute_cfs_runtime().

Fixes: c06f04c70489 ("sched: Fix potential near-infinite distribute_cfs_runtime() loop")
Reviewed-by: Ben Segall <bsegall@google.com>
Signed-off-by: Huaixin Chang <changhuaixin@linux.alibaba.com>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Signed-off-by: Ingo Molnar <mingo@kernel.org>
Link: https://lore.kernel.org/lkml/20200325092602.22471-1-changhuaixin@linux.alibaba.com/
---
 kernel/sched/fair.c | 31 +++++++++++--------------------
 1 file changed, 11 insertions(+), 20 deletions(-)

diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
index fb025e9..95cbd9e 100644
--- a/kernel/sched/fair.c
+++ b/kernel/sched/fair.c
@@ -4836,11 +4836,10 @@ void unthrottle_cfs_rq(struct cfs_rq *cfs_rq)
 		resched_curr(rq);
 }
 
-static u64 distribute_cfs_runtime(struct cfs_bandwidth *cfs_b, u64 remaining)
+static void distribute_cfs_runtime(struct cfs_bandwidth *cfs_b)
 {
 	struct cfs_rq *cfs_rq;
-	u64 runtime;
-	u64 starting_runtime = remaining;
+	u64 runtime, remaining = 1;
 
 	rcu_read_lock();
 	list_for_each_entry_rcu(cfs_rq, &cfs_b->throttled_cfs_rq,
@@ -4855,10 +4854,13 @@ static u64 distribute_cfs_runtime(struct cfs_bandwidth *cfs_b, u64 remaining)
 		/* By the above check, this should never be true */
 		SCHED_WARN_ON(cfs_rq->runtime_remaining > 0);
 
+		raw_spin_lock(&cfs_b->lock);
 		runtime = -cfs_rq->runtime_remaining + 1;
-		if (runtime > remaining)
-			runtime = remaining;
-		remaining -= runtime;
+		if (runtime > cfs_b->runtime)
+			runtime = cfs_b->runtime;
+		cfs_b->runtime -= runtime;
+		remaining = cfs_b->runtime;
+		raw_spin_unlock(&cfs_b->lock);
 
 		cfs_rq->runtime_remaining += runtime;
 
@@ -4873,8 +4875,6 @@ next:
 			break;
 	}
 	rcu_read_unlock();
-
-	return starting_runtime - remaining;
 }
 
 /*
@@ -4885,7 +4885,6 @@ next:
  */
 static int do_sched_cfs_period_timer(struct cfs_bandwidth *cfs_b, int overrun, unsigned long flags)
 {
-	u64 runtime;
 	int throttled;
 
 	/* no need to continue the timer with no bandwidth constraint */
@@ -4914,24 +4913,17 @@ static int do_sched_cfs_period_timer(struct cfs_bandwidth *cfs_b, int overrun, u
 	cfs_b->nr_throttled += overrun;
 
 	/*
-	 * This check is repeated as we are holding onto the new bandwidth while
-	 * we unthrottle. This can potentially race with an unthrottled group
-	 * trying to acquire new bandwidth from the global pool. This can result
-	 * in us over-using our runtime if it is all used during this loop, but
-	 * only by limited amounts in that extreme case.
+	 * This check is repeated as we release cfs_b->lock while we unthrottle.
 	 */
 	while (throttled && cfs_b->runtime > 0 && !cfs_b->distribute_running) {
-		runtime = cfs_b->runtime;
 		cfs_b->distribute_running = 1;
 		raw_spin_unlock_irqrestore(&cfs_b->lock, flags);
 		/* we can't nest cfs_b->lock while distributing bandwidth */
-		runtime = distribute_cfs_runtime(cfs_b, runtime);
+		distribute_cfs_runtime(cfs_b);
 		raw_spin_lock_irqsave(&cfs_b->lock, flags);
 
 		cfs_b->distribute_running = 0;
 		throttled = !list_empty(&cfs_b->throttled_cfs_rq);
-
-		lsub_positive(&cfs_b->runtime, runtime);
 	}
 
 	/*
@@ -5065,10 +5057,9 @@ static void do_sched_cfs_slack_timer(struct cfs_bandwidth *cfs_b)
 	if (!runtime)
 		return;
 
-	runtime = distribute_cfs_runtime(cfs_b, runtime);
+	distribute_cfs_runtime(cfs_b);
 
 	raw_spin_lock_irqsave(&cfs_b->lock, flags);
-	lsub_positive(&cfs_b->runtime, runtime);
 	cfs_b->distribute_running = 0;
 	raw_spin_unlock_irqrestore(&cfs_b->lock, flags);
 }
