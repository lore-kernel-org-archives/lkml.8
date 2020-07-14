Return-Path: <SRS0=dAmO=AZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,UPPERCASE_50_75,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2F0BBC433E0
	for <linux-kernel@archiver.kernel.org>; Tue, 14 Jul 2020 12:25:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 06CC722453
	for <linux-kernel@archiver.kernel.org>; Tue, 14 Jul 2020 12:25:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="AK6fOcm5"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728172AbgGNMZh (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 14 Jul 2020 08:25:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34930 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726889AbgGNMZh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Jul 2020 08:25:37 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0015BC061755;
        Tue, 14 Jul 2020 05:25:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:MIME-Version:
        References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:
        Content-Type:Content-ID:Content-Description;
        bh=mUMC34ZPtgkcffgbeSJReQnIQf4f75wbAsLK1lVyoQE=; b=AK6fOcm5fCuuyhCRwNkqA7pBU6
        Qy4jBsGEH0JugxFzWi43nFWbl+SffIL4/on9bBc2DihdGGDMsUQNOMlbtIH9hXAIlEFEr6UGiErwv
        VNjhKi5B1NGP9RG1UN18MvOcOuX7lDQpB7qfw1KVPuJA3OfmoYM4Bx7rubQ8ffXPLYuEG6I6bnlo1
        98HnZAIVU9THUoGr1T7xyOVOviG2Af7inxOHqEE3JWRM+lKr8MG2thxJPc0zICSnwUYJ5nrnu7ucZ
        +En8inzuJ9QCkBv1Wq6IdKz+T1R1JH19PX2/bg2aoMTRHwzgeiXxGQJrHKcVMSj1CH1+HLvHj4rjf
        gcBSQKSw==;
Received: from 089144201169.atnat0010.highway.a1.net ([89.144.201.169] helo=localhost)
        by casper.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1jvK02-0001OI-9J; Tue, 14 Jul 2020 12:25:30 +0000
From:   Christoph Hellwig <hch@lst.de>
To:     Yoshinori Sato <ysato@users.sourceforge.jp>,
        Rich Felker <dalias@libc.org>
Cc:     linux-sh@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH 02/10] sh: sort the selects for SUPERH alphabetically
Date:   Tue, 14 Jul 2020 14:18:48 +0200
Message-Id: <20200714121856.955680-3-hch@lst.de>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20200714121856.955680-1-hch@lst.de>
References: <20200714121856.955680-1-hch@lst.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by casper.infradead.org. See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Ensure there is an order for the selects.  Also remove a duplicate
one.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 arch/sh/Kconfig | 95 ++++++++++++++++++++++++-------------------------
 1 file changed, 47 insertions(+), 48 deletions(-)

diff --git a/arch/sh/Kconfig b/arch/sh/Kconfig
index 9fc2b010e938c9..f8027eee08edae 100644
--- a/arch/sh/Kconfig
+++ b/arch/sh/Kconfig
@@ -1,75 +1,74 @@
 # SPDX-License-Identifier: GPL-2.0
 config SUPERH
 	def_bool y
+	select ARCH_32BIT_OFF_T
+	select ARCH_HAVE_CUSTOM_GPIO_H
+	select ARCH_HAVE_NMI_SAFE_CMPXCHG if (GUSA_RB || CPU_SH4A)
 	select ARCH_HAS_BINFMT_FLAT if !MMU
+	select ARCH_HAS_GIGANTIC_PAGE
+	select ARCH_HAS_GCOV_PROFILE_ALL
 	select ARCH_HAS_PTE_SPECIAL
 	select ARCH_HAS_TICK_BROADCAST if GENERIC_CLOCKEVENTS_BROADCAST
+	select ARCH_HIBERNATION_POSSIBLE if MMU
 	select ARCH_MIGHT_HAVE_PC_PARPORT
-	select HAVE_PATA_PLATFORM
+	select ARCH_WANT_IPC_PARSE_VERSION
 	select CLKDEV_LOOKUP
+	select CPU_NO_EFFICIENT_FFS
 	select DMA_DECLARE_COHERENT
-	select HAVE_IDE if HAS_IOPORT_MAP
-	select HAVE_OPROFILE
+	select GENERIC_ATOMIC64
+	select GENERIC_CLOCKEVENTS
+	select GENERIC_CMOS_UPDATE if SH_SH03 || SH_DREAMCAST
+	select GENERIC_IDLE_POLL_SETUP
+	select GENERIC_IRQ_SHOW
+	select GENERIC_PCI_IOMAP if PCI
+	select GENERIC_SCHED_CLOCK
+	select GENERIC_STRNCPY_FROM_USER
+	select GENERIC_STRNLEN_USER
+	select GENERIC_SMP_IDLE_THREAD
+	select GUP_GET_PTE_LOW_HIGH if X2TLB
+	select HAVE_ARCH_AUDITSYSCALL
+	select HAVE_ARCH_KGDB
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
+	select HAVE_DYNAMIC_FTRACE
+	select HAVE_FAST_GUP if MMU
+	select HAVE_FUNCTION_GRAPH_TRACER
+	select HAVE_FUNCTION_TRACER
+	select HAVE_FUTEX_CMPXCHG if FUTEX
+	select HAVE_FTRACE_MCOUNT_RECORD
+	select HAVE_HW_BREAKPOINT
+	select HAVE_IDE if HAS_IOPORT_MAP
+	select HAVE_IOREMAP_PROT if MMU && !X2TLB
 	select HAVE_KERNEL_BZIP2
+	select HAVE_KERNEL_GZIP
 	select HAVE_KERNEL_LZMA
-	select HAVE_KERNEL_XZ
 	select HAVE_KERNEL_LZO
+	select HAVE_KERNEL_XZ
+	select HAVE_KPROBES
+	select HAVE_KRETPROBES
+	select HAVE_MIXED_BREAKPOINTS_REGS
+	select HAVE_MOD_ARCH_SPECIFIC if DWARF_UNWINDER
+	select HAVE_NMI
+	select HAVE_OPROFILE
+	select HAVE_PATA_PLATFORM
+	select HAVE_PERF_EVENTS
+	select HAVE_REGS_AND_STACK_ACCESS_API
 	select HAVE_UID16
-	select ARCH_WANT_IPC_PARSE_VERSION
+	select HAVE_STACKPROTECTOR
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
-	select ARCH_32BIT_OFF_T
-	select GUP_GET_PTE_LOW_HIGH if X2TLB
-	select HAVE_KPROBES
-	select HAVE_KRETPROBES
-	select HAVE_IOREMAP_PROT if MMU && !X2TLB
-	select HAVE_FUNCTION_TRACER
-	select HAVE_FTRACE_MCOUNT_RECORD
-	select HAVE_DYNAMIC_FTRACE
-	select ARCH_WANT_IPC_PARSE_VERSION
-	select HAVE_FUNCTION_GRAPH_TRACER
-	select HAVE_ARCH_KGDB
-	select HAVE_HW_BREAKPOINT
-	select HAVE_MIXED_BREAKPOINTS_REGS
 	select PERF_EVENTS
-	select ARCH_HIBERNATION_POSSIBLE if MMU
+	select PERF_USE_VMALLOC
+	select RTC_LIB
 	select SPARSE_IRQ
-	select HAVE_STACKPROTECTOR
 	help
 	  The SuperH is a RISC processor targeted for use in embedded systems
 	  and consumer electronics; it was also used in the Sega Dreamcast
-- 
2.26.2

