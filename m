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
	by smtp.lore.kernel.org (Postfix) with ESMTP id A18AFC433DF
	for <linux-kernel@archiver.kernel.org>; Mon, 18 May 2020 01:22:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 81B98207ED
	for <linux-kernel@archiver.kernel.org>; Mon, 18 May 2020 01:22:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="i6qFVekf"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727017AbgERBWB (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 17 May 2020 21:22:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47844 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726958AbgERBV4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 17 May 2020 21:21:56 -0400
Received: from mail-pf1-x441.google.com (mail-pf1-x441.google.com [IPv6:2607:f8b0:4864:20::441])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A3D72C061A0C
        for <linux-kernel@vger.kernel.org>; Sun, 17 May 2020 18:21:56 -0700 (PDT)
Received: by mail-pf1-x441.google.com with SMTP id z1so4210181pfn.3
        for <linux-kernel@vger.kernel.org>; Sun, 17 May 2020 18:21:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=s7ZF/TSgVPMfBiVL+g87/XdCmCQwJ5rXkaWI13NQ9/4=;
        b=i6qFVekfMEKDNi1U1IPosOULPIAx+nSjOpugNRND1bVgup/cqL6ozD56uPC/QjGFZo
         pVh/5YrY/zGj+XVrQdk16oy7cGfc8RZ4iOhpdtyB8g46pnSWce2MGzFfcGaJ3X2BBVJE
         VwluPHIcLkkZY8ICNsLHt71CbIXxRoUjXpHsiqELgkIf+yZ4dDTEAynmegKvbL0j17yl
         FMgQRRNqZoiPTb1D7xioV23OQtdX38JJVHJd4dC1wdDmiq7ditwiOAQ25/F//Cza8VNF
         Ia7/XcKVEpqhAGOvbZ4o9yf+3jLghWOgNCKuclGFf8TBrv4KHJO8kiQsXU/veXUQXDl7
         QR6Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=s7ZF/TSgVPMfBiVL+g87/XdCmCQwJ5rXkaWI13NQ9/4=;
        b=n/O9O1J6qnD2tk7tzh2cBB+wcKRXbkA2hSzk5K8m92Rtp14J64YVGORtZ7l6MzqR8V
         on5Y0fAgsFe7AmUl04nz81X/lxzv3cCsS0dZxzyUGwG9hFBXXrCRpsNt+K6hGiB3QscR
         eNPYdsyGYR9Oi5W3h4fNnE+ia2BHtXz/5zXDUqbh9IztR3ljx10wuLv8m6p4JrVDntkD
         tKHHE+knvJW+Zyi0L2h1sxWj18WYpF+OFve24nEwceCycJxa2L7XGTexJUeu3lmYAnOC
         6QPpA1TawJlMFYU21P15fTC+4B3iQNFMeS+SvFfS6dDFEuLNTFgyb1fgHoKnFSteCK3O
         7nUw==
X-Gm-Message-State: AOAM533Olt7ol3JV/Vf0Yr6AIvRmoVJ8E8Mctp+tyqhQDpEOUnLtVKjL
        WtTzRyaayfj+smzihXn3xZ0=
X-Google-Smtp-Source: ABdhPJzs7I2th1ALqmLEiamW68tTpAcgk740vzOfrPORpBpBUVeAsqL9hJ9ZCBdpBVIw38ka9LG+2g==
X-Received: by 2002:a63:c146:: with SMTP id p6mr6866650pgi.55.1589764916099;
        Sun, 17 May 2020 18:21:56 -0700 (PDT)
Received: from localhost.localdomain ([114.206.198.176])
        by smtp.gmail.com with ESMTPSA id fw4sm1544376pjb.31.2020.05.17.18.21.53
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 17 May 2020 18:21:55 -0700 (PDT)
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
Subject: [PATCH 05/11] mm/hugetlb: make hugetlb migration target allocation APIs CMA aware
Date:   Mon, 18 May 2020 10:20:51 +0900
Message-Id: <1589764857-6800-6-git-send-email-iamjoonsoo.kim@lge.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1589764857-6800-1-git-send-email-iamjoonsoo.kim@lge.com>
References: <1589764857-6800-1-git-send-email-iamjoonsoo.kim@lge.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Joonsoo Kim <iamjoonsoo.kim@lge.com>

There is a user who do not want to use CMA memory for migration. Until
now, it is implemented by caller side but it's not optimal since there
is limited information on caller. This patch implements it on callee side
to get better result.

Signed-off-by: Joonsoo Kim <iamjoonsoo.kim@lge.com>
---
 include/linux/hugetlb.h |  2 --
 mm/gup.c                |  9 +++------
 mm/hugetlb.c            | 21 +++++++++++++++++----
 mm/internal.h           |  1 +
 4 files changed, 21 insertions(+), 12 deletions(-)

diff --git a/include/linux/hugetlb.h b/include/linux/hugetlb.h
index 4892ed3..6485e92 100644
--- a/include/linux/hugetlb.h
+++ b/include/linux/hugetlb.h
@@ -503,8 +503,6 @@ struct huge_bootmem_page {
 	struct hstate *hstate;
 };
 
-struct page *alloc_migrate_huge_page(struct hstate *h,
-				struct alloc_control *ac);
 struct page *alloc_huge_page_nodemask(struct hstate *h,
 				struct alloc_control *ac);
 struct page *alloc_huge_page_vma(struct hstate *h, struct vm_area_struct *vma,
diff --git a/mm/gup.c b/mm/gup.c
index 9890fb0..1c86db5 100644
--- a/mm/gup.c
+++ b/mm/gup.c
@@ -1618,14 +1618,11 @@ static struct page *new_non_cma_page(struct page *page, unsigned long private)
 		struct alloc_control ac = {
 			.nid = nid,
 			.nmask = NULL,
-			.gfp_mask = gfp_mask,
+			.gfp_mask = __GFP_NOWARN,
+			.skip_cma = true,
 		};
 
-		/*
-		 * We don't want to dequeue from the pool because pool pages will
-		 * mostly be from the CMA region.
-		 */
-		return alloc_migrate_huge_page(h, &ac);
+		return alloc_huge_page_nodemask(h, &ac);
 	}
 
 	if (PageTransHuge(page)) {
diff --git a/mm/hugetlb.c b/mm/hugetlb.c
index 60b0983..53edd02 100644
--- a/mm/hugetlb.c
+++ b/mm/hugetlb.c
@@ -1034,13 +1034,19 @@ static void enqueue_huge_page(struct hstate *h, struct page *page)
 	h->free_huge_pages_node[nid]++;
 }
 
-static struct page *dequeue_huge_page_node_exact(struct hstate *h, int nid)
+static struct page *dequeue_huge_page_node_exact(struct hstate *h,
+						int nid, bool skip_cma)
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
@@ -1081,7 +1087,7 @@ static struct page *dequeue_huge_page_nodemask(struct hstate *h,
 			continue;
 		node = zone_to_nid(zone);
 
-		page = dequeue_huge_page_node_exact(h, node);
+		page = dequeue_huge_page_node_exact(h, node, ac->skip_cma);
 		if (page)
 			return page;
 	}
@@ -1938,7 +1944,7 @@ static struct page *alloc_surplus_huge_page(struct hstate *h, gfp_t gfp_mask,
 	return page;
 }
 
-struct page *alloc_migrate_huge_page(struct hstate *h,
+static struct page *alloc_migrate_huge_page(struct hstate *h,
 				struct alloc_control *ac)
 {
 	struct page *page;
@@ -2000,6 +2006,13 @@ struct page *alloc_huge_page_nodemask(struct hstate *h,
 	}
 	spin_unlock(&hugetlb_lock);
 
+	/*
+	 * clearing __GFP_MOVABLE flag ensure that allocated page
+	 * will not come from CMA area
+	 */
+	if (ac->skip_cma)
+		ac->gfp_mask &= ~__GFP_MOVABLE;
+
 	return alloc_migrate_huge_page(h, ac);
 }
 
diff --git a/mm/internal.h b/mm/internal.h
index 574722d0..6b6507e 100644
--- a/mm/internal.h
+++ b/mm/internal.h
@@ -619,6 +619,7 @@ struct alloc_control {
 	nodemask_t *nmask;
 	gfp_t gfp_mask;
 	bool thisnode;
+	bool skip_cma;
 };
 
 #endif	/* __MM_INTERNAL_H */
-- 
2.7.4

