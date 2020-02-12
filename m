Return-Path: <SRS0=shi3=4A=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AA88AC2BA83
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Feb 2020 13:37:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7661D20659
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Feb 2020 13:37:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728042AbgBLNhX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 12 Feb 2020 08:37:23 -0500
Received: from mx2.suse.de ([195.135.220.15]:35530 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725887AbgBLNhX (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Feb 2020 08:37:23 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx2.suse.de (Postfix) with ESMTP id AED92AF19;
        Wed, 12 Feb 2020 13:37:19 +0000 (UTC)
Date:   Wed, 12 Feb 2020 13:37:15 +0000
From:   Mel Gorman <mgorman@suse.de>
To:     Vincent Guittot <vincent.guittot@linaro.org>
Cc:     mingo@redhat.com, peterz@infradead.org, juri.lelli@redhat.com,
        dietmar.eggemann@arm.com, rostedt@goodmis.org, bsegall@google.com,
        linux-kernel@vger.kernel.org, pauld@redhat.com,
        parth@linux.ibm.com, valentin.schneider@arm.com
Subject: Re: [RFC 2/4] sched/numa: replace runnable_load_avg by load_avg
Message-ID: <20200212133715.GU3420@suse.de>
References: <20200211174651.10330-1-vincent.guittot@linaro.org>
 <20200211174651.10330-3-vincent.guittot@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-15
Content-Disposition: inline
In-Reply-To: <20200211174651.10330-3-vincent.guittot@linaro.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Feb 11, 2020 at 06:46:49PM +0100, Vincent Guittot wrote:
> Similarly to what has been done for the normal load balance, we can
> replace runnable_load_avg by load_avg in numa load balancing and track
> other statistics like the utilization and the number of running tasks to
> get to better view of the current state of a node.
> 
> Signed-off-by: Vincent Guittot <vincent.guittot@linaro.org>
> ---
>  kernel/sched/fair.c | 102 ++++++++++++++++++++++++++++++++------------
>  1 file changed, 75 insertions(+), 27 deletions(-)
> 
> diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
> index a1ea02b5362e..6e4c2b012c48 100644
> --- a/kernel/sched/fair.c
> +++ b/kernel/sched/fair.c
> @@ -1473,38 +1473,35 @@ bool should_numa_migrate_memory(struct task_struct *p, struct page * page,
>  	       group_faults_cpu(ng, src_nid) * group_faults(p, dst_nid) * 4;
>  }
>  
> -static inline unsigned long cfs_rq_runnable_load_avg(struct cfs_rq *cfs_rq);
> -
> -static unsigned long cpu_runnable_load(struct rq *rq)
> -{
> -	return cfs_rq_runnable_load_avg(&rq->cfs);
> -}
> +/*
> + * 'numa_type' describes the node at the moment of load balancing.
> + */
> +enum numa_type {
> +	/* The node has spare capacity that can be used to run more tasks.  */
> +	node_has_spare = 0,
> +	/*
> +	 * The node is fully used and the tasks don't compete for more CPU
> +	 * cycles. Nevertheless, some tasks might wait before running.
> +	 */
> +	node_fully_busy,
> +	/*
> +	 * The node is overloaded and can't provide expected CPU cycles to all
> +	 * tasks.
> +	 */
> +	node_overloaded
> +};
>  

Ok, to reconcile this with the load balancer, it would need to account
for imbalanced but that's ok in the context of this patch.

>  /* Cached statistics for all CPUs within a node */
>  struct numa_stats {
>  	unsigned long load;
> -
> +	unsigned long util;
>  	/* Total compute capacity of CPUs on a node */
>  	unsigned long compute_capacity;
> +	unsigned int nr_running;
> +	unsigned int weight;
> +	enum numa_type node_type;
>  };
>  
> -/*
> - * XXX borrowed from update_sg_lb_stats
> - */
> -static void update_numa_stats(struct numa_stats *ns, int nid)
> -{
> -	int cpu;
> -
> -	memset(ns, 0, sizeof(*ns));
> -	for_each_cpu(cpu, cpumask_of_node(nid)) {
> -		struct rq *rq = cpu_rq(cpu);
> -
> -		ns->load += cpu_runnable_load(rq);
> -		ns->compute_capacity += capacity_of(cpu);
> -	}
> -
> -}
> -
>  struct task_numa_env {
>  	struct task_struct *p;
>  
> @@ -1521,6 +1518,47 @@ struct task_numa_env {
>  	int best_cpu;
>  };
>  
> +static unsigned long cpu_load(struct rq *rq);
> +static unsigned long cpu_util(int cpu);
> +
> +static inline enum
> +numa_type numa_classify(unsigned int imbalance_pct,
> +			 struct numa_stats *ns)
> +{
> +	if ((ns->nr_running > ns->weight) &&
> +	    ((ns->compute_capacity * 100) < (ns->util * imbalance_pct)))
> +		return node_overloaded;
> +

Ok, so this is essentially group_is_overloaded.


> +	if ((ns->nr_running < ns->weight) ||
> +	    ((ns->compute_capacity * 100) > (ns->util * imbalance_pct)))
> +		return node_has_spare;
> +

And this is group_has_capacity. What I did was have a common helper
for both NUMA and normal load balancing and translated the fields from
sg_lb_stats and numa_stats into a common helper. This is to prevent them
getting out of sync. The conversion was incomplete in my case but in
principle, both NUMA and CPU load balancing should use common helpers or
they'll get out of sync.


> +	return node_fully_busy;
> +}
> +
> +/*
> + * XXX borrowed from update_sg_lb_stats
> + */
> +static void update_numa_stats(struct task_numa_env *env,
> +			      struct numa_stats *ns, int nid)
> +{
> +	int cpu;
> +
> +	memset(ns, 0, sizeof(*ns));
> +	for_each_cpu(cpu, cpumask_of_node(nid)) {
> +		struct rq *rq = cpu_rq(cpu);
> +
> +		ns->load += cpu_load(rq);
> +		ns->util += cpu_util(cpu);
> +		ns->nr_running += rq->cfs.h_nr_running;
> +		ns->compute_capacity += capacity_of(cpu);
> +	}
> +
> +	ns->weight = cpumask_weight(cpumask_of_node(nid));
> +
> +	ns->node_type = numa_classify(env->imbalance_pct, ns);
> +}
> +

Ok, this is more or less what I had except I wedged other stuff in there
too specific to NUMA balancing to avoid multiple walks of the cpumask.

>  static void task_numa_assign(struct task_numa_env *env,
>  			     struct task_struct *p, long imp)
>  {
> @@ -1556,6 +1594,11 @@ static bool load_too_imbalanced(long src_load, long dst_load,
>  	long orig_src_load, orig_dst_load;
>  	long src_capacity, dst_capacity;
>  
> +
> +	/* If dst node has spare capacity, there is no real load imbalance */
> +	if (env->dst_stats.node_type == node_has_spare)
> +		return false;
> +

Not exactly what the load balancer thinks though, the load balancer
may decide to balance the tasks between NUMA groups even when there is
capacity. That said, what you did here is compatible with the current code.

I'll want to test this further but in general

Acked-by: Mel Gorman <mgorman@techsingularity.net>

However, I really would have preferred if numa_classify shared common
code with group_[is_overloaded|has_capacity] instead of having
equivalent but different implementations.

>  	/*
>  	 * The load is corrected for the CPU capacity available on each node.
>  	 *
> @@ -1788,10 +1831,10 @@ static int task_numa_migrate(struct task_struct *p)
>  	dist = env.dist = node_distance(env.src_nid, env.dst_nid);
>  	taskweight = task_weight(p, env.src_nid, dist);
>  	groupweight = group_weight(p, env.src_nid, dist);
> -	update_numa_stats(&env.src_stats, env.src_nid);
> +	update_numa_stats(&env, &env.src_stats, env.src_nid);
>  	taskimp = task_weight(p, env.dst_nid, dist) - taskweight;
>  	groupimp = group_weight(p, env.dst_nid, dist) - groupweight;
> -	update_numa_stats(&env.dst_stats, env.dst_nid);
> +	update_numa_stats(&env, &env.dst_stats, env.dst_nid);
>  
>  	/* Try to find a spot on the preferred nid. */
>  	task_numa_find_cpu(&env, taskimp, groupimp);
> @@ -1824,7 +1867,7 @@ static int task_numa_migrate(struct task_struct *p)
>  
>  			env.dist = dist;
>  			env.dst_nid = nid;
> -			update_numa_stats(&env.dst_stats, env.dst_nid);
> +			update_numa_stats(&env, &env.dst_stats, env.dst_nid);
>  			task_numa_find_cpu(&env, taskimp, groupimp);
>  		}
>  	}
> @@ -5446,6 +5489,11 @@ static unsigned long cpu_load_without(struct rq *rq, struct task_struct *p)
>  	return load;
>  }
>  
> +static unsigned long cpu_runnable_load(struct rq *rq)
> +{
> +	return cfs_rq_runnable_load_avg(&rq->cfs);
> +}
> +
>  static unsigned long capacity_of(int cpu)
>  {
>  	return cpu_rq(cpu)->cpu_capacity;
> -- 
> 2.17.1
> 

-- 
Mel Gorman
SUSE Labs
