Return-Path: <SRS0=wESH=6W=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 401E5C38A2A
	for <linux-kernel@archiver.kernel.org>; Fri,  8 May 2020 08:33:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1389C208CA
	for <linux-kernel@archiver.kernel.org>; Fri,  8 May 2020 08:33:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=mg.codeaurora.org header.i=@mg.codeaurora.org header.b="V0blrqcr"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727768AbgEHId0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 8 May 2020 04:33:26 -0400
Received: from mail27.static.mailgun.info ([104.130.122.27]:30883 "EHLO
        mail27.static.mailgun.info" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726616AbgEHIdZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 May 2020 04:33:25 -0400
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org; q=dns/txt;
 s=smtp; t=1588926804; h=In-Reply-To: Content-Type: MIME-Version:
 References: Message-ID: Subject: Cc: To: From: Date: Sender;
 bh=fnFWFjkV8XYBBAeCXxdB6/4OcgYhDVeeHfzRuRT2mw0=; b=V0blrqcr7AQOUNHUQTKSEK6KGsWFpfYsvjzgnCW2V1U9QPs3Wb6V7eNYXNCDN1p1i5DSQYkR
 qjQjby9RQJ2z91ZvnkeAVp+EdyWdf/an0e00/0Z/1ydvLrEqc/4yoQ6+hcCQiRG1WKVcu6ae
 jplncvnYaCvx7Hoeu9GGv8K++1Q=
X-Mailgun-Sending-Ip: 104.130.122.27
X-Mailgun-Sid: WyI0MWYwYSIsICJsaW51eC1rZXJuZWxAdmdlci5rZXJuZWwub3JnIiwgImJlOWU0YSJd
Received: from smtp.codeaurora.org (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171])
 by mxa.mailgun.org with ESMTP id 5eb5194c.7f1e19f6a030-smtp-out-n04;
 Fri, 08 May 2020 08:33:16 -0000 (UTC)
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
        id B1B00C44792; Fri,  8 May 2020 08:33:16 +0000 (UTC)
Received: from codeaurora.org (blr-c-bdr-fw-01_GlobalNAT_AllZones-Outside.qualcomm.com [103.229.19.19])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: pkondeti)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 70956C433BA;
        Fri,  8 May 2020 08:33:11 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 70956C433BA
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; spf=none smtp.mailfrom=pkondeti@codeaurora.org
Date:   Fri, 8 May 2020 14:03:08 +0530
From:   Pavan Kondeti <pkondeti@codeaurora.org>
To:     Parth Shah <parth@linux.ibm.com>
Cc:     linux-kernel@vger.kernel.org, peterz@infradead.org,
        mingo@redhat.com, vincent.guittot@linaro.org,
        dietmar.eggemann@arm.com, qais.yousef@arm.com,
        chris.hyser@oracle.com, valentin.schneider@arm.com,
        rjw@rjwysocki.net
Subject: Re: [RFC 2/4] sched/core: Set nr_lat_sensitive counter at various
 scheduler entry/exit points
Message-ID: <20200508083308.GI19464@codeaurora.org>
References: <20200507133723.18325-1-parth@linux.ibm.com>
 <20200507133723.18325-3-parth@linux.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200507133723.18325-3-parth@linux.ibm.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Parth,

On Thu, May 07, 2020 at 07:07:21PM +0530, Parth Shah wrote:
> Monitor tasks at:
> 1. wake_up_new_task() - forked tasks
> 
> 2. set_task_cpu() - task migrations, Load balancer
> 
> 3. __sched_setscheduler() - set/unset latency_nice value
> Increment the nr_lat_sensitive count on the CPU with task marked with
> latency_nice == -20.
> Similarly, decrement the nr_lat_sensitive counter upon re-marking the task
> with >-20 latency_nice task.
> 
> 4. finish_task_switch() - dying task
> 


> Signed-off-by: Parth Shah <parth@linux.ibm.com>
> ---
>  kernel/sched/core.c  | 30 ++++++++++++++++++++++++++++--
>  kernel/sched/sched.h |  5 +++++
>  2 files changed, 33 insertions(+), 2 deletions(-)
> 
> diff --git a/kernel/sched/core.c b/kernel/sched/core.c
> index 2d8b76f41d61..ad396c36eba6 100644
> --- a/kernel/sched/core.c
> +++ b/kernel/sched/core.c
> @@ -1744,6 +1744,11 @@ void set_task_cpu(struct task_struct *p, unsigned int new_cpu)
>  	trace_sched_migrate_task(p, new_cpu);
>  
>  	if (task_cpu(p) != new_cpu) {
> +		if (task_is_lat_sensitive(p)) {
> +			per_cpu(nr_lat_sensitive, task_cpu(p))--;
> +			per_cpu(nr_lat_sensitive, new_cpu)++;
> +		}
> +

Since we can come here without rq locks, there is a possibility
of a race and incorrect updates can happen. Since the counters
are used to prevent C-states, we don't want that to happen.

>  		if (p->sched_class->migrate_task_rq)
>  			p->sched_class->migrate_task_rq(p, new_cpu);
>  		p->se.nr_migrations++;
> @@ -2947,6 +2952,7 @@ void wake_up_new_task(struct task_struct *p)
>  {
>  	struct rq_flags rf;
>  	struct rq *rq;
> +	int target_cpu = 0;
>  
>  	raw_spin_lock_irqsave(&p->pi_lock, rf.flags);
>  	p->state = TASK_RUNNING;
> @@ -2960,9 +2966,17 @@ void wake_up_new_task(struct task_struct *p)
>  	 * as we're not fully set-up yet.
>  	 */
>  	p->recent_used_cpu = task_cpu(p);
> -	__set_task_cpu(p, select_task_rq(p, task_cpu(p), SD_BALANCE_FORK, 0));
> +	target_cpu = select_task_rq(p, task_cpu(p), SD_BALANCE_FORK, 0);
> +	__set_task_cpu(p, target_cpu);
> +

The target_cpu variable can be eliminated by using task_cpu(p) directly
in the below update.

>  #endif
>  	rq = __task_rq_lock(p, &rf);
> +
> +#ifdef CONFIG_SMP
> +	if (task_is_lat_sensitive(p))
> +		per_cpu(nr_lat_sensitive, target_cpu)++;
> +#endif
> +

Is the SMP check intentional? In some parts of this patch, updates to
nr_lat_sensitive are done without SMP checks. For example,
finish_task_switch() below.

>  	update_rq_clock(rq);
>  	post_init_entity_util_avg(p);
>  
> @@ -3248,6 +3262,9 @@ static struct rq *finish_task_switch(struct task_struct *prev)
>  		if (prev->sched_class->task_dead)
>  			prev->sched_class->task_dead(prev);
>  
> +		if (task_is_lat_sensitive(prev))
> +			per_cpu(nr_lat_sensitive, prev->cpu)--;
> +
>  		/*
>  		 * Remove function-return probe instances associated with this
>  		 * task and put them back on the free list.
> @@ -4732,8 +4749,17 @@ static void __setscheduler_params(struct task_struct *p,
>  	p->normal_prio = normal_prio(p);
>  	set_load_weight(p, true);
>  
> -	if (attr->sched_flags & SCHED_FLAG_LATENCY_NICE)
> +	if (attr->sched_flags & SCHED_FLAG_LATENCY_NICE) {
> +		if (p->state != TASK_DEAD &&
> +		    attr->sched_latency_nice != p->latency_nice) {
> +			if (attr->sched_latency_nice == MIN_LATENCY_NICE)
> +				per_cpu(nr_lat_sensitive, task_cpu(p))++;
> +			else if (task_is_lat_sensitive(p))
> +				per_cpu(nr_lat_sensitive, task_cpu(p))--;
> +		}
> +
>  		p->latency_nice = attr->sched_latency_nice;
> +	}
>  }

There is a potential race here due to which we can mess up the refcount.

- A latency sensitive task is marked TASK_DEAD
<snip>
- sched_setattr() called on the task to clear the latency nice. Since
we check the task state here, we skip the decrement.
- The task is finally context switched out and we skip the decrement again
since it is not a latency senstivie task.

>  
>  /* Actually do priority change: must hold pi & rq lock. */
> diff --git a/kernel/sched/sched.h b/kernel/sched/sched.h
> index 5c41020c530e..56f885e37451 100644
> --- a/kernel/sched/sched.h
> +++ b/kernel/sched/sched.h
> @@ -211,6 +211,11 @@ static inline int task_has_dl_policy(struct task_struct *p)
>  	return dl_policy(p->policy);
>  }
>  
> +static inline int task_is_lat_sensitive(struct task_struct *p)
> +{
> +	return p->latency_nice == MIN_LATENCY_NICE;
> +}
> +
>  #define cap_scale(v, s) ((v)*(s) >> SCHED_CAPACITY_SHIFT)
>  
>  /*
> -- 
> 2.17.2
> 

Thanks,
Pavan

-- 
Qualcomm India Private Limited, on behalf of Qualcomm Innovation Center, Inc.
Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum, a Linux Foundation Collaborative Project.
