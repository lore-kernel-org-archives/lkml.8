Return-Path: <SRS0=8grS=CJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.0 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 91E90C433E6
	for <linux-kernel@archiver.kernel.org>; Mon, 31 Aug 2020 08:30:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 75D882073A
	for <linux-kernel@archiver.kernel.org>; Mon, 31 Aug 2020 08:30:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728405AbgHaIax (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 31 Aug 2020 04:30:53 -0400
Received: from pegase1.c-s.fr ([93.17.236.30]:14548 "EHLO pegase1.c-s.fr"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728147AbgHaIas (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 31 Aug 2020 04:30:48 -0400
Received: from localhost (mailhub1-int [192.168.12.234])
        by localhost (Postfix) with ESMTP id 4Bg3LS3VFFz9v478;
        Mon, 31 Aug 2020 10:30:40 +0200 (CEST)
X-Virus-Scanned: Debian amavisd-new at c-s.fr
Received: from pegase1.c-s.fr ([192.168.12.234])
        by localhost (pegase1.c-s.fr [192.168.12.234]) (amavisd-new, port 10024)
        with ESMTP id xUqf6y9tCXfm; Mon, 31 Aug 2020 10:30:40 +0200 (CEST)
Received: from messagerie.si.c-s.fr (messagerie.si.c-s.fr [192.168.25.192])
        by pegase1.c-s.fr (Postfix) with ESMTP id 4Bg3LS2Y5bz9v470;
        Mon, 31 Aug 2020 10:30:40 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
        by messagerie.si.c-s.fr (Postfix) with ESMTP id 4E2628B799;
        Mon, 31 Aug 2020 10:30:45 +0200 (CEST)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from messagerie.si.c-s.fr ([127.0.0.1])
        by localhost (messagerie.si.c-s.fr [127.0.0.1]) (amavisd-new, port 10023)
        with ESMTP id PouFLmaQOdgA; Mon, 31 Aug 2020 10:30:45 +0200 (CEST)
Received: from po17688vm.idsi0.si.c-s.fr (po15451.idsi0.si.c-s.fr [172.25.230.104])
        by messagerie.si.c-s.fr (Postfix) with ESMTP id 101108B7BB;
        Mon, 31 Aug 2020 10:30:45 +0200 (CEST)
Received: by po17688vm.idsi0.si.c-s.fr (Postfix, from userid 0)
        id 83FC065D48; Mon, 31 Aug 2020 08:30:44 +0000 (UTC)
Message-Id: <a518abc29266a708dfbccc8fce9ae6694fe4c2c6.1598862623.git.christophe.leroy@csgroup.eu>
In-Reply-To: <f6ea2483c2c389567b007945948f704d18cfaeea.1598862623.git.christophe.leroy@csgroup.eu>
References: <f6ea2483c2c389567b007945948f704d18cfaeea.1598862623.git.christophe.leroy@csgroup.eu>
From:   Christophe Leroy <christophe.leroy@csgroup.eu>
Subject: [PATCH 2/2] powerpc/8xx: Support 16k hugepages with 4k pages
To:     Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>,
        Michael Ellerman <mpe@ellerman.id.au>
Cc:     linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org
Date:   Mon, 31 Aug 2020 08:30:44 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The 8xx has 4 page sizes: 4k, 16k, 512k and 8M

4k and 16k can be selected at build time as standard page sizes,
and 512k and 8M are hugepages.

When 4k standard pages are selected, 16k pages are not available.

Allow 16k pages as hugepages when 4k pages are used.

To allow that, implement arch_make_huge_pte() which receives
the necessary arguments to allow setting the PTE in accordance
with the page size:
- 512 k pages must have _PAGE_HUGE and _PAGE_SPS. They are set
by pte_mkhuge(). arch_make_huge_pte() does nothing.
- 16 k pages must have only _PAGE_SPS. arch_make_huge_pte() clears
_PAGE_HUGE.

Signed-off-by: Christophe Leroy <christophe.leroy@csgroup.eu>
---
 arch/powerpc/include/asm/nohash/32/hugetlb-8xx.h | 14 ++++++++++++++
 arch/powerpc/include/asm/nohash/32/pgtable.h     |  2 ++
 arch/powerpc/mm/hugetlbpage.c                    |  2 +-
 arch/powerpc/mm/nohash/tlb.c                     |  4 ----
 arch/powerpc/mm/ptdump/8xx.c                     |  5 +++++
 include/uapi/asm-generic/hugetlb_encode.h        |  1 +
 include/uapi/linux/mman.h                        |  1 +
 7 files changed, 24 insertions(+), 5 deletions(-)

diff --git a/arch/powerpc/include/asm/nohash/32/hugetlb-8xx.h b/arch/powerpc/include/asm/nohash/32/hugetlb-8xx.h
index e752a5807a59..39be9aea86db 100644
--- a/arch/powerpc/include/asm/nohash/32/hugetlb-8xx.h
+++ b/arch/powerpc/include/asm/nohash/32/hugetlb-8xx.h
@@ -65,4 +65,18 @@ static inline void huge_ptep_set_wrprotect(struct mm_struct *mm,
 	pte_update(mm, addr, ptep, clr, set, 1);
 }
 
+#ifdef CONFIG_PPC_4K_PAGES
+static inline pte_t arch_make_huge_pte(pte_t entry, struct vm_area_struct *vma,
+				       struct page *page, int writable)
+{
+	size_t size = huge_page_size(hstate_vma(vma));
+
+	if (size == SZ_16K)
+		return __pte(pte_val(entry) & ~_PAGE_HUGE);
+	else
+		return entry;
+}
+#define arch_make_huge_pte arch_make_huge_pte
+#endif
+
 #endif /* _ASM_POWERPC_NOHASH_32_HUGETLB_8XX_H */
diff --git a/arch/powerpc/include/asm/nohash/32/pgtable.h b/arch/powerpc/include/asm/nohash/32/pgtable.h
index 80bbc21b87f0..ee2243ba96cf 100644
--- a/arch/powerpc/include/asm/nohash/32/pgtable.h
+++ b/arch/powerpc/include/asm/nohash/32/pgtable.h
@@ -235,6 +235,8 @@ static int number_of_cells_per_pte(pmd_t *pmd, pte_basic_t val, int huge)
 		return PAGE_SIZE / SZ_4K;
 	else if (hugepd_ok(*((hugepd_t *)pmd)))
 		return 1;
+	else if (IS_ENABLED(CONFIG_PPC_4K_PAGES) && !(val & _PAGE_HUGE))
+		return SZ_16K / SZ_4K;
 	else
 		return SZ_512K / SZ_4K;
 }
diff --git a/arch/powerpc/mm/hugetlbpage.c b/arch/powerpc/mm/hugetlbpage.c
index e7ae2a2c4545..36c3800769fb 100644
--- a/arch/powerpc/mm/hugetlbpage.c
+++ b/arch/powerpc/mm/hugetlbpage.c
@@ -180,7 +180,7 @@ pte_t *huge_pte_alloc(struct mm_struct *mm, unsigned long addr, unsigned long sz
 	if (!hpdp)
 		return NULL;
 
-	if (IS_ENABLED(CONFIG_PPC_8xx) && sz == SZ_512K)
+	if (IS_ENABLED(CONFIG_PPC_8xx) && pshift < PMD_SHIFT)
 		return pte_alloc_map(mm, (pmd_t *)hpdp, addr);
 
 	BUG_ON(!hugepd_none(*hpdp) && !hugepd_ok(*hpdp));
diff --git a/arch/powerpc/mm/nohash/tlb.c b/arch/powerpc/mm/nohash/tlb.c
index 14514585db98..5872f69141d5 100644
--- a/arch/powerpc/mm/nohash/tlb.c
+++ b/arch/powerpc/mm/nohash/tlb.c
@@ -83,16 +83,12 @@ struct mmu_psize_def mmu_psize_defs[MMU_PAGE_COUNT] = {
 };
 #elif defined(CONFIG_PPC_8xx)
 struct mmu_psize_def mmu_psize_defs[MMU_PAGE_COUNT] = {
-	/* we only manage 4k and 16k pages as normal pages */
-#ifdef CONFIG_PPC_4K_PAGES
 	[MMU_PAGE_4K] = {
 		.shift	= 12,
 	},
-#else
 	[MMU_PAGE_16K] = {
 		.shift	= 14,
 	},
-#endif
 	[MMU_PAGE_512K] = {
 		.shift	= 19,
 	},
diff --git a/arch/powerpc/mm/ptdump/8xx.c b/arch/powerpc/mm/ptdump/8xx.c
index 8a797dcbf475..86da2a669680 100644
--- a/arch/powerpc/mm/ptdump/8xx.c
+++ b/arch/powerpc/mm/ptdump/8xx.c
@@ -11,8 +11,13 @@
 
 static const struct flag_info flag_array[] = {
 	{
+#ifdef CONFIG_PPC_16K_PAGES
 		.mask	= _PAGE_HUGE,
 		.val	= _PAGE_HUGE,
+#else
+		.mask	= _PAGE_SPS,
+		.val	= _PAGE_SPS,
+#endif
 		.set	= "huge",
 		.clear	= "    ",
 	}, {
diff --git a/include/uapi/asm-generic/hugetlb_encode.h b/include/uapi/asm-generic/hugetlb_encode.h
index b0f8e87235bd..4f3d5aaa11f5 100644
--- a/include/uapi/asm-generic/hugetlb_encode.h
+++ b/include/uapi/asm-generic/hugetlb_encode.h
@@ -20,6 +20,7 @@
 #define HUGETLB_FLAG_ENCODE_SHIFT	26
 #define HUGETLB_FLAG_ENCODE_MASK	0x3f
 
+#define HUGETLB_FLAG_ENCODE_16KB	(14 << HUGETLB_FLAG_ENCODE_SHIFT)
 #define HUGETLB_FLAG_ENCODE_64KB	(16 << HUGETLB_FLAG_ENCODE_SHIFT)
 #define HUGETLB_FLAG_ENCODE_512KB	(19 << HUGETLB_FLAG_ENCODE_SHIFT)
 #define HUGETLB_FLAG_ENCODE_1MB		(20 << HUGETLB_FLAG_ENCODE_SHIFT)
diff --git a/include/uapi/linux/mman.h b/include/uapi/linux/mman.h
index 923cc162609c..f55bc680b5b0 100644
--- a/include/uapi/linux/mman.h
+++ b/include/uapi/linux/mman.h
@@ -27,6 +27,7 @@
 #define MAP_HUGE_SHIFT	HUGETLB_FLAG_ENCODE_SHIFT
 #define MAP_HUGE_MASK	HUGETLB_FLAG_ENCODE_MASK
 
+#define MAP_HUGE_16KB	HUGETLB_FLAG_ENCODE_16KB
 #define MAP_HUGE_64KB	HUGETLB_FLAG_ENCODE_64KB
 #define MAP_HUGE_512KB	HUGETLB_FLAG_ENCODE_512KB
 #define MAP_HUGE_1MB	HUGETLB_FLAG_ENCODE_1MB
-- 
2.25.0

