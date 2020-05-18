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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4BC0AC433E4
	for <linux-kernel@archiver.kernel.org>; Mon, 18 May 2020 01:22:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2ADCA207BB
	for <linux-kernel@archiver.kernel.org>; Mon, 18 May 2020 01:22:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="TuGN6hvO"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727873AbgERBWU (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 17 May 2020 21:22:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47882 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727122AbgERBWJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 17 May 2020 21:22:09 -0400
Received: from mail-pg1-x542.google.com (mail-pg1-x542.google.com [IPv6:2607:f8b0:4864:20::542])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2392EC061A0C
        for <linux-kernel@vger.kernel.org>; Sun, 17 May 2020 18:22:09 -0700 (PDT)
Received: by mail-pg1-x542.google.com with SMTP id c75so3065907pga.3
        for <linux-kernel@vger.kernel.org>; Sun, 17 May 2020 18:22:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=hSmTRtwjBP1ZZownFG4HBeG6KLnsrTJB9GY/Fcznxzc=;
        b=TuGN6hvOEpkfqCs4Mvgl/vl8r+hMnu+bB+x9wBx+9bEp99DAdm6X8DZvpyWGMysK6v
         /a2//CE3tJV7QOfl68+JpvvSaiWYsBK5QKtenLwI9T3PfkxzRFAsmDi9A2LwYliCz6NQ
         FBlBWw78UvlD6iM4YTL+ZUBw2dJVxXSRp8Zk5MceYVwwqD/yvQ0V09whKPIbKyF7As5R
         udmPfK3hOaR+GxQVHDwnypOFO6AwuNFMUjFJQURv/38bBvLvFQBhCSz2159A/v7pp90R
         oyWkR3CXI0eWEdOb7Zsp7GlTYy7PWNwLc4mK6SCXDL2uWiYMB3hhK8Gu117NzaON1ftT
         iNQw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=hSmTRtwjBP1ZZownFG4HBeG6KLnsrTJB9GY/Fcznxzc=;
        b=ekWRGowVCmssKI7GuFvCdOE5CJtJkDKlKolwKMV/Gen/LHsE7KISqUc30XNIxZFwtx
         pVvTruwWr/UYBXb1nB60sm8NfKs/IEVKv+gnEQEI8Qq2L/wCyW/Um0oqiEWi0sGNp9T6
         5Tue2GNZS6YMqS392UgvZTPYzdVdRwQwK0Bj+c511CjV2GQtUrTwbrZnhB0SJJ75MSh0
         mewMABkja7BQOAeNObYpbXqcE0EjjBItj1jDLUoWsJX89apx27uEy5iCteBSOpZ0JBUu
         wh5EPGjEJ8RaR+Uzq/oNdYHvQQ2qmSwWvpka8DHrT4BkNyPnRqb4bzo3jjfJya73SaXo
         PkBA==
X-Gm-Message-State: AOAM532EGNAsS7RbYUsL0f4Qpleiy5r2kZttd6Z5CBHl4eW/FUr2d9hA
        R0odHbRv1kb51RESzF8MxFU=
X-Google-Smtp-Source: ABdhPJwdffOTCzgAHEOzll3Uppf9LzYDzLMemDkCIRp0Bxicgs2qNDjNkDk572iKIGCGbwWZuGngjQ==
X-Received: by 2002:a63:5209:: with SMTP id g9mr12546532pgb.162.1589764928658;
        Sun, 17 May 2020 18:22:08 -0700 (PDT)
Received: from localhost.localdomain ([114.206.198.176])
        by smtp.gmail.com with ESMTPSA id fw4sm1544376pjb.31.2020.05.17.18.22.05
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 17 May 2020 18:22:08 -0700 (PDT)
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
Subject: [PATCH 09/11] mm/gup: use standard migration target allocation function
Date:   Mon, 18 May 2020 10:20:55 +0900
Message-Id: <1589764857-6800-10-git-send-email-iamjoonsoo.kim@lge.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1589764857-6800-1-git-send-email-iamjoonsoo.kim@lge.com>
References: <1589764857-6800-1-git-send-email-iamjoonsoo.kim@lge.com>
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
index be9cb79..d88a965 100644
--- a/mm/gup.c
+++ b/mm/gup.c
@@ -1594,58 +1594,16 @@ static bool check_dax_vmas(struct vm_area_struct **vmas, long nr_pages)
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
@@ -1707,8 +1665,9 @@ static long check_and_migrate_cma_pages(struct task_struct *tsk,
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

