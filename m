Return-Path: <SRS0=8dav=5Y=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D38DDC2D0F4
	for <linux-kernel@archiver.kernel.org>; Wed,  8 Apr 2020 16:50:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9E31920730
	for <linux-kernel@archiver.kernel.org>; Wed,  8 Apr 2020 16:50:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=dabbelt-com.20150623.gappssmtp.com header.i=@dabbelt-com.20150623.gappssmtp.com header.b="JBeN7IqT"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730437AbgDHQuJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 8 Apr 2020 12:50:09 -0400
Received: from mail-pj1-f66.google.com ([209.85.216.66]:50676 "EHLO
        mail-pj1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727929AbgDHQuJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Apr 2020 12:50:09 -0400
Received: by mail-pj1-f66.google.com with SMTP id b7so74781pju.0
        for <linux-kernel@vger.kernel.org>; Wed, 08 Apr 2020 09:50:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=dabbelt-com.20150623.gappssmtp.com; s=20150623;
        h=date:subject:cc:from:to:message-id;
        bh=QQYZPZuaD3gvAt8XvbfkSFn8KkJ/ebEVEHLVG8rqDb8=;
        b=JBeN7IqThBYCjzPGqKVTDAG2xe3PHO4U03Mm4mB5xCFqyu5yAqK1gT1Vo1GwI+BgBr
         lmHg0ljh4tCR/rt9y9ZMz5IbXesWdJxVKjasZ1/ICu1QsAxZCZzVwKUmZApNZnk2Q3Q5
         ZcOs09nnR3yHWJNM9FKVrln0fu6n4JbC4Ql/bkE+s06HVsZVdYpZF9Uoo+2IC0EMbXhY
         WBiExf70ZFS7690mXP1JWJ/vzKJrlU/7ushbNdtepGsgpe5HJ+aIdqYrwP1m4EyBOW/q
         KK/57fnO//dTwIEKWEsNb2vLnOABOvFjoIix54U5C2Xs6urKKEZCCZwgmpR6Kqx1z6iT
         cp1g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:subject:cc:from:to:message-id;
        bh=QQYZPZuaD3gvAt8XvbfkSFn8KkJ/ebEVEHLVG8rqDb8=;
        b=i3Z6u3HqvhSI+y1cZvOTtn7G5rk4llAys7MlMTBq5Ty8u30N8ZZc6CZhBoBOKiE7h9
         qW0+h+7IKvwu0xFO5Q+Btjnu2tY5ZGL0wsLiKPeXOt5OQ072ffAyd9yZWob2OrDyMBNm
         ItD5dIpmT8n1Eqi1L4P64C/YAdGfdXoHZh35wIKpBxAEcVspy2fI4JvOh/OiRl1pUgNx
         jeiAZz10KlO90Ks5V2R24r3dGDgTXNJkof7+x347QeJqMYnlQomD+NpC8PLYT6W6bCxK
         6sz3flDsQ4ECNwDwjPsoDlEZJX/r6etZI1Ts1AkbhyEsYmxviYTf0Jlncru8Xu/94UGO
         4PKg==
X-Gm-Message-State: AGi0PuYm8KQ349gHS4iXx2yQKetMM+LDEUEKFSpn3RtPRGPc1JMsGuZu
        fbscqdtHVLEb800zCWvpYWmRCw==
X-Google-Smtp-Source: APiQypJS11tt0zxW9CXPj84MqIyJl1W+42dBt+SIznUYnT+NWvjD/TCjU0w0toKvVMos7dVstsi/cQ==
X-Received: by 2002:a17:90b:14cf:: with SMTP id jz15mr6569330pjb.36.1586364606596;
        Wed, 08 Apr 2020 09:50:06 -0700 (PDT)
Received: from localhost (76-210-143-223.lightspeed.sntcca.sbcglobal.net. [76.210.143.223])
        by smtp.gmail.com with ESMTPSA id t27sm8071069pgn.53.2020.04.08.09.50.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 08 Apr 2020 09:50:05 -0700 (PDT)
Date:   Wed, 08 Apr 2020 09:50:05 -0700 (PDT)
X-Google-Original-Date: Wed, 08 Apr 2020 09:50:01 PDT (-0700)
Subject: [GIT PULL] RISC-V Patches for the 5.7 Merge Window, Part 1
CC:         linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org
From:   Palmer Dabbelt <palmer@dabbelt.com>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Message-ID: <mhng-e58ec1f9-86f2-451e-ac9f-9add83693752@palmerdabbelt-glaptop1>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following changes since commit 98d54f81e36ba3bf92172791eba5ca5bd813989b:

  Linux 5.6-rc4 (2020-03-01 16:38:46 -0600)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/riscv/linux.git tags/riscv-for-linus-5.7

for you to fetch changes up to 37809df4b1c88927fe944eb766e0553811c51f64:

  riscv: create a loader.bin boot image for Kendryte SoC (2020-04-03 10:50:17 -0700)

----------------------------------------------------------------
RISC-V Patches for the 5.7 Merge Window, Part 1

This tag contains the patches I'd like to target for 5.7.  It has a handful of
new features:

* Partial support for the Kendryte K210.  There are still a few outstanding
  issues that I have patches for, but I don't actually have a board to test
  them so they're not included yet.
* SBI v0.2 support.
* Fixes to support for building with LLVM-based toolchains.  The resulting
  images are known not to boot yet.

This builds and boots for me.  There is one merge conflict, it's just a Kconfig
merge issue.  I can publish a resolved branch if you'd like.

I don't anticipate a part two, but I'll probably have something early in the
RCs to finish up the K210 support.

----------------------------------------------------------------
Alexandre Ghiti (1):
      riscv: Use p*d_leaf macros to define p*d_huge

Atish Patra (12):
      RISC-V: Move all address space definition macros to one place
      RISC-V: Mark existing SBI as 0.1 SBI.
      RISC-V: Add basic support for SBI v0.2
      RISC-V: Add SBI v0.2 extension definitions
      RISC-V: Introduce a new config for SBI v0.1
      RISC-V: Implement new SBI v0.2 extensions
      RISC-V: Move relocate and few other functions out of __init
      RISC-V: Add cpu_ops and modify default booting method
      RISC-V: Export SBI error to linux error mapping function
      RISC-V: Add SBI HSM extension definitions
      RISC-V: Add supported for ordered booting method using HSM
      RISC-V: Support cpu hotplug

Christoph Hellwig (2):
      riscv: Add Kendryte K210 SoC support
      riscv: create a loader.bin boot image for Kendryte SoC

Damien Le Moal (5):
      riscv: Unaligned load/store handling for M_MODE
      riscv: Add SOC early init support
      riscv: Select required drivers for Kendryte SOC
      riscv: Add Kendryte K210 device tree
      riscv: Kendryte K210 default config

Deepa Dinamani (1):
      riscv: Delete CONFIG_SYSFS_SYSCALL from defconfigs

Guo Ren (1):
      riscv: Use flush_icache_mm for flush_icache_user_range

Palmer Dabbelt (4):
      RISC-V: Stop putting .sbss in .sdata
      RISC-V: Stop relying on GCC's register allocator's hueristics
      RISC-V: Inline the assembly register save/restore macros
      RISC-V: Stop using LOCAL for the uaccess fixups

Zong Li (12):
      riscv: force hart_lottery to put in .sdata section
      riscv: add ARCH_HAS_SET_MEMORY support
      riscv: add ARCH_HAS_SET_DIRECT_MAP support
      riscv: add ARCH_SUPPORTS_DEBUG_PAGEALLOC support
      riscv: move exception table immediately after RO_DATA
      riscv: add alignment for text, rodata and data sections
      riscv: add STRICT_KERNEL_RWX support
      riscv: add macro to get instruction length
      riscv: introduce interfaces to patch kernel code
      riscv: patch code by fixmap mapping
      riscv: Add support to dump the kernel page tables
      riscv: Use macro definition instead of magic number

 arch/riscv/Kconfig                      |  26 +-
 arch/riscv/Kconfig.socs                 |  34 ++
 arch/riscv/Makefile                     |   6 +-
 arch/riscv/boot/Makefile                |   3 +
 arch/riscv/boot/dts/Makefile            |   1 +
 arch/riscv/boot/dts/kendryte/Makefile   |   2 +
 arch/riscv/boot/dts/kendryte/k210.dts   |  23 ++
 arch/riscv/boot/dts/kendryte/k210.dtsi  | 123 +++++++
 arch/riscv/configs/defconfig            |   1 +
 arch/riscv/configs/nommu_k210_defconfig |  68 ++++
 arch/riscv/configs/rv32_defconfig       |   1 +
 arch/riscv/include/asm/bug.h            |   8 +
 arch/riscv/include/asm/cacheflush.h     |   2 +-
 arch/riscv/include/asm/cpu_ops.h        |  46 +++
 arch/riscv/include/asm/current.h        |   5 +-
 arch/riscv/include/asm/fixmap.h         |   2 +
 arch/riscv/include/asm/kasan.h          |   2 +-
 arch/riscv/include/asm/patch.h          |  12 +
 arch/riscv/include/asm/pgtable.h        |  80 +++--
 arch/riscv/include/asm/ptdump.h         |  11 +
 arch/riscv/include/asm/sbi.h            | 195 +++++++----
 arch/riscv/include/asm/set_memory.h     |  48 +++
 arch/riscv/include/asm/smp.h            |  24 ++
 arch/riscv/include/asm/soc.h            |  23 ++
 arch/riscv/kernel/Makefile              |  13 +-
 arch/riscv/kernel/cpu-hotplug.c         |  87 +++++
 arch/riscv/kernel/cpu_ops.c             |  46 +++
 arch/riscv/kernel/cpu_ops_sbi.c         | 115 +++++++
 arch/riscv/kernel/cpu_ops_spinwait.c    |  43 +++
 arch/riscv/kernel/entry.S               | 143 ++++----
 arch/riscv/kernel/ftrace.c              |  13 +-
 arch/riscv/kernel/head.S                | 180 ++++++----
 arch/riscv/kernel/patch.c               | 120 +++++++
 arch/riscv/kernel/process.c             |   5 +-
 arch/riscv/kernel/sbi.c                 | 575 +++++++++++++++++++++++++++++++-
 arch/riscv/kernel/setup.c               |  32 +-
 arch/riscv/kernel/smpboot.c             |  53 +--
 arch/riscv/kernel/soc.c                 |  28 ++
 arch/riscv/kernel/stacktrace.c          |   7 +-
 arch/riscv/kernel/traps.c               |  32 +-
 arch/riscv/kernel/traps_misaligned.c    | 370 ++++++++++++++++++++
 arch/riscv/kernel/vmlinux.lds.S         |  23 +-
 arch/riscv/lib/uaccess.S                |   6 +-
 arch/riscv/mm/Makefile                  |   3 +-
 arch/riscv/mm/hugetlbpage.c             |   6 +-
 arch/riscv/mm/init.c                    |  44 +++
 arch/riscv/mm/pageattr.c                | 187 +++++++++++
 arch/riscv/mm/ptdump.c                  | 317 ++++++++++++++++++
 drivers/soc/Kconfig                     |   1 +
 drivers/soc/Makefile                    |   1 +
 drivers/soc/kendryte/Kconfig            |  14 +
 drivers/soc/kendryte/Makefile           |   3 +
 drivers/soc/kendryte/k210-sysctl.c      | 248 ++++++++++++++
 include/dt-bindings/clock/k210-clk.h    |  20 ++
 54 files changed, 3154 insertions(+), 327 deletions(-)
 create mode 100644 arch/riscv/boot/dts/kendryte/Makefile
 create mode 100644 arch/riscv/boot/dts/kendryte/k210.dts
 create mode 100644 arch/riscv/boot/dts/kendryte/k210.dtsi
 create mode 100644 arch/riscv/configs/nommu_k210_defconfig
 create mode 100644 arch/riscv/include/asm/cpu_ops.h
 create mode 100644 arch/riscv/include/asm/patch.h
 create mode 100644 arch/riscv/include/asm/ptdump.h
 create mode 100644 arch/riscv/include/asm/set_memory.h
 create mode 100644 arch/riscv/include/asm/soc.h
 create mode 100644 arch/riscv/kernel/cpu-hotplug.c
 create mode 100644 arch/riscv/kernel/cpu_ops.c
 create mode 100644 arch/riscv/kernel/cpu_ops_sbi.c
 create mode 100644 arch/riscv/kernel/cpu_ops_spinwait.c
 create mode 100644 arch/riscv/kernel/patch.c
 create mode 100644 arch/riscv/kernel/soc.c
 create mode 100644 arch/riscv/kernel/traps_misaligned.c
 create mode 100644 arch/riscv/mm/pageattr.c
 create mode 100644 arch/riscv/mm/ptdump.c
 create mode 100644 drivers/soc/kendryte/Kconfig
 create mode 100644 drivers/soc/kendryte/Makefile
 create mode 100644 drivers/soc/kendryte/k210-sysctl.c
 create mode 100644 include/dt-bindings/clock/k210-clk.h
