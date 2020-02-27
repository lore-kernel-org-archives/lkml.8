Return-Path: <SRS0=BMk7=4P=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 824E8C4BA24
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Feb 2020 09:03:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 59A9324672
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Feb 2020 09:03:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=verdurent-com.20150623.gappssmtp.com header.i=@verdurent-com.20150623.gappssmtp.com header.b="LE+vE3N3"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728760AbgB0JDP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 27 Feb 2020 04:03:15 -0500
Received: from mail-vk1-f193.google.com ([209.85.221.193]:44680 "EHLO
        mail-vk1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728464AbgB0JDO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Feb 2020 04:03:14 -0500
Received: by mail-vk1-f193.google.com with SMTP id x62so513027vkg.11
        for <linux-kernel@vger.kernel.org>; Thu, 27 Feb 2020 01:03:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=verdurent-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=xlBXz/I3y1DVeHcgLwW/RjYI7dU6kY1tZBKMT3/lG1E=;
        b=LE+vE3N3S+gbAaAfC3Vfv+H9+noQ20DPexyV4aaqLuiY4PpXFfEsCJc5aH+gZfzmpa
         i4v4NvRggZMtHweKbDYdnWASzvLok+G0TVSNJ6CQUC+4Klw+/fpQ3aBO0DdUerubSjGB
         mZSH0p6/3LXLuH7LzxFE1VHUA9nrHdU6Axn95gljr8Lcjq2lvV9NGIkSPg7CLGxxgJ+w
         Wy+d7HE2dcI1FIBYgveCcej6Z6wQzBVoNKg0XkUvujt3iiqktKjDgLqd36xF1hSAxufi
         Tj4t8lsOqMAl/Q84F9CBh1AoHJ0LmefhX8R8v9DU7OxRpRtf/p3sxHUcWi0Cvi1fZ3ul
         blMw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=xlBXz/I3y1DVeHcgLwW/RjYI7dU6kY1tZBKMT3/lG1E=;
        b=qa9UD38jLEZ2yG0u79bDlbynbqLxwe+BjF3Yzsi8PaSRqMp47f9cW+RBxBrZbYFa3S
         zatXX7tqcaxrOX9zJEtLp88OurMe0LZcOwYWofWx8Ru1FaEc2OxHRo2oaDs1HzSCi0Dl
         nMh86sDqOxCzjnJdfxvtkobv1gl3+LL/kpvxQo3tORNIYZ9pEamV/P4C7esrUswEN4ke
         W/37YvzI7Z6AECS3pzueXmjPtUmQXSsf4YcwYjm/fl5Lz3UGPdmKF6kVUWR9+NUNFHdl
         GBYopXwavHCBc5Kowli2W7gv182mFLlY/qIFh4+DRO2Dh0JtIbCIAHMLJxZ2FGnjA1L0
         qUSg==
X-Gm-Message-State: APjAAAV8lj0gqEa82HAYrnym7uR6lydBBsIMOh7RRcXdxii5er19QzDY
        wmhFtWIB9vI4BmaXxaYEvFei2RzsFfis04xEnak1cg==
X-Google-Smtp-Source: APXvYqzGDQrLZWo6G8So0bF7sp3/szPgKEW2F1KhYNwOPm1NXJ7sLpPlEQJTWknoNa7ZXrCkZEQ3oFY0Qi7o3cIh29I=
X-Received: by 2002:ac5:c7a9:: with SMTP id d9mr2057624vkn.79.1582794192622;
 Thu, 27 Feb 2020 01:03:12 -0800 (PST)
MIME-Version: 1.0
References: <20200222005213.3873-1-thara.gopinath@linaro.org> <20200222005213.3873-7-thara.gopinath@linaro.org>
In-Reply-To: <20200222005213.3873-7-thara.gopinath@linaro.org>
From:   Amit Kucheria <amit.kucheria@verdurent.com>
Date:   Thu, 27 Feb 2020 14:33:01 +0530
Message-ID: <CAHLCerNWYHSE=0m_AqH2UY6gKvK7EV64JaZxnLC_TufNrO7ZBg@mail.gmail.com>
Subject: Re: [Patch v10 6/9] sched/fair: Enable periodic update of average
 thermal pressure
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
        Juri Lelli <juri.lelli@redhat.com>,
        Jonathan Corbet <corbet@lwn.net>,
        LKML <linux-kernel@vger.kernel.org>,
        Amit Daniel Kachhap <amit.kachhap@gmail.com>,
        Javi Merino <javi.merino@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Feb 22, 2020 at 6:22 AM Thara Gopinath
<thara.gopinath@linaro.org> wrote:
>
> Introduce support in scheduler periodic tick and other CFS bookkeeping
> apis to trigger the process of computing average thermal pressure for a
> cpu. Also consider avg_thermal.load_avg in others_have_blocked which
> allows for decay of pelt signals.
>
> Signed-off-by: Thara Gopinath <thara.gopinath@linaro.org>
> ---
> v8->v9:
>         - Moved periodic triggering of thermal pressure averaging from CFS
>           tick function to generic scheduler core tick function as per
>           Peter's review comments.
>
>  kernel/sched/core.c | 3 +++
>  kernel/sched/fair.c | 7 +++++++
>  2 files changed, 10 insertions(+)

Hi Thara,

This patch has a fuzz while applying to v5.6-rc2. Just FYI.

Regards,
Amit


>
> diff --git a/kernel/sched/core.c b/kernel/sched/core.c
> index e94819d573be..160b5e9e8945 100644
> --- a/kernel/sched/core.c
> +++ b/kernel/sched/core.c
> @@ -3588,6 +3588,7 @@ void scheduler_tick(void)
>         struct rq *rq = cpu_rq(cpu);
>         struct task_struct *curr = rq->curr;
>         struct rq_flags rf;
> +       unsigned long thermal_pressure;
>
>         arch_scale_freq_tick();
>         sched_clock_tick();
> @@ -3595,6 +3596,8 @@ void scheduler_tick(void)
>         rq_lock(rq, &rf);
>
>         update_rq_clock(rq);
> +       thermal_pressure = arch_scale_thermal_pressure(cpu_of(rq));
> +       update_thermal_load_avg(rq_clock_task(rq), rq, thermal_pressure);
>         curr->sched_class->task_tick(rq, curr, 0);
>         calc_global_load_tick(rq);
>         psi_task_tick(rq);
> diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
> index f38ff5a335d3..00b21a5b71f0 100644
> --- a/kernel/sched/fair.c
> +++ b/kernel/sched/fair.c
> @@ -7536,6 +7536,9 @@ static inline bool others_have_blocked(struct rq *rq)
>         if (READ_ONCE(rq->avg_dl.util_avg))
>                 return true;
>
> +       if (thermal_load_avg(rq))
> +               return true;
> +
>  #ifdef CONFIG_HAVE_SCHED_AVG_IRQ
>         if (READ_ONCE(rq->avg_irq.util_avg))
>                 return true;
> @@ -7561,6 +7564,7 @@ static bool __update_blocked_others(struct rq *rq, bool *done)
>  {
>         const struct sched_class *curr_class;
>         u64 now = rq_clock_pelt(rq);
> +       unsigned long thermal_pressure;
>         bool decayed;
>
>         /*
> @@ -7569,8 +7573,11 @@ static bool __update_blocked_others(struct rq *rq, bool *done)
>          */
>         curr_class = rq->curr->sched_class;
>
> +       thermal_pressure = arch_scale_thermal_pressure(cpu_of(rq));
> +
>         decayed = update_rt_rq_load_avg(now, rq, curr_class == &rt_sched_class) |
>                   update_dl_rq_load_avg(now, rq, curr_class == &dl_sched_class) |
> +                 update_thermal_load_avg(rq_clock_task(rq), rq, thermal_pressure) |
>                   update_irq_load_avg(rq, 0);
>
>         if (others_have_blocked(rq))
> --
> 2.20.1
>
