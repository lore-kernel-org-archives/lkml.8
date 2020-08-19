Return-Path: <SRS0=EnQK=B5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C3909C433DF
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Aug 2020 15:06:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9C53520882
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Aug 2020 15:06:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="dUNOgQpc"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728445AbgHSPGW (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 19 Aug 2020 11:06:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56136 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726751AbgHSPGG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Aug 2020 11:06:06 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 379D2C061757
        for <linux-kernel@vger.kernel.org>; Wed, 19 Aug 2020 08:06:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:MIME-Version:
        References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:
        Content-Type:Content-ID:Content-Description;
        bh=rGp99648ZL0r8woPVMUKJKf4XOJovtD4R7sQ3PkJTLE=; b=dUNOgQpcGDOwdV8W+iUjybIwz+
        r+TCpbUCYbiD/bbVV6c1OmHeGRWxPtfu2txRjPQVQsykgWedkCX3/v3nBLonEAgBvgHc5ioaM6BUq
        cijdVuMd0vvhpGf3O41lbKHakZeRwKqC+ozro8VGm+DfwJqUjXalnWrHeBaG6doMOvoAHUiwUUQN0
        /zzAu3yQ3do3r6oNcMel12m+sHtRdIYmiAqJE69Usrh3NdJvSFYhuQBo4IBQl/2p/57Dki2r/nIg9
        SwYXcxtirP9t5Os0G/qp7a7zVQv76J5CffmARXi6O6aoghk/ibUNLObpyowQvAjZXA1WZvJW03atC
        sc7rTN6g==;
Received: from willy by casper.infradead.org with local (Exim 4.92.3 #3 (Red Hat Linux))
        id 1k8Pf4-0008Fe-H1; Wed, 19 Aug 2020 15:05:58 +0000
From:   "Matthew Wilcox (Oracle)" <willy@infradead.org>
To:     linux-mm@kvack.org
Cc:     "Matthew Wilcox (Oracle)" <willy@infradead.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Hugh Dickins <hughd@google.com>,
        William Kucharski <william.kucharski@oracle.com>,
        Johannes Weiner <hannes@cmpxchg.org>, Jan Kara <jack@suse.cz>,
        linux-kernel@vger.kernel.org
Subject: [PATCH 2/7] mm: Rewrite shmem_seek_hole_data
Date:   Wed, 19 Aug 2020 16:05:50 +0100
Message-Id: <20200819150555.31669-3-willy@infradead.org>
X-Mailer: git-send-email 2.21.3
In-Reply-To: <20200819150555.31669-1-willy@infradead.org>
References: <20200819150555.31669-1-willy@infradead.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

use the XArray directly instead of using the pagevec abstraction.
The code is simpler and more efficient.

Signed-off-by: Matthew Wilcox (Oracle) <willy@infradead.org>
---
 mm/shmem.c | 61 +++++++++++++++++++++---------------------------------
 1 file changed, 24 insertions(+), 37 deletions(-)

diff --git a/mm/shmem.c b/mm/shmem.c
index a7bbc4ed9677..0f9f149f4b5e 100644
--- a/mm/shmem.c
+++ b/mm/shmem.c
@@ -2659,53 +2659,40 @@ static ssize_t shmem_file_read_iter(struct kiocb *iocb, struct iov_iter *to)
 }
 
 /*
- * llseek SEEK_DATA or SEEK_HOLE through the page cache.
+ * llseek SEEK_DATA or SEEK_HOLE through the page cache.  We don't need
+ * to get a reference on the page because this interface is racy anyway.
+ * The page we find will have had the state at some point.
  */
 static pgoff_t shmem_seek_hole_data(struct address_space *mapping,
 				    pgoff_t index, pgoff_t end, int whence)
 {
+	XA_STATE(xas, &mapping->i_pages, index);
 	struct page *page;
-	struct pagevec pvec;
-	pgoff_t indices[PAGEVEC_SIZE];
-	bool done = false;
-	int i;
 
-	pagevec_init(&pvec);
-	pvec.nr = 1;		/* start small: we may be there already */
-	while (!done) {
-		pvec.nr = find_get_entries(mapping, index,
-					pvec.nr, pvec.pages, indices);
-		if (!pvec.nr) {
-			if (whence == SEEK_DATA)
-				index = end;
-			break;
+	rcu_read_lock();
+	if (whence == SEEK_DATA) {
+		for (;;) {
+			page = xas_find(&xas, end);
+			if (xas_retry(&xas, page))
+				continue;
+			if (!page || xa_is_value(page) || PageUptodate(page))
+				break;
 		}
-		for (i = 0; i < pvec.nr; i++, index++) {
-			if (index < indices[i]) {
-				if (whence == SEEK_HOLE) {
-					done = true;
-					break;
-				}
-				index = indices[i];
-			}
-			page = pvec.pages[i];
-			if (page && !xa_is_value(page)) {
-				if (!PageUptodate(page))
-					page = NULL;
-			}
-			if (index >= end ||
-			    (page && whence == SEEK_DATA) ||
-			    (!page && whence == SEEK_HOLE)) {
-				done = true;
+	} else /* SEEK_HOLE */ {
+		for (;;) {
+			page = xas_next(&xas);
+			if (xas_retry(&xas, page))
+				continue;
+			if (!xa_is_value(page) &&
+					(!page || !PageUptodate(page)))
+				break;
+			if (xas.xa_index >= end)
 				break;
-			}
 		}
-		pagevec_remove_exceptionals(&pvec);
-		pagevec_release(&pvec);
-		pvec.nr = PAGEVEC_SIZE;
-		cond_resched();
 	}
-	return index;
+	rcu_read_unlock();
+
+	return xas.xa_index;
 }
 
 static loff_t shmem_file_llseek(struct file *file, loff_t offset, int whence)
-- 
2.28.0

