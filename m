Return-Path: <SRS0=QqoS=AI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7F57EC433E0
	for <linux-kernel@archiver.kernel.org>; Sat, 27 Jun 2020 08:17:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 56B882080C
	for <linux-kernel@archiver.kernel.org>; Sat, 27 Jun 2020 08:17:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1593245851;
	bh=bx9KLSFLdGSv6yxlwrHpM9s3B00/UStRmHuswAZu/F8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=UNFNGbckxm+8E3GGIc25RpIyJ443g3046ZlthbhfOac30PTMvBQvMeyZsovPLlxIv
	 BunAnlU1e1dpJlwkjjQhkdqLzp/xKQoPJbOt2Uez9C1YTcd9jGQiKn9WSqW596tt6w
	 yUagco8awbl2HRaRMkyQbWrLo7lBjBB36OfQ3nAQ=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726448AbgF0IR3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 27 Jun 2020 04:17:29 -0400
Received: from mail.kernel.org ([198.145.29.99]:51608 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725900AbgF0IR2 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 27 Jun 2020 04:17:28 -0400
Received: from aquarius.haifa.ibm.com (nesher1.haifa.il.ibm.com [195.110.40.7])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id E78D22080C;
        Sat, 27 Jun 2020 08:17:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1593245847;
        bh=bx9KLSFLdGSv6yxlwrHpM9s3B00/UStRmHuswAZu/F8=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=HLsAxDlhu9peiDRGm42AmnHwmdxNLeX+5vyJdA9H00PPXL1Uz1guNAYGwdCjls/s1
         t3fcBZhgP/JABf8HyibFlmJ5Qc//Q/ryvoSCK+Vf73G+tAjcRTYvv+eATJyO5lO88Q
         ZzwhqyhGSJNLrupWufetzZc+XXfsmDBLwPtHQLBY=
From:   Mike Rapoport <rppt@kernel.org>
To:     sparclinux@vger.kernel.org
Cc:     David Miller <davem@davemloft.net>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Mike Rapoport <rppt@kernel.org>, linux-kernel@vger.kernel.org,
        Mike Rapoport <rppt@linux.ibm.com>
Subject: [PATCH v2 2/2] sparc32: srmmu: improve type safety of __nocache_fix()
Date:   Sat, 27 Jun 2020 11:16:53 +0300
Message-Id: <20200627081653.25311-3-rppt@kernel.org>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20200627081653.25311-1-rppt@kernel.org>
References: <20200627081653.25311-1-rppt@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Mike Rapoport <rppt@linux.ibm.com>

The __nocache_fix(VADDR) macro is used to add an offset for pointers and
its "return type" is 'void *'.

We can do better and keep the type information with simply by casting the
return value to (__typeof__(VADDR)).

This will  ".. show when those pgd/p4d/pud pointers get mis-used because
they don't end up dropping the type info.."

The addition of the casting to __nocache_fix() also allows to remove
explicit casts at its call sites.

Suggested-by: Linus Torvalds <torvalds@linux-foundation.org>
Signed-off-by: Mike Rapoport <rppt@linux.ibm.com>
Link: https://lkml.kernel.org/r/CAHk-=wisORTa7QVPnFqNw9pFs62UiwgsD4C4d=MtYy1o4JPyGQ@mail.gmail.com
---
 arch/sparc/include/asm/pgtsrmmu.h |  2 +-
 arch/sparc/mm/srmmu.c             | 16 ++++++++--------
 2 files changed, 9 insertions(+), 9 deletions(-)

diff --git a/arch/sparc/include/asm/pgtsrmmu.h b/arch/sparc/include/asm/pgtsrmmu.h
index 7708d015712b..6067925972d9 100644
--- a/arch/sparc/include/asm/pgtsrmmu.h
+++ b/arch/sparc/include/asm/pgtsrmmu.h
@@ -113,7 +113,7 @@ extern unsigned long last_valid_pfn;
 extern void *srmmu_nocache_pool;
 #define __nocache_pa(VADDR) (((unsigned long)VADDR) - SRMMU_NOCACHE_VADDR + __pa((unsigned long)srmmu_nocache_pool))
 #define __nocache_va(PADDR) (__va((unsigned long)PADDR) - (unsigned long)srmmu_nocache_pool + SRMMU_NOCACHE_VADDR)
-#define __nocache_fix(VADDR) __va(__nocache_pa(VADDR))
+#define __nocache_fix(VADDR) ((__typeof__(VADDR))__va(__nocache_pa(VADDR)))
 
 /* Accessing the MMU control register. */
 unsigned int srmmu_get_mmureg(void);
diff --git a/arch/sparc/mm/srmmu.c b/arch/sparc/mm/srmmu.c
index f5fa07958f34..da4e10b4cb37 100644
--- a/arch/sparc/mm/srmmu.c
+++ b/arch/sparc/mm/srmmu.c
@@ -689,7 +689,7 @@ static void __init srmmu_early_allocate_ptable_skeleton(unsigned long start,
 		pgdp = pgd_offset_k(start);
 		p4dp = p4d_offset(pgdp, start);
 		pudp = pud_offset(p4dp, start);
-		if (pud_none(*(pud_t *)__nocache_fix(pudp))) {
+		if (pud_none(*__nocache_fix(pudp))) {
 			pmdp = __srmmu_get_nocache(
 			    SRMMU_PMD_TABLE_SIZE, SRMMU_PMD_TABLE_SIZE);
 			if (pmdp == NULL)
@@ -698,7 +698,7 @@ static void __init srmmu_early_allocate_ptable_skeleton(unsigned long start,
 			pud_set(__nocache_fix(pudp), pmdp);
 		}
 		pmdp = pmd_offset(__nocache_fix(pudp), start);
-		if (srmmu_pmd_none(*(pmd_t *)__nocache_fix(pmdp))) {
+		if (srmmu_pmd_none(*__nocache_fix(pmdp))) {
 			ptep = __srmmu_get_nocache(PTE_SIZE, PTE_SIZE);
 			if (ptep == NULL)
 				early_pgtable_allocfail("pte");
@@ -810,11 +810,11 @@ static void __init srmmu_inherit_prom_mappings(unsigned long start,
 		p4dp = p4d_offset(pgdp, start);
 		pudp = pud_offset(p4dp, start);
 		if (what == 2) {
-			*(pgd_t *)__nocache_fix(pgdp) = __pgd(probed);
+			*__nocache_fix(pgdp) = __pgd(probed);
 			start += PGDIR_SIZE;
 			continue;
 		}
-		if (pud_none(*(pud_t *)__nocache_fix(pudp))) {
+		if (pud_none(*__nocache_fix(pudp))) {
 			pmdp = __srmmu_get_nocache(SRMMU_PMD_TABLE_SIZE,
 						   SRMMU_PMD_TABLE_SIZE);
 			if (pmdp == NULL)
@@ -828,7 +828,7 @@ static void __init srmmu_inherit_prom_mappings(unsigned long start,
 			start += PMD_SIZE;
 			continue;
 		}
-		if (srmmu_pmd_none(*(pmd_t *)__nocache_fix(pmdp))) {
+		if (srmmu_pmd_none(*__nocache_fix(pmdp))) {
 			ptep = __srmmu_get_nocache(PTE_SIZE, PTE_SIZE);
 			if (ptep == NULL)
 				early_pgtable_allocfail("pte");
@@ -836,7 +836,7 @@ static void __init srmmu_inherit_prom_mappings(unsigned long start,
 			pmd_set(__nocache_fix(pmdp), ptep);
 		}
 		ptep = pte_offset_kernel(__nocache_fix(pmdp), start);
-		*(pte_t *)__nocache_fix(ptep) = __pte(probed);
+		*__nocache_fix(ptep) = __pte(probed);
 		start += PAGE_SIZE;
 	}
 }
@@ -850,7 +850,7 @@ static void __init do_large_mapping(unsigned long vaddr, unsigned long phys_base
 	unsigned long big_pte;
 
 	big_pte = KERNEL_PTE(phys_base >> 4);
-	*(pgd_t *)__nocache_fix(pgdp) = __pgd(big_pte);
+	*__nocache_fix(pgdp) = __pgd(big_pte);
 }
 
 /* Map sp_bank entry SP_ENTRY, starting at virtual address VBASE. */
@@ -940,7 +940,7 @@ void __init srmmu_paging_init(void)
 	srmmu_ctx_table_phys = (ctxd_t *)__nocache_pa(srmmu_context_table);
 
 	for (i = 0; i < num_contexts; i++)
-		srmmu_ctxd_set((ctxd_t *)__nocache_fix(&srmmu_context_table[i]), srmmu_swapper_pg_dir);
+		srmmu_ctxd_set(__nocache_fix(&srmmu_context_table[i]), srmmu_swapper_pg_dir);
 
 	flush_cache_all();
 	srmmu_set_ctable_ptr((unsigned long)srmmu_ctx_table_phys);
-- 
2.26.2

