Return-Path: <SRS0=xNW4=3S=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,URIBL_DBL_ABUSE_MALW autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 91E19C33CB2
	for <linux-kernel@archiver.kernel.org>; Wed, 29 Jan 2020 10:45:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5D9E720732
	for <linux-kernel@archiver.kernel.org>; Wed, 29 Jan 2020 10:45:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="yNtSuSdW"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726719AbgA2KpU (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 29 Jan 2020 05:45:20 -0500
Received: from merlin.infradead.org ([205.233.59.134]:48216 "EHLO
        merlin.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726632AbgA2KpR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Jan 2020 05:45:17 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=merlin.20170209; h=Content-Type:MIME-Version:References:
        Subject:Cc:To:From:Date:Message-Id:Sender:Reply-To:Content-Transfer-Encoding:
        Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
        Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:List-Id:List-Help:
        List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=cKWDLyH34lsKGUb78B0klmtcz2u9EuKcQCo74I6jyeE=; b=yNtSuSdW1EumY55qZ6YMz7b987
        mWMEH0KDZu8DoDXe3Gu3e0al84S8oNCypo5p6puul3Q/Ri3RVPA5FsBuAadOflGHC+nCqrhh5VBzR
        QVXEmmaJT/UQcO3ALJJchukTm8pUkLxgAnMmSeNBeSng4rZi0NennmQCdYyJVQgIJ4UAQicolxyHi
        9awjiXtBnRFhZpDpPprBfKuSTmcnMUb44Gb2wjwZ0TAowt/kr0/hiwjoZ8HOM3SfarINvL6CPBs0y
        jPfUvpLiCgpaHNZeZ5v1XFJ9tAS2QVzSBZ3LjTTHfRILDhgADQHWkBPDZTnnxf8zT8MTXD2LHEWso
        kOb82pxA==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by merlin.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1iwkqN-0001OI-8O; Wed, 29 Jan 2020 10:45:11 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id C795A30607E;
        Wed, 29 Jan 2020 11:43:24 +0100 (CET)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 0)
        id 8266F2B2E7F3D; Wed, 29 Jan 2020 11:45:07 +0100 (CET)
Message-Id: <20200129104345.378213302@infradead.org>
User-Agent: quilt/0.65
Date:   Wed, 29 Jan 2020 11:39:43 +0100
From:   Peter Zijlstra <peterz@infradead.org>
To:     Geert Uytterhoeven <geert@linux-m68k.org>
Cc:     linux-m68k@lists.linux-m68k.org, linux-kernel@vger.kernel.org,
        Will Deacon <will@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>
Subject: [PATCH 2/5] m68k,mm: Improve kernel_page_table()
References: <20200129103941.304769381@infradead.org>
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
 arch/m68k/include/asm/motorola_pgtable.h |   13 ++++++
 arch/m68k/mm/init.c                      |    5 --
 arch/m68k/mm/motorola.c                  |   61 +++++++++++++++++--------------
 3 files changed, 46 insertions(+), 33 deletions(-)

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
@@ -50,29 +50,37 @@ extern __initdata unsigned long m68k_ini
 
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
+		__flush_page_to_ram(pte_table);
+		flush_tlb_kernel_page(pte_table);
+		nocache_page(pte_table);
+
+		last_pte_table = pte_table;
+	}
 
-	ptablep = (pte_t *)memblock_alloc_low(PAGE_SIZE, PAGE_SIZE);
-	if (!ptablep)
-		panic("%s: Failed to allocate %lu bytes align=%lx\n",
-		      __func__, PAGE_SIZE, PAGE_SIZE);
-
-	clear_page(ptablep);
-	__flush_page_to_ram(ptablep);
-	flush_tlb_kernel_page(ptablep);
-	nocache_page(ptablep);
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
 
@@ -91,27 +99,27 @@ static pmd_t * __init kernel_ptr_table(v
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
-		__flush_page_to_ram(last_pgtable);
-		flush_tlb_kernel_page(last_pgtable);
-		nocache_page(last_pgtable);
+		clear_page(last_pmd_table);
+		__flush_page_to_ram(last_pmd_table);
+		flush_tlb_kernel_page(last_pmd_table);
+		nocache_page(last_pmd_table);
 	}
 
-	return last_pgtable;
+	return last_pmd_table;
 }
 
 static void __init map_node(int node)
@@ -174,8 +182,7 @@ static void __init map_node(int node)
 #ifdef DEBUG
 				printk ("[zero map]");
 #endif
-				zero_pgtable = kernel_ptr_table();
-				pte_dir = (pte_t *)zero_pgtable;
+				pte_dir = kernel_page_table();
 				pmd_set(pmd_dir, pte_dir);
 
 				pte_val(*pte_dir++) = 0;


