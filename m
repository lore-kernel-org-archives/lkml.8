Return-Path: <SRS0=5bHT=BN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A188BC433E0
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Aug 2020 14:55:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 72F4C20775
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Aug 2020 14:55:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1596466525;
	bh=hY3GxYa8Ze1c89nkhAYPYeXq3wLWIR/bMh0G23sp6CY=;
	h=Date:From:To:Cc:Subject:List-ID:From;
	b=TA2preSjUEUlFHO3p73OnKnRL/05w9RaUGXZV5OgU1kP2p5j/zjHV+ma2BVuencpe
	 8o/qhujj0SUQ8+YZyzxGBWFLbnZjMT9y5qSnWkpXiAYI2US/ZuKYubvmdDfynKhkk/
	 M5r1a0w9tqEPIEk29bPYoxaXaxsssLOR4xNOEkqk=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726971AbgHCOzZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 3 Aug 2020 10:55:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37022 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726825AbgHCOzY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Aug 2020 10:55:24 -0400
Received: from mail-ej1-x643.google.com (mail-ej1-x643.google.com [IPv6:2a00:1450:4864:20::643])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 56846C06174A
        for <linux-kernel@vger.kernel.org>; Mon,  3 Aug 2020 07:55:24 -0700 (PDT)
Received: by mail-ej1-x643.google.com with SMTP id o18so38920058eje.7
        for <linux-kernel@vger.kernel.org>; Mon, 03 Aug 2020 07:55:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:mime-version
         :content-disposition:content-transfer-encoding;
        bh=cDWVptvljKDEsN0JJLonsDW10le/m6YJzi+ovX7Suxc=;
        b=WnPVuhTpF6cox7jW+H5GNJktBS1yvTjVLNZC+uE7NEQA4VdEBG6PdDbxjgOTbryqFA
         PPLgHbeBnpl6QhXIZBsoKMM5WrcUPjpsb+0d7/6Ig+QQVbGjaWQsIThHiJ2BkDdEsB6u
         9Vnmvgc7mTL5McD+5gt+rwm9xNlr7ESQIMhdftg05xD33eKlLwp9vX5PUrFNfFM6GMns
         HpS08zlbMEfRyxbfhrBpMGkCafXgTNyw+7U9OuZQTa+wfXWHC8utiBIVsi7zu6tDu21u
         VJSFGMLhrmpfDr6SM5kj59vBQB/FWMfbBVGtnPpaKheOKY66uzkAoldacH4wukB/7Vna
         aOvg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :mime-version:content-disposition:content-transfer-encoding;
        bh=cDWVptvljKDEsN0JJLonsDW10le/m6YJzi+ovX7Suxc=;
        b=RxKNgU6j/wwqzkIvkE8b0W7RfxrbCQyBC5e1tcZ02K7PVmZAiYQX9O+e8Wc/gnFbpu
         iwOrjngBP1qu2J9w6BGOGb4kxC8yjuLSJjgim/9yDbxEgo6LLRQaPbKt+XnFiCm12gzN
         W1OeqzqLRrNsEdfkbYtUJGgTN2y9MlK04gA2fDO/v6NbMkx1VSIolZH8VzkRBNMXVXMM
         xrvFes4/XCBgcAsZwjMH5ZTQbubE6r6SJybeEWXsjCtUolIJqVDs2f+5Lb12XdUEldaH
         VlP9FDcH7AvWExfQKq+ECTHuQ4DFxwir2JOBDnBCyFJgwiHv6uZ4ZBjdVJzeUedURYvf
         PhyA==
X-Gm-Message-State: AOAM5337tO/zW66lJM1m5CKNj4rwvCJO3L8a2SV5zKza/1HNnUtvaNgT
        Ajvd2AfFGt2qGXUsImQ/gxw=
X-Google-Smtp-Source: ABdhPJzLGErV5kybGbB+LxQZuAPAbX1mCqLpnfLrniGLvcU8rLhIA1ItrpEZuHwy/1pG/sHjfiVCxA==
X-Received: by 2002:a17:907:20b7:: with SMTP id pw23mr2744470ejb.148.1596466523042;
        Mon, 03 Aug 2020 07:55:23 -0700 (PDT)
Received: from gmail.com (54033286.catv.pool.telekom.hu. [84.3.50.134])
        by smtp.gmail.com with ESMTPSA id 89sm8426649ede.29.2020.08.03.07.55.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 03 Aug 2020 07:55:22 -0700 (PDT)
Date:   Mon, 3 Aug 2020 16:55:19 +0200
From:   Ingo Molnar <mingo@kernel.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     linux-kernel@vger.kernel.org,
        Peter Zijlstra <a.p.zijlstra@chello.nl>,
        Juri Lelli <juri.lelli@redhat.com>,
        Vincent Guittot <vincent.guittot@linaro.org>
Subject: [GIT PULL] scheduler updates for v5.9
Message-ID: <20200803145519.GA633133@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Linus,

Please pull the latest sched/core git tree from:

   git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git sched-core-2020-08-03

   # HEAD: 949bcb8135a96a6923e676646bd29cbe69e8350f sched/doc: Factorize bits between sched-energy.rst & sched-capacity.rst

The main changes in this cycle were:

 - Improve uclamp performance by using a static key for the fast path

 - Add the "sched_util_clamp_min_rt_default" sysctl, to optimize for
   better power efficiency of RT tasks on battery powered devices.
   (The default is to maximize performance & reduce RT latencies.)

 - Improve utime and stime tracking accuracy, which had a fixed boundary
   of error, which created larger and larger relative errors as the values
   become larger. This is now replaced with more precise arithmetics,
   using the new mul_u64_u64_div_u64() helper in math64.h.

 - Improve the deadline scheduler, such as making it capacity aware

 - Improve frequency-invariant scheduling

 - Misc cleanups in energy/power aware scheduling

 - Add sched_update_nr_running tracepoint to track changes to nr_running

 - Documentation additions and updates

 - Misc cleanups and smaller fixes

 Thanks,

	Ingo

------------------>
Alex Belits (3):
      lib: Restrict cpumask_local_spread to houskeeping CPUs
      PCI: Restrict probe functions to housekeeping CPUs
      net: Restrict receive packets queuing to housekeeping CPUs

Christophe JAILLET (1):
      sched/deadline: Fix a typo in a comment

Dietmar Eggemann (6):
      sched/pelt: Remove redundant cap_scale() definition
      sched/core: Remove redundant 'preempt' param from sched_class->yield_to_task()
      sched/idle,stop: Remove .get_rr_interval from sched_class
      sched/fair: Remove unused 'sd' parameter from scale_rt_capacity()
      sched/deadline: Optimize dl_bw_cpus()
      sched/deadline: Add dl_bw_capacity()

Giovanni Gherdovich (3):
      x86, sched: check for counters overflow in frequency invariant accounting
      x86, sched: Bail out of frequency invariance if turbo frequency is unknown
      x86, sched: Bail out of frequency invariance if turbo_freq/base_freq gives 0

Kirill Tkhai (1):
      sched: Micro optimization in pick_next_task() and in check_preempt_curr()

Luca Abeni (3):
      sched/deadline: Improve admission control for asymmetric CPU capacities
      sched/deadline: Make DL capacity-aware
      sched/deadline: Implement fallback mechanism for !fit case

Marcelo Tosatti (2):
      kthread: Switch to cpu_possible_mask
      isolcpus: Affine unbound kernel threads to housekeeping cpus

Miaohe Lin (1):
      sched: Remove duplicated tick_nohz_full_enabled() check

Muchun Song (1):
      smp: Fix a potential usage of stale nr_cpus

Oleg Nesterov (1):
      sched/cputime: Improve cputime_adjust()

Paul Gortmaker (1):
      sched: nohz: stop passing around unused "ticks" parameter.

Peng Liu (1):
      sched: correct SD_flags returned by tl->sd_flags()

Peng Wang (1):
      sched/fair: Optimize dequeue_task_fair()

Peter Puhov (1):
      sched/fair: update_pick_idlest() Select group with lowest group_util when idle_cpus are equal

Peter Zijlstra (3):
      sched/deadline: Impose global limits on sched_attr::sched_period
      sched, vmlinux.lds: Increase STRUCT_ALIGNMENT to 64 bytes for GCC-4.9
      sched: Better document ttwu()

Phil Auld (1):
      sched: Add a tracepoint to track rq->nr_running

Qais Yousef (5):
      sched/uclamp: Fix initialization of struct uclamp_rq
      sched/uclamp: Protect uclamp fast path code with static key
      sched/uclamp: Fix a deadlock when enabling uclamp static key
      sched/uclamp: Add a new sysctl to control RT default boost value
      Documentation/sysctl: Document uclamp sysctl knobs

Qinglang Miao (1):
      sched/uclamp: Remove unnecessary mutex_init()

Randy Dunlap (2):
      linux/sched/mm.h: drop duplicated words in comments
      trace/events/sched.h: fix duplicated word

Sebastian Andrzej Siewior (1):
      sched/core: Remove mmdrop() definition

Steven Rostedt (VMware) (3):
      sched: Force the address order of each sched class descriptor
      sched: Have sched_class_highest define by vmlinux.lds.h
      sched: Remove struct sched_class::next field

Suren Baghdasaryan (1):
      psi: eliminate kthread_worker from psi trigger scheduling mechanism

Valentin Schneider (7):
      arch_topology, sched/core: Cleanup thermal pressure definition
      sched: Cleanup SCHED_THERMAL_PRESSURE kconfig entry
      arm, arm64: Select CONFIG_SCHED_THERMAL_PRESSURE
      arm, arm64: Fix selection of CONFIG_SCHED_THERMAL_PRESSURE
      sched: Document arch_scale_*_capacity()
      sched/doc: Document capacity aware scheduling
      sched/doc: Factorize bits between sched-energy.rst & sched-capacity.rst

Vincent Donnefort (1):
      sched/debug: Add new tracepoints to track util_est

Vincent Guittot (2):
      sched/fair: Fix NOHZ next idle balance
      sched/pelt: Cleanup PELT divider

王文虎 (1):
      sched: Fix a typo in a comment


 Documentation/admin-guide/sysctl/kernel.rst |  54 ++++
 Documentation/scheduler/index.rst           |   1 +
 Documentation/scheduler/sched-capacity.rst  | 439 ++++++++++++++++++++++++++
 Documentation/scheduler/sched-energy.rst    |  12 +-
 arch/arm/include/asm/topology.h             |   3 +-
 arch/arm64/include/asm/topology.h           |   3 +-
 arch/x86/include/asm/div64.h                |  14 +-
 arch/x86/include/asm/topology.h             |   2 +-
 arch/x86/kernel/smpboot.c                   |  50 ++-
 drivers/base/arch_topology.c                |  11 +
 drivers/pci/pci-driver.c                    |   5 +-
 include/asm-generic/vmlinux.lds.h           |  24 +-
 include/linux/arch_topology.h               |   4 +-
 include/linux/math64.h                      |   2 +
 include/linux/psi_types.h                   |   7 +-
 include/linux/sched.h                       |  25 +-
 include/linux/sched/isolation.h             |   1 +
 include/linux/sched/loadavg.h               |   2 +-
 include/linux/sched/mm.h                    |   8 +-
 include/linux/sched/sysctl.h                |   4 +
 include/linux/sched/task.h                  |   1 +
 include/linux/sched/topology.h              |  17 +
 include/trace/events/sched.h                |  14 +-
 init/Kconfig                                |  17 +-
 kernel/fork.c                               |   1 +
 kernel/kthread.c                            |   6 +-
 kernel/sched/core.c                         | 466 +++++++++++++++++++++++-----
 kernel/sched/cpudeadline.c                  |  24 ++
 kernel/sched/cpufreq_schedutil.c            |   2 +-
 kernel/sched/cputime.c                      |  46 +--
 kernel/sched/deadline.c                     | 118 +++++--
 kernel/sched/fair.c                         |  93 ++++--
 kernel/sched/idle.c                         |  11 +-
 kernel/sched/isolation.c                    |   3 +-
 kernel/sched/loadavg.c                      |   2 +-
 kernel/sched/pelt.c                         |   6 +-
 kernel/sched/pelt.h                         |   5 +
 kernel/sched/psi.c                          | 113 ++++---
 kernel/sched/rt.c                           |   4 +-
 kernel/sched/sched.h                        | 126 ++++++--
 kernel/sched/stop_task.c                    |  12 +-
 kernel/sched/topology.c                     |   2 +-
 kernel/smp.c                                |   3 +-
 kernel/sysctl.c                             |  21 ++
 kernel/time/timekeeping.c                   |   2 +-
 lib/cpumask.c                               |  16 +-
 lib/math/div64.c                            |  41 +++
 net/core/net-sysfs.c                        |  10 +-
 48 files changed, 1521 insertions(+), 332 deletions(-)
 create mode 100644 Documentation/scheduler/sched-capacity.rst
