Return-Path: <SRS0=AA2M=7E=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 68FA6C433E0
	for <linux-kernel@archiver.kernel.org>; Fri, 22 May 2020 14:58:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 331B0205CB
	for <linux-kernel@archiver.kernel.org>; Fri, 22 May 2020 14:58:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="XTm6h5XJ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731149AbgEVO6m (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 22 May 2020 10:58:42 -0400
Received: from us-smtp-2.mimecast.com ([207.211.31.81]:43586 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1730172AbgEVO6i (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 May 2020 10:58:38 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1590159516;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=Tcg5O6tg9/g2qkZJF7ek4q20Mh8+V3JxTbjxECMTTXE=;
        b=XTm6h5XJ3s3zGNw9jBzwYMmu+MYHrwu1c/nw8EpIE+Y/kFjdVw6k2EfmN4iqBvxq9MBrp4
        eTg5K+T0+ogR1KQUXPnVQSg1fWnAL9hLxIRW39p0njJhyIqWVzjHHG/dDWjZwL+XzVa2mI
        Ruwml5e2Atf8aX/BxiCuBfztFOVwlB0=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-287-MZXjoiUmNDOMp-gsqYYijQ-1; Fri, 22 May 2020 10:58:32 -0400
X-MC-Unique: MZXjoiUmNDOMp-gsqYYijQ-1
Received: by mail-wm1-f69.google.com with SMTP id j132so2667113wma.8
        for <linux-kernel@vger.kernel.org>; Fri, 22 May 2020 07:58:32 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=Tcg5O6tg9/g2qkZJF7ek4q20Mh8+V3JxTbjxECMTTXE=;
        b=CDFa9L1X0KqwoFiwqCtvh70O7BgZVozKbxf6KARz9/BokeQTiOIXkseaujSkPJcjHE
         O5Y8yRngCQP3Nj8yjWXFapMcZijSEcBojBnrvaonoMxlm8NQ2xjGf6waJZwCNrH3qFyt
         3NQLF/OKJDjpil7pELvMHldwiWYgd/iv6A0wYUr2t0Z017rJzzcs3Zr9z26HnVjwXfQd
         R0Qt6biw/whsZvcQw/HUtEGpgTfnlC62v4NMv1fowAXcQD/F5X+FO95etnR1sDC/ogrc
         BSSptMXRICiINE8jVkMSe8hcTJ1JtkSo5gezbafdRbc3hZSNI+nvLP+5HxRcYRBH5h7m
         1y9Q==
X-Gm-Message-State: AOAM531LrcuWSYGCNXJgoFrw9gdJBRBbkNBT2YoJg36JjgLkeFh/ESLX
        PdMB15JA1jczzU/0BMmBaK/+Lxejc0k3wwfedKRvoe9zgHNMDQM1L+YGZjV0WyaOq3gDzqUEHFR
        mpXPvwtg20pwLSUJx8YSdkhEp
X-Received: by 2002:a1c:2e16:: with SMTP id u22mr12843834wmu.168.1590159510798;
        Fri, 22 May 2020 07:58:30 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJwdYY+sHy9mv5Kyov467vdDyzrFTaugGd8YBGb5SSCeOtFdndcs7Q1XBx4uKMsFnHn1Vx5A2g==
X-Received: by 2002:a1c:2e16:: with SMTP id u22mr12843803wmu.168.1590159510522;
        Fri, 22 May 2020 07:58:30 -0700 (PDT)
Received: from localhost.localdomain ([151.29.176.125])
        by smtp.gmail.com with ESMTPSA id 94sm10137191wrf.74.2020.05.22.07.58.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 22 May 2020 07:58:30 -0700 (PDT)
Date:   Fri, 22 May 2020 16:58:27 +0200
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
Subject: Re: [PATCH v3 3/5] sched/deadline: Improve admission control for
 asymmetric CPU capacities
Message-ID: <20200522145827.GD600689@localhost.localdomain>
References: <20200520134243.19352-1-dietmar.eggemann@arm.com>
 <20200520134243.19352-4-dietmar.eggemann@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200520134243.19352-4-dietmar.eggemann@arm.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 20/05/20 15:42, Dietmar Eggemann wrote:
> From: Luca Abeni <luca.abeni@santannapisa.it>
> 
> The current SCHED_DEADLINE (DL) admission control ensures that
> 
>     sum of reserved CPU bandwidth < x * M
> 
> where
> 
>     x = /proc/sys/kernel/sched_rt_{runtime,period}_us
>     M = # CPUs in root domain.
> 
> DL admission control works well for homogeneous systems where the
> capacity of all CPUs are equal (1024). I.e. bounded tardiness for DL
> and non-starvation of non-DL tasks is guaranteed.
> 
> But on heterogeneous systems where capacity of CPUs are different it
> could fail by over-allocating CPU time on smaller capacity CPUs.
> 
> On an Arm big.LITTLE/DynamIQ system DL tasks can easily starve other
> tasks making it unusable.
> 
> Fix this by explicitly considering the CPU capacity in the DL admission
> test by replacing M with the root domain CPU capacity sum.
> 
> Signed-off-by: Luca Abeni <luca.abeni@santannapisa.it>
> Signed-off-by: Dietmar Eggemann <dietmar.eggemann@arm.com>
> ---
>  kernel/sched/deadline.c | 30 +++++++++++++++++-------------
>  kernel/sched/sched.h    |  6 +++---
>  2 files changed, 20 insertions(+), 16 deletions(-)
> 
> diff --git a/kernel/sched/deadline.c b/kernel/sched/deadline.c
> index ea7282ce484c..fa8566517715 100644
> --- a/kernel/sched/deadline.c
> +++ b/kernel/sched/deadline.c
> @@ -2590,11 +2590,12 @@ void sched_dl_do_global(void)
>  int sched_dl_overflow(struct task_struct *p, int policy,
>  		      const struct sched_attr *attr)
>  {
> -	struct dl_bw *dl_b = dl_bw_of(task_cpu(p));
>  	u64 period = attr->sched_period ?: attr->sched_deadline;
>  	u64 runtime = attr->sched_runtime;
>  	u64 new_bw = dl_policy(policy) ? to_ratio(period, runtime) : 0;
> -	int cpus, err = -1;
> +	int cpus, err = -1, cpu = task_cpu(p);
> +	struct dl_bw *dl_b = dl_bw_of(cpu);
> +	unsigned long cap;
>  
>  	if (attr->sched_flags & SCHED_FLAG_SUGOV)
>  		return 0;
> @@ -2609,15 +2610,17 @@ int sched_dl_overflow(struct task_struct *p, int policy,
>  	 * allocated bandwidth of the container.
>  	 */
>  	raw_spin_lock(&dl_b->lock);
> -	cpus = dl_bw_cpus(task_cpu(p));
> +	cpus = dl_bw_cpus(cpu);
> +	cap = dl_bw_capacity(cpu);
> +
>  	if (dl_policy(policy) && !task_has_dl_policy(p) &&
> -	    !__dl_overflow(dl_b, cpus, 0, new_bw)) {
> +	    !__dl_overflow(dl_b, cap, 0, new_bw)) {
>  		if (hrtimer_active(&p->dl.inactive_timer))
>  			__dl_sub(dl_b, p->dl.dl_bw, cpus);
>  		__dl_add(dl_b, new_bw, cpus);
>  		err = 0;
>  	} else if (dl_policy(policy) && task_has_dl_policy(p) &&
> -		   !__dl_overflow(dl_b, cpus, p->dl.dl_bw, new_bw)) {
> +		   !__dl_overflow(dl_b, cap, p->dl.dl_bw, new_bw)) {
>  		/*
>  		 * XXX this is slightly incorrect: when the task
>  		 * utilization decreases, we should delay the total
> @@ -2753,19 +2756,19 @@ bool dl_param_changed(struct task_struct *p, const struct sched_attr *attr)
>  #ifdef CONFIG_SMP
>  int dl_task_can_attach(struct task_struct *p, const struct cpumask *cs_cpus_allowed)
>  {
> +	unsigned long flags, cap;
>  	unsigned int dest_cpu;
>  	struct dl_bw *dl_b;
>  	bool overflow;
> -	int cpus, ret;
> -	unsigned long flags;
> +	int ret;
>  
>  	dest_cpu = cpumask_any_and(cpu_active_mask, cs_cpus_allowed);
>  
>  	rcu_read_lock_sched();
>  	dl_b = dl_bw_of(dest_cpu);
>  	raw_spin_lock_irqsave(&dl_b->lock, flags);
> -	cpus = dl_bw_cpus(dest_cpu);
> -	overflow = __dl_overflow(dl_b, cpus, 0, p->dl.dl_bw);
> +	cap = dl_bw_capacity(dest_cpu);
> +	overflow = __dl_overflow(dl_b, cap, 0, p->dl.dl_bw);
>  	if (overflow) {
>  		ret = -EBUSY;
>  	} else {
> @@ -2775,6 +2778,8 @@ int dl_task_can_attach(struct task_struct *p, const struct cpumask *cs_cpus_allo
>  		 * We will free resources in the source root_domain
>  		 * later on (see set_cpus_allowed_dl()).
>  		 */
> +		int cpus = dl_bw_cpus(dest_cpu);
> +
>  		__dl_add(dl_b, p->dl.dl_bw, cpus);
>  		ret = 0;
>  	}
> @@ -2807,16 +2812,15 @@ int dl_cpuset_cpumask_can_shrink(const struct cpumask *cur,
>  
>  bool dl_cpu_busy(unsigned int cpu)
>  {
> -	unsigned long flags;
> +	unsigned long flags, cap;
>  	struct dl_bw *dl_b;
>  	bool overflow;
> -	int cpus;
>  
>  	rcu_read_lock_sched();
>  	dl_b = dl_bw_of(cpu);
>  	raw_spin_lock_irqsave(&dl_b->lock, flags);
> -	cpus = dl_bw_cpus(cpu);
> -	overflow = __dl_overflow(dl_b, cpus, 0, 0);
> +	cap = dl_bw_capacity(cpu);
> +	overflow = __dl_overflow(dl_b, cap, 0, 0);
>  	raw_spin_unlock_irqrestore(&dl_b->lock, flags);
>  	rcu_read_unlock_sched();
>  
> diff --git a/kernel/sched/sched.h b/kernel/sched/sched.h
> index 21416b30c520..14cb6a97e2d2 100644
> --- a/kernel/sched/sched.h
> +++ b/kernel/sched/sched.h
> @@ -310,11 +310,11 @@ void __dl_add(struct dl_bw *dl_b, u64 tsk_bw, int cpus)
>  	__dl_update(dl_b, -((s32)tsk_bw / cpus));
>  }
>  
> -static inline
> -bool __dl_overflow(struct dl_bw *dl_b, int cpus, u64 old_bw, u64 new_bw)
> +static inline bool __dl_overflow(struct dl_bw *dl_b, unsigned long cap,
> +				 u64 old_bw, u64 new_bw)
>  {
>  	return dl_b->bw != -1 &&
> -	       dl_b->bw * cpus < dl_b->total_bw - old_bw + new_bw;
> +	       cap_scale(dl_b->bw, cap) < dl_b->total_bw - old_bw + new_bw;
>  }
>  
>  extern void init_dl_bw(struct dl_bw *dl_b);
> -- 

Acked-by: Juri Lelli <juri.lelli@redhat.com>

