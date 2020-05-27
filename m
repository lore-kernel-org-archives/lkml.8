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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 79898C433E2
	for <linux-kernel@archiver.kernel.org>; Wed, 27 May 2020 06:46:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 58B6C2078C
	for <linux-kernel@archiver.kernel.org>; Wed, 27 May 2020 06:46:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="KsSlU8K3"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728998AbgE0GqS (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 27 May 2020 02:46:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57278 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728922AbgE0GqQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 May 2020 02:46:16 -0400
Received: from mail-pj1-x1041.google.com (mail-pj1-x1041.google.com [IPv6:2607:f8b0:4864:20::1041])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0B93DC061A0F
        for <linux-kernel@vger.kernel.org>; Tue, 26 May 2020 23:46:16 -0700 (PDT)
Received: by mail-pj1-x1041.google.com with SMTP id s69so1126884pjb.4
        for <linux-kernel@vger.kernel.org>; Tue, 26 May 2020 23:46:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=oCWTo8ae5wYqiJISS3BTEu3KhdtRS7foiClTJOTmPqk=;
        b=KsSlU8K3mDcBiOUAUkKkIwvhCMS4g9bfdCw4o4WsKIf22rLAtmHAXQsoHGN7UZz444
         R21H+Aulwtj2jNq0ihq4BvK1LveOWhyzf5yjzsHd0Zo3bDYryfRveYuTCk2EJq5WNmRg
         mQ1cCYr8mHA7FF7m7VDFgIwAa0GE4Egot9Vz0z25QFbeJQmxxRv8q18hYl3ie8Gia34l
         KAdgPWYYY/2frIOy3xexSVkyubLJYzSiWeRYQIfTG5FZ8EeKJbJp179ulCV6l8ukxiQV
         CB3WG8E2dZ+3XPJnoVKZSF6aob4zhGkX8MXaNpJa9NCVg6MrjwULuYdRNlyb/bHq5PB1
         ZFdw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=oCWTo8ae5wYqiJISS3BTEu3KhdtRS7foiClTJOTmPqk=;
        b=JDziRNMKPZqcC29kozxcMUJDg6DG/4/fmIsUecFaMguHEt+K6Z3vEh08BW27P3JzIF
         tIIQ4CL3o7hU7e2le6xwjjd4x3iw6JgGrwWvJlZzGwT3jfmtiZkVBcoFNsip/u5eXQwb
         h+0eZoE7qkFEA2sd5uRKUDoXJVk5csVjWIR2sI8JBiphax8P3+5UR8qystJQYJGi3Wgc
         7YPy6GA4a8R0zT8BbuMvVQVl68a7iqzEj7EcH9oNTjOjRL94FcnQK79Oxd1zxAuYL0pu
         Z4KGblmoQuybqAlk51LhjlIVRT6eRD7LDEZV7I7VW6PoCNjLzgHVW6gM0my+mb5f9RNn
         vV+g==
X-Gm-Message-State: AOAM530M4/tpWzWQ1uw2lvAJemcurCjAM0TyB7FQGCM6jzin6p64WDNz
        eSTlEFscvtkEE/nCwiIj7aU=
X-Google-Smtp-Source: ABdhPJw3jajYq9SthyVPEZGa8LUwP/TevuizPIaj1Sm2mwxn2apJlZMK7RQ7Em8i91cW9R3vjFwFAA==
X-Received: by 2002:a17:90a:2325:: with SMTP id f34mr3212211pje.91.1590561975534;
        Tue, 26 May 2020 23:46:15 -0700 (PDT)
Received: from localhost.localdomain ([114.206.198.176])
        by smtp.gmail.com with ESMTPSA id r13sm443883pgv.50.2020.05.26.23.46.12
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 26 May 2020 23:46:15 -0700 (PDT)
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
Subject: [PATCH v2 10/12] mm/gup: use standard migration target allocation function
Date:   Wed, 27 May 2020 15:45:01 +0900
Message-Id: <1590561903-13186-11-git-send-email-iamjoonsoo.kim@lge.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1590561903-13186-1-git-send-email-iamjoonsoo.kim@lge.com>
References: <1590561903-13186-1-git-send-email-iamjoonsoo.kim@lge.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Joonsoo Kim <iamjoonsoo.kim@lge.com>

There is no reason to implement it's own function for migration
target allocation. Use standard one.

Signed-off-by: Joonsoo Kim <iamjoonsoo.kim@lge.com>
---
 mm/gup.c | 61 ++++++++++---------------------------------------------------
 1 file changed, 10 insertions(+), 51 deletions(-)

diff --git a/mm/gup.c b/mm/gup.c
index a49d7ea..0e4214d 100644
--- a/mm/gup.c
+++ b/mm/gup.c
@@ -1593,58 +1593,16 @@ static bool check_dax_vmas(struct vm_area_struct **vmas, long nr_pages)
 }
 
 #ifdef CONFIG_CMA
-static struct page *new_non_cma_page(struct page *page,
+static struct page *alloc_migration_target_non_cma(struct page *page,
 				struct alloc_control *ac)
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
-	if (PageHuge(page)) {
-		struct hstate *h = page_hstate(page);
-		struct alloc_control ac = {
-			.nid = nid,
-			.nmask = NULL,
-			.gfp_mask = __GFP_NOWARN,
-			.skip_cma = true,
-		};
-
-		return alloc_huge_page_nodemask(h, &ac);
-	}
-
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
+	struct alloc_control __ac = {
+		.nid = page_to_nid(page),
+		.gfp_mask = GFP_USER | __GFP_NOWARN,
+		.skip_cma = true,
+	};
 
-	return __alloc_pages_node(nid, gfp_mask, 0);
+	return alloc_migration_target(page, &__ac);
 }
 
 static long check_and_migrate_cma_pages(struct task_struct *tsk,
@@ -1706,8 +1664,9 @@ static long check_and_migrate_cma_pages(struct task_struct *tsk,
 		for (i = 0; i < nr_pages; i++)
 			put_page(pages[i]);
 
-		if (migrate_pages(&cma_page_list, new_non_cma_page,
-				  NULL, NULL, MIGRATE_SYNC, MR_CONTIG_RANGE)) {
+		if (migrate_pages(&cma_page_list,
+				alloc_migration_target_non_cma, NULL, NULL,
+				MIGRATE_SYNC, MR_CONTIG_RANGE)) {
 			/*
 			 * some of the pages failed migration. Do get_user_pages
 			 * without migration.
-- 
2.7.4

