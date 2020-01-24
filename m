Return-Path: <SRS0=1j9/=3N=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2EA1AC35240
	for <linux-kernel@archiver.kernel.org>; Fri, 24 Jan 2020 02:52:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 08A9B21D7D
	for <linux-kernel@archiver.kernel.org>; Fri, 24 Jan 2020 02:52:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730479AbgAXCwp (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 23 Jan 2020 21:52:45 -0500
Received: from foss.arm.com ([217.140.110.172]:46148 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730355AbgAXCwp (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Jan 2020 21:52:45 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 1DCBF328;
        Thu, 23 Jan 2020 18:52:44 -0800 (PST)
Received: from e107158-lin (e107158-lin.cambridge.arm.com [10.1.195.21])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 577913F52E;
        Thu, 23 Jan 2020 18:52:42 -0800 (PST)
Date:   Fri, 24 Jan 2020 02:52:39 +0000
From:   Qais Yousef <qais.yousef@arm.com>
To:     Wei Wang <wvw@google.com>
Cc:     wei.vince.wang@gmail.com, dietmar.eggemann@arm.com,
        valentin.schneider@arm.com, chris.redpath@arm.com,
        qperret@google.com, Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Juri Lelli <juri.lelli@redhat.com>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Ben Segall <bsegall@google.com>, Mel Gorman <mgorman@suse.de>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] [RFC] sched: restrict iowait boost for boosted task only
Message-ID: <20200124025238.jsf36n6w4rrn2ehc@e107158-lin>
References: <20200124002811.228334-1-wvw@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20200124002811.228334-1-wvw@google.com>
User-Agent: NeoMutt/20171215
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 01/23/20 16:28, Wei Wang wrote:
> Currently iowait doesn't distinguish background/foreground tasks.
> This may not be a problem in servers but could impact devices that
> are more sensitive on energy consumption. [1]
> In Android world, we have seen many cases where device run to high and
> inefficient frequency unnecessarily when running some background task
> which are interacting I/O.
> 
> The ultimate goal is to only apply iowait boost on UX related tasks and
> leave the rest for EAS scheduler for better efficiency.
> 
> This patch limits iowait boost for tasks which are associated with boost
> signal from user land. On Android specifically, those are foreground or
> top app tasks.
> 
> [1] ANDROID discussion:
> https://android-review.googlesource.com/c/kernel/common/+/1215695
> 
> Signed-off-by: Wei Wang <wvw@google.com>
> ---
>  kernel/sched/fair.c  |  4 +++-
>  kernel/sched/sched.h | 12 ++++++++++++
>  2 files changed, 15 insertions(+), 1 deletion(-)
> 
> diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
> index ba749f579714..221c0fbcea0e 100644
> --- a/kernel/sched/fair.c
> +++ b/kernel/sched/fair.c
> @@ -5220,8 +5220,10 @@ enqueue_task_fair(struct rq *rq, struct task_struct *p, int flags)
>  	 * If in_iowait is set, the code below may not trigger any cpufreq
>  	 * utilization updates, so do it here explicitly with the IOWAIT flag
>  	 * passed.
> +	 * If CONFIG_ENERGY_MODEL and CONFIG_UCLAMP_TASK are both configured,
> +	 * only boost for tasks set with non-null min-clamp.
>  	 */
> -	if (p->in_iowait)
> +	if (iowait_boosted(p))
>  		cpufreq_update_util(rq, SCHED_CPUFREQ_IOWAIT);
>  
>  	for_each_sched_entity(se) {
> diff --git a/kernel/sched/sched.h b/kernel/sched/sched.h
> index 280a3c735935..a13d49d835ed 100644
> --- a/kernel/sched/sched.h
> +++ b/kernel/sched/sched.h
> @@ -2341,6 +2341,18 @@ static inline unsigned int uclamp_util(struct rq *rq, unsigned int util)
>  }
>  #endif /* CONFIG_UCLAMP_TASK */
>  
> +#if defined(CONFIG_ENERGY_MODEL) && defined(CONFIG_UCLAMP_TASK)

Why depend on CONFIG_ENERGY_MODEL? Laptops are battery powered and might not
have this option enabled. Do we really need energy model here?

> +static inline bool iowait_boosted(struct task_struct *p)
> +{
> +	return p->in_iowait && uclamp_eff_value(p, UCLAMP_MIN) > 0;

I think this is overloading the usage of util clamp. You're basically using
cpu.uclamp.min to temporarily switch iowait boost on/off.

Isn't it better to add a new cgroup attribute to toggle this feature?

The problem does seem generic enough and could benefit other battery-powered
devices outside of the Android world. I don't think the dependency on uclamp &&
energy model are necessary to solve this.

Thanks

--
Qais Yousef

> +}
> +#else /* defined(CONFIG_ENERGY_MODEL) && defined(CONFIG_UCLAMP_TASK) */
> +static inline bool iowait_boosted(struct task_struct *p)
> +{
> +	return p->in_iowait;
> +}
> +#endif /* defined(CONFIG_ENERGY_MODEL) && defined(CONFIG_UCLAMP_TASK) */
> +
>  #ifdef arch_scale_freq_capacity
>  # ifndef arch_scale_freq_invariant
>  #  define arch_scale_freq_invariant()	true
> -- 
> 2.25.0.341.g760bfbb309-goog
> 
