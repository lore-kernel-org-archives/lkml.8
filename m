Return-Path: <SRS0=OrIQ=3R=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FSL_HELO_FAKE,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2BC71C2D0DB
	for <linux-kernel@archiver.kernel.org>; Tue, 28 Jan 2020 16:14:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E9D65214AF
	for <linux-kernel@archiver.kernel.org>; Tue, 28 Jan 2020 16:14:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1580228091;
	bh=tjii4YNRvA/nIsZBMXCEx0+nbBG3bmmBtPs4zKdgutQ=;
	h=Date:From:To:Cc:Subject:List-ID:From;
	b=QQ6KebF+67Nt57zzBzUIol8g2OlKhMYz3H401RKFwzv8fPjgmUBVyVmkWI+0v8wdA
	 UPgtcakjjXbY2xsyrHoHJ+2y6hfDHrpUYCCS6OzVhfO2IM5JwmBv/enTu/uBiBy9B4
	 gtvuh3GwAhRl9T/NwFo8qy3KBsrykBPSwSXQUcQc=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726234AbgA1QOu (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 28 Jan 2020 11:14:50 -0500
Received: from mail-wr1-f66.google.com ([209.85.221.66]:45607 "EHLO
        mail-wr1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725959AbgA1QOt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Jan 2020 11:14:49 -0500
Received: by mail-wr1-f66.google.com with SMTP id a6so2087169wrx.12
        for <linux-kernel@vger.kernel.org>; Tue, 28 Jan 2020 08:14:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:mime-version
         :content-disposition:user-agent;
        bh=ViaOSTUntq0NHX15uZfFgqmOsi0BZmVRhuuTmmUk2yY=;
        b=heMPapNpxxj6TcUyUWJayfCFjSX6jFqPer7lud28Ad5+u51zRumabpFNDE7MavIk+z
         IUl/glbCvE/dZFI6v/N2zzowFaFGdED7AZ83C/5AHe9gqnbQBJL8fqb8tPyOyJYotuvE
         NW32sUrvlZRAogQNg5tzvnKvn1P/YSPZa0t6pkGa0D4be5M9GP1NpXNcqE/QYwnCLMfC
         Z0mYMpSWT3zj8B8ovKe17yfoBl8SUvajnDVKTrfMa7XVrL2oMXnXK4kx2jDJHEVVGNmP
         GJDYYnIi52fB+Qt9n10zBOPMn0QnlxWUd8p8eGyoXXDYVnYa1hdwQ8ddRHfgkEEtBnE/
         ASrQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :mime-version:content-disposition:user-agent;
        bh=ViaOSTUntq0NHX15uZfFgqmOsi0BZmVRhuuTmmUk2yY=;
        b=D2euK7xn0V+peKYWugQfa2OgSXUUWDT74oeRFYpcDKeScrHXZ7ZNXYZBd2yQ5wK5RI
         WFdBxLUgxd0JHiJKWm2YTcfJRub546tLED6aYMnuEVPjcOjbY5Goh91KtMluUM2kUO7y
         g6klPDnhZi5EIp0XHmHEkG6/J1yvSMbsHl5GNR1WrfswaAymcQiCK28P8daFVgMT8ZgI
         bKGTHFIwSHHtVnwr4q3E6dRaHwIIicBH7P77Z7Z1GhqKDwSYpuF8/OhNBUtvPJ6l13wi
         uuZmT4Y3yuPFt/ATbxdtNLpPJbbopB0ksqZcYlA1R1NEQTJq6Bbg1eXBEjTHKh3/NJFg
         4WpA==
X-Gm-Message-State: APjAAAUf8ZURjophTi7RK2H1BI5t0hMKWoSfg6fjb74ZaxlqLNcmsQvT
        32+DGXn3bKCAMfSx9ltAsK0=
X-Google-Smtp-Source: APXvYqyf1wNDCgXtfHaIZnVeG/ur5so+OgP0pwT9+AHduD6Z2mYO9aVRPOoH6XhnmJLwtJD8LPXq7w==
X-Received: by 2002:adf:eb0a:: with SMTP id s10mr28081859wrn.320.1580228086673;
        Tue, 28 Jan 2020 08:14:46 -0800 (PST)
Received: from gmail.com (54033286.catv.pool.telekom.hu. [84.3.50.134])
        by smtp.gmail.com with ESMTPSA id b16sm3571917wmj.39.2020.01.28.08.14.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 28 Jan 2020 08:14:46 -0800 (PST)
Date:   Tue, 28 Jan 2020 17:14:44 +0100
From:   Ingo Molnar <mingo@kernel.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     linux-kernel@vger.kernel.org,
        Peter Zijlstra <a.p.zijlstra@chello.nl>,
        Thomas Gleixner <tglx@linutronix.de>,
        Andrew Morton <akpm@linux-foundation.org>
Subject: [GIT PULL] scheduler updates for v5.6
Message-ID: <20200128161444.GA38989@gmail.com>
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

   # HEAD: afa70d941f663c69c9a64ec1021bbcfa82f0e54a sched/fair: Define sched_idle_cpu() only for SMP configurations

These were the main changes in this cycle:

 - More -rt motivated separation of CONFIG_PREEMPT and CONFIG_PREEMPTION.

 - Add more low level scheduling topology sanity checks and warnings to 
   filter out nonsensical topologies that break scheduling.

 - Extend uclamp constraints to influence wakeup CPU placement

 - Make the RT scheduler more aware of asymmetric topologies and CPU 
   capacities, via uclamp metrics, if CONFIG_UCLAMP_TASK=y

 - Make idle CPU selection more consistent

 - Various fixes, smaller cleanups, updates and enhancements - please see 
   the git log for details.

 Thanks,

	Ingo

------------------>
Alex Shi (1):
      sched/cputime: move rq parameter in irqtime_account_process_tick

Cheng Jian (1):
      sched/fair: Optimize select_idle_cpu

Frederic Weisbecker (2):
      sched: Spare resched IPI when prio changes on a single fair task
      sched: Use fair:prio_changed() instead of ad-hoc implementation

Hewenliang (1):
      idle: fix spelling mistake "iterrupts" -> "interrupts"

Jisheng Zhang (1):
      watchdog: Remove soft_lockup_hrtimer_cnt and related code

Li Guanglei (1):
      sched/core: Fix size of rq::uclamp initialization

Oleg Nesterov (1):
      sched/wait: fix ___wait_var_event(exclusive)

Peng Liu (1):
      sched/fair: Fix sgc->{min,max}_capacity calculation for SD_OVERLAP

Peng Wang (2):
      schied/fair: Skip calculating @contrib without load
      sched/fair: calculate delta runnable load only when it's needed

Peter Zijlstra (1):
      cpu/hotplug, stop_machine: Fix stop_machine vs hotplug order

Qais Yousef (2):
      sched/rt: Make RT capacity-aware
      sched/uclamp: Fix a bug in propagating uclamp value in new cgroups

Qian Cai (1):
      sched/core: Remove unused variable from set_user_nice()

Sebastian Andrzej Siewior (3):
      sched/rt, locking: Use CONFIG_PREEMPTION
      sched/core: Use CONFIG_PREEMPTION
      sched/rt, workqueue: Use PREEMPTION

Thomas Gleixner (24):
      sched/rt, ARM: Use CONFIG_PREEMPTION
      sched/rt, arm64: Use CONFIG_PREEMPTION
      sched/rt, powerpc: Use CONFIG_PREEMPTION
      sched/rt, ARC: Use CONFIG_PREEMPTION
      sched/rt, c6x: Use CONFIG_PREEMPTION
      sched/rt, csky: Use CONFIG_PREEMPTION
      sched/rt, h8300: Use CONFIG_PREEMPTION
      sched/rt, hexagon: Use CONFIG_PREEMPTION
      sched/rt, ia64: Use CONFIG_PREEMPTION
      sched/rt, microblaze: Use CONFIG_PREEMPTION
      sched/rt, MIPS: Use CONFIG_PREEMPTION
      sched/rt, nds32: Use CONFIG_PREEMPTION
      sched/rt, nios2: Use CONFIG_PREEMPTION
      sched/rt, parisc: Use CONFIG_PREEMPTION
      sched/rt, riscv: Use CONFIG_PREEMPTION
      sched/rt, s390: Use CONFIG_PREEMPTION
      sched/rt, sh: Use CONFIG_PREEMPTION
      sched/rt, sparc: Use CONFIG_PREEMPTION
      sched/rt, xtensa: Use CONFIG_PREEMPTION
      sched/rt, net: Use CONFIG_PREEMPTION.patch
      sched/rt, xen: Use CONFIG_PREEMPTION
      sched/rt, fs: Use CONFIG_PREEMPTION
      sched/rt, btrfs: Use CONFIG_PREEMPTION
      sched/rt, mm: Use CONFIG_PREEMPTION

Valentin Schneider (6):
      sched/uclamp: Remove uclamp_util()
      sched/uclamp: Make uclamp util helpers use and return UL values
      sched/uclamp: Rename uclamp_util_with() into uclamp_rq_util_with()
      sched/fair: Make task_fits_capacity() consider uclamp restrictions
      sched/fair: Make EAS wakeup placement consider uclamp restrictions
      sched/topology: Assert non-NUMA topology masks don't (partially) overlap

Vincent Guittot (2):
      sched/fair : Improve update_sd_pick_busiest for spare capacity case
      sched/fair: Remove redundant call to cpufreq_update_util()

Viresh Kumar (3):
      sched/fair: Make sched-idle CPU selection consistent throughout
      sched/fair: Load balance aggressively for SCHED_IDLE CPUs
      sched/fair: Define sched_idle_cpu() only for SMP configurations

Wang Long (1):
      sched/psi: create /proc/pressure and /proc/pressure/{io|memory|cpu} only when psi enabled

Wei Li (1):
      sched/debug: Reset watchdog on all CPUs while processing sysrq-t

Yangtao Li (2):
      stop_machine: remove try_stop_cpus helper
      stop_machine: Make stop_cpus() static

Zhenzhong Duan (1):
      sched/clock: Use static_branch_likely() with sched_clock_running


 arch/arc/kernel/entry.S            |   6 +-
 arch/arm/include/asm/switch_to.h   |   2 +-
 arch/arm/kernel/entry-armv.S       |   4 +-
 arch/arm/kernel/traps.c            |   2 +
 arch/arm/mm/cache-v7.S             |   4 +-
 arch/arm/mm/cache-v7m.S            |   4 +-
 arch/arm64/Kconfig                 |  52 +++++------
 arch/arm64/crypto/sha256-glue.c    |   2 +-
 arch/arm64/include/asm/assembler.h |   6 +-
 arch/arm64/include/asm/preempt.h   |   4 +-
 arch/arm64/kernel/entry.S          |   2 +-
 arch/arm64/kernel/traps.c          |   3 +
 arch/c6x/kernel/entry.S            |   8 +-
 arch/csky/kernel/entry.S           |   4 +-
 arch/h8300/kernel/entry.S          |   6 +-
 arch/hexagon/kernel/vm_entry.S     |   6 +-
 arch/ia64/kernel/entry.S           |  12 +--
 arch/ia64/kernel/kprobes.c         |   2 +-
 arch/microblaze/kernel/entry.S     |   2 +-
 arch/mips/include/asm/asmmacro.h   |   4 +-
 arch/mips/kernel/entry.S           |   6 +-
 arch/nds32/Kconfig                 |   2 +-
 arch/nds32/kernel/ex-exit.S        |   4 +-
 arch/nios2/kernel/entry.S          |   2 +-
 arch/parisc/Kconfig                |   2 +-
 arch/parisc/kernel/entry.S         |  10 +--
 arch/powerpc/Kconfig               |   2 +-
 arch/powerpc/kernel/entry_32.S     |   4 +-
 arch/powerpc/kernel/entry_64.S     |   4 +-
 arch/riscv/kernel/entry.S          |   4 +-
 arch/s390/Kconfig                  |   2 +-
 arch/s390/include/asm/preempt.h    |   4 +-
 arch/s390/kernel/dumpstack.c       |   2 +
 arch/s390/kernel/entry.S           |   2 +-
 arch/sh/Kconfig                    |   2 +-
 arch/sh/kernel/cpu/sh5/entry.S     |   4 +-
 arch/sh/kernel/entry-common.S      |   4 +-
 arch/sparc/Kconfig                 |   2 +-
 arch/sparc/kernel/rtrap_64.S       |   2 +-
 arch/xtensa/kernel/entry.S         |   2 +-
 arch/xtensa/kernel/traps.c         |   7 +-
 drivers/xen/preempt.c              |   4 +-
 fs/btrfs/volumes.h                 |   2 +-
 fs/stack.c                         |   6 +-
 include/linux/fs.h                 |   4 +-
 include/linux/genhd.h              |   6 +-
 include/linux/sched/cpufreq.h      |   1 -
 include/linux/stop_machine.h       |  16 ----
 include/xen/xen-ops.h              |   4 +-
 kernel/Kconfig.locks               |  12 +--
 kernel/cpu.c                       |  13 ++-
 kernel/sched/clock.c               |   6 +-
 kernel/sched/core.c                |  34 +++++---
 kernel/sched/cpufreq_schedutil.c   |   2 +-
 kernel/sched/cpupri.c              |  25 +++++-
 kernel/sched/cpupri.h              |   4 +-
 kernel/sched/cputime.c             |  15 ++--
 kernel/sched/debug.c               |  11 ++-
 kernel/sched/fair.c                | 171 ++++++++++++++++++++-----------------
 kernel/sched/idle.c                |   2 +-
 kernel/sched/pelt.c                |  20 ++++-
 kernel/sched/psi.c                 |  10 ++-
 kernel/sched/rt.c                  |  83 ++++++++++++++----
 kernel/sched/sched.h               |  24 ++----
 kernel/sched/topology.c            |  39 +++++++++
 kernel/sched/wait_bit.c            |   1 +
 kernel/stop_machine.c              |  32 +------
 kernel/watchdog.c                  |   3 -
 kernel/workqueue.c                 |   2 +-
 lib/Kconfig.debug                  |   2 +-
 mm/memory.c                        |   2 +-
 mm/slub.c                          |  12 +--
 net/core/dev.c                     |   2 +-
 73 files changed, 446 insertions(+), 332 deletions(-)
