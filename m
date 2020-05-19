Return-Path: <SRS0=IaiW=7B=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,UPPERCASE_50_75,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 17901C433E0
	for <linux-kernel@archiver.kernel.org>; Tue, 19 May 2020 03:42:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E584C20708
	for <linux-kernel@archiver.kernel.org>; Tue, 19 May 2020 03:42:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=sifive.com header.i=@sifive.com header.b="UaafkKkH"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728139AbgESDmI (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 18 May 2020 23:42:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40526 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726492AbgESDmH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 May 2020 23:42:07 -0400
Received: from mail-pj1-x1042.google.com (mail-pj1-x1042.google.com [IPv6:2607:f8b0:4864:20::1042])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 671C2C061A0C
        for <linux-kernel@vger.kernel.org>; Mon, 18 May 2020 20:42:07 -0700 (PDT)
Received: by mail-pj1-x1042.google.com with SMTP id z15so689824pjb.0
        for <linux-kernel@vger.kernel.org>; Mon, 18 May 2020 20:42:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sifive.com; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=hz7q0UBXblJmlQ0Hl2W6faDSP3NssHAPx2k9KjAeicQ=;
        b=UaafkKkHB3bn3XLmoTmBUZU5KegPGb7yPErquAgEVbCgBiU8D0JlUwxA9Am5kigVvK
         uBTdGmdTtfbsCVP+wq0fCu1+wLTzqGFKO6Rh2UeoZ90q6suAEKpdWGrXbTeqnVFK6lQB
         FQRmAFHVGjQ3yn5ASlot6syu4Ptyt0CjwwWTb3SKvRh6kd82uHPIjd++kgMcaD56bIdl
         RxY6u4dLxCtoK6Db3tcqvaqcmer5Nyt63Km/jayiGjOxGe2CVMPQ1BveHUtBKunf7n0h
         fGAAQI85he6V5bURxKkDgJAqM8kmkKtAGoiu0S3V6e3BRzBGE0jiJoCL/UxBRbmKdyKi
         1u2A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=hz7q0UBXblJmlQ0Hl2W6faDSP3NssHAPx2k9KjAeicQ=;
        b=FxQBFPFe4kbQy18qDLXMpuKiFE/lwgcxFyE+t24Syj5YutZAhk5R39RE0A28WkYQfw
         Jgnlt7KixvuRiqZo+N5BW8Ri/PFdZr1h9KYXvwHufNo5GzbKK0s920p+vyexbkAGamf6
         YsnrXEwvluZUgRFmnreLkQHMzX7hHu5/g138zi4SVZsUhgKH1jV0Wiy8V0bXtex3v9zB
         lESfDEcAuGlrm9p4YP6prUmXNWNxBKdyTlfxP0pMHouenp/Div1df/nAs54rePXBPv2J
         MCWIUg+Jz1ZtlwfOntPBA2qMc04v7Cs7MJ+MPmpKHyydAIFrg5Czavr8f8ZGQkCjY4TQ
         D9OQ==
X-Gm-Message-State: AOAM532L5v6o/ceNRRB9iG96F0TolgOyguQzaiy6XPMKVSTG0I9qMuOf
        FonMefw2i2A7SguwFHt0NvzRANzljJvttg==
X-Google-Smtp-Source: ABdhPJz0IdEJZwszdGYcpyvCUZEq/Vy7gmVpIPeErXvXC9hONhg5CBbhkxozisfGyPcrnbQxxSLWuQ==
X-Received: by 2002:a17:90a:fb96:: with SMTP id cp22mr2816190pjb.201.1589859726950;
        Mon, 18 May 2020 20:42:06 -0700 (PDT)
Received: from hsinchu02.internal.sifive.com (114-34-229-221.HINET-IP.hinet.net. [114.34.229.221])
        by smtp.gmail.com with ESMTPSA id 188sm9832256pfg.218.2020.05.18.20.42.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 18 May 2020 20:42:06 -0700 (PDT)
From:   Zong Li <zong.li@sifive.com>
To:     paul.walmsley@sifive.com, palmer@dabbelt.com,
        linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org
Cc:     Zong Li <zong.li@sifive.com>
Subject: [PATCH 1/1] riscv: sort select statements alphanumerically
Date:   Tue, 19 May 2020 11:42:04 +0800
Message-Id: <0609f8f0c0c7182fda08fc395161ec11309c63fb.1589859647.git.zong.li@sifive.com>
X-Mailer: git-send-email 2.26.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Like patch b1b3f49 ("ARM: config: sort select statements alphanumerically")
, we sort all our select statements alphanumerically by using the perl
script in patch b1b3f49 as above.

As suggested by Andrew Morton:

  This is a pet peeve of mine.  Any time there's a long list of items
  (header file inclusions, kconfig entries, array initalisers, etc) and
  someone wants to add a new item, they *always* go and stick it at the
  end of the list.

  Guys, don't do this.  Either put the new item into a randomly-chosen
  position or, probably better, alphanumerically sort the list.

Signed-off-by: Zong Li <zong.li@sifive.com>
---
 arch/riscv/Kconfig | 70 +++++++++++++++++++++++-----------------------
 1 file changed, 35 insertions(+), 35 deletions(-)

diff --git a/arch/riscv/Kconfig b/arch/riscv/Kconfig
index 74ce5c5249e9..8244b8f7e7c3 100644
--- a/arch/riscv/Kconfig
+++ b/arch/riscv/Kconfig
@@ -12,64 +12,64 @@ config 32BIT
 
 config RISCV
 	def_bool y
-	select OF
-	select OF_EARLY_FLATTREE
-	select OF_IRQ
 	select ARCH_HAS_BINFMT_FLAT
+	select ARCH_HAS_DEBUG_VIRTUAL if MMU
+	select ARCH_HAS_DEBUG_WX
+	select ARCH_HAS_GCOV_PROFILE_ALL
+	select ARCH_HAS_GIGANTIC_PAGE
+	select ARCH_HAS_MMIOWB
+	select ARCH_HAS_PTE_SPECIAL
+	select ARCH_HAS_SET_DIRECT_MAP
+	select ARCH_HAS_SET_MEMORY
+	select ARCH_HAS_STRICT_KERNEL_RWX if MMU
+	select ARCH_WANT_DEFAULT_TOPDOWN_MMAP_LAYOUT if MMU
 	select ARCH_WANT_FRAME_POINTERS
+	select ARCH_WANT_HUGE_PMD_SHARE if 64BIT
 	select CLONE_BACKWARDS
 	select COMMON_CLK
+	select EDAC_SUPPORT
+	select GENERIC_ARCH_TOPOLOGY if SMP
+	select GENERIC_ATOMIC64 if !64BIT
 	select GENERIC_CLOCKEVENTS
+	select GENERIC_IOREMAP
+	select GENERIC_IRQ_MULTI_HANDLER
 	select GENERIC_IRQ_SHOW
 	select GENERIC_PCI_IOMAP
+	select GENERIC_PTDUMP if MMU
 	select GENERIC_SCHED_CLOCK
+	select GENERIC_SMP_IDLE_THREAD
 	select GENERIC_STRNCPY_FROM_USER if MMU
 	select GENERIC_STRNLEN_USER if MMU
-	select GENERIC_SMP_IDLE_THREAD
-	select GENERIC_ATOMIC64 if !64BIT
-	select GENERIC_IOREMAP
-	select GENERIC_PTDUMP if MMU
 	select HAVE_ARCH_AUDITSYSCALL
+	select HAVE_ARCH_KASAN if MMU && 64BIT
+	select HAVE_ARCH_KGDB
+	select HAVE_ARCH_KGDB_QXFER_PKT
+	select HAVE_ARCH_MMAP_RND_BITS if MMU
 	select HAVE_ARCH_SECCOMP_FILTER
+	select HAVE_ARCH_TRACEHOOK
 	select HAVE_ASM_MODVERSIONS
+	select HAVE_COPY_THREAD_TLS
 	select HAVE_DMA_CONTIGUOUS if MMU
+	select HAVE_EBPF_JIT if MMU
 	select HAVE_FUTEX_CMPXCHG if FUTEX
+	select HAVE_PCI
 	select HAVE_PERF_EVENTS
 	select HAVE_PERF_REGS
 	select HAVE_PERF_USER_STACK_DUMP
 	select HAVE_SYSCALL_TRACEPOINTS
 	select IRQ_DOMAIN
-	select SPARSE_IRQ
-	select SYSCTL_EXCEPTION_TRACE
-	select HAVE_ARCH_TRACEHOOK
-	select HAVE_PCI
 	select MODULES_USE_ELF_RELA if MODULES
 	select MODULE_SECTIONS if MODULES
-	select THREAD_INFO_IN_TASK
+	select OF
+	select OF_EARLY_FLATTREE
+	select OF_IRQ
 	select PCI_DOMAINS_GENERIC if PCI
 	select PCI_MSI if PCI
 	select RISCV_TIMER
-	select GENERIC_IRQ_MULTI_HANDLER
-	select GENERIC_ARCH_TOPOLOGY if SMP
-	select ARCH_HAS_PTE_SPECIAL
-	select ARCH_HAS_MMIOWB
-	select ARCH_HAS_DEBUG_VIRTUAL if MMU
-	select HAVE_EBPF_JIT if MMU
-	select EDAC_SUPPORT
-	select ARCH_HAS_GIGANTIC_PAGE
-	select ARCH_HAS_SET_DIRECT_MAP
-	select ARCH_HAS_SET_MEMORY
-	select ARCH_HAS_STRICT_KERNEL_RWX if MMU
-	select ARCH_WANT_HUGE_PMD_SHARE if 64BIT
 	select SPARSEMEM_STATIC if 32BIT
-	select ARCH_WANT_DEFAULT_TOPDOWN_MMAP_LAYOUT if MMU
-	select HAVE_ARCH_MMAP_RND_BITS if MMU
-	select ARCH_HAS_GCOV_PROFILE_ALL
-	select HAVE_COPY_THREAD_TLS
-	select HAVE_ARCH_KASAN if MMU && 64BIT
-	select HAVE_ARCH_KGDB
-	select HAVE_ARCH_KGDB_QXFER_PKT
-	select ARCH_HAS_DEBUG_WX
+	select SPARSE_IRQ
+	select SYSCTL_EXCEPTION_TRACE
+	select THREAD_INFO_IN_TASK
 
 config ARCH_MMAP_RND_BITS_MIN
 	default 18 if 64BIT
@@ -196,11 +196,11 @@ config ARCH_RV64I
 	bool "RV64I"
 	select 64BIT
 	select ARCH_SUPPORTS_INT128 if CC_HAS_INT128 && GCC_VERSION >= 50000
-	select HAVE_FUNCTION_TRACER
-	select HAVE_FUNCTION_GRAPH_TRACER
-	select HAVE_FTRACE_MCOUNT_RECORD
 	select HAVE_DYNAMIC_FTRACE if MMU
 	select HAVE_DYNAMIC_FTRACE_WITH_REGS if HAVE_DYNAMIC_FTRACE
+	select HAVE_FTRACE_MCOUNT_RECORD
+	select HAVE_FUNCTION_GRAPH_TRACER
+	select HAVE_FUNCTION_TRACER
 	select SWIOTLB if MMU
 
 endchoice
-- 
2.26.2

