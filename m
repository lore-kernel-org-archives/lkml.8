Return-Path: <SRS0=LUA0=7L=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5F3BBC433E0
	for <linux-kernel@archiver.kernel.org>; Fri, 29 May 2020 03:01:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3076D2075A
	for <linux-kernel@archiver.kernel.org>; Fri, 29 May 2020 03:01:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="GHVHWUzj"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390165AbgE2DBY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 28 May 2020 23:01:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46036 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2407175AbgE2C6i (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 May 2020 22:58:38 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:e::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D11C5C0A88B4;
        Thu, 28 May 2020 19:58:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=Content-Transfer-Encoding:
        MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender
        :Reply-To:Content-Type:Content-ID:Content-Description;
        bh=3hjPUrs+sThnhjJWoFR0hPXPZx64xJlitsYvYMC+qXI=; b=GHVHWUzjU0uUofHjhDU1jgwhre
        Y4pGON3FePJIeKdymTFCQjWQu05F1wpXVCSh9d5GEdItHl6Aj9sOVKJHi9NcN0DfPbpj1JZMNGOxC
        gC5RqqREX3sKOLt2Cy4Th3dJh1Anyh7k9PNQn/ZxLzR6Whluwd+7+1cNkHHtY05J4ks3U5am4qELL
        P4rfGMtntcH5XfcFChpxdy/GGBUIa5x5PoasSGYR4N+Y4TcFMEkL7Rz1r03Pyq8dUdIDzV2RHIBkI
        liXGGpbMdwMsuWsegSV3bHZDGMXQN0CDP/9B6AeUkEUQNqcCm1aFepIEVCYga8yNLM0uZjXpRTb8A
        yKc1E6AQ==;
Received: from willy by bombadil.infradead.org with local (Exim 4.92.3 #3 (Red Hat Linux))
        id 1jeVE3-0008Sl-Jl; Fri, 29 May 2020 02:58:27 +0000
From:   Matthew Wilcox <willy@infradead.org>
To:     linux-fsdevel@vger.kernel.org
Cc:     "Matthew Wilcox (Oracle)" <willy@infradead.org>,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org
Subject: [PATCH v5 27/39] mm: Remove assumptions of THP size
Date:   Thu, 28 May 2020 19:58:12 -0700
Message-Id: <20200529025824.32296-28-willy@infradead.org>
X-Mailer: git-send-email 2.21.1
In-Reply-To: <20200529025824.32296-1-willy@infradead.org>
References: <20200529025824.32296-1-willy@infradead.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: "Matthew Wilcox (Oracle)" <willy@infradead.org>

Remove direct uses of HPAGE_PMD_NR in paths that aren't necessarily
PMD sized.

Signed-off-by: Matthew Wilcox (Oracle) <willy@infradead.org>
---
 mm/huge_memory.c | 15 ++++++++-------
 mm/rmap.c        | 10 +++++-----
 2 files changed, 13 insertions(+), 12 deletions(-)

diff --git a/mm/huge_memory.c b/mm/huge_memory.c
index 15a86b06befc..4c4f92349829 100644
--- a/mm/huge_memory.c
+++ b/mm/huge_memory.c
@@ -2518,7 +2518,7 @@ static void remap_page(struct page *page)
 	if (PageTransHuge(page)) {
 		remove_migration_ptes(page, page, true);
 	} else {
-		for (i = 0; i < HPAGE_PMD_NR; i++)
+		for (i = 0; i < hpage_nr_pages(page); i++)
 			remove_migration_ptes(page + i, page + i, true);
 	}
 }
@@ -2593,6 +2593,7 @@ static void __split_huge_page(struct page *page, struct list_head *list,
 	struct lruvec *lruvec;
 	struct address_space *swap_cache = NULL;
 	unsigned long offset = 0;
+	unsigned int nr = hpage_nr_pages(head);
 	int i;
 
 	lruvec = mem_cgroup_page_lruvec(head, pgdat);
@@ -2608,7 +2609,7 @@ static void __split_huge_page(struct page *page, struct list_head *list,
 		xa_lock(&swap_cache->i_pages);
 	}
 
-	for (i = HPAGE_PMD_NR - 1; i >= 1; i--) {
+	for (i = nr - 1; i >= 1; i--) {
 		__split_huge_page_tail(head, i, lruvec, list);
 		/* Some pages can be beyond i_size: drop them from page cache */
 		if (head[i].index >= end) {
@@ -2649,7 +2650,7 @@ static void __split_huge_page(struct page *page, struct list_head *list,
 
 	remap_page(head);
 
-	for (i = 0; i < HPAGE_PMD_NR; i++) {
+	for (i = 0; i < nr; i++) {
 		struct page *subpage = head + i;
 		if (subpage == page)
 			continue;
@@ -2731,14 +2732,14 @@ int page_trans_huge_mapcount(struct page *page, int *total_mapcount)
 	page = compound_head(page);
 
 	_total_mapcount = ret = 0;
-	for (i = 0; i < HPAGE_PMD_NR; i++) {
+	for (i = 0; i < hpage_nr_pages(page); i++) {
 		mapcount = atomic_read(&page[i]._mapcount) + 1;
 		ret = max(ret, mapcount);
 		_total_mapcount += mapcount;
 	}
 	if (PageDoubleMap(page)) {
 		ret -= 1;
-		_total_mapcount -= HPAGE_PMD_NR;
+		_total_mapcount -= hpage_nr_pages(page);
 	}
 	mapcount = compound_mapcount(page);
 	ret += mapcount;
@@ -2755,9 +2756,9 @@ bool can_split_huge_page(struct page *page, int *pextra_pins)
 
 	/* Additional pins from page cache */
 	if (PageAnon(page))
-		extra_pins = PageSwapCache(page) ? HPAGE_PMD_NR : 0;
+		extra_pins = PageSwapCache(page) ? hpage_nr_pages(page) : 0;
 	else
-		extra_pins = HPAGE_PMD_NR;
+		extra_pins = hpage_nr_pages(page);
 	if (pextra_pins)
 		*pextra_pins = extra_pins;
 	return total_mapcount(page) == page_count(page) - extra_pins - 1;
diff --git a/mm/rmap.c b/mm/rmap.c
index f79a206b271a..9da4b5121baa 100644
--- a/mm/rmap.c
+++ b/mm/rmap.c
@@ -1199,7 +1199,7 @@ void page_add_file_rmap(struct page *page, bool compound)
 	VM_BUG_ON_PAGE(compound && !PageTransHuge(page), page);
 	lock_page_memcg(page);
 	if (compound && PageTransHuge(page)) {
-		for (i = 0, nr = 0; i < HPAGE_PMD_NR; i++) {
+		for (i = 0, nr = 0; i < hpage_nr_pages(page); i++) {
 			if (atomic_inc_and_test(&page[i]._mapcount))
 				nr++;
 		}
@@ -1241,7 +1241,7 @@ static void page_remove_file_rmap(struct page *page, bool compound)
 
 	/* page still mapped by someone else? */
 	if (compound && PageTransHuge(page)) {
-		for (i = 0, nr = 0; i < HPAGE_PMD_NR; i++) {
+		for (i = 0, nr = 0; i < hpage_nr_pages(page); i++) {
 			if (atomic_add_negative(-1, &page[i]._mapcount))
 				nr++;
 		}
@@ -1290,7 +1290,7 @@ static void page_remove_anon_compound_rmap(struct page *page)
 		 * Subpages can be mapped with PTEs too. Check how many of
 		 * them are still mapped.
 		 */
-		for (i = 0, nr = 0; i < HPAGE_PMD_NR; i++) {
+		for (i = 0, nr = 0; i < hpage_nr_pages(page); i++) {
 			if (atomic_add_negative(-1, &page[i]._mapcount))
 				nr++;
 		}
@@ -1300,10 +1300,10 @@ static void page_remove_anon_compound_rmap(struct page *page)
 		 * page of the compound page is unmapped, but at least one
 		 * small page is still mapped.
 		 */
-		if (nr && nr < HPAGE_PMD_NR)
+		if (nr && nr < hpage_nr_pages(page))
 			deferred_split_huge_page(page);
 	} else {
-		nr = HPAGE_PMD_NR;
+		nr = hpage_nr_pages(page);
 	}
 
 	if (unlikely(PageMlocked(page)))
-- 
2.26.2

