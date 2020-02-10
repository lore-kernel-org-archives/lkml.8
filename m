Return-Path: <SRS0=Vo5z=36=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E1295C352A4
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Feb 2020 12:09:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C0DB520838
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Feb 2020 12:09:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727974AbgBJMJI (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 10 Feb 2020 07:09:08 -0500
Received: from foss.arm.com ([217.140.110.172]:59386 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727570AbgBJMHY (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Feb 2020 07:07:24 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id DD9A81FB;
        Mon, 10 Feb 2020 04:07:23 -0800 (PST)
Received: from [192.168.0.7] (unknown [172.31.20.19])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id C0B883F6CF;
        Mon, 10 Feb 2020 04:07:20 -0800 (PST)
Subject: Re: [Patch v9 0/8] Introduce Thermal Pressure
To:     Thara Gopinath <thara.gopinath@linaro.org>, mingo@redhat.com,
        peterz@infradead.org, ionela.voinescu@arm.com,
        vincent.guittot@linaro.org, rui.zhang@intel.com,
        qperret@google.com, daniel.lezcano@linaro.org,
        viresh.kumar@linaro.org, rostedt@goodmis.org, will@kernel.org,
        catalin.marinas@arm.com, sudeep.holla@arm.com,
        juri.lelli@redhat.com, corbet@lwn.net
Cc:     linux-kernel@vger.kernel.org, amit.kachhap@gmail.com,
        javi.merino@kernel.org, amit.kucheria@verdurent.com
References: <1580250967-4386-1-git-send-email-thara.gopinath@linaro.org>
From:   Dietmar Eggemann <dietmar.eggemann@arm.com>
Message-ID: <95164e1d-12e4-b155-f0d6-f869ee982aae@arm.com>
Date:   Mon, 10 Feb 2020 13:07:19 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.1
MIME-Version: 1.0
In-Reply-To: <1580250967-4386-1-git-send-email-thara.gopinath@linaro.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 28/01/2020 23:35, Thara Gopinath wrote:
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

What do we do on systems on which one Frequency domain spawns all the
CPUs (e.g. Hikey620)?

perf stat --null --repeat 10 -- perf bench sched messaging -g 10 -l 1000

# Running 'sched/messaging' benchmark:
# 20 sender and receiver processes per group
# 10 groups == 400 processes run

     Total time: 4.697 [sec]
# Running 'sched/messaging' benchmark:
[ 8082.882751] hisi_thermal f7030700.tsensor: sensor <2> THERMAL ALARM: 66385 > 65000
# 20 sender and receiver processes per group
# 10 groups == 400 processes run

     Total time: 4.910 [sec]
# Running 'sched/messaging' benchmark:
[ 8091.070386] CPU3 cpus=0-7 th_pressure=205
[ 8091.178390] CPU3 cpus=0-7 th_pressure=0
[ 8091.286389] CPU3 cpus=0-7 th_pressure=205
[ 8091.398397] CPU3 cpus=0-7 th_pressure=0
