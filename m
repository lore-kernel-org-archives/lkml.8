Return-Path: <SRS0=shi3=4A=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D64AAC3B186
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Feb 2020 09:37:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AD94D206ED
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Feb 2020 09:37:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728927AbgBLJhE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 12 Feb 2020 04:37:04 -0500
Received: from outbound-smtp38.blacknight.com ([46.22.139.221]:45574 "EHLO
        outbound-smtp38.blacknight.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1728904AbgBLJhC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Feb 2020 04:37:02 -0500
Received: from mail.blacknight.com (unknown [81.17.254.10])
        by outbound-smtp38.blacknight.com (Postfix) with ESMTPS id 7F145C28
        for <linux-kernel@vger.kernel.org>; Wed, 12 Feb 2020 09:36:59 +0000 (GMT)
Received: (qmail 25367 invoked from network); 12 Feb 2020 09:36:59 -0000
Received: from unknown (HELO stampy.112glenside.lan) (mgorman@techsingularity.net@[84.203.18.57])
  by 81.17.254.9 with ESMTPA; 12 Feb 2020 09:36:59 -0000
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
        LKML <linux-kernel@vger.kernel.org>,
        Mel Gorman <mgorman@techsingularity.net>
Subject: [PATCH 06/11] sched/numa: Prefer using an idle cpu as a migration target instead of comparing tasks
Date:   Wed, 12 Feb 2020 09:36:49 +0000
Message-Id: <20200212093654.4816-7-mgorman@techsingularity.net>
X-Mailer: git-send-email 2.16.4
In-Reply-To: <20200212093654.4816-1-mgorman@techsingularity.net>
References: <20200212093654.4816-1-mgorman@techsingularity.net>
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
 kernel/sched/fair.c | 123 +++++++++++++++++++++++++++++++++++++++++++++-------
 1 file changed, 107 insertions(+), 16 deletions(-)

diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
index 6005ce28033b..d2a58b19430e 100644
--- a/kernel/sched/fair.c
+++ b/kernel/sched/fair.c
@@ -1486,23 +1486,87 @@ struct numa_stats {
 
 	/* Total compute capacity of CPUs on a node */
 	unsigned long compute_capacity;
+
+	/* Details on idle CPUs */
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
 /*
- * XXX borrowed from update_sg_lb_stats
+ * Gather all necessary information to make NUMA balancing placement
+ * decisions that are compatible with standard load balanced. This
+ * borrows code and logic from update_sg_lb_stats but sharing a
+ * common implementation is impractical.
  */
-static void update_numa_stats(struct numa_stats *ns, int nid)
+static void
+update_numa_stats(struct numa_stats *ns, int nid,
+		  struct task_struct *p, bool find_idle)
 {
-	int cpu;
+	int cpu, idle_core = -1;
+	int last_llc_id = -1;
+	bool check_smt = false;
 
 	memset(ns, 0, sizeof(*ns));
+	ns->idle_cpu = -1;
 	for_each_cpu(cpu, cpumask_of_node(nid)) {
 		struct rq *rq = cpu_rq(cpu);
 
 		ns->load += cpu_runnable_load(rq);
 		ns->compute_capacity += capacity_of(cpu);
+
+		if (find_idle && !rq->nr_running && idle_cpu(cpu)) {
+			int this_llc_id;
+
+			if (READ_ONCE(rq->numa_migrate_on) ||
+			    !cpumask_test_cpu(cpu, p->cpus_ptr))
+				continue;
+
+			if (ns->idle_cpu == -1)
+				ns->idle_cpu = cpu;
+
+			if (!static_branch_likely(&sched_smt_present) ||
+			    idle_core >= 0) {
+				continue;
+			}
+
+			/* Check if idle cores exist on this LLC */
+			this_llc_id = per_cpu(sd_llc_id, cpu);
+			if (last_llc_id != this_llc_id) {
+				check_smt = test_idle_cores(cpu, false);
+				last_llc_id = this_llc_id;
+			}
+
+			/*
+			 * Prefer cores instead of packing HT siblings
+			 * and triggering future load balancing.
+			 */
+			if (check_smt && is_core_idle(cpu))
+				idle_core = cpu;
+			check_smt = false;
+		}
 	}
 
+	if (idle_core >= 0)
+		ns->idle_cpu = idle_core;
 }
 
 struct task_numa_env {
@@ -1527,7 +1591,7 @@ static void task_numa_assign(struct task_numa_env *env,
 	struct rq *rq = cpu_rq(env->dst_cpu);
 
 	/* Bail out if run-queue part of active NUMA balance. */
-	if (xchg(&rq->numa_migrate_on, 1))
+	if (env->best_cpu != env->dst_cpu && xchg(&rq->numa_migrate_on, 1))
 		return;
 
 	/*
@@ -1691,19 +1755,39 @@ static void task_numa_compare(struct task_numa_env *env,
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
@@ -1728,6 +1812,13 @@ static void task_numa_find_cpu(struct task_numa_env *env,
 	 */
 	maymove = !load_too_imbalanced(src_load, dst_load, env);
 
+	/* Use an idle CPU if one has been found already */
+	if (maymove && env->dst_stats.idle_cpu >= 0) {
+		env->dst_cpu = env->dst_stats.idle_cpu;
+		task_numa_assign(env, NULL, 0);
+		return;
+	}
+
 	for_each_cpu(cpu, cpumask_of_node(env->dst_nid)) {
 		/* Skip this CPU if the source task cannot migrate */
 		if (!cpumask_test_cpu(cpu, env->p->cpus_ptr))
@@ -1788,10 +1879,10 @@ static int task_numa_migrate(struct task_struct *p)
 	dist = env.dist = node_distance(env.src_nid, env.dst_nid);
 	taskweight = task_weight(p, env.src_nid, dist);
 	groupweight = group_weight(p, env.src_nid, dist);
-	update_numa_stats(&env.src_stats, env.src_nid);
+	update_numa_stats(&env.src_stats, env.src_nid, env.p, false);
 	taskimp = task_weight(p, env.dst_nid, dist) - taskweight;
 	groupimp = group_weight(p, env.dst_nid, dist) - groupweight;
-	update_numa_stats(&env.dst_stats, env.dst_nid);
+	update_numa_stats(&env.dst_stats, env.dst_nid, env.p, true);
 
 	/* Try to find a spot on the preferred nid. */
 	task_numa_find_cpu(&env, taskimp, groupimp);
@@ -1824,7 +1915,7 @@ static int task_numa_migrate(struct task_struct *p)
 
 			env.dist = dist;
 			env.dst_nid = nid;
-			update_numa_stats(&env.dst_stats, env.dst_nid);
+			update_numa_stats(&env.dst_stats, env.dst_nid, env.p, true);
 			task_numa_find_cpu(&env, taskimp, groupimp);
 		}
 	}
-- 
2.16.4

