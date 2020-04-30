Return-Path: <SRS0=SogR=6O=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9025CC8300A
	for <linux-kernel@archiver.kernel.org>; Thu, 30 Apr 2020 13:11:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 656B22082E
	for <linux-kernel@archiver.kernel.org>; Thu, 30 Apr 2020 13:11:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=mg.codeaurora.org header.i=@mg.codeaurora.org header.b="iVeNuxg4"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726837AbgD3NLF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 30 Apr 2020 09:11:05 -0400
Received: from mail26.static.mailgun.info ([104.130.122.26]:10170 "EHLO
        mail26.static.mailgun.info" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726577AbgD3NLE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Apr 2020 09:11:04 -0400
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org; q=dns/txt;
 s=smtp; t=1588252262; h=In-Reply-To: Content-Type: MIME-Version:
 References: Message-ID: Subject: Cc: To: From: Date: Sender;
 bh=IWQCgRCTAvu6acX8+beIsSHVTleZwB9MBvZXRrdCz7A=; b=iVeNuxg4n/KtFZqZGy4c/30a+c41jtnlWDucYTZxhISx09gGPJXi2fzDhrU3fPHI2z6NjSL4
 KjBVR6AyaxN6pByeEMTtK7iT0Or/1sP2rBhLflVyJNWyDSo+aSbR34+cprDLyMoJr+NjqzFb
 7PbF4g4FQ2GkRvGvbmrN/w/QdbY=
X-Mailgun-Sending-Ip: 104.130.122.26
X-Mailgun-Sid: WyI0MWYwYSIsICJsaW51eC1rZXJuZWxAdmdlci5rZXJuZWwub3JnIiwgImJlOWU0YSJd
Received: from smtp.codeaurora.org (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171])
 by mxa.mailgun.org with ESMTP id 5eaace56.7f88f8ef2f10-smtp-out-n01;
 Thu, 30 Apr 2020 13:10:46 -0000 (UTC)
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
        id 8F8A6C43637; Thu, 30 Apr 2020 13:10:46 +0000 (UTC)
Received: from codeaurora.org (blr-c-bdr-fw-01_GlobalNAT_AllZones-Outside.qualcomm.com [103.229.19.19])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: pkondeti)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 63CB4C433CB;
        Thu, 30 Apr 2020 13:10:40 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 63CB4C433CB
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; spf=none smtp.mailfrom=pkondeti@codeaurora.org
Date:   Thu, 30 Apr 2020 18:40:37 +0530
From:   Pavan Kondeti <pkondeti@codeaurora.org>
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
        Patrick Bellasi <patrick.bellasi@matbug.net>,
        Morten Rasmussen <morten.rasmussen@arm.com>,
        Valentin Schneider <valentin.schneider@arm.com>,
        Qais Yousef <qais.yousef@arm.com>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 5/6] sched/deadline: Make DL capacity-aware
Message-ID: <20200430131036.GE19464@codeaurora.org>
References: <20200427083709.30262-1-dietmar.eggemann@arm.com>
 <20200427083709.30262-6-dietmar.eggemann@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200427083709.30262-6-dietmar.eggemann@arm.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Apr 27, 2020 at 10:37:08AM +0200, Dietmar Eggemann wrote:
> From: Luca Abeni <luca.abeni@santannapisa.it>
> 
> The current SCHED_DEADLINE (DL) scheduler uses a global EDF scheduling
> algorithm w/o considering CPU capacity or task utilization.
> This works well on homogeneous systems where DL tasks are guaranteed
> to have a bounded tardiness but presents issues on heterogeneous
> systems.
> 
> A DL task can migrate to a CPU which does not have enough CPU capacity
> to correctly serve the task (e.g. a task w/ 70ms runtime and 100ms
> period on a CPU w/ 512 capacity).
> 
> Add the DL fitness function dl_task_fits_capacity() for DL admission
> control on heterogeneous systems. A task fits onto a CPU if:
> 
>     CPU original capacity / 1024 >= task runtime / task deadline
> 
> Use this function on heterogeneous systems to try to find a CPU which
> meets this criterion during task wakeup, push and offline migration.
> 
> On homogeneous systems the original behavior of the DL admission
> control should be retained.
> 
> Signed-off-by: Luca Abeni <luca.abeni@santannapisa.it>
> Signed-off-by: Dietmar Eggemann <dietmar.eggemann@arm.com>
> ---
>  kernel/sched/cpudeadline.c | 14 +++++++++++++-
>  kernel/sched/deadline.c    | 18 ++++++++++++++----
>  kernel/sched/sched.h       | 15 +++++++++++++++
>  3 files changed, 42 insertions(+), 5 deletions(-)
> 
> diff --git a/kernel/sched/cpudeadline.c b/kernel/sched/cpudeadline.c
> index 5cc4012572ec..8630f2a40a3f 100644
> --- a/kernel/sched/cpudeadline.c
> +++ b/kernel/sched/cpudeadline.c
> @@ -121,7 +121,19 @@ int cpudl_find(struct cpudl *cp, struct task_struct *p,
>  
>  	if (later_mask &&
>  	    cpumask_and(later_mask, cp->free_cpus, p->cpus_ptr)) {
> -		return 1;
> +		int cpu;
> +
> +		if (!static_branch_unlikely(&sched_asym_cpucapacity))
> +			return 1;
> +
> +		/* Ensure the capacity of the CPUs fits the task. */
> +		for_each_cpu(cpu, later_mask) {
> +			if (!dl_task_fits_capacity(p, cpu))
> +				cpumask_clear_cpu(cpu, later_mask);
> +		}
> +
> +		if (!cpumask_empty(later_mask))
> +			return 1;
>  	} else {
>  		int best_cpu = cpudl_maximum(cp);
>  
> diff --git a/kernel/sched/deadline.c b/kernel/sched/deadline.c
> index 08ab28e1cefc..575b7d88d839 100644
> --- a/kernel/sched/deadline.c
> +++ b/kernel/sched/deadline.c
> @@ -1634,6 +1634,7 @@ static int
>  select_task_rq_dl(struct task_struct *p, int cpu, int sd_flag, int flags)
>  {
>  	struct task_struct *curr;
> +	bool select_rq;
>  	struct rq *rq;
>  
>  	if (sd_flag != SD_BALANCE_WAKE)
> @@ -1653,10 +1654,19 @@ select_task_rq_dl(struct task_struct *p, int cpu, int sd_flag, int flags)
>  	 * other hand, if it has a shorter deadline, we
>  	 * try to make it stay here, it might be important.
>  	 */
> -	if (unlikely(dl_task(curr)) &&
> -	    (curr->nr_cpus_allowed < 2 ||
> -	     !dl_entity_preempt(&p->dl, &curr->dl)) &&
> -	    (p->nr_cpus_allowed > 1)) {
> +	select_rq = unlikely(dl_task(curr)) &&
> +		    (curr->nr_cpus_allowed < 2 ||
> +		     !dl_entity_preempt(&p->dl, &curr->dl)) &&
> +		    p->nr_cpus_allowed > 1;
> +
> +	/*
> +	 * Take the capacity of the CPU into account to
> +	 * ensure it fits the requirement of the task.
> +	 */
> +	if (static_branch_unlikely(&sched_asym_cpucapacity))
> +		select_rq |= !dl_task_fits_capacity(p, cpu);
> +
> +	if (select_rq) {
>  		int target = find_later_rq(p);

I see that find_later_rq() checks if the previous CPU is part of
later_mask and returns it immediately. So we don't migrate the
task in the case where there previous CPU can't fit the task and
there are no idle CPUs on which the task can fit. LGTM.

>  
>  		if (target != -1 &&
> diff --git a/kernel/sched/sched.h b/kernel/sched/sched.h
> index 511edacc2282..ec0efd99497b 100644
> --- a/kernel/sched/sched.h
> +++ b/kernel/sched/sched.h
> @@ -317,6 +317,21 @@ static inline bool __dl_overflow(struct dl_bw *dl_b, unsigned long cap,
>  	       cap_scale(dl_b->bw, cap) < dl_b->total_bw - old_bw + new_bw;
>  }
>  
> +/*
> + * Verify the fitness of task @p to run on @cpu taking into account the
> + * CPU original capacity and the runtime/deadline ratio of the task.
> + *
> + * The function will return true if the CPU original capacity of the
> + * @cpu scaled by SCHED_CAPACITY_SCALE >= runtime/deadline ratio of the
> + * task and false otherwise.
> + */
> +static inline bool dl_task_fits_capacity(struct task_struct *p, int cpu)
> +{
> +	unsigned long cap = arch_scale_cpu_capacity(cpu);
> +
> +	return cap_scale(p->dl.dl_deadline, cap) >= p->dl.dl_runtime;
> +}
> +

This is same as

return p->dl.dl_bw >> (BW_SHIFT - SCHED_CAPACITY_SHIFT) <= cap

Correct?  If yes, would it be better to use this?

Thanks,
Pavan

-- 
Qualcomm India Private Limited, on behalf of Qualcomm Innovation Center, Inc.
Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum, a Linux Foundation Collaborative Project.
