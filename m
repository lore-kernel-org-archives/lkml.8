Return-Path: <SRS0=XgUW=7G=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DE880C433E0
	for <linux-kernel@archiver.kernel.org>; Sun, 24 May 2020 16:22:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id BCFFB20787
	for <linux-kernel@archiver.kernel.org>; Sun, 24 May 2020 16:22:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1590337326;
	bh=YweMuEPk/vOQ2J8eOzqSp+RPj79OVzORMtJFlJKshPg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=sgDb85Ssd5t2m7m6CzQKTfoddeGnk+eVd3VnWAP/Eanc2V3NylxCYt8xp3shkmgX2
	 TNKBDHC9yYEted7rxhi8U0SW01cJckTtG2ei79VuWli89j3FH2B0onY3BtViirSeFq
	 BHu9imd+vt6dli9D32cPtHng2FPFxhOiVp2SsisQ=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387767AbgEXQWG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 24 May 2020 12:22:06 -0400
Received: from mail.kernel.org ([198.145.29.99]:55308 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2387682AbgEXQWE (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 24 May 2020 12:22:04 -0400
Received: from aquarius.haifa.ibm.com (nesher1.haifa.il.ibm.com [195.110.40.7])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 60F85207CB;
        Sun, 24 May 2020 16:22:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1590337323;
        bh=YweMuEPk/vOQ2J8eOzqSp+RPj79OVzORMtJFlJKshPg=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=hMNAopsV8q+N0zHNkNU/EYpIx2mwRywPKtnLesOKJ4EEMT4ehndEt9ecniLjGtMJh
         DjFFaoyx9I/gpqqYlKSnhiguj+2ptWR+r8Ygqi2SiPENFHn2NSFgTs/ijKFsS+W7m9
         Cj7HIIIWmjRQpBKc8Z66922qXJ4NijiyNs5VSzlk=
From:   Mike Rapoport <rppt@kernel.org>
To:     "David S. Miller" <davem@davemloft.net>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        sparclinux@vger.kernel.org, linux-kernel@vger.kernel.org,
        Mike Rapoport <rppt@kernel.org>,
        Mike Rapoport <rppt@linux.ibm.com>
Subject: [PATCH 2/2] sparc32: srmmu: improve type safety of __nocache_fix()
Date:   Sun, 24 May 2020 19:21:51 +0300
Message-Id: <20200524162151.3493-3-rppt@kernel.org>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20200524162151.3493-1-rppt@kernel.org>
References: <20200524162151.3493-1-rppt@kernel.org>
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
Link: https://lkml.kernel.org/stablestablestablestablestabler/CAHk-=wisORTa7QVPnFqNw9pFs62UiwgsD4C4d=MtYy1o4JPyGQ@mail.gmail.com
---
 arch/sparc/include/asm/pgtsrmmu.h |  2 +-
 arch/sparc/mm/srmmu.c             | 16 ++++++++--------
 2 files changed, 9 insertions(+), 9 deletions(-)

diff --git a/arch/sparc/include/asm/pgtsrmmu.h b/arch/sparc/include/asm/pgtsrmmu.h
index 32a508897501..941d42a59b81 100644
--- a/arch/sparc/include/asm/pgtsrmmu.h
+++ b/arch/sparc/include/asm/pgtsrmmu.h
@@ -143,7 +143,7 @@ extern unsigned long last_valid_pfn;
 extern void *srmmu_nocache_pool;
 #define __nocache_pa(VADDR) (((unsigned long)VADDR) - SRMMU_NOCACHE_VADDR + __pa((unsigned long)srmmu_nocache_pool))
 #define __nocache_va(PADDR) (__va((unsigned long)PADDR) - (unsigned long)srmmu_nocache_pool + SRMMU_NOCACHE_VADDR)
-#define __nocache_fix(VADDR) __va(__nocache_pa(VADDR))
+#define __nocache_fix(VADDR) ((__typeof__(VADDR))__va(__nocache_pa(VADDR)))
 
 /* Accessing the MMU control register. */
 unsigned int srmmu_get_mmureg(void);
diff --git a/arch/sparc/mm/srmmu.c b/arch/sparc/mm/srmmu.c
index dbf5334dd084..d86e6c657922 100644
--- a/arch/sparc/mm/srmmu.c
+++ b/arch/sparc/mm/srmmu.c
@@ -724,7 +724,7 @@ static void __init srmmu_early_allocate_ptable_skeleton(unsigned long start,
 			pud_set(__nocache_fix(pudp), pmdp);
 		}
 		pmdp = pmd_offset(__nocache_fix(pudp), start);
-		if (srmmu_pmd_none(*(pmd_t *)__nocache_fix(pmdp))) {
+		if (srmmu_pmd_none(*__nocache_fix(pmdp))) {
 			ptep = __srmmu_get_nocache(PTE_SIZE, PTE_SIZE);
 			if (ptep == NULL)
 				early_pgtable_allocfail("pte");
@@ -836,11 +836,11 @@ static void __init srmmu_inherit_prom_mappings(unsigned long start,
 		p4dp = p4d_offset(pgdp, start);
 		pudp = pud_offset(p4dp, start);
 		if (what == 2) {
-			*(pgd_t *)__nocache_fix(pgdp) = __pgd(probed);
+			*__nocache_fix(pgdp) = __pgd(probed);
 			start += SRMMU_PGDIR_SIZE;
 			continue;
 		}
-		if (pud_none(*(pud_t *)__nocache_fix(pudp))) {
+		if (pud_none(*__nocache_fix(pudp))) {
 			pmdp = __srmmu_get_nocache(SRMMU_PMD_TABLE_SIZE,
 						   SRMMU_PMD_TABLE_SIZE);
 			if (pmdp == NULL)
@@ -849,7 +849,7 @@ static void __init srmmu_inherit_prom_mappings(unsigned long start,
 			pud_set(__nocache_fix(pudp), pmdp);
 		}
 		pmdp = pmd_offset(__nocache_fix(pudp), start);
-		if (srmmu_pmd_none(*(pmd_t *)__nocache_fix(pmdp))) {
+		if (srmmu_pmd_none(*__nocache_fix(pmdp))) {
 			ptep = __srmmu_get_nocache(PTE_SIZE, PTE_SIZE);
 			if (ptep == NULL)
 				early_pgtable_allocfail("pte");
@@ -865,12 +865,12 @@ static void __init srmmu_inherit_prom_mappings(unsigned long start,
 			unsigned long *val;
 			x = (start >> PMD_SHIFT) & 15;
 			val = &pmdp->pmdv[x];
-			*(unsigned long *)__nocache_fix(val) = probed;
+			*__nocache_fix(val) = probed;
 			start += SRMMU_REAL_PMD_SIZE;
 			continue;
 		}
 		ptep = pte_offset_kernel(__nocache_fix(pmdp), start);
-		*(pte_t *)__nocache_fix(ptep) = __pte(probed);
+		*__nocache_fix(ptep) = __pte(probed);
 		start += PAGE_SIZE;
 	}
 }
@@ -884,7 +884,7 @@ static void __init do_large_mapping(unsigned long vaddr, unsigned long phys_base
 	unsigned long big_pte;
 
 	big_pte = KERNEL_PTE(phys_base >> 4);
-	*(pgd_t *)__nocache_fix(pgdp) = __pgd(big_pte);
+	*__nocache_fix(pgdp) = __pgd(big_pte);
 }
 
 /* Map sp_bank entry SP_ENTRY, starting at virtual address VBASE. */
@@ -974,7 +974,7 @@ void __init srmmu_paging_init(void)
 	srmmu_ctx_table_phys = (ctxd_t *)__nocache_pa(srmmu_context_table);
 
 	for (i = 0; i < num_contexts; i++)
-		srmmu_ctxd_set((ctxd_t *)__nocache_fix(&srmmu_context_table[i]), srmmu_swapper_pg_dir);
+		srmmu_ctxd_set(__nocache_fix(&srmmu_context_table[i]), srmmu_swapper_pg_dir);
 
 	flush_cache_all();
 	srmmu_set_ctable_ptr((unsigned long)srmmu_ctx_table_phys);
-- 
2.26.2

