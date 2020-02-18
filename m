Return-Path: <SRS0=52rg=4G=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 41A72C34026
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Feb 2020 14:54:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 20A8922B48
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Feb 2020 14:54:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726788AbgBROyS (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 18 Feb 2020 09:54:18 -0500
Received: from foss.arm.com ([217.140.110.172]:53774 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726634AbgBROyS (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Feb 2020 09:54:18 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 0898930E;
        Tue, 18 Feb 2020 06:54:18 -0800 (PST)
Received: from [10.1.195.59] (ifrit.cambridge.arm.com [10.1.195.59])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 8158E3F703;
        Tue, 18 Feb 2020 06:54:16 -0800 (PST)
Subject: Re: [PATCH v2 2/5] sched/numa: Replace runnable_load_avg by load_avg
To:     Vincent Guittot <vincent.guittot@linaro.org>, mingo@redhat.com,
        peterz@infradead.org, juri.lelli@redhat.com,
        dietmar.eggemann@arm.com, rostedt@goodmis.org, bsegall@google.com,
        mgorman@suse.de, linux-kernel@vger.kernel.org
Cc:     pauld@redhat.com, parth@linux.ibm.com, hdanton@sina.com
References: <20200214152729.6059-1-vincent.guittot@linaro.org>
 <20200214152729.6059-3-vincent.guittot@linaro.org>
From:   Valentin Schneider <valentin.schneider@arm.com>
Message-ID: <b67ae78b-17ba-8f3f-9052-fecefb848e3d@arm.com>
Date:   Tue, 18 Feb 2020 14:54:14 +0000
User-Agent: Mozilla/5.0 (X11; Linux aarch64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.1
MIME-Version: 1.0
In-Reply-To: <20200214152729.6059-3-vincent.guittot@linaro.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2/14/20 3:27 PM, Vincent Guittot wrote:
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

Could we reuse group_type instead? The definitions are the same modulo
s/group/node/.

>  
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
> +	if ((ns->nr_running < ns->weight) ||
> +	    ((ns->compute_capacity * 100) > (ns->util * imbalance_pct)))
> +		return node_has_spare;
> +
> +	return node_fully_busy;
> +}
> +

As Mel pointed out, this is group_is_overloaded() and group_has_capacity().
@Mel, you mentioned having a common helper, do you have that laying around?
I haven't seen it in your reconciliation series.

What I'm naively thinking here is that we could have either move the whole
thing to just sg_lb_stats (AFAICT the fields of numa_stats are a subset of it),
or if we really care about the stack we could tweak the ordering to ensure
we can cast one into the other (not too enticed by that one though).

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
>  static void task_numa_assign(struct task_numa_env *env,
>  			     struct task_struct *p, long imp)
>  {
