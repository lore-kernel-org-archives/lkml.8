Return-Path: <SRS0=RE5T=7A=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 37D07C433E1
	for <linux-kernel@archiver.kernel.org>; Mon, 18 May 2020 01:21:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0929A207BB
	for <linux-kernel@archiver.kernel.org>; Mon, 18 May 2020 01:21:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Cr7jEBcu"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726957AbgERBVx (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 17 May 2020 21:21:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47824 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726665AbgERBVv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 17 May 2020 21:21:51 -0400
Received: from mail-pl1-x644.google.com (mail-pl1-x644.google.com [IPv6:2607:f8b0:4864:20::644])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 37A39C061A0C
        for <linux-kernel@vger.kernel.org>; Sun, 17 May 2020 18:21:50 -0700 (PDT)
Received: by mail-pl1-x644.google.com with SMTP id k22so3542159pls.10
        for <linux-kernel@vger.kernel.org>; Sun, 17 May 2020 18:21:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=FbiwIN0Eqv2g2RfAcusyp0+1xL1QG0WEl5uXNY0CaCU=;
        b=Cr7jEBcudjUwSV7Lvxc490fhb8YrWE0ASE7FOEf9LSdFfc4kaGghJENkKguqJLbZRz
         Wr8Ta52kFM8a7t/VYZT4WOL1eF4FZB7zUf0y/kASDV9TcgJo55HTk3ohWM2q7N8VH26A
         NN9WB58AhEu7iJiGwRiaspLHOb1nAl6LN/oTxNWKIDK9JHA6Z5Q6phlHDTnz55WoK6DR
         LAcKeWdNknPOAsiYQl2agzsypKlz+L2gs1cdGV4q+t7GTRGZdqyBjnkrVX29ps4jBCXI
         bynPdyEQBZjgWKn4PUxf39NIM5X5W1FP+hDQ/VWR11kCCeg2cHhQ4QMhCpOma9SJAIWP
         JxAQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=FbiwIN0Eqv2g2RfAcusyp0+1xL1QG0WEl5uXNY0CaCU=;
        b=nIqx7nqHXqT1VKU7bsd/UjeORlSaA1psA+HeMc6pT0ggBsmSQIuGH7SYUeIccPasLo
         xdHTK5EWDg/Fk+7Tk/KsrN9RDMn7SuN/9hOcOXnibKV2v59UOLXNevrhgp/gm4p5SndM
         wJzaFwEFoxxjWpcNKuXe/wbtxyfUfmgFPEz98iqmmvWqR8aDlwAoLH6oaPchuyW0HSHq
         8O/AQv4+kaA7iRdr+eM7X+yWBclzCkhNCcMaypB4D8xIEF27BO8KqAJiQTFop/rVW/+2
         g67ht21WL06EDX5MljnVxCjasGxrDct7IQlrXeRWHf2MfbIqG/fvn6SZJT0xoNzeuIu1
         wKgg==
X-Gm-Message-State: AOAM533Q2/SG4t5lhYOR7ntx6oTOYtcJbFAavLyjW1agaYNM0ihyA+UL
        7EdPjezx2PTglaFmH4SJqo4=
X-Google-Smtp-Source: ABdhPJySN9wkUNF+0AS/utKC9LrqPrUmLF7sZXguoF99RsvNhZliEpXCff1SM+nIbmOR1gbwpJBLdw==
X-Received: by 2002:a17:90a:290f:: with SMTP id g15mr14952644pjd.93.1589764909711;
        Sun, 17 May 2020 18:21:49 -0700 (PDT)
Received: from localhost.localdomain ([114.206.198.176])
        by smtp.gmail.com with ESMTPSA id fw4sm1544376pjb.31.2020.05.17.18.21.46
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 17 May 2020 18:21:49 -0700 (PDT)
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
Subject: [PATCH 03/11] mm/hugetlb: introduce alloc_control structure to simplify migration target allocation APIs
Date:   Mon, 18 May 2020 10:20:49 +0900
Message-Id: <1589764857-6800-4-git-send-email-iamjoonsoo.kim@lge.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1589764857-6800-1-git-send-email-iamjoonsoo.kim@lge.com>
References: <1589764857-6800-1-git-send-email-iamjoonsoo.kim@lge.com>
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

Note that, gfp_mask handling on alloc_huge_page_(node|nodemask) is
slightly changed, from ASSIGN to OR. It's safe since caller of these
functions doesn't pass extra gfp_mask except htlb_alloc_mask().

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
index 0cced41..6da217e 100644
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
index 0d64ea8..9890fb0 100644
--- a/mm/gup.c
+++ b/mm/gup.c
@@ -1613,16 +1613,21 @@ static struct page *new_non_cma_page(struct page *page, unsigned long private)
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
index dcb34d7..859dba4 100644
--- a/mm/hugetlb.c
+++ b/mm/hugetlb.c
@@ -1054,8 +1054,8 @@ static struct page *dequeue_huge_page_node_exact(struct hstate *h, int nid)
 	return page;
 }
 
-static struct page *dequeue_huge_page_nodemask(struct hstate *h, gfp_t gfp_mask, int nid,
-		nodemask_t *nmask)
+static struct page *dequeue_huge_page_nodemask(struct hstate *h,
+				struct alloc_control *ac)
 {
 	unsigned int cpuset_mems_cookie;
 	struct zonelist *zonelist;
@@ -1063,14 +1063,15 @@ static struct page *dequeue_huge_page_nodemask(struct hstate *h, gfp_t gfp_mask,
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
@@ -1106,9 +1107,7 @@ static struct page *dequeue_huge_page_vma(struct hstate *h,
 {
 	struct page *page;
 	struct mempolicy *mpol;
-	gfp_t gfp_mask;
-	nodemask_t *nodemask;
-	int nid;
+	struct alloc_control ac = {0};
 
 	/*
 	 * A child process with MAP_PRIVATE mappings created by their parent
@@ -1123,9 +1122,10 @@ static struct page *dequeue_huge_page_vma(struct hstate *h,
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
@@ -1938,15 +1938,16 @@ static struct page *alloc_surplus_huge_page(struct hstate *h, gfp_t gfp_mask,
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
 
@@ -1980,36 +1981,37 @@ struct page *alloc_buddy_huge_page_with_mpol(struct hstate *h,
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
+	ac->gfp_mask |= htlb_alloc_mask(h);
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
+	ac->gfp_mask |= htlb_alloc_mask(h);
 
 	spin_lock(&hugetlb_lock);
 	if (h->free_huge_pages - h->resv_huge_pages > 0) {
 		struct page *page;
 
-		page = dequeue_huge_page_nodemask(h, gfp_mask, preferred_nid, nmask);
+		page = dequeue_huge_page_nodemask(h, ac);
 		if (page) {
 			spin_unlock(&hugetlb_lock);
 			return page;
@@ -2017,22 +2019,20 @@ struct page *alloc_huge_page_nodemask(struct hstate *h, int preferred_nid,
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
index 791e4b5a..75b3f8e 100644
--- a/mm/internal.h
+++ b/mm/internal.h
@@ -613,4 +613,11 @@ static inline bool is_migrate_highatomic_page(struct page *page)
 
 void setup_zone_pageset(struct zone *zone);
 extern struct page *alloc_new_node_page(struct page *page, unsigned long node);
+
+struct alloc_control {
+	int nid;
+	nodemask_t *nmask;
+	gfp_t gfp_mask;
+};
+
 #endif	/* __MM_INTERNAL_H */
diff --git a/mm/mempolicy.c b/mm/mempolicy.c
index 1965e26..06f60a5 100644
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
+		struct hstate *h = page_hstate(page);
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
index a298a8c..94d2386 100644
--- a/mm/migrate.c
+++ b/mm/migrate.c
@@ -1526,10 +1526,15 @@ struct page *new_page_nodemask(struct page *page,
 	unsigned int order = 0;
 	struct page *new_page = NULL;
 
-	if (PageHuge(page))
-		return alloc_huge_page_nodemask(
-				page_hstate(compound_head(page)),
-				preferred_nid, nodemask);
+	if (PageHuge(page)) {
+		struct hstate *h = page_hstate(page);
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

