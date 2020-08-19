Return-Path: <SRS0=EnQK=B5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 68CEFC433E1
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Aug 2020 15:06:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3FCC420885
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Aug 2020 15:06:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="rUIjVaD5"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728754AbgHSPG2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 19 Aug 2020 11:06:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56146 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728605AbgHSPGH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Aug 2020 11:06:07 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8A3BBC061343
        for <linux-kernel@vger.kernel.org>; Wed, 19 Aug 2020 08:06:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:MIME-Version:
        References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:
        Content-Type:Content-ID:Content-Description;
        bh=0lmsqbGmetlJBkzc4ZuNWjeYeYTFCAAUm9L6wN3Rc00=; b=rUIjVaD5CCarDxn4eu+VjYvcFd
        0vo+utMww9Ae2xY12uEPQKKI9CpFQrq7dKm3H5T6aVH7EEtFOFvt7FVQZdPBUuxSKUgr/rZQSddyH
        6W/KNQAu46A/Ag7Ggq3hdcRTJRIWOA5ClS7AibYpLBomOuksNCNapyW+KPfhK9FrTmWrritHAnu61
        +UHR9h6kpppb1gnBENEUsh9jRhfDmBPLpxjPUs/KW9u0tdNMjG9teBh5wtlnCrJNzoZdzbR0BhsEv
        JgJ8M0AD1n7eLVLwAUmOJYPi7scFnX41G4qhfI4sqZZnGgzMgDiJEyp0O+DTVpFyuC278jpFBm5Xk
        MaEtLlGA==;
Received: from willy by casper.infradead.org with local (Exim 4.92.3 #3 (Red Hat Linux))
        id 1k8Pf5-0008Ft-EJ; Wed, 19 Aug 2020 15:05:59 +0000
From:   "Matthew Wilcox (Oracle)" <willy@infradead.org>
To:     linux-mm@kvack.org
Cc:     "Matthew Wilcox (Oracle)" <willy@infradead.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Hugh Dickins <hughd@google.com>,
        William Kucharski <william.kucharski@oracle.com>,
        Johannes Weiner <hannes@cmpxchg.org>, Jan Kara <jack@suse.cz>,
        linux-kernel@vger.kernel.org
Subject: [PATCH 4/7] mm: Add an 'end' parameter to pagevec_lookup_entries
Date:   Wed, 19 Aug 2020 16:05:52 +0100
Message-Id: <20200819150555.31669-5-willy@infradead.org>
X-Mailer: git-send-email 2.21.3
In-Reply-To: <20200819150555.31669-1-willy@infradead.org>
References: <20200819150555.31669-1-willy@infradead.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Simplifies the callers and uses the existing functionality of
find_get_entries().

Signed-off-by: Matthew Wilcox (Oracle) <willy@infradead.org>
---
 include/linux/pagevec.h |  5 ++---
 mm/swap.c               |  8 ++++----
 mm/truncate.c           | 36 ++++++++----------------------------
 3 files changed, 14 insertions(+), 35 deletions(-)

diff --git a/include/linux/pagevec.h b/include/linux/pagevec.h
index 081d934eda64..4b245592262c 100644
--- a/include/linux/pagevec.h
+++ b/include/linux/pagevec.h
@@ -26,9 +26,8 @@ struct pagevec {
 void __pagevec_release(struct pagevec *pvec);
 void __pagevec_lru_add(struct pagevec *pvec);
 unsigned pagevec_lookup_entries(struct pagevec *pvec,
-				struct address_space *mapping,
-				pgoff_t start, unsigned nr_entries,
-				pgoff_t *indices);
+		struct address_space *mapping, pgoff_t start, pgoff_t end,
+		unsigned nr_entries, pgoff_t *indices);
 void pagevec_remove_exceptionals(struct pagevec *pvec);
 unsigned pagevec_lookup_range(struct pagevec *pvec,
 			      struct address_space *mapping,
diff --git a/mm/swap.c b/mm/swap.c
index fcf6ccb94b09..b6e56a84b466 100644
--- a/mm/swap.c
+++ b/mm/swap.c
@@ -1036,6 +1036,7 @@ void __pagevec_lru_add(struct pagevec *pvec)
  * @pvec:	Where the resulting entries are placed
  * @mapping:	The address_space to search
  * @start:	The starting entry index
+ * @end:	The highest index to return (inclusive).
  * @nr_entries:	The maximum number of pages
  * @indices:	The cache indices corresponding to the entries in @pvec
  *
@@ -1056,11 +1057,10 @@ void __pagevec_lru_add(struct pagevec *pvec)
  * found.
  */
 unsigned pagevec_lookup_entries(struct pagevec *pvec,
-				struct address_space *mapping,
-				pgoff_t start, unsigned nr_entries,
-				pgoff_t *indices)
+		struct address_space *mapping, pgoff_t start, pgoff_t end,
+		unsigned nr_entries, pgoff_t *indices)
 {
-	pvec->nr = find_get_entries(mapping, start, ULONG_MAX, nr_entries,
+	pvec->nr = find_get_entries(mapping, start, end, nr_entries,
 				    pvec->pages, indices);
 	return pagevec_count(pvec);
 }
diff --git a/mm/truncate.c b/mm/truncate.c
index dd9ebc1da356..9c617291fb1e 100644
--- a/mm/truncate.c
+++ b/mm/truncate.c
@@ -326,9 +326,8 @@ void truncate_inode_pages_range(struct address_space *mapping,
 
 	pagevec_init(&pvec);
 	index = start;
-	while (index < end && pagevec_lookup_entries(&pvec, mapping, index,
-			min(end - index, (pgoff_t)PAGEVEC_SIZE),
-			indices)) {
+	while (pagevec_lookup_entries(&pvec, mapping, index, end - 1,
+			PAGEVEC_SIZE, indices)) {
 		/*
 		 * Pagevec array has exceptional entries and we may also fail
 		 * to lock some pages. So we store pages that can be deleted
@@ -342,8 +341,6 @@ void truncate_inode_pages_range(struct address_space *mapping,
 
 			/* We rely upon deletion not changing page->index */
 			index = indices[i];
-			if (index >= end)
-				break;
 
 			if (xa_is_value(page))
 				continue;
@@ -413,8 +410,8 @@ void truncate_inode_pages_range(struct address_space *mapping,
 	index = start;
 	for ( ; ; ) {
 		cond_resched();
-		if (!pagevec_lookup_entries(&pvec, mapping, index,
-			min(end - index, (pgoff_t)PAGEVEC_SIZE), indices)) {
+		if (!pagevec_lookup_entries(&pvec, mapping, index, end - 1,
+				PAGEVEC_SIZE, indices)) {
 			/* If all gone from start onwards, we're done */
 			if (index == start)
 				break;
@@ -422,23 +419,12 @@ void truncate_inode_pages_range(struct address_space *mapping,
 			index = start;
 			continue;
 		}
-		if (index == start && indices[0] >= end) {
-			/* All gone out of hole to be punched, we're done */
-			pagevec_remove_exceptionals(&pvec);
-			pagevec_release(&pvec);
-			break;
-		}
 
 		for (i = 0; i < pagevec_count(&pvec); i++) {
 			struct page *page = pvec.pages[i];
 
 			/* We rely upon deletion not changing page->index */
 			index = indices[i];
-			if (index >= end) {
-				/* Restart punch to make sure all gone */
-				index = start - 1;
-				break;
-			}
 
 			if (xa_is_value(page))
 				continue;
@@ -554,16 +540,13 @@ unsigned long invalidate_mapping_pages(struct address_space *mapping,
 	int i;
 
 	pagevec_init(&pvec);
-	while (index <= end && pagevec_lookup_entries(&pvec, mapping, index,
-			min(end - index, (pgoff_t)PAGEVEC_SIZE - 1) + 1,
-			indices)) {
+	while (pagevec_lookup_entries(&pvec, mapping, index, end,
+			PAGEVEC_SIZE, indices)) {
 		for (i = 0; i < pagevec_count(&pvec); i++) {
 			struct page *page = pvec.pages[i];
 
 			/* We rely upon deletion not changing page->index */
 			index = indices[i];
-			if (index > end)
-				break;
 
 			if (xa_is_value(page)) {
 				invalidate_exceptional_entry(mapping, index,
@@ -697,16 +680,13 @@ int invalidate_inode_pages2_range(struct address_space *mapping,
 
 	pagevec_init(&pvec);
 	index = start;
-	while (index <= end && pagevec_lookup_entries(&pvec, mapping, index,
-			min(end - index, (pgoff_t)PAGEVEC_SIZE - 1) + 1,
-			indices)) {
+	while (pagevec_lookup_entries(&pvec, mapping, index, end,
+			PAGEVEC_SIZE, indices)) {
 		for (i = 0; i < pagevec_count(&pvec); i++) {
 			struct page *page = pvec.pages[i];
 
 			/* We rely upon deletion not changing page->index */
 			index = indices[i];
-			if (index > end)
-				break;
 
 			if (xa_is_value(page)) {
 				if (!invalidate_exceptional_entry2(mapping,
-- 
2.28.0

