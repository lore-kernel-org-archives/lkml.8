Return-Path: <SRS0=Mt+e=5P=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DB12BC43331
	for <linux-kernel@archiver.kernel.org>; Mon, 30 Mar 2020 14:50:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A546E20780
	for <linux-kernel@archiver.kernel.org>; Mon, 30 Mar 2020 14:50:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728964AbgC3OuJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 30 Mar 2020 10:50:09 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:59017 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728721AbgC3OuA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 Mar 2020 10:50:00 -0400
Received: from [5.158.153.52] (helo=nanos.tec.linutronix.de)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tglx@linutronix.de>)
        id 1jIvjg-0006uJ-Mw; Mon, 30 Mar 2020 16:49:56 +0200
Received: from nanos.tec.linutronix.de (localhost [IPv6:::1])
        by nanos.tec.linutronix.de (Postfix) with ESMTP id 4DF981040EC;
        Mon, 30 Mar 2020 16:49:56 +0200 (CEST)
Date:   Mon, 30 Mar 2020 14:47:14 -0000
From:   Thomas Gleixner <tglx@linutronix.de>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     linux-kernel@vger.kernel.org, x86@kernel.org
Subject: [GIT pull] x86/entry for v5.7
References: <158557962955.22376.9136086165862170511.tglx@nanos.tec.linutronix.de>
Message-ID: <158557963437.22376.13314216004420999087.tglx@nanos.tec.linutronix.de>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Linus,

please pull the latest x86/entry branch from:

   git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git x86-entry-2020-03-30

up to:  290a4474d019: x86/entry: Fix build error x86 with !CONFIG_POSIX_TIMERS


x86 entry code updates:

    - Convert the 32bit syscalls to be pt_regs based which removes the
      requirement to push all 6 potential arguments onto the stack and
      consolidates the interface with the 64bit variant

    - The first small portion of the exception and syscall related entry
      code consolidation which aims to address the recently discovered
      issues vs. RCU, int3, NMI and some other exceptions which can
      interrupt any context. The bulk of the changes is still work in
      progress and aimed for 5.8.

    - A few lockdep namespace cleanups which have been applied into this
      branch to keep the prerequisites for the ongoing work confined.

Thanks,

	tglx

------------------>
Andy Lutomirski (2):
      x86/mce: Disable tracing and kprobes on do_machine_check()
      x86/traps: Stop using ist_enter/exit() in do_int3()

Brian Gerst (19):
      x86/entry: Refactor SYSCALL_DEFINEx macros
      x86/entry: Refactor SYSCALL_DEFINE0 macros
      x86/entry: Refactor COND_SYSCALL macros
      x86/entry: Refactor SYS_NI macros
      x86/entry/64: Use syscall wrappers for x32_rt_sigreturn
      x86/entry/64: Move sys_ni_syscall stub to common.c
      x86/entry/64: Split X32 syscall table into its own file
      x86/entry: Move max syscall number calculation to syscallhdr.sh
      x86/entry/64: Remove ptregs qualifier from syscall table
      x86/entry: Remove syscall qualifier support
      x86/entry/64: Add __SYSCALL_COMMON()
      x86/entry: Remove ABI prefixes from functions in syscall tables
      x86/entry/32: Clean up syscall_32.tbl
      x86/entry/32: Rename 32-bit specific syscalls
      x86/entry/32: Use IA32-specific wrappers for syscalls taking 64-bit arguments
      x86/entry/32: Enable pt_regs based syscalls
      x86/entry: Drop asmlinkage from syscalls
      x86: Remove unneeded includes
      x86/entry: Fix build error x86 with !CONFIG_POSIX_TIMERS

Peter Zijlstra (3):
      x86/entry: Rename ___preempt_schedule
      lockdep: Rename trace_softirqs_{on,off}()
      lockdep: Rename trace_{hard,soft}{irq_context,irqs_enabled}()

Thomas Gleixner (11):
      x86/entry/32: Add missing ASM_CLAC to general_protection entry
      x86/entry/32: Force MCE through do_mce()
      x86/traps: Remove pointless irq enable from do_spurious_interrupt_bug()
      x86/traps: Document do_spurious_interrupt_bug()
      x86/traps: Remove redundant declaration of do_double_fault()
      x86/irq: Remove useless return value from do_IRQ()
      x86/entry/entry_32: Route int3 through common_exception
      x86/entry/32: Remove the 0/-1 distinction from exception entries
      x86/entry/32: Remove unused label restore_nocheck
      x86/entry/64: Trace irqflags unconditionally as ON when returning to user space
      lockdep: Rename trace_hardirq_{enter,exit}()


 arch/x86/Kconfig                            |   2 +-
 arch/x86/entry/Makefile                     |   1 +
 arch/x86/entry/common.c                     |  18 +-
 arch/x86/entry/entry_32.S                   |  23 +-
 arch/x86/entry/entry_64.S                   |   4 +-
 arch/x86/entry/syscall_32.c                 |  19 +-
 arch/x86/entry/syscall_64.c                 |  39 +-
 arch/x86/entry/syscall_x32.c                |  29 +
 arch/x86/entry/syscalls/syscall_32.tbl      | 818 ++++++++++++++--------------
 arch/x86/entry/syscalls/syscall_64.tbl      | 740 ++++++++++++-------------
 arch/x86/entry/syscalls/syscallhdr.sh       |   7 +
 arch/x86/entry/syscalls/syscalltbl.sh       |  44 +-
 arch/x86/entry/thunk_32.S                   |   8 +-
 arch/x86/entry/thunk_64.S                   |   8 +-
 arch/x86/entry/vdso/vdso32/vclock_gettime.c |   1 +
 arch/x86/ia32/Makefile                      |   2 +-
 arch/x86/include/asm/irq.h                  |   2 +-
 arch/x86/include/asm/mce.h                  |   3 -
 arch/x86/include/asm/preempt.h              |   8 +-
 arch/x86/include/asm/sighandling.h          |   5 -
 arch/x86/include/asm/syscall.h              |  11 +-
 arch/x86/include/asm/syscall_wrapper.h      | 287 +++++-----
 arch/x86/include/asm/syscalls.h             |  34 --
 arch/x86/include/asm/traps.h                |  17 +-
 arch/x86/include/asm/unistd.h               |   7 +
 arch/x86/kernel/Makefile                    |   2 +
 arch/x86/kernel/asm-offsets_32.c            |   9 -
 arch/x86/kernel/asm-offsets_64.c            |  36 --
 arch/x86/kernel/cpu/mce/core.c              |  12 +-
 arch/x86/kernel/cpu/mce/internal.h          |   3 +
 arch/x86/kernel/irq.c                       |   3 +-
 arch/x86/kernel/ldt.c                       |   1 -
 arch/x86/kernel/process.c                   |   1 -
 arch/x86/kernel/process_32.c                |   1 -
 arch/x86/kernel/process_64.c                |   1 -
 arch/x86/kernel/signal.c                    |   4 +-
 arch/x86/{ia32 => kernel}/sys_ia32.c        | 143 ++---
 arch/x86/kernel/sys_x86_64.c                |   1 -
 arch/x86/kernel/traps.c                     |  41 +-
 arch/x86/um/Makefile                        |   1 +
 arch/x86/um/sys_call_table_32.c             |   6 +-
 arch/x86/um/sys_call_table_64.c             |   9 +-
 arch/x86/um/user-offsets.c                  |  15 -
 include/linux/hardirq.h                     |   8 +-
 include/linux/irqflags.h                    |  34 +-
 kernel/locking/lockdep.c                    |  12 +-
 kernel/softirq.c                            |  15 +-
 tools/include/linux/irqflags.h              |  12 +-
 48 files changed, 1206 insertions(+), 1301 deletions(-)
 create mode 100644 arch/x86/entry/syscall_x32.c
 rename arch/x86/{ia32 => kernel}/sys_ia32.c (78%)


