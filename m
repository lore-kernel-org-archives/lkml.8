Return-Path: <SRS0=Zbf8=4B=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 500C8C2BA83
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Feb 2020 12:31:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 186BA218AC
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Feb 2020 12:31:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="N9bYgcsD"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729931AbgBMMb1 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 13 Feb 2020 07:31:27 -0500
Received: from mail-vs1-f67.google.com ([209.85.217.67]:40471 "EHLO
        mail-vs1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729531AbgBMMb0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Feb 2020 07:31:26 -0500
Received: by mail-vs1-f67.google.com with SMTP id c18so3439161vsq.7
        for <linux-kernel@vger.kernel.org>; Thu, 13 Feb 2020 04:31:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=91Du8YsM0/9IzYNh4jnrkOUwL/byVUy2Gt9fOKH3nc0=;
        b=N9bYgcsDB8jM1fgLYqR6Z3vmQtHMF7tkw0A9ecbCMS4L3hhp+8fnIXWiDMILlNLz+6
         D1d+QqfP10dE9KVQGkF7CVRz3gLVCHQl5MNdmIyrdwAcnhzvY2M/zo/x/1RoXeadgqiL
         p6S3q2Lu/pjM673J2MUBmBNANlLC2wYWg9qV+jOJX0AlBs7zp8m+LA7H4wRfbTke/bZ6
         QY7JGVMLNjJE82jE4vKX2jkRL/7fR1qyjhl8zdudX4EoNXPupTAUofEfQISiSERddNoI
         TgQNwDBShfqSEnzZaITSflsSB7X54LbhZpSDpFbH0UKSPYb06naufDB+YzNVIrodJJ9j
         1OYg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=91Du8YsM0/9IzYNh4jnrkOUwL/byVUy2Gt9fOKH3nc0=;
        b=DbaaLnrO9sPMvSLAZQXlN8kpuUgKdLEIWZOQIwl35/6caYB6308YWkwU/yrN+a3k+C
         /nET8vskGtxqj+JtdbxikkV/U+SHiim32qQf74qeyA5SMBdyZGUN29qSv5Y/QxxG6tSk
         GgIvZbEimDvc3R8kccz5uIyNABwpFYdVOy8BHpG8QInYnmMQKjKeSJPLRiBVWV++SLb1
         +KMfAiLxJg6afb6Fp82eKX2ZSiOo1ngFJDNcN458noWx4ATd3E76HveZKv3+0vtkDq35
         xb3nRMeI4S4gb1GDrf+xWLmp84+HsXcJkk9xw/nwHrzyCrEDLEEwPWOXjSGHT68qMF/x
         T40g==
X-Gm-Message-State: APjAAAWrPzFR3zdmugWdHavA0WnCMU0RiEwlOY543GCs0xGD+Skr+7dV
        K3211yOBeoT5U3hMpozABgwjVcoFBopwWzGcTd6mMQ==
X-Google-Smtp-Source: APXvYqyOmbQSsN78HKwOc0Zkl4CZ8J0BJCeU5qkukMFncil53td3aKnsQbFGLdg/M9H55POCeXS+zImTaFTCKvO1Mi8=
X-Received: by 2002:a05:6102:535:: with SMTP id m21mr1783762vsa.95.1581597085131;
 Thu, 13 Feb 2020 04:31:25 -0800 (PST)
MIME-Version: 1.0
References: <1579031859-18692-1-git-send-email-thara.gopinath@linaro.org>
 <1579031859-18692-2-git-send-email-thara.gopinath@linaro.org> <CAHLCerNqu4feFX1DB8MJN2eKUd=Zt6VDCXDQjeE780AB75B+EQ@mail.gmail.com>
In-Reply-To: <CAHLCerNqu4feFX1DB8MJN2eKUd=Zt6VDCXDQjeE780AB75B+EQ@mail.gmail.com>
From:   Amit Kucheria <amit.kucheria@linaro.org>
Date:   Thu, 13 Feb 2020 18:01:14 +0530
Message-ID: <CAHLCerNRZSEFYGH-QviH5ESuqeQ7sHm+-cvK+UD3ffj7aRJHUw@mail.gmail.com>
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

On Thu, Feb 13, 2020 at 5:33 PM Amit Kucheria <amit.kucheria@linaro.org> wrote:
>
> On Wed, Jan 15, 2020 at 1:27 AM Thara Gopinath
> <thara.gopinath@linaro.org> wrote:
> >
> > Extrapolating on the existing framework to track rt/dl utilization using
> > pelt signals, add a similar mechanism to track thermal pressure. The
> > difference here from rt/dl utilization tracking is that, instead of
> > tracking time spent by a cpu running a rt/dl task through util_avg, the
> > average thermal pressure is tracked through load_avg. This is because
> > thermal pressure signal is weighted "delta" capacity and is not
> > binary(util_avg is binary). "delta capacity" here means delta between the
> > actual capacity of a cpu and the decreased capacity a cpu due to a thermal
> > event.
> >
> > In order to track average thermal pressure, a new sched_avg variable
> > avg_thermal is introduced. Function update_thermal_load_avg can be called
> > to do the periodic bookkeeping (accumulate, decay and average) of the
> > thermal pressure.
> >
> > Signed-off-by: Thara Gopinath <thara.gopinath@linaro.org>
> > Reviewed-by: Vincent Guittot <vincent.guittot@linaro.org>
> > ---
> >
> > v6->v7:
> >         - Added CONFIG_HAVE_SCHED_THERMAL_PRESSURE to stub out
> >           update_thermal_load_avg in unsupported architectures as per
> >           review comments from Peter, Dietmar and Quentin.
> >         - Updated comment for update_thermal_load_avg as per review
> >           comments from Peter and Dietmar.
> > v7->v8:
> >         - Fixed typo in defining update_thermal_load_avg which was
> >           causing build errors (reported by kbuild test report)
> >
> >  include/trace/events/sched.h |  4 ++++
> >  init/Kconfig                 |  4 ++++
> >  kernel/sched/pelt.c          | 31 +++++++++++++++++++++++++++++++
> >  kernel/sched/pelt.h          | 16 ++++++++++++++++
> >  kernel/sched/sched.h         |  1 +
> >  5 files changed, 56 insertions(+)
> >
> > diff --git a/include/trace/events/sched.h b/include/trace/events/sched.h
> > index 420e80e..a8fb667 100644
> > --- a/include/trace/events/sched.h
> > +++ b/include/trace/events/sched.h
> > @@ -613,6 +613,10 @@ DECLARE_TRACE(pelt_dl_tp,
> >         TP_PROTO(struct rq *rq),
> >         TP_ARGS(rq));
> >
> > +DECLARE_TRACE(pelt_thermal_tp,
> > +       TP_PROTO(struct rq *rq),
> > +       TP_ARGS(rq));
> > +
> >  DECLARE_TRACE(pelt_irq_tp,
> >         TP_PROTO(struct rq *rq),
> >         TP_ARGS(rq));
> > diff --git a/init/Kconfig b/init/Kconfig
> > index f6a4a91..c16ea88 100644
> > --- a/init/Kconfig
> > +++ b/init/Kconfig
> > @@ -450,6 +450,10 @@ config HAVE_SCHED_AVG_IRQ
> >         depends on IRQ_TIME_ACCOUNTING || PARAVIRT_TIME_ACCOUNTING
> >         depends on SMP
> >
> > +config HAVE_SCHED_THERMAL_PRESSURE
> > +       bool "Enable periodic averaging of thermal pressure"
> > +       depends on SMP
> > +
> >  config BSD_PROCESS_ACCT
> >         bool "BSD Process Accounting"
> >         depends on MULTIUSER
> > diff --git a/kernel/sched/pelt.c b/kernel/sched/pelt.c
> > index bd006b7..5d1fbf0 100644
> > --- a/kernel/sched/pelt.c
> > +++ b/kernel/sched/pelt.c
> > @@ -367,6 +367,37 @@ int update_dl_rq_load_avg(u64 now, struct rq *rq, int running)
> >         return 0;
> >  }
> >
> > +#ifdef CONFIG_HAVE_SCHED_THERMAL_PRESSURE
> > +/*
> > + * thermal:
> > + *
> > + *   load_sum = \Sum se->avg.load_sum but se->avg.load_sum is not tracked
> > + *
> > + *   util_avg and runnable_load_avg are not supported and meaningless.
> > + *
> > + * Unlike rt/dl utilization tracking that track time spent by a cpu
> > + * running a rt/dl task through util_avg, the average thermal pressure is
> > + * tracked through load_avg. This is because thermal pressure signal is
> > + * weighted "delta" capacity and is not binary(util_avg is binary). "delta
>
> May I suggest a slight rewording here and in the commit description,
>
>    This is because the thermal pressure signal is weighted "delta"
> capacity unlike util_avg which is binary.
>
> It would also help, if you expanded on what you mean by binary in the
> commit description and how the delta capacity is weighted.
>
> > + * capacity" here means delta between the actual capacity of a cpu and the
> > + * decreased capacity a cpu due to a thermal event.
>
> This could be shortened to:
>
> Delta capacity of cpu = Actual capacity - Decreased capacity due to
> thermal event
>

Please ignore. I should have sent this against v9, it was languishing
in my mailbox since v8 and I sent this out by mistake.
