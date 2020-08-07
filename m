Return-Path: <SRS0=KWFo=BR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.0 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E10BBC433E1
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Aug 2020 08:38:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C56F522CAE
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Aug 2020 08:38:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728096AbgHGIif (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 7 Aug 2020 04:38:35 -0400
Received: from mx2.suse.de ([195.135.220.15]:59650 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726987AbgHGIie (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 Aug 2020 04:38:34 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id A0329B641;
        Fri,  7 Aug 2020 08:38:49 +0000 (UTC)
From:   Juergen Gross <jgross@suse.com>
To:     xen-devel@lists.xenproject.org, x86@kernel.org,
        linux-kernel@vger.kernel.org
Cc:     Juergen Gross <jgross@suse.com>,
        Boris Ostrovsky <boris.ostrovsky@oracle.com>,
        Stefano Stabellini <sstabellini@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        "H. Peter Anvin" <hpa@zytor.com>
Subject: [PATCH v3 3/7] x86/xen: drop tests for highmem in pv code
Date:   Fri,  7 Aug 2020 10:38:22 +0200
Message-Id: <20200807083826.16794-4-jgross@suse.com>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20200807083826.16794-1-jgross@suse.com>
References: <20200807083826.16794-1-jgross@suse.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

With support for 32-bit pv guests gone pure pv-code no longer needs to
test for highmem. Dropping those tests removes the need for flushing
in some places.

Signed-off-by: Juergen Gross <jgross@suse.com>
---
 arch/x86/xen/enlighten_pv.c |  11 ++-
 arch/x86/xen/mmu_pv.c       | 138 ++++++++++++++----------------------
 2 files changed, 57 insertions(+), 92 deletions(-)

diff --git a/arch/x86/xen/enlighten_pv.c b/arch/x86/xen/enlighten_pv.c
index 7d90b3da8bb4..9fec952f84f3 100644
--- a/arch/x86/xen/enlighten_pv.c
+++ b/arch/x86/xen/enlighten_pv.c
@@ -347,6 +347,7 @@ static void set_aliased_prot(void *v, pgprot_t prot)
 	unsigned long pfn;
 	struct page *page;
 	unsigned char dummy;
+	void *av;
 
 	ptep = lookup_address((unsigned long)v, &level);
 	BUG_ON(ptep == NULL);
@@ -383,14 +384,10 @@ static void set_aliased_prot(void *v, pgprot_t prot)
 	if (HYPERVISOR_update_va_mapping((unsigned long)v, pte, 0))
 		BUG();
 
-	if (!PageHighMem(page)) {
-		void *av = __va(PFN_PHYS(pfn));
+	av = __va(PFN_PHYS(pfn));
 
-		if (av != v)
-			if (HYPERVISOR_update_va_mapping((unsigned long)av, pte, 0))
-				BUG();
-	} else
-		kmap_flush_unused();
+	if (av != v && HYPERVISOR_update_va_mapping((unsigned long)av, pte, 0))
+		BUG();
 
 	preempt_enable();
 }
diff --git a/arch/x86/xen/mmu_pv.c b/arch/x86/xen/mmu_pv.c
index 1f9500d0b839..3774fa6d2ef7 100644
--- a/arch/x86/xen/mmu_pv.c
+++ b/arch/x86/xen/mmu_pv.c
@@ -537,25 +537,26 @@ __visible p4d_t xen_make_p4d(p4dval_t p4d)
 PV_CALLEE_SAVE_REGS_THUNK(xen_make_p4d);
 #endif  /* CONFIG_PGTABLE_LEVELS >= 5 */
 
-static int xen_pmd_walk(struct mm_struct *mm, pmd_t *pmd,
-		int (*func)(struct mm_struct *mm, struct page *, enum pt_level),
-		bool last, unsigned long limit)
+static void xen_pmd_walk(struct mm_struct *mm, pmd_t *pmd,
+			 void (*func)(struct mm_struct *mm, struct page *,
+				      enum pt_level),
+			 bool last, unsigned long limit)
 {
-	int i, nr, flush = 0;
+	int i, nr;
 
 	nr = last ? pmd_index(limit) + 1 : PTRS_PER_PMD;
 	for (i = 0; i < nr; i++) {
 		if (!pmd_none(pmd[i]))
-			flush |= (*func)(mm, pmd_page(pmd[i]), PT_PTE);
+			(*func)(mm, pmd_page(pmd[i]), PT_PTE);
 	}
-	return flush;
 }
 
-static int xen_pud_walk(struct mm_struct *mm, pud_t *pud,
-		int (*func)(struct mm_struct *mm, struct page *, enum pt_level),
-		bool last, unsigned long limit)
+static void xen_pud_walk(struct mm_struct *mm, pud_t *pud,
+			 void (*func)(struct mm_struct *mm, struct page *,
+				      enum pt_level),
+			 bool last, unsigned long limit)
 {
-	int i, nr, flush = 0;
+	int i, nr;
 
 	nr = last ? pud_index(limit) + 1 : PTRS_PER_PUD;
 	for (i = 0; i < nr; i++) {
@@ -566,29 +567,26 @@ static int xen_pud_walk(struct mm_struct *mm, pud_t *pud,
 
 		pmd = pmd_offset(&pud[i], 0);
 		if (PTRS_PER_PMD > 1)
-			flush |= (*func)(mm, virt_to_page(pmd), PT_PMD);
-		flush |= xen_pmd_walk(mm, pmd, func,
-				last && i == nr - 1, limit);
+			(*func)(mm, virt_to_page(pmd), PT_PMD);
+		xen_pmd_walk(mm, pmd, func, last && i == nr - 1, limit);
 	}
-	return flush;
 }
 
-static int xen_p4d_walk(struct mm_struct *mm, p4d_t *p4d,
-		int (*func)(struct mm_struct *mm, struct page *, enum pt_level),
-		bool last, unsigned long limit)
+static void xen_p4d_walk(struct mm_struct *mm, p4d_t *p4d,
+			 void (*func)(struct mm_struct *mm, struct page *,
+				      enum pt_level),
+			 bool last, unsigned long limit)
 {
-	int flush = 0;
 	pud_t *pud;
 
 
 	if (p4d_none(*p4d))
-		return flush;
+		return;
 
 	pud = pud_offset(p4d, 0);
 	if (PTRS_PER_PUD > 1)
-		flush |= (*func)(mm, virt_to_page(pud), PT_PUD);
-	flush |= xen_pud_walk(mm, pud, func, last, limit);
-	return flush;
+		(*func)(mm, virt_to_page(pud), PT_PUD);
+	xen_pud_walk(mm, pud, func, last, limit);
 }
 
 /*
@@ -603,12 +601,12 @@ static int xen_p4d_walk(struct mm_struct *mm, p4d_t *p4d,
  * We must skip the Xen hole in the middle of the address space, just after
  * the big x86-64 virtual hole.
  */
-static int __xen_pgd_walk(struct mm_struct *mm, pgd_t *pgd,
-			  int (*func)(struct mm_struct *mm, struct page *,
-				      enum pt_level),
-			  unsigned long limit)
+static void __xen_pgd_walk(struct mm_struct *mm, pgd_t *pgd,
+			   void (*func)(struct mm_struct *mm, struct page *,
+					enum pt_level),
+			   unsigned long limit)
 {
-	int i, nr, flush = 0;
+	int i, nr;
 	unsigned hole_low = 0, hole_high = 0;
 
 	/* The limit is the last byte to be touched */
@@ -633,22 +631,20 @@ static int __xen_pgd_walk(struct mm_struct *mm, pgd_t *pgd,
 			continue;
 
 		p4d = p4d_offset(&pgd[i], 0);
-		flush |= xen_p4d_walk(mm, p4d, func, i == nr - 1, limit);
+		xen_p4d_walk(mm, p4d, func, i == nr - 1, limit);
 	}
 
 	/* Do the top level last, so that the callbacks can use it as
 	   a cue to do final things like tlb flushes. */
-	flush |= (*func)(mm, virt_to_page(pgd), PT_PGD);
-
-	return flush;
+	(*func)(mm, virt_to_page(pgd), PT_PGD);
 }
 
-static int xen_pgd_walk(struct mm_struct *mm,
-			int (*func)(struct mm_struct *mm, struct page *,
-				    enum pt_level),
-			unsigned long limit)
+static void xen_pgd_walk(struct mm_struct *mm,
+			 void (*func)(struct mm_struct *mm, struct page *,
+				      enum pt_level),
+			 unsigned long limit)
 {
-	return __xen_pgd_walk(mm, mm->pgd, func, limit);
+	__xen_pgd_walk(mm, mm->pgd, func, limit);
 }
 
 /* If we're using split pte locks, then take the page's lock and
@@ -681,26 +677,17 @@ static void xen_do_pin(unsigned level, unsigned long pfn)
 	xen_extend_mmuext_op(&op);
 }
 
-static int xen_pin_page(struct mm_struct *mm, struct page *page,
-			enum pt_level level)
+static void xen_pin_page(struct mm_struct *mm, struct page *page,
+			 enum pt_level level)
 {
 	unsigned pgfl = TestSetPagePinned(page);
-	int flush;
-
-	if (pgfl)
-		flush = 0;		/* already pinned */
-	else if (PageHighMem(page))
-		/* kmaps need flushing if we found an unpinned
-		   highpage */
-		flush = 1;
-	else {
+
+	if (!pgfl) {
 		void *pt = lowmem_page_address(page);
 		unsigned long pfn = page_to_pfn(page);
 		struct multicall_space mcs = __xen_mc_entry(0);
 		spinlock_t *ptl;
 
-		flush = 0;
-
 		/*
 		 * We need to hold the pagetable lock between the time
 		 * we make the pagetable RO and when we actually pin
@@ -737,8 +724,6 @@ static int xen_pin_page(struct mm_struct *mm, struct page *page,
 			xen_mc_callback(xen_pte_unlock, ptl);
 		}
 	}
-
-	return flush;
 }
 
 /* This is called just after a mm has been created, but it has not
@@ -752,14 +737,7 @@ static void __xen_pgd_pin(struct mm_struct *mm, pgd_t *pgd)
 
 	xen_mc_batch();
 
-	if (__xen_pgd_walk(mm, pgd, xen_pin_page, USER_LIMIT)) {
-		/* re-enable interrupts for flushing */
-		xen_mc_issue(0);
-
-		kmap_flush_unused();
-
-		xen_mc_batch();
-	}
+	__xen_pgd_walk(mm, pgd, xen_pin_page, USER_LIMIT);
 
 	xen_do_pin(MMUEXT_PIN_L4_TABLE, PFN_DOWN(__pa(pgd)));
 
@@ -803,11 +781,10 @@ void xen_mm_pin_all(void)
 	spin_unlock(&pgd_lock);
 }
 
-static int __init xen_mark_pinned(struct mm_struct *mm, struct page *page,
-				  enum pt_level level)
+static void __init xen_mark_pinned(struct mm_struct *mm, struct page *page,
+				   enum pt_level level)
 {
 	SetPagePinned(page);
-	return 0;
 }
 
 /*
@@ -823,12 +800,12 @@ static void __init xen_after_bootmem(void)
 	xen_pgd_walk(&init_mm, xen_mark_pinned, FIXADDR_TOP);
 }
 
-static int xen_unpin_page(struct mm_struct *mm, struct page *page,
-			  enum pt_level level)
+static void xen_unpin_page(struct mm_struct *mm, struct page *page,
+			   enum pt_level level)
 {
 	unsigned pgfl = TestClearPagePinned(page);
 
-	if (pgfl && !PageHighMem(page)) {
+	if (pgfl) {
 		void *pt = lowmem_page_address(page);
 		unsigned long pfn = page_to_pfn(page);
 		spinlock_t *ptl = NULL;
@@ -859,8 +836,6 @@ static int xen_unpin_page(struct mm_struct *mm, struct page *page,
 			xen_mc_callback(xen_pte_unlock, ptl);
 		}
 	}
-
-	return 0;		/* never need to flush on unpin */
 }
 
 /* Release a pagetables pages back as normal RW */
@@ -1554,20 +1529,14 @@ static inline void xen_alloc_ptpage(struct mm_struct *mm, unsigned long pfn,
 		if (static_branch_likely(&xen_struct_pages_ready))
 			SetPagePinned(page);
 
-		if (!PageHighMem(page)) {
-			xen_mc_batch();
+		xen_mc_batch();
 
-			__set_pfn_prot(pfn, PAGE_KERNEL_RO);
+		__set_pfn_prot(pfn, PAGE_KERNEL_RO);
 
-			if (level == PT_PTE && USE_SPLIT_PTE_PTLOCKS)
-				__pin_pagetable_pfn(MMUEXT_PIN_L1_TABLE, pfn);
+		if (level == PT_PTE && USE_SPLIT_PTE_PTLOCKS)
+			__pin_pagetable_pfn(MMUEXT_PIN_L1_TABLE, pfn);
 
-			xen_mc_issue(PARAVIRT_LAZY_MMU);
-		} else {
-			/* make sure there are no stray mappings of
-			   this page */
-			kmap_flush_unused();
-		}
+		xen_mc_issue(PARAVIRT_LAZY_MMU);
 	}
 }
 
@@ -1590,16 +1559,15 @@ static inline void xen_release_ptpage(unsigned long pfn, unsigned level)
 	trace_xen_mmu_release_ptpage(pfn, level, pinned);
 
 	if (pinned) {
-		if (!PageHighMem(page)) {
-			xen_mc_batch();
+		xen_mc_batch();
 
-			if (level == PT_PTE && USE_SPLIT_PTE_PTLOCKS)
-				__pin_pagetable_pfn(MMUEXT_UNPIN_TABLE, pfn);
+		if (level == PT_PTE && USE_SPLIT_PTE_PTLOCKS)
+			__pin_pagetable_pfn(MMUEXT_UNPIN_TABLE, pfn);
 
-			__set_pfn_prot(pfn, PAGE_KERNEL);
+		__set_pfn_prot(pfn, PAGE_KERNEL);
+
+		xen_mc_issue(PARAVIRT_LAZY_MMU);
 
-			xen_mc_issue(PARAVIRT_LAZY_MMU);
-		}
 		ClearPagePinned(page);
 	}
 }
-- 
2.26.2

