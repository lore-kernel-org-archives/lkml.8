Return-Path: <SRS0=qJsj=BZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.5 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D8A05C433DF
	for <linux-kernel@archiver.kernel.org>; Sat, 15 Aug 2020 22:46:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id BCA9720675
	for <linux-kernel@archiver.kernel.org>; Sat, 15 Aug 2020 22:46:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729261AbgHOWp7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 15 Aug 2020 18:45:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54604 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728390AbgHOWpm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 15 Aug 2020 18:45:42 -0400
X-Greylist: delayed 904 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Sat, 15 Aug 2020 12:48:12 PDT
Received: from brightrain.aerifal.cx (unknown [IPv6:2002:d80c:560d::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A19C3C0045A7
        for <linux-kernel@vger.kernel.org>; Sat, 15 Aug 2020 12:48:12 -0700 (PDT)
Date:   Sat, 15 Aug 2020 15:33:04 -0400
From:   Rich Felker <dalias@libc.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Linux-sh list <linux-sh@vger.kernel.org>,
        linux-kernel@vger.kernel.org,
        Yoshinori Sato <ysato@users.sourceforge.jp>
Subject: [GIT PULL] arch/sh updates for 5.9
Message-ID: <20200815193255.GA23393@brightrain.aerifal.cx>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following changes since commit bcf876870b95592b52519ed4aafcf9d95999bc9c:

  Linux 5.8 (2020-08-02 14:21:45 -0700)

are available in the Git repository at:

  git://git.libc.org/linux-sh tags/sh-for-5.9

for you to fetch changes up to 0c64a0dce51faa9c706fdf1f957d6f19878f4b81:

  sh: landisk: Add missing initialization of sh_io_port_base (2020-08-14 22:43:17 -0400)

----------------------------------------------------------------
Cleanup, SECCOMP_FILTER support, message printing fixes, and other
changes to arch/sh.

----------------------------------------------------------------
Alexander A. Klimov (1):
      sh: Replace HTTP links with HTTPS ones

Chen Zhou (1):
      sh: remove call to memset after dma_alloc_coherent

Christian Brauner (1):
      sh: switch to copy_thread_tls()

Christoph Hellwig (10):
      sh: remove -Werror from Makefiles
      sh: sort the selects for SUPERH alphabetically
      sh: remove __KERNEL__ ifdefs from non-UAPI headers
      sh: move ioremap_fixed details out of <asm/io.h>
      sh: move the ioremap implementation out of line
      sh: don't include <asm/io_trapped.h> in <asm/io.h>
      sh: unexport register_trapped_io and match_trapped_io_handler
      dma-mapping: consolidate the NO_DMA definition in kernel/dma/Kconfig
      sh: don't allow non-coherent DMA for NOMMU
      sh: use the generic dma coherent remap allocator

Flavio Suligoi (1):
      arch: sh: smc37c93x: fix spelling mistake

Geert Uytterhoeven (14):
      Revert "sh: add missing EXPORT_SYMBOL() for __delay"
      sh: Remove SH5-based Cayman platform
      input: i8042 - Remove special Cayman handling
      sh: fault: Fix duplicate printing of "PC:"
      Revert "sh: add loglvl to printk_address()"
      Revert "sh: remove needless printk()"
      sh: kernel: disassemble: Fix broken lines in disassembly dumps
      sh: dump_stack: Fix broken lines and ptrval in calltrace dumps
      sh: process: Fix broken lines in register dumps
      sh: sh2007: Modernize printing of kernel messages
      sh: pci: Modernize printing of kernel messages
      sh: machvec: Modernize printing of kernel messages
      sh: stacktrace: Remove stacktrace_ops.stack()
      sh: landisk: Add missing initialization of sh_io_port_base

Hans Verkuil (1):
      arch/sh/configs: remove obsolete CONFIG_SOC_CAMERA*

John Paul Adrian Glaubitz (1):
      sh: Implement __get_user_u64() required for 64-bit get_user()

Matthew Wilcox (Oracle) (1):
      sh: Fix unneeded constructor in page table allocation

Michael Karcher (3):
      sh: Rearrange blocks in entry-common.S
      sh: Add SECCOMP_FILTER
      sh: bring syscall_set_return_value in line with other architectures

 arch/m68k/Kconfig                             |   4 +-
 arch/m68k/Kconfig.machine                     |   1 +
 arch/sh/Kconfig                               | 109 ++++++++--------
 arch/sh/Makefile                              |   5 -
 arch/sh/boards/Kconfig                        |   6 -
 arch/sh/boards/board-sh2007.c                 |   4 +-
 arch/sh/boards/mach-cayman/Makefile           |   5 -
 arch/sh/boards/mach-cayman/irq.c              | 148 ---------------------
 arch/sh/boards/mach-cayman/panic.c            |  46 -------
 arch/sh/boards/mach-cayman/setup.c            | 181 --------------------------
 arch/sh/boards/mach-landisk/setup.c           |   3 +
 arch/sh/configs/ap325rxa_defconfig            |   3 -
 arch/sh/configs/cayman_defconfig              |  66 ----------
 arch/sh/configs/ecovec24_defconfig            |   3 -
 arch/sh/configs/migor_defconfig               |   3 -
 arch/sh/configs/se7724_defconfig              |   2 -
 arch/sh/drivers/pci/Makefile                  |   1 -
 arch/sh/drivers/pci/common.c                  |   6 +-
 arch/sh/drivers/pci/fixups-cayman.c           |  78 -----------
 arch/sh/drivers/pci/pci-sh7780.c              |  23 ++--
 arch/sh/drivers/pci/pci.c                     |  11 +-
 arch/sh/include/asm/adc.h                     |   2 -
 arch/sh/include/asm/addrspace.h               |   3 -
 arch/sh/include/asm/bitops.h                  |   4 -
 arch/sh/include/asm/cache.h                   |   2 -
 arch/sh/include/asm/cacheflush.h              |   3 -
 arch/sh/include/asm/dma.h                     |   2 -
 arch/sh/include/asm/elf.h                     |   2 -
 arch/sh/include/asm/freq.h                    |   2 -
 arch/sh/include/asm/futex.h                   |   3 -
 arch/sh/include/asm/io.h                      | 119 ++---------------
 arch/sh/include/asm/kdebug.h                  |   3 +-
 arch/sh/include/asm/mmu_context.h             |   2 -
 arch/sh/include/asm/mmzone.h                  |   3 -
 arch/sh/include/asm/pci.h                     |   4 -
 arch/sh/include/asm/processor_32.h            |   2 -
 arch/sh/include/asm/smc37c93x.h               |   4 +-
 arch/sh/include/asm/sparsemem.h               |   3 -
 arch/sh/include/asm/stacktrace.h              |   2 -
 arch/sh/include/asm/string_32.h               |   4 -
 arch/sh/include/asm/syscall_32.h              |   5 +-
 arch/sh/include/asm/syscalls_32.h             |   3 -
 arch/sh/include/asm/thread_info.h             |   5 -
 arch/sh/include/asm/uaccess_32.h              |  53 ++++++++
 arch/sh/include/asm/watchdog.h                |   2 -
 arch/sh/kernel/Makefile                       |   2 -
 arch/sh/kernel/disassemble.c                  | 103 +++++++--------
 arch/sh/kernel/dma-coherent.c                 |  51 +-------
 arch/sh/kernel/dumpstack.c                    |  30 ++---
 arch/sh/kernel/entry-common.S                 |  59 +++++----
 arch/sh/kernel/io_trapped.c                   |   2 -
 arch/sh/kernel/ioport.c                       |   1 +
 arch/sh/kernel/machvec.c                      |   8 +-
 arch/sh/kernel/perf_callchain.c               |   6 -
 arch/sh/kernel/process_32.c                   |  44 +++----
 arch/sh/kernel/ptrace_32.c                    |   5 +-
 arch/sh/kernel/stacktrace.c                   |   7 -
 arch/sh/lib/Makefile                          |   2 -
 arch/sh/lib/delay.c                           |   1 -
 arch/sh/mm/Makefile                           |   2 -
 arch/sh/mm/consistent.c                       |   2 -
 arch/sh/mm/fault.c                            |   3 +-
 arch/sh/mm/init.c                             |   1 +
 arch/sh/mm/ioremap.c                          |  55 ++++++++
 arch/sh/mm/ioremap.h                          |  23 ++++
 arch/sh/mm/ioremap_fixed.c                    |   1 +
 arch/sh/mm/pgtable.c                          |   7 +-
 arch/sh/oprofile/backtrace.c                  |   7 -
 arch/sh/tools/mach-types                      |   1 -
 arch/um/Kconfig                               |   4 +-
 drivers/input/serio/i8042-io.h                |   2 -
 kernel/dma/Kconfig                            |   3 +
 tools/testing/selftests/seccomp/seccomp_bpf.c |   8 +-
 73 files changed, 373 insertions(+), 1012 deletions(-)
 delete mode 100644 arch/sh/boards/mach-cayman/Makefile
 delete mode 100644 arch/sh/boards/mach-cayman/irq.c
 delete mode 100644 arch/sh/boards/mach-cayman/panic.c
 delete mode 100644 arch/sh/boards/mach-cayman/setup.c
 delete mode 100644 arch/sh/configs/cayman_defconfig
 delete mode 100644 arch/sh/drivers/pci/fixups-cayman.c
 create mode 100644 arch/sh/mm/ioremap.h
