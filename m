Return-Path: <SRS0=vN1y=BQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.0 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 73215C433E0
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Aug 2020 23:17:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 67B862075A
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Aug 2020 23:17:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=dabbelt-com.20150623.gappssmtp.com header.i=@dabbelt-com.20150623.gappssmtp.com header.b="syzHWmPv"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726294AbgHFXRv (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 6 Aug 2020 19:17:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46756 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725272AbgHFXRv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Aug 2020 19:17:51 -0400
Received: from mail-pj1-x1044.google.com (mail-pj1-x1044.google.com [IPv6:2607:f8b0:4864:20::1044])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1D645C061574
        for <linux-kernel@vger.kernel.org>; Thu,  6 Aug 2020 16:17:51 -0700 (PDT)
Received: by mail-pj1-x1044.google.com with SMTP id 2so7629883pjx.5
        for <linux-kernel@vger.kernel.org>; Thu, 06 Aug 2020 16:17:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=dabbelt-com.20150623.gappssmtp.com; s=20150623;
        h=date:subject:cc:from:to:message-id;
        bh=i/OwUIJf7SuJHYzeBOib/eEDsTwDweM8G7B4I7i5Bvo=;
        b=syzHWmPvTWALcrWBF18nmFt2CvSrIQYFi1YMgwYoeqCG1noUVuvEyvzppBNyxLschE
         vuX35e4wHBO2uDnVXgHHa8SUMo7ibA3GrjjlHw62UO3BE9b+AsLtvN/JyMadYkvn4cQB
         F3I6JVnvZAFkwunDEY7J34CGXmCvq6kj94LsGSGNaO1D7KmdlrfxCP8hD4QSZ+qwvGxv
         ts8MAebxt/4uuGVrn+HQQBvKWhMbRkgXVOKJQVgyyyyJ9u3Q3x7hA0FYzvwlFoa8GdGq
         UZBHbIpd73ITwUoJJrESh7jQtaxz4GsC4Q0/6nLr7QDEGJ9N+dGy5PZNv/uPqRVdFyf9
         HZFg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:subject:cc:from:to:message-id;
        bh=i/OwUIJf7SuJHYzeBOib/eEDsTwDweM8G7B4I7i5Bvo=;
        b=M+MOl1zWIxAGG09WX2M42b0hr+DPoGWIhfPS807MWaYwIufQNlozQNRlRD/EbvS9JL
         NOeIhG1sjgH46gnqchtuemwYQx1mLGmWtpwFoNVDmOqZ89ULyybwsQMM0/2jMaWSYcMj
         DiPdOaftcaXBVwF8HKiOp1d2ymFwsYG1Nz1iRDuHML0288VVKslMUTNqI5y6zDQNtXMX
         tTpFl/zDkPa+sh8RqA8KepkX8NhFMvaa2uMMo2WMno+SXhS9iwTIe6p7SnJoI1F1dveK
         NGvyYu0TzagZ1JjRVafeXVjIHdzPXM9lpnI/y9PAEmT85H2KbmYAqussveSzvK9Ct7Mg
         6/Kg==
X-Gm-Message-State: AOAM532Y2uXwgVc5gt8gSmiD2tR2t5cfuokA9sCnQ2csz5XJYe767b4C
        uSK+UmOaSVTXRsL5qNDR9APt/g==
X-Google-Smtp-Source: ABdhPJx9PA/4CJu14d0jYRFqd7WVyGbfengXQHp8k+Q/wkU6L2M8uCVqMNWs1WC93enhL/GT20beMw==
X-Received: by 2002:a17:902:368:: with SMTP id 95mr10201850pld.279.1596755870455;
        Thu, 06 Aug 2020 16:17:50 -0700 (PDT)
Received: from localhost (76-210-143-223.lightspeed.sntcca.sbcglobal.net. [76.210.143.223])
        by smtp.gmail.com with ESMTPSA id e9sm9761253pfh.151.2020.08.06.16.17.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 06 Aug 2020 16:17:49 -0700 (PDT)
Date:   Thu, 06 Aug 2020 16:17:49 -0700 (PDT)
X-Google-Original-Date: Thu, 06 Aug 2020 16:17:37 PDT (-0700)
Subject: [GIT PULL] RISC-V Patches for the 5.9 Merge Window, Part 1
CC:         linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org
From:   Palmer Dabbelt <palmer@dabbelt.com>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Message-ID: <mhng-bb218bf7-4f63-48f8-95a6-67ff0d32a166@palmerdabbelt-glaptop1>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following changes since commit 9ebcfadb0610322ac537dd7aa5d9cbc2b2894c68:

  Linux 5.8-rc3 (2020-06-28 15:00:24 -0700)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/riscv/linux.git tags/riscv-for-linus-5.9-mw0

for you to fetch changes up to 40284a072c42f6177184fb1f62ba94c69e0c0277:

  riscv: disable stack-protector for vDSO (2020-08-04 15:02:49 -0700)

----------------------------------------------------------------
RISC-V Patches for the 5.9 Merge Window, Part 1

We have a lot of new kernel features for this merge window:

* ARCH_SUPPORTS_ATOMIC_RMW, to allow OSQ locks to be enabled.
* The ability to enable NO_HZ_FULL
* Support for enabling kcov, kmemleak, stack protector, and VM debugging.
* JUMP_LABEL support.

There are also a handful of cleanups.

next points out a trivial Kconfig merge conflict.  I don't see any way to have
done this better: the symbols are sorted, it just happens that
HAVE_COPY_THREAD_TLS was in the middle of two new symbols.  In case it helps
any, here's a pretty current conflict resolution:

diff --cc arch/riscv/Kconfig
index bc37241a6875,6c4bce7cad8a..7b5905529146
--- a/arch/riscv/Kconfig
+++ b/arch/riscv/Kconfig
@@@ -57,9 -54,6 +59,8 @@@ config RISC
        select HAVE_ARCH_SECCOMP_FILTER
        select HAVE_ARCH_TRACEHOOK
        select HAVE_ASM_MODVERSIONS
 +      select HAVE_CONTEXT_TRACKING
-       select HAVE_COPY_THREAD_TLS
 +      select HAVE_DEBUG_KMEMLEAK
        select HAVE_DMA_CONTIGUOUS if MMU
        select HAVE_EBPF_JIT if MMU
        select HAVE_FUTEX_CMPXCHG if FUTEX

----------------------------------------------------------------
Alexander A. Klimov (1):
      Replace HTTP links with HTTPS ones: RISC-V

Atish Patra (2):
      RISC-V: Setup exception vector early
      RISC-V: Fix build warning for smpboot.c

Chenxi Mao (1):
      riscv: Select ARCH_SUPPORTS_ATOMIC_RMW by default

Emil Renner Berthing (3):
      riscv: Support R_RISCV_ADD64 and R_RISCV_SUB64 relocs
      riscv: Add jump-label implementation
      riscv: Select ARCH_HAS_DEBUG_VM_PGTABLE

Greentime Hu (3):
      RISC-V: Use a local variable instead of smp_processor_id()
      riscv: Support irq_work via self IPIs
      riscv: Enable context tracking

Guo Ren (4):
      riscv: Fixup static_obj() fail
      riscv: Enable LOCKDEP_SUPPORT & fixup TRACE_IRQFLAGS_SUPPORT
      riscv: Add STACKPROTECTOR supported
      riscv: Cleanup unnecessary define in asm-offset.c

Pekka Enberg (2):
      mm: pgtable: Make generic pgprot_* macros available for no-MMU
      riscv: Use generic pgprot_* macros from <linux/pgtable.h>

Tobias Klauser (4):
      riscv: Allow building with kcov coverage
      riscv: Add kmemleak support
      riscv: Fix typo in asm/hwcap.h uapi header
      riscv: disable stack-protector for vDSO

Zong Li (4):
      riscv: Register System RAM as iomem resources
      riscv: Fixup lockdep_assert_held with wrong param cpu_running
      riscv: Fix build warning for mm/init
      riscv: fix build warning of mm/pageattr

 .../features/core/jump-labels/arch-support.txt     |  2 +-
 .../debug/debug-vm-pgtable/arch-support.txt        |  2 +-
 arch/riscv/Kconfig                                 | 12 ++++
 arch/riscv/boot/Makefile                           |  2 +
 arch/riscv/configs/defconfig                       |  1 +
 arch/riscv/configs/nommu_k210_defconfig            |  1 +
 arch/riscv/configs/nommu_virt_defconfig            |  1 +
 arch/riscv/configs/rv32_defconfig                  |  1 +
 arch/riscv/include/asm/irq_work.h                  | 10 +++
 arch/riscv/include/asm/jump_label.h                | 60 ++++++++++++++++++
 arch/riscv/include/asm/mmio.h                      |  6 --
 arch/riscv/include/asm/smp.h                       |  3 +
 arch/riscv/include/asm/stackprotector.h            | 33 ++++++++++
 arch/riscv/include/uapi/asm/hwcap.h                |  2 +-
 arch/riscv/include/uapi/asm/unistd.h               |  2 +-
 arch/riscv/kernel/Makefile                         |  2 +
 arch/riscv/kernel/asm-offsets.c                    |  3 -
 arch/riscv/kernel/entry.S                          | 54 ++++++++++++++--
 arch/riscv/kernel/head.S                           | 10 ++-
 arch/riscv/kernel/jump_label.c                     | 53 ++++++++++++++++
 arch/riscv/kernel/module.c                         | 16 +++++
 arch/riscv/kernel/process.c                        |  6 ++
 arch/riscv/kernel/smp.c                            | 15 +++++
 arch/riscv/kernel/smpboot.c                        | 12 ++--
 arch/riscv/kernel/traps.c                          |  8 +--
 arch/riscv/kernel/vdso/Makefile                    |  3 +
 arch/riscv/kernel/vmlinux.lds.S                    |  2 +-
 arch/riscv/mm/Makefile                             |  2 +
 arch/riscv/mm/init.c                               | 27 ++++++++
 arch/riscv/mm/pageattr.c                           |  3 +-
 include/linux/pgtable.h                            | 71 +++++++++++-----------
 tools/arch/riscv/include/uapi/asm/unistd.h         |  2 +-
 32 files changed, 356 insertions(+), 71 deletions(-)
 create mode 100644 arch/riscv/include/asm/irq_work.h
 create mode 100644 arch/riscv/include/asm/jump_label.h
 create mode 100644 arch/riscv/include/asm/stackprotector.h
 create mode 100644 arch/riscv/kernel/jump_label.c
