Return-Path: <SRS0=PJcK=74=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BA861C433E0
	for <linux-kernel@archiver.kernel.org>; Mon, 15 Jun 2020 13:15:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 986272074D
	for <linux-kernel@archiver.kernel.org>; Mon, 15 Jun 2020 13:15:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730373AbgFONPi (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 15 Jun 2020 09:15:38 -0400
Received: from foss.arm.com ([217.140.110.172]:47612 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729977AbgFONPf (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 Jun 2020 09:15:35 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 9736F31B;
        Mon, 15 Jun 2020 06:15:34 -0700 (PDT)
Received: from p8cg001049571a15.arm.com (unknown [10.163.79.186])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 2E7143F6CF;
        Mon, 15 Jun 2020 06:15:30 -0700 (PDT)
From:   Anshuman Khandual <anshuman.khandual@arm.com>
To:     linux-mm@kvack.org, linux-arm-kernel@lists.infradead.org
Cc:     catalin.marinas@arm.com, will@kernel.org, mark.rutland@arm.com,
        ziy@nvidia.com, Anshuman Khandual <anshuman.khandual@arm.com>,
        Marc Zyngier <maz@kernel.org>,
        Suzuki Poulose <suzuki.poulose@arm.com>,
        linux-kernel@vger.kernel.org
Subject: [RFC V2 1/2] arm64/mm: Change THP helpers per generic memory semantics
Date:   Mon, 15 Jun 2020 18:45:17 +0530
Message-Id: <1592226918-26378-2-git-send-email-anshuman.khandual@arm.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1592226918-26378-1-git-send-email-anshuman.khandual@arm.com>
References: <1592226918-26378-1-git-send-email-anshuman.khandual@arm.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

pmd_present() and pmd_trans_huge() are expected to behave in the following
manner during various phases of a PMD entry. This table is derived from a
previous discussion on this topic [1] and available THP documentation [2].

pmd_present(pmd):

- True if PMD has a mapped huge page i.e valid pmd_page(pmd)
- False if PMD does not have a mapped huge page i.e invalid pmd_page(pmd)

pmd_trans_huge(pmd):

- True if PMD has a mapped huge page and is a THP

-------------------------------------------------------------------------
|	PMD states	|	pmd_present	|	pmd_trans_huge	|
-------------------------------------------------------------------------
|	Mapped		|	Yes		|	Yes		|
-------------------------------------------------------------------------
|	Splitting	|	Yes		|	Yes		|
-------------------------------------------------------------------------
|	Migration/Swap	|	No		|	No		|
-------------------------------------------------------------------------

Current Problem:-

PMD is invalidated with pmdp_invalidate() before it's splitting. It clears
PMD_SECT_VALID as below.

PMD Split -> pmdp_invalidate() -> pmd_mkinvalid() -> Clears PMD_SECT_VALID

Once PMD_SECT_VALID gets cleared, pmd_present() returns false. It will need
a separate page table bit apart from PMD_SECT_VALID, in order to reaffirm
pmd_present() as true during this THP split process. To comply with above
mentioned semantics, pmd_trans_huge() should also check pmd_present() first
before testing presence of an actual transparent huge page mapping.

PMD_TYPE_SECT should have been used here. But it shares bit position with
PMD_SECT_VALID which gets cleared during THP invalidation. Hence, it cannot
be used for pmd_present() after pmdp_invalidate().

Proposed Solution:-

PMD_TABLE_BIT can be set during pmdp_invalidate() process which will make
pmd_present() return true as required. But then, PMD_TABLE_BIT needs to be
cleared when PMD gets mapped again.

This replaces pmd_present() with pte_present() in huge_pte_offset() just to
preserve the existing semantics.

[1]: https://lore.kernel.org/linux-mm/20181017020930.GN30832@redhat.com/
[2]: https://www.kernel.org/doc/Documentation/vm/transhuge.txt

Cc: Catalin Marinas <catalin.marinas@arm.com>
Cc: Will Deacon <will@kernel.org>
Cc: Mark Rutland <mark.rutland@arm.com>
Cc: Marc Zyngier <maz@kernel.org>
Cc: Suzuki Poulose <suzuki.poulose@arm.com>
Cc: linux-arm-kernel@lists.infradead.org
Cc: linux-kernel@vger.kernel.org
Signed-off-by: Anshuman Khandual <anshuman.khandual@arm.com>
---
 arch/arm64/include/asm/pgtable.h | 92 ++++++++++++++++++++++++++++----
 arch/arm64/mm/hugetlbpage.c      |  2 +-
 arch/arm64/mm/mmu.c              | 20 +++++++
 3 files changed, 102 insertions(+), 12 deletions(-)

diff --git a/arch/arm64/include/asm/pgtable.h b/arch/arm64/include/asm/pgtable.h
index 6dbd267ab931..560be593a8dc 100644
--- a/arch/arm64/include/asm/pgtable.h
+++ b/arch/arm64/include/asm/pgtable.h
@@ -353,15 +353,92 @@ static inline int pmd_protnone(pmd_t pmd)
 }
 #endif
 
+#define pmd_table(pmd)	((pmd_val(pmd) & PMD_TYPE_MASK) ==  PMD_TYPE_TABLE)
+#define pmd_sect(pmd)	((pmd_val(pmd) & PMD_TYPE_MASK) ==  PMD_TYPE_SECT)
+
+#ifdef CONFIG_TRANSPARENT_HUGEPAGE
 /*
- * THP definitions.
+ * PMD Level Encoding (THP Enabled)
+ *
+ * 0b00 - Not valid	Not present	NA
+ * 0b10 - Not valid	Present		Huge  (Splitting)
+ * 0b01 - Valid		Present		Huge  (Mapped)
+ * 0b11 - Valid		Present		Table (Mapped)
  */
+static inline pmd_t pmd_mksplitting(pmd_t pmd)
+{
+	unsigned long val = pmd_val(pmd);
 
-#ifdef CONFIG_TRANSPARENT_HUGEPAGE
-#define pmd_trans_huge(pmd)	(pmd_val(pmd) && !(pmd_val(pmd) & PMD_TABLE_BIT))
+	return __pmd((val & ~PMD_TYPE_MASK) | PMD_TABLE_BIT);
+}
+
+static inline pmd_t pmd_clrsplitting(pmd_t pmd)
+{
+	unsigned long val = pmd_val(pmd);
+
+	return __pmd((val & ~PMD_TYPE_MASK) | PMD_TYPE_SECT);
+}
+
+static inline bool pmd_splitting(pmd_t pmd)
+{
+	unsigned long val = pmd_val(pmd);
+
+	if ((val & PMD_TYPE_MASK) == PMD_TABLE_BIT)
+		return true;
+	return false;
+}
+
+static inline bool pmd_mapped(pmd_t pmd)
+{
+	return pmd_sect(pmd);
+}
+
+static inline pmd_t pmd_mkinvalid(pmd_t pmd)
+{
+	/*
+	 * Invalidation should not have been invoked on
+	 * a PMD table entry. Just warn here otherwise.
+	 */
+	WARN_ON(pmd_table(pmd));
+	return pmd_mksplitting(pmd);
+}
+
+static inline int pmd_present(pmd_t pmd);
+
+static inline int pmd_trans_huge(pmd_t pmd)
+{
+	if (!pmd_present(pmd))
+		return 0;
+
+	if (!pmd_val(pmd))
+		return 0;
+
+	if (pmd_mapped(pmd))
+		return 1;
+
+	if (pmd_splitting(pmd))
+		return 1;
+	return 0;
+}
+
+void set_pmd_at(struct mm_struct *mm, unsigned long addr,
+		pmd_t *pmdp, pmd_t pmd);
 #endif /* CONFIG_TRANSPARENT_HUGEPAGE */
 
-#define pmd_present(pmd)	pte_present(pmd_pte(pmd))
+static inline int pmd_present(pmd_t pmd)
+{
+	pte_t pte = pmd_pte(pmd);
+
+	if (pte_present(pte))
+		return 1;
+
+#ifdef CONFIG_TRANSPARENT_HUGEPAGE
+	if (pmd_splitting(pmd))
+		return 1;
+#endif
+	return 0;
+}
+
 #define pmd_dirty(pmd)		pte_dirty(pmd_pte(pmd))
 #define pmd_young(pmd)		pte_young(pmd_pte(pmd))
 #define pmd_valid(pmd)		pte_valid(pmd_pte(pmd))
@@ -371,7 +448,6 @@ static inline int pmd_protnone(pmd_t pmd)
 #define pmd_mkclean(pmd)	pte_pmd(pte_mkclean(pmd_pte(pmd)))
 #define pmd_mkdirty(pmd)	pte_pmd(pte_mkdirty(pmd_pte(pmd)))
 #define pmd_mkyoung(pmd)	pte_pmd(pte_mkyoung(pmd_pte(pmd)))
-#define pmd_mkinvalid(pmd)	(__pmd(pmd_val(pmd) & ~PMD_SECT_VALID))
 
 #define pmd_thp_or_huge(pmd)	(pmd_huge(pmd) || pmd_trans_huge(pmd))
 
@@ -404,8 +480,6 @@ static inline pmd_t pmd_mkdevmap(pmd_t pmd)
 #define pud_pfn(pud)		((__pud_to_phys(pud) & PUD_MASK) >> PAGE_SHIFT)
 #define pfn_pud(pfn,prot)	__pud(__phys_to_pud_val((phys_addr_t)(pfn) << PAGE_SHIFT) | pgprot_val(prot))
 
-#define set_pmd_at(mm, addr, pmdp, pmd)	set_pte_at(mm, addr, (pte_t *)pmdp, pmd_pte(pmd))
-
 #define __p4d_to_phys(p4d)	__pte_to_phys(p4d_pte(p4d))
 #define __phys_to_p4d_val(phys)	__phys_to_pte_val(phys)
 
@@ -448,10 +522,6 @@ extern pgprot_t phys_mem_access_prot(struct file *file, unsigned long pfn,
 
 #define pmd_bad(pmd)		(!(pmd_val(pmd) & PMD_TABLE_BIT))
 
-#define pmd_table(pmd)		((pmd_val(pmd) & PMD_TYPE_MASK) == \
-				 PMD_TYPE_TABLE)
-#define pmd_sect(pmd)		((pmd_val(pmd) & PMD_TYPE_MASK) == \
-				 PMD_TYPE_SECT)
 #define pmd_leaf(pmd)		pmd_sect(pmd)
 
 #if defined(CONFIG_ARM64_64K_PAGES) || CONFIG_PGTABLE_LEVELS < 3
diff --git a/arch/arm64/mm/hugetlbpage.c b/arch/arm64/mm/hugetlbpage.c
index 0a52ce46f020..79a8d5c8d4f4 100644
--- a/arch/arm64/mm/hugetlbpage.c
+++ b/arch/arm64/mm/hugetlbpage.c
@@ -294,7 +294,7 @@ pte_t *huge_pte_offset(struct mm_struct *mm,
 	if (!(sz == PMD_SIZE || sz == CONT_PMD_SIZE) &&
 	    pmd_none(pmd))
 		return NULL;
-	if (pmd_huge(pmd) || !pmd_present(pmd))
+	if (pmd_huge(pmd) || !pte_present(pmd_pte(pmd)))
 		return (pte_t *)pmdp;
 
 	if (sz == CONT_PTE_SIZE)
diff --git a/arch/arm64/mm/mmu.c b/arch/arm64/mm/mmu.c
index 990929c8837e..337519031115 100644
--- a/arch/arm64/mm/mmu.c
+++ b/arch/arm64/mm/mmu.c
@@ -22,6 +22,8 @@
 #include <linux/io.h>
 #include <linux/mm.h>
 #include <linux/vmalloc.h>
+#include <linux/swap.h>
+#include <linux/swapops.h>
 
 #include <asm/barrier.h>
 #include <asm/cputype.h>
@@ -1483,3 +1485,21 @@ static int __init prevent_bootmem_remove_init(void)
 }
 device_initcall(prevent_bootmem_remove_init);
 #endif
+
+#ifdef CONFIG_TRANSPARENT_HUGEPAGE
+void set_pmd_at(struct mm_struct *mm, unsigned long addr,
+		pmd_t *pmdp, pmd_t pmd)
+{
+	/*
+	 * PMD migration entries need to retain splitting PMD
+	 * representation created with pmdp_invalidate(). But
+	 * any non-migration entry which just might have been
+	 * invalidated previously, still need be a normal huge
+	 * page. Hence selectively clear splitting entries.
+	 */
+	if (!is_migration_entry(pmd_to_swp_entry(pmd)))
+		pmd = pmd_clrsplitting(pmd);
+
+	set_pte_at(mm, addr, (pte_t *)pmdp, pmd_pte(pmd));
+}
+#endif
-- 
2.20.1

