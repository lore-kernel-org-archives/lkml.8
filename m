Return-Path: <SRS0=flzY=3U=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,URIBL_DBL_ABUSE_MALW autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 56863C33CB2
	for <linux-kernel@archiver.kernel.org>; Fri, 31 Jan 2020 12:56:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 278F7215A4
	for <linux-kernel@archiver.kernel.org>; Fri, 31 Jan 2020 12:56:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="PiXr0TMK"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728598AbgAaM4F (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 31 Jan 2020 07:56:05 -0500
Received: from bombadil.infradead.org ([198.137.202.133]:53356 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728511AbgAaM4F (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 31 Jan 2020 07:56:05 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=Content-Type:MIME-Version:References:
        Subject:Cc:To:From:Date:Message-Id:Sender:Reply-To:Content-Transfer-Encoding:
        Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
        Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:List-Id:List-Help:
        List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=n6RhCQHsHSyTTjZawIUQRIGp0UsjTpUD7uRgGAuTt9A=; b=PiXr0TMKBYgO1KuaqgBFJjOPAJ
        jsw+p5rUo36Dm+/CFm2tZ4siWZ254oxNJxdEqOfpzB4jEH/UhKKmw0fuf9KV261tj7yFZ+3lsVPVZ
        r2ysWQwFFvo34sOzbTY3Op04SYS2dFAvyn5OkjQdxK0dwPv8aRd2UthCr8rF0amWRlUIv7dLeb8wV
        QqmyHqNODbxGQujpXWQO6LDfdtSaRghDzFvdfBxXF+OQPSDOuvLuDmk1WIp1PS8hWCmY+DHPUXqLr
        Ql1j4CrA5ofiQim4yVy47OunCuO0gTkQOlSP0lfWkEHB5h7l7ZoLY8k98mkbPphB0WJNqvy6oAG0A
        JxRLjLKA==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by bombadil.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1ixVq7-0001ZA-2D; Fri, 31 Jan 2020 12:56:03 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 3C2B43011E8;
        Fri, 31 Jan 2020 13:54:17 +0100 (CET)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 0)
        id E25142B4C4271; Fri, 31 Jan 2020 13:56:00 +0100 (CET)
Message-Id: <20200131125403.597688427@infradead.org>
User-Agent: quilt/0.65
Date:   Fri, 31 Jan 2020 13:45:34 +0100
From:   Peter Zijlstra <peterz@infradead.org>
To:     Geert Uytterhoeven <geert@linux-m68k.org>
Cc:     linux-m68k@lists.linux-m68k.org, linux-kernel@vger.kernel.org,
        Will Deacon <will@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Michael Schmitz <schmitzmic@gmail.com>,
        Greg Ungerer <gerg@linux-m68k.org>
Subject: [PATCH -v2 03/10] m68k,mm: Unify Motorola MMU page setup
References: <20200131124531.623136425@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Seeing how there are 5 copies of this magic code, one of which is
unexplainably different, unify and document things.

Suggested-by: Will Deacon <will@kernel.org>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
---
 arch/m68k/include/asm/motorola_pgalloc.h |   23 ++++++++++-------------
 arch/m68k/mm/memory.c                    |    5 ++---
 arch/m68k/mm/motorola.c                  |   30 ++++++++++++++++++++++++------
 3 files changed, 36 insertions(+), 22 deletions(-)

--- a/arch/m68k/include/asm/motorola_pgalloc.h
+++ b/arch/m68k/include/asm/motorola_pgalloc.h
@@ -5,6 +5,9 @@
 #include <asm/tlb.h>
 #include <asm/tlbflush.h>
 
+extern void mmu_page_ctor(void *page);
+extern void mmu_page_dtor(void *page);
+
 extern pmd_t *get_pointer_table(void);
 extern int free_pointer_table(pmd_t *);
 
@@ -13,25 +16,21 @@ static inline pte_t *pte_alloc_one_kerne
 	pte_t *pte;
 
 	pte = (pte_t *)__get_free_page(GFP_KERNEL|__GFP_ZERO);
-	if (pte) {
-		__flush_page_to_ram(pte);
-		flush_tlb_kernel_page(pte);
-		nocache_page(pte);
-	}
+	if (pte)
+		mmu_page_ctor(pte);
 
 	return pte;
 }
 
 static inline void pte_free_kernel(struct mm_struct *mm, pte_t *pte)
 {
-	cache_page(pte);
+	mmu_page_dtor(pte);
 	free_page((unsigned long) pte);
 }
 
 static inline pgtable_t pte_alloc_one(struct mm_struct *mm)
 {
 	struct page *page;
-	pte_t *pte;
 
 	page = alloc_pages(GFP_KERNEL|__GFP_ZERO, 0);
 	if(!page)
@@ -41,18 +40,16 @@ static inline pgtable_t pte_alloc_one(st
 		return NULL;
 	}
 
-	pte = kmap(page);
-	__flush_page_to_ram(pte);
-	flush_tlb_kernel_page(pte);
-	nocache_page(pte);
+	mmu_page_ctor(kmap(page));
 	kunmap(page);
+
 	return page;
 }
 
 static inline void pte_free(struct mm_struct *mm, pgtable_t page)
 {
 	pgtable_pte_page_dtor(page);
-	cache_page(kmap(page));
+	mmu_page_dtor(kmap(page));
 	kunmap(page);
 	__free_page(page);
 }
@@ -61,7 +58,7 @@ static inline void __pte_free_tlb(struct
 				  unsigned long address)
 {
 	pgtable_pte_page_dtor(page);
-	cache_page(kmap(page));
+	mmu_page_dtor(kmap(page));
 	kunmap(page);
 	__free_page(page);
 }
--- a/arch/m68k/mm/memory.c
+++ b/arch/m68k/mm/memory.c
@@ -77,8 +77,7 @@ pmd_t *get_pointer_table (void)
 		if (!(page = (void *)get_zeroed_page(GFP_KERNEL)))
 			return NULL;
 
-		flush_tlb_kernel_page(page);
-		nocache_page(page);
+		mmu_page_ctor(page);
 
 		new = PD_PTABLE(page);
 		PD_MARKBITS(new) = 0xfe;
@@ -112,7 +111,7 @@ int free_pointer_table (pmd_t *ptable)
 	if (PD_MARKBITS(dp) == 0xff) {
 		/* all tables in page are free, free page */
 		list_del(dp);
-		cache_page((void *)page);
+		mmu_page_dtor((void *)page);
 		free_page (page);
 		return 1;
 	} else if (ptable_list.next != dp) {
--- a/arch/m68k/mm/motorola.c
+++ b/arch/m68k/mm/motorola.c
@@ -45,6 +45,28 @@ unsigned long mm_cachebits;
 EXPORT_SYMBOL(mm_cachebits);
 #endif
 
+
+/*
+ * Motorola 680x0 user's manual recommends using uncached memory for address
+ * translation tables.
+ *
+ * Seeing how the MMU can be external on (some of) these chips, that seems like
+ * a very important recommendation to follow. Provide some helpers to combat
+ * 'variation' amongst the users of this.
+ */
+
+void mmu_page_ctor(void *page)
+{
+	__flush_page_to_ram(page);
+	flush_tlb_kernel_page(page);
+	nocache_page(page);
+}
+
+void mmu_page_dtor(void *page)
+{
+	cache_page(page);
+}
+
 /* size of memory already mapped in head.S */
 extern __initdata unsigned long m68k_init_mapped_size;
 
@@ -60,9 +82,7 @@ static pte_t * __init kernel_page_table(
 		      __func__, PAGE_SIZE, PAGE_SIZE);
 
 	clear_page(ptablep);
-	__flush_page_to_ram(ptablep);
-	flush_tlb_kernel_page(ptablep);
-	nocache_page(ptablep);
+	mmu_page_ctor(ptablep);
 
 	return ptablep;
 }
@@ -106,9 +126,7 @@ static pmd_t * __init kernel_ptr_table(v
 			      __func__, PAGE_SIZE, PAGE_SIZE);
 
 		clear_page(last_pgtable);
-		__flush_page_to_ram(last_pgtable);
-		flush_tlb_kernel_page(last_pgtable);
-		nocache_page(last_pgtable);
+		mmu_page_ctor(last_pgtable);
 	}
 
 	return last_pgtable;


