Return-Path: <SRS0=EnQK=B5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 28135C433E1
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Aug 2020 15:07:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0565920882
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Aug 2020 15:07:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="uot5Q+Pa"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728739AbgHSPHZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 19 Aug 2020 11:07:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56160 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728714AbgHSPGJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Aug 2020 11:06:09 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4E946C061346
        for <linux-kernel@vger.kernel.org>; Wed, 19 Aug 2020 08:06:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:MIME-Version:
        References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:
        Content-Type:Content-ID:Content-Description;
        bh=PBUUysYXD1votG2sPHoOzk7JYvDz6PjbCnVt50looX0=; b=uot5Q+Paoy8MbWBw+iBrtx95MO
        K4Q8hbW6lGvuw5BdC+KAryA7EVvf6XkP16KpNT4Ta1bZZyAth185SFmFyIf1siToBaofIC6XSueim
        xUc1ot2ubZYvodtQ5saB/9J6Jkj5jkXYFlmlG8r9poo42xr/YWYbtyOJ4xdFFuIXPVGN/eU0H9oIQ
        ETQt9fqxcGQiyWDRN4K9jEffXqbgF55phGQq6cYJepuTZ8q9gNzQXhSAH8DnM/uFbgfnvV1QegeuQ
        TZcmgD6GQNnvGUo/6xGXDqS/AVu0wQcZS8GxrMF4BDcfv3ppFZJVEv2NGIAsGYzbKVjOxqpfDObpP
        LVLfeZUg==;
Received: from willy by casper.infradead.org with local (Exim 4.92.3 #3 (Red Hat Linux))
        id 1k8Pf7-0008GI-1y; Wed, 19 Aug 2020 15:06:01 +0000
From:   "Matthew Wilcox (Oracle)" <willy@infradead.org>
To:     linux-mm@kvack.org
Cc:     "Matthew Wilcox (Oracle)" <willy@infradead.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Hugh Dickins <hughd@google.com>,
        William Kucharski <william.kucharski@oracle.com>,
        Johannes Weiner <hannes@cmpxchg.org>, Jan Kara <jack@suse.cz>,
        linux-kernel@vger.kernel.org
Subject: [PATCH 7/7] mm: Remove pagevec_lookup_entries
Date:   Wed, 19 Aug 2020 16:05:55 +0100
Message-Id: <20200819150555.31669-8-willy@infradead.org>
X-Mailer: git-send-email 2.21.3
In-Reply-To: <20200819150555.31669-1-willy@infradead.org>
References: <20200819150555.31669-1-willy@infradead.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

pagevec_lookup_entries() is now just a wrapper around find_get_entries()
so remove it and convert all its callers.

Signed-off-by: Matthew Wilcox (Oracle) <willy@infradead.org>
---
 include/linux/pagevec.h |  3 ---
 mm/swap.c               | 36 ++----------------------------------
 mm/truncate.c           |  9 ++++-----
 3 files changed, 6 insertions(+), 42 deletions(-)

diff --git a/include/linux/pagevec.h b/include/linux/pagevec.h
index ce77724a2ab7..a45bea4b4d08 100644
--- a/include/linux/pagevec.h
+++ b/include/linux/pagevec.h
@@ -25,9 +25,6 @@ struct pagevec {
 
 void __pagevec_release(struct pagevec *pvec);
 void __pagevec_lru_add(struct pagevec *pvec);
-unsigned pagevec_lookup_entries(struct pagevec *pvec,
-		struct address_space *mapping, pgoff_t start, pgoff_t end,
-		pgoff_t *indices);
 void pagevec_remove_exceptionals(struct pagevec *pvec);
 unsigned pagevec_lookup_range(struct pagevec *pvec,
 			      struct address_space *mapping,
diff --git a/mm/swap.c b/mm/swap.c
index 40b23300d353..cc0d648f79d4 100644
--- a/mm/swap.c
+++ b/mm/swap.c
@@ -1031,44 +1031,12 @@ void __pagevec_lru_add(struct pagevec *pvec)
 	pagevec_lru_move_fn(pvec, __pagevec_lru_add_fn, NULL);
 }
 
-/**
- * pagevec_lookup_entries - gang pagecache lookup
- * @pvec:	Where the resulting entries are placed
- * @mapping:	The address_space to search
- * @start:	The starting entry index
- * @end:	The highest index to return (inclusive).
- * @nr_entries:	The maximum number of pages
- * @indices:	The cache indices corresponding to the entries in @pvec
- *
- * pagevec_lookup_entries() will search for and return a group of up
- * to @nr_pages pages and shadow entries in the mapping.  All
- * entries are placed in @pvec.  pagevec_lookup_entries() takes a
- * reference against actual pages in @pvec.
- *
- * The search returns a group of mapping-contiguous entries with
- * ascending indexes.  There may be holes in the indices due to
- * not-present entries.
- *
- * Only one subpage of a Transparent Huge Page is returned in one call:
- * allowing truncate_inode_pages_range() to evict the whole THP without
- * cycling through a pagevec of extra references.
- *
- * pagevec_lookup_entries() returns the number of entries which were
- * found.
- */
-unsigned pagevec_lookup_entries(struct pagevec *pvec,
-		struct address_space *mapping, pgoff_t start, pgoff_t end,
-		pgoff_t *indices)
-{
-	return find_get_entries(mapping, start, end, pvec, indices);
-}
-
 /**
  * pagevec_remove_exceptionals - pagevec exceptionals pruning
  * @pvec:	The pagevec to prune
  *
- * pagevec_lookup_entries() fills both pages and exceptional radix
- * tree entries into the pagevec.  This function prunes all
+ * find_get_entries() fills both pages and XArray value entries (aka
+ * exceptional entries) into the pagevec.  This function prunes all
  * exceptionals from @pvec without leaving holes, so that it can be
  * passed on to page-only pagevec operations.
  */
diff --git a/mm/truncate.c b/mm/truncate.c
index 96a45ba28042..90b07884db9f 100644
--- a/mm/truncate.c
+++ b/mm/truncate.c
@@ -326,8 +326,7 @@ void truncate_inode_pages_range(struct address_space *mapping,
 
 	pagevec_init(&pvec);
 	index = start;
-	while (pagevec_lookup_entries(&pvec, mapping, index, end - 1,
-			indices)) {
+	while (find_get_entries(mapping, index, end - 1, &pvec, indices)) {
 		/*
 		 * Pagevec array has exceptional entries and we may also fail
 		 * to lock some pages. So we store pages that can be deleted
@@ -410,7 +409,7 @@ void truncate_inode_pages_range(struct address_space *mapping,
 	index = start;
 	for ( ; ; ) {
 		cond_resched();
-		if (!pagevec_lookup_entries(&pvec, mapping, index, end - 1,
+		if (!find_get_entries(mapping, index, end - 1, &pvec,
 				indices)) {
 			/* If all gone from start onwards, we're done */
 			if (index == start)
@@ -540,7 +539,7 @@ unsigned long invalidate_mapping_pages(struct address_space *mapping,
 	int i;
 
 	pagevec_init(&pvec);
-	while (pagevec_lookup_entries(&pvec, mapping, index, end, indices)) {
+	while (find_get_entries(mapping, index, end, &pvec, indices)) {
 		for (i = 0; i < pagevec_count(&pvec); i++) {
 			struct page *page = pvec.pages[i];
 
@@ -679,7 +678,7 @@ int invalidate_inode_pages2_range(struct address_space *mapping,
 
 	pagevec_init(&pvec);
 	index = start;
-	while (pagevec_lookup_entries(&pvec, mapping, index, end, indices)) {
+	while (find_get_entries(mapping, index, end, &pvec, indices)) {
 		for (i = 0; i < pagevec_count(&pvec); i++) {
 			struct page *page = pvec.pages[i];
 
-- 
2.28.0

