Return-Path: <SRS0=/EmK=CQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 45E8AC433E2
	for <linux-kernel@archiver.kernel.org>; Mon,  7 Sep 2020 07:30:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 078B9207C3
	for <linux-kernel@archiver.kernel.org>; Mon,  7 Sep 2020 07:30:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727815AbgIGHaV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 7 Sep 2020 03:30:21 -0400
Received: from szxga06-in.huawei.com ([45.249.212.32]:48696 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726443AbgIGHaQ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Sep 2020 03:30:16 -0400
Received: from DGGEMS402-HUB.china.huawei.com (unknown [172.30.72.59])
        by Forcepoint Email with ESMTP id 62890A3BBFCE23E8395C;
        Mon,  7 Sep 2020 15:30:11 +0800 (CST)
Received: from SWX921481.china.huawei.com (10.126.201.74) by
 DGGEMS402-HUB.china.huawei.com (10.3.19.202) with Microsoft SMTP Server id
 14.3.487.0; Mon, 7 Sep 2020 15:30:04 +0800
From:   Barry Song <song.bao.hua@hisilicon.com>
To:     <mingo@redhat.com>, <peterz@infradead.org>,
        <juri.lelli@redhat.com>, <vincent.guittot@linaro.org>,
        <dietmar.eggemann@arm.com>, <bsegall@google.com>,
        <mgorman@suse.de>, <linux-kernel@vger.kernel.org>
CC:     <linuxarm@huawei.com>, Barry Song <song.bao.hua@hisilicon.com>,
        Mel Gorman <mgorman@techsingularity.net>,
        Peter Zijlstra <a.p.zijlstra@chello.nl>,
        Valentin Schneider <valentin.schneider@arm.com>,
        Phil Auld <pauld@redhat.com>, Hillf Danton <hdanton@sina.com>,
        Ingo Molnar <mingo@kernel.org>
Subject: [PATCH] sched/fair: use dst group while checking imbalance for NUMA balancer
Date:   Mon, 7 Sep 2020 19:27:08 +1200
Message-ID: <20200907072708.8664-1-song.bao.hua@hisilicon.com>
X-Mailer: git-send-email 2.21.0.windows.1
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.126.201.74]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Something is wrong. In find_busiest_group(), we are checking if src has
higher load, however, in task_numa_find_cpu(), we are checking if dst
will have higher load after balancing. It seems it is not sensible to
check src.
It maybe cause wrong imbalance value, for example, if
dst_running = env->dst_stats.nr_running + 1 results in 3 or above, and
src_running = env->src_stats.nr_running - 1 results in 1;
The current code is thinking imbalance as 0 since src_running is smaller
than 2.
This is inconsistent with load balancer.

Fixes: fb86f5b211 ("sched/numa: Use similar logic to the load balancer for moving between domains with spare capacity")
Cc: Mel Gorman <mgorman@techsingularity.net>
Cc: Peter Zijlstra <a.p.zijlstra@chello.nl>
Cc: Vincent Guittot <vincent.guittot@linaro.org>
Cc: Juri Lelli <juri.lelli@redhat.com>
Cc: Dietmar Eggemann <dietmar.eggemann@arm.com>
Cc: Valentin Schneider <valentin.schneider@arm.com>
Cc: Phil Auld <pauld@redhat.com>
Cc: Hillf Danton <hdanton@sina.com>
Cc: Ingo Molnar <mingo@kernel.org>
Signed-off-by: Barry Song <song.bao.hua@hisilicon.com>
---
 kernel/sched/fair.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
index 1a68a05..90cfee7 100644
--- a/kernel/sched/fair.c
+++ b/kernel/sched/fair.c
@@ -1548,7 +1548,7 @@ struct task_numa_env {
 
 static unsigned long cpu_load(struct rq *rq);
 static unsigned long cpu_util(int cpu);
-static inline long adjust_numa_imbalance(int imbalance, int src_nr_running);
+static inline long adjust_numa_imbalance(int imbalance, int nr_running);
 
 static inline enum
 numa_type numa_classify(unsigned int imbalance_pct,
@@ -1925,7 +1925,7 @@ static void task_numa_find_cpu(struct task_numa_env *env,
 		src_running = env->src_stats.nr_running - 1;
 		dst_running = env->dst_stats.nr_running + 1;
 		imbalance = max(0, dst_running - src_running);
-		imbalance = adjust_numa_imbalance(imbalance, src_running);
+		imbalance = adjust_numa_imbalance(imbalance, dst_running);
 
 		/* Use idle CPU if there is no imbalance */
 		if (!imbalance) {
@@ -8957,7 +8957,7 @@ static inline void update_sd_lb_stats(struct lb_env *env, struct sd_lb_stats *sd
 	}
 }
 
-static inline long adjust_numa_imbalance(int imbalance, int src_nr_running)
+static inline long adjust_numa_imbalance(int imbalance, int nr_running)
 {
 	unsigned int imbalance_min;
 
@@ -8966,7 +8966,7 @@ static inline long adjust_numa_imbalance(int imbalance, int src_nr_running)
 	 * tasks that remain local when the source domain is almost idle.
 	 */
 	imbalance_min = 2;
-	if (src_nr_running <= imbalance_min)
+	if (nr_running <= imbalance_min)
 		return 0;
 
 	return imbalance;
-- 
2.7.4


