Return-Path: <SRS0=728o=CL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0867DC43461
	for <linux-kernel@archiver.kernel.org>; Wed,  2 Sep 2020 18:07:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id CE722206EB
	for <linux-kernel@archiver.kernel.org>; Wed,  2 Sep 2020 18:07:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=sent.com header.i=@sent.com header.b="TEpelWRj";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="SVTFniIB"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728141AbgIBSHq (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 2 Sep 2020 14:07:46 -0400
Received: from out1-smtp.messagingengine.com ([66.111.4.25]:36053 "EHLO
        out1-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727950AbgIBSGm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Sep 2020 14:06:42 -0400
Received: from compute4.internal (compute4.nyi.internal [10.202.2.44])
        by mailout.nyi.internal (Postfix) with ESMTP id 3434E5C01D3;
        Wed,  2 Sep 2020 14:06:35 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute4.internal (MEProxy); Wed, 02 Sep 2020 14:06:35 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sent.com; h=from
        :to:cc:subject:date:message-id:in-reply-to:references:reply-to
        :mime-version:content-transfer-encoding; s=fm1; bh=vo+WlP2P6ZaoJ
        IBCKZI+fyRIw5q3MoMn49o4u3ecZgg=; b=TEpelWRjPEIN4vRp/+z6iP4vNaUPK
        TCfhY2IrfliRvbztLqUxe/30zaxBLRMNaOfnCx4pTfN+O/8DNd+Pt3aXgK5LLiId
        2X3/ltk49Uhbc1yU2cSrD7mnSHuQbOcH7vRCPFnXZuYWbyTdmOxM1ldW0UNO89+w
        ZAfcvluypPsVDAYYBqmdGlLd42+zsXSV5J/z1vL4tvDVfhZ3ATygP5WeCGNGR7DS
        75E9INuE3acxE/LvEpuGf8LVWWa/Iqrhei2VQAvU29p2DbZvX1snfWYdZnqv1qzf
        oj1hUediWQjrhLVVizqERzNJfk9Y5GjqzAfQG8JNrnyTNus8FC6pInQ/w==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-transfer-encoding:date:from
        :in-reply-to:message-id:mime-version:references:reply-to:subject
        :to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
        fm3; bh=vo+WlP2P6ZaoJIBCKZI+fyRIw5q3MoMn49o4u3ecZgg=; b=SVTFniIB
        rrl/tDZwQceF1nSi0Gj3wgFNyMZ7A2wCl+DZP9PuJ3elUf1hNTd7D2tJADQzuAGO
        r2/A2hglI/Pii+/yTm/oTYCtqvnt51yzJgp6Z8ROmqUyrKYqXkEV9K4voQbg6nzb
        K3DHuFUEOuep6H6xZWIXjyJ0y5h98frbJoTtrOlxYJxd0GvvPq2WOF64fzFQs0+B
        gFHgN/TDH+SrqWIVa6MM8v9+RcppP5/OfyZMVC95TVnLpQM/d8FIiyLjF0PbbOEi
        kfQqWy98Qy/ZBJ+j1lAsi1fX7QM/hrXgE4Vfdv3x1RON3hpT+r8AJAL5SLYtwIRP
        dp8XSwGkGt5nhA==
X-ME-Sender: <xms:Kt9PX4m78iYrNRlGc2voPtP2FYfYqvZbbx2sh2UrUAzDu1dqC5MmsA>
    <xme:Kt9PX30LGaJxhUmWRC7U0TiT50wiOS932Q4iGp_U5A3HJ67JD1kE3IK3yO8Qkgv0W
    lyfx_XjLvcB2t-bTA>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeduiedrudefledguddvudcutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfgh
    necuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmd
    enucfjughrpefhvffufffkofgjfhhrggfgsedtkeertdertddtnecuhfhrohhmpegkihcu
    jggrnhcuoeiiihdrhigrnhesshgvnhhtrdgtohhmqeenucggtffrrghtthgvrhhnpeduhf
    ffveektdduhfdutdfgtdekkedvhfetuedufedtgffgvdevleehheevjefgtdenucfkphep
    uddvrdegiedruddtiedrudeigeenucevlhhushhtvghrufhiiigvpeduvdenucfrrghrrg
    hmpehmrghilhhfrhhomhepiihirdihrghnsehsvghnthdrtghomh
X-ME-Proxy: <xmx:Kt9PX2qKmHkeYA55WZzh7hcR2M7z5tiA_Xv6XzAGiZQ-K7zCU27B9g>
    <xmx:Kt9PX0mX6Zy5GLqWTMPrO8LvhiGLC68GFmA4I-TxQexXOcsLw1Os8A>
    <xmx:Kt9PX23E8K5EmzPeFE7eWAKucx60fTxqsnIfOHDDD17r1-T2naWUbQ>
    <xmx:K99PX_lugGEXT8hcRFcf_PNwBOTOBzXZ3_B-iB6bJnWASOSEtPCCgQ>
Received: from nvrsysarch6.NVidia.COM (unknown [12.46.106.164])
        by mail.messagingengine.com (Postfix) with ESMTPA id 89BD23060272;
        Wed,  2 Sep 2020 14:06:34 -0400 (EDT)
From:   Zi Yan <zi.yan@sent.com>
To:     linux-mm@kvack.org, Roman Gushchin <guro@fb.com>
Cc:     Rik van Riel <riel@surriel.com>,
        "Kirill A . Shutemov" <kirill.shutemov@linux.intel.com>,
        Matthew Wilcox <willy@infradead.org>,
        Shakeel Butt <shakeelb@google.com>,
        Yang Shi <yang.shi@linux.alibaba.com>,
        David Nellans <dnellans@nvidia.com>,
        linux-kernel@vger.kernel.org, Zi Yan <ziy@nvidia.com>
Subject: [RFC PATCH 16/16] mm: thp: use cma reservation for pud thp allocation.
Date:   Wed,  2 Sep 2020 14:06:28 -0400
Message-Id: <20200902180628.4052244-17-zi.yan@sent.com>
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

Sharing hugepage_cma reservation with hugetlb for pud thp allocaiton.
The reserved cma regions still can be used for moveable page allocations.

During 1GB page split, all subpages are cleared from the CMA bitmap,
since they are no more 1GB pages and will be freed via the normal path
instead of cma_release().

Signed-off-by: Zi Yan <ziy@nvidia.com>
---
 include/linux/cma.h     |  3 +++
 include/linux/huge_mm.h | 10 ++++++++++
 mm/cma.c                | 31 +++++++++++++++++++++++++++++++
 mm/huge_memory.c        | 30 ++++++++++++++++++++++++++++++
 mm/mempolicy.c          | 12 +++++++++---
 mm/page_alloc.c         |  3 ++-
 6 files changed, 85 insertions(+), 4 deletions(-)

diff --git a/include/linux/cma.h b/include/linux/cma.h
index abcf7ab712f9..b765d19e4052 100644
--- a/include/linux/cma.h
+++ b/include/linux/cma.h
@@ -46,6 +46,9 @@ extern struct page *cma_alloc(struct cma *cma, size_t count, unsigned int align,
 			      bool no_warn);
 extern bool cma_release(struct cma *cma, const struct page *pages, unsigned int count);
 
+extern bool cma_clear_bitmap_if_in_range(struct cma *cma, const struct page *page,
+					unsigned int count);
+
 extern int cma_for_each_area(int (*it)(struct cma *cma, void *data), void *data);
 
 extern void cma_reserve(int min_order, unsigned long requested_size,
diff --git a/include/linux/huge_mm.h b/include/linux/huge_mm.h
index 3bf8d8a09f08..5a45877055bb 100644
--- a/include/linux/huge_mm.h
+++ b/include/linux/huge_mm.h
@@ -24,6 +24,8 @@ extern struct page *follow_trans_huge_pud(struct vm_area_struct *vma,
 					  unsigned long addr,
 					  pud_t *pud,
 					  unsigned int flags);
+extern struct page *alloc_thp_pud_page(int nid);
+extern bool free_thp_pud_page(struct page *page, int order);
 #else
 static inline void huge_pud_set_accessed(struct vm_fault *vmf, pud_t orig_pud)
 {
@@ -43,6 +45,14 @@ struct page *follow_trans_huge_pud(struct vm_area_struct *vma,
 {
 	return NULL;
 }
+struct page *alloc_thp_pud_page(int nid)
+{
+	return NULL;
+}
+extern bool free_thp_pud_page(struct page *page, int order);
+{
+	return false;
+}
 #endif
 
 extern vm_fault_t do_huge_pmd_wp_page(struct vm_fault *vmf, pmd_t orig_pmd);
diff --git a/mm/cma.c b/mm/cma.c
index aa3a17d8a191..3f721b8f7ccd 100644
--- a/mm/cma.c
+++ b/mm/cma.c
@@ -532,6 +532,37 @@ bool cma_release(struct cma *cma, const struct page *pages, unsigned int count)
 	return true;
 }
 
+/**
+ * cma_clear_bitmap_if_in_range() - clear bitmap for a given page
+ * @cma:   Contiguous memory region for which the allocation is performed.
+ * @pages: Allocated pages.
+ * @count: Number of allocated pages.
+ *
+ * This function clears bitmap of memory allocated by cma_alloc().
+ * It returns false when provided pages do not belong to contiguous area and
+ * true otherwise.
+ */
+bool cma_clear_bitmap_if_in_range(struct cma *cma, const struct page *pages,
+				  unsigned int count)
+{
+	unsigned long pfn;
+
+	if (!cma || !pages)
+		return false;
+
+	pfn = page_to_pfn(pages);
+
+	if (pfn < cma->base_pfn || pfn >= cma->base_pfn + cma->count)
+		return false;
+
+	if (pfn + count > cma->base_pfn + cma->count)
+		return false;
+
+	cma_clear_bitmap(cma, pfn, count);
+
+	return true;
+}
+
 int cma_for_each_area(int (*it)(struct cma *cma, void *data), void *data)
 {
 	int i;
diff --git a/mm/huge_memory.c b/mm/huge_memory.c
index e1440a13da63..2020b843fd97 100644
--- a/mm/huge_memory.c
+++ b/mm/huge_memory.c
@@ -33,6 +33,7 @@
 #include <linux/oom.h>
 #include <linux/numa.h>
 #include <linux/page_owner.h>
+#include <linux/cma.h>
 
 #include <asm/tlb.h>
 #include <asm/pgalloc.h>
@@ -64,6 +65,10 @@ static struct shrinker deferred_split_shrinker;
 static atomic_t huge_zero_refcount;
 struct page *huge_zero_page __read_mostly;
 
+#ifdef CONFIG_CMA
+extern struct cma *hugepage_cma[MAX_NUMNODES];
+#endif
+
 bool transparent_hugepage_enabled(struct vm_area_struct *vma)
 {
 	/* The addr is used to check if the vma size fits */
@@ -2526,6 +2531,13 @@ static void __split_huge_pud_page(struct page *page, struct list_head *list,
 	/* no file-back page support yet */
 	VM_BUG_ON(!PageAnon(page));
 
+	/*  */
+	if (IS_ENABLED(CONFIG_CMA)) {
+		struct cma *cma = hugepage_cma[page_to_nid(head)];
+		VM_BUG_ON(!cma_clear_bitmap_if_in_range(cma, head,
+				thp_nr_pages(head)));
+	}
+
 	for (i = HPAGE_PUD_NR - HPAGE_PMD_NR; i >= 1; i -= HPAGE_PMD_NR) {
 		__split_huge_pud_page_tail(head, i, lruvec, list);
 	}
@@ -3753,3 +3765,21 @@ void remove_migration_pmd(struct page_vma_mapped_walk *pvmw, struct page *new)
 	update_mmu_cache_pmd(vma, address, pvmw->pmd);
 }
 #endif
+
+struct page *alloc_thp_pud_page(int nid)
+{
+	struct page *page = NULL;
+#ifdef CONFIG_CMA
+	page = cma_alloc(hugepage_cma[nid], HPAGE_PUD_NR, HPAGE_PUD_ORDER, true);
+#endif
+	return page;
+}
+
+bool free_thp_pud_page(struct page *page, int order)
+{
+	bool ret = false;
+#ifdef CONFIG_CMA
+	ret = cma_release(hugepage_cma[page_to_nid(page)], page, 1<<order);
+#endif
+	return ret;
+}
diff --git a/mm/mempolicy.c b/mm/mempolicy.c
index 4bae089e7a89..82b496922196 100644
--- a/mm/mempolicy.c
+++ b/mm/mempolicy.c
@@ -2139,7 +2139,10 @@ static struct page *alloc_page_interleave(gfp_t gfp, unsigned order,
 	struct page *page;
 
 	if (order > MAX_ORDER) {
-		page = alloc_contig_pages(1UL<<order, gfp, nid, NULL);
+		if (order == HPAGE_PUD_ORDER)
+			page = alloc_thp_pud_page(nid);
+		if (!page)
+			page = alloc_contig_pages(1UL<<order, gfp, nid, NULL);
 		if (page && (gfp & __GFP_COMP))
 			prep_compound_page(page, order);
 	} else
@@ -2219,8 +2222,11 @@ alloc_pages_vma(gfp_t gfp, int order, struct vm_area_struct *vma,
 			mpol_cond_put(pol);
 
 			if (order > MAX_ORDER) {
-				page = alloc_contig_pages(1UL<<order, gfp,
-							  hpage_node, NULL);
+				if (order == HPAGE_PUD_ORDER)
+					page = alloc_thp_pud_page(hpage_node);
+				if (!page)
+					page = alloc_contig_pages(1UL<<order,
+							gfp, hpage_node, NULL);
 				if (page && (gfp & __GFP_COMP))
 					prep_compound_page(page, order);
 				goto out;
diff --git a/mm/page_alloc.c b/mm/page_alloc.c
index 8a8b241508f7..eff307b4dc57 100644
--- a/mm/page_alloc.c
+++ b/mm/page_alloc.c
@@ -1509,7 +1509,8 @@ static void __free_pages_ok(struct page *page, unsigned int order)
 
 	if (order >= MAX_ORDER) {
 		destroy_compound_gigantic_page(page, order);
-		free_contig_range(page_to_pfn(page), 1 << order);
+		if (!free_thp_pud_page(page, order))
+			free_contig_range(page_to_pfn(page), 1 << order);
 	} else {
 		migratetype = get_pfnblock_migratetype(page, pfn);
 		local_irq_save(flags);
-- 
2.28.0

