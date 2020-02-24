Return-Path: <SRS0=7TUr=4M=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 453E0C3567B
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Feb 2020 09:54:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1DC6220842
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Feb 2020 09:54:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727686AbgBXJyJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 24 Feb 2020 04:54:09 -0500
Received: from outbound-smtp08.blacknight.com ([46.22.139.13]:54279 "EHLO
        outbound-smtp08.blacknight.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726838AbgBXJyJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Feb 2020 04:54:09 -0500
Received: from mail.blacknight.com (pemlinmail04.blacknight.ie [81.17.254.17])
        by outbound-smtp08.blacknight.com (Postfix) with ESMTPS id 73A9C1C359D
        for <linux-kernel@vger.kernel.org>; Mon, 24 Feb 2020 09:54:07 +0000 (GMT)
Received: (qmail 25002 invoked from network); 24 Feb 2020 09:54:07 -0000
Received: from unknown (HELO stampy.112glenside.lan) (mgorman@techsingularity.net@[84.203.18.57])
  by 81.17.254.9 with ESMTPA; 24 Feb 2020 09:54:07 -0000
From:   Mel Gorman <mgorman@techsingularity.net>
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     Ingo Molnar <mingo@kernel.org>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Juri Lelli <juri.lelli@redhat.com>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Ben Segall <bsegall@google.com>,
        Valentin Schneider <valentin.schneider@arm.com>,
        Phil Auld <pauld@redhat.com>, Hillf Danton <hdanton@sina.com>,
        LKML <linux-kernel@vger.kernel.org>,
        Mel Gorman <mgorman@techsingularity.net>
Subject: [PATCH 09/13] sched/fair: Take into account runnable_avg to classify group
Date:   Mon, 24 Feb 2020 09:52:19 +0000
Message-Id: <20200224095223.13361-10-mgorman@techsingularity.net>
X-Mailer: git-send-email 2.16.4
In-Reply-To: <20200224095223.13361-1-mgorman@techsingularity.net>
References: <20200224095223.13361-1-mgorman@techsingularity.net>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Vincent Guittot <vincent.guittot@linaro.org>

Take into account the new runnable_avg signal to classify a group and to
mitigate the volatility of util_avg in face of intensive migration or
new task with random utilization.

Signed-off-by: Vincent Guittot <vincent.guittot@linaro.org>
Reviewed-by: "Dietmar Eggemann <dietmar.eggemann@arm.com>"
Signed-off-by: Mel Gorman <mgorman@techsingularity.net>
---
 kernel/sched/fair.c | 31 ++++++++++++++++++++++++++++++-
 1 file changed, 30 insertions(+), 1 deletion(-)

diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
index 24fbbb588df2..8ce9a04e7efb 100644
--- a/kernel/sched/fair.c
+++ b/kernel/sched/fair.c
@@ -5470,6 +5470,24 @@ static unsigned long cpu_runnable(struct rq *rq)
 	return cfs_rq_runnable_avg(&rq->cfs);
 }
 
+static unsigned long cpu_runnable_without(struct rq *rq, struct task_struct *p)
+{
+	struct cfs_rq *cfs_rq;
+	unsigned int runnable;
+
+	/* Task has no contribution or is new */
+	if (cpu_of(rq) != task_cpu(p) || !READ_ONCE(p->se.avg.last_update_time))
+		return cpu_runnable(rq);
+
+	cfs_rq = &rq->cfs;
+	runnable = READ_ONCE(cfs_rq->avg.runnable_avg);
+
+	/* Discount task's runnable from CPU's runnable */
+	lsub_positive(&runnable, p->se.avg.runnable_avg);
+
+	return runnable;
+}
+
 static unsigned long capacity_of(int cpu)
 {
 	return cpu_rq(cpu)->cpu_capacity;
@@ -7753,7 +7771,8 @@ struct sg_lb_stats {
 	unsigned long avg_load; /*Avg load across the CPUs of the group */
 	unsigned long group_load; /* Total load over the CPUs of the group */
 	unsigned long group_capacity;
-	unsigned long group_util; /* Total utilization of the group */
+	unsigned long group_util; /* Total utilization over the CPUs of the group */
+	unsigned long group_runnable; /* Total runnable time over the CPUs of the group */
 	unsigned int sum_nr_running; /* Nr of tasks running in the group */
 	unsigned int sum_h_nr_running; /* Nr of CFS tasks running in the group */
 	unsigned int idle_cpus;
@@ -7974,6 +7993,10 @@ group_has_capacity(unsigned int imbalance_pct, struct sg_lb_stats *sgs)
 	if (sgs->sum_nr_running < sgs->group_weight)
 		return true;
 
+	if ((sgs->group_capacity * imbalance_pct) <
+			(sgs->group_runnable * 100))
+		return false;
+
 	if ((sgs->group_capacity * 100) >
 			(sgs->group_util * imbalance_pct))
 		return true;
@@ -7999,6 +8022,10 @@ group_is_overloaded(unsigned int imbalance_pct, struct sg_lb_stats *sgs)
 			(sgs->group_util * imbalance_pct))
 		return true;
 
+	if ((sgs->group_capacity * imbalance_pct) <
+			(sgs->group_runnable * 100))
+		return true;
+
 	return false;
 }
 
@@ -8093,6 +8120,7 @@ static inline void update_sg_lb_stats(struct lb_env *env,
 
 		sgs->group_load += cpu_load(rq);
 		sgs->group_util += cpu_util(i);
+		sgs->group_runnable += cpu_runnable(rq);
 		sgs->sum_h_nr_running += rq->cfs.h_nr_running;
 
 		nr_running = rq->nr_running;
@@ -8368,6 +8396,7 @@ static inline void update_sg_wakeup_stats(struct sched_domain *sd,
 
 		sgs->group_load += cpu_load_without(rq, p);
 		sgs->group_util += cpu_util_without(i, p);
+		sgs->group_runnable += cpu_runnable_without(rq, p);
 		local = task_running_on_cpu(i, p);
 		sgs->sum_h_nr_running += rq->cfs.h_nr_running - local;
 
-- 
2.16.4

