Return-Path: <SRS0=dAmO=AZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 72BD0C433E2
	for <linux-kernel@archiver.kernel.org>; Tue, 14 Jul 2020 12:27:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 437002245A
	for <linux-kernel@archiver.kernel.org>; Tue, 14 Jul 2020 12:27:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="gRrPXjlf"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727909AbgGNM1y (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 14 Jul 2020 08:27:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35276 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726041AbgGNM1x (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Jul 2020 08:27:53 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2DA09C061755;
        Tue, 14 Jul 2020 05:27:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:MIME-Version:
        References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:
        Content-Type:Content-ID:Content-Description;
        bh=D8rbwu3C7VXGzgGu0Qn3qSmdXeFwXlYF0N46QN81IhM=; b=gRrPXjlfpb+Ygy1mJG+YIMYd0U
        yebdiSZgnwuLn2e4OtOWcOTKtb8lGndkJ5NQ/+UPMpbqs8nqKOETkli2OU0H3pI6/sgxw9/UZ6PyT
        K/3JKN1EqFk0lFweTu5+MShACx46VTzvnK7vz/y+YVrj9HAy4N47WMy2+pLE6D9Eh8v7DlNAW+jgL
        /5iglXZDOaPxWU9AN2s/JPMNm5ccIsfsDSiMpeuYRe2kSkfXm2ExhcNU4Iqa2RKY+MrxJ0wGnDiRN
        VFyiic85MxMNV18Obo9jB6ybXvDKjx8a5G6ND7dYcfxtgS8yyMMXcuUYDEsJw9/UCn8KMOGDRTEDu
        LJyv3lDA==;
Received: from 089144201169.atnat0010.highway.a1.net ([89.144.201.169] helo=localhost)
        by casper.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1jvK2A-0001XG-AD; Tue, 14 Jul 2020 12:27:43 +0000
From:   Christoph Hellwig <hch@lst.de>
To:     Yoshinori Sato <ysato@users.sourceforge.jp>,
        Rich Felker <dalias@libc.org>
Cc:     linux-sh@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH 03/10] sh: remove __KERNEL__ ifdefs from non-UAPI headers
Date:   Tue, 14 Jul 2020 14:18:49 +0200
Message-Id: <20200714121856.955680-4-hch@lst.de>
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

There is no point in having __KERNEL__ ifdefs in headers not exported to
userspace.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 arch/sh/include/asm/adc.h          | 2 --
 arch/sh/include/asm/addrspace.h    | 3 ---
 arch/sh/include/asm/bitops.h       | 4 ----
 arch/sh/include/asm/cache.h        | 2 --
 arch/sh/include/asm/cacheflush.h   | 3 ---
 arch/sh/include/asm/dma.h          | 2 --
 arch/sh/include/asm/elf.h          | 2 --
 arch/sh/include/asm/freq.h         | 2 --
 arch/sh/include/asm/futex.h        | 3 ---
 arch/sh/include/asm/io.h           | 3 ---
 arch/sh/include/asm/mmu_context.h  | 2 --
 arch/sh/include/asm/mmzone.h       | 3 ---
 arch/sh/include/asm/pci.h          | 4 ----
 arch/sh/include/asm/processor_32.h | 2 --
 arch/sh/include/asm/sparsemem.h    | 3 ---
 arch/sh/include/asm/string_32.h    | 4 ----
 arch/sh/include/asm/syscalls_32.h  | 3 ---
 arch/sh/include/asm/thread_info.h  | 5 -----
 arch/sh/include/asm/watchdog.h     | 2 --
 19 files changed, 54 deletions(-)

diff --git a/arch/sh/include/asm/adc.h b/arch/sh/include/asm/adc.h
index 99ec668495594c..feccfe639e3896 100644
--- a/arch/sh/include/asm/adc.h
+++ b/arch/sh/include/asm/adc.h
@@ -1,7 +1,6 @@
 /* SPDX-License-Identifier: GPL-2.0 */
 #ifndef __ASM_ADC_H
 #define __ASM_ADC_H
-#ifdef __KERNEL__
 /*
  * Copyright (C) 2004  Andriy Skulysh
  */
@@ -10,5 +9,4 @@
 
 int adc_single(unsigned int channel);
 
-#endif /* __KERNEL__ */
 #endif /* __ASM_ADC_H */
diff --git a/arch/sh/include/asm/addrspace.h b/arch/sh/include/asm/addrspace.h
index 34bfbcddcce027..468fba333e896b 100644
--- a/arch/sh/include/asm/addrspace.h
+++ b/arch/sh/include/asm/addrspace.h
@@ -7,8 +7,6 @@
 #ifndef __ASM_SH_ADDRSPACE_H
 #define __ASM_SH_ADDRSPACE_H
 
-#ifdef __KERNEL__
-
 #include <cpu/addrspace.h>
 
 /* If this CPU supports segmentation, hook up the helpers */
@@ -62,5 +60,4 @@
 #define P3_ADDR_MAX		P4SEG
 #endif
 
-#endif /* __KERNEL__ */
 #endif /* __ASM_SH_ADDRSPACE_H */
diff --git a/arch/sh/include/asm/bitops.h b/arch/sh/include/asm/bitops.h
index 445dd14c448a67..450b5854d7c67b 100644
--- a/arch/sh/include/asm/bitops.h
+++ b/arch/sh/include/asm/bitops.h
@@ -2,8 +2,6 @@
 #ifndef __ASM_SH_BITOPS_H
 #define __ASM_SH_BITOPS_H
 
-#ifdef __KERNEL__
-
 #ifndef _LINUX_BITOPS_H
 #error only <linux/bitops.h> can be included directly
 #endif
@@ -71,6 +69,4 @@ static inline unsigned long __ffs(unsigned long word)
 #include <asm-generic/bitops/__fls.h>
 #include <asm-generic/bitops/fls64.h>
 
-#endif /* __KERNEL__ */
-
 #endif /* __ASM_SH_BITOPS_H */
diff --git a/arch/sh/include/asm/cache.h b/arch/sh/include/asm/cache.h
index 2408ac4873aa00..a293343456affe 100644
--- a/arch/sh/include/asm/cache.h
+++ b/arch/sh/include/asm/cache.h
@@ -8,7 +8,6 @@
  */
 #ifndef __ASM_SH_CACHE_H
 #define __ASM_SH_CACHE_H
-#ifdef __KERNEL__
 
 #include <linux/init.h>
 #include <cpu/cache.h>
@@ -44,5 +43,4 @@ struct cache_info {
 	unsigned long flags;
 };
 #endif /* __ASSEMBLY__ */
-#endif /* __KERNEL__ */
 #endif /* __ASM_SH_CACHE_H */
diff --git a/arch/sh/include/asm/cacheflush.h b/arch/sh/include/asm/cacheflush.h
index fe7400079b97b0..4486a865ff62f6 100644
--- a/arch/sh/include/asm/cacheflush.h
+++ b/arch/sh/include/asm/cacheflush.h
@@ -2,8 +2,6 @@
 #ifndef __ASM_SH_CACHEFLUSH_H
 #define __ASM_SH_CACHEFLUSH_H
 
-#ifdef __KERNEL__
-
 #include <linux/mm.h>
 
 /*
@@ -109,5 +107,4 @@ static inline void *sh_cacheop_vaddr(void *vaddr)
 	return vaddr;
 }
 
-#endif /* __KERNEL__ */
 #endif /* __ASM_SH_CACHEFLUSH_H */
diff --git a/arch/sh/include/asm/dma.h b/arch/sh/include/asm/dma.h
index 4d5a21a891c078..17d23ae98c77a4 100644
--- a/arch/sh/include/asm/dma.h
+++ b/arch/sh/include/asm/dma.h
@@ -6,7 +6,6 @@
  */
 #ifndef __ASM_SH_DMA_H
 #define __ASM_SH_DMA_H
-#ifdef __KERNEL__
 
 #include <linux/spinlock.h>
 #include <linux/wait.h>
@@ -144,5 +143,4 @@ extern int isa_dma_bridge_buggy;
 #define isa_dma_bridge_buggy	(0)
 #endif
 
-#endif /* __KERNEL__ */
 #endif /* __ASM_SH_DMA_H */
diff --git a/arch/sh/include/asm/elf.h b/arch/sh/include/asm/elf.h
index 7661fb5d548a08..2862d6d1cb64f1 100644
--- a/arch/sh/include/asm/elf.h
+++ b/arch/sh/include/asm/elf.h
@@ -90,7 +90,6 @@ typedef struct user_fpu_struct elf_fpregset_t;
 #endif
 #define ELF_ARCH	EM_SH
 
-#ifdef __KERNEL__
 /*
  * This is used to ensure we don't load something for the wrong architecture.
  */
@@ -209,5 +208,4 @@ do {								\
 	NEW_AUX_ENT(AT_L2_CACHESHAPE, l2_cache_shape);		\
 } while (0)
 
-#endif /* __KERNEL__ */
 #endif /* __ASM_SH_ELF_H */
diff --git a/arch/sh/include/asm/freq.h b/arch/sh/include/asm/freq.h
index 18133bf837386b..87c23621b7ae81 100644
--- a/arch/sh/include/asm/freq.h
+++ b/arch/sh/include/asm/freq.h
@@ -6,9 +6,7 @@
  */
 #ifndef __ASM_SH_FREQ_H
 #define __ASM_SH_FREQ_H
-#ifdef __KERNEL__
 
 #include <cpu/freq.h>
 
-#endif /* __KERNEL__ */
 #endif /* __ASM_SH_FREQ_H */
diff --git a/arch/sh/include/asm/futex.h b/arch/sh/include/asm/futex.h
index b39cda09fb95cc..b70f3fce6ed77a 100644
--- a/arch/sh/include/asm/futex.h
+++ b/arch/sh/include/asm/futex.h
@@ -2,8 +2,6 @@
 #ifndef __ASM_SH_FUTEX_H
 #define __ASM_SH_FUTEX_H
 
-#ifdef __KERNEL__
-
 #include <linux/futex.h>
 #include <linux/uaccess.h>
 #include <asm/errno.h>
@@ -71,5 +69,4 @@ static inline int arch_futex_atomic_op_inuser(int op, u32 oparg, int *oval,
 	return ret;
 }
 
-#endif /* __KERNEL__ */
 #endif /* __ASM_SH_FUTEX_H */
diff --git a/arch/sh/include/asm/io.h b/arch/sh/include/asm/io.h
index 26f0f9b4658b20..1fd06ef6a19454 100644
--- a/arch/sh/include/asm/io.h
+++ b/arch/sh/include/asm/io.h
@@ -20,7 +20,6 @@
 #include <linux/pgtable.h>
 #include <asm-generic/iomap.h>
 
-#ifdef __KERNEL__
 #define __IO_PREFIX     generic
 #include <asm/io_generic.h>
 #include <asm/io_trapped.h>
@@ -380,6 +379,4 @@ static inline int iounmap_fixed(void __iomem *addr) { return -EINVAL; }
 int valid_phys_addr_range(phys_addr_t addr, size_t size);
 int valid_mmap_phys_addr_range(unsigned long pfn, size_t size);
 
-#endif /* __KERNEL__ */
-
 #endif /* __ASM_SH_IO_H */
diff --git a/arch/sh/include/asm/mmu_context.h b/arch/sh/include/asm/mmu_context.h
index 48e67d544d53cf..f664e51e8a15e5 100644
--- a/arch/sh/include/asm/mmu_context.h
+++ b/arch/sh/include/asm/mmu_context.h
@@ -8,7 +8,6 @@
 #ifndef __ASM_SH_MMU_CONTEXT_H
 #define __ASM_SH_MMU_CONTEXT_H
 
-#ifdef __KERNEL__
 #include <cpu/mmu_context.h>
 #include <asm/tlbflush.h>
 #include <linux/uaccess.h>
@@ -177,5 +176,4 @@ static inline void disable_mmu(void)
 #define disable_mmu()	do { } while (0)
 #endif
 
-#endif /* __KERNEL__ */
 #endif /* __ASM_SH_MMU_CONTEXT_H */
diff --git a/arch/sh/include/asm/mmzone.h b/arch/sh/include/asm/mmzone.h
index cbaee1d1b67320..6552a088dc97ae 100644
--- a/arch/sh/include/asm/mmzone.h
+++ b/arch/sh/include/asm/mmzone.h
@@ -2,8 +2,6 @@
 #ifndef __ASM_SH_MMZONE_H
 #define __ASM_SH_MMZONE_H
 
-#ifdef __KERNEL__
-
 #ifdef CONFIG_NEED_MULTIPLE_NODES
 #include <linux/numa.h>
 
@@ -44,5 +42,4 @@ void __init __add_active_range(unsigned int nid, unsigned long start_pfn,
 /* arch/sh/mm/init.c */
 void __init allocate_pgdat(unsigned int nid);
 
-#endif /* __KERNEL__ */
 #endif /* __ASM_SH_MMZONE_H */
diff --git a/arch/sh/include/asm/pci.h b/arch/sh/include/asm/pci.h
index 10a36b1cf2eab1..ad22e88c6657dc 100644
--- a/arch/sh/include/asm/pci.h
+++ b/arch/sh/include/asm/pci.h
@@ -2,8 +2,6 @@
 #ifndef __ASM_SH_PCI_H
 #define __ASM_SH_PCI_H
 
-#ifdef __KERNEL__
-
 /* Can be used to override the logic in pci_scan_bus for skipping
    already-configured bus numbers - to be used for buggy BIOSes
    or architectures with incomplete PCI setup by the loader */
@@ -96,6 +94,4 @@ static inline int pci_get_legacy_ide_irq(struct pci_dev *dev, int channel)
 	return channel ? 15 : 14;
 }
 
-#endif /* __KERNEL__ */
 #endif /* __ASM_SH_PCI_H */
-
diff --git a/arch/sh/include/asm/processor_32.h b/arch/sh/include/asm/processor_32.h
index d44409413418a5..aa92cc933889df 100644
--- a/arch/sh/include/asm/processor_32.h
+++ b/arch/sh/include/asm/processor_32.h
@@ -8,7 +8,6 @@
 
 #ifndef __ASM_SH_PROCESSOR_32_H
 #define __ASM_SH_PROCESSOR_32_H
-#ifdef __KERNEL__
 
 #include <linux/compiler.h>
 #include <linux/linkage.h>
@@ -203,5 +202,4 @@ static inline void prefetchw(const void *x)
 }
 #endif
 
-#endif /* __KERNEL__ */
 #endif /* __ASM_SH_PROCESSOR_32_H */
diff --git a/arch/sh/include/asm/sparsemem.h b/arch/sh/include/asm/sparsemem.h
index 4eb899751e4590..ed287c4980bcab 100644
--- a/arch/sh/include/asm/sparsemem.h
+++ b/arch/sh/include/asm/sparsemem.h
@@ -2,7 +2,6 @@
 #ifndef __ASM_SH_SPARSEMEM_H
 #define __ASM_SH_SPARSEMEM_H
 
-#ifdef __KERNEL__
 /*
  * SECTION_SIZE_BITS		2^N: how big each section will be
  * MAX_PHYSADDR_BITS		2^N: how much physical address space we have
@@ -12,6 +11,4 @@
 #define MAX_PHYSADDR_BITS	32
 #define MAX_PHYSMEM_BITS	32
 
-#endif
-
 #endif /* __ASM_SH_SPARSEMEM_H */
diff --git a/arch/sh/include/asm/string_32.h b/arch/sh/include/asm/string_32.h
index 3558b1d7123e9c..778589e4a99dbb 100644
--- a/arch/sh/include/asm/string_32.h
+++ b/arch/sh/include/asm/string_32.h
@@ -2,8 +2,6 @@
 #ifndef __ASM_SH_STRING_H
 #define __ASM_SH_STRING_H
 
-#ifdef __KERNEL__
-
 /*
  * Copyright (C) 1999 Niibe Yutaka
  * But consider these trivial functions to be public domain.
@@ -127,6 +125,4 @@ extern void *memchr(const void *__s, int __c, size_t __n);
 #define __HAVE_ARCH_STRLEN
 extern size_t strlen(const char *);
 
-#endif /* __KERNEL__ */
-
 #endif /* __ASM_SH_STRING_H */
diff --git a/arch/sh/include/asm/syscalls_32.h b/arch/sh/include/asm/syscalls_32.h
index 9f9faf63b48c2e..5c555b864fe092 100644
--- a/arch/sh/include/asm/syscalls_32.h
+++ b/arch/sh/include/asm/syscalls_32.h
@@ -2,8 +2,6 @@
 #ifndef __ASM_SH_SYSCALLS_32_H
 #define __ASM_SH_SYSCALLS_32_H
 
-#ifdef __KERNEL__
-
 #include <linux/compiler.h>
 #include <linux/linkage.h>
 #include <linux/types.h>
@@ -26,5 +24,4 @@ asmlinkage void do_syscall_trace_leave(struct pt_regs *regs);
 asmlinkage void do_notify_resume(struct pt_regs *regs, unsigned int save_r0,
 				 unsigned long thread_info_flags);
 
-#endif /* __KERNEL__ */
 #endif /* __ASM_SH_SYSCALLS_32_H */
diff --git a/arch/sh/include/asm/thread_info.h b/arch/sh/include/asm/thread_info.h
index 6404be69d5fa6b..243ea5150aa00b 100644
--- a/arch/sh/include/asm/thread_info.h
+++ b/arch/sh/include/asm/thread_info.h
@@ -10,8 +10,6 @@
  *  Copyright (C) 2002  David Howells (dhowells@redhat.com)
  *  - Incorporating suggestions made by Linus Torvalds and Dave Miller
  */
-#ifdef __KERNEL__
-
 #include <asm/page.h>
 
 /*
@@ -170,7 +168,4 @@ static inline unsigned int get_thread_fault_code(void)
 }
 
 #endif	/* !__ASSEMBLY__ */
-
-#endif /* __KERNEL__ */
-
 #endif /* __ASM_SH_THREAD_INFO_H */
diff --git a/arch/sh/include/asm/watchdog.h b/arch/sh/include/asm/watchdog.h
index cecd0fc507f938..b9ca4c99f046a6 100644
--- a/arch/sh/include/asm/watchdog.h
+++ b/arch/sh/include/asm/watchdog.h
@@ -8,7 +8,6 @@
  */
 #ifndef __ASM_SH_WATCHDOG_H
 #define __ASM_SH_WATCHDOG_H
-#ifdef __KERNEL__
 
 #include <linux/types.h>
 #include <linux/io.h>
@@ -157,5 +156,4 @@ static inline void sh_wdt_write_csr(__u8 val)
 	__raw_writew((WTCSR_HIGH << 8) | (__u16)val, WTCSR);
 }
 #endif /* CONFIG_CPU_SUBTYPE_SH7785 || CONFIG_CPU_SUBTYPE_SH7780 */
-#endif /* __KERNEL__ */
 #endif /* __ASM_SH_WATCHDOG_H */
-- 
2.26.2

