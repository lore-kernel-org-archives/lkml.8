Return-Path: <SRS0=rtH4=AH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,UPPERCASE_50_75,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 77BA4C433DF
	for <linux-kernel@archiver.kernel.org>; Fri, 26 Jun 2020 08:07:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 555BA2082E
	for <linux-kernel@archiver.kernel.org>; Fri, 26 Jun 2020 08:07:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="IhyMz/KW"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728955AbgFZIHq (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 26 Jun 2020 04:07:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41020 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729435AbgFZIHk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 Jun 2020 04:07:40 -0400
Received: from casper.infradead.org (unknown [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3F139C08C5C1;
        Fri, 26 Jun 2020 01:07:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:MIME-Version:
        References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:
        Content-Type:Content-ID:Content-Description;
        bh=mUMC34ZPtgkcffgbeSJReQnIQf4f75wbAsLK1lVyoQE=; b=IhyMz/KWtjlw8/dJeU2G36yACP
        J1pOSJvtFwkpivSu6IISp8n/ejKLptmXDNU8GPBgETrv5DFWD50VKs9XkilZXKkl2sbCAQhcHvkMm
        zNBXbcqCUIYnwA6hxM/U7yUZetN9a6XeyzxHQeB3sV/56UpfFqANmiXlIfsVVVTLqKCxYp2n6rkXX
        XN4XEHJ3uXrJQsdU2d3wS4leU1Mt0Me62Z80F1iCufRaptSXm8pnvVz6kHhmKjXnhAajgTI/u92Dk
        92AC98lwHMEzr+9GViodM8mKEXZD2J0EAuKkBDVRXaqhdbrr1a6t74nlJtK51CWrJTvEwdFNOSe9Z
        WUScfjkQ==;
Received: from [2001:4bb8:184:76e3:2b32:1123:bea8:6121] (helo=localhost)
        by casper.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1jojOK-0007t7-GK; Fri, 26 Jun 2020 08:07:20 +0000
From:   Christoph Hellwig <hch@lst.de>
To:     Yoshinori Sato <ysato@users.sourceforge.jp>,
        Rich Felker <dalias@libc.org>
Cc:     linux-sh@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH 02/10] sh: sort the selects for SUPERH alphabetically
Date:   Fri, 26 Jun 2020 10:07:09 +0200
Message-Id: <20200626080717.1999041-3-hch@lst.de>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20200626080717.1999041-1-hch@lst.de>
References: <20200626080717.1999041-1-hch@lst.de>
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

