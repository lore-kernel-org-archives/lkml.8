Return-Path: <SRS0=0vny=62=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.7 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9E8B1C54E8F
	for <linux-kernel@archiver.kernel.org>; Tue, 12 May 2020 14:37:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7F24B206F5
	for <linux-kernel@archiver.kernel.org>; Tue, 12 May 2020 14:37:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730503AbgELOhk (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 12 May 2020 10:37:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39424 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730401AbgELOhM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 May 2020 10:37:12 -0400
Received: from Galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CB735C061A0E;
        Tue, 12 May 2020 07:37:11 -0700 (PDT)
Received: from [5.158.153.53] (helo=tip-bot2.lab.linutronix.de)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tip-bot2@linutronix.de>)
        id 1jYW1m-0005rh-Ag; Tue, 12 May 2020 16:37:02 +0200
Received: from [127.0.1.1] (localhost [IPv6:::1])
        by tip-bot2.lab.linutronix.de (Postfix) with ESMTP id 0F1411C06DA;
        Tue, 12 May 2020 16:37:00 +0200 (CEST)
Date:   Tue, 12 May 2020 14:36:59 -0000
From:   "tip-bot2 for Will Deacon" <tip-bot2@linutronix.de>
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: locking/kcsan] sparc32: mm: Change pgtable_t type to pte_t *
 instead of struct page *
Cc:     Will Deacon <will@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>,
        "David S. Miller" <davem@davemloft.net>, x86 <x86@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
In-Reply-To: <20200511204150.27858-4-will@kernel.org>
References: <20200511204150.27858-4-will@kernel.org>
MIME-Version: 1.0
Message-ID: <158929421995.390.11008436405637547074.tip-bot2@tip-bot2>
X-Mailer: tip-git-log-daemon
Robot-ID: <tip-bot2.linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Linutronix-Spam-Score: -1.0
X-Linutronix-Spam-Level: -
X-Linutronix-Spam-Status: No , -1.0 points, 5.0 required,  ALL_TRUSTED=-1,SHORTCIRCUIT=-0.0001
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following commit has been merged into the locking/kcsan branch of tip:

Commit-ID:     c95be5b549d6af16e1f9b9307f745ef78a01d11c
Gitweb:        https://git.kernel.org/tip/c95be5b549d6af16e1f9b9307f745ef78a01d11c
Author:        Will Deacon <will@kernel.org>
AuthorDate:    Mon, 11 May 2020 21:41:35 +01:00
Committer:     Thomas Gleixner <tglx@linutronix.de>
CommitterDate: Tue, 12 May 2020 11:04:09 +02:00

sparc32: mm: Change pgtable_t type to pte_t * instead of struct page *

Change the 'pgtable_t' type for sparc32 so that it represents the uncached
virtual address of the PTE table, rather than the underlying 'struct page'.

This allows to free page table allocations smaller than a page.

Signed-off-by: Will Deacon <will@kernel.org>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Acked-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Cc: "David S. Miller" <davem@davemloft.net>
Link: https://lkml.kernel.org/r/20200511204150.27858-4-will@kernel.org

---
 arch/sparc/include/asm/page_32.h    |  2 +-
 arch/sparc/include/asm/pgalloc_32.h |  6 +++---
 arch/sparc/include/asm/pgtable_32.h | 11 +++++++++++-
 arch/sparc/mm/srmmu.c               | 29 ++++++++--------------------
 4 files changed, 24 insertions(+), 24 deletions(-)

diff --git a/arch/sparc/include/asm/page_32.h b/arch/sparc/include/asm/page_32.h
index da01c8c..fff8861 100644
--- a/arch/sparc/include/asm/page_32.h
+++ b/arch/sparc/include/asm/page_32.h
@@ -106,7 +106,7 @@ typedef unsigned long iopgprot_t;
 
 #endif
 
-typedef struct page *pgtable_t;
+typedef pte_t *pgtable_t;
 
 #define TASK_UNMAPPED_BASE	0x50000000
 
diff --git a/arch/sparc/include/asm/pgalloc_32.h b/arch/sparc/include/asm/pgalloc_32.h
index 99c0324..b772384 100644
--- a/arch/sparc/include/asm/pgalloc_32.h
+++ b/arch/sparc/include/asm/pgalloc_32.h
@@ -50,11 +50,11 @@ static inline void free_pmd_fast(pmd_t * pmd)
 #define pmd_free(mm, pmd)		free_pmd_fast(pmd)
 #define __pmd_free_tlb(tlb, pmd, addr)	pmd_free((tlb)->mm, pmd)
 
-void pmd_populate(struct mm_struct *mm, pmd_t *pmdp, struct page *ptep);
-#define pmd_pgtable(pmd) pmd_page(pmd)
+#define pmd_populate(mm, pmd, pte)	pmd_set(pmd, pte)
+#define pmd_pgtable(pmd)		(pgtable_t)__pmd_page(pmd)
 
 void pmd_set(pmd_t *pmdp, pte_t *ptep);
-#define pmd_populate_kernel(MM, PMD, PTE) pmd_set(PMD, PTE)
+#define pmd_populate_kernel		pmd_populate
 
 pgtable_t pte_alloc_one(struct mm_struct *mm);
 
diff --git a/arch/sparc/include/asm/pgtable_32.h b/arch/sparc/include/asm/pgtable_32.h
index 3367e2b..c5625b2 100644
--- a/arch/sparc/include/asm/pgtable_32.h
+++ b/arch/sparc/include/asm/pgtable_32.h
@@ -135,6 +135,17 @@ static inline struct page *pmd_page(pmd_t pmd)
 	return pfn_to_page((pmd_val(pmd) & SRMMU_PTD_PMASK) >> (PAGE_SHIFT-4));
 }
 
+static inline unsigned long __pmd_page(pmd_t pmd)
+{
+	unsigned long v;
+
+	if (srmmu_device_memory(pmd_val(pmd)))
+		BUG();
+
+	v = pmd_val(pmd) & SRMMU_PTD_PMASK;
+	return (unsigned long)__nocache_va(v << 4);
+}
+
 static inline unsigned long pud_page_vaddr(pud_t pud)
 {
 	if (srmmu_device_memory(pud_val(pud))) {
diff --git a/arch/sparc/mm/srmmu.c b/arch/sparc/mm/srmmu.c
index 50da4bc..c861c0f 100644
--- a/arch/sparc/mm/srmmu.c
+++ b/arch/sparc/mm/srmmu.c
@@ -140,12 +140,6 @@ void pmd_set(pmd_t *pmdp, pte_t *ptep)
 	set_pte((pte_t *)&pmd_val(*pmdp), __pte(SRMMU_ET_PTD | ptp));
 }
 
-void pmd_populate(struct mm_struct *mm, pmd_t *pmdp, struct page *ptep)
-{
-	unsigned long ptp = page_to_pfn(ptep) << (PAGE_SHIFT-4); /* watch for overflow */
-	set_pte((pte_t *)&pmd_val(*pmdp), __pte(SRMMU_ET_PTD | ptp));
-}
-
 /* Find an entry in the third-level page table.. */
 pte_t *pte_offset_kernel(pmd_t *dir, unsigned long address)
 {
@@ -364,31 +358,26 @@ pgd_t *get_pgd_fast(void)
  */
 pgtable_t pte_alloc_one(struct mm_struct *mm)
 {
-	unsigned long pte;
+	pte_t *ptep;
 	struct page *page;
 
-	if ((pte = (unsigned long)pte_alloc_one_kernel(mm)) == 0)
+	if ((ptep = pte_alloc_one_kernel(mm)) == 0)
 		return NULL;
-	page = pfn_to_page(__nocache_pa(pte) >> PAGE_SHIFT);
+	page = pfn_to_page(__nocache_pa((unsigned long)ptep) >> PAGE_SHIFT);
 	if (!pgtable_pte_page_ctor(page)) {
 		__free_page(page);
 		return NULL;
 	}
-	return page;
+	return ptep;
 }
 
-void pte_free(struct mm_struct *mm, pgtable_t pte)
+void pte_free(struct mm_struct *mm, pgtable_t ptep)
 {
-	unsigned long p;
-
-	pgtable_pte_page_dtor(pte);
-	p = (unsigned long)page_address(pte);	/* Cached address (for test) */
-	if (p == 0)
-		BUG();
-	p = page_to_pfn(pte) << PAGE_SHIFT;	/* Physical address */
+	struct page *page;
 
-	/* free non cached virtual address*/
-	srmmu_free_nocache(__nocache_va(p), SRMMU_PTE_TABLE_SIZE);
+	page = pfn_to_page(__nocache_pa((unsigned long)ptep) >> PAGE_SHIFT);
+	pgtable_pte_page_dtor(page);
+	srmmu_free_nocache(ptep, SRMMU_PTE_TABLE_SIZE);
 }
 
 /* context handling - a dynamically sized pool is used */
