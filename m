Return-Path: <SRS0=RE5T=7A=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E4E21C433DF
	for <linux-kernel@archiver.kernel.org>; Mon, 18 May 2020 14:53:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B4D7420674
	for <linux-kernel@archiver.kernel.org>; Mon, 18 May 2020 14:53:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="VBs84BY5"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727973AbgEROxK (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 18 May 2020 10:53:10 -0400
Received: from us-smtp-2.mimecast.com ([207.211.31.81]:58110 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726918AbgEROxJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 May 2020 10:53:09 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1589813587;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=dDIXW0PXydkPcg60drrr8hqfRN3jAbv+LFPuW+ViSe4=;
        b=VBs84BY5HqA40/oGU5sLMMJzkmDFGCgo+F6tlmD76HuD4faP0xfNficEqRwpJj6z+ZnAR+
        uWZF/SHDmd5/logBcupheW7puSt3J8wXwuAR0HAQ9/dtwlGsS+lVwp1yA08rmbiR3uI8FD
        jj9Z8LQIci5o/bEjihlEjWicrc3m03E=
Received: from mail-ed1-f71.google.com (mail-ed1-f71.google.com
 [209.85.208.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-217-rjs8GbYeNpSYpSgKKZrwdA-1; Mon, 18 May 2020 10:53:05 -0400
X-MC-Unique: rjs8GbYeNpSYpSgKKZrwdA-1
Received: by mail-ed1-f71.google.com with SMTP id e1so3359007edn.14
        for <linux-kernel@vger.kernel.org>; Mon, 18 May 2020 07:53:05 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=dDIXW0PXydkPcg60drrr8hqfRN3jAbv+LFPuW+ViSe4=;
        b=K47XIJjkEdN54Mb+3xAjjCdcOlGgoIHFNnHUHd3J2Xz37GnIOpqYawTzJwc87VwDD9
         eacFjhEhIHKqJvKYYVLNmYPHkkIgEMpdZnauVHCSLURE4Zk3SlU77Hh/2g/QRWk0AgJw
         nDTD2PpVnWKDAFEEdU5IO/7tYBFgs/vUzCcM+z1WqGy61Tj27uIewV2l+PN8kRKTwh+B
         UTMe5MjJiDG9B9a9VU++Y6jNLMSDZDMxoSRO4U51+wpIzhxtzT7IWfDnZ7d9n0aPfB+d
         XeZFpRStLes6a1TEiTvnxka8pYrbRDyFdrUqLGNKPbwN03a2C5aX8gUiaFewrDtGIp2r
         v2Jw==
X-Gm-Message-State: AOAM531ZDTRC4M8Q96Ssj6sdicHTphbll5qyxpv7XEC0ZQwGOo/lcfYx
        MS2nQOfZHq0lm2USbDl/xKRFginajGGTpHKfpudTvnOor+ipVb6r6MBam5to+7HPBOETHmSBnQ1
        tf9clrjoR9S9a49KQkIY2NxpEk1DY9R70AiLVIM6l
X-Received: by 2002:a17:906:5004:: with SMTP id s4mr15837113ejj.13.1589813584122;
        Mon, 18 May 2020 07:53:04 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJzDPDmzmLfAVsUSo7IIHKsgACVICNjKbLShsqi+qd/o4Ekm/ZsQ1vaPT99guG9fR6UjS3xwWSTKDAcONW+cEvA=
X-Received: by 2002:a17:906:5004:: with SMTP id s4mr15837080ejj.13.1589813583772;
 Mon, 18 May 2020 07:53:03 -0700 (PDT)
MIME-Version: 1.0
References: <CAE4VaGD8DUEi6JnKd8vrqUL_8HZXnNyHMoK2D+1-F5wo+5Z53Q@mail.gmail.com>
 <20200312214736.GA3818@techsingularity.net> <CAE4VaGCfDpu0EuvHNHwDGbR-HNBSAHY=yu3DJ33drKgymMTTOw@mail.gmail.com>
 <CAE4VaGC09OfU2zXeq2yp_N0zXMbTku5ETz0KEocGi-RSiKXv-w@mail.gmail.com>
 <20200320152251.GC3818@techsingularity.net> <CAE4VaGBGbTT8dqNyLWAwuiqL8E+3p1_SqP6XTTV71wNZMjc9Zg@mail.gmail.com>
 <20200320163843.GD3818@techsingularity.net> <CAE4VaGCf0P2ht+7nbGFHV8Dd=e4oDEUPNdRUUBokRWgKRxofAA@mail.gmail.com>
 <20200507155422.GD3758@techsingularity.net> <CAE4VaGCDTeE16nNmSS8fGzCBvHsO=qkJAW6yDiORAxgsPi-Ziw@mail.gmail.com>
 <20200507174934.GD19331@lorien.usersys.redhat.com> <20200508034741.13036-1-hdanton@sina.com>
In-Reply-To: <20200508034741.13036-1-hdanton@sina.com>
From:   Jirka Hladky <jhladky@redhat.com>
Date:   Mon, 18 May 2020 16:52:52 +0200
Message-ID: <CAE4VaGDBAquxbBjuzzyaT1WPR95wiaiHsrEPs-eOP2W+r=fQFg@mail.gmail.com>
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
        Joe Mario <jmario@redhat.com>, Bill Gray <bgray@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Hillf,

thanks a lot for your patch!

Compared to 5.7 rc4 vanilla, we observe the following:
  * Single-tenant jobs show improvement up to 15% for SPECjbb2005 and
up to 100% for NAS in low thread mode. In other words, it fixes all
the problems we have reported in this thread.
  * Multitenancy jobs show performance degradation up to 30% for SPECjbb2005

While it fixes problems with single-tenant jobs and with a performance
at low system load, it breaks multi-tenant tasks.

We have compared it against kernel with adjust_numa_imbalance disabled
[1], and both kernels perform at the same level for the single-tenant
jobs, but the proposed patch is bad for the multitenancy mode. The
kernel with adjust_numa_imbalance disabled is a clear winner here.

We would be very interested in what others think about disabling
adjust_numa_imbalance function. The patch is bellow. It would be great
to collect performance results for different scenarios to make sure
the results are objective.

Thanks a lot!
Jirka

[1] Patch to test kernel with adjust_numa_imbalance disabled:
===============================================
diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
index 02f323b..8c43d29 100644
--- a/kernel/sched/fair.c
+++ b/kernel/sched/fair.c
@@ -8907,14 +8907,6 @@ static inline long adjust_numa_imbalance(int
imbalance, int src_nr_running)
{
       unsigned int imbalance_min;

-       /*
-        * Allow a small imbalance based on a simple pair of communicating
-        * tasks that remain local when the source domain is almost idle.
-        */
-       imbalance_min = 2;
-       if (src_nr_running <= imbalance_min)
-               return 0;
-
       return imbalance;
}
===============================================





On Fri, May 8, 2020 at 5:47 AM Hillf Danton <hdanton@sina.com> wrote:
>
>
> On Thu, 7 May 2020 13:49:34 Phil Auld wrote:
> >
> > On Thu, May 07, 2020 at 06:29:44PM +0200 Jirka Hladky wrote:
> > > Hi Mel,
> > >
> > > we are not targeting just OMP applications. We see the performance
> > > degradation also for other workloads, like SPECjbb2005 and
> > > SPECjvm2008. Even worse, it also affects a higher number of threads.
> > > For example, comparing 5.7.0-0.rc2 against 5.6 kernel, on 4 NUMA
> > > server with 2x AMD 7351 CPU, we see performance degradation 22% for 32
> > > threads (the system has 64 CPUs in total). We observe this degradation
> > > only when we run a single SPECjbb binary. When running 4 SPECjbb
> > > binaries in parallel, there is no change in performance between 5.6
> > > and 5.7.
> > >
> > > That's why we are asking for the kernel tunable, which we would add to
> > > the tuned profile. We don't expect users to change this frequently but
> > > rather to set the performance profile once based on the purpose of the
> > > server.
> > >
> > > If you could prepare a patch for us, we would be more than happy to
> > > test it extensively. Based on the results, we can then evaluate if
> > > it's the way to go. Thoughts?
> > >
> >
> > I'm happy to spin up a patch once I'm sure what exactly the tuning would
> > effect. At an initial glance I'm thinking it would be the imbalance_min
> > which is currently hardcoded to 2. But there may be something else...
>
> hrm... try to restore the old behavior by skipping task migrate in favor
> of the local node if there is no imbalance.
>
> --- a/kernel/sched/fair.c
> +++ b/kernel/sched/fair.c
> @@ -1928,18 +1928,16 @@ static void task_numa_find_cpu(struct ta
>                 src_running = env->src_stats.nr_running - 1;
>                 dst_running = env->dst_stats.nr_running + 1;
>                 imbalance = max(0, dst_running - src_running);
> -               imbalance = adjust_numa_imbalance(imbalance, src_running);
> +               imbalance = adjust_numa_imbalance(imbalance, src_running +1);
>
> -               /* Use idle CPU if there is no imbalance */
> +               /* No task migrate without imbalance */
>                 if (!imbalance) {
> -                       maymove = true;
> -                       if (env->dst_stats.idle_cpu >= 0) {
> -                               env->dst_cpu = env->dst_stats.idle_cpu;
> -                               task_numa_assign(env, NULL, 0);
> -                               return;
> -                       }
> +                       env->best_cpu = -1;
> +                       return;
>                 }
> -       } else {
> +       }
> +
> +       do {
>                 long src_load, dst_load, load;
>                 /*
>                  * If the improvement from just moving env->p direction is better
> @@ -1949,7 +1947,7 @@ static void task_numa_find_cpu(struct ta
>                 dst_load = env->dst_stats.load + load;
>                 src_load = env->src_stats.load - load;
>                 maymove = !load_too_imbalanced(src_load, dst_load, env);
> -       }
> +       } while (0);
>
>         for_each_cpu(cpu, cpumask_of_node(env->dst_nid)) {
>                 /* Skip this CPU if the source task cannot migrate */
>
>


--
-Jirka

