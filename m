Return-Path: <SRS0=flzY=3U=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,URIBL_DBL_ABUSE_MALW autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 043C3C33CB2
	for <linux-kernel@archiver.kernel.org>; Fri, 31 Jan 2020 12:56:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C338320CC7
	for <linux-kernel@archiver.kernel.org>; Fri, 31 Jan 2020 12:56:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="orD9HrRI"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728718AbgAaM4a (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 31 Jan 2020 07:56:30 -0500
Received: from merlin.infradead.org ([205.233.59.134]:39028 "EHLO
        merlin.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728624AbgAaM4I (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 31 Jan 2020 07:56:08 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=merlin.20170209; h=Content-Type:MIME-Version:References:
        Subject:Cc:To:From:Date:Message-Id:Sender:Reply-To:Content-Transfer-Encoding:
        Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
        Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:List-Id:List-Help:
        List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=2ncwAtU/6habEN96Se4NpvcIuiY/ZRaX74et3gpqWsA=; b=orD9HrRIwsy//hfpdmrsUuuogO
        zglhQeg1oIyz5qfFeyK4l4m0Wewrukvo6AQfc2z7Oz1pTqKrLe0SxIBkKctY0r261st4NbL4OPMGe
        pfkG6iFnUjBm2C61Cg3dbJ/BYa6xubEfyVgn1/8ViWvDLIAZ4+sHQKKiHGJz5/mcT6slbaXxqRVBJ
        o7YxOe86qfv94LGhaQ7StkAzqxu+5e6PUGy68CcGxZ34DfJs7cws1fQdrpDo3DNCHaOC4jbcXpklX
        pGRvVBZyBelzmLe3nnpDMhpvrwnuX22IXKjd4yFgHF3nvAsw7KFda0R2z+E1iLRpvQKdMP236vket
        eaHKAMTw==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by merlin.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1ixVq8-0003gL-Jp; Fri, 31 Jan 2020 12:56:04 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 49979306BE4;
        Fri, 31 Jan 2020 13:54:17 +0100 (CET)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 0)
        id 01CA62B634817; Fri, 31 Jan 2020 13:56:01 +0100 (CET)
Message-Id: <20200131125403.882175409@infradead.org>
User-Agent: quilt/0.65
Date:   Fri, 31 Jan 2020 13:45:39 +0100
From:   Peter Zijlstra <peterz@infradead.org>
To:     Geert Uytterhoeven <geert@linux-m68k.org>
Cc:     linux-m68k@lists.linux-m68k.org, linux-kernel@vger.kernel.org,
        Will Deacon <will@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Michael Schmitz <schmitzmic@gmail.com>,
        Greg Ungerer <gerg@linux-m68k.org>
Subject: [PATCH -v2 08/10] m68k,mm: Extend table allocator for multiple sizes
References: <20200131124531.623136425@infradead.org>
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

 - the allocator gained a list_empty() check to deal with there not
   being any pages at all.

 - the free mask is extended to cover more than the 8 bits required
   for the (512 byte) PGD/PMD tables.

 - NR_PAGETABLE accounting is restored.

Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
---
 arch/m68k/include/asm/motorola_pgalloc.h |   31 +++++++++-----
 arch/m68k/mm/init.c                      |   16 +++----
 arch/m68k/mm/motorola.c                  |   65 ++++++++++++++++++++-----------
 3 files changed, 70 insertions(+), 42 deletions(-)

--- a/arch/m68k/include/asm/motorola_pgalloc.h
+++ b/arch/m68k/include/asm/motorola_pgalloc.h
@@ -8,61 +8,68 @@
 extern void mmu_page_ctor(void *page);
 extern void mmu_page_dtor(void *page);
 
-extern pmd_t *get_pointer_table(void);
-extern int free_pointer_table(pmd_t *);
+enum m68k_table_types {
+	TABLE_PGD = 0,
+	TABLE_PMD = 0, /* same size as PGD */
+	TABLE_PTE = 1,
+};
+
+extern void init_pointer_table(void *table, int type);
+extern void *get_pointer_table(int type);
+extern int free_pointer_table(void *table, int type);
 
 static inline pte_t *pte_alloc_one_kernel(struct mm_struct *mm)
 {
-	return (pte_t *)get_pointer_table();
+	return get_pointer_table(TABLE_PTE);
 }
 
 static inline void pte_free_kernel(struct mm_struct *mm, pte_t *pte)
 {
-	free_pointer_table((void *)pte);
+	free_pointer_table(pte, TABLE_PTE);
 }
 
 static inline pgtable_t pte_alloc_one(struct mm_struct *mm)
 {
-	return (pte_t *)get_pointer_table();
+	return get_pointer_table(TABLE_PTE);
 }
 
 static inline void pte_free(struct mm_struct *mm, pgtable_t pgtable)
 {
-	free_pointer_table((void *)pgtable);
+	free_pointer_table(pgtable, TABLE_PTE);
 }
 
 static inline void __pte_free_tlb(struct mmu_gather *tlb, pgtable_t pgtable,
 				  unsigned long address)
 {
-	free_pointer_table((void *)pgtable);
+	free_pointer_table(pgtable, TABLE_PTE);
 }
 
 
 static inline pmd_t *pmd_alloc_one(struct mm_struct *mm, unsigned long address)
 {
-	return get_pointer_table();
+	return get_pointer_table(TABLE_PMD);
 }
 
 static inline int pmd_free(struct mm_struct *mm, pmd_t *pmd)
 {
-	return free_pointer_table(pmd);
+	return free_pointer_table(pmd, TABLE_PMD);
 }
 
 static inline int __pmd_free_tlb(struct mmu_gather *tlb, pmd_t *pmd,
 				 unsigned long address)
 {
-	return free_pointer_table(pmd);
+	return free_pointer_table(pmd, TABLE_PMD);
 }
 
 
 static inline void pgd_free(struct mm_struct *mm, pgd_t *pgd)
 {
-	pmd_free(mm, (pmd_t *)pgd);
+	free_pointer_table(pgd, TABLE_PGD);
 }
 
 static inline pgd_t *pgd_alloc(struct mm_struct *mm)
 {
-	return (pgd_t *)get_pointer_table();
+	return get_pointer_table(TABLE_PGD);
 }
 
 
--- a/arch/m68k/mm/init.c
+++ b/arch/m68k/mm/init.c
@@ -40,10 +40,6 @@
 void *empty_zero_page;
 EXPORT_SYMBOL(empty_zero_page);
 
-#if !defined(CONFIG_SUN3) && !defined(CONFIG_COLDFIRE)
-extern void init_pointer_table(unsigned long ptable);
-#endif
-
 #ifdef CONFIG_MMU
 
 pg_data_t pg_data_map[MAX_NUMNODES];
@@ -127,12 +123,16 @@ static inline void init_pointer_tables(v
 	int i;
 
 	/* insert pointer tables allocated so far into the tablelist */
-	init_pointer_table((unsigned long)kernel_pg_dir);
+	init_pointer_table(kernel_pg_dir, TABLE_PGD);
 	for (i = 0; i < PTRS_PER_PGD; i++) {
-		pud_t *pud = (pud_t *)(&kernel_pg_dir[i]);
+		pud_t *pud = (pud_t *)&kernel_pg_dir[i];
+		pmd_t *pmd_dir;
+
+		if (!pud_present(*pud))
+			continue;
 
-		if (pud_present(*pud))
-			init_pointer_table(pgd_page_vaddr(kernel_pg_dir[i]));
+		pmd_dir = (pmd_t *)pgd_page_vaddr(kernel_pg_dir[i]);
+		init_pointer_table(pmd_dir, TABLE_PMD);
 	}
 #endif
 }
--- a/arch/m68k/mm/motorola.c
+++ b/arch/m68k/mm/motorola.c
@@ -72,24 +72,35 @@ void mmu_page_dtor(void *page)
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
+void __init init_pointer_table(void *table, int type)
 {
 	ptable_desc *dp;
+	unsigned long ptable = (unsigned long)table;
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
@@ -102,12 +113,11 @@ void __init init_pointer_table(unsigned
 	return;
 }
 
-pmd_t *get_pointer_table (void)
+void *get_pointer_table(int type)
 {
-	ptable_desc *dp = ptable_list.next;
-	unsigned char mask = PD_MARKBITS (dp);
-	unsigned char tmp;
-	unsigned int off;
+	ptable_desc *dp = ptable_list[type].next;
+	unsigned int mask = list_empty(&ptable_list[type]) ? 0 : PD_MARKBITS(dp);
+	unsigned int tmp, off;
 
 	/*
 	 * For a pointer table for a user process address space, a
@@ -122,30 +132,39 @@ pmd_t *get_pointer_table (void)
 		if (!(page = (void *)get_zeroed_page(GFP_KERNEL)))
 			return NULL;
 
+		if (type == TABLE_PTE) {
+			/*
+			 * m68k doesn't have SPLIT_PTE_PTLOCKS for not having
+			 * SMP.
+			 */
+			pgtable_pte_page_ctor(virt_to_page(page));
+		}
+
 		mmu_page_ctor(page);
 
 		new = PD_PTABLE(page);
-		PD_MARKBITS(new) = 0xfe;
+		PD_MARKBITS(new) = ptable_mask(type) - 1;
 		list_add_tail(new, dp);
 
 		return (pmd_t *)page;
 	}
 
-	for (tmp = 1, off = 0; (mask & tmp) == 0; tmp <<= 1, off += PTABLE_SIZE)
+	for (tmp = 1, off = 0; (mask & tmp) == 0; tmp <<= 1, off += ptable_size(type))
 		;
 	PD_MARKBITS(dp) = mask & ~tmp;
 	if (!PD_MARKBITS(dp)) {
 		/* move to end of list */
-		list_move_tail(dp, &ptable_list);
+		list_move_tail(dp, &ptable_list[type]);
 	}
-	return (pmd_t *) (page_address(PD_PAGE(dp)) + off);
+	return page_address(PD_PAGE(dp)) + off;
 }
 
-int free_pointer_table (pmd_t *ptable)
+int free_pointer_table(void *table, int type)
 {
 	ptable_desc *dp;
-	unsigned long page = (unsigned long)ptable & PAGE_MASK;
-	unsigned char mask = 1 << (((unsigned long)ptable - page)/PTABLE_SIZE);
+	unsigned long ptable = (unsigned long)table;
+	unsigned long page = ptable & PAGE_MASK;
+	unsigned int mask = 1U << ((ptable - page)/ptable_size(type));
 
 	dp = PD_PTABLE(page);
 	if (PD_MARKBITS (dp) & mask)
@@ -153,18 +172,20 @@ int free_pointer_table (pmd_t *ptable)
 
 	PD_MARKBITS (dp) |= mask;
 
-	if (PD_MARKBITS(dp) == 0xff) {
+	if (PD_MARKBITS(dp) == ptable_mask(type)) {
 		/* all tables in page are free, free page */
 		list_del(dp);
 		mmu_page_dtor((void *)page);
+		if (type == TABLE_PTE)
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


