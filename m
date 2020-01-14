Return-Path: <SRS0=z1XV=3D=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4A858C33C9E
	for <linux-kernel@archiver.kernel.org>; Tue, 14 Jan 2020 19:57:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 135A824672
	for <linux-kernel@archiver.kernel.org>; Tue, 14 Jan 2020 19:57:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="muL/AInb"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728863AbgANT5o (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 14 Jan 2020 14:57:44 -0500
Received: from mail-qt1-f172.google.com ([209.85.160.172]:37633 "EHLO
        mail-qt1-f172.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727102AbgANT5n (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Jan 2020 14:57:43 -0500
Received: by mail-qt1-f172.google.com with SMTP id w47so13602020qtk.4
        for <linux-kernel@vger.kernel.org>; Tue, 14 Jan 2020 11:57:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id;
        bh=FBDm8rXxqoJerRPSzDQ2JDLH7LK7B9nGO3qBUQgSoXY=;
        b=muL/AInbvP0cTPyGwTx7CP2q9fAVfK3v31nVFLHgljcXnup9rrk/Eu0WGGLzM+PLKg
         8XIVEB4d8eYkVPdnLhxfAtvejxMB+Zi6ndk/dH28rDmt1PkGBhZXoD1K9OgwKUWz0ZMd
         UDMmBjKcD8nT+28k5n15m0yLQOjBwRoRTugjkXhP95aXhGYVi+OgGgz/TtEHy41RCPyk
         wURUUHkwFweu7+9ejKJI/84Mgv7ZhQ+VMn057hvB/uo+Ltu3rfiA5lVfFRAdeL/MGZr3
         R4vTM9NTnYtm1eeJ93hTuHzkpsBlhpzP39rxYk1wyuqFTeDbdJhn0jPOQXSMHa0omeN5
         Yyxw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=FBDm8rXxqoJerRPSzDQ2JDLH7LK7B9nGO3qBUQgSoXY=;
        b=sME9/sEKpw6WAvQ15CUWmYfHgVkxinpms/9hRYKdum3obNuxlH0kqG3ArSeRnB9+C2
         48vFsIXu0FGUCdFnwn2xUj8YqXYAkOSEGPAsBrjlPhvOWopAauAAo7m6iEJ5CNFJ6o8t
         vnBz997LErZkD+FHp4MBhd4PjIg+9b1nv0UGqdzLkuvY68VYGLmnrsimbqYgFbfEGqKj
         ZTZ2FOtd3VehXmWRHY+/H+n+6bClc8waCE3pPw2hTBebO8YLK8a4xCJGTafidBZLl5+U
         /Q8Sz7RakseJCaunN+o2wbVW1EynDYXRrSMJbYBqQMq4nlhwG2LcQTHWBO0aE8fbdzRY
         3lMQ==
X-Gm-Message-State: APjAAAWpbNa9z/974dpyg+2D3SMd2lXs9NEE3BJYQDAl+5mj30Dipjtj
        z1zgW3LP3jo6e8x3OLElJ9t+dw==
X-Google-Smtp-Source: APXvYqyaXcYlqOu+EuPG1ShHFxnZN5vfDRulW4QINanUuErkYEoSoYfYaBlrhOtNGDVIvkJnjchIaw==
X-Received: by 2002:ac8:404e:: with SMTP id j14mr245134qtl.312.1579031862473;
        Tue, 14 Jan 2020 11:57:42 -0800 (PST)
Received: from Thara-Work-Ubuntu.fios-router.home (pool-71-255-246-27.washdc.fios.verizon.net. [71.255.246.27])
        by smtp.googlemail.com with ESMTPSA id b81sm7183497qkc.135.2020.01.14.11.57.40
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Tue, 14 Jan 2020 11:57:41 -0800 (PST)
From:   Thara Gopinath <thara.gopinath@linaro.org>
To:     mingo@redhat.com, peterz@infradead.org, ionela.voinescu@arm.com,
        vincent.guittot@linaro.org, dietmar.eggemann@arm.com,
        rui.zhang@intel.com, qperret@google.com, daniel.lezcano@linaro.org,
        viresh.kumar@linaro.org
Cc:     linux-kernel@vger.kernel.org, amit.kachhap@gmail.com,
        javi.merino@kernel.org, amit.kucheria@verdurent.com
Subject: [Patch v8 0/7] Introduce Thermal Pressure
Date:   Tue, 14 Jan 2020 14:57:32 -0500
Message-Id: <1579031859-18692-1-git-send-email-thara.gopinath@linaro.org>
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

Thara Gopinath (7):
  sched/pelt: Add support to track thermal pressure
  sched/topology: Add hook to read per cpu thermal pressure.
  arm,arm64,drivers:Add infrastructure to store and update instantaneous
    thermal pressure
  sched/fair: Enable periodic update of average thermal pressure
  sched/fair: update cpu_capacity to reflect thermal pressure
  thermal/cpu-cooling: Update thermal pressure in case of a maximum
    frequency capping
  sched/fair: Enable tuning of decay period

 Documentation/admin-guide/kernel-parameters.txt |  5 +++
 arch/arm/include/asm/topology.h                 |  3 ++
 arch/arm64/include/asm/topology.h               |  3 ++
 drivers/base/arch_topology.c                    | 11 ++++++
 drivers/thermal/cpufreq_cooling.c               | 19 +++++++++--
 include/linux/arch_topology.h                   | 10 ++++++
 include/linux/sched/topology.h                  |  8 +++++
 include/trace/events/sched.h                    |  4 +++
 init/Kconfig                                    |  4 +++
 kernel/sched/fair.c                             | 45 +++++++++++++++++++++++++
 kernel/sched/pelt.c                             | 31 +++++++++++++++++
 kernel/sched/pelt.h                             | 16 +++++++++
 kernel/sched/sched.h                            |  1 +
 13 files changed, 158 insertions(+), 2 deletions(-)

-- 
2.1.4

