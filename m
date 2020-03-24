Return-Path: <SRS0=tn8d=5J=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B7255C41621
	for <linux-kernel@archiver.kernel.org>; Tue, 24 Mar 2020 16:26:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7FE1E20788
	for <linux-kernel@archiver.kernel.org>; Tue, 24 Mar 2020 16:26:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="iW209ec4"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728794AbgCXQ0s (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 24 Mar 2020 12:26:48 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:59570 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728766AbgCXQ0r (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 Mar 2020 12:26:47 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=Content-Transfer-Encoding:
        MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender
        :Reply-To:Content-Type:Content-ID:Content-Description;
        bh=Ih4/ByJTX4E+YrWPhWRj3NvIC+f0+8UmAcjGFn1gi/g=; b=iW209ec4r1EqIMkauz+vJv8W1F
        t9tna/045RSvo6Erv52W85Ywouotk13yvP6q0f1AVPNdEil+8YHf5WeKwaMLUWlO6+41ocsXPm7QE
        jQ37oNJB6GyeHga9XuBqUHVLWCZDXoBZw5rNzNu3hwwDdn8ZlpxynVPYC18KHSka6EAKHEV4AYwmP
        QP9N/4k/tWIoG/6q7I3C0TMbKSZIAfbA8IfMthdzqBzLU3NVQzDnvkLBNz6qOrLr+cReYgOSYfBH0
        7P9yl0vnnAEDZnxScr+13xeziZasAM6pLJ17WvxjgF1eJEBR+DOc59x/SG6ArjJxHytlIU8+bUndW
        hkMsIVhA==;
Received: from [2001:4bb8:18c:2a9e:999c:283e:b14a:9189] (helo=localhost)
        by bombadil.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1jGmO2-0007cc-2j; Tue, 24 Mar 2020 16:26:42 +0000
From:   Christoph Hellwig <hch@lst.de>
To:     Yoshinori Sato <ysato@users.sourceforge.jp>,
        Rich Felker <dalias@libc.org>
Cc:     linux-sh@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH 03/10] sh: remove __KERNEL__ ifdefs from non-UAPI headers
Date:   Tue, 24 Mar 2020 17:26:26 +0100
Message-Id: <20200324162633.754714-4-hch@lst.de>
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
 arch/sh/include/asm/string_64.h    | 4 ----
 arch/sh/include/asm/syscalls.h     | 3 ---
 arch/sh/include/asm/syscalls_32.h  | 3 ---
 arch/sh/include/asm/syscalls_64.h  | 3 ---
 arch/sh/include/asm/thread_info.h  | 5 -----
 arch/sh/include/asm/watchdog.h     | 2 --
 22 files changed, 64 deletions(-)

diff --git a/arch/sh/include/asm/adc.h b/arch/sh/include/asm/adc.h
index 99ec66849559..feccfe639e38 100644
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
index 34bfbcddcce0..468fba333e89 100644
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
index 8c3578288db5..0e7a1d9616ab 100644
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
@@ -97,6 +95,4 @@ static inline unsigned long ffz(unsigned long word)
 #include <asm-generic/bitops/__fls.h>
 #include <asm-generic/bitops/fls64.h>
 
-#endif /* __KERNEL__ */
-
 #endif /* __ASM_SH_BITOPS_H */
diff --git a/arch/sh/include/asm/cache.h b/arch/sh/include/asm/cache.h
index 2408ac4873aa..a293343456af 100644
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
index b932e42ef028..f509d3ede39c 100644
--- a/arch/sh/include/asm/cacheflush.h
+++ b/arch/sh/include/asm/cacheflush.h
@@ -2,8 +2,6 @@
 #ifndef __ASM_SH_CACHEFLUSH_H
 #define __ASM_SH_CACHEFLUSH_H
 
-#ifdef __KERNEL__
-
 #include <linux/mm.h>
 
 /*
@@ -108,5 +106,4 @@ static inline void *sh_cacheop_vaddr(void *vaddr)
 	return vaddr;
 }
 
-#endif /* __KERNEL__ */
 #endif /* __ASM_SH_CACHEFLUSH_H */
diff --git a/arch/sh/include/asm/dma.h b/arch/sh/include/asm/dma.h
index 4d5a21a891c0..17d23ae98c77 100644
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
index 5ec8db1ddc20..a033f0c32c91 100644
--- a/arch/sh/include/asm/elf.h
+++ b/arch/sh/include/asm/elf.h
@@ -90,7 +90,6 @@ typedef struct user_fpu_struct elf_fpregset_t;
 #endif
 #define ELF_ARCH	EM_SH
 
-#ifdef __KERNEL__
 /*
  * This is used to ensure we don't load something for the wrong architecture.
  */
@@ -232,5 +231,4 @@ do {								\
 	NEW_AUX_ENT(AT_L2_CACHESHAPE, l2_cache_shape);		\
 } while (0)
 
-#endif /* __KERNEL__ */
 #endif /* __ASM_SH_ELF_H */
diff --git a/arch/sh/include/asm/freq.h b/arch/sh/include/asm/freq.h
index 18133bf83738..87c23621b7ae 100644
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
index 3190ec89df81..9fb58252d915 100644
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
@@ -75,5 +73,4 @@ static inline int arch_futex_atomic_op_inuser(int op, u32 oparg, int *oval,
 	return ret;
 }
 
-#endif /* __KERNEL__ */
 #endif /* __ASM_SH_FUTEX_H */
diff --git a/arch/sh/include/asm/io.h b/arch/sh/include/asm/io.h
index 39c9ead489e5..5154c6b8c618 100644
--- a/arch/sh/include/asm/io.h
+++ b/arch/sh/include/asm/io.h
@@ -20,7 +20,6 @@
 #include <asm/pgtable.h>
 #include <asm-generic/iomap.h>
 
-#ifdef __KERNEL__
 #define __IO_PREFIX     generic
 #include <asm/io_generic.h>
 #include <asm/io_trapped.h>
@@ -384,6 +383,4 @@ static inline int iounmap_fixed(void __iomem *addr) { return -EINVAL; }
 int valid_phys_addr_range(phys_addr_t addr, size_t size);
 int valid_mmap_phys_addr_range(unsigned long pfn, size_t size);
 
-#endif /* __KERNEL__ */
-
 #endif /* __ASM_SH_IO_H */
diff --git a/arch/sh/include/asm/mmu_context.h b/arch/sh/include/asm/mmu_context.h
index 2d09650093c7..070f5a42dd00 100644
--- a/arch/sh/include/asm/mmu_context.h
+++ b/arch/sh/include/asm/mmu_context.h
@@ -8,7 +8,6 @@
 #ifndef __ASM_SH_MMU_CONTEXT_H
 #define __ASM_SH_MMU_CONTEXT_H
 
-#ifdef __KERNEL__
 #include <cpu/mmu_context.h>
 #include <asm/tlbflush.h>
 #include <linux/uaccess.h>
@@ -189,5 +188,4 @@ static inline void disable_mmu(void)
 #define disable_mmu()	do { } while (0)
 #endif
 
-#endif /* __KERNEL__ */
 #endif /* __ASM_SH_MMU_CONTEXT_H */
diff --git a/arch/sh/include/asm/mmzone.h b/arch/sh/include/asm/mmzone.h
index cbaee1d1b673..6552a088dc97 100644
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
index 10a36b1cf2ea..ad22e88c6657 100644
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
index 0e0ecc0132e3..fa9e1a67dadf 100644
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
index 4eb899751e45..ed287c4980bc 100644
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
index 3558b1d7123e..778589e4a99d 100644
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
diff --git a/arch/sh/include/asm/string_64.h b/arch/sh/include/asm/string_64.h
index d51d6150a4e2..3746f46633ca 100644
--- a/arch/sh/include/asm/string_64.h
+++ b/arch/sh/include/asm/string_64.h
@@ -2,8 +2,6 @@
 #ifndef __ASM_SH_STRING_64_H
 #define __ASM_SH_STRING_64_H
 
-#ifdef __KERNEL__
-
 #define __HAVE_ARCH_MEMSET
 extern void *memset(void *__s, int __c, size_t __count);
 
@@ -16,6 +14,4 @@ extern size_t strlen(const char *);
 #define __HAVE_ARCH_STRCPY
 extern char *strcpy(char *__dest, const char *__src);
 
-#endif /* __KERNEL__ */
-
 #endif /* __ASM_SH_STRING_64_H */
diff --git a/arch/sh/include/asm/syscalls.h b/arch/sh/include/asm/syscalls.h
index 995ef046232c..74f9de3f9ba3 100644
--- a/arch/sh/include/asm/syscalls.h
+++ b/arch/sh/include/asm/syscalls.h
@@ -2,8 +2,6 @@
 #ifndef __ASM_SH_SYSCALLS_H
 #define __ASM_SH_SYSCALLS_H
 
-#ifdef __KERNEL__
-
 asmlinkage int old_mmap(unsigned long addr, unsigned long len,
 			unsigned long prot, unsigned long flags,
 			int fd, unsigned long off);
@@ -17,5 +15,4 @@ asmlinkage long sys_mmap2(unsigned long addr, unsigned long len,
 # include <asm/syscalls_64.h>
 #endif
 
-#endif /* __KERNEL__ */
 #endif /* __ASM_SH_SYSCALLS_H */
diff --git a/arch/sh/include/asm/syscalls_32.h b/arch/sh/include/asm/syscalls_32.h
index 9f9faf63b48c..5c555b864fe0 100644
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
diff --git a/arch/sh/include/asm/syscalls_64.h b/arch/sh/include/asm/syscalls_64.h
index df42656cebea..2e65fad46dc9 100644
--- a/arch/sh/include/asm/syscalls_64.h
+++ b/arch/sh/include/asm/syscalls_64.h
@@ -2,8 +2,6 @@
 #ifndef __ASM_SH_SYSCALLS_64_H
 #define __ASM_SH_SYSCALLS_64_H
 
-#ifdef __KERNEL__
-
 #include <linux/compiler.h>
 #include <linux/linkage.h>
 #include <linux/types.h>
@@ -14,5 +12,4 @@ struct pt_regs;
 asmlinkage long long do_syscall_trace_enter(struct pt_regs *regs);
 asmlinkage void do_syscall_trace_leave(struct pt_regs *regs);
 
-#endif /* __KERNEL__ */
 #endif /* __ASM_SH_SYSCALLS_64_H */
diff --git a/arch/sh/include/asm/thread_info.h b/arch/sh/include/asm/thread_info.h
index cf5c792bf70b..82b2e3d779b7 100644
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
@@ -172,7 +170,4 @@ static inline unsigned int get_thread_fault_code(void)
 }
 
 #endif	/* !__ASSEMBLY__ */
-
-#endif /* __KERNEL__ */
-
 #endif /* __ASM_SH_THREAD_INFO_H */
diff --git a/arch/sh/include/asm/watchdog.h b/arch/sh/include/asm/watchdog.h
index cecd0fc507f9..b9ca4c99f046 100644
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
2.25.1

