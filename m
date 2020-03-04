Return-Path: <SRS0=idZ5=4V=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_2
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 92726C3F2D1
	for <linux-kernel@archiver.kernel.org>; Wed,  4 Mar 2020 16:27:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 67FB322B48
	for <linux-kernel@archiver.kernel.org>; Wed,  4 Mar 2020 16:27:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388376AbgCDQ1n (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 4 Mar 2020 11:27:43 -0500
Received: from mail.kernel.org ([198.145.29.99]:38534 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2387497AbgCDQ1n (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Mar 2020 11:27:43 -0500
Received: from gandalf.local.home (cpe-66-24-58-225.stny.res.rr.com [66.24.58.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id C035F21775;
        Wed,  4 Mar 2020 16:27:40 +0000 (UTC)
Date:   Wed, 4 Mar 2020 11:27:39 -0500
From:   Steven Rostedt <rostedt@goodmis.org>
To:     Qais Yousef <qais.yousef@arm.com>
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
Message-ID: <20200304112739.7b99677e@gandalf.local.home>
In-Reply-To: <20200302132721.8353-2-qais.yousef@arm.com>
References: <20200302132721.8353-1-qais.yousef@arm.com>
        <20200302132721.8353-2-qais.yousef@arm.com>
X-Mailer: Claws Mail 3.17.3 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon,  2 Mar 2020 13:27:16 +0000
Qais Yousef <qais.yousef@arm.com> wrote:


>  /**
>   * cpupri_find - find the best (lowest-pri) CPU in the system
>   * @cp: The cpupri context
> @@ -62,80 +115,72 @@ int cpupri_find(struct cpupri *cp, struct task_struct *p,
>  		struct cpumask *lowest_mask,
>  		bool (*fitness_fn)(struct task_struct *p, int cpu))
>  {
> -	int idx = 0;
>  	int task_pri = convert_prio(p->prio);
> +	int best_unfit_idx = -1;
> +	int idx = 0, cpu;

Nit, but if you moved idx, might as well remove the unnecessary
initialization of it as well ;-)

>  
>  	BUG_ON(task_pri >= CPUPRI_NR_PRIORITIES);
>  
>  	for (idx = 0; idx < task_pri; idx++) {

It's initialized here.

> -		struct cpupri_vec *vec  = &cp->pri_to_cpu[idx];
> -		int skip = 0;
>  
> -		if (!atomic_read(&(vec)->count))
> -			skip = 1;
> -		/*
> -		 * When looking at the vector, we need to read the counter,
> -		 * do a memory barrier, then read the mask.
> -		 *
> -		 * Note: This is still all racey, but we can deal with it.
> -		 *  Ideally, we only want to look at masks that are set.
> -		 *
> -		 *  If a mask is not set, then the only thing wrong is that we
> -		 *  did a little more work than necessary.
> -		 *
> -		 *  If we read a zero count but the mask is set, because of the
> -		 *  memory barriers, that can only happen when the highest prio
> -		 *  task for a run queue has left the run queue, in which case,
> -		 *  it will be followed by a pull. If the task we are processing
> -		 *  fails to find a proper place to go, that pull request will
> -		 *  pull this task if the run queue is running at a lower
> -		 *  priority.
> -		 */
> -		smp_rmb();
> -
> -		/* Need to do the rmb for every iteration */
> -		if (skip)
> -			continue;
> -
> -		if (cpumask_any_and(p->cpus_ptr, vec->mask) >= nr_cpu_ids)
> +		if (!__cpupri_find(cp, p, lowest_mask, idx))
>  			continue;
>  
> -		if (lowest_mask) {
> -			int cpu;
> +		if (!lowest_mask || !fitness_fn)
> +			return 1;
>  
> -			cpumask_and(lowest_mask, p->cpus_ptr, vec->mask);
> +		/* Ensure the capacity of the CPUs fit the task */
> +		for_each_cpu(cpu, lowest_mask) {
> +			if (!fitness_fn(p, cpu))
> +				cpumask_clear_cpu(cpu, lowest_mask);
> +		}
>  
> +		/*
> +		 * If no CPU at the current priority can fit the task
> +		 * continue looking
> +		 */
> +		if (cpumask_empty(lowest_mask)) {
>  			/*
> -			 * We have to ensure that we have at least one bit
> -			 * still set in the array, since the map could have
> -			 * been concurrently emptied between the first and
> -			 * second reads of vec->mask.  If we hit this
> -			 * condition, simply act as though we never hit this
> -			 * priority level and continue on.
> +			 * Store our fallback priority in case we
> +			 * didn't find a fitting CPU
>  			 */
> -			if (cpumask_empty(lowest_mask))
> -				continue;
> +			if (best_unfit_idx == -1)
> +				best_unfit_idx = idx;
>  
> -			if (!fitness_fn)
> -				return 1;
> -
> -			/* Ensure the capacity of the CPUs fit the task */
> -			for_each_cpu(cpu, lowest_mask) {
> -				if (!fitness_fn(p, cpu))
> -					cpumask_clear_cpu(cpu, lowest_mask);
> -			}
> -
> -			/*
> -			 * If no CPU at the current priority can fit the task
> -			 * continue looking
> -			 */
> -			if (cpumask_empty(lowest_mask))
> -				continue;
> +			continue;
>  		}
>  
>  		return 1;
>  	}
>  
> +	/*
> +	 * If we failed to find a fitting lowest_mask, make sure we fall back
> +	 * to the last known unfitting lowest_mask.
> +	 *
> +	 * Note that the map of the recorded idx might have changed since then,
> +	 * so we must ensure to do the full dance to make sure that level still
> +	 * holds a valid lowest_mask.
> +	 *
> +	 * As per above, the map could have been concurrently emptied while we
> +	 * were busy searching for a fitting lowest_mask at the other priority
> +	 * levels.
> +	 *
> +	 * This rule favours honouring priority over fitting the task in the
> +	 * correct CPU (Capacity Awareness being the only user now).
> +	 * The idea is that if a higher priority task can run, then it should
> +	 * run even if this ends up being on unfitting CPU.
> +	 *
> +	 * The cost of this trade-off is not entirely clear and will probably
> +	 * be good for some workloads and bad for others.
> +	 *
> +	 * The main idea here is that if some CPUs were overcommitted, we try
> +	 * to spread which is what the scheduler traditionally did. Sys admins
> +	 * must do proper RT planning to avoid overloading the system if they
> +	 * really care.
> +	 */
> +	if (best_unfit_idx != -1)
> +		return __cpupri_find(cp, p, lowest_mask, best_unfit_idx);

Hmm, this only checks the one index, which can change and then we miss
everything. I think we can do better. What about this:


        for (idx = 0; idx < task_pri; idx++) {
		int found = -1;

                if (!__cpupri_find(cp, p, lowest_mask, idx))
                        continue;

                if (!lowest_mask || !fitness_fn)
                        return 1;

		/* Make sure we have one fit CPU before clearing */
		for_each_cpu(cpu, lowest_mask) {
			if (fitness_fn(p, cpu)) {
				found = cpu;
				break;
			}
		}

		if (found == -1)
			continue;

                /* Ensure the capacity of the CPUs fit the task */
                for_each_cpu(cpu, lowest_mask) {
                        if (cpu < found || !fitness_fn(p, cpu))
                                cpumask_clear_cpu(cpu, lowest_mask);
                }

                return 1;
        }

This way, if nothing fits we return the untouched lowest_mask, and only
clear the lowest_mask bits if we found a fitness cpu.

-- Steve
