Return-Path: <SRS0=r24B=6M=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 54341C83007
	for <linux-kernel@archiver.kernel.org>; Tue, 28 Apr 2020 19:45:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2D8EA21707
	for <linux-kernel@archiver.kernel.org>; Tue, 28 Apr 2020 19:45:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="MCylAK5+"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729149AbgD1To7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 28 Apr 2020 15:44:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55368 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1728987AbgD1To6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Apr 2020 15:44:58 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:e::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8B12EC03C1AB;
        Tue, 28 Apr 2020 12:44:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=Content-Transfer-Encoding:
        MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender
        :Reply-To:Content-Type:Content-ID:Content-Description;
        bh=uhxYV2kO5n88E0AvwP3eNmBuHjvcK1ETxqmaSL4hXlQ=; b=MCylAK5+TGaqUVhj7CUnwDHNrV
        8gBEzS+zzmBmzl3IrFTT0Uqitkp3UCpGzbodghmvxnhbrmihjeZaAZnP4darLcUvZ99WH9x73yCSv
        0hQ8BvpKh935wsXw2kBPQjTxsh4lKGpoXo02N0nOKEcupx3/X+r32bJGy8DDQCv4qZAmEJzjI19SP
        ZQ09kOS3wQxcYzzpGcTqOovcBdv4t64QeQPa2kmJNSkEWu0KWUvWNEzTIWLLEQ6mwZQJaZRmC4qbE
        VBXOPaG3qf/ZHq3YXCTywd802Xi1O/j+6RAnFtwT5hZ22pRjBCAKtr3gkLmv9qwso8h+saCsaXEZa
        5Z85aasw==;
Received: from willy by bombadil.infradead.org with local (Exim 4.92.3 #3 (Red Hat Linux))
        id 1jTW9y-0005uY-Vh; Tue, 28 Apr 2020 19:44:50 +0000
From:   Matthew Wilcox <willy@infradead.org>
To:     linux-mm@kvack.org
Cc:     "Matthew Wilcox (Oracle)" <willy@infradead.org>,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        Will Deacon <will@kernel.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Russell King <linux@armlinux.org.uk>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        linux-m68k@lists.linux-m68k.org
Subject: [PATCH 3/7] arm: Thread mm_struct throughout page table allocation
Date:   Tue, 28 Apr 2020 12:44:45 -0700
Message-Id: <20200428194449.22615-4-willy@infradead.org>
X-Mailer: git-send-email 2.21.1
In-Reply-To: <20200428194449.22615-1-willy@infradead.org>
References: <20200428194449.22615-1-willy@infradead.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: "Matthew Wilcox (Oracle)" <willy@infradead.org>

An upcoming patch will pass mm_struct to the page table constructor.
Make sure ARM has the appropriate mm_struct at the point it needs to
call the constructor.

Signed-off-by: Matthew Wilcox (Oracle) <willy@infradead.org>
---
 arch/arm/mm/mmu.c | 64 +++++++++++++++++++++++------------------------
 1 file changed, 32 insertions(+), 32 deletions(-)

diff --git a/arch/arm/mm/mmu.c b/arch/arm/mm/mmu.c
index ec8d0008bfa1..e5275bfbe695 100644
--- a/arch/arm/mm/mmu.c
+++ b/arch/arm/mm/mmu.c
@@ -690,7 +690,9 @@ EXPORT_SYMBOL(phys_mem_access_prot);
 
 #define vectors_base()	(vectors_high() ? 0xffff0000 : 0)
 
-static void __init *early_alloc(unsigned long sz)
+typedef void *(arm_pt_alloc_t)(unsigned long size, struct mm_struct *);
+
+static void __init *early_alloc(unsigned long sz, struct mm_struct *mm)
 {
 	void *ptr = memblock_alloc(sz, sz);
 
@@ -701,7 +703,7 @@ static void __init *early_alloc(unsigned long sz)
 	return ptr;
 }
 
-static void *__init late_alloc(unsigned long sz)
+static void *__init late_alloc(unsigned long sz, struct mm_struct *mm)
 {
 	void *ptr = (void *)__get_free_pages(GFP_PGTABLE_KERNEL, get_order(sz));
 
@@ -710,31 +712,30 @@ static void *__init late_alloc(unsigned long sz)
 	return ptr;
 }
 
-static pte_t * __init arm_pte_alloc(pmd_t *pmd, unsigned long addr,
-				unsigned long prot,
-				void *(*alloc)(unsigned long sz))
+static pte_t * __init arm_pte_alloc(struct mm_struct *mm, pmd_t *pmd,
+				unsigned long addr, unsigned long prot,
+				arm_pt_alloc_t alloc)
 {
 	if (pmd_none(*pmd)) {
-		pte_t *pte = alloc(PTE_HWTABLE_OFF + PTE_HWTABLE_SIZE);
+		pte_t *pte = alloc(PTE_HWTABLE_OFF + PTE_HWTABLE_SIZE, mm);
 		__pmd_populate(pmd, __pa(pte), prot);
 	}
 	BUG_ON(pmd_bad(*pmd));
 	return pte_offset_kernel(pmd, addr);
 }
 
-static pte_t * __init early_pte_alloc(pmd_t *pmd, unsigned long addr,
-				      unsigned long prot)
+static pte_t * __init early_pte_alloc(struct mm_struct *mm, pmd_t *pmd,
+					unsigned long addr, unsigned long prot)
 {
-	return arm_pte_alloc(pmd, addr, prot, early_alloc);
+	return arm_pte_alloc(mm, pmd, addr, prot, early_alloc);
 }
 
-static void __init alloc_init_pte(pmd_t *pmd, unsigned long addr,
-				  unsigned long end, unsigned long pfn,
-				  const struct mem_type *type,
-				  void *(*alloc)(unsigned long sz),
-				  bool ng)
+static void __init alloc_init_pte(struct mm_struct *mm, pmd_t *pmd,
+				unsigned long addr, unsigned long end,
+				unsigned long pfn, const struct mem_type *type,
+				arm_pt_alloc_t alloc, bool ng)
 {
-	pte_t *pte = arm_pte_alloc(pmd, addr, type->prot_l1, alloc);
+	pte_t *pte = arm_pte_alloc(mm, pmd, addr, type->prot_l1, alloc);
 	do {
 		set_pte_ext(pte, pfn_pte(pfn, __pgprot(type->prot_pte)),
 			    ng ? PTE_EXT_NG : 0);
@@ -769,10 +770,10 @@ static void __init __map_init_section(pmd_t *pmd, unsigned long addr,
 	flush_pmd_entry(p);
 }
 
-static void __init alloc_init_pmd(pud_t *pud, unsigned long addr,
-				      unsigned long end, phys_addr_t phys,
-				      const struct mem_type *type,
-				      void *(*alloc)(unsigned long sz), bool ng)
+static void __init alloc_init_pmd(struct mm_struct *mm, pud_t *pud,
+				unsigned long addr, unsigned long end,
+				phys_addr_t phys, const struct mem_type *type,
+				arm_pt_alloc_t alloc, bool ng)
 {
 	pmd_t *pmd = pmd_offset(pud, addr);
 	unsigned long next;
@@ -792,7 +793,7 @@ static void __init alloc_init_pmd(pud_t *pud, unsigned long addr,
 				((addr | next | phys) & ~SECTION_MASK) == 0) {
 			__map_init_section(pmd, addr, next, phys, type, ng);
 		} else {
-			alloc_init_pte(pmd, addr, next,
+			alloc_init_pte(mm, pmd, addr, next,
 				       __phys_to_pfn(phys), type, alloc, ng);
 		}
 
@@ -801,17 +802,17 @@ static void __init alloc_init_pmd(pud_t *pud, unsigned long addr,
 	} while (pmd++, addr = next, addr != end);
 }
 
-static void __init alloc_init_pud(pgd_t *pgd, unsigned long addr,
-				  unsigned long end, phys_addr_t phys,
-				  const struct mem_type *type,
-				  void *(*alloc)(unsigned long sz), bool ng)
+static void __init alloc_init_pud(struct mm_struct *mm, pgd_t *pgd,
+				unsigned long addr, unsigned long end,
+				phys_addr_t phys, const struct mem_type *type,
+				arm_pt_alloc_t alloc, bool ng)
 {
 	pud_t *pud = pud_offset(pgd, addr);
 	unsigned long next;
 
 	do {
 		next = pud_addr_end(addr, end);
-		alloc_init_pmd(pud, addr, next, phys, type, alloc, ng);
+		alloc_init_pmd(mm, pud, addr, next, phys, type, alloc, ng);
 		phys += next - addr;
 	} while (pud++, addr = next, addr != end);
 }
@@ -879,8 +880,7 @@ static void __init create_36bit_mapping(struct mm_struct *mm,
 #endif	/* !CONFIG_ARM_LPAE */
 
 static void __init __create_mapping(struct mm_struct *mm, struct map_desc *md,
-				    void *(*alloc)(unsigned long sz),
-				    bool ng)
+					arm_pt_alloc_t alloc, bool ng)
 {
 	unsigned long addr, length, end;
 	phys_addr_t phys;
@@ -914,7 +914,7 @@ static void __init __create_mapping(struct mm_struct *mm, struct map_desc *md,
 	do {
 		unsigned long next = pgd_addr_end(addr, end);
 
-		alloc_init_pud(pgd, addr, next, phys, type, alloc, ng);
+		alloc_init_pud(mm, pgd, addr, next, phys, type, alloc, ng);
 
 		phys += next - addr;
 		addr = next;
@@ -1316,7 +1316,7 @@ static void __init devicemaps_init(const struct machine_desc *mdesc)
 	/*
 	 * Allocate the vector page early.
 	 */
-	vectors = early_alloc(PAGE_SIZE * 2);
+	vectors = early_alloc(PAGE_SIZE * 2, &init_mm);
 
 	early_trap_init(vectors);
 
@@ -1413,11 +1413,11 @@ static void __init devicemaps_init(const struct machine_desc *mdesc)
 static void __init kmap_init(void)
 {
 #ifdef CONFIG_HIGHMEM
-	pkmap_page_table = early_pte_alloc(pmd_off_k(PKMAP_BASE),
+	pkmap_page_table = early_pte_alloc(&init_mm, pmd_off_k(PKMAP_BASE),
 		PKMAP_BASE, _PAGE_KERNEL_TABLE);
 #endif
 
-	early_pte_alloc(pmd_off_k(FIXADDR_START), FIXADDR_START,
+	early_pte_alloc(&init_mm, pmd_off_k(FIXADDR_START), FIXADDR_START,
 			_PAGE_KERNEL_TABLE);
 }
 
@@ -1630,7 +1630,7 @@ void __init paging_init(const struct machine_desc *mdesc)
 	top_pmd = pmd_off_k(0xffff0000);
 
 	/* allocate the zero page. */
-	zero_page = early_alloc(PAGE_SIZE);
+	zero_page = early_alloc(PAGE_SIZE, &init_mm);
 
 	bootmem_init();
 
-- 
2.26.2

