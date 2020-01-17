Return-Path: <SRS0=N8G3=3G=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 16341C33CB1
	for <linux-kernel@archiver.kernel.org>; Fri, 17 Jan 2020 13:23:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DAE0D206B7
	for <linux-kernel@archiver.kernel.org>; Fri, 17 Jan 2020 13:23:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="hMru0rew"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726982AbgAQNXF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 17 Jan 2020 08:23:05 -0500
Received: from mail-lf1-f66.google.com ([209.85.167.66]:35221 "EHLO
        mail-lf1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726890AbgAQNXE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Jan 2020 08:23:04 -0500
Received: by mail-lf1-f66.google.com with SMTP id 15so18349547lfr.2
        for <linux-kernel@vger.kernel.org>; Fri, 17 Jan 2020 05:23:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=zllgq5fb58Nvx/kXIr9DmmFUIHHhMyq6w8QbHcZulRQ=;
        b=hMru0rew5W2r2jg2z4ygnA+2adJe2C3UGBlUiG/O7/HRX7zIyJEgSlO55dzdgBHDui
         Je/k52NLVRYzq168+P9XWOhVjZauQ60nQ2YEkPNkCNySjPHuvGUBk7gqbI4hUGjT1uUu
         RQvVHCH0tn2BN6QekeerisZKKPEM63JcTcTU9znAe3Pzh242vIp8qh94TknHX/2A5ZEZ
         ji9URHs8yTObVvPsrsrmRGGZM0syfHM86zaJxNtmELMYkcw/pmbTDIif6Ful1pEKqHm9
         t1ilMST5RadIcRDMrL6+oVvXJVf+WKe4fGKpUGfalkEKzY82bb45RdQmX7FU44gADbaW
         Ys6Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=zllgq5fb58Nvx/kXIr9DmmFUIHHhMyq6w8QbHcZulRQ=;
        b=UIjOjlu42nUg8QEo4QJsagrAI8YBd+lAAS2JumVIHBb7ct22oppMECaNJG1mMPBbNr
         ou0KJS/G6JSrtG27WBC4SX/GtRcgf9Rck6Y3ueYtX+7+nEXLw2OTPRzrVlx2IFKUUaRM
         8VFM6l8PW5oOoyIVgpg1yq6RozYfqX5E50GcnURut9mJkXVwKbBBqRm6Lh3Bv5oNVMVl
         7w4jdC3nYbIGX1arWEAM7xUbeOevF+yi7ueUb5Kz99tOf+SFtkFgFdVJ+3hxhw7E3z90
         YYLqRLjuyai6RjaP4oD1Uhn06MIb6MOmGt96rbrv6QEVbv9B8X4dPrA6Jjzx4NNuYEzI
         yAlA==
X-Gm-Message-State: APjAAAU1N6V7K4eX2lHGT+1UByfVlIQZ6Mumth5lUywR7ZXi6258lRbT
        4uqkDmtT/CO6LaAdSDOSL1RSvNph3R7/FFvHHOoylg==
X-Google-Smtp-Source: APXvYqzKMgWI5/s9GyLPGL7GZ3SiZXmTtloBpF0cqWO7wNun6yjAi28v3zhsKzUzo6wOtG6SG4lY5wcU7n+ZASlioSU=
X-Received: by 2002:a19:114:: with SMTP id 20mr4907699lfb.25.1579267382341;
 Fri, 17 Jan 2020 05:23:02 -0800 (PST)
MIME-Version: 1.0
References: <1579031859-18692-1-git-send-email-thara.gopinath@linaro.org>
 <1579031859-18692-5-git-send-email-thara.gopinath@linaro.org> <20200116151502.GQ2827@hirez.programming.kicks-ass.net>
In-Reply-To: <20200116151502.GQ2827@hirez.programming.kicks-ass.net>
From:   Vincent Guittot <vincent.guittot@linaro.org>
Date:   Fri, 17 Jan 2020 14:22:51 +0100
Message-ID: <CAKfTPtA-M_APhGzwADhuwABzW_M5YKjm_ONGzQjFNRoJ+qYBmg@mail.gmail.com>
Subject: Re: [Patch v8 4/7] sched/fair: Enable periodic update of average
 thermal pressure
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     Thara Gopinath <thara.gopinath@linaro.org>,
        Ingo Molnar <mingo@redhat.com>,
        Ionela Voinescu <ionela.voinescu@arm.com>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Zhang Rui <rui.zhang@intel.com>,
        Quentin Perret <qperret@google.com>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        viresh kumar <viresh.kumar@linaro.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Amit Kachhap <amit.kachhap@gmail.com>,
        Javi Merino <javi.merino@kernel.org>,
        Amit Kucheria <amit.kucheria@verdurent.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 16 Jan 2020 at 16:15, Peter Zijlstra <peterz@infradead.org> wrote:
>
> On Tue, Jan 14, 2020 at 02:57:36PM -0500, Thara Gopinath wrote:
> > Introduce support in CFS periodic tick and other bookkeeping apis
> > to trigger the process of computing average thermal pressure for a
> > cpu. Also consider avg_thermal.load_avg in others_have_blocked
> > which allows for decay of pelt signals.
> >
> > Signed-off-by: Thara Gopinath <thara.gopinath@linaro.org>
> > ---
> >  kernel/sched/fair.c | 8 ++++++++
> >  1 file changed, 8 insertions(+)
> >
> > diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
> > index 8da0222..311bb0b 100644
> > --- a/kernel/sched/fair.c
> > +++ b/kernel/sched/fair.c
> > @@ -7470,6 +7470,9 @@ static inline bool others_have_blocked(struct rq *rq)
> >       if (READ_ONCE(rq->avg_dl.util_avg))
> >               return true;
> >
> > +     if (READ_ONCE(rq->avg_thermal.load_avg))
> > +             return true;
> > +
>
> Given that struct sched_avg is 1 cacheline, the above is a pointless
> guaranteed cacheline miss if the arch doesn't
> CONFIG_HAVE_SCHED_THERMAL_PRESSURE.
>
> >  #ifdef CONFIG_HAVE_SCHED_AVG_IRQ
> >       if (READ_ONCE(rq->avg_irq.util_avg))
> >               return true;
> > @@ -7495,6 +7498,7 @@ static bool __update_blocked_others(struct rq *rq, bool *done)
> >  {
> >       const struct sched_class *curr_class;
> >       u64 now = rq_clock_pelt(rq);
> > +     unsigned long thermal_pressure = arch_cpu_thermal_pressure(cpu_of(rq));
> >       bool decayed;
> >
> >       /*
> > @@ -7505,6 +7509,8 @@ static bool __update_blocked_others(struct rq *rq, bool *done)
> >
> >       decayed = update_rt_rq_load_avg(now, rq, curr_class == &rt_sched_class) |
> >                 update_dl_rq_load_avg(now, rq, curr_class == &dl_sched_class) |
> > +               update_thermal_load_avg(rq_clock_task(rq), rq,
> > +                                       thermal_pressure)                     |
> >                 update_irq_load_avg(rq, 0);
> >
> >       if (others_have_blocked(rq))
>
> That there indentation trainwreck is a reason to rename the function.
>
>         decayed = update_rt_rq_load_avg(now, rq, curr_class == &rt_sched_class) |
>                   update_dl_rq_load_avg(now, rq, curr_class == &dl_sched_class) |
>                   update_thermal_load_avg(rq_clock_task(rq), rq, thermal_pressure) |
>                   update_irq_load_avg(rq, 0);
>
> Is much better.
>
> But now that you made me look at that, I noticed it's using a different
> clock -- it is _NOT_ using now/rq_clock_pelt(), which means it'll not be
> in sync with the other averages.
>
> Is there a good reason for that?

We don't need to apply frequency and cpu capacity invariance on the
thermal capping signal which is  what rq_clock_pelt does

>
> > @@ -10275,6 +10281,7 @@ static void task_tick_fair(struct rq *rq, struct task_struct *curr, int queued)
> >  {
> >       struct cfs_rq *cfs_rq;
> >       struct sched_entity *se = &curr->se;
> > +     unsigned long thermal_pressure = arch_cpu_thermal_pressure(cpu_of(rq));
> >
> >       for_each_sched_entity(se) {
> >               cfs_rq = cfs_rq_of(se);
> > @@ -10286,6 +10293,7 @@ static void task_tick_fair(struct rq *rq, struct task_struct *curr, int queued)
> >
> >       update_misfit_status(curr, rq);
> >       update_overutilized_status(task_rq(curr));
> > +     update_thermal_load_avg(rq_clock_task(rq), rq, thermal_pressure);
> >  }
>
> I'm thinking this is the wrong place; should this not be in
> scheduler_tick(), right before calling sched_class::task_tick() ? Surely
> any execution will affect thermals, not only fair class execution.
