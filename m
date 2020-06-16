Return-Path: <SRS0=dgGg=75=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	UNPARSEABLE_RELAY,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 89A66C433E1
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Jun 2020 06:05:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 614602074D
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Jun 2020 06:05:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726959AbgFPGFs (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 16 Jun 2020 02:05:48 -0400
Received: from out30-57.freemail.mail.aliyun.com ([115.124.30.57]:42234 "EHLO
        out30-57.freemail.mail.aliyun.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725775AbgFPGFr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 Jun 2020 02:05:47 -0400
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R101e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=e01e01419;MF=rocking@linux.alibaba.com;NM=1;PH=DS;RN=9;SR=0;TI=SMTPD_---0U.l9QU7_1592287535;
Received: from localhost(mailfrom:rocking@linux.alibaba.com fp:SMTPD_---0U.l9QU7_1592287535)
          by smtp.aliyun-inc.com(127.0.0.1);
          Tue, 16 Jun 2020 14:05:43 +0800
From:   Peng Wang <rocking@linux.alibaba.com>
To:     mingo@redhat.com, peterz@infradead.org, juri.lelli@redhat.com,
        vincent.guittot@linaro.org, dietmar.eggemann@arm.com,
        rostedt@goodmis.org, bsegall@google.com, mgorman@suse.de
Cc:     linux-kernel@vger.kernel.org
Subject: [PATCH v2] sched/fair: Optimize dequeue_task_fair()
Date:   Tue, 16 Jun 2020 14:04:07 +0800
Message-Id: <701eef9a40de93dcf5fe7063fd607bca5db38e05.1592287263.git.rocking@linux.alibaba.com>
X-Mailer: git-send-email 2.9.5
In-Reply-To: <6f2f195aea48bc50187dfb064aa530ba132be01b.1592230286.git.rocking@linux.alibaba.com>
References: <6f2f195aea48bc50187dfb064aa530ba132be01b.1592230286.git.rocking@linux.alibaba.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

While looking at enqueue_task_fair and dequeue_task_fair, it occurred
to me that dequeue_task_fair can also be optimized as Vincent described
in commit 7d148be69e3a ("sched/fair: Optimize enqueue_task_fair()").

When encountering throttled cfs_rq, dequeue_throttle label can ensure
se not to be NULL, and rq->nr_running remains unchanged, so we can also
skip the early balance check.

Signed-off-by: Peng Wang <rocking@linux.alibaba.com>
---
 kernel/sched/fair.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
index cbcb2f7..05242b7 100644
--- a/kernel/sched/fair.c
+++ b/kernel/sched/fair.c
@@ -5614,14 +5614,14 @@ static void dequeue_task_fair(struct rq *rq, struct task_struct *p, int flags)
 
 	}
 
-dequeue_throttle:
-	if (!se)
-		sub_nr_running(rq, 1);
+	/* At this point se is NULL and we are at root level*/
+	sub_nr_running(rq, 1);
 
 	/* balance early to pull high priority tasks */
 	if (unlikely(!was_sched_idle && sched_idle_rq(rq)))
 		rq->next_balance = jiffies;
 
+dequeue_throttle:
 	util_est_dequeue(&rq->cfs, p, task_sleep);
 	hrtick_update(rq);
 }
-- 
2.9.5

