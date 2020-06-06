Return-Path: <SRS0=ne2O=7T=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.2 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 43891C433E0
	for <linux-kernel@archiver.kernel.org>; Sat,  6 Jun 2020 16:56:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0DF0F207ED
	for <linux-kernel@archiver.kernel.org>; Sat,  6 Jun 2020 16:56:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728808AbgFFQ40 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 6 Jun 2020 12:56:26 -0400
Received: from brightrain.aerifal.cx ([216.12.86.13]:41748 "EHLO
        brightrain.aerifal.cx" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727989AbgFFQ4Z (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 6 Jun 2020 12:56:25 -0400
Date:   Sat, 6 Jun 2020 12:56:22 -0400
From:   Rich Felker <dalias@libc.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Linux-sh list <linux-sh@vger.kernel.org>,
        linux-kernel@vger.kernel.org,
        Yoshinori Sato <ysato@users.sourceforge.jp>
Subject: [GIT PULL] arch/sh updates for 5.8
Message-ID: <20200606165610.GA28637@brightrain.aerifal.cx>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following changes since commit 3d77e6a8804abcc0504c904bd6e5cdf3a5cf8162:

  Linux 5.7 (2020-05-31 16:49:15 -0700)

are available in the Git repository at:

  git://git.libc.org/linux-sh tags/sh-for-5.8

for you to fetch changes up to 37744feebc086908fd89760650f458ab19071750:

  sh: remove sh5 support (2020-06-01 14:48:52 -0400)

----------------------------------------------------------------
Fix for arch/sh build regression with newer binutils, removal of SH5,
fixes for module exports, and misc cleanup.

----------------------------------------------------------------
Arnd Bergmann (1):
      sh: remove sh5 support

Bin Meng (1):
      sh: Replace CONFIG_MTD_M25P80 with CONFIG_MTD_SPI_NOR in sh7757lcr_defconfig

Krzysztof Kozlowski (2):
      sh: sh4a: Bring back tmu3_device early device
      sh: configs: Cleanup old Kconfig IO scheduler options

Kuninori Morimoto (4):
      sh: Add missing DECLARE_EXPORT() for __ashiftrt_r4_xx
      sh: Convert iounmap() macros to inline functions
      sh: Convert ins[bwl]/outs[bwl] macros to inline functions
      sh: add missing EXPORT_SYMBOL() for __delay

Romain Naour (1):
      arch/sh: vmlinux.scr

 arch/sh/Kconfig                           |   62 +-
 arch/sh/Kconfig.cpu                       |    9 -
 arch/sh/Kconfig.debug                     |   13 +-
 arch/sh/Makefile                          |   29 +-
 arch/sh/boot/compressed/Makefile          |   12 +-
 arch/sh/boot/compressed/misc.c            |    8 -
 arch/sh/boot/compressed/vmlinux.scr       |    2 +-
 arch/sh/configs/apsh4ad0a_defconfig       |    3 +-
 arch/sh/configs/kfr2r09_defconfig         |    2 -
 arch/sh/configs/magicpanelr2_defconfig    |    2 -
 arch/sh/configs/polaris_defconfig         |    1 -
 arch/sh/configs/r7780mp_defconfig         |    2 -
 arch/sh/configs/r7785rp_defconfig         |    2 -
 arch/sh/configs/rsk7201_defconfig         |    2 -
 arch/sh/configs/rsk7203_defconfig         |    2 -
 arch/sh/configs/rsk7264_defconfig         |    2 -
 arch/sh/configs/rsk7269_defconfig         |    2 -
 arch/sh/configs/sdk7786_defconfig         |    3 +-
 arch/sh/configs/se7206_defconfig          |    2 -
 arch/sh/configs/se7343_defconfig          |    1 -
 arch/sh/configs/se7619_defconfig          |    2 -
 arch/sh/configs/se7705_defconfig          |    2 -
 arch/sh/configs/se7712_defconfig          |    2 -
 arch/sh/configs/se7721_defconfig          |    2 -
 arch/sh/configs/se7722_defconfig          |    2 -
 arch/sh/configs/se7780_defconfig          |    1 -
 arch/sh/configs/sh7710voipgw_defconfig    |    1 -
 arch/sh/configs/sh7757lcr_defconfig       |    2 +-
 arch/sh/configs/shmin_defconfig           |    2 -
 arch/sh/configs/ul2_defconfig             |    2 -
 arch/sh/drivers/pci/Makefile              |    1 -
 arch/sh/drivers/pci/ops-sh5.c             |   65 -
 arch/sh/drivers/pci/pci-sh5.c             |  217 ----
 arch/sh/drivers/pci/pci-sh5.h             |  108 --
 arch/sh/include/asm/barrier.h             |    4 +-
 arch/sh/include/asm/bitops.h              |   26 -
 arch/sh/include/asm/bl_bit.h              |   11 +-
 arch/sh/include/asm/bl_bit_64.h           |   37 -
 arch/sh/include/asm/bugs.h                |    4 -
 arch/sh/include/asm/cache_insns.h         |   12 +-
 arch/sh/include/asm/cache_insns_64.h      |   20 -
 arch/sh/include/asm/checksum.h            |    6 +-
 arch/sh/include/asm/elf.h                 |   23 -
 arch/sh/include/asm/extable.h             |    4 -
 arch/sh/include/asm/fixmap.h              |    4 -
 arch/sh/include/asm/io.h                  |    6 +-
 arch/sh/include/asm/io_noioport.h         |   34 +-
 arch/sh/include/asm/irq.h                 |    3 -
 arch/sh/include/asm/mmu_context.h         |   12 -
 arch/sh/include/asm/mmu_context_64.h      |   75 --
 arch/sh/include/asm/page.h                |   21 +-
 arch/sh/include/asm/pgtable.h             |   17 -
 arch/sh/include/asm/pgtable_64.h          |  307 -----
 arch/sh/include/asm/posix_types.h         |    6 +-
 arch/sh/include/asm/processor.h           |   14 +-
 arch/sh/include/asm/processor_64.h        |  212 ---
 arch/sh/include/asm/ptrace_64.h           |   14 -
 arch/sh/include/asm/string.h              |    6 +-
 arch/sh/include/asm/string_64.h           |   21 -
 arch/sh/include/asm/switch_to.h           |   11 +-
 arch/sh/include/asm/switch_to_64.h        |   32 -
 arch/sh/include/asm/syscall.h             |    6 +-
 arch/sh/include/asm/syscall_64.h          |   75 --
 arch/sh/include/asm/syscalls.h            |    9 +-
 arch/sh/include/asm/syscalls_64.h         |   18 -
 arch/sh/include/asm/thread_info.h         |    4 +-
 arch/sh/include/asm/tlb.h                 |    6 +-
 arch/sh/include/asm/tlb_64.h              |   68 -
 arch/sh/include/asm/traps.h               |    4 -
 arch/sh/include/asm/traps_64.h            |   35 -
 arch/sh/include/asm/types.h               |    5 -
 arch/sh/include/asm/uaccess.h             |    4 -
 arch/sh/include/asm/uaccess_64.h          |   85 --
 arch/sh/include/asm/unistd.h              |    6 +-
 arch/sh/include/asm/user.h                |    7 -
 arch/sh/include/asm/vermagic.h            |    4 -
 arch/sh/include/asm/vmlinux.lds.h         |    8 -
 arch/sh/include/cpu-sh5/cpu/addrspace.h   |   12 -
 arch/sh/include/cpu-sh5/cpu/cache.h       |   94 --
 arch/sh/include/cpu-sh5/cpu/irq.h         |  113 --
 arch/sh/include/cpu-sh5/cpu/mmu_context.h |   22 -
 arch/sh/include/cpu-sh5/cpu/registers.h   |  103 --
 arch/sh/include/cpu-sh5/cpu/rtc.h         |    9 -
 arch/sh/include/uapi/asm/posix_types.h    |    8 +-
 arch/sh/include/uapi/asm/posix_types_64.h |   29 -
 arch/sh/include/uapi/asm/ptrace.h         |    5 -
 arch/sh/include/uapi/asm/ptrace_64.h      |   15 -
 arch/sh/include/uapi/asm/sigcontext.h     |   13 -
 arch/sh/include/uapi/asm/stat.h           |   61 -
 arch/sh/include/uapi/asm/swab.h           |   10 -
 arch/sh/include/uapi/asm/unistd.h         |    8 +-
 arch/sh/include/uapi/asm/unistd_64.h      |  423 ------
 arch/sh/kernel/Makefile                   |   16 +-
 arch/sh/kernel/cpu/Makefile               |    1 -
 arch/sh/kernel/cpu/init.c                 |    2 +-
 arch/sh/kernel/cpu/irq/Makefile           |    3 +-
 arch/sh/kernel/cpu/irq/intc-sh5.c         |  194 ---
 arch/sh/kernel/cpu/proc.c                 |    1 -
 arch/sh/kernel/cpu/sh4a/setup-sh7786.c    |    1 +
 arch/sh/kernel/cpu/sh5/Makefile           |   16 -
 arch/sh/kernel/cpu/sh5/clock-sh5.c        |   76 --
 arch/sh/kernel/cpu/sh5/entry.S            | 2000 -----------------------------
 arch/sh/kernel/cpu/sh5/fpu.c              |  106 --
 arch/sh/kernel/cpu/sh5/probe.c            |   72 --
 arch/sh/kernel/cpu/sh5/setup-sh5.c        |  121 --
 arch/sh/kernel/cpu/sh5/switchto.S         |  195 ---
 arch/sh/kernel/cpu/sh5/unwind.c           |  342 -----
 arch/sh/kernel/head_64.S                  |  346 -----
 arch/sh/kernel/irq_64.c                   |   48 -
 arch/sh/kernel/module.c                   |    9 -
 arch/sh/kernel/process.c                  |    2 -
 arch/sh/kernel/process_64.c               |  461 -------
 arch/sh/kernel/ptrace_64.c                |  576 ---------
 arch/sh/kernel/reboot.c                   |    6 -
 arch/sh/kernel/sh_ksyms_32.c              |   17 +
 arch/sh/kernel/sh_ksyms_64.c              |   51 -
 arch/sh/kernel/signal_64.c                |  567 --------
 arch/sh/kernel/syscalls_64.S              |  419 ------
 arch/sh/kernel/traps_64.c                 |  814 ------------
 arch/sh/kernel/vmlinux.lds.S              |   18 +-
 arch/sh/lib/delay.c                       |    1 +
 arch/sh/lib64/Makefile                    |   17 -
 arch/sh/lib64/copy_page.S                 |   89 --
 arch/sh/lib64/copy_user_memcpy.S          |  218 ----
 arch/sh/lib64/memcpy.S                    |  202 ---
 arch/sh/lib64/memset.S                    |   92 --
 arch/sh/lib64/panic.c                     |   15 -
 arch/sh/lib64/sdivsi3.S                   |  136 --
 arch/sh/lib64/strcpy.S                    |   98 --
 arch/sh/lib64/strlen.S                    |   34 -
 arch/sh/lib64/udelay.c                    |   49 -
 arch/sh/lib64/udivdi3.S                   |  121 --
 arch/sh/lib64/udivsi3.S                   |   60 -
 arch/sh/mm/Kconfig                        |   16 +-
 arch/sh/mm/Makefile                       |   31 +-
 arch/sh/mm/cache-sh5.c                    |  621 ---------
 arch/sh/mm/cache.c                        |    6 -
 arch/sh/mm/extable_64.c                   |   84 --
 arch/sh/mm/tlb-sh5.c                      |  224 ----
 arch/sh/mm/tlbex_64.c                     |  166 ---
 arch/sh/mm/tlbflush_64.c                  |  172 ---
 drivers/rtc/Kconfig                       |    2 +-
 fs/Kconfig.binfmt                         |    2 +-
 scripts/headers_install.sh                |    3 -
 tools/arch/sh/include/asm/barrier.h       |    2 +-
 145 files changed, 121 insertions(+), 11601 deletions(-)
 delete mode 100644 arch/sh/drivers/pci/ops-sh5.c
 delete mode 100644 arch/sh/drivers/pci/pci-sh5.c
 delete mode 100644 arch/sh/drivers/pci/pci-sh5.h
 delete mode 100644 arch/sh/include/asm/bl_bit_64.h
 delete mode 100644 arch/sh/include/asm/cache_insns_64.h
 delete mode 100644 arch/sh/include/asm/mmu_context_64.h
 delete mode 100644 arch/sh/include/asm/pgtable_64.h
 delete mode 100644 arch/sh/include/asm/processor_64.h
 delete mode 100644 arch/sh/include/asm/ptrace_64.h
 delete mode 100644 arch/sh/include/asm/string_64.h
 delete mode 100644 arch/sh/include/asm/switch_to_64.h
 delete mode 100644 arch/sh/include/asm/syscall_64.h
 delete mode 100644 arch/sh/include/asm/syscalls_64.h
 delete mode 100644 arch/sh/include/asm/tlb_64.h
 delete mode 100644 arch/sh/include/asm/traps_64.h
 delete mode 100644 arch/sh/include/asm/uaccess_64.h
 delete mode 100644 arch/sh/include/cpu-sh5/cpu/addrspace.h
 delete mode 100644 arch/sh/include/cpu-sh5/cpu/cache.h
 delete mode 100644 arch/sh/include/cpu-sh5/cpu/irq.h
 delete mode 100644 arch/sh/include/cpu-sh5/cpu/mmu_context.h
 delete mode 100644 arch/sh/include/cpu-sh5/cpu/registers.h
 delete mode 100644 arch/sh/include/cpu-sh5/cpu/rtc.h
 delete mode 100644 arch/sh/include/uapi/asm/posix_types_64.h
 delete mode 100644 arch/sh/include/uapi/asm/ptrace_64.h
 delete mode 100644 arch/sh/include/uapi/asm/unistd_64.h
 delete mode 100644 arch/sh/kernel/cpu/irq/intc-sh5.c
 delete mode 100644 arch/sh/kernel/cpu/sh5/Makefile
 delete mode 100644 arch/sh/kernel/cpu/sh5/clock-sh5.c
 delete mode 100644 arch/sh/kernel/cpu/sh5/entry.S
 delete mode 100644 arch/sh/kernel/cpu/sh5/fpu.c
 delete mode 100644 arch/sh/kernel/cpu/sh5/probe.c
 delete mode 100644 arch/sh/kernel/cpu/sh5/setup-sh5.c
 delete mode 100644 arch/sh/kernel/cpu/sh5/switchto.S
 delete mode 100644 arch/sh/kernel/cpu/sh5/unwind.c
 delete mode 100644 arch/sh/kernel/head_64.S
 delete mode 100644 arch/sh/kernel/irq_64.c
 delete mode 100644 arch/sh/kernel/process_64.c
 delete mode 100644 arch/sh/kernel/ptrace_64.c
 delete mode 100644 arch/sh/kernel/sh_ksyms_64.c
 delete mode 100644 arch/sh/kernel/signal_64.c
 delete mode 100644 arch/sh/kernel/syscalls_64.S
 delete mode 100644 arch/sh/kernel/traps_64.c
 delete mode 100644 arch/sh/lib64/Makefile
 delete mode 100644 arch/sh/lib64/copy_page.S
 delete mode 100644 arch/sh/lib64/copy_user_memcpy.S
 delete mode 100644 arch/sh/lib64/memcpy.S
 delete mode 100644 arch/sh/lib64/memset.S
 delete mode 100644 arch/sh/lib64/panic.c
 delete mode 100644 arch/sh/lib64/sdivsi3.S
 delete mode 100644 arch/sh/lib64/strcpy.S
 delete mode 100644 arch/sh/lib64/strlen.S
 delete mode 100644 arch/sh/lib64/udelay.c
 delete mode 100644 arch/sh/lib64/udivdi3.S
 delete mode 100644 arch/sh/lib64/udivsi3.S
 delete mode 100644 arch/sh/mm/cache-sh5.c
 delete mode 100644 arch/sh/mm/extable_64.c
 delete mode 100644 arch/sh/mm/tlb-sh5.c
 delete mode 100644 arch/sh/mm/tlbex_64.c
 delete mode 100644 arch/sh/mm/tlbflush_64.c
