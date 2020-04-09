Return-Path: <SRS0=n+Ub=5Z=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 54B9BC2BA2B
	for <linux-kernel@archiver.kernel.org>; Thu,  9 Apr 2020 10:26:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 28BE32082D
	for <linux-kernel@archiver.kernel.org>; Thu,  9 Apr 2020 10:26:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726609AbgDIK0D (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 9 Apr 2020 06:26:03 -0400
Received: from foss.arm.com ([217.140.110.172]:48184 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725828AbgDIK0D (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Apr 2020 06:26:03 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 0A09C31B;
        Thu,  9 Apr 2020 03:26:03 -0700 (PDT)
Received: from e107158-lin.cambridge.arm.com (e107158-lin.cambridge.arm.com [10.1.195.21])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 0F06D3F73D;
        Thu,  9 Apr 2020 03:26:00 -0700 (PDT)
Date:   Thu, 9 Apr 2020 11:25:58 +0100
From:   Qais Yousef <qais.yousef@arm.com>
To:     Dietmar Eggemann <dietmar.eggemann@arm.com>
Cc:     Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Juri Lelli <juri.lelli@redhat.com>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Luca Abeni <luca.abeni@santannapisa.it>,
        Daniel Bristot de Oliveira <bristot@redhat.com>,
        Wei Wang <wvw@google.com>, Quentin Perret <qperret@google.com>,
        Alessio Balsini <balsini@google.com>,
        Pavan Kondeti <pkondeti@codeaurora.org>,
        Patrick Bellasi <patrick.bellasi@matbug.net>,
        Morten Rasmussen <morten.rasmussen@arm.com>,
        Valentin Schneider <valentin.schneider@arm.com>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 4/4] sched/deadline: Implement fallback mechanism for
 !fit case
Message-ID: <20200409102557.h4humnsa5dlwvlym@e107158-lin.cambridge.arm.com>
References: <20200408095012.3819-1-dietmar.eggemann@arm.com>
 <20200408095012.3819-5-dietmar.eggemann@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20200408095012.3819-5-dietmar.eggemann@arm.com>
User-Agent: NeoMutt/20171215
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 04/08/20 11:50, Dietmar Eggemann wrote:
> From: Luca Abeni <luca.abeni@santannapisa.it>
> 
> When a task has a runtime that cannot be served within the scheduling
> deadline by any of the idle CPU (later_mask) the task is doomed to miss
> its deadline.
> 
> This can happen since the SCHED_DEADLINE admission control guarantees
> only bounded tardiness and not the hard respect of all deadlines.
> In this case try to select the idle CPU with the largest CPU capacity
> to minimize tardiness.
> 
> Signed-off-by: Luca Abeni <luca.abeni@santannapisa.it>
> Signed-off-by: Dietmar Eggemann <dietmar.eggemann@arm.com>
> ---

Outside of the scope of this series. But does it make sense to make
sched_setattr() fail to create a new deadline task if the system will be
overcommitted, hence causing some dl tasks to miss their deadlines?

If some overcommitting is fine (some deadlines are soft and are okay to fail
every once in a while), does it make sense for this to be a tunable of how much
the system can be overcommitted before disallowing new DL tasks to be created?

Just thinking out loudly. This fallback is fine, but it made me think why did
we have to end up in a situation that we can fail in the first place since the
same info is available when a new DL task is created, and being preventative
might be a better approach..

Thanks

--
Qais Yousef

>  kernel/sched/cpudeadline.c | 19 +++++++++++++++----
>  1 file changed, 15 insertions(+), 4 deletions(-)
> 
> diff --git a/kernel/sched/cpudeadline.c b/kernel/sched/cpudeadline.c
> index 8630f2a40a3f..8525d73e3de4 100644
> --- a/kernel/sched/cpudeadline.c
> +++ b/kernel/sched/cpudeadline.c
> @@ -121,19 +121,30 @@ int cpudl_find(struct cpudl *cp, struct task_struct *p,
>  
>  	if (later_mask &&
>  	    cpumask_and(later_mask, cp->free_cpus, p->cpus_ptr)) {
> -		int cpu;
> +		unsigned long cap, max_cap = 0;
> +		int cpu, max_cpu = -1;
>  
>  		if (!static_branch_unlikely(&sched_asym_cpucapacity))
>  			return 1;
>  
>  		/* Ensure the capacity of the CPUs fits the task. */
>  		for_each_cpu(cpu, later_mask) {
> -			if (!dl_task_fits_capacity(p, cpu))
> +			if (!dl_task_fits_capacity(p, cpu)) {
>  				cpumask_clear_cpu(cpu, later_mask);
> +
> +				cap = arch_scale_cpu_capacity(cpu);
> +
> +				if (cap > max_cap) {
> +					max_cap = cap;
> +					max_cpu = cpu;
> +				}
> +			}
>  		}
>  
> -		if (!cpumask_empty(later_mask))
> -			return 1;
> +		if (cpumask_empty(later_mask))
> +			cpumask_set_cpu(max_cpu, later_mask);
> +
> +		return 1;
>  	} else {
>  		int best_cpu = cpudl_maximum(cp);
>  
> -- 
> 2.17.1
> 
