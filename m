Return-Path: <SRS0=xNW4=3S=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,URIBL_DBL_ABUSE_MALW autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 267E2C35240
	for <linux-kernel@archiver.kernel.org>; Wed, 29 Jan 2020 10:45:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E624F20732
	for <linux-kernel@archiver.kernel.org>; Wed, 29 Jan 2020 10:45:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="hW7aiT84"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726670AbgA2KpS (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 29 Jan 2020 05:45:18 -0500
Received: from merlin.infradead.org ([205.233.59.134]:48214 "EHLO
        merlin.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726551AbgA2KpP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Jan 2020 05:45:15 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=merlin.20170209; h=Content-Type:MIME-Version:References:
        Subject:Cc:To:From:Date:Message-Id:Sender:Reply-To:Content-Transfer-Encoding:
        Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
        Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:List-Id:List-Help:
        List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=Xf+HYyabx00hesBGuy25K5IzuYiZGH8DfWI2UrwSTqY=; b=hW7aiT84MMdNFafk4bT7Yf5Abh
        o4p3gvNtQLXqD2ElCZZqOLh3bS5cB6Rrx2gpcN9OBW074Q2L/MNhTn0zQIaXixtJS0HSVoN0p+RJ+
        dPuk3Nu0MeU0uL8HOoFpwM5KI3VrLXay28d4GdCsFRI5atfAf8J7pTaEEFZSIwmsZv3JNm7loMMsH
        X4vGSHASOO1AUmOxKYJoSptVVrS4l76iH5iqws3sEIsoxJ2xx0BSZycxvyM9MHM0EOnSTTJQRmMGw
        iGED+pRbokH6qDx0zIl7rSpzH3JJtZZ/ATiOQJXC2iEcAkH9GnOEltxk8LZ3y7yfYFfQCTLGVq4ZD
        G1j6kwqA==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by merlin.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1iwkqN-0001OJ-8W; Wed, 29 Jan 2020 10:45:11 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id CA9153060EB;
        Wed, 29 Jan 2020 11:43:24 +0100 (CET)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 0)
        id 895DF2B2E7F40; Wed, 29 Jan 2020 11:45:07 +0100 (CET)
Message-Id: <20200129104345.434705552@infradead.org>
User-Agent: quilt/0.65
Date:   Wed, 29 Jan 2020 11:39:44 +0100
From:   Peter Zijlstra <peterz@infradead.org>
To:     Geert Uytterhoeven <geert@linux-m68k.org>
Cc:     linux-m68k@lists.linux-m68k.org, linux-kernel@vger.kernel.org,
        Will Deacon <will@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>
Subject: [PATCH 3/5] m68k,mm: Use table allocator for pgtables
References: <20200129103941.304769381@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

With the new page-table layout, using full (4k) pages for (256 byte)
pte-tables is immensely wastefull. Move the pte-tables over to the
same allocator already used for the (512 byte) higher level tables
(pgd/pmd).

This reduces the pte-table waste from 15x to 2x.

Due to no longer being bound to 16 consecutive tables, this might
actually already be more efficient than the old code for sparse
tables.

Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
---
 arch/m68k/include/asm/motorola_pgalloc.h |   54 ++++++-------------------------
 arch/m68k/include/asm/motorola_pgtable.h |    8 ++++
 arch/m68k/include/asm/page.h             |    2 -
 3 files changed, 19 insertions(+), 45 deletions(-)

--- a/arch/m68k/include/asm/motorola_pgalloc.h
+++ b/arch/m68k/include/asm/motorola_pgalloc.h
@@ -10,60 +10,28 @@ extern int free_pointer_table(pmd_t *);
 
 static inline pte_t *pte_alloc_one_kernel(struct mm_struct *mm)
 {
-	pte_t *pte;
-
-	pte = (pte_t *)__get_free_page(GFP_KERNEL|__GFP_ZERO);
-	if (pte) {
-		__flush_page_to_ram(pte);
-		flush_tlb_kernel_page(pte);
-		nocache_page(pte);
-	}
-
-	return pte;
+	return (pte_t *)get_pointer_table();
 }
 
 static inline void pte_free_kernel(struct mm_struct *mm, pte_t *pte)
 {
-	cache_page(pte);
-	free_page((unsigned long) pte);
+	free_pointer_table((void *)pte);
 }
 
 static inline pgtable_t pte_alloc_one(struct mm_struct *mm)
 {
-	struct page *page;
-	pte_t *pte;
+	return (pte_t *)get_pointer_table();
+}
 
-	page = alloc_pages(GFP_KERNEL|__GFP_ZERO, 0);
-	if(!page)
-		return NULL;
-	if (!pgtable_pte_page_ctor(page)) {
-		__free_page(page);
-		return NULL;
-	}
-
-	pte = kmap(page);
-	__flush_page_to_ram(pte);
-	flush_tlb_kernel_page(pte);
-	nocache_page(pte);
-	kunmap(page);
-	return page;
-}
-
-static inline void pte_free(struct mm_struct *mm, pgtable_t page)
-{
-	pgtable_pte_page_dtor(page);
-	cache_page(kmap(page));
-	kunmap(page);
-	__free_page(page);
+static inline void pte_free(struct mm_struct *mm, pgtable_t pgtable)
+{
+	free_pointer_table((void *)pgtable);
 }
 
-static inline void __pte_free_tlb(struct mmu_gather *tlb, pgtable_t page,
+static inline void __pte_free_tlb(struct mmu_gather *tlb, pgtable_t pgtable,
 				  unsigned long address)
 {
-	pgtable_pte_page_dtor(page);
-	cache_page(kmap(page));
-	kunmap(page);
-	__free_page(page);
+	free_pointer_table((void *)pgtable);
 }
 
 
@@ -102,9 +70,9 @@ static inline void pmd_populate_kernel(s
 
 static inline void pmd_populate(struct mm_struct *mm, pmd_t *pmd, pgtable_t page)
 {
-	pmd_set(pmd, page_address(page));
+	pmd_set(pmd, page);
 }
-#define pmd_pgtable(pmd) pmd_page(pmd)
+#define pmd_pgtable(pmd) ((pgtable_t)__pmd_page(pmd))
 
 static inline void pud_populate(struct mm_struct *mm, pud_t *pud, pmd_t *pmd)
 {
--- a/arch/m68k/include/asm/motorola_pgtable.h
+++ b/arch/m68k/include/asm/motorola_pgtable.h
@@ -133,7 +133,13 @@ static inline void pud_set(pud_t *pudp,
 #define pmd_bad(pmd)		((pmd_val(pmd) & _DESCTYPE_MASK) != _PAGE_TABLE)
 #define pmd_present(pmd)	(pmd_val(pmd) & _PAGE_TABLE)
 #define pmd_clear(pmdp)		({ pmd_val(*pmdp) = 0; })
-#define pmd_page(pmd)		virt_to_page(__va(pmd_val(pmd)))
+
+/*
+ * m68k does not have huge pages (020/030 actually could), but generic code
+ * expects pmd_page() to exists, only to then DCE it all. Provide a dummy to
+ * make the compiler happy.
+ */
+#define pmd_page(pmd)		NULL
 
 
 #define pud_none(pud)		(!pud_val(pud))
--- a/arch/m68k/include/asm/page.h
+++ b/arch/m68k/include/asm/page.h
@@ -30,7 +30,7 @@ typedef struct { unsigned long pmd; } pm
 typedef struct { unsigned long pte; } pte_t;
 typedef struct { unsigned long pgd; } pgd_t;
 typedef struct { unsigned long pgprot; } pgprot_t;
-typedef struct page *pgtable_t;
+typedef pte_t *pgtable_t;
 
 #define pte_val(x)	((x).pte)
 #define pgd_val(x)	((x).pgd)


