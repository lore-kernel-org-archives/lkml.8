Return-Path: <SRS0=shi3=4A=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 49E43C352A4
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Feb 2020 21:29:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 12BE921569
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Feb 2020 21:29:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729107AbgBLV3z (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 12 Feb 2020 16:29:55 -0500
Received: from outbound-smtp53.blacknight.com ([46.22.136.237]:56037 "EHLO
        outbound-smtp53.blacknight.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727420AbgBLV3z (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Feb 2020 16:29:55 -0500
Received: from mail.blacknight.com (pemlinmail06.blacknight.ie [81.17.255.152])
        by outbound-smtp53.blacknight.com (Postfix) with ESMTPS id C1870FA870
        for <linux-kernel@vger.kernel.org>; Wed, 12 Feb 2020 21:29:51 +0000 (GMT)
Received: (qmail 12560 invoked from network); 12 Feb 2020 21:29:51 -0000
Received: from unknown (HELO techsingularity.net) (mgorman@techsingularity.net@[84.203.18.57])
  by 81.17.254.9 with ESMTPSA (AES256-SHA encrypted, authenticated); 12 Feb 2020 21:29:51 -0000
Date:   Wed, 12 Feb 2020 21:29:50 +0000
From:   Mel Gorman <mgorman@techsingularity.net>
To:     Vincent Guittot <vincent.guittot@linaro.org>
Cc:     mingo@redhat.com, peterz@infradead.org, juri.lelli@redhat.com,
        dietmar.eggemann@arm.com, rostedt@goodmis.org, bsegall@google.com,
        linux-kernel@vger.kernel.org, pauld@redhat.com,
        parth@linux.ibm.com, valentin.schneider@arm.com
Subject: Re: [RFC 2/4] sched/numa: replace runnable_load_avg by load_avg
Message-ID: <20200212212950.GT3466@techsingularity.net>
References: <20200211174651.10330-1-vincent.guittot@linaro.org>
 <20200211174651.10330-3-vincent.guittot@linaro.org>
 <20200212133715.GU3420@suse.de>
 <20200212194903.GS3466@techsingularity.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-15
Content-Disposition: inline
In-Reply-To: <20200212194903.GS3466@techsingularity.net>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Feb 12, 2020 at 07:49:03PM +0000, Mel Gorman wrote:
> On Wed, Feb 12, 2020 at 01:37:15PM +0000, Mel Gorman wrote:
> > >  static void task_numa_assign(struct task_numa_env *env,
> > >  			     struct task_struct *p, long imp)
> > >  {
> > > @@ -1556,6 +1594,11 @@ static bool load_too_imbalanced(long src_load, long dst_load,
> > >  	long orig_src_load, orig_dst_load;
> > >  	long src_capacity, dst_capacity;
> > >  
> > > +
> > > +	/* If dst node has spare capacity, there is no real load imbalance */
> > > +	if (env->dst_stats.node_type == node_has_spare)
> > > +		return false;
> > > +
> > 
> > Not exactly what the load balancer thinks though, the load balancer
> > may decide to balance the tasks between NUMA groups even when there is
> > capacity. That said, what you did here is compatible with the current code.
> > 
> > I'll want to test this further but in general
> > 
> > Acked-by: Mel Gorman <mgorman@techsingularity.net>
> > 
> 
> And I was wrong. I worried that the conflict with the load balancer would
> be a problem when I wrote this comment.  That was based on finding that
> I had to account for the load balancer when using capacity to decide
> whether an idle CPU can be used. When I didn't, performance went to
> hell but thought that maybe you had somehow avoided the same problem.
> Unfortunately, testing indicates that the same, or similar, problem is
> here.
> 

Maybe this on top of your patch? I've slotted it in and will see what
falls out. You may notice a stray hunk related to cpu_runnable_load.
It's because an earlier patch introduces it unnecessarily and only needs
it later in your series. It's a minor cleanup of the overall series but
easiest to illustrate for now.

--8<--
sched/numa: Use similar logic to the load balancer for moving between domains with spare capacity

The standard load balancer generally tries to keep the number of running
tasks or idle CPUs balanced between NUMA domains. The NUMA balancer allows
tasks to move if there is spare capacity but this causes a conflict and
utilisation between NUMA nodes gets badly skewed. This patch uses similar
logic between the NUMA balancer and load balancer when deciding if a task
migrating to its preferred node can use an idle CPU.

Signed-off-by: Mel Gorman <mgorman@suse.com>

diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
index 9cabfb4fe505..ee80f31ec710 100644
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
@@ -1757,19 +1753,36 @@ static void task_numa_compare(struct task_numa_env *env,
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
+		maymove = true;
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
@@ -5491,11 +5504,6 @@ static unsigned long cpu_load_without(struct rq *rq, struct task_struct *p)
 	return load;
 }
 
-static unsigned long cpu_runnable_load(struct rq *rq)
-{
-	return cfs_rq_runnable_load_avg(&rq->cfs);
-}
-
 static unsigned long capacity_of(int cpu)
 {
 	return cpu_rq(cpu)->cpu_capacity;
@@ -8705,6 +8713,21 @@ static inline void update_sd_lb_stats(struct lb_env *env, struct sd_lb_stats *sd
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
@@ -8801,24 +8824,9 @@ static inline void calculate_imbalance(struct lb_env *env, struct sd_lb_stats *s
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
