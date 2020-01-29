Return-Path: <SRS0=xNW4=3S=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,URIBL_DBL_ABUSE_MALW autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6D279C35240
	for <linux-kernel@archiver.kernel.org>; Wed, 29 Jan 2020 10:45:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 36DEC20720
	for <linux-kernel@archiver.kernel.org>; Wed, 29 Jan 2020 10:45:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="qac8stnl"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726541AbgA2KpO (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 29 Jan 2020 05:45:14 -0500
Received: from bombadil.infradead.org ([198.137.202.133]:59032 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726184AbgA2KpO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Jan 2020 05:45:14 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=Content-Type:MIME-Version:References:
        Subject:Cc:To:From:Date:Message-Id:Sender:Reply-To:Content-Transfer-Encoding:
        Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
        Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:List-Id:List-Help:
        List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=5frOrssk50zd7j0cykjQNlB4hyTCdivtF9YQgSUjvHs=; b=qac8stnld6ZZvrLb4aWF4GCgnW
        LTgIi43I3+J0kp0pNhYHbynHOWjJArzl5waLrlABwEVPHr/b+zluWjmmoddQ6U+guCoourt6EJPKz
        iC1v/JRGBWFqt+j2QrZWKLke33cSNYNrGgTytD8G9bhWqp3EBwe8jtpQ4P8UjRpCAGu9vsUGHgMLN
        Qq96pzZ/1yoWUJxCBrBL9JmR57vZFcranp//VJH+ulTu3OGEKAJca+REMsFUKG9nMDL5Z45TL3Nr/
        jNyxOf57fndppxP9dRH1FGrlqd76g2VuXrZu0xeLeJfPYwEVM8CbKI23RVvdn+RRZHVBYIVxKhe/x
        wT8USpLA==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by bombadil.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1iwkqM-0001Cz-PU; Wed, 29 Jan 2020 10:45:11 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id C492F30600B;
        Wed, 29 Jan 2020 11:43:24 +0100 (CET)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 0)
        id 801C2203C0A05; Wed, 29 Jan 2020 11:45:07 +0100 (CET)
Message-Id: <20200129104345.321146759@infradead.org>
User-Agent: quilt/0.65
Date:   Wed, 29 Jan 2020 11:39:42 +0100
From:   Peter Zijlstra <peterz@infradead.org>
To:     Geert Uytterhoeven <geert@linux-m68k.org>
Cc:     linux-m68k@lists.linux-m68k.org, linux-kernel@vger.kernel.org,
        Will Deacon <will@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>
Subject: [PATCH 1/5] m68k,mm: Restructure motorola mmu page-table layout
References: <20200129103941.304769381@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The Motorola 68xxx MMUs, 040 (and later) have a fixed 7,7,{5,6}
page-table setup, where the last depends on the page-size selected (8k
vs 4k resp.), and head.S selects 4K pages. For 030 (and earlier) we
explicitly program 7,7,6 and 4K pages in %tc.

However, the current code implements this mightily weird. What it does
is group 16 of those (6 bit) pte tables into one 4k page to not waste
space. The down-side is that that forces pmd_t to be a 16-tuple
pointing to consecutive pte tables.

This breaks the generic code which assumes READ_ONCE(*pmd) will be
word sized.

Therefore implement a straight forward 7,7,6 3 level page-table setup,
with the addition (for 020/030) of (partial) large-page support. For
now this increases the memory footprint for pte-tables 15 fold.

Tested with ARAnyM/68040 emulation.

Suggested-by: Will Deacon <will@kernel.org>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
---
 arch/m68k/include/asm/motorola_pgtable.h |   15 +-----------
 arch/m68k/include/asm/page.h             |    6 ++---
 arch/m68k/include/asm/pgtable_mm.h       |   10 ++++----
 arch/m68k/mm/kmap.c                      |   36 +++++++++++++------------------
 arch/m68k/mm/motorola.c                  |   28 +++++++++++-------------
 5 files changed, 39 insertions(+), 56 deletions(-)

--- a/arch/m68k/include/asm/motorola_pgtable.h
+++ b/arch/m68k/include/asm/motorola_pgtable.h
@@ -108,13 +108,7 @@ static inline pte_t pte_modify(pte_t pte
 
 static inline void pmd_set(pmd_t *pmdp, pte_t *ptep)
 {
-	unsigned long ptbl = virt_to_phys(ptep) | _PAGE_TABLE | _PAGE_ACCESSED;
-	unsigned long *ptr = pmdp->pmd;
-	short i = 16;
-	while (--i >= 0) {
-		*ptr++ = ptbl;
-		ptbl += (sizeof(pte_t)*PTRS_PER_PTE/16);
-	}
+	pmd_val(*pmdp) = virt_to_phys(ptep) | _PAGE_TABLE | _PAGE_ACCESSED;
 }
 
 static inline void pud_set(pud_t *pudp, pmd_t *pmdp)
@@ -138,12 +132,7 @@ static inline void pud_set(pud_t *pudp,
 #define pmd_none(pmd)		(!pmd_val(pmd))
 #define pmd_bad(pmd)		((pmd_val(pmd) & _DESCTYPE_MASK) != _PAGE_TABLE)
 #define pmd_present(pmd)	(pmd_val(pmd) & _PAGE_TABLE)
-#define pmd_clear(pmdp) ({			\
-	unsigned long *__ptr = pmdp->pmd;	\
-	short __i = 16;				\
-	while (--__i >= 0)			\
-		*__ptr++ = 0;			\
-})
+#define pmd_clear(pmdp)		({ pmd_val(*pmdp) = 0; })
 #define pmd_page(pmd)		virt_to_page(__va(pmd_val(pmd)))
 
 
--- a/arch/m68k/include/asm/page.h
+++ b/arch/m68k/include/asm/page.h
@@ -22,9 +22,9 @@
  * These are used to make use of C type-checking..
  */
 #if !defined(CONFIG_MMU) || CONFIG_PGTABLE_LEVELS == 3
-typedef struct { unsigned long pmd[16]; } pmd_t;
-#define pmd_val(x)	((&x)->pmd[0])
-#define __pmd(x)	((pmd_t) { { (x) }, })
+typedef struct { unsigned long pmd; } pmd_t;
+#define pmd_val(x)	((&x)->pmd)
+#define __pmd(x)	((pmd_t) { (x) } )
 #endif
 
 typedef struct { unsigned long pte; } pte_t;
--- a/arch/m68k/include/asm/pgtable_mm.h
+++ b/arch/m68k/include/asm/pgtable_mm.h
@@ -36,7 +36,7 @@
 
 /* PMD_SHIFT determines the size of the area a second-level page table can map */
 #if CONFIG_PGTABLE_LEVELS == 3
-#define PMD_SHIFT	22
+#define PMD_SHIFT	18
 #endif
 #define PMD_SIZE	(1UL << PMD_SHIFT)
 #define PMD_MASK	(~(PMD_SIZE-1))
@@ -67,8 +67,8 @@
 #define PTRS_PER_PMD	1
 #define PTRS_PER_PGD	1024
 #else
-#define PTRS_PER_PTE	1024
-#define PTRS_PER_PMD	8
+#define PTRS_PER_PTE	64
+#define PTRS_PER_PMD	128
 #define PTRS_PER_PGD	128
 #endif
 #define USER_PTRS_PER_PGD	(TASK_SIZE/PGDIR_SIZE)
@@ -76,8 +76,8 @@
 
 /* Virtual address region for use by kernel_map() */
 #ifdef CONFIG_SUN3
-#define KMAP_START     0x0DC00000
-#define KMAP_END       0x0E000000
+#define KMAP_START	0x0dc00000
+#define KMAP_END	0x0e000000
 #elif defined(CONFIG_COLDFIRE)
 #define KMAP_START	0xe0000000
 #define KMAP_END	0xf0000000
--- a/arch/m68k/mm/kmap.c
+++ b/arch/m68k/mm/kmap.c
@@ -24,8 +24,6 @@
 
 #undef DEBUG
 
-#define PTRTREESIZE	(256*1024)
-
 /*
  * For 040/060 we can use the virtual memory area like other architectures,
  * but for 020/030 we want to use early termination page descriptors and we
@@ -50,7 +48,7 @@ static inline void free_io_area(void *ad
 
 #else
 
-#define IO_SIZE		(256*1024)
+#define IO_SIZE		PMD_SIZE
 
 static struct vm_struct *iolist;
 
@@ -81,14 +79,13 @@ static void __free_io_area(void *addr, u
 
 #if CONFIG_PGTABLE_LEVELS == 3
 		if (CPU_IS_020_OR_030) {
-			int pmd_off = (virtaddr/PTRTREESIZE) & 15;
-			int pmd_type = pmd_dir->pmd[pmd_off] & _DESCTYPE_MASK;
+			int pmd_type = pmd_val(*pmd_dir) & _DESCTYPE_MASK;
 
 			if (pmd_type == _PAGE_PRESENT) {
-				pmd_dir->pmd[pmd_off] = 0;
-				virtaddr += PTRTREESIZE;
-				size -= PTRTREESIZE;
-				continue;
+				pmd_clear(pmd_dir);
+				virtaddr += PMD_SIZE;
+				size -= PMD_SIZE;
+
 			} else if (pmd_type == 0)
 				continue;
 		}
@@ -249,7 +246,7 @@ void __iomem *__ioremap(unsigned long ph
 
 	while ((long)size > 0) {
 #ifdef DEBUG
-		if (!(virtaddr & (PTRTREESIZE-1)))
+		if (!(virtaddr & (PMD_SIZE-1)))
 			printk ("\npa=%#lx va=%#lx ", physaddr, virtaddr);
 #endif
 		pgd_dir = pgd_offset_k(virtaddr);
@@ -263,10 +260,10 @@ void __iomem *__ioremap(unsigned long ph
 
 #if CONFIG_PGTABLE_LEVELS == 3
 		if (CPU_IS_020_OR_030) {
-			pmd_dir->pmd[(virtaddr/PTRTREESIZE) & 15] = physaddr;
-			physaddr += PTRTREESIZE;
-			virtaddr += PTRTREESIZE;
-			size -= PTRTREESIZE;
+			pmd_val(*pmd_dir) = physaddr;
+			physaddr += PMD_SIZE;
+			virtaddr += PMD_SIZE;
+			size -= PMD_SIZE;
 		} else
 #endif
 		{
@@ -367,13 +364,12 @@ void kernel_set_cachemode(void *addr, un
 
 #if CONFIG_PGTABLE_LEVELS == 3
 		if (CPU_IS_020_OR_030) {
-			int pmd_off = (virtaddr/PTRTREESIZE) & 15;
+			unsigned long pmd = pmd_val(*pmd_dir);
 
-			if ((pmd_dir->pmd[pmd_off] & _DESCTYPE_MASK) == _PAGE_PRESENT) {
-				pmd_dir->pmd[pmd_off] = (pmd_dir->pmd[pmd_off] &
-							 _CACHEMASK040) | cmode;
-				virtaddr += PTRTREESIZE;
-				size -= PTRTREESIZE;
+			if ((pmd & _DESCTYPE_MASK) == _PAGE_PRESENT) {
+				*pmd_dir = __pmd((pmd & _CACHEMASK040) | cmode);
+				virtaddr += PMD_SIZE;
+				size -= PMD_SIZE;
 				continue;
 			}
 		}
--- a/arch/m68k/mm/motorola.c
+++ b/arch/m68k/mm/motorola.c
@@ -116,8 +116,6 @@ static pmd_t * __init kernel_ptr_table(v
 
 static void __init map_node(int node)
 {
-#define PTRTREESIZE (256*1024)
-#define ROOTTREESIZE (32*1024*1024)
 	unsigned long physaddr, virtaddr, size;
 	pgd_t *pgd_dir;
 	p4d_t *p4d_dir;
@@ -135,21 +133,21 @@ static void __init map_node(int node)
 
 	while (size > 0) {
 #ifdef DEBUG
-		if (!(virtaddr & (PTRTREESIZE-1)))
+		if (!(virtaddr & (PMD_SIZE-1)))
 			printk ("\npa=%#lx va=%#lx ", physaddr & PAGE_MASK,
 				virtaddr);
 #endif
 		pgd_dir = pgd_offset_k(virtaddr);
 		if (virtaddr && CPU_IS_020_OR_030) {
-			if (!(virtaddr & (ROOTTREESIZE-1)) &&
-			    size >= ROOTTREESIZE) {
+			if (!(virtaddr & (PGDIR_SIZE-1)) &&
+			    size >= PGDIR_SIZE) {
 #ifdef DEBUG
 				printk ("[very early term]");
 #endif
 				pgd_val(*pgd_dir) = physaddr;
-				size -= ROOTTREESIZE;
-				virtaddr += ROOTTREESIZE;
-				physaddr += ROOTTREESIZE;
+				size -= PGDIR_SIZE;
+				virtaddr += PGDIR_SIZE;
+				physaddr += PGDIR_SIZE;
 				continue;
 			}
 		}
@@ -169,8 +167,8 @@ static void __init map_node(int node)
 #ifdef DEBUG
 				printk ("[early term]");
 #endif
-				pmd_dir->pmd[(virtaddr/PTRTREESIZE) & 15] = physaddr;
-				physaddr += PTRTREESIZE;
+				pmd_val(*pmd_dir) = physaddr;
+				physaddr += PMD_SIZE;
 			} else {
 				int i;
 #ifdef DEBUG
@@ -178,15 +176,15 @@ static void __init map_node(int node)
 #endif
 				zero_pgtable = kernel_ptr_table();
 				pte_dir = (pte_t *)zero_pgtable;
-				pmd_dir->pmd[0] = virt_to_phys(pte_dir) |
-					_PAGE_TABLE | _PAGE_ACCESSED;
+				pmd_set(pmd_dir, pte_dir);
+
 				pte_val(*pte_dir++) = 0;
 				physaddr += PAGE_SIZE;
-				for (i = 1; i < 64; physaddr += PAGE_SIZE, i++)
+				for (i = 1; i < PTRS_PER_PTE; physaddr += PAGE_SIZE, i++)
 					pte_val(*pte_dir++) = physaddr;
 			}
-			size -= PTRTREESIZE;
-			virtaddr += PTRTREESIZE;
+			size -= PMD_SIZE;
+			virtaddr += PMD_SIZE;
 		} else {
 			if (!pmd_present(*pmd_dir)) {
 #ifdef DEBUG


