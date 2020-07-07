Return-Path: <SRS0=aTFg=AS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8A8FAC433E2
	for <linux-kernel@archiver.kernel.org>; Tue,  7 Jul 2020 07:45:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6598120708
	for <linux-kernel@archiver.kernel.org>; Tue,  7 Jul 2020 07:45:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jobv/5LY"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728348AbgGGHpZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 7 Jul 2020 03:45:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46186 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728300AbgGGHpY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Jul 2020 03:45:24 -0400
Received: from mail-pf1-x443.google.com (mail-pf1-x443.google.com [IPv6:2607:f8b0:4864:20::443])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 10A40C061755
        for <linux-kernel@vger.kernel.org>; Tue,  7 Jul 2020 00:45:24 -0700 (PDT)
Received: by mail-pf1-x443.google.com with SMTP id j20so2402430pfe.5
        for <linux-kernel@vger.kernel.org>; Tue, 07 Jul 2020 00:45:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=qnoK4TvyfV1LRCnzNkO0sqYOjp7Armsh3/cW2lDsC+Q=;
        b=jobv/5LYElZozBTe1V8H6oXs2SS82tcccFNT1Fx/0CN/Dt4Ya/uzNhWhvnwrkUko5E
         7NBqO3SiduMLv2ylTEsL1DGacWRs+1ilbZH8y2/kfLBfWZ3KWLxn/Vd+liaAp348aeAt
         ppuUi0tMVN9BljVTgUJLnqcsJR98W2Xy9u5fTiT1bh9xGrXLp3LQri9jXhPxKbBN0Fio
         ibqu0tge5U2LSf79tgdW3kA5kKXhYRvKGZBiCm8Mo5RyrF4LtL118zB/7Nywptx/Pm29
         zMWHUDvkJiVyjgKwPNv5znXz33AejY8BF0dqtG7JTq5eaFDy4U6I0E2bmvCnrP2uADq5
         wLiQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=qnoK4TvyfV1LRCnzNkO0sqYOjp7Armsh3/cW2lDsC+Q=;
        b=Yev3/lEvfVMfo6og4nGiYzH7DCMDaF8G32LXP8NVQ31MfgVVNmgocRCQvNr9FBJOiU
         obxWCp0xkgnIjv90JoIxzBy5FGhF920xaqKkrvb2RQDQFuoinJW8kr8Yz+UZCkjb5Li9
         0prlF3cBja6AqK+8rzp0L6kMvUWN+gLkNvVaquuEcHsTnUsq8wgTjCb7IDL2ef/IfYVb
         tEuj7bnIjlxFPM9z1fM5YXHU504JFWs0kY167b1KhHvRU45zqlrZYbsRxAp4vPZHEYJe
         mjyfe0goaTmROn1hDhxBBnzKXbM/7BpMSRgI0/VZ1IOOK6VG3Mz4ZttWLh5Y5T2fiWs7
         IWuA==
X-Gm-Message-State: AOAM532IlR384Ze/nu9LxQdPbBRRmPiIUAr3x1e/RGTsmAeWe4sg22Ye
        5HMFUkPoO/UPetEzEuHHBRY=
X-Google-Smtp-Source: ABdhPJzbD9rVzloBGi9muM3LkFH+P5PEtYezvEv6+d9lkLW2H2SyN8bq7RDgMXzPGTBGgQLAbzW8jw==
X-Received: by 2002:a65:5c88:: with SMTP id a8mr9026434pgt.215.1594107923604;
        Tue, 07 Jul 2020 00:45:23 -0700 (PDT)
Received: from localhost.localdomain ([114.206.198.176])
        by smtp.gmail.com with ESMTPSA id 191sm21330151pfw.150.2020.07.07.00.45.20
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 07 Jul 2020 00:45:23 -0700 (PDT)
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
Subject: [PATCH v4 04/11] mm/hugetlb: make hugetlb migration callback CMA aware
Date:   Tue,  7 Jul 2020 16:44:42 +0900
Message-Id: <1594107889-32228-5-git-send-email-iamjoonsoo.kim@lge.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1594107889-32228-1-git-send-email-iamjoonsoo.kim@lge.com>
References: <1594107889-32228-1-git-send-email-iamjoonsoo.kim@lge.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Joonsoo Kim <iamjoonsoo.kim@lge.com>

new_non_cma_page() in gup.c which try to allocate migration target page
requires to allocate the new page that is not on the CMA area.
new_non_cma_page() implements it by removing __GFP_MOVABLE flag.  This way
works well for THP page or normal page but not for hugetlb page.

hugetlb page allocation process consists of two steps.  First is dequeing
from the pool.  Second is, if there is no available page on the queue,
allocating from the page allocator.

new_non_cma_page() can control allocation from the page allocator by
specifying correct gfp flag.  However, dequeing cannot be controlled until
now, so, new_non_cma_page() skips dequeing completely.  It is a suboptimal
since new_non_cma_page() cannot utilize hugetlb pages on the queue so this
patch tries to fix this situation.

This patch makes the deque function on hugetlb CMA aware and skip CMA
pages if newly added skip_cma argument is passed as true.

Acked-by: Mike Kravetz <mike.kravetz@oracle.com>
Signed-off-by: Joonsoo Kim <iamjoonsoo.kim@lge.com>
---
 include/linux/hugetlb.h |  6 ++----
 mm/gup.c                |  3 ++-
 mm/hugetlb.c            | 46 ++++++++++++++++++++++++++++++----------------
 mm/mempolicy.c          |  2 +-
 mm/migrate.c            |  2 +-
 5 files changed, 36 insertions(+), 23 deletions(-)

diff --git a/include/linux/hugetlb.h b/include/linux/hugetlb.h
index bb93e95..5a9ddf1 100644
--- a/include/linux/hugetlb.h
+++ b/include/linux/hugetlb.h
@@ -506,11 +506,9 @@ struct huge_bootmem_page {
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
 
@@ -770,7 +768,7 @@ static inline struct page *alloc_huge_page(struct vm_area_struct *vma,
 
 static inline struct page *
 alloc_huge_page_nodemask(struct hstate *h, int preferred_nid,
-			nodemask_t *nmask, gfp_t gfp_mask)
+			nodemask_t *nmask, gfp_t gfp_mask, bool skip_cma)
 {
 	return NULL;
 }
diff --git a/mm/gup.c b/mm/gup.c
index 5daadae..2c3dab4 100644
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
index 3245aa0..bcf4abe 100644
--- a/mm/hugetlb.c
+++ b/mm/hugetlb.c
@@ -29,6 +29,7 @@
 #include <linux/numa.h>
 #include <linux/llist.h>
 #include <linux/cma.h>
+#include <linux/sched/mm.h>
 
 #include <asm/page.h>
 #include <asm/tlb.h>
@@ -1033,13 +1034,18 @@ static void enqueue_huge_page(struct hstate *h, struct page *page)
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
@@ -1054,7 +1060,7 @@ static struct page *dequeue_huge_page_node_exact(struct hstate *h, int nid)
 }
 
 static struct page *dequeue_huge_page_nodemask(struct hstate *h, gfp_t gfp_mask, int nid,
-		nodemask_t *nmask)
+		nodemask_t *nmask, bool skip_cma)
 {
 	unsigned int cpuset_mems_cookie;
 	struct zonelist *zonelist;
@@ -1079,7 +1085,7 @@ static struct page *dequeue_huge_page_nodemask(struct hstate *h, gfp_t gfp_mask,
 			continue;
 		node = zone_to_nid(zone);
 
-		page = dequeue_huge_page_node_exact(h, node);
+		page = dequeue_huge_page_node_exact(h, node, skip_cma);
 		if (page)
 			return page;
 	}
@@ -1115,7 +1121,7 @@ static struct page *dequeue_huge_page_vma(struct hstate *h,
 
 	gfp_mask = htlb_alloc_mask(h);
 	nid = huge_node(vma, address, gfp_mask, &mpol, &nodemask);
-	page = dequeue_huge_page_nodemask(h, gfp_mask, nid, nodemask);
+	page = dequeue_huge_page_nodemask(h, gfp_mask, nid, nodemask, false);
 	if (page && !avoid_reserve && vma_has_reserves(vma, chg)) {
 		SetPagePrivate(page);
 		h->resv_huge_pages--;
@@ -1928,7 +1934,7 @@ static struct page *alloc_surplus_huge_page(struct hstate *h, gfp_t gfp_mask,
 	return page;
 }
 
-struct page *alloc_migrate_huge_page(struct hstate *h, gfp_t gfp_mask,
+static struct page *alloc_migrate_huge_page(struct hstate *h, gfp_t gfp_mask,
 				     int nid, nodemask_t *nmask)
 {
 	struct page *page;
@@ -1971,21 +1977,29 @@ struct page *alloc_buddy_huge_page_with_mpol(struct hstate *h,
 
 /* page migration callback function */
 struct page *alloc_huge_page_nodemask(struct hstate *h, int preferred_nid,
-		nodemask_t *nmask, gfp_t gfp_mask)
+		nodemask_t *nmask, gfp_t gfp_mask, bool skip_cma)
 {
+	unsigned int flags = 0;
+	struct page *page = NULL;
+
+	if (skip_cma)
+		flags = memalloc_nocma_save();
+
 	spin_lock(&hugetlb_lock);
 	if (h->free_huge_pages - h->resv_huge_pages > 0) {
-		struct page *page;
-
-		page = dequeue_huge_page_nodemask(h, gfp_mask, preferred_nid, nmask);
-		if (page) {
-			spin_unlock(&hugetlb_lock);
-			return page;
-		}
+		page = dequeue_huge_page_nodemask(h, gfp_mask,
+					preferred_nid, nmask, skip_cma);
 	}
 	spin_unlock(&hugetlb_lock);
 
-	return alloc_migrate_huge_page(h, gfp_mask, preferred_nid, nmask);
+	if (!page)
+		page = alloc_migrate_huge_page(h, gfp_mask,
+					preferred_nid, nmask);
+
+	if (skip_cma)
+		memalloc_nocma_restore(flags);
+
+	return page;
 }
 
 /* mempolicy aware migration callback */
@@ -2000,7 +2014,7 @@ struct page *alloc_huge_page_vma(struct hstate *h, struct vm_area_struct *vma,
 
 	gfp_mask = htlb_alloc_mask(h);
 	node = huge_node(vma, address, gfp_mask, &mpol, &nodemask);
-	page = alloc_huge_page_nodemask(h, node, nodemask, gfp_mask);
+	page = alloc_huge_page_nodemask(h, node, nodemask, gfp_mask, false);
 	mpol_cond_put(mpol);
 
 	return page;
diff --git a/mm/mempolicy.c b/mm/mempolicy.c
index 9034a53..667b453 100644
--- a/mm/mempolicy.c
+++ b/mm/mempolicy.c
@@ -1072,7 +1072,7 @@ struct page *alloc_new_node_page(struct page *page, unsigned long node)
 		struct hstate *h = page_hstate(compound_head(page));
 		gfp_t gfp_mask = htlb_alloc_mask(h) | __GFP_THISNODE;
 
-		return alloc_huge_page_nodemask(h, node, NULL, gfp_mask);
+		return alloc_huge_page_nodemask(h, node, NULL, gfp_mask, false);
 	} else if (PageTransHuge(page)) {
 		struct page *thp;
 
diff --git a/mm/migrate.c b/mm/migrate.c
index 3b3d918..02b31fe 100644
--- a/mm/migrate.c
+++ b/mm/migrate.c
@@ -1543,7 +1543,7 @@ struct page *new_page_nodemask(struct page *page,
 
 		gfp_mask = htlb_alloc_mask(h);
 		return alloc_huge_page_nodemask(h, preferred_nid,
-						nodemask, gfp_mask);
+						nodemask, gfp_mask, false);
 	}
 
 	if (PageTransHuge(page)) {
-- 
2.7.4

