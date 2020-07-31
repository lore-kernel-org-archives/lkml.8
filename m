Return-Path: <SRS0=S/iQ=BK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3A773C433E0
	for <linux-kernel@archiver.kernel.org>; Fri, 31 Jul 2020 07:35:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 10A302067D
	for <linux-kernel@archiver.kernel.org>; Fri, 31 Jul 2020 07:35:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="BTCzKe1Y"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731698AbgGaHfb (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 31 Jul 2020 03:35:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43458 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727851AbgGaHfa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 31 Jul 2020 03:35:30 -0400
Received: from mail-pj1-x1044.google.com (mail-pj1-x1044.google.com [IPv6:2607:f8b0:4864:20::1044])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5D122C061574
        for <linux-kernel@vger.kernel.org>; Fri, 31 Jul 2020 00:35:30 -0700 (PDT)
Received: by mail-pj1-x1044.google.com with SMTP id a9so6595618pjd.3
        for <linux-kernel@vger.kernel.org>; Fri, 31 Jul 2020 00:35:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=nTOeh5fqlwQsgY4OnS7FbOZYYXYJ7FGvJ4/opw7eMkY=;
        b=BTCzKe1YYfaTHDlc9k551SWHQ5bhsQrRZLQ4ItO6c0Lxb9vpjV++4UhTzAha+D19yD
         wAFKf2kq4hz0mpMPb3xP6J5fdEmb7rbzJ8lTRmAs1W+HWx1/sNnkgEIeJZfapSE03T7F
         uzfl/2+kQ3ArdKnROBH1Dma7X/3TQQotb4X6UTGOccDl2X3+uv0yriYPDBd2Js82a0cv
         S6vqI/OvkovTyMX/0v3XnsvokBcEN7BslHI8er43XMNLcnZN1XIyhYWc+g/k1a8a2n7N
         DG1DVqRmoZ6NjLrxhkOq6zYax1J5EnstY/xQYC2q815pLeV+7fZpCSUnYhnTIBg8Mpj1
         uOZw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=nTOeh5fqlwQsgY4OnS7FbOZYYXYJ7FGvJ4/opw7eMkY=;
        b=r0ljxrNLuD4I22VfaN1TUINnWaRkcqTFYdadAElbFSwVEw4UAjBOHpmBYoTmRBUYDq
         EyEKPf4o++DMLuXXsBs7R6XfMzJhZxSkgViLuIzSE2z6mSUO3tIxdj0D/q7LvIGxE+Vv
         ey8X23Mdxbb543xkD/+m9GJ4l3dqTUV9Tq33z2yBh8HZjhXk5rFieNwI1KXnqVqZFF3P
         mu+kU+urV1N04VtS6s4JGv1bP4mkoS8hiEFX/fRSyJrHxwmULluchYx/ZDG0/ePcwLk8
         1X+E/gVQEecXGeaYZYHqLsVJOY4ajvIi6FoL+XohdvZkg7XTjxOn3t4vAODr3XuTVVMt
         CeUA==
X-Gm-Message-State: AOAM533tTB8Tm7OF0rqit4vOhybxPSKGqe5uY5Op3W2uieNGhZyXpZuo
        y/H2bFnGF9U48f+squkGVDM=
X-Google-Smtp-Source: ABdhPJzMO3GCZ8fVbA39QgF045FZzZbELKbPceky+/2okq6PdkJjF56KezF8TKN24LjjFAvuXD3/2g==
X-Received: by 2002:a17:902:b685:: with SMTP id c5mr2576130pls.115.1596180929852;
        Fri, 31 Jul 2020 00:35:29 -0700 (PDT)
Received: from localhost.localdomain ([114.206.198.176])
        by smtp.gmail.com with ESMTPSA id 13sm8355522pfp.3.2020.07.31.00.35.26
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 31 Jul 2020 00:35:29 -0700 (PDT)
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
        "Aneesh Kumar K . V" <aneesh.kumar@linux.ibm.com>,
        Joonsoo Kim <iamjoonsoo.kim@lge.com>
Subject: [PATCH v3 1/3] mm/gup: restrict CMA region by using allocation scope API
Date:   Fri, 31 Jul 2020 16:35:04 +0900
Message-Id: <1596180906-8442-1-git-send-email-iamjoonsoo.kim@lge.com>
X-Mailer: git-send-email 2.7.4
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Joonsoo Kim <iamjoonsoo.kim@lge.com>

We have well defined scope API to exclude CMA region.
Use it rather than manipulating gfp_mask manually. With this change,
we can now restore __GFP_MOVABLE for gfp_mask like as usual migration
target allocation. It would result in that the ZONE_MOVABLE is also
searched by page allocator. For hugetlb, gfp_mask is redefined since
it has a regular allocation mask filter for migration target.
__GPF_NOWARN is added to hugetlb gfp_mask filter since a new user for
gfp_mask filter, gup, want to be silent when allocation fails.

Note that this can be considered as a fix for the commit 9a4e9f3b2d73
("mm: update get_user_pages_longterm to migrate pages allocated from
CMA region"). However, "Fixes" tag isn't added here since it is just
suboptimal but it doesn't cause any problem.

Suggested-by: Michal Hocko <mhocko@suse.com>
Signed-off-by: Joonsoo Kim <iamjoonsoo.kim@lge.com>
---
 include/linux/hugetlb.h |  2 ++
 mm/gup.c                | 17 ++++++++---------
 2 files changed, 10 insertions(+), 9 deletions(-)

diff --git a/include/linux/hugetlb.h b/include/linux/hugetlb.h
index 6b9508d..2660b04 100644
--- a/include/linux/hugetlb.h
+++ b/include/linux/hugetlb.h
@@ -708,6 +708,8 @@ static inline gfp_t htlb_modify_alloc_mask(struct hstate *h, gfp_t gfp_mask)
 	/* Some callers might want to enfoce node */
 	modified_mask |= (gfp_mask & __GFP_THISNODE);
 
+	modified_mask |= (gfp_mask & __GFP_NOWARN);
+
 	return modified_mask;
 }
 
diff --git a/mm/gup.c b/mm/gup.c
index a55f1ec..3990ddc 100644
--- a/mm/gup.c
+++ b/mm/gup.c
@@ -1601,10 +1601,12 @@ static struct page *new_non_cma_page(struct page *page, unsigned long private)
 	 * Trying to allocate a page for migration. Ignore allocation
 	 * failure warnings. We don't force __GFP_THISNODE here because
 	 * this node here is the node where we have CMA reservation and
-	 * in some case these nodes will have really less non movable
+	 * in some case these nodes will have really less non CMA
 	 * allocation memory.
+	 *
+	 * Note that CMA region is prohibited by allocation scope.
 	 */
-	gfp_t gfp_mask = GFP_USER | __GFP_NOWARN;
+	gfp_t gfp_mask = GFP_USER | __GFP_MOVABLE | __GFP_NOWARN;
 
 	if (PageHighMem(page))
 		gfp_mask |= __GFP_HIGHMEM;
@@ -1612,6 +1614,8 @@ static struct page *new_non_cma_page(struct page *page, unsigned long private)
 #ifdef CONFIG_HUGETLB_PAGE
 	if (PageHuge(page)) {
 		struct hstate *h = page_hstate(page);
+
+		gfp_mask = htlb_modify_alloc_mask(h, gfp_mask);
 		/*
 		 * We don't want to dequeue from the pool because pool pages will
 		 * mostly be from the CMA region.
@@ -1626,11 +1630,6 @@ static struct page *new_non_cma_page(struct page *page, unsigned long private)
 		 */
 		gfp_t thp_gfpmask = GFP_TRANSHUGE | __GFP_NOWARN;
 
-		/*
-		 * Remove the movable mask so that we don't allocate from
-		 * CMA area again.
-		 */
-		thp_gfpmask &= ~__GFP_MOVABLE;
 		thp = __alloc_pages_node(nid, thp_gfpmask, HPAGE_PMD_ORDER);
 		if (!thp)
 			return NULL;
@@ -1773,7 +1772,6 @@ static long __gup_longterm_locked(struct mm_struct *mm,
 				     vmas_tmp, NULL, gup_flags);
 
 	if (gup_flags & FOLL_LONGTERM) {
-		memalloc_nocma_restore(flags);
 		if (rc < 0)
 			goto out;
 
@@ -1786,9 +1784,10 @@ static long __gup_longterm_locked(struct mm_struct *mm,
 
 		rc = check_and_migrate_cma_pages(mm, start, rc, pages,
 						 vmas_tmp, gup_flags);
+out:
+		memalloc_nocma_restore(flags);
 	}
 
-out:
 	if (vmas_tmp != vmas)
 		kfree(vmas_tmp);
 	return rc;
-- 
2.7.4

