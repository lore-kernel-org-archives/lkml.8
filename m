Return-Path: <SRS0=Zbf8=4B=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 61212C2BA83
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Feb 2020 12:03:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2AA542168B
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Feb 2020 12:03:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="mlHcVq56"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729854AbgBMMDb (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 13 Feb 2020 07:03:31 -0500
Received: from mail-vs1-f67.google.com ([209.85.217.67]:39049 "EHLO
        mail-vs1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727059AbgBMMDb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Feb 2020 07:03:31 -0500
Received: by mail-vs1-f67.google.com with SMTP id p14so3395405vsq.6
        for <linux-kernel@vger.kernel.org>; Thu, 13 Feb 2020 04:03:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=AinNZlPOMPF7P0YnR4U5N+Ebr6M0cP3ykpfHfDAopbI=;
        b=mlHcVq56FKI+ndgu97XNmYJuqn3QSbAmKNF3b9evE3v/oCalo9ajzCWFVGznWpdnC6
         j13OcoKLM883n1YnfaXhpurEoq+TYWESewxM1+VRz4fjS/1PoawVeAnVSsNa+IhjMM5w
         VVc4FQVJSsLzb4/FsaoM5yRY8tBkZQpePPTUEzFv4d1YhtnV38Ipt8H69LG/I/KfPgGn
         zX44K3VSa8TR4iicDkKARnVswKCTtoQI1BeNbdIgKkaMASAssBcULpDOZ+qT7umWS+1G
         L1rfbx7E3f6EIKNQtHzjtsWlc/tM4XgG2zf/ZFtpe3vIuZt+JBjmiZrEf8DIfDlEFaNJ
         qeQg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=AinNZlPOMPF7P0YnR4U5N+Ebr6M0cP3ykpfHfDAopbI=;
        b=SZIojTjYbeGcEF1QmkPeZIBp+OwNxIozyxWuKv6g6B9pP780zCBvYYoaKMy41L3FFG
         zqLJ66Moim/teLugGGrHbN7lc1BJCD9DEArC62oBCLo4IHC4q/74GGC0oia4IKJU4EYd
         miuCbDKx8tIqSaBSrAQvqJJm3UdLkWFkyqjvMJ8hED1/hswH6DXFlu32LuyLI66wyKfT
         TGsI5U5811t52iZA+LHx4C7Xc6LPGUb6ZXCpp1D/Yvw7lTM5hNoSIzXOteKcevovYt9C
         rJ552loHsoi4pm+huq2XaA56+7oJsGmzLg8ZH3tZJjRg25ffn7VDBVdKky4MRmHadD0t
         bMOw==
X-Gm-Message-State: APjAAAW1Lfrn8ummLgnxLm8h+7BG3iCYRsc59c1gDXo+i3vi1EG9OUcz
        uGbTSJGLP1QfWjrXgsmnXagTNBFhVsDxFZoJaT1uJQ==
X-Google-Smtp-Source: APXvYqwT53lMA4Fq4gFiytjK/Zd4hQdPCKfP7xxnBSwyMIWTUjt7yz11yAjnx/1PCN6xXqCZwmJ117/R7gMdj3fTlJI=
X-Received: by 2002:a67:e99a:: with SMTP id b26mr1812709vso.27.1581595408046;
 Thu, 13 Feb 2020 04:03:28 -0800 (PST)
MIME-Version: 1.0
References: <1579031859-18692-1-git-send-email-thara.gopinath@linaro.org> <1579031859-18692-2-git-send-email-thara.gopinath@linaro.org>
In-Reply-To: <1579031859-18692-2-git-send-email-thara.gopinath@linaro.org>
From:   Amit Kucheria <amit.kucheria@linaro.org>
Date:   Thu, 13 Feb 2020 17:33:16 +0530
Message-ID: <CAHLCerNqu4feFX1DB8MJN2eKUd=Zt6VDCXDQjeE780AB75B+EQ@mail.gmail.com>
Subject: Re: [Patch v8 1/7] sched/pelt: Add support to track thermal pressure
To:     Thara Gopinath <thara.gopinath@linaro.org>
Cc:     Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>, ionela.voinescu@arm.com,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Zhang Rui <rui.zhang@intel.com>, qperret@google.com,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Viresh Kumar <viresh.kumar@linaro.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Amit Daniel Kachhap <amit.kachhap@gmail.com>,
        Javi Merino <javi.merino@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jan 15, 2020 at 1:27 AM Thara Gopinath
<thara.gopinath@linaro.org> wrote:
>
> Extrapolating on the existing framework to track rt/dl utilization using
> pelt signals, add a similar mechanism to track thermal pressure. The
> difference here from rt/dl utilization tracking is that, instead of
> tracking time spent by a cpu running a rt/dl task through util_avg, the
> average thermal pressure is tracked through load_avg. This is because
> thermal pressure signal is weighted "delta" capacity and is not
> binary(util_avg is binary). "delta capacity" here means delta between the
> actual capacity of a cpu and the decreased capacity a cpu due to a thermal
> event.
>
> In order to track average thermal pressure, a new sched_avg variable
> avg_thermal is introduced. Function update_thermal_load_avg can be called
> to do the periodic bookkeeping (accumulate, decay and average) of the
> thermal pressure.
>
> Signed-off-by: Thara Gopinath <thara.gopinath@linaro.org>
> Reviewed-by: Vincent Guittot <vincent.guittot@linaro.org>
> ---
>
> v6->v7:
>         - Added CONFIG_HAVE_SCHED_THERMAL_PRESSURE to stub out
>           update_thermal_load_avg in unsupported architectures as per
>           review comments from Peter, Dietmar and Quentin.
>         - Updated comment for update_thermal_load_avg as per review
>           comments from Peter and Dietmar.
> v7->v8:
>         - Fixed typo in defining update_thermal_load_avg which was
>           causing build errors (reported by kbuild test report)
>
>  include/trace/events/sched.h |  4 ++++
>  init/Kconfig                 |  4 ++++
>  kernel/sched/pelt.c          | 31 +++++++++++++++++++++++++++++++
>  kernel/sched/pelt.h          | 16 ++++++++++++++++
>  kernel/sched/sched.h         |  1 +
>  5 files changed, 56 insertions(+)
>
> diff --git a/include/trace/events/sched.h b/include/trace/events/sched.h
> index 420e80e..a8fb667 100644
> --- a/include/trace/events/sched.h
> +++ b/include/trace/events/sched.h
> @@ -613,6 +613,10 @@ DECLARE_TRACE(pelt_dl_tp,
>         TP_PROTO(struct rq *rq),
>         TP_ARGS(rq));
>
> +DECLARE_TRACE(pelt_thermal_tp,
> +       TP_PROTO(struct rq *rq),
> +       TP_ARGS(rq));
> +
>  DECLARE_TRACE(pelt_irq_tp,
>         TP_PROTO(struct rq *rq),
>         TP_ARGS(rq));
> diff --git a/init/Kconfig b/init/Kconfig
> index f6a4a91..c16ea88 100644
> --- a/init/Kconfig
> +++ b/init/Kconfig
> @@ -450,6 +450,10 @@ config HAVE_SCHED_AVG_IRQ
>         depends on IRQ_TIME_ACCOUNTING || PARAVIRT_TIME_ACCOUNTING
>         depends on SMP
>
> +config HAVE_SCHED_THERMAL_PRESSURE
> +       bool "Enable periodic averaging of thermal pressure"
> +       depends on SMP
> +
>  config BSD_PROCESS_ACCT
>         bool "BSD Process Accounting"
>         depends on MULTIUSER
> diff --git a/kernel/sched/pelt.c b/kernel/sched/pelt.c
> index bd006b7..5d1fbf0 100644
> --- a/kernel/sched/pelt.c
> +++ b/kernel/sched/pelt.c
> @@ -367,6 +367,37 @@ int update_dl_rq_load_avg(u64 now, struct rq *rq, int running)
>         return 0;
>  }
>
> +#ifdef CONFIG_HAVE_SCHED_THERMAL_PRESSURE
> +/*
> + * thermal:
> + *
> + *   load_sum = \Sum se->avg.load_sum but se->avg.load_sum is not tracked
> + *
> + *   util_avg and runnable_load_avg are not supported and meaningless.
> + *
> + * Unlike rt/dl utilization tracking that track time spent by a cpu
> + * running a rt/dl task through util_avg, the average thermal pressure is
> + * tracked through load_avg. This is because thermal pressure signal is
> + * weighted "delta" capacity and is not binary(util_avg is binary). "delta

May I suggest a slight rewording here and in the commit description,

   This is because the thermal pressure signal is weighted "delta"
capacity unlike util_avg which is binary.

It would also help, if you expanded on what you mean by binary in the
commit description and how the delta capacity is weighted.

> + * capacity" here means delta between the actual capacity of a cpu and the
> + * decreased capacity a cpu due to a thermal event.

This could be shortened to:

Delta capacity of cpu = Actual capacity - Decreased capacity due to
thermal event

> + */
> +
> +int update_thermal_load_avg(u64 now, struct rq *rq, u64 capacity)
> +{
> +       if (___update_load_sum(now, &rq->avg_thermal,
> +                              capacity,
> +                              capacity,
> +                              capacity)) {
> +               ___update_load_avg(&rq->avg_thermal, 1, 1);
> +               trace_pelt_thermal_tp(rq);
> +               return 1;
> +       }
> +
> +       return 0;
> +}
> +#endif
> +
>  #ifdef CONFIG_HAVE_SCHED_AVG_IRQ
>  /*
>   * irq:
> diff --git a/kernel/sched/pelt.h b/kernel/sched/pelt.h
> index afff644..bf1e17b 100644
> --- a/kernel/sched/pelt.h
> +++ b/kernel/sched/pelt.h
> @@ -7,6 +7,16 @@ int __update_load_avg_cfs_rq(u64 now, struct cfs_rq *cfs_rq);
>  int update_rt_rq_load_avg(u64 now, struct rq *rq, int running);
>  int update_dl_rq_load_avg(u64 now, struct rq *rq, int running);
>
> +#ifdef CONFIG_HAVE_SCHED_THERMAL_PRESSURE
> +int update_thermal_load_avg(u64 now, struct rq *rq, u64 capacity);
> +#else
> +static inline int
> +update_thermal_load_avg(u64 now, struct rq *rq, u64 capacity)
> +{
> +       return 0;
> +}
> +#endif
> +
>  #ifdef CONFIG_HAVE_SCHED_AVG_IRQ
>  int update_irq_load_avg(struct rq *rq, u64 running);
>  #else
> @@ -159,6 +169,12 @@ update_dl_rq_load_avg(u64 now, struct rq *rq, int running)
>  }
>
>  static inline int
> +update_thermal_load_avg(u64 now, struct rq *rq, u64 capacity)
> +{
> +       return 0;
> +}
> +
> +static inline int
>  update_irq_load_avg(struct rq *rq, u64 running)
>  {
>         return 0;
> diff --git a/kernel/sched/sched.h b/kernel/sched/sched.h
> index 280a3c7..37bd7ef 100644
> --- a/kernel/sched/sched.h
> +++ b/kernel/sched/sched.h
> @@ -944,6 +944,7 @@ struct rq {
>  #ifdef CONFIG_HAVE_SCHED_AVG_IRQ
>         struct sched_avg        avg_irq;
>  #endif
> +       struct sched_avg        avg_thermal;
>         u64                     idle_stamp;
>         u64                     avg_idle;
>
> --
> 2.1.4
>
