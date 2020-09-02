Return-Path: <SRS0=728o=CL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 55BCBC433E7
	for <linux-kernel@archiver.kernel.org>; Wed,  2 Sep 2020 18:07:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0A01C2083B
	for <linux-kernel@archiver.kernel.org>; Wed,  2 Sep 2020 18:07:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=sent.com header.i=@sent.com header.b="P8P7CfEl";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="MkeIbM+2"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728126AbgIBSHk (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 2 Sep 2020 14:07:40 -0400
Received: from out1-smtp.messagingengine.com ([66.111.4.25]:42567 "EHLO
        out1-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727932AbgIBSGm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Sep 2020 14:06:42 -0400
Received: from compute4.internal (compute4.nyi.internal [10.202.2.44])
        by mailout.nyi.internal (Postfix) with ESMTP id 8F0C55C0124;
        Wed,  2 Sep 2020 14:06:33 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute4.internal (MEProxy); Wed, 02 Sep 2020 14:06:33 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sent.com; h=from
        :to:cc:subject:date:message-id:in-reply-to:references:reply-to
        :mime-version:content-transfer-encoding; s=fm1; bh=VqjbKpwSxWZRQ
        y6eLruyGy2XZPSqw79Q7BA1v8F56IU=; b=P8P7CfEloHLWcv67cAe3Of3TnCn7S
        f/Nhqk+npLVLSQbxlR7oIAg1/kCbMyi1ni0oB78W4AT1DndApXMnJI8BFcl3cnpJ
        Kpq5CXcG3LtjKGVO+epc2OviDrLJv7AlFuBP2n8SA9uthGznOqUEV84lkPKtHzru
        WSJTq3uH9BYIOpwfSQgck5X4pk3z5Au09fXIrOf77JGy/typ6GOSHz1uUKEnpnva
        nI7eJ1R348lpvcZwGq63jqmZrxA88RTlKQEBLsgPMOBy8AqPVyLj5xzvE/nOYcyZ
        dEZy0MTjAtqGWZT4eZgWAr+bCe4tymZhLbcMDTSt1v9v4A/MWEqZxzu+A==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-transfer-encoding:date:from
        :in-reply-to:message-id:mime-version:references:reply-to:subject
        :to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
        fm3; bh=VqjbKpwSxWZRQy6eLruyGy2XZPSqw79Q7BA1v8F56IU=; b=MkeIbM+2
        TUIhWNqYZuNW4jx96eAMxGrJ4KNy4SF/6kj/BMHdL9Lzbj9JUrO69zSI5ogt9p/u
        J2zB79jD0VuGoqSqaVb9B4KmcLPspgfQsm/9LCysPlH3ejrarX1o6ULvbaUTMll9
        u7adAKKZmwPmM0gpgnK0Opaq0eYJ1vYHCzcyTcFlBvhYUyAkMR2tNL8U8trYv/8v
        QdTvAxF/6ZF+zOsA2IoRkLAWT4LswWGqsgMIePu61cvx0KWh12MMKh+o+LwHrSnf
        QSRjM4jOoF6P+F8imd59WMScnvvfaUbmhvlp08Shb6Q57OwoyMxgS7mK2E1XKS19
        qAlTcFBs+pV55A==
X-ME-Sender: <xms:KN9PXynSM4HVGYF7G8p1hjnnl4CfpULauvYaU0in_dJTcY38PWTr1A>
    <xme:KN9PX51toyWlVEPURQSsyG-rnQOFCm5pEwUeau3d5ZbOIxxseuIH4Z0G7DnBKNtkx
    meZBY4pP24AHA8-JQ>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeduiedrudefledguddvudcutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfgh
    necuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmd
    enucfjughrpefhvffufffkofgjfhhrggfgsedtkeertdertddtnecuhfhrohhmpegkihcu
    jggrnhcuoeiiihdrhigrnhesshgvnhhtrdgtohhmqeenucggtffrrghtthgvrhhnpeduhf
    ffveektdduhfdutdfgtdekkedvhfetuedufedtgffgvdevleehheevjefgtdenucfkphep
    uddvrdegiedruddtiedrudeigeenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmh
    epmhgrihhlfhhrohhmpeiiihdrhigrnhesshgvnhhtrdgtohhm
X-ME-Proxy: <xmx:KN9PXwoSLQVYjC0HmPjb1DRI1-rFId4IBp9psJmSx4gJV0Qo7Yy2Jw>
    <xmx:KN9PX2kWgUQsRENB3H6dL8XyBgmTP-PVC_75nchWDEE5cuhyIg05MQ>
    <xmx:KN9PXw2lKBgG6Xutt25FN-bjMwDXPH08XPHuvkF7T-OKyLgytyNseQ>
    <xmx:Kd9PXxmZ51IhoTCLlt758CDphKFCU2WnFsCdeV-jPjU9SAb5BdB1QQ>
Received: from nvrsysarch6.NVidia.COM (unknown [12.46.106.164])
        by mail.messagingengine.com (Postfix) with ESMTPA id 2943130605C8;
        Wed,  2 Sep 2020 14:06:32 -0400 (EDT)
From:   Zi Yan <zi.yan@sent.com>
To:     linux-mm@kvack.org, Roman Gushchin <guro@fb.com>
Cc:     Rik van Riel <riel@surriel.com>,
        "Kirill A . Shutemov" <kirill.shutemov@linux.intel.com>,
        Matthew Wilcox <willy@infradead.org>,
        Shakeel Butt <shakeelb@google.com>,
        Yang Shi <yang.shi@linux.alibaba.com>,
        David Nellans <dnellans@nvidia.com>,
        linux-kernel@vger.kernel.org, Zi Yan <ziy@nvidia.com>
Subject: [RFC PATCH 06/16] mm: thp: add 1GB THP split_huge_pud_page() function.
Date:   Wed,  2 Sep 2020 14:06:18 -0400
Message-Id: <20200902180628.4052244-7-zi.yan@sent.com>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <20200902180628.4052244-1-zi.yan@sent.com>
References: <20200902180628.4052244-1-zi.yan@sent.com>
Reply-To: Zi Yan <ziy@nvidia.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Zi Yan <ziy@nvidia.com>

It mimics PMD-level THP split. In addition, to support PMD-mapped PUD
THP, PMDPageInPUD() is used. For the mapcount of PMD-mapped PUD THP,
sub_compound_mapcount() is used, which uses
(head_page+3).compound_mapcount, since each base page's mapcount is used
for PTE mapping. PagePUDDoubleMap() is used for both PUD-mapped and
PMD-mapped PUD THPs.

page_xxx_rmap() functions now have an extra page order parameter to
distinguish different THP sizes.

Signed-off-by: Zi Yan <ziy@nvidia.com>
---
 arch/x86/include/asm/pgtable.h |  21 ++
 include/linux/huge_mm.h        |  31 +-
 include/linux/memcontrol.h     |   5 +
 include/linux/mm.h             |  25 +-
 include/linux/page-flags.h     |  47 +++
 include/linux/pgtable.h        |  17 ++
 include/linux/rmap.h           |   9 +-
 include/linux/swap.h           |   2 +
 include/linux/vm_event_item.h  |   4 +
 kernel/events/uprobes.c        |   4 +-
 mm/huge_memory.c               | 536 +++++++++++++++++++++++++++++++--
 mm/hugetlb.c                   |   4 +-
 mm/khugepaged.c                |   6 +-
 mm/ksm.c                       |   4 +-
 mm/memcontrol.c                |  13 +
 mm/memory.c                    |  18 +-
 mm/migrate.c                   |  10 +-
 mm/page_alloc.c                |  20 +-
 mm/pgtable-generic.c           |  11 +
 mm/rmap.c                      | 106 +++++--
 mm/swap.c                      |  31 ++
 mm/swapfile.c                  |   4 +-
 mm/userfaultfd.c               |   2 +-
 mm/util.c                      |  16 +-
 mm/vmstat.c                    |   4 +
 25 files changed, 852 insertions(+), 98 deletions(-)

diff --git a/arch/x86/include/asm/pgtable.h b/arch/x86/include/asm/pgtable.h
index 15334f5ba172..fe4600256bc7 100644
--- a/arch/x86/include/asm/pgtable.h
+++ b/arch/x86/include/asm/pgtable.h
@@ -630,6 +630,12 @@ static inline pmd_t pmd_mkinvalid(pmd_t pmd)
 		      __pgprot(pmd_flags(pmd) & ~(_PAGE_PRESENT|_PAGE_PROTNONE)));
 }
 
+static inline pud_t pud_mknotpresent(pud_t pud)
+{
+	return pfn_pud(pud_pfn(pud),
+	      __pgprot(pud_flags(pud) & ~(_PAGE_PRESENT|_PAGE_PROTNONE)));
+}
+
 static inline u64 flip_protnone_guard(u64 oldval, u64 val, u64 mask);
 
 static inline pte_t pte_modify(pte_t pte, pgprot_t newprot)
@@ -1246,6 +1252,21 @@ static inline p4d_t *user_to_kernel_p4dp(p4d_t *p4dp)
 }
 #endif /* CONFIG_PAGE_TABLE_ISOLATION */
 
+#ifndef pudp_establish
+#define pudp_establish pudp_establish
+static inline pud_t pudp_establish(struct vm_area_struct *vma,
+		unsigned long address, pud_t *pudp, pud_t pud)
+{
+	if (IS_ENABLED(CONFIG_SMP)) {
+		return xchg(pudp, pud);
+	} else {
+		pud_t old = *pudp;
+		*pudp = pud;
+		return old;
+	}
+}
+#endif
+
 /*
  * clone_pgd_range(pgd_t *dst, pgd_t *src, int count);
  *
diff --git a/include/linux/huge_mm.h b/include/linux/huge_mm.h
index 0c20a8ea6911..589e5af5a1c2 100644
--- a/include/linux/huge_mm.h
+++ b/include/linux/huge_mm.h
@@ -227,17 +227,27 @@ void __split_huge_pmd(struct vm_area_struct *vma, pmd_t *pmd,
 void split_huge_pmd_address(struct vm_area_struct *vma, unsigned long address,
 		bool freeze, struct page *page);
 
+bool can_split_huge_pud_page(struct page *page, int *pextra_pins);
+int split_huge_pud_page_to_list(struct page *page, struct list_head *list);
+static inline int split_huge_pud_page(struct page *page)
+{
+	return split_huge_pud_page_to_list(page, NULL);
+}
 void __split_huge_pud(struct vm_area_struct *vma, pud_t *pud,
-		unsigned long address);
+		unsigned long address, bool freeze, struct page *page);
 
 #define split_huge_pud(__vma, __pud, __address)				\
 	do {								\
 		pud_t *____pud = (__pud);				\
 		if (pud_trans_huge(*____pud)				\
 					|| pud_devmap(*____pud))	\
-			__split_huge_pud(__vma, __pud, __address);	\
+			__split_huge_pud(__vma, __pud, __address,	\
+						false, NULL);		\
 	}  while (0)
 
+void split_huge_pud_address(struct vm_area_struct *vma, unsigned long address,
+		bool freeze, struct page *page);
+
 extern int hugepage_madvise(struct vm_area_struct *vma,
 			    unsigned long *vm_flags, int advice);
 extern void vma_adjust_trans_huge(struct vm_area_struct *vma,
@@ -427,8 +437,25 @@ static inline void __split_huge_pmd(struct vm_area_struct *vma, pmd_t *pmd,
 static inline void split_huge_pmd_address(struct vm_area_struct *vma,
 		unsigned long address, bool freeze, struct page *page) {}
 
+static inline bool
+can_split_huge_pud_page(struct page *page, int *pextra_pins)
+{
+	BUILD_BUG();
+	return false;
+}
+static inline int
+split_huge_pud_page_to_list(struct page *page, struct list_head *list)
+{
+	return 0;
+}
+static inline int split_huge_pud_page(struct page *page)
+{
+	return 0;
+}
 #define split_huge_pud(__vma, __pmd, __address)	\
 	do { } while (0)
+static inline void split_huge_pud_address(struct vm_area_struct *vma,
+		unsigned long address, bool freeze, struct page *page) {}
 
 static inline int hugepage_madvise(struct vm_area_struct *vma,
 				   unsigned long *vm_flags, int advice)
diff --git a/include/linux/memcontrol.h b/include/linux/memcontrol.h
index d0b036123c6a..3ccff298d4b2 100644
--- a/include/linux/memcontrol.h
+++ b/include/linux/memcontrol.h
@@ -929,6 +929,7 @@ static inline void memcg_memory_event_mm(struct mm_struct *mm,
 
 #ifdef CONFIG_TRANSPARENT_HUGEPAGE
 void mem_cgroup_split_huge_fixup(struct page *head);
+void mem_cgroup_split_huge_pud_fixup(struct page *head);
 #endif
 
 #else /* CONFIG_MEMCG */
@@ -1261,6 +1262,10 @@ static inline void mem_cgroup_split_huge_fixup(struct page *head)
 {
 }
 
+static inline void mem_cgroup_split_huge_pud_fixup(struct page *head)
+{
+}
+
 static inline void count_memcg_events(struct mem_cgroup *memcg,
 				      enum vm_event_item idx,
 				      unsigned long count)
diff --git a/include/linux/mm.h b/include/linux/mm.h
index cb1ccf804404..8a85d96ab7e5 100644
--- a/include/linux/mm.h
+++ b/include/linux/mm.h
@@ -797,6 +797,24 @@ static inline int compound_mapcount(struct page *page)
 	return head_compound_mapcount(page);
 }
 
+static inline unsigned int compound_order(struct page *page);
+static inline atomic_t *sub_compound_mapcount_ptr(struct page *page, int sub_level)
+{
+	struct page *head = compound_head(page);
+
+	VM_BUG_ON_PAGE(!PageCompound(page), page);
+	VM_BUG_ON_PAGE(compound_order(head) != HPAGE_PUD_ORDER, page);
+	VM_BUG_ON_PAGE((page - head) % HPAGE_PMD_NR, page);
+	VM_BUG_ON_PAGE(sub_level != 1, page);
+	return &page[2 + sub_level].compound_mapcount;
+}
+
+/* Only works for PUD pages */
+static inline int sub_compound_mapcount(struct page *page)
+{
+	return atomic_read(sub_compound_mapcount_ptr(page, 1)) + 1;
+}
+
 /*
  * The atomic page->_mapcount, starts from -1: so that transitions
  * both from it and to it can be tracked, using atomic_inc_and_test
@@ -889,13 +907,6 @@ static inline void destroy_compound_page(struct page *page)
 	compound_page_dtors[page[1].compound_dtor](page);
 }
 
-static inline unsigned int compound_order(struct page *page)
-{
-	if (!PageHead(page))
-		return 0;
-	return page[1].compound_order;
-}
-
 static inline bool hpage_pincount_available(struct page *page)
 {
 	/*
diff --git a/include/linux/page-flags.h b/include/linux/page-flags.h
index fbbb841a9346..cdca0165d2db 100644
--- a/include/linux/page-flags.h
+++ b/include/linux/page-flags.h
@@ -235,6 +235,9 @@ static inline void page_init_poison(struct page *page, size_t size)
  *
  * PF_SECOND:
  *     the page flag is stored in the first tail page.
+ *
+ * PF_THIRD:
+ *     the page flag is stored in the second tail page.
  */
 #define PF_POISONED_CHECK(page) ({					\
 		VM_BUG_ON_PGFLAGS(PagePoisoned(page), page);		\
@@ -253,6 +256,9 @@ static inline void page_init_poison(struct page *page, size_t size)
 #define PF_SECOND(page, enforce) ({					\
 		VM_BUG_ON_PGFLAGS(!PageHead(page), page);		\
 		PF_POISONED_CHECK(&page[1]); })
+#define PF_THIRD(page, enforce) ({					\
+		VM_BUG_ON_PGFLAGS(!PageHead(page), page);		\
+		PF_POISONED_CHECK(&page[2]); })
 
 /*
  * Macros to create function definitions for page flags
@@ -674,6 +680,29 @@ static inline int PageTransTail(struct page *page)
 	return PageTail(page);
 }
 
+#define HPAGE_PMD_SHIFT PMD_SHIFT
+#define HPAGE_PMD_ORDER (HPAGE_PMD_SHIFT-PAGE_SHIFT)
+#define HPAGE_PMD_NR (1<<HPAGE_PMD_ORDER)
+
+#define HPAGE_PUD_SHIFT PUD_SHIFT
+#define HPAGE_PUD_ORDER (HPAGE_PUD_SHIFT-PAGE_SHIFT)
+#define HPAGE_PUD_NR (1<<HPAGE_PUD_ORDER)
+
+static inline unsigned int compound_order(struct page *page)
+{
+	if (!PageHead(page))
+		return 0;
+	return page[1].compound_order;
+}
+
+
+static inline int PMDPageInPUD(struct page *page)
+{
+	struct page *head = compound_head(page);
+	return (PageCompound(page) && compound_order(head) == HPAGE_PUD_ORDER &&
+		((page - head) % HPAGE_PMD_NR == 0));
+}
+
 /*
  * PageDoubleMap indicates that the compound page is mapped with PTEs as well
  * as PMDs.
@@ -689,13 +718,31 @@ static inline int PageTransTail(struct page *page)
  */
 PAGEFLAG(DoubleMap, double_map, PF_SECOND)
 	TESTSCFLAG(DoubleMap, double_map, PF_SECOND)
+/*
+ * PagePUDDoubleMap indicates that the compound page is mapped with PMDs as well
+ * as PUDs.
+ *
+ * This is required for optimization of rmap operations for THP: we can postpone
+ * per small page mapcount accounting (and its overhead from atomic operations)
+ * until the first PUD split.
+ *
+ * For the page PagePUDDoubleMap means ->_mapcount in all sub-PMD pages is
+ * offset up by one. This reference will go away with last sub_compound_mapcount.
+ *
+ * See also __split_huge_pud_locked() and page_remove_anon_compound_rmap().
+ */
+PAGEFLAG(PUDDoubleMap, double_map, PF_THIRD)
+	TESTSCFLAG(PUDDoubleMap, double_map, PF_THIRD)
 #else
 TESTPAGEFLAG_FALSE(TransHuge)
 TESTPAGEFLAG_FALSE(TransCompound)
 TESTPAGEFLAG_FALSE(TransCompoundMap)
 TESTPAGEFLAG_FALSE(TransTail)
+TESTPAGEFLAG_FALSE(PMDPageInPUD)
 PAGEFLAG_FALSE(DoubleMap)
 	TESTSCFLAG_FALSE(DoubleMap)
+PAGEFLAG_FALSE(PUDDoubleMap)
+	TESTSETFLAG_FALSE(PUDDoubleMap)
 #endif
 
 /*
diff --git a/include/linux/pgtable.h b/include/linux/pgtable.h
index 8ef358c386af..7acf218a8879 100644
--- a/include/linux/pgtable.h
+++ b/include/linux/pgtable.h
@@ -505,6 +505,11 @@ extern pmd_t pmdp_invalidate(struct vm_area_struct *vma, unsigned long address,
 			    pmd_t *pmdp);
 #endif
 
+#ifndef __HAVE_ARCH_PUDP_INVALIDATE
+extern pud_t pudp_invalidate(struct vm_area_struct *vma, unsigned long address,
+			    pud_t *pudp);
+#endif
+
 #ifndef __HAVE_ARCH_PTE_SAME
 static inline int pte_same(pte_t pte_a, pte_t pte_b)
 {
@@ -1158,6 +1163,18 @@ static inline pmd_t pmd_read_atomic(pmd_t *pmdp)
 }
 #endif
 
+#ifndef pud_read_atomic
+static inline pud_t pud_read_atomic(pud_t *pudp)
+{
+	/*
+	 * Depend on compiler for an atomic pmd read. NOTE: this is
+	 * only going to work, if the pmdval_t isn't larger than
+	 * an unsigned long.
+	 */
+	return *pudp;
+}
+#endif
+
 #ifndef arch_needs_pgtable_deposit
 #define arch_needs_pgtable_deposit() (false)
 #endif
diff --git a/include/linux/rmap.h b/include/linux/rmap.h
index 0af61dd193d2..c43da5919354 100644
--- a/include/linux/rmap.h
+++ b/include/linux/rmap.h
@@ -99,6 +99,7 @@ enum ttu_flags {
 	TTU_RMAP_LOCKED		= 0x80,	/* do not grab rmap lock:
 					 * caller holds it */
 	TTU_SPLIT_FREEZE	= 0x100,		/* freeze pte under splitting thp */
+	TTU_SPLIT_HUGE_PUD	= 0x200,		/* split huge PUD if any */
 };
 
 #ifdef CONFIG_MMU
@@ -171,13 +172,13 @@ struct anon_vma *page_get_anon_vma(struct page *page);
  */
 void page_move_anon_rmap(struct page *, struct vm_area_struct *);
 void page_add_anon_rmap(struct page *, struct vm_area_struct *,
-		unsigned long, bool);
+		unsigned long, bool, int);
 void do_page_add_anon_rmap(struct page *, struct vm_area_struct *,
-			   unsigned long, int);
+			   unsigned long, int, int);
 void page_add_new_anon_rmap(struct page *, struct vm_area_struct *,
-		unsigned long, bool);
+		unsigned long, bool, int);
 void page_add_file_rmap(struct page *, bool);
-void page_remove_rmap(struct page *, bool);
+void page_remove_rmap(struct page *, bool, int);
 
 void hugepage_add_anon_rmap(struct page *, struct vm_area_struct *,
 			    unsigned long);
diff --git a/include/linux/swap.h b/include/linux/swap.h
index 5c48713221fe..871c62211ecd 100644
--- a/include/linux/swap.h
+++ b/include/linux/swap.h
@@ -340,6 +340,8 @@ extern void lru_note_cost_page(struct page *);
 extern void lru_cache_add(struct page *);
 extern void lru_add_page_tail(struct page *page, struct page *page_tail,
 			 struct lruvec *lruvec, struct list_head *head);
+extern void lru_add_pud_page_tail(struct page *page, struct page *page_tail,
+			 struct lruvec *lruvec, struct list_head *head);
 extern void mark_page_accessed(struct page *);
 extern void lru_add_drain(void);
 extern void lru_add_drain_cpu(int cpu);
diff --git a/include/linux/vm_event_item.h b/include/linux/vm_event_item.h
index a3f1093a55bb..b336de64586c 100644
--- a/include/linux/vm_event_item.h
+++ b/include/linux/vm_event_item.h
@@ -96,6 +96,10 @@ enum vm_event_item { PGPGIN, PGPGOUT, PSWPIN, PSWPOUT,
 		THP_FAULT_FALLBACK_PUD,
 		THP_FAULT_FALLBACK_PUD_CHARGE,
 		THP_SPLIT_PUD,
+		THP_SPLIT_PUD_PAGE,
+		THP_SPLIT_PUD_PAGE_FAILED,
+		THP_ZERO_PUD_PAGE_ALLOC,
+		THP_ZERO_PUD_PAGE_ALLOC_FAILED,
 #endif
 		THP_ZERO_PAGE_ALLOC,
 		THP_ZERO_PAGE_ALLOC_FAILED,
diff --git a/kernel/events/uprobes.c b/kernel/events/uprobes.c
index 0e18aaf23a7b..834b350a49f6 100644
--- a/kernel/events/uprobes.c
+++ b/kernel/events/uprobes.c
@@ -183,7 +183,7 @@ static int __replace_page(struct vm_area_struct *vma, unsigned long addr,
 
 	if (new_page) {
 		get_page(new_page);
-		page_add_new_anon_rmap(new_page, vma, addr, false);
+		page_add_new_anon_rmap(new_page, vma, addr, false, 0);
 		lru_cache_add_inactive_or_unevictable(new_page, vma);
 	} else
 		/* no new page, just dec_mm_counter for old_page */
@@ -200,7 +200,7 @@ static int __replace_page(struct vm_area_struct *vma, unsigned long addr,
 		set_pte_at_notify(mm, addr, pvmw.pte,
 				  mk_pte(new_page, vma->vm_page_prot));
 
-	page_remove_rmap(old_page, false);
+	page_remove_rmap(old_page, false, 0);
 	if (!page_mapped(old_page))
 		try_to_free_swap(old_page);
 	page_vma_mapped_walk_done(&pvmw);
diff --git a/mm/huge_memory.c b/mm/huge_memory.c
index 6da9b02501b7..398f1b52f789 100644
--- a/mm/huge_memory.c
+++ b/mm/huge_memory.c
@@ -618,7 +618,7 @@ static vm_fault_t __do_huge_pmd_anonymous_page(struct vm_fault *vmf,
 
 		entry = mk_huge_pmd(page, vma->vm_page_prot);
 		entry = maybe_pmd_mkwrite(pmd_mkdirty(entry), vma);
-		page_add_new_anon_rmap(page, vma, haddr, true);
+		page_add_new_anon_rmap(page, vma, haddr, true, HPAGE_PMD_ORDER);
 		lru_cache_add_inactive_or_unevictable(page, vma);
 		pgtable_trans_huge_deposit(vma->vm_mm, vmf->pmd, pgtable);
 		set_pmd_at(vma->vm_mm, haddr, vmf->pmd, entry);
@@ -991,7 +991,7 @@ static int __do_huge_pud_anonymous_page(struct vm_fault *vmf, struct page *page,
 
 		entry = mk_huge_pud(page, vma->vm_page_prot);
 		entry = maybe_pud_mkwrite(pud_mkdirty(entry), vma);
-		page_add_new_anon_rmap(page, vma, haddr, true);
+		page_add_new_anon_rmap(page, vma, haddr, true, HPAGE_PUD_ORDER);
 		lru_cache_add_inactive_or_unevictable(page, vma);
 		pgtable_trans_huge_pud_deposit(vma->vm_mm, vmf->pud,
 				virt_to_page(pmd_pgtable));
@@ -1384,7 +1384,7 @@ vm_fault_t do_huge_pud_wp_page(struct vm_fault *vmf, pud_t orig_pud)
 	unlock_page(page);
 	spin_unlock(vmf->ptl);
 fallback:
-	__split_huge_pud(vma, vmf->pud, vmf->address);
+	__split_huge_pud(vma, vmf->pud, vmf->address, false, NULL);
 	return VM_FAULT_FALLBACK;
 }
 
@@ -1825,9 +1825,9 @@ int zap_huge_pmd(struct mmu_gather *tlb, struct vm_area_struct *vma,
 
 		if (pmd_present(orig_pmd)) {
 			page = pmd_page(orig_pmd);
-			page_remove_rmap(page, true);
+			page_remove_rmap(page, true, HPAGE_PMD_ORDER);
 			VM_BUG_ON_PAGE(page_mapcount(page) < 0, page);
-			VM_BUG_ON_PAGE(!PageHead(page), page);
+			VM_BUG_ON_PAGE(!PageHead(page) && !PMDPageInPUD(page), page);
 		} else if (thp_migration_supported()) {
 			swp_entry_t entry;
 
@@ -2111,7 +2111,7 @@ int zap_huge_pud(struct mmu_gather *tlb, struct vm_area_struct *vma,
 
 		if (pud_present(orig_pud)) {
 			page = pud_page(orig_pud);
-			page_remove_rmap(page, true);
+			page_remove_rmap(page, true, HPAGE_PUD_ORDER);
 			VM_BUG_ON_PAGE(page_mapcount(page) < 0, page);
 			VM_BUG_ON_PAGE(!PageHead(page), page);
 		} else
@@ -2134,8 +2134,16 @@ int zap_huge_pud(struct mmu_gather *tlb, struct vm_area_struct *vma,
 }
 
 static void __split_huge_pud_locked(struct vm_area_struct *vma, pud_t *pud,
-		unsigned long haddr)
+		unsigned long haddr, bool freeze)
 {
+	struct mm_struct *mm = vma->vm_mm;
+	struct page *page;
+	pgtable_t pgtable;
+	pud_t _pud, old_pud;
+	bool young, write, dirty, soft_dirty;
+	unsigned long addr;
+	int i;
+
 	VM_BUG_ON(haddr & ~HPAGE_PUD_MASK);
 	VM_BUG_ON_VMA(vma->vm_start > haddr, vma);
 	VM_BUG_ON_VMA(vma->vm_end < haddr + HPAGE_PUD_SIZE, vma);
@@ -2143,23 +2151,141 @@ static void __split_huge_pud_locked(struct vm_area_struct *vma, pud_t *pud,
 
 	count_vm_event(THP_SPLIT_PUD);
 
-	pudp_huge_clear_flush_notify(vma, haddr, pud);
+	if (!vma_is_anonymous(vma)) {
+		_pud = pudp_huge_clear_flush_notify(vma, haddr, pud);
+		/*
+		 * We are going to unmap this huge page. So
+		 * just go ahead and zap it
+		 */
+		if (arch_needs_pgtable_deposit())
+			zap_pud_deposited_table(mm, pud);
+		if (vma_is_dax(vma))
+			return;
+		page = pud_page(_pud);
+		if (!PageReferenced(page) && pud_young(_pud))
+			SetPageReferenced(page);
+		page_remove_rmap(page, true, HPAGE_PUD_ORDER);
+		put_page(page);
+		add_mm_counter(mm, MM_FILEPAGES, -HPAGE_PUD_NR);
+		return;
+	}
+
+	/* See the comment above pmdp_invalidate() in __split_huge_pmd_locked() */
+	old_pud = pudp_invalidate(vma, haddr, pud);
+
+	page = pud_page(old_pud);
+	VM_BUG_ON_PAGE(!page_count(page), page);
+	page_ref_add(page, (1<<(HPAGE_PUD_ORDER-HPAGE_PMD_ORDER)) - 1);
+	if (pud_dirty(old_pud))
+		SetPageDirty(page);
+	write = pud_write(old_pud);
+	young = pud_young(old_pud);
+	dirty = pud_dirty(old_pud);
+	soft_dirty = pud_soft_dirty(old_pud);
+
+	pgtable = pgtable_trans_huge_pud_withdraw(mm, pud);
+	pud_populate_with_pgtable(mm, &_pud, pgtable);
+
+	for (i = 0, addr = haddr; i < HPAGE_PUD_NR;
+		 i += HPAGE_PMD_NR, addr += PMD_SIZE) {
+		pmd_t entry, *pmd;
+		/*
+		 * Note that NUMA hinting access restrictions are not
+		 * transferred to avoid any possibility of altering
+		 * permissions across VMAs.
+		 */
+		if (freeze) {
+			swp_entry_t swp_entry;
+
+			swp_entry = make_migration_entry(page + i, write);
+			entry = swp_entry_to_pmd(swp_entry);
+			if (soft_dirty)
+				entry = pmd_swp_mksoft_dirty(entry);
+		} else {
+			entry = mk_huge_pmd(page + i, READ_ONCE(vma->vm_page_prot));
+			entry = maybe_pmd_mkwrite(entry, vma);
+			if (!write)
+				entry = pmd_wrprotect(entry);
+			if (!young)
+				entry = pmd_mkold(entry);
+			if (soft_dirty)
+				entry = pmd_mksoft_dirty(entry);
+		}
+		pmd = pmd_offset(&_pud, addr);
+		VM_BUG_ON(!pmd_none(*pmd));
+		set_pmd_at(mm, addr, pmd, entry);
+		/* distinguish between pud compound_mapcount and pmd compound_mapcount */
+		if (atomic_inc_and_test(sub_compound_mapcount_ptr(&page[i], 1))) {
+			/* first pmd-mapped pud page */
+			lock_page_memcg(page);
+			__inc_lruvec_page_state(page, NR_ANON_THPS);
+			unlock_page_memcg(page);
+		}
+	}
+
+	/*
+	 * Set PG_double_map before dropping compound_mapcount to avoid
+	 * false-negative page_mapped().
+	 */
+	if (compound_mapcount(page) > 1 && !TestSetPagePUDDoubleMap(page)) {
+		for (i = 0; i < HPAGE_PUD_NR; i += HPAGE_PMD_NR)
+		/* distinguish between pud compound_mapcount and pmd compound_mapcount */
+			atomic_inc(sub_compound_mapcount_ptr(&page[i], 1));
+	}
+
+	lock_page_memcg(page);
+	if (atomic_add_negative(-1, compound_mapcount_ptr(page))) {
+		/* Last compound_mapcount is gone. */
+		__dec_lruvec_page_state(page, NR_ANON_THPS_PUD);
+		if (TestClearPagePUDDoubleMap(page)) {
+			/* No need in mapcount reference anymore */
+			for (i = 0; i < HPAGE_PUD_NR; i += HPAGE_PMD_NR)
+		/* distinguish between pud compound_mapcount and pmd compound_mapcount */
+				atomic_dec(sub_compound_mapcount_ptr(&page[i], 1));
+		}
+	}
+	unlock_page_memcg(page);
+
+	smp_wmb(); /* make pte visible before pmd */
+	pud_populate_with_pgtable(mm, pud, pgtable);
+
+	if (freeze) {
+		for (i = 0; i < HPAGE_PUD_NR; i += HPAGE_PMD_NR) {
+			page_remove_rmap(page + i, true, HPAGE_PMD_ORDER);
+			put_page(page + i);
+		}
+	}
 }
 
 void __split_huge_pud(struct vm_area_struct *vma, pud_t *pud,
-		unsigned long address)
+		unsigned long address, bool freeze, struct page *page)
 {
 	spinlock_t *ptl;
+	struct mm_struct *mm = vma->vm_mm;
+	unsigned long haddr = address & HPAGE_PUD_MASK;
 	struct mmu_notifier_range range;
 
 	mmu_notifier_range_init(&range, MMU_NOTIFY_CLEAR, 0, vma, vma->vm_mm,
 				address & HPAGE_PUD_MASK,
 				(address & HPAGE_PUD_MASK) + HPAGE_PUD_SIZE);
 	mmu_notifier_invalidate_range_start(&range);
-	ptl = pud_lock(vma->vm_mm, pud);
-	if (unlikely(!pud_trans_huge(*pud) && !pud_devmap(*pud)))
+	ptl = pud_lock(mm, pud);
+
+	/*
+	 * If caller asks to setup a migration entries, we need a page to check
+	 * pmd against. Otherwise we can end up replacing wrong page.
+	 */
+	VM_BUG_ON(freeze && !page);
+	if (page && page != pud_page(*pud))
 		goto out;
-	__split_huge_pud_locked(vma, pud, range.start);
+
+	if (pud_trans_huge(*pud)) {
+		page = pud_page(*pud);
+		if (PageMlocked(page))
+			clear_page_mlock(page);
+	} else if (unlikely(!pud_devmap(*pud)))
+		goto out;
+	__split_huge_pud_locked(vma, pud, haddr, freeze);
 
 out:
 	spin_unlock(ptl);
@@ -2169,6 +2295,281 @@ void __split_huge_pud(struct vm_area_struct *vma, pud_t *pud,
 	 */
 	mmu_notifier_invalidate_range_only_end(&range);
 }
+
+void split_huge_pud_address(struct vm_area_struct *vma, unsigned long address,
+		bool freeze, struct page *page)
+{
+	pgd_t *pgd;
+	p4d_t *p4d;
+	pud_t *pud;
+
+	pgd = pgd_offset(vma->vm_mm, address);
+	if (!pgd_present(*pgd))
+		return;
+
+	p4d = p4d_offset(pgd, address);
+	if (!p4d_present(*p4d))
+		return;
+
+	pud = pud_offset(p4d, address);
+
+	__split_huge_pud(vma, pud, address, freeze, page);
+}
+
+static void unmap_pud_page(struct page *page)
+{
+	enum ttu_flags ttu_flags = TTU_IGNORE_MLOCK | TTU_IGNORE_ACCESS |
+		TTU_RMAP_LOCKED | TTU_SPLIT_HUGE_PUD;
+	bool unmap_success;
+
+	VM_BUG_ON_PAGE(!PageHead(page), page);
+
+	if (PageAnon(page))
+		ttu_flags |= TTU_SPLIT_FREEZE;
+
+	unmap_success = try_to_unmap(page, ttu_flags);
+	VM_BUG_ON_PAGE(!unmap_success, page);
+}
+
+static void remap_pud_page(struct page *page)
+{
+	int i;
+
+	VM_BUG_ON(!PageTransHuge(page));
+	if (compound_order(page) == HPAGE_PUD_ORDER) {
+		remove_migration_ptes(page, page, true);
+	} else if (compound_order(page) == HPAGE_PMD_ORDER) {
+		for (i = 0; i < HPAGE_PUD_NR; i += HPAGE_PMD_NR)
+			remove_migration_ptes(page + i, page + i, true);
+	} else
+		VM_BUG_ON_PAGE(1, page);
+}
+
+static void __split_huge_pud_page_tail(struct page *head, int tail,
+		struct lruvec *lruvec, struct list_head *list)
+{
+	struct page *page_tail = head + tail;
+
+	VM_BUG_ON_PAGE(page_ref_count(page_tail) != 0, page_tail);
+
+	/*
+	 * Clone page flags before unfreezing refcount.
+	 *
+	 * After successful get_page_unless_zero() might follow flags change,
+	 * for example lock_page() which set PG_waiters.
+	 */
+
+	page_tail->flags &= ~PAGE_FLAGS_CHECK_AT_PREP;
+	page_tail->flags |= (head->flags &
+			((1L << PG_referenced) |
+			 (1L << PG_swapbacked) |
+			 (1L << PG_swapcache) |
+			 (1L << PG_mlocked) |
+			 (1L << PG_uptodate) |
+			 (1L << PG_active) |
+			 (1L << PG_locked) |
+			 (1L << PG_unevictable) |
+			 (1L << PG_dirty) |
+			 /* preserve THP */
+			 (1L << PG_head)));
+
+	/* ->mapping in first tail page is compound_mapcount */
+	VM_BUG_ON_PAGE(tail > 2 && page_tail->mapping != TAIL_MAPPING,
+			page_tail);
+	page_tail->mapping = head->mapping;
+	page_tail->index = head->index + tail;
+
+	/* Page flags also must be visible before we make the page PMD-compound. */
+	smp_wmb();
+
+	clear_compound_head(page_tail);
+	prep_compound_page(page_tail, HPAGE_PMD_ORDER);
+	prep_transhuge_page(page_tail);
+
+	/* Finally unfreeze refcount. Additional reference from page cache. */
+	page_ref_unfreeze(page_tail, 1 + (!PageAnon(head) ||
+					  PageSwapCache(head)));
+
+	if (page_is_young(head))
+		set_page_young(page_tail);
+	if (page_is_idle(head))
+		set_page_idle(page_tail);
+
+	page_cpupid_xchg_last(page_tail, page_cpupid_last(head));
+	lru_add_pud_page_tail(head, page_tail, lruvec, list);
+}
+
+static void __split_huge_pud_page(struct page *page, struct list_head *list,
+		unsigned long flags)
+{
+	struct page *head = compound_head(page);
+	pg_data_t *pgdat = page_pgdat(head);
+	struct lruvec *lruvec;
+	int i;
+
+	lruvec = mem_cgroup_page_lruvec(head, pgdat);
+
+	/* complete memcg works before add pages to LRU */
+	mem_cgroup_split_huge_pud_fixup(head);
+
+	/* no file-back page support yet */
+	VM_BUG_ON(!PageAnon(page));
+
+	for (i = HPAGE_PUD_NR - HPAGE_PMD_NR; i >= 1; i -= HPAGE_PMD_NR) {
+		__split_huge_pud_page_tail(head, i, lruvec, list);
+	}
+	/* reset head page order  */
+	prep_compound_page(head, HPAGE_PMD_ORDER);
+	prep_transhuge_page(head);
+
+	page_ref_inc(head);
+
+	spin_unlock_irqrestore(&pgdat->lru_lock, flags);
+
+	remap_pud_page(head);
+
+	for (i = 0; i < HPAGE_PUD_NR; i += HPAGE_PMD_NR) {
+		struct page *subpage = head + i;
+
+		if (subpage == page)
+			continue;
+		unlock_page(subpage);
+
+		/*
+		 * Subpages may be freed if there wasn't any mapping
+		 * like if add_to_swap() is running on a lru page that
+		 * had its mapping zapped. And freeing these pages
+		 * requires taking the lru_lock so we do the put_page
+		 * of the tail pages after the split is complete.
+		 */
+		put_page(subpage);
+	}
+}
+/* Racy check whether the huge page can be split */
+bool can_split_huge_pud_page(struct page *page, int *pextra_pins)
+{
+	int extra_pins;
+
+	VM_BUG_ON(!PageAnon(page));
+
+	extra_pins = PageSwapCache(page) ? HPAGE_PUD_NR : 0;
+
+	if (pextra_pins)
+		*pextra_pins = extra_pins;
+	return total_mapcount(page) == page_count(page) - extra_pins - 1;
+}
+
+/*
+ * This function splits huge page into normal pages. @page can point to any
+ * subpage of huge page to split. Split doesn't change the position of @page.
+ *
+ * Only caller must hold pin on the @page, otherwise split fails with -EBUSY.
+ * The huge page must be locked.
+ *
+ * If @list is null, tail pages will be added to LRU list, otherwise, to @list.
+ *
+ * Both head page and tail pages will inherit mapping, flags, and so on from
+ * the hugepage.
+ *
+ * GUP pin and PG_locked transferred to @page. Rest subpages can be freed if
+ * they are not mapped.
+ *
+ * Returns 0 if the hugepage is split successfully.
+ * Returns -EBUSY if the page is pinned or if anon_vma disappeared from under
+ * us.
+ */
+int split_huge_pud_page_to_list(struct page *page, struct list_head *list)
+{
+	struct page *head = compound_head(page);
+	struct pglist_data *pgdata = NODE_DATA(page_to_nid(head));
+	struct deferred_split *ds_queue = get_deferred_split_queue(head);
+	struct anon_vma *anon_vma = NULL;
+	struct address_space *mapping = NULL;
+	int count, mapcount, extra_pins, ret;
+	bool mlocked;
+	unsigned long flags;
+
+	VM_BUG_ON_PAGE(is_huge_zero_page(page), page);
+	VM_BUG_ON_PAGE(!PageLocked(page), page);
+	VM_BUG_ON_PAGE(!PageCompound(page), page);
+	VM_BUG_ON_PAGE(!PageAnon(page), page);
+
+	if (PageWriteback(page))
+		return -EBUSY;
+
+	/*
+	 * The caller does not necessarily hold an mmap_sem that would
+	 * prevent the anon_vma disappearing so we first we take a
+	 * reference to it and then lock the anon_vma for write. This
+	 * is similar to page_lock_anon_vma_read except the write lock
+	 * is taken to serialise against parallel split or collapse
+	 * operations.
+	 */
+	anon_vma = page_get_anon_vma(head);
+	if (!anon_vma) {
+		ret = -EBUSY;
+		goto out;
+	}
+	mapping = NULL;
+	anon_vma_lock_write(anon_vma);
+	/*
+	 * Racy check if we can split the page, before unmap_pud_page() will
+	 * split PUDs
+	 */
+	if (!can_split_huge_pud_page(head, &extra_pins)) {
+		ret = -EBUSY;
+		goto out_unlock;
+	}
+
+	mlocked = PageMlocked(page);
+	unmap_pud_page(head);
+	VM_BUG_ON_PAGE(compound_mapcount(head), head);
+
+	/* Make sure the page is not on per-CPU pagevec as it takes pin */
+	if (mlocked)
+		lru_add_drain();
+
+	/* prevent PageLRU to go away from under us, and freeze lru stats */
+	spin_lock_irqsave(&pgdata->lru_lock, flags);
+
+	/* Prevent deferred_split_scan() touching ->_refcount */
+	spin_lock(&ds_queue->split_queue_lock);
+	count = page_count(head);
+	mapcount = total_mapcount(head);
+	if (!mapcount && page_ref_freeze(head, 1 + extra_pins)) {
+		if (!list_empty(page_deferred_list(head))) {
+			ds_queue->split_queue_len--;
+			list_del(page_deferred_list(head));
+		}
+		if (mapping) {
+			__dec_node_page_state(page, NR_SHMEM_THPS);
+		}
+		spin_unlock(&ds_queue->split_queue_lock);
+		__split_huge_pud_page(page, list, flags);
+		ret = 0;
+	} else {
+		if (IS_ENABLED(CONFIG_DEBUG_VM) && mapcount) {
+			pr_alert("total_mapcount: %u, page_count(): %u\n",
+					mapcount, count);
+			if (PageTail(page))
+				dump_page(head, NULL);
+			dump_page(page, "total_mapcount(head) > 0");
+		}
+		spin_unlock(&ds_queue->split_queue_lock);
+		spin_unlock_irqrestore(&pgdata->lru_lock, flags);
+		remap_pud_page(head);
+		ret = -EBUSY;
+	}
+
+out_unlock:
+	if (anon_vma) {
+		anon_vma_unlock_write(anon_vma);
+		put_anon_vma(anon_vma);
+	}
+out:
+	count_vm_event(!ret ? THP_SPLIT_PUD_PAGE : THP_SPLIT_PUD_PAGE_FAILED);
+	return ret;
+}
 #endif /* CONFIG_HAVE_ARCH_TRANSPARENT_HUGEPAGE_PUD */
 
 static void __split_huge_zero_page_pmd(struct vm_area_struct *vma,
@@ -2209,7 +2610,7 @@ static void __split_huge_pmd_locked(struct vm_area_struct *vma, pmd_t *pmd,
 		unsigned long haddr, bool freeze)
 {
 	struct mm_struct *mm = vma->vm_mm;
-	struct page *page;
+	struct page *page, *head;
 	pgtable_t pgtable;
 	pmd_t old_pmd, _pmd;
 	bool young, write, soft_dirty, pmd_migration = false, uffd_wp = false;
@@ -2239,7 +2640,7 @@ static void __split_huge_pmd_locked(struct vm_area_struct *vma, pmd_t *pmd,
 			set_page_dirty(page);
 		if (!PageReferenced(page) && pmd_young(_pmd))
 			SetPageReferenced(page);
-		page_remove_rmap(page, true);
+		page_remove_rmap(page, true, HPAGE_PMD_ORDER);
 		put_page(page);
 		add_mm_counter(mm, mm_counter_file(page), -HPAGE_PMD_NR);
 		return;
@@ -2298,7 +2699,8 @@ static void __split_huge_pmd_locked(struct vm_area_struct *vma, pmd_t *pmd,
 		uffd_wp = pmd_uffd_wp(old_pmd);
 	}
 	VM_BUG_ON_PAGE(!page_count(page), page);
-	page_ref_add(page, HPAGE_PMD_NR - 1);
+	head = compound_head(page);
+	page_ref_add(head, HPAGE_PMD_NR - 1);
 
 	/*
 	 * Withdraw the table only after we mark the pmd entry invalid.
@@ -2344,14 +2746,24 @@ static void __split_huge_pmd_locked(struct vm_area_struct *vma, pmd_t *pmd,
 	/*
 	 * Set PG_double_map before dropping compound_mapcount to avoid
 	 * false-negative page_mapped().
+	 * Don't set it if the PUD page is mapped at PUD level, since
+	 * page_mapped() is true in that case.
 	 */
-	if (compound_mapcount(page) > 1 && !TestSetPageDoubleMap(page)) {
+	if (((PMDPageInPUD(page) &&
+		sub_compound_mapcount(page) >
+			(1 + PagePUDDoubleMap(compound_head(page)))) ||
+	    (!PMDPageInPUD(page) &&
+		compound_mapcount(page) > 1))
+		&& !TestSetPageDoubleMap(page)) {
 		for (i = 0; i < HPAGE_PMD_NR; i++)
 			atomic_inc(&page[i]._mapcount);
 	}
 
 	lock_page_memcg(page);
-	if (atomic_add_negative(-1, compound_mapcount_ptr(page))) {
+	if ((PMDPageInPUD(page) &&
+		atomic_add_negative(-1, sub_compound_mapcount_ptr(page, 1))) ||
+	    (!PMDPageInPUD(page) &&
+		atomic_add_negative(-1, compound_mapcount_ptr(page)))) {
 		/* Last compound_mapcount is gone. */
 		__dec_lruvec_page_state(page, NR_ANON_THPS);
 		if (TestClearPageDoubleMap(page)) {
@@ -2367,7 +2779,7 @@ static void __split_huge_pmd_locked(struct vm_area_struct *vma, pmd_t *pmd,
 
 	if (freeze) {
 		for (i = 0; i < HPAGE_PMD_NR; i++) {
-			page_remove_rmap(page + i, false);
+			page_remove_rmap(page + i, false, 0);
 			put_page(page + i);
 		}
 	}
@@ -2478,6 +2890,11 @@ void vma_adjust_trans_huge(struct vm_area_struct *vma,
 	 * previously contain an hugepage: check if we need to split
 	 * an huge pmd.
 	 */
+	if (start & ~HPAGE_PUD_MASK &&
+	    (start & HPAGE_PUD_MASK) >= vma->vm_start &&
+	    (start & HPAGE_PUD_MASK) + HPAGE_PUD_SIZE <= vma->vm_end)
+		split_huge_pud_address(vma, start, false, NULL);
+
 	if (start & ~HPAGE_PMD_MASK &&
 	    (start & HPAGE_PMD_MASK) >= vma->vm_start &&
 	    (start & HPAGE_PMD_MASK) + HPAGE_PMD_SIZE <= vma->vm_end)
@@ -2488,6 +2905,11 @@ void vma_adjust_trans_huge(struct vm_area_struct *vma,
 	 * previously contain an hugepage: check if we need to split
 	 * an huge pmd.
 	 */
+	if (end & ~HPAGE_PUD_MASK &&
+	    (end & HPAGE_PUD_MASK) >= vma->vm_start &&
+	    (end & HPAGE_PUD_MASK) + HPAGE_PUD_SIZE <= vma->vm_end)
+		split_huge_pud_address(vma, end, false, NULL);
+
 	if (end & ~HPAGE_PMD_MASK &&
 	    (end & HPAGE_PMD_MASK) >= vma->vm_start &&
 	    (end & HPAGE_PMD_MASK) + HPAGE_PMD_SIZE <= vma->vm_end)
@@ -2502,6 +2924,11 @@ void vma_adjust_trans_huge(struct vm_area_struct *vma,
 		struct vm_area_struct *next = vma->vm_next;
 		unsigned long nstart = next->vm_start;
 		nstart += adjust_next << PAGE_SHIFT;
+		if (nstart & ~HPAGE_PUD_MASK &&
+		    (nstart & HPAGE_PUD_MASK) >= next->vm_start &&
+		    (nstart & HPAGE_PUD_MASK) + HPAGE_PUD_SIZE <= next->vm_end)
+			split_huge_pud_address(next, nstart, false, NULL);
+
 		if (nstart & ~HPAGE_PMD_MASK &&
 		    (nstart & HPAGE_PMD_MASK) >= next->vm_start &&
 		    (nstart & HPAGE_PMD_MASK) + HPAGE_PMD_SIZE <= next->vm_end)
@@ -2691,12 +3118,23 @@ int total_mapcount(struct page *page)
 	if (PageHuge(page))
 		return compound;
 	ret = compound;
-	for (i = 0; i < HPAGE_PMD_NR; i++)
-		ret += atomic_read(&page[i]._mapcount) + 1;
+	/* if PMD, read all base page, if PUD, read the sub_compound_mapcount()*/
+	if (compound_order(page) == HPAGE_PMD_ORDER) {
+		for (i = 0; i < thp_nr_pages(page); i++)
+			ret += atomic_read(&page[i]._mapcount) + 1;
+	} else if (compound_order(page) == HPAGE_PUD_ORDER) {
+		for (i = 0; i < HPAGE_PUD_NR; i += HPAGE_PMD_NR)
+			ret += sub_compound_mapcount(&page[i]);
+		for (i = 0; i < thp_nr_pages(page); i++)
+			ret += atomic_read(&page[i]._mapcount) + 1;
+	} else
+		VM_BUG_ON_PAGE(1, page);
 	/* File pages has compound_mapcount included in _mapcount */
+	/* both PUD and PMD has HPAGE_PMD_NR sub pages */
 	if (!PageAnon(page))
 		return ret - compound * HPAGE_PMD_NR;
-	if (PageDoubleMap(page))
+	/* both PUD and PMD has HPAGE_PMD_NR sub pages */
+	if (PagePUDDoubleMap(page) || PageDoubleMap(page))
 		ret -= HPAGE_PMD_NR;
 	return ret;
 }
@@ -2742,13 +3180,38 @@ int page_trans_huge_mapcount(struct page *page, int *total_mapcount)
 	page = compound_head(page);
 
 	_total_mapcount = ret = 0;
-	for (i = 0; i < HPAGE_PMD_NR; i++) {
-		mapcount = atomic_read(&page[i]._mapcount) + 1;
-		ret = max(ret, mapcount);
-		_total_mapcount += mapcount;
-	}
-	if (PageDoubleMap(page)) {
+	/* if PMD, read all base page, if PUD, read the sub_compound_mapcount()*/
+	if (compound_order(page) == HPAGE_PMD_ORDER) {
+		for (i = 0; i < thp_nr_pages(page); i++) {
+			mapcount = atomic_read(&page[i]._mapcount) + 1;
+			ret = max(ret, mapcount);
+			_total_mapcount += mapcount;
+		}
+	} else if (compound_order(page) == HPAGE_PUD_ORDER) {
+		for (i = 0; i < HPAGE_PUD_NR; i += HPAGE_PMD_NR) {
+			int j;
+
+			mapcount = sub_compound_mapcount(&page[i]);
+			ret = max(ret, mapcount);
+			_total_mapcount += mapcount;
+
+			/* Triple mapped at base page size */
+			for (j = 0; j < HPAGE_PMD_NR; j++) {
+				mapcount = atomic_read(&page[i + j]._mapcount) + 1;
+				ret = max(ret, mapcount);
+				_total_mapcount += mapcount;
+			}
+
+			if (PageDoubleMap(&page[i])) {
+				ret -= 1;
+				_total_mapcount -= HPAGE_PMD_NR;
+			}
+		}
+	} else
+		VM_BUG_ON_PAGE(1, page);
+	if (PageDoubleMap(page) || PagePUDDoubleMap(page)) {
 		ret -= 1;
+		/* both PUD and PMD has HPAGE_PMD_NR sub pages */
 		_total_mapcount -= HPAGE_PMD_NR;
 	}
 	mapcount = compound_mapcount(page);
@@ -2994,6 +3457,9 @@ static unsigned long deferred_split_count(struct shrinker *shrink,
 	return READ_ONCE(ds_queue->split_queue_len);
 }
 
+#define deferred_list_entry(x) (compound_head(list_entry((void *)x, \
+					struct page, mapping)))
+
 static unsigned long deferred_split_scan(struct shrinker *shrink,
 		struct shrink_control *sc)
 {
@@ -3027,12 +3493,18 @@ static unsigned long deferred_split_scan(struct shrinker *shrink,
 	spin_unlock_irqrestore(&ds_queue->split_queue_lock, flags);
 
 	list_for_each_safe(pos, next, &list) {
-		page = list_entry((void *)pos, struct page, mapping);
+		page = deferred_list_entry(pos);
 		if (!trylock_page(page))
 			goto next;
 		/* split_huge_page() removes page from list on success */
-		if (!split_huge_page(page))
-			split++;
+		if (compound_order(page) == HPAGE_PUD_ORDER) {
+			if (!split_huge_pud_page(page))
+				split++;
+		} else if (compound_order(page) == HPAGE_PMD_ORDER) {
+			if (!split_huge_page(page))
+				split++;
+		} else
+			VM_BUG_ON_PAGE(1, page);
 		unlock_page(page);
 next:
 		put_page(page);
@@ -3135,7 +3607,7 @@ void set_pmd_migration_entry(struct page_vma_mapped_walk *pvmw,
 	if (pmd_soft_dirty(pmdval))
 		pmdswp = pmd_swp_mksoft_dirty(pmdswp);
 	set_pmd_at(mm, address, pvmw->pmd, pmdswp);
-	page_remove_rmap(page, true);
+	page_remove_rmap(page, true, HPAGE_PMD_ORDER);
 	put_page(page);
 }
 
@@ -3161,7 +3633,7 @@ void remove_migration_pmd(struct page_vma_mapped_walk *pvmw, struct page *new)
 
 	flush_cache_range(vma, mmun_start, mmun_start + HPAGE_PMD_SIZE);
 	if (PageAnon(new))
-		page_add_anon_rmap(new, vma, mmun_start, true);
+		page_add_anon_rmap(new, vma, mmun_start, true, HPAGE_PMD_ORDER);
 	else
 		page_add_file_rmap(new, true);
 	set_pmd_at(mm, mmun_start, pvmw->pmd, pmde);
diff --git a/mm/hugetlb.c b/mm/hugetlb.c
index 27a51b202d1f..4113d7b66fee 100644
--- a/mm/hugetlb.c
+++ b/mm/hugetlb.c
@@ -3993,7 +3993,7 @@ void __unmap_hugepage_range(struct mmu_gather *tlb, struct vm_area_struct *vma,
 			set_page_dirty(page);
 
 		hugetlb_count_sub(pages_per_huge_page(h), mm);
-		page_remove_rmap(page, true);
+		page_remove_rmap(page, true, huge_page_order(h));
 
 		spin_unlock(ptl);
 		tlb_remove_page_size(tlb, page, huge_page_size(h));
@@ -4218,7 +4218,7 @@ static vm_fault_t hugetlb_cow(struct mm_struct *mm, struct vm_area_struct *vma,
 		mmu_notifier_invalidate_range(mm, range.start, range.end);
 		set_huge_pte_at(mm, haddr, ptep,
 				make_huge_pte(vma, new_page, 1));
-		page_remove_rmap(old_page, true);
+		page_remove_rmap(old_page, true, huge_page_order(h));
 		hugepage_add_new_anon_rmap(new_page, vma, haddr);
 		set_page_huge_active(new_page);
 		/* Make the old page be freed below */
diff --git a/mm/khugepaged.c b/mm/khugepaged.c
index e749e568e1ea..84ce39652282 100644
--- a/mm/khugepaged.c
+++ b/mm/khugepaged.c
@@ -762,7 +762,7 @@ static void __collapse_huge_page_copy(pte_t *pte, struct page *page,
 			 * superfluous.
 			 */
 			pte_clear(vma->vm_mm, address, _pte);
-			page_remove_rmap(src_page, false);
+			page_remove_rmap(src_page, false, 0);
 			spin_unlock(ptl);
 			free_page_and_swap_cache(src_page);
 		}
@@ -1172,7 +1172,7 @@ static void collapse_huge_page(struct mm_struct *mm,
 
 	spin_lock(pmd_ptl);
 	BUG_ON(!pmd_none(*pmd));
-	page_add_new_anon_rmap(new_page, vma, address, true);
+	page_add_new_anon_rmap(new_page, vma, address, true, HPAGE_PMD_ORDER);
 	lru_cache_add_inactive_or_unevictable(new_page, vma);
 	pgtable_trans_huge_deposit(mm, pmd, pgtable);
 	set_pmd_at(mm, address, pmd, _pmd);
@@ -1475,7 +1475,7 @@ void collapse_pte_mapped_thp(struct mm_struct *mm, unsigned long addr)
 		if (pte_none(*pte))
 			continue;
 		page = vm_normal_page(vma, addr, *pte);
-		page_remove_rmap(page, false);
+		page_remove_rmap(page, false, HPAGE_PMD_ORDER);
 	}
 
 	pte_unmap_unlock(start_pte, ptl);
diff --git a/mm/ksm.c b/mm/ksm.c
index 0aa2247bddd7..d778b4d1b626 100644
--- a/mm/ksm.c
+++ b/mm/ksm.c
@@ -1153,7 +1153,7 @@ static int replace_page(struct vm_area_struct *vma, struct page *page,
 	 */
 	if (!is_zero_pfn(page_to_pfn(kpage))) {
 		get_page(kpage);
-		page_add_anon_rmap(kpage, vma, addr, false);
+		page_add_anon_rmap(kpage, vma, addr, false, 0);
 		newpte = mk_pte(kpage, vma->vm_page_prot);
 	} else {
 		newpte = pte_mkspecial(pfn_pte(page_to_pfn(kpage),
@@ -1177,7 +1177,7 @@ static int replace_page(struct vm_area_struct *vma, struct page *page,
 	ptep_clear_flush(vma, addr, ptep);
 	set_pte_at_notify(mm, addr, ptep, newpte);
 
-	page_remove_rmap(page, false);
+	page_remove_rmap(page, false, 0);
 	if (!page_mapped(page))
 		try_to_free_swap(page);
 	put_page(page);
diff --git a/mm/memcontrol.c b/mm/memcontrol.c
index dc892a3c4b17..5d5be3b7c739 100644
--- a/mm/memcontrol.c
+++ b/mm/memcontrol.c
@@ -3232,6 +3232,19 @@ void mem_cgroup_split_huge_fixup(struct page *head)
 		head[i].mem_cgroup = memcg;
 	}
 }
+
+void mem_cgroup_split_huge_pud_fixup(struct page *head)
+{
+	int i;
+
+	if (mem_cgroup_disabled())
+		return;
+
+	for (i = HPAGE_PMD_NR; i < HPAGE_PUD_NR; i += HPAGE_PMD_NR)
+		head[i].mem_cgroup = head->mem_cgroup;
+
+	/*__mod_memcg_state(head->mem_cgroup, MEMCG_RSS_HUGE, -HPAGE_PUD_NR);*/
+}
 #endif /* CONFIG_TRANSPARENT_HUGEPAGE */
 
 #ifdef CONFIG_MEMCG_SWAP
diff --git a/mm/memory.c b/mm/memory.c
index b88587256bc1..184d8eb2d060 100644
--- a/mm/memory.c
+++ b/mm/memory.c
@@ -1090,7 +1090,7 @@ static unsigned long zap_pte_range(struct mmu_gather *tlb,
 					mark_page_accessed(page);
 			}
 			rss[mm_counter(page)]--;
-			page_remove_rmap(page, false);
+			page_remove_rmap(page, false, 0);
 			if (unlikely(page_mapcount(page) < 0))
 				print_bad_pte(vma, addr, ptent, page);
 			if (unlikely(__tlb_remove_page(tlb, page))) {
@@ -1118,7 +1118,7 @@ static unsigned long zap_pte_range(struct mmu_gather *tlb,
 
 			pte_clear_not_present_full(mm, addr, pte, tlb->fullmm);
 			rss[mm_counter(page)]--;
-			page_remove_rmap(page, false);
+			page_remove_rmap(page, false, 0);
 			put_page(page);
 			continue;
 		}
@@ -2725,7 +2725,7 @@ static vm_fault_t wp_page_copy(struct vm_fault *vmf)
 		 * thread doing COW.
 		 */
 		ptep_clear_flush_notify(vma, vmf->address, vmf->pte);
-		page_add_new_anon_rmap(new_page, vma, vmf->address, false);
+		page_add_new_anon_rmap(new_page, vma, vmf->address, false, 0);
 		lru_cache_add_inactive_or_unevictable(new_page, vma);
 		/*
 		 * We call the notify macro here because, when using secondary
@@ -2757,7 +2757,7 @@ static vm_fault_t wp_page_copy(struct vm_fault *vmf)
 			 * mapcount is visible. So transitively, TLBs to
 			 * old page will be flushed before it can be reused.
 			 */
-			page_remove_rmap(old_page, false);
+			page_remove_rmap(old_page, false, 0);
 		}
 
 		/* Free the old page.. */
@@ -3273,10 +3273,10 @@ vm_fault_t do_swap_page(struct vm_fault *vmf)
 
 	/* ksm created a completely new copy */
 	if (unlikely(page != swapcache && swapcache)) {
-		page_add_new_anon_rmap(page, vma, vmf->address, false);
+		page_add_new_anon_rmap(page, vma, vmf->address, false, 0);
 		lru_cache_add_inactive_or_unevictable(page, vma);
 	} else {
-		do_page_add_anon_rmap(page, vma, vmf->address, exclusive);
+		do_page_add_anon_rmap(page, vma, vmf->address, exclusive, 0);
 	}
 
 	swap_free(entry);
@@ -3420,7 +3420,7 @@ static vm_fault_t do_anonymous_page(struct vm_fault *vmf)
 	}
 
 	inc_mm_counter_fast(vma->vm_mm, MM_ANONPAGES);
-	page_add_new_anon_rmap(page, vma, vmf->address, false);
+	page_add_new_anon_rmap(page, vma, vmf->address, false, 0);
 	lru_cache_add_inactive_or_unevictable(page, vma);
 setpte:
 	set_pte_at(vma->vm_mm, vmf->address, vmf->pte, entry);
@@ -3678,7 +3678,7 @@ vm_fault_t alloc_set_pte(struct vm_fault *vmf, struct page *page)
 	/* copy-on-write page */
 	if (write && !(vma->vm_flags & VM_SHARED)) {
 		inc_mm_counter_fast(vma->vm_mm, MM_ANONPAGES);
-		page_add_new_anon_rmap(page, vma, vmf->address, false);
+		page_add_new_anon_rmap(page, vma, vmf->address, false, 0);
 		lru_cache_add_inactive_or_unevictable(page, vma);
 	} else {
 		inc_mm_counter_fast(vma->vm_mm, mm_counter_file(page));
@@ -4155,7 +4155,7 @@ static vm_fault_t create_huge_pud(struct vm_fault *vmf)
 			return ret;
 	}
 	/* COW or write-notify not handled on PUD level: split pud.*/
-	__split_huge_pud(vmf->vma, vmf->pud, vmf->address);
+	split_huge_pud(vmf->vma, vmf->pud, vmf->address);
 #endif /* CONFIG_TRANSPARENT_HUGEPAGE */
 	return VM_FAULT_FALLBACK;
 }
diff --git a/mm/migrate.c b/mm/migrate.c
index 0b945c8031be..be0e80b32686 100644
--- a/mm/migrate.c
+++ b/mm/migrate.c
@@ -270,7 +270,7 @@ static bool remove_migration_pte(struct page *page, struct vm_area_struct *vma,
 			set_pte_at(vma->vm_mm, pvmw.address, pvmw.pte, pte);
 
 			if (PageAnon(new))
-				page_add_anon_rmap(new, vma, pvmw.address, false);
+				page_add_anon_rmap(new, vma, pvmw.address, false, 0);
 			else
 				page_add_file_rmap(new, false);
 		}
@@ -2194,7 +2194,7 @@ int migrate_misplaced_transhuge_page(struct mm_struct *mm,
 	 * new page and page_add_new_anon_rmap guarantee the copy is
 	 * visible before the pagetable update.
 	 */
-	page_add_anon_rmap(new_page, vma, start, true);
+	page_add_anon_rmap(new_page, vma, start, true, HPAGE_PMD_ORDER);
 	/*
 	 * At this point the pmd is numa/protnone (i.e. non present) and the TLB
 	 * has already been flushed globally.  So no TLB can be currently
@@ -2211,7 +2211,7 @@ int migrate_misplaced_transhuge_page(struct mm_struct *mm,
 
 	page_ref_unfreeze(page, 2);
 	mlock_migrate_page(new_page, page);
-	page_remove_rmap(page, true);
+	page_remove_rmap(page, true, HPAGE_PMD_ORDER);
 	set_page_owner_migrate_reason(new_page, MR_NUMA_MISPLACED);
 
 	spin_unlock(ptl);
@@ -2455,7 +2455,7 @@ static int migrate_vma_collect_pmd(pmd_t *pmdp,
 			 * drop page refcount. Page won't be freed, as we took
 			 * a reference just above.
 			 */
-			page_remove_rmap(page, false);
+			page_remove_rmap(page, false, 0);
 			put_page(page);
 
 			if (pte_present(pte))
@@ -2940,7 +2940,7 @@ static void migrate_vma_insert_page(struct migrate_vma *migrate,
 		goto unlock_abort;
 
 	inc_mm_counter(mm, MM_ANONPAGES);
-	page_add_new_anon_rmap(page, vma, addr, false);
+	page_add_new_anon_rmap(page, vma, addr, false, 0);
 	if (!is_zone_device_page(page))
 		lru_cache_add_inactive_or_unevictable(page, vma);
 	get_page(page);
diff --git a/mm/page_alloc.c b/mm/page_alloc.c
index 763acbed66f1..97a4c7e4a579 100644
--- a/mm/page_alloc.c
+++ b/mm/page_alloc.c
@@ -679,6 +679,9 @@ void prep_compound_page(struct page *page, unsigned int order)
 	atomic_set(compound_mapcount_ptr(page), -1);
 	if (hpage_pincount_available(page))
 		atomic_set(compound_pincount_ptr(page), 0);
+	if (order == HPAGE_PUD_ORDER)
+		for (i = 0; i < HPAGE_PUD_NR; i += HPAGE_PMD_NR)
+			atomic_set(sub_compound_mapcount_ptr(&page[i], 1), -1);
 }
 
 #ifdef CONFIG_DEBUG_PAGEALLOC
@@ -1132,6 +1135,15 @@ static int free_tail_pages_check(struct page *head_page, struct page *page)
 		 */
 		break;
 	default:
+		/* sub_compound_map_ptr store here */
+		if (compound_order(head_page) == HPAGE_PUD_ORDER &&
+			(page - head_page) % HPAGE_PMD_NR == 3) {
+			if (unlikely(atomic_read(&page->compound_mapcount) != -1)) {
+				pr_err("sub_compound_mapcount: %d\n", atomic_read(&page->compound_mapcount) + 1);
+				bad_page(page, "nonzero sub_compound_mapcount");
+			}
+			break;
+		}
 		if (page->mapping != TAIL_MAPPING) {
 			bad_page(page, "corrupted mapping in tail page");
 			goto out;
@@ -1183,8 +1195,14 @@ static __always_inline bool free_pages_prepare(struct page *page,
 
 		VM_BUG_ON_PAGE(compound && compound_order(page) != order, page);
 
-		if (compound)
+		if (compound) {
 			ClearPageDoubleMap(page);
+			if (order == HPAGE_PUD_ORDER) {
+				ClearPagePUDDoubleMap(page);
+				for (i = 0; i < HPAGE_PUD_NR; i += HPAGE_PMD_NR)
+					ClearPageDoubleMap(&page[i]);
+			}
+		}
 		for (i = 1; i < (1 << order); i++) {
 			if (compound)
 				bad += free_tail_pages_check(page, page + i);
diff --git a/mm/pgtable-generic.c b/mm/pgtable-generic.c
index ef218b0f5d74..a8529afc55e5 100644
--- a/mm/pgtable-generic.c
+++ b/mm/pgtable-generic.c
@@ -245,6 +245,17 @@ pmd_t pmdp_invalidate(struct vm_area_struct *vma, unsigned long address,
 }
 #endif
 
+#ifndef __HAVE_ARCH_PUDP_INVALIDATE
+pud_t pudp_invalidate(struct vm_area_struct *vma, unsigned long address,
+		     pud_t *pudp)
+{
+	pud_t old = pudp_establish(vma, address, pudp, pud_mknotpresent(*pudp));
+
+	flush_pud_tlb_range(vma, address, address + HPAGE_PUD_SIZE);
+	return old;
+}
+#endif
+
 #ifndef pmdp_collapse_flush
 pmd_t pmdp_collapse_flush(struct vm_area_struct *vma, unsigned long address,
 			  pmd_t *pmdp)
diff --git a/mm/rmap.c b/mm/rmap.c
index 77cec0658b76..0bbaaa891b3c 100644
--- a/mm/rmap.c
+++ b/mm/rmap.c
@@ -1108,9 +1108,9 @@ static void __page_check_anon_rmap(struct page *page,
  * (but PageKsm is never downgraded to PageAnon).
  */
 void page_add_anon_rmap(struct page *page,
-	struct vm_area_struct *vma, unsigned long address, bool compound)
+	struct vm_area_struct *vma, unsigned long address, bool compound, int order)
 {
-	do_page_add_anon_rmap(page, vma, address, compound ? RMAP_COMPOUND : 0);
+	do_page_add_anon_rmap(page, vma, address, compound ? RMAP_COMPOUND : 0, order);
 }
 
 /*
@@ -1119,7 +1119,7 @@ void page_add_anon_rmap(struct page *page,
  * Everybody else should continue to use page_add_anon_rmap above.
  */
 void do_page_add_anon_rmap(struct page *page,
-	struct vm_area_struct *vma, unsigned long address, int flags)
+	struct vm_area_struct *vma, unsigned long address, int flags, int order)
 {
 	bool compound = flags & RMAP_COMPOUND;
 	bool first;
@@ -1130,10 +1130,21 @@ void do_page_add_anon_rmap(struct page *page,
 		VM_BUG_ON_PAGE(!PageLocked(page), page);
 
 	if (compound) {
-		atomic_t *mapcount;
+		atomic_t *mapcount = NULL;
 		VM_BUG_ON_PAGE(!PageLocked(page), page);
 		VM_BUG_ON_PAGE(!PageTransHuge(page), page);
-		mapcount = compound_mapcount_ptr(page);
+		if (compound_order(page) == HPAGE_PUD_ORDER) {
+			if (order == HPAGE_PUD_ORDER) {
+				mapcount = compound_mapcount_ptr(page);
+			} else if (order == HPAGE_PMD_ORDER) {
+				VM_BUG_ON(!PMDPageInPUD(page));
+				mapcount = sub_compound_mapcount_ptr(page, 1);
+			} else
+				VM_BUG_ON(1);
+		} else if (compound_order(page) == HPAGE_PMD_ORDER) {
+			mapcount = compound_mapcount_ptr(page);
+		} else
+			VM_BUG_ON(1);
 		first = atomic_inc_and_test(mapcount);
 	} else {
 		first = atomic_inc_and_test(&page->_mapcount);
@@ -1148,7 +1159,7 @@ void do_page_add_anon_rmap(struct page *page,
 		 * disabled.
 		 */
 		if (compound) {
-			if (nr == HPAGE_PMD_NR)
+			if (order == HPAGE_PMD_ORDER)
 				__inc_lruvec_page_state(page, NR_ANON_THPS);
 			else
 				__inc_lruvec_page_state(page, NR_ANON_THPS_PUD);
@@ -1181,7 +1192,7 @@ void do_page_add_anon_rmap(struct page *page,
  * Page does not have to be locked.
  */
 void page_add_new_anon_rmap(struct page *page,
-	struct vm_area_struct *vma, unsigned long address, bool compound)
+	struct vm_area_struct *vma, unsigned long address, bool compound, int order)
 {
 	int nr = compound ? thp_nr_pages(page) : 1;
 
@@ -1194,10 +1205,15 @@ void page_add_new_anon_rmap(struct page *page,
 		if (hpage_pincount_available(page))
 			atomic_set(compound_pincount_ptr(page), 0);
 
-		if (nr == HPAGE_PMD_NR)
-			__inc_lruvec_page_state(page, NR_ANON_THPS);
-		else
+		if (order == HPAGE_PUD_ORDER) {
+			VM_BUG_ON(compound_order(page) != HPAGE_PUD_ORDER);
+			/* Anon THP always mapped first with PMD */
 			__inc_lruvec_page_state(page, NR_ANON_THPS_PUD);
+		} else if (order == HPAGE_PMD_ORDER) {
+			VM_BUG_ON(compound_order(page) != HPAGE_PMD_ORDER);
+			__inc_lruvec_page_state(page, NR_ANON_THPS);
+		} else
+			VM_BUG_ON(1);
 	} else {
 		/* Anon THP always mapped first with PMD */
 		VM_BUG_ON_PAGE(PageTransCompound(page), page);
@@ -1289,12 +1305,40 @@ static void page_remove_file_rmap(struct page *page, bool compound)
 		clear_page_mlock(page);
 }
 
-static void page_remove_anon_compound_rmap(struct page *page)
+static void page_remove_anon_compound_rmap(struct page *page, int order)
 {
-	int i, nr;
-
-	if (!atomic_add_negative(-1, compound_mapcount_ptr(page)))
-		return;
+	int i, nr = 0;
+	struct page *head = compound_head(page);
+
+	if (compound_order(head) == HPAGE_PUD_ORDER) {
+		if (order == HPAGE_PMD_ORDER) {
+			VM_BUG_ON(!PMDPageInPUD(page));
+			if (atomic_add_negative(-1, sub_compound_mapcount_ptr(page, 1))) {
+				if (TestClearPageDoubleMap(page)) {
+					/*
+					 * Subpages can be mapped with PTEs too. Check how many of
+					 * themi are still mapped.
+					 */
+					for (i = 0; i < thp_nr_pages(head); i++) {
+						if (atomic_add_negative(-1, &head[i]._mapcount))
+							nr++;
+					}
+				}
+				__dec_node_page_state(page, NR_ANON_THPS);
+			}
+			nr += HPAGE_PMD_NR;
+			__mod_node_page_state(page_pgdat(head), NR_ANON_MAPPED, -nr);
+			return;
+		} else {
+			VM_BUG_ON(order != HPAGE_PUD_ORDER);
+			if (!atomic_add_negative(-1, compound_mapcount_ptr(page)))
+				return;
+		}
+	} else if (compound_order(head) == HPAGE_PMD_ORDER) {
+		if (!atomic_add_negative(-1, compound_mapcount_ptr(page)))
+			return;
+	} else
+		VM_BUG_ON_PAGE(1, page);
 
 	/* Hugepages are not counted in NR_ANON_PAGES for now. */
 	if (unlikely(PageHuge(page)))
@@ -1303,12 +1347,26 @@ static void page_remove_anon_compound_rmap(struct page *page)
 	if (!IS_ENABLED(CONFIG_TRANSPARENT_HUGEPAGE))
 		return;
 
-	if (thp_nr_pages(page) == HPAGE_PMD_NR)
+	if (order == HPAGE_PMD_ORDER)
 		__dec_lruvec_page_state(page, NR_ANON_THPS);
-	else
+	else if (order == HPAGE_PUD_ORDER)
 		__dec_lruvec_page_state(page, NR_ANON_THPS_PUD);
+	else
+		VM_BUG_ON(1);
 
-	if (TestClearPageDoubleMap(page)) {
+	/* PMD-mapped PUD THP is handled above */
+	if (TestClearPagePUDDoubleMap(head)) {
+		VM_BUG_ON(!(compound_order(head) == HPAGE_PUD_ORDER || head == page));
+		/*
+		 * Subpages can be mapped with PMDs too. Check how many of
+		 * themi are still mapped.
+		 */
+		for (i = 0, nr = 0; i < HPAGE_PUD_NR; i += HPAGE_PMD_NR) {
+			if (atomic_add_negative(-1, sub_compound_mapcount_ptr(&head[i], 1)))
+				nr += HPAGE_PMD_NR;
+		}
+	} else if (TestClearPageDoubleMap(head)) {
+		VM_BUG_ON(compound_order(head) != HPAGE_PMD_ORDER);
 		/*
 		 * Subpages can be mapped with PTEs too. Check how many of
 		 * them are still mapped.
@@ -1332,8 +1390,10 @@ static void page_remove_anon_compound_rmap(struct page *page)
 	if (unlikely(PageMlocked(page)))
 		clear_page_mlock(page);
 
-	if (nr)
-		__mod_lruvec_page_state(page, NR_ANON_MAPPED, -nr);
+	if (nr) {
+		__mod_lruvec_page_state(head, NR_ANON_MAPPED, -nr);
+		deferred_split_huge_page(head);
+	}
 }
 
 /**
@@ -1343,7 +1403,7 @@ static void page_remove_anon_compound_rmap(struct page *page)
  *
  * The caller needs to hold the pte lock.
  */
-void page_remove_rmap(struct page *page, bool compound)
+void page_remove_rmap(struct page *page, bool compound, int order)
 {
 	lock_page_memcg(page);
 
@@ -1353,7 +1413,7 @@ void page_remove_rmap(struct page *page, bool compound)
 	}
 
 	if (compound) {
-		page_remove_anon_compound_rmap(page);
+		page_remove_anon_compound_rmap(page, order);
 		goto out;
 	}
 
@@ -1734,7 +1794,7 @@ static bool try_to_unmap_one(struct page *page, struct vm_area_struct *vma,
 		 *
 		 * See Documentation/vm/mmu_notifier.rst
 		 */
-		page_remove_rmap(subpage, PageHuge(page));
+		page_remove_rmap(subpage, PageHuge(page), 0);
 		put_page(page);
 	}
 
diff --git a/mm/swap.c b/mm/swap.c
index 999a84dbe12c..b70631c71171 100644
--- a/mm/swap.c
+++ b/mm/swap.c
@@ -964,6 +964,37 @@ void lru_add_page_tail(struct page *page, struct page *page_tail,
 					  page_lru(page_tail));
 	}
 }
+
+/* used by __split_pud_huge_page_tail() */
+void lru_add_pud_page_tail(struct page *page, struct page *page_tail,
+		       struct lruvec *lruvec, struct list_head *list)
+{
+	VM_BUG_ON_PAGE(!PageHead(page), page);
+	VM_BUG_ON_PAGE(PageLRU(page_tail), page);
+	VM_BUG_ON(NR_CPUS != 1 &&
+		  !spin_is_locked(&lruvec_pgdat(lruvec)->lru_lock));
+
+	if (!list)
+		SetPageLRU(page_tail);
+
+	if (likely(PageLRU(page)))
+		list_add_tail(&page_tail->lru, &page->lru);
+	else if (list) {
+		/* page reclaim is reclaiming a huge page */
+		get_page(page_tail);
+		list_add_tail(&page_tail->lru, list);
+	} else {
+		/*
+		 * Head page has not yet been counted, as an hpage,
+		 * so we must account for each subpage individually.
+		 *
+		 * Put page_tail on the list at the correct position
+		 * so they all end up in order.
+		 */
+		add_page_to_lru_list_tail(page_tail, lruvec,
+					  page_lru(page_tail));
+	}
+}
 #endif /* CONFIG_TRANSPARENT_HUGEPAGE */
 
 static void __pagevec_lru_add_fn(struct page *page, struct lruvec *lruvec,
diff --git a/mm/swapfile.c b/mm/swapfile.c
index e3f771c2ad83..285edbcb5e22 100644
--- a/mm/swapfile.c
+++ b/mm/swapfile.c
@@ -1921,9 +1921,9 @@ static int unuse_pte(struct vm_area_struct *vma, pmd_t *pmd,
 	set_pte_at(vma->vm_mm, addr, pte,
 		   pte_mkold(mk_pte(page, vma->vm_page_prot)));
 	if (page == swapcache) {
-		page_add_anon_rmap(page, vma, addr, false);
+		page_add_anon_rmap(page, vma, addr, false, 0);
 	} else { /* ksm created a completely new copy */
-		page_add_new_anon_rmap(page, vma, addr, false);
+		page_add_new_anon_rmap(page, vma, addr, false, 0);
 		lru_cache_add_inactive_or_unevictable(page, vma);
 	}
 	swap_free(entry);
diff --git a/mm/userfaultfd.c b/mm/userfaultfd.c
index 9a3d451402d7..9b31d9beaa46 100644
--- a/mm/userfaultfd.c
+++ b/mm/userfaultfd.c
@@ -122,7 +122,7 @@ static int mcopy_atomic_pte(struct mm_struct *dst_mm,
 		goto out_release_uncharge_unlock;
 
 	inc_mm_counter(dst_mm, MM_ANONPAGES);
-	page_add_new_anon_rmap(page, dst_vma, dst_addr, false);
+	page_add_new_anon_rmap(page, dst_vma, dst_addr, false, 0);
 	lru_cache_add_inactive_or_unevictable(page, dst_vma);
 
 	set_pte_at(dst_mm, dst_addr, dst_pte, _dst_pte);
diff --git a/mm/util.c b/mm/util.c
index bb902f5a6582..410f1ca0932a 100644
--- a/mm/util.c
+++ b/mm/util.c
@@ -713,17 +713,27 @@ struct address_space *page_mapping_file(struct page *page)
 int __page_mapcount(struct page *page)
 {
 	int ret;
+	struct page *head = compound_head(page);
 
+	/* base page mapping */
 	ret = atomic_read(&page->_mapcount) + 1;
+
+	/* PMDInPUD mapping */
+	if (compound_order(head) == HPAGE_PUD_ORDER) {
+		struct page *sub_compound_page = head +
+			(((page - head) / HPAGE_PMD_NR) * HPAGE_PMD_NR);
+
+		ret += sub_compound_mapcount(sub_compound_page);
+	}
 	/*
 	 * For file THP page->_mapcount contains total number of mapping
 	 * of the page: no need to look into compound_mapcount.
 	 */
 	if (!PageAnon(page) && !PageHuge(page))
 		return ret;
-	page = compound_head(page);
-	ret += atomic_read(compound_mapcount_ptr(page)) + 1;
-	if (PageDoubleMap(page))
+	/* highest compound mapping */
+	ret += atomic_read(compound_mapcount_ptr(head)) + 1;
+	if (PageDoubleMap(head))
 		ret--;
 	return ret;
 }
diff --git a/mm/vmstat.c b/mm/vmstat.c
index 3a01212b652c..dc7c2cec9102 100644
--- a/mm/vmstat.c
+++ b/mm/vmstat.c
@@ -1330,6 +1330,10 @@ const char * const vmstat_text[] = {
 	"thp_fault_fallback_pud",
 	"thp_fault_fallback_pud_charge",
 	"thp_split_pud",
+	"thp_split_pud_page",
+	"thp_split_pud_page_failed",
+	"thp_zero_pud_page_alloc",
+	"thp_zero_pud_page_alloc_failed",
 #endif
 	"thp_zero_page_alloc",
 	"thp_zero_page_alloc_failed",
-- 
2.28.0

