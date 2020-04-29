Return-Path: <SRS0=ObIu=6N=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2E076C83004
	for <linux-kernel@archiver.kernel.org>; Wed, 29 Apr 2020 13:41:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0F85F206D6
	for <linux-kernel@archiver.kernel.org>; Wed, 29 Apr 2020 13:41:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="hPY6ikuk"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728647AbgD2Nla (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 29 Apr 2020 09:41:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52960 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727049AbgD2NhA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Apr 2020 09:37:00 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:e::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AD0E5C09B050;
        Wed, 29 Apr 2020 06:36:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=Content-Transfer-Encoding:
        MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender
        :Reply-To:Content-Type:Content-ID:Content-Description;
        bh=/I2+DCXCESGHqvjUnYcK6t8+p4l0VeWIO9rp24wHt2Y=; b=hPY6ikukO6LnUyAVB/d1DxFnJ5
        Bb+d2Lxn664VdDhjTbraTN8nNIeaxJA9QypBdsy+htxXBjjjjLJbzPWL+LpuDfGBgatCNUTi9DAOJ
        294iexS7iKLrS5oxAIsPvafE7suUeL8GNbagiDBJldfJdIP6GZLfPXyqzPLYiDPlglP431z0fWRh2
        18FHZ7iDAERi9Bd6xHHEFjg42cSryBqEJkP5sPzBIEb2CjCjdcIJq1uO3fWw3qCo6b5PDiYVXMcJu
        Ov97qptjM8N+o4Njcv6IZM4F4rN1C7w557fFCWXqFu+DWY6dhd0dSl9QLz7IKYdnPvz6dsThg7Cn0
        jGGC7mkw==;
Received: from willy by bombadil.infradead.org with local (Exim 4.92.3 #3 (Red Hat Linux))
        id 1jTmtX-0005vj-Is; Wed, 29 Apr 2020 13:36:59 +0000
From:   Matthew Wilcox <willy@infradead.org>
To:     linux-fsdevel@vger.kernel.org
Cc:     "Matthew Wilcox (Oracle)" <willy@infradead.org>,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        Christoph Hellwig <hch@lst.de>
Subject: [PATCH v3 14/25] iomap: Inline data shouldn't see large pages
Date:   Wed, 29 Apr 2020 06:36:46 -0700
Message-Id: <20200429133657.22632-15-willy@infradead.org>
X-Mailer: git-send-email 2.21.1
In-Reply-To: <20200429133657.22632-1-willy@infradead.org>
References: <20200429133657.22632-1-willy@infradead.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: "Matthew Wilcox (Oracle)" <willy@infradead.org>

Assert that we're not seeing large pages in functions that read/write
inline data, rather than zeroing out the tail.

Signed-off-by: Matthew Wilcox (Oracle) <willy@infradead.org>
Reviewed-by: Christoph Hellwig <hch@lst.de>
---
 fs/iomap/buffered-io.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/fs/iomap/buffered-io.c b/fs/iomap/buffered-io.c
index 709be90a1997..e489b8769fcb 100644
--- a/fs/iomap/buffered-io.c
+++ b/fs/iomap/buffered-io.c
@@ -221,6 +221,7 @@ iomap_read_inline_data(struct inode *inode, struct page *page,
 		return;
 
 	BUG_ON(page->index);
+	BUG_ON(PageCompound(page));
 	BUG_ON(size > PAGE_SIZE - offset_in_page(iomap->inline_data));
 
 	addr = kmap_atomic(page);
@@ -732,6 +733,7 @@ iomap_write_end_inline(struct inode *inode, struct page *page,
 	void *addr;
 
 	WARN_ON_ONCE(!PageUptodate(page));
+	BUG_ON(PageCompound(page));
 	BUG_ON(pos + copied > PAGE_SIZE - offset_in_page(iomap->inline_data));
 
 	addr = kmap_atomic(page);
-- 
2.26.2

