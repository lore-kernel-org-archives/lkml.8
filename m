Return-Path: <SRS0=aTFg=AS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 52B33C433DF
	for <linux-kernel@archiver.kernel.org>; Tue,  7 Jul 2020 13:30:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2AA8520672
	for <linux-kernel@archiver.kernel.org>; Tue,  7 Jul 2020 13:30:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="vu7obTCv"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727876AbgGGNan (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 7 Jul 2020 09:30:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43200 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726805AbgGGNam (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Jul 2020 09:30:42 -0400
Received: from mail-lj1-x243.google.com (mail-lj1-x243.google.com [IPv6:2a00:1450:4864:20::243])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4B220C061755
        for <linux-kernel@vger.kernel.org>; Tue,  7 Jul 2020 06:30:42 -0700 (PDT)
Received: by mail-lj1-x243.google.com with SMTP id q7so36637328ljm.1
        for <linux-kernel@vger.kernel.org>; Tue, 07 Jul 2020 06:30:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=ytTXbUnpyEHr/PePdG9cbFm9zb2rnLmsICtm/Rte0aQ=;
        b=vu7obTCv449t1/QABeXXxJQEQrPb1cGJ7lu2d97+PN05Ckxdy2ypFjDk9MEknqIegU
         U57fxfbxMO2VNzRIXXQywb2JeakztpC62BtiCdVprMaReNIqQJcz1p+iTwqgsb9Cm3L7
         xGcdQ9R6Zai5AO4F7Y6QhtO8O46Aayg6DtUnfixyIIG0o9FDTjEhHqFpPCI2ZfvLtRbX
         D4u2xPayPxRcfHZSRQPffJxWfTPAXY34+xhXwkbbsx16ffyJM4KMklYSp4JLNgvkmyLs
         4l/gXdPkNkgNkel5QnRe0lwCyUrNGPAxYxml/sRtfYcErqVT0VL3mNPf0fLTl3ESguVf
         jmAA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=ytTXbUnpyEHr/PePdG9cbFm9zb2rnLmsICtm/Rte0aQ=;
        b=ImQ87cCPb2Rat3ARXr8HVTZXUBGnacSyIYRm63C4RI+mvhIKaT967RNqDy7NM80e3R
         fF3lWqZaiaBHlmdMeBr6mTzLR9gXwRRHBPcBqeln/DGpJAH60CWCJIRLxnGMO8nc/1ZH
         Nzw1aC5h+vXN38mwQgZXVWCKULiUfgfQxBmy4DZ3JUCBIYuKUt1QcduDlX0rbQM9lff1
         aiNrhUoQHOOiS+OGlUvo4Y9AsP2/8wxmeOcLB9fg+UlcTXF5BVe7I1S9GrQZhjpQC9cE
         V5q/K1iqjK9QSqSeB5+eDaYO3fKvx6xAiocpPx42t0/zUmjx8sDNEi0gG6Fd9w1bYBwK
         smJw==
X-Gm-Message-State: AOAM5321cj/o6OYWpjg/uy62uR45dI+C0yAloCIu9prpAaWbdNCJhZ/y
        9SmnuudCUmJAGu4jmBCQ77wjBG0ZmzjxUOiBXlV1zwtg
X-Google-Smtp-Source: ABdhPJyv/NY9PcCTyWJgQIuTmWnkweMm5rEOL2DL0iuA2rXDnLKtPfzuoCejsumtJyOo72W+9PrzTyk/D9exPOiA/PU=
X-Received: by 2002:a2e:3c0e:: with SMTP id j14mr30747645lja.25.1594128640669;
 Tue, 07 Jul 2020 06:30:40 -0700 (PDT)
MIME-Version: 1.0
References: <20200702144258.19326-1-vincent.guittot@linaro.org>
 <jhjh7up99ss.mognet@arm.com> <CAKfTPtCxki8E=9DqistC32xZJ4ozufb9jUOR=ro34BNNNJtJiw@mail.gmail.com>
In-Reply-To: <CAKfTPtCxki8E=9DqistC32xZJ4ozufb9jUOR=ro34BNNNJtJiw@mail.gmail.com>
From:   Vincent Guittot <vincent.guittot@linaro.org>
Date:   Tue, 7 Jul 2020 15:30:29 +0200
Message-ID: <CAKfTPtA2RNc+XYMn0z_JyCgFswkUxHTS83uN_sJ8pjU7XPE4aA@mail.gmail.com>
Subject: Re: [PATCH] sched/fair: handle case of task_h_load() returning 0
To:     Valentin Schneider <valentin.schneider@arm.com>
Cc:     Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Juri Lelli <juri.lelli@redhat.com>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Ben Segall <bsegall@google.com>, Mel Gorman <mgorman@suse.de>,
        linux-kernel <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2 Jul 2020 at 18:28, Vincent Guittot <vincent.guittot@linaro.org> wrote:
>
> On Thu, 2 Jul 2020 at 18:11, Valentin Schneider
> <valentin.schneider@arm.com> wrote:
> >
> >
> > On 02/07/20 15:42, Vincent Guittot wrote:
> > > task_h_load() can return 0 in some situations like running stress-ng
> > > mmapfork, which forks thousands of threads, in a sched group on a 224 cores
> > > system. The load balance doesn't handle this correctly because
> > > env->imbalance never decreases and it will stop pulling tasks only after
> > > reaching loop_max, which can be equal to the number of running tasks of
> > > the cfs. Make sure that imbalance will be decreased by at least 1.
> > >
> > > misfit task is the other feature that doesn't handle correctly such
> > > situation although it's probably more difficult to face the problem
> > > because of the smaller number of CPUs and running tasks on heterogenous
> > > system.
> > >
> > > We can't simply ensure that task_h_load() returns at least one because it
> > > would imply to handle underrun in other places.
> >
> > Nasty one, that...
> >
> > Random thought: isn't that the kind of thing we have scale_load() and
> > scale_load_down() for? There's more uses of task_h_load() than I would like
> > for this, but if we upscale its output (or introduce an upscaled variant),
> > we could do something like:
> >
> > ---
> > detach_tasks()
> > {
> >         long imbalance = env->imbalance;
> >
> >         if (env->migration_type == migrate_load)
> >                 imbalance = scale_load(imbalance);
> >
> >         while (!list_empty(tasks)) {
> >                 /* ... */
> >                 switch (env->migration_type) {
> >                 case migrate_load:
> >                         load = task_h_load_upscaled(p);
> >                         /* ... usual bits here ...*/
> >                         lsub_positive(&env->imbalance, load);
> >                         break;
> >                         /* ... */
> >                 }
> >
> >                 if (!scale_load_down(env->imbalance))
> >                         break;
> >         }
> > }
> > ---
> >
> > It's not perfect, and there's still the misfit situation to sort out -
> > still, do you think this is something we could go towards?
>
> This will not work for 32bits system.
>
> For 64bits, I have to think a bit more if the upscale would fix all
> cases and support propagation across a hierarchy. And in this case we
> could also consider to make scale_load/scale_load_down a nop all the
> time

In addition that problem remains on 32bits, the problem can still
happen after extending the scale so this current patch still makes
sense.

Then if we want to reduce the cases where task_h_load returns 0, we
should better make scale_load_down a nop otherwise we will have to
maintain 2 values h_load and scale_h_load across the hierarchy

>
> >
> > >
> > > Signed-off-by: Vincent Guittot <vincent.guittot@linaro.org>
> > > ---
> > >  kernel/sched/fair.c | 18 +++++++++++++++++-
> > >  1 file changed, 17 insertions(+), 1 deletion(-)
> > >
> > > diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
> > > index 6fab1d17c575..62747c24aa9e 100644
> > > --- a/kernel/sched/fair.c
> > > +++ b/kernel/sched/fair.c
> > > @@ -4049,7 +4049,13 @@ static inline void update_misfit_status(struct task_struct *p, struct rq *rq)
> > >               return;
> > >       }
> > >
> > > -     rq->misfit_task_load = task_h_load(p);
> > > +     /*
> > > +      * Make sure that misfit_task_load will not be null even if
> > > +      * task_h_load() returns 0. misfit_task_load is only used to select
> > > +      * rq with highest load so adding 1 will not modify the result
> > > +      * of the comparison.
> > > +      */
> > > +     rq->misfit_task_load = task_h_load(p) + 1;
> > >  }
> > >
> > >  #else /* CONFIG_SMP */
> > > @@ -7664,6 +7670,16 @@ static int detach_tasks(struct lb_env *env)
> > >                           env->sd->nr_balance_failed <= env->sd->cache_nice_tries)
> > >                               goto next;
> > >
> > > +                     /*
> > > +                      * Depending of the number of CPUs and tasks and the
> > > +                      * cgroup hierarchy, task_h_load() can return a null
> > > +                      * value. Make sure that env->imbalance decreases
> > > +                      * otherwise detach_tasks() will stop only after
> > > +                      * detaching up to loop_max tasks.
> > > +                      */
> > > +                     if (!load)
> > > +                             load = 1;
> > > +
> > >                       env->imbalance -= load;
> > >                       break;
