Return-Path: <SRS0=UR55=7J=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F3BB1C433DF
	for <linux-kernel@archiver.kernel.org>; Wed, 27 May 2020 06:45:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id CBBD82078C
	for <linux-kernel@archiver.kernel.org>; Wed, 27 May 2020 06:45:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="m0JYOn6+"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728869AbgE0Gp4 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 27 May 2020 02:45:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57208 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725613AbgE0Gpy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 May 2020 02:45:54 -0400
Received: from mail-pf1-x444.google.com (mail-pf1-x444.google.com [IPv6:2607:f8b0:4864:20::444])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5E8F4C061A0F
        for <linux-kernel@vger.kernel.org>; Tue, 26 May 2020 23:45:53 -0700 (PDT)
Received: by mail-pf1-x444.google.com with SMTP id 23so11407818pfy.8
        for <linux-kernel@vger.kernel.org>; Tue, 26 May 2020 23:45:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=jaarsNSXj2r2waFsbt4JrekebWDf+ECBsfQlLjWzW54=;
        b=m0JYOn6+E3aA9tTAoXzWIvHFJk9ihfsGTa9eW2Cq9puUGbJI0gqyc7WioqQAVmX9cB
         drHR+R1iXZrQW+mCs0P10dSUF1kwDTnEhEOCFM5LMvML1HOniLA8Lp40Xkm7AVKLzpXF
         B8m0nNskH/bH9yQVQA5JT8Zmcc5Qcfo/Dhuy55ZtG253979LAmLZuRqOO8w3i7ktom2n
         +p1KtHQsq0+oZ5zxvBZoWLJkmX9w3jeLB+xHE0r3rjdS0q1GzRdQh7l0ZZDYsUwNozot
         k9v5N6H2gZTd2lIN3ehubuH5FuHFw/Ml2yu/5sxuXQ+QI1149fx3ipruf5YCYSuIXSxV
         YoOA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=jaarsNSXj2r2waFsbt4JrekebWDf+ECBsfQlLjWzW54=;
        b=NvBQ3i6aWmARTogxqCpBJydFHoS3i6aKZnJ9df4ca1kCpK5RHW1ykp6KYlRae6ndAR
         EuFykVAsIa8LhgqSoZStUutF5w77UjxjIiaj3ZLSFHTePw9LkaXx1n/7hSINAoxXcW1F
         Tg5bHJEP+zNYLnJ0eq2oUuC9ZLUkfxvd875CjXy7GgcLqC1IDKS9n5w+aFMpGXg/vRBV
         m7FaJk/m7lyz6mBty9BlYHqTNUrIyVx4KE6ulKDsbydkxai9yonrMe1tKo7FgCUPvryS
         lbicEaohf2wzqCJ7KDsj2aNb0HVX9JbCCdbz1WmhCofKEfsVCzILSSXnz1LvYO+tUCly
         XGhw==
X-Gm-Message-State: AOAM530wyNRAUIgxmDFvWAdLdrX4rChz57HzLp5LYz2N34GRxkwyD6cY
        L2eb7i3F6XgH+FT/IEhq8uI=
X-Google-Smtp-Source: ABdhPJxB5bxzuGK5pHdRrxzi6GgnTgAWzwtdJVzKuudbLq8EMY5LdFpjt9XIp7hnApVXqcZ1sij+bw==
X-Received: by 2002:a65:6852:: with SMTP id q18mr2624663pgt.218.1590561952892;
        Tue, 26 May 2020 23:45:52 -0700 (PDT)
Received: from localhost.localdomain ([114.206.198.176])
        by smtp.gmail.com with ESMTPSA id r13sm443883pgv.50.2020.05.26.23.45.49
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 26 May 2020 23:45:52 -0700 (PDT)
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
Subject: [PATCH v2 03/12] mm/hugetlb: introduce alloc_control structure to simplify migration target allocation APIs
Date:   Wed, 27 May 2020 15:44:54 +0900
Message-Id: <1590561903-13186-4-git-send-email-iamjoonsoo.kim@lge.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1590561903-13186-1-git-send-email-iamjoonsoo.kim@lge.com>
References: <1590561903-13186-1-git-send-email-iamjoonsoo.kim@lge.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Joonsoo Kim <iamjoonsoo.kim@lge.com>

Currently, page allocation functions for migration requires some arguments.
More worse, in the following patch, more argument will be needed to unify
the similar functions. To simplify them, in this patch, unified data
structure that controls allocation behaviour is introduced.

For clean-up, function declarations are re-ordered.

Signed-off-by: Joonsoo Kim <iamjoonsoo.kim@lge.com>
---
 include/linux/hugetlb.h | 35 +++++++++++++++-------------
 mm/gup.c                | 11 ++++++---
 mm/hugetlb.c            | 62 ++++++++++++++++++++++++-------------------------
 mm/internal.h           |  7 ++++++
 mm/mempolicy.c          | 13 +++++++----
 mm/migrate.c            | 13 +++++++----
 6 files changed, 83 insertions(+), 58 deletions(-)

diff --git a/include/linux/hugetlb.h b/include/linux/hugetlb.h
index 50650d0..15c8fb8 100644
--- a/include/linux/hugetlb.h
+++ b/include/linux/hugetlb.h
@@ -14,6 +14,7 @@
 struct ctl_table;
 struct user_struct;
 struct mmu_gather;
+struct alloc_control;
 
 #ifndef is_hugepd
 typedef struct { unsigned long pd; } hugepd_t;
@@ -502,15 +503,16 @@ struct huge_bootmem_page {
 	struct hstate *hstate;
 };
 
-struct page *alloc_huge_page(struct vm_area_struct *vma,
-				unsigned long addr, int avoid_reserve);
-struct page *alloc_huge_page_node(struct hstate *h, int nid);
-struct page *alloc_huge_page_nodemask(struct hstate *h, int preferred_nid,
-				nodemask_t *nmask);
+struct page *alloc_migrate_huge_page(struct hstate *h,
+				struct alloc_control *ac);
+struct page *alloc_huge_page_node(struct hstate *h,
+				struct alloc_control *ac);
+struct page *alloc_huge_page_nodemask(struct hstate *h,
+				struct alloc_control *ac);
 struct page *alloc_huge_page_vma(struct hstate *h, struct vm_area_struct *vma,
 				unsigned long address);
-struct page *alloc_migrate_huge_page(struct hstate *h, gfp_t gfp_mask,
-				     int nid, nodemask_t *nmask);
+struct page *alloc_huge_page(struct vm_area_struct *vma,
+				unsigned long addr, int avoid_reserve);
 int huge_add_to_page_cache(struct page *page, struct address_space *mapping,
 			pgoff_t idx);
 
@@ -752,20 +754,14 @@ static inline void huge_ptep_modify_prot_commit(struct vm_area_struct *vma,
 #else	/* CONFIG_HUGETLB_PAGE */
 struct hstate {};
 
-static inline struct page *alloc_huge_page(struct vm_area_struct *vma,
-					   unsigned long addr,
-					   int avoid_reserve)
-{
-	return NULL;
-}
-
-static inline struct page *alloc_huge_page_node(struct hstate *h, int nid)
+static inline struct page *
+alloc_huge_page_node(struct hstate *h, struct alloc_control *ac)
 {
 	return NULL;
 }
 
 static inline struct page *
-alloc_huge_page_nodemask(struct hstate *h, int preferred_nid, nodemask_t *nmask)
+alloc_huge_page_nodemask(struct hstate *h, struct alloc_control *ac)
 {
 	return NULL;
 }
@@ -777,6 +773,13 @@ static inline struct page *alloc_huge_page_vma(struct hstate *h,
 	return NULL;
 }
 
+static inline struct page *alloc_huge_page(struct vm_area_struct *vma,
+					   unsigned long addr,
+					   int avoid_reserve)
+{
+	return NULL;
+}
+
 static inline int __alloc_bootmem_huge_page(struct hstate *h)
 {
 	return 0;
diff --git a/mm/gup.c b/mm/gup.c
index ee039d4..6b78f11 100644
--- a/mm/gup.c
+++ b/mm/gup.c
@@ -1612,16 +1612,21 @@ static struct page *new_non_cma_page(struct page *page, unsigned long private)
 	if (PageHighMem(page))
 		gfp_mask |= __GFP_HIGHMEM;
 
-#ifdef CONFIG_HUGETLB_PAGE
 	if (PageHuge(page)) {
 		struct hstate *h = page_hstate(page);
+		struct alloc_control ac = {
+			.nid = nid,
+			.nmask = NULL,
+			.gfp_mask = gfp_mask,
+		};
+
 		/*
 		 * We don't want to dequeue from the pool because pool pages will
 		 * mostly be from the CMA region.
 		 */
-		return alloc_migrate_huge_page(h, gfp_mask, nid, NULL);
+		return alloc_migrate_huge_page(h, &ac);
 	}
-#endif
+
 	if (PageTransHuge(page)) {
 		struct page *thp;
 		/*
diff --git a/mm/hugetlb.c b/mm/hugetlb.c
index 57ece74..453ba94 100644
--- a/mm/hugetlb.c
+++ b/mm/hugetlb.c
@@ -1053,8 +1053,8 @@ static struct page *dequeue_huge_page_node_exact(struct hstate *h, int nid)
 	return page;
 }
 
-static struct page *dequeue_huge_page_nodemask(struct hstate *h, gfp_t gfp_mask, int nid,
-		nodemask_t *nmask)
+static struct page *dequeue_huge_page_nodemask(struct hstate *h,
+				struct alloc_control *ac)
 {
 	unsigned int cpuset_mems_cookie;
 	struct zonelist *zonelist;
@@ -1062,14 +1062,15 @@ static struct page *dequeue_huge_page_nodemask(struct hstate *h, gfp_t gfp_mask,
 	struct zoneref *z;
 	int node = NUMA_NO_NODE;
 
-	zonelist = node_zonelist(nid, gfp_mask);
+	zonelist = node_zonelist(ac->nid, ac->gfp_mask);
 
 retry_cpuset:
 	cpuset_mems_cookie = read_mems_allowed_begin();
-	for_each_zone_zonelist_nodemask(zone, z, zonelist, gfp_zone(gfp_mask), nmask) {
+	for_each_zone_zonelist_nodemask(zone, z, zonelist,
+			gfp_zone(ac->gfp_mask), ac->nmask) {
 		struct page *page;
 
-		if (!cpuset_zone_allowed(zone, gfp_mask))
+		if (!cpuset_zone_allowed(zone, ac->gfp_mask))
 			continue;
 		/*
 		 * no need to ask again on the same node. Pool is node rather than
@@ -1105,9 +1106,7 @@ static struct page *dequeue_huge_page_vma(struct hstate *h,
 {
 	struct page *page;
 	struct mempolicy *mpol;
-	gfp_t gfp_mask;
-	nodemask_t *nodemask;
-	int nid;
+	struct alloc_control ac = {0};
 
 	/*
 	 * A child process with MAP_PRIVATE mappings created by their parent
@@ -1122,9 +1121,10 @@ static struct page *dequeue_huge_page_vma(struct hstate *h,
 	if (avoid_reserve && h->free_huge_pages - h->resv_huge_pages == 0)
 		goto err;
 
-	gfp_mask = htlb_alloc_mask(h);
-	nid = huge_node(vma, address, gfp_mask, &mpol, &nodemask);
-	page = dequeue_huge_page_nodemask(h, gfp_mask, nid, nodemask);
+	ac.gfp_mask = htlb_alloc_mask(h);
+	ac.nid = huge_node(vma, address, ac.gfp_mask, &mpol, &ac.nmask);
+
+	page = dequeue_huge_page_nodemask(h, &ac);
 	if (page && !avoid_reserve && vma_has_reserves(vma, chg)) {
 		SetPagePrivate(page);
 		h->resv_huge_pages--;
@@ -1937,15 +1937,16 @@ static struct page *alloc_surplus_huge_page(struct hstate *h, gfp_t gfp_mask,
 	return page;
 }
 
-struct page *alloc_migrate_huge_page(struct hstate *h, gfp_t gfp_mask,
-				     int nid, nodemask_t *nmask)
+struct page *alloc_migrate_huge_page(struct hstate *h,
+				struct alloc_control *ac)
 {
 	struct page *page;
 
 	if (hstate_is_gigantic(h))
 		return NULL;
 
-	page = alloc_fresh_huge_page(h, gfp_mask, nid, nmask, NULL);
+	page = alloc_fresh_huge_page(h, ac->gfp_mask,
+				ac->nid, ac->nmask, NULL);
 	if (!page)
 		return NULL;
 
@@ -1979,36 +1980,37 @@ struct page *alloc_buddy_huge_page_with_mpol(struct hstate *h,
 }
 
 /* page migration callback function */
-struct page *alloc_huge_page_node(struct hstate *h, int nid)
+struct page *alloc_huge_page_node(struct hstate *h,
+				struct alloc_control *ac)
 {
-	gfp_t gfp_mask = htlb_alloc_mask(h);
 	struct page *page = NULL;
 
-	if (nid != NUMA_NO_NODE)
-		gfp_mask |= __GFP_THISNODE;
+	ac->gfp_mask = htlb_alloc_mask(h);
+	if (ac->nid != NUMA_NO_NODE)
+		ac->gfp_mask |= __GFP_THISNODE;
 
 	spin_lock(&hugetlb_lock);
 	if (h->free_huge_pages - h->resv_huge_pages > 0)
-		page = dequeue_huge_page_nodemask(h, gfp_mask, nid, NULL);
+		page = dequeue_huge_page_nodemask(h, ac);
 	spin_unlock(&hugetlb_lock);
 
 	if (!page)
-		page = alloc_migrate_huge_page(h, gfp_mask, nid, NULL);
+		page = alloc_migrate_huge_page(h, ac);
 
 	return page;
 }
 
 /* page migration callback function */
-struct page *alloc_huge_page_nodemask(struct hstate *h, int preferred_nid,
-		nodemask_t *nmask)
+struct page *alloc_huge_page_nodemask(struct hstate *h,
+				struct alloc_control *ac)
 {
-	gfp_t gfp_mask = htlb_alloc_mask(h);
+	ac->gfp_mask = htlb_alloc_mask(h);
 
 	spin_lock(&hugetlb_lock);
 	if (h->free_huge_pages - h->resv_huge_pages > 0) {
 		struct page *page;
 
-		page = dequeue_huge_page_nodemask(h, gfp_mask, preferred_nid, nmask);
+		page = dequeue_huge_page_nodemask(h, ac);
 		if (page) {
 			spin_unlock(&hugetlb_lock);
 			return page;
@@ -2016,22 +2018,20 @@ struct page *alloc_huge_page_nodemask(struct hstate *h, int preferred_nid,
 	}
 	spin_unlock(&hugetlb_lock);
 
-	return alloc_migrate_huge_page(h, gfp_mask, preferred_nid, nmask);
+	return alloc_migrate_huge_page(h, ac);
 }
 
 /* mempolicy aware migration callback */
 struct page *alloc_huge_page_vma(struct hstate *h, struct vm_area_struct *vma,
 		unsigned long address)
 {
+	struct alloc_control ac = {0};
 	struct mempolicy *mpol;
-	nodemask_t *nodemask;
 	struct page *page;
-	gfp_t gfp_mask;
-	int node;
 
-	gfp_mask = htlb_alloc_mask(h);
-	node = huge_node(vma, address, gfp_mask, &mpol, &nodemask);
-	page = alloc_huge_page_nodemask(h, node, nodemask);
+	ac.gfp_mask = htlb_alloc_mask(h);
+	ac.nid = huge_node(vma, address, ac.gfp_mask, &mpol, &ac.nmask);
+	page = alloc_huge_page_nodemask(h, &ac);
 	mpol_cond_put(mpol);
 
 	return page;
diff --git a/mm/internal.h b/mm/internal.h
index 9886db2..6e613ce 100644
--- a/mm/internal.h
+++ b/mm/internal.h
@@ -613,4 +613,11 @@ static inline bool is_migrate_highatomic_page(struct page *page)
 
 void setup_zone_pageset(struct zone *zone);
 extern struct page *alloc_new_node_page(struct page *page, unsigned long node);
+
+struct alloc_control {
+	int nid;		/* preferred node id */
+	nodemask_t *nmask;
+	gfp_t gfp_mask;
+};
+
 #endif	/* __MM_INTERNAL_H */
diff --git a/mm/mempolicy.c b/mm/mempolicy.c
index 3813206..3b6b551 100644
--- a/mm/mempolicy.c
+++ b/mm/mempolicy.c
@@ -1068,10 +1068,15 @@ static int migrate_page_add(struct page *page, struct list_head *pagelist,
 /* page allocation callback for NUMA node migration */
 struct page *alloc_new_node_page(struct page *page, unsigned long node)
 {
-	if (PageHuge(page))
-		return alloc_huge_page_node(page_hstate(compound_head(page)),
-					node);
-	else if (PageTransHuge(page)) {
+	if (PageHuge(page)) {
+		struct hstate *h = page_hstate(compound_head(page));
+		struct alloc_control ac = {
+			.nid = node,
+			.nmask = NULL,
+		};
+
+		return alloc_huge_page_node(h, &ac);
+	} else if (PageTransHuge(page)) {
 		struct page *thp;
 
 		thp = alloc_pages_node(node,
diff --git a/mm/migrate.c b/mm/migrate.c
index 824c22e..30217537 100644
--- a/mm/migrate.c
+++ b/mm/migrate.c
@@ -1544,10 +1544,15 @@ struct page *new_page_nodemask(struct page *page,
 	unsigned int order = 0;
 	struct page *new_page = NULL;
 
-	if (PageHuge(page))
-		return alloc_huge_page_nodemask(
-				page_hstate(compound_head(page)),
-				preferred_nid, nodemask);
+	if (PageHuge(page)) {
+		struct hstate *h = page_hstate(compound_head(page));
+		struct alloc_control ac = {
+			.nid = preferred_nid,
+			.nmask = nodemask,
+		};
+
+		return alloc_huge_page_nodemask(h, &ac);
+	}
 
 	if (PageTransHuge(page)) {
 		gfp_mask |= GFP_TRANSHUGE;
-- 
2.7.4

