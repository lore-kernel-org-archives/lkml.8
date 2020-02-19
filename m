Return-Path: <SRS0=ZTvs=4H=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D3DF4C34047
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Feb 2020 13:56:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B261E24672
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Feb 2020 13:56:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727960AbgBSN4a (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 19 Feb 2020 08:56:30 -0500
Received: from outbound-smtp15.blacknight.com ([46.22.139.232]:33140 "EHLO
        outbound-smtp15.blacknight.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727402AbgBSN43 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Feb 2020 08:56:29 -0500
Received: from mail.blacknight.com (unknown [81.17.254.26])
        by outbound-smtp15.blacknight.com (Postfix) with ESMTPS id A78FF1C1991
        for <linux-kernel@vger.kernel.org>; Wed, 19 Feb 2020 13:56:27 +0000 (GMT)
Received: (qmail 12807 invoked from network); 19 Feb 2020 13:56:27 -0000
Received: from unknown (HELO stampy.112glenside.lan) (mgorman@techsingularity.net@[84.203.18.57])
  by 81.17.254.9 with ESMTPA; 19 Feb 2020 13:56:27 -0000
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
Date:   Wed, 19 Feb 2020 13:54:38 +0000
Message-Id: <20200219135442.18107-10-mgorman@techsingularity.net>
X-Mailer: git-send-email 2.16.4
In-Reply-To: <20200219135442.18107-1-mgorman@techsingularity.net>
References: <20200219135442.18107-1-mgorman@techsingularity.net>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Vincent Guittot <vincent.guittot@linaro.org>

Take into account the new runnable_avg signal to classify a group and to
mitigate the volatility of util_avg in face of intensive migration.

Signed-off-by: Vincent Guittot <vincent.guittot@linaro.org>
---
 kernel/sched/fair.c | 12 +++++++++++-
 1 file changed, 11 insertions(+), 1 deletion(-)

diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
index 1feac09f9b22..3d5b8240a356 100644
--- a/kernel/sched/fair.c
+++ b/kernel/sched/fair.c
@@ -7748,7 +7748,8 @@ struct sg_lb_stats {
 	unsigned long avg_load; /*Avg load across the CPUs of the group */
 	unsigned long group_load; /* Total load over the CPUs of the group */
 	unsigned long group_capacity;
-	unsigned long group_util; /* Total utilization of the group */
+	unsigned long group_util; /* Total utilization over the CPUs of the group */
+	unsigned long group_runnable; /* Total runnable time over the CPUs of the group */
 	unsigned int sum_nr_running; /* Nr of tasks running in the group */
 	unsigned int sum_h_nr_running; /* Nr of CFS tasks running in the group */
 	unsigned int idle_cpus;
@@ -7969,6 +7970,10 @@ group_has_capacity(unsigned int imbalance_pct, struct sg_lb_stats *sgs)
 	if (sgs->sum_nr_running < sgs->group_weight)
 		return true;
 
+	if ((sgs->group_capacity * imbalance_pct) <
+			(sgs->group_runnable * 100))
+		return false;
+
 	if ((sgs->group_capacity * 100) >
 			(sgs->group_util * imbalance_pct))
 		return true;
@@ -7994,6 +7999,10 @@ group_is_overloaded(unsigned int imbalance_pct, struct sg_lb_stats *sgs)
 			(sgs->group_util * imbalance_pct))
 		return true;
 
+	if ((sgs->group_capacity * imbalance_pct) <
+			(sgs->group_runnable * 100))
+		return true;
+
 	return false;
 }
 
@@ -8088,6 +8097,7 @@ static inline void update_sg_lb_stats(struct lb_env *env,
 
 		sgs->group_load += cpu_load(rq);
 		sgs->group_util += cpu_util(i);
+		sgs->group_runnable += cpu_runnable(rq);
 		sgs->sum_h_nr_running += rq->cfs.h_nr_running;
 
 		nr_running = rq->nr_running;
-- 
2.16.4

