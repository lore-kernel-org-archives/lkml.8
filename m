Return-Path: <SRS0=fG1M=4C=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AB5BDC3B18F
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Feb 2020 08:12:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8892F222C2
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Feb 2020 08:12:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729035AbgBNIMc (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 14 Feb 2020 03:12:32 -0500
Received: from outbound-smtp40.blacknight.com ([46.22.139.223]:42688 "EHLO
        outbound-smtp40.blacknight.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1728791AbgBNIMY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Feb 2020 03:12:24 -0500
Received: from mail.blacknight.com (unknown [81.17.254.10])
        by outbound-smtp40.blacknight.com (Postfix) with ESMTPS id C71C61C2F77
        for <linux-kernel@vger.kernel.org>; Fri, 14 Feb 2020 08:12:21 +0000 (GMT)
Received: (qmail 30829 invoked from network); 14 Feb 2020 08:12:21 -0000
Received: from unknown (HELO stampy.112glenside.lan) (mgorman@techsingularity.net@[84.203.18.57])
  by 81.17.254.9 with ESMTPA; 14 Feb 2020 08:12:21 -0000
From:   Mel Gorman <mgorman@techsingularity.net>
To:     Vincent Guittot <vincent.guittot@linaro.org>
Cc:     Ingo Molnar <mingo@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Juri Lelli <juri.lelli@redhat.com>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Ben Segall <bsegall@google.com>,
        Valentin Schneider <valentin.schneider@arm.com>,
        Phil Auld <pauld@redhat.com>, Hillf Danton <hdanton@sina.com>,
        LKML <linux-kernel@vger.kernel.org>,
        Mel Gorman <mgorman@techsingularity.net>
Subject: [PATCH 06/12] sched/numa: Use similar logic to the load balancer for moving between domains with spare capacity
Date:   Fri, 14 Feb 2020 08:12:13 +0000
Message-Id: <20200214081219.26352-7-mgorman@techsingularity.net>
X-Mailer: git-send-email 2.16.4
In-Reply-To: <20200214081219.26352-1-mgorman@techsingularity.net>
References: <20200214081219.26352-1-mgorman@techsingularity.net>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The standard load balancer generally tries to keep the number of running
tasks or idle CPUs balanced between NUMA domains. The NUMA balancer allows
tasks to move if there is spare capacity but this causes a conflict and
utilisation between NUMA nodes gets badly skewed. This patch uses similar
logic between the NUMA balancer and load balancer when deciding if a task
migrating to its preferred node can use an idle CPU.

Signed-off-by: Mel Gorman <mgorman@suse.com>
---
 kernel/sched/fair.c | 76 +++++++++++++++++++++++++++++++----------------------
 1 file changed, 45 insertions(+), 31 deletions(-)

diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
index 52e74b53d6e7..ae7870f71457 100644
--- a/kernel/sched/fair.c
+++ b/kernel/sched/fair.c
@@ -1520,6 +1520,7 @@ struct task_numa_env {
 
 static unsigned long cpu_load(struct rq *rq);
 static unsigned long cpu_util(int cpu);
+static inline long adjust_numa_imbalance(int imbalance, int src_nr_running);
 
 static inline enum
 numa_type numa_classify(unsigned int imbalance_pct,
@@ -1594,11 +1595,6 @@ static bool load_too_imbalanced(long src_load, long dst_load,
 	long orig_src_load, orig_dst_load;
 	long src_capacity, dst_capacity;
 
-
-	/* If dst node has spare capacity, there is no real load imbalance */
-	if (env->dst_stats.node_type == node_has_spare)
-		return false;
-
 	/*
 	 * The load is corrected for the CPU capacity available on each node.
 	 *
@@ -1757,19 +1753,37 @@ static void task_numa_compare(struct task_numa_env *env,
 static void task_numa_find_cpu(struct task_numa_env *env,
 				long taskimp, long groupimp)
 {
-	long src_load, dst_load, load;
 	bool maymove = false;
 	int cpu;
 
-	load = task_h_load(env->p);
-	dst_load = env->dst_stats.load + load;
-	src_load = env->src_stats.load - load;
-
 	/*
-	 * If the improvement from just moving env->p direction is better
-	 * than swapping tasks around, check if a move is possible.
+	 * If dst node has spare capacity, then check if there is an
+	 * imbalance that would be overruled by the load balancer.
 	 */
-	maymove = !load_too_imbalanced(src_load, dst_load, env);
+	if (env->dst_stats.node_type == node_has_spare) {
+		unsigned int imbalance;
+		int src_running, dst_running;
+
+		/* Would movement cause an imbalance? */
+		src_running = env->src_stats.nr_running - 1;
+		dst_running = env->dst_stats.nr_running + 1;
+		imbalance = max(0, dst_running - src_running);
+		imbalance = adjust_numa_imbalance(imbalance, src_running);
+
+		/* Use idle CPU if there is no imbalance */
+		if (!imbalance)
+			maymove = true;
+	} else {
+		long src_load, dst_load, load;
+		/*
+		 * If the improvement from just moving env->p direction is better
+		 * than swapping tasks around, check if a move is possible.
+		 */
+		load = task_h_load(env->p);
+		dst_load = env->dst_stats.load + load;
+		src_load = env->src_stats.load - load;
+		maymove = !load_too_imbalanced(src_load, dst_load, env);
+	}
 
 	for_each_cpu(cpu, cpumask_of_node(env->dst_nid)) {
 		/* Skip this CPU if the source task cannot migrate */
@@ -8700,6 +8714,21 @@ static inline void update_sd_lb_stats(struct lb_env *env, struct sd_lb_stats *sd
 	}
 }
 
+static inline long adjust_numa_imbalance(int imbalance, int src_nr_running)
+{
+	unsigned int imbalance_min;
+
+	/*
+	 * Allow a small imbalance based on a simple pair of communicating
+	 * tasks that remain local when the source domain is almost idle.
+	 */
+	imbalance_min = 2;
+	if (src_nr_running <= imbalance_min)
+		return 0;
+
+	return imbalance;
+}
+
 /**
  * calculate_imbalance - Calculate the amount of imbalance present within the
  *			 groups of a given sched_domain during load balance.
@@ -8796,24 +8825,9 @@ static inline void calculate_imbalance(struct lb_env *env, struct sd_lb_stats *s
 		}
 
 		/* Consider allowing a small imbalance between NUMA groups */
-		if (env->sd->flags & SD_NUMA) {
-			unsigned int imbalance_min;
-
-			/*
-			 * Compute an allowed imbalance based on a simple
-			 * pair of communicating tasks that should remain
-			 * local and ignore them.
-			 *
-			 * NOTE: Generally this would have been based on
-			 * the domain size and this was evaluated. However,
-			 * the benefit is similar across a range of workloads
-			 * and machines but scaling by the domain size adds
-			 * the risk that lower domains have to be rebalanced.
-			 */
-			imbalance_min = 2;
-			if (busiest->sum_nr_running <= imbalance_min)
-				env->imbalance = 0;
-		}
+		if (env->sd->flags & SD_NUMA)
+			env->imbalance = adjust_numa_imbalance(env->imbalance,
+						busiest->sum_nr_running);
 
 		return;
 	}
-- 
2.16.4

