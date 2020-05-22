Return-Path: <SRS0=AA2M=7E=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8B55FC433DF
	for <linux-kernel@archiver.kernel.org>; Fri, 22 May 2020 14:59:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 498B3205CB
	for <linux-kernel@archiver.kernel.org>; Fri, 22 May 2020 14:59:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="dxY4L6Uz"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731372AbgEVO7H (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 22 May 2020 10:59:07 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:42285 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1730931AbgEVO6z (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 May 2020 10:58:55 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1590159533;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=5XaoLAqqnX0AjePEzM4E513mSIH0je3L0zFu2bL8d6Y=;
        b=dxY4L6UzW5VvzYOksfVonkAh0yZU0iUMcsSaY0IT+//lNgPC59n2Pjoq5YeLAzHGt6Iyvu
        1BgjeI1OznHd2VrhNYsDqRhCMK6Bk7+9BfSAAZHGi/MAvOw7cHnw2HMb9BpHLXqbM5dPni
        RR+6GxOn1H8cZlzxwaJw9lVqmBeuJBU=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-180-sIr1V2gUNImJfayYAzweSw-1; Fri, 22 May 2020 10:58:52 -0400
X-MC-Unique: sIr1V2gUNImJfayYAzweSw-1
Received: by mail-wr1-f71.google.com with SMTP id z10so4529066wrs.2
        for <linux-kernel@vger.kernel.org>; Fri, 22 May 2020 07:58:52 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=5XaoLAqqnX0AjePEzM4E513mSIH0je3L0zFu2bL8d6Y=;
        b=DL/DF0nFh2F+s/BdGGfsRdBhC53exYIrqMKHmhdgRhTy26CHL6dGRtSs6qlwzfvd0H
         J1S3GUIHBKnbCDW/GerWgGhGhehnm4IQbTl/oaLmtXgvg8C58tm+1ln6Dwh4sq978BIP
         JNTWc/N46U4Iqjln1EXy2EC2SZuTKvu58fGAjbbtI1p964b0gbuA3it5+22kSpFaL4GI
         97rhzV6ki8qQV8bQVmczxs/RJ5JcGuJHAlv6E98aJeKQrFLkGEy8IX8uLQLAHJl/68MP
         F0wgzTYD8kvq95opsFBAFXlYcsF3P7usHAqVRoBaYa5ldolYv8/3PQs8qBKpcL6DPpit
         AiJw==
X-Gm-Message-State: AOAM532IP5uAHjQivXEeR4VkAg8p9c+NM5UkdTHAzmVhu+MZcDYwyj8D
        svp5d78Xct6sQxaPK24DcrIVE57VkV7s9awSsUj8xOR9AJuD5weXn7h/X4ksHU31bjmFjtLd2uL
        jzrnOBmyzNf1JcJSqIHwxh3OB
X-Received: by 2002:a1c:4c16:: with SMTP id z22mr1575921wmf.17.1590159529716;
        Fri, 22 May 2020 07:58:49 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJyaNJD2NxswEbp3KjC42VAxXLa9+U2YeakcBt5MFrZihfT1BqfmtBLgzImUGUozDrmUo7mKVQ==
X-Received: by 2002:a1c:4c16:: with SMTP id z22mr1575900wmf.17.1590159529395;
        Fri, 22 May 2020 07:58:49 -0700 (PDT)
Received: from localhost.localdomain ([151.29.176.125])
        by smtp.gmail.com with ESMTPSA id z7sm9728837wrl.88.2020.05.22.07.58.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 22 May 2020 07:58:48 -0700 (PDT)
Date:   Fri, 22 May 2020 16:58:46 +0200
From:   Juri Lelli <juri.lelli@redhat.com>
To:     Dietmar Eggemann <dietmar.eggemann@arm.com>
Cc:     Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
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
        Qais Yousef <qais.yousef@arm.com>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 4/5] sched/deadline: Make DL capacity-aware
Message-ID: <20200522145846.GE600689@localhost.localdomain>
References: <20200520134243.19352-1-dietmar.eggemann@arm.com>
 <20200520134243.19352-5-dietmar.eggemann@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200520134243.19352-5-dietmar.eggemann@arm.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 20/05/20 15:42, Dietmar Eggemann wrote:
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
> index fa8566517715..f2e8f5a36707 100644
> --- a/kernel/sched/deadline.c
> +++ b/kernel/sched/deadline.c
> @@ -1643,6 +1643,7 @@ static int
>  select_task_rq_dl(struct task_struct *p, int cpu, int sd_flag, int flags)
>  {
>  	struct task_struct *curr;
> +	bool select_rq;
>  	struct rq *rq;
>  
>  	if (sd_flag != SD_BALANCE_WAKE)
> @@ -1662,10 +1663,19 @@ select_task_rq_dl(struct task_struct *p, int cpu, int sd_flag, int flags)
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
>  
>  		if (target != -1 &&
> diff --git a/kernel/sched/sched.h b/kernel/sched/sched.h
> index 14cb6a97e2d2..6ebbb1f353c4 100644
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
>  extern void init_dl_bw(struct dl_bw *dl_b);
>  extern int  sched_dl_global_validate(void);
>  extern void sched_dl_do_global(void);
> -- 

Acked-by: Juri Lelli <juri.lelli@redhat.com>

