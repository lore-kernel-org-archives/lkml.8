Return-Path: <SRS0=shi3=4A=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6489BC2BA83
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Feb 2020 15:46:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3A662206ED
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Feb 2020 15:46:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728576AbgBLPq1 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 12 Feb 2020 10:46:27 -0500
Received: from outbound-smtp27.blacknight.com ([81.17.249.195]:34431 "EHLO
        outbound-smtp27.blacknight.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1728052AbgBLPq1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Feb 2020 10:46:27 -0500
Received: from mail.blacknight.com (pemlinmail01.blacknight.ie [81.17.254.10])
        by outbound-smtp27.blacknight.com (Postfix) with ESMTPS id 003D6B8736
        for <linux-kernel@vger.kernel.org>; Wed, 12 Feb 2020 15:46:24 +0000 (GMT)
Received: (qmail 32079 invoked from network); 12 Feb 2020 15:46:24 -0000
Received: from unknown (HELO techsingularity.net) (mgorman@techsingularity.net@[84.203.18.57])
  by 81.17.254.9 with ESMTPSA (AES256-SHA encrypted, authenticated); 12 Feb 2020 15:46:24 -0000
Date:   Wed, 12 Feb 2020 15:46:23 +0000
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
Subject: [PATCH 11/11] sched/numa: Use similar logic to the load balancer for
 moving between overloaded domains
Message-ID: <20200212154623.GP3466@techsingularity.net>
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

The NUMA balancer compares task loads to determine if a task can move
to the preferred domain but this is not what the load balancer does.
Migrating a task to a preferred domain risks the NUMA balancer and load
balancer overriding each others decisions.

This patch brings the NUMA balancer more in line with the load balancer by
considering two cases when an idle CPU cannot be used. If the preferred
node has no spare capacity but a move to an idle CPU would not cause
a load imbalance then it's allowed. Alternatively, when comparing tasks
for swapping, it'll allow the swap if the load imbalance is reduced.

Signed-off-by: Mel Gorman <mgorman@techsingularity.net>
---
 kernel/sched/fair.c | 132 +++++++++++++++++++++++++++++-----------------------
 1 file changed, 75 insertions(+), 57 deletions(-)

diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
index 69e41204cfae..b5a93c345e97 100644
--- a/kernel/sched/fair.c
+++ b/kernel/sched/fair.c
@@ -1605,7 +1605,7 @@ struct task_numa_env {
 	int best_cpu;
 };
 
-static void task_numa_assign(struct task_numa_env *env,
+static bool task_numa_assign(struct task_numa_env *env,
 			     struct task_struct *p, long imp)
 {
 	struct rq *rq = cpu_rq(env->dst_cpu);
@@ -1629,7 +1629,7 @@ static void task_numa_assign(struct task_numa_env *env,
 		}
 
 		/* Failed to find an alternative idle CPU */
-		return;
+		return false;
 	}
 
 assign:
@@ -1650,34 +1650,39 @@ static void task_numa_assign(struct task_numa_env *env,
 	env->best_task = p;
 	env->best_imp = imp;
 	env->best_cpu = env->dst_cpu;
+	return true;
 }
 
-static bool load_too_imbalanced(long src_load, long dst_load,
-				struct task_numa_env *env)
+/*
+ * For overloaded domains, the load balancer compares average
+ * load -- See group_overloaded case in update_sd_pick_busiest.
+ * Return true if the load balancer has more work to do after
+ * a move.
+ */
+static bool load_degrades_imbalance(struct task_numa_env *env, long src_load, long dst_load)
 {
-	long imb, old_imb;
-	long orig_src_load, orig_dst_load;
-	long src_capacity, dst_capacity;
+	long cur_imb, new_imb;
+	long src_avg_load, dst_avg_load;
 
-	/*
-	 * The load is corrected for the CPU capacity available on each node.
-	 *
-	 * src_load        dst_load
-	 * ------------ vs ---------
-	 * src_capacity    dst_capacity
-	 */
-	src_capacity = env->src_stats.group_capacity;
-	dst_capacity = env->dst_stats.group_capacity;
-
-	imb = abs(dst_load * src_capacity - src_load * dst_capacity);
+	if (src_load == dst_load)
+		return false;
 
-	orig_src_load = env->src_stats.group_load;
-	orig_dst_load = env->dst_stats.group_load;
+	/* Current imbalance */
+	src_avg_load = (env->src_stats.group_load * SCHED_CAPACITY_SCALE) /
+			env->src_stats.group_capacity;
+	dst_avg_load = (env->dst_stats.group_load * SCHED_CAPACITY_SCALE) /
+			env->dst_stats.group_capacity;
+	cur_imb = abs(dst_avg_load - src_avg_load);
 
-	old_imb = abs(orig_dst_load * src_capacity - orig_src_load * dst_capacity);
+	/* Post-move imbalance */
+	src_avg_load = ((env->src_stats.group_load + dst_load - src_load) * SCHED_CAPACITY_SCALE) /
+			env->src_stats.group_capacity;
+	dst_avg_load = ((env->dst_stats.group_load + src_load - dst_load) * SCHED_CAPACITY_SCALE) /
+			env->dst_stats.group_capacity;
+	new_imb = abs(dst_avg_load - src_avg_load);
 
-	/* Would this change make things worse? */
-	return (imb > old_imb);
+	/* Does the move make the imbalance worse? */
+	return new_imb > cur_imb;
 }
 
 /*
@@ -1693,7 +1698,7 @@ static bool load_too_imbalanced(long src_load, long dst_load,
  * into account that it might be best if task running on the dst_cpu should
  * be exchanged with the source task
  */
-static void task_numa_compare(struct task_numa_env *env,
+static bool task_numa_compare(struct task_numa_env *env,
 			      long taskimp, long groupimp, bool maymove)
 {
 	struct numa_group *cur_ng, *p_ng = deref_curr_numa_group(env->p);
@@ -1703,10 +1708,9 @@ static void task_numa_compare(struct task_numa_env *env,
 	long src_load, dst_load;
 	int dist = env->dist;
 	long moveimp = imp;
-	long load;
 
 	if (READ_ONCE(dst_rq->numa_migrate_on))
-		return;
+		return false;
 
 	rcu_read_lock();
 	cur = rcu_dereference(dst_rq->curr);
@@ -1802,7 +1806,6 @@ static void task_numa_compare(struct task_numa_env *env,
 		goto assign;
 	}
 
-
 	/*
 	 * If the NUMA importance is less than SMALLIMP,
 	 * task migration might only result in ping pong
@@ -1812,17 +1815,10 @@ static void task_numa_compare(struct task_numa_env *env,
 	if (imp < SMALLIMP || imp <= env->best_imp + SMALLIMP / 2)
 		goto unlock;
 
-	/*
-	 * In the overloaded case, try and keep the load balanced.
-	 */
-	load = task_h_load(env->p) - task_h_load(cur);
-	if (!load)
-		goto assign;
-
-	dst_load = env->dst_stats.group_load + load;
-	src_load = env->src_stats.group_load - load;
-
-	if (load_too_imbalanced(src_load, dst_load, env))
+	/* In the overloaded case, try and keep the load balanced. */
+	src_load = task_h_load(env->p);
+	dst_load = task_h_load(cur);
+	if (load_degrades_imbalance(env, src_load, dst_load))
 		goto unlock;
 
 assign:
@@ -1849,20 +1845,41 @@ static void task_numa_compare(struct task_numa_env *env,
 	task_numa_assign(env, cur, imp);
 unlock:
 	rcu_read_unlock();
+
+	/*
+	 * If a move to idle is allowed because there is capacity or load
+	 * balance improves then stop the search. While a better swap
+	 * candidate may exist, a search is not free.
+	 */
+	if (maymove && !cur)
+		return true;
+
+	/*
+	 * If a swap candidate must be identified and the best one moves to
+	 * its preferred node then stop the search. Search is not free.
+	 */
+	if (!maymove && env->best_task &&
+	    env->best_task->numa_preferred_nid == env->src_nid) {
+		return true;
+	}
+
+	return false;
 }
 
 static void task_numa_find_cpu(struct task_numa_env *env,
 				long taskimp, long groupimp)
 {
-	long src_load, dst_load, load;
-	bool maymove = false;
 	int cpu;
+	bool has_capacity;
+	bool maymove = false;
+
+	has_capacity = numa_has_capacity(env->imbalance_pct, &env->dst_stats);
 
 	/*
 	 * If the load balancer is unlikely to interfere with the task after
-	 * a migration then use an idle CPU.
+	 * a migration then try use an idle CPU.
 	 */
-	if (env->dst_stats.idle_cpu >= 0) {
+	if (has_capacity) {
 		unsigned int imbalance;
 		int src_running, dst_running;
 
@@ -1872,31 +1889,32 @@ static void task_numa_find_cpu(struct task_numa_env *env,
 		imbalance = max(0, dst_running - src_running);
 		imbalance = adjust_numa_imbalance(imbalance, src_running);
 
-		/* Use idle CPU there is spare capacity and no imbalance */
-		if (numa_has_capacity(env->imbalance_pct, &env->dst_stats) &&
-		    !imbalance) {
+		/* Use idle CPU if there is no imbalance */
+		if (!imbalance) {
 			env->dst_cpu = env->dst_stats.idle_cpu;
-			task_numa_assign(env, NULL, 0);
-			return;
+			if (env->dst_cpu >= 0 && task_numa_assign(env, NULL, 0))
+				return;
+
+			/*
+			 * A race prevented finding or using an idle CPU but
+			 * searching for swap candidates may still find an
+			 * idle CPU.
+			 */
+			maymove = true;
 		}
+	} else {
+		/* Fully busy/overloaded. Allow a move if improves balance */
+		maymove = !load_degrades_imbalance(env, task_h_load(env->p), 0);
 	}
 
-	/*
-	 * If using an idle CPU would cause an imbalance that would likely
-	 * be overridden by the load balancer, consider the load instead.
-	 */
-	load = task_h_load(env->p);
-	dst_load = env->dst_stats.group_load + load;
-	src_load = env->src_stats.group_load - load;
-	maymove = !load_too_imbalanced(src_load, dst_load, env);
-
 	for_each_cpu(cpu, cpumask_of_node(env->dst_nid)) {
 		/* Skip this CPU if the source task cannot migrate */
 		if (!cpumask_test_cpu(cpu, env->p->cpus_ptr))
 			continue;
 
 		env->dst_cpu = cpu;
-		task_numa_compare(env, taskimp, groupimp, maymove);
+		if (task_numa_compare(env, taskimp, groupimp, maymove))
+			break;
 	}
 }
 
-- 
2.16.4

