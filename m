Return-Path: <SRS0=nwpL=6I=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.8 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9B091C54FD0
	for <linux-kernel@archiver.kernel.org>; Fri, 24 Apr 2020 22:20:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 77B8820736
	for <linux-kernel@archiver.kernel.org>; Fri, 24 Apr 2020 22:20:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726186AbgDXWUO (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 24 Apr 2020 18:20:14 -0400
Received: from mout.kundenserver.de ([212.227.126.135]:40867 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726044AbgDXWUN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Apr 2020 18:20:13 -0400
Received: from threadripper.lan ([149.172.19.189]) by mrelayeu.kundenserver.de
 (mreue010 [212.227.15.129]) with ESMTPA (Nemesis) id
 1MhlXE-1ixSpA2tNo-00dpuQ; Sat, 25 Apr 2020 00:19:56 +0200
From:   Arnd Bergmann <arnd@arndb.de>
To:     linux-sh@vger.kernel.org
Cc:     ysato@users.sourceforge.jp, dalias@libc.org,
        linux-kernel@vger.kernel.org, viro@zeniv.linux.org.uk,
        Rob Landley <rob@landley.net>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        Arnd Bergmann <arnd@arndb.de>
Subject: [GIT PULL] sh: remove sh5 support
Date:   Sat, 25 Apr 2020 00:19:47 +0200
Message-Id: <20200424221948.1120587-1-arnd@arndb.de>
X-Mailer: git-send-email 2.26.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Provags-ID: V03:K1:8ecPHMRIsa5PthQLU4xC8p0mA2NTjt2n6Wg/LoFPPTKjiSSObmC
 SaygAwZ1vZadqQbfwJTp/JuCa7yx68J+aQpoH1HUKqrgI5z+AjdxTgULK5phfOT8jCJFzf+
 AZx0Hn0ZxHPHWrPIdO+Tsb5Ds4iMc+hJm7GvAUWUTqBn2AiPweMicRyEgxrrVMYkEekLqMe
 jLUUlcxQUhzeOH3zHZL7A==
X-UI-Out-Filterresults: notjunk:1;V03:K0:jNUtpf9n8pE=:mNn+WdfypKofE2h+aENHwp
 /+gD44oRoyX3BFefQl6w1HmUqAwXjFK1FoIk/grnE4Rz0XHGWlEEDT/0KuUXEbvTdBTQ8FUfD
 WHiV9iWJwTyhVT2Jt3ryo9PrpO4GYRXZoe540zxSI+OJDvS2TfSuqJJvVERxp1DbvVFpMwR/l
 aOlJ+XS3JxhHvt73fpQlz+2CVibG4PWV2OXHTvduYxjyXhxiLMmhfeMESKVO5b2dGYvUOtczy
 N2Aqz5Z96H9A3d/P1aZt/txctDzmMnSYaCxJtLYPa/PUVjgqFZ82W1mqDc+IEKHiSOHgvm6tW
 +Pr8iBzxQD+PRtWj3VgRslQOtroVinEiVcwnZywQOSAnm4J5KTDudg+TkG/Wygzps3fbWi9YV
 zJl+FD+fbIC8kmcpkcvgJQ+hRTjG/sgRXSzdRUhtM3mycNRFqlF5zY8XrrwVmghOXqGAbdJ/d
 68P7sy9uH1SRpvDZ/ml/sQlWnV7mejBDqyIlo5sW4KHQUx3jpKCC6LVpascPwcKgEa5ByTPa/
 aHed19bkSs0YRr5M/3LNIxXCu8KKEH4eQeTdP7HXbgEh1qfVYnbKOVD25mm0LGbz7PETi+ISs
 V6A7t38PkX3uch2wR9jW8u1wdJ2p4aarNhMSO/PpWv90/1Zu4sKV928F4GCU+Nb8bi/n6P4ru
 WiXXgUenhOnWl7M2qsEq3Vme06OFTan+VZRtRTRI3Gs5654/ABpGA4GHxb9tWMxFDTvUHInto
 BZTzFd9DS/ttJG83NLi919QtocGcRMW+vC5T/bnMqWSgMHiyw8Lf60SCm9o+UzynkdU0bUJwr
 YWXrkDTTwiBmA+6/XmFzMIVMbxiOPAUiNUgA72+0Ozwk4i9avM=
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following changes since commit
ae83d0b416db002fe95601e7f97f64b59514d936:

  Linux 5.7-rc2 (2020-04-19 14:35:30 -0700)

are available in the Git repository at:

  git://git.kernel.org:/pub/scm/linux/kernel/git/arnd/playground.git
tags/sh5-remove

for you to fetch changes up to 29e36fbee3be4c13ff6881a275c86d5f68acfa23:

  sh: remove sh5 support (2020-04-24 22:20:55 +0200)

----------------------------------------------------------------
sh: remove sh5 support

At long last, this is the removal of the 64-bit sh5 port
that never went into production.

Signed-off-by: Arnd Bergmann <arnd@arndb.de>

----------------------------------------------------------------

v2: I should have fixed all the missing changes that Geert pointed out,
    this time sending it as a pull request as the removal patch is
    too big for the mailing lists, and a 'git format-patch -D' patch
    is unreliable

Arnd Bergmann (1):
  sh: remove sh5 support

 arch/sh/Kconfig                           |   62 +-
 arch/sh/Kconfig.cpu                       |    9 -
 arch/sh/Kconfig.debug                     |   13 +-
 arch/sh/Makefile                          |   29 +-
 arch/sh/boot/compressed/Makefile          |   12 +-
 arch/sh/boot/compressed/misc.c            |    8 -
 arch/sh/drivers/pci/Makefile              |    1 -
 arch/sh/drivers/pci/ops-sh5.c             |   65 -
 arch/sh/drivers/pci/pci-sh5.c             |  217 ---
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
 arch/sh/include/asm/io.h                  |    4 -
 arch/sh/include/asm/irq.h                 |    3 -
 arch/sh/include/asm/mmu_context.h         |   12 -
 arch/sh/include/asm/mmu_context_64.h      |   75 -
 arch/sh/include/asm/module.h              |    4 -
 arch/sh/include/asm/page.h                |   21 +-
 arch/sh/include/asm/pgtable.h             |   17 -
 arch/sh/include/asm/pgtable_64.h          |  307 ----
 arch/sh/include/asm/posix_types.h         |    6 +-
 arch/sh/include/asm/processor.h           |   14 +-
 arch/sh/include/asm/processor_64.h        |  212 ---
 arch/sh/include/asm/ptrace_64.h           |   14 -
 arch/sh/include/asm/string.h              |    6 +-
 arch/sh/include/asm/string_64.h           |   21 -
 arch/sh/include/asm/switch_to.h           |   11 +-
 arch/sh/include/asm/switch_to_64.h        |   32 -
 arch/sh/include/asm/syscall.h             |    6 +-
 arch/sh/include/asm/syscall_64.h          |   75 -
 arch/sh/include/asm/syscalls.h            |    9 +-
 arch/sh/include/asm/syscalls_64.h         |   18 -
 arch/sh/include/asm/thread_info.h         |    4 +-
 arch/sh/include/asm/tlb.h                 |    6 +-
 arch/sh/include/asm/tlb_64.h              |   68 -
 arch/sh/include/asm/traps.h               |    4 -
 arch/sh/include/asm/traps_64.h            |   35 -
 arch/sh/include/asm/types.h               |    5 -
 arch/sh/include/asm/uaccess.h             |    4 -
 arch/sh/include/asm/uaccess_64.h          |   85 -
 arch/sh/include/asm/unistd.h              |    6 +-
 arch/sh/include/asm/user.h                |    7 -
 arch/sh/include/asm/vmlinux.lds.h         |    8 -
 arch/sh/include/cpu-sh5/cpu/addrspace.h   |   12 -
 arch/sh/include/cpu-sh5/cpu/cache.h       |   94 -
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
 arch/sh/include/uapi/asm/unistd_64.h      |  423 -----
 arch/sh/kernel/Makefile                   |   16 +-
 arch/sh/kernel/cpu/Makefile               |    1 -
 arch/sh/kernel/cpu/init.c                 |    2 +-
 arch/sh/kernel/cpu/irq/Makefile           |    3 +-
 arch/sh/kernel/cpu/irq/intc-sh5.c         |  194 --
 arch/sh/kernel/cpu/proc.c                 |    1 -
 arch/sh/kernel/cpu/sh5/Makefile           |   16 -
 arch/sh/kernel/cpu/sh5/clock-sh5.c        |   76 -
 arch/sh/kernel/cpu/sh5/entry.S            | 2000 ---------------------
 arch/sh/kernel/cpu/sh5/fpu.c              |  106 --
 arch/sh/kernel/cpu/sh5/probe.c            |   72 -
 arch/sh/kernel/cpu/sh5/setup-sh5.c        |  121 --
 arch/sh/kernel/cpu/sh5/switchto.S         |  195 --
 arch/sh/kernel/cpu/sh5/unwind.c           |  342 ----
 arch/sh/kernel/head_64.S                  |  346 ----
 arch/sh/kernel/irq_64.c                   |   48 -
 arch/sh/kernel/module.c                   |    9 -
 arch/sh/kernel/process.c                  |    2 -
 arch/sh/kernel/process_64.c               |  461 -----
 arch/sh/kernel/ptrace_64.c                |  576 ------
 arch/sh/kernel/reboot.c                   |    6 -
 arch/sh/kernel/sh_ksyms_64.c              |   51 -
 arch/sh/kernel/signal_64.c                |  567 ------
 arch/sh/kernel/syscalls_64.S              |  419 -----
 arch/sh/kernel/traps_64.c                 |  814 ---------
 arch/sh/kernel/vmlinux.lds.S              |   18 +-
 arch/sh/lib64/Makefile                    |   17 -
 arch/sh/lib64/copy_page.S                 |   89 -
 arch/sh/lib64/copy_user_memcpy.S          |  218 ---
 arch/sh/lib64/memcpy.S                    |  202 ---
 arch/sh/lib64/memset.S                    |   92 -
 arch/sh/lib64/panic.c                     |   15 -
 arch/sh/lib64/sdivsi3.S                   |  136 --
 arch/sh/lib64/strcpy.S                    |   98 -
 arch/sh/lib64/strlen.S                    |   34 -
 arch/sh/lib64/udelay.c                    |   49 -
 arch/sh/lib64/udivdi3.S                   |  121 --
 arch/sh/lib64/udivsi3.S                   |   60 -
 arch/sh/mm/Kconfig                        |   16 +-
 arch/sh/mm/Makefile                       |   31 +-
 arch/sh/mm/cache-sh5.c                    |  621 -------
 arch/sh/mm/cache.c                        |    6 -
 arch/sh/mm/extable_64.c                   |   84 -
 arch/sh/mm/tlb-sh5.c                      |  224 ---
 arch/sh/mm/tlbex_64.c                     |  166 --
 arch/sh/mm/tlbflush_64.c                  |  172 --
 drivers/rtc/Kconfig                       |    2 +-
 fs/Kconfig.binfmt                         |    2 +-
 scripts/headers_install.sh                |    3 -
 tools/arch/sh/include/asm/barrier.h       |    2 +-
 117 files changed, 67 insertions(+), 11554 deletions(-)
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

-- 
2.26.0

