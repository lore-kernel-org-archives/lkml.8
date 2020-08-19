Return-Path: <SRS0=EnQK=B5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 66B4CC433E1
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Aug 2020 18:49:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 46FAC207DE
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Aug 2020 18:49:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="QBZEY6GN"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726976AbgHSStp (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 19 Aug 2020 14:49:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34090 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726820AbgHSStG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Aug 2020 14:49:06 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 09EADC061342;
        Wed, 19 Aug 2020 11:49:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:MIME-Version:
        References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:
        Content-Type:Content-ID:Content-Description;
        bh=7+YSI5YaFA7nV1yaE7i/RW3xZbJtF/8x3LDr4io57Q8=; b=QBZEY6GNdSOmnF4ujehB7tIL/+
        8WlFkWpSxuLPFzkGOnnhlBlJavyO4Z+T0yXOfXgJgAGvoDk+Cf1m8ak9wPM8AkhSIMWn8nFA51xkD
        WHXh1JSEJrwxa10n1dsaReCF4jaEG4ACDpvQROgOqopHoed3BHKh9cV153/2lHtDBdHzNGvzALDwt
        xhCJjd4YgCOtHb28bEt8UYDUq80/QJIuQXJRj9csQ+VHnOkdnIJ+SSvdZLDIr692dGd7QtGw5TKT0
        kT9IZJattIKOxBcoS1wr/w22x9PoXKBXAMBPZyBB/EKkYK4S922ZQv2l+P8miuoSBxQIRrrF5OJXs
        10W3+YmQ==;
Received: from willy by casper.infradead.org with local (Exim 4.92.3 #3 (Red Hat Linux))
        id 1k8T8q-0006UR-DL; Wed, 19 Aug 2020 18:48:56 +0000
From:   "Matthew Wilcox (Oracle)" <willy@infradead.org>
To:     linux-mm@kvack.org
Cc:     "Matthew Wilcox (Oracle)" <willy@infradead.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Hugh Dickins <hughd@google.com>,
        William Kucharski <william.kucharski@oracle.com>,
        Jani Nikula <jani.nikula@linux.intel.com>,
        Alexey Dobriyan <adobriyan@gmail.com>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Chris Wilson <chris@chris-wilson.co.uk>,
        Matthew Auld <matthew.auld@intel.com>,
        Huang Ying <ying.huang@intel.com>,
        intel-gfx@lists.freedesktop.org, cgroups@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH 8/8] mm: Hoist find_subpage call further up in pagecache_get_page
Date:   Wed, 19 Aug 2020 19:48:50 +0100
Message-Id: <20200819184850.24779-9-willy@infradead.org>
X-Mailer: git-send-email 2.21.3
In-Reply-To: <20200819184850.24779-1-willy@infradead.org>
References: <20200819184850.24779-1-willy@infradead.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This avoids a call to compound_head().

Signed-off-by: Matthew Wilcox (Oracle) <willy@infradead.org>
---
 mm/filemap.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/mm/filemap.c b/mm/filemap.c
index 6594baae7cd2..8c354277108d 100644
--- a/mm/filemap.c
+++ b/mm/filemap.c
@@ -1667,7 +1667,6 @@ struct page *pagecache_get_page(struct address_space *mapping, pgoff_t index,
 		page = NULL;
 	if (!page)
 		goto no_page;
-	page = find_subpage(page, index);
 
 	if (fgp_flags & FGP_LOCK) {
 		if (fgp_flags & FGP_NOWAIT) {
@@ -1680,12 +1679,12 @@ struct page *pagecache_get_page(struct address_space *mapping, pgoff_t index,
 		}
 
 		/* Has the page been truncated? */
-		if (unlikely(compound_head(page)->mapping != mapping)) {
+		if (unlikely(page->mapping != mapping)) {
 			unlock_page(page);
 			put_page(page);
 			goto repeat;
 		}
-		VM_BUG_ON_PAGE(page->index != index, page);
+		VM_BUG_ON_PAGE(!thp_valid_index(page, index), page);
 	}
 
 	if (fgp_flags & FGP_ACCESSED)
@@ -1695,6 +1694,7 @@ struct page *pagecache_get_page(struct address_space *mapping, pgoff_t index,
 		if (page_is_idle(page))
 			clear_page_idle(page);
 	}
+	page = find_subpage(page, index);
 
 no_page:
 	if (!page && (fgp_flags & FGP_CREAT)) {
-- 
2.28.0

