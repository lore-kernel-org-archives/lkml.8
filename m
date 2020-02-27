Return-Path: <SRS0=BMk7=4P=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0799DC3F2C2
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Feb 2020 21:32:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D80F5246A1
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Feb 2020 21:32:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730050AbgB0Vcs (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 27 Feb 2020 16:32:48 -0500
Received: from shelob.surriel.com ([96.67.55.147]:46266 "EHLO
        shelob.surriel.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729974AbgB0Vcs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Feb 2020 16:32:48 -0500
Received: from imladris.surriel.com ([96.67.55.152])
        by shelob.surriel.com with esmtpsa (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256)
        (Exim 4.92.3)
        (envelope-from <riel@shelob.surriel.com>)
        id 1j7Qlq-0007O1-WC; Thu, 27 Feb 2020 16:32:39 -0500
From:   Rik van Riel <riel@surriel.com>
To:     linux-kernel@vger.kernel.org
Cc:     kernel-team@fb.com, akpm@linux-foundation.org, linux-mm@kvack.org,
        mhocko@kernel.org, vbabka@suse.cz, mgorman@techsingularity.net,
        rientjes@google.com, aarcange@redhat.com, ziy@nvidia.com,
        Rik van Riel <riel@surriel.com>
Subject: [PATCH v2 2/2] mm,thp,compaction,cma: allow THP migration for CMA allocations
Date:   Thu, 27 Feb 2020 16:32:29 -0500
Message-Id: <20200227213238.1298752-2-riel@surriel.com>
X-Mailer: git-send-email 2.24.1
In-Reply-To: <cover.1582321646.git.riel@surriel.com>
References: <cover.1582321646.git.riel@surriel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The code to implement THP migrations already exists, and the code
for CMA to clear out a region of memory already exists.

Only a few small tweaks are needed to allow CMA to move THP memory
when attempting an allocation from alloc_contig_range.

With these changes, migrating THPs from a CMA area works when
allocating a 1GB hugepage from CMA memory.

Signed-off-by: Rik van Riel <riel@surriel.com>
Reviewed-by: Zi Yan <ziy@nvidia.com>
---
 mm/compaction.c | 22 +++++++++++++---------
 mm/page_alloc.c |  9 +++++++--
 2 files changed, 20 insertions(+), 11 deletions(-)

diff --git a/mm/compaction.c b/mm/compaction.c
index 672d3c78c6ab..000ade085b89 100644
--- a/mm/compaction.c
+++ b/mm/compaction.c
@@ -894,12 +894,13 @@ isolate_migratepages_block(struct compact_control *cc, unsigned long low_pfn,
 
 		/*
 		 * Regardless of being on LRU, compound pages such as THP and
-		 * hugetlbfs are not to be compacted. We can potentially save
-		 * a lot of iterations if we skip them at once. The check is
-		 * racy, but we can consider only valid values and the only
-		 * danger is skipping too much.
+		 * hugetlbfs are not to be compacted unless we are attempting
+		 * an allocation much larger than the huge page size (eg CMA).
+		 * We can potentially save a lot of iterations if we skip them
+		 * at once. The check is racy, but we can consider only valid
+		 * values and the only danger is skipping too much.
 		 */
-		if (PageCompound(page)) {
+		if (PageCompound(page) && !cc->alloc_contig) {
 			const unsigned int order = compound_order(page);
 
 			if (likely(order < MAX_ORDER))
@@ -969,7 +970,7 @@ isolate_migratepages_block(struct compact_control *cc, unsigned long low_pfn,
 			 * and it's on LRU. It can only be a THP so the order
 			 * is safe to read and it's 0 for tail pages.
 			 */
-			if (unlikely(PageCompound(page))) {
+			if (unlikely(PageCompound(page) && !cc->alloc_contig)) {
 				low_pfn += compound_nr(page) - 1;
 				goto isolate_fail;
 			}
@@ -981,12 +982,15 @@ isolate_migratepages_block(struct compact_control *cc, unsigned long low_pfn,
 		if (__isolate_lru_page(page, isolate_mode) != 0)
 			goto isolate_fail;
 
-		VM_BUG_ON_PAGE(PageCompound(page), page);
+		/* The whole page is taken off the LRU; skip the tail pages. */
+		if (PageCompound(page))
+			low_pfn += compound_nr(page) - 1;
 
 		/* Successfully isolated */
 		del_page_from_lru_list(page, lruvec, page_lru(page));
-		inc_node_page_state(page,
-				NR_ISOLATED_ANON + page_is_file_cache(page));
+		mod_node_page_state(page_pgdat(page),
+				NR_ISOLATED_ANON + page_is_file_cache(page),
+				hpage_nr_pages(page));
 
 isolate_success:
 		list_add(&page->lru, &cc->migratepages);
diff --git a/mm/page_alloc.c b/mm/page_alloc.c
index a36736812596..6257c849cc00 100644
--- a/mm/page_alloc.c
+++ b/mm/page_alloc.c
@@ -8253,14 +8253,19 @@ struct page *has_unmovable_pages(struct zone *zone, struct page *page,
 
 		/*
 		 * Hugepages are not in LRU lists, but they're movable.
+		 * THPs are on the LRU, but need to be counted as #small pages.
 		 * We need not scan over tail pages because we don't
 		 * handle each tail page individually in migration.
 		 */
-		if (PageHuge(page)) {
+		if (PageHuge(page) || PageTransCompound(page)) {
 			struct page *head = compound_head(page);
 			unsigned int skip_pages;
 
-			if (!hugepage_migration_supported(page_hstate(head)))
+			if (PageHuge(page) &&
+			    !hugepage_migration_supported(page_hstate(head)))
+				return page;
+
+			if (!PageLRU(head) && !__PageMovable(head))
 				return page;
 
 			skip_pages = compound_nr(head) - (page - head);
-- 
2.24.1

