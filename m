Return-Path: <SRS0=PfNx=4F=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E4080C34022
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Feb 2020 23:45:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C07CE2072C
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Feb 2020 23:45:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726108AbgBQXpy (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 17 Feb 2020 18:45:54 -0500
Received: from foss.arm.com ([217.140.110.172]:42850 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725987AbgBQXpy (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Feb 2020 18:45:54 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id A7A3F30E;
        Mon, 17 Feb 2020 15:45:53 -0800 (PST)
Received: from e107158-lin (e107158-lin.cambridge.arm.com [10.1.195.21])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 551EA3F703;
        Mon, 17 Feb 2020 15:45:52 -0800 (PST)
Date:   Mon, 17 Feb 2020 23:45:49 +0000
From:   Qais Yousef <qais.yousef@arm.com>
To:     Dietmar Eggemann <dietmar.eggemann@arm.com>
Cc:     Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Pavan Kondeti <pkondeti@codeaurora.org>,
        Juri Lelli <juri.lelli@redhat.com>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Ben Segall <bsegall@google.com>, Mel Gorman <mgorman@suse.de>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/3] sched/rt: cpupri_find: implement fallback mechanism
 for !fit case
Message-ID: <20200217234549.rpv3ns7bd7l6twqu@e107158-lin>
References: <20200214163949.27850-1-qais.yousef@arm.com>
 <20200214163949.27850-2-qais.yousef@arm.com>
 <c0772fca-0a4b-c88d-fdf2-5715fcf8447b@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <c0772fca-0a4b-c88d-fdf2-5715fcf8447b@arm.com>
User-Agent: NeoMutt/20171215
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 02/17/20 20:09, Dietmar Eggemann wrote:
> On 14/02/2020 17:39, Qais Yousef wrote:
> 
> [...]
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
> >  
> >  	BUG_ON(task_pri >= CPUPRI_NR_PRIORITIES);
> >  
> >  	for (idx = 0; idx < task_pri; idx++) {
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
> 
> Shouldn't we add an extra condition here?
> 
> +               if (!static_branch_unlikely(&sched_asym_cpucapacity))
> +                       return 1;
> +
> 
> Otherwise non-heterogeneous systems have to got through this
> for_each_cpu(cpu, lowest_mask) further below for no good reason.

Hmm below is the best solution I can think of at the moment. Works for you?

It's independent of what this patch tries to fix, so I'll add as a separate
patch to the series in the next update.

Thanks

--
Qais Yousef

---

diff --git a/kernel/sched/rt.c b/kernel/sched/rt.c
index 5ea235f2cfe8..5f2eaf3affde 100644
--- a/kernel/sched/rt.c
+++ b/kernel/sched/rt.c
@@ -14,6 +14,8 @@ static int do_sched_rt_period_timer(struct rt_bandwidth *rt_b, int overrun);

 struct rt_bandwidth def_rt_bandwidth;

+typedef bool (*fitness_fn_t)(struct task_struct *p, int cpu);
+
 static enum hrtimer_restart sched_rt_period_timer(struct hrtimer *timer)
 {
        struct rt_bandwidth *rt_b =
@@ -1708,6 +1710,7 @@ static int find_lowest_rq(struct task_struct *task)
        struct cpumask *lowest_mask = this_cpu_cpumask_var_ptr(local_cpu_mask);
        int this_cpu = smp_processor_id();
        int cpu      = task_cpu(task);
+       fitness_fn_t fitness_fn;

        /* Make sure the mask is initialized first */
        if (unlikely(!lowest_mask))
@@ -1716,8 +1719,17 @@ static int find_lowest_rq(struct task_struct *task)
        if (task->nr_cpus_allowed == 1)
                return -1; /* No other targets possible */

+       /*
+        * Help cpupri_find avoid the cost of looking for a fitting CPU when
+        * not really needed.
+        */
+       if (static_branch_unlikely(&sched_asym_cpucapacity))
+               fitness_fn = rt_task_fits_capacity;
+       else
+               fitness_fn = NULL;
+
        if (!cpupri_find(&task_rq(task)->rd->cpupri, task, lowest_mask,
-                        rt_task_fits_capacity))
+                        fitness_fn))
                return -1; /* No targets found */

        /*


> 
> > +		if (!lowest_mask || !fitness_fn)
> > +			return 1;
> >  
> > -			cpumask_and(lowest_mask, p->cpus_ptr, vec->mask);
> > +		/* Ensure the capacity of the CPUs fit the task */
> > +		for_each_cpu(cpu, lowest_mask) {
> > +			if (!fitness_fn(p, cpu))
> > +				cpumask_clear_cpu(cpu, lowest_mask);
> > +		}
> 
> [...]
