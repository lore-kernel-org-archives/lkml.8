Return-Path: <SRS0=7TUr=4M=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CD089C3567B
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Feb 2020 08:32:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9632B2072D
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Feb 2020 08:32:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="LdMixJJC"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727202AbgBXIcS (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 24 Feb 2020 03:32:18 -0500
Received: from mail-lj1-f194.google.com ([209.85.208.194]:39304 "EHLO
        mail-lj1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726452AbgBXIcS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Feb 2020 03:32:18 -0500
Received: by mail-lj1-f194.google.com with SMTP id o15so9079829ljg.6
        for <linux-kernel@vger.kernel.org>; Mon, 24 Feb 2020 00:32:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=XJRgxNIsppv7vONIRKrF9gVAm4UMJ5H/Ru2R3Bz9H+c=;
        b=LdMixJJCYCeW+0+fhCp7YjLrLwmzuXw5+YBZZ7/ZQWqmVWX3QyJo+5alqv8hMLfggr
         lj4lOI2jBfPnlsSFWniy9pJ1nGQ1CasY6fdJb+2TE85qljjWVeYwUSu3cyg60yd4kOFE
         Jt5BbNUdilPfQsvW0OQ3DI/VvHwpZuPXIbVSAllaF9r6rDf76f9n2YATDNAosk636v39
         k6B0GEnS08oPozQMarxl8QE1oISB18wO5VND9utNo0uuPnYAiGPwAqfuVbLd4b6qSgEg
         qvEne9gisvjzoQhem+UCXJ9+u4IMxQ/HsV7iXrCO7HJnKOLaCxfCci4fzvGJ+YlIQp/S
         /UAA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=XJRgxNIsppv7vONIRKrF9gVAm4UMJ5H/Ru2R3Bz9H+c=;
        b=lY+ePKoFpxajUBRZOdm3W40dB55zYqrAJ1cg2L143hssyTZV8Kl3AQooaRsydkhWCp
         Y6Dh3gBkk+LNYiwL8vnqglY3wADCghqUuHRPiCiMFBEbP/oOnJ3JrhX+me6ZGh5w8K1p
         9svbOuQ8yDhQF2haXKKgUVEuNlqVyO8ew/m7uMIaJ5ZEOT4YHf4dgeeIoluSUED3QJ54
         KXyJ/9GmFZMVy5pnA8AZatjH+g9M2OF9gFh8G2JZCllqdDCXNTb0kJyWaDgBbken42oy
         d+EU4RVUbJar7MTBlptwIeDf7liH/uQ2UZIp6r5F2TxtVhDOuT1FNLu+yjYMkv00FNAe
         RINg==
X-Gm-Message-State: APjAAAVXTa8FnDGzyJJUqh/sRP4t30r6riwm6pytlqGvjRvBk6lfPDtJ
        AnDDMoeTqHlKGaBZZP5HKRPGcTIgNK1gY3j5y4yw1A==
X-Google-Smtp-Source: APXvYqzQzXy127bLWQiTgNAlPeV7wkROPuOjgKaR4adX5Qbe5ZjNe+c4FcEbBIjQ08YtQLSOScd+jlKHlX2IAsZN074=
X-Received: by 2002:a2e:8699:: with SMTP id l25mr28711426lji.137.1582533135007;
 Mon, 24 Feb 2020 00:32:15 -0800 (PST)
MIME-Version: 1.0
References: <20200221132715.20648-1-vincent.guittot@linaro.org> <20200222055522.9548-1-hdanton@sina.com>
In-Reply-To: <20200222055522.9548-1-hdanton@sina.com>
From:   Vincent Guittot <vincent.guittot@linaro.org>
Date:   Mon, 24 Feb 2020 09:32:03 +0100
Message-ID: <CAKfTPtB4g099_JHG3d0duoggL2fYPVH9b2mxixe88KPveD-RhA@mail.gmail.com>
Subject: Re: [PATCH v4 5/5] sched/fair: Take into account runnable_avg to
 classify group
To:     Hillf Danton <hdanton@sina.com>
Cc:     Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Juri Lelli <juri.lelli@redhat.com>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Ben Segall <bsegall@google.com>, Mel Gorman <mgorman@suse.de>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Phil Auld <pauld@redhat.com>, Parth Shah <parth@linux.ibm.com>,
        Valentin Schneider <valentin.schneider@arm.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 22 Feb 2020 at 06:55, Hillf Danton <hdanton@sina.com> wrote:
>
>
> On Fri, 21 Feb 2020 14:27:15 +0100 Vincent Guittot wrote:
> >
> > Take into account the new runnable_avg signal to classify a group and to
> > mitigate the volatility of util_avg in face of intensive migration or
> > new task with random utilization.
> >
> > Signed-off-by: Vincent Guittot <vincent.guittot@linaro.org>
> > Reviewed-by: "Dietmar Eggemann <dietmar.eggemann@arm.com>"
> > ---
> >  kernel/sched/fair.c | 31 ++++++++++++++++++++++++++++++-
> >  1 file changed, 30 insertions(+), 1 deletion(-)
> >
> > diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
> > index 608c26d59c46..ef96049a02c3 100644
> > --- a/kernel/sched/fair.c
> > +++ b/kernel/sched/fair.c
> > @@ -5449,6 +5449,24 @@ static unsigned long cpu_runnable(struct rq *rq)
> >       return cfs_rq_runnable_avg(&rq->cfs);
> >  }
> >
> > +static unsigned long cpu_runnable_without(struct rq *rq, struct task_struct *p)
> > +{
> > +     struct cfs_rq *cfs_rq;
> > +     unsigned int runnable;
> > +
> > +     /* Task has no contribution or is new */
> > +     if (cpu_of(rq) != task_cpu(p) || !READ_ONCE(p->se.avg.last_update_time))
> > +             return cpu_runnable(rq);
> > +
> > +     cfs_rq = &rq->cfs;
> > +     runnable = READ_ONCE(cfs_rq->avg.runnable_avg);
> > +
> > +     /* Discount task's runnable from CPU's runnable */
> > +     lsub_positive(&runnable, p->se.avg.runnable_avg);
> > +
> > +     return runnable;
> > +}
> > +
> >  static unsigned long capacity_of(int cpu)
> >  {
> >       return cpu_rq(cpu)->cpu_capacity;
> > @@ -7718,7 +7736,8 @@ struct sg_lb_stats {
> >       unsigned long avg_load; /*Avg load across the CPUs of the group */
> >       unsigned long group_load; /* Total load over the CPUs of the group */
> >       unsigned long group_capacity;
> > -     unsigned long group_util; /* Total utilization of the group */
> > +     unsigned long group_util; /* Total utilization over the CPUs of the group */
> > +     unsigned long group_runnable; /* Total runnable time over the CPUs of the group */
> >       unsigned int sum_nr_running; /* Nr of tasks running in the group */
> >       unsigned int sum_h_nr_running; /* Nr of CFS tasks running in the group */
> >       unsigned int idle_cpus;
> > @@ -7939,6 +7958,10 @@ group_has_capacity(unsigned int imbalance_pct, struct sg_lb_stats *sgs)
> >       if (sgs->sum_nr_running < sgs->group_weight)
> >               return true;
> >
> > +     if ((sgs->group_capacity * imbalance_pct) <
> > +                     (sgs->group_runnable * 100))
> > +             return false;
> > +
> >       if ((sgs->group_capacity * 100) >
> >                       (sgs->group_util * imbalance_pct))
> >               return true;
>
> Is it likely to compare capacity with runnable in the same way as
> with util e.g

We don't want to compare util and runnable in the same way because
util_avg is a lower bound of the utilization of the capacity so we
consider taht the group doesn't have spare capacity if util_avg is
close but below the capacity whereas runnable is the upper bound so it
must be higher than capacity before considering that there is no
capacity.

>
>         if ((sgs->group_capacity * 100) >
>             (max(sgs->group_util, sgs->group_runnable) * imbalance_pct))
>                 return true;
>
> > @@ -7964,6 +7987,10 @@ group_is_overloaded(unsigned int imbalance_pct, struct sg_lb_stats *sgs)
> >                       (sgs->group_util * imbalance_pct))
> >               return true;
> >
> > +     if ((sgs->group_capacity * imbalance_pct) <
> > +                     (sgs->group_runnable * 100))
> > +             return true;
> > +
> >       return false;
> >  }
> >
> > @@ -8058,6 +8085,7 @@ static inline void update_sg_lb_stats(struct lb_env *env,
> >
> >               sgs->group_load += cpu_load(rq);
> >               sgs->group_util += cpu_util(i);
> > +             sgs->group_runnable += cpu_runnable(rq);
> >               sgs->sum_h_nr_running += rq->cfs.h_nr_running;
> >
> >               nr_running = rq->nr_running;
> > @@ -8333,6 +8361,7 @@ static inline void update_sg_wakeup_stats(struct sched_domain *sd,
> >
> >               sgs->group_load += cpu_load_without(rq, p);
> >               sgs->group_util += cpu_util_without(i, p);
> > +             sgs->group_runnable += cpu_runnable_without(rq, p);
> >               local = task_running_on_cpu(i, p);
> >               sgs->sum_h_nr_running += rq->cfs.h_nr_running - local;
> >
> > --
> > 2.17.1
> >
> >
>
