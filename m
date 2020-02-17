Return-Path: <SRS0=PfNx=4F=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EC502C34021
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Feb 2020 15:06:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CEE5220679
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Feb 2020 15:06:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729403AbgBQPGU (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 17 Feb 2020 10:06:20 -0500
Received: from outbound-smtp39.blacknight.com ([46.22.139.222]:60222 "EHLO
        outbound-smtp39.blacknight.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1729365AbgBQPGU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Feb 2020 10:06:20 -0500
Received: from mail.blacknight.com (unknown [81.17.254.17])
        by outbound-smtp39.blacknight.com (Postfix) with ESMTPS id 929DF1115
        for <linux-kernel@vger.kernel.org>; Mon, 17 Feb 2020 15:06:16 +0000 (GMT)
Received: (qmail 13384 invoked from network); 17 Feb 2020 15:06:16 -0000
Received: from unknown (HELO techsingularity.net) (mgorman@techsingularity.net@[84.203.18.57])
  by 81.17.254.9 with ESMTPSA (AES256-SHA encrypted, authenticated); 17 Feb 2020 15:06:16 -0000
Date:   Mon, 17 Feb 2020 15:06:15 +0000
From:   Mel Gorman <mgorman@techsingularity.net>
To:     Hillf Danton <hdanton@sina.com>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@kernel.org>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Juri Lelli <juri.lelli@redhat.com>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Ben Segall <bsegall@google.com>,
        Valentin Schneider <valentin.schneider@arm.com>,
        Phil Auld <pauld@redhat.com>,
        LKML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 06/13] sched/numa: Use similar logic to the load balancer
 for moving between domains with spare capacity
Message-ID: <20200217150615.GJ3466@techsingularity.net>
References: <20200217104402.11643-1-mgorman@techsingularity.net>
 <20200217132019.6684-1-hdanton@sina.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-15
Content-Disposition: inline
In-Reply-To: <20200217132019.6684-1-hdanton@sina.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Feb 17, 2020 at 09:20:19PM +0800, Hillf Danton wrote:
> 
> On Mon, 17 Feb 2020 10:43:55 +0000 Mel Gorman wrote:
> > 
> > The standard load balancer generally tries to keep the number of running
> > tasks or idle CPUs balanced between NUMA domains. The NUMA balancer allows
> > tasks to move if there is spare capacity but this causes a conflict and
> > utilisation between NUMA nodes gets badly skewed. This patch uses similar
> > logic between the NUMA balancer and load balancer when deciding if a task
> > migrating to its preferred node can use an idle CPU.
> > 
> > Signed-off-by: Mel Gorman <mgorman@suse.com>
> > ---
> >  kernel/sched/fair.c | 76 +++++++++++++++++++++++++++++++----------------------
> >  1 file changed, 45 insertions(+), 31 deletions(-)
> > 
> > diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
> > index 52e74b53d6e7..ae7870f71457 100644
> > --- a/kernel/sched/fair.c
> > +++ b/kernel/sched/fair.c
> > @@ -1520,6 +1520,7 @@ struct task_numa_env {
> >  
> >  static unsigned long cpu_load(struct rq *rq);
> >  static unsigned long cpu_util(int cpu);
> > +static inline long adjust_numa_imbalance(int imbalance, int src_nr_running);
> >  
> >  static inline enum
> >  numa_type numa_classify(unsigned int imbalance_pct,
> > @@ -1594,11 +1595,6 @@ static bool load_too_imbalanced(long src_load, long dst_load,
> >  	long orig_src_load, orig_dst_load;
> >  	long src_capacity, dst_capacity;
> >  
> > -
> > -	/* If dst node has spare capacity, there is no real load imbalance */
> > -	if (env->dst_stats.node_type == node_has_spare)
> > -		return false;
> > -
>
> The current logic is: move if dst node has spare capacity,
> 

THe load balancer takes either idle CPUs or running tasks into account
depending on SD flags. Unless this check is removed, the CPU usage
across nodes becomes imbalanced, the load balancer takes action and
testing indicates that performance degrades severely. The impact is
illustrated in the leader of the patch series as well as the effect of
this patch in isolation.

> >  	/*
> >  	 * The load is corrected for the CPU capacity available on each node.
> >  	 *
> > @@ -1757,19 +1753,37 @@ static void task_numa_compare(struct task_numa_env *env,
> >  static void task_numa_find_cpu(struct task_numa_env *env,
> >  				long taskimp, long groupimp)
> >  {
> > -	long src_load, dst_load, load;
> >  	bool maymove = false;
> >  	int cpu;
> >  
> > -	load = task_h_load(env->p);
> > -	dst_load = env->dst_stats.load + load;
> > -	src_load = env->src_stats.load - load;
> > -
> >  	/*
> > -	 * If the improvement from just moving env->p direction is better
> > -	 * than swapping tasks around, check if a move is possible.
> > +	 * If dst node has spare capacity, then check if there is an
> > +	 * imbalance that would be overruled by the load balancer.
> >  	 */
> > -	maymove = !load_too_imbalanced(src_load, dst_load, env);
> > +	if (env->dst_stats.node_type == node_has_spare) {
> 
> so maymove should be true here.
> 

Performance suffers on numerous workloads that way.

> > +		unsigned int imbalance;
> > +		int src_running, dst_running;
> > +
> > +		/* Would movement cause an imbalance? */
> > +		src_running = env->src_stats.nr_running - 1;
> > +		dst_running = env->dst_stats.nr_running + 1;
> > +		imbalance = max(0, dst_running - src_running);
> > +		imbalance = adjust_numa_imbalance(imbalance, src_running);
> > +
> The imbalance could be ignored if src domain is idle enough, and no move
> could be expected.
> 

Again, it hits corner cases. While there is scope for allowing some
degree of imbalance, it needs to be a separate patch on top of this.
It's something I intend to examine but only once this series is out of
the way because the NUMA and load balancer do need to be using similar
logic first or it gets a bit fragile.

With this patch, and the series in general, it does mean that some tasks
fail to migrate to a CPU local to the memory being accessed even though
there are CPUs available but having the NUMA balancer and load balancer
override each other is not free either.

Thanks.

-- 
Mel Gorman
SUSE Labs
