Return-Path: <SRS0=AA2M=7E=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 929E9C433DF
	for <linux-kernel@archiver.kernel.org>; Fri, 22 May 2020 14:58:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 73758206C3
	for <linux-kernel@archiver.kernel.org>; Fri, 22 May 2020 14:58:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Qavi8gxF"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730996AbgEVO6O (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 22 May 2020 10:58:14 -0400
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:50627 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1730699AbgEVO6K (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 May 2020 10:58:10 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1590159487;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=iH5yVdy61YIiERwmNvp4WQdgMphPo686FYjJ6kiL4ZA=;
        b=Qavi8gxFgMxdw4CYkqhoX6BzBiAQoYYgHKu0iQdB76mld0t8aXh+VEXbEkmQ43z7aFeNvb
        IdoSrAG6Pmg3IKFFyxANnVdYvO0a+mdjfEcu2915HzM0V75SCB3Rjb7qIn5MHxuxwgDwju
        /6EDyIn7JnR2UlZGQ78qhYC1Aeb3KgE=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-435-vYfV2lUpP6-oGK-i_XgiHg-1; Fri, 22 May 2020 10:58:06 -0400
X-MC-Unique: vYfV2lUpP6-oGK-i_XgiHg-1
Received: by mail-wm1-f71.google.com with SMTP id f9so4208325wml.9
        for <linux-kernel@vger.kernel.org>; Fri, 22 May 2020 07:58:06 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=iH5yVdy61YIiERwmNvp4WQdgMphPo686FYjJ6kiL4ZA=;
        b=CWDp3U+5ca/zcTe1/kCmwJjR7MadBX+ikvzXhSGtLpErbciwuNHZTAsWtVLCVHCKKn
         IST96qnfoFyckgQ4gYTKZPAvcWgrrCZLwAlG7chKqHbUeuMkgiO1BSOq2Iitm6fn5Tpo
         WLxwyGFENyUxhAv9q3WMO5g6Z+mEzT9gZ5s5O3oJIuEnd8ArSgB7FWg8GVeKiRNwkCyK
         yUYkBewy6qUrS5LVMh/zrsZKT1H3A2SIjTrP3e9P/iy2v12yD/28qepY2L8vqmH/1/w7
         lZoUenTCw6/F7sMwZSBGktPOUpfuM19Lg6veqPA1ratkqXCCXvhA6aSgUp7YAqa2ga3F
         4sPA==
X-Gm-Message-State: AOAM533ZLJBOmlMoBNACLhJKRjlbk/PH3ZhuYaANnhleYptY1ZUPFIft
        tccweA11gGlRdNL0/rPNOgm7DAsAlygRWOnjjTxECg1luEWtcPSp4cdcYb99FI0JIjACvVQPdWI
        ix8M2dKWBeIxwztQ8Dt8LPe++
X-Received: by 2002:adf:f1c3:: with SMTP id z3mr4026778wro.201.1590159485111;
        Fri, 22 May 2020 07:58:05 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJzKjvGDwnmuEq3et/BLCF8Wh7yOCByU0KoiB4uZlEPuXaSdvfxQg7Rn1+Ocx72s1TGajpOpxg==
X-Received: by 2002:adf:f1c3:: with SMTP id z3mr4026753wro.201.1590159484884;
        Fri, 22 May 2020 07:58:04 -0700 (PDT)
Received: from localhost.localdomain ([151.29.176.125])
        by smtp.gmail.com with ESMTPSA id v24sm10259172wmh.45.2020.05.22.07.58.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 22 May 2020 07:58:04 -0700 (PDT)
Date:   Fri, 22 May 2020 16:58:02 +0200
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
Subject: Re: [PATCH v3 2/5] sched/deadline: Add dl_bw_capacity()
Message-ID: <20200522145802.GC600689@localhost.localdomain>
References: <20200520134243.19352-1-dietmar.eggemann@arm.com>
 <20200520134243.19352-3-dietmar.eggemann@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200520134243.19352-3-dietmar.eggemann@arm.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 20/05/20 15:42, Dietmar Eggemann wrote:
> Capacity-aware SCHED_DEADLINE Admission Control (AC) needs root domain
> (rd) CPU capacity sum.
> 
> Introduce dl_bw_capacity() which for a symmetric rd w/ a CPU capacity
> of SCHED_CAPACITY_SCALE simply relies on dl_bw_cpus() to return #CPUs
> multiplied by SCHED_CAPACITY_SCALE.
> 
> For an asymmetric rd or a CPU capacity < SCHED_CAPACITY_SCALE it
> computes the CPU capacity sum over rd span and cpu_active_mask.
> 
> A 'XXX Fix:' comment was added to highlight that if 'rq->rd ==
> def_root_domain' AC should be performed against the capacity of the
> CPU the task is running on rather the rd CPU capacity sum. This
> issue already exists w/o capacity awareness.
> 
> Signed-off-by: Dietmar Eggemann <dietmar.eggemann@arm.com>
> ---
>  kernel/sched/deadline.c | 33 +++++++++++++++++++++++++++++++++
>  1 file changed, 33 insertions(+)
> 
> diff --git a/kernel/sched/deadline.c b/kernel/sched/deadline.c
> index 4ae22bfc37ae..ea7282ce484c 100644
> --- a/kernel/sched/deadline.c
> +++ b/kernel/sched/deadline.c
> @@ -69,6 +69,34 @@ static inline int dl_bw_cpus(int i)
>  
>  	return cpus;
>  }
> +
> +static inline unsigned long __dl_bw_capacity(int i)
> +{
> +	struct root_domain *rd = cpu_rq(i)->rd;
> +	unsigned long cap = 0;
> +
> +	RCU_LOCKDEP_WARN(!rcu_read_lock_sched_held(),
> +			 "sched RCU must be held");
> +
> +	for_each_cpu_and(i, rd->span, cpu_active_mask)
> +		cap += capacity_orig_of(i);
> +
> +	return cap;
> +}
> +
> +/*
> + * XXX Fix: If 'rq->rd == def_root_domain' perform AC against capacity
> + * of the CPU the task is running on rather rd's \Sum CPU capacity.
> + */
> +static inline unsigned long dl_bw_capacity(int i)
> +{
> +	if (!static_branch_unlikely(&sched_asym_cpucapacity) &&
> +	    capacity_orig_of(i) == SCHED_CAPACITY_SCALE) {
> +		return dl_bw_cpus(i) << SCHED_CAPACITY_SHIFT;
> +	} else {
> +		return __dl_bw_capacity(i);
> +	}
> +}
>  #else
>  static inline struct dl_bw *dl_bw_of(int i)
>  {
> @@ -79,6 +107,11 @@ static inline int dl_bw_cpus(int i)
>  {
>  	return 1;
>  }
> +
> +static inline unsigned long dl_bw_capacity(int i)
> +{
> +	return SCHED_CAPACITY_SCALE;
> +}
>  #endif
>  
>  static inline
> -- 

Acked-by: Juri Lelli <juri.lelli@redhat.com>

