Return-Path: <SRS0=BMk7=4P=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D6920C4BA24
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Feb 2020 09:02:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9778624672
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Feb 2020 09:02:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=verdurent-com.20150623.gappssmtp.com header.i=@verdurent-com.20150623.gappssmtp.com header.b="QSgP8qus"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728688AbgB0JCM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 27 Feb 2020 04:02:12 -0500
Received: from mail-vs1-f66.google.com ([209.85.217.66]:43526 "EHLO
        mail-vs1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728620AbgB0JCM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Feb 2020 04:02:12 -0500
Received: by mail-vs1-f66.google.com with SMTP id 7so1324278vsr.10
        for <linux-kernel@vger.kernel.org>; Thu, 27 Feb 2020 01:02:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=verdurent-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=9Ym3+LivfToOu0cDcirhGLkZLPrt03CVZkRGzcx6ji4=;
        b=QSgP8qusfjMI3a22VeuMrNYxGrB7iZszxeGRLFN01+GT4/KVIiLhpwqCA4LWi9Acq5
         4tBCYVC5uBGsx++PEUgYwcKI2tgaPZhNl5Vmf0cX6PPOxA9C58QG0Zf+lq4c+XBOzJv9
         i9HLHMD8UtrLTh2brlhZZ63ooaH26MVH4Z+5mfsdpD4IyVizonZ5fAeVZdlf5CT0jCDp
         Q5MfGgZPi79G+e2QCYRJfLDEIsILhar1cAOgv9YTVszJskHz9tART1ZsEO+s5U3/50w4
         xh3+8cz2Ehht1f3BcXQIrYXemESiBUQZpbeEYLTZky7kd0ClecC6yJd1YrBkFaTeHma/
         Ccmg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=9Ym3+LivfToOu0cDcirhGLkZLPrt03CVZkRGzcx6ji4=;
        b=jJm05dnBa3k15cDjcgQf2+C9WBYFpefDLXvj5pbig04fKHG2F6z0GVM9jMmlhOIZh9
         10HoJuQdcOp03oA+LWqPtOqaYXG1a+6DqAvZzqfn/rcKjAaNzWpqBIgtSoLd4cTw7zAa
         i7aIKRjUpCAzpoOdoq3RQhZ90SMMB/zVhkL2YYsgFlGfdcTpWAnh6znt1y+QUhiWfwBE
         wysuCrO4W3r8PRFok3HJSNsss3TfV2tz+YJc5G12zsdKDeE1YkBm/OtUEjG6aY54vZjT
         R87+x0Z4jfjS8FATDgHb4XGjaw2iXG9D6oiUzAlq1WoA3LlHtjuJP02Ds6L1txuuGmD3
         DRbQ==
X-Gm-Message-State: APjAAAXXDOTv4dcJu7fSOZlvJriKAu74ejij3qC7a7xKZu+8qA6ZH/+p
        9S7EjXvIC5iW1/TlZeY/YT0aFaGJmlwUITTfQIIMJg==
X-Google-Smtp-Source: APXvYqyWu0sOicHf/6nwHVDw2Ddyjj+MRbHaljxjYXSjpPESisbMPZcsmNChAnXVnTNFUSQtYkLFlq8DPRs9StUS7ro=
X-Received: by 2002:a67:de85:: with SMTP id r5mr2031791vsk.9.1582794129961;
 Thu, 27 Feb 2020 01:02:09 -0800 (PST)
MIME-Version: 1.0
References: <20200222005213.3873-1-thara.gopinath@linaro.org>
In-Reply-To: <20200222005213.3873-1-thara.gopinath@linaro.org>
From:   Amit Kucheria <amit.kucheria@verdurent.com>
Date:   Thu, 27 Feb 2020 14:31:58 +0530
Message-ID: <CAHLCerO9WS_a_5qO-19y4-9Bs1XmEeDR+X_-Pfn0imeqF-yEPg@mail.gmail.com>
Subject: Re: [Patch v10 0/9] Introduce Thermal Pressure
To:     Thara Gopinath <thara.gopinath@linaro.org>
Cc:     Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>, ionela.voinescu@arm.com,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Zhang Rui <rui.zhang@intel.com>, qperret@google.com,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Viresh Kumar <viresh.kumar@linaro.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Will Deacon <will@kernel.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Sudeep Holla <sudeep.holla@arm.com>,
        Juri Lelli <juri.lelli@redhat.com>,
        Jonathan Corbet <corbet@lwn.net>,
        LKML <linux-kernel@vger.kernel.org>,
        Amit Daniel Kachhap <amit.kachhap@gmail.com>,
        Javi Merino <javi.merino@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Feb 22, 2020 at 6:22 AM Thara Gopinath
<thara.gopinath@linaro.org> wrote:
>
> Thermal governors can respond to an overheat event of a cpu by
> capping the cpu's maximum possible frequency. This in turn
> means that the maximum available compute capacity of the
> cpu is restricted. But today in the kernel, task scheduler is
> not notified of capping of maximum frequency of a cpu.
> In other words, scheduler is unaware of maximum capacity
> restrictions placed on a cpu due to thermal activity.
> This patch series attempts to address this issue.
> The benefits identified are better task placement among available
> cpus in event of overheating which in turn leads to better
> performance numbers.
>
> The reduction in the maximum possible capacity of a cpu due to a
> thermal event can be considered as thermal pressure. Instantaneous
> thermal pressure is hard to record and can sometime be erroneous
> as there can be mismatch between the actual capping of capacity
> and scheduler recording it. Thus solution is to have a weighted
> average per cpu value for thermal pressure over time.
> The weight reflects the amount of time the cpu has spent at a
> capped maximum frequency. Since thermal pressure is recorded as
> an average, it must be decayed periodically. Exisiting algorithm
> in the kernel scheduler pelt framework is re-used to calculate
> the weighted average. This patch series also defines a sysctl
> inerface to allow for a configurable decay period.
>
> Regarding testing, basic build, boot and sanity testing have been
> performed on db845c platform with debian file system.
> Further, dhrystone and hackbench tests have been
> run with the thermal pressure algorithm. During testing, due to
> constraints of step wise governor in dealing with big little systems,
> trip point 0 temperature was made assymetric between cpus in little
> cluster and big cluster; the idea being that
> big core will heat up and cpu cooling device will throttle the
> frequency of the big cores faster, there by limiting the maximum available
> capacity and the scheduler will spread out tasks to little cores as well.
>
> Test Results
>
> Hackbench: 1 group , 30000 loops, 10 runs
>                                                Result         SD
>                                                (Secs)     (% of mean)
>  No Thermal Pressure                            14.03       2.69%
>  Thermal Pressure PELT Algo. Decay : 32 ms      13.29       0.56%
>  Thermal Pressure PELT Algo. Decay : 64 ms      12.57       1.56%
>  Thermal Pressure PELT Algo. Decay : 128 ms     12.71       1.04%
>  Thermal Pressure PELT Algo. Decay : 256 ms     12.29       1.42%
>  Thermal Pressure PELT Algo. Decay : 512 ms     12.42       1.15%
>
> Dhrystone Run Time  : 20 threads, 3000 MLOOPS
>                                                  Result      SD
>                                                  (Secs)    (% of mean)
>  No Thermal Pressure                              9.452      4.49%
>  Thermal Pressure PELT Algo. Decay : 32 ms        8.793      5.30%
>  Thermal Pressure PELT Algo. Decay : 64 ms        8.981      5.29%
>  Thermal Pressure PELT Algo. Decay : 128 ms       8.647      6.62%
>  Thermal Pressure PELT Algo. Decay : 256 ms       8.774      6.45%
>  Thermal Pressure PELT Algo. Decay : 512 ms       8.603      5.41%
>

I've tested this series with a patch to artificially reducing the
capacity of big cores on the QCOM sdm845 by reducing the temperature
at which it starts throttling (thereby introducing thermal pressure
earlier) and can see the tasks being migrated to the LITTLE cores.

FWIW,
Tested-by: Amit Kucheria <amit.kucheria@linaro.org>

> A Brief History
>
> The first version of this patch-series was posted with resuing
> PELT algorithm to decay thermal pressure signal. The discussions
> that followed were around whether intanteneous thermal pressure
> solution is better and whether a stand-alone algortihm to accumulate
> and decay thermal pressure is more appropriate than re-using the
> PELT framework.
> Tests on Hikey960 showed the stand-alone algorithm performing slightly
> better than resuing PELT algorithm and V2 was posted with the stand
> alone algorithm. Test results were shared as part of this series.
> Discussions were around re-using PELT algorithm and running
> further tests with more granular decay period.
>
> For some time after this development was impeded due to hardware
> unavailability, some other unforseen and possibly unfortunate events.
> For this version, h/w was switched from hikey960 to db845c.
> Also Instantaneous thermal pressure was never tested as part of this
> cycle as it is clear that weighted average is a better implementation.
> The non-PELT algorithm never gave any conclusive results to prove that it
> is better than reusing PELT algorithm, in this round of testing.
> Also reusing PELT algorithm means thermal pressure tracks the
> other utilization signals in the scheduler.
>
> v3->v4:
>         - "Patch 3/7:sched: Initialize per cpu thermal pressure structure"
>            is dropped as it is no longer needed following changes in other
>            other patches.
>         - rest of the change log mentioned in specific patches.
>
> v5->v6:
>         - "Added arch_ interface APIs to access and update thermal pressure.
>            Moved declaration of per cpu thermal_pressure valriable and
>            infrastructure to update the variable to topology files.
>
> v6->v7:
>         - Added CONFIG_HAVE_SCHED_THERMAL_PRESSURE to stub out
>           update_thermal_load_avg in unsupported architectures as per
>           review comments from Peter, Dietmar and Quentin.
>         - Renamed arch_scale_thermal_capacity to arch_cpu_thermal_pressure
>           as per review comments from Peter, Dietmar and Ionela.
>         - Changed the input argument in arch_set_thermal_pressure from
>           capped capacity to delta capacity(thermal pressure) as per
>           Ionela's review comments. Hence the calculation for delta
>           capacity(thermal pressure) is moved to cpufreq_cooling.c.
>         - Fixed a bunch of spelling typos.
>
> v7->v8:
>         - Fixed typo in defining update_thermal_load_avg which was
>           causing build errors (reported by kbuild test report)
>
> v8->v9:
>         - Defined thermal_load_avg to read rq->avg_thermal.load_avg and
>           avoid cacheline miss in unsupported cases as per Peter's
>           suggestion.
>         - Moved periodic triggering of thermal pressure averaging from CFS
>           tick function to generic scheduler core tick function.
>         - Moved rq_clock_thermal from fair.c to sched.h to enable using
>           the function from multiple files.
>         - Initialized the __shift to 0 in setup_sched_thermal_decay_shift
>           as per Quentin's suggestion
>         - Added an extra patch enabling CONFIG_HAVE_SCHED_THERMAL_PRESSURE
>           as per Dietmar's request.
>
> v9->v10:
>         - Renamed arch_cpu_thermal_pressure to arch_scale_thermal_pressure
>           as per review comments from Dietmar.
>         - Split "[Patch v9 3/8] arm,arm64,drivers:Add infrastructure to
>           store and update instantaneous thermal pressure" into 3 thus
>           separating out arch/arm and arch/arm64 specific code into
>           individual patches as suggested by Amit Kucheria.
>         - Added description for sched_thermal_decay_shift in
>           kernel-parameters.txt following Randy's review comments.
>         - Fixed typos in comments as per Amit Kucheria's review comments.
>
> Thara Gopinath (9):
>   sched/pelt: Add support to track thermal pressure
>   sched/topology: Add hook to read per cpu thermal pressure.
>   drivers/base/arch_topology: Add infrastructure to store and update
>     instantaneous thermal pressure
>   arm64/topology: Populate arch_cpu_thermal_pressure for arm64 platforms
>   arm/topology: Populate arch_cpu_thermal_pressure for arm platforms
>   sched/fair: Enable periodic update of average thermal pressure
>   sched/fair: update cpu_capacity to reflect thermal pressure
>   thermal/cpu-cooling: Update thermal pressure in case of a maximum
>     frequency capping
>   sched/fair: Enable tuning of decay period
>
>  .../admin-guide/kernel-parameters.txt         | 16 ++++++++++
>  arch/arm/include/asm/topology.h               |  3 ++
>  arch/arm64/include/asm/topology.h             |  3 ++
>  drivers/base/arch_topology.c                  | 11 +++++++
>  drivers/thermal/cpufreq_cooling.c             | 19 ++++++++++--
>  include/linux/arch_topology.h                 | 10 ++++++
>  include/linux/sched/topology.h                |  8 +++++
>  include/trace/events/sched.h                  |  4 +++
>  init/Kconfig                                  |  4 +++
>  kernel/sched/core.c                           |  3 ++
>  kernel/sched/fair.c                           | 27 ++++++++++++++++
>  kernel/sched/pelt.c                           | 31 +++++++++++++++++++
>  kernel/sched/pelt.h                           | 31 +++++++++++++++++++
>  kernel/sched/sched.h                          | 21 +++++++++++++
>  14 files changed, 189 insertions(+), 2 deletions(-)
>
> --
> 2.20.1
>
