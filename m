Return-Path: <SRS0=S/iQ=BK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B99C3C433DF
	for <linux-kernel@archiver.kernel.org>; Fri, 31 Jul 2020 07:35:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 92095206FA
	for <linux-kernel@archiver.kernel.org>; Fri, 31 Jul 2020 07:35:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="p6cjWGM7"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731714AbgGaHfi (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 31 Jul 2020 03:35:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43478 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731706AbgGaHfh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 31 Jul 2020 03:35:37 -0400
Received: from mail-pl1-x643.google.com (mail-pl1-x643.google.com [IPv6:2607:f8b0:4864:20::643])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 910E1C061574
        for <linux-kernel@vger.kernel.org>; Fri, 31 Jul 2020 00:35:37 -0700 (PDT)
Received: by mail-pl1-x643.google.com with SMTP id u10so7129010plr.7
        for <linux-kernel@vger.kernel.org>; Fri, 31 Jul 2020 00:35:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=fz5EvzWcsoicVDmNg73Hue/6iS5qANYWrgBKFYsm2Zk=;
        b=p6cjWGM7sl0zlXQANnmmK2pluQpa12wDI/791cNq4b6MOShBvRCZEEQP5DIXgqJV0h
         iWDU5I3sKZxfLbmoY372/fADoK6qr8ExQ/vRQn0yY3Jd4sqp+wWissRwbrRH7pYk/zS+
         dfTaKuQYwhLBINAUDVvGbB2uWnSKfpDpWKsNU4G5T7VrHHCB3/oR/ynoPeDn9DKENrlN
         9xli6W4OdNu9V8Fpiu48wkcjFiiM8LZUMgxrsYMXkjvSuWjWYp0gYPEsQJz6Ivlnr2gf
         p4036Fpz9ulmfypc1Zq0KpvVy33oV1M0RWf5UhSrFPmwV5v1aGOXrQBwN47VSYZnhA0Y
         C3Vw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=fz5EvzWcsoicVDmNg73Hue/6iS5qANYWrgBKFYsm2Zk=;
        b=GtRKFha1mrKHqiLGjVbEF8qOVZsan8Cx6A2677VyhxTpRhKfxhjR0NGhiJj0EOx7Sr
         8P/Lh8CCKjwkFmgG0RYWPpSn9ybv+fCMaRxJLk5yagA/M6bDhBTYJS43bQ80pGUdfPJW
         W/fxvXMe2vkELdhYQbBaOfYeO1zsF5qpkUORHuhxRTh27FPW5y8UvCYIUuzJS7yqkxLF
         21lH5LekAxJhCkK6Zlv8QYu/SeuSFZlhczs79zZu/uxqW/YUlqGf1ipVWqUKvQIIjz4T
         zD6APx8A12Cx2KCeIhMhMMDNRYYqisq4yvzd0mvMm/AQfzvXsVkQVS7RXEV4O9YILOmD
         OiKw==
X-Gm-Message-State: AOAM530K1ir+IAkfPLmEXIV0zqVEbXLIFZoeeX3uSL5O01EI535aNZGT
        2YRIqQ7oJ6wzJ2fBaK7/HsM=
X-Google-Smtp-Source: ABdhPJzpHCy21D2TSln0lf0yWFRkxFEHawCHi92eFry8Gc2RG7tB3k+D/dChftMGTjry5R/agH4Ufw==
X-Received: by 2002:a17:90b:46c1:: with SMTP id jx1mr2972537pjb.125.1596180937167;
        Fri, 31 Jul 2020 00:35:37 -0700 (PDT)
Received: from localhost.localdomain ([114.206.198.176])
        by smtp.gmail.com with ESMTPSA id 13sm8355522pfp.3.2020.07.31.00.35.33
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 31 Jul 2020 00:35:36 -0700 (PDT)
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
Subject: [PATCH v3 3/3] mm/gup: use a standard migration target allocation callback
Date:   Fri, 31 Jul 2020 16:35:06 +0900
Message-Id: <1596180906-8442-3-git-send-email-iamjoonsoo.kim@lge.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1596180906-8442-1-git-send-email-iamjoonsoo.kim@lge.com>
References: <1596180906-8442-1-git-send-email-iamjoonsoo.kim@lge.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Joonsoo Kim <iamjoonsoo.kim@lge.com>

There is a well-defined migration target allocation callback. Use it.

Acked-by: Vlastimil Babka <vbabka@suse.cz>
Acked-by: Michal Hocko <mhocko@suse.com>
Signed-off-by: Joonsoo Kim <iamjoonsoo.kim@lge.com>
---
 mm/gup.c | 54 ++++++------------------------------------------------
 1 file changed, 6 insertions(+), 48 deletions(-)

diff --git a/mm/gup.c b/mm/gup.c
index 7b63d72..ae096ea 100644
--- a/mm/gup.c
+++ b/mm/gup.c
@@ -1590,52 +1590,6 @@ static bool check_dax_vmas(struct vm_area_struct **vmas, long nr_pages)
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
-	 * in some case these nodes will have really less non CMA
-	 * allocation memory.
-	 *
-	 * Note that CMA region is prohibited by allocation scope.
-	 */
-	gfp_t gfp_mask = GFP_USER | __GFP_MOVABLE | __GFP_NOWARN;
-
-	if (PageHighMem(page))
-		gfp_mask |= __GFP_HIGHMEM;
-
-#ifdef CONFIG_HUGETLB_PAGE
-	if (PageHuge(page)) {
-		struct hstate *h = page_hstate(page);
-
-		gfp_mask = htlb_modify_alloc_mask(h, gfp_mask);
-		return alloc_huge_page_nodemask(h, nid, NULL, gfp_mask);
-	}
-#endif
-	if (PageTransHuge(page)) {
-		struct page *thp;
-		/*
-		 * ignore allocation failure warnings
-		 */
-		gfp_t thp_gfpmask = GFP_TRANSHUGE | __GFP_NOWARN;
-
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
 static long check_and_migrate_cma_pages(struct mm_struct *mm,
 					unsigned long start,
 					unsigned long nr_pages,
@@ -1649,6 +1603,10 @@ static long check_and_migrate_cma_pages(struct mm_struct *mm,
 	bool migrate_allow = true;
 	LIST_HEAD(cma_page_list);
 	long ret = nr_pages;
+	struct migration_target_control mtc = {
+		.nid = NUMA_NO_NODE,
+		.gfp_mask = GFP_USER | __GFP_MOVABLE | __GFP_NOWARN,
+	};
 
 check_again:
 	for (i = 0; i < nr_pages;) {
@@ -1694,8 +1652,8 @@ static long check_and_migrate_cma_pages(struct mm_struct *mm,
 		for (i = 0; i < nr_pages; i++)
 			put_page(pages[i]);
 
-		if (migrate_pages(&cma_page_list, new_non_cma_page,
-				  NULL, 0, MIGRATE_SYNC, MR_CONTIG_RANGE)) {
+		if (migrate_pages(&cma_page_list, alloc_migration_target, NULL,
+			(unsigned long)&mtc, MIGRATE_SYNC, MR_CONTIG_RANGE)) {
 			/*
 			 * some of the pages failed migration. Do get_user_pages
 			 * without migration.
-- 
2.7.4

