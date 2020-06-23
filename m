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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 80A00C433DF
	for <linux-kernel@archiver.kernel.org>; Tue, 23 Jun 2020 06:14:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 525C020772
	for <linux-kernel@archiver.kernel.org>; Tue, 23 Jun 2020 06:14:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="uNvLL5HW"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730917AbgFWGOh (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 23 Jun 2020 02:14:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34192 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730571AbgFWGOf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 Jun 2020 02:14:35 -0400
Received: from mail-pf1-x441.google.com (mail-pf1-x441.google.com [IPv6:2607:f8b0:4864:20::441])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 27233C061573
        for <linux-kernel@vger.kernel.org>; Mon, 22 Jun 2020 23:14:35 -0700 (PDT)
Received: by mail-pf1-x441.google.com with SMTP id j12so7374123pfn.10
        for <linux-kernel@vger.kernel.org>; Mon, 22 Jun 2020 23:14:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=pyWkbUPFywlUnCqFbpFEE4fSGCvnXjgq1ygQYJuoSV8=;
        b=uNvLL5HWoOF4zAqhjW2fWVD+KWhOJ7u1zP8Yiam7dbbMVGt+tWK8zjz4aDvXVQrhys
         sTwS0LM8YuYjjDP55AvYfqMO8cnj9HjtxQL8pZ1zZL1/32Z8YHYy2tfiwxaieKTy1CYS
         iANFnlZv4fQ5jySuYZhxRPc3Ebdx/+7Yx5Ak7g5PmxpFUyp6W5C+UdjyTkMzD7DSDIko
         ImD6Pga/V1Hdr9UulMJwnDwDKK/qDxLJBWxbNu/+fTOmie6fbhvl4MboHznUrR5niXM9
         yaMhKyNLOgvk7ur1oB/Z8nJymYRT1JRXCc6n6eM6chRnPAAs35cvu1nVeEG5HVPq/NR1
         d9IQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=pyWkbUPFywlUnCqFbpFEE4fSGCvnXjgq1ygQYJuoSV8=;
        b=s5ji0MtAuVrM2BQPX3fZ3or6klkfFrlAOOttFFpVPGEYs0vpAi6QfHrflsjgS/AvR7
         QgWEwE7yM2RhtFKVMM9KfVQ1pxRSFYdFSnVsvh1rjMXqtPSs1uK9Jd2QhywVkvNKpQGC
         Rqu5v1alz8Fnw5m53ICrFgqbk17b++5JV8RRvOii2n2D703te061mH3feEeOt4j4qTkZ
         3yKXzj+pUNHlD/dz9TWUbpxIM/heP+hSbPcfc0W/g/fOFV5fvEhnWS/Deo+Ca2Ga68tk
         2Tu6h5Oe0tmFMoqE+SodXCMr0afgdZBPrKuPdKi071l/xVpE4EiJ75AXA7ADQqP/BZni
         Lmng==
X-Gm-Message-State: AOAM533aS1uWXRvL6Bpxs4PPCX3yNc2F5N5g7SBYGlPHD3ewLhHM2WJ/
        NK1AW52OGO8OUFVt8rocVhM=
X-Google-Smtp-Source: ABdhPJzwyQQtbQ5JzbpAA0kxeJXe/6GgmtIQYcaoxTuoAL78jLEBo3afozcGmr++GgyGwCZbn4ctCQ==
X-Received: by 2002:a65:62ce:: with SMTP id m14mr16354063pgv.410.1592892874671;
        Mon, 22 Jun 2020 23:14:34 -0700 (PDT)
Received: from localhost.localdomain ([114.206.198.176])
        by smtp.gmail.com with ESMTPSA id m15sm12801093pgv.45.2020.06.22.23.14.31
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 22 Jun 2020 23:14:34 -0700 (PDT)
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
Subject: [PATCH v3 3/8] mm/hugetlb: unify migration callbacks
Date:   Tue, 23 Jun 2020 15:13:43 +0900
Message-Id: <1592892828-1934-4-git-send-email-iamjoonsoo.kim@lge.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1592892828-1934-1-git-send-email-iamjoonsoo.kim@lge.com>
References: <1592892828-1934-1-git-send-email-iamjoonsoo.kim@lge.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Joonsoo Kim <iamjoonsoo.kim@lge.com>

There is no difference between two migration callback functions,
alloc_huge_page_node() and alloc_huge_page_nodemask(), except
__GFP_THISNODE handling. This patch adds an argument, gfp_mask, on
alloc_huge_page_nodemask() and replace the callsite for
alloc_huge_page_node() with the call to
alloc_huge_page_nodemask(..., __GFP_THISNODE).

It's safe to remove a node id check in alloc_huge_page_node() since
there is no caller passing NUMA_NO_NODE as a node id.

Signed-off-by: Joonsoo Kim <iamjoonsoo.kim@lge.com>
---
 include/linux/hugetlb.h | 11 +++--------
 mm/hugetlb.c            | 26 +++-----------------------
 mm/mempolicy.c          |  9 +++++----
 mm/migrate.c            |  5 +++--
 4 files changed, 14 insertions(+), 37 deletions(-)

diff --git a/include/linux/hugetlb.h b/include/linux/hugetlb.h
index 50650d0..8a8b755 100644
--- a/include/linux/hugetlb.h
+++ b/include/linux/hugetlb.h
@@ -504,9 +504,8 @@ struct huge_bootmem_page {
 
 struct page *alloc_huge_page(struct vm_area_struct *vma,
 				unsigned long addr, int avoid_reserve);
-struct page *alloc_huge_page_node(struct hstate *h, int nid);
 struct page *alloc_huge_page_nodemask(struct hstate *h, int preferred_nid,
-				nodemask_t *nmask);
+				nodemask_t *nmask, gfp_t gfp_mask);
 struct page *alloc_huge_page_vma(struct hstate *h, struct vm_area_struct *vma,
 				unsigned long address);
 struct page *alloc_migrate_huge_page(struct hstate *h, gfp_t gfp_mask,
@@ -759,13 +758,9 @@ static inline struct page *alloc_huge_page(struct vm_area_struct *vma,
 	return NULL;
 }
 
-static inline struct page *alloc_huge_page_node(struct hstate *h, int nid)
-{
-	return NULL;
-}
-
 static inline struct page *
-alloc_huge_page_nodemask(struct hstate *h, int preferred_nid, nodemask_t *nmask)
+alloc_huge_page_nodemask(struct hstate *h, int preferred_nid,
+			nodemask_t *nmask, gfp_t gfp_mask)
 {
 	return NULL;
 }
diff --git a/mm/hugetlb.c b/mm/hugetlb.c
index d54bb7e..bd408f2 100644
--- a/mm/hugetlb.c
+++ b/mm/hugetlb.c
@@ -1979,30 +1979,10 @@ struct page *alloc_buddy_huge_page_with_mpol(struct hstate *h,
 }
 
 /* page migration callback function */
-struct page *alloc_huge_page_node(struct hstate *h, int nid)
-{
-	gfp_t gfp_mask = htlb_alloc_mask(h);
-	struct page *page = NULL;
-
-	if (nid != NUMA_NO_NODE)
-		gfp_mask |= __GFP_THISNODE;
-
-	spin_lock(&hugetlb_lock);
-	if (h->free_huge_pages - h->resv_huge_pages > 0)
-		page = dequeue_huge_page_nodemask(h, gfp_mask, nid, NULL);
-	spin_unlock(&hugetlb_lock);
-
-	if (!page)
-		page = alloc_migrate_huge_page(h, gfp_mask, nid, NULL);
-
-	return page;
-}
-
-/* page migration callback function */
 struct page *alloc_huge_page_nodemask(struct hstate *h, int preferred_nid,
-		nodemask_t *nmask)
+		nodemask_t *nmask, gfp_t gfp_mask)
 {
-	gfp_t gfp_mask = htlb_alloc_mask(h);
+	gfp_mask |= htlb_alloc_mask(h);
 
 	spin_lock(&hugetlb_lock);
 	if (h->free_huge_pages - h->resv_huge_pages > 0) {
@@ -2031,7 +2011,7 @@ struct page *alloc_huge_page_vma(struct hstate *h, struct vm_area_struct *vma,
 
 	gfp_mask = htlb_alloc_mask(h);
 	node = huge_node(vma, address, gfp_mask, &mpol, &nodemask);
-	page = alloc_huge_page_nodemask(h, node, nodemask);
+	page = alloc_huge_page_nodemask(h, node, nodemask, 0);
 	mpol_cond_put(mpol);
 
 	return page;
diff --git a/mm/mempolicy.c b/mm/mempolicy.c
index b9e85d4..f21cff5 100644
--- a/mm/mempolicy.c
+++ b/mm/mempolicy.c
@@ -1068,10 +1068,11 @@ static int migrate_page_add(struct page *page, struct list_head *pagelist,
 /* page allocation callback for NUMA node migration */
 struct page *alloc_new_node_page(struct page *page, unsigned long node)
 {
-	if (PageHuge(page))
-		return alloc_huge_page_node(page_hstate(compound_head(page)),
-					node);
-	else if (PageTransHuge(page)) {
+	if (PageHuge(page)) {
+		return alloc_huge_page_nodemask(
+			page_hstate(compound_head(page)), node,
+			NULL, __GFP_THISNODE);
+	} else if (PageTransHuge(page)) {
 		struct page *thp;
 
 		thp = alloc_pages_node(node,
diff --git a/mm/migrate.c b/mm/migrate.c
index 6b5c75b..6ca9f0c 100644
--- a/mm/migrate.c
+++ b/mm/migrate.c
@@ -1543,10 +1543,11 @@ struct page *new_page_nodemask(struct page *page,
 	unsigned int order = 0;
 	struct page *new_page = NULL;
 
-	if (PageHuge(page))
+	if (PageHuge(page)) {
 		return alloc_huge_page_nodemask(
 				page_hstate(compound_head(page)),
-				preferred_nid, nodemask);
+				preferred_nid, nodemask, 0);
+	}
 
 	if (PageTransHuge(page)) {
 		gfp_mask |= GFP_TRANSHUGE;
-- 
2.7.4

