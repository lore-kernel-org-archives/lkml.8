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
	by smtp.lore.kernel.org (Postfix) with ESMTP id B7914C433E7
	for <linux-kernel@archiver.kernel.org>; Wed,  2 Sep 2020 18:07:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9097A208C7
	for <linux-kernel@archiver.kernel.org>; Wed,  2 Sep 2020 18:07:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=sent.com header.i=@sent.com header.b="d0fu8CF1";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="D+VDVEja"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728081AbgIBSHe (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 2 Sep 2020 14:07:34 -0400
Received: from out1-smtp.messagingengine.com ([66.111.4.25]:47311 "EHLO
        out1-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727951AbgIBSGm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Sep 2020 14:06:42 -0400
Received: from compute4.internal (compute4.nyi.internal [10.202.2.44])
        by mailout.nyi.internal (Postfix) with ESMTP id C83AF5C0228;
        Wed,  2 Sep 2020 14:06:34 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute4.internal (MEProxy); Wed, 02 Sep 2020 14:06:34 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sent.com; h=from
        :to:cc:subject:date:message-id:in-reply-to:references:reply-to
        :mime-version:content-transfer-encoding; s=fm1; bh=s9cLKQkvqUgXX
        9qXewNv9AkRjEs8xeCBdkOQExd8Kic=; b=d0fu8CF1/88vb3bsZ//Ho24Y0suIX
        KQI0dXvhwHw6lSXXK7Ssxhq8nomgdsyFgR63v8tb4xjpetozezYfOHCe3yqAhe9A
        cYfpbx/ETEuYd/8hWLjP6GD/YHxEggMXs14iCEW1MKR2+To1GaMYxOTSkuxijhwt
        EJJp9HrWfU/MphR0SME/Wa8eMYuM7b+XasdN83zg6zSNQIv1AopRE2/IR6SLbwve
        Dmm6+TE1oskLFZAA9AcZyxqwytCQDcV1n12kESu6xGbLch4Tsb4XgQGODsWTsGBs
        lKVyENQ+EdxAkKBlqzvtbYbq02eBWevmzOuKac+VoIj49z4KpNP7CpIgg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-transfer-encoding:date:from
        :in-reply-to:message-id:mime-version:references:reply-to:subject
        :to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
        fm3; bh=s9cLKQkvqUgXX9qXewNv9AkRjEs8xeCBdkOQExd8Kic=; b=D+VDVEja
        tEWQh/q4xvCmWQ0PreIazjh+j4MqjMIrUNRr3K2yx0KtC/6EOTtdJm8YrGIlbNj1
        saYcp8FpDifWHUxM/AKiHxxrUknO7J+MW8WLawZJfMJOaZhvV51jdI0An7xgeBQt
        UFw+3s4Cy3Owm1e6EhqKu0zzw2oXyVBF2egbD31IiiI/USetF9iUqIlnt/Rw3OaP
        Vaj8AO01ZnSddKw8xORhiFSA9XeOSRR7G08/UwEhLna0ECpd7pcE6vA+94FgnQ44
        zzJ3uYxq+poFQ2jBUzjNkTJOH3QkoEKdFQeykpggx2OzbIEVLyZRxrGOf0y1s8cK
        XO8WYhIsaegQIw==
X-ME-Sender: <xms:Kt9PX3aKZm7wRTn5bCGLw69udDIL068V5RzQoiCf-2hAigmUxpY7lQ>
    <xme:Kt9PX2YUzWIhrPae9y_7-ftSRq3hfUujIJ1SPSu0Uzz4MOIoWc3MdeCnw6vO7LC07
    tsn1g6kKR9c45Jk6g>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeduiedrudefledguddvudcutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfgh
    necuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmd
    enucfjughrpefhvffufffkofgjfhhrggfgsedtkeertdertddtnecuhfhrohhmpegkihcu
    jggrnhcuoeiiihdrhigrnhesshgvnhhtrdgtohhmqeenucggtffrrghtthgvrhhnpeduhf
    ffveektdduhfdutdfgtdekkedvhfetuedufedtgffgvdevleehheevjefgtdenucfkphep
    uddvrdegiedruddtiedrudeigeenucevlhhushhtvghrufhiiigvpeduvdenucfrrghrrg
    hmpehmrghilhhfrhhomhepiihirdihrghnsehsvghnthdrtghomh
X-ME-Proxy: <xmx:Kt9PX5-rDYv0XMe8YnKg7DpfxsNlStX_UZqM1AjJH8DZ_pRFFbCY2Q>
    <xmx:Kt9PX9pYetpMsmnmnqaO1QDZgAcGp8hpNi7WIJ-ODfbqqZlxW8984A>
    <xmx:Kt9PXyp1JyPWwDCxVheATg4g3Y1swLkOVgvjeMUQzLT8eWClkikYVQ>
    <xmx:Kt9PXyKE3CCmvhSRJuEj1jU3Pu60A4Kir4JuAqjjyBDaPSTceRxNbw>
Received: from nvrsysarch6.NVidia.COM (unknown [12.46.106.164])
        by mail.messagingengine.com (Postfix) with ESMTPA id 1633630600A6;
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
Subject: [RFC PATCH 14/16] mm: page_alloc: >=MAX_ORDER pages allocation an deallocation.
Date:   Wed,  2 Sep 2020 14:06:26 -0400
Message-Id: <20200902180628.4052244-15-zi.yan@sent.com>
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

Use alloc_contig_pages for allocation and destroy_compound_gigantic_page
for deallocation, so 1GB THP can be created and destroyed without
changing MAX_ORDER.

Signed-off-by: Zi Yan <ziy@nvidia.com>
---
 mm/hugetlb.c    | 22 ----------------------
 mm/internal.h   |  2 ++
 mm/mempolicy.c  | 15 ++++++++++++++-
 mm/page_alloc.c | 33 ++++++++++++++++++++++++++++-----
 4 files changed, 44 insertions(+), 28 deletions(-)

diff --git a/mm/hugetlb.c b/mm/hugetlb.c
index 4113d7b66fee..d5357778b026 100644
--- a/mm/hugetlb.c
+++ b/mm/hugetlb.c
@@ -1211,26 +1211,6 @@ static int hstate_next_node_to_free(struct hstate *h, nodemask_t *nodes_allowed)
 		nr_nodes--)
 
 #ifdef CONFIG_ARCH_HAS_GIGANTIC_PAGE
-static void destroy_compound_gigantic_page(struct page *page,
-					unsigned int order)
-{
-	int i;
-	int nr_pages = 1 << order;
-	struct page *p = page + 1;
-
-	atomic_set(compound_mapcount_ptr(page), 0);
-	if (hpage_pincount_available(page))
-		atomic_set(compound_pincount_ptr(page), 0);
-
-	for (i = 1; i < nr_pages; i++, p = mem_map_next(p, page, i)) {
-		clear_compound_head(p);
-		set_page_refcounted(p);
-	}
-
-	set_compound_order(page, 0);
-	__ClearPageHead(page);
-}
-
 static void free_gigantic_page(struct page *page, unsigned int order)
 {
 	/*
@@ -1288,8 +1268,6 @@ static struct page *alloc_gigantic_page(struct hstate *h, gfp_t gfp_mask,
 	return NULL;
 }
 static inline void free_gigantic_page(struct page *page, unsigned int order) { }
-static inline void destroy_compound_gigantic_page(struct page *page,
-						unsigned int order) { }
 #endif
 
 static void update_and_free_page(struct hstate *h, struct page *page)
diff --git a/mm/internal.h b/mm/internal.h
index 10c677655912..520fd9b5e18a 100644
--- a/mm/internal.h
+++ b/mm/internal.h
@@ -620,4 +620,6 @@ struct migration_target_control {
 	gfp_t gfp_mask;
 };
 
+void destroy_compound_gigantic_page(struct page *page,
+					unsigned int order);
 #endif	/* __MM_INTERNAL_H */
diff --git a/mm/mempolicy.c b/mm/mempolicy.c
index eddbe4e56c73..4bae089e7a89 100644
--- a/mm/mempolicy.c
+++ b/mm/mempolicy.c
@@ -2138,7 +2138,12 @@ static struct page *alloc_page_interleave(gfp_t gfp, unsigned order,
 {
 	struct page *page;
 
-	page = __alloc_pages(gfp, order, nid);
+	if (order > MAX_ORDER) {
+		page = alloc_contig_pages(1UL<<order, gfp, nid, NULL);
+		if (page && (gfp & __GFP_COMP))
+			prep_compound_page(page, order);
+	} else
+		page = __alloc_pages(gfp, order, nid);
 	/* skip NUMA_INTERLEAVE_HIT counter update if numa stats is disabled */
 	if (!static_branch_likely(&vm_numa_stat_key))
 		return page;
@@ -2212,6 +2217,14 @@ alloc_pages_vma(gfp_t gfp, int order, struct vm_area_struct *vma,
 		nmask = policy_nodemask(gfp, pol);
 		if (!nmask || node_isset(hpage_node, *nmask)) {
 			mpol_cond_put(pol);
+
+			if (order > MAX_ORDER) {
+				page = alloc_contig_pages(1UL<<order, gfp,
+							  hpage_node, NULL);
+				if (page && (gfp & __GFP_COMP))
+					prep_compound_page(page, order);
+				goto out;
+			}
 			/*
 			 * First, try to allocate THP only on local node, but
 			 * don't reclaim unnecessarily, just compact.
diff --git a/mm/page_alloc.c b/mm/page_alloc.c
index 97a4c7e4a579..8a8b241508f7 100644
--- a/mm/page_alloc.c
+++ b/mm/page_alloc.c
@@ -1480,6 +1480,24 @@ void __meminit reserve_bootmem_region(phys_addr_t start, phys_addr_t end)
 	}
 }
 
+void destroy_compound_gigantic_page(struct page *page,
+					unsigned int order)
+{
+	int i;
+	int nr_pages = 1 << order;
+	struct page *p = page + 1;
+
+	atomic_set(compound_mapcount_ptr(page), 0);
+	for (i = 1; i < nr_pages; i++, p = mem_map_next(p, page, i)) {
+		clear_compound_head(p);
+		set_page_refcounted(p);
+	}
+
+	set_compound_order(page, 0);
+	__ClearPageHead(page);
+	set_page_refcounted(page);
+}
+
 static void __free_pages_ok(struct page *page, unsigned int order)
 {
 	unsigned long flags;
@@ -1489,11 +1507,16 @@ static void __free_pages_ok(struct page *page, unsigned int order)
 	if (!free_pages_prepare(page, order, true))
 		return;
 
-	migratetype = get_pfnblock_migratetype(page, pfn);
-	local_irq_save(flags);
-	__count_vm_events(PGFREE, 1 << order);
-	free_one_page(page_zone(page), page, pfn, order, migratetype);
-	local_irq_restore(flags);
+	if (order >= MAX_ORDER) {
+		destroy_compound_gigantic_page(page, order);
+		free_contig_range(page_to_pfn(page), 1 << order);
+	} else {
+		migratetype = get_pfnblock_migratetype(page, pfn);
+		local_irq_save(flags);
+		__count_vm_events(PGFREE, 1 << order);
+		free_one_page(page_zone(page), page, pfn, order, migratetype);
+		local_irq_restore(flags);
+	}
 }
 
 void __free_pages_core(struct page *page, unsigned int order)
-- 
2.28.0

