Return-Path: <SRS0=BsgQ=65=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 402F6C433E0
	for <linux-kernel@archiver.kernel.org>; Fri, 15 May 2020 19:01:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1402C206D8
	for <linux-kernel@archiver.kernel.org>; Fri, 15 May 2020 19:01:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=dabbelt-com.20150623.gappssmtp.com header.i=@dabbelt-com.20150623.gappssmtp.com header.b="1uWs4zKf"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726275AbgEOTBT (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 15 May 2020 15:01:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49282 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726023AbgEOTBR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 May 2020 15:01:17 -0400
Received: from mail-pf1-x442.google.com (mail-pf1-x442.google.com [IPv6:2607:f8b0:4864:20::442])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F1E50C061A0C
        for <linux-kernel@vger.kernel.org>; Fri, 15 May 2020 12:01:16 -0700 (PDT)
Received: by mail-pf1-x442.google.com with SMTP id y18so1399169pfl.9
        for <linux-kernel@vger.kernel.org>; Fri, 15 May 2020 12:01:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=dabbelt-com.20150623.gappssmtp.com; s=20150623;
        h=date:subject:cc:from:to:message-id;
        bh=Y4Tu4UqtalfMRN8mnNoM6mpqo/qALhm8HqxuxykVAjE=;
        b=1uWs4zKf4rQGsgiboVezung6oJ1vpH+pnRdjBVMXfyDJyIS1CV4CGEncgYCMYLtvES
         J64a013s9DcH76+W3dU+SmJg9kKInKG6ZE9zwbOwHHiEF+tWFwUc5DtppaydVC5Pgvpk
         Vq5YwwtqTPtxl/CaAkIXHCZaKkgbWGm7TLEQBuU3MkjhHqlCiSuxEUG6v19ViH9O6Poh
         honoDgGJO2bVhqjzz9OXcsfncuQjro2bAfQdZHJp7KU3aFgrYq3xUUlb4vI89dPqLOaI
         lpHYhbWYiBEM/QtL78s/GHWVQBkGf9KAVUUIJdTi047noN0A7mKxlZfQ3pUi3kJFWrMD
         fn0A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:subject:cc:from:to:message-id;
        bh=Y4Tu4UqtalfMRN8mnNoM6mpqo/qALhm8HqxuxykVAjE=;
        b=XxK7qLiaUvWJkhF2KZ0iS9/MwiYuhsIJdjSR/KmJZbHXfApXm7ghI/hGDBJV0XhhuQ
         X1V22ppmpNIlmD8rnFVsrbcqU8LpITys11w9VaNqxKN7rUEkGADwlM2tmwepq7UV+r9X
         WAA1K1w18+g4kT8OwkYPjTvZsYJ9ukHszBf2DstDk8Ag1esl5t6NU9srRjD18QnQc3mV
         TrfiBxCwWFd9n2pySCDfhuFnFyOIe/LKMkXIhKRpwaXlENMvzhUcvhugkoW4V/O8Hk9D
         3Pc/E6qR6oy7aqc5+y5NGYeYbA3x1Jv0P95iMQBjNq+uCBZCvtSaAg3NY92fe58U8fld
         A1Mw==
X-Gm-Message-State: AOAM530c3jmdGSw0rUaf6h+p/kxYBcT2p7t00vdGf2jAYOi/ckHEZFdw
        2mqN+z53ZwS1WhBut1JqDq7qfA==
X-Google-Smtp-Source: ABdhPJw6LoHwUAxm+l8/QIdvGoJTT2nBrVnwuMLOr03EUKhztvF58+XxCYARunlt/hIb7c53IltMGQ==
X-Received: by 2002:a63:175c:: with SMTP id 28mr4243174pgx.44.1589569276342;
        Fri, 15 May 2020 12:01:16 -0700 (PDT)
Received: from localhost (76-210-143-223.lightspeed.sntcca.sbcglobal.net. [76.210.143.223])
        by smtp.gmail.com with ESMTPSA id g1sm2574162pfb.191.2020.05.15.12.01.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 15 May 2020 12:01:15 -0700 (PDT)
Date:   Fri, 15 May 2020 12:01:15 -0700 (PDT)
X-Google-Original-Date: Fri, 15 May 2020 11:58:33 PDT (-0700)
Subject: [GIT PULL] RISC-V Fixes for 5.7-rc6
CC:         linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org
From:   Palmer Dabbelt <palmer@dabbelt.com>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Message-ID: <mhng-0786a015-369a-4f54-aa78-f4550588e4ef@palmerdabbelt-glaptop1>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following changes since commit 2ef96a5bb12be62ef75b5828c0aab838ebb29cb8:

  Linux 5.7-rc5 (2020-05-10 15:16:58 -0700)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/riscv/linux.git tags/riscv-for-linus-5.7-rc6

for you to fetch changes up to ed1ed4c0da5447c5e322481ce2ef9f03336c6ffb:

  riscv: mmiowb: Fix implicit declaration of function 'smp_processor_id' (2020-05-13 17:11:46 -0700)

----------------------------------------------------------------
RISC-V Fixes for 5.7-rc6

This consists of a handful of build fixes, all found by Huawei's autobuilder.
None of these patches should have any functional impact on kernels that build,
and they're mostly related to various features intermingling with !MMU.  While
some of these might be better hoisted to generic code, it seems better to have
the simple fixes in the meanwhile.

As far as I know these are the only outstanding patches for 5.7.

----------------------------------------------------------------
Kefeng Wang (9):
      riscv: perf_event: Make some funciton static
      riscv: perf: RISCV_BASE_PMU should be independent
      riscv: Fix unmet direct dependencies built based on SOC_VIRT
      riscv: stacktrace: Fix undefined reference to `walk_stackframe'
      riscv: Add pgprot_writecombine/device and PAGE_SHARED defination if NOMMU
      riscv: Disable ARCH_HAS_DEBUG_VIRTUAL if NOMMU
      riscv: Make SYS_SUPPORTS_HUGETLBFS depends on MMU
      riscv: pgtable: Fix __kernel_map_pages build error if NOMMU
      riscv: mmiowb: Fix implicit declaration of function 'smp_processor_id'

 arch/riscv/Kconfig                  |  3 ++-
 arch/riscv/Kconfig.socs             | 17 +++++++++--------
 arch/riscv/include/asm/mmio.h       |  2 ++
 arch/riscv/include/asm/mmiowb.h     |  1 +
 arch/riscv/include/asm/perf_event.h |  8 ++------
 arch/riscv/include/asm/pgtable.h    |  3 +++
 arch/riscv/kernel/Makefile          |  2 +-
 arch/riscv/kernel/perf_event.c      |  8 ++++----
 arch/riscv/kernel/stacktrace.c      |  2 +-
 9 files changed, 25 insertions(+), 21 deletions(-)
