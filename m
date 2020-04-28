Return-Path: <SRS0=r24B=6M=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DC5F8C8300A
	for <linux-kernel@archiver.kernel.org>; Tue, 28 Apr 2020 19:45:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id BA4FE221EA
	for <linux-kernel@archiver.kernel.org>; Tue, 28 Apr 2020 19:45:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="s/qXru4u"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729065AbgD1Tox (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 28 Apr 2020 15:44:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55346 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1728986AbgD1Tow (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Apr 2020 15:44:52 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:e::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7C2B8C03C1AC;
        Tue, 28 Apr 2020 12:44:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=Content-Transfer-Encoding:
        MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender
        :Reply-To:Content-Type:Content-ID:Content-Description;
        bh=M4UWeVD1aiN0w304dAdjToeSDD+jrmpQN+yIxabjhn8=; b=s/qXru4uMFH5VaWHC1OJZxpdzW
        KeYszvg733nHAjNHTibtOGKEAjMi6q+kRfoc0l94abgczc3N3jigTc1K+DkEC8tR3aixDaGv6kLFR
        igyYaP+qhO2iXdjH2k4zrXSiMHg9G8r5J8gLDsf/4oY67296N/kHAOPu2tJASHR+OzUFKqB0k6+1O
        XP7F607JbUKJESNj4gYNIKW84rMFyI+rrYhNTZIcB835hxoRMYIe2uN3ULt8mIlvdjwNEjdK1RS0/
        Q41YqjvelbZfSnz+qEpjgp2MB0eY3qbMRWQkScZeztV7m/nl6MguX7ACoaK83UKfuQSNLW3eoaGRC
        F8NMwPwA==;
Received: from willy by bombadil.infradead.org with local (Exim 4.92.3 #3 (Red Hat Linux))
        id 1jTW9z-0005uo-43; Tue, 28 Apr 2020 19:44:51 +0000
From:   Matthew Wilcox <willy@infradead.org>
To:     linux-mm@kvack.org
Cc:     "Matthew Wilcox (Oracle)" <willy@infradead.org>,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        Will Deacon <will@kernel.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Russell King <linux@armlinux.org.uk>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        linux-m68k@lists.linux-m68k.org
Subject: [PATCH 7/7] mm: Set pt_mm in PMD constructor
Date:   Tue, 28 Apr 2020 12:44:49 -0700
Message-Id: <20200428194449.22615-8-willy@infradead.org>
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

By setting pt_mm for pages in use as page tables, we can help with
debugging and lay the foundation for handling hardware errors in page
tables more gracefully.  It also opens up the possibility for adding
more sanity checks in the future.

Also set and clear the PageTable bit so that we know these are page tables.

Signed-off-by: Matthew Wilcox (Oracle) <willy@infradead.org>
---
 arch/arm64/include/asm/pgalloc.h   |  2 +-
 arch/arm64/mm/mmu.c                |  2 +-
 arch/powerpc/mm/book3s64/pgtable.c |  2 +-
 arch/s390/include/asm/pgalloc.h    |  2 +-
 arch/x86/include/asm/pgalloc.h     |  2 +-
 arch/x86/mm/pgtable.c              |  2 +-
 include/linux/mm.h                 | 13 +++++++++++--
 7 files changed, 17 insertions(+), 8 deletions(-)

diff --git a/arch/arm64/include/asm/pgalloc.h b/arch/arm64/include/asm/pgalloc.h
index 172d76fa0245..920da9c5786c 100644
--- a/arch/arm64/include/asm/pgalloc.h
+++ b/arch/arm64/include/asm/pgalloc.h
@@ -30,7 +30,7 @@ static inline pmd_t *pmd_alloc_one(struct mm_struct *mm, unsigned long addr)
 	page = alloc_page(gfp);
 	if (!page)
 		return NULL;
-	if (!pgtable_pmd_page_ctor(page)) {
+	if (!pgtable_pmd_page_ctor(page, mm)) {
 		__free_page(page);
 		return NULL;
 	}
diff --git a/arch/arm64/mm/mmu.c b/arch/arm64/mm/mmu.c
index c706bed1e496..b7bdde1990be 100644
--- a/arch/arm64/mm/mmu.c
+++ b/arch/arm64/mm/mmu.c
@@ -383,7 +383,7 @@ static phys_addr_t pgd_pgtable_alloc(int shift, struct mm_struct *mm)
 	if (shift == PAGE_SHIFT)
 		BUG_ON(!pgtable_pte_page_ctor(phys_to_page(pa), mm));
 	else if (shift == PMD_SHIFT)
-		BUG_ON(!pgtable_pmd_page_ctor(phys_to_page(pa)));
+		BUG_ON(!pgtable_pmd_page_ctor(phys_to_page(pa), mm));
 
 	return pa;
 }
diff --git a/arch/powerpc/mm/book3s64/pgtable.c b/arch/powerpc/mm/book3s64/pgtable.c
index e0bb69c616e4..9fda5287c197 100644
--- a/arch/powerpc/mm/book3s64/pgtable.c
+++ b/arch/powerpc/mm/book3s64/pgtable.c
@@ -297,7 +297,7 @@ static pmd_t *__alloc_for_pmdcache(struct mm_struct *mm)
 	page = alloc_page(gfp);
 	if (!page)
 		return NULL;
-	if (!pgtable_pmd_page_ctor(page)) {
+	if (!pgtable_pmd_page_ctor(page, mm)) {
 		__free_pages(page, 0);
 		return NULL;
 	}
diff --git a/arch/s390/include/asm/pgalloc.h b/arch/s390/include/asm/pgalloc.h
index 74a352f8c0d1..bebad4e5d42a 100644
--- a/arch/s390/include/asm/pgalloc.h
+++ b/arch/s390/include/asm/pgalloc.h
@@ -86,7 +86,7 @@ static inline pmd_t *pmd_alloc_one(struct mm_struct *mm, unsigned long vmaddr)
 	if (!table)
 		return NULL;
 	crst_table_init(table, _SEGMENT_ENTRY_EMPTY);
-	if (!pgtable_pmd_page_ctor(virt_to_page(table))) {
+	if (!pgtable_pmd_page_ctor(virt_to_page(table), mm)) {
 		crst_table_free(mm, table);
 		return NULL;
 	}
diff --git a/arch/x86/include/asm/pgalloc.h b/arch/x86/include/asm/pgalloc.h
index 29aa7859bdee..33514f0a9e79 100644
--- a/arch/x86/include/asm/pgalloc.h
+++ b/arch/x86/include/asm/pgalloc.h
@@ -96,7 +96,7 @@ static inline pmd_t *pmd_alloc_one(struct mm_struct *mm, unsigned long addr)
 	page = alloc_pages(gfp, 0);
 	if (!page)
 		return NULL;
-	if (!pgtable_pmd_page_ctor(page)) {
+	if (!pgtable_pmd_page_ctor(page, mm)) {
 		__free_pages(page, 0);
 		return NULL;
 	}
diff --git a/arch/x86/mm/pgtable.c b/arch/x86/mm/pgtable.c
index f5f46737aea0..8f4255662c5a 100644
--- a/arch/x86/mm/pgtable.c
+++ b/arch/x86/mm/pgtable.c
@@ -229,7 +229,7 @@ static int preallocate_pmds(struct mm_struct *mm, pmd_t *pmds[], int count)
 		pmd_t *pmd = (pmd_t *)__get_free_page(gfp);
 		if (!pmd)
 			failed = true;
-		if (pmd && !pgtable_pmd_page_ctor(virt_to_page(pmd))) {
+		if (pmd && !pgtable_pmd_page_ctor(virt_to_page(pmd), mm)) {
 			free_page((unsigned long)pmd);
 			pmd = NULL;
 			failed = true;
diff --git a/include/linux/mm.h b/include/linux/mm.h
index 2a98eebeba91..e2924d900fc5 100644
--- a/include/linux/mm.h
+++ b/include/linux/mm.h
@@ -2216,11 +2216,14 @@ static inline spinlock_t *pmd_lockptr(struct mm_struct *mm, pmd_t *pmd)
 	return ptlock_ptr(pmd_to_page(pmd));
 }
 
-static inline bool pgtable_pmd_page_ctor(struct page *page)
+static inline
+bool pgtable_pmd_page_ctor(struct page *page, struct mm_struct *mm)
 {
 #ifdef CONFIG_TRANSPARENT_HUGEPAGE
 	page->pmd_huge_pte = NULL;
 #endif
+	__SetPageTable(page);
+	page->pt_mm = mm;
 	return ptlock_init(page);
 }
 
@@ -2229,6 +2232,8 @@ static inline void pgtable_pmd_page_dtor(struct page *page)
 #ifdef CONFIG_TRANSPARENT_HUGEPAGE
 	VM_BUG_ON_PAGE(page->pmd_huge_pte, page);
 #endif
+	__ClearPageTable(page);
+	page->pt_mm = NULL;
 	ptlock_free(page);
 }
 
@@ -2241,7 +2246,11 @@ static inline spinlock_t *pmd_lockptr(struct mm_struct *mm, pmd_t *pmd)
 	return &mm->page_table_lock;
 }
 
-static inline bool pgtable_pmd_page_ctor(struct page *page) { return true; }
+static inline
+bool pgtable_pmd_page_ctor(struct page *page, struct mm_struct *mm)
+{
+	return true;
+}
 static inline void pgtable_pmd_page_dtor(struct page *page) {}
 
 #define pmd_huge_pte(mm, pmd) ((mm)->pmd_huge_pte)
-- 
2.26.2

