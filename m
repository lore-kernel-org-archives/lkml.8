Return-Path: <SRS0=/IhT=AT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ABA6AC433E0
	for <linux-kernel@archiver.kernel.org>; Wed,  8 Jul 2020 09:48:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 82889206F6
	for <linux-kernel@archiver.kernel.org>; Wed,  8 Jul 2020 09:48:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="ihrFGM1z"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728337AbgGHJsN (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 8 Jul 2020 05:48:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34344 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728180AbgGHJsM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Jul 2020 05:48:12 -0400
Received: from mail-lj1-x241.google.com (mail-lj1-x241.google.com [IPv6:2a00:1450:4864:20::241])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3B86AC08C5DC
        for <linux-kernel@vger.kernel.org>; Wed,  8 Jul 2020 02:48:12 -0700 (PDT)
Received: by mail-lj1-x241.google.com with SMTP id h22so46247303lji.9
        for <linux-kernel@vger.kernel.org>; Wed, 08 Jul 2020 02:48:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=EorH25W8Yxxi5FY5OnW1g+jshkGYsQppDgKBd1wwZ1k=;
        b=ihrFGM1ziTDLRncYiMtbhzukF7rJcIYxDSGdN5kiRbNtq9IuS1n5MUXiqVYSraXFyk
         nJ9BoyiVz4zei3RAyZRw2ByIUkOtvb7p3ZbZeUTWJOxiRvtiz9zKqWfRt+8YGMXvz/1F
         Yz2GgYndWW05bNlxCb0g7BQ/XzcGX/KqeWzCrUBJTlv2WUCn5Ht3mN5CIGvxBHPY0O7F
         8IrAVDssLs+mKZmL3YEumddRgCt1lB+LCOCQ8IU40ZilSNenPAutNYq5BSDEYNDa0wp4
         1edKDNBLjpPvC9DCqgrrqUuqP3eT78CkeopMMcQfMjsf4hXs7HZQb7Y+83QWyIBCQzyp
         RY4w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=EorH25W8Yxxi5FY5OnW1g+jshkGYsQppDgKBd1wwZ1k=;
        b=VnCeiXKq5MJpHJ7DY772Yx6CML2xdAsmHoObTzOBmc+toY+UW33PTiIIyRklTR/DHw
         YPoF7tAfjyFgMEpvCzdcOGxep7jx6t9dFcQ1sdFL5ftwuXbDp5srK/QaLl2lQDIJ55eV
         VZBUWnKe0pN/oSiAns8tcRUz/obM25wmAR+LUgVZsjp7WBIFEA5PQM4rHelT4jDLH1o+
         x6ui4XiLb8rqxP+il0lGDfEXJaZXOsMZMZifcb4ghT1ETqxNW8fcJ3e+D8iyeVhdJQA7
         tPUGnzRQcI4O0sTHUMDuXWAqLk1MEcsGG8oj6c86N+adsNY6tQuT/DkHVoae5Tpe+F6X
         pTug==
X-Gm-Message-State: AOAM532jNFvipIUPe0kHBXUirHbAeOPaIoLr5mpeEP6PnXY2OIdxttPM
        j0uE1YlYGJqNhvWZEEIUISgGazNVsFrJPyyCW/aQag==
X-Google-Smtp-Source: ABdhPJz2gMjFnsDKbFqZPDDFArmkqye10pgeVljvY4vAJonEYlmNuZ3cZbOCCsYr//jzwPdEwL3oHR2klTs1FpqRQT8=
X-Received: by 2002:a2e:7601:: with SMTP id r1mr34827659ljc.111.1594201690546;
 Wed, 08 Jul 2020 02:48:10 -0700 (PDT)
MIME-Version: 1.0
References: <20200702144258.19326-1-vincent.guittot@linaro.org> <4198cf3d-308e-feee-91c3-2edfd1748b4c@arm.com>
In-Reply-To: <4198cf3d-308e-feee-91c3-2edfd1748b4c@arm.com>
From:   Vincent Guittot <vincent.guittot@linaro.org>
Date:   Wed, 8 Jul 2020 11:47:59 +0200
Message-ID: <CAKfTPtBeRXCEWB3dTC8uOqbQ5xaZqQTAeG1EVGEk+pJcYz00sw@mail.gmail.com>
Subject: Re: [PATCH] sched/fair: handle case of task_h_load() returning 0
To:     Dietmar Eggemann <dietmar.eggemann@arm.com>
Cc:     Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Juri Lelli <juri.lelli@redhat.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Ben Segall <bsegall@google.com>, Mel Gorman <mgorman@suse.de>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Valentin Schneider <valentin.schneider@arm.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 8 Jul 2020 at 11:45, Dietmar Eggemann <dietmar.eggemann@arm.com> wr=
ote:
>
> On 02/07/2020 16:42, Vincent Guittot wrote:
> > task_h_load() can return 0 in some situations like running stress-ng
> > mmapfork, which forks thousands of threads, in a sched group on a 224 c=
ores
> > system. The load balance doesn't handle this correctly because
>
> I guess the issue here is that 'cfs_rq->h_load' in
>
> task_h_load() {
>     struct cfs_rq *cfs_rq =3D task_cfs_rq(p);
>     ...
>     return div64_ul(p->se.avg.load_avg * cfs_rq->h_load,
>                     cfs_rq_load_avg(cfs_rq) + 1);
> }
>
> is still ~0 (or at least pretty small) compared to se.avg.load_avg being
> 1024 and cfs_rq_load_avg(cfs_rq) n*1024 in these lb occurrences.
>
> > env->imbalance never decreases and it will stop pulling tasks only afte=
r
> > reaching loop_max, which can be equal to the number of running tasks of
> > the cfs. Make sure that imbalance will be decreased by at least 1.
> >
> > misfit task is the other feature that doesn't handle correctly such
> > situation although it's probably more difficult to face the problem
> > because of the smaller number of CPUs and running tasks on heterogenous
> > system.
> >
> > We can't simply ensure that task_h_load() returns at least one because =
it
> > would imply to handle underrun in other places.
> >
> > Signed-off-by: Vincent Guittot <vincent.guittot@linaro.org>
> > ---
> >  kernel/sched/fair.c | 18 +++++++++++++++++-
> >  1 file changed, 17 insertions(+), 1 deletion(-)
> >
> > diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
> > index 6fab1d17c575..62747c24aa9e 100644
> > --- a/kernel/sched/fair.c
> > +++ b/kernel/sched/fair.c
> > @@ -4049,7 +4049,13 @@ static inline void update_misfit_status(struct t=
ask_struct *p, struct rq *rq)
> >               return;
> >       }
> >
> > -     rq->misfit_task_load =3D task_h_load(p);
> > +     /*
> > +      * Make sure that misfit_task_load will not be null even if
> > +      * task_h_load() returns 0. misfit_task_load is only used to sele=
ct
> > +      * rq with highest load so adding 1 will not modify the result
> > +      * of the comparison.
> > +      */
> > +     rq->misfit_task_load =3D task_h_load(p) + 1;
> >  }
> >
> >  #else /* CONFIG_SMP */
> > @@ -7664,6 +7670,16 @@ static int detach_tasks(struct lb_env *env)
> >                           env->sd->nr_balance_failed <=3D env->sd->cach=
e_nice_tries)
> >                               goto next;
> >
> > +                     /*
> > +                      * Depending of the number of CPUs and tasks and =
the
> > +                      * cgroup hierarchy, task_h_load() can return a n=
ull
> > +                      * value. Make sure that env->imbalance decreases
> > +                      * otherwise detach_tasks() will stop only after
> > +                      * detaching up to loop_max tasks.
> > +                      */
> > +                     if (!load)
> > +                             load =3D 1;
> > +
> >                       env->imbalance -=3D load;
> >                       break;
>
> I assume that this is related to the LKP mail

I have found this problem while studying the regression raised in the
email below but it doesn't fix it. At least, it's not enough

>
> https://lkml.kernel.org/r/20200421004749.GC26573@shao2-debian ?
>
> I ran the test (5.8.0-rc4 w/o vs. w/ your patch) on 'Intel(R) Xeon(R)
> CPU E5-2690 v2 @ 3.00GHz' (2*2*10, 40 CPUs).
> I can't see the changes in the magnitude shown in the email above (they
> used a 96 CPU system though).
> I used only scheduler stressor mmapfork in taskgroup /A/B/C:
>
>  stress-ng --timeout 1 --times --verify --metrics-brief --sequential 40 -=
-class scheduler --exclude (all except mmapfork)
>
> 5.8.0-rc4-custom-dieegg01-stress-ng-base
>
> stress-ng: info:  [3720]  stressor      bogo ops real time  usr time  sys=
 time   bogo ops/s   bogo ops/s
> stress-ng: info:  [3720]                           (secs)    (secs)    (s=
ecs)   (real time) (usr+sys time)
> stress-ng: info:  [3720]  mmapfork            40      1.98     12.53     =
71.12        20.21         0.48
> stress-ng: info:  [5201]  mmapfork            40      2.50     13.10     =
98.61        16.01         0.36
> stress-ng: info:  [6682]  mmapfork            40      2.58     14.80     =
98.63        15.88         0.36
> stress-ng: info:  [8195]  mmapfork            40      1.79     12.57     =
61.61        22.31         0.54
> stress-ng: info:  [9679]  mmapfork            40      2.20     12.17     =
82.66        18.20         0.42
> stress-ng: info:  [11164] mmapfork            40      2.61     15.09    1=
02.86        16.86         0.37
> stress-ng: info:  [12773] mmapfork            40      1.89     12.32     =
65.09        21.15         0.52
> stress-ng: info:  [3883]  mmapfork            40      2.14     12.90     =
76.73        18.68         0.45
> stress-ng: info:  [6845]  mmapfork            40      2.25     11.83     =
84.06        17.80         0.42
> stress-ng: info:  [8326]  mmapfork            40      1.76     12.93     =
56.65        22.70         0.57
>
>                                                                          =
       Mean: 18.98 (=CF=83: 2.369)
> 5.8.0-rc4-custom-dieegg01-stress-ng
>
> stress-ng: info:  [3895]  mmapfork            40      2.40     13.56     =
92.83        16.67         0.38
> stress-ng: info:  [5379]  mmapfork            40      2.08     13.65     =
74.11        19.23         0.46
> stress-ng: info:  [6860]  mmapfork            40      2.15     13.72     =
80.24        18.62         0.43
> stress-ng: info:  [8341]  mmapfork            40      2.37     13.74     =
90.93        16.85         0.38
> stress-ng: info:  [9822]  mmapfork            40      2.10     12.48     =
83.85        19.09         0.42
> stress-ng: info:  [13816] mmapfork            40      2.05     12.13     =
77.64        19.49         0.45
> stress-ng: info:  [15297] mmapfork            40      2.53     13.16    1=
00.26        15.84         0.35
> stress-ng: info:  [16780] mmapfork            40      2.00     12.10     =
71.25        20.02         0.48
> stress-ng: info:  [18262] mmapfork            40      1.73     12.24     =
57.69        23.09         0.57
> stress-ng: info:  [19743] mmapfork            40      1.78     12.51     =
57.89        22.48         0.57
>
>                                                                          =
       Mean: 19.14 (=CF=83: 2.239)
>
>
>
>
>
