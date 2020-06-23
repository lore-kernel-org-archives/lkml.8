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
	by smtp.lore.kernel.org (Postfix) with ESMTP id D880FC433E1
	for <linux-kernel@archiver.kernel.org>; Tue, 23 Jun 2020 06:14:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id AF14F20772
	for <linux-kernel@archiver.kernel.org>; Tue, 23 Jun 2020 06:14:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="mJFf5ODp"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730972AbgFWGOr (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 23 Jun 2020 02:14:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34224 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730412AbgFWGOp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 Jun 2020 02:14:45 -0400
Received: from mail-pg1-x544.google.com (mail-pg1-x544.google.com [IPv6:2607:f8b0:4864:20::544])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2B685C061573
        for <linux-kernel@vger.kernel.org>; Mon, 22 Jun 2020 23:14:45 -0700 (PDT)
Received: by mail-pg1-x544.google.com with SMTP id e8so4148895pgc.5
        for <linux-kernel@vger.kernel.org>; Mon, 22 Jun 2020 23:14:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=QF5i+SE5gbif6Va56aYHUaIx3APq5EkmJc5AU12Pz8o=;
        b=mJFf5ODpBD9gu+7mDdXDz31TmMcHtiC98GFP0hobASpUDM4xOAyss2qOk0u5RA3vLJ
         yeaSEKxRfACslj6q4pzg6MmOMJs2Nk+7aZPOhWVGqx5exhF0U3izjuVbmwyKdFazHT4s
         2U/6UIyUKZcIVeZ5z2k8g8sogP7GynPjXPprlwFHDqpfrvWZ85mMQnqb0UfIgewT3XoH
         bmhmp0Lli5yp5t/j9X3q7YqkB/3eyenHxEtuUoxyx8cZrgl0u3/nMXSYtx+5OSEpq4gs
         suc+k+jfluaY78PMckMubgEE4tZ1hh8HPYKXugMiw6ZzUK/gnPkWy+R+ZfSkMh7HbEcz
         UCmQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=QF5i+SE5gbif6Va56aYHUaIx3APq5EkmJc5AU12Pz8o=;
        b=kzWHUYhOOzOyhYbKUL+biM81YvNTY7ULXkVB3HYJ0RtEpqqkuGCAnGNjfhzzWeuI88
         3VYSYEIV4GSNDSeQLFsT72ojFtU811zwVtTavWhlTc/VA8Bly66ZzVwWkMvCRrCe1PzJ
         WTV+HOkK7kUn9KlWZdp//4LkIvyRlc3SN4u/7XTQmgupcpwdChdq/WZrGO3yLaE4KZdc
         7C5tvaP0ghlKPdd3TUH6Eh8ZRpWUNb9CeObfxxKHrnSa8OwNsJ3jTGR5pS6PBUyIHPYb
         Q6XYQSmLq02+sAOutTnicNP0BiTQwya/DH4EienWyQjP0NQzSiVz7GdLrR0hEnuopjaw
         2JcA==
X-Gm-Message-State: AOAM530gWREeNU9m8GzSAYDdi63yqMVga5DD8ykZCGvZU9+jL0I3rjro
        uklHKd7Rl64dOP44jXtlNL4=
X-Google-Smtp-Source: ABdhPJwrMMzKL86HSk0nGtBbRa3gNPmTWuQbWt+R1Htn2k3+JEhVmmRornqm1es9r19YZtnhaZa3/g==
X-Received: by 2002:aa7:91d4:: with SMTP id z20mr22230280pfa.153.1592892884702;
        Mon, 22 Jun 2020 23:14:44 -0700 (PDT)
Received: from localhost.localdomain ([114.206.198.176])
        by smtp.gmail.com with ESMTPSA id m15sm12801093pgv.45.2020.06.22.23.14.41
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 22 Jun 2020 23:14:44 -0700 (PDT)
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
Subject: [PATCH v3 6/8] mm/gup: use a standard migration target allocation callback
Date:   Tue, 23 Jun 2020 15:13:46 +0900
Message-Id: <1592892828-1934-7-git-send-email-iamjoonsoo.kim@lge.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1592892828-1934-1-git-send-email-iamjoonsoo.kim@lge.com>
References: <1592892828-1934-1-git-send-email-iamjoonsoo.kim@lge.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Joonsoo Kim <iamjoonsoo.kim@lge.com>

There is a well-defined migration target allocation callback.
It's mostly similar with new_non_cma_page() except considering CMA pages.

This patch adds a CMA consideration to the standard migration target
allocation callback and use it on gup.c.

Signed-off-by: Joonsoo Kim <iamjoonsoo.kim@lge.com>
---
 mm/gup.c      | 57 ++++++++-------------------------------------------------
 mm/internal.h |  1 +
 mm/migrate.c  |  4 +++-
 3 files changed, 12 insertions(+), 50 deletions(-)

diff --git a/mm/gup.c b/mm/gup.c
index 15be281..f6124e3 100644
--- a/mm/gup.c
+++ b/mm/gup.c
@@ -1608,56 +1608,15 @@ static bool check_dax_vmas(struct vm_area_struct **vmas, long nr_pages)
 }
 
 #ifdef CONFIG_CMA
-static struct page *new_non_cma_page(struct page *page, unsigned long private)
+static struct page *alloc_migration_target_non_cma(struct page *page, unsigned long private)
 {
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
+	struct migration_target_control mtc = {
+		.nid = page_to_nid(page),
+		.gfp_mask = GFP_USER | __GFP_NOWARN,
+		.skip_cma = true,
+	};
 
-	return __alloc_pages_node(nid, gfp_mask, 0);
+	return alloc_migration_target(page, (unsigned long)&mtc);
 }
 
 static long check_and_migrate_cma_pages(struct task_struct *tsk,
@@ -1719,7 +1678,7 @@ static long check_and_migrate_cma_pages(struct task_struct *tsk,
 		for (i = 0; i < nr_pages; i++)
 			put_page(pages[i]);
 
-		if (migrate_pages(&cma_page_list, new_non_cma_page,
+		if (migrate_pages(&cma_page_list, alloc_migration_target_non_cma,
 				  NULL, 0, MIGRATE_SYNC, MR_CONTIG_RANGE)) {
 			/*
 			 * some of the pages failed migration. Do get_user_pages
diff --git a/mm/internal.h b/mm/internal.h
index f725aa8..fb7f7fe 100644
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
index 3afff59..7c4cd74 100644
--- a/mm/migrate.c
+++ b/mm/migrate.c
@@ -1550,7 +1550,7 @@ struct page *alloc_migration_target(struct page *page, unsigned long private)
 	if (PageHuge(page)) {
 		return alloc_huge_page_nodemask(
 				page_hstate(compound_head(page)), mtc->nid,
-				mtc->nmask, gfp_mask, false);
+				mtc->nmask, gfp_mask, mtc->skip_cma);
 	}
 
 	if (PageTransHuge(page)) {
@@ -1561,6 +1561,8 @@ struct page *alloc_migration_target(struct page *page, unsigned long private)
 	zidx = zone_idx(page_zone(page));
 	if (is_highmem_idx(zidx) || zidx == ZONE_MOVABLE)
 		gfp_mask |= __GFP_HIGHMEM;
+	if (mtc->skip_cma)
+		gfp_mask &= ~__GFP_MOVABLE;
 
 	new_page = __alloc_pages_nodemask(gfp_mask, order,
 				mtc->nid, mtc->nmask);
-- 
2.7.4

