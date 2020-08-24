Return-Path: <SRS0=wYIT=CC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8547AC433E1
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Aug 2020 18:34:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5A6C820639
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Aug 2020 18:34:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="SxKljR35"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726750AbgHXSed (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 24 Aug 2020 14:34:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43890 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726336AbgHXSeb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Aug 2020 14:34:31 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B2E40C061573
        for <linux-kernel@vger.kernel.org>; Mon, 24 Aug 2020 11:34:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:MIME-Version:
        Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
        Content-Description:In-Reply-To:References;
        bh=BP9cpqmF4IATPqCCJSLgnGP7perlJaubbvCMXtQsvlk=; b=SxKljR35b6XcdxA7GECjRRyjuD
        li77K3qqe8bpxR8Nzg87Id7tZ1lC4bFC63wb+NKU/aP9HcI3OQt1p1Gmyn8qJy4rDFTgUUBv7bGd9
        ao48UabTyI+9YU8iIfaI1DUn+rBN/jLumJ5yfN0isj6nydZvJzITOX530+z6H5PoltVAO4Ri+x4As
        ctZvsK/EDqzHaPWLLvZG+0u07yuLHds5/kJtF8XTNK2eb94oRP3S3dRjLskAZZgXpN9SxQq9trcU8
        0caZXfVAECGy6xpJdfdZ6Z1YcC76BiDT8cAxiXi5t9q339ABSDxiYZ94KVaTX6UJc95tQXN/Xs74U
        D57p91DA==;
Received: from willy by casper.infradead.org with local (Exim 4.92.3 #3 (Red Hat Linux))
        id 1kAHIZ-000172-K3; Mon, 24 Aug 2020 18:34:28 +0000
From:   "Matthew Wilcox (Oracle)" <willy@infradead.org>
To:     David Howells <dhowells@redhat.com>
Cc:     "Matthew Wilcox (Oracle)" <willy@infradead.org>,
        linux-afs@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH] afs: Use a pagevec in afs_writepages()
Date:   Mon, 24 Aug 2020 19:34:24 +0100
Message-Id: <20200824183424.4222-1-willy@infradead.org>
X-Mailer: git-send-email 2.21.3
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This amortises the overhead of retrieving pages from the pagecache
and the overhead of freeing pages if we happen to end up with the
last references to the pages.

Signed-off-by: Matthew Wilcox (Oracle) <willy@infradead.org>
---
 fs/afs/write.c | 41 ++++++++++++++++++++++++-----------------
 1 file changed, 24 insertions(+), 17 deletions(-)

diff --git a/fs/afs/write.c b/fs/afs/write.c
index a121c247d95a..2d20037c7ff0 100644
--- a/fs/afs/write.c
+++ b/fs/afs/write.c
@@ -673,16 +673,24 @@ static int afs_writepages_region(struct address_space *mapping,
 				 struct writeback_control *wbc,
 				 pgoff_t index, pgoff_t end, pgoff_t *_next)
 {
-	struct page *page;
-	int ret, n;
+	struct pagevec pvec;
+	int ret, i = 0;
 
 	_enter(",,%lx,%lx,", index, end);
 
+	pagevec_init(&pvec);
 	do {
-		n = find_get_pages_range_tag(mapping, &index, end,
-					PAGECACHE_TAG_DIRTY, 1, &page);
-		if (!n)
-			break;
+		struct page *page;
+
+		if (i == pagevec_count(&pvec)) {
+			pagevec_release(&pvec);
+			if (!pagevec_lookup_range_tag(&pvec, mapping,
+					&index, end, PAGECACHE_TAG_DIRTY))
+				break;
+			i = 0;
+		}
+
+		page = pvec.pages[i++];
 
 		_debug("wback %lx", page->index);
 
@@ -693,15 +701,11 @@ static int afs_writepages_region(struct address_space *mapping,
 		 * back from swapper_space to tmpfs file mapping
 		 */
 		ret = lock_page_killable(page);
-		if (ret < 0) {
-			put_page(page);
-			_leave(" = %d", ret);
-			return ret;
-		}
+		if (ret < 0)
+			goto err;
 
 		if (page->mapping != mapping || !PageDirty(page)) {
 			unlock_page(page);
-			put_page(page);
 			continue;
 		}
 
@@ -709,7 +713,6 @@ static int afs_writepages_region(struct address_space *mapping,
 			unlock_page(page);
 			if (wbc->sync_mode != WB_SYNC_NONE)
 				wait_on_page_writeback(page);
-			put_page(page);
 			continue;
 		}
 
@@ -717,19 +720,23 @@ static int afs_writepages_region(struct address_space *mapping,
 			BUG();
 		ret = afs_write_back_from_locked_page(mapping, wbc, page, end);
 		put_page(page);
-		if (ret < 0) {
-			_leave(" = %d", ret);
-			return ret;
-		}
+		if (ret < 0)
+			goto err;
 
 		wbc->nr_to_write -= ret;
 
 		cond_resched();
 	} while (index < end && wbc->nr_to_write > 0);
 
+	pagevec_release(&pvec);
 	*_next = index;
 	_leave(" = 0 [%lx]", *_next);
 	return 0;
+
+err:
+	pagevec_release(&pvec);
+	_leave(" = %d", ret);
+	return ret;
 }
 
 /*
-- 
2.28.0

