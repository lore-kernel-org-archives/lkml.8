Return-Path: <SRS0=N8G3=3G=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 45515C33CB1
	for <linux-kernel@archiver.kernel.org>; Fri, 17 Jan 2020 13:17:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 17F5C206E6
	for <linux-kernel@archiver.kernel.org>; Fri, 17 Jan 2020 13:17:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="D6s0DVh+"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727243AbgAQNRu (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 17 Jan 2020 08:17:50 -0500
Received: from mail-lf1-f68.google.com ([209.85.167.68]:45415 "EHLO
        mail-lf1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726329AbgAQNRu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Jan 2020 08:17:50 -0500
Received: by mail-lf1-f68.google.com with SMTP id 203so18304817lfa.12
        for <linux-kernel@vger.kernel.org>; Fri, 17 Jan 2020 05:17:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=q2OChnFdSNqECe+vPEB3C3OvYxdGrVXJ27kI6yMrowk=;
        b=D6s0DVh+yENJfQDtTUOPcevVij8PgvbarGgFmoQrjJ6jDX4229Qi6Mt00InzgEWXSQ
         VwWcLmi8KV5X349Kz7NuZkjwYAMidULL7RzNeul3R/hr8vQu27stJTOh2D/kz5fF2Ea0
         BsDvNkFEK57srpr4G0hoIyMSazxVF9tP/H1O/qZzhOW/aPwp5PLgPhddm8Zp8gO6zA8p
         +utPy/Zamr/forEqwXKp60+veecRrZHA+oHFijf/38svhRXHH1TPiHCLRBCJ94JAmcz7
         XL8HwUWCW7KrQmF/A+COYGjR457KO++mGtInK3OMSLwhD0DkXgeKn86QHHnkOVt4g16X
         g+PA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=q2OChnFdSNqECe+vPEB3C3OvYxdGrVXJ27kI6yMrowk=;
        b=HbJV8hZr65TG1HlpHDEmhc9B+/OnJuTGy+HNv3R/RnScdrMynKI2KXPnefIwLBGKTt
         X5z7hyYm861SCEm3XNXjqW8RbKCbxLxZC66rENVcXQCa2U7Xk+mmDsdeYJlF1JSEKQyW
         smOHafnAjwIuUEH9WF/vCQ7FYQNZsl8EftCwibQgFd78mCsrREayTVf4VIa7jS1QUQQ9
         rCn0AdS4T3BXi2/7YczCqvvJRCsjTcL2jwOvLfMW0gRDzI+KPC91sMIy6Nlu2TuIh7lR
         20q8I6ibvi8SNpMaePYtTwMtZ618P1UY/xq9vnY44Uz+z7b26n7XFAu3ouMaa7ZgT/Xa
         fiQQ==
X-Gm-Message-State: APjAAAUVMmgYZUqRCOgCQdc7JvWaOlIacc1aSJlSTzorWijkrd/mEYVZ
        HHZWcwf241SHx9E62+qXJlHk07p1WXdNJY+ileWuBw==
X-Google-Smtp-Source: APXvYqx5DEM4+ejKOlGUrW07UoDMdzZ2JX3qcGwU0UnYkaSSA6WZZJ97KOlbW28z12aDeSmzY8Id7/YUluz5tYYy8X0=
X-Received: by 2002:ac2:59dd:: with SMTP id x29mr5325027lfn.95.1579267067908;
 Fri, 17 Jan 2020 05:17:47 -0800 (PST)
MIME-Version: 1.0
References: <1579031859-18692-1-git-send-email-thara.gopinath@linaro.org>
 <1579031859-18692-5-git-send-email-thara.gopinath@linaro.org>
 <20200116151502.GQ2827@hirez.programming.kicks-ass.net> <20200117114045.GA219309@google.com>
 <20200117123103.GB14879@hirez.programming.kicks-ass.net>
In-Reply-To: <20200117123103.GB14879@hirez.programming.kicks-ass.net>
From:   Vincent Guittot <vincent.guittot@linaro.org>
Date:   Fri, 17 Jan 2020 14:17:36 +0100
Message-ID: <CAKfTPtALUU7SRmyU=u6-fxa8dkNWFrxE59JfYh+TmiDCqf0Kqg@mail.gmail.com>
Subject: Re: [Patch v8 4/7] sched/fair: Enable periodic update of average
 thermal pressure
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     Quentin Perret <qperret@google.com>,
        Thara Gopinath <thara.gopinath@linaro.org>,
        Ingo Molnar <mingo@redhat.com>,
        Ionela Voinescu <ionela.voinescu@arm.com>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Zhang Rui <rui.zhang@intel.com>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        viresh kumar <viresh.kumar@linaro.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Amit Kachhap <amit.kachhap@gmail.com>,
        Javi Merino <javi.merino@kernel.org>,
        Amit Kucheria <amit.kucheria@verdurent.com>,
        Android Kernel Team <kernel-team@android.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 17 Jan 2020 at 13:31, Peter Zijlstra <peterz@infradead.org> wrote:
>
> On Fri, Jan 17, 2020 at 11:40:45AM +0000, Quentin Perret wrote:
> > On Thursday 16 Jan 2020 at 16:15:02 (+0100), Peter Zijlstra wrote:
> > > > @@ -10275,6 +10281,7 @@ static void task_tick_fair(struct rq *rq, struct task_struct *curr, int queued)
> > > >  {
> > > >   struct cfs_rq *cfs_rq;
> > > >   struct sched_entity *se = &curr->se;
> > > > + unsigned long thermal_pressure = arch_cpu_thermal_pressure(cpu_of(rq));
> > > >
> > > >   for_each_sched_entity(se) {
> > > >           cfs_rq = cfs_rq_of(se);
> > > > @@ -10286,6 +10293,7 @@ static void task_tick_fair(struct rq *rq, struct task_struct *curr, int queued)
> > > >
> > > >   update_misfit_status(curr, rq);
> > > >   update_overutilized_status(task_rq(curr));
> > > > + update_thermal_load_avg(rq_clock_task(rq), rq, thermal_pressure);
> > > >  }
> > >
> > > I'm thinking this is the wrong place; should this not be in
> > > scheduler_tick(), right before calling sched_class::task_tick() ? Surely
> > > any execution will affect thermals, not only fair class execution.
> >
> > Right, but right now only CFS takes action when we overheat. That is,
> > only CFS uses capacity_of() which is where the thermal signal gets
> > reflected.
>
> Sure, but we should still track the thermals unconditionally, even if
> only CFS consumes it.

I agree, tracking thermal pressure should happen even if no cfs task are running

>
> > We definitely could (and maybe should) make RT and DL react to thermal
> > pressure as well when they're both capacity-aware. But perhaps that's
> > for later ? Thoughts ?
>
> Yeah, that's later head-aches. Even determining what to do there, except
> panic() is going to be 'interesting'.
