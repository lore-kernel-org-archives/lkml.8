Return-Path: <SRS0=EnQK=B5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4D65FC433E1
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Aug 2020 15:06:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2519A20885
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Aug 2020 15:06:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="cx0kbIBX"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728746AbgHSPGc (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 19 Aug 2020 11:06:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56154 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728705AbgHSPGI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Aug 2020 11:06:08 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A1424C061342
        for <linux-kernel@vger.kernel.org>; Wed, 19 Aug 2020 08:06:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:MIME-Version:
        References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:
        Content-Type:Content-ID:Content-Description;
        bh=TSamiOhG2S3AH0N4Z2wiaep3ZhVXUV1KTlhMVzss2SA=; b=cx0kbIBXbS1sJsc7muQXiVH2Ae
        WK+c4NxORyCOq2xtIpaA6ykb3izA3RzxuI8qFYl5CDQTQkKTOLb+x/65Gqk0Y4RHbcha8h335WL+B
        4VQQAa/ypuhgxFaUSrze+FOrtT8e2zWgjF/KRaJAJUTN2p5v6UFVdhwgeZkOo2dpw6yekFLFOaaSe
        PYKFPtvsLHDAnT0XXlth/OE7kzO0a4WHN1MnvfF3RBXfkZSgd8rOoSNaJHrhHcRWHfWd+EKfdKUzP
        PqEKYu+2zO4Mw593kNVOtVcMWLNM8IgYcEl2WLRJs+liZ4K43ZkEXa8MgWthS7x48jCulIHv+JzP2
        T10n8dLw==;
Received: from willy by casper.infradead.org with local (Exim 4.92.3 #3 (Red Hat Linux))
        id 1k8Pf6-0008G8-Ao; Wed, 19 Aug 2020 15:06:00 +0000
From:   "Matthew Wilcox (Oracle)" <willy@infradead.org>
To:     linux-mm@kvack.org
Cc:     "Matthew Wilcox (Oracle)" <willy@infradead.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Hugh Dickins <hughd@google.com>,
        William Kucharski <william.kucharski@oracle.com>,
        Johannes Weiner <hannes@cmpxchg.org>, Jan Kara <jack@suse.cz>,
        linux-kernel@vger.kernel.org
Subject: [PATCH 6/7] mm: Pass pvec directly to find_get_entries
Date:   Wed, 19 Aug 2020 16:05:54 +0100
Message-Id: <20200819150555.31669-7-willy@infradead.org>
X-Mailer: git-send-email 2.21.3
In-Reply-To: <20200819150555.31669-1-willy@infradead.org>
References: <20200819150555.31669-1-willy@infradead.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

All callers of find_get_entries() use a pvec, so pass it directly
instead of manipulating it in the caller.

Signed-off-by: Matthew Wilcox (Oracle) <willy@infradead.org>
---
 include/linux/pagemap.h |  3 +--
 mm/filemap.c            | 14 ++++++--------
 mm/shmem.c              | 11 +++--------
 mm/swap.c               |  4 +---
 4 files changed, 11 insertions(+), 21 deletions(-)

diff --git a/include/linux/pagemap.h b/include/linux/pagemap.h
index 3f0dc8d00f2a..9d465dd8b379 100644
--- a/include/linux/pagemap.h
+++ b/include/linux/pagemap.h
@@ -387,8 +387,7 @@ static inline struct page *find_subpage(struct page *head, pgoff_t index)
 struct page *find_get_entry(struct address_space *mapping, pgoff_t offset);
 struct page *find_lock_entry(struct address_space *mapping, pgoff_t offset);
 unsigned find_get_entries(struct address_space *mapping, pgoff_t start,
-		pgoff_t end, unsigned int nr_entries, struct page **entries,
-		pgoff_t *indices);
+		pgoff_t end, struct pagevec *pvec, pgoff_t *indices);
 unsigned find_get_pages_range(struct address_space *mapping, pgoff_t *start,
 			pgoff_t end, unsigned int nr_pages,
 			struct page **pages);
diff --git a/mm/filemap.c b/mm/filemap.c
index 159cf3d6f1ae..892c7beef392 100644
--- a/mm/filemap.c
+++ b/mm/filemap.c
@@ -1743,8 +1743,7 @@ EXPORT_SYMBOL(pagecache_get_page);
  * @mapping:	The address_space to search
  * @start:	The starting page cache index
  * @end:	The highest page cache index to return.
- * @nr_entries:	The maximum number of entries
- * @entries:	Where the resulting entries are placed
+ * @pvec:	Where the resulting entries are placed
  * @indices:	The cache indices corresponding to the entries in @entries
  *
  * find_get_entries() will search for and return a group of up to
@@ -1767,15 +1766,12 @@ EXPORT_SYMBOL(pagecache_get_page);
  * Return: the number of pages and shadow entries which were found.
  */
 unsigned find_get_entries(struct address_space *mapping, pgoff_t start,
-		pgoff_t end, unsigned int nr_entries, struct page **entries,
-		pgoff_t *indices)
+		pgoff_t end, struct pagevec *pvec, pgoff_t *indices)
 {
 	XA_STATE(xas, &mapping->i_pages, start);
 	struct page *page;
 	unsigned int ret = 0;
-
-	if (!nr_entries)
-		return 0;
+	unsigned nr_entries = PAGEVEC_SIZE;
 
 	rcu_read_lock();
 	xas_for_each(&xas, page, end) {
@@ -1806,7 +1802,7 @@ unsigned find_get_entries(struct address_space *mapping, pgoff_t start,
 		}
 export:
 		indices[ret] = xas.xa_index;
-		entries[ret] = page;
+		pvec->pages[ret] = page;
 		if (++ret == nr_entries)
 			break;
 		continue;
@@ -1816,6 +1812,8 @@ unsigned find_get_entries(struct address_space *mapping, pgoff_t start,
 		xas_reset(&xas);
 	}
 	rcu_read_unlock();
+
+	pvec->nr = ret;
 	return ret;
 }
 
diff --git a/mm/shmem.c b/mm/shmem.c
index abdbe61a1aa7..e73c0b2ba99c 100644
--- a/mm/shmem.c
+++ b/mm/shmem.c
@@ -905,11 +905,7 @@ static void shmem_undo_range(struct inode *inode, loff_t lstart, loff_t lend,
 
 	pagevec_init(&pvec);
 	index = start;
-	while (index < end) {
-		pvec.nr = find_get_entries(mapping, index, end - 1,
-				PAGEVEC_SIZE, pvec.pages, indices);
-		if (!pvec.nr)
-			break;
+	while (find_get_entries(mapping, index, end - 1, &pvec, indices)) {
 		for (i = 0; i < pagevec_count(&pvec); i++) {
 			struct page *page = pvec.pages[i];
 
@@ -976,9 +972,8 @@ static void shmem_undo_range(struct inode *inode, loff_t lstart, loff_t lend,
 	while (index < end) {
 		cond_resched();
 
-		pvec.nr = find_get_entries(mapping, index, end - 1,
-				PAGEVEC_SIZE, pvec.pages, indices);
-		if (!pvec.nr) {
+		if (!find_get_entries(mapping, index, end - 1, &pvec,
+				indices)) {
 			/* If all gone or hole-punch or unfalloc, we're done */
 			if (index == start || end != -1)
 				break;
diff --git a/mm/swap.c b/mm/swap.c
index d4e3ba4c967c..40b23300d353 100644
--- a/mm/swap.c
+++ b/mm/swap.c
@@ -1060,9 +1060,7 @@ unsigned pagevec_lookup_entries(struct pagevec *pvec,
 		struct address_space *mapping, pgoff_t start, pgoff_t end,
 		pgoff_t *indices)
 {
-	pvec->nr = find_get_entries(mapping, start, end, PAGEVEC_SIZE,
-				    pvec->pages, indices);
-	return pagevec_count(pvec);
+	return find_get_entries(mapping, start, end, pvec, indices);
 }
 
 /**
-- 
2.28.0

