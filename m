Return-Path: <SRS0=AM+j=AE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 45FE5C433DF
	for <linux-kernel@archiver.kernel.org>; Tue, 23 Jun 2020 06:14:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1B2B020772
	for <linux-kernel@archiver.kernel.org>; Tue, 23 Jun 2020 06:14:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="up5DFWGz"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730946AbgFWGOk (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 23 Jun 2020 02:14:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34204 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730571AbgFWGOi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 Jun 2020 02:14:38 -0400
Received: from mail-pl1-x643.google.com (mail-pl1-x643.google.com [IPv6:2607:f8b0:4864:20::643])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7FD37C061573
        for <linux-kernel@vger.kernel.org>; Mon, 22 Jun 2020 23:14:38 -0700 (PDT)
Received: by mail-pl1-x643.google.com with SMTP id d8so8668450plo.12
        for <linux-kernel@vger.kernel.org>; Mon, 22 Jun 2020 23:14:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=Dc8LghL6mPcKqqBO+Tl511spB3nCK4Lh+EbuLfVS40I=;
        b=up5DFWGzS5WrjfCoJJN5xdu/dSnt80JnCIvsIR4FO584vq8RGK7mjGJlO4zGnQnNt9
         NDY1nG1cVMwu4sfBRNJyFolgiS5lSDAnc63N6CgrsQqsDGoeM2Jm2F0l009uokROvN6L
         TcUVe/dRulxTsgXTBZ2IbIXV2QdSufrJOOF6888yhzHDBKa6m9H7zbcooNgkaNZwgvHQ
         8/p5jgQyvOV5rB+VkogjzEos4W758txaS7wzQQfMCXFgtwB6CP7yGkIMdJfhsgLs6nqY
         miY0y/GsbyMyZ9j/9XiP7D9ZxKNn3KHoCCQ3ouGbMvYgmwqqFC/mcZW5Vr5EErUq9TLy
         Jv7A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=Dc8LghL6mPcKqqBO+Tl511spB3nCK4Lh+EbuLfVS40I=;
        b=qfbwwMIZ/Omj2efBvYf2z7nXYiM/zRlxoujo7Psv2ZhfhIpjHNrkq811e7XzwzOdoL
         BAb/tfSg7IUbab0UbJKSYutLjfV9okRx7lobuevdtPKcvsS4kOSHrucT5plt/3s8nRkm
         /P1sbZJ75vP1pdqcvv85jDB69h9rzlXWjYqDBzumLn3xoQMaBAnoQZK7Lg5/sB5/zGw9
         AN3O8Wkh4j4DMihhH7Z4iZAg/6uLrtfsWeh88ow1S1N78CFKiP5J9mvz8ObJk3/EytCl
         pe6kGZjeTWKEd09BpYxQYvXjCJBF44Zh6u/v9YpCYIFG0gcPqsB8bkm05eMjqz5eChry
         YmIQ==
X-Gm-Message-State: AOAM533u3YuSNTQFsVPu4zFpnkO8SHjgjtPnEjN3XWorPwGmEkbmt81U
        eOtjG0tqV0tcuxn0HZvT7rY=
X-Google-Smtp-Source: ABdhPJzKX1HSJANYr7NhAx6gNraDC6+KJqFwV6wV6/d6ax9bWH8Sqo5hTpSz6Y3cF5ezGkJ0Cy/U0Q==
X-Received: by 2002:a17:90a:f0d4:: with SMTP id fa20mr21701832pjb.160.1592892878004;
        Mon, 22 Jun 2020 23:14:38 -0700 (PDT)
Received: from localhost.localdomain ([114.206.198.176])
        by smtp.gmail.com with ESMTPSA id m15sm12801093pgv.45.2020.06.22.23.14.34
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 22 Jun 2020 23:14:37 -0700 (PDT)
From:   js1304@gmail.com
X-Google-Original-From: iamjoonsoo.kim@lge.com
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        kernel-team@lge.com, Vlastimil Babka <vbabka@suse.cz>,
        Christoph Hellwig <hch@infradead.org>,
        Roman Gushchin <guro@fb.com>,
        Mike Kravetz <mike.kravetz@oracle.com>,
        Naoya Horiguchi <n-horiguchi@ah.jp.nec.com>,
        Michal Hocko <mhocko@suse.com>,
        Joonsoo Kim <iamjoonsoo.kim@lge.com>
Subject: [PATCH v3 4/8] mm/hugetlb: make hugetlb migration callback CMA aware
Date:   Tue, 23 Jun 2020 15:13:44 +0900
Message-Id: <1592892828-1934-5-git-send-email-iamjoonsoo.kim@lge.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1592892828-1934-1-git-send-email-iamjoonsoo.kim@lge.com>
References: <1592892828-1934-1-git-send-email-iamjoonsoo.kim@lge.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Joonsoo Kim <iamjoonsoo.kim@lge.com>

new_non_cma_page() in gup.c which try to allocate migration target page
requires to allocate the new page that is not on the CMA area.
new_non_cma_page() implements it by removing __GFP_MOVABLE flag. This way
works well for THP page or normal page but not for hugetlb page.

hugetlb page allocation process consists of two steps. First is dequeing
from the pool. Second is, if there is no available page on the queue,
allocating from the page allocator.

new_non_cma_page() can control allocation from the page allocator by
specifying correct gfp flag. However, dequeing cannot be controlled until
now, so, new_non_cma_page() skips dequeing completely. It is a suboptimal
since new_non_cma_page() cannot utilize hugetlb pages on the queue so
this patch tries to fix this situation.

This patch makes the deque function on hugetlb CMA aware and skip CMA
pages if newly added skip_cma argument is passed as true.

Acked-by: Mike Kravetz <mike.kravetz@oracle.com>
Signed-off-by: Joonsoo Kim <iamjoonsoo.kim@lge.com>
---
 include/linux/hugetlb.h |  6 ++----
 mm/gup.c                |  3 ++-
 mm/hugetlb.c            | 31 ++++++++++++++++++++++---------
 mm/mempolicy.c          |  2 +-
 mm/migrate.c            |  2 +-
 5 files changed, 28 insertions(+), 16 deletions(-)

diff --git a/include/linux/hugetlb.h b/include/linux/hugetlb.h
index 8a8b755..858522e 100644
--- a/include/linux/hugetlb.h
+++ b/include/linux/hugetlb.h
@@ -505,11 +505,9 @@ struct huge_bootmem_page {
 struct page *alloc_huge_page(struct vm_area_struct *vma,
 				unsigned long addr, int avoid_reserve);
 struct page *alloc_huge_page_nodemask(struct hstate *h, int preferred_nid,
-				nodemask_t *nmask, gfp_t gfp_mask);
+				nodemask_t *nmask, gfp_t gfp_mask, bool skip_cma);
 struct page *alloc_huge_page_vma(struct hstate *h, struct vm_area_struct *vma,
 				unsigned long address);
-struct page *alloc_migrate_huge_page(struct hstate *h, gfp_t gfp_mask,
-				     int nid, nodemask_t *nmask);
 int huge_add_to_page_cache(struct page *page, struct address_space *mapping,
 			pgoff_t idx);
 
@@ -760,7 +758,7 @@ static inline struct page *alloc_huge_page(struct vm_area_struct *vma,
 
 static inline struct page *
 alloc_huge_page_nodemask(struct hstate *h, int preferred_nid,
-			nodemask_t *nmask, gfp_t gfp_mask)
+			nodemask_t *nmask, gfp_t gfp_mask, bool skip_cma)
 {
 	return NULL;
 }
diff --git a/mm/gup.c b/mm/gup.c
index 6f47697..15be281 100644
--- a/mm/gup.c
+++ b/mm/gup.c
@@ -1630,11 +1630,12 @@ static struct page *new_non_cma_page(struct page *page, unsigned long private)
 #ifdef CONFIG_HUGETLB_PAGE
 	if (PageHuge(page)) {
 		struct hstate *h = page_hstate(page);
+
 		/*
 		 * We don't want to dequeue from the pool because pool pages will
 		 * mostly be from the CMA region.
 		 */
-		return alloc_migrate_huge_page(h, gfp_mask, nid, NULL);
+		return alloc_huge_page_nodemask(h, nid, NULL, gfp_mask, true);
 	}
 #endif
 	if (PageTransHuge(page)) {
diff --git a/mm/hugetlb.c b/mm/hugetlb.c
index bd408f2..1410e62 100644
--- a/mm/hugetlb.c
+++ b/mm/hugetlb.c
@@ -1033,13 +1033,18 @@ static void enqueue_huge_page(struct hstate *h, struct page *page)
 	h->free_huge_pages_node[nid]++;
 }
 
-static struct page *dequeue_huge_page_node_exact(struct hstate *h, int nid)
+static struct page *dequeue_huge_page_node_exact(struct hstate *h, int nid, bool skip_cma)
 {
 	struct page *page;
 
-	list_for_each_entry(page, &h->hugepage_freelists[nid], lru)
+	list_for_each_entry(page, &h->hugepage_freelists[nid], lru) {
+		if (skip_cma && is_migrate_cma_page(page))
+			continue;
+
 		if (!PageHWPoison(page))
 			break;
+	}
+
 	/*
 	 * if 'non-isolated free hugepage' not found on the list,
 	 * the allocation fails.
@@ -1054,7 +1059,7 @@ static struct page *dequeue_huge_page_node_exact(struct hstate *h, int nid)
 }
 
 static struct page *dequeue_huge_page_nodemask(struct hstate *h, gfp_t gfp_mask, int nid,
-		nodemask_t *nmask)
+		nodemask_t *nmask, bool skip_cma)
 {
 	unsigned int cpuset_mems_cookie;
 	struct zonelist *zonelist;
@@ -1079,7 +1084,7 @@ static struct page *dequeue_huge_page_nodemask(struct hstate *h, gfp_t gfp_mask,
 			continue;
 		node = zone_to_nid(zone);
 
-		page = dequeue_huge_page_node_exact(h, node);
+		page = dequeue_huge_page_node_exact(h, node, skip_cma);
 		if (page)
 			return page;
 	}
@@ -1124,7 +1129,7 @@ static struct page *dequeue_huge_page_vma(struct hstate *h,
 
 	gfp_mask = htlb_alloc_mask(h);
 	nid = huge_node(vma, address, gfp_mask, &mpol, &nodemask);
-	page = dequeue_huge_page_nodemask(h, gfp_mask, nid, nodemask);
+	page = dequeue_huge_page_nodemask(h, gfp_mask, nid, nodemask, false);
 	if (page && !avoid_reserve && vma_has_reserves(vma, chg)) {
 		SetPagePrivate(page);
 		h->resv_huge_pages--;
@@ -1937,7 +1942,7 @@ static struct page *alloc_surplus_huge_page(struct hstate *h, gfp_t gfp_mask,
 	return page;
 }
 
-struct page *alloc_migrate_huge_page(struct hstate *h, gfp_t gfp_mask,
+static struct page *alloc_migrate_huge_page(struct hstate *h, gfp_t gfp_mask,
 				     int nid, nodemask_t *nmask)
 {
 	struct page *page;
@@ -1980,7 +1985,7 @@ struct page *alloc_buddy_huge_page_with_mpol(struct hstate *h,
 
 /* page migration callback function */
 struct page *alloc_huge_page_nodemask(struct hstate *h, int preferred_nid,
-		nodemask_t *nmask, gfp_t gfp_mask)
+		nodemask_t *nmask, gfp_t gfp_mask, bool skip_cma)
 {
 	gfp_mask |= htlb_alloc_mask(h);
 
@@ -1988,7 +1993,8 @@ struct page *alloc_huge_page_nodemask(struct hstate *h, int preferred_nid,
 	if (h->free_huge_pages - h->resv_huge_pages > 0) {
 		struct page *page;
 
-		page = dequeue_huge_page_nodemask(h, gfp_mask, preferred_nid, nmask);
+		page = dequeue_huge_page_nodemask(h, gfp_mask,
+					preferred_nid, nmask, skip_cma);
 		if (page) {
 			spin_unlock(&hugetlb_lock);
 			return page;
@@ -1996,6 +2002,13 @@ struct page *alloc_huge_page_nodemask(struct hstate *h, int preferred_nid,
 	}
 	spin_unlock(&hugetlb_lock);
 
+	/*
+	 * To skip the memory on CMA area, we need to clear __GFP_MOVABLE.
+	 * Clearing __GFP_MOVABLE at the top of this function would also skip
+	 * the proper allocation candidates for dequeue so clearing it here.
+	 */
+	if (skip_cma)
+		gfp_mask &= ~__GFP_MOVABLE;
 	return alloc_migrate_huge_page(h, gfp_mask, preferred_nid, nmask);
 }
 
@@ -2011,7 +2024,7 @@ struct page *alloc_huge_page_vma(struct hstate *h, struct vm_area_struct *vma,
 
 	gfp_mask = htlb_alloc_mask(h);
 	node = huge_node(vma, address, gfp_mask, &mpol, &nodemask);
-	page = alloc_huge_page_nodemask(h, node, nodemask, 0);
+	page = alloc_huge_page_nodemask(h, node, nodemask, 0, false);
 	mpol_cond_put(mpol);
 
 	return page;
diff --git a/mm/mempolicy.c b/mm/mempolicy.c
index f21cff5..a3abf64 100644
--- a/mm/mempolicy.c
+++ b/mm/mempolicy.c
@@ -1071,7 +1071,7 @@ struct page *alloc_new_node_page(struct page *page, unsigned long node)
 	if (PageHuge(page)) {
 		return alloc_huge_page_nodemask(
 			page_hstate(compound_head(page)), node,
-			NULL, __GFP_THISNODE);
+			NULL, __GFP_THISNODE, false);
 	} else if (PageTransHuge(page)) {
 		struct page *thp;
 
diff --git a/mm/migrate.c b/mm/migrate.c
index 6ca9f0c..634f1ea 100644
--- a/mm/migrate.c
+++ b/mm/migrate.c
@@ -1546,7 +1546,7 @@ struct page *new_page_nodemask(struct page *page,
 	if (PageHuge(page)) {
 		return alloc_huge_page_nodemask(
 				page_hstate(compound_head(page)),
-				preferred_nid, nodemask, 0);
+				preferred_nid, nodemask, 0, false);
 	}
 
 	if (PageTransHuge(page)) {
-- 
2.7.4

