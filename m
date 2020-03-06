Return-Path: <SRS0=glOU=4X=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 54988C10DCE
	for <linux-kernel@archiver.kernel.org>; Fri,  6 Mar 2020 17:32:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2CD802051A
	for <linux-kernel@archiver.kernel.org>; Fri,  6 Mar 2020 17:32:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726873AbgCFRcY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 6 Mar 2020 12:32:24 -0500
Received: from foss.arm.com ([217.140.110.172]:36820 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725873AbgCFRcX (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 6 Mar 2020 12:32:23 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 2D5AF30E;
        Fri,  6 Mar 2020 09:32:23 -0800 (PST)
Received: from e112269-lin.cambridge.arm.com (e112269-lin.cambridge.arm.com [10.1.195.32])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 62E113F6C4;
        Fri,  6 Mar 2020 09:32:22 -0800 (PST)
From:   Steven Price <steven.price@arm.com>
To:     Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Steven Price <steven.price@arm.com>
Subject: [PATCH] arm64: Map page table of linear map readonly
Date:   Fri,  6 Mar 2020 17:32:17 +0000
Message-Id: <20200306173217.44372-1-steven.price@arm.com>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

It's fairly rare that linear mappings need to be updated, so to improve
security we can map the leaf page table entries as read-only, this makes
it harder for an attacker to modify the permissions of the linear
mappings, while the overhead is low because the linear mappings don't
need to be changed frequently. When they do need to be updated we can
use fixmaps to create a temporary alternative mapping to do the update.

Signed-off-by: Steven Price <steven.price@arm.com>
---
 arch/arm64/Kconfig              |  9 ++++++++
 arch/arm64/include/asm/fixmap.h | 20 ++++++++++++++++-
 arch/arm64/mm/mmu.c             | 38 +++++++++++++++++++++++++++++++--
 arch/arm64/mm/pageattr.c        | 36 ++++++++++++++++++++++++++++++-
 4 files changed, 99 insertions(+), 4 deletions(-)

diff --git a/arch/arm64/Kconfig b/arch/arm64/Kconfig
index 0b30e884e088..00362e9b9934 100644
--- a/arch/arm64/Kconfig
+++ b/arch/arm64/Kconfig
@@ -1210,6 +1210,15 @@ config RODATA_FULL_DEFAULT_ENABLED
 	  This requires the linear region to be mapped down to pages,
 	  which may adversely affect performance in some cases.
 
+config LINEAR_PGTABLE_RO
+	bool "Apply r/o permissions to page tables of linear mapping"
+	help
+	  Apply read-only attributes to the page tables that make up the
+	  the linear mapping. This prevents the linear page tables from being
+	  inadvertently modified.
+
+	  This requires rodata=on (or RODATA_FULL_DEFAULT_ENABLED).
+
 config ARM64_SW_TTBR0_PAN
 	bool "Emulate Privileged Access Never using TTBR0_EL1 switching"
 	help
diff --git a/arch/arm64/include/asm/fixmap.h b/arch/arm64/include/asm/fixmap.h
index f987b8a8f325..55bf08151d73 100644
--- a/arch/arm64/include/asm/fixmap.h
+++ b/arch/arm64/include/asm/fixmap.h
@@ -67,6 +67,12 @@ enum fixed_addresses {
 	FIX_ENTRY_TRAMP_TEXT,
 #define TRAMP_VALIAS		(__fix_to_virt(FIX_ENTRY_TRAMP_TEXT))
 #endif /* CONFIG_UNMAP_KERNEL_AT_EL0 */
+
+#ifdef CONFIG_LINEAR_PGTABLE_RO
+	FIX_LINEAR_RO_BEGIN,
+	FIX_LINEAR_RO_END = FIX_LINEAR_RO_BEGIN + NR_CPUS - 1,
+#endif
+
 	__end_of_permanent_fixed_addresses,
 
 	/*
@@ -77,7 +83,15 @@ enum fixed_addresses {
 #define FIX_BTMAPS_SLOTS	7
 #define TOTAL_FIX_BTMAPS	(NR_FIX_BTMAPS * FIX_BTMAPS_SLOTS)
 
+#ifdef CONFIG_LINEAR_PGTABLE_RO
+	/*
+	 * Share the space with the LINEAR_RO area as during early boot, the
+	 * LINEAR_RO area isn't needed
+	 */
+	FIX_BTMAP_END = FIX_LINEAR_RO_BEGIN,
+#else
 	FIX_BTMAP_END = __end_of_permanent_fixed_addresses,
+#endif
 	FIX_BTMAP_BEGIN = FIX_BTMAP_END + TOTAL_FIX_BTMAPS - 1,
 
 	/*
@@ -89,9 +103,13 @@ enum fixed_addresses {
 	FIX_PUD,
 	FIX_PGD,
 
-	__end_of_fixed_addresses
+	___end_of_fixed_addresses
 };
 
+static const enum fixed_addresses __end_of_fixed_addresses =
+	___end_of_fixed_addresses > __end_of_permanent_fixed_addresses ?
+	___end_of_fixed_addresses : __end_of_permanent_fixed_addresses;
+
 #define FIXADDR_SIZE	(__end_of_permanent_fixed_addresses << PAGE_SHIFT)
 #define FIXADDR_START	(FIXADDR_TOP - FIXADDR_SIZE)
 
diff --git a/arch/arm64/mm/mmu.c b/arch/arm64/mm/mmu.c
index 128f70852bf3..9a2379b6179e 100644
--- a/arch/arm64/mm/mmu.c
+++ b/arch/arm64/mm/mmu.c
@@ -20,6 +20,7 @@
 #include <linux/fs.h>
 #include <linux/io.h>
 #include <linux/mm.h>
+#include <linux/pagewalk.h>
 #include <linux/vmalloc.h>
 
 #include <asm/barrier.h>
@@ -455,6 +456,34 @@ void __init mark_linear_text_alias_ro(void)
 			    PAGE_KERNEL_RO);
 }
 
+#ifdef CONFIG_LINEAR_PGTABLE_RO
+static int __init mark_linear_pmd_ro(pmd_t *pmd, unsigned long addr,
+				     unsigned long next, struct mm_walk *walk)
+{
+	phys_addr_t pmd_phys = pte_offset_phys(pmd, 0);
+
+	__map_memblock(walk->mm->pgd, pmd_phys, pmd_phys + PAGE_SIZE,
+		       PAGE_KERNEL_RO, NO_BLOCK_MAPPINGS | NO_CONT_MAPPINGS);
+
+	return 0;
+}
+
+static const struct mm_walk_ops mark_linear_pg_ro_ops __initconst = {
+	.pmd_entry = mark_linear_pmd_ro,
+};
+
+/*
+ * Remove the write permission from the leaf page tables of the linear map
+ */
+void __init mark_linear_pg_ro(void)
+{
+	down_read(&init_mm.mmap_sem);
+	walk_page_range_novma(&init_mm, PAGE_OFFSET, PAGE_END,
+			      &mark_linear_pg_ro_ops, init_mm.pgd, NULL);
+	up_read(&init_mm.mmap_sem);
+}
+#endif
+
 static void __init map_mem(pgd_t *pgdp)
 {
 	phys_addr_t kernel_start = __pa_symbol(_text);
@@ -502,7 +531,7 @@ static void __init map_mem(pgd_t *pgdp)
 	 * so we should avoid them here.
 	 */
 	__map_memblock(pgdp, kernel_start, kernel_end,
-		       PAGE_KERNEL, NO_CONT_MAPPINGS);
+		       PAGE_KERNEL, flags | NO_CONT_MAPPINGS);
 	memblock_clear_nomap(kernel_start, kernel_end - kernel_start);
 
 #ifdef CONFIG_KEXEC_CORE
@@ -678,6 +707,11 @@ void __init paging_init(void)
 	cpu_replace_ttbr1(lm_alias(swapper_pg_dir));
 	init_mm.pgd = swapper_pg_dir;
 
+#ifdef CONFIG_LINEAR_PGTABLE_RO
+	if (rodata_full)
+		mark_linear_pg_ro();
+#endif
+
 	memblock_free(__pa_symbol(init_pg_dir),
 		      __pa_symbol(init_pg_end) - __pa_symbol(init_pg_dir));
 
@@ -874,8 +908,8 @@ void __set_fixmap(enum fixed_addresses idx,
 		set_pte(ptep, pfn_pte(phys >> PAGE_SHIFT, flags));
 	} else {
 		pte_clear(&init_mm, addr, ptep);
-		flush_tlb_kernel_range(addr, addr+PAGE_SIZE);
 	}
+	flush_tlb_kernel_range(addr, addr + PAGE_SIZE);
 }
 
 void *__init fixmap_remap_fdt(phys_addr_t dt_phys, int *size, pgprot_t prot)
diff --git a/arch/arm64/mm/pageattr.c b/arch/arm64/mm/pageattr.c
index 250c49008d73..52d34c06656c 100644
--- a/arch/arm64/mm/pageattr.c
+++ b/arch/arm64/mm/pageattr.c
@@ -7,6 +7,7 @@
 #include <linux/module.h>
 #include <linux/sched.h>
 #include <linux/vmalloc.h>
+#include <linux/uaccess.h>
 
 #include <asm/pgtable.h>
 #include <asm/set_memory.h>
@@ -19,6 +20,33 @@ struct page_change_data {
 
 bool rodata_full __ro_after_init = IS_ENABLED(CONFIG_RODATA_FULL_DEFAULT_ENABLED);
 
+#ifdef CONFIG_LINEAR_PGTABLE_RO
+static void set_linear_pte_range(pte_t *ptep, pte_t pte)
+{
+	unsigned long flags;
+	unsigned int idx;
+	unsigned long addr;
+
+	local_irq_save(flags);
+	preempt_disable();
+
+	/* During early boot we use FIX_PTE as we don't need a per-CPU slot */
+	if (system_state < SYSTEM_SCHEDULING)
+		idx = FIX_PTE;
+	else
+		idx = FIX_LINEAR_RO_BEGIN + smp_processor_id();
+
+	addr = virt_to_phys(ptep);
+	set_fixmap(idx, addr);
+	ptep = (pte_t *)(__fix_to_virt(idx) + (addr & ~PAGE_MASK));
+	set_pte(ptep, pte);
+	clear_fixmap(idx);
+
+	preempt_enable();
+	local_irq_restore(flags);
+}
+#endif
+
 static int change_page_range(pte_t *ptep, unsigned long addr, void *data)
 {
 	struct page_change_data *cdata = data;
@@ -27,7 +55,13 @@ static int change_page_range(pte_t *ptep, unsigned long addr, void *data)
 	pte = clear_pte_bit(pte, cdata->clear_mask);
 	pte = set_pte_bit(pte, cdata->set_mask);
 
-	set_pte(ptep, pte);
+#ifdef CONFIG_LINEAR_PGTABLE_RO
+	if (addr >= PAGE_OFFSET)
+		set_linear_pte_range(ptep, pte);
+	else
+#endif
+		set_pte(ptep, pte);
+
 	return 0;
 }
 
-- 
2.20.1

