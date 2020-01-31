Return-Path: <SRS0=flzY=3U=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 70856C33CB2
	for <linux-kernel@archiver.kernel.org>; Fri, 31 Jan 2020 10:06:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 339A220705
	for <linux-kernel@archiver.kernel.org>; Fri, 31 Jan 2020 10:06:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=mg.codeaurora.org header.i=@mg.codeaurora.org header.b="k2tYY3FC"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728307AbgAaKGk (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 31 Jan 2020 05:06:40 -0500
Received: from mail26.static.mailgun.info ([104.130.122.26]:32514 "EHLO
        mail26.static.mailgun.info" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1728160AbgAaKGk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 31 Jan 2020 05:06:40 -0500
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org; q=dns/txt;
 s=smtp; t=1580465199; h=In-Reply-To: Content-Type: MIME-Version:
 References: Message-ID: Subject: Cc: To: From: Date: Sender;
 bh=EpGs6eXScqMaP9HENZsJx5BfCs4zweX9ZjwZs/w1/J8=; b=k2tYY3FCvWLhxl/9Ol84A8WW5ylWoSSjlU/q6E3fYjv+6vyOROaFKpfIx9xMhD2dHP6rqVq7
 LLQk8SVho+35KADxGRUF4gnUHZJ4wlM9aB48SBy0dcv336IZXkU5TpaTjelmjnjuosLkvuMa
 7k3v290NGJgOHSDyhDERbcJrNJE=
X-Mailgun-Sending-Ip: 104.130.122.26
X-Mailgun-Sid: WyI0MWYwYSIsICJsaW51eC1rZXJuZWxAdmdlci5rZXJuZWwub3JnIiwgImJlOWU0YSJd
Received: from smtp.codeaurora.org (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171])
 by mxa.mailgun.org with ESMTP id 5e33fc2e.7f39c2dfcd18-smtp-out-n01;
 Fri, 31 Jan 2020 10:06:38 -0000 (UTC)
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
        id EF6D2C447A2; Fri, 31 Jan 2020 10:06:37 +0000 (UTC)
Received: from codeaurora.org (blr-c-bdr-fw-01_GlobalNAT_AllZones-Outside.qualcomm.com [103.229.19.19])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: pkondeti)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 988C1C43383;
        Fri, 31 Jan 2020 10:06:33 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 988C1C43383
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; spf=none smtp.mailfrom=pkondeti@codeaurora.org
Date:   Fri, 31 Jan 2020 15:36:29 +0530
From:   Pavan Kondeti <pkondeti@codeaurora.org>
To:     Qais Yousef <qais.yousef@arm.com>
Cc:     Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Juri Lelli <juri.lelli@redhat.com>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Ben Segall <bsegall@google.com>, Mel Gorman <mgorman@suse.de>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] sched: rt: Make RT capacity aware
Message-ID: <20200131100629.GC27398@codeaurora.org>
References: <20191009104611.15363-1-qais.yousef@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191009104611.15363-1-qais.yousef@arm.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Qais,

On Wed, Oct 09, 2019 at 11:46:11AM +0100, Qais Yousef wrote:
> Capacity Awareness refers to the fact that on heterogeneous systems
> (like Arm big.LITTLE), the capacity of the CPUs is not uniform, hence
> when placing tasks we need to be aware of this difference of CPU
> capacities.
> 
> In such scenarios we want to ensure that the selected CPU has enough
> capacity to meet the requirement of the running task. Enough capacity
> means here that capacity_orig_of(cpu) >= task.requirement.
> 
> The definition of task.requirement is dependent on the scheduling class.
> 
> For CFS, utilization is used to select a CPU that has >= capacity value
> than the cfs_task.util.
> 
> 	capacity_orig_of(cpu) >= cfs_task.util
> 
> DL isn't capacity aware at the moment but can make use of the bandwidth
> reservation to implement that in a similar manner CFS uses utilization.
> The following patchset implements that:
> 
> https://lore.kernel.org/lkml/20190506044836.2914-1-luca.abeni@santannapisa.it/
> 
> 	capacity_orig_of(cpu)/SCHED_CAPACITY >= dl_deadline/dl_runtime
> 
> For RT we don't have a per task utilization signal and we lack any
> information in general about what performance requirement the RT task
> needs. But with the introduction of uclamp, RT tasks can now control
> that by setting uclamp_min to guarantee a minimum performance point.
> 
> ATM the uclamp value are only used for frequency selection; but on
> heterogeneous systems this is not enough and we need to ensure that the
> capacity of the CPU is >= uclamp_min. Which is what implemented here.
> 
> 	capacity_orig_of(cpu) >= rt_task.uclamp_min
> 
> Note that by default uclamp.min is 1024, which means that RT tasks will
> always be biased towards the big CPUs, which make for a better more
> predictable behavior for the default case.
> 
> Must stress that the bias acts as a hint rather than a definite
> placement strategy. For example, if all big cores are busy executing
> other RT tasks we can't guarantee that a new RT task will be placed
> there.
> 
> On non-heterogeneous systems the original behavior of RT should be
> retained. Similarly if uclamp is not selected in the config.
> 
> Signed-off-by: Qais Yousef <qais.yousef@arm.com>
> ---
> 
> Changes in v2:
> 	- Use cpupri_find() to check the fitness of the task instead of
> 	  sprinkling find_lowest_rq() with several checks of
> 	  rt_task_fits_capacity().
> 
> 	  The selected implementation opted to pass the fitness function as an
> 	  argument rather than call rt_task_fits_capacity() capacity which is
> 	  a cleaner to keep the logical separation of the 2 modules; but it
> 	  means the compiler has less room to optimize rt_task_fits_capacity()
> 	  out when it's a constant value.
> 
> The logic is not perfect. For example if a 'small' task is occupying a big CPU
> and another big task wakes up; we won't force migrate the small task to clear
> the big cpu for the big task that woke up.
> 
> IOW, the logic is best effort and can't give hard guarantees. But improves the
> current situation where a task can randomly end up on any CPU regardless of
> what it needs. ie: without this patch an RT task can wake up on a big or small
> CPU, but with this it will always wake up on a big CPU (assuming the big CPUs
> aren't overloaded) - hence provide a consistent performance.
> 
> I'm looking at ways to improve this best effort, but this patch should be
> a good start to discuss our Capacity Awareness requirement. There's a trade-off
> of complexity to be made here and I'd like to keep things as simple as
> possible and build on top as needed.
> 
> 
>  kernel/sched/cpupri.c | 23 ++++++++++--
>  kernel/sched/cpupri.h |  4 ++-
>  kernel/sched/rt.c     | 81 +++++++++++++++++++++++++++++++++++--------
>  3 files changed, 91 insertions(+), 17 deletions(-)
> 
> diff --git a/kernel/sched/cpupri.c b/kernel/sched/cpupri.c
> index b7abca987d94..799791c01d60 100644
> --- a/kernel/sched/cpupri.c
> +++ b/kernel/sched/cpupri.c
> @@ -57,7 +57,8 @@ static int convert_prio(int prio)
>   * Return: (int)bool - CPUs were found
>   */
>  int cpupri_find(struct cpupri *cp, struct task_struct *p,
> -		struct cpumask *lowest_mask)
> +		struct cpumask *lowest_mask,
> +		bool (*fitness_fn)(struct task_struct *p, int cpu))
>  {
>  	int idx = 0;
>  	int task_pri = convert_prio(p->prio);
> @@ -98,6 +99,8 @@ int cpupri_find(struct cpupri *cp, struct task_struct *p,
>  			continue;
>  
>  		if (lowest_mask) {
> +			int cpu;
> +
>  			cpumask_and(lowest_mask, p->cpus_ptr, vec->mask);
>  
>  			/*
> @@ -108,7 +111,23 @@ int cpupri_find(struct cpupri *cp, struct task_struct *p,
>  			 * condition, simply act as though we never hit this
>  			 * priority level and continue on.
>  			 */
> -			if (cpumask_any(lowest_mask) >= nr_cpu_ids)
> +			if (cpumask_empty(lowest_mask))
> +				continue;
> +
> +			if (!fitness_fn)
> +				return 1;
> +
> +			/* Ensure the capacity of the CPUs fit the task */
> +			for_each_cpu(cpu, lowest_mask) {
> +				if (!fitness_fn(p, cpu))
> +					cpumask_clear_cpu(cpu, lowest_mask);
> +			}
> +
> +			/*
> +			 * If no CPU at the current priority can fit the task
> +			 * continue looking
> +			 */
> +			if (cpumask_empty(lowest_mask))
>  				continue;
>  		}
>  

I understand that RT tasks run on BIG cores by default when uclamp is enabled.
Can you tell what happens when we have more runnable RT tasks than the BIG
CPUs? Do they get packed on the BIG CPUs or eventually silver CPUs pull those
tasks? Since rt_task_fits_capacity() is considered during wakeup, push and
pull, the tasks may get packed on BIG forever. Is my understanding correct?

Also what happens for the case where RT tasks are pinned to silver but with
default uclamp value i.e p.uclamp.min=1024 ? They may all get queued on a
single silver and other silvers may not help since the task does not fit
there. In practice, we may not use this setup. Just wanted to know if this
behavior is intentional or not.

Thanks,
Pavan

-- 
Qualcomm India Private Limited, on behalf of Qualcomm Innovation Center, Inc.
Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum, a Linux Foundation Collaborative Project.
