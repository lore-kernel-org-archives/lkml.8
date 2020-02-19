Return-Path: <SRS0=ZTvs=4H=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 624D7C34047
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Feb 2020 14:08:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3E85120801
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Feb 2020 14:08:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727980AbgBSOIl (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 19 Feb 2020 09:08:41 -0500
Received: from outbound-smtp45.blacknight.com ([46.22.136.57]:52849 "EHLO
        outbound-smtp45.blacknight.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727756AbgBSOIk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Feb 2020 09:08:40 -0500
Received: from mail.blacknight.com (pemlinmail01.blacknight.ie [81.17.254.10])
        by outbound-smtp45.blacknight.com (Postfix) with ESMTPS id 384E8FB13D
        for <linux-kernel@vger.kernel.org>; Wed, 19 Feb 2020 14:08:39 +0000 (GMT)
Received: (qmail 28871 invoked from network); 19 Feb 2020 14:08:39 -0000
Received: from unknown (HELO stampy.112glenside.lan) (mgorman@techsingularity.net@[84.203.18.57])
  by 81.17.254.9 with ESMTPA; 19 Feb 2020 14:08:38 -0000
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
Subject: [PATCH 05/13] sched/numa: Replace runnable_load_avg by load_avg
Date:   Wed, 19 Feb 2020 14:07:28 +0000
Message-Id: <20200219140736.20499-6-mgorman@techsingularity.net>
X-Mailer: git-send-email 2.16.4
In-Reply-To: <20200219140736.20499-1-mgorman@techsingularity.net>
References: <20200219140736.20499-1-mgorman@techsingularity.net>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Vincent Guittot <vincent.guittot@linaro.org>

Similarly to what has been done for the normal load balancer, we can
replace runnable_load_avg by load_avg in numa load balancing and track the
other statistics like the utilization and the number of running tasks to
get to better view of the current state of a node.

[mgorman@techsingularity.net: Remove premature definition of cpu_runnable_load]
Signed-off-by: Vincent Guittot <vincent.guittot@linaro.org>
Signed-off-by: Mel Gorman <mgorman@techsingularity.net>
---
 kernel/sched/fair.c | 97 ++++++++++++++++++++++++++++++++++++++---------------
 1 file changed, 70 insertions(+), 27 deletions(-)

diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
index 4395951b1530..52e74b53d6e7 100644
--- a/kernel/sched/fair.c
+++ b/kernel/sched/fair.c
@@ -1473,38 +1473,35 @@ bool should_numa_migrate_memory(struct task_struct *p, struct page * page,
 	       group_faults_cpu(ng, src_nid) * group_faults(p, dst_nid) * 4;
 }
 
-static inline unsigned long cfs_rq_runnable_load_avg(struct cfs_rq *cfs_rq);
-
-static unsigned long cpu_runnable_load(struct rq *rq)
-{
-	return cfs_rq_runnable_load_avg(&rq->cfs);
-}
+/*
+ * 'numa_type' describes the node at the moment of load balancing.
+ */
+enum numa_type {
+	/* The node has spare capacity that can be used to run more tasks.  */
+	node_has_spare = 0,
+	/*
+	 * The node is fully used and the tasks don't compete for more CPU
+	 * cycles. Nevertheless, some tasks might wait before running.
+	 */
+	node_fully_busy,
+	/*
+	 * The node is overloaded and can't provide expected CPU cycles to all
+	 * tasks.
+	 */
+	node_overloaded
+};
 
 /* Cached statistics for all CPUs within a node */
 struct numa_stats {
 	unsigned long load;
-
+	unsigned long util;
 	/* Total compute capacity of CPUs on a node */
 	unsigned long compute_capacity;
+	unsigned int nr_running;
+	unsigned int weight;
+	enum numa_type node_type;
 };
 
-/*
- * XXX borrowed from update_sg_lb_stats
- */
-static void update_numa_stats(struct numa_stats *ns, int nid)
-{
-	int cpu;
-
-	memset(ns, 0, sizeof(*ns));
-	for_each_cpu(cpu, cpumask_of_node(nid)) {
-		struct rq *rq = cpu_rq(cpu);
-
-		ns->load += cpu_runnable_load(rq);
-		ns->compute_capacity += capacity_of(cpu);
-	}
-
-}
-
 struct task_numa_env {
 	struct task_struct *p;
 
@@ -1521,6 +1518,47 @@ struct task_numa_env {
 	int best_cpu;
 };
 
+static unsigned long cpu_load(struct rq *rq);
+static unsigned long cpu_util(int cpu);
+
+static inline enum
+numa_type numa_classify(unsigned int imbalance_pct,
+			 struct numa_stats *ns)
+{
+	if ((ns->nr_running > ns->weight) &&
+	    ((ns->compute_capacity * 100) < (ns->util * imbalance_pct)))
+		return node_overloaded;
+
+	if ((ns->nr_running < ns->weight) ||
+	    ((ns->compute_capacity * 100) > (ns->util * imbalance_pct)))
+		return node_has_spare;
+
+	return node_fully_busy;
+}
+
+/*
+ * XXX borrowed from update_sg_lb_stats
+ */
+static void update_numa_stats(struct task_numa_env *env,
+			      struct numa_stats *ns, int nid)
+{
+	int cpu;
+
+	memset(ns, 0, sizeof(*ns));
+	for_each_cpu(cpu, cpumask_of_node(nid)) {
+		struct rq *rq = cpu_rq(cpu);
+
+		ns->load += cpu_load(rq);
+		ns->util += cpu_util(cpu);
+		ns->nr_running += rq->cfs.h_nr_running;
+		ns->compute_capacity += capacity_of(cpu);
+	}
+
+	ns->weight = cpumask_weight(cpumask_of_node(nid));
+
+	ns->node_type = numa_classify(env->imbalance_pct, ns);
+}
+
 static void task_numa_assign(struct task_numa_env *env,
 			     struct task_struct *p, long imp)
 {
@@ -1556,6 +1594,11 @@ static bool load_too_imbalanced(long src_load, long dst_load,
 	long orig_src_load, orig_dst_load;
 	long src_capacity, dst_capacity;
 
+
+	/* If dst node has spare capacity, there is no real load imbalance */
+	if (env->dst_stats.node_type == node_has_spare)
+		return false;
+
 	/*
 	 * The load is corrected for the CPU capacity available on each node.
 	 *
@@ -1788,10 +1831,10 @@ static int task_numa_migrate(struct task_struct *p)
 	dist = env.dist = node_distance(env.src_nid, env.dst_nid);
 	taskweight = task_weight(p, env.src_nid, dist);
 	groupweight = group_weight(p, env.src_nid, dist);
-	update_numa_stats(&env.src_stats, env.src_nid);
+	update_numa_stats(&env, &env.src_stats, env.src_nid);
 	taskimp = task_weight(p, env.dst_nid, dist) - taskweight;
 	groupimp = group_weight(p, env.dst_nid, dist) - groupweight;
-	update_numa_stats(&env.dst_stats, env.dst_nid);
+	update_numa_stats(&env, &env.dst_stats, env.dst_nid);
 
 	/* Try to find a spot on the preferred nid. */
 	task_numa_find_cpu(&env, taskimp, groupimp);
@@ -1824,7 +1867,7 @@ static int task_numa_migrate(struct task_struct *p)
 
 			env.dist = dist;
 			env.dst_nid = nid;
-			update_numa_stats(&env.dst_stats, env.dst_nid);
+			update_numa_stats(&env, &env.dst_stats, env.dst_nid);
 			task_numa_find_cpu(&env, taskimp, groupimp);
 		}
 	}
-- 
2.16.4

