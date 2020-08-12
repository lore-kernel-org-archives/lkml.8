Return-Path: <SRS0=ZArZ=BW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.0 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A5DAAC433E0
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Aug 2020 01:07:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 90443206F2
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Aug 2020 01:07:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726506AbgHLBHO (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 11 Aug 2020 21:07:14 -0400
Received: from szxga06-in.huawei.com ([45.249.212.32]:44942 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726420AbgHLBHN (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Aug 2020 21:07:13 -0400
Received: from DGGEMS408-HUB.china.huawei.com (unknown [172.30.72.60])
        by Forcepoint Email with ESMTP id B4164D85BC53D551978D;
        Wed, 12 Aug 2020 09:07:06 +0800 (CST)
Received: from vm107-89-192.huawei.com (100.107.89.192) by
 DGGEMS408-HUB.china.huawei.com (10.3.19.208) with Microsoft SMTP Server id
 14.3.487.0; Wed, 12 Aug 2020 09:06:56 +0800
From:   Wei Li <liwei213@huawei.com>
To:     <catalin.marinas@arm.com>, <will@kernel.org>
CC:     <liwei213@huawei.com>, <saberlily.xia@hisilicon.com>,
        <puck.chen@hisilicon.com>, <butao@hisilicon.com>,
        <fengbaopeng2@hisilicon.com>, <nsaenzjulienne@suse.de>,
        <steve.capper@arm.com>, <rppt@linux.ibm.com>,
        <song.bao.hua@hisilicon.com>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, <sujunfei2@hisilicon.com>
Subject: [PATCH v2] arm64: mm: free unused memmap for sparse memory model that define VMEMMAP
Date:   Wed, 12 Aug 2020 09:06:55 +0800
Message-ID: <20200812010655.96339-1-liwei213@huawei.com>
X-Mailer: git-send-email 2.15.0
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [100.107.89.192]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

For the memory hole, sparse memory model that define SPARSEMEM_VMEMMAP
do not free the reserved memory for the page map, this patch do it.

Signed-off-by: Wei Li <liwei213@huawei.com>
Signed-off-by: Chen Feng <puck.chen@hisilicon.com>
Signed-off-by: Xia Qing <saberlily.xia@hisilicon.com>

v2: fix the patch v1 compile errors that are not based on the latest mainline.
---
 arch/arm64/mm/init.c | 81 +++++++++++++++++++++++++++++++++++++++++++++-------
 1 file changed, 71 insertions(+), 10 deletions(-)

diff --git a/arch/arm64/mm/init.c b/arch/arm64/mm/init.c
index 1e93cfc7c47a..600889945cd0 100644
--- a/arch/arm64/mm/init.c
+++ b/arch/arm64/mm/init.c
@@ -441,7 +441,48 @@ void __init bootmem_init(void)
 	memblock_dump_all();
 }

-#ifndef CONFIG_SPARSEMEM_VMEMMAP
+#ifdef CONFIG_SPARSEMEM_VMEMMAP
+#define VMEMMAP_PAGE_INUSE 0xFD
+static inline void free_memmap(unsigned long start_pfn, unsigned long end_pfn)
+{
+	unsigned long addr, end;
+	unsigned long next;
+	pmd_t *pmd;
+	void *page_addr;
+	phys_addr_t phys_addr;
+
+	addr = (unsigned long)pfn_to_page(start_pfn);
+	end = (unsigned long)pfn_to_page(end_pfn);
+
+	pmd = pmd_off_k(addr);
+	for (; addr < end; addr = next, pmd++) {
+		next = pmd_addr_end(addr, end);
+
+		if (!pmd_present(*pmd))
+			continue;
+
+		if (IS_ALIGNED(addr, PMD_SIZE) &&
+			IS_ALIGNED(next, PMD_SIZE)) {
+			phys_addr = __pfn_to_phys(pmd_pfn(*pmd));
+			memblock_free(phys_addr, PMD_SIZE);
+			pmd_clear(pmd);
+		} else {
+			/* If here, we are freeing vmemmap pages. */
+			memset((void *)addr, VMEMMAP_PAGE_INUSE, next - addr);
+			page_addr = page_address(pmd_page(*pmd));
+
+			if (!memchr_inv(page_addr, VMEMMAP_PAGE_INUSE,
+				PMD_SIZE)) {
+				phys_addr = __pfn_to_phys(pmd_pfn(*pmd));
+				memblock_free(phys_addr, PMD_SIZE);
+				pmd_clear(pmd);
+			}
+		}
+	}
+
+	flush_tlb_all();
+}
+#else
 static inline void free_memmap(unsigned long start_pfn, unsigned long end_pfn)
 {
 	struct page *start_pg, *end_pg;
@@ -468,31 +509,53 @@ static inline void free_memmap(unsigned long start_pfn, unsigned long end_pfn)
 		memblock_free(pg, pgend - pg);
 }

+#endif
+
 /*
  * The mem_map array can get very big. Free the unused area of the memory map.
  */
 static void __init free_unused_memmap(void)
 {
-	unsigned long start, prev_end = 0;
+	unsigned long start, cur_start, prev_end = 0;
 	struct memblock_region *reg;

 	for_each_memblock(memory, reg) {
-		start = __phys_to_pfn(reg->base);
+		cur_start = __phys_to_pfn(reg->base);

 #ifdef CONFIG_SPARSEMEM
 		/*
 		 * Take care not to free memmap entries that don't exist due
 		 * to SPARSEMEM sections which aren't present.
 		 */
-		start = min(start, ALIGN(prev_end, PAGES_PER_SECTION));
-#endif
+		start = min(cur_start, ALIGN(prev_end, PAGES_PER_SECTION));
+
 		/*
-		 * If we had a previous bank, and there is a space between the
-		 * current bank and the previous, free it.
+		 * Free memory in the case of:
+		 * 1. if cur_start - prev_end <= PAGES_PER_SECTION,
+		 * free pre_end ~ cur_start.
+		 * 2. if cur_start - prev_end > PAGES_PER_SECTION,
+		 * free pre_end ~ ALIGN(prev_end, PAGES_PER_SECTION).
 		 */
 		if (prev_end && prev_end < start)
 			free_memmap(prev_end, start);

+		/*
+		 * Free memory in the case of:
+		 * if cur_start - prev_end > PAGES_PER_SECTION,
+		 * free ALIGN_DOWN(cur_start, PAGES_PER_SECTION) ~ cur_start.
+		 */
+		if (cur_start > start &&
+		    !IS_ALIGNED(cur_start, PAGES_PER_SECTION))
+			free_memmap(ALIGN_DOWN(cur_start, PAGES_PER_SECTION),
+				    cur_start);
+#else
+		/*
+		 * If we had a previous bank, and there is a space between the
+		 * current bank and the previous, free it.
+		 */
+		if (prev_end && prev_end < cur_start)
+			free_memmap(prev_end, cur_start);
+#endif
 		/*
 		 * Align up here since the VM subsystem insists that the
 		 * memmap entries are valid from the bank end aligned to
@@ -507,7 +570,6 @@ static void __init free_unused_memmap(void)
 		free_memmap(prev_end, ALIGN(prev_end, PAGES_PER_SECTION));
 #endif
 }
-#endif	/* !CONFIG_SPARSEMEM_VMEMMAP */

 /*
  * mem_init() marks the free areas in the mem_map and tells us how much memory
@@ -524,9 +586,8 @@ void __init mem_init(void)

 	set_max_mapnr(max_pfn - PHYS_PFN_OFFSET);

-#ifndef CONFIG_SPARSEMEM_VMEMMAP
 	free_unused_memmap();
-#endif
+
 	/* this will put all unused low memory onto the freelists */
 	memblock_free_all();

--
2.15.0

