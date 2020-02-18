Return-Path: <SRS0=52rg=4G=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C55C0C34026
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Feb 2020 15:38:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A447A2176D
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Feb 2020 15:38:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726582AbgBRPiK (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 18 Feb 2020 10:38:10 -0500
Received: from mx2.suse.de ([195.135.220.15]:42878 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726338AbgBRPiK (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Feb 2020 10:38:10 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx2.suse.de (Postfix) with ESMTP id B2057BAF0;
        Tue, 18 Feb 2020 15:38:04 +0000 (UTC)
Date:   Tue, 18 Feb 2020 15:38:01 +0000
From:   Mel Gorman <mgorman@suse.de>
To:     Valentin Schneider <valentin.schneider@arm.com>
Cc:     Vincent Guittot <vincent.guittot@linaro.org>, mingo@redhat.com,
        peterz@infradead.org, juri.lelli@redhat.com,
        dietmar.eggemann@arm.com, rostedt@goodmis.org, bsegall@google.com,
        linux-kernel@vger.kernel.org, pauld@redhat.com,
        parth@linux.ibm.com, hdanton@sina.com
Subject: Re: [PATCH v2 2/5] sched/numa: Replace runnable_load_avg by load_avg
Message-ID: <20200218153801.GF3420@suse.de>
References: <20200214152729.6059-1-vincent.guittot@linaro.org>
 <20200214152729.6059-3-vincent.guittot@linaro.org>
 <b67ae78b-17ba-8f3f-9052-fecefb848e3d@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-15
Content-Disposition: inline
In-Reply-To: <b67ae78b-17ba-8f3f-9052-fecefb848e3d@arm.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Feb 18, 2020 at 02:54:14PM +0000, Valentin Schneider wrote:
> On 2/14/20 3:27 PM, Vincent Guittot wrote:
> > @@ -1473,38 +1473,35 @@ bool should_numa_migrate_memory(struct task_struct *p, struct page * page,
> >  	       group_faults_cpu(ng, src_nid) * group_faults(p, dst_nid) * 4;
> >  }
> >  
> > -static inline unsigned long cfs_rq_runnable_load_avg(struct cfs_rq *cfs_rq);
> > -
> > -static unsigned long cpu_runnable_load(struct rq *rq)
> > -{
> > -	return cfs_rq_runnable_load_avg(&rq->cfs);
> > -}
> > +/*
> > + * 'numa_type' describes the node at the moment of load balancing.
> > + */
> > +enum numa_type {
> > +	/* The node has spare capacity that can be used to run more tasks.  */
> > +	node_has_spare = 0,
> > +	/*
> > +	 * The node is fully used and the tasks don't compete for more CPU
> > +	 * cycles. Nevertheless, some tasks might wait before running.
> > +	 */
> > +	node_fully_busy,
> > +	/*
> > +	 * The node is overloaded and can't provide expected CPU cycles to all
> > +	 * tasks.
> > +	 */
> > +	node_overloaded
> > +};
> 
> Could we reuse group_type instead? The definitions are the same modulo
> s/group/node/.
> 

I kept the naming because there is the remote possibility that NUMA
balancing will deviate in some fashion. Right now, it's harmless.

> >  
> >  /* Cached statistics for all CPUs within a node */
> >  struct numa_stats {
> >  	unsigned long load;
> > -
> > +	unsigned long util;
> >  	/* Total compute capacity of CPUs on a node */
> >  	unsigned long compute_capacity;
> > +	unsigned int nr_running;
> > +	unsigned int weight;
> > +	enum numa_type node_type;
> >  };
> >  
> > -/*
> > - * XXX borrowed from update_sg_lb_stats
> > - */
> > -static void update_numa_stats(struct numa_stats *ns, int nid)
> > -{
> > -	int cpu;
> > -
> > -	memset(ns, 0, sizeof(*ns));
> > -	for_each_cpu(cpu, cpumask_of_node(nid)) {
> > -		struct rq *rq = cpu_rq(cpu);
> > -
> > -		ns->load += cpu_runnable_load(rq);
> > -		ns->compute_capacity += capacity_of(cpu);
> > -	}
> > -
> > -}
> > -
> >  struct task_numa_env {
> >  	struct task_struct *p;
> >  
> > @@ -1521,6 +1518,47 @@ struct task_numa_env {
> >  	int best_cpu;
> >  };
> >  
> > +static unsigned long cpu_load(struct rq *rq);
> > +static unsigned long cpu_util(int cpu);
> > +
> > +static inline enum
> > +numa_type numa_classify(unsigned int imbalance_pct,
> > +			 struct numa_stats *ns)
> > +{
> > +	if ((ns->nr_running > ns->weight) &&
> > +	    ((ns->compute_capacity * 100) < (ns->util * imbalance_pct)))
> > +		return node_overloaded;
> > +
> > +	if ((ns->nr_running < ns->weight) ||
> > +	    ((ns->compute_capacity * 100) > (ns->util * imbalance_pct)))
> > +		return node_has_spare;
> > +
> > +	return node_fully_busy;
> > +}
> > +
> 
> As Mel pointed out, this is group_is_overloaded() and group_has_capacity().
> @Mel, you mentioned having a common helper, do you have that laying around?
> I haven't seen it in your reconciliation series.
> 

I didn't merge that part of the first version of my series. I was
waiting to see how the implementation for allowing a small degree of
imbalance looks like. If it's entirely confined in adjust_numa_balance
then I'll create the common helper at the same time. For now, I left the
possibility open that numa_classify would use something different than
group_is_overloaded or group_has_capacity even if I find that hard to
imagine at the moment.

> What I'm naively thinking here is that we could have either move the whole
> thing to just sg_lb_stats (AFAICT the fields of numa_stats are a subset of it),
> or if we really care about the stack we could tweak the ordering to ensure
> we can cast one into the other (not too enticed by that one though).
> 

Yikes, no I'd rather not do that. Basically all I did before was create
a common helper like __lb_has_capacity that only took basic types as
parameters. group_has_capacity and numa_has_capacity were simple wrappers
that read the correct fields from their respective stats structures.

-- 
Mel Gorman
SUSE Labs
