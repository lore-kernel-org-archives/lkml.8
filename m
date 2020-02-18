Return-Path: <SRS0=52rg=4G=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 00E74C34026
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Feb 2020 15:29:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B7DD021D56
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Feb 2020 15:29:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="Y6i/TXAF"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726632AbgBRP3K (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 18 Feb 2020 10:29:10 -0500
Received: from mail-lj1-f194.google.com ([209.85.208.194]:35953 "EHLO
        mail-lj1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726312AbgBRP3K (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Feb 2020 10:29:10 -0500
Received: by mail-lj1-f194.google.com with SMTP id r19so23437029ljg.3
        for <linux-kernel@vger.kernel.org>; Tue, 18 Feb 2020 07:29:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=nCMSK5qKtWnHvKOE7JodWi5C45C51Cw+Z/kwEVm06II=;
        b=Y6i/TXAFSDvmAAikQWwpD28/ZbC/9zjGP9BNHYLnqZWl0IFAOm2n7qfGDYJYdtiZzJ
         gY4hMUyynXtuJbW5UqtyQ7PqUv5Y4WVf4Jb0TPgkZssvAKBtb2+OYoSQZGb8UichIXuR
         bDbpbfZ+TXVnBvx7L9bGumT7uGNmhx8jR8zcv9FlrmXNbRFKEDeGe0pPlyUO4DVtZt10
         K/IfD9t9ZQjxaq4S5OsAkExPeVA6OqqSnvsJgDAkiVZicDZJuY/nU+SSWT8DjKoF+R+O
         yNE4u0LxsDTigmr1OvEAyTKEUIs6gtFVPlQS8gThpNYpGE7LOYrIYbudyZ8dMyN2LH5b
         5XJQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=nCMSK5qKtWnHvKOE7JodWi5C45C51Cw+Z/kwEVm06II=;
        b=IKquUhqsY1PIpZutPoDNohbfX+Z+0HchJJOyVOteXr8pRnTqLeiiRCs2ZH4hnMKzfe
         dRxpYI/BUw1PaIbeTb8qYKeI2s7eagfu1n7YZukIk/MmBx3hyThiLNTTZApRATrmzQqx
         5RP6dSQHRkRiGJLQCLjeC+ANGSBrsOsELu9lwT7Dj2eSeVFmYQgeLWKUO7WN6+ir3zo/
         3r6W9DwaaA9sr9eueiqb6znfc6/XR1i3nn5z7Y2r0YQ9B5rwA6Rut8zHuQKiFY0kBw6H
         HUjrUbt5/xBTn4q1huAQqUzF7NTpwG7fJMLnGN+KCuJ/+5QSJvGGh6GbEU/+cruM8p+n
         5kxQ==
X-Gm-Message-State: APjAAAW/Kmiqtzf/5ewvr1WBEYhKIhnjsOLAVZ4pS341qPjpcAG1FhOB
        uWu2YwWLE13QEYMAUoAFGCoXiK8qIdwYu9ivoS/ysQ==
X-Google-Smtp-Source: APXvYqyM4hfVYoDYwfQfVPhbnPFk4I8LKxaCDffZcJwq7fD3GxqUJEH6Udb9zt2BbyK4tPnOr9RKMynt1WyBL89J69U=
X-Received: by 2002:a2e:808a:: with SMTP id i10mr13116369ljg.151.1582039746654;
 Tue, 18 Feb 2020 07:29:06 -0800 (PST)
MIME-Version: 1.0
References: <20200214152729.6059-1-vincent.guittot@linaro.org>
 <20200214152729.6059-5-vincent.guittot@linaro.org> <5ea96f6e-433e-1520-56dc-a10e9a8e63c7@arm.com>
In-Reply-To: <5ea96f6e-433e-1520-56dc-a10e9a8e63c7@arm.com>
From:   Vincent Guittot <vincent.guittot@linaro.org>
Date:   Tue, 18 Feb 2020 16:28:55 +0100
Message-ID: <CAKfTPtBn+OG6HDN6prWk+7BNH4Grpc67Mex41-=DumKMogvxpw@mail.gmail.com>
Subject: Re: [PATCH v2 4/5] sched/pelt: Add a new runnable average signal
To:     Valentin Schneider <valentin.schneider@arm.com>
Cc:     Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Juri Lelli <juri.lelli@redhat.com>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Ben Segall <bsegall@google.com>, Mel Gorman <mgorman@suse.de>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Phil Auld <pauld@redhat.com>, Parth Shah <parth@linux.ibm.com>,
        Hillf Danton <hdanton@sina.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 18 Feb 2020 at 15:54, Valentin Schneider
<valentin.schneider@arm.com> wrote:
>
> On 2/14/20 3:27 PM, Vincent Guittot wrote:
> > @@ -532,8 +535,8 @@ void print_cfs_rq(struct seq_file *m, int cpu, struct cfs_rq *cfs_rq)
> >                       cfs_rq->removed.load_avg);
> >       SEQ_printf(m, "  .%-30s: %ld\n", "removed.util_avg",
> >                       cfs_rq->removed.util_avg);
> > -     SEQ_printf(m, "  .%-30s: %ld\n", "removed.runnable_sum",
> > -                     cfs_rq->removed.runnable_sum);
>
> Shouldn't that have been part of patch 3?

No this was used to propagate load_avg

>
> > +     SEQ_printf(m, "  .%-30s: %ld\n", "removed.runnable_avg",
> > +                     cfs_rq->removed.runnable_avg);
> >  #ifdef CONFIG_FAIR_GROUP_SCHED
> >       SEQ_printf(m, "  .%-30s: %lu\n", "tg_load_avg_contrib",
> >                       cfs_rq->tg_load_avg_contrib);
> > @@ -3278,6 +3280,32 @@ update_tg_cfs_util(struct cfs_rq *cfs_rq, struct sched_entity *se, struct cfs_rq
> >       cfs_rq->avg.util_sum = cfs_rq->avg.util_avg * LOAD_AVG_MAX;
> >  }
> >
> > +static inline void
> > +update_tg_cfs_runnable(struct cfs_rq *cfs_rq, struct sched_entity *se, struct cfs_rq *gcfs_rq)
> > +{
> > +     long delta = gcfs_rq->avg.runnable_avg - se->avg.runnable_avg;
> > +
> > +     /* Nothing to update */
> > +     if (!delta)
> > +             return;
> > +
> > +     /*
> > +      * The relation between sum and avg is:
> > +      *
> > +      *   LOAD_AVG_MAX - 1024 + sa->period_contrib
> > +      *
> > +      * however, the PELT windows are not aligned between grq and gse.
> > +      */
> > +
> > +     /* Set new sched_entity's runnable */
> > +     se->avg.runnable_avg = gcfs_rq->avg.runnable_avg;
> > +     se->avg.runnable_sum = se->avg.runnable_avg * LOAD_AVG_MAX;
> > +
> > +     /* Update parent cfs_rq runnable */
> > +     add_positive(&cfs_rq->avg.runnable_avg, delta);
> > +     cfs_rq->avg.runnable_sum = cfs_rq->avg.runnable_avg * LOAD_AVG_MAX;
> > +}
> > +
>
> Humph, that's an exact copy of update_tg_cfs_util(). FWIW the following
> eldritch horror compiles...
>
> ---
> diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
> index 99249a2484b4..be796532a2d3 100644
> --- a/kernel/sched/fair.c
> +++ b/kernel/sched/fair.c
> @@ -3254,57 +3254,34 @@ void set_task_rq_fair(struct sched_entity *se,
>   *
>   */
>
> -static inline void
> -update_tg_cfs_util(struct cfs_rq *cfs_rq, struct sched_entity *se, struct cfs_rq *gcfs_rq)
> -{
> -       long delta = gcfs_rq->avg.util_avg - se->avg.util_avg;
> -
> -       /* Nothing to update */
> -       if (!delta)
> -               return;
> -
> -       /*
> -        * The relation between sum and avg is:
> -        *
> -        *   LOAD_AVG_MAX - 1024 + sa->period_contrib
> -        *
> -        * however, the PELT windows are not aligned between grq and gse.
> -        */
> -
> -       /* Set new sched_entity's utilization */
> -       se->avg.util_avg = gcfs_rq->avg.util_avg;
> -       se->avg.util_sum = se->avg.util_avg * LOAD_AVG_MAX;
> -
> -       /* Update parent cfs_rq utilization */
> -       add_positive(&cfs_rq->avg.util_avg, delta);
> -       cfs_rq->avg.util_sum = cfs_rq->avg.util_avg * LOAD_AVG_MAX;
> -}
> -
> -static inline void
> -update_tg_cfs_runnable(struct cfs_rq *cfs_rq, struct sched_entity *se, struct cfs_rq *gcfs_rq)
> -{
> -       long delta = gcfs_rq->avg.runnable_avg - se->avg.runnable_avg;
> -
> -       /* Nothing to update */
> -       if (!delta)
> -               return;
> -
> -       /*
> -        * The relation between sum and avg is:
> -        *
> -        *   LOAD_AVG_MAX - 1024 + sa->period_contrib
> -        *
> -        * however, the PELT windows are not aligned between grq and gse.
> -        */
> -
> -       /* Set new sched_entity's runnable */
> -       se->avg.runnable_avg = gcfs_rq->avg.runnable_avg;
> -       se->avg.runnable_sum = se->avg.runnable_avg * LOAD_AVG_MAX;
> +#define DECLARE_UPDATE_TG_CFS_SIGNAL(signal)                           \
> +static inline void                                             \
> +update_tg_cfs_##signal(struct cfs_rq *cfs_rq, struct sched_entity *se, struct cfs_rq *gcfs_rq) \
> +{                                                              \
> +       long delta = gcfs_rq->avg.signal##_avg - se->avg.signal##_avg; \
> +                                                               \
> +       /* Nothing to update */                                 \
> +       if (!delta)                                             \
> +               return;                                         \
> +                                                               \
> +       /*                                                                      \
> +        * The relation between sum and avg is:                                 \
> +        *                                                                      \
> +        *   LOAD_AVG_MAX - 1024 + sa->period_contrib                           \
> +        *                                                                      \
> +               * however, the PELT windows are not aligned between grq and gse.        \
> +       */                                                                      \
> +       /* Set new sched_entity's runnable */                   \
> +       se->avg.signal##_avg = gcfs_rq->avg.signal##_avg;       \
> +       se->avg.signal##_sum = se->avg.signal##_avg * LOAD_AVG_MAX; \
> +                                                               \
> +       /* Update parent cfs_rq signal## */                     \
> +       add_positive(&cfs_rq->avg.signal##_avg, delta);         \
> +       cfs_rq->avg.signal##_sum = cfs_rq->avg.signal##_avg * LOAD_AVG_MAX; \
> +}                                                              \
>
> -       /* Update parent cfs_rq runnable */
> -       add_positive(&cfs_rq->avg.runnable_avg, delta);
> -       cfs_rq->avg.runnable_sum = cfs_rq->avg.runnable_avg * LOAD_AVG_MAX;
> -}
> +DECLARE_UPDATE_TG_CFS_SIGNAL(util);
> +DECLARE_UPDATE_TG_CFS_SIGNAL(runnable);

TBH, I prefer keeping the current version which is easier to read IMO

>
>  static inline void
>  update_tg_cfs_load(struct cfs_rq *cfs_rq, struct sched_entity *se, struct cfs_rq *gcfs_rq)
> ---
>
> >  static inline void
> >  update_tg_cfs_load(struct cfs_rq *cfs_rq, struct sched_entity *se, struct cfs_rq *gcfs_rq)
> >  {
> > @@ -3358,6 +3386,7 @@ static inline int propagate_entity_load_avg(struct sched_entity *se)
> >       add_tg_cfs_propagate(cfs_rq, gcfs_rq->prop_runnable_sum);
> >
> >       update_tg_cfs_util(cfs_rq, se, gcfs_rq);
> > +     update_tg_cfs_runnable(cfs_rq, se, gcfs_rq);
> >       update_tg_cfs_load(cfs_rq, se, gcfs_rq);
> >
> >       trace_pelt_cfs_tp(cfs_rq);
> > @@ -3439,7 +3468,7 @@ update_cfs_rq_load_avg(u64 now, struct cfs_rq *cfs_rq)
> >               raw_spin_lock(&cfs_rq->removed.lock);
> >               swap(cfs_rq->removed.util_avg, removed_util);
> >               swap(cfs_rq->removed.load_avg, removed_load);
> > -             swap(cfs_rq->removed.runnable_sum, removed_runnable_sum);
>
> Ditto on the stray from patch 3?

same as 1st point above
>
> > +             swap(cfs_rq->removed.runnable_avg, removed_runnable);
> >               cfs_rq->removed.nr = 0;
> >               raw_spin_unlock(&cfs_rq->removed.lock);
> >
> > @@ -3451,7 +3480,16 @@ update_cfs_rq_load_avg(u64 now, struct cfs_rq *cfs_rq)
>
