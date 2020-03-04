Return-Path: <SRS0=idZ5=4V=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 537CEC3F2D1
	for <linux-kernel@archiver.kernel.org>; Wed,  4 Mar 2020 17:39:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2B3DA22B48
	for <linux-kernel@archiver.kernel.org>; Wed,  4 Mar 2020 17:39:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730011AbgCDRjb (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 4 Mar 2020 12:39:31 -0500
Received: from foss.arm.com ([217.140.110.172]:37674 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726561AbgCDRja (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Mar 2020 12:39:30 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id AC17831B;
        Wed,  4 Mar 2020 09:39:29 -0800 (PST)
Received: from e107158-lin.cambridge.arm.com (e107158-lin.cambridge.arm.com [10.1.195.21])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 5981D3F6CF;
        Wed,  4 Mar 2020 09:39:28 -0800 (PST)
Date:   Wed, 4 Mar 2020 17:39:26 +0000
From:   Qais Yousef <qais.yousef@arm.com>
To:     Steven Rostedt <rostedt@goodmis.org>
Cc:     Ingo Molnar <mingo@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Pavan Kondeti <pkondeti@codeaurora.org>,
        Juri Lelli <juri.lelli@redhat.com>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Ben Segall <bsegall@google.com>, Mel Gorman <mgorman@suse.de>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 1/6] sched/rt: cpupri_find: Implement fallback
 mechanism for !fit case
Message-ID: <20200304173925.43xq4wztummxgs3x@e107158-lin.cambridge.arm.com>
References: <20200302132721.8353-1-qais.yousef@arm.com>
 <20200302132721.8353-2-qais.yousef@arm.com>
 <20200304112739.7b99677e@gandalf.local.home>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20200304112739.7b99677e@gandalf.local.home>
User-Agent: NeoMutt/20171215
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 03/04/20 11:27, Steven Rostedt wrote:
> On Mon,  2 Mar 2020 13:27:16 +0000
> Qais Yousef <qais.yousef@arm.com> wrote:
> 
> 
> >  /**
> >   * cpupri_find - find the best (lowest-pri) CPU in the system
> >   * @cp: The cpupri context
> > @@ -62,80 +115,72 @@ int cpupri_find(struct cpupri *cp, struct task_struct *p,
> >  		struct cpumask *lowest_mask,
> >  		bool (*fitness_fn)(struct task_struct *p, int cpu))
> >  {
> > -	int idx = 0;
> >  	int task_pri = convert_prio(p->prio);
> > +	int best_unfit_idx = -1;
> > +	int idx = 0, cpu;
> 
> Nit, but if you moved idx, might as well remove the unnecessary
> initialization of it as well ;-)

Sure :)

> 
> >  
> >  	BUG_ON(task_pri >= CPUPRI_NR_PRIORITIES);
> >  
> >  	for (idx = 0; idx < task_pri; idx++) {
> 
> It's initialized here.
> 
> > -		struct cpupri_vec *vec  = &cp->pri_to_cpu[idx];
> > -		int skip = 0;
> >  
> > -		if (!atomic_read(&(vec)->count))
> > -			skip = 1;
> > -		/*
> > -		 * When looking at the vector, we need to read the counter,
> > -		 * do a memory barrier, then read the mask.
> > -		 *
> > -		 * Note: This is still all racey, but we can deal with it.
> > -		 *  Ideally, we only want to look at masks that are set.
> > -		 *
> > -		 *  If a mask is not set, then the only thing wrong is that we
> > -		 *  did a little more work than necessary.
> > -		 *
> > -		 *  If we read a zero count but the mask is set, because of the
> > -		 *  memory barriers, that can only happen when the highest prio
> > -		 *  task for a run queue has left the run queue, in which case,
> > -		 *  it will be followed by a pull. If the task we are processing
> > -		 *  fails to find a proper place to go, that pull request will
> > -		 *  pull this task if the run queue is running at a lower
> > -		 *  priority.
> > -		 */
> > -		smp_rmb();
> > -
> > -		/* Need to do the rmb for every iteration */
> > -		if (skip)
> > -			continue;
> > -
> > -		if (cpumask_any_and(p->cpus_ptr, vec->mask) >= nr_cpu_ids)
> > +		if (!__cpupri_find(cp, p, lowest_mask, idx))
> >  			continue;
> >  
> > -		if (lowest_mask) {
> > -			int cpu;
> > +		if (!lowest_mask || !fitness_fn)
> > +			return 1;
> >  
> > -			cpumask_and(lowest_mask, p->cpus_ptr, vec->mask);
> > +		/* Ensure the capacity of the CPUs fit the task */
> > +		for_each_cpu(cpu, lowest_mask) {
> > +			if (!fitness_fn(p, cpu))
> > +				cpumask_clear_cpu(cpu, lowest_mask);
> > +		}
> >  
> > +		/*
> > +		 * If no CPU at the current priority can fit the task
> > +		 * continue looking
> > +		 */
> > +		if (cpumask_empty(lowest_mask)) {
> >  			/*
> > -			 * We have to ensure that we have at least one bit
> > -			 * still set in the array, since the map could have
> > -			 * been concurrently emptied between the first and
> > -			 * second reads of vec->mask.  If we hit this
> > -			 * condition, simply act as though we never hit this
> > -			 * priority level and continue on.
> > +			 * Store our fallback priority in case we
> > +			 * didn't find a fitting CPU
> >  			 */
> > -			if (cpumask_empty(lowest_mask))
> > -				continue;
> > +			if (best_unfit_idx == -1)
> > +				best_unfit_idx = idx;
> >  
> > -			if (!fitness_fn)
> > -				return 1;
> > -
> > -			/* Ensure the capacity of the CPUs fit the task */
> > -			for_each_cpu(cpu, lowest_mask) {
> > -				if (!fitness_fn(p, cpu))
> > -					cpumask_clear_cpu(cpu, lowest_mask);
> > -			}
> > -
> > -			/*
> > -			 * If no CPU at the current priority can fit the task
> > -			 * continue looking
> > -			 */
> > -			if (cpumask_empty(lowest_mask))
> > -				continue;
> > +			continue;
> >  		}
> >  
> >  		return 1;
> >  	}
> >  
> > +	/*
> > +	 * If we failed to find a fitting lowest_mask, make sure we fall back
> > +	 * to the last known unfitting lowest_mask.
> > +	 *
> > +	 * Note that the map of the recorded idx might have changed since then,
> > +	 * so we must ensure to do the full dance to make sure that level still
> > +	 * holds a valid lowest_mask.
> > +	 *
> > +	 * As per above, the map could have been concurrently emptied while we
> > +	 * were busy searching for a fitting lowest_mask at the other priority
> > +	 * levels.
> > +	 *
> > +	 * This rule favours honouring priority over fitting the task in the
> > +	 * correct CPU (Capacity Awareness being the only user now).
> > +	 * The idea is that if a higher priority task can run, then it should
> > +	 * run even if this ends up being on unfitting CPU.
> > +	 *
> > +	 * The cost of this trade-off is not entirely clear and will probably
> > +	 * be good for some workloads and bad for others.
> > +	 *
> > +	 * The main idea here is that if some CPUs were overcommitted, we try
> > +	 * to spread which is what the scheduler traditionally did. Sys admins
> > +	 * must do proper RT planning to avoid overloading the system if they
> > +	 * really care.
> > +	 */
> > +	if (best_unfit_idx != -1)
> > +		return __cpupri_find(cp, p, lowest_mask, best_unfit_idx);
> 
> Hmm, this only checks the one index, which can change and then we miss
> everything. I think we can do better. What about this:

Hmm. I see 2 issues with this approach:

> 
> 
>         for (idx = 0; idx < task_pri; idx++) {
> 		int found = -1;
> 
>                 if (!__cpupri_find(cp, p, lowest_mask, idx))
>                         continue;

1.

__cpupri_find() could update the lowest_mask at the next iteration, so the
fallback wouldn't be the lowest level, right?

> 
>                 if (!lowest_mask || !fitness_fn)
>                         return 1;
> 
> 		/* Make sure we have one fit CPU before clearing */
> 		for_each_cpu(cpu, lowest_mask) {
> 			if (fitness_fn(p, cpu)) {
> 				found = cpu;
> 				break;
> 			}
> 		}
> 
> 		if (found == -1)
> 			continue;

2.

If we fix 1, then assuming found == -1 for all level, we'll still have the
problem that the mask is stale.

We can do a full scan again as Tao was suggestion, the 2nd one without any
fitness check that is. But isn't this expensive?

We risk the mask being stale anyway directly after selecting it. Or a priority
level might become the lowest level just after we dismissed it.

So our best effort could end up lying even if we do the right thing (TM).

> 
>                 /* Ensure the capacity of the CPUs fit the task */
>                 for_each_cpu(cpu, lowest_mask) {
>                         if (cpu < found || !fitness_fn(p, cpu))
>                                 cpumask_clear_cpu(cpu, lowest_mask);
>                 }
> 
>                 return 1;
>         }
> 
> This way, if nothing fits we return the untouched lowest_mask, and only
> clear the lowest_mask bits if we found a fitness cpu.

Because of 1, I think the lowest mask will not be the true lowest mask, no?
Please correct me if I missed something.

There's another 'major' problem that I need to bring your attention to,
find_lowest_rq() always returns the first CPU in the mask.

See discussion below for more details

	https://lore.kernel.org/lkml/20200219140243.wfljmupcrwm2jelo@e107158-lin/

In my test because multiple tasks wakeup together they all end up going to CPU1
(the first fitting CPU in the mask), then just to be pushed back again. Not
necessarily to where they were running before.

Not sure if there are other situations where this could happen.

If we fix this problem then we can help reduce the effect of this raciness in
find_lowest_rq(), and end up with less ping-ponging if tasks happen to
wakeup/sleep at the wrong time during the scan.

Or maybe there is a way to eliminate all these races with the current design?

Thanks

--
Qais Yousef
