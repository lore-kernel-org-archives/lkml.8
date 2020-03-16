Return-Path: <SRS0=ltrd=5B=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 08B96C2BB1D
	for <linux-kernel@archiver.kernel.org>; Mon, 16 Mar 2020 12:37:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C6EEE205ED
	for <linux-kernel@archiver.kernel.org>; Mon, 16 Mar 2020 12:37:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=c-s.fr header.i=@c-s.fr header.b="QnRoKj1r"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731214AbgCPMgR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 16 Mar 2020 08:36:17 -0400
Received: from pegase1.c-s.fr ([93.17.236.30]:41784 "EHLO pegase1.c-s.fr"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731097AbgCPMgK (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Mar 2020 08:36:10 -0400
Received: from localhost (mailhub1-int [192.168.12.234])
        by localhost (Postfix) with ESMTP id 48gwl70hH3z9v02j;
        Mon, 16 Mar 2020 13:36:03 +0100 (CET)
Authentication-Results: localhost; dkim=pass
        reason="1024-bit key; insecure key"
        header.d=c-s.fr header.i=@c-s.fr header.b=QnRoKj1r; dkim-adsp=pass;
        dkim-atps=neutral
X-Virus-Scanned: Debian amavisd-new at c-s.fr
Received: from pegase1.c-s.fr ([192.168.12.234])
        by localhost (pegase1.c-s.fr [192.168.12.234]) (amavisd-new, port 10024)
        with ESMTP id WTVz0pAtFMFa; Mon, 16 Mar 2020 13:36:03 +0100 (CET)
Received: from messagerie.si.c-s.fr (messagerie.si.c-s.fr [192.168.25.192])
        by pegase1.c-s.fr (Postfix) with ESMTP id 48gwl66nlsz9v02f;
        Mon, 16 Mar 2020 13:36:02 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=c-s.fr; s=mail;
        t=1584362162; bh=VtBkhQVm3tmFTz//V+0xvWujDtcu4f8ETZZXj7iTBdc=;
        h=In-Reply-To:References:From:Subject:To:Cc:Date:From;
        b=QnRoKj1rDsLBuV2+ZR4yDBvJwEE5Yamzbn64Ne2f/snZ3St8VTPolhjmDJctdCoYk
         NakrM5qRErG5NEmXR5xLhz+msmalkGJA/MexsaAr1clCvRQB2c6rgef3a8qMZVNe0d
         qzW4sncZ7avXQioHcL1rP109LI07ENITNPpmiL1E=
Received: from localhost (localhost [127.0.0.1])
        by messagerie.si.c-s.fr (Postfix) with ESMTP id E0D9E8B7D0;
        Mon, 16 Mar 2020 13:36:07 +0100 (CET)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from messagerie.si.c-s.fr ([127.0.0.1])
        by localhost (messagerie.si.c-s.fr [127.0.0.1]) (amavisd-new, port 10023)
        with ESMTP id IlkwfWy3KBRF; Mon, 16 Mar 2020 13:36:07 +0100 (CET)
Received: from pc16570vm.idsi0.si.c-s.fr (po15451.idsi0.si.c-s.fr [172.25.230.100])
        by messagerie.si.c-s.fr (Postfix) with ESMTP id B39D38B7CB;
        Mon, 16 Mar 2020 13:36:07 +0100 (CET)
Received: by pc16570vm.idsi0.si.c-s.fr (Postfix, from userid 0)
        id A2C3065595; Mon, 16 Mar 2020 12:36:07 +0000 (UTC)
Message-Id: <cdea4918655420059d2badd5ddb4d0b540a6563e.1584360344.git.christophe.leroy@c-s.fr>
In-Reply-To: <cover.1584360343.git.christophe.leroy@c-s.fr>
References: <cover.1584360343.git.christophe.leroy@c-s.fr>
From:   Christophe Leroy <christophe.leroy@c-s.fr>
Subject: [PATCH v1 22/46] powerpc/mm: Standardise pte_update() prototype
 between PPC32 and PPC64
To:     Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>,
        Michael Ellerman <mpe@ellerman.id.au>
Cc:     linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org
Date:   Mon, 16 Mar 2020 12:36:07 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

PPC64 takes 3 additional parameters compared to PPC32:
- mm
- address
- huge

These 3 parameters will be needed in order to perform different
action depending on the page size on the 8xx.

Make pte_update() prototype identical for PPC32 and PPC64.

This allows dropping an #ifdef in huge_ptep_get_and_clear().

Signed-off-by: Christophe Leroy <christophe.leroy@c-s.fr>
---
 arch/powerpc/include/asm/book3s/32/pgtable.h | 15 ++++++++-------
 arch/powerpc/include/asm/hugetlb.h           |  4 ----
 arch/powerpc/include/asm/nohash/32/pgtable.h | 13 +++++++------
 3 files changed, 15 insertions(+), 17 deletions(-)

diff --git a/arch/powerpc/include/asm/book3s/32/pgtable.h b/arch/powerpc/include/asm/book3s/32/pgtable.h
index 8122f0b55d21..f5eab98c4e41 100644
--- a/arch/powerpc/include/asm/book3s/32/pgtable.h
+++ b/arch/powerpc/include/asm/book3s/32/pgtable.h
@@ -218,7 +218,7 @@ int map_kernel_page(unsigned long va, phys_addr_t pa, pgprot_t prot);
  */
 
 #define pte_clear(mm, addr, ptep) \
-	do { pte_update(ptep, ~_PAGE_HASHPTE, 0); } while (0)
+	do { pte_update(mm, addr, ptep, ~_PAGE_HASHPTE, 0, 0); } while (0)
 
 #define pmd_none(pmd)		(!pmd_val(pmd))
 #define	pmd_bad(pmd)		(pmd_val(pmd) & _PMD_BAD)
@@ -254,7 +254,8 @@ extern void flush_hash_entry(struct mm_struct *mm, pte_t *ptep,
  * when using atomic updates, only the low part of the PTE is
  * accessed atomically.
  */
-static inline pte_basic_t pte_update(pte_t *p, unsigned long clr, unsigned long set)
+static inline pte_basic_t pte_update(struct mm_struct *mm, unsigned long addr, pte_t *p,
+				     unsigned long clr, unsigned long set, int huge)
 {
 	pte_basic_t old;
 	unsigned long tmp;
@@ -292,7 +293,7 @@ static inline int __ptep_test_and_clear_young(struct mm_struct *mm,
 					      unsigned long addr, pte_t *ptep)
 {
 	unsigned long old;
-	old = pte_update(ptep, _PAGE_ACCESSED, 0);
+	old = pte_update(mm, addr, ptep, _PAGE_ACCESSED, 0, 0);
 	if (old & _PAGE_HASHPTE) {
 		unsigned long ptephys = __pa(ptep) & PAGE_MASK;
 		flush_hash_pages(mm->context.id, addr, ptephys, 1);
@@ -306,14 +307,14 @@ static inline int __ptep_test_and_clear_young(struct mm_struct *mm,
 static inline pte_t ptep_get_and_clear(struct mm_struct *mm, unsigned long addr,
 				       pte_t *ptep)
 {
-	return __pte(pte_update(ptep, ~_PAGE_HASHPTE, 0));
+	return __pte(pte_update(mm, addr, ptep, ~_PAGE_HASHPTE, 0, 0));
 }
 
 #define __HAVE_ARCH_PTEP_SET_WRPROTECT
 static inline void ptep_set_wrprotect(struct mm_struct *mm, unsigned long addr,
 				      pte_t *ptep)
 {
-	pte_update(ptep, _PAGE_RW, 0);
+	pte_update(mm, addr, ptep, _PAGE_RW, 0, 0);
 }
 
 static inline void __ptep_set_access_flags(struct vm_area_struct *vma,
@@ -324,7 +325,7 @@ static inline void __ptep_set_access_flags(struct vm_area_struct *vma,
 	unsigned long set = pte_val(entry) &
 		(_PAGE_DIRTY | _PAGE_ACCESSED | _PAGE_RW | _PAGE_EXEC);
 
-	pte_update(ptep, 0, set);
+	pte_update(vma->vm_mm, address, ptep, 0, set, 0);
 
 	flush_tlb_page(vma, address);
 }
@@ -522,7 +523,7 @@ static inline void __set_pte_at(struct mm_struct *mm, unsigned long addr,
 		*ptep = __pte((pte_val(*ptep) & _PAGE_HASHPTE)
 			      | (pte_val(pte) & ~_PAGE_HASHPTE));
 	else
-		pte_update(ptep, ~_PAGE_HASHPTE, pte_val(pte));
+		pte_update(mm, addr, ptep, ~_PAGE_HASHPTE, pte_val(pte), 0);
 
 #elif defined(CONFIG_PTE_64BIT)
 	/* Second case is 32-bit with 64-bit PTE.  In this case, we
diff --git a/arch/powerpc/include/asm/hugetlb.h b/arch/powerpc/include/asm/hugetlb.h
index bd6504c28c2f..e4276af034e9 100644
--- a/arch/powerpc/include/asm/hugetlb.h
+++ b/arch/powerpc/include/asm/hugetlb.h
@@ -40,11 +40,7 @@ void hugetlb_free_pgd_range(struct mmu_gather *tlb, unsigned long addr,
 static inline pte_t huge_ptep_get_and_clear(struct mm_struct *mm,
 					    unsigned long addr, pte_t *ptep)
 {
-#ifdef CONFIG_PPC64
 	return __pte(pte_update(mm, addr, ptep, ~0UL, 0, 1));
-#else
-	return __pte(pte_update(ptep, ~0UL, 0));
-#endif
 }
 
 #define __HAVE_ARCH_HUGE_PTEP_CLEAR_FLUSH
diff --git a/arch/powerpc/include/asm/nohash/32/pgtable.h b/arch/powerpc/include/asm/nohash/32/pgtable.h
index ddf681ceb860..75880eb1cb91 100644
--- a/arch/powerpc/include/asm/nohash/32/pgtable.h
+++ b/arch/powerpc/include/asm/nohash/32/pgtable.h
@@ -166,7 +166,7 @@ int map_kernel_page(unsigned long va, phys_addr_t pa, pgprot_t prot);
 #ifndef __ASSEMBLY__
 
 #define pte_clear(mm, addr, ptep) \
-	do { pte_update(ptep, ~0, 0); } while (0)
+	do { pte_update(mm, addr, ptep, ~0, 0, 0); } while (0)
 
 #ifndef pte_mkwrite
 static inline pte_t pte_mkwrite(pte_t pte)
@@ -222,7 +222,8 @@ static inline void pmd_clear(pmd_t *pmdp)
  * to properly flush the virtually tagged instruction cache of
  * those implementations.
  */
-static inline pte_basic_t pte_update(pte_t *p, unsigned long clr, unsigned long set)
+static inline pte_basic_t pte_update(struct mm_struct *mm, unsigned long addr, pte_t *p,
+				     unsigned long clr, unsigned long set, int huge)
 {
 #if defined(PTE_ATOMIC_UPDATES) && !defined(CONFIG_PTE_64BIT)
 	unsigned long old, tmp;
@@ -260,7 +261,7 @@ static inline int __ptep_test_and_clear_young(struct mm_struct *mm,
 					      unsigned long addr, pte_t *ptep)
 {
 	unsigned long old;
-	old = pte_update(ptep, _PAGE_ACCESSED, 0);
+	old = pte_update(mm, addr, ptep, _PAGE_ACCESSED, 0, 0);
 	return (old & _PAGE_ACCESSED) != 0;
 }
 #define ptep_test_and_clear_young(__vma, __addr, __ptep) \
@@ -270,7 +271,7 @@ static inline int __ptep_test_and_clear_young(struct mm_struct *mm,
 static inline pte_t ptep_get_and_clear(struct mm_struct *mm, unsigned long addr,
 				       pte_t *ptep)
 {
-	return __pte(pte_update(ptep, ~0, 0));
+	return __pte(pte_update(mm, addr, ptep, ~0, 0, 0));
 }
 
 #define __HAVE_ARCH_PTEP_SET_WRPROTECT
@@ -280,7 +281,7 @@ static inline void ptep_set_wrprotect(struct mm_struct *mm, unsigned long addr,
 	unsigned long clr = ~pte_val(pte_wrprotect(__pte(~0)));
 	unsigned long set = pte_val(pte_wrprotect(__pte(0)));
 
-	pte_update(ptep, clr, set);
+	pte_update(mm, addr, ptep, clr, set, 0);
 }
 
 static inline void __ptep_set_access_flags(struct vm_area_struct *vma,
@@ -293,7 +294,7 @@ static inline void __ptep_set_access_flags(struct vm_area_struct *vma,
 	unsigned long set = pte_val(entry) & pte_val(pte_set);
 	unsigned long clr = ~pte_val(entry) & ~pte_val(pte_clr);
 
-	pte_update(ptep, clr, set);
+	pte_update(vma->vm_mm, address, ptep, clr, set, 0);
 
 	flush_tlb_page(vma, address);
 }
-- 
2.25.0

