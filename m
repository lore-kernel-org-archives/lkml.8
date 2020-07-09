Return-Path: <SRS0=8wH5=AU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1D1A3C433DF
	for <linux-kernel@archiver.kernel.org>; Thu,  9 Jul 2020 13:51:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E53FB207FB
	for <linux-kernel@archiver.kernel.org>; Thu,  9 Jul 2020 13:51:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="WYIv4EPD"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727834AbgGINvZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 9 Jul 2020 09:51:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40702 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726358AbgGINvZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Jul 2020 09:51:25 -0400
Received: from mail-lj1-x241.google.com (mail-lj1-x241.google.com [IPv6:2a00:1450:4864:20::241])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B4716C08C5CE
        for <linux-kernel@vger.kernel.org>; Thu,  9 Jul 2020 06:51:24 -0700 (PDT)
Received: by mail-lj1-x241.google.com with SMTP id q7so2502499ljm.1
        for <linux-kernel@vger.kernel.org>; Thu, 09 Jul 2020 06:51:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=OMmGFiM5wZvylNqtr2CfBk2MvkCWGsBEORBKOC6AJtU=;
        b=WYIv4EPDk1sP0EDqyQ6yQhaF0ahSuSWPYVys127cyyrQRYH17mGNM9KL6YkWIIlpgl
         gfOLNRCNfRD590jGetuk3vgAAueI8stSPXGcIbK81zTojc+zTrp5eEYira+35tlTIjlB
         Yz4T1SFCv/f+uAmJgOr828J0/RFXZn7zNISwdpkPDHd/n/ALW+aDd6M3isb9vCniUyDQ
         oDhWwvrDOUA/HanGmAh+8LKYVSRqIor/dTjlBF1QlVeQRiQTfWIl74BQ066jhoowpb1A
         ntJ/mVxyld/xjMf8190eZdAnbapZ85dFFxIFxUyWV/3EKOx2i5urSmhp2ycfP7ldJaIH
         p+Yg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=OMmGFiM5wZvylNqtr2CfBk2MvkCWGsBEORBKOC6AJtU=;
        b=FgEdv48HdQRSGyUePTimi02NgivaGTLUEYzYO6UeQZ8cX9SKSC2SHZB/o9SbkNpCaI
         Z6PAQA9s0f+eU+5Bw41+HfSysnw+7QrrX36t6qhQ1/20jjPBNSAVQ6+gxFlypcoj0GlD
         xp1DOmZR+gnPPG2QE22U8WiZk7+H25QEDw192552omyShANaay9G/HTZDSMIkCnVHxpZ
         F2OcwOJdp4VSKTjHleHB+bDYGd/8zLTEqY3yRvZmllTgr4yivnI7ebA+tvEjkxevdKd6
         UL7XhD+K44tAzEB6gMgi/ANdymVWvrQKx2OTh8+4q7swHlfRMPQHFaFLI/gXGsIUcKCE
         248A==
X-Gm-Message-State: AOAM531t1TjErLz88BAzjQ1mcrxSQZ8Qcl7Bx3rABamTkMc+P79vvYg2
        j0lJ2InsUcpQ7+jIA7Z6Xt6lT1Pov7ga31kf4H6ufFTL
X-Google-Smtp-Source: ABdhPJxb0UBsaQeh2wIkM4KVhzDkkP/wpab6lPBXYITv0teE6BOMlOjz/erXQ9cJJwROkafNA9zRF1bNGEm0LoQEeo0=
X-Received: by 2002:a2e:8059:: with SMTP id p25mr20507176ljg.156.1594302683087;
 Thu, 09 Jul 2020 06:51:23 -0700 (PDT)
MIME-Version: 1.0
References: <20200702144258.19326-1-vincent.guittot@linaro.org> <jhjsge0ltwk.mognet@arm.com>
In-Reply-To: <jhjsge0ltwk.mognet@arm.com>
From:   Vincent Guittot <vincent.guittot@linaro.org>
Date:   Thu, 9 Jul 2020 15:51:11 +0200
Message-ID: <CAKfTPtDNziLmAN4aFiiKoujkavs-pkFKs6A=Fyy4nv_vaGB5Lw@mail.gmail.com>
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

On Thu, 9 Jul 2020 at 15:06, Valentin Schneider
<valentin.schneider@arm.com> wrote:
>
>
> On 02/07/20 15:42, Vincent Guittot wrote:
> > task_h_load() can return 0 in some situations like running stress-ng
> > mmapfork, which forks thousands of threads, in a sched group on a 224 cores
> > system. The load balance doesn't handle this correctly because
> > env->imbalance never decreases and it will stop pulling tasks only after
> > reaching loop_max, which can be equal to the number of running tasks of
> > the cfs. Make sure that imbalance will be decreased by at least 1.
> >
> > misfit task is the other feature that doesn't handle correctly such
> > situation although it's probably more difficult to face the problem
> > because of the smaller number of CPUs and running tasks on heterogenous
> > system.
> >
> > We can't simply ensure that task_h_load() returns at least one because it
> > would imply to handle underrun in other places.
> >
> > Signed-off-by: Vincent Guittot <vincent.guittot@linaro.org>
>
> I dug some more into this; if I got my math right, this can be reproduced
> with a single task group below the root. Forked tasks get max load, so this
> can be tried out with either tons of forks or tons of CPU hogs.
>
> We need
>
>   p->se.avg.load_avg * cfs_rq->h_load
>   -----------------------------------  < 1
>     cfs_rq_load_avg(cfs_rq) + 1
>
> Assuming homogeneous system with tasks spread out all over (no other tasks
> interfering), that should boil down to
>
>   1024 * (tg.shares / nr_cpus)
>   ---------------------------  < 1
>   1024 * (nr_tasks_on_cpu)
>
> IOW
>
>   tg.shares / nr_cpus < nr_tasks_on_cpu
>
> If we get tasks nicely spread out, a simple condition to hit this should be
> to have more tasks than shares.
>
> I can hit task_h_load=0 with the following on my Juno (pinned to one CPU to
> make things simpler; big.LITTLE doesn't yield equal weights between CPUs):
>
>   cgcreate -g cpu:tg0
>
>   echo 128 > /sys/fs/cgroup/cpu/tg0/cpu.shares
>
>   for ((i=0; i<130; i++)); do
>       # busy loop of your choice
>       taskset -c 0 ./loop.sh &
>       echo $! > /sys/fs/cgroup/cpu/tg0/tasks
>   done
>
> > ---
> >  kernel/sched/fair.c | 18 +++++++++++++++++-
> >  1 file changed, 17 insertions(+), 1 deletion(-)
> >
> > diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
> > index 6fab1d17c575..62747c24aa9e 100644
> > --- a/kernel/sched/fair.c
> > +++ b/kernel/sched/fair.c
> > @@ -4049,7 +4049,13 @@ static inline void update_misfit_status(struct task_struct *p, struct rq *rq)
> >               return;
> >       }
> >
> > -     rq->misfit_task_load = task_h_load(p);
> > +     /*
> > +      * Make sure that misfit_task_load will not be null even if
> > +      * task_h_load() returns 0. misfit_task_load is only used to select
> > +      * rq with highest load so adding 1 will not modify the result
> > +      * of the comparison.
> > +      */
> > +     rq->misfit_task_load = task_h_load(p) + 1;
>
> For here and below; wouldn't it be a tad cleaner to just do
>
>         foo = max(task_h_load(p), 1);

+1

For the one below, my goal was mainly to not impact the result of the
tests before applying the +1 but doing it before will not change the
results

I'm going to update it

>
> Otherwise, I think I've properly convinced myself we do want to have
> that in one form or another. So either way:
>
> Reviewed-by: Valentin Schneider <valentin.schneider@arm.com>

Thanks

>
> >  }
> >
> >  #else /* CONFIG_SMP */
> > @@ -7664,6 +7670,16 @@ static int detach_tasks(struct lb_env *env)
> >                           env->sd->nr_balance_failed <= env->sd->cache_nice_tries)
> >                               goto next;
> >
> > +                     /*
> > +                      * Depending of the number of CPUs and tasks and the
> > +                      * cgroup hierarchy, task_h_load() can return a null
> > +                      * value. Make sure that env->imbalance decreases
> > +                      * otherwise detach_tasks() will stop only after
> > +                      * detaching up to loop_max tasks.
> > +                      */
> > +                     if (!load)
> > +                             load = 1;
> > +
> >                       env->imbalance -= load;
> >                       break;
