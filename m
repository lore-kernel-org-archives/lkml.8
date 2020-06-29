Return-Path: <SRS0=6VGy=AK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 34B3DC433E1
	for <linux-kernel@archiver.kernel.org>; Mon, 29 Jun 2020 23:48:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 17C7720780
	for <linux-kernel@archiver.kernel.org>; Mon, 29 Jun 2020 23:48:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728279AbgF2Xsm (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 29 Jun 2020 19:48:42 -0400
Received: from mga05.intel.com ([192.55.52.43]:17894 "EHLO mga05.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727901AbgF2Xsf (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 Jun 2020 19:48:35 -0400
IronPort-SDR: poyoQ9I4GarjOu0ubZociJCxbbrVsHaBTQ0Fy67+iw75bVp6sjQCQmKTz/7s8XkPI5kpTIzFEw
 FWx7YLfv+/qw==
X-IronPort-AV: E=McAfee;i="6000,8403,9666"; a="230951608"
X-IronPort-AV: E=Sophos;i="5.75,296,1589266800"; 
   d="scan'208";a="230951608"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Jun 2020 16:48:31 -0700
IronPort-SDR: 3DjoyN++8LiPSXa9PvxNGIDMIgxrTeGxgSGD58gJlLuHdbVM4qG3L9wV8nfdlyI36qJvEFosLj
 aa/JJxnxt+AA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.75,296,1589266800"; 
   d="scan'208";a="320182264"
Received: from viggo.jf.intel.com (HELO localhost.localdomain) ([10.54.77.144])
  by orsmga007.jf.intel.com with ESMTP; 29 Jun 2020 16:48:31 -0700
Subject: [RFC][PATCH 2/8] mm/migrate: Defer allocating new page until needed
To:     linux-kernel@vger.kernel.org
Cc:     linux-mm@kvack.org, Dave Hansen <dave.hansen@linux.intel.com>,
        kbusch@kernel.org, yang.shi@linux.alibaba.com, rientjes@google.com,
        ying.huang@intel.com, dan.j.williams@intel.com
From:   Dave Hansen <dave.hansen@linux.intel.com>
Date:   Mon, 29 Jun 2020 16:45:07 -0700
References: <20200629234503.749E5340@viggo.jf.intel.com>
In-Reply-To: <20200629234503.749E5340@viggo.jf.intel.com>
Message-Id: <20200629234507.CA0FDE19@viggo.jf.intel.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


From: Keith Busch <kbusch@kernel.org>

Migrating pages had been allocating the new page before it was actually
needed. Subsequent operations may still fail, which would have to handle
cleaning up the newly allocated page when it was never used.

Defer allocating the page until we are actually ready to make use of
it, after locking the original page. This simplifies error handling,
but should not have any functional change in behavior. This is just
refactoring page migration so the main part can more easily be reused
by other code.

#Signed-off-by: Keith Busch <keith.busch@intel.com>
Signed-off-by: Dave Hansen <dave.hansen@linux.intel.com>
Cc: Keith Busch <kbusch@kernel.org>
Cc: Yang Shi <yang.shi@linux.alibaba.com>
Cc: David Rientjes <rientjes@google.com>
Cc: Huang Ying <ying.huang@intel.com>
Cc: Dan Williams <dan.j.williams@intel.com>
---

 b/mm/migrate.c |  148 ++++++++++++++++++++++++++++-----------------------------
 1 file changed, 75 insertions(+), 73 deletions(-)

diff -puN mm/migrate.c~0007-mm-migrate-Defer-allocating-new-page-until-needed mm/migrate.c
--- a/mm/migrate.c~0007-mm-migrate-Defer-allocating-new-page-until-needed	2020-06-29 16:34:37.896312607 -0700
+++ b/mm/migrate.c	2020-06-29 16:34:37.900312607 -0700
@@ -1014,56 +1014,17 @@ out:
 	return rc;
 }
 
-static int __unmap_and_move(struct page *page, struct page *newpage,
-				int force, enum migrate_mode mode)
+static int __unmap_and_move(new_page_t get_new_page,
+			    free_page_t put_new_page,
+			    unsigned long private, struct page *page,
+			    enum migrate_mode mode,
+			    enum migrate_reason reason)
 {
 	int rc = -EAGAIN;
 	int page_was_mapped = 0;
 	struct anon_vma *anon_vma = NULL;
 	bool is_lru = !__PageMovable(page);
-
-	if (!trylock_page(page)) {
-		if (!force || mode == MIGRATE_ASYNC)
-			goto out;
-
-		/*
-		 * It's not safe for direct compaction to call lock_page.
-		 * For example, during page readahead pages are added locked
-		 * to the LRU. Later, when the IO completes the pages are
-		 * marked uptodate and unlocked. However, the queueing
-		 * could be merging multiple pages for one bio (e.g.
-		 * mpage_readpages). If an allocation happens for the
-		 * second or third page, the process can end up locking
-		 * the same page twice and deadlocking. Rather than
-		 * trying to be clever about what pages can be locked,
-		 * avoid the use of lock_page for direct compaction
-		 * altogether.
-		 */
-		if (current->flags & PF_MEMALLOC)
-			goto out;
-
-		lock_page(page);
-	}
-
-	if (PageWriteback(page)) {
-		/*
-		 * Only in the case of a full synchronous migration is it
-		 * necessary to wait for PageWriteback. In the async case,
-		 * the retry loop is too short and in the sync-light case,
-		 * the overhead of stalling is too much
-		 */
-		switch (mode) {
-		case MIGRATE_SYNC:
-		case MIGRATE_SYNC_NO_COPY:
-			break;
-		default:
-			rc = -EBUSY;
-			goto out_unlock;
-		}
-		if (!force)
-			goto out_unlock;
-		wait_on_page_writeback(page);
-	}
+	struct page *newpage;
 
 	/*
 	 * By try_to_unmap(), page->mapcount goes down to 0 here. In this case,
@@ -1082,6 +1043,12 @@ static int __unmap_and_move(struct page
 	if (PageAnon(page) && !PageKsm(page))
 		anon_vma = page_get_anon_vma(page);
 
+	newpage = get_new_page(page, private);
+	if (!newpage) {
+		rc = -ENOMEM;
+		goto out;
+	}
+
 	/*
 	 * Block others from accessing the new page when we get around to
 	 * establishing additional references. We are usually the only one
@@ -1091,11 +1058,11 @@ static int __unmap_and_move(struct page
 	 * This is much like races on refcount of oldpage: just don't BUG().
 	 */
 	if (unlikely(!trylock_page(newpage)))
-		goto out_unlock;
+		goto out_put;
 
 	if (unlikely(!is_lru)) {
 		rc = move_to_new_page(newpage, page, mode);
-		goto out_unlock_both;
+		goto out_unlock;
 	}
 
 	/*
@@ -1114,7 +1081,7 @@ static int __unmap_and_move(struct page
 		VM_BUG_ON_PAGE(PageAnon(page), page);
 		if (page_has_private(page)) {
 			try_to_free_buffers(page);
-			goto out_unlock_both;
+			goto out_unlock;
 		}
 	} else if (page_mapped(page)) {
 		/* Establish migration ptes */
@@ -1131,15 +1098,9 @@ static int __unmap_and_move(struct page
 	if (page_was_mapped)
 		remove_migration_ptes(page,
 			rc == MIGRATEPAGE_SUCCESS ? newpage : page, false);
-
-out_unlock_both:
-	unlock_page(newpage);
 out_unlock:
-	/* Drop an anon_vma reference if we took one */
-	if (anon_vma)
-		put_anon_vma(anon_vma);
-	unlock_page(page);
-out:
+	unlock_page(newpage);
+out_put:
 	/*
 	 * If migration is successful, decrease refcount of the newpage
 	 * which will not free the page because new page owner increased
@@ -1150,12 +1111,20 @@ out:
 	 * state.
 	 */
 	if (rc == MIGRATEPAGE_SUCCESS) {
+		set_page_owner_migrate_reason(newpage, reason);
 		if (unlikely(!is_lru))
 			put_page(newpage);
 		else
 			putback_lru_page(newpage);
+	} else if (put_new_page) {
+		put_new_page(newpage, private);
+	} else {
+		put_page(newpage);
 	}
-
+out:
+	/* Drop an anon_vma reference if we took one */
+	if (anon_vma)
+		put_anon_vma(anon_vma);
 	return rc;
 }
 
@@ -1203,8 +1172,7 @@ static ICE_noinline int unmap_and_move(n
 				   int force, enum migrate_mode mode,
 				   enum migrate_reason reason)
 {
-	int rc = MIGRATEPAGE_SUCCESS;
-	struct page *newpage = NULL;
+	int rc = -EAGAIN;
 
 	if (!thp_migration_supported() && PageTransHuge(page))
 		return -ENOMEM;
@@ -1219,17 +1187,57 @@ static ICE_noinline int unmap_and_move(n
 				__ClearPageIsolated(page);
 			unlock_page(page);
 		}
+		rc = MIGRATEPAGE_SUCCESS;
 		goto out;
 	}
 
-	newpage = get_new_page(page, private);
-	if (!newpage)
-		return -ENOMEM;
+	if (!trylock_page(page)) {
+		if (!force || mode == MIGRATE_ASYNC)
+			return rc;
 
-	rc = __unmap_and_move(page, newpage, force, mode);
-	if (rc == MIGRATEPAGE_SUCCESS)
-		set_page_owner_migrate_reason(newpage, reason);
+		/*
+		 * It's not safe for direct compaction to call lock_page.
+		 * For example, during page readahead pages are added locked
+		 * to the LRU. Later, when the IO completes the pages are
+		 * marked uptodate and unlocked. However, the queueing
+		 * could be merging multiple pages for one bio (e.g.
+		 * mpage_readpages). If an allocation happens for the
+		 * second or third page, the process can end up locking
+		 * the same page twice and deadlocking. Rather than
+		 * trying to be clever about what pages can be locked,
+		 * avoid the use of lock_page for direct compaction
+		 * altogether.
+		 */
+		if (current->flags & PF_MEMALLOC)
+			return rc;
+
+		lock_page(page);
+	}
+
+	if (PageWriteback(page)) {
+		/*
+		 * Only in the case of a full synchronous migration is it
+		 * necessary to wait for PageWriteback. In the async case,
+		 * the retry loop is too short and in the sync-light case,
+		 * the overhead of stalling is too much
+		 */
+		switch (mode) {
+		case MIGRATE_SYNC:
+		case MIGRATE_SYNC_NO_COPY:
+			break;
+		default:
+			rc = -EBUSY;
+			goto out_unlock;
+		}
+		if (!force)
+			goto out_unlock;
+		wait_on_page_writeback(page);
+	}
+	rc = __unmap_and_move(get_new_page, put_new_page, private,
+			      page, mode, reason);
 
+out_unlock:
+	unlock_page(page);
 out:
 	if (rc != -EAGAIN) {
 		/*
@@ -1269,9 +1277,8 @@ out:
 		if (rc != -EAGAIN) {
 			if (likely(!__PageMovable(page))) {
 				putback_lru_page(page);
-				goto put_new;
+				goto done;
 			}
-
 			lock_page(page);
 			if (PageMovable(page))
 				putback_movable_page(page);
@@ -1280,13 +1287,8 @@ out:
 			unlock_page(page);
 			put_page(page);
 		}
-put_new:
-		if (put_new_page)
-			put_new_page(newpage, private);
-		else
-			put_page(newpage);
 	}
-
+done:
 	return rc;
 }
 
_
