Return-Path: <SRS0=Mt+e=5P=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B0D7DC43331
	for <linux-kernel@archiver.kernel.org>; Mon, 30 Mar 2020 14:50:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8EE862073B
	for <linux-kernel@archiver.kernel.org>; Mon, 30 Mar 2020 14:50:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728863AbgC3OuA (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 30 Mar 2020 10:50:00 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:59008 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728658AbgC3Ot4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 Mar 2020 10:49:56 -0400
Received: from [5.158.153.52] (helo=nanos.tec.linutronix.de)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tglx@linutronix.de>)
        id 1jIvjd-0006tC-2f; Mon, 30 Mar 2020 16:49:53 +0200
Received: from nanos.tec.linutronix.de (localhost [IPv6:::1])
        by nanos.tec.linutronix.de (Postfix) with ESMTP id 99C4C1040EC;
        Mon, 30 Mar 2020 16:49:52 +0200 (CEST)
Date:   Mon, 30 Mar 2020 14:47:10 -0000
From:   Thomas Gleixner <tglx@linutronix.de>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     linux-kernel@vger.kernel.org, x86@kernel.org
Subject: [GIT pull] smp/core for v5.7
References: <158557962955.22376.9136086165862170511.tglx@nanos.tec.linutronix.de>
Message-ID: <158557963075.22376.606316234727225860.tglx@nanos.tec.linutronix.de>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Linus,

please pull the latest smp/core branch from:

   git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git smp-core-2020-03-30

up to:  e98eac6ff1b4: cpu/hotplug: Ignore pm_wakeup_pending() for disable_nonboot_cpus()


CPU (hotplug) updates:

  - Support for locked CSD objects in smp_call_function_single_async()
    which allows to simplify callsites in the scheduler core and MIPS

  - Treewide consolidation of CPU hotplug functions which ensures the
    consistency between the sysfs interface and kernel state. The low level
    functions cpu_up/down() are now confined to the core code and not
    longer accessible from random code.

Thanks,

	tglx

------------------>
Peter Xu (3):
      smp: Allow smp_call_function_single_async() to insert locked csd
      MIPS: smp: Remove tick_broadcast_count
      sched/core: Remove rq.hrtick_csd_pending

Qais Yousef (18):
      cpu/hotplug: Add new {add,remove}_cpu() functions
      cpu/hotplug: Create a new function to shutdown nonboot cpus
      ia64: Replace cpu_down() with smp_shutdown_nonboot_cpus()
      ARM: Don't use disable_nonboot_cpus()
      ARM: Use reboot_cpu instead of hardcoding it to 0
      arm64: Don't use disable_nonboot_cpus()
      arm64: Use reboot_cpu instead of hardconding it to 0
      cpu/hotplug: Provide bringup_hibernate_cpu()
      arm64: hibernate: Use bringup_hibernate_cpu()
      x86/smp: Replace cpu_up/down() with add/remove_cpu()
      powerpc: Replace cpu_up/down() with add/remove_cpu()
      sparc: Replace cpu_up/down() with add/remove_cpu()
      parisc: Replace cpu_up/down() with add/remove_cpu()
      xen/cpuhotplug: Replace cpu_up/down() with device_online/offline()
      firmware: psci: Replace cpu_up/down() with add/remove_cpu()
      torture: Replace cpu_up/down() with add/remove_cpu()
      cpu/hotplug: Move bringup of secondary CPUs out of smp_init()
      cpu/hotplug: Hide cpu_up/down()

Thomas Gleixner (1):
      cpu/hotplug: Ignore pm_wakeup_pending() for disable_nonboot_cpus()


 arch/arm/kernel/reboot.c             |   4 +-
 arch/arm64/kernel/hibernate.c        |  13 ++--
 arch/arm64/kernel/process.c          |   4 +-
 arch/ia64/kernel/process.c           |   8 +-
 arch/mips/kernel/smp.c               |   9 +--
 arch/parisc/kernel/processor.c       |   2 +-
 arch/powerpc/kexec/core_64.c         |   2 +-
 arch/sparc/kernel/ds.c               |   4 +-
 arch/x86/kernel/topology.c           |  22 ++----
 arch/x86/mm/mmio-mod.c               |   4 +-
 arch/x86/xen/smp.c                   |   2 +-
 drivers/base/cpu.c                   |   4 +-
 drivers/firmware/psci/psci_checker.c |   4 +-
 drivers/xen/cpu_hotplug.c            |   2 +-
 include/linux/cpu.h                  |  22 ++++--
 kernel/cpu.c                         | 143 +++++++++++++++++++++++++++++++----
 kernel/sched/core.c                  |   9 +--
 kernel/sched/sched.h                 |   1 -
 kernel/smp.c                         |  23 +++---
 kernel/torture.c                     |   9 ++-
 20 files changed, 194 insertions(+), 97 deletions(-)


