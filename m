Return-Path: <SRS0=ObIu=6N=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C75E2C8300A
	for <linux-kernel@archiver.kernel.org>; Wed, 29 Apr 2020 19:33:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 96720206D6
	for <linux-kernel@archiver.kernel.org>; Wed, 29 Apr 2020 19:33:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=narfindustries.com header.i=@narfindustries.com header.b="Pep6ZJ/n"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727103AbgD2Tdx (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 29 Apr 2020 15:33:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52844 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726481AbgD2Tdv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Apr 2020 15:33:51 -0400
Received: from mail-ua1-x942.google.com (mail-ua1-x942.google.com [IPv6:2607:f8b0:4864:20::942])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3F515C03C1AE
        for <linux-kernel@vger.kernel.org>; Wed, 29 Apr 2020 12:33:51 -0700 (PDT)
Received: by mail-ua1-x942.google.com with SMTP id y10so1408218uao.8
        for <linux-kernel@vger.kernel.org>; Wed, 29 Apr 2020 12:33:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=narfindustries.com; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :in-reply-to:references;
        bh=8AaV3Fi0qjMdLXHUKhA9z8PQQ3uws6a6ACazsxJHCsg=;
        b=Pep6ZJ/npopg6GROAvwfXxZdCS9pj1352pn6DZKEHGP90ybas0ePpLKXkI0x5AY975
         at5MUhEfvBKtWPl3pw0mW1PYmya7y5nDv/RawYZBSqn6y2vfDnHkw3GZUdsD7fRAWc95
         D4yccQXLLH4Nrm0EjNnXnoT3mqZZJxdHyUGqKJ4WdPSvZQi+nC5iH9yrV6RRXTnIwlMH
         KITxqX2C3g6sAQJATaCGMsT+kqMLJ7EMb4c7VWlUNgCuvinKVI2cZFPWieU+QfdUdzFP
         zLPWTvVXsZwuodFVND0sYdjIaA+WBtiN7CnZ60O9wBFmxnQpLBeSm5IfWNHMSa9WMg6Q
         /lZA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:in-reply-to:references;
        bh=8AaV3Fi0qjMdLXHUKhA9z8PQQ3uws6a6ACazsxJHCsg=;
        b=X6eLQM6Ur6RV4YeH0Wa1E1zvNjDQGNurXQ4R/jQ+eNLDyIy03jM9HuBNaWirQWir6M
         CZUxI3D/zTmN/a9PthdZdGWkLkRYo4vNwVVEQgvkQ8DVUALNAmF88Np6m18e+0IGBx83
         DKHtVFzyqSRSIPPFXhyZbro38SYNMQ/iwZb3+8bTXDYnx8McPXg5JlJOpHLbfCSakBiC
         OxCkJimr+uPowhW84l8TTZDCZH8lwD3bdV1LTYwnpAC7WDoOvjNgtTDZ9YFnsXkgDw6+
         qrmmPAEZ/B7ocTQh+e5XZTSqQNPd76QR97ylr/jOIEs6NYU6Od9yL4G+ZFg4h+8OOULx
         AQdA==
X-Gm-Message-State: AGi0PuaQ/LvrD3fwBPaR/FpdL7hqHzI6GwjSvzNpIXqVSC+ahiIHb2kG
        dlH9CSB3RxqpX504/ykD//n7IZDr0PkLZw==
X-Google-Smtp-Source: APiQypJsriR5P0zJ5HILBocMHjGrlWlszzC5ugL2a2GddVU41ywUQ9BMhPVv2npGd3Pb1jAXJ3qftA==
X-Received: by 2002:ab0:3457:: with SMTP id a23mr23208428uaq.11.1588188830158;
        Wed, 29 Apr 2020 12:33:50 -0700 (PDT)
Received: from localhost.localdomain ([24.171.221.68])
        by smtp.gmail.com with ESMTPSA id k26sm76764uag.10.2020.04.29.12.33.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 29 Apr 2020 12:33:49 -0700 (PDT)
From:   Javier Malave <javier.malave@narfindustries.com>
To:     bx@narfindustries.com
Cc:     Javier Malave <javier.malave@narfindustries.com>,
        linux-kernel@vger.kernel.org, ah@narfindustries.com
Subject: [RFC 3/9] Temporary revert L1TF mitigation for Popcorn
Date:   Wed, 29 Apr 2020 15:32:50 -0400
Message-Id: <03636df1d6b3e8e68f61e234c676acfdd0b92985.1588127445.git.javier.malave@narfindustries.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <cover.1588127445.git.javier.malave@narfindustries.com>
References: <0>
 <cover.1588127445.git.javier.malave@narfindustries.com>
In-Reply-To: <cover.1588127445.git.javier.malave@narfindustries.com>
References: <cover.1588127445.git.javier.malave@narfindustries.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Popcorn Linux is a Linux kernel-based software stack
that enables applications to execute, with a shared
source base, on distributed hosts.

To ensure correct functionality across hosts and
focus feedback during the RFC process we have
reverted L1TF mitigations for x86 mitigations
temporarily. Future iterations of Popcorn will
comply with the L1TF mitigations.
---
 arch/x86/include/asm/pgtable-2level.h | 17 --------
 arch/x86/include/asm/pgtable-3level.h |  2 -
 arch/x86/include/asm/pgtable.h        | 59 +++++----------------------
 arch/x86/include/asm/pgtable_64.h     |  2 -
 arch/x86/mm/mmap.c                    | 21 ----------
 mm/memory.c                           | 41 +++++++------------
 mm/mprotect.c                         | 49 ----------------------
 7 files changed, 25 insertions(+), 166 deletions(-)

diff --git a/arch/x86/include/asm/pgtable-2level.h b/arch/x86/include/asm/pgtable-2level.h
index 60d0f9015..685ffe8a0 100644
--- a/arch/x86/include/asm/pgtable-2level.h
+++ b/arch/x86/include/asm/pgtable-2level.h
@@ -95,21 +95,4 @@ static inline unsigned long pte_bitop(unsigned long value, unsigned int rightshi
 #define __pte_to_swp_entry(pte)		((swp_entry_t) { (pte).pte_low })
 #define __swp_entry_to_pte(x)		((pte_t) { .pte = (x).val })
 
-/* No inverted PFNs on 2 level page tables */
-
-static inline u64 protnone_mask(u64 val)
-{
-	return 0;
-}
-
-static inline u64 flip_protnone_guard(u64 oldval, u64 val, u64 mask)
-{
-	return val;
-}
-
-static inline bool __pte_needs_invert(u64 val)
-{
-	return false;
-}
-
 #endif /* _ASM_X86_PGTABLE_2LEVEL_H */
diff --git a/arch/x86/include/asm/pgtable-3level.h b/arch/x86/include/asm/pgtable-3level.h
index f8b1ad2c3..fa1a7047f 100644
--- a/arch/x86/include/asm/pgtable-3level.h
+++ b/arch/x86/include/asm/pgtable-3level.h
@@ -332,6 +332,4 @@ static inline pte_t gup_get_pte(pte_t *ptep)
 	return pte;
 }
 
-#include <asm/pgtable-invert.h>
-
 #endif /* _ASM_X86_PGTABLE_3LEVEL_H */
diff --git a/arch/x86/include/asm/pgtable.h b/arch/x86/include/asm/pgtable.h
index 7a0171c67..21a97114d 100644
--- a/arch/x86/include/asm/pgtable.h
+++ b/arch/x86/include/asm/pgtable.h
@@ -204,33 +204,19 @@ static inline int pte_special(pte_t pte)
 	return pte_flags(pte) & _PAGE_SPECIAL;
 }
 
-/* Entries that were set to PROT_NONE are inverted */
-
-static inline u64 protnone_mask(u64 val);
-
 static inline unsigned long pte_pfn(pte_t pte)
 {
-#ifdef CONFIG_POPCORN
 	return (pte_val(pte) & PTE_PFN_MASK) >> PAGE_SHIFT;
-#else
-	phys_addr_t pfn = pte_val(pte);
-	pfn ^= protnone_mask(pfn);
-	return (pfn & PTE_PFN_MASK) >> PAGE_SHIFT;
-#endif
 }
 
 static inline unsigned long pmd_pfn(pmd_t pmd)
 {
-	phys_addr_t pfn = pmd_val(pmd);
-	pfn ^= protnone_mask(pfn);
-	return (pfn & pmd_pfn_mask(pmd)) >> PAGE_SHIFT;
+	return (pmd_val(pmd) & pmd_pfn_mask(pmd)) >> PAGE_SHIFT;
 }
 
 static inline unsigned long pud_pfn(pud_t pud)
 {
-	phys_addr_t pfn = pud_val(pud);
-	pfn ^= protnone_mask(pfn);
-	return (pfn & pud_pfn_mask(pud)) >> PAGE_SHIFT;
+	return (pud_val(pud) & pud_pfn_mask(pud)) >> PAGE_SHIFT;
 }
 
 static inline unsigned long p4d_pfn(p4d_t p4d)
@@ -568,26 +554,20 @@ static inline pgprotval_t check_pgprot(pgprot_t pgprot)
 
 static inline pte_t pfn_pte(unsigned long page_nr, pgprot_t pgprot)
 {
-	phys_addr_t pfn = (phys_addr_t)page_nr << PAGE_SHIFT;
-	pfn ^= protnone_mask(pgprot_val(pgprot));
-	pfn &= PTE_PFN_MASK;
-	return __pte(pfn | check_pgprot(pgprot));
+	return __pte(((phys_addr_t)page_nr << PAGE_SHIFT) |
+		     check_pgprot(pgprot));
 }
 
 static inline pmd_t pfn_pmd(unsigned long page_nr, pgprot_t pgprot)
 {
-	phys_addr_t pfn = (phys_addr_t)page_nr << PAGE_SHIFT;
-	pfn ^= protnone_mask(pgprot_val(pgprot));
-	pfn &= PHYSICAL_PMD_PAGE_MASK;
-	return __pmd(pfn | check_pgprot(pgprot));
+	return __pmd(((phys_addr_t)page_nr << PAGE_SHIFT) |
+		     check_pgprot(pgprot));
 }
 
 static inline pud_t pfn_pud(unsigned long page_nr, pgprot_t pgprot)
 {
-	phys_addr_t pfn = (phys_addr_t)page_nr << PAGE_SHIFT;
-	pfn ^= protnone_mask(pgprot_val(pgprot));
-	pfn &= PHYSICAL_PUD_PAGE_MASK;
-	return __pud(pfn | check_pgprot(pgprot));
+	return __pud(((phys_addr_t)page_nr << PAGE_SHIFT) |
+		     check_pgprot(pgprot));
 }
 
 static inline pmd_t pmd_mknotpresent(pmd_t pmd)
@@ -602,15 +582,9 @@ static inline pud_t pud_mknotpresent(pud_t pud)
 	      __pgprot(pud_flags(pud) & ~(_PAGE_PRESENT|_PAGE_PROTNONE)));
 }
 
-static inline u64 flip_protnone_guard(u64 oldval, u64 val, u64 mask);
-
 static inline pte_t pte_modify(pte_t pte, pgprot_t newprot)
 {
-#ifndef CONFIG_POPCORN
-	pteval_t val = pte_val(pte), oldval = val;
-#else
 	pteval_t val = pte_val(pte);
-#endif
 
 	/*
 	 * Chop off the NX bit (if present), and add the NX portion of
@@ -618,20 +592,17 @@ static inline pte_t pte_modify(pte_t pte, pgprot_t newprot)
 	 */
 	val &= _PAGE_CHG_MASK;
 	val |= check_pgprot(newprot) & ~_PAGE_CHG_MASK;
-#ifndef CONFIG_POPCORN
-	val = flip_protnone_guard(oldval, val, PTE_PFN_MASK);
-#endif
-	return __pte(val);
 
+	return __pte(val);
 }
 
 static inline pmd_t pmd_modify(pmd_t pmd, pgprot_t newprot)
 {
-	pmdval_t val = pmd_val(pmd), oldval = val;
+	pmdval_t val = pmd_val(pmd);
 
 	val &= _HPAGE_CHG_MASK;
 	val |= check_pgprot(newprot) & ~_HPAGE_CHG_MASK;
-	val = flip_protnone_guard(oldval, val, PHYSICAL_PMD_PAGE_MASK);
+
 	return __pmd(val);
 }
 
@@ -1466,14 +1437,6 @@ static inline bool pud_access_permitted(pud_t pud, bool write)
 	return __pte_access_permitted(pud_val(pud), write);
 }
 
-#define __HAVE_ARCH_PFN_MODIFY_ALLOWED 1
-extern bool pfn_modify_allowed(unsigned long pfn, pgprot_t prot);
-
-static inline bool arch_has_pfn_modify_check(void)
-{
-	return boot_cpu_has_bug(X86_BUG_L1TF);
-}
-
 #include <asm-generic/pgtable.h>
 #endif	/* __ASSEMBLY__ */
 
diff --git a/arch/x86/include/asm/pgtable_64.h b/arch/x86/include/asm/pgtable_64.h
index 0bb566315..0e529a4a5 100644
--- a/arch/x86/include/asm/pgtable_64.h
+++ b/arch/x86/include/asm/pgtable_64.h
@@ -272,7 +272,5 @@ static inline bool gup_fast_permitted(unsigned long start, int nr_pages)
 	return true;
 }
 
-#include <asm/pgtable-invert.h>
-
 #endif /* !__ASSEMBLY__ */
 #endif /* _ASM_X86_PGTABLE_64_H */
diff --git a/arch/x86/mm/mmap.c b/arch/x86/mm/mmap.c
index aae9a933d..1afca4ddf 100644
--- a/arch/x86/mm/mmap.c
+++ b/arch/x86/mm/mmap.c
@@ -227,24 +227,3 @@ int valid_mmap_phys_addr_range(unsigned long pfn, size_t count)
 
 	return phys_addr_valid(addr + count - 1);
 }
-
-/*
- * Only allow root to set high MMIO mappings to PROT_NONE.
- * This prevents an unpriv. user to set them to PROT_NONE and invert
- * them, then pointing to valid memory for L1TF speculation.
- *
- * Note: for locked down kernels may want to disable the root override.
- */
-bool pfn_modify_allowed(unsigned long pfn, pgprot_t prot)
-{
-	if (!boot_cpu_has_bug(X86_BUG_L1TF))
-		return true;
-	if (!__pte_needs_invert(pgprot_val(prot)))
-		return true;
-	/* If it's real memory always allow */
-	if (pfn_valid(pfn))
-		return true;
-	if (pfn >= l1tf_pfn_limit() && !capable(CAP_SYS_ADMIN))
-		return false;
-	return true;
-}
diff --git a/mm/memory.c b/mm/memory.c
index dd972a6a1..a93c9a9dd 100644
--- a/mm/memory.c
+++ b/mm/memory.c
@@ -119,9 +119,13 @@ EXPORT_SYMBOL(high_memory);
 int randomize_va_space __read_mostly =
 #ifdef CONFIG_COMPAT_BRK
 					1;
+#else
+#ifdef CONFIG_POPCORN
+					0;	/* Popcorn needs address space randomization to be turned off for the time being */
 #else
 					2;
 #endif
+#endif
 
 static int __init disable_randmaps(char *s)
 {
@@ -1706,9 +1710,6 @@ vm_fault_t vmf_insert_pfn_prot(struct vm_area_struct *vma, unsigned long addr,
 	if (addr < vma->vm_start || addr >= vma->vm_end)
 		return VM_FAULT_SIGBUS;
 
-	if (!pfn_modify_allowed(pfn, pgprot))
-		return VM_FAULT_SIGBUS;
-
 	track_pfn_insert(vma, &pgprot, __pfn_to_pfn_t(pfn, PFN_DEV));
 
 	return insert_pfn(vma, addr, __pfn_to_pfn_t(pfn, PFN_DEV), pgprot,
@@ -1770,9 +1771,6 @@ static vm_fault_t __vm_insert_mixed(struct vm_area_struct *vma,
 
 	track_pfn_insert(vma, &pgprot, pfn);
 
-	if (!pfn_modify_allowed(pfn_t_to_pfn(pfn), pgprot))
-		return VM_FAULT_SIGBUS;
-
 	/*
 	 * If we don't have pte special, then we have to use the pfn_valid()
 	 * based VM_MIXEDMAP scheme (see vm_normal_page), and thus we *must*
@@ -1833,7 +1831,6 @@ static int remap_pte_range(struct mm_struct *mm, pmd_t *pmd,
 {
 	pte_t *pte;
 	spinlock_t *ptl;
-	int err = 0;
 
 	pte = pte_alloc_map_lock(mm, pmd, addr, &ptl);
 	if (!pte)
@@ -1841,16 +1838,12 @@ static int remap_pte_range(struct mm_struct *mm, pmd_t *pmd,
 	arch_enter_lazy_mmu_mode();
 	do {
 		BUG_ON(!pte_none(*pte));
-		if (!pfn_modify_allowed(pfn, prot)) {
-			err = -EACCES;
-			break;
-		}
 		set_pte_at(mm, addr, pte, pte_mkspecial(pfn_pte(pfn, prot)));
 		pfn++;
 	} while (pte++, addr += PAGE_SIZE, addr != end);
 	arch_leave_lazy_mmu_mode();
 	pte_unmap_unlock(pte - 1, ptl);
-	return err;
+	return 0;
 }
 
 static inline int remap_pmd_range(struct mm_struct *mm, pud_t *pud,
@@ -1859,7 +1852,6 @@ static inline int remap_pmd_range(struct mm_struct *mm, pud_t *pud,
 {
 	pmd_t *pmd;
 	unsigned long next;
-	int err;
 
 	pfn -= addr >> PAGE_SHIFT;
 	pmd = pmd_alloc(mm, pud, addr);
@@ -1868,10 +1860,9 @@ static inline int remap_pmd_range(struct mm_struct *mm, pud_t *pud,
 	VM_BUG_ON(pmd_trans_huge(*pmd));
 	do {
 		next = pmd_addr_end(addr, end);
-		err = remap_pte_range(mm, pmd, addr, next,
-				pfn + (addr >> PAGE_SHIFT), prot);
-		if (err)
-			return err;
+		if (remap_pte_range(mm, pmd, addr, next,
+				pfn + (addr >> PAGE_SHIFT), prot))
+			return -ENOMEM;
 	} while (pmd++, addr = next, addr != end);
 	return 0;
 }
@@ -1882,7 +1873,6 @@ static inline int remap_pud_range(struct mm_struct *mm, p4d_t *p4d,
 {
 	pud_t *pud;
 	unsigned long next;
-	int err;
 
 	pfn -= addr >> PAGE_SHIFT;
 	pud = pud_alloc(mm, p4d, addr);
@@ -1890,10 +1880,9 @@ static inline int remap_pud_range(struct mm_struct *mm, p4d_t *p4d,
 		return -ENOMEM;
 	do {
 		next = pud_addr_end(addr, end);
-		err = remap_pmd_range(mm, pud, addr, next,
-				pfn + (addr >> PAGE_SHIFT), prot);
-		if (err)
-			return err;
+		if (remap_pmd_range(mm, pud, addr, next,
+				pfn + (addr >> PAGE_SHIFT), prot))
+			return -ENOMEM;
 	} while (pud++, addr = next, addr != end);
 	return 0;
 }
@@ -1904,7 +1893,6 @@ static inline int remap_p4d_range(struct mm_struct *mm, pgd_t *pgd,
 {
 	p4d_t *p4d;
 	unsigned long next;
-	int err;
 
 	pfn -= addr >> PAGE_SHIFT;
 	p4d = p4d_alloc(mm, pgd, addr);
@@ -1912,10 +1900,9 @@ static inline int remap_p4d_range(struct mm_struct *mm, pgd_t *pgd,
 		return -ENOMEM;
 	do {
 		next = p4d_addr_end(addr, end);
-		err = remap_pud_range(mm, p4d, addr, next,
-				pfn + (addr >> PAGE_SHIFT), prot);
-		if (err)
-			return err;
+		if (remap_pud_range(mm, p4d, addr, next,
+				pfn + (addr >> PAGE_SHIFT), prot))
+			return -ENOMEM;
 	} while (p4d++, addr = next, addr != end);
 	return 0;
 }
diff --git a/mm/mprotect.c b/mm/mprotect.c
index d78e9dbc5..a9b0dfc60 100644
--- a/mm/mprotect.c
+++ b/mm/mprotect.c
@@ -313,42 +313,6 @@ unsigned long change_protection(struct vm_area_struct *vma, unsigned long start,
 	return pages;
 }
 
-static int prot_none_pte_entry(pte_t *pte, unsigned long addr,
-			       unsigned long next, struct mm_walk *walk)
-{
-	return pfn_modify_allowed(pte_pfn(*pte), *(pgprot_t *)(walk->private)) ?
-		0 : -EACCES;
-}
-
-static int prot_none_hugetlb_entry(pte_t *pte, unsigned long hmask,
-				   unsigned long addr, unsigned long next,
-				   struct mm_walk *walk)
-{
-	return pfn_modify_allowed(pte_pfn(*pte), *(pgprot_t *)(walk->private)) ?
-		0 : -EACCES;
-}
-
-static int prot_none_test(unsigned long addr, unsigned long next,
-			  struct mm_walk *walk)
-{
-	return 0;
-}
-
-static int prot_none_walk(struct vm_area_struct *vma, unsigned long start,
-			   unsigned long end, unsigned long newflags)
-{
-	pgprot_t new_pgprot = vm_get_page_prot(newflags);
-	struct mm_walk prot_none_walk = {
-		.pte_entry = prot_none_pte_entry,
-		.hugetlb_entry = prot_none_hugetlb_entry,
-		.test_walk = prot_none_test,
-		.mm = current->mm,
-		.private = &new_pgprot,
-	};
-
-	return walk_page_range(start, end, &prot_none_walk);
-}
-
 int
 mprotect_fixup(struct vm_area_struct *vma, struct vm_area_struct **pprev,
 	unsigned long start, unsigned long end, unsigned long newflags)
@@ -366,19 +330,6 @@ mprotect_fixup(struct vm_area_struct *vma, struct vm_area_struct **pprev,
 		return 0;
 	}
 
-	/*
-	 * Do PROT_NONE PFN permission checks here when we can still
-	 * bail out without undoing a lot of state. This is a rather
-	 * uncommon case, so doesn't need to be very optimized.
-	 */
-	if (arch_has_pfn_modify_check() &&
-	    (vma->vm_flags & (VM_PFNMAP|VM_MIXEDMAP)) &&
-	    (newflags & (VM_READ|VM_WRITE|VM_EXEC)) == 0) {
-		error = prot_none_walk(vma, start, end, newflags);
-		if (error)
-			return error;
-	}
-
 	/*
 	 * If we make a private mapping writable we increase our commit;
 	 * but (without finer accounting) cannot reduce our commit if we
-- 
2.17.1

