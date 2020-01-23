Return-Path: <SRS0=EowN=3M=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2F8FAC33CAF
	for <linux-kernel@archiver.kernel.org>; Thu, 23 Jan 2020 05:55:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0522D24125
	for <linux-kernel@archiver.kernel.org>; Thu, 23 Jan 2020 05:55:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726772AbgAWFzd (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 23 Jan 2020 00:55:33 -0500
Received: from foss.arm.com ([217.140.110.172]:35280 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725938AbgAWFzc (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Jan 2020 00:55:32 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id EE9FE1FB;
        Wed, 22 Jan 2020 21:55:31 -0800 (PST)
Received: from p8cg001049571a15.blr.arm.com (p8cg001049571a15.blr.arm.com [10.162.16.32])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 812B83F68E;
        Wed, 22 Jan 2020 21:55:28 -0800 (PST)
From:   Anshuman Khandual <anshuman.khandual@arm.com>
To:     linux-mm@kvack.org
Cc:     Anshuman Khandual <anshuman.khandual@arm.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Steve Capper <steve.capper@arm.com>,
        David Hildenbrand <david@redhat.com>,
        Yu Zhao <yuzhao@google.com>,
        Hsin-Yi Wang <hsinyi@chromium.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Andrew Morton <akpm@linux-foundation.org>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH 2/2] arm64/mm: Enable vmem_altmap support for vmemmap mappings
Date:   Thu, 23 Jan 2020 11:26:28 +0530
Message-Id: <1579758988-18520-3-git-send-email-anshuman.khandual@arm.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1579758988-18520-1-git-send-email-anshuman.khandual@arm.com>
References: <1579758988-18520-1-git-send-email-anshuman.khandual@arm.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Device memory ranges when getting hot added into ZONE_DEVICE, might require
their vmemmap mapping's backing memory to be allocated from their own range
instead of consuming system memory. This prevents large system memory usage
for potentially large device memory ranges. Device driver communicates this
request via vmem_altmap structure. Architecture needs to take this request
into account while creating and tearing down vemmmap mappings.

This enables vmem_altmap support in vmemmap_populate() and vmemmap_free()
which includes vmemmap_populate_basepages() used for ARM64_16K_PAGES and
ARM64_64K_PAGES configs.

Cc: Catalin Marinas <catalin.marinas@arm.com>
Cc: Will Deacon <will@kernel.org>
Cc: Mark Rutland <mark.rutland@arm.com>
Cc: Steve Capper <steve.capper@arm.com>
Cc: David Hildenbrand <david@redhat.com>
Cc: Yu Zhao <yuzhao@google.com>
Cc: Hsin-Yi Wang <hsinyi@chromium.org>
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: Andrew Morton <akpm@linux-foundation.org>
Cc: linux-arm-kernel@lists.infradead.org
Cc: linux-kernel@vger.kernel.org

Signed-off-by: Anshuman Khandual <anshuman.khandual@arm.com>
---
 arch/arm64/mm/mmu.c | 65 ++++++++++++++++++++++++++++++++-------------
 1 file changed, 47 insertions(+), 18 deletions(-)

diff --git a/arch/arm64/mm/mmu.c b/arch/arm64/mm/mmu.c
index 882698a716fb..ff69349ea5ec 100644
--- a/arch/arm64/mm/mmu.c
+++ b/arch/arm64/mm/mmu.c
@@ -727,15 +727,30 @@ int kern_addr_valid(unsigned long addr)
 }
 
 #ifdef CONFIG_MEMORY_HOTPLUG
-static void free_hotplug_page_range(struct page *page, size_t size)
+static void free_hotplug_page_range(struct page *page, size_t size,
+				    struct vmem_altmap *altmap)
 {
-	WARN_ON(PageReserved(page));
-	free_pages((unsigned long)page_address(page), get_order(size));
+	if (altmap) {
+		/*
+		 * Though unmap_hotplug_range() will tear down altmap based
+		 * vmemmap mappings at all page table levels, these mappings
+		 * should only have been created either at PTE or PMD level
+		 * with vmemmap_populate_basepages() or vmemmap_populate()
+		 * respectively. Unmapping requests at any other level will
+		 * be problematic. Drop these warnings when vmemmap mapping
+		 * is supported at PUD level.
+		 */
+		WARN_ON((size != PAGE_SIZE) && (size != PMD_SIZE));
+		vmem_altmap_free(altmap, size >> PAGE_SHIFT);
+	} else {
+		WARN_ON(PageReserved(page));
+		free_pages((unsigned long)page_address(page), get_order(size));
+	}
 }
 
 static void free_hotplug_pgtable_page(struct page *page)
 {
-	free_hotplug_page_range(page, PAGE_SIZE);
+	free_hotplug_page_range(page, PAGE_SIZE, NULL);
 }
 
 static bool pgtable_range_aligned(unsigned long start, unsigned long end,
@@ -758,7 +773,8 @@ static bool pgtable_range_aligned(unsigned long start, unsigned long end,
 }
 
 static void unmap_hotplug_pte_range(pmd_t *pmdp, unsigned long addr,
-				    unsigned long end, bool free_mapped)
+				    unsigned long end, bool free_mapped,
+				    struct vmem_altmap *altmap)
 {
 	pte_t *ptep, pte;
 
@@ -772,12 +788,14 @@ static void unmap_hotplug_pte_range(pmd_t *pmdp, unsigned long addr,
 		pte_clear(&init_mm, addr, ptep);
 		flush_tlb_kernel_range(addr, addr + PAGE_SIZE);
 		if (free_mapped)
-			free_hotplug_page_range(pte_page(pte), PAGE_SIZE);
+			free_hotplug_page_range(pte_page(pte),
+						PAGE_SIZE, altmap);
 	} while (addr += PAGE_SIZE, addr < end);
 }
 
 static void unmap_hotplug_pmd_range(pud_t *pudp, unsigned long addr,
-				    unsigned long end, bool free_mapped)
+				    unsigned long end, bool free_mapped,
+				    struct vmem_altmap *altmap)
 {
 	unsigned long next;
 	pmd_t *pmdp, pmd;
@@ -800,16 +818,17 @@ static void unmap_hotplug_pmd_range(pud_t *pudp, unsigned long addr,
 			flush_tlb_kernel_range(addr, addr + PAGE_SIZE);
 			if (free_mapped)
 				free_hotplug_page_range(pmd_page(pmd),
-							PMD_SIZE);
+							PMD_SIZE, altmap);
 			continue;
 		}
 		WARN_ON(!pmd_table(pmd));
-		unmap_hotplug_pte_range(pmdp, addr, next, free_mapped);
+		unmap_hotplug_pte_range(pmdp, addr, next, free_mapped, altmap);
 	} while (addr = next, addr < end);
 }
 
 static void unmap_hotplug_pud_range(pgd_t *pgdp, unsigned long addr,
-				    unsigned long end, bool free_mapped)
+				    unsigned long end, bool free_mapped,
+				    struct vmem_altmap *altmap)
 {
 	unsigned long next;
 	pud_t *pudp, pud;
@@ -832,20 +851,27 @@ static void unmap_hotplug_pud_range(pgd_t *pgdp, unsigned long addr,
 			flush_tlb_kernel_range(addr, addr + PAGE_SIZE);
 			if (free_mapped)
 				free_hotplug_page_range(pud_page(pud),
-							PUD_SIZE);
+							PUD_SIZE, altmap);
 			continue;
 		}
 		WARN_ON(!pud_table(pud));
-		unmap_hotplug_pmd_range(pudp, addr, next, free_mapped);
+		unmap_hotplug_pmd_range(pudp, addr, next, free_mapped, altmap);
 	} while (addr = next, addr < end);
 }
 
 static void unmap_hotplug_range(unsigned long addr, unsigned long end,
-				bool free_mapped)
+				bool free_mapped, struct vmem_altmap *altmap)
 {
 	unsigned long next;
 	pgd_t *pgdp, pgd;
 
+	/*
+	 * vmem_altmap can only be used as backing memory in a given
+	 * page table mapping. In case backing memory itself is not
+	 * being freed, then altmap is irrelevant. Warn about this
+	 * inconsistency when encountered.
+	 */
+	WARN_ON(!free_mapped && altmap);
 	do {
 		next = pgd_addr_end(addr, end);
 		pgdp = pgd_offset_k(addr);
@@ -854,7 +880,7 @@ static void unmap_hotplug_range(unsigned long addr, unsigned long end,
 			continue;
 
 		WARN_ON(!pgd_present(pgd));
-		unmap_hotplug_pud_range(pgdp, addr, next, free_mapped);
+		unmap_hotplug_pud_range(pgdp, addr, next, free_mapped, altmap);
 	} while (addr = next, addr < end);
 }
 
@@ -999,7 +1025,7 @@ static void free_empty_tables(unsigned long addr, unsigned long end,
 int __meminit vmemmap_populate(unsigned long start, unsigned long end, int node,
 		struct vmem_altmap *altmap)
 {
-	return vmemmap_populate_basepages(start, end, node, NULL);
+	return vmemmap_populate_basepages(start, end, node, altmap);
 }
 #else	/* !ARM64_SWAPPER_USES_SECTION_MAPS */
 int __meminit vmemmap_populate(unsigned long start, unsigned long end, int node,
@@ -1026,7 +1052,10 @@ int __meminit vmemmap_populate(unsigned long start, unsigned long end, int node,
 		if (pmd_none(READ_ONCE(*pmdp))) {
 			void *p = NULL;
 
-			p = vmemmap_alloc_block_buf(PMD_SIZE, node);
+			if (altmap)
+				p = altmap_alloc_block_buf(PMD_SIZE, altmap);
+			else
+				p = vmemmap_alloc_block_buf(PMD_SIZE, node);
 			if (!p)
 				return -ENOMEM;
 
@@ -1044,7 +1073,7 @@ void vmemmap_free(unsigned long start, unsigned long end,
 #ifdef CONFIG_MEMORY_HOTPLUG
 	WARN_ON((start < VMEMMAP_START) || (end > VMEMMAP_END));
 
-	unmap_hotplug_range(start, end, true);
+	unmap_hotplug_range(start, end, true, altmap);
 	free_empty_tables(start, end, VMEMMAP_START, VMEMMAP_END);
 #endif
 }
@@ -1332,7 +1361,7 @@ static void __remove_pgd_mapping(pgd_t *pgdir, unsigned long start, u64 size)
 	WARN_ON(pgdir != init_mm.pgd);
 	WARN_ON((start < PAGE_OFFSET) || (end > PAGE_END));
 
-	unmap_hotplug_range(start, end, false);
+	unmap_hotplug_range(start, end, false, NULL);
 	free_empty_tables(start, end, PAGE_OFFSET, PAGE_END);
 }
 
-- 
2.20.1

