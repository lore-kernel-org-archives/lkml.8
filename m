Return-Path: <SRS0=Zbf8=4B=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AE896C2BA83
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Feb 2020 09:24:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 829C721734
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Feb 2020 09:24:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729685AbgBMJYQ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 13 Feb 2020 04:24:16 -0500
Received: from outbound-smtp62.blacknight.com ([46.22.136.251]:51295 "EHLO
        outbound-smtp62.blacknight.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726545AbgBMJYQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Feb 2020 04:24:16 -0500
Received: from mail.blacknight.com (pemlinmail01.blacknight.ie [81.17.254.10])
        by outbound-smtp62.blacknight.com (Postfix) with ESMTPS id 3CE0AFA839
        for <linux-kernel@vger.kernel.org>; Thu, 13 Feb 2020 09:24:13 +0000 (GMT)
Received: (qmail 25173 invoked from network); 13 Feb 2020 09:24:13 -0000
Received: from unknown (HELO techsingularity.net) (mgorman@techsingularity.net@[84.203.18.57])
  by 81.17.254.9 with ESMTPSA (AES256-SHA encrypted, authenticated); 13 Feb 2020 09:24:13 -0000
Date:   Thu, 13 Feb 2020 09:24:10 +0000
From:   Mel Gorman <mgorman@techsingularity.net>
To:     Vincent Guittot <vincent.guittot@linaro.org>
Cc:     Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Juri Lelli <juri.lelli@redhat.com>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Ben Segall <bsegall@google.com>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Phil Auld <pauld@redhat.com>, Parth Shah <parth@linux.ibm.com>,
        Valentin Schneider <valentin.schneider@arm.com>
Subject: Re: [RFC 2/4] sched/numa: replace runnable_load_avg by load_avg
Message-ID: <20200213092410.GV3466@techsingularity.net>
References: <20200211174651.10330-1-vincent.guittot@linaro.org>
 <20200211174651.10330-3-vincent.guittot@linaro.org>
 <20200212133715.GU3420@suse.de>
 <20200212194903.GS3466@techsingularity.net>
 <CAKfTPtDA5GamN4A1SnegYwYCk123TqUDE9EHFbHTgKCMR+yqGQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-15
Content-Disposition: inline
In-Reply-To: <CAKfTPtDA5GamN4A1SnegYwYCk123TqUDE9EHFbHTgKCMR+yqGQ@mail.gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Feb 13, 2020 at 09:05:35AM +0100, Vincent Guittot wrote:
> > And I was wrong. I worried that the conflict with the load balancer would
> > be a problem when I wrote this comment.  That was based on finding that
> > I had to account for the load balancer when using capacity to decide
> > whether an idle CPU can be used. When I didn't, performance went to
> > hell but thought that maybe you had somehow avoided the same problem.
> > Unfortunately, testing indicates that the same, or similar, problem is
> > here.
> >
> > This is specjbb running two JVMs on a 2-socket Haswell machine with 48
> > cores in total. This is just your first two patches, I have found that
> 
> thanks for the test results. Unfortunately i haven't specjbb to
> analyse the metrics and study what is going wrong
> 

That's fine. There will be alternative tests that show a similar
problem. I generally like specjbb because it's more predictable than
others while still being complex enough from a scheduler perspective to be
interesting.

> > Note that how it reaches the point where the node is almost utilised
> > ( near tput-12) that performance drops.  Graphing mpstat on a per-node
> > basis shows there is imbalance in the CPU utilisation between nodes.
> 
> ok. So the has_spare_capacity condition that i added in
> load_too_imbalanced() is probably to aggressive although the goal was
> to let task moving on their preferred node
> 

Yes. It's a "fun" challenge to balance compute capacity, memory bandwidth
and memory locality. The patch on top I posted yesterday had a error
but fortunately I caught it last night after one test showed surprising
results. The corrected version is below. With it, the degree to which
both CPU load balance and NUMA balancing allows an imbalance between two
nodes to exist is controlled from one common function. It appears to work
but I want more than one test to complete before I bet money on it.

The one test is close to performance-neutral even though 4-socket shows
more system CPU usage than I'd like. This is still an improvement given
that the two balancers now make decisions based on the same metrics
without regressing (yet). I'll continue looking at how both of our series
can play nice together but so far, this is what I think is needed after
patch 2 of your series;

--8<--
sched/numa: Use similar logic to the load balancer for moving between domains with spare capacity

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
index 52e74b53d6e7..5a34752b8dbe 100644
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
+		dst_running = env->src_stats.nr_running + 1;
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
Mel Gorman
SUSE Labs
