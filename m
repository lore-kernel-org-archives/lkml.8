Return-Path: <SRS0=1j9/=3N=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8ED8FC2D0DB
	for <linux-kernel@archiver.kernel.org>; Fri, 24 Jan 2020 15:45:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 614942072C
	for <linux-kernel@archiver.kernel.org>; Fri, 24 Jan 2020 15:45:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="Anmezv+U"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388962AbgAXPp1 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 24 Jan 2020 10:45:27 -0500
Received: from mail-lf1-f41.google.com ([209.85.167.41]:45244 "EHLO
        mail-lf1-f41.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388035AbgAXPp1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Jan 2020 10:45:27 -0500
Received: by mail-lf1-f41.google.com with SMTP id 203so1391846lfa.12
        for <linux-kernel@vger.kernel.org>; Fri, 24 Jan 2020 07:45:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=kfyvQTn0g3NmbBob0j021PC/6QP6hYOFzKNdsQKaexo=;
        b=Anmezv+USLZozR3HeoTec9bQ1bEx1V7DMcpOGGbCNGfCSEiZ+jlqTVtAY7bnzzSqGJ
         iZbNQ3d18EJ8S+Ud93DpJ6wPQadTY3XQeEEymxX5lTWEFcpQpcc9lKFg6K86zJoWjfmb
         +ZPq0Teprhkvia2HRDvLQQ+0YQ1mt+SLMuQipr/vrJmwlu+6Mk2/2gDTfsZXubWnroCu
         iBPaQwNlyUlVfOr1Jw0Q5+ZFJDBKQXzTPPNkiHnZwfts6Q+L7zS/kSApua88PPrq3sor
         68Ipbc+XI679/iw/ZwLF/UuXjAnt4neZBCa8tbPU79NKS0bfvPZhfIfzt7vIkzeSPC8v
         DbIw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=kfyvQTn0g3NmbBob0j021PC/6QP6hYOFzKNdsQKaexo=;
        b=Mn8mJAQZIqg7aY16K7LXZrwmIWaFkTqEhXOB5rw/kP4x2QgtQ4svMI5mBau5DIgRT4
         dP9T5+ZcWWsJumQEqzsqjLjCVApJ2lLy8+fT6DjxPx22lR3WlP2Rs2C4f6O0evd1OR/x
         XfmXN8IazSohs+HiAqB/WKYQP6fm5rE+e5smatCiIhA6Zk/TvaaVfPNqTBm+pAygf5LY
         s6jUUePL7tBgR6v75/3K4YI6YPrd7iKCEEHHDOAood8+NHvJ91nw2Oa+0Fw3N1+ESy/7
         NOzLHr/c/OpgbXpJWYrTmBpHmI8QbnkxdAf6Ig/j9yH0RUN8JpUeQAA4vKzHfar1UQxJ
         aCOA==
X-Gm-Message-State: APjAAAVfSoImOscZmN9jsFYFhaOUspmhGo+l2rV2qm2MkriJLRe94Xqb
        2aLTIlURxgIHO06FS1agVBY7+K1SysmrOkaWRFwLZA==
X-Google-Smtp-Source: APXvYqyP1USSorFbeLrXeR3Pp4110Hu1uNRNI2ZRC63AT5rIvlo2Ceobepi9xyQJhRxn2BTgUyMnLj0oW8MOvCtpOVw=
X-Received: by 2002:a19:5504:: with SMTP id n4mr1578411lfe.25.1579880724795;
 Fri, 24 Jan 2020 07:45:24 -0800 (PST)
MIME-Version: 1.0
References: <1579031859-18692-1-git-send-email-thara.gopinath@linaro.org>
 <1579031859-18692-5-git-send-email-thara.gopinath@linaro.org>
 <20200116151502.GQ2827@hirez.programming.kicks-ass.net> <CAKfTPtA-M_APhGzwADhuwABzW_M5YKjm_ONGzQjFNRoJ+qYBmg@mail.gmail.com>
 <20200117145544.GE14879@hirez.programming.kicks-ass.net> <CAKfTPtAzgNAV5c_sTycSocmi8Y4oGGT5rDNSYmgL3tCjZ1RAQw@mail.gmail.com>
 <e0ede843-4cb8-83d8-708b-87d96b6eb1c3@arm.com>
In-Reply-To: <e0ede843-4cb8-83d8-708b-87d96b6eb1c3@arm.com>
From:   Vincent Guittot <vincent.guittot@linaro.org>
Date:   Fri, 24 Jan 2020 16:45:13 +0100
Message-ID: <CAKfTPtA-pr9y2MuwY8vTAy=m4beqdhNCek0fgdZP7u0JT8ojvA@mail.gmail.com>
Subject: Re: [Patch v8 4/7] sched/fair: Enable periodic update of average
 thermal pressure
To:     Dietmar Eggemann <dietmar.eggemann@arm.com>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Thara Gopinath <thara.gopinath@linaro.org>,
        Ingo Molnar <mingo@redhat.com>,
        Ionela Voinescu <ionela.voinescu@arm.com>,
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

On Fri, 24 Jan 2020 at 16:37, Dietmar Eggemann <dietmar.eggemann@arm.com> wrote:
>
> On 17/01/2020 16:39, Vincent Guittot wrote:
> > On Fri, 17 Jan 2020 at 15:55, Peter Zijlstra <peterz@infradead.org> wrote:
> >>
> >> On Fri, Jan 17, 2020 at 02:22:51PM +0100, Vincent Guittot wrote:
> >>> On Thu, 16 Jan 2020 at 16:15, Peter Zijlstra <peterz@infradead.org> wrote:
> >>
> >>>>
> >>>> That there indentation trainwreck is a reason to rename the function.
> >>>>
> >>>>         decayed = update_rt_rq_load_avg(now, rq, curr_class == &rt_sched_class) |
> >>>>                   update_dl_rq_load_avg(now, rq, curr_class == &dl_sched_class) |
> >>>>                   update_thermal_load_avg(rq_clock_task(rq), rq, thermal_pressure) |
> >>>>                   update_irq_load_avg(rq, 0);
> >>>>
> >>>> Is much better.
> >>>>
> >>>> But now that you made me look at that, I noticed it's using a different
> >>>> clock -- it is _NOT_ using now/rq_clock_pelt(), which means it'll not be
> >>>> in sync with the other averages.
> >>>>
> >>>> Is there a good reason for that?
> >>>
> >>> We don't need to apply frequency and cpu capacity invariance on the
> >>> thermal capping signal which is  what rq_clock_pelt does
> >>
> >> Hmm, I suppose that is true, and that really could've done with a
> >> comment. Now clock_pelt is sort-of in sync with clock_task, but won't it
> >> still give weird artifacts by having it on a slightly different basis?
> >
> > No we should not. Weird artifacts happens when we
> > add/subtract/propagate signals between each other and then apply pelt
> > algorithm on the results. In the case of thermal signal, we only add
> > it to others to update cpu_capacity but pelt algo is then not applied
> > on it. The error because of some signals being at segment boundaries
> > whereas others are not, is limited to 2% and doesn't accumulate over
> > time.
> >
> >>
> >> Anyway, looking at this, would it make sense to remove the @now argument
> >> from update_*_load_avg()? All those functions already take @rq, and
> >> rq_clock_*() are fairly trivial inlines.
> >
> > TBH I was thinking of doing the opposite for update_irq_load_avg which
> > hides the clock that is used for irq_avg. This helps to easily
> > identify which signals use the exact same clock and can be mixed to
> > create a new pelt signal and which can't
>
> The 'now' argument is one thing but why not:
>
> -int update_thermal_load_avg(u64 now, struct rq *rq, u64 capacity)
> +int update_thermal_load_avg(u64 now, struct rq *rq)
>  {
> +       u64 capacity = arch_cpu_thermal_pressure(cpu_of(rq));
> +
>         if (___update_load_sum(now, &rq->avg_thermal,
>
> This would make the call-sites __update_blocked_others() and
> task_tick(_fair)() cleaner.

I prefer to keep the capacity as argument. This is more aligned with
others that provides the value of the signal to apply

>
> I guess the argument is not to pollute pelt.c. But it already contains

you've got it. I don't want to pollute the pelt.c file with things not
related to pelt but thermal as an example.

> arch_scale_[freq|cpu]_capacity() for irq.
>
>
