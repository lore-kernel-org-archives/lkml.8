Return-Path: <SRS0=eGSO=AR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3FC9BC433DF
	for <linux-kernel@archiver.kernel.org>; Mon,  6 Jul 2020 02:57:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 27EAD20747
	for <linux-kernel@archiver.kernel.org>; Mon,  6 Jul 2020 02:57:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728727AbgGFC5N (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 5 Jul 2020 22:57:13 -0400
Received: from foss.arm.com ([217.140.110.172]:52796 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728632AbgGFC5M (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 5 Jul 2020 22:57:12 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 72752C0A;
        Sun,  5 Jul 2020 19:57:11 -0700 (PDT)
Received: from p8cg001049571a15.arm.com (unknown [10.163.84.195])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 24CE73F71E;
        Sun,  5 Jul 2020 19:57:06 -0700 (PDT)
From:   Anshuman Khandual <anshuman.khandual@arm.com>
To:     linux-mm@kvack.org
Cc:     justin.he@arm.com, catalin.marinas@arm.com,
        akpm@linux-foundation.org,
        Anshuman Khandual <anshuman.khandual@arm.com>,
        Will Deacon <will@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Steve Capper <steve.capper@arm.com>,
        David Hildenbrand <david@redhat.com>,
        Yu Zhao <yuzhao@google.com>,
        Hsin-Yi Wang <hsinyi@chromium.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH V4 3/3] arm64/mm: Enable vmem_altmap support for vmemmap mappings
Date:   Mon,  6 Jul 2020 08:26:18 +0530
Message-Id: <1594004178-8861-4-git-send-email-anshuman.khandual@arm.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1594004178-8861-1-git-send-email-anshuman.khandual@arm.com>
References: <1594004178-8861-1-git-send-email-anshuman.khandual@arm.com>
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
Tested-by: Jia He <justin.he@arm.com>
Reviewed-by: Catalin Marinas <catalin.marinas@arm.com>
Signed-off-by: Anshuman Khandual <anshuman.khandual@arm.com>
---
 arch/arm64/mm/mmu.c | 58 +++++++++++++++++++++++++++++----------------
 1 file changed, 38 insertions(+), 20 deletions(-)

diff --git a/arch/arm64/mm/mmu.c b/arch/arm64/mm/mmu.c
index 9c08d1882106..51a1b0e886ff 100644
--- a/arch/arm64/mm/mmu.c
+++ b/arch/arm64/mm/mmu.c
@@ -760,15 +760,20 @@ int kern_addr_valid(unsigned long addr)
 }
 
 #ifdef CONFIG_MEMORY_HOTPLUG
-static void free_hotplug_page_range(struct page *page, size_t size)
+static void free_hotplug_page_range(struct page *page, size_t size,
+				    struct vmem_altmap *altmap)
 {
-	WARN_ON(PageReserved(page));
-	free_pages((unsigned long)page_address(page), get_order(size));
+	if (altmap) {
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
@@ -791,7 +796,8 @@ static bool pgtable_range_aligned(unsigned long start, unsigned long end,
 }
 
 static void unmap_hotplug_pte_range(pmd_t *pmdp, unsigned long addr,
-				    unsigned long end, bool free_mapped)
+				    unsigned long end, bool free_mapped,
+				    struct vmem_altmap *altmap)
 {
 	pte_t *ptep, pte;
 
@@ -805,12 +811,14 @@ static void unmap_hotplug_pte_range(pmd_t *pmdp, unsigned long addr,
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
@@ -833,16 +841,17 @@ static void unmap_hotplug_pmd_range(pud_t *pudp, unsigned long addr,
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
 
 static void unmap_hotplug_pud_range(p4d_t *p4dp, unsigned long addr,
-				    unsigned long end, bool free_mapped)
+				    unsigned long end, bool free_mapped,
+				    struct vmem_altmap *altmap)
 {
 	unsigned long next;
 	pud_t *pudp, pud;
@@ -865,16 +874,17 @@ static void unmap_hotplug_pud_range(p4d_t *p4dp, unsigned long addr,
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
 
 static void unmap_hotplug_p4d_range(pgd_t *pgdp, unsigned long addr,
-				    unsigned long end, bool free_mapped)
+				    unsigned long end, bool free_mapped,
+				    struct vmem_altmap *altmap)
 {
 	unsigned long next;
 	p4d_t *p4dp, p4d;
@@ -887,16 +897,24 @@ static void unmap_hotplug_p4d_range(pgd_t *pgdp, unsigned long addr,
 			continue;
 
 		WARN_ON(!p4d_present(p4d));
-		unmap_hotplug_pud_range(p4dp, addr, next, free_mapped);
+		unmap_hotplug_pud_range(p4dp, addr, next, free_mapped, altmap);
 	} while (addr = next, addr < end);
 }
 
 static void unmap_hotplug_range(unsigned long addr, unsigned long end,
-				bool free_mapped)
+				bool free_mapped, struct vmem_altmap *altmap)
 {
 	unsigned long next;
 	pgd_t *pgdp, pgd;
 
+	/*
+	 * altmap can only be used as vmemmap mapping backing memory.
+	 * In case the backing memory itself is not being freed, then
+	 * altmap is irrelevant. Warn about this inconsistency when
+	 * encountered.
+	 */
+	WARN_ON(!free_mapped && altmap);
+
 	do {
 		next = pgd_addr_end(addr, end);
 		pgdp = pgd_offset_k(addr);
@@ -905,7 +923,7 @@ static void unmap_hotplug_range(unsigned long addr, unsigned long end,
 			continue;
 
 		WARN_ON(!pgd_present(pgd));
-		unmap_hotplug_p4d_range(pgdp, addr, next, free_mapped);
+		unmap_hotplug_p4d_range(pgdp, addr, next, free_mapped, altmap);
 	} while (addr = next, addr < end);
 }
 
@@ -1069,7 +1087,7 @@ static void free_empty_tables(unsigned long addr, unsigned long end,
 int __meminit vmemmap_populate(unsigned long start, unsigned long end, int node,
 		struct vmem_altmap *altmap)
 {
-	return vmemmap_populate_basepages(start, end, node, NULL);
+	return vmemmap_populate_basepages(start, end, node, altmap);
 }
 #else	/* !ARM64_SWAPPER_USES_SECTION_MAPS */
 int __meminit vmemmap_populate(unsigned long start, unsigned long end, int node,
@@ -1101,7 +1119,7 @@ int __meminit vmemmap_populate(unsigned long start, unsigned long end, int node,
 		if (pmd_none(READ_ONCE(*pmdp))) {
 			void *p = NULL;
 
-			p = vmemmap_alloc_block_buf(PMD_SIZE, node, NULL);
+			p = vmemmap_alloc_block_buf(PMD_SIZE, node, altmap);
 			if (!p)
 				return -ENOMEM;
 
@@ -1119,7 +1137,7 @@ void vmemmap_free(unsigned long start, unsigned long end,
 #ifdef CONFIG_MEMORY_HOTPLUG
 	WARN_ON((start < VMEMMAP_START) || (end > VMEMMAP_END));
 
-	unmap_hotplug_range(start, end, true);
+	unmap_hotplug_range(start, end, true, altmap);
 	free_empty_tables(start, end, VMEMMAP_START, VMEMMAP_END);
 #endif
 }
@@ -1410,7 +1428,7 @@ static void __remove_pgd_mapping(pgd_t *pgdir, unsigned long start, u64 size)
 	WARN_ON(pgdir != init_mm.pgd);
 	WARN_ON((start < PAGE_OFFSET) || (end > PAGE_END));
 
-	unmap_hotplug_range(start, end, false);
+	unmap_hotplug_range(start, end, false, NULL);
 	free_empty_tables(start, end, PAGE_OFFSET, PAGE_END);
 }
 
-- 
2.20.1

