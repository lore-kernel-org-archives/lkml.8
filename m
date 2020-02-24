Return-Path: <SRS0=7TUr=4M=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B5EDEC35679
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Feb 2020 06:10:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 75F3320675
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Feb 2020 06:10:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=mg.codeaurora.org header.i=@mg.codeaurora.org header.b="n0Aj8oQM"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727197AbgBXGKQ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 24 Feb 2020 01:10:16 -0500
Received: from mail26.static.mailgun.info ([104.130.122.26]:45516 "EHLO
        mail26.static.mailgun.info" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725895AbgBXGKP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Feb 2020 01:10:15 -0500
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org; q=dns/txt;
 s=smtp; t=1582524614; h=In-Reply-To: Content-Type: MIME-Version:
 References: Message-ID: Subject: Cc: To: From: Date: Sender;
 bh=WezVhpbngsRu/0CMqksHt2ZzH7Kp+nlJzmAmxW0OzTU=; b=n0Aj8oQMF9QFC8fFmy86Ft2T5g28KWsS2hNAme3nQ6QN7o+jtEOQX06J3x1C+SK2lbF5mtAd
 nWHQcV4Yobeb/h96dBy0zcwzXKgKWN4aHt5HTar7aOoS0EfOv39xwKK+j4y8g7kNBPTksYM6
 sfCSJhUZ3utEvjGpuHipQZApyME=
X-Mailgun-Sending-Ip: 104.130.122.26
X-Mailgun-Sid: WyI0MWYwYSIsICJsaW51eC1rZXJuZWxAdmdlci5rZXJuZWwub3JnIiwgImJlOWU0YSJd
Received: from smtp.codeaurora.org (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171])
 by mxa.mailgun.org with ESMTP id 5e5368c5.7fc9af8fda40-smtp-out-n02;
 Mon, 24 Feb 2020 06:10:13 -0000 (UTC)
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
        id A1C03C447A4; Mon, 24 Feb 2020 06:10:11 +0000 (UTC)
Received: from codeaurora.org (blr-c-bdr-fw-01_GlobalNAT_AllZones-Outside.qualcomm.com [103.229.19.19])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: pkondeti)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 2F114C43383;
        Mon, 24 Feb 2020 06:10:06 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 2F114C43383
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; spf=none smtp.mailfrom=pkondeti@codeaurora.org
Date:   Mon, 24 Feb 2020 11:40:04 +0530
From:   Pavan Kondeti <pkondeti@codeaurora.org>
To:     Qais Yousef <qais.yousef@arm.com>
Cc:     Ingo Molnar <mingo@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Juri Lelli <juri.lelli@redhat.com>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Ben Segall <bsegall@google.com>, Mel Gorman <mgorman@suse.de>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 5/6] sched/rt: Better manage pushing unfit tasks on
 wakeup
Message-ID: <20200224061004.GH28029@codeaurora.org>
References: <20200223184001.14248-1-qais.yousef@arm.com>
 <20200223184001.14248-6-qais.yousef@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200223184001.14248-6-qais.yousef@arm.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Qais,

On Sun, Feb 23, 2020 at 06:40:00PM +0000, Qais Yousef wrote:
> On wakeup, if a task doesn't fit the CPU it is running on (due to its
> uclamp_min value), then we trigger the push mechanism to try to find a
> more suitable CPU.
> 
> But the logic introduced in commit 804d402fb6f6 ("sched/rt: Make RT capacity-aware")
> was incomplete. If the rq isn't overloaded, push_rt_task() will bail out
> immediately.
> 
> Steve suggested using the overloaded flag to force the push, but as
> Pavan pointed out this could cause a lot of unnecessary IPIs in case of
> HAVE_RT_PUSH_IPI.
> 
> To still allow pushing unfitting task ASAP, but without causing a lot of
> disturbance in case this is not possible (no available CPU that is
> running at a lower priority level), introduce a new rt_nr_unfitting in
> struct rt_rq and use that to manage how hard we try to push an unfitting
> task in push_rt_task().
> 

The 1-4 patches in this series are looking good to me.

At this point (after applying 4 patches), removing rt_task_fits_capacity()
check from switched_to_rt() and task_woken_rt() would be sufficient, I think.
i.e no changes to push/pull logic and we have a fallback for wakeup time cpu
selection.

It is not clear what you meant by pushing the unfit task ASAP. A running
task on a little CPU can not be pushed to BIG CPU. That would require waking
a migration task to do the migration. The other problem is if CPU has more
than 2 tasks (excluding running task) which one to be pushed. Are you trying
to solve this problem?


> If the task is pinned to a single CPU, we won't inc rt_nr_unfitting,
> hence skipping the push in this case.
> 
> Also there's no need to force a push on switched_to_rt(). On the next
> wakeup we should handle it which should suffice.
> 
> Fixes: 804d402fb6f6 ("sched/rt: Make RT capacity-aware")
> LINK: https://lore.kernel.org/lkml/20200221080701.GF28029@codeaurora.org/
> Signed-off-by: Qais Yousef <qais.yousef@arm.com>
> ---
>  kernel/sched/rt.c    | 100 +++++++++++++++++++++++++++++++++++++++----
>  kernel/sched/sched.h |   3 ++
>  2 files changed, 95 insertions(+), 8 deletions(-)
> 
> diff --git a/kernel/sched/rt.c b/kernel/sched/rt.c
> index 9ae8a9fabe8b..b35e49cdafcc 100644
> --- a/kernel/sched/rt.c
> +++ b/kernel/sched/rt.c
> @@ -11,6 +11,7 @@ int sched_rr_timeslice = RR_TIMESLICE;
>  int sysctl_sched_rr_timeslice = (MSEC_PER_SEC / HZ) * RR_TIMESLICE;
>  
>  static int do_sched_rt_period_timer(struct rt_bandwidth *rt_b, int overrun);
> +static bool rt_task_fits_capacity(struct task_struct *p, int cpu);
>  
>  struct rt_bandwidth def_rt_bandwidth;
>  
> @@ -313,6 +314,27 @@ static void update_rt_migration(struct rt_rq *rt_rq)
>  	}
>  }
>  
> +#ifdef CONFIG_UCLAMP_TASK
> +static void inc_rt_unfit_tasks(struct task_struct *p, struct rt_rq *rt_rq)
> +{
> +	int cpu = cpu_of(rq_of_rt_rq(rt_rq));
> +
> +	if (!rt_task_fits_capacity(p, cpu))
> +		rt_rq->rt_nr_unfit++;
> +}
> +
> +static void dec_rt_unfit_tasks(struct task_struct *p, struct rt_rq *rt_rq)
> +{
> +	int cpu = cpu_of(rq_of_rt_rq(rt_rq));
> +
> +	if (!rt_task_fits_capacity(p, cpu))
> +		rt_rq->rt_nr_unfit--;
> +}
> +#else
> +static void inc_rt_unfit_tasks(struct task_struct *p, struct rt_rq *rt_rq) {}
> +static void dec_rt_unfit_tasks(struct task_struct *p, struct rt_rq *rt_rq) {}
> +#endif
> +
>  static void inc_rt_migration(struct sched_rt_entity *rt_se, struct rt_rq *rt_rq)
>  {
>  	struct task_struct *p;
> @@ -324,9 +346,17 @@ static void inc_rt_migration(struct sched_rt_entity *rt_se, struct rt_rq *rt_rq)
>  	rt_rq = &rq_of_rt_rq(rt_rq)->rt;
>  
>  	rt_rq->rt_nr_total++;
> -	if (p->nr_cpus_allowed > 1)
> +	if (p->nr_cpus_allowed > 1) {
>  		rt_rq->rt_nr_migratory++;
>  
> +		/*
> +		 * The task is dequeued and queue again on set_cpus_allowed(),
> +		 * so we can't end up with a unbalanced inc/dec if
> +		 * p->nr_cpus_allowed has changed.
> +		 */
> +		inc_rt_unfit_tasks(p, rt_rq);
> +	}
> +
>  	update_rt_migration(rt_rq);
>  }
>  
> @@ -341,12 +371,29 @@ static void dec_rt_migration(struct sched_rt_entity *rt_se, struct rt_rq *rt_rq)
>  	rt_rq = &rq_of_rt_rq(rt_rq)->rt;
>  
>  	rt_rq->rt_nr_total--;
> -	if (p->nr_cpus_allowed > 1)
> +	if (p->nr_cpus_allowed > 1) {
>  		rt_rq->rt_nr_migratory--;
>  
> +		/*
> +		 * The task is dequeued and queue again on set_cpus_allowed(),
> +		 * so we can't end up with a unbalanced inc/dec if
> +		 * p->nr_cpus_allowed has changed.
> +		 */
> +		dec_rt_unfit_tasks(p, rt_rq);
> +	}
> +

When uclamp values are changed via cgroups or global sysctl knobs, we don't
enqueue/dequeue all tasks similar to sched_setattr. So a task that was fit
at enqueue time can become unfit if uclamp values are changed in between.

>  	update_rt_migration(rt_rq);
>  }
>  
> +static inline int has_unfit_tasks(struct rq *rq)
> +{
> +#ifdef CONFIG_UCLAMP_TASK
> +	return rq->rt.rt_nr_unfit;
> +#else
> +	return 0;
> +#endif
> +}
> +
>  static inline int has_pushable_tasks(struct rq *rq)
>  {
>  	return !plist_head_empty(&rq->rt.pushable_tasks);
> @@ -1862,8 +1909,9 @@ static int push_rt_task(struct rq *rq)
>  	struct task_struct *next_task;
>  	struct rq *lowest_rq;
>  	int ret = 0;
> +	bool fit;
>  
> -	if (!rq->rt.overloaded)
> +	if (!rq->rt.overloaded && !has_unfit_tasks(rq))
>  		return 0;
>  

When there is one unfit RT task, are we setting overloaded anywhere due
to fitness check? I don't see that in this patch.
Even if we set overload condition, we can't push the running task.

>  	next_task = pick_next_pushable_task(rq);
> @@ -1874,12 +1922,21 @@ static int push_rt_task(struct rq *rq)
>  	if (WARN_ON(next_task == rq->curr))
>  		return 0;
>  
> +	/*
> +	 * The rq could be overloaded because it has unfitting task, if that's
> +	 * the case then we need to try harder to find a better fitting CPU.
> +	 */
> +	fit = rt_task_fits_capacity(next_task, cpu_of(rq));
> +
>  	/*
>  	 * It's possible that the next_task slipped in of
>  	 * higher priority than current. If that's the case
>  	 * just reschedule current.
> +	 *
> +	 * Unless next_task doesn't fit in this cpu, then continue with the
> +	 * attempt to push it.
>  	 */
> -	if (unlikely(next_task->prio < rq->curr->prio)) {
> +	if (unlikely(next_task->prio < rq->curr->prio && fit)) {
>  		resched_curr(rq);
>  		return 0;
>  	}
> @@ -1922,6 +1979,35 @@ static int push_rt_task(struct rq *rq)
>  		goto retry;
>  	}
>  
> +	/*
> +	 * Bail out if the task doesn't fit on either CPUs.
> +	 *
> +	 * Unless..
> +	 *
> +	 * * The rq is already overloaded, then push anyway.
> +	 *
> +	 * * The priority of next_task is higher than current, then we
> +	 *   resched_curr(). We forced skipping this condition above if the rq
> +	 *   was overloaded but the task didn't fit.
> +	 */
> +	if (!fit && !rt_task_fits_capacity(next_task, cpu_of(lowest_rq))) {
> +
> +		/*
> +		 * If the system wasn't overloaded, then pretend we didn't run.
> +		 */
> +		if (!rq->rt.overloaded)
> +			goto out_unlock;
> +
> +		/*
> +		 * If the system is overloaded, we forced skipping this
> +		 * condition, so re-evaluate it.
> +		 */
> +		if (unlikely(next_task->prio < rq->curr->prio)) {
> +			resched_curr(rq);
> +			goto out_unlock;
> +		}
> +	}
> +
>  	deactivate_task(rq, next_task, 0);
>  	set_task_cpu(next_task, lowest_rq->cpu);
>  	activate_task(lowest_rq, next_task, 0);
> @@ -1929,6 +2015,7 @@ static int push_rt_task(struct rq *rq)
>  
>  	resched_curr(lowest_rq);
>  
> +out_unlock:
>  	double_unlock_balance(rq, lowest_rq);
>  
>  out:
> @@ -2297,10 +2384,7 @@ static void switched_to_rt(struct rq *rq, struct task_struct *p)
>  	 */
>  	if (task_on_rq_queued(p) && rq->curr != p) {
>  #ifdef CONFIG_SMP
> -		bool need_to_push = rq->rt.overloaded ||
> -				    !rt_task_fits_capacity(p, cpu_of(rq));
> -
> -		if (p->nr_cpus_allowed > 1 && need_to_push)
> +		if (p->nr_cpus_allowed > 1 && rq->rt.overloaded)
>  			rt_queue_push_tasks(rq);

Right. What about the check in task_woken_rt()? We should remove it
from there too.

>  #endif /* CONFIG_SMP */
>  		if (p->prio < rq->curr->prio && cpu_online(cpu_of(rq)))
> diff --git a/kernel/sched/sched.h b/kernel/sched/sched.h
> index 1a88dc8ad11b..7dea81ccd49a 100644
> --- a/kernel/sched/sched.h
> +++ b/kernel/sched/sched.h
> @@ -603,6 +603,9 @@ struct rt_rq {
>  #ifdef CONFIG_SMP
>  	unsigned long		rt_nr_migratory;
>  	unsigned long		rt_nr_total;
> +#ifdef CONFIG_UCLAMP_TASK
> +	unsigned long		rt_nr_unfit;
> +#endif
>  	int			overloaded;
>  	struct plist_head	pushable_tasks;
>  
> -- 
> 2.17.1
> 

-- 
Qualcomm India Private Limited, on behalf of Qualcomm Innovation Center, Inc.
Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum, a Linux Foundation Collaborative Project.
