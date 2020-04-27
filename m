Return-Path: <SRS0=jv8X=6L=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 40291C54FD0
	for <linux-kernel@archiver.kernel.org>; Mon, 27 Apr 2020 13:34:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1CA5320663
	for <linux-kernel@archiver.kernel.org>; Mon, 27 Apr 2020 13:34:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="eWsiqAfD"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727117AbgD0Neq (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 27 Apr 2020 09:34:46 -0400
Received: from us-smtp-1.mimecast.com ([205.139.110.61]:36938 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726651AbgD0Nep (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Apr 2020 09:34:45 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1587994484;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=hCIx+uylxDiIkQIo7KO6BB1dE1p8+oU0uTFZQetsf50=;
        b=eWsiqAfDllpkf3sf9ed5i7DugdqymnPVy+H/HG6LZNeekaj5Ata8ZqSeWaC7DLTKQQVVZq
        domXIMbGtScEa1ErcRYEP4R044KQz+y5YoTF+gQlfr8DKVqpR04rCf58L9wP6mRd4mUx3+
        O47rKjolGj96UTIyftEO1hiwqVDSKNA=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-394-7plCh5oWNpCIucYQSc93jQ-1; Mon, 27 Apr 2020 09:34:43 -0400
X-MC-Unique: 7plCh5oWNpCIucYQSc93jQ-1
Received: by mail-wm1-f70.google.com with SMTP id 72so21444wmb.1
        for <linux-kernel@vger.kernel.org>; Mon, 27 Apr 2020 06:34:42 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=hCIx+uylxDiIkQIo7KO6BB1dE1p8+oU0uTFZQetsf50=;
        b=Xvh3D8bjhkbMZgU2S+5rgcZX5YVo+uMyOKg5ipZaNiD+KWVqa1m7bJkxRWYblfTHXi
         SiKmsQFPt4U8UqjlAi4IeRjFrk1J1Wd8mumObK6VwgiHp8Mxgeaq4D4iZRm+gJbrZrl4
         aTSSr4h8SGxXodgqBA07uzRMpaTlMIQRdjpsBh+HGVuDeCFU5Ufh1Ju3QYjxJCraJ5Qi
         YBh0aR6Jqa0VJ8lBbxIivQBuRu8vTCqcAsx1RPtaVSdZOVTaIAwRY8EcILXx9sN4OSK0
         84Dw6bi6ypScDo0Rmwj/vjd0G7pItZIOiGp3mJpoSX2vFpbYEvTxPv7KyEc3VleuYMii
         3vbA==
X-Gm-Message-State: AGi0Pub0HiH6V8nL7udPOVsEOTxD0/R6xTEiVd8+c5f/rQx/aopQLtTB
        zZomg+x2hjushX+ywlenCmI474FwjRCWUvSqzeQzbszAaK+Bz4T2Vx0i40z5iG+OTaZO8uLtD1P
        lSM2by4MjqKz4L41/lMwCn6L4
X-Received: by 2002:a1c:2383:: with SMTP id j125mr25781800wmj.6.1587994481714;
        Mon, 27 Apr 2020 06:34:41 -0700 (PDT)
X-Google-Smtp-Source: APiQypL/8fhnPF6uJTxPIAxQKuM5Wu3I9kgqbQ/J1LPwGYsrrgrO5zSWZlrzHK/Fh7Awiw8Gd/wlfA==
X-Received: by 2002:a1c:2383:: with SMTP id j125mr25781773wmj.6.1587994481373;
        Mon, 27 Apr 2020 06:34:41 -0700 (PDT)
Received: from localhost.localdomain ([151.29.194.179])
        by smtp.gmail.com with ESMTPSA id r3sm22287559wrx.72.2020.04.27.06.34.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 27 Apr 2020 06:34:40 -0700 (PDT)
Date:   Mon, 27 Apr 2020 15:34:38 +0200
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
Subject: Re: [PATCH v2 6/6] sched/deadline: Implement fallback mechanism for
 !fit case
Message-ID: <20200427133438.GA6469@localhost.localdomain>
References: <20200427083709.30262-1-dietmar.eggemann@arm.com>
 <20200427083709.30262-7-dietmar.eggemann@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200427083709.30262-7-dietmar.eggemann@arm.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On 27/04/20 10:37, Dietmar Eggemann wrote:
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
>  kernel/sched/cpudeadline.c | 19 +++++++++++++++----
>  1 file changed, 15 insertions(+), 4 deletions(-)
> 
> diff --git a/kernel/sched/cpudeadline.c b/kernel/sched/cpudeadline.c
> index 8630f2a40a3f..b6c7a0bc0880 100644
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
> +				cap = capacity_orig_of(cpu);
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

Think we touched upon this during v1 review, but I'm (still?) wondering
if we can do a little better, still considering only free cpus.

Can't we get into a situation that some of the (once free) big cpus have
been occupied by small tasks and now a big task enters the system and it
only finds small cpus available, were it could have fit into bigs if
small tasks were put onto small cpus?

I.e., shouldn't we always try to best fit among free cpus?

Thanks,

Juri

