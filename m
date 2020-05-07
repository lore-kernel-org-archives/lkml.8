Return-Path: <SRS0=0sZ+=6V=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CBA6CC38A24
	for <linux-kernel@archiver.kernel.org>; Thu,  7 May 2020 14:36:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9D33621473
	for <linux-kernel@archiver.kernel.org>; Thu,  7 May 2020 14:36:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="S2H8lj7O"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728810AbgEGOgA (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 7 May 2020 10:36:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50412 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728102AbgEGOfy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 May 2020 10:35:54 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:e::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 699EFC05BD43;
        Thu,  7 May 2020 07:35:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=clHnBJsN9031K6+AcxWtZ3S1WO9na20IIc7aW3tlhVw=; b=S2H8lj7ORk2zNorcPqQVCxzZTb
        XBuJKz6Q5UI6sMdOD4/Y2Zhx5Up1tq7MLViO0TxAZOQWF8HIZBu9baCZmzWiQd4pdDjpKTMfLx+A9
        4H9kOKRI6x+4vrDUUKOU+Q6HI9OnSVnNFdUZ36+CoKp5gltMVewTFxc2OF3HTuM6TDcmXtTlti5tF
        00QCPDYHBopCSFzIBJw0uee/l1/RRSClF+9EB3NBPv6TX0TH1gHfpN8k0UHcXTErbaVjflNrvyUqM
        IZLf33PNLMc4e9ouPVVB599Q8u1HXLksBJsa4LpdyKwrq8LLRPm9kckaExmmjHB6+ycHC6a4hNR2l
        wBZMPoHQ==;
Received: from hch by bombadil.infradead.org with local (Exim 4.92.3 #3 (Red Hat Linux))
        id 1jWhcu-0001vk-KB; Thu, 07 May 2020 14:35:52 +0000
Date:   Thu, 7 May 2020 07:35:52 -0700
From:   Christoph Hellwig <hch@infradead.org>
To:     Arnd Bergmann <arnd@arndb.de>
Cc:     linux-sh@vger.kernel.org, ysato@users.sourceforge.jp,
        dalias@libc.org, linux-kernel@vger.kernel.org,
        viro@zeniv.linux.org.uk, Rob Landley <rob@landley.net>,
        Geert Uytterhoeven <geert@linux-m68k.org>
Subject: Re: [GIT PULL] sh: remove sh5 support
Message-ID: <20200507143552.GA28683@infradead.org>
References: <20200424221948.1120587-1-arnd@arndb.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200424221948.1120587-1-arnd@arndb.de>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Any progress on this?  I plan to resend the sh dma-mapping I've been
trying to get upstream for a year again, and they would conflict,
so I could look into rebasing them first.

On Sat, Apr 25, 2020 at 12:19:47AM +0200, Arnd Bergmann wrote:
> The following changes since commit
> ae83d0b416db002fe95601e7f97f64b59514d936:
> 
>   Linux 5.7-rc2 (2020-04-19 14:35:30 -0700)
> 
> are available in the Git repository at:
> 
>   git://git.kernel.org:/pub/scm/linux/kernel/git/arnd/playground.git
> tags/sh5-remove
> 
> for you to fetch changes up to 29e36fbee3be4c13ff6881a275c86d5f68acfa23:
> 
>   sh: remove sh5 support (2020-04-24 22:20:55 +0200)
> 
> ----------------------------------------------------------------
> sh: remove sh5 support
> 
> At long last, this is the removal of the 64-bit sh5 port
> that never went into production.
> 
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>
> 
> ----------------------------------------------------------------
> 
> v2: I should have fixed all the missing changes that Geert pointed out,
>     this time sending it as a pull request as the removal patch is
>     too big for the mailing lists, and a 'git format-patch -D' patch
>     is unreliable
> 
> Arnd Bergmann (1):
>   sh: remove sh5 support
> 
>  arch/sh/Kconfig                           |   62 +-
>  arch/sh/Kconfig.cpu                       |    9 -
>  arch/sh/Kconfig.debug                     |   13 +-
>  arch/sh/Makefile                          |   29 +-
>  arch/sh/boot/compressed/Makefile          |   12 +-
>  arch/sh/boot/compressed/misc.c            |    8 -
>  arch/sh/drivers/pci/Makefile              |    1 -
>  arch/sh/drivers/pci/ops-sh5.c             |   65 -
>  arch/sh/drivers/pci/pci-sh5.c             |  217 ---
>  arch/sh/drivers/pci/pci-sh5.h             |  108 --
>  arch/sh/include/asm/barrier.h             |    4 +-
>  arch/sh/include/asm/bitops.h              |   26 -
>  arch/sh/include/asm/bl_bit.h              |   11 +-
>  arch/sh/include/asm/bl_bit_64.h           |   37 -
>  arch/sh/include/asm/bugs.h                |    4 -
>  arch/sh/include/asm/cache_insns.h         |   12 +-
>  arch/sh/include/asm/cache_insns_64.h      |   20 -
>  arch/sh/include/asm/checksum.h            |    6 +-
>  arch/sh/include/asm/elf.h                 |   23 -
>  arch/sh/include/asm/extable.h             |    4 -
>  arch/sh/include/asm/fixmap.h              |    4 -
>  arch/sh/include/asm/io.h                  |    4 -
>  arch/sh/include/asm/irq.h                 |    3 -
>  arch/sh/include/asm/mmu_context.h         |   12 -
>  arch/sh/include/asm/mmu_context_64.h      |   75 -
>  arch/sh/include/asm/module.h              |    4 -
>  arch/sh/include/asm/page.h                |   21 +-
>  arch/sh/include/asm/pgtable.h             |   17 -
>  arch/sh/include/asm/pgtable_64.h          |  307 ----
>  arch/sh/include/asm/posix_types.h         |    6 +-
>  arch/sh/include/asm/processor.h           |   14 +-
>  arch/sh/include/asm/processor_64.h        |  212 ---
>  arch/sh/include/asm/ptrace_64.h           |   14 -
>  arch/sh/include/asm/string.h              |    6 +-
>  arch/sh/include/asm/string_64.h           |   21 -
>  arch/sh/include/asm/switch_to.h           |   11 +-
>  arch/sh/include/asm/switch_to_64.h        |   32 -
>  arch/sh/include/asm/syscall.h             |    6 +-
>  arch/sh/include/asm/syscall_64.h          |   75 -
>  arch/sh/include/asm/syscalls.h            |    9 +-
>  arch/sh/include/asm/syscalls_64.h         |   18 -
>  arch/sh/include/asm/thread_info.h         |    4 +-
>  arch/sh/include/asm/tlb.h                 |    6 +-
>  arch/sh/include/asm/tlb_64.h              |   68 -
>  arch/sh/include/asm/traps.h               |    4 -
>  arch/sh/include/asm/traps_64.h            |   35 -
>  arch/sh/include/asm/types.h               |    5 -
>  arch/sh/include/asm/uaccess.h             |    4 -
>  arch/sh/include/asm/uaccess_64.h          |   85 -
>  arch/sh/include/asm/unistd.h              |    6 +-
>  arch/sh/include/asm/user.h                |    7 -
>  arch/sh/include/asm/vmlinux.lds.h         |    8 -
>  arch/sh/include/cpu-sh5/cpu/addrspace.h   |   12 -
>  arch/sh/include/cpu-sh5/cpu/cache.h       |   94 -
>  arch/sh/include/cpu-sh5/cpu/irq.h         |  113 --
>  arch/sh/include/cpu-sh5/cpu/mmu_context.h |   22 -
>  arch/sh/include/cpu-sh5/cpu/registers.h   |  103 --
>  arch/sh/include/cpu-sh5/cpu/rtc.h         |    9 -
>  arch/sh/include/uapi/asm/posix_types.h    |    8 +-
>  arch/sh/include/uapi/asm/posix_types_64.h |   29 -
>  arch/sh/include/uapi/asm/ptrace.h         |    5 -
>  arch/sh/include/uapi/asm/ptrace_64.h      |   15 -
>  arch/sh/include/uapi/asm/sigcontext.h     |   13 -
>  arch/sh/include/uapi/asm/stat.h           |   61 -
>  arch/sh/include/uapi/asm/swab.h           |   10 -
>  arch/sh/include/uapi/asm/unistd.h         |    8 +-
>  arch/sh/include/uapi/asm/unistd_64.h      |  423 -----
>  arch/sh/kernel/Makefile                   |   16 +-
>  arch/sh/kernel/cpu/Makefile               |    1 -
>  arch/sh/kernel/cpu/init.c                 |    2 +-
>  arch/sh/kernel/cpu/irq/Makefile           |    3 +-
>  arch/sh/kernel/cpu/irq/intc-sh5.c         |  194 --
>  arch/sh/kernel/cpu/proc.c                 |    1 -
>  arch/sh/kernel/cpu/sh5/Makefile           |   16 -
>  arch/sh/kernel/cpu/sh5/clock-sh5.c        |   76 -
>  arch/sh/kernel/cpu/sh5/entry.S            | 2000 ---------------------
>  arch/sh/kernel/cpu/sh5/fpu.c              |  106 --
>  arch/sh/kernel/cpu/sh5/probe.c            |   72 -
>  arch/sh/kernel/cpu/sh5/setup-sh5.c        |  121 --
>  arch/sh/kernel/cpu/sh5/switchto.S         |  195 --
>  arch/sh/kernel/cpu/sh5/unwind.c           |  342 ----
>  arch/sh/kernel/head_64.S                  |  346 ----
>  arch/sh/kernel/irq_64.c                   |   48 -
>  arch/sh/kernel/module.c                   |    9 -
>  arch/sh/kernel/process.c                  |    2 -
>  arch/sh/kernel/process_64.c               |  461 -----
>  arch/sh/kernel/ptrace_64.c                |  576 ------
>  arch/sh/kernel/reboot.c                   |    6 -
>  arch/sh/kernel/sh_ksyms_64.c              |   51 -
>  arch/sh/kernel/signal_64.c                |  567 ------
>  arch/sh/kernel/syscalls_64.S              |  419 -----
>  arch/sh/kernel/traps_64.c                 |  814 ---------
>  arch/sh/kernel/vmlinux.lds.S              |   18 +-
>  arch/sh/lib64/Makefile                    |   17 -
>  arch/sh/lib64/copy_page.S                 |   89 -
>  arch/sh/lib64/copy_user_memcpy.S          |  218 ---
>  arch/sh/lib64/memcpy.S                    |  202 ---
>  arch/sh/lib64/memset.S                    |   92 -
>  arch/sh/lib64/panic.c                     |   15 -
>  arch/sh/lib64/sdivsi3.S                   |  136 --
>  arch/sh/lib64/strcpy.S                    |   98 -
>  arch/sh/lib64/strlen.S                    |   34 -
>  arch/sh/lib64/udelay.c                    |   49 -
>  arch/sh/lib64/udivdi3.S                   |  121 --
>  arch/sh/lib64/udivsi3.S                   |   60 -
>  arch/sh/mm/Kconfig                        |   16 +-
>  arch/sh/mm/Makefile                       |   31 +-
>  arch/sh/mm/cache-sh5.c                    |  621 -------
>  arch/sh/mm/cache.c                        |    6 -
>  arch/sh/mm/extable_64.c                   |   84 -
>  arch/sh/mm/tlb-sh5.c                      |  224 ---
>  arch/sh/mm/tlbex_64.c                     |  166 --
>  arch/sh/mm/tlbflush_64.c                  |  172 --
>  drivers/rtc/Kconfig                       |    2 +-
>  fs/Kconfig.binfmt                         |    2 +-
>  scripts/headers_install.sh                |    3 -
>  tools/arch/sh/include/asm/barrier.h       |    2 +-
>  117 files changed, 67 insertions(+), 11554 deletions(-)
>  delete mode 100644 arch/sh/drivers/pci/ops-sh5.c
>  delete mode 100644 arch/sh/drivers/pci/pci-sh5.c
>  delete mode 100644 arch/sh/drivers/pci/pci-sh5.h
>  delete mode 100644 arch/sh/include/asm/bl_bit_64.h
>  delete mode 100644 arch/sh/include/asm/cache_insns_64.h
>  delete mode 100644 arch/sh/include/asm/mmu_context_64.h
>  delete mode 100644 arch/sh/include/asm/pgtable_64.h
>  delete mode 100644 arch/sh/include/asm/processor_64.h
>  delete mode 100644 arch/sh/include/asm/ptrace_64.h
>  delete mode 100644 arch/sh/include/asm/string_64.h
>  delete mode 100644 arch/sh/include/asm/switch_to_64.h
>  delete mode 100644 arch/sh/include/asm/syscall_64.h
>  delete mode 100644 arch/sh/include/asm/syscalls_64.h
>  delete mode 100644 arch/sh/include/asm/tlb_64.h
>  delete mode 100644 arch/sh/include/asm/traps_64.h
>  delete mode 100644 arch/sh/include/asm/uaccess_64.h
>  delete mode 100644 arch/sh/include/cpu-sh5/cpu/addrspace.h
>  delete mode 100644 arch/sh/include/cpu-sh5/cpu/cache.h
>  delete mode 100644 arch/sh/include/cpu-sh5/cpu/irq.h
>  delete mode 100644 arch/sh/include/cpu-sh5/cpu/mmu_context.h
>  delete mode 100644 arch/sh/include/cpu-sh5/cpu/registers.h
>  delete mode 100644 arch/sh/include/cpu-sh5/cpu/rtc.h
>  delete mode 100644 arch/sh/include/uapi/asm/posix_types_64.h
>  delete mode 100644 arch/sh/include/uapi/asm/ptrace_64.h
>  delete mode 100644 arch/sh/include/uapi/asm/unistd_64.h
>  delete mode 100644 arch/sh/kernel/cpu/irq/intc-sh5.c
>  delete mode 100644 arch/sh/kernel/cpu/sh5/Makefile
>  delete mode 100644 arch/sh/kernel/cpu/sh5/clock-sh5.c
>  delete mode 100644 arch/sh/kernel/cpu/sh5/entry.S
>  delete mode 100644 arch/sh/kernel/cpu/sh5/fpu.c
>  delete mode 100644 arch/sh/kernel/cpu/sh5/probe.c
>  delete mode 100644 arch/sh/kernel/cpu/sh5/setup-sh5.c
>  delete mode 100644 arch/sh/kernel/cpu/sh5/switchto.S
>  delete mode 100644 arch/sh/kernel/cpu/sh5/unwind.c
>  delete mode 100644 arch/sh/kernel/head_64.S
>  delete mode 100644 arch/sh/kernel/irq_64.c
>  delete mode 100644 arch/sh/kernel/process_64.c
>  delete mode 100644 arch/sh/kernel/ptrace_64.c
>  delete mode 100644 arch/sh/kernel/sh_ksyms_64.c
>  delete mode 100644 arch/sh/kernel/signal_64.c
>  delete mode 100644 arch/sh/kernel/syscalls_64.S
>  delete mode 100644 arch/sh/kernel/traps_64.c
>  delete mode 100644 arch/sh/lib64/Makefile
>  delete mode 100644 arch/sh/lib64/copy_page.S
>  delete mode 100644 arch/sh/lib64/copy_user_memcpy.S
>  delete mode 100644 arch/sh/lib64/memcpy.S
>  delete mode 100644 arch/sh/lib64/memset.S
>  delete mode 100644 arch/sh/lib64/panic.c
>  delete mode 100644 arch/sh/lib64/sdivsi3.S
>  delete mode 100644 arch/sh/lib64/strcpy.S
>  delete mode 100644 arch/sh/lib64/strlen.S
>  delete mode 100644 arch/sh/lib64/udelay.c
>  delete mode 100644 arch/sh/lib64/udivdi3.S
>  delete mode 100644 arch/sh/lib64/udivsi3.S
>  delete mode 100644 arch/sh/mm/cache-sh5.c
>  delete mode 100644 arch/sh/mm/extable_64.c
>  delete mode 100644 arch/sh/mm/tlb-sh5.c
>  delete mode 100644 arch/sh/mm/tlbex_64.c
>  delete mode 100644 arch/sh/mm/tlbflush_64.c
> 
> -- 
> 2.26.0
> 
---end quoted text---
