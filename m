Return-Path: <SRS0=Zbf8=4B=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.7 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 61740C2BA83
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Feb 2020 12:30:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2BDA8217F4
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Feb 2020 12:30:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=verdurent-com.20150623.gappssmtp.com header.i=@verdurent-com.20150623.gappssmtp.com header.b="A7lnflGx"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729911AbgBMMaI (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 13 Feb 2020 07:30:08 -0500
Received: from mail-vs1-f66.google.com ([209.85.217.66]:46941 "EHLO
        mail-vs1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729531AbgBMMaI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Feb 2020 07:30:08 -0500
Received: by mail-vs1-f66.google.com with SMTP id t12so3429868vso.13
        for <linux-kernel@vger.kernel.org>; Thu, 13 Feb 2020 04:30:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=verdurent-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=EZOpQ1PJkZ+dCWbPKJgvY1GJipZZjyyGhXZ1qG68CEU=;
        b=A7lnflGx3LufOzmX9xh9MuPNG4eHrBdPNuQ/gEsP+8pQTd5HAKRhN5Ynr8VN2ZnU2Z
         epw8lUGPgvGO8ZP3Wsg+QkugfyqyZFhVlxoKzfse2ajlWZAwfrt0T6NBFkLXGalOt1ES
         xFaAFZI+j4RN+uN94/NcKP9iWihXfzIfIfg0kw60Uo/vu9tMk4WN+sINWdwi00HCEdqQ
         +zeTpOd0yZCqEpd+1EXesF4+E9XzjKCKK8o8dZiWJwudpUBssw/KmpSgOCKvKAPu9ZSj
         vmsha1OOAA/sXlVsTt+tUsWhHsxCup5pOiV3lTWl7M8P4wEXilOR9I2UsptSNHWoxwHz
         u09g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=EZOpQ1PJkZ+dCWbPKJgvY1GJipZZjyyGhXZ1qG68CEU=;
        b=cUW09Qo+pviSiwll0MLTJitT+fDUamjxiqMgFSiTbQX9ibj3s4Pkt3o9z+HGfQf9BY
         Bh5v8YiUYNFGZdVnb5Aoc+OLGN9NL/ej93AOORL5NvQd+A8BGKKFPO8anxWvZNgkqFit
         kvgL9KT8Nwa9nHUYKNO9Tou7fzUb02sxrC1ZeFZdw2yL82U8VZvW3p2np6srxVVC80hb
         0DtHHsbsBGV0Fa2bISp8N/qhGlI02B/B/RUch3SN1m1gGkclZxH+EmI6agy68zecZqL1
         wKsKSZWNNgXxLKscCliAoKMK+/mpQvnkPA0j1EFBRbRDjkmpWgTUlutVlTHtzJUIxsdM
         kmDw==
X-Gm-Message-State: APjAAAVg1p7qjt0Lsh7PU3Df7//J9FGN6aYpW4mALOk5O9EYp1Ibteuo
        3U9BH+yQoOfRwEP/jJz+kld8uk3W47a08HPRQ2F1vw==
X-Google-Smtp-Source: APXvYqy0heCdZCFBtVTyvWxUcLAT3k+kRIMbiD17TRpUE1QQbDXzyN1OddLGfUryn0xIR+OLvcsV6VVnm4X+lkkzDMs=
X-Received: by 2002:a05:6102:535:: with SMTP id m21mr1780766vsa.95.1581597005286;
 Thu, 13 Feb 2020 04:30:05 -0800 (PST)
MIME-Version: 1.0
References: <1580250967-4386-1-git-send-email-thara.gopinath@linaro.org> <1580250967-4386-2-git-send-email-thara.gopinath@linaro.org>
In-Reply-To: <1580250967-4386-2-git-send-email-thara.gopinath@linaro.org>
From:   Amit Kucheria <amit.kucheria@verdurent.com>
Date:   Thu, 13 Feb 2020 17:59:54 +0530
Message-ID: <CAHLCerM9xi4BqmGhfzsq-BQ+gEhP3n70T=RvBrpriXiXChLebQ@mail.gmail.com>
Subject: Re: [Patch v9 1/8] sched/pelt: Add support to track thermal pressure
To:     Thara Gopinath <thara.gopinath@linaro.org>
Cc:     Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>, ionela.voinescu@arm.com,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Zhang Rui <rui.zhang@intel.com>, qperret@google.com,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Viresh Kumar <viresh.kumar@linaro.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Will Deacon <will@kernel.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Sudeep Holla <sudeep.holla@arm.com>,
        Juri Lelli <juri.lelli@redhat.com>, corbet@lwn.net,
        LKML <linux-kernel@vger.kernel.org>,
        Amit Daniel Kachhap <amit.kachhap@gmail.com>,
        Javi Merino <javi.merino@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jan 29, 2020 at 4:06 AM Thara Gopinath
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
> v8->v9:
>         - Defined thermal_load_avg to read rq->avg_thermal.load_avg and
>           avoid cacheline miss in unsupported cases as per Peter's
>           suggestion.
>
>  include/trace/events/sched.h |  4 ++++
>  init/Kconfig                 |  4 ++++
>  kernel/sched/pelt.c          | 31 +++++++++++++++++++++++++++++++
>  kernel/sched/pelt.h          | 31 +++++++++++++++++++++++++++++++
>  kernel/sched/sched.h         |  3 +++
>  5 files changed, 73 insertions(+)
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
> index bd9f1fd..055c3bf 100644
> --- a/init/Kconfig
> +++ b/init/Kconfig
> @@ -463,6 +463,10 @@ config HAVE_SCHED_AVG_IRQ
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

Use consistent wording throughout the series - either capped or
decreased capacity.

> + */

This could be shortened to:

Delta capacity of cpu = Actual capacity - Capped capacity due to thermal event

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
> index afff644..916979a 100644
> --- a/kernel/sched/pelt.h
> +++ b/kernel/sched/pelt.h
> @@ -7,6 +7,26 @@ int __update_load_avg_cfs_rq(u64 now, struct cfs_rq *cfs_rq);
>  int update_rt_rq_load_avg(u64 now, struct rq *rq, int running);
>  int update_dl_rq_load_avg(u64 now, struct rq *rq, int running);
>
> +#ifdef CONFIG_HAVE_SCHED_THERMAL_PRESSURE
> +int update_thermal_load_avg(u64 now, struct rq *rq, u64 capacity);
> +
> +static inline u64 thermal_load_avg(struct rq *rq)
> +{
> +       return READ_ONCE(rq->avg_thermal.load_avg);
> +}
> +#else
> +static inline int
> +update_thermal_load_avg(u64 now, struct rq *rq, u64 capacity)
> +{
> +       return 0;
> +}
> +
> +static inline u64 thermal_load_avg(struct rq *rq)
> +{
> +       return 0;
> +}
> +#endif
> +
>  #ifdef CONFIG_HAVE_SCHED_AVG_IRQ
>  int update_irq_load_avg(struct rq *rq, u64 running);
>  #else
> @@ -159,6 +179,17 @@ update_dl_rq_load_avg(u64 now, struct rq *rq, int running)
>  }
>
>  static inline int
> +update_thermal_load_avg(u64 now, struct rq *rq, u64 capacity)
> +{
> +       return 0;
> +}
> +
> +static inline u64 thermal_load_avg(struct rq *rq)
> +{
> +       return 0;
> +}
> +
> +static inline int
>  update_irq_load_avg(struct rq *rq, u64 running)
>  {
>         return 0;
> diff --git a/kernel/sched/sched.h b/kernel/sched/sched.h
> index 1a88dc8..1f256cb 100644
> --- a/kernel/sched/sched.h
> +++ b/kernel/sched/sched.h
> @@ -944,6 +944,9 @@ struct rq {
>  #ifdef CONFIG_HAVE_SCHED_AVG_IRQ
>         struct sched_avg        avg_irq;
>  #endif
> +#ifdef CONFIG_HAVE_SCHED_THERMAL_PRESSURE
> +       struct sched_avg        avg_thermal;
> +#endif
>         u64                     idle_stamp;
>         u64                     avg_idle;
>
> --
> 2.1.4
>
