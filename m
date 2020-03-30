Return-Path: <SRS0=Mt+e=5P=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FSL_HELO_FAKE,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B482FC43331
	for <linux-kernel@archiver.kernel.org>; Mon, 30 Mar 2020 17:32:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7670C20776
	for <linux-kernel@archiver.kernel.org>; Mon, 30 Mar 2020 17:32:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1585589526;
	bh=ThELxLN1qj4z7D3XU077NgpZ1K+G5sqvD4yPUywogVE=;
	h=Date:From:To:Cc:Subject:List-ID:From;
	b=XfwruEqKmUBBiYU15/sVAXYZZ6irRf2qEavPtLkqPEWW9aVuEPwqYXtn82dkgnoT4
	 jUC1f9X1s8u7+4wphXAB3iT3/+dl+oW7cVeZCQbBcd3AT63dbSOED3hgMllXLdjKrr
	 p25StCXawIyaLsl03QgxJh6bQOUcSpSAQCVr2SR4=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729092AbgC3RcF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 30 Mar 2020 13:32:05 -0400
Received: from mail-wr1-f45.google.com ([209.85.221.45]:40625 "EHLO
        mail-wr1-f45.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727717AbgC3RcE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 Mar 2020 13:32:04 -0400
Received: by mail-wr1-f45.google.com with SMTP id u10so22701693wro.7
        for <linux-kernel@vger.kernel.org>; Mon, 30 Mar 2020 10:32:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:mime-version
         :content-disposition:user-agent;
        bh=2513EE8HLBj07QnBJ1ZZfViitBD+ZN+G6CqB/vrjtOw=;
        b=JrrghBd7zToWXYmqy9zOJu8RQI1N+yYYeqFw5MDhUHbHeyjA1dQD/b1qDBoSyvsIRR
         8vZ9c7cXQz8VWMFDdmfRIFwE/cpXHdXDVGO0/kgexGpBsU3p58e0WFgzfgWKH4rpqOSO
         jo23bXErNlkFnCfWHhqJUstlEEqCU07Ht2DKsTZK8fXzetWTQyERfrKRljM2QIoYdCTi
         Z9BWwHmxohlkeaNWK3vz4dg383ca8MINREdrreuEviVjAOosM5480Fc/k8sfQU7Jefd5
         uh8ZXJ4hcdzdL/3vuEBfgGi7hion+enOi/HPIcPH1iyCDRqhbCc7WDGcuSHTBOcuH2By
         d0fQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :mime-version:content-disposition:user-agent;
        bh=2513EE8HLBj07QnBJ1ZZfViitBD+ZN+G6CqB/vrjtOw=;
        b=A64yKNEQD/PPliK7la/YD/GNFhZtg7v/mYknTbkeH9rkqHSAXCD1CmNkN9Q5Je9DQC
         mVMf4XOnbzFebmK5hqUmuMw+LoVHoku7IArTq5P8xriFJIWHp+gdgyEuin0BDoZdERnX
         aO47QemMB4IRPMQVyaYxQ5XE6URoNfOJlJmDqCvGV9S+WjGE/BJbWXgzPFit7ppl2jT8
         AnXZQfowijT/YIUt62odTikOc7dvR6h3Hcd3UnGJauKM3aJDXt/f21EYI/8bp+dRgxBk
         aJ7odyptreoXumW7erPIaETRauX2K6djRfTwmZpvsJo6riDyDj+nBTf6bYW45PBzafCP
         kiAw==
X-Gm-Message-State: ANhLgQ2aC0BdqfcCPvQjL/u1o5z1O1NpYt0IE2+Oimy+Rca64w4RlwvW
        OXgVPIQ7LEV1YEU9khXRVjo=
X-Google-Smtp-Source: ADFU+vuScWEWpRYxolPGkz1A9L/L5yBuJVG9gk9XGupr4bIjZoiH8bhnbxUDxMPZ9iicEsTCDZTBvw==
X-Received: by 2002:a05:6000:1251:: with SMTP id j17mr16087559wrx.228.1585589521687;
        Mon, 30 Mar 2020 10:32:01 -0700 (PDT)
Received: from gmail.com (54033286.catv.pool.telekom.hu. [84.3.50.134])
        by smtp.gmail.com with ESMTPSA id o67sm348910wmo.5.2020.03.30.10.32.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 30 Mar 2020 10:32:01 -0700 (PDT)
Date:   Mon, 30 Mar 2020 19:31:59 +0200
From:   Ingo Molnar <mingo@kernel.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     linux-kernel@vger.kernel.org,
        Peter Zijlstra <a.p.zijlstra@chello.nl>,
        Thomas Gleixner <tglx@linutronix.de>,
        Andrew Morton <akpm@linux-foundation.org>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Mel Gorman <mgorman@suse.de>,
        Juri Lelli <juri.lelli@redhat.com>
Subject: [GIT PULL] scheduler changes for v5.7
Message-ID: <20200330173159.GA128106@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Linus,

Please pull the latest sched-core-for-linus git tree from:

   git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git sched-core-for-linus

   # HEAD: 313f16e2e35abb833eab5bdebc6ae30699adca18 Merge branch 'sched/rt' into sched/core, to pick up completed topic tree

The main changes in this cycle are:

 - Various NUMA scheduling updates: harmonize the load-balancer and NUMA 
   placement logic to not work against each other. The intended result is 
   better locality, better utilization and fewer migrations.

 - Introduce Thermal Pressure tracking and optimizations, to improve task 
   placement on thermally overloaded systems.

 - Implement frequency invariant scheduler accounting on (some) x86 CPUs. 
   This is done by observing and sampling the 'recent' CPU frequency 
   average at ~tick boundaries. The CPU provides this data via the 
   APERF/MPERF MSRs. This hopefully makes our capacity estimates more 
   precise and keeps tasks on the same CPU better even if it might seem 
   overloaded at a lower momentary frequency. (As usual, turbo mode is a 
   complication that we resolve by observing the maximum frequency and 
   renormalizing to it.)

 - Add asymmetric CPU capacity wakeup scan to improve capacity 
   utilization on asymmetric topologies. (big.LITTLE systems)

 - PSI fixes and optimizations.

 - RT scheduling capacity awareness fixes & improvements.

 - Optimize the CONFIG_RT_GROUP_SCHED constraints code.

 - Misc fixes, cleanups and optimizations - see the changelog for details.

 Thanks,

	Ingo

------------------>
Chris Wilson (1):
      sched/vtime: Prevent unstable evaluation of WARN(vtime->state)

Giovanni Gherdovich (6):
      x86, sched: Add support for frequency invariance
      x86, sched: Add support for frequency invariance on SKYLAKE_X
      x86, sched: Add support for frequency invariance on XEON_PHI_KNL/KNM
      x86, sched: Add support for frequency invariance on ATOM_GOLDMONT*
      x86, sched: Add support for frequency invariance on ATOM
      x86/intel_pstate: Handle runtime turbo disablement/enablement in frequency invariance

Ingo Molnar (1):
      thermal/cpu-cooling, sched/core: Move the arch_set_thermal_pressure() API to generic scheduler code

Jann Horn (1):
      threads: Update PID limit comment according to futex UAPI change

Johannes Weiner (3):
      psi: Fix cpu.pressure for cpu.max and competing cgroups
      psi: Optimize switching tasks inside shared cgroups
      MAINTAINERS: Add maintenance information for psi

Konstantin Khlebnikov (1):
      sched/rt: Optimize checking group RT scheduler constraints

Liang Chen (1):
      kthread: Do not preempt current task if it is going to call schedule()

Mel Gorman (8):
      sched/numa: Trace when no candidate CPU was found on the preferred node
      sched/numa: Distinguish between the different task_numa_migrate() failure cases
      sched/numa: Use similar logic to the load balancer for moving between domains with spare capacity
      sched/numa: Prefer using an idle CPU as a migration target instead of comparing tasks
      sched/numa: Find an alternative idle CPU if the CPU is part of an active NUMA balance
      sched/numa: Bias swapping tasks based on their preferred node
      sched/numa: Stop an exhastive search if a reasonable swap candidate or idle CPU is found
      sched/numa: Acquire RCU lock for checking idle cores during NUMA balancing

Michael Wang (1):
      sched: Avoid scale real weight down to zero

Morten Rasmussen (3):
      sched/fair: Add asymmetric CPU capacity wakeup scan
      sched/topology: Remove SD_BALANCE_WAKE on asymmetric capacity systems
      sched/fair: Remove wake_cap()

Paul Turner (1):
      sched/core: Distribute tasks within affinity masks

Qais Yousef (6):
      sched/rt: cpupri_find: Implement fallback mechanism for !fit case
      sched/rt: Re-instate old behavior in select_task_rq_rt()
      sched/rt: Optimize cpupri_find() on non-heterogenous systems
      sched/rt: Allow pulling unfitting task
      sched/rt: Remove unnecessary push for unfit tasks
      sched/rt: cpupri_find: Trigger a full search as fallback

Scott Wood (1):
      sched/core: Remove duplicate assignment in sched_tick_remote()

Srikar Dronamraju (1):
      sched/fair: Optimize select_idle_core()

Tao Zhou (1):
      sched/fair: Fix condition of avg_load calculation

Thara Gopinath (9):
      sched/pelt: Add support to track thermal pressure
      sched/topology: Add callback to read per CPU thermal pressure
      drivers/base/arch_topology: Add infrastructure to store and update instantaneous thermal pressure
      arm64/topology: Populate arch_scale_thermal_pressure() for arm64 platforms
      arm/topology: Populate arch_scale_thermal_pressure() for ARM platforms
      sched/fair: Enable periodic update of average thermal pressure
      sched/fair: Update cpu_capacity to reflect thermal pressure
      thermal/cpu-cooling: Update thermal pressure in case of a maximum frequency capping
      sched/fair: Enable tuning of decay period

Thomas Gleixner (2):
      sched/rt: Provide migrate_disable/enable() inlines
      sched: Provide cant_migrate()

Valentin Schneider (4):
      sched/core: Remove for_each_lower_domain()
      sched/fair: Fix kernel build warning in test_idle_cores() for !SMT NUMA
      sched/topology: Don't enable EAS on SMT systems
      arm64: defconfig: enable CONFIG_SCHED_SMT

Vincent Guittot (9):
      sched/fair: Reorder enqueue/dequeue_task_fair path
      sched/numa: Replace runnable_load_avg by load_avg
      sched/pelt: Remove unused runnable load average
      sched/pelt: Add a new runnable average signal
      sched/fair: Take into account runnable_avg to classify group
      sched/fair: Fix runnable_avg for throttled cfs
      sched/fair: Fix reordering of enqueue/dequeue_task_fair()
      sched/fair: Fix enqueue_task_fair warning
      sched/fair: Improve spreading of utilization

Yafang Shao (1):
      psi: Move PF_MEMSTALL out of task->flags

Yu Chen (1):
      sched/deadline: Make two functions static


 Documentation/admin-guide/kernel-parameters.txt |  16 +
 Documentation/robust-futex-ABI.txt              |  14 +-
 MAINTAINERS                                     |   6 +
 arch/arm/include/asm/topology.h                 |   3 +
 arch/arm64/configs/defconfig                    |   1 +
 arch/arm64/include/asm/topology.h               |   3 +
 arch/x86/include/asm/topology.h                 |  25 +
 arch/x86/kernel/smpboot.c                       | 290 ++++++++-
 drivers/cpufreq/intel_pstate.c                  |   1 +
 drivers/thermal/cpufreq_cooling.c               |  19 +-
 include/linux/arch_topology.h                   |  10 +
 include/linux/cpumask.h                         |   7 +
 include/linux/kernel.h                          |   7 +
 include/linux/preempt.h                         |  30 +
 include/linux/psi.h                             |   2 +
 include/linux/psi_types.h                       |  10 +-
 include/linux/sched.h                           |  37 +-
 include/linux/sched/topology.h                  |   8 +
 include/linux/threads.h                         |   2 +-
 include/trace/events/sched.h                    |  53 +-
 init/Kconfig                                    |   4 +
 kernel/kthread.c                                |  17 +-
 kernel/sched/core.c                             |  27 +-
 kernel/sched/cpupri.c                           | 158 +++--
 kernel/sched/cpupri.h                           |   6 +-
 kernel/sched/cputime.c                          |  41 +-
 kernel/sched/deadline.c                         |   6 +-
 kernel/sched/debug.c                            |  17 +-
 kernel/sched/fair.c                             | 791 ++++++++++++++++--------
 kernel/sched/pelt.c                             |  90 ++-
 kernel/sched/pelt.h                             |  31 +
 kernel/sched/psi.c                              | 111 +++-
 kernel/sched/rt.c                               |  66 +-
 kernel/sched/sched.h                            |  69 ++-
 kernel/sched/stats.h                            |  31 +-
 kernel/sched/topology.c                         |  27 +-
 lib/cpumask.c                                   |  29 +
 37 files changed, 1552 insertions(+), 513 deletions(-)
