Return-Path: <SRS0=flzY=3U=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,URIBL_DBL_ABUSE_MALW autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B27ADC35240
	for <linux-kernel@archiver.kernel.org>; Fri, 31 Jan 2020 12:56:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7C944215A4
	for <linux-kernel@archiver.kernel.org>; Fri, 31 Jan 2020 12:56:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="cXPQWrGC"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728729AbgAaM4a (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 31 Jan 2020 07:56:30 -0500
Received: from merlin.infradead.org ([205.233.59.134]:39026 "EHLO
        merlin.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728629AbgAaM4H (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 31 Jan 2020 07:56:07 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=merlin.20170209; h=Content-Type:MIME-Version:References:
        Subject:Cc:To:From:Date:Message-Id:Sender:Reply-To:Content-Transfer-Encoding:
        Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
        Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:List-Id:List-Help:
        List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=sHyRxd7EEmzb1g8C6ExJ6oMWz3riyBUp8AM/mXJQbuw=; b=cXPQWrGCJ6ktH9WjbZGvRZBWtg
        VZ1RpxuLhQl0qX6C5A12QMfbGWAptZm0eiXF1IXKmmXoPdexQljhjtdNUoN8qrhmxzxr6Yyw6Vw9k
        pTM+i2z7ngxWRWh0OomhnZawbuUxSQexXpDxZBz+Q6d4W/gsKRdk3r/NLkHXV6+S0Admh5dlPXtJz
        CCFk/IkIzPHa7PYW7tHleFWjrsUW9YmFDjMER2b2jK6pheorrg6eoEhkUZcTbVorzwEIelfPStqyL
        W5pTYKFgl8q0PjrXtMOS6hPpinJJufb40Hze7XNpbu2uHTLUPfKkDj8AlqriMX793vY/tihm5dh1i
        dXcyt6MA==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by merlin.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1ixVq8-0003gK-J8; Fri, 31 Jan 2020 12:56:04 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 48CF9306368;
        Fri, 31 Jan 2020 13:54:17 +0100 (CET)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 0)
        id F408E2B634819; Fri, 31 Jan 2020 13:56:00 +0100 (CET)
Message-Id: <20200131125403.825295149@infradead.org>
User-Agent: quilt/0.65
Date:   Fri, 31 Jan 2020 13:45:38 +0100
From:   Peter Zijlstra <peterz@infradead.org>
To:     Geert Uytterhoeven <geert@linux-m68k.org>
Cc:     linux-m68k@lists.linux-m68k.org, linux-kernel@vger.kernel.org,
        Will Deacon <will@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Michael Schmitz <schmitzmic@gmail.com>,
        Greg Ungerer <gerg@linux-m68k.org>
Subject: [PATCH -v2 07/10] m68k,mm: Use table allocator for pgtables
References: <20200131124531.623136425@infradead.org>
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
 arch/m68k/include/asm/motorola_pgalloc.h |   44 ++++++-------------------------
 arch/m68k/include/asm/motorola_pgtable.h |    8 ++++-
 arch/m68k/include/asm/page.h             |    5 +++
 3 files changed, 21 insertions(+), 36 deletions(-)

--- a/arch/m68k/include/asm/motorola_pgalloc.h
+++ b/arch/m68k/include/asm/motorola_pgalloc.h
@@ -13,54 +13,28 @@ extern int free_pointer_table(pmd_t *);
 
 static inline pte_t *pte_alloc_one_kernel(struct mm_struct *mm)
 {
-	pte_t *pte;
-
-	pte = (pte_t *)__get_free_page(GFP_KERNEL|__GFP_ZERO);
-	if (pte)
-		mmu_page_ctor(pte);
-
-	return pte;
+	return (pte_t *)get_pointer_table();
 }
 
 static inline void pte_free_kernel(struct mm_struct *mm, pte_t *pte)
 {
-	mmu_page_dtor(pte);
-	free_page((unsigned long) pte);
+	free_pointer_table((void *)pte);
 }
 
 static inline pgtable_t pte_alloc_one(struct mm_struct *mm)
 {
-	struct page *page;
-
-	page = alloc_pages(GFP_KERNEL|__GFP_ZERO, 0);
-	if(!page)
-		return NULL;
-	if (!pgtable_pte_page_ctor(page)) {
-		__free_page(page);
-		return NULL;
-	}
-
-	mmu_page_ctor(kmap(page));
-	kunmap(page);
-
-	return page;
+	return (pte_t *)get_pointer_table();
 }
 
-static inline void pte_free(struct mm_struct *mm, pgtable_t page)
+static inline void pte_free(struct mm_struct *mm, pgtable_t pgtable)
 {
-	pgtable_pte_page_dtor(page);
-	mmu_page_dtor(kmap(page));
-	kunmap(page);
-	__free_page(page);
+	free_pointer_table((void *)pgtable);
 }
 
-static inline void __pte_free_tlb(struct mmu_gather *tlb, pgtable_t page,
+static inline void __pte_free_tlb(struct mmu_gather *tlb, pgtable_t pgtable,
 				  unsigned long address)
 {
-	pgtable_pte_page_dtor(page);
-	mmu_page_dtor(kmap(page));
-	kunmap(page);
-	__free_page(page);
+	free_pointer_table((void *)pgtable);
 }
 
 
@@ -99,9 +73,9 @@ static inline void pmd_populate_kernel(s
 
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
@@ -144,7 +144,13 @@ static inline void pud_set(pud_t *pudp,
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
@@ -30,7 +30,12 @@ typedef struct { unsigned long pmd; } pm
 typedef struct { unsigned long pte; } pte_t;
 typedef struct { unsigned long pgd; } pgd_t;
 typedef struct { unsigned long pgprot; } pgprot_t;
+
+#if defined(CONFIG_SUN3) || defined(CONFIG_COLDFIRE)
 typedef struct page *pgtable_t;
+#else
+typedef pte_t *pgtable_t;
+#endif
 
 #define pte_val(x)	((x).pte)
 #define pgd_val(x)	((x).pgd)


