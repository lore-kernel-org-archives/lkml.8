Return-Path: <SRS0=OrIQ=3R=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9CB1DC2D0DB
	for <linux-kernel@archiver.kernel.org>; Tue, 28 Jan 2020 22:36:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4E37021739
	for <linux-kernel@archiver.kernel.org>; Tue, 28 Jan 2020 22:36:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="wGUZlBr7"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726391AbgA1WgL (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 28 Jan 2020 17:36:11 -0500
Received: from mail-qv1-f52.google.com ([209.85.219.52]:39087 "EHLO
        mail-qv1-f52.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726257AbgA1WgL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Jan 2020 17:36:11 -0500
Received: by mail-qv1-f52.google.com with SMTP id y8so7083943qvk.6
        for <linux-kernel@vger.kernel.org>; Tue, 28 Jan 2020 14:36:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id;
        bh=r2imr4Qyz3++THwAeaYqJluRAXMOC9erDmyCBduis5c=;
        b=wGUZlBr7/yFnTgYgm9XDri4uB23r/tplpEJDnq6xOZS3dnYD3bPB5/xFnWTlBQqf9S
         UYHQ2UGpLCKg/A7V4iqt6DfaMAO6xuKGxmqe6bHpqnIzSEd7pgUOdHpKJpteaGnofR0j
         PcnShkecUCtyFxApNIw51m93ULH+WVrHN3mY0MkA2WK/gnNPmKlg5MCjMf7oTQJ22cp2
         AFEmzlEWos9DbuzvDTDDY59G3SXk3wuIrK+ssX/3ZJyEUYOClGiGoOM7ESZGkXXESGWk
         OgfgbQu8K/3xv2hsYygs73BZ4xlTCSznskDcAIGIE72p8yxBTTvHqd4uhxRhMNd7MWlH
         VWlw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=r2imr4Qyz3++THwAeaYqJluRAXMOC9erDmyCBduis5c=;
        b=DWYHx/gC9FLSuLG5nlrtAU/LoMIYGcUg6UBGt0ztFsikc6G05coDR0B6AAKWFhRPJG
         UCoZjen2Br7HDugNLZqQ+aUlqLgkCccJFZZiZuxiOhdD6UlRUD8DAXbtlXk2Yrwlco6O
         AC3Lodq4V6DtivVXLOpM082NqJ1Q4NwswrlOSm28ayv8G9lnw4pdQ4IW/WgtoGvu/m2y
         UlRVedGu/kqbmTdMaI7y7Tw8fWrKxYFimSrYXwKbk/AGJ6EsbFyCsuQ/lsteA3FugY+2
         9k74POxliz/ShOx0If+7Co5SPqarDNBhU6EtEbU9Sdv9+J4j8EUzxo+jZGuY0oRRPKz+
         Ol9A==
X-Gm-Message-State: APjAAAWnE96RAqWecAXcMCC1pdeSbvVTdOeX1YKAaijeK1LI7y864S6n
        7vlDiP0TzOX79wV6hDlzcDkbrw==
X-Google-Smtp-Source: APXvYqx4tiwgmQ5ok0aKA75/w+l29BVh5gztf8f/Eaz6lyeR1BG4yKUi5dvvVlxq+fZkRNfZQuHDqw==
X-Received: by 2002:a0c:e58a:: with SMTP id t10mr25030566qvm.161.1580250969731;
        Tue, 28 Jan 2020 14:36:09 -0800 (PST)
Received: from Thara-Work-Ubuntu.fios-router.home (pool-71-255-246-27.washdc.fios.verizon.net. [71.255.246.27])
        by smtp.googlemail.com with ESMTPSA id 124sm13014259qko.11.2020.01.28.14.36.08
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Tue, 28 Jan 2020 14:36:09 -0800 (PST)
From:   Thara Gopinath <thara.gopinath@linaro.org>
To:     mingo@redhat.com, peterz@infradead.org, ionela.voinescu@arm.com,
        vincent.guittot@linaro.org, dietmar.eggemann@arm.com,
        rui.zhang@intel.com, qperret@google.com, daniel.lezcano@linaro.org,
        viresh.kumar@linaro.org, rostedt@goodmis.org, will@kernel.org,
        catalin.marinas@arm.com, sudeep.holla@arm.com,
        juri.lelli@redhat.com, corbet@lwn.net
Cc:     linux-kernel@vger.kernel.org, amit.kachhap@gmail.com,
        javi.merino@kernel.org, amit.kucheria@verdurent.com
Subject: [Patch v9 0/8] Introduce Thermal Pressure
Date:   Tue, 28 Jan 2020 17:35:59 -0500
Message-Id: <1580250967-4386-1-git-send-email-thara.gopinath@linaro.org>
X-Mailer: git-send-email 2.1.4
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Thermal governors can respond to an overheat event of a cpu by
capping the cpu's maximum possible frequency. This in turn
means that the maximum available compute capacity of the
cpu is restricted. But today in the kernel, task scheduler is
not notified of capping of maximum frequency of a cpu.
In other words, scheduler is unaware of maximum capacity
restrictions placed on a cpu due to thermal activity.
This patch series attempts to address this issue.
The benefits identified are better task placement among available
cpus in event of overheating which in turn leads to better
performance numbers.

The reduction in the maximum possible capacity of a cpu due to a
thermal event can be considered as thermal pressure. Instantaneous
thermal pressure is hard to record and can sometime be erroneous
as there can be mismatch between the actual capping of capacity
and scheduler recording it. Thus solution is to have a weighted
average per cpu value for thermal pressure over time.
The weight reflects the amount of time the cpu has spent at a
capped maximum frequency. Since thermal pressure is recorded as
an average, it must be decayed periodically. Exisiting algorithm
in the kernel scheduler pelt framework is re-used to calculate
the weighted average. This patch series also defines a sysctl
inerface to allow for a configurable decay period.

Regarding testing, basic build, boot and sanity testing have been
performed on db845c platform with debian file system.
Further, dhrystone and hackbench tests have been
run with the thermal pressure algorithm. During testing, due to
constraints of step wise governor in dealing with big little systems,
trip point 0 temperature was made assymetric between cpus in little
cluster and big cluster; the idea being that
big core will heat up and cpu cooling device will throttle the
frequency of the big cores faster, there by limiting the maximum available
capacity and the scheduler will spread out tasks to little cores as well.

Test Results

Hackbench: 1 group , 30000 loops, 10 runs
                                               Result         SD
                                               (Secs)     (% of mean)
 No Thermal Pressure                            14.03       2.69%
 Thermal Pressure PELT Algo. Decay : 32 ms      13.29       0.56%
 Thermal Pressure PELT Algo. Decay : 64 ms      12.57       1.56%
 Thermal Pressure PELT Algo. Decay : 128 ms     12.71       1.04%
 Thermal Pressure PELT Algo. Decay : 256 ms     12.29       1.42%
 Thermal Pressure PELT Algo. Decay : 512 ms     12.42       1.15%

Dhrystone Run Time  : 20 threads, 3000 MLOOPS
                                                 Result      SD
                                                 (Secs)    (% of mean)
 No Thermal Pressure                              9.452      4.49%
 Thermal Pressure PELT Algo. Decay : 32 ms        8.793      5.30%
 Thermal Pressure PELT Algo. Decay : 64 ms        8.981      5.29%
 Thermal Pressure PELT Algo. Decay : 128 ms       8.647      6.62%
 Thermal Pressure PELT Algo. Decay : 256 ms       8.774      6.45%
 Thermal Pressure PELT Algo. Decay : 512 ms       8.603      5.41%

A Brief History

The first version of this patch-series was posted with resuing
PELT algorithm to decay thermal pressure signal. The discussions
that followed were around whether intanteneous thermal pressure
solution is better and whether a stand-alone algortihm to accumulate
and decay thermal pressure is more appropriate than re-using the
PELT framework.
Tests on Hikey960 showed the stand-alone algorithm performing slightly
better than resuing PELT algorithm and V2 was posted with the stand
alone algorithm. Test results were shared as part of this series.
Discussions were around re-using PELT algorithm and running
further tests with more granular decay period.

For some time after this development was impeded due to hardware
unavailability, some other unforseen and possibly unfortunate events.
For this version, h/w was switched from hikey960 to db845c.
Also Instantaneous thermal pressure was never tested as part of this
cycle as it is clear that weighted average is a better implementation.
The non-PELT algorithm never gave any conclusive results to prove that it
is better than reusing PELT algorithm, in this round of testing.
Also reusing PELT algorithm means thermal pressure tracks the
other utilization signals in the scheduler.

v3->v4:
        - "Patch 3/7:sched: Initialize per cpu thermal pressure structure"
           is dropped as it is no longer needed following changes in other
           other patches.
        - rest of the change log mentioned in specific patches.

v5->v6:
	- "Added arch_ interface APIs to access and update thermal pressure.
	   Moved declaration of per cpu thermal_pressure valriable and
	   infrastructure to update the variable to topology files.

v6->v7:
	- Added CONFIG_HAVE_SCHED_THERMAL_PRESSURE to stub out
	  update_thermal_load_avg in unsupported architectures as per
	  review comments from Peter, Dietmar and Quentin.
	- Renamed arch_scale_thermal_capacity to arch_cpu_thermal_pressure
	  as per review comments from Peter, Dietmar and Ionela.
	- Changed the input argument in arch_set_thermal_pressure from
	  capped capacity to delta capacity(thermal pressure) as per
	  Ionela's review comments. Hence the calculation for delta
	  capacity(thermal pressure) is moved to cpufreq_cooling.c.
	- Fixed a bunch of spelling typos.

v7->v8:
	- Fixed typo in defining update_thermal_load_avg which was
	  causing build errors (reported by kbuild test report)

v8->v9:
	- Defined thermal_load_avg to read rq->avg_thermal.load_avg and
	  avoid cacheline miss in unsupported cases as per Peter's
          suggestion.
	- Moved periodic triggering of thermal pressure averaging from CFS
	  tick function to generic scheduler core tick function.
	- Moved rq_clock_thermal from fair.c to sched.h to enable using
	  the function from multiple files.
	- Initialized the __shift to 0 in setup_sched_thermal_decay_shift
	  as per Quentin's suggestion
	- Added an extra patch enabling CONFIG_HAVE_SCHED_THERMAL_PRESSURE
	  as per Dietmar's request.

Thara Gopinath (8):
  sched/pelt: Add support to track thermal pressure
  sched/topology: Add hook to read per cpu thermal pressure.
  arm,arm64,drivers:Add infrastructure to store and update instantaneous
    thermal pressure
  sched/fair: Enable periodic update of average thermal pressure
  sched/fair: update cpu_capacity to reflect thermal pressure
  thermal/cpu-cooling: Update thermal pressure in case of a maximum
    frequency capping
  sched/fair: Enable tuning of decay period
  arm64: Enable averaging of thermal pressure for arm64 based SoCs

 Documentation/admin-guide/kernel-parameters.txt |  5 ++++
 arch/arm/include/asm/topology.h                 |  3 +++
 arch/arm64/configs/defconfig                    |  1 +
 arch/arm64/include/asm/topology.h               |  3 +++
 drivers/base/arch_topology.c                    | 11 +++++++++
 drivers/thermal/cpufreq_cooling.c               | 19 +++++++++++++--
 include/linux/arch_topology.h                   | 10 ++++++++
 include/linux/sched/topology.h                  |  8 +++++++
 include/trace/events/sched.h                    |  4 ++++
 init/Kconfig                                    |  4 ++++
 kernel/sched/core.c                             |  3 +++
 kernel/sched/fair.c                             | 25 ++++++++++++++++++++
 kernel/sched/pelt.c                             | 31 +++++++++++++++++++++++++
 kernel/sched/pelt.h                             | 31 +++++++++++++++++++++++++
 kernel/sched/sched.h                            | 21 +++++++++++++++++
 15 files changed, 177 insertions(+), 2 deletions(-)

-- 
2.1.4

