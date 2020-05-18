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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5B653C433DF
	for <linux-kernel@archiver.kernel.org>; Mon, 18 May 2020 01:21:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 30DBC207F9
	for <linux-kernel@archiver.kernel.org>; Mon, 18 May 2020 01:21:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Wnr40su/"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726990AbgERBVz (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 17 May 2020 21:21:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47836 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726958AbgERBVx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 17 May 2020 21:21:53 -0400
Received: from mail-pl1-x644.google.com (mail-pl1-x644.google.com [IPv6:2607:f8b0:4864:20::644])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5B8F3C061A0C
        for <linux-kernel@vger.kernel.org>; Sun, 17 May 2020 18:21:53 -0700 (PDT)
Received: by mail-pl1-x644.google.com with SMTP id k19so3541388pll.9
        for <linux-kernel@vger.kernel.org>; Sun, 17 May 2020 18:21:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=ODtKSE0Od0SMbp4Vjhm8eJRPOKYNB3i5H6QmRpOi+Z0=;
        b=Wnr40su/PZ233GDcGfPStPxBV2EQiYtUEGGZnTd5JO6xmv/X9BLkGjHGeXutrxxxHS
         YBva+DZwV9iwqCPvFsTUylcaUOsiPU/yVdCcpTz2Lj8UA1oHEnrO5BZJXxG1L1WVGyrc
         j31GjOmdep/Rva0m5m/lqWZaraJbO+4CDuMByuXcRN7yPdq9hG/iw76CaPWtlpxgkcfd
         22gzsyB/c8iFCdx76hZxl1qDNkYec+wZtKgfbBj62f1KCAyeFQZXGLvfu+GicleNPveD
         lyBOSmKjIWNaukH+O3wvfb/0MlrXg3UWlL9skFBmBn+9SD6zfmkrIxyReNzI2DG+GQFA
         FVoA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=ODtKSE0Od0SMbp4Vjhm8eJRPOKYNB3i5H6QmRpOi+Z0=;
        b=DqLJ84W9iD7XTKypH+vmGDCESB2So9nyaKpixutsSvwxh/Y+9KER41+7/P8L66h6vb
         pmHCdrbipWamQ1y9I0hfqvAz2SFI3JwwIUWQsbmg0XwqcJ7DKIOcgN9qktC5Vr0FRoKS
         dBEQnyGkrYhBNZisXZr3WWP5bFAZpeLxbTBtG89RqlxRZylNk7OgBdF54oAFgoyuo10l
         NQgDSvLHvUmI4hA7QuGzznaknWIslWFagcec4DeJggXlOyOvr7vXSed0tALypVLp/TWb
         Ly7ftIBi2puXJd4Ii9/BPh+ysBuJUhjnbeaIpmfKh42d9xVhD186Fv4/JR8SwfoFDlxH
         z4jg==
X-Gm-Message-State: AOAM53019SVzp+2PAADG7fTXmgcfuyT89dT0Y5/O2VOakxk0av9UQXve
        8oX7XnLju5fGMiV8oCIrNa8=
X-Google-Smtp-Source: ABdhPJy3dc+vcPbNB0TuCD0/Vkqb33F5xqfwaa+AkKhcXXzGh4y8yKQPyxeO0/wLED4A7mU5h7d87g==
X-Received: by 2002:a17:90a:8a06:: with SMTP id w6mr17617575pjn.191.1589764912858;
        Sun, 17 May 2020 18:21:52 -0700 (PDT)
Received: from localhost.localdomain ([114.206.198.176])
        by smtp.gmail.com with ESMTPSA id fw4sm1544376pjb.31.2020.05.17.18.21.49
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 17 May 2020 18:21:52 -0700 (PDT)
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
Subject: [PATCH 04/11] mm/hugetlb: unify hugetlb migration callback function
Date:   Mon, 18 May 2020 10:20:50 +0900
Message-Id: <1589764857-6800-5-git-send-email-iamjoonsoo.kim@lge.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1589764857-6800-1-git-send-email-iamjoonsoo.kim@lge.com>
References: <1589764857-6800-1-git-send-email-iamjoonsoo.kim@lge.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Joonsoo Kim <iamjoonsoo.kim@lge.com>

There is no difference between two migration callback functions,
alloc_huge_page_node() and alloc_huge_page_nodemask(), except
__GFP_THISNODE handling. This patch adds one more field on to
the alloc_control and handles this exception.

Signed-off-by: Joonsoo Kim <iamjoonsoo.kim@lge.com>
---
 include/linux/hugetlb.h |  8 --------
 mm/hugetlb.c            | 23 ++---------------------
 mm/internal.h           |  1 +
 mm/mempolicy.c          |  3 ++-
 4 files changed, 5 insertions(+), 30 deletions(-)

diff --git a/include/linux/hugetlb.h b/include/linux/hugetlb.h
index 6da217e..4892ed3 100644
--- a/include/linux/hugetlb.h
+++ b/include/linux/hugetlb.h
@@ -505,8 +505,6 @@ struct huge_bootmem_page {
 
 struct page *alloc_migrate_huge_page(struct hstate *h,
 				struct alloc_control *ac);
-struct page *alloc_huge_page_node(struct hstate *h,
-				struct alloc_control *ac);
 struct page *alloc_huge_page_nodemask(struct hstate *h,
 				struct alloc_control *ac);
 struct page *alloc_huge_page_vma(struct hstate *h, struct vm_area_struct *vma,
@@ -755,12 +753,6 @@ static inline void huge_ptep_modify_prot_commit(struct vm_area_struct *vma,
 struct hstate {};
 
 static inline struct page *
-alloc_huge_page_node(struct hstate *h, struct alloc_control *ac)
-{
-	return NULL;
-}
-
-static inline struct page *
 alloc_huge_page_nodemask(struct hstate *h, struct alloc_control *ac)
 {
 	return NULL;
diff --git a/mm/hugetlb.c b/mm/hugetlb.c
index 859dba4..60b0983 100644
--- a/mm/hugetlb.c
+++ b/mm/hugetlb.c
@@ -1981,31 +1981,12 @@ struct page *alloc_buddy_huge_page_with_mpol(struct hstate *h,
 }
 
 /* page migration callback function */
-struct page *alloc_huge_page_node(struct hstate *h,
-				struct alloc_control *ac)
-{
-	struct page *page = NULL;
-
-	ac->gfp_mask |= htlb_alloc_mask(h);
-	if (ac->nid != NUMA_NO_NODE)
-		ac->gfp_mask |= __GFP_THISNODE;
-
-	spin_lock(&hugetlb_lock);
-	if (h->free_huge_pages - h->resv_huge_pages > 0)
-		page = dequeue_huge_page_nodemask(h, ac);
-	spin_unlock(&hugetlb_lock);
-
-	if (!page)
-		page = alloc_migrate_huge_page(h, ac);
-
-	return page;
-}
-
-/* page migration callback function */
 struct page *alloc_huge_page_nodemask(struct hstate *h,
 				struct alloc_control *ac)
 {
 	ac->gfp_mask |= htlb_alloc_mask(h);
+	if (ac->thisnode && ac->nid != NUMA_NO_NODE)
+		ac->gfp_mask |= __GFP_THISNODE;
 
 	spin_lock(&hugetlb_lock);
 	if (h->free_huge_pages - h->resv_huge_pages > 0) {
diff --git a/mm/internal.h b/mm/internal.h
index 75b3f8e..574722d0 100644
--- a/mm/internal.h
+++ b/mm/internal.h
@@ -618,6 +618,7 @@ struct alloc_control {
 	int nid;
 	nodemask_t *nmask;
 	gfp_t gfp_mask;
+	bool thisnode;
 };
 
 #endif	/* __MM_INTERNAL_H */
diff --git a/mm/mempolicy.c b/mm/mempolicy.c
index 06f60a5..629feaa 100644
--- a/mm/mempolicy.c
+++ b/mm/mempolicy.c
@@ -1073,9 +1073,10 @@ struct page *alloc_new_node_page(struct page *page, unsigned long node)
 		struct alloc_control ac = {
 			.nid = node,
 			.nmask = NULL,
+			.thisnode = true,
 		};
 
-		return alloc_huge_page_node(h, &ac);
+		return alloc_huge_page_nodemask(h, &ac);
 	} else if (PageTransHuge(page)) {
 		struct page *thp;
 
-- 
2.7.4

