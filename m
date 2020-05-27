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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 44A47C433E1
	for <linux-kernel@archiver.kernel.org>; Wed, 27 May 2020 06:46:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 223D2208E4
	for <linux-kernel@archiver.kernel.org>; Wed, 27 May 2020 06:46:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="RNNjsksJ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728904AbgE0GqC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 27 May 2020 02:46:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57228 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725613AbgE0GqA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 May 2020 02:46:00 -0400
Received: from mail-pl1-x644.google.com (mail-pl1-x644.google.com [IPv6:2607:f8b0:4864:20::644])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DD80FC03E96F
        for <linux-kernel@vger.kernel.org>; Tue, 26 May 2020 23:45:59 -0700 (PDT)
Received: by mail-pl1-x644.google.com with SMTP id bg4so4481969plb.3
        for <linux-kernel@vger.kernel.org>; Tue, 26 May 2020 23:45:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=4+7G4sF/LBY2T1Rcr4q2hABu3PPTL1U0eg/qjTVIM5Q=;
        b=RNNjsksJBEQSxwRaNcnVBhv83AMTxB3wY3MlvdwSMKYgoPiK/kARvmuDjFJcftvh3S
         79VFKJ+he2uzx32m5P5mHvnTDbrIZsBr90Ydysl3aebsb8+Dno7RZzjqNjEk3BvavEfY
         Rg7oO+jPMM5Wccn1TjWZYOFdG7HmnG7yJFPhYN3xLOXUK5AaFZzSLdRzWe/OaIkFgRj2
         mgrLhLJL5dbtN34btLxxUwRastIZdCY8rPbUFqyxn6GjzNoekeTGmIYxJcLn4tZyBuXQ
         T+xFn7oBofObcYuB/UBtvXD1bFNQiY54+a80X2jrwjWK9FrWoP3jnt1//BwNA9flzbwi
         5BDQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=4+7G4sF/LBY2T1Rcr4q2hABu3PPTL1U0eg/qjTVIM5Q=;
        b=b5Lj+wsu1qLbztS2t8XvFB8tl69W/HMUr2TcdF3FtkStdoUDuDyu+tVHsa3v/oALSt
         8zWd60BeGESMwpGTClDtTadYkn+e29zlFACI1ELwYLk2+up0vgprgH4XHB335W9a9p/M
         RZUosr+TMDu2/GdxnHtlElKHUDa6mMBidsc5SgXEB5LQU4GP0Ra4IE3ZAVBR5nnojiOF
         6L3by2GrLTHkA/quqAY0uYpwsY5yW5SVMvS3LOLdCDqAd2xFCz9rV4XhXN3hF90Nrc+6
         swR0G9w1earwAjZ2NO3CpekYiphWD2V1sVx1kh+6vrayb/jfMRPqDlSxfxeS43ltBZAU
         paFg==
X-Gm-Message-State: AOAM5325YE18/GFzF2G6qaC7+hQ7rIiUIzxal2z3dv3EDzIrrLBhGRRT
        Lq4ppQM8UYQSXwvSRnh14pY=
X-Google-Smtp-Source: ABdhPJwb/bznyw4ccdgL1+FH7sh9R8l8nGE2XSUt8mY61KSL7oERqpos6LYIsBdJBtNARZkTPVr5JQ==
X-Received: by 2002:a17:902:be09:: with SMTP id r9mr4508282pls.271.1590561959345;
        Tue, 26 May 2020 23:45:59 -0700 (PDT)
Received: from localhost.localdomain ([114.206.198.176])
        by smtp.gmail.com with ESMTPSA id r13sm443883pgv.50.2020.05.26.23.45.56
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 26 May 2020 23:45:58 -0700 (PDT)
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
Subject: [PATCH v2 05/12] mm/hugetlb: unify hugetlb migration callback function
Date:   Wed, 27 May 2020 15:44:56 +0900
Message-Id: <1590561903-13186-6-git-send-email-iamjoonsoo.kim@lge.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1590561903-13186-1-git-send-email-iamjoonsoo.kim@lge.com>
References: <1590561903-13186-1-git-send-email-iamjoonsoo.kim@lge.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Joonsoo Kim <iamjoonsoo.kim@lge.com>

There is no difference between two migration callback functions,
alloc_huge_page_node() and alloc_huge_page_nodemask(), except
__GFP_THISNODE handling. This patch moves this handling to
alloc_huge_page_nodemask() and function caller. Then, remove
alloc_huge_page_node().

Signed-off-by: Joonsoo Kim <iamjoonsoo.kim@lge.com>
---
 include/linux/hugetlb.h |  8 --------
 mm/hugetlb.c            | 23 ++---------------------
 mm/mempolicy.c          |  3 ++-
 3 files changed, 4 insertions(+), 30 deletions(-)

diff --git a/include/linux/hugetlb.h b/include/linux/hugetlb.h
index 15c8fb8..f482563 100644
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
index dabe460..8132985 100644
--- a/mm/hugetlb.c
+++ b/mm/hugetlb.c
@@ -1980,31 +1980,12 @@ struct page *alloc_buddy_huge_page_with_mpol(struct hstate *h,
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
+	if (ac->nid == NUMA_NO_NODE)
+		ac->gfp_mask &= ~__GFP_THISNODE;
 
 	spin_lock(&hugetlb_lock);
 	if (h->free_huge_pages - h->resv_huge_pages > 0) {
diff --git a/mm/mempolicy.c b/mm/mempolicy.c
index 3b6b551..e705efd 100644
--- a/mm/mempolicy.c
+++ b/mm/mempolicy.c
@@ -1073,9 +1073,10 @@ struct page *alloc_new_node_page(struct page *page, unsigned long node)
 		struct alloc_control ac = {
 			.nid = node,
 			.nmask = NULL,
+			.gfp_mask = __GFP_THISNODE,
 		};
 
-		return alloc_huge_page_node(h, &ac);
+		return alloc_huge_page_nodemask(h, &ac);
 	} else if (PageTransHuge(page)) {
 		struct page *thp;
 
-- 
2.7.4

