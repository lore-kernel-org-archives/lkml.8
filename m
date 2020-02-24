Return-Path: <SRS0=7TUr=4M=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.8 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C9DEBC11D34
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Feb 2020 15:20:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9B2022082F
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Feb 2020 15:20:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728090AbgBXPUx (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 24 Feb 2020 10:20:53 -0500
Received: from Galois.linutronix.de ([193.142.43.55]:50348 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727701AbgBXPUv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Feb 2020 10:20:51 -0500
Received: from [5.158.153.53] (helo=tip-bot2.lab.linutronix.de)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tip-bot2@linutronix.de>)
        id 1j6FX5-0005q4-DG; Mon, 24 Feb 2020 16:20:31 +0100
Received: from [127.0.1.1] (localhost [IPv6:::1])
        by tip-bot2.lab.linutronix.de (Postfix) with ESMTP id 115EF1C213A;
        Mon, 24 Feb 2020 16:20:31 +0100 (CET)
Date:   Mon, 24 Feb 2020 15:20:30 -0000
From:   "tip-bot2 for Mel Gorman" <tip-bot2@linutronix.de>
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: sched/core] sched/numa: Prefer using an idle CPU as a migration
 target instead of comparing tasks
Cc:     Mel Gorman <mgorman@techsingularity.net>,
        Ingo Molnar <mingo@kernel.org>,
        Peter Zijlstra <a.p.zijlstra@chello.nl>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Juri Lelli <juri.lelli@redhat.com>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Valentin Schneider <valentin.schneider@arm.com>,
        Phil Auld <pauld@redhat.com>, Hillf Danton <hdanton@sina.com>,
        x86 <x86@kernel.org>, LKML <linux-kernel@vger.kernel.org>
In-Reply-To: <20200224095223.13361-11-mgorman@techsingularity.net>
References: <20200224095223.13361-11-mgorman@techsingularity.net>
MIME-Version: 1.0
Message-ID: <158255763082.28353.16689616186297155982.tip-bot2@tip-bot2>
X-Mailer: tip-git-log-daemon
Robot-ID: <tip-bot2.linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Linutronix-Spam-Score: -1.0
X-Linutronix-Spam-Level: -
X-Linutronix-Spam-Status: No , -1.0 points, 5.0 required,  ALL_TRUSTED=-1,SHORTCIRCUIT=-0.0001
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following commit has been merged into the sched/core branch of tip:

Commit-ID:     ff7db0bf24db919f69121bf5df8f3cb6d79f49af
Gitweb:        https://git.kernel.org/tip/ff7db0bf24db919f69121bf5df8f3cb6d79f49af
Author:        Mel Gorman <mgorman@techsingularity.net>
AuthorDate:    Mon, 24 Feb 2020 09:52:20 
Committer:     Ingo Molnar <mingo@kernel.org>
CommitterDate: Mon, 24 Feb 2020 11:36:38 +01:00

sched/numa: Prefer using an idle CPU as a migration target instead of comparing tasks

task_numa_find_cpu() can scan a node multiple times. Minimally it scans to
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
Signed-off-by: Ingo Molnar <mingo@kernel.org>
Acked-by: Peter Zijlstra <a.p.zijlstra@chello.nl>
Cc: Vincent Guittot <vincent.guittot@linaro.org>
Cc: Juri Lelli <juri.lelli@redhat.com>
Cc: Dietmar Eggemann <dietmar.eggemann@arm.com>
Cc: Steven Rostedt <rostedt@goodmis.org>
Cc: Valentin Schneider <valentin.schneider@arm.com>
Cc: Phil Auld <pauld@redhat.com>
Cc: Hillf Danton <hdanton@sina.com>
Link: https://lore.kernel.org/r/20200224095223.13361-11-mgorman@techsingularity.net
---
 kernel/sched/fair.c | 119 ++++++++++++++++++++++++++++++++++++-------
 1 file changed, 102 insertions(+), 17 deletions(-)

diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
index 87521ac..2da21f4 100644
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
@@ -1776,8 +1855,14 @@ static void task_numa_find_cpu(struct task_numa_env *env,
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
@@ -1850,10 +1935,10 @@ static int task_numa_migrate(struct task_struct *p)
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
@@ -1886,7 +1971,7 @@ static int task_numa_migrate(struct task_struct *p)
 
 			env.dist = dist;
 			env.dst_nid = nid;
-			update_numa_stats(&env, &env.dst_stats, env.dst_nid);
+			update_numa_stats(&env, &env.dst_stats, env.dst_nid, true);
 			task_numa_find_cpu(&env, taskimp, groupimp);
 		}
 	}
