Return-Path: <SRS0=sqqi=7C=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 84DDEC433E0
	for <linux-kernel@archiver.kernel.org>; Wed, 20 May 2020 13:58:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 578C5207F9
	for <linux-kernel@archiver.kernel.org>; Wed, 20 May 2020 13:58:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="J5Ja4BtS"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726718AbgETN6V (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 20 May 2020 09:58:21 -0400
Received: from us-smtp-2.mimecast.com ([205.139.110.61]:49000 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726486AbgETN6U (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 May 2020 09:58:20 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1589983098;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=+6p4jdAvCMC0iizzaffYOBefDLg5kSFsX+MrN5miuVs=;
        b=J5Ja4BtSGU3XkqkWRPtxpGj6vrrpoa0kJTGFo8mXYgInJmNjt4hYe2SjaLwLo/hWYxDV9c
        y9TdJxBB0n/ZXoedWxcTKujYB0uO8G01r3mwXwFTKvsBSqXNP9KjQAb7Uz4xVW30Iw4DvW
        /Lg7G22KMIkCi0DWEHCehQpWnM0GiGo=
Received: from mail-ej1-f71.google.com (mail-ej1-f71.google.com
 [209.85.218.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-108-0iyzYYn5PaSCCe8Ux0C1bQ-1; Wed, 20 May 2020 09:58:14 -0400
X-MC-Unique: 0iyzYYn5PaSCCe8Ux0C1bQ-1
Received: by mail-ej1-f71.google.com with SMTP id c9so1364359ejr.16
        for <linux-kernel@vger.kernel.org>; Wed, 20 May 2020 06:58:14 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=+6p4jdAvCMC0iizzaffYOBefDLg5kSFsX+MrN5miuVs=;
        b=DNgw8QmHV8K6RejRdloGMhetifn2BcDWyc5o338AnOA3fHgHrGe1mUqB9H1WBTQHQh
         TLMG7PQrmYbwBE95iUKtkgxvojPPoRsVE9kxZlgRAJtJjwxaKtorZXr7G0KmrsrOhXTj
         EBQ+AhUiyiv/srIvBqCXCr1aac3fk9OwlBh8FCObV+hUXbfBdUo181i0IWcKcWJHU7tZ
         Q2gGuL0du7N3c4bFglf9NiBJX4qwukMcdFGj8yCoOd4hnUOpxiNrL/ZjyRXcrb/h3ns4
         wS2CjtE7fDWhvmwHxxknKiLOz4GEelr9bIQgTPU7nvI0SpeQCknHPloyhofZd9zExgkr
         RV6Q==
X-Gm-Message-State: AOAM533+BMRlyvNJnWrm+gPPUeuHUDWlmrmN/o5D/fVVew3F2GGkQ/rI
        p+D9GrKf+w7pofxOFWLslVNoNm7aeeFdI9jNmOW/tNJ3Adja8YYAgP+vLBQW1Q49P99Zmb9Mo+h
        Tnn7mQ8cinHbpCEp9ohDMio/DwOp82imJe8HP3gU0
X-Received: by 2002:a17:906:ce39:: with SMTP id sd25mr3923285ejb.477.1589983093410;
        Wed, 20 May 2020 06:58:13 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJyyhdjVDrVULc74i7yTtFnNL3+QsexeKRP5wQGf5rAUvj8ueQ+O8jEvI/aEw7C2H8EXSJVg5cL2ciozwIH0Grs=
X-Received: by 2002:a17:906:ce39:: with SMTP id sd25mr3923259ejb.477.1589983093142;
 Wed, 20 May 2020 06:58:13 -0700 (PDT)
MIME-Version: 1.0
References: <CAE4VaGD8DUEi6JnKd8vrqUL_8HZXnNyHMoK2D+1-F5wo+5Z53Q@mail.gmail.com>
 <20200312214736.GA3818@techsingularity.net> <CAE4VaGCfDpu0EuvHNHwDGbR-HNBSAHY=yu3DJ33drKgymMTTOw@mail.gmail.com>
 <CAE4VaGC09OfU2zXeq2yp_N0zXMbTku5ETz0KEocGi-RSiKXv-w@mail.gmail.com>
 <20200320152251.GC3818@techsingularity.net> <CAE4VaGBGbTT8dqNyLWAwuiqL8E+3p1_SqP6XTTV71wNZMjc9Zg@mail.gmail.com>
 <20200320163843.GD3818@techsingularity.net> <CAE4VaGCf0P2ht+7nbGFHV8Dd=e4oDEUPNdRUUBokRWgKRxofAA@mail.gmail.com>
 <20200507155422.GD3758@techsingularity.net> <CAE4VaGCDTeE16nNmSS8fGzCBvHsO=qkJAW6yDiORAxgsPi-Ziw@mail.gmail.com>
 <20200507174934.GD19331@lorien.usersys.redhat.com> <20200508034741.13036-1-hdanton@sina.com>
 <CAE4VaGDBAquxbBjuzzyaT1WPR95wiaiHsrEPs-eOP2W+r=fQFg@mail.gmail.com> <20200519043154.10876-1-hdanton@sina.com>
In-Reply-To: <20200519043154.10876-1-hdanton@sina.com>
From:   Jirka Hladky <jhladky@redhat.com>
Date:   Wed, 20 May 2020 15:58:01 +0200
Message-ID: <CAE4VaGAxqK_gr7gstk1S8z3vx+9c6rG-Xo_kUiAzuOWpqOR4cQ@mail.gmail.com>
Subject: Re: [PATCH 00/13] Reconcile NUMA balancing decisions with the load
 balancer v6
To:     Hillf Danton <hdanton@sina.com>
Cc:     Phil Auld <pauld@redhat.com>,
        Mel Gorman <mgorman@techsingularity.net>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@kernel.org>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Juri Lelli <juri.lelli@redhat.com>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Ben Segall <bsegall@google.com>,
        Valentin Schneider <valentin.schneider@arm.com>,
        LKML <linux-kernel@vger.kernel.org>,
        Douglas Shakshober <dshaks@redhat.com>,
        Waiman Long <longman@redhat.com>,
        Joe Mario <jmario@redhat.com>, Bill Gray <bgray@redhat.com>,
        "aokuliar@redhat.com" <aokuliar@redhat.com>,
        "kkolakow@redhat.com" <kkolakow@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Hillf, Mel and all,

thanks for the patch! It has produced really GOOD results.

1) It has fixed performance problems with 5.7 vanilla kernel for
single-tenant workload and low system load scenarios, without
performance degradation for the multi-tenant tasks. It's producing the
same results as the previous proof-of-concept patch where
adjust_numa_imbalance function was modified to be a no-op (returning
the same value of imbalance as it gets on the input).

2) We have also added Mel's netperf-cstate-small-cross-socket test to
our test battery:
https://github.com/gormanm/mmtests/blob/master/configs/config-network-netperf-cstate-small-cross-socket

Mel told me that he had seen significant performance improvements with
5.7 over 5.6 for the netperf-cstate-small-cross-socket scenario.

Out of 6 different patches we have tested, your patch has performed
the best for this scenario. Compared to vanilla, we see minimal
performance degradation of 2.5% for the udp stream throughput and 0.6%
for the tcp throughput. The testing was done on a dual-socket system
with Gold 6132 CPU.

@Mel - could you please test Hillf's patch with your full testing
suite? So far, it looks very promising, but I would like to check the
patch thoroughly to make sure it does not hurt performance in other
areas.

Thanks a lot!
Jirka












On Tue, May 19, 2020 at 6:32 AM Hillf Danton <hdanton@sina.com> wrote:
>
>
> Hi Jirka
>
> On Mon, 18 May 2020 16:52:52 +0200 Jirka Hladky wrote:
> >
> > We have compared it against kernel with adjust_numa_imbalance disabled
> > [1], and both kernels perform at the same level for the single-tenant
> > jobs, but the proposed patch is bad for the multitenancy mode. The
> > kernel with adjust_numa_imbalance disabled is a clear winner here.
>
> Double thanks to you for the tests!
>
> > We would be very interested in what others think about disabling
> > adjust_numa_imbalance function. The patch is bellow. It would be great
>
> A minute...
>
> > to collect performance results for different scenarios to make sure
> > the results are objective.
>
> I don't have another test case but a diff trying to confine the tool
> in question back to the hard-coded 2's field.
>
> It's used in the first hunk below to detect imbalance before migrating
> a task, and a small churn of code is added at another call site when
> balancing idle CPUs.
>
> Thanks
> Hillf
>
> --- a/kernel/sched/fair.c
> +++ b/kernel/sched/fair.c
> @@ -1916,20 +1916,26 @@ static void task_numa_find_cpu(struct ta
>          * imbalance that would be overruled by the load balancer.
>          */
>         if (env->dst_stats.node_type == node_has_spare) {
> -               unsigned int imbalance;
> -               int src_running, dst_running;
> +               unsigned int imbalance = 2;
>
> -               /*
> -                * Would movement cause an imbalance? Note that if src has
> -                * more running tasks that the imbalance is ignored as the
> -                * move improves the imbalance from the perspective of the
> -                * CPU load balancer.
> -                * */
> -               src_running = env->src_stats.nr_running - 1;
> -               dst_running = env->dst_stats.nr_running + 1;
> -               imbalance = max(0, dst_running - src_running);
> -               imbalance = adjust_numa_imbalance(imbalance, src_running);
> +               //No imbalance computed without spare capacity
> +               if (env->dst_stats.node_type != env->src_stats.node_type)
> +                       goto check_imb;
> +
> +               imbalance = adjust_numa_imbalance(imbalance,
> +                                               env->src_stats.nr_running);
> +
> +               //Do nothing without imbalance
> +               if (!imbalance) {
> +                       imbalance = 2;
> +                       goto check_imb;
> +               }
> +
> +               //Migrate task if it's likely to grow balance
> +               if (env->dst_stats.nr_running + 1 < env->src_stats.nr_running)
> +                       imbalance = 0;
>
> +check_imb:
>                 /* Use idle CPU if there is no imbalance */
>                 if (!imbalance) {
>                         maymove = true;
> @@ -9011,12 +9017,13 @@ static inline void calculate_imbalance(s
>                         env->migration_type = migrate_task;
>                         env->imbalance = max_t(long, 0, (local->idle_cpus -
>                                                  busiest->idle_cpus) >> 1);
> -               }
>
> -               /* Consider allowing a small imbalance between NUMA groups */
> -               if (env->sd->flags & SD_NUMA)
> -                       env->imbalance = adjust_numa_imbalance(env->imbalance,
> -                                               busiest->sum_nr_running);
> +                       /* Consider allowing a small imbalance between NUMA groups */
> +                       if (env->sd->flags & SD_NUMA &&
> +                           local->group_type == busiest->group_type)
> +                               env->imbalance = adjust_numa_imbalance(env->imbalance,
> +                                                       busiest->sum_nr_running);
> +               }
>
>                 return;
>         }
> --
>


-- 
-Jirka

