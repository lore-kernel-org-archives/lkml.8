Return-Path: <SRS0=shi3=4A=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 13948C2BA83
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Feb 2020 15:46:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D8B6A206ED
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Feb 2020 15:46:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728544AbgBLPqL (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 12 Feb 2020 10:46:11 -0500
Received: from outbound-smtp17.blacknight.com ([46.22.139.234]:50736 "EHLO
        outbound-smtp17.blacknight.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1728052AbgBLPqK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Feb 2020 10:46:10 -0500
Received: from mail.blacknight.com (pemlinmail03.blacknight.ie [81.17.254.16])
        by outbound-smtp17.blacknight.com (Postfix) with ESMTPS id B0B771C2A0F
        for <linux-kernel@vger.kernel.org>; Wed, 12 Feb 2020 15:46:07 +0000 (GMT)
Received: (qmail 19967 invoked from network); 12 Feb 2020 15:46:07 -0000
Received: from unknown (HELO techsingularity.net) (mgorman@techsingularity.net@[84.203.18.57])
  by 81.17.254.9 with ESMTPSA (AES256-SHA encrypted, authenticated); 12 Feb 2020 15:46:07 -0000
Date:   Wed, 12 Feb 2020 15:46:06 +0000
From:   Mel Gorman <mgorman@techsingularity.net>
To:     Vincent Guittot <vincent.guittot@linaro.org>
Cc:     Ingo Molnar <mingo@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Juri Lelli <juri.lelli@redhat.com>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Ben Segall <bsegall@google.com>,
        Valentin Schneider <valentin.schneider@arm.com>,
        Phil Auld <pauld@redhat.com>,
        LKML <linux-kernel@vger.kernel.org>
Subject: [PATCH 10/11] sched/numa: Use similar logic to the load balancer for
 moving between domains with spare capacity
Message-ID: <20200212154606.GO3466@techsingularity.net>
References: <20200212093654.4816-1-mgorman@techsingularity.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-15
Content-Disposition: inline
In-Reply-To: <20200212093654.4816-1-mgorman@techsingularity.net>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The standard load balancer generally allows an imbalance to exist if
a domain has spare capacity. This patch uses similar logic within NUMA
balancing when moving a task to a preferred node. This is not a perfect
comparison with the load balancer but should be a close enough match
when the destination domain has spare capacity and the imbalance is not
too large.

Signed-off-by: Mel Gorman <mgorman@techsingularity.net>
---
 kernel/sched/fair.c | 114 ++++++++++++++++++++++++++++++++++++----------------
 1 file changed, 79 insertions(+), 35 deletions(-)

diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
index b2476ef0b056..69e41204cfae 100644
--- a/kernel/sched/fair.c
+++ b/kernel/sched/fair.c
@@ -1473,21 +1473,19 @@ bool should_numa_migrate_memory(struct task_struct *p, struct page * page,
 	       group_faults_cpu(ng, src_nid) * group_faults(p, dst_nid) * 4;
 }
 
-static inline unsigned long cfs_rq_runnable_load_avg(struct cfs_rq *cfs_rq);
-
-static unsigned long cpu_runnable_load(struct rq *rq)
-{
-	return cfs_rq_runnable_load_avg(&rq->cfs);
-}
-
 /* Cached statistics for all CPUs within a node */
 struct numa_stats {
-	unsigned long load;
+	unsigned long group_load;
+	unsigned long group_util;
 
 	/* Total compute capacity of CPUs on a node */
-	unsigned long compute_capacity;
+	unsigned long group_capacity;
+
+	unsigned int sum_nr_running;
 
 	/* Details on idle CPUs */
+	unsigned int group_weight;
+	int nr_idle;
 	int idle_cpu;
 };
 
@@ -1511,6 +1509,22 @@ static inline bool is_core_idle(int cpu)
 /* Forward declarations of select_idle_sibling helpers */
 static inline bool test_idle_cores(int cpu, bool def);
 
+/* Forward declarations of lb helpers */
+static unsigned long cpu_load(struct rq *rq);
+static inline unsigned long cpu_util(int cpu);
+static inline bool __lb_has_capacity(unsigned int imbalance_pct,
+	unsigned int sum_nr_running, unsigned int group_weight,
+	unsigned long group_capacity, unsigned long group_util);
+static inline long adjust_numa_imbalance(int imbalance, int src_nr_running);
+
+/* NUMA Balancing equivalents for LB helpers */
+static inline bool
+numa_has_capacity(unsigned int imbalance_pct, struct numa_stats *ns)
+{
+	return __lb_has_capacity(imbalance_pct, ns->sum_nr_running + 1,
+		ns->group_weight, ns->group_capacity, ns->group_util);
+}
+
 /*
  * Gather all necessary information to make NUMA balancing placement
  * decisions that are compatible with standard load balanced. This
@@ -1529,14 +1543,20 @@ update_numa_stats(struct numa_stats *ns, int nid,
 	ns->idle_cpu = -1;
 	for_each_cpu(cpu, cpumask_of_node(nid)) {
 		struct rq *rq = cpu_rq(cpu);
+		unsigned int nr_running = rq->nr_running;
 
-		ns->load += cpu_runnable_load(rq);
-		ns->compute_capacity += capacity_of(cpu);
+		ns->group_load += cpu_load(rq);
+		ns->group_util += cpu_util(cpu);
+		ns->group_capacity += capacity_of(cpu);
+		ns->group_weight++;
+		ns->sum_nr_running += nr_running;
 
-		if (find_idle && !rq->nr_running && idle_cpu(cpu)) {
+		if (!nr_running && idle_cpu(cpu)) {
 			int this_llc_id;
 
-			if (READ_ONCE(rq->numa_migrate_on) ||
+			ns->nr_idle++;
+
+			if (!find_idle || READ_ONCE(rq->numa_migrate_on) ||
 			    !cpumask_test_cpu(cpu, p->cpus_ptr))
 				continue;
 
@@ -1646,13 +1666,13 @@ static bool load_too_imbalanced(long src_load, long dst_load,
 	 * ------------ vs ---------
 	 * src_capacity    dst_capacity
 	 */
-	src_capacity = env->src_stats.compute_capacity;
-	dst_capacity = env->dst_stats.compute_capacity;
+	src_capacity = env->src_stats.group_capacity;
+	dst_capacity = env->dst_stats.group_capacity;
 
 	imb = abs(dst_load * src_capacity - src_load * dst_capacity);
 
-	orig_src_load = env->src_stats.load;
-	orig_dst_load = env->dst_stats.load;
+	orig_src_load = env->src_stats.group_load;
+	orig_dst_load = env->dst_stats.group_load;
 
 	old_imb = abs(orig_dst_load * src_capacity - orig_src_load * dst_capacity);
 
@@ -1799,8 +1819,8 @@ static void task_numa_compare(struct task_numa_env *env,
 	if (!load)
 		goto assign;
 
-	dst_load = env->dst_stats.load + load;
-	src_load = env->src_stats.load - load;
+	dst_load = env->dst_stats.group_load + load;
+	src_load = env->src_stats.group_load - load;
 
 	if (load_too_imbalanced(src_load, dst_load, env))
 		goto unlock;
@@ -1838,23 +1858,38 @@ static void task_numa_find_cpu(struct task_numa_env *env,
 	bool maymove = false;
 	int cpu;
 
-	load = task_h_load(env->p);
-	dst_load = env->dst_stats.load + load;
-	src_load = env->src_stats.load - load;
-
 	/*
-	 * If the improvement from just moving env->p direction is better
-	 * than swapping tasks around, check if a move is possible.
+	 * If the load balancer is unlikely to interfere with the task after
+	 * a migration then use an idle CPU.
 	 */
-	maymove = !load_too_imbalanced(src_load, dst_load, env);
+	if (env->dst_stats.idle_cpu >= 0) {
+		unsigned int imbalance;
+		int src_running, dst_running;
 
-	/* Use an idle CPU if one has been found already */
-	if (maymove && env->dst_stats.idle_cpu >= 0) {
-		env->dst_cpu = env->dst_stats.idle_cpu;
-		task_numa_assign(env, NULL, 0);
-		return;
+		/* Would movement cause an imbalance? */
+		src_running = env->src_stats.sum_nr_running - 1;
+		dst_running = env->src_stats.sum_nr_running + 1;
+		imbalance = max(0, dst_running - src_running);
+		imbalance = adjust_numa_imbalance(imbalance, src_running);
+
+		/* Use idle CPU there is spare capacity and no imbalance */
+		if (numa_has_capacity(env->imbalance_pct, &env->dst_stats) &&
+		    !imbalance) {
+			env->dst_cpu = env->dst_stats.idle_cpu;
+			task_numa_assign(env, NULL, 0);
+			return;
+		}
 	}
 
+	/*
+	 * If using an idle CPU would cause an imbalance that would likely
+	 * be overridden by the load balancer, consider the load instead.
+	 */
+	load = task_h_load(env->p);
+	dst_load = env->dst_stats.group_load + load;
+	src_load = env->src_stats.group_load - load;
+	maymove = !load_too_imbalanced(src_load, dst_load, env);
+
 	for_each_cpu(cpu, cpumask_of_node(env->dst_nid)) {
 		/* Skip this CPU if the source task cannot migrate */
 		if (!cpumask_test_cpu(cpu, env->p->cpus_ptr))
@@ -8048,18 +8083,27 @@ static inline int sg_imbalanced(struct sched_group *group)
  * any benefit for the load balance.
  */
 static inline bool
-group_has_capacity(unsigned int imbalance_pct, struct sg_lb_stats *sgs)
+__lb_has_capacity(unsigned int imbalance_pct, unsigned int sum_nr_running,
+	unsigned int group_weight, unsigned long group_capacity,
+	unsigned long group_util)
 {
-	if (sgs->sum_nr_running < sgs->group_weight)
+	if (sum_nr_running < group_weight)
 		return true;
 
-	if ((sgs->group_capacity * 100) >
-			(sgs->group_util * imbalance_pct))
+	if ((group_capacity * 100) >
+			(group_util * imbalance_pct))
 		return true;
 
 	return false;
 }
 
+static inline bool
+group_has_capacity(unsigned int imbalance_pct, struct sg_lb_stats *sgs)
+{
+	return __lb_has_capacity(imbalance_pct, sgs->sum_nr_running,
+		sgs->group_weight, sgs->group_capacity, sgs->group_util);
+}
+
 /*
  *  group_is_overloaded returns true if the group has more tasks than it can
  *  handle.
-- 
2.16.4

