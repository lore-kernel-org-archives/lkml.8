Return-Path: <SRS0=6o4L=5Q=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 07D6CC2D0F4
	for <linux-kernel@archiver.kernel.org>; Tue, 31 Mar 2020 09:50:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CC394208FE
	for <linux-kernel@archiver.kernel.org>; Tue, 31 Mar 2020 09:50:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730502AbgCaJuD (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 31 Mar 2020 05:50:03 -0400
Received: from 59-120-53-16.HINET-IP.hinet.net ([59.120.53.16]:14592 "EHLO
        ATCSQR.andestech.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1730430AbgCaJt7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 31 Mar 2020 05:49:59 -0400
Received: from ATCSQR.andestech.com (localhost [127.0.0.2] (may be forged))
        by ATCSQR.andestech.com with ESMTP id 02V9bYm1066402
        for <linux-kernel@vger.kernel.org>; Tue, 31 Mar 2020 17:37:34 +0800 (GMT-8)
        (envelope-from tesheng@andestech.com)
Received: from mail.andestech.com (atcpcs16.andestech.com [10.0.1.222])
        by ATCSQR.andestech.com with ESMTP id 02V9WGga065487;
        Tue, 31 Mar 2020 17:32:16 +0800 (GMT-8)
        (envelope-from tesheng@andestech.com)
Received: from atcsqa06.andestech.com (10.0.15.65) by ATCPCS16.andestech.com
 (10.0.1.222) with Microsoft SMTP Server id 14.3.123.3; Tue, 31 Mar 2020
 17:33:08 +0800
From:   Eric Lin <tesheng@andestech.com>
To:     <linux-riscv@lists.infradead.org>
CC:     <linux-kernel@vger.kernel.org>, <paul.walmsley@sifive.com>,
        <palmer@dabbelt.com>, <aou@eecs.berkeley.edu>,
        <green.hu@gmail.com>, <Anup.Patel@wdc.com>,
        <akpm@linux-foundation.org>, <logang@deltatee.com>,
        <david.abdurachmanov@gmail.com>, <atish.patra@wdc.com>,
        <tglx@linutronix.de>, <bp@suse.de>, <yash.shah@sifive.com>,
        <alex@ghiti.fr>, <zong.li@sifive.com>, <gary@garyguo.net>,
        <rppt@linux.ibm.com>, <steven.price@arm.com>,
        Eric Lin <tesheng@andestech.com>,
        Alan Kao <alankao@andestech.com>
Subject: [PATCH 2/3] riscv/mm: Implement kmap() and kmap_atomic()
Date:   Tue, 31 Mar 2020 17:32:40 +0800
Message-ID: <20200331093241.3728-3-tesheng@andestech.com>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20200331093241.3728-1-tesheng@andestech.com>
References: <20200331093241.3728-1-tesheng@andestech.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.0.15.65]
X-DNSRBL: 
X-MAIL: ATCSQR.andestech.com 02V9WGga065487
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Both kmap() and kmap_atomic() help kernel to create
temporary mappings from a highmem page.

Be aware that use kmap() might put calling function to sleep
and it cannot use in interrupt context. kmap_atomic() is an
atomic version of kmap() which can be used in interrupt context
and it is faster than kmap() because it doesn't hold a lock.

Here we preserve some memory slots from fixmap region for
kmap_atomic() and kmap() will use pkmap region.

Signed-off-by: Eric Lin <tesheng@andestech.com>
Cc: Alan Kao <alankao@andestech.com>
---
 arch/riscv/include/asm/fixmap.h  |  9 +++-
 arch/riscv/include/asm/highmem.h | 30 +++++++++++++
 arch/riscv/include/asm/pgtable.h |  5 +++
 arch/riscv/mm/Makefile           |  1 +
 arch/riscv/mm/highmem.c          | 74 ++++++++++++++++++++++++++++++++
 5 files changed, 118 insertions(+), 1 deletion(-)
 create mode 100644 arch/riscv/mm/highmem.c

diff --git a/arch/riscv/include/asm/fixmap.h b/arch/riscv/include/asm/fixmap.h
index 42d2c42f3cc9..8dedc2bf2917 100644
--- a/arch/riscv/include/asm/fixmap.h
+++ b/arch/riscv/include/asm/fixmap.h
@@ -1,6 +1,7 @@
 /* SPDX-License-Identifier: GPL-2.0 */
 /*
  * Copyright (C) 2019 Western Digital Corporation or its affiliates.
+ * Copyright (C) 2020 Andes Technology Corporation
  */
 
 #ifndef _ASM_RISCV_FIXMAP_H
@@ -10,6 +11,7 @@
 #include <linux/sizes.h>
 #include <asm/page.h>
 #include <asm/pgtable.h>
+#include <asm/kmap_types.h>
 
 #ifdef CONFIG_MMU
 /*
@@ -28,7 +30,12 @@ enum fixed_addresses {
 	FIX_PTE,
 	FIX_PMD,
 	FIX_EARLYCON_MEM_BASE,
-	__end_of_fixed_addresses
+#ifdef CONFIG_HIGHMEM
+	FIX_KMAP_RESERVED,
+	FIX_KMAP_BEGIN,
+	FIX_KMAP_END = FIX_KMAP_BEGIN + (KM_TYPE_NR * NR_CPUS),
+#endif
+	__end_of_fixed_addresses,
 };
 
 #define FIXMAP_PAGE_IO		PAGE_KERNEL
diff --git a/arch/riscv/include/asm/highmem.h b/arch/riscv/include/asm/highmem.h
index 7fc79e58f607..ec7c83d55830 100644
--- a/arch/riscv/include/asm/highmem.h
+++ b/arch/riscv/include/asm/highmem.h
@@ -17,3 +17,33 @@
 #define PKMAP_NR(virt)	(((virt) - (PKMAP_BASE)) >> PAGE_SHIFT)
 #define PKMAP_ADDR(nr)	(PKMAP_BASE + ((nr) << PAGE_SHIFT))
 #define kmap_prot		PAGE_KERNEL
+
+static inline void flush_cache_kmaps(void)
+{
+	flush_cache_all();
+}
+
+/* Declarations for highmem.c */
+extern unsigned long highstart_pfn, highend_pfn;
+
+extern pte_t *pkmap_page_table;
+
+extern void *kmap_high(struct page *page);
+extern void kunmap_high(struct page *page);
+
+extern void kmap_init(void);
+
+/*
+ * The following functions are already defined by <linux/highmem.h>
+ * when CONFIG_HIGHMEM is not set.
+ */
+#ifdef CONFIG_HIGHMEM
+extern void *kmap(struct page *page);
+extern void kunmap(struct page *page);
+extern void *kmap_atomic(struct page *page);
+extern void __kunmap_atomic(void *kvaddr);
+extern void *kmap_atomic_pfn(unsigned long pfn);
+extern struct page *kmap_atomic_to_page(void *ptr);
+#endif
+
+#endif
diff --git a/arch/riscv/include/asm/pgtable.h b/arch/riscv/include/asm/pgtable.h
index d9a3769f1f4e..1a774d5a8bbc 100644
--- a/arch/riscv/include/asm/pgtable.h
+++ b/arch/riscv/include/asm/pgtable.h
@@ -200,6 +200,11 @@ static inline pgd_t *pgd_offset(const struct mm_struct *mm, unsigned long addr)
 /* Locate an entry in the kernel page global directory */
 #define pgd_offset_k(addr)      pgd_offset(&init_mm, (addr))
 
+#ifdef CONFIG_HIGHMEM
+/* Locate an entry in the second-level page table */
+#define pmd_off_k(addr)  pmd_offset((pud_t *)pgd_offset_k(addr), addr)
+#endif
+
 static inline struct page *pmd_page(pmd_t pmd)
 {
 	return pfn_to_page(pmd_val(pmd) >> _PAGE_PFN_SHIFT);
diff --git a/arch/riscv/mm/Makefile b/arch/riscv/mm/Makefile
index 50b7af58c566..6f9305afc632 100644
--- a/arch/riscv/mm/Makefile
+++ b/arch/riscv/mm/Makefile
@@ -16,6 +16,7 @@ obj-$(CONFIG_SMP) += tlbflush.o
 endif
 obj-$(CONFIG_HUGETLB_PAGE) += hugetlbpage.o
 obj-$(CONFIG_KASAN)   += kasan_init.o
+obj-$(CONFIG_HIGHMEM) += highmem.o
 
 ifdef CONFIG_KASAN
 KASAN_SANITIZE_kasan_init.o := n
diff --git a/arch/riscv/mm/highmem.c b/arch/riscv/mm/highmem.c
new file mode 100644
index 000000000000..b01ebe34619e
--- /dev/null
+++ b/arch/riscv/mm/highmem.c
@@ -0,0 +1,74 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * Copyright (C) 2005-2020 Andes Technology Corporation
+ */
+
+#include <linux/export.h>
+#include <linux/highmem.h>
+#include <linux/sched.h>
+#include <linux/smp.h>
+#include <linux/interrupt.h>
+#include <asm/fixmap.h>
+#include <asm/pgtable.h>
+#include <asm/tlbflush.h>
+
+void *kmap(struct page *page)
+{
+	unsigned long vaddr;
+
+	might_sleep();
+	if (!PageHighMem(page))
+		return page_address(page);
+	vaddr = (unsigned long)kmap_high(page);
+	return (void *)vaddr;
+}
+EXPORT_SYMBOL(kmap);
+
+void kunmap(struct page *page)
+{
+	BUG_ON(in_interrupt());
+	if (!PageHighMem(page))
+		return;
+	kunmap_high(page);
+}
+EXPORT_SYMBOL(kunmap);
+
+void *kmap_atomic(struct page *page)
+{
+	unsigned int idx;
+	unsigned long vaddr;
+	int type;
+	pte_t *ptep;
+
+	preempt_disable();
+	pagefault_disable();
+
+	if (!PageHighMem(page))
+		return page_address(page);
+
+	type = kmap_atomic_idx_push();
+
+	idx = type + KM_TYPE_NR * smp_processor_id();
+	vaddr = __fix_to_virt(FIX_KMAP_BEGIN + idx);
+
+	ptep = pte_offset_kernel(pmd_off_k(vaddr), vaddr);
+	set_pte(ptep, mk_pte(page, kmap_prot));
+
+	return (void *)vaddr;
+}
+EXPORT_SYMBOL(kmap_atomic);
+
+void __kunmap_atomic(void *kvaddr)
+{
+	if (kvaddr >= (void *)FIXADDR_START && kvaddr < (void *)FIXADDR_TOP) {
+		unsigned long vaddr = (unsigned long)kvaddr;
+		pte_t *ptep;
+
+		kmap_atomic_idx_pop();
+		ptep = pte_offset_kernel(pmd_off_k(vaddr), vaddr);
+		set_pte(ptep, __pte(0));
+	}
+	pagefault_enable();
+	preempt_enable();
+}
+EXPORT_SYMBOL(__kunmap_atomic);
-- 
2.17.0

