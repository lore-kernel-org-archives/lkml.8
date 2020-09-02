Return-Path: <SRS0=728o=CL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.0 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,UNWANTED_LANGUAGE_BODY,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DA5C1C43461
	for <linux-kernel@archiver.kernel.org>; Wed,  2 Sep 2020 18:07:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A47B420FC3
	for <linux-kernel@archiver.kernel.org>; Wed,  2 Sep 2020 18:07:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=sent.com header.i=@sent.com header.b="UFUXOnjJ";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="goFpC3BM"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728004AbgIBSHN (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 2 Sep 2020 14:07:13 -0400
Received: from out1-smtp.messagingengine.com ([66.111.4.25]:51799 "EHLO
        out1-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727915AbgIBSGg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Sep 2020 14:06:36 -0400
Received: from compute4.internal (compute4.nyi.internal [10.202.2.44])
        by mailout.nyi.internal (Postfix) with ESMTP id 71C865C01BC;
        Wed,  2 Sep 2020 14:06:32 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute4.internal (MEProxy); Wed, 02 Sep 2020 14:06:32 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sent.com; h=from
        :to:cc:subject:date:message-id:in-reply-to:references:reply-to
        :mime-version:content-transfer-encoding; s=fm1; bh=Gc4UsLeb5bYFT
        ZYziOCiFFrVo565mG6ZB6RNAooF1qY=; b=UFUXOnjJZ92OP+ZxhHUP8neKAGPXP
        pzdl8faWniqhbMm4pBqg2Rm4gf9/5yo9hxhGzSaRsOcxjf1Z/0m+f1NQuIAz40h8
        FUVe9tAc8hBCLfvjX0XtBgataJElrA/r9+027KUm7rLdGPUxLqrT/dkFXB2L71uP
        A0sfenNgn2n6NkCk9tIvV1pjWmW1i1CilSEJ9wEyJH7yVpJ9tn15gXyr8tsLG/nU
        ztgxiJ3ex/VTLAkNONKIx3AEvgaxN2PSr9ccnoIsOmPG/WmbTvboBstQY2bFhdnW
        mvZgPDave4BZkljO6WaI0QQdzeO0iZ7LWmNnLnVKqnHV4JH+gKIQ9GfzQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-transfer-encoding:date:from
        :in-reply-to:message-id:mime-version:references:reply-to:subject
        :to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
        fm3; bh=Gc4UsLeb5bYFTZYziOCiFFrVo565mG6ZB6RNAooF1qY=; b=goFpC3BM
        MTKZbBpKBmz5M+RA9qSSRvGqv41UWVrqSqlZJA42PehDSDaKf70Zz/Z/H5e8TKnZ
        azc2YYo6bdEhEflqMsa1chVkZgo3RmLH9AOWFggaSen4z0H2bxL9AhxPad61AzG7
        TH3LQBYh5zZjdVlVvoX36VVxeVm8ZFS6VwUwTERJjydTD20VIiFs9oXPhbLj3ZZY
        +bYfC4OtlTcXKj+/EYjU7jeOcDMNevTKm28iaSx8/ImkjxnGat2MCmRt2bownW6i
        Gx+AeYKPTnJ6POg9t0muyrhPLyMt8lmlldrTJHCU9wQE2zyKQ5RBQIl/Mty6EPKa
        I1yCL1EiFTq/OA==
X-ME-Sender: <xms:J99PX0fymQdIITd6OELsOJrdq0M5nkyCSjTGpqpYS4Qpqw6jGI1bPw>
    <xme:J99PX2MOor8ULlXEDpXXs3JEltqW3ku4mTgw4_f7j9Nfwn4fAgQEqGCDaMUb2B7LL
    auqYOXXflnUvcqNHg>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeduiedrudefledguddvudcutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfgh
    necuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmd
    enucfjughrpefhvffufffkofgjfhhrggfgsedtkeertdertddtnecuhfhrohhmpegkihcu
    jggrnhcuoeiiihdrhigrnhesshgvnhhtrdgtohhmqeenucggtffrrghtthgvrhhnpeduhf
    ffveektdduhfdutdfgtdekkedvhfetuedufedtgffgvdevleehheevjefgtdenucfkphep
    uddvrdegiedruddtiedrudeigeenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmh
    epmhgrihhlfhhrohhmpeiiihdrhigrnhesshgvnhhtrdgtohhm
X-ME-Proxy: <xmx:J99PX1hqkUWLknOPyzXx1P_7lmfGro17WJJWuDMXPJMJI03T6-dkeg>
    <xmx:J99PX5_DeOKyTlhWci8BNg_cbgOQ1ZVY-aB34aJ-vL1kOkSsEFVi7g>
    <xmx:J99PXwvpA2KJCnltMzEuAkoFHGNlEHTybd0_PYr4z5d27Ul3asV6Ig>
    <xmx:KN9PX1_3h4P5aqS4pTwDWW30iEanmtkjk0Obf0awOZ0h-lMEKfgJoA>
Received: from nvrsysarch6.NVidia.COM (unknown [12.46.106.164])
        by mail.messagingengine.com (Postfix) with ESMTPA id 2FA4530600DC;
        Wed,  2 Sep 2020 14:06:31 -0400 (EDT)
From:   Zi Yan <zi.yan@sent.com>
To:     linux-mm@kvack.org, Roman Gushchin <guro@fb.com>
Cc:     Rik van Riel <riel@surriel.com>,
        "Kirill A . Shutemov" <kirill.shutemov@linux.intel.com>,
        Matthew Wilcox <willy@infradead.org>,
        Shakeel Butt <shakeelb@google.com>,
        Yang Shi <yang.shi@linux.alibaba.com>,
        David Nellans <dnellans@nvidia.com>,
        linux-kernel@vger.kernel.org, Zi Yan <ziy@nvidia.com>
Subject: [RFC PATCH 02/16] mm: thp: 1GB anonymous page implementation.
Date:   Wed,  2 Sep 2020 14:06:14 -0400
Message-Id: <20200902180628.4052244-3-zi.yan@sent.com>
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

This adds 1GB THP support for anonymous pages. Applications can get 1GB
pages during page faults when their VMAs are larger than 1GB. For
read-only 1GB zero THP, a shared 1GB zero THP is created for all
readers.

Signed-off-by: Zi Yan <ziy@nvidia.com>
---
 arch/x86/include/asm/pgalloc.h |  59 +++++++++++
 arch/x86/include/asm/pgtable.h |   2 +
 arch/x86/mm/pgtable.c          |  25 +++++
 drivers/base/node.c            |   3 +
 fs/proc/meminfo.c              |   2 +
 include/linux/huge_mm.h        |  13 ++-
 include/linux/mm.h             |   4 +
 include/linux/mm_types.h       |   1 +
 include/linux/mmzone.h         |   1 +
 include/linux/pgtable.h        |   3 +
 include/linux/vm_event_item.h  |   3 +
 kernel/fork.c                  |   5 +
 mm/huge_memory.c               | 188 +++++++++++++++++++++++++++++++--
 mm/memory.c                    |  29 ++++-
 mm/page_alloc.c                |   3 +-
 mm/pgtable-generic.c           |  45 ++++++++
 mm/rmap.c                      |  30 ++++--
 mm/vmstat.c                    |   4 +
 18 files changed, 396 insertions(+), 24 deletions(-)

diff --git a/arch/x86/include/asm/pgalloc.h b/arch/x86/include/asm/pgalloc.h
index 62ad61d6fefc..fae13467d3e1 100644
--- a/arch/x86/include/asm/pgalloc.h
+++ b/arch/x86/include/asm/pgalloc.h
@@ -52,6 +52,18 @@ extern pgd_t *pgd_alloc(struct mm_struct *);
 extern void pgd_free(struct mm_struct *mm, pgd_t *pgd);
 
 extern pgtable_t pte_alloc_one(struct mm_struct *);
+extern pgtable_t pte_alloc_order(struct mm_struct *, unsigned long, int);
+
+static inline void pte_free_order(struct mm_struct *mm, struct page *pte,
+		int order)
+{
+	int i;
+
+	for (i = 0; i < (1<<order); i++) {
+		pgtable_pte_page_dtor(&pte[i]);
+		__free_page(&pte[i]);
+	}
+}
 
 extern void ___pte_free_tlb(struct mmu_gather *tlb, struct page *pte);
 
@@ -87,6 +99,53 @@ static inline void pmd_populate(struct mm_struct *mm, pmd_t *pmd,
 #define pmd_pgtable(pmd) pmd_page(pmd)
 
 #if CONFIG_PGTABLE_LEVELS > 2
+static inline pmd_t *pmd_alloc_one_page_with_ptes(struct mm_struct *mm, unsigned long addr)
+{
+	pgtable_t pte_pgtables;
+	pmd_t *pmd;
+	spinlock_t *pmd_ptl;
+	int i;
+
+	pte_pgtables = pte_alloc_order(mm, addr,
+		HPAGE_PUD_ORDER - HPAGE_PMD_ORDER);
+	if (!pte_pgtables)
+		return NULL;
+
+	pmd = pmd_alloc_one(mm, addr);
+	if (unlikely(!pmd)) {
+		pte_free_order(mm, pte_pgtables,
+			HPAGE_PUD_ORDER - HPAGE_PMD_ORDER);
+		return NULL;
+	}
+	pmd_ptl = pmd_lock(mm, pmd);
+
+	for (i = 0; i < (1<<(HPAGE_PUD_ORDER - HPAGE_PMD_ORDER)); i++)
+		pgtable_trans_huge_deposit(mm, pmd, pte_pgtables + i);
+
+	spin_unlock(pmd_ptl);
+
+	return pmd;
+}
+
+static inline void pmd_free_page_with_ptes(struct mm_struct *mm, pmd_t *pmd)
+{
+	spinlock_t *pmd_ptl;
+	int i;
+
+	BUG_ON((unsigned long)pmd & (PAGE_SIZE-1));
+	pmd_ptl = pmd_lock(mm, pmd);
+
+	for (i = 0; i < (1<<(HPAGE_PUD_ORDER - HPAGE_PMD_ORDER)); i++) {
+		pgtable_t pte_pgtable;
+
+		pte_pgtable = pgtable_trans_huge_withdraw(mm, pmd);
+		pte_free(mm, pte_pgtable);
+	}
+
+	spin_unlock(pmd_ptl);
+	pmd_free(mm, pmd);
+}
+
 extern void ___pmd_free_tlb(struct mmu_gather *tlb, pmd_t *pmd);
 
 static inline void __pmd_free_tlb(struct mmu_gather *tlb, pmd_t *pmd,
diff --git a/arch/x86/include/asm/pgtable.h b/arch/x86/include/asm/pgtable.h
index 5e0dcc20614d..26255cac78c0 100644
--- a/arch/x86/include/asm/pgtable.h
+++ b/arch/x86/include/asm/pgtable.h
@@ -1141,6 +1141,8 @@ static inline pmd_t pmdp_huge_get_and_clear(struct mm_struct *mm, unsigned long
 	return native_pmdp_get_and_clear(pmdp);
 }
 
+#define mk_pud(page, pgprot)   pfn_pud(page_to_pfn(page), (pgprot))
+
 #define __HAVE_ARCH_PUDP_HUGE_GET_AND_CLEAR
 static inline pud_t pudp_huge_get_and_clear(struct mm_struct *mm,
 					unsigned long addr, pud_t *pudp)
diff --git a/arch/x86/mm/pgtable.c b/arch/x86/mm/pgtable.c
index dfd82f51ba66..7be73aee6183 100644
--- a/arch/x86/mm/pgtable.c
+++ b/arch/x86/mm/pgtable.c
@@ -33,6 +33,31 @@ pgtable_t pte_alloc_one(struct mm_struct *mm)
 	return __pte_alloc_one(mm, __userpte_alloc_gfp);
 }
 
+pgtable_t pte_alloc_order(struct mm_struct *mm, unsigned long address, int order)
+{
+	struct page *pte;
+	int i;
+
+	pte = alloc_pages(__userpte_alloc_gfp, order);
+	if (!pte)
+		return NULL;
+	split_page(pte, order);
+	for (i = 1; i < (1 << order); i++)
+		set_page_private(pte + i, 0);
+
+	for (i = 0; i < (1<<order); i++) {
+		if (!pgtable_pte_page_ctor(&pte[i])) {
+			__free_page(&pte[i]);
+			while (--i >= 0) {
+				pgtable_pte_page_dtor(&pte[i]);
+				__free_page(&pte[i]);
+			}
+			return NULL;
+		}
+	}
+	return pte;
+}
+
 static int __init setup_userpte(char *arg)
 {
 	if (!arg)
diff --git a/drivers/base/node.c b/drivers/base/node.c
index 508b80f6329b..f11b4d88911c 100644
--- a/drivers/base/node.c
+++ b/drivers/base/node.c
@@ -428,6 +428,7 @@ static ssize_t node_read_meminfo(struct device *dev,
 		       "Node %d SUnreclaim:     %8lu kB\n"
 #ifdef CONFIG_TRANSPARENT_HUGEPAGE
 		       "Node %d AnonHugePages:  %8lu kB\n"
+		       "Node %d AnonHugePUDPages: %8lu kB\n"
 		       "Node %d ShmemHugePages: %8lu kB\n"
 		       "Node %d ShmemPmdMapped: %8lu kB\n"
 		       "Node %d FileHugePages: %8lu kB\n"
@@ -457,6 +458,8 @@ static ssize_t node_read_meminfo(struct device *dev,
 		       ,
 		       nid, K(node_page_state(pgdat, NR_ANON_THPS) *
 				       HPAGE_PMD_NR),
+			   nid, K(node_page_state(pgdat, NR_ANON_THPS_PUD) *
+				       HPAGE_PUD_NR),
 		       nid, K(node_page_state(pgdat, NR_SHMEM_THPS) *
 				       HPAGE_PMD_NR),
 		       nid, K(node_page_state(pgdat, NR_SHMEM_PMDMAPPED) *
diff --git a/fs/proc/meminfo.c b/fs/proc/meminfo.c
index 887a5532e449..b60e0c241015 100644
--- a/fs/proc/meminfo.c
+++ b/fs/proc/meminfo.c
@@ -130,6 +130,8 @@ static int meminfo_proc_show(struct seq_file *m, void *v)
 #ifdef CONFIG_TRANSPARENT_HUGEPAGE
 	show_val_kb(m, "AnonHugePages:  ",
 		    global_node_page_state(NR_ANON_THPS) * HPAGE_PMD_NR);
+	show_val_kb(m, "AnonHugePUDPages:  ",
+			global_node_page_state(NR_ANON_THPS_PUD) * HPAGE_PUD_NR);
 	show_val_kb(m, "ShmemHugePages: ",
 		    global_node_page_state(NR_SHMEM_THPS) * HPAGE_PMD_NR);
 	show_val_kb(m, "ShmemPmdMapped: ",
diff --git a/include/linux/huge_mm.h b/include/linux/huge_mm.h
index 8a8bc46a2432..7528652400e4 100644
--- a/include/linux/huge_mm.h
+++ b/include/linux/huge_mm.h
@@ -18,10 +18,15 @@ extern int copy_huge_pud(struct mm_struct *dst_mm, struct mm_struct *src_mm,
 
 #ifdef CONFIG_HAVE_ARCH_TRANSPARENT_HUGEPAGE_PUD
 extern void huge_pud_set_accessed(struct vm_fault *vmf, pud_t orig_pud);
+extern int do_huge_pud_anonymous_page(struct vm_fault *vmf);
 #else
 static inline void huge_pud_set_accessed(struct vm_fault *vmf, pud_t orig_pud)
 {
 }
+extern int do_huge_pud_anonymous_page(struct vm_fault *vmf)
+{
+	return VM_FAULT_FALLBACK;
+}
 #endif
 
 extern vm_fault_t do_huge_pmd_wp_page(struct vm_fault *vmf, pmd_t orig_pmd);
@@ -115,6 +120,9 @@ extern struct kobj_attribute shmem_enabled_attr;
 #define HPAGE_PMD_ORDER (HPAGE_PMD_SHIFT-PAGE_SHIFT)
 #define HPAGE_PMD_NR (1<<HPAGE_PMD_ORDER)
 
+#define HPAGE_PUD_ORDER (HPAGE_PUD_SHIFT-PAGE_SHIFT)
+#define HPAGE_PUD_NR (1<<HPAGE_PUD_ORDER)
+
 #ifdef CONFIG_TRANSPARENT_HUGEPAGE
 #define HPAGE_PMD_SHIFT PMD_SHIFT
 #define HPAGE_PMD_SIZE	((1UL) << HPAGE_PMD_SHIFT)
@@ -276,7 +284,7 @@ static inline unsigned int thp_order(struct page *page)
 {
 	VM_BUG_ON_PGFLAGS(PageTail(page), page);
 	if (PageHead(page))
-		return HPAGE_PMD_ORDER;
+		return page[1].compound_order;
 	return 0;
 }
 
@@ -288,7 +296,7 @@ static inline int thp_nr_pages(struct page *page)
 {
 	VM_BUG_ON_PGFLAGS(PageTail(page), page);
 	if (PageHead(page))
-		return HPAGE_PMD_NR;
+		return (1<<page[1].compound_order);
 	return 1;
 }
 
@@ -320,6 +328,7 @@ struct page *mm_get_huge_zero_page(struct mm_struct *mm);
 void mm_put_huge_zero_page(struct mm_struct *mm);
 
 #define mk_huge_pmd(page, prot) pmd_mkhuge(mk_pmd(page, prot))
+#define mk_huge_pud(page, prot) pud_mkhuge(mk_pud(page, prot))
 
 static inline bool thp_migration_supported(void)
 {
diff --git a/include/linux/mm.h b/include/linux/mm.h
index f3a4f099fb1b..cb1ccf804404 100644
--- a/include/linux/mm.h
+++ b/include/linux/mm.h
@@ -31,6 +31,7 @@
 #include <linux/sizes.h>
 #include <linux/sched.h>
 #include <linux/pgtable.h>
+#include <linux/pagechain.h>
 
 struct mempolicy;
 struct anon_vma;
@@ -2184,6 +2185,7 @@ static inline void pgtable_init(void)
 {
 	ptlock_cache_init();
 	pgtable_cache_init();
+	pagechain_cache_init();
 }
 
 static inline bool pgtable_pte_page_ctor(struct page *page)
@@ -2316,6 +2318,8 @@ static inline spinlock_t *pud_lock(struct mm_struct *mm, pud_t *pud)
 	return ptl;
 }
 
+#define pud_huge_pte(mm, pud) ((mm)->pud_huge_pte)
+
 extern void __init pagecache_init(void);
 extern void __init free_area_init_memoryless_node(int nid);
 extern void free_initmem(void);
diff --git a/include/linux/mm_types.h b/include/linux/mm_types.h
index 496c3ff97cce..4c1839366af4 100644
--- a/include/linux/mm_types.h
+++ b/include/linux/mm_types.h
@@ -513,6 +513,7 @@ struct mm_struct {
 #if defined(CONFIG_TRANSPARENT_HUGEPAGE) && !USE_SPLIT_PMD_PTLOCKS
 		pgtable_t pmd_huge_pte; /* protected by page_table_lock */
 #endif
+		struct list_head pud_huge_pte; /* protected by page_table_lock */
 #ifdef CONFIG_NUMA_BALANCING
 		/*
 		 * numa_next_scan is the next time that the PTEs will be marked
diff --git a/include/linux/mmzone.h b/include/linux/mmzone.h
index 0a404552ecc1..3a8f54a2c5a7 100644
--- a/include/linux/mmzone.h
+++ b/include/linux/mmzone.h
@@ -196,6 +196,7 @@ enum node_stat_item {
 	NR_FILE_THPS,
 	NR_FILE_PMDMAPPED,
 	NR_ANON_THPS,
+	NR_ANON_THPS_PUD,
 	NR_VMSCAN_WRITE,
 	NR_VMSCAN_IMMEDIATE,	/* Prioritise for reclaim when writeback ends */
 	NR_DIRTIED,		/* page dirtyings since bootup */
diff --git a/include/linux/pgtable.h b/include/linux/pgtable.h
index e8cbc2e795d5..255275d5b73e 100644
--- a/include/linux/pgtable.h
+++ b/include/linux/pgtable.h
@@ -462,10 +462,13 @@ static inline pmd_t pmdp_collapse_flush(struct vm_area_struct *vma,
 #ifndef __HAVE_ARCH_PGTABLE_DEPOSIT
 extern void pgtable_trans_huge_deposit(struct mm_struct *mm, pmd_t *pmdp,
 				       pgtable_t pgtable);
+extern void pgtable_trans_huge_pud_deposit(struct mm_struct *mm, pud_t *pudp,
+				       pgtable_t pgtable);
 #endif
 
 #ifndef __HAVE_ARCH_PGTABLE_WITHDRAW
 extern pgtable_t pgtable_trans_huge_withdraw(struct mm_struct *mm, pmd_t *pmdp);
+extern pgtable_t pgtable_trans_huge_pud_withdraw(struct mm_struct *mm, pud_t *pudp);
 #endif
 
 #ifdef CONFIG_TRANSPARENT_HUGEPAGE
diff --git a/include/linux/vm_event_item.h b/include/linux/vm_event_item.h
index 2e6ca53b9bbd..a3f1093a55bb 100644
--- a/include/linux/vm_event_item.h
+++ b/include/linux/vm_event_item.h
@@ -92,6 +92,9 @@ enum vm_event_item { PGPGIN, PGPGOUT, PSWPIN, PSWPOUT,
 		THP_DEFERRED_SPLIT_PAGE,
 		THP_SPLIT_PMD,
 #ifdef CONFIG_HAVE_ARCH_TRANSPARENT_HUGEPAGE_PUD
+		THP_FAULT_ALLOC_PUD,
+		THP_FAULT_FALLBACK_PUD,
+		THP_FAULT_FALLBACK_PUD_CHARGE,
 		THP_SPLIT_PUD,
 #endif
 		THP_ZERO_PAGE_ALLOC,
diff --git a/kernel/fork.c b/kernel/fork.c
index 3f281814a3d3..842fdc4ae5fc 100644
--- a/kernel/fork.c
+++ b/kernel/fork.c
@@ -663,6 +663,10 @@ static void check_mm(struct mm_struct *mm)
 #if defined(CONFIG_TRANSPARENT_HUGEPAGE) && !USE_SPLIT_PMD_PTLOCKS
 	VM_BUG_ON_MM(mm->pmd_huge_pte, mm);
 #endif
+	VM_BUG_ON_MM(!list_empty(&mm->pud_huge_pte) &&
+				 !pagechain_empty(list_first_entry(&mm->pud_huge_pte,
+					struct pagechain, list)),
+				mm);
 }
 
 #define allocate_mm()	(kmem_cache_alloc(mm_cachep, GFP_KERNEL))
@@ -1023,6 +1027,7 @@ static struct mm_struct *mm_init(struct mm_struct *mm, struct task_struct *p,
 #if defined(CONFIG_TRANSPARENT_HUGEPAGE) && !USE_SPLIT_PMD_PTLOCKS
 	mm->pmd_huge_pte = NULL;
 #endif
+	INIT_LIST_HEAD(&mm->pud_huge_pte);
 	mm_init_uprobes_state(mm);
 
 	if (current->mm) {
diff --git a/mm/huge_memory.c b/mm/huge_memory.c
index 90733cefa528..ec3847392208 100644
--- a/mm/huge_memory.c
+++ b/mm/huge_memory.c
@@ -933,6 +933,112 @@ vm_fault_t vmf_insert_pfn_pud_prot(struct vm_fault *vmf, pfn_t pfn,
 	return VM_FAULT_NOPAGE;
 }
 EXPORT_SYMBOL_GPL(vmf_insert_pfn_pud_prot);
+
+static int __do_huge_pud_anonymous_page(struct vm_fault *vmf, struct page *page,
+		gfp_t gfp)
+{
+	struct vm_area_struct *vma = vmf->vma;
+	pmd_t *pmd_pgtable;
+	unsigned long haddr = vmf->address & HPAGE_PUD_MASK;
+	int ret = 0;
+
+	VM_BUG_ON_PAGE(!PageCompound(page), page);
+
+	if (mem_cgroup_charge(page, vma->vm_mm, gfp)) {
+		put_page(page);
+		count_vm_event(THP_FAULT_FALLBACK_PUD);
+		count_vm_event(THP_FAULT_FALLBACK_CHARGE);
+		return VM_FAULT_FALLBACK;
+	}
+	cgroup_throttle_swaprate(page, gfp);
+
+	pmd_pgtable = pmd_alloc_one_page_with_ptes(vma->vm_mm, haddr);
+	if (unlikely(!pmd_pgtable)) {
+		ret = VM_FAULT_OOM;
+		goto release;
+	}
+
+	clear_huge_page(page, vmf->address, HPAGE_PUD_NR);
+	/*
+	 * The memory barrier inside __SetPageUptodate makes sure that
+	 * clear_huge_page writes become visible before the set_pmd_at()
+	 * write.
+	 */
+	__SetPageUptodate(page);
+
+	vmf->ptl = pud_lock(vma->vm_mm, vmf->pud);
+	if (unlikely(!pud_none(*vmf->pud))) {
+		goto unlock_release;
+	} else {
+		pud_t entry;
+		int i;
+
+		ret = check_stable_address_space(vma->vm_mm);
+		if (ret)
+			goto unlock_release;
+
+		/* Deliver the page fault to userland */
+		if (userfaultfd_missing(vma)) {
+			vm_fault_t ret2;
+
+			spin_unlock(vmf->ptl);
+			put_page(page);
+			pmd_free_page_with_ptes(vma->vm_mm, pmd_pgtable);
+			ret2 = handle_userfault(vmf, VM_UFFD_MISSING);
+			VM_BUG_ON(ret2 & VM_FAULT_FALLBACK);
+			return ret2;
+		}
+
+		entry = mk_huge_pud(page, vma->vm_page_prot);
+		entry = maybe_pud_mkwrite(pud_mkdirty(entry), vma);
+		page_add_new_anon_rmap(page, vma, haddr, true);
+		lru_cache_add_inactive_or_unevictable(page, vma);
+		pgtable_trans_huge_pud_deposit(vma->vm_mm, vmf->pud,
+				virt_to_page(pmd_pgtable));
+		set_pud_at(vma->vm_mm, haddr, vmf->pud, entry);
+		add_mm_counter(vma->vm_mm, MM_ANONPAGES, HPAGE_PUD_NR);
+		mm_inc_nr_pmds(vma->vm_mm);
+		for (i = 0; i < (1<<(HPAGE_PUD_ORDER - HPAGE_PMD_ORDER)); i++)
+			mm_inc_nr_ptes(vma->vm_mm);
+		spin_unlock(vmf->ptl);
+		count_vm_event(THP_FAULT_ALLOC_PUD);
+	}
+
+	return 0;
+unlock_release:
+	spin_unlock(vmf->ptl);
+release:
+	if (pmd_pgtable)
+		pmd_free_page_with_ptes(vma->vm_mm, pmd_pgtable);
+	put_page(page);
+	return ret;
+
+}
+
+int do_huge_pud_anonymous_page(struct vm_fault *vmf)
+{
+	struct vm_area_struct *vma = vmf->vma;
+	gfp_t gfp;
+	struct page *page;
+	unsigned long haddr = vmf->address & HPAGE_PUD_MASK;
+
+	if (haddr < vma->vm_start || haddr + HPAGE_PUD_SIZE > vma->vm_end)
+		return VM_FAULT_FALLBACK;
+	if (unlikely(anon_vma_prepare(vma)))
+		return VM_FAULT_OOM;
+	if (unlikely(khugepaged_enter(vma, vma->vm_flags)))
+		return VM_FAULT_OOM;
+
+	gfp = alloc_hugepage_direct_gfpmask(vma);
+	page = alloc_hugepage_vma(gfp, vma, haddr, HPAGE_PUD_ORDER);
+	if (unlikely(!page)) {
+		count_vm_event(THP_FAULT_FALLBACK_PUD);
+		return VM_FAULT_FALLBACK;
+	}
+	prep_transhuge_page(page);
+	return __do_huge_pud_anonymous_page(vmf, page, gfp);
+}
+
 #endif /* CONFIG_HAVE_ARCH_TRANSPARENT_HUGEPAGE_PUD */
 
 static void touch_pmd(struct vm_area_struct *vma, unsigned long addr,
@@ -1159,7 +1265,12 @@ int copy_huge_pud(struct mm_struct *dst_mm, struct mm_struct *src_mm,
 {
 	spinlock_t *dst_ptl, *src_ptl;
 	pud_t pud;
-	int ret;
+	pmd_t *pmd_pgtable = NULL;
+	int ret = -ENOMEM;
+
+	pmd_pgtable = pmd_alloc_one_page_with_ptes(vma->vm_mm, addr);
+	if (unlikely(!pmd_pgtable))
+		goto out;
 
 	dst_ptl = pud_lock(dst_mm, dst_pud);
 	src_ptl = pud_lockptr(src_mm, src_pud);
@@ -1167,16 +1278,28 @@ int copy_huge_pud(struct mm_struct *dst_mm, struct mm_struct *src_mm,
 
 	ret = -EAGAIN;
 	pud = *src_pud;
+
+	/* only transparent huge pud page needs extra page table pages for
+	 * possible huge page split */
+	if (!pud_trans_huge(pud))
+		pmd_free_page_with_ptes(dst_mm, pmd_pgtable);
+
 	if (unlikely(!pud_trans_huge(pud) && !pud_devmap(pud)))
 		goto out_unlock;
 
-	/*
-	 * When page table lock is held, the huge zero pud should not be
-	 * under splitting since we don't split the page itself, only pud to
-	 * a page table.
-	 */
-	if (is_huge_zero_pud(pud)) {
-		/* No huge zero pud yet */
+	if (pud_trans_huge(pud)) {
+		struct page *src_page;
+		int i;
+
+		src_page = pud_page(pud);
+		VM_BUG_ON_PAGE(!PageHead(src_page), src_page);
+		get_page(src_page);
+		page_dup_rmap(src_page, true);
+		add_mm_counter(dst_mm, MM_ANONPAGES, HPAGE_PUD_NR);
+		mm_inc_nr_pmds(dst_mm);
+		for (i = 0; i < (1<<(HPAGE_PUD_ORDER - HPAGE_PMD_ORDER)); i++)
+			mm_inc_nr_ptes(dst_mm);
+		pgtable_trans_huge_pud_deposit(dst_mm, dst_pud, virt_to_page(pmd_pgtable));
 	}
 
 	pudp_set_wrprotect(src_mm, addr, src_pud);
@@ -1187,6 +1310,7 @@ int copy_huge_pud(struct mm_struct *dst_mm, struct mm_struct *src_mm,
 out_unlock:
 	spin_unlock(src_ptl);
 	spin_unlock(dst_ptl);
+out:
 	return ret;
 }
 
@@ -1887,11 +2011,27 @@ spinlock_t *__pud_trans_huge_lock(pud_t *pud, struct vm_area_struct *vma)
 }
 
 #ifdef CONFIG_HAVE_ARCH_TRANSPARENT_HUGEPAGE_PUD
+static inline void zap_pud_deposited_table(struct mm_struct *mm, pud_t *pud)
+{
+	pgtable_t pgtable;
+	int i;
+
+	pgtable = pgtable_trans_huge_pud_withdraw(mm, pud);
+	pmd_free_page_with_ptes(mm, (pmd_t *)page_address(pgtable));
+
+	mm_dec_nr_pmds(mm);
+	for (i = 0; i < (1<<(HPAGE_PUD_ORDER - HPAGE_PMD_ORDER)); i++)
+		mm_dec_nr_ptes(mm);
+}
+
 int zap_huge_pud(struct mmu_gather *tlb, struct vm_area_struct *vma,
 		 pud_t *pud, unsigned long addr)
 {
+	pud_t orig_pud;
 	spinlock_t *ptl;
 
+	tlb_change_page_size(tlb, HPAGE_PUD_SIZE);
+
 	ptl = __pud_trans_huge_lock(pud, vma);
 	if (!ptl)
 		return 0;
@@ -1901,14 +2041,40 @@ int zap_huge_pud(struct mmu_gather *tlb, struct vm_area_struct *vma,
 	 * pgtable_trans_huge_withdraw after finishing pudp related
 	 * operations.
 	 */
-	pudp_huge_get_and_clear_full(tlb->mm, addr, pud, tlb->fullmm);
+	orig_pud = pudp_huge_get_and_clear_full(tlb->mm, addr, pud,
+			tlb->fullmm);
 	tlb_remove_pud_tlb_entry(tlb, pud, addr);
 	if (vma_is_special_huge(vma)) {
 		spin_unlock(ptl);
 		/* No zero page support yet */
+	} else if (is_huge_zero_pud(orig_pud)) {
+		zap_pud_deposited_table(tlb->mm, pud);
+		spin_unlock(ptl);
+		tlb_remove_page_size(tlb, pud_page(orig_pud), HPAGE_PUD_SIZE);
 	} else {
-		/* No support for anonymous PUD pages yet */
-		BUG();
+		struct page *page = NULL;
+		int flush_needed = 1;
+
+		if (pud_present(orig_pud)) {
+			page = pud_page(orig_pud);
+			page_remove_rmap(page, true);
+			VM_BUG_ON_PAGE(page_mapcount(page) < 0, page);
+			VM_BUG_ON_PAGE(!PageHead(page), page);
+		} else
+			WARN_ONCE(1, "Non present huge pmd without pmd migration enabled!");
+
+		if (PageAnon(page)) {
+			zap_pud_deposited_table(tlb->mm, pud);
+			add_mm_counter(tlb->mm, MM_ANONPAGES, -HPAGE_PUD_NR);
+		} else {
+			if (arch_needs_pgtable_deposit())
+				zap_pud_deposited_table(tlb->mm, pud);
+			add_mm_counter(tlb->mm, MM_FILEPAGES, -HPAGE_PUD_NR);
+		}
+
+		spin_unlock(ptl);
+		if (flush_needed)
+			tlb_remove_page_size(tlb, page, HPAGE_PUD_SIZE);
 	}
 	return 1;
 }
diff --git a/mm/memory.c b/mm/memory.c
index fb5463153351..6f86294438fd 100644
--- a/mm/memory.c
+++ b/mm/memory.c
@@ -4147,14 +4147,13 @@ static vm_fault_t create_huge_pud(struct vm_fault *vmf)
 	defined(CONFIG_HAVE_ARCH_TRANSPARENT_HUGEPAGE_PUD)
 	/* No support for anonymous transparent PUD pages yet */
 	if (vma_is_anonymous(vmf->vma))
-		goto split;
+		return do_huge_pud_anonymous_page(vmf);
 	if (vmf->vma->vm_ops->huge_fault) {
 		vm_fault_t ret = vmf->vma->vm_ops->huge_fault(vmf, PE_SIZE_PUD);
 
 		if (!(ret & VM_FAULT_FALLBACK))
 			return ret;
 	}
-split:
 	/* COW or write-notify not handled on PUD level: split pud.*/
 	__split_huge_pud(vmf->vma, vmf->pud, vmf->address);
 #endif /* CONFIG_TRANSPARENT_HUGEPAGE */
@@ -5098,3 +5097,29 @@ void ptlock_free(struct page *page)
 	kmem_cache_free(page_ptl_cachep, page->ptl);
 }
 #endif
+
+static struct kmem_cache *pagechain_cachep;
+
+void __init pagechain_cache_init(void)
+{
+	pagechain_cachep = kmem_cache_create("pagechain",
+		sizeof(struct pagechain), 0, SLAB_PANIC, NULL);
+}
+
+struct pagechain *pagechain_alloc(void)
+{
+	struct pagechain *chain;
+
+	chain = kmem_cache_alloc(pagechain_cachep, GFP_ATOMIC);
+
+	if (!chain)
+		return NULL;
+
+	pagechain_init(chain);
+	return chain;
+}
+
+void pagechain_free(struct pagechain *pchain)
+{
+	kmem_cache_free(pagechain_cachep, pchain);
+}
diff --git a/mm/page_alloc.c b/mm/page_alloc.c
index 0d9f9bd0e06c..763acbed66f1 100644
--- a/mm/page_alloc.c
+++ b/mm/page_alloc.c
@@ -5443,7 +5443,8 @@ void show_free_areas(unsigned int filter, nodemask_t *nodemask)
 			K(node_page_state(pgdat, NR_SHMEM_THPS) * HPAGE_PMD_NR),
 			K(node_page_state(pgdat, NR_SHMEM_PMDMAPPED)
 					* HPAGE_PMD_NR),
-			K(node_page_state(pgdat, NR_ANON_THPS) * HPAGE_PMD_NR),
+			K(node_page_state(pgdat, NR_ANON_THPS) * HPAGE_PMD_NR +
+			  node_page_state(pgdat, NR_ANON_THPS_PUD) * HPAGE_PUD_NR),
 #endif
 			K(node_page_state(pgdat, NR_WRITEBACK_TEMP)),
 			node_page_state(pgdat, NR_KERNEL_STACK_KB),
diff --git a/mm/pgtable-generic.c b/mm/pgtable-generic.c
index 9578db83e312..ef218b0f5d74 100644
--- a/mm/pgtable-generic.c
+++ b/mm/pgtable-generic.c
@@ -10,6 +10,7 @@
 #include <linux/pagemap.h>
 #include <linux/hugetlb.h>
 #include <linux/pgtable.h>
+#include <linux/pagechain.h>
 #include <asm/tlb.h>
 
 /*
@@ -170,6 +171,23 @@ void pgtable_trans_huge_deposit(struct mm_struct *mm, pmd_t *pmdp,
 		list_add(&pgtable->lru, &pmd_huge_pte(mm, pmdp)->lru);
 	pmd_huge_pte(mm, pmdp) = pgtable;
 }
+
+void pgtable_trans_huge_pud_deposit(struct mm_struct *mm, pud_t *pudp,
+				pgtable_t pgtable)
+{
+	struct pagechain *chain = NULL;
+
+	assert_spin_locked(pud_lockptr(mm, pudp));
+	/* FIFO */
+	chain = list_first_entry_or_null(&pud_huge_pte(mm, pudp),
+			struct pagechain, list);
+
+	if (!chain || !pagechain_space(chain)) {
+		chain = pagechain_alloc();
+		list_add(&chain->list, &pud_huge_pte(mm, pudp));
+	}
+	pagechain_deposit(chain, pgtable);
+}
 #endif
 
 #ifndef __HAVE_ARCH_PGTABLE_WITHDRAW
@@ -188,6 +206,33 @@ pgtable_t pgtable_trans_huge_withdraw(struct mm_struct *mm, pmd_t *pmdp)
 		list_del(&pgtable->lru);
 	return pgtable;
 }
+
+pgtable_t pgtable_trans_huge_pud_withdraw(struct mm_struct *mm, pud_t *pudp)
+{
+	pgtable_t pgtable;
+	struct pagechain *chain = NULL;
+
+	assert_spin_locked(pud_lockptr(mm, pudp));
+
+	/* FIFO */
+retry:
+	chain = list_first_entry_or_null(&pud_huge_pte(mm, pudp),
+			struct pagechain, list);
+
+	if (!chain)
+		return NULL;
+
+	if (pagechain_empty(chain)) {
+		if (list_is_singular(&chain->list))
+			return NULL;
+		list_del(&chain->list);
+		pagechain_free(chain);
+		goto retry;
+	}
+
+	pgtable = pagechain_withdraw(chain);
+	return pgtable;
+}
 #endif
 
 #ifndef __HAVE_ARCH_PMDP_INVALIDATE
diff --git a/mm/rmap.c b/mm/rmap.c
index 9425260774a1..10195a2421cf 100644
--- a/mm/rmap.c
+++ b/mm/rmap.c
@@ -726,6 +726,7 @@ pmd_t *mm_find_pmd(struct mm_struct *mm, unsigned long address)
 	pgd_t *pgd;
 	p4d_t *p4d;
 	pud_t *pud;
+	pud_t pude;
 	pmd_t *pmd = NULL;
 	pmd_t pmde;
 
@@ -738,7 +739,10 @@ pmd_t *mm_find_pmd(struct mm_struct *mm, unsigned long address)
 		goto out;
 
 	pud = pud_offset(p4d, address);
-	if (!pud_present(*pud))
+
+	pude = *pud;
+	barrier();
+	if (!pud_present(pude) || pud_trans_huge(pude))
 		goto out;
 
 	pmd = pmd_offset(pud, address);
@@ -1033,7 +1037,7 @@ void page_move_anon_rmap(struct page *page, struct vm_area_struct *vma)
  * __page_set_anon_rmap - set up new anonymous rmap
  * @page:	Page or Hugepage to add to rmap
  * @vma:	VM area to add page to.
- * @address:	User virtual address of the mapping	
+ * @address:	User virtual address of the mapping
  * @exclusive:	the page is exclusively owned by the current process
  */
 static void __page_set_anon_rmap(struct page *page,
@@ -1137,8 +1141,12 @@ void do_page_add_anon_rmap(struct page *page,
 		 * pte lock(a spinlock) is held, which implies preemption
 		 * disabled.
 		 */
-		if (compound)
-			__inc_lruvec_page_state(page, NR_ANON_THPS);
+		if (compound) {
+			if (nr == HPAGE_PMD_NR)
+				__inc_lruvec_page_state(page, NR_ANON_THPS);
+			else
+				__inc_lruvec_page_state(page, NR_ANON_THPS_PUD);
+		}
 		__mod_lruvec_page_state(page, NR_ANON_MAPPED, nr);
 	}
 
@@ -1180,7 +1188,10 @@ void page_add_new_anon_rmap(struct page *page,
 		if (hpage_pincount_available(page))
 			atomic_set(compound_pincount_ptr(page), 0);
 
-		__inc_lruvec_page_state(page, NR_ANON_THPS);
+		if (nr == HPAGE_PMD_NR)
+			__inc_lruvec_page_state(page, NR_ANON_THPS);
+		else
+			__inc_lruvec_page_state(page, NR_ANON_THPS_PUD);
 	} else {
 		/* Anon THP always mapped first with PMD */
 		VM_BUG_ON_PAGE(PageTransCompound(page), page);
@@ -1286,14 +1297,17 @@ static void page_remove_anon_compound_rmap(struct page *page)
 	if (!IS_ENABLED(CONFIG_TRANSPARENT_HUGEPAGE))
 		return;
 
-	__dec_lruvec_page_state(page, NR_ANON_THPS);
+	if (thp_nr_pages(page) == HPAGE_PMD_NR)
+		__dec_lruvec_page_state(page, NR_ANON_THPS);
+	else
+		__dec_lruvec_page_state(page, NR_ANON_THPS_PUD);
 
 	if (TestClearPageDoubleMap(page)) {
 		/*
 		 * Subpages can be mapped with PTEs too. Check how many of
 		 * them are still mapped.
 		 */
-		for (i = 0, nr = 0; i < HPAGE_PMD_NR; i++) {
+		for (i = 0, nr = 0; i < thp_nr_pages(page); i++) {
 			if (atomic_add_negative(-1, &page[i]._mapcount))
 				nr++;
 		}
@@ -1306,7 +1320,7 @@ static void page_remove_anon_compound_rmap(struct page *page)
 		if (nr && nr < HPAGE_PMD_NR)
 			deferred_split_huge_page(page);
 	} else {
-		nr = HPAGE_PMD_NR;
+		nr = thp_nr_pages(page);
 	}
 
 	if (unlikely(PageMlocked(page)))
diff --git a/mm/vmstat.c b/mm/vmstat.c
index 06fd13ebc2b8..3a01212b652c 100644
--- a/mm/vmstat.c
+++ b/mm/vmstat.c
@@ -1209,6 +1209,7 @@ const char * const vmstat_text[] = {
 	"nr_file_hugepages",
 	"nr_file_pmdmapped",
 	"nr_anon_transparent_hugepages",
+	"nr_anon_transparent_pud_hugepages",
 	"nr_vmscan_write",
 	"nr_vmscan_immediate_reclaim",
 	"nr_dirtied",
@@ -1325,6 +1326,9 @@ const char * const vmstat_text[] = {
 	"thp_deferred_split_page",
 	"thp_split_pmd",
 #ifdef CONFIG_HAVE_ARCH_TRANSPARENT_HUGEPAGE_PUD
+	"thp_fault_alloc_pud",
+	"thp_fault_fallback_pud",
+	"thp_fault_fallback_pud_charge",
 	"thp_split_pud",
 #endif
 	"thp_zero_page_alloc",
-- 
2.28.0

