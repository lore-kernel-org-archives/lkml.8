Return-Path: <SRS0=5bHT=BN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,INCLUDES_PULL_REQUEST,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 66132C433E0
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Aug 2020 09:39:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2D15D20722
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Aug 2020 09:39:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1596447589;
	bh=A6pdrJac209oL6Jt8qw0836N9oAsZBGFJC+ecL2wqxU=;
	h=Date:From:To:Cc:Subject:List-ID:From;
	b=PkDcZCvd9YQoWvZaWcSdLD3qOssInoyP2kvqriCUjeZ93linCFTq07S433C5AKqM2
	 WXt6eFHDT97xLrN3ycBYUR7VVCFKGnsM9L0JjO9kVUqkMFU4WHddgZeTBEnkLEg0Yt
	 hCNRWwkLakUP1KMD/5DU/MhC3Ar5zgY+at2ieLAQ=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726398AbgHCJjs (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 3 Aug 2020 05:39:48 -0400
Received: from mail.kernel.org ([198.145.29.99]:54700 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725948AbgHCJjr (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Aug 2020 05:39:47 -0400
Received: from kernel.org (unknown [87.70.91.42])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 4466420719;
        Mon,  3 Aug 2020 09:39:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1596447585;
        bh=A6pdrJac209oL6Jt8qw0836N9oAsZBGFJC+ecL2wqxU=;
        h=Date:From:To:Cc:Subject:From;
        b=sKup/vJQfbGwbGgkOfN9KrXVdFXun9eBJtglCOOkztrZxPI18mo4r+aEGgXITqSt2
         pYsHLdDyH1/blW3SL7tsS9IQbCdmj9Is8CH4err4MJhkCbZ7KacDQ4z0d6r8ByplcD
         B7I8YTibkl6xFnh9c/dt008UXWdZqXG3pYqgJJrk=
Date:   Mon, 3 Aug 2020 12:39:39 +0300
From:   Mike Rapoport <rppt@kernel.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Arnd Bergmann <arnd@arndb.de>, Guan Xuetao <gxt@pku.edu.cn>,
        Guenter Roeck <linux@roeck-us.net>,
        Mike Rapoport <rppt@linux.ibm.com>,
        Mike Rapoport <rppt@kernel.org>,
        Peter Maydell <peter.maydell@linaro.org>,
        linux-kernel@vger.kernel.org
Subject: [GIT PULL] remove unicore32 support
Message-ID: <20200803093939.GA8243@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Linus,

The following changes since commit 9ebcfadb0610322ac537dd7aa5d9cbc2b2894c68:

  Linux 5.8-rc3 (2020-06-28 15:00:24 -0700)

are available in the Git repository at:

  https://git.kernel.org/pub/scm/linux/kernel/git/rppt/linux.git/ tags/rm-unicore32

for you to fetch changes up to 3346dd99fb4cd174fdbfb68dc62cd109e4323f0f:

  MAINTAINERS: remove "PKUNITY SOC DRIVERS" entry (2020-07-01 12:11:02 +0300)

----------------------------------------------------------------

The unicore32 port do not seem maintained for a long time now, there is no
upstream toolchain that can create unicore32 binaries and all the links to
prebuilt toolchains for unicore32 are dead. Even compilers that were
available are not supported by the kernel anymore.

Guenter Roeck says:

  I have stopped building unicore32 images since v4.19 since there is no
  available compiler that is still supported by the kernel. I am surprised
  that support for it has not been removed from the kernel.

However, it's worth pointing out two things:

- Guan Xuetao is still listed as maintainer and asked for the port to be
  kept around the last time Arnd suggested removing it two years ago. He
  promised that there would be compiler sources (presumably llvm), but has
  not made those available since.

- https://github.com/gxt has patches to linux-4.9 and qemu-2.7, both
  released in 2016, with patches dated early 2019. These patches mainly
  restore a syscall ABI that was never part of mainline Linux but apparently
  used in production. qemu-2.8 removed support for that ABI and newer kernels
  (4.19+) can no longer be built with the old toolchain, so apparently
  there will not be any future updates to that git tree.

----------------------------------------------------------------
Mike Rapoport (8):
      arch: remove unicore32 port
      cpufreq: remove unicore32 driver
      i2c/buses: remove i2c-puv3  driver
      input: i8042: remove support for 8042-unicore32io
      pwm: remove pwm-puv3  driver
      video: fbdev: remove fb-puv3  driver
      rtc: remove fb-puv3  driver
      MAINTAINERS: remove "PKUNITY SOC DRIVERS" entry

 .../features/core/cBPF-JIT/arch-support.txt        |   1 -
 .../features/core/eBPF-JIT/arch-support.txt        |   1 -
 .../core/generic-idle-thread/arch-support.txt      |   1 -
 .../features/core/jump-labels/arch-support.txt     |   1 -
 .../features/core/tracehook/arch-support.txt       |   1 -
 .../features/debug/KASAN/arch-support.txt          |   1 -
 .../debug/debug-vm-pgtable/arch-support.txt        |   1 -
 .../debug/gcov-profile-all/arch-support.txt        |   1 -
 Documentation/features/debug/kgdb/arch-support.txt |   1 -
 .../debug/kprobes-on-ftrace/arch-support.txt       |   1 -
 .../features/debug/kprobes/arch-support.txt        |   1 -
 .../features/debug/kretprobes/arch-support.txt     |   1 -
 .../features/debug/optprobes/arch-support.txt      |   1 -
 .../features/debug/stackprotector/arch-support.txt |   1 -
 .../features/debug/uprobes/arch-support.txt        |   1 -
 .../debug/user-ret-profiler/arch-support.txt       |   1 -
 .../features/io/dma-contiguous/arch-support.txt    |   1 -
 .../locking/cmpxchg-local/arch-support.txt         |   1 -
 .../features/locking/lockdep/arch-support.txt      |   1 -
 .../locking/queued-rwlocks/arch-support.txt        |   1 -
 .../locking/queued-spinlocks/arch-support.txt      |   1 -
 .../features/perf/kprobes-event/arch-support.txt   |   1 -
 .../features/perf/perf-regs/arch-support.txt       |   1 -
 .../features/perf/perf-stackdump/arch-support.txt  |   1 -
 .../sched/membarrier-sync-core/arch-support.txt    |   1 -
 .../features/sched/numa-balancing/arch-support.txt |   1 -
 .../seccomp/seccomp-filter/arch-support.txt        |   1 -
 .../time/arch-tick-broadcast/arch-support.txt      |   1 -
 .../features/time/clockevents/arch-support.txt     |   1 -
 .../time/context-tracking/arch-support.txt         |   1 -
 .../features/time/irq-time-acct/arch-support.txt   |   1 -
 .../time/modern-timekeeping/arch-support.txt       |   1 -
 .../features/time/virt-cpuacct/arch-support.txt    |   1 -
 .../features/vm/ELF-ASLR/arch-support.txt          |   1 -
 .../features/vm/PG_uncached/arch-support.txt       |   1 -
 Documentation/features/vm/THP/arch-support.txt     |   1 -
 Documentation/features/vm/TLB/arch-support.txt     |   1 -
 .../features/vm/huge-vmap/arch-support.txt         |   1 -
 .../features/vm/ioremap_prot/arch-support.txt      |   1 -
 .../features/vm/pte_special/arch-support.txt       |   1 -
 MAINTAINERS                                        |  17 -
 arch/unicore32/.gitignore                          |  22 -
 arch/unicore32/Kconfig                             | 200 -----
 arch/unicore32/Kconfig.debug                       |  29 -
 arch/unicore32/Makefile                            |  59 --
 arch/unicore32/boot/Makefile                       |  39 -
 arch/unicore32/boot/compressed/Makefile            |  64 --
 arch/unicore32/boot/compressed/head.S              | 201 -----
 arch/unicore32/boot/compressed/misc.c              | 123 ---
 arch/unicore32/boot/compressed/piggy.S.in          |   6 -
 arch/unicore32/boot/compressed/vmlinux.lds.S       |  58 --
 arch/unicore32/configs/defconfig                   | 214 ------
 arch/unicore32/include/asm/Kbuild                  |   7 -
 arch/unicore32/include/asm/assembler.h             | 128 ----
 arch/unicore32/include/asm/barrier.h               |  16 -
 arch/unicore32/include/asm/bitops.h                |  46 --
 arch/unicore32/include/asm/bug.h                   |  20 -
 arch/unicore32/include/asm/cache.h                 |  24 -
 arch/unicore32/include/asm/cacheflush.h            | 186 -----
 arch/unicore32/include/asm/checksum.h              |  38 -
 arch/unicore32/include/asm/cmpxchg.h               |  58 --
 arch/unicore32/include/asm/cpu-single.h            |  42 --
 arch/unicore32/include/asm/cputype.h               |  30 -
 arch/unicore32/include/asm/delay.h                 |  49 --
 arch/unicore32/include/asm/dma.h                   |  20 -
 arch/unicore32/include/asm/elf.h                   |  90 ---
 arch/unicore32/include/asm/fpstate.h               |  23 -
 arch/unicore32/include/asm/fpu-ucf64.h             |  50 --
 arch/unicore32/include/asm/gpio.h                  | 101 ---
 arch/unicore32/include/asm/hwcap.h                 |  29 -
 arch/unicore32/include/asm/hwdef-copro.h           |  45 --
 arch/unicore32/include/asm/io.h                    |  69 --
 arch/unicore32/include/asm/irq.h                   | 102 ---
 arch/unicore32/include/asm/irqflags.h              |  50 --
 arch/unicore32/include/asm/linkage.h               |  19 -
 arch/unicore32/include/asm/memblock.h              |  43 --
 arch/unicore32/include/asm/memory.h                | 102 ---
 arch/unicore32/include/asm/mmu.h                   |  14 -
 arch/unicore32/include/asm/mmu_context.h           |  98 ---
 arch/unicore32/include/asm/page.h                  |  74 --
 arch/unicore32/include/asm/pci.h                   |  20 -
 arch/unicore32/include/asm/pgalloc.h               |  87 ---
 arch/unicore32/include/asm/pgtable-hwdef.h         |  51 --
 arch/unicore32/include/asm/pgtable.h               | 267 -------
 arch/unicore32/include/asm/processor.h             |  74 --
 arch/unicore32/include/asm/ptrace.h                |  58 --
 arch/unicore32/include/asm/stacktrace.h            |  28 -
 arch/unicore32/include/asm/string.h                |  35 -
 arch/unicore32/include/asm/suspend.h               |  26 -
 arch/unicore32/include/asm/switch_to.h             |  27 -
 arch/unicore32/include/asm/syscall.h               |  12 -
 arch/unicore32/include/asm/thread_info.h           | 133 ----
 arch/unicore32/include/asm/timex.h                 |  31 -
 arch/unicore32/include/asm/tlb.h                   |  24 -
 arch/unicore32/include/asm/tlbflush.h              | 192 -----
 arch/unicore32/include/asm/traps.h                 |  18 -
 arch/unicore32/include/asm/uaccess.h               |  38 -
 arch/unicore32/include/asm/vmalloc.h               |   4 -
 arch/unicore32/include/mach/PKUnity.h              |  95 ---
 arch/unicore32/include/mach/bitfield.h             |  21 -
 arch/unicore32/include/mach/dma.h                  |  45 --
 arch/unicore32/include/mach/hardware.h             |  30 -
 arch/unicore32/include/mach/map.h                  |  17 -
 arch/unicore32/include/mach/memory.h               |  54 --
 arch/unicore32/include/mach/ocd.h                  |  33 -
 arch/unicore32/include/mach/pm.h                   |  37 -
 arch/unicore32/include/mach/regs-ac97.h            |  33 -
 arch/unicore32/include/mach/regs-dmac.h            |  82 --
 arch/unicore32/include/mach/regs-gpio.h            |  71 --
 arch/unicore32/include/mach/regs-i2c.h             |  64 --
 arch/unicore32/include/mach/regs-intc.h            |  29 -
 arch/unicore32/include/mach/regs-nand.h            |  80 --
 arch/unicore32/include/mach/regs-ost.h             |  91 ---
 arch/unicore32/include/mach/regs-pci.h             |  95 ---
 arch/unicore32/include/mach/regs-pm.h              | 127 ----
 arch/unicore32/include/mach/regs-ps2.h             |  21 -
 arch/unicore32/include/mach/regs-resetc.h          |  35 -
 arch/unicore32/include/mach/regs-rtc.h             |  38 -
 arch/unicore32/include/mach/regs-sdc.h             | 157 ----
 arch/unicore32/include/mach/regs-spi.h             |  99 ---
 arch/unicore32/include/mach/regs-uart.h            |   3 -
 arch/unicore32/include/mach/regs-umal.h            | 230 ------
 arch/unicore32/include/mach/regs-unigfx.h          | 201 -----
 arch/unicore32/include/mach/uncompress.h           |  31 -
 arch/unicore32/include/uapi/asm/Kbuild             |   2 -
 arch/unicore32/include/uapi/asm/byteorder.h        |  25 -
 arch/unicore32/include/uapi/asm/ptrace.h           |  91 ---
 arch/unicore32/include/uapi/asm/sigcontext.h       |  30 -
 arch/unicore32/include/uapi/asm/unistd.h           |  21 -
 arch/unicore32/kernel/Makefile                     |  31 -
 arch/unicore32/kernel/asm-offsets.c                | 108 ---
 arch/unicore32/kernel/clock.c                      | 387 ----------
 arch/unicore32/kernel/debug-macro.S                |  86 ---
 arch/unicore32/kernel/debug.S                      |  82 --
 arch/unicore32/kernel/dma.c                        | 179 -----
 arch/unicore32/kernel/early_printk.c               |  46 --
 arch/unicore32/kernel/elf.c                        |  35 -
 arch/unicore32/kernel/entry.S                      | 802 --------------------
 arch/unicore32/kernel/fpu-ucf64.c                  | 117 ---
 arch/unicore32/kernel/gpio.c                       | 121 ---
 arch/unicore32/kernel/head.S                       | 249 ------
 arch/unicore32/kernel/hibernate.c                  | 159 ----
 arch/unicore32/kernel/hibernate_asm.S              | 114 ---
 arch/unicore32/kernel/irq.c                        | 371 ---------
 arch/unicore32/kernel/ksyms.c                      |  57 --
 arch/unicore32/kernel/ksyms.h                      |  14 -
 arch/unicore32/kernel/module.c                     | 105 ---
 arch/unicore32/kernel/pci.c                        | 371 ---------
 arch/unicore32/kernel/pm.c                         | 121 ---
 arch/unicore32/kernel/process.c                    | 319 --------
 arch/unicore32/kernel/ptrace.c                     | 147 ----
 arch/unicore32/kernel/puv3-core.c                  | 276 -------
 arch/unicore32/kernel/puv3-nb0916.c                | 147 ----
 arch/unicore32/kernel/setup.c                      | 352 ---------
 arch/unicore32/kernel/setup.h                      |  36 -
 arch/unicore32/kernel/signal.c                     | 424 -----------
 arch/unicore32/kernel/sleep.S                      | 199 -----
 arch/unicore32/kernel/stacktrace.c                 | 127 ----
 arch/unicore32/kernel/sys.c                        |  37 -
 arch/unicore32/kernel/time.c                       | 128 ----
 arch/unicore32/kernel/traps.c                      | 322 --------
 arch/unicore32/kernel/vmlinux.lds.S                |  59 --
 arch/unicore32/lib/Makefile                        |  28 -
 arch/unicore32/lib/backtrace.S                     | 168 -----
 arch/unicore32/lib/clear_user.S                    |  54 --
 arch/unicore32/lib/copy_from_user.S                | 101 ---
 arch/unicore32/lib/copy_page.S                     |  36 -
 arch/unicore32/lib/copy_template.S                 | 211 ------
 arch/unicore32/lib/copy_to_user.S                  |  93 ---
 arch/unicore32/lib/delay.S                         |  48 --
 arch/unicore32/lib/findbit.S                       |  97 ---
 arch/unicore32/lib/strncpy_from_user.S             |  42 --
 arch/unicore32/lib/strnlen_user.S                  |  39 -
 arch/unicore32/mm/Kconfig                          |  41 -
 arch/unicore32/mm/Makefile                         |  14 -
 arch/unicore32/mm/alignment.c                      | 524 -------------
 arch/unicore32/mm/cache-ucv2.S                     | 209 ------
 arch/unicore32/mm/extable.c                        |  21 -
 arch/unicore32/mm/fault.c                          | 481 ------------
 arch/unicore32/mm/flush.c                          |  94 ---
 arch/unicore32/mm/init.c                           | 261 -------
 arch/unicore32/mm/ioremap.c                        | 242 ------
 arch/unicore32/mm/mm.h                             |  31 -
 arch/unicore32/mm/mmu.c                            | 513 -------------
 arch/unicore32/mm/pgd.c                            | 102 ---
 arch/unicore32/mm/proc-macros.S                    | 142 ----
 arch/unicore32/mm/proc-syms.c                      |  19 -
 arch/unicore32/mm/proc-ucv2.S                      | 131 ----
 arch/unicore32/mm/tlb-ucv2.S                       |  86 ---
 drivers/cpufreq/Makefile                           |   1 -
 drivers/cpufreq/unicore2-cpufreq.c                 |  76 --
 drivers/i2c/busses/Kconfig                         |  11 -
 drivers/i2c/busses/Makefile                        |   1 -
 drivers/i2c/busses/i2c-puv3.c                      | 275 -------
 drivers/input/serio/i8042-unicore32io.h            |  70 --
 drivers/input/serio/i8042.h                        |   2 -
 drivers/pwm/Kconfig                                |   9 -
 drivers/pwm/Makefile                               |   1 -
 drivers/pwm/pwm-puv3.c                             | 150 ----
 drivers/rtc/Kconfig                                |   9 -
 drivers/rtc/Makefile                               |   1 -
 drivers/rtc/rtc-puv3.c                             | 286 -------
 drivers/video/fbdev/Kconfig                        |  11 -
 drivers/video/fbdev/Makefile                       |   1 -
 drivers/video/fbdev/fb-puv3.c                      | 836 ---------------------
 kernel/reboot.c                                    |   2 +-
 206 files changed, 1 insertion(+), 17455 deletions(-)
 delete mode 100644 arch/unicore32/.gitignore
 delete mode 100644 arch/unicore32/Kconfig
 delete mode 100644 arch/unicore32/Kconfig.debug
 delete mode 100644 arch/unicore32/Makefile
 delete mode 100644 arch/unicore32/boot/Makefile
 delete mode 100644 arch/unicore32/boot/compressed/Makefile
 delete mode 100644 arch/unicore32/boot/compressed/head.S
 delete mode 100644 arch/unicore32/boot/compressed/misc.c
 delete mode 100644 arch/unicore32/boot/compressed/piggy.S.in
 delete mode 100644 arch/unicore32/boot/compressed/vmlinux.lds.S
 delete mode 100644 arch/unicore32/configs/defconfig
 delete mode 100644 arch/unicore32/include/asm/Kbuild
 delete mode 100644 arch/unicore32/include/asm/assembler.h
 delete mode 100644 arch/unicore32/include/asm/barrier.h
 delete mode 100644 arch/unicore32/include/asm/bitops.h
 delete mode 100644 arch/unicore32/include/asm/bug.h
 delete mode 100644 arch/unicore32/include/asm/cache.h
 delete mode 100644 arch/unicore32/include/asm/cacheflush.h
 delete mode 100644 arch/unicore32/include/asm/checksum.h
 delete mode 100644 arch/unicore32/include/asm/cmpxchg.h
 delete mode 100644 arch/unicore32/include/asm/cpu-single.h
 delete mode 100644 arch/unicore32/include/asm/cputype.h
 delete mode 100644 arch/unicore32/include/asm/delay.h
 delete mode 100644 arch/unicore32/include/asm/dma.h
 delete mode 100644 arch/unicore32/include/asm/elf.h
 delete mode 100644 arch/unicore32/include/asm/fpstate.h
 delete mode 100644 arch/unicore32/include/asm/fpu-ucf64.h
 delete mode 100644 arch/unicore32/include/asm/gpio.h
 delete mode 100644 arch/unicore32/include/asm/hwcap.h
 delete mode 100644 arch/unicore32/include/asm/hwdef-copro.h
 delete mode 100644 arch/unicore32/include/asm/io.h
 delete mode 100644 arch/unicore32/include/asm/irq.h
 delete mode 100644 arch/unicore32/include/asm/irqflags.h
 delete mode 100644 arch/unicore32/include/asm/linkage.h
 delete mode 100644 arch/unicore32/include/asm/memblock.h
 delete mode 100644 arch/unicore32/include/asm/memory.h
 delete mode 100644 arch/unicore32/include/asm/mmu.h
 delete mode 100644 arch/unicore32/include/asm/mmu_context.h
 delete mode 100644 arch/unicore32/include/asm/page.h
 delete mode 100644 arch/unicore32/include/asm/pci.h
 delete mode 100644 arch/unicore32/include/asm/pgalloc.h
 delete mode 100644 arch/unicore32/include/asm/pgtable-hwdef.h
 delete mode 100644 arch/unicore32/include/asm/pgtable.h
 delete mode 100644 arch/unicore32/include/asm/processor.h
 delete mode 100644 arch/unicore32/include/asm/ptrace.h
 delete mode 100644 arch/unicore32/include/asm/stacktrace.h
 delete mode 100644 arch/unicore32/include/asm/string.h
 delete mode 100644 arch/unicore32/include/asm/suspend.h
 delete mode 100644 arch/unicore32/include/asm/switch_to.h
 delete mode 100644 arch/unicore32/include/asm/syscall.h
 delete mode 100644 arch/unicore32/include/asm/thread_info.h
 delete mode 100644 arch/unicore32/include/asm/timex.h
 delete mode 100644 arch/unicore32/include/asm/tlb.h
 delete mode 100644 arch/unicore32/include/asm/tlbflush.h
 delete mode 100644 arch/unicore32/include/asm/traps.h
 delete mode 100644 arch/unicore32/include/asm/uaccess.h
 delete mode 100644 arch/unicore32/include/asm/vmalloc.h
 delete mode 100644 arch/unicore32/include/mach/PKUnity.h
 delete mode 100644 arch/unicore32/include/mach/bitfield.h
 delete mode 100644 arch/unicore32/include/mach/dma.h
 delete mode 100644 arch/unicore32/include/mach/hardware.h
 delete mode 100644 arch/unicore32/include/mach/map.h
 delete mode 100644 arch/unicore32/include/mach/memory.h
 delete mode 100644 arch/unicore32/include/mach/ocd.h
 delete mode 100644 arch/unicore32/include/mach/pm.h
 delete mode 100644 arch/unicore32/include/mach/regs-ac97.h
 delete mode 100644 arch/unicore32/include/mach/regs-dmac.h
 delete mode 100644 arch/unicore32/include/mach/regs-gpio.h
 delete mode 100644 arch/unicore32/include/mach/regs-i2c.h
 delete mode 100644 arch/unicore32/include/mach/regs-intc.h
 delete mode 100644 arch/unicore32/include/mach/regs-nand.h
 delete mode 100644 arch/unicore32/include/mach/regs-ost.h
 delete mode 100644 arch/unicore32/include/mach/regs-pci.h
 delete mode 100644 arch/unicore32/include/mach/regs-pm.h
 delete mode 100644 arch/unicore32/include/mach/regs-ps2.h
 delete mode 100644 arch/unicore32/include/mach/regs-resetc.h
 delete mode 100644 arch/unicore32/include/mach/regs-rtc.h
 delete mode 100644 arch/unicore32/include/mach/regs-sdc.h
 delete mode 100644 arch/unicore32/include/mach/regs-spi.h
 delete mode 100644 arch/unicore32/include/mach/regs-uart.h
 delete mode 100644 arch/unicore32/include/mach/regs-umal.h
 delete mode 100644 arch/unicore32/include/mach/regs-unigfx.h
 delete mode 100644 arch/unicore32/include/mach/uncompress.h
 delete mode 100644 arch/unicore32/include/uapi/asm/Kbuild
 delete mode 100644 arch/unicore32/include/uapi/asm/byteorder.h
 delete mode 100644 arch/unicore32/include/uapi/asm/ptrace.h
 delete mode 100644 arch/unicore32/include/uapi/asm/sigcontext.h
 delete mode 100644 arch/unicore32/include/uapi/asm/unistd.h
 delete mode 100644 arch/unicore32/kernel/Makefile
 delete mode 100644 arch/unicore32/kernel/asm-offsets.c
 delete mode 100644 arch/unicore32/kernel/clock.c
 delete mode 100644 arch/unicore32/kernel/debug-macro.S
 delete mode 100644 arch/unicore32/kernel/debug.S
 delete mode 100644 arch/unicore32/kernel/dma.c
 delete mode 100644 arch/unicore32/kernel/early_printk.c
 delete mode 100644 arch/unicore32/kernel/elf.c
 delete mode 100644 arch/unicore32/kernel/entry.S
 delete mode 100644 arch/unicore32/kernel/fpu-ucf64.c
 delete mode 100644 arch/unicore32/kernel/gpio.c
 delete mode 100644 arch/unicore32/kernel/head.S
 delete mode 100644 arch/unicore32/kernel/hibernate.c
 delete mode 100644 arch/unicore32/kernel/hibernate_asm.S
 delete mode 100644 arch/unicore32/kernel/irq.c
 delete mode 100644 arch/unicore32/kernel/ksyms.c
 delete mode 100644 arch/unicore32/kernel/ksyms.h
 delete mode 100644 arch/unicore32/kernel/module.c
 delete mode 100644 arch/unicore32/kernel/pci.c
 delete mode 100644 arch/unicore32/kernel/pm.c
 delete mode 100644 arch/unicore32/kernel/process.c
 delete mode 100644 arch/unicore32/kernel/ptrace.c
 delete mode 100644 arch/unicore32/kernel/puv3-core.c
 delete mode 100644 arch/unicore32/kernel/puv3-nb0916.c
 delete mode 100644 arch/unicore32/kernel/setup.c
 delete mode 100644 arch/unicore32/kernel/setup.h
 delete mode 100644 arch/unicore32/kernel/signal.c
 delete mode 100644 arch/unicore32/kernel/sleep.S
 delete mode 100644 arch/unicore32/kernel/stacktrace.c
 delete mode 100644 arch/unicore32/kernel/sys.c
 delete mode 100644 arch/unicore32/kernel/time.c
 delete mode 100644 arch/unicore32/kernel/traps.c
 delete mode 100644 arch/unicore32/kernel/vmlinux.lds.S
 delete mode 100644 arch/unicore32/lib/Makefile
 delete mode 100644 arch/unicore32/lib/backtrace.S
 delete mode 100644 arch/unicore32/lib/clear_user.S
 delete mode 100644 arch/unicore32/lib/copy_from_user.S
 delete mode 100644 arch/unicore32/lib/copy_page.S
 delete mode 100644 arch/unicore32/lib/copy_template.S
 delete mode 100644 arch/unicore32/lib/copy_to_user.S
 delete mode 100644 arch/unicore32/lib/delay.S
 delete mode 100644 arch/unicore32/lib/findbit.S
 delete mode 100644 arch/unicore32/lib/strncpy_from_user.S
 delete mode 100644 arch/unicore32/lib/strnlen_user.S
 delete mode 100644 arch/unicore32/mm/Kconfig
 delete mode 100644 arch/unicore32/mm/Makefile
 delete mode 100644 arch/unicore32/mm/alignment.c
 delete mode 100644 arch/unicore32/mm/cache-ucv2.S
 delete mode 100644 arch/unicore32/mm/extable.c
 delete mode 100644 arch/unicore32/mm/fault.c
 delete mode 100644 arch/unicore32/mm/flush.c
 delete mode 100644 arch/unicore32/mm/init.c
 delete mode 100644 arch/unicore32/mm/ioremap.c
 delete mode 100644 arch/unicore32/mm/mm.h
 delete mode 100644 arch/unicore32/mm/mmu.c
 delete mode 100644 arch/unicore32/mm/pgd.c
 delete mode 100644 arch/unicore32/mm/proc-macros.S
 delete mode 100644 arch/unicore32/mm/proc-syms.c
 delete mode 100644 arch/unicore32/mm/proc-ucv2.S
 delete mode 100644 arch/unicore32/mm/tlb-ucv2.S
 delete mode 100644 drivers/cpufreq/unicore2-cpufreq.c
 delete mode 100644 drivers/i2c/busses/i2c-puv3.c
 delete mode 100644 drivers/input/serio/i8042-unicore32io.h
 delete mode 100644 drivers/pwm/pwm-puv3.c
 delete mode 100644 drivers/rtc/rtc-puv3.c
 delete mode 100644 drivers/video/fbdev/fb-puv3.c
