Return-Path: <SRS0=fG1M=4C=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 35A2FC2BA83
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Feb 2020 08:17:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 067AB217F4
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Feb 2020 08:17:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728923AbgBNIRp (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 14 Feb 2020 03:17:45 -0500
Received: from outbound-smtp38.blacknight.com ([46.22.139.221]:59733 "EHLO
        outbound-smtp38.blacknight.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1728783AbgBNIRo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Feb 2020 03:17:44 -0500
Received: from mail.blacknight.com (unknown [81.17.254.10])
        by outbound-smtp38.blacknight.com (Postfix) with ESMTPS id A740513B8
        for <linux-kernel@vger.kernel.org>; Fri, 14 Feb 2020 08:17:41 +0000 (GMT)
Received: (qmail 17129 invoked from network); 14 Feb 2020 08:17:41 -0000
Received: from unknown (HELO techsingularity.net) (mgorman@techsingularity.net@[84.203.18.57])
  by 81.17.254.9 with ESMTPSA (AES256-SHA encrypted, authenticated); 14 Feb 2020 08:17:41 -0000
Date:   Fri, 14 Feb 2020 08:17:39 +0000
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
        LKML <linux-kernel@vger.kernel.org>
Subject: [PATCH 09/12] sched/numa: Prefer using an idle cpu as a migration
 target instead of comparing tasks
Message-ID: <20200214081739.GD3466@techsingularity.net>
References: <20200214081324.26859-1-mgorman@techsingularity.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-15
Content-Disposition: inline
In-Reply-To: <20200214081324.26859-1-mgorman@techsingularity.net>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

task_numa_find_cpu can scan a node multiple times. Minimally it scans to
gather statistics and later to find a suitable target. In some cases, the
second scan will simply pick an idle CPU if the load is not imbalanced.

This patch caches information on an idle core while gathering statistics
and uses it immediately if load is not imbalanced to avoid a second scan
of the node runqueues. Preference is given to an idle core rather than an
idle SMT sibling to avoid packing HT siblings due to linearly scanning the
node cpumask.

As a side-effect, even when the second scan is necessary, the importance
of using select_idle_sibling is much reduced because information on idle
CPUs is cached and can be reused.

Note that this patch actually makes is harder to move to an idle CPU
as multiple tasks can race for the same idle CPU due to a race checking
numa_migrate_on. This is addressed in the next patch.

Signed-off-by: Mel Gorman <mgorman@techsingularity.net>
---
 kernel/sched/fair.c | 119 ++++++++++++++++++++++++++++++++++++++++++++--------
 1 file changed, 102 insertions(+), 17 deletions(-)

diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
index 80c237677fc8..7d2f9440ef32 100644
--- a/kernel/sched/fair.c
+++ b/kernel/sched/fair.c
@@ -1500,8 +1500,29 @@ struct numa_stats {
 	unsigned int nr_running;
 	unsigned int weight;
 	enum numa_type node_type;
+	int idle_cpu;
 };
 
+static inline bool is_core_idle(int cpu)
+{
+#ifdef CONFIG_SCHED_SMT
+	int sibling;
+
+	for_each_cpu(sibling, cpu_smt_mask(cpu)) {
+		if (cpu == sibling)
+			continue;
+
+		if (!idle_cpu(cpu))
+			return false;
+	}
+#endif
+
+	return true;
+}
+
+/* Forward declarations of select_idle_sibling helpers */
+static inline bool test_idle_cores(int cpu, bool def);
+
 struct task_numa_env {
 	struct task_struct *p;
 
@@ -1537,15 +1558,39 @@ numa_type numa_classify(unsigned int imbalance_pct,
 	return node_fully_busy;
 }
 
+static inline int numa_idle_core(int idle_core, int cpu)
+{
+#ifdef CONFIG_SCHED_SMT
+	if (!static_branch_likely(&sched_smt_present) ||
+	    idle_core >= 0 || !test_idle_cores(cpu, false))
+		return idle_core;
+
+	/*
+	 * Prefer cores instead of packing HT siblings
+	 * and triggering future load balancing.
+	 */
+	if (is_core_idle(cpu))
+		idle_core = cpu;
+#endif
+
+	return idle_core;
+}
+
 /*
- * XXX borrowed from update_sg_lb_stats
+ * Gather all necessary information to make NUMA balancing placement
+ * decisions that are compatible with standard load balancer. This
+ * borrows code and logic from update_sg_lb_stats but sharing a
+ * common implementation is impractical.
  */
 static void update_numa_stats(struct task_numa_env *env,
-			      struct numa_stats *ns, int nid)
+			      struct numa_stats *ns, int nid,
+			      bool find_idle)
 {
-	int cpu;
+	int cpu, idle_core = -1;
 
 	memset(ns, 0, sizeof(*ns));
+	ns->idle_cpu = -1;
+
 	for_each_cpu(cpu, cpumask_of_node(nid)) {
 		struct rq *rq = cpu_rq(cpu);
 
@@ -1553,11 +1598,25 @@ static void update_numa_stats(struct task_numa_env *env,
 		ns->util += cpu_util(cpu);
 		ns->nr_running += rq->cfs.h_nr_running;
 		ns->compute_capacity += capacity_of(cpu);
+
+		if (find_idle && !rq->nr_running && idle_cpu(cpu)) {
+			if (READ_ONCE(rq->numa_migrate_on) ||
+			    !cpumask_test_cpu(cpu, env->p->cpus_ptr))
+				continue;
+
+			if (ns->idle_cpu == -1)
+				ns->idle_cpu = cpu;
+
+			idle_core = numa_idle_core(idle_core, cpu);
+		}
 	}
 
 	ns->weight = cpumask_weight(cpumask_of_node(nid));
 
 	ns->node_type = numa_classify(env->imbalance_pct, ns);
+
+	if (idle_core >= 0)
+		ns->idle_cpu = idle_core;
 }
 
 static void task_numa_assign(struct task_numa_env *env,
@@ -1566,7 +1625,7 @@ static void task_numa_assign(struct task_numa_env *env,
 	struct rq *rq = cpu_rq(env->dst_cpu);
 
 	/* Bail out if run-queue part of active NUMA balance. */
-	if (xchg(&rq->numa_migrate_on, 1))
+	if (env->best_cpu != env->dst_cpu && xchg(&rq->numa_migrate_on, 1))
 		return;
 
 	/*
@@ -1730,19 +1789,39 @@ static void task_numa_compare(struct task_numa_env *env,
 		goto unlock;
 
 assign:
-	/*
-	 * One idle CPU per node is evaluated for a task numa move.
-	 * Call select_idle_sibling to maybe find a better one.
-	 */
+	/* Evaluate an idle CPU for a task numa move. */
 	if (!cur) {
+		int cpu = env->dst_stats.idle_cpu;
+
+		/* Nothing cached so current CPU went idle since the search. */
+		if (cpu < 0)
+			cpu = env->dst_cpu;
+
 		/*
-		 * select_idle_siblings() uses an per-CPU cpumask that
-		 * can be used from IRQ context.
+		 * If the CPU is no longer truly idle and the previous best CPU
+		 * is, keep using it.
 		 */
-		local_irq_disable();
-		env->dst_cpu = select_idle_sibling(env->p, env->src_cpu,
+		if (!idle_cpu(cpu) && env->best_cpu >= 0 &&
+		    idle_cpu(env->best_cpu)) {
+			cpu = env->best_cpu;
+		}
+
+		/*
+		 * Use select_idle_sibling if the previously found idle CPU is
+		 * not idle any more.
+		 */
+		if (!idle_cpu(cpu)) {
+			/*
+			 * select_idle_siblings() uses an per-CPU cpumask that
+			 * can be used from IRQ context.
+			 */
+			local_irq_disable();
+			cpu = select_idle_sibling(env->p, env->src_cpu,
 						   env->dst_cpu);
-		local_irq_enable();
+			local_irq_enable();
+		}
+
+		env->dst_cpu = cpu;
 	}
 
 	task_numa_assign(env, cur, imp);
@@ -1771,8 +1850,14 @@ static void task_numa_find_cpu(struct task_numa_env *env,
 		imbalance = adjust_numa_imbalance(imbalance, src_running);
 
 		/* Use idle CPU if there is no imbalance */
-		if (!imbalance)
+		if (!imbalance) {
 			maymove = true;
+			if (env->dst_stats.idle_cpu >= 0) {
+				env->dst_cpu = env->dst_stats.idle_cpu;
+				task_numa_assign(env, NULL, 0);
+				return;
+			}
+		}
 	} else {
 		long src_load, dst_load, load;
 		/*
@@ -1845,10 +1930,10 @@ static int task_numa_migrate(struct task_struct *p)
 	dist = env.dist = node_distance(env.src_nid, env.dst_nid);
 	taskweight = task_weight(p, env.src_nid, dist);
 	groupweight = group_weight(p, env.src_nid, dist);
-	update_numa_stats(&env, &env.src_stats, env.src_nid);
+	update_numa_stats(&env, &env.src_stats, env.src_nid, false);
 	taskimp = task_weight(p, env.dst_nid, dist) - taskweight;
 	groupimp = group_weight(p, env.dst_nid, dist) - groupweight;
-	update_numa_stats(&env, &env.dst_stats, env.dst_nid);
+	update_numa_stats(&env, &env.dst_stats, env.dst_nid, true);
 
 	/* Try to find a spot on the preferred nid. */
 	task_numa_find_cpu(&env, taskimp, groupimp);
@@ -1881,7 +1966,7 @@ static int task_numa_migrate(struct task_struct *p)
 
 			env.dist = dist;
 			env.dst_nid = nid;
-			update_numa_stats(&env, &env.dst_stats, env.dst_nid);
+			update_numa_stats(&env, &env.dst_stats, env.dst_nid, true);
 			task_numa_find_cpu(&env, taskimp, groupimp);
 		}
 	}
-- 
2.16.4
