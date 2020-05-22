Return-Path: <SRS0=AA2M=7E=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7B1A3C433DF
	for <linux-kernel@archiver.kernel.org>; Fri, 22 May 2020 14:59:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3C794205CB
	for <linux-kernel@archiver.kernel.org>; Fri, 22 May 2020 14:59:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="S4PISZ5Q"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731165AbgEVO7M (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 22 May 2020 10:59:12 -0400
Received: from us-smtp-2.mimecast.com ([207.211.31.81]:29489 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1730306AbgEVO7K (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 May 2020 10:59:10 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1590159548;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=9V1KMcVCYfmseNXs10csHjrAiE7ISkQIhvFETaCXQP4=;
        b=S4PISZ5QTjDYKxVCkRBHJSL8KzmiSQZCBnjj+My6Xc6TZcQO6dEdlWLSFSGs5kLq7USRVL
        hVlkybR8GLSubMAsiFrBKpLDkZ3haawnWLT+/ZuPWUxw1ua6W8ZCgsJDfWAyDeh/qkZyrM
        uQxlBagSvMXsXua/TM3GHdUmhzY6zW8=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-431-QzIjg918Mpat1EMVi8ib5w-1; Fri, 22 May 2020 10:59:06 -0400
X-MC-Unique: QzIjg918Mpat1EMVi8ib5w-1
Received: by mail-wm1-f72.google.com with SMTP id m11so2756197wml.5
        for <linux-kernel@vger.kernel.org>; Fri, 22 May 2020 07:59:06 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=9V1KMcVCYfmseNXs10csHjrAiE7ISkQIhvFETaCXQP4=;
        b=e+HGqm5yonCcHIWESO9XM/77a6YX7LqVjcYWtjZoVJoXfAQ8qpZ/hLXJGQ/oCDrPPC
         VVOZi2spws5BAeWKYrycNDHHYpY0W/zBH9lkJQwkyMg7oxGU7OROmoI9hHk1vu6rdBEN
         soko0kmF24dgdF4kA4gSoNJLcGsV4tmzb8kj+GX5XnlCZN6/1svd3CCeLJcYbKUyEha7
         XtFWWi5AMo8nru1D8+0koprK+pb2GEAIXrJ2/G/I6ijHwmTZjwrOgbvJkyfcVMqT5bdm
         tt7fy8F6xhELfrhJLhidwd27l5FVbq5qNXR44YQ3dvlt9QEFO+yPBXX1WCrUirr3qdFV
         FqNA==
X-Gm-Message-State: AOAM531kfAboOgQnX3P9X0rnEJqeTmj59QoWi/WELBJtwqbafL4IBKN7
        hFh9nDAsZM2JLxVKV01G0a8Q3WheNLb2StviFU/oIfj3AyswsEQOy5qPUoxlC1PewEB/W60JRwM
        eLu0uIqw7bhvZ7zyRVMKRgjke
X-Received: by 2002:a05:6000:1c5:: with SMTP id t5mr4066391wrx.229.1590159545170;
        Fri, 22 May 2020 07:59:05 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJxLKrDXMh7GgjbEFduXzdNuG+aerFiNNHbYbt/h3MNDMdzyBSK5PcErcAMEZLwwBm9Ff2XVkA==
X-Received: by 2002:a05:6000:1c5:: with SMTP id t5mr4066372wrx.229.1590159544888;
        Fri, 22 May 2020 07:59:04 -0700 (PDT)
Received: from localhost.localdomain ([151.29.176.125])
        by smtp.gmail.com with ESMTPSA id h137sm16059488wme.0.2020.05.22.07.59.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 22 May 2020 07:59:04 -0700 (PDT)
Date:   Fri, 22 May 2020 16:59:02 +0200
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
Subject: Re: [PATCH v3 5/5] sched/deadline: Implement fallback mechanism for
 !fit case
Message-ID: <20200522145902.GF600689@localhost.localdomain>
References: <20200520134243.19352-1-dietmar.eggemann@arm.com>
 <20200520134243.19352-6-dietmar.eggemann@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200520134243.19352-6-dietmar.eggemann@arm.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 20/05/20 15:42, Dietmar Eggemann wrote:
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
> Favor task_cpu(p) if it has max capacity of !fitting CPUs so that
> find_later_rq() can potentially still return it (most likely cache-hot)
> early.
> 
> Signed-off-by: Luca Abeni <luca.abeni@santannapisa.it>
> Signed-off-by: Dietmar Eggemann <dietmar.eggemann@arm.com>
> ---
>  kernel/sched/cpudeadline.c | 20 ++++++++++++++++----
>  1 file changed, 16 insertions(+), 4 deletions(-)
> 
> diff --git a/kernel/sched/cpudeadline.c b/kernel/sched/cpudeadline.c
> index 8630f2a40a3f..8cb06c8c7eb1 100644
> --- a/kernel/sched/cpudeadline.c
> +++ b/kernel/sched/cpudeadline.c
> @@ -121,19 +121,31 @@ int cpudl_find(struct cpudl *cp, struct task_struct *p,
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
> +				cap = capacity_orig_of(cpu);
> +
> +				if (cap > max_cap ||
> +				    (cpu == task_cpu(p) && cap == max_cap)) {
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

Acked-by: Juri Lelli <juri.lelli@redhat.com>

