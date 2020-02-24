Return-Path: <SRS0=7TUr=4M=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.8 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 72DABC11D2F
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Feb 2020 15:20:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 484532082F
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Feb 2020 15:20:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728018AbgBXPUr (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 24 Feb 2020 10:20:47 -0500
Received: from Galois.linutronix.de ([193.142.43.55]:50321 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727749AbgBXPUq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Feb 2020 10:20:46 -0500
Received: from [5.158.153.53] (helo=tip-bot2.lab.linutronix.de)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tip-bot2@linutronix.de>)
        id 1j6FX6-0005qJ-Vm; Mon, 24 Feb 2020 16:20:33 +0100
Received: from [127.0.1.1] (localhost [IPv6:::1])
        by tip-bot2.lab.linutronix.de (Postfix) with ESMTP id A27661C213A;
        Mon, 24 Feb 2020 16:20:32 +0100 (CET)
Date:   Mon, 24 Feb 2020 15:20:32 -0000
From:   "tip-bot2 for Mel Gorman" <tip-bot2@linutronix.de>
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: sched/core] sched/numa: Use similar logic to the load balancer
 for moving between domains with spare capacity
Cc:     Mel Gorman <mgorman@techsingularity.net>,
        Ingo Molnar <mingo@kernel.org>,
        Peter Zijlstra <a.p.zijlstra@chello.nl>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Juri Lelli <juri.lelli@redhat.com>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Valentin Schneider <valentin.schneider@arm.com>,
        Phil Auld <pauld@redhat.com>, Hillf Danton <hdanton@sina.com>,
        x86 <x86@kernel.org>, LKML <linux-kernel@vger.kernel.org>
In-Reply-To: <20200224095223.13361-7-mgorman@techsingularity.net>
References: <20200224095223.13361-7-mgorman@techsingularity.net>
MIME-Version: 1.0
Message-ID: <158255763235.28353.6329377716415522983.tip-bot2@tip-bot2>
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

Commit-ID:     fb86f5b2119245afd339280099b4e9417cc0b03a
Gitweb:        https://git.kernel.org/tip/fb86f5b2119245afd339280099b4e9417cc0b03a
Author:        Mel Gorman <mgorman@techsingularity.net>
AuthorDate:    Mon, 24 Feb 2020 09:52:16 
Committer:     Ingo Molnar <mingo@kernel.org>
CommitterDate: Mon, 24 Feb 2020 11:36:35 +01:00

sched/numa: Use similar logic to the load balancer for moving between domains with spare capacity

The standard load balancer generally tries to keep the number of running
tasks or idle CPUs balanced between NUMA domains. The NUMA balancer allows
tasks to move if there is spare capacity but this causes a conflict and
utilisation between NUMA nodes gets badly skewed. This patch uses similar
logic between the NUMA balancer and load balancer when deciding if a task
migrating to its preferred node can use an idle CPU.

Signed-off-by: Mel Gorman <mgorman@techsingularity.net>
Signed-off-by: Ingo Molnar <mingo@kernel.org>
Acked-by: Peter Zijlstra <a.p.zijlstra@chello.nl>
Cc: Vincent Guittot <vincent.guittot@linaro.org>
Cc: Juri Lelli <juri.lelli@redhat.com>
Cc: Dietmar Eggemann <dietmar.eggemann@arm.com>
Cc: Valentin Schneider <valentin.schneider@arm.com>
Cc: Phil Auld <pauld@redhat.com>
Cc: Hillf Danton <hdanton@sina.com>
Link: https://lore.kernel.org/r/20200224095223.13361-7-mgorman@techsingularity.net
---
 kernel/sched/fair.c | 81 +++++++++++++++++++++++++++-----------------
 1 file changed, 50 insertions(+), 31 deletions(-)

diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
index bc3d651..7a3c66f 100644
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
@@ -1757,19 +1753,42 @@ unlock:
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
+		/*
+		 * Would movement cause an imbalance? Note that if src has
+		 * more running tasks that the imbalance is ignored as the
+		 * move improves the imbalance from the perspective of the
+		 * CPU load balancer.
+		 * */
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
@@ -8694,6 +8713,21 @@ next_group:
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
@@ -8790,24 +8824,9 @@ static inline void calculate_imbalance(struct lb_env *env, struct sd_lb_stats *s
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
