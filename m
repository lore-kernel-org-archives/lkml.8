Return-Path: <SRS0=s8dx=5M=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	UNPARSEABLE_RELAY,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6DAE1C43331
	for <linux-kernel@archiver.kernel.org>; Fri, 27 Mar 2020 03:26:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3AEDD20787
	for <linux-kernel@archiver.kernel.org>; Fri, 27 Mar 2020 03:26:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727666AbgC0D0q (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 26 Mar 2020 23:26:46 -0400
Received: from out30-44.freemail.mail.aliyun.com ([115.124.30.44]:50419 "EHLO
        out30-44.freemail.mail.aliyun.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726363AbgC0D0q (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 26 Mar 2020 23:26:46 -0400
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R171e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=e01f04397;MF=changhuaixin@linux.alibaba.com;NM=1;PH=DS;RN=10;SR=0;TI=SMTPD_---0Ttjxvmh_1585279600;
Received: from localhost(mailfrom:changhuaixin@linux.alibaba.com fp:SMTPD_---0Ttjxvmh_1585279600)
          by smtp.aliyun-inc.com(127.0.0.1);
          Fri, 27 Mar 2020 11:26:42 +0800
From:   Huaixin Chang <changhuaixin@linux.alibaba.com>
To:     linux-kernel@vger.kernel.org, changhuaixin@linux.alibaba.com
Cc:     shanpeic@linux.alibaba.com, yun.wang@linux.alibaba.com,
        xlpang@linux.alibaba.com, peterz@infradead.org, mingo@redhat.com,
        bsegall@google.com, chiluk+linux@indeed.com,
        vincent.guittot@linaro.org
Subject: [PATCH v3] sched/fair: Fix race between runtime distribution and assignment
Date:   Fri, 27 Mar 2020 11:26:25 +0800
Message-Id: <20200327032625.53856-1-changhuaixin@linux.alibaba.com>
X-Mailer: git-send-email 2.14.4.44.g2045bb6
In-Reply-To: <20200325092602.22471-1-changhuaixin@linux.alibaba.com>
References: <20200325092602.22471-1-changhuaixin@linux.alibaba.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

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
Signed-off-by: Huaixin Chang <changhuaixin@linux.alibaba.com>
Reviewed-by: Ben Segall <bsegall@google.com>
Link: https://lore.kernel.org/lkml/20200325092602.22471-1-changhuaixin@linux.alibaba.com/
---
 kernel/sched/fair.c | 31 +++++++++++--------------------
 1 file changed, 11 insertions(+), 20 deletions(-)

diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
index c1217bfe5e81..0eaa12d0f1b9 100644
--- a/kernel/sched/fair.c
+++ b/kernel/sched/fair.c
@@ -4629,11 +4629,10 @@ void unthrottle_cfs_rq(struct cfs_rq *cfs_rq)
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
@@ -4648,10 +4647,13 @@ static u64 distribute_cfs_runtime(struct cfs_bandwidth *cfs_b, u64 remaining)
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
 
@@ -4666,8 +4668,6 @@ static u64 distribute_cfs_runtime(struct cfs_bandwidth *cfs_b, u64 remaining)
 			break;
 	}
 	rcu_read_unlock();
-
-	return starting_runtime - remaining;
 }
 
 /*
@@ -4678,7 +4678,6 @@ static u64 distribute_cfs_runtime(struct cfs_bandwidth *cfs_b, u64 remaining)
  */
 static int do_sched_cfs_period_timer(struct cfs_bandwidth *cfs_b, int overrun, unsigned long flags)
 {
-	u64 runtime;
 	int throttled;
 
 	/* no need to continue the timer with no bandwidth constraint */
@@ -4707,24 +4706,17 @@ static int do_sched_cfs_period_timer(struct cfs_bandwidth *cfs_b, int overrun, u
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
@@ -4858,10 +4850,9 @@ static void do_sched_cfs_slack_timer(struct cfs_bandwidth *cfs_b)
 	if (!runtime)
 		return;
 
-	runtime = distribute_cfs_runtime(cfs_b, runtime);
+	distribute_cfs_runtime(cfs_b);
 
 	raw_spin_lock_irqsave(&cfs_b->lock, flags);
-	lsub_positive(&cfs_b->runtime, runtime);
 	cfs_b->distribute_running = 0;
 	raw_spin_unlock_irqrestore(&cfs_b->lock, flags);
 }
-- 
2.14.4.44.g2045bb6

