Return-Path: <SRS0=Mt+e=5P=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FSL_HELO_FAKE,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9C809C43331
	for <linux-kernel@archiver.kernel.org>; Mon, 30 Mar 2020 15:18:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5B322206F5
	for <linux-kernel@archiver.kernel.org>; Mon, 30 Mar 2020 15:18:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1585581528;
	bh=3trTPBKXql8fKNLCdAL5qIZM1v0MdDA3GQPd1EqfFmA=;
	h=Date:From:To:Cc:Subject:List-ID:From;
	b=myEIYbx78Li+IK+1GAeQfF+4/B5+mZHFYa4cSmcYCLdS4hFY0rLLRCgNI7sDMtK1v
	 UYKz0errxMCm4OlTNn0yv0o+zBN/mex+z73LE1NC/OjcTnh9f/QIthnx8kid80RpEu
	 Exmuv6kGErvar1vdZ4Beq2yOFZCVeqETIuc670B0=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728658AbgC3PSr (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 30 Mar 2020 11:18:47 -0400
Received: from mail-wm1-f67.google.com ([209.85.128.67]:50244 "EHLO
        mail-wm1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727255AbgC3PSr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 Mar 2020 11:18:47 -0400
Received: by mail-wm1-f67.google.com with SMTP id t128so1938801wma.0
        for <linux-kernel@vger.kernel.org>; Mon, 30 Mar 2020 08:18:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:mime-version
         :content-disposition:user-agent;
        bh=1AtNdh6OstiM0nHyfMjqJx3O5C8JLNvCWHvVPuUfhWQ=;
        b=swMYz9yGtrKx5vblADfChPR0Ub0iG4wWgro13/e5J6BU8oqJH05MMFdcwxhK3LwX8z
         pt1nwsuPEWydF9TikUGTslTukBqFSOyMn7hbtKiSfoqg2T4rJFx0UWpdTS3ebM5iC+bK
         vEtd8apD5qwDP9JTWItln53CxpYT40b98FXBlfA/vM2VlnbfLE4ORAytE72MXK4F0W7W
         547182og5NJ725RdzPBmKoxRKtL+9aFVOaQVV6AUU5GVGBl+Og3/QHx/wBxhiRifZ5eR
         IVEVrVMAPsnRE+rxMEEJdhEaG+IL5JoHqjpqzAwzi1bTZmpPTRRDz1TOX1NZmEfJgQ43
         5J8A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :mime-version:content-disposition:user-agent;
        bh=1AtNdh6OstiM0nHyfMjqJx3O5C8JLNvCWHvVPuUfhWQ=;
        b=uONSg1iNpUhcw7gzVonquzaSqR7DoOS3VqPrslLOfdiijjoy/ZAg08P/af7BI50Vid
         z0fJsqnRennElgAxR4U/fqXJouYWYm2HrPLMGD2mI+usaraS4bd8enZ6PA+RHrIrOEVq
         zgSY1UwTnZdxLOGsESqjY8hPeI803ekMVYa1GrYSPOhcznJSl82/X0ungqQ2sOu+HtkX
         CQryHI4zHiPGcsLgeYYQVDadcJkCIeAA3oYJqZH+i9m+0kuWhrNVEw2tj/LwH0Uykaz9
         qN0/KGPEMxWEGg5Tfh9Isp4THeaHQdpKeC1kKHUK4RdgE1Ng9slefQ+vUBVPtQWxj0aW
         nFjw==
X-Gm-Message-State: ANhLgQ2M2bEqpfDeZ8wzlNe/YtiHAKMTK8riRxOTzBuoWNaymrDETlZt
        LlQf1g4p75xT8Vx1GxggDpi0iLKx
X-Google-Smtp-Source: ADFU+vtzk5ne2ZcnUIDrD/p2Ch33DrxleALA/khgX8X92AyGjpHDSx5v5GSznpVnFLxfEVSlvS+30g==
X-Received: by 2002:a7b:cd10:: with SMTP id f16mr12793719wmj.132.1585581523304;
        Mon, 30 Mar 2020 08:18:43 -0700 (PDT)
Received: from gmail.com (54033286.catv.pool.telekom.hu. [84.3.50.134])
        by smtp.gmail.com with ESMTPSA id r5sm4251177wmr.15.2020.03.30.08.18.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 30 Mar 2020 08:18:42 -0700 (PDT)
Date:   Mon, 30 Mar 2020 17:18:40 +0200
From:   Ingo Molnar <mingo@kernel.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     linux-kernel@vger.kernel.org,
        Peter Zijlstra <a.p.zijlstra@chello.nl>,
        Thomas Gleixner <tglx@linutronix.de>,
        Andrew Morton <akpm@linux-foundation.org>,
        Will Deacon <will.deacon@arm.com>
Subject: [GIT PULL] locking changes for v5.7
Message-ID: <20200330151840.GA99197@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Linus,

Please pull the latest locking-core-for-linus git tree from:

   git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git locking-core-for-linus

   # HEAD: f1e67e355c2aafeddf1eac31335709236996d2fe fs/buffer: Make BH_Uptodate_Lock bit_spin_lock a regular spinlock_t

The main changes in this cycle were:

 - Continued user-access cleanups in the futex code.

 - percpu-rwsem rewrite that uses its own waitqueue and atomic_t instead 
   of an embedded rwsem. This addresses a couple of weaknesses, but the 
   primary motivation was complications on the -rt kernel.

 - Introduce raw lock nesting detection on lockdep 
   (CONFIG_PROVE_RAW_LOCK_NESTING=y), document the raw_lock vs. normal 
   lock differences. This too originates from -rt.

 - Reuse lockdep zapped chain_hlocks entries, to conserve RAM footprint 
   on distro-ish kernels running into the "BUG: MAX_LOCKDEP_CHAIN_HLOCKS 
   too low!" depletion of the lockdep chain-entries pool.

 - Misc cleanups, smaller fixes and enhancements - see the changelog for 
   details.

 Thanks,

	Ingo

------------------>
Al Viro (8):
      futex: arch_futex_atomic_op_inuser() calling conventions change
      sh: no need of access_ok() in arch_futex_atomic_op_inuser()
      [parisc, s390, sparc64] no need for access_ok() in futex handling
      objtool: whitelist __sanitizer_cov_trace_switch()
      x86: convert arch_futex_atomic_op_inuser() to user_access_begin/user_access_end()
      x86: don't reload after cmpxchg in unsafe_atomic_op2() loop
      generic arch_futex_atomic_op_inuser() doesn't need access_ok()
      x86: get rid of user_atomic_cmpxchg_inatomic()

Boqun Feng (1):
      locking/lockdep: Avoid recursion in lockdep_count_{for,back}ward_deps()

Clark Williams (1):
      thermal/x86_pkg_temp: Make pkg_temp_lock a raw_spinlock_t

Davidlohr Bueso (2):
      locking/percpu-rwsem: Fold __percpu_up_read()
      locking/percpu-rwsem: Add might_sleep() for writer locking

Logan Gunthorpe (1):
      PCI/switchtec: Fix init_completion race condition with poll_wait()

Peter Zijlstra (13):
      locking/percpu-rwsem, lockdep: Make percpu-rwsem use its own lockdep_map
      locking/percpu-rwsem: Convert to bool
      locking/percpu-rwsem: Move __this_cpu_inc() into the slowpath
      locking/percpu-rwsem: Extract __percpu_down_read_trylock()
      locking/percpu-rwsem: Remove the embedded rwsem
      locking/rwsem: Remove RWSEM_OWNER_UNKNOWN
      futex: Remove pointless mmgrap() + mmdrop()
      futex: Remove {get,drop}_futex_key_refs()
      locking/lockdep: Fix bad recursion pattern
      locking/lockdep: Rework lockdep_lock
      lockdep: Teach lockdep about "USED" <- "IN-NMI" inversions
      acpi: Remove header dependency
      lockdep: Introduce wait-type checks

Peter Zijlstra (Intel) (2):
      rcuwait: Add @state argument to rcuwait_wait_event()
      powerpc/ps3: Convert half completion to rcuwait

Randy Dunlap (1):
      Documentation/locking/locktypes: Minor copy editor fixes

Sebastian Andrzej Siewior (9):
      pci/switchtec: Replace completion wait queue usage for poll
      nds32: Remove mm.h from asm/uaccess.h
      csky: Remove mm.h from asm/uaccess.h
      hexagon: Remove mm.h from asm/uaccess.h
      ia64: Remove mm.h from asm/uaccess.h
      microblaze: Remove mm.h from asm/uaccess.h
      lockdep: Add hrtimer context tracing bits
      lockdep: Annotate irq_work
      lockdep: Add posixtimer context tracing bits

Sebastian Siewior (1):
      completion: Use lockdep_assert_RT_in_threaded_ctx() in complete_all()

Thomas Gleixner (9):
      usb: gadget: Use completion interface instead of open coding it
      orinoco_usb: Use the regular completion interfaces
      Documentation: Add lock ordering and nesting documentation
      timekeeping: Split jiffies seqlock
      sched/swait: Prepare usage in completions
      completion: Use simple wait queues
      m68knommu: Remove mm.h include from uaccess_no.h
      Documentation/locking/locktypes: Further clarifications and wordsmithing
      fs/buffer: Make BH_Uptodate_Lock bit_spin_lock a regular spinlock_t

Waiman Long (6):
      locking/lockdep: Decrement IRQ context counters when removing lock chain
      locking/lockdep: Display irq_context names in /proc/lockdep_chains
      locking/lockdep: Track number of zapped classes
      locking/lockdep: Throw away all lock chains with zapped class
      locking/lockdep: Track number of zapped lock chains
      locking/lockdep: Reuse freed chain_hlocks entries

Will Deacon (1):
      asm-generic/bitops: Update stale comment


 Documentation/locking/index.rst                    |   1 +
 Documentation/locking/locktypes.rst                | 347 +++++++++++
 arch/alpha/include/asm/futex.h                     |   5 +-
 arch/arc/include/asm/futex.h                       |   5 +-
 arch/arm/include/asm/futex.h                       |   5 +-
 arch/arm64/include/asm/futex.h                     |   5 +-
 arch/csky/include/asm/uaccess.h                    |   1 -
 arch/hexagon/include/asm/futex.h                   |   5 +-
 arch/hexagon/include/asm/uaccess.h                 |   1 -
 arch/ia64/include/asm/futex.h                      |   5 +-
 arch/ia64/include/asm/uaccess.h                    |   1 -
 arch/ia64/kernel/process.c                         |   1 +
 arch/ia64/mm/ioremap.c                             |   1 +
 arch/m68k/include/asm/uaccess_no.h                 |   1 -
 arch/microblaze/include/asm/futex.h                |   5 +-
 arch/microblaze/include/asm/uaccess.h              |   1 -
 arch/mips/include/asm/futex.h                      |   5 +-
 arch/nds32/include/asm/futex.h                     |   6 +-
 arch/nds32/include/asm/uaccess.h                   |   1 -
 arch/openrisc/include/asm/futex.h                  |   5 +-
 arch/parisc/include/asm/futex.h                    |   2 -
 arch/powerpc/include/asm/futex.h                   |   5 +-
 arch/powerpc/platforms/ps3/device-init.c           |  18 +-
 arch/riscv/include/asm/futex.h                     |   5 +-
 arch/s390/include/asm/futex.h                      |   2 -
 arch/sh/include/asm/futex.h                        |   4 -
 arch/sparc/include/asm/futex_64.h                  |   4 -
 arch/x86/include/asm/futex.h                       |  99 +--
 arch/x86/include/asm/uaccess.h                     |  93 ---
 arch/xtensa/include/asm/futex.h                    |   5 +-
 .../net/wireless/intersil/orinoco/orinoco_usb.c    |  21 +-
 drivers/pci/switch/switchtec.c                     |  22 +-
 drivers/platform/x86/dell-smo8800.c                |   1 +
 drivers/platform/x86/wmi.c                         |   1 +
 .../intel/int340x_thermal/acpi_thermal_rel.c       |   1 +
 drivers/thermal/intel/x86_pkg_temp_thermal.c       |  24 +-
 drivers/usb/gadget/function/f_fs.c                 |   2 +-
 drivers/usb/gadget/legacy/inode.c                  |   4 +-
 fs/buffer.c                                        |  19 +-
 fs/ext4/page-io.c                                  |   8 +-
 fs/ntfs/aops.c                                     |   9 +-
 include/acpi/acpi_bus.h                            |   2 +-
 include/asm-generic/bitops.h                       |   5 +-
 include/asm-generic/futex.h                        |   2 -
 include/linux/buffer_head.h                        |   6 +-
 include/linux/completion.h                         |   8 +-
 include/linux/irq_work.h                           |   2 +
 include/linux/irqflags.h                           |  48 +-
 include/linux/lockdep.h                            |  86 ++-
 include/linux/mutex.h                              |   7 +-
 include/linux/percpu-rwsem.h                       |  83 +--
 include/linux/rcuwait.h                            |  12 +-
 include/linux/rwlock_types.h                       |   6 +-
 include/linux/rwsem.h                              |  12 +-
 include/linux/sched.h                              |   2 +
 include/linux/spinlock.h                           |  35 +-
 include/linux/spinlock_types.h                     |  24 +-
 include/linux/wait.h                               |   1 +
 kernel/cpu.c                                       |   4 +-
 kernel/exit.c                                      |   1 +
 kernel/futex.c                                     | 107 +---
 kernel/irq/handle.c                                |   7 +
 kernel/irq_work.c                                  |   2 +
 kernel/locking/lockdep.c                           | 674 +++++++++++++++++----
 kernel/locking/lockdep_internals.h                 |  14 +-
 kernel/locking/lockdep_proc.c                      |  31 +-
 kernel/locking/mutex-debug.c                       |   2 +-
 kernel/locking/percpu-rwsem.c                      | 194 ++++--
 kernel/locking/rwsem.c                             |   9 +-
 kernel/locking/rwsem.h                             |  10 -
 kernel/locking/spinlock_debug.c                    |   6 +-
 kernel/rcu/tree.c                                  |   1 +
 kernel/rcu/update.c                                |  24 +-
 kernel/sched/completion.c                          |  36 +-
 kernel/sched/sched.h                               |   3 +
 kernel/sched/swait.c                               |  15 +-
 kernel/time/hrtimer.c                              |   6 +-
 kernel/time/jiffies.c                              |   7 +-
 kernel/time/posix-cpu-timers.c                     |   6 +-
 kernel/time/tick-common.c                          |  10 +-
 kernel/time/tick-sched.c                           |  20 +-
 kernel/time/timekeeping.c                          |   6 +-
 kernel/time/timekeeping.h                          |   3 +-
 lib/Kconfig.debug                                  |  17 +
 tools/objtool/check.c                              |   1 +
 85 files changed, 1611 insertions(+), 702 deletions(-)
 create mode 100644 Documentation/locking/locktypes.rst
