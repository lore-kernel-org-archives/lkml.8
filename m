Return-Path: <SRS0=VV4q=52=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 34020C2BA2B
	for <linux-kernel@archiver.kernel.org>; Fri, 10 Apr 2020 12:53:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0881920769
	for <linux-kernel@archiver.kernel.org>; Fri, 10 Apr 2020 12:53:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="XVjfd4IC"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726657AbgDJMxD (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 10 Apr 2020 08:53:03 -0400
Received: from us-smtp-2.mimecast.com ([207.211.31.81]:31866 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726080AbgDJMxD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Apr 2020 08:53:03 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1586523181;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=LqF4UBEchVgf9MYTYsKWmjVMPGeFZpig/VHewR58cXY=;
        b=XVjfd4ICgYo7/XoHYza9gYlvq+fqdcRqTFlb3AhIQej+Ow4c5L5Rxc1J+pmJ1P3F2ZjOMY
        CcqiEslhi/ygAwXNi79LAfjwaWNZ1FVDhmVrqpTaFcwvK0eXK6/OwKGDwDJVc89ogMbFUR
        +uLLVpUpmkOShRxRzG8g3Uy0OIfdFBs=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-277-sxKsWB6lMr-93RKdiM6jxw-1; Fri, 10 Apr 2020 08:52:58 -0400
X-MC-Unique: sxKsWB6lMr-93RKdiM6jxw-1
Received: by mail-wm1-f71.google.com with SMTP id p18so711900wmk.9
        for <linux-kernel@vger.kernel.org>; Fri, 10 Apr 2020 05:52:57 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=LqF4UBEchVgf9MYTYsKWmjVMPGeFZpig/VHewR58cXY=;
        b=suwn2FXMSQ3Br6fTbgoIONmCcR6Vaw01WoXC35Hq0r7ibfkBtD+Au8xwfWrDZ3R3Oy
         xY0ok56rIpY7CNwHleHyhTehpgUzykKcfUwqqDV3WMab3lFEiJT0iZT839M8bGa72gZm
         hB/vL0VNviLiXVy3dkuBxT4mcQ5uLpgMuvJGuaT7z2sZYx+jmlHDBZa/EUOjwbj5wqt1
         lB0xHIlUzQgUNkuiLy+1QqlWntG4QDA6/mZRFTONB2HYa3PO2RT6XiahB5XrrtqKnSYN
         BW/DCm2ChGS1EbUR5QJByE9XmXJ3BxzuVnPLTJmQ5zL05MvqdooGOvnUrCB0XFy5lQgt
         1j/g==
X-Gm-Message-State: AGi0PuZxUUuOyry/vN93qbDbT8Db7K11N9RqPiiyBjKOrb4E5MBB+p1C
        1xepz9pmc2i5x+c6wGnyr4AhXlsVWdCKLoNQZ6YyPK9HVZUR3W9XKJ9XF92uAeveacnk03Hhcqi
        hika9i7+MOhtLswBd7fnjaG7b
X-Received: by 2002:a5d:6742:: with SMTP id l2mr4810058wrw.124.1586523176745;
        Fri, 10 Apr 2020 05:52:56 -0700 (PDT)
X-Google-Smtp-Source: APiQypJS75qQ91qjkpljhtq24b8vhnGo3RSVQ9TR45ewKpjD+kSckvXzRjFCck+VH14Sfd2UDH4gQQ==
X-Received: by 2002:a5d:6742:: with SMTP id l2mr4810032wrw.124.1586523176424;
        Fri, 10 Apr 2020 05:52:56 -0700 (PDT)
Received: from localhost.localdomain ([151.29.194.179])
        by smtp.gmail.com with ESMTPSA id g186sm2872319wmg.36.2020.04.10.05.52.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 10 Apr 2020 05:52:55 -0700 (PDT)
Date:   Fri, 10 Apr 2020 14:52:53 +0200
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
Subject: Re: [PATCH 3/4] sched/deadline: Make DL capacity-aware
Message-ID: <20200410125253.GE14300@localhost.localdomain>
References: <20200408095012.3819-1-dietmar.eggemann@arm.com>
 <20200408095012.3819-4-dietmar.eggemann@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200408095012.3819-4-dietmar.eggemann@arm.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On 08/04/20 11:50, Dietmar Eggemann wrote:
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
> index 53b34a95e29e..e10adf1e3c27 100644
> --- a/kernel/sched/deadline.c
> +++ b/kernel/sched/deadline.c
> @@ -1604,6 +1604,7 @@ static int
>  select_task_rq_dl(struct task_struct *p, int cpu, int sd_flag, int flags)
>  {
>  	struct task_struct *curr;
> +	bool select_rq;
>  	struct rq *rq;
>  
>  	if (sd_flag != SD_BALANCE_WAKE)
> @@ -1623,10 +1624,19 @@ select_task_rq_dl(struct task_struct *p, int cpu, int sd_flag, int flags)
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
> +	 * We take into account the capacity of the CPU to
> +	 * ensure it fits the requirement of the task.
> +	 */
> +	if (static_branch_unlikely(&sched_asym_cpucapacity))
> +		select_rq |= !dl_task_fits_capacity(p, cpu);

I'm thinking that, while dl_task_fits_capacity() works well when
selecting idle cpus, in this case we should consider the fact that curr
might be deadline as well and already consuming some of the rq capacity.

Do you think we should try to take that into account, maybe using
dl_rq->this_bw ?

Thanks,

Juri

