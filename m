Return-Path: <SRS0=sqqi=7C=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 26FDFC433DF
	for <linux-kernel@archiver.kernel.org>; Wed, 20 May 2020 16:02:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E5AB22070A
	for <linux-kernel@archiver.kernel.org>; Wed, 20 May 2020 16:02:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="IHF+WyLK"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726844AbgETQCJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 20 May 2020 12:02:09 -0400
Received: from us-smtp-1.mimecast.com ([207.211.31.81]:57883 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726560AbgETQCI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 May 2020 12:02:08 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1589990526;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=KMQx3CJaDuLGpNTSBHpWIwiqV2cYKS8CUQMrDvjG1OI=;
        b=IHF+WyLKeCn+Dk/KeOnFfyyBOwEypwX3AZYh61Qe06YMWw/USmM3/uI67/JlpRR29xrDp9
        8koYFsu36S/kSM3aC5poBiLGO3OPr4sSNkGcWF2ghRBJQpwwt3ExDG8qhg/3Jth+SEVa9H
        vIWvRJiSwkFng7VmRGviiIQhf5CT3xU=
Received: from mail-ej1-f71.google.com (mail-ej1-f71.google.com
 [209.85.218.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-343-b8VpCxxpPZayDUKteklelw-1; Wed, 20 May 2020 12:01:32 -0400
X-MC-Unique: b8VpCxxpPZayDUKteklelw-1
Received: by mail-ej1-f71.google.com with SMTP id gl5so1540948ejb.5
        for <linux-kernel@vger.kernel.org>; Wed, 20 May 2020 09:01:32 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=KMQx3CJaDuLGpNTSBHpWIwiqV2cYKS8CUQMrDvjG1OI=;
        b=Q+Iju85NER9joNC4XMd9qoqbACAswh9D/PzsCjvyWTFfx36qmh20LTHNoGy4tik7a6
         1qET1kAsPxrLYLxK7+BsNUcqw3GSw6JreG+L49WlZ1pozVNMA0kzSTjI5VksBnJUxI0R
         btFxcuTn5NV6r826QFgBjEM2ais3uGYwnJEsvvfpVgQni9MNB8scCUzaYwCqin1fBgG8
         h8QHi0smyBxh4y6r1nwKnMmREMfe+PbKB2h7mP6RJJy6g7E3E3S4x8pLj2TpM6K8p4nc
         peNjeCUjksoERwPRxw2L0nDDkbDz6o1DMN22wSULJdmbCwSweJGvvRXnesR7DxjDGneD
         3Zyw==
X-Gm-Message-State: AOAM532ei4fP4bTdjwJnTqaoAoIW4ajDlbx8b251B118nmXZ0maujBgv
        O7h4YNabhWP5kBN2SHTH5I4SdG2aXUsI7iFm1yG+gpcGXwNzKpG9UESrXnmLpgP7kcG/s1HOoWL
        UJCrZVW1cHiKeAoLnGRSHP5Pc6j1FIuaEaLveMfPe
X-Received: by 2002:a05:6402:31ad:: with SMTP id dj13mr4175765edb.232.1589990490999;
        Wed, 20 May 2020 09:01:30 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJzT9suogOnoQUaF/gxrh/lSHkNmFGj8jKQHtSgp0nG/kUUrYtFstNCEi3zmWpJfNw4m2Rq4QNGA6RtD20kKDfU=
X-Received: by 2002:a05:6402:31ad:: with SMTP id dj13mr4175708edb.232.1589990490525;
 Wed, 20 May 2020 09:01:30 -0700 (PDT)
MIME-Version: 1.0
References: <CAE4VaGD8DUEi6JnKd8vrqUL_8HZXnNyHMoK2D+1-F5wo+5Z53Q@mail.gmail.com>
 <20200312214736.GA3818@techsingularity.net> <CAE4VaGCfDpu0EuvHNHwDGbR-HNBSAHY=yu3DJ33drKgymMTTOw@mail.gmail.com>
 <CAE4VaGC09OfU2zXeq2yp_N0zXMbTku5ETz0KEocGi-RSiKXv-w@mail.gmail.com>
 <20200320152251.GC3818@techsingularity.net> <CAE4VaGBGbTT8dqNyLWAwuiqL8E+3p1_SqP6XTTV71wNZMjc9Zg@mail.gmail.com>
 <20200320163843.GD3818@techsingularity.net> <CAE4VaGCf0P2ht+7nbGFHV8Dd=e4oDEUPNdRUUBokRWgKRxofAA@mail.gmail.com>
 <20200507155422.GD3758@techsingularity.net> <CAE4VaGCDTeE16nNmSS8fGzCBvHsO=qkJAW6yDiORAxgsPi-Ziw@mail.gmail.com>
 <20200507174934.GD19331@lorien.usersys.redhat.com> <20200508034741.13036-1-hdanton@sina.com>
 <CAE4VaGDBAquxbBjuzzyaT1WPR95wiaiHsrEPs-eOP2W+r=fQFg@mail.gmail.com>
 <20200519043154.10876-1-hdanton@sina.com> <CAE4VaGAxqK_gr7gstk1S8z3vx+9c6rG-Xo_kUiAzuOWpqOR4cQ@mail.gmail.com>
In-Reply-To: <CAE4VaGAxqK_gr7gstk1S8z3vx+9c6rG-Xo_kUiAzuOWpqOR4cQ@mail.gmail.com>
From:   Jirka Hladky <jhladky@redhat.com>
Date:   Wed, 20 May 2020 18:01:19 +0200
Message-ID: <CAE4VaGBsjVYc0kOXjm8OgRQgg73rUcyovMAiqcTO7VhbOhxUFw@mail.gmail.com>
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

I have an update on netperf-cstate-small-cross-socket results.

Reported performance degradation of 2.5% for the UDP stream throughput
and 0.6% for the TCP throughput is for message size of 16kB. For
smaller message sizes, the performance drop is higher - up to 5% for
UDP throughput for a message size of 64B. See the numbers below [1]

We still think that it's acceptable given the gains in other
situations (this is again compared to 5.7 vanilla) :

* solved the performance drop upto 20%  with single instance
SPECjbb2005 benchmark on 8 NUMA node servers (particularly on AMD EPYC
Rome systems) => this performance drop was INCREASING with higher
threads counts (10% for 16 threads and 20 % for 32 threads)
* solved the performance drop upto 50% for low load scenarios
(SPECjvm2008 and NAS)

[1]
Hillf's patch compared to 5.7 (rc4) vanilla:

TCP throughput
Message size (B)
64          -2.6%
128        -2.3%
256        -2.6%
1024      -2.7%
2048      -2.2%
3312      -2.4%
4096      -1.1%
8192      -0.4%
16384    -0.6%

UDP throughput
64          -5.0%
128        -3.0%
256        -3.0%
1024      -3.1%
2048      -3.3%
3312      -3.5%
4096      -4.0%
8192      -3.3%
16384    -2.6%


On Wed, May 20, 2020 at 3:58 PM Jirka Hladky <jhladky@redhat.com> wrote:
>
> Hi Hillf, Mel and all,
>
> thanks for the patch! It has produced really GOOD results.
>
> 1) It has fixed performance problems with 5.7 vanilla kernel for
> single-tenant workload and low system load scenarios, without
> performance degradation for the multi-tenant tasks. It's producing the
> same results as the previous proof-of-concept patch where
> adjust_numa_imbalance function was modified to be a no-op (returning
> the same value of imbalance as it gets on the input).
>
> 2) We have also added Mel's netperf-cstate-small-cross-socket test to
> our test battery:
> https://github.com/gormanm/mmtests/blob/master/configs/config-network-netperf-cstate-small-cross-socket
>
> Mel told me that he had seen significant performance improvements with
> 5.7 over 5.6 for the netperf-cstate-small-cross-socket scenario.
>
> Out of 6 different patches we have tested, your patch has performed
> the best for this scenario. Compared to vanilla, we see minimal
> performance degradation of 2.5% for the udp stream throughput and 0.6%
> for the tcp throughput. The testing was done on a dual-socket system
> with Gold 6132 CPU.
>
> @Mel - could you please test Hillf's patch with your full testing
> suite? So far, it looks very promising, but I would like to check the
> patch thoroughly to make sure it does not hurt performance in other
> areas.
>
> Thanks a lot!
> Jirka
>
>
>
>
>
>
>
>
>
>
>
>
> On Tue, May 19, 2020 at 6:32 AM Hillf Danton <hdanton@sina.com> wrote:
> >
> >
> > Hi Jirka
> >
> > On Mon, 18 May 2020 16:52:52 +0200 Jirka Hladky wrote:
> > >
> > > We have compared it against kernel with adjust_numa_imbalance disabled
> > > [1], and both kernels perform at the same level for the single-tenant
> > > jobs, but the proposed patch is bad for the multitenancy mode. The
> > > kernel with adjust_numa_imbalance disabled is a clear winner here.
> >
> > Double thanks to you for the tests!
> >
> > > We would be very interested in what others think about disabling
> > > adjust_numa_imbalance function. The patch is bellow. It would be great
> >
> > A minute...
> >
> > > to collect performance results for different scenarios to make sure
> > > the results are objective.
> >
> > I don't have another test case but a diff trying to confine the tool
> > in question back to the hard-coded 2's field.
> >
> > It's used in the first hunk below to detect imbalance before migrating
> > a task, and a small churn of code is added at another call site when
> > balancing idle CPUs.
> >
> > Thanks
> > Hillf
> >
> > --- a/kernel/sched/fair.c
> > +++ b/kernel/sched/fair.c
> > @@ -1916,20 +1916,26 @@ static void task_numa_find_cpu(struct ta
> >          * imbalance that would be overruled by the load balancer.
> >          */
> >         if (env->dst_stats.node_type == node_has_spare) {
> > -               unsigned int imbalance;
> > -               int src_running, dst_running;
> > +               unsigned int imbalance = 2;
> >
> > -               /*
> > -                * Would movement cause an imbalance? Note that if src has
> > -                * more running tasks that the imbalance is ignored as the
> > -                * move improves the imbalance from the perspective of the
> > -                * CPU load balancer.
> > -                * */
> > -               src_running = env->src_stats.nr_running - 1;
> > -               dst_running = env->dst_stats.nr_running + 1;
> > -               imbalance = max(0, dst_running - src_running);
> > -               imbalance = adjust_numa_imbalance(imbalance, src_running);
> > +               //No imbalance computed without spare capacity
> > +               if (env->dst_stats.node_type != env->src_stats.node_type)
> > +                       goto check_imb;
> > +
> > +               imbalance = adjust_numa_imbalance(imbalance,
> > +                                               env->src_stats.nr_running);
> > +
> > +               //Do nothing without imbalance
> > +               if (!imbalance) {
> > +                       imbalance = 2;
> > +                       goto check_imb;
> > +               }
> > +
> > +               //Migrate task if it's likely to grow balance
> > +               if (env->dst_stats.nr_running + 1 < env->src_stats.nr_running)
> > +                       imbalance = 0;
> >
> > +check_imb:
> >                 /* Use idle CPU if there is no imbalance */
> >                 if (!imbalance) {
> >                         maymove = true;
> > @@ -9011,12 +9017,13 @@ static inline void calculate_imbalance(s
> >                         env->migration_type = migrate_task;
> >                         env->imbalance = max_t(long, 0, (local->idle_cpus -
> >                                                  busiest->idle_cpus) >> 1);
> > -               }
> >
> > -               /* Consider allowing a small imbalance between NUMA groups */
> > -               if (env->sd->flags & SD_NUMA)
> > -                       env->imbalance = adjust_numa_imbalance(env->imbalance,
> > -                                               busiest->sum_nr_running);
> > +                       /* Consider allowing a small imbalance between NUMA groups */
> > +                       if (env->sd->flags & SD_NUMA &&
> > +                           local->group_type == busiest->group_type)
> > +                               env->imbalance = adjust_numa_imbalance(env->imbalance,
> > +                                                       busiest->sum_nr_running);
> > +               }
> >
> >                 return;
> >         }
> > --
> >
>
>
> --
> -Jirka



-- 
-Jirka

