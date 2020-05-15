Return-Path: <SRS0=BsgQ=65=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5D808C433E2
	for <linux-kernel@archiver.kernel.org>; Fri, 15 May 2020 13:18:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 309B720759
	for <linux-kernel@archiver.kernel.org>; Fri, 15 May 2020 13:18:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="FLROOFg5"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728000AbgEONSq (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 15 May 2020 09:18:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51234 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726465AbgEONRC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 May 2020 09:17:02 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:e::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CB9A0C05BD13;
        Fri, 15 May 2020 06:17:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=Content-Transfer-Encoding:
        MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender
        :Reply-To:Content-Type:Content-ID:Content-Description;
        bh=FXuYLfOOUqxYWErosUnOKtFWf/8GnaS/MYoQGYunbOM=; b=FLROOFg5qEg5Rihr1eJZZn6DZS
        I72CJ7wR+QVI6Pe8yv26zoadigrAUi5HDw7QwVntYKg/gkKWgw9AkSpDCgoL9wKOLEKUIXeJ3kVut
        MKxeBNt01O/Ursgz7KLTIfkNNMi0SsBKAKYgb09hlpNUnsdhROZjd+Di3doKBGOZnhchUKpE0AdAg
        IEi4olTZl5LC9nRojXJeuxbs4gUw2qWScd9npF7Y7wGCzshZMnBFENeh5S0kfQ6Dox05nhL3+R6/y
        Ndg31NnKTGSkofRnNmyBp7aQThjcpkCVuihZZnpS1cs47OTIf/fbw3xUxKcxmodP+M1UUk0sq+QpH
        rL3mFmCg==;
Received: from willy by bombadil.infradead.org with local (Exim 4.92.3 #3 (Red Hat Linux))
        id 1jZaCz-0005ew-KV; Fri, 15 May 2020 13:17:01 +0000
From:   Matthew Wilcox <willy@infradead.org>
To:     linux-fsdevel@vger.kernel.org
Cc:     "Matthew Wilcox (Oracle)" <willy@infradead.org>,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        Christoph Hellwig <hch@lst.de>
Subject: [PATCH v4 17/36] iomap: Inline data shouldn't see large pages
Date:   Fri, 15 May 2020 06:16:37 -0700
Message-Id: <20200515131656.12890-18-willy@infradead.org>
X-Mailer: git-send-email 2.21.1
In-Reply-To: <20200515131656.12890-1-willy@infradead.org>
References: <20200515131656.12890-1-willy@infradead.org>
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
index b7504b8aa90c..782757258a28 100644
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

