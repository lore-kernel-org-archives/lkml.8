Return-Path: <SRS0=CsDi=3F=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 82D49C33CB1
	for <linux-kernel@archiver.kernel.org>; Thu, 16 Jan 2020 15:15:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5511420730
	for <linux-kernel@archiver.kernel.org>; Thu, 16 Jan 2020 15:15:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="isc0ZVJl"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726944AbgAPPP2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 16 Jan 2020 10:15:28 -0500
Received: from merlin.infradead.org ([205.233.59.134]:34632 "EHLO
        merlin.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726151AbgAPPP2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Jan 2020 10:15:28 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=merlin.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=qoUXBXv4dmIcVxYx4dcFEIHMfATjHKmPNQitOkWA9AM=; b=isc0ZVJl5r1qjqtAHu2C7KfFl
        fW7BPPsbqLi54W1Ft1rofGePenGx3BsIq5Y01WVD0pSEVqOP39htMyDkmKQSok0AwYNEVP1kDOUdi
        85D9S8fagTsNdTH6JuYU0j92Duee/3ta7wHEVXGXMR3wGiY8v+gu9tkcTvvfwVTwQ5ZWbTtWa0y80
        HzIizTSlYW8Y+AcczUoJ9JRiwxmHYKydvItNDlIMfJyaEZAR0UTkMgQGfzgKIf0g8hgJXUzKRnUVE
        2QCmCD9BLiEMjPOTYfWk/83uEg1llgTcNq75yq56jb6lMn91KzMUOvNQtwshuPMKtSEpFs5sXJUJA
        kFmqSd8fg==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by merlin.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1is6rT-0003Z3-7K; Thu, 16 Jan 2020 15:15:07 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 8FAE53011DD;
        Thu, 16 Jan 2020 16:13:25 +0100 (CET)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 5D1682B6D1E15; Thu, 16 Jan 2020 16:15:02 +0100 (CET)
Date:   Thu, 16 Jan 2020 16:15:02 +0100
From:   Peter Zijlstra <peterz@infradead.org>
To:     Thara Gopinath <thara.gopinath@linaro.org>
Cc:     mingo@redhat.com, ionela.voinescu@arm.com,
        vincent.guittot@linaro.org, dietmar.eggemann@arm.com,
        rui.zhang@intel.com, qperret@google.com, daniel.lezcano@linaro.org,
        viresh.kumar@linaro.org, linux-kernel@vger.kernel.org,
        amit.kachhap@gmail.com, javi.merino@kernel.org,
        amit.kucheria@verdurent.com
Subject: Re: [Patch v8 4/7] sched/fair: Enable periodic update of average
 thermal pressure
Message-ID: <20200116151502.GQ2827@hirez.programming.kicks-ass.net>
References: <1579031859-18692-1-git-send-email-thara.gopinath@linaro.org>
 <1579031859-18692-5-git-send-email-thara.gopinath@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1579031859-18692-5-git-send-email-thara.gopinath@linaro.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jan 14, 2020 at 02:57:36PM -0500, Thara Gopinath wrote:
> Introduce support in CFS periodic tick and other bookkeeping apis
> to trigger the process of computing average thermal pressure for a
> cpu. Also consider avg_thermal.load_avg in others_have_blocked
> which allows for decay of pelt signals.
> 
> Signed-off-by: Thara Gopinath <thara.gopinath@linaro.org>
> ---
>  kernel/sched/fair.c | 8 ++++++++
>  1 file changed, 8 insertions(+)
> 
> diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
> index 8da0222..311bb0b 100644
> --- a/kernel/sched/fair.c
> +++ b/kernel/sched/fair.c
> @@ -7470,6 +7470,9 @@ static inline bool others_have_blocked(struct rq *rq)
>  	if (READ_ONCE(rq->avg_dl.util_avg))
>  		return true;
>  
> +	if (READ_ONCE(rq->avg_thermal.load_avg))
> +		return true;
> +

Given that struct sched_avg is 1 cacheline, the above is a pointless
guaranteed cacheline miss if the arch doesn't
CONFIG_HAVE_SCHED_THERMAL_PRESSURE.

>  #ifdef CONFIG_HAVE_SCHED_AVG_IRQ
>  	if (READ_ONCE(rq->avg_irq.util_avg))
>  		return true;
> @@ -7495,6 +7498,7 @@ static bool __update_blocked_others(struct rq *rq, bool *done)
>  {
>  	const struct sched_class *curr_class;
>  	u64 now = rq_clock_pelt(rq);
> +	unsigned long thermal_pressure = arch_cpu_thermal_pressure(cpu_of(rq));
>  	bool decayed;
>  
>  	/*
> @@ -7505,6 +7509,8 @@ static bool __update_blocked_others(struct rq *rq, bool *done)
>  
>  	decayed = update_rt_rq_load_avg(now, rq, curr_class == &rt_sched_class) |
>  		  update_dl_rq_load_avg(now, rq, curr_class == &dl_sched_class) |
> +		  update_thermal_load_avg(rq_clock_task(rq), rq,
> +					  thermal_pressure) 			|
>  		  update_irq_load_avg(rq, 0);
>  
>  	if (others_have_blocked(rq))

That there indentation trainwreck is a reason to rename the function.

	decayed = update_rt_rq_load_avg(now, rq, curr_class == &rt_sched_class) |
		  update_dl_rq_load_avg(now, rq, curr_class == &dl_sched_class) |
		  update_thermal_load_avg(rq_clock_task(rq), rq, thermal_pressure) |
		  update_irq_load_avg(rq, 0);

Is much better.

But now that you made me look at that, I noticed it's using a different
clock -- it is _NOT_ using now/rq_clock_pelt(), which means it'll not be
in sync with the other averages.

Is there a good reason for that?

> @@ -10275,6 +10281,7 @@ static void task_tick_fair(struct rq *rq, struct task_struct *curr, int queued)
>  {
>  	struct cfs_rq *cfs_rq;
>  	struct sched_entity *se = &curr->se;
> +	unsigned long thermal_pressure = arch_cpu_thermal_pressure(cpu_of(rq));
>  
>  	for_each_sched_entity(se) {
>  		cfs_rq = cfs_rq_of(se);
> @@ -10286,6 +10293,7 @@ static void task_tick_fair(struct rq *rq, struct task_struct *curr, int queued)
>  
>  	update_misfit_status(curr, rq);
>  	update_overutilized_status(task_rq(curr));
> +	update_thermal_load_avg(rq_clock_task(rq), rq, thermal_pressure);
>  }

I'm thinking this is the wrong place; should this not be in
scheduler_tick(), right before calling sched_class::task_tick() ? Surely
any execution will affect thermals, not only fair class execution.
