Return-Path: <SRS0=EnQK=B5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A0B20C433DF
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Aug 2020 15:06:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6D42E20882
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Aug 2020 15:06:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="ffAW0f0D"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728727AbgHSPGL (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 19 Aug 2020 11:06:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56144 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726951AbgHSPGG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Aug 2020 11:06:06 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0AD45C061342
        for <linux-kernel@vger.kernel.org>; Wed, 19 Aug 2020 08:06:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:MIME-Version:
        References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:
        Content-Type:Content-ID:Content-Description;
        bh=Gkcnj4yhUWqPRu+2OkTCO03CnKySGnZw3mzNydBSfcA=; b=ffAW0f0D1d1omddPa5+aJNHjAc
        +5Lo/7IKLb/hX3GLdwhytr7L5hYgAjOTamc8h0qoDrNC0Ki3JOQYdndraV7OKyBt9D7S/PDeJh4Wl
        Jkdx7aCz0uGzDmFdi6T6EHGro+20pmkYU6wmLphhiLcTHilCxSJ7WPp778kxpm4a33mCgOrUKI0g1
        koPqTmVOv6vU5iVhfHnfnY7QEGRnoTKGPphGQQanHnEpKEZz9WGDi+D6Zz1Kb+xsGR/nRhuNEtVys
        oFWZRbeyr/wlvWQspEWFDef1bCB4lLudcVmBodmk6Dy9JzAVfGCyUTvcZZo9XjTjM30RQQdf5tznH
        Fed/gOSg==;
Received: from willy by casper.infradead.org with local (Exim 4.92.3 #3 (Red Hat Linux))
        id 1k8Pf4-0008Fm-VN; Wed, 19 Aug 2020 15:05:59 +0000
From:   "Matthew Wilcox (Oracle)" <willy@infradead.org>
To:     linux-mm@kvack.org
Cc:     "Matthew Wilcox (Oracle)" <willy@infradead.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Hugh Dickins <hughd@google.com>,
        William Kucharski <william.kucharski@oracle.com>,
        Johannes Weiner <hannes@cmpxchg.org>, Jan Kara <jack@suse.cz>,
        linux-kernel@vger.kernel.org
Subject: [PATCH 3/7] mm: Add an 'end' parameter to find_get_entries
Date:   Wed, 19 Aug 2020 16:05:51 +0100
Message-Id: <20200819150555.31669-4-willy@infradead.org>
X-Mailer: git-send-email 2.21.3
In-Reply-To: <20200819150555.31669-1-willy@infradead.org>
References: <20200819150555.31669-1-willy@infradead.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This simplifies the callers and leads to a more efficient implementation
since the XArray has this functionality already.

Signed-off-by: Matthew Wilcox (Oracle) <willy@infradead.org>
---
 include/linux/pagemap.h |  4 ++--
 mm/filemap.c            |  9 +++++----
 mm/shmem.c              | 10 ++++------
 mm/swap.c               |  2 +-
 4 files changed, 12 insertions(+), 13 deletions(-)

diff --git a/include/linux/pagemap.h b/include/linux/pagemap.h
index 7de11dcd534d..3f0dc8d00f2a 100644
--- a/include/linux/pagemap.h
+++ b/include/linux/pagemap.h
@@ -387,8 +387,8 @@ static inline struct page *find_subpage(struct page *head, pgoff_t index)
 struct page *find_get_entry(struct address_space *mapping, pgoff_t offset);
 struct page *find_lock_entry(struct address_space *mapping, pgoff_t offset);
 unsigned find_get_entries(struct address_space *mapping, pgoff_t start,
-			  unsigned int nr_entries, struct page **entries,
-			  pgoff_t *indices);
+		pgoff_t end, unsigned int nr_entries, struct page **entries,
+		pgoff_t *indices);
 unsigned find_get_pages_range(struct address_space *mapping, pgoff_t *start,
 			pgoff_t end, unsigned int nr_pages,
 			struct page **pages);
diff --git a/mm/filemap.c b/mm/filemap.c
index 1aaea26556cc..159cf3d6f1ae 100644
--- a/mm/filemap.c
+++ b/mm/filemap.c
@@ -1742,6 +1742,7 @@ EXPORT_SYMBOL(pagecache_get_page);
  * find_get_entries - gang pagecache lookup
  * @mapping:	The address_space to search
  * @start:	The starting page cache index
+ * @end:	The highest page cache index to return.
  * @nr_entries:	The maximum number of entries
  * @entries:	Where the resulting entries are placed
  * @indices:	The cache indices corresponding to the entries in @entries
@@ -1765,9 +1766,9 @@ EXPORT_SYMBOL(pagecache_get_page);
  *
  * Return: the number of pages and shadow entries which were found.
  */
-unsigned find_get_entries(struct address_space *mapping,
-			  pgoff_t start, unsigned int nr_entries,
-			  struct page **entries, pgoff_t *indices)
+unsigned find_get_entries(struct address_space *mapping, pgoff_t start,
+		pgoff_t end, unsigned int nr_entries, struct page **entries,
+		pgoff_t *indices)
 {
 	XA_STATE(xas, &mapping->i_pages, start);
 	struct page *page;
@@ -1777,7 +1778,7 @@ unsigned find_get_entries(struct address_space *mapping,
 		return 0;
 
 	rcu_read_lock();
-	xas_for_each(&xas, page, ULONG_MAX) {
+	xas_for_each(&xas, page, end) {
 		if (xas_retry(&xas, page))
 			continue;
 		/*
diff --git a/mm/shmem.c b/mm/shmem.c
index 0f9f149f4b5e..abdbe61a1aa7 100644
--- a/mm/shmem.c
+++ b/mm/shmem.c
@@ -906,9 +906,8 @@ static void shmem_undo_range(struct inode *inode, loff_t lstart, loff_t lend,
 	pagevec_init(&pvec);
 	index = start;
 	while (index < end) {
-		pvec.nr = find_get_entries(mapping, index,
-			min(end - index, (pgoff_t)PAGEVEC_SIZE),
-			pvec.pages, indices);
+		pvec.nr = find_get_entries(mapping, index, end - 1,
+				PAGEVEC_SIZE, pvec.pages, indices);
 		if (!pvec.nr)
 			break;
 		for (i = 0; i < pagevec_count(&pvec); i++) {
@@ -977,9 +976,8 @@ static void shmem_undo_range(struct inode *inode, loff_t lstart, loff_t lend,
 	while (index < end) {
 		cond_resched();
 
-		pvec.nr = find_get_entries(mapping, index,
-				min(end - index, (pgoff_t)PAGEVEC_SIZE),
-				pvec.pages, indices);
+		pvec.nr = find_get_entries(mapping, index, end - 1,
+				PAGEVEC_SIZE, pvec.pages, indices);
 		if (!pvec.nr) {
 			/* If all gone or hole-punch or unfalloc, we're done */
 			if (index == start || end != -1)
diff --git a/mm/swap.c b/mm/swap.c
index d16d65d9b4e0..fcf6ccb94b09 100644
--- a/mm/swap.c
+++ b/mm/swap.c
@@ -1060,7 +1060,7 @@ unsigned pagevec_lookup_entries(struct pagevec *pvec,
 				pgoff_t start, unsigned nr_entries,
 				pgoff_t *indices)
 {
-	pvec->nr = find_get_entries(mapping, start, nr_entries,
+	pvec->nr = find_get_entries(mapping, start, ULONG_MAX, nr_entries,
 				    pvec->pages, indices);
 	return pagevec_count(pvec);
 }
-- 
2.28.0

