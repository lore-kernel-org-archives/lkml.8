Return-Path: <SRS0=7TUr=4M=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.8 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 36DDAC11D32
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Feb 2020 15:20:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0D25120838
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Feb 2020 15:20:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728068AbgBXPUv (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 24 Feb 2020 10:20:51 -0500
Received: from Galois.linutronix.de ([193.142.43.55]:50338 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728023AbgBXPUt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Feb 2020 10:20:49 -0500
Received: from [5.158.153.53] (helo=tip-bot2.lab.linutronix.de)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tip-bot2@linutronix.de>)
        id 1j6FXA-0005r6-Ca; Mon, 24 Feb 2020 16:20:36 +0100
Received: from [127.0.1.1] (localhost [IPv6:::1])
        by tip-bot2.lab.linutronix.de (Postfix) with ESMTP id F12721C213D;
        Mon, 24 Feb 2020 16:20:32 +0100 (CET)
Date:   Mon, 24 Feb 2020 15:20:32 -0000
From:   "tip-bot2 for Vincent Guittot" <tip-bot2@linutronix.de>
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: sched/core] sched/numa: Replace runnable_load_avg by load_avg
Cc:     Vincent Guittot <vincent.guittot@linaro.org>,
        Mel Gorman <mgorman@techsingularity.net>,
        Ingo Molnar <mingo@kernel.org>,
        "Dietmar Eggemann" <dietmar.eggemann@arm.com>,
        Peter Zijlstra <a.p.zijlstra@chello.nl>,
        Juri Lelli <juri.lelli@redhat.com>,
        Valentin Schneider <valentin.schneider@arm.com>,
        Phil Auld <pauld@redhat.com>, Hillf Danton <hdanton@sina.com>,
        x86 <x86@kernel.org>, LKML <linux-kernel@vger.kernel.org>
In-Reply-To: <20200224095223.13361-6-mgorman@techsingularity.net>
References: <20200224095223.13361-6-mgorman@techsingularity.net>
MIME-Version: 1.0
Message-ID: <158255763273.28353.4606148712630409487.tip-bot2@tip-bot2>
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

Commit-ID:     6499b1b2dd1b8d404a16b9fbbf1af6b9b3c1d83d
Gitweb:        https://git.kernel.org/tip/6499b1b2dd1b8d404a16b9fbbf1af6b9b3c1d83d
Author:        Vincent Guittot <vincent.guittot@linaro.org>
AuthorDate:    Mon, 24 Feb 2020 09:52:15 
Committer:     Ingo Molnar <mingo@kernel.org>
CommitterDate: Mon, 24 Feb 2020 11:36:34 +01:00

sched/numa: Replace runnable_load_avg by load_avg

Similarly to what has been done for the normal load balancer, we can
replace runnable_load_avg by load_avg in numa load balancing and track the
other statistics like the utilization and the number of running tasks to
get to better view of the current state of a node.

Signed-off-by: Vincent Guittot <vincent.guittot@linaro.org>
Signed-off-by: Mel Gorman <mgorman@techsingularity.net>
Signed-off-by: Ingo Molnar <mingo@kernel.org>
Reviewed-by: "Dietmar Eggemann <dietmar.eggemann@arm.com>"
Acked-by: Peter Zijlstra <a.p.zijlstra@chello.nl>
Cc: Juri Lelli <juri.lelli@redhat.com>
Cc: Valentin Schneider <valentin.schneider@arm.com>
Cc: Phil Auld <pauld@redhat.com>
Cc: Hillf Danton <hdanton@sina.com>
Link: https://lore.kernel.org/r/20200224095223.13361-6-mgorman@techsingularity.net
---
 kernel/sched/fair.c | 102 +++++++++++++++++++++++++++++--------------
 1 file changed, 70 insertions(+), 32 deletions(-)

diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
index a6c7f8b..bc3d651 100644
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
@@ -3686,11 +3729,6 @@ static void remove_entity_load_avg(struct sched_entity *se)
 	raw_spin_unlock_irqrestore(&cfs_rq->removed.lock, flags);
 }
 
-static inline unsigned long cfs_rq_runnable_load_avg(struct cfs_rq *cfs_rq)
-{
-	return cfs_rq->avg.runnable_load_avg;
-}
-
 static inline unsigned long cfs_rq_load_avg(struct cfs_rq *cfs_rq)
 {
 	return cfs_rq->avg.load_avg;
