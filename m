Return-Path: <SRS0=xNW4=3S=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,URIBL_DBL_ABUSE_MALW autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A3567C33CB2
	for <linux-kernel@archiver.kernel.org>; Wed, 29 Jan 2020 10:45:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6BFBE207FD
	for <linux-kernel@archiver.kernel.org>; Wed, 29 Jan 2020 10:45:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="T38JVOu3"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726633AbgA2KpR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 29 Jan 2020 05:45:17 -0500
Received: from bombadil.infradead.org ([198.137.202.133]:59034 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726558AbgA2KpP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Jan 2020 05:45:15 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=Content-Type:MIME-Version:References:
        Subject:Cc:To:From:Date:Message-Id:Sender:Reply-To:Content-Transfer-Encoding:
        Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
        Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:List-Id:List-Help:
        List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=mF2/nIbJW7qxp6R2cN7YamxVRNWJgRj+uf5uunTthjs=; b=T38JVOu3u3AssuCrrnxPGLdw1q
        E+/WTNKiLQ47jzdVvDhzzwp7124Az2KHNKWxpKaMLAosRP0BEkeLgXYOLzjw0BbuHF2qyxhBIufR+
        ETFL5OyYJHbnCGWN6qyWbkaBlidWSRXYJ8hSFYdUleZcOoMGgf06LO8+K/EjYyjmlkD9xsTHtiyr7
        jzBDH+LQ3rBJPENe5zbezoFDWFzvnuwzMP5ucwYYipwHHgaO9ALUhYzKnzMkrEKGQmcntOTYT9nnn
        bodxPtvnOpAkkEJHd5l0F9Ta23gwSg5YTeKM6ryjutaV7bUBzs0AlTOuyK4UenaroTb1PhK2ijlYG
        d6hNFj5A==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by bombadil.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1iwkqM-0001BS-PZ; Wed, 29 Jan 2020 10:45:11 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id CF610306368;
        Wed, 29 Jan 2020 11:43:24 +0100 (CET)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 0)
        id 8E10E2B2E7F41; Wed, 29 Jan 2020 11:45:07 +0100 (CET)
Message-Id: <20200129104345.491163937@infradead.org>
User-Agent: quilt/0.65
Date:   Wed, 29 Jan 2020 11:39:45 +0100
From:   Peter Zijlstra <peterz@infradead.org>
To:     Geert Uytterhoeven <geert@linux-m68k.org>
Cc:     linux-m68k@lists.linux-m68k.org, linux-kernel@vger.kernel.org,
        Will Deacon <will@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>
Subject: [PATCH 4/5] m68k,mm: Extend table allocator for multiple sizes
References: <20200129103941.304769381@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In addition to the PGD/PMD table size (128*4) add a PTE table size
(64*4) to the table allocator. This completely removes the pte-table
overhead compared to the old code, even for dense tables.

Notes:

 - the allocator gained __flush_page_to_ram(), since the old
   page-based allocator had that.

 - the allocator gained a list_empty() check to deal with there not
   being any pages at all.

 - the free mask is extended to cover more than the 8 bits required
   for the (512 byte) PGD/PMD tables.

 - NR_PAGETABLE accounting is restored.

Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
---
 arch/m68k/include/asm/motorola_pgalloc.h |   24 +++++-----
 arch/m68k/mm/init.c                      |    6 +-
 arch/m68k/mm/memory.c                    |   70 ++++++++++++++++++++-----------
 3 files changed, 61 insertions(+), 39 deletions(-)

--- a/arch/m68k/include/asm/motorola_pgalloc.h
+++ b/arch/m68k/include/asm/motorola_pgalloc.h
@@ -5,61 +5,61 @@
 #include <asm/tlb.h>
 #include <asm/tlbflush.h>
 
-extern pmd_t *get_pointer_table(void);
-extern int free_pointer_table(pmd_t *);
+extern void *get_pointer_table(int type);
+extern int free_pointer_table(void *table, int type);
 
 static inline pte_t *pte_alloc_one_kernel(struct mm_struct *mm)
 {
-	return (pte_t *)get_pointer_table();
+	return get_pointer_table(1);
 }
 
 static inline void pte_free_kernel(struct mm_struct *mm, pte_t *pte)
 {
-	free_pointer_table((void *)pte);
+	free_pointer_table(pte, 1);
 }
 
 static inline pgtable_t pte_alloc_one(struct mm_struct *mm)
 {
-	return (pte_t *)get_pointer_table();
+	return get_pointer_table(1);
 }
 
 static inline void pte_free(struct mm_struct *mm, pgtable_t pgtable)
 {
-	free_pointer_table((void *)pgtable);
+	free_pointer_table(pgtable, 1);
 }
 
 static inline void __pte_free_tlb(struct mmu_gather *tlb, pgtable_t pgtable,
 				  unsigned long address)
 {
-	free_pointer_table((void *)pgtable);
+	free_pointer_table(pgtable, 1);
 }
 
 
 static inline pmd_t *pmd_alloc_one(struct mm_struct *mm, unsigned long address)
 {
-	return get_pointer_table();
+	return get_pointer_table(0);
 }
 
 static inline int pmd_free(struct mm_struct *mm, pmd_t *pmd)
 {
-	return free_pointer_table(pmd);
+	return free_pointer_table(pmd, 0);
 }
 
 static inline int __pmd_free_tlb(struct mmu_gather *tlb, pmd_t *pmd,
 				 unsigned long address)
 {
-	return free_pointer_table(pmd);
+	return free_pointer_table(pmd, 0);
 }
 
 
 static inline void pgd_free(struct mm_struct *mm, pgd_t *pgd)
 {
-	pmd_free(mm, (pmd_t *)pgd);
+	free_pointer_table(pgd, 0);
 }
 
 static inline pgd_t *pgd_alloc(struct mm_struct *mm)
 {
-	return (pgd_t *)get_pointer_table();
+	return get_pointer_table(0);
 }
 
 
--- a/arch/m68k/mm/init.c
+++ b/arch/m68k/mm/init.c
@@ -41,7 +41,7 @@ void *empty_zero_page;
 EXPORT_SYMBOL(empty_zero_page);
 
 #if !defined(CONFIG_SUN3) && !defined(CONFIG_COLDFIRE)
-extern void init_pointer_table(unsigned long ptable);
+extern void init_pointer_table(unsigned long ptable, int type);
 #endif
 
 #ifdef CONFIG_MMU
@@ -127,12 +127,12 @@ static inline void init_pointer_tables(v
 	int i;
 
 	/* insert pointer tables allocated so far into the tablelist */
-	init_pointer_table((unsigned long)kernel_pg_dir);
+	init_pointer_table((unsigned long)kernel_pg_dir, 0);
 	for (i = 0; i < PTRS_PER_PGD; i++) {
 		pud_t *pud = (pud_t *)(&kernel_pg_dir[i]);
 
 		if (pud_present(*pud))
-			init_pointer_table(pgd_page_vaddr(kernel_pg_dir[i]));
+			init_pointer_table(pgd_page_vaddr(kernel_pg_dir[i]), 0);
 	}
 #endif
 }
--- a/arch/m68k/mm/memory.c
+++ b/arch/m68k/mm/memory.c
@@ -27,24 +27,34 @@
    arch/sparc/mm/srmmu.c ... */
 
 typedef struct list_head ptable_desc;
-static LIST_HEAD(ptable_list);
+
+static struct list_head ptable_list[2] = {
+	LIST_HEAD_INIT(ptable_list[0]),
+	LIST_HEAD_INIT(ptable_list[1]),
+};
 
 #define PD_PTABLE(page) ((ptable_desc *)&(virt_to_page(page)->lru))
 #define PD_PAGE(ptable) (list_entry(ptable, struct page, lru))
-#define PD_MARKBITS(dp) (*(unsigned char *)&PD_PAGE(dp)->index)
+#define PD_MARKBITS(dp) (*(unsigned int *)&PD_PAGE(dp)->index)
+
+static const int ptable_shift[2] = {
+	7+2, /* PGD, PMD */
+	6+2, /* PTE */
+};
 
-#define PTABLE_SIZE (PTRS_PER_PMD * sizeof(pmd_t))
+#define ptable_size(type) (1U << ptable_shift[type])
+#define ptable_mask(type) ((1U << (PAGE_SIZE / ptable_size(type))) - 1)
 
-void __init init_pointer_table(unsigned long ptable)
+void __init init_pointer_table(unsigned long ptable, int type)
 {
 	ptable_desc *dp;
 	unsigned long page = ptable & PAGE_MASK;
-	unsigned char mask = 1 << ((ptable - page)/PTABLE_SIZE);
+	unsigned int mask = 1U << ((ptable - page)/ptable_size(type));
 
 	dp = PD_PTABLE(page);
 	if (!(PD_MARKBITS(dp) & mask)) {
-		PD_MARKBITS(dp) = 0xff;
-		list_add(dp, &ptable_list);
+		PD_MARKBITS(dp) = ptable_mask(type);
+		list_add(dp, &ptable_list[type]);
 	}
 
 	PD_MARKBITS(dp) &= ~mask;
@@ -57,12 +67,10 @@ void __init init_pointer_table(unsigned
 	return;
 }
 
-pmd_t *get_pointer_table (void)
+void *get_pointer_table (int type)
 {
-	ptable_desc *dp = ptable_list.next;
-	unsigned char mask = PD_MARKBITS (dp);
-	unsigned char tmp;
-	unsigned int off;
+	ptable_desc *dp = ptable_list[type].next;
+	unsigned int mask, tmp, off;
 
 	/*
 	 * For a pointer table for a user process address space, a
@@ -70,38 +78,50 @@ pmd_t *get_pointer_table (void)
 	 * page can hold 8 pointer tables.  The page is remapped in
 	 * virtual address space to be noncacheable.
 	 */
-	if (mask == 0) {
+	if (list_empty(&ptable_list[type]) || PD_MARKBITS(dp) == 0) {
 		void *page;
 		ptable_desc *new;
 
 		if (!(page = (void *)get_zeroed_page(GFP_KERNEL)))
 			return NULL;
 
+		if (type) {
+			/*
+			 * m68k doesn't have SPLIT_PTE_PTLOCKS for not having
+			 * SMP.
+			 */
+			pgtable_pte_page_ctor(virt_to_page(page));
+		}
+
+		__flush_page_to_ram(page);
 		flush_tlb_kernel_page(page);
 		nocache_page(page);
 
 		new = PD_PTABLE(page);
-		PD_MARKBITS(new) = 0xfe;
+		PD_MARKBITS(new) = ptable_mask(type) - 1;
 		list_add_tail(new, dp);
 
 		return (pmd_t *)page;
 	}
 
-	for (tmp = 1, off = 0; (mask & tmp) == 0; tmp <<= 1, off += PTABLE_SIZE)
+	mask = PD_MARKBITS(dp);
+	for (tmp = 1, off = 0; (mask & tmp) == 0; tmp <<= 1, off += ptable_size(type))
 		;
-	PD_MARKBITS(dp) = mask & ~tmp;
-	if (!PD_MARKBITS(dp)) {
+	mask &= ~tmp;
+	PD_MARKBITS(dp) = mask;
+	if (!mask) {
 		/* move to end of list */
-		list_move_tail(dp, &ptable_list);
+		list_move_tail(dp, &ptable_list[type]);
 	}
-	return (pmd_t *) (page_address(PD_PAGE(dp)) + off);
+
+	return page_address(PD_PAGE(dp)) + off;
 }
 
-int free_pointer_table (pmd_t *ptable)
+int free_pointer_table (void *ptable, int type)
 {
 	ptable_desc *dp;
 	unsigned long page = (unsigned long)ptable & PAGE_MASK;
-	unsigned char mask = 1 << (((unsigned long)ptable - page)/PTABLE_SIZE);
+	unsigned int mask = 1U << (((unsigned long)ptable - page)/ptable_size(type));
 
 	dp = PD_PTABLE(page);
 	if (PD_MARKBITS (dp) & mask)
@@ -109,18 +129,20 @@ int free_pointer_table (pmd_t *ptable)
 
 	PD_MARKBITS (dp) |= mask;
 
-	if (PD_MARKBITS(dp) == 0xff) {
+	if (PD_MARKBITS(dp) == ptable_mask(type)) {
 		/* all tables in page are free, free page */
 		list_del(dp);
 		cache_page((void *)page);
+		if (type)
+			pgtable_pte_page_dtor(virt_to_page(page));
 		free_page (page);
 		return 1;
-	} else if (ptable_list.next != dp) {
+	} else if (ptable_list[type].next != dp) {
 		/*
 		 * move this descriptor to the front of the list, since
 		 * it has one or more free tables.
 		 */
-		list_move(dp, &ptable_list);
+		list_move(dp, &ptable_list[type]);
 	}
 	return 0;
 }


