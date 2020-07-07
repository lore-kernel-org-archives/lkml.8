Return-Path: <SRS0=aTFg=AS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B1B84C433E0
	for <linux-kernel@archiver.kernel.org>; Tue,  7 Jul 2020 07:45:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8F3EF20738
	for <linux-kernel@archiver.kernel.org>; Tue,  7 Jul 2020 07:45:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Zg+77soX"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728409AbgGGHpe (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 7 Jul 2020 03:45:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46216 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727116AbgGGHpd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Jul 2020 03:45:33 -0400
Received: from mail-pj1-x1044.google.com (mail-pj1-x1044.google.com [IPv6:2607:f8b0:4864:20::1044])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9741CC061755
        for <linux-kernel@vger.kernel.org>; Tue,  7 Jul 2020 00:45:33 -0700 (PDT)
Received: by mail-pj1-x1044.google.com with SMTP id md7so3039120pjb.1
        for <linux-kernel@vger.kernel.org>; Tue, 07 Jul 2020 00:45:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=+ALly2iCWh0BQrkDtphHPvmMGWbm0eTErSKhy81hot0=;
        b=Zg+77soXJbGPc0NLsJ1kxiqjpVafBKmMrM7OrBM/xlmVUcDE60zBLnfNUgGGVdVK2s
         0w8xvrmQ2Q0eJ+1i+W52IE020sATbBxP2fTnqWsjmH+UR82HhNYSeZaFZe/q3N3qyk6y
         n4mwItTqjvUKh7fE5iQQoRubyoBMRMOM0WUpaYxYeAR6GdVzsmBmJhfSvsCzvrUj+obn
         BKdPyYXDG2rNiso+K+HhOJh1dSGn92Yn29xep5Vfe+W9e0AsjcdosphSScN7ixuhtOUz
         zX0YQpzayUfiJ2AUgxgNL3yPUPW+yhfV26GKkKhdyLODcWkEqp5bgUDt1hWp2sa040i1
         ndeQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=+ALly2iCWh0BQrkDtphHPvmMGWbm0eTErSKhy81hot0=;
        b=lLhLz14ggYsHNylK1xAmgAOee2r9bnPqjp/J30Q9zAZFYxb/KTn0REAUNU2mM/wKzQ
         gnFLM+qnohkV3NK7KShNWfzA0qE4QPOYZrl96AP90XWq/hsWAgAD/P0OYUBz0K9urHYP
         5UDevX48RlEN3S/KEluxWUMtfi6DeUFfV+ViqNpOo0rpV1p3CnMpo4bF1g6QxvVCZBzz
         1c1Cca356LjpjoNXrDr/Zvyim47GLBrt7e/uSwGqr7+uZlPEN2YXoW+FiI+dwcgvEMfg
         emgjIFNbuw5XKhSrDd9F4iXMjd/4Zawvk8BxxmdvRqaL+/2/ka5gt7ghwZ9kA3aVi/NA
         gxYA==
X-Gm-Message-State: AOAM5331QDK/b3O+phDAmwr/3ysdbueExyg8/rMbNc9R/c+Izyt29URT
        bzz1Iwjxl0CDDYRyw3G2A7Q=
X-Google-Smtp-Source: ABdhPJwQlR9icSQ/ViMylCqjKeK8iBXZ5C6sPnSc8IPP0qMzT56rzVGFjpDNgYoarPioFStmVxlTbw==
X-Received: by 2002:a17:902:161:: with SMTP id 88mr16321361plb.325.1594107933119;
        Tue, 07 Jul 2020 00:45:33 -0700 (PDT)
Received: from localhost.localdomain ([114.206.198.176])
        by smtp.gmail.com with ESMTPSA id 191sm21330151pfw.150.2020.07.07.00.45.30
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 07 Jul 2020 00:45:32 -0700 (PDT)
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
Subject: [PATCH v4 07/11] mm/gup: use a standard migration target allocation callback
Date:   Tue,  7 Jul 2020 16:44:45 +0900
Message-Id: <1594107889-32228-8-git-send-email-iamjoonsoo.kim@lge.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1594107889-32228-1-git-send-email-iamjoonsoo.kim@lge.com>
References: <1594107889-32228-1-git-send-email-iamjoonsoo.kim@lge.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Joonsoo Kim <iamjoonsoo.kim@lge.com>

There is a well-defined migration target allocation callback.  It's mostly
similar with new_non_cma_page() except considering CMA pages.

This patch adds a CMA consideration to the standard migration target
allocation callback and use it on gup.c.

Acked-by: Vlastimil Babka <vbabka@suse.cz>
Signed-off-by: Joonsoo Kim <iamjoonsoo.kim@lge.com>
---
 mm/gup.c      | 61 +++++++----------------------------------------------------
 mm/internal.h |  1 +
 mm/migrate.c  |  9 ++++++++-
 3 files changed, 16 insertions(+), 55 deletions(-)

diff --git a/mm/gup.c b/mm/gup.c
index 2c3dab4..6a74c30 100644
--- a/mm/gup.c
+++ b/mm/gup.c
@@ -1608,58 +1608,6 @@ static bool check_dax_vmas(struct vm_area_struct **vmas, long nr_pages)
 }
 
 #ifdef CONFIG_CMA
-static struct page *new_non_cma_page(struct page *page, unsigned long private)
-{
-	/*
-	 * We want to make sure we allocate the new page from the same node
-	 * as the source page.
-	 */
-	int nid = page_to_nid(page);
-	/*
-	 * Trying to allocate a page for migration. Ignore allocation
-	 * failure warnings. We don't force __GFP_THISNODE here because
-	 * this node here is the node where we have CMA reservation and
-	 * in some case these nodes will have really less non movable
-	 * allocation memory.
-	 */
-	gfp_t gfp_mask = GFP_USER | __GFP_NOWARN;
-
-	if (PageHighMem(page))
-		gfp_mask |= __GFP_HIGHMEM;
-
-#ifdef CONFIG_HUGETLB_PAGE
-	if (PageHuge(page)) {
-		struct hstate *h = page_hstate(page);
-
-		/*
-		 * We don't want to dequeue from the pool because pool pages will
-		 * mostly be from the CMA region.
-		 */
-		return alloc_huge_page_nodemask(h, nid, NULL, gfp_mask, true);
-	}
-#endif
-	if (PageTransHuge(page)) {
-		struct page *thp;
-		/*
-		 * ignore allocation failure warnings
-		 */
-		gfp_t thp_gfpmask = GFP_TRANSHUGE | __GFP_NOWARN;
-
-		/*
-		 * Remove the movable mask so that we don't allocate from
-		 * CMA area again.
-		 */
-		thp_gfpmask &= ~__GFP_MOVABLE;
-		thp = __alloc_pages_node(nid, thp_gfpmask, HPAGE_PMD_ORDER);
-		if (!thp)
-			return NULL;
-		prep_transhuge_page(thp);
-		return thp;
-	}
-
-	return __alloc_pages_node(nid, gfp_mask, 0);
-}
-
 static long check_and_migrate_cma_pages(struct task_struct *tsk,
 					struct mm_struct *mm,
 					unsigned long start,
@@ -1674,6 +1622,11 @@ static long check_and_migrate_cma_pages(struct task_struct *tsk,
 	bool migrate_allow = true;
 	LIST_HEAD(cma_page_list);
 	long ret = nr_pages;
+	struct migration_target_control mtc = {
+		.nid = NUMA_NO_NODE,
+		.gfp_mask = GFP_USER | __GFP_NOWARN,
+		.skip_cma = true,
+	};
 
 check_again:
 	for (i = 0; i < nr_pages;) {
@@ -1719,8 +1672,8 @@ static long check_and_migrate_cma_pages(struct task_struct *tsk,
 		for (i = 0; i < nr_pages; i++)
 			put_page(pages[i]);
 
-		if (migrate_pages(&cma_page_list, new_non_cma_page,
-				  NULL, 0, MIGRATE_SYNC, MR_CONTIG_RANGE)) {
+		if (migrate_pages(&cma_page_list, alloc_migration_target, NULL,
+			(unsigned long)&mtc, MIGRATE_SYNC, MR_CONTIG_RANGE)) {
 			/*
 			 * some of the pages failed migration. Do get_user_pages
 			 * without migration.
diff --git a/mm/internal.h b/mm/internal.h
index 0beacf3..3236fef 100644
--- a/mm/internal.h
+++ b/mm/internal.h
@@ -619,6 +619,7 @@ struct migration_target_control {
 	int nid;		/* preferred node id */
 	nodemask_t *nmask;
 	gfp_t gfp_mask;
+	bool skip_cma;
 };
 
 #endif	/* __MM_INTERNAL_H */
diff --git a/mm/migrate.c b/mm/migrate.c
index 00cd81c..ab18b9c 100644
--- a/mm/migrate.c
+++ b/mm/migrate.c
@@ -1539,6 +1539,7 @@ struct page *alloc_migration_target(struct page *page, unsigned long private)
 	struct page *new_page = NULL;
 	int nid;
 	int zidx;
+	unsigned int flags = 0;
 
 	mtc = (struct migration_target_control *)private;
 	gfp_mask = mtc->gfp_mask;
@@ -1551,9 +1552,12 @@ struct page *alloc_migration_target(struct page *page, unsigned long private)
 
 		gfp_mask |= htlb_alloc_mask(h);
 		return alloc_huge_page_nodemask(h, nid, mtc->nmask,
-						gfp_mask, false);
+						gfp_mask, mtc->skip_cma);
 	}
 
+	if (mtc->skip_cma)
+		flags = memalloc_nocma_save();
+
 	if (PageTransHuge(page)) {
 		/*
 		 * clear __GFP_RECALIM since GFP_TRANSHUGE is the gfp_mask
@@ -1572,6 +1576,9 @@ struct page *alloc_migration_target(struct page *page, unsigned long private)
 	if (new_page && PageTransHuge(new_page))
 		prep_transhuge_page(new_page);
 
+	if (mtc->skip_cma)
+		memalloc_nocma_restore(flags);
+
 	return new_page;
 }
 
-- 
2.7.4

