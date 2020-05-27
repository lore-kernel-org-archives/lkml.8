Return-Path: <SRS0=UR55=7J=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLACK,URIBL_BLOCKED autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9E89DC433E0
	for <linux-kernel@archiver.kernel.org>; Wed, 27 May 2020 10:23:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7A353207CB
	for <linux-kernel@archiver.kernel.org>; Wed, 27 May 2020 10:23:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="oJ+4hU+1"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729798AbgE0KXh (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 27 May 2020 06:23:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34488 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729781AbgE0KXh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 May 2020 06:23:37 -0400
Received: from mail-lf1-x142.google.com (mail-lf1-x142.google.com [IPv6:2a00:1450:4864:20::142])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DA425C061A0F
        for <linux-kernel@vger.kernel.org>; Wed, 27 May 2020 03:23:36 -0700 (PDT)
Received: by mail-lf1-x142.google.com with SMTP id d7so2976448lfi.12
        for <linux-kernel@vger.kernel.org>; Wed, 27 May 2020 03:23:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=ngqDXpFcRXHKFoG+x5fAGamcSPI53olUIMOUNpy9SEU=;
        b=oJ+4hU+1wTPPvY4iQBNlCbb79oQPqTCh8MYp7A8+SzSebQYn7zo7SHcPB8MGe51+47
         tgWjq0BnioB4aUxjuR+6MdSd67y8HvUt47+Gp6YYXvxcn9uaU6l5Zm30aB8E5dnRl5Q7
         fILLvvneDP14TWjwez1OnPWdEHLZy8p3HswQB498DHIZtGkUOAtzSLzL5CEWM/3t7+wm
         5lN2Nt5s+N1sym3h269rxeqW/h5ManntNf0Izht98rmQRe5cU1Egu0hQZE4XbuP/6X76
         /9om3BUCHBQHKLBU80JvnGyoUZuuZwmOwYxSOLzE7wXIXUjZJ9qTPV2+VCmcS+q4HyrB
         kc0w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=ngqDXpFcRXHKFoG+x5fAGamcSPI53olUIMOUNpy9SEU=;
        b=O7xrdQ8wpK1yG94rM+RyFJahNcb9lQ0KCQcgg1HETr7ElUJDqwzX1reffh4BAaogsS
         cfh+o92rxgxOoKz+nKKjmPoc0AYqoQvHQxuaZ4WZeX2sKGJQxEoiG3zTd+h85rrTHqAe
         Ypcq7bBL2S5Ik6OMwVkrLjQJILD4p2cct9Ywv4jiZsjXSXDC50ogrChu7TWF64eT0v6H
         JFw1eJgwkjYBOqDdTwj95VywuEp+8Kf33pZ3IxuAHI1IZXvYcNtKVdhFRvJr07N6ngbU
         DlXHOG8ezexGnv1v4FZ0JVIKIRXbW6g1CD5hUNQtdhg8MbQb5j/iP02eTnVfSQY55u7h
         Tcyg==
X-Gm-Message-State: AOAM531xnBSc55JPkAEVDygvS2/LuUNhxMgJ7d8/6MBEMhSykqN/e1u1
        ahvHQJpUQ6P3lMiyWuXI2ajmqeMbuHogdjSJqhn04Q==
X-Google-Smtp-Source: ABdhPJwOX+mWeQUL5k3W2EGVDjgqHENxwLUUUlsy3SsiKQ2i0GXQR8sBN8YbtoXhot2SjRLoyt53WlJ+JlGfudnVbck=
X-Received: by 2002:a19:2250:: with SMTP id i77mr2829922lfi.133.1590575015298;
 Wed, 27 May 2020 03:23:35 -0700 (PDT)
MIME-Version: 1.0
References: <20200526161057.531933155@infradead.org> <20200526161907.778543557@infradead.org>
In-Reply-To: <20200526161907.778543557@infradead.org>
From:   Vincent Guittot <vincent.guittot@linaro.org>
Date:   Wed, 27 May 2020 12:23:23 +0200
Message-ID: <CAKfTPtA6t5=Gc6cWR3iS9QL+Vy=jhUkP345V9q2xqyhHx=rGNQ@mail.gmail.com>
Subject: Re: [RFC][PATCH 1/7] sched: Fix smp_call_function_single_async()
 usage for ILB
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     Thomas Gleixner <tglx@linutronix.de>, frederic@kernel.org,
        linux-kernel <linux-kernel@vger.kernel.org>,
        x86 <x86@kernel.org>, Qian Cai <cai@lca.pw>,
        Mel Gorman <mgorman@techsingularity.net>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 26 May 2020 at 18:19, Peter Zijlstra <peterz@infradead.org> wrote:
>
> The recent commit: 90b5363acd47 ("sched: Clean up scheduler_ipi()")
> got smp_call_function_single_async() subtly wrong. Even though it will
> return -EBUSY when trying to re-use a csd, that condition is not
> atomic and still requires external serialization.
>
> The change in kick_ilb() got this wrong.
>
> While on first reading kick_ilb() has an atomic test-and-set that
> appears to serialize the use, the matching 'release' is not in the
> right place to actually guarantee this serialization.
>
> Rework the nohz_idle_balance() trigger so that the release is in the
> IPI callback and thus guarantees the required serialization for the
> CSD.
>
> Fixes: 90b5363acd47 ("sched: Clean up scheduler_ipi()")
> Reported-by: Qian Cai <cai@lca.pw>
> Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>

Reviewed-by: Vincent Guittot <vincent.guittot@linaro.org>

> ---
>  include/linux/sched.h      |    4 +
>  include/linux/sched/idle.h |   55 ++++++++++++++++++
>  kernel/sched/core.c        |  132 +++++++++------------------------------------
>  kernel/sched/fair.c        |   18 ++----
>  kernel/sched/idle.c        |    3 -
>  kernel/sched/sched.h       |    2
>  kernel/smp.c               |    7 ++
>  7 files changed, 102 insertions(+), 119 deletions(-)
>
> --- a/kernel/sched/core.c
> +++ b/kernel/sched/core.c
> @@ -637,41 +568,25 @@ void wake_up_nohz_cpu(int cpu)
>                 wake_up_idle_cpu(cpu);
>  }
>
> -static inline bool got_nohz_idle_kick(void)
> +static void nohz_csd_func(void *info)
>  {
> -       int cpu = smp_processor_id();
> -
> -       if (!(atomic_read(nohz_flags(cpu)) & NOHZ_KICK_MASK))
> -               return false;
> -
> -       if (idle_cpu(cpu) && !need_resched())
> -               return true;
> +       struct rq *rq = info;
> +       int cpu = cpu_of(rq);
> +       unsigned int flags;
>
>         /*
> -        * We can't run Idle Load Balance on this CPU for this time so we
> -        * cancel it and clear NOHZ_BALANCE_KICK
> +        * Release the rq::nohz_csd.
>          */
> -       atomic_andnot(NOHZ_KICK_MASK, nohz_flags(cpu));
> -       return false;
> -}
> -
> -static void nohz_csd_func(void *info)
> -{
> -       struct rq *rq = info;
> +       flags = atomic_fetch_andnot(NOHZ_KICK_MASK, nohz_flags(cpu));

Why can't this be done in nohz_idle_balance() instead ?

you are not using flags in nohz_csd_func() and SCHED_SOFTIRQ which
calls nohz_idle_balance(), happens after nohz_csd_func(), isn't it ?

In this case, you don't have to use the intermediate variable
this_rq->nohz_idle_balance


> +       WARN_ON(!(flags & NOHZ_KICK_MASK));
>
> -       if (got_nohz_idle_kick()) {
> -               rq->idle_balance = 1;
> +       rq->idle_balance = idle_cpu(cpu);
> +       if (rq->idle_balance && !need_resched()) {
> +               rq->nohz_idle_balance = flags;
>                 raise_softirq_irqoff(SCHED_SOFTIRQ);
>         }
>  }
>
> -#else /* CONFIG_NO_HZ_COMMON */
> -
> -static inline bool got_nohz_idle_kick(void)
> -{
> -       return false;
> -}
> -
>  #endif /* CONFIG_NO_HZ_COMMON */
>
>  #ifdef CONFIG_NO_HZ_FULL
> --- a/kernel/sched/fair.c
> +++ b/kernel/sched/fair.c
> @@ -10024,6 +10024,10 @@ static void kick_ilb(unsigned int flags)
>         if (ilb_cpu >= nr_cpu_ids)
>                 return;
>
> +       /*
> +        * Access to rq::nohz_csd is serialized by NOHZ_KICK_MASK; he who sets
> +        * the first flag owns it; cleared by nohz_csd_func().
> +        */
>         flags = atomic_fetch_or(flags, nohz_flags(ilb_cpu));
>         if (flags & NOHZ_KICK_MASK)
>                 return;
> @@ -10371,20 +10375,14 @@ static bool _nohz_idle_balance(struct rq
>   */
>  static bool nohz_idle_balance(struct rq *this_rq, enum cpu_idle_type idle)
>  {
> -       int this_cpu = this_rq->cpu;
> -       unsigned int flags;
> +       unsigned int flags = this_rq->nohz_idle_balance;
>
> -       if (!(atomic_read(nohz_flags(this_cpu)) & NOHZ_KICK_MASK))
> +       if (!flags)
>                 return false;
>
> -       if (idle != CPU_IDLE) {
> -               atomic_andnot(NOHZ_KICK_MASK, nohz_flags(this_cpu));
> -               return false;
> -       }
> +       this_rq->nohz_idle_balance = 0;
>
> -       /* could be _relaxed() */
> -       flags = atomic_fetch_andnot(NOHZ_KICK_MASK, nohz_flags(this_cpu));
> -       if (!(flags & NOHZ_KICK_MASK))
> +       if (idle != CPU_IDLE)
>                 return false;
>
>         _nohz_idle_balance(this_rq, flags, idle);
> --- a/kernel/sched/sched.h
> +++ b/kernel/sched/sched.h
> @@ -951,6 +951,7 @@ struct rq {
>
>         struct callback_head    *balance_callback;
>
> +       unsigned char           nohz_idle_balance;
>         unsigned char           idle_balance;
>
>         unsigned long           misfit_task_load;
>
>
