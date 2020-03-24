Return-Path: <SRS0=tn8d=5J=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,UPPERCASE_50_75,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 27D37C43331
	for <linux-kernel@archiver.kernel.org>; Tue, 24 Mar 2020 16:26:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F0F5D20788
	for <linux-kernel@archiver.kernel.org>; Tue, 24 Mar 2020 16:26:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="DFwVmlyN"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728768AbgCXQ0q (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 24 Mar 2020 12:26:46 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:59558 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728637AbgCXQ0o (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 Mar 2020 12:26:44 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=Content-Transfer-Encoding:
        MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender
        :Reply-To:Content-Type:Content-ID:Content-Description;
        bh=fTzmx+3y0abwCmtc5yMkI3NKOSqJHJ1zF1HY0E+MrKQ=; b=DFwVmlyNxFqu46pre485nI1Uno
        HU04h/zblFYZWlqFX7olTaXYe2IGA8QOMcT22YuEqBBPFCra1Dv8k0PGKITVoN/JTbTgNqfr5/pyY
        0EuwlOdKO0VxBbsfg8p5CmRvdMLUn/J269EURETmU4iLDYnUWBzz9v5tFOOfNwdQPQpPFRO3lvDji
        x879EI+q2BnIfifYGVeBO5B/K9vwc9Fu3NjXLA7io/m+10djLjzmhGsN7pj5fOwzxJLatVN8ACMQp
        mhOdY8fWtjv+uFOSyoWxozYE6aV3lr+i3ZmVPftNp/Vymt2GHXjs9Uwq7w3ExrrKFUxSlfsJRqV+k
        fd/rkQWA==;
Received: from [2001:4bb8:18c:2a9e:999c:283e:b14a:9189] (helo=localhost)
        by bombadil.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1jGmNz-0007cA-Mb; Tue, 24 Mar 2020 16:26:40 +0000
From:   Christoph Hellwig <hch@lst.de>
To:     Yoshinori Sato <ysato@users.sourceforge.jp>,
        Rich Felker <dalias@libc.org>
Cc:     linux-sh@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH 02/10] sh: sort the selects for SUPERH alphabetically
Date:   Tue, 24 Mar 2020 17:26:25 +0100
Message-Id: <20200324162633.754714-3-hch@lst.de>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200324162633.754714-1-hch@lst.de>
References: <20200324162633.754714-1-hch@lst.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Ensure there is an order for the selects of the main SUPERH symbol,
as well as the SUPERH32 and SUPER64 ones.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 arch/sh/Kconfig | 87 ++++++++++++++++++++++++-------------------------
 1 file changed, 43 insertions(+), 44 deletions(-)

diff --git a/arch/sh/Kconfig b/arch/sh/Kconfig
index 9ece111b0254..808b638b11f3 100644
--- a/arch/sh/Kconfig
+++ b/arch/sh/Kconfig
@@ -2,59 +2,58 @@
 config SUPERH
 	def_bool y
 	select ARCH_HAS_BINFMT_FLAT if !MMU
+	select ARCH_HAS_GCOV_PROFILE_ALL
+	select ARCH_HAS_GIGANTIC_PAGE
 	select ARCH_HAS_PTE_SPECIAL
 	select ARCH_HAS_TICK_BROADCAST if GENERIC_CLOCKEVENTS_BROADCAST
+	select ARCH_HAVE_CUSTOM_GPIO_H
+	select ARCH_HAVE_NMI_SAFE_CMPXCHG if (GUSA_RB || CPU_SH4A)
 	select ARCH_MIGHT_HAVE_PC_PARPORT
-	select HAVE_PATA_PLATFORM
+	select ARCH_WANT_IPC_PARSE_VERSION
 	select CLKDEV_LOOKUP
+	select CPU_NO_EFFICIENT_FFS
 	select DMA_DECLARE_COHERENT
-	select HAVE_IDE if HAS_IOPORT_MAP
-	select HAVE_MEMBLOCK_NODE_MAP
-	select HAVE_OPROFILE
+	select GENERIC_ATOMIC64
+	select GENERIC_CLOCKEVENTS
+	select GENERIC_CMOS_UPDATE if SH_SH03 || SH_DREAMCAST
+	select GENERIC_IDLE_POLL_SETUP
+	select GENERIC_IRQ_SHOW
+	select GENERIC_PCI_IOMAP if PCI
+	select GENERIC_SCHED_CLOCK
+	select GENERIC_SMP_IDLE_THREAD
+	select GENERIC_STRNCPY_FROM_USER
+	select GENERIC_STRNLEN_USER
+	select HAVE_ARCH_AUDITSYSCALL
 	select HAVE_ARCH_TRACEHOOK
-	select HAVE_PERF_EVENTS
 	select HAVE_DEBUG_BUGVERBOSE
-	select HAVE_FAST_GUP if MMU
-	select ARCH_HAVE_CUSTOM_GPIO_H
-	select ARCH_HAVE_NMI_SAFE_CMPXCHG if (GUSA_RB || CPU_SH4A)
-	select ARCH_HAS_GCOV_PROFILE_ALL
-	select PERF_USE_VMALLOC
 	select HAVE_DEBUG_KMEMLEAK
-	select HAVE_KERNEL_GZIP
-	select CPU_NO_EFFICIENT_FFS
+	select HAVE_FAST_GUP if MMU
+	select HAVE_FUTEX_CMPXCHG if FUTEX
+	select HAVE_IDE if HAS_IOPORT_MAP
 	select HAVE_KERNEL_BZIP2
+	select HAVE_KERNEL_GZIP
 	select HAVE_KERNEL_LZMA
-	select HAVE_KERNEL_XZ
 	select HAVE_KERNEL_LZO
+	select HAVE_KERNEL_XZ
+	select HAVE_MEMBLOCK_NODE_MAP
+	select HAVE_MOD_ARCH_SPECIFIC if DWARF_UNWINDER
+	select HAVE_NMI
+	select HAVE_OPROFILE
+	select HAVE_PATA_PLATFORM
+	select HAVE_PERF_EVENTS
+	select HAVE_REGS_AND_STACK_ACCESS_API
 	select HAVE_UID16
-	select ARCH_WANT_IPC_PARSE_VERSION
 	select HAVE_SYSCALL_TRACEPOINTS
-	select HAVE_REGS_AND_STACK_ACCESS_API
-	select MAY_HAVE_SPARSE_IRQ
 	select IRQ_FORCED_THREADING
-	select RTC_LIB
-	select GENERIC_ATOMIC64
-	select GENERIC_IRQ_SHOW
-	select GENERIC_SMP_IDLE_THREAD
-	select GENERIC_IDLE_POLL_SETUP
-	select GENERIC_CLOCKEVENTS
-	select GENERIC_CMOS_UPDATE if SH_SH03 || SH_DREAMCAST
-	select GENERIC_PCI_IOMAP if PCI
-	select GENERIC_SCHED_CLOCK
-	select GENERIC_STRNCPY_FROM_USER
-	select GENERIC_STRNLEN_USER
-	select HAVE_MOD_ARCH_SPECIFIC if DWARF_UNWINDER
+	select MAY_HAVE_SPARSE_IRQ
 	select MODULES_USE_ELF_RELA
+	select NEED_SG_DMA_LENGTH
 	select NO_GENERIC_PCI_IOPORT_MAP if PCI
-	select OLD_SIGSUSPEND
 	select OLD_SIGACTION
+	select OLD_SIGSUSPEND
 	select PCI_DOMAINS if PCI
-	select HAVE_ARCH_AUDITSYSCALL
-	select HAVE_FUTEX_CMPXCHG if FUTEX
-	select HAVE_NMI
-	select NEED_SG_DMA_LENGTH
-	select ARCH_HAS_GIGANTIC_PAGE
-
+	select PERF_USE_VMALLOC
+	select RTC_LIB
 	help
 	  The SuperH is a RISC processor targeted for use in embedded systems
 	  and consumer electronics; it was also used in the Sega Dreamcast
@@ -64,23 +63,23 @@ config SUPERH
 config SUPERH32
 	def_bool "$(ARCH)" = "sh"
 	select ARCH_32BIT_OFF_T
+	select ARCH_HIBERNATION_POSSIBLE if MMU
+	select ARCH_WANT_IPC_PARSE_VERSION
 	select GUP_GET_PTE_LOW_HIGH if X2TLB
-	select HAVE_KPROBES
-	select HAVE_KRETPROBES
-	select HAVE_IOREMAP_PROT if MMU && !X2TLB
+	select HAVE_ARCH_KGDB
+	select HAVE_DYNAMIC_FTRACE
 	select HAVE_FUNCTION_TRACER
+	select HAVE_FUNCTION_GRAPH_TRACER
 	select HAVE_FTRACE_MCOUNT_RECORD
-	select HAVE_DYNAMIC_FTRACE
 	select HAVE_FTRACE_NMI_ENTER if DYNAMIC_FTRACE
-	select ARCH_WANT_IPC_PARSE_VERSION
-	select HAVE_FUNCTION_GRAPH_TRACER
-	select HAVE_ARCH_KGDB
 	select HAVE_HW_BREAKPOINT
+	select HAVE_IOREMAP_PROT if MMU && !X2TLB
+	select HAVE_KPROBES
+	select HAVE_KRETPROBES
 	select HAVE_MIXED_BREAKPOINTS_REGS
+	select HAVE_STACKPROTECTOR
 	select PERF_EVENTS
-	select ARCH_HIBERNATION_POSSIBLE if MMU
 	select SPARSE_IRQ
-	select HAVE_STACKPROTECTOR
 
 config SUPERH64
 	def_bool "$(ARCH)" = "sh64"
-- 
2.25.1

