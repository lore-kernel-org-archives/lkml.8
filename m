Return-Path: <SRS0=flzY=3U=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_DBL_ABUSE_MALW autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9B105C35240
	for <linux-kernel@archiver.kernel.org>; Fri, 31 Jan 2020 12:56:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6D83220705
	for <linux-kernel@archiver.kernel.org>; Fri, 31 Jan 2020 12:56:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="VlmI1KoG"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728654AbgAaM4M (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 31 Jan 2020 07:56:12 -0500
Received: from bombadil.infradead.org ([198.137.202.133]:53376 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728630AbgAaM4H (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 31 Jan 2020 07:56:07 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=Content-Type:MIME-Version:References:
        Subject:Cc:To:From:Date:Message-Id:Sender:Reply-To:Content-Transfer-Encoding:
        Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
        Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:List-Id:List-Help:
        List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=JGyzJIdSAeUuwaS5ghKWt7Oe5KchyraA+YzWRvpN9j4=; b=VlmI1KoGDLJobBRnsSD/feA05x
        3IkN16YQM1iDnk4geXte/LqWcfYIANbqUX9BiCs3tnoSsU4T+vj3/Rdb8yBiP+h/dOECrAaS06jw7
        cwszebQJy81ahAm4gFzA9RFceVg9rjcpT0DYwSDyFxRdvpDfVAFeSSD/ZE+dBEUt0ewf3+WeqlkSX
        p5s84IRWh0cMGJL4wlQU1NTtsVljjtjo6KgTYB6D025rwN+rZqEt90b9biu0miZC6lwOUJoJIRy8s
        4m1rGIZkXKOir9Xsach2wpHB8AO2TIwLp+fdpOuPwpX7QG2HOWm2FYFk+qY5P9XbMKSNEhTZoKnq9
        1w5pm+pw==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by bombadil.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1ixVq9-0001ZM-IQ; Fri, 31 Jan 2020 12:56:05 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 4B8D730700B;
        Fri, 31 Jan 2020 13:54:17 +0100 (CET)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 0)
        id 0A8212B4C4270; Fri, 31 Jan 2020 13:56:01 +0100 (CET)
Message-Id: <20200131125403.995781825@infradead.org>
User-Agent: quilt/0.65
Date:   Fri, 31 Jan 2020 13:45:41 +0100
From:   Peter Zijlstra <peterz@infradead.org>
To:     Geert Uytterhoeven <geert@linux-m68k.org>
Cc:     linux-m68k@lists.linux-m68k.org, linux-kernel@vger.kernel.org,
        Will Deacon <will@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Michael Schmitz <schmitzmic@gmail.com>,
        Greg Ungerer <gerg@linux-m68k.org>
Subject: [PATCH -v2 10/10] m68k,mm: Change ColdFire pgtable_t
References: <20200131124531.623136425@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Will Deacon <will@kernel.org>

To match what we did to the Motorola MMU routines, change the ColdFire
pgalloc.

The result is that ColdFire and Sun3 pgalloc are actually very similar
and could conceivably be unified.

Signed-off-by: Will Deacon <will@kernel.org>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
---
 arch/m68k/include/asm/mcf_pgalloc.h |   25 +++++++++++++------------
 arch/m68k/include/asm/page.h        |    7 ++++++-
 2 files changed, 19 insertions(+), 13 deletions(-)

--- a/arch/m68k/include/asm/mcf_pgalloc.h
+++ b/arch/m68k/include/asm/mcf_pgalloc.h
@@ -28,21 +28,22 @@ extern inline pmd_t *pmd_alloc_kernel(pg
 	return (pmd_t *) pgd;
 }
 
-#define pmd_populate(mm, pmd, page) (pmd_val(*pmd) = \
-	(unsigned long)(page_address(page)))
+#define pmd_populate(mm, pmd, pte) (pmd_val(*pmd) = (unsigned long)(pte))
 
-#define pmd_populate_kernel(mm, pmd, pte) (pmd_val(*pmd) = (unsigned long)(pte))
+#define pmd_populate_kernel pmd_populate
 
-#define pmd_pgtable(pmd) pmd_page(pmd)
+#define pmd_pgtable(pmd) pfn_to_virt(pmd_val(pmd) >> PAGE_SHIFT)
 
-static inline void __pte_free_tlb(struct mmu_gather *tlb, pgtable_t page,
+static inline void __pte_free_tlb(struct mmu_gather *tlb, pgtable_t pgtable,
 				  unsigned long address)
 {
+	struct page *page = virt_to_page(pgtable);
+
 	pgtable_pte_page_dtor(page);
 	__free_page(page);
 }
 
-static inline struct page *pte_alloc_one(struct mm_struct *mm)
+static inline pgtable_t pte_alloc_one(struct mm_struct *mm)
 {
 	struct page *page = alloc_pages(GFP_DMA, 0);
 	pte_t *pte;
@@ -54,16 +55,16 @@ static inline struct page *pte_alloc_one
 		return NULL;
 	}
 
-	pte = kmap(page);
-	if (pte)
-		clear_page(pte);
-	kunmap(page);
+	pte = page_address(page);
+	clear_page(pte);
 
-	return page;
+	return pte;
 }
 
-static inline void pte_free(struct mm_struct *mm, struct page *page)
+static inline void pte_free(struct mm_struct *mm, pgtable_t pgtable)
 {
+	struct page *page = virt_to_page(pgtable);
+
 	pgtable_pte_page_dtor(page);
 	__free_page(page);
 }
--- a/arch/m68k/include/asm/page.h
+++ b/arch/m68k/include/asm/page.h
@@ -31,7 +31,12 @@ typedef struct { unsigned long pte; } pt
 typedef struct { unsigned long pgd; } pgd_t;
 typedef struct { unsigned long pgprot; } pgprot_t;
 
-#if defined(CONFIG_SUN3) || defined(CONFIG_COLDFIRE)
+#if defined(CONFIG_SUN3)
+/*
+ * Sun3 still uses the asm-generic/pgalloc.h code and thus needs this
+ * definition. It would be possible to unify Sun3 and ColdFire pgalloc and have
+ * all of m68k use the same type.
+ */
 typedef struct page *pgtable_t;
 #else
 typedef pte_t *pgtable_t;


