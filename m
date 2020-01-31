Return-Path: <SRS0=flzY=3U=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,URIBL_DBL_ABUSE_MALW autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 18668C33CB2
	for <linux-kernel@archiver.kernel.org>; Fri, 31 Jan 2020 12:56:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D528920CC7
	for <linux-kernel@archiver.kernel.org>; Fri, 31 Jan 2020 12:56:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="xVcegotK"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728678AbgAaM4P (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 31 Jan 2020 07:56:15 -0500
Received: from merlin.infradead.org ([205.233.59.134]:39048 "EHLO
        merlin.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728644AbgAaM4L (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 31 Jan 2020 07:56:11 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=merlin.20170209; h=Content-Type:MIME-Version:References:
        Subject:Cc:To:From:Date:Message-Id:Sender:Reply-To:Content-Transfer-Encoding:
        Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
        Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:List-Id:List-Help:
        List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=9skKaSN5kw8RVXS0KFaUHnOcBBS9aO6l/jJdROgaDeo=; b=xVcegotKbyYCMjU5l0POryyHJh
        wHoA6aXc98yatIPWzAjJRV/fcfF+hoplYK5Y1YwpB6J1EEpArFG4adt3Qhby4gmE7zIvQVHS/h7Xx
        HlhebsIXh+tf6BTLZiOLXriNWv+j3A8/nQhQVuUM3GqjSoSyHTJlJHaYzoGDMGomBZ61L9L8jSA86
        sxLj0/jgaTV7k/5SnipM1PnoIMvJShlf8glgCmtPTl7iMrq0cxyoMiwfoDPyU733dBGS7Tm3JQ4Yd
        h/u71zVNaIW8mEm2hKDjzjXFUM9DMjgLwRybetx1CRNg3vfhAo6uG9g66Tqh3dbYBUQTUHwboBU3u
        2c2PMzVQ==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by merlin.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1ixVq8-0003gJ-EX; Fri, 31 Jan 2020 12:56:04 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 45FC23062C2;
        Fri, 31 Jan 2020 13:54:17 +0100 (CET)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 0)
        id EE0922B4F2915; Fri, 31 Jan 2020 13:56:00 +0100 (CET)
Message-Id: <20200131125403.768263973@infradead.org>
User-Agent: quilt/0.65
Date:   Fri, 31 Jan 2020 13:45:37 +0100
From:   Peter Zijlstra <peterz@infradead.org>
To:     Geert Uytterhoeven <geert@linux-m68k.org>
Cc:     linux-m68k@lists.linux-m68k.org, linux-kernel@vger.kernel.org,
        Will Deacon <will@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Michael Schmitz <schmitzmic@gmail.com>,
        Greg Ungerer <gerg@linux-m68k.org>
Subject: [PATCH -v2 06/10] m68k,mm: Improve kernel_page_table()
References: <20200131124531.623136425@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

With the PTE-tables now only being 256 bytes, allocating a full page
for them is a giant waste. Start by improving the boot time allocator
such that init_mm initialization will at least have optimal memory
density.

Much thanks to Will Deacon in help with debugging and ferreting out
lost information on these dusty MMUs.

Notes:

 - _TABLE_MASK is reduced to account for the shorter (256 byte)
   alignment of pte-tables, per the manual, table entries should only
   ever have state in the low 4 bits (Used,WrProt,Desc1,Desc0) so it is
   still longer than strictly required. (Thanks Will!!!)

 - Also use kernel_page_table() for the 020/030 zero_pgtable case and
   consequently remove the zero_pgtable init hack (will fix up later).

Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
---
 arch/m68k/include/asm/motorola_pgtable.h |   13 +++++++
 arch/m68k/mm/init.c                      |    5 ---
 arch/m68k/mm/motorola.c                  |   51 +++++++++++++++++--------------
 3 files changed, 41 insertions(+), 28 deletions(-)

--- a/arch/m68k/include/asm/motorola_pgtable.h
+++ b/arch/m68k/include/asm/motorola_pgtable.h
@@ -23,7 +23,18 @@
 #define _DESCTYPE_MASK	0x003
 
 #define _CACHEMASK040	(~0x060)
-#define _TABLE_MASK	(0xfffffe00)
+
+/*
+ * Currently set to the minimum alignment of table pointers (256 bytes).
+ * The hardware only uses the low 4 bits for state:
+ *
+ *    3 - Used
+ *    2 - Write Protected
+ *  0,1 - Desciptor Type
+ *
+ * and has the rest of the bits reserved.
+ */
+#define _TABLE_MASK	(0xffffff00)
 
 #define _PAGE_TABLE	(_PAGE_SHORT)
 #define _PAGE_CHG_MASK  (PAGE_MASK | _PAGE_ACCESSED | _PAGE_DIRTY | _PAGE_NOCACHE)
--- a/arch/m68k/mm/init.c
+++ b/arch/m68k/mm/init.c
@@ -42,7 +42,6 @@ EXPORT_SYMBOL(empty_zero_page);
 
 #if !defined(CONFIG_SUN3) && !defined(CONFIG_COLDFIRE)
 extern void init_pointer_table(unsigned long ptable);
-extern pmd_t *zero_pgtable;
 #endif
 
 #ifdef CONFIG_MMU
@@ -135,10 +134,6 @@ static inline void init_pointer_tables(v
 		if (pud_present(*pud))
 			init_pointer_table(pgd_page_vaddr(kernel_pg_dir[i]));
 	}
-
-	/* insert also pointer table that we used to unmap the zero page */
-	if (zero_pgtable)
-		init_pointer_table((unsigned long)zero_pgtable);
 #endif
 }
 
--- a/arch/m68k/mm/motorola.c
+++ b/arch/m68k/mm/motorola.c
@@ -72,27 +72,35 @@ extern __initdata unsigned long m68k_ini
 
 extern unsigned long availmem;
 
+static pte_t *last_pte_table __initdata = NULL;
+
 static pte_t * __init kernel_page_table(void)
 {
-	pte_t *ptablep;
+	pte_t *pte_table = last_pte_table;
+
+	if (((unsigned long)last_pte_table & ~PAGE_MASK) == 0) {
+		pte_table = (pte_t *)memblock_alloc_low(PAGE_SIZE, PAGE_SIZE);
+		if (!pte_table) {
+			panic("%s: Failed to allocate %lu bytes align=%lx\n",
+					__func__, PAGE_SIZE, PAGE_SIZE);
+		}
+
+		clear_page(pte_table);
+		mmu_page_ctor(pte_table);
 
-	ptablep = (pte_t *)memblock_alloc_low(PAGE_SIZE, PAGE_SIZE);
-	if (!ptablep)
-		panic("%s: Failed to allocate %lu bytes align=%lx\n",
-		      __func__, PAGE_SIZE, PAGE_SIZE);
+		last_pte_table = pte_table;
+	}
 
-	clear_page(ptablep);
-	mmu_page_ctor(ptablep);
+	last_pte_table += PTRS_PER_PTE;
 
-	return ptablep;
+	return pte_table;
 }
 
-static pmd_t *last_pgtable __initdata = NULL;
-pmd_t *zero_pgtable __initdata = NULL;
+static pmd_t *last_pmd_table __initdata = NULL;
 
 static pmd_t * __init kernel_ptr_table(void)
 {
-	if (!last_pgtable) {
+	if (!last_pmd_table) {
 		unsigned long pmd, last;
 		int i;
 
@@ -111,25 +119,25 @@ static pmd_t * __init kernel_ptr_table(v
 				last = pmd;
 		}
 
-		last_pgtable = (pmd_t *)last;
+		last_pmd_table = (pmd_t *)last;
 #ifdef DEBUG
-		printk("kernel_ptr_init: %p\n", last_pgtable);
+		printk("kernel_ptr_init: %p\n", last_pmd_table);
 #endif
 	}
 
-	last_pgtable += PTRS_PER_PMD;
-	if (((unsigned long)last_pgtable & ~PAGE_MASK) == 0) {
-		last_pgtable = (pmd_t *)memblock_alloc_low(PAGE_SIZE,
+	last_pmd_table += PTRS_PER_PMD;
+	if (((unsigned long)last_pmd_table & ~PAGE_MASK) == 0) {
+		last_pmd_table = (pmd_t *)memblock_alloc_low(PAGE_SIZE,
 							   PAGE_SIZE);
-		if (!last_pgtable)
+		if (!last_pmd_table)
 			panic("%s: Failed to allocate %lu bytes align=%lx\n",
 			      __func__, PAGE_SIZE, PAGE_SIZE);
 
-		clear_page(last_pgtable);
-		mmu_page_ctor(last_pgtable);
+		clear_page(last_pmd_table);
+		mmu_page_ctor(last_pmd_table);
 	}
 
-	return last_pgtable;
+	return last_pmd_table;
 }
 
 static void __init map_node(int node)
@@ -192,8 +200,7 @@ static void __init map_node(int node)
 #ifdef DEBUG
 				printk ("[zero map]");
 #endif
-				zero_pgtable = kernel_ptr_table();
-				pte_dir = (pte_t *)zero_pgtable;
+				pte_dir = kernel_page_table();
 				pmd_set(pmd_dir, pte_dir);
 
 				pte_val(*pte_dir++) = 0;


