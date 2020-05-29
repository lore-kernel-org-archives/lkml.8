Return-Path: <SRS0=LUA0=7L=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 696DCC433E0
	for <linux-kernel@archiver.kernel.org>; Fri, 29 May 2020 03:03:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 36E4420721
	for <linux-kernel@archiver.kernel.org>; Fri, 29 May 2020 03:03:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="p/4mTPXO"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391822AbgE2DDx (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 28 May 2020 23:03:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46020 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2391647AbgE2C6g (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 May 2020 22:58:36 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:e::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CD14DC08C5C7;
        Thu, 28 May 2020 19:58:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=Content-Transfer-Encoding:
        MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender
        :Reply-To:Content-Type:Content-ID:Content-Description;
        bh=9KvoeAFnUpEm6vX6aegi31mfb0B48oh6WJ2ZQb46Eg0=; b=p/4mTPXO84eibr5G7Cu/wwQ2MD
        YvkRRfwMid53APEQ2o5vgnZ78ThzJG8WRW6grAOH2iOxUfqaRXQav8wS8Z3xQ3gF8aX7z9cYPtgDC
        +8dpO3u9RkcacbYIrK0ymtv+TyfCbve3PYAZjhlx+EV82bve/GiWlPZwUTzvZJKvvAARUtj0NRpLR
        7ls1OnMgh4TxOT9aeFbcBQ0aLQ/JYhZcqkplRZYlKoulVWYl0gi6f5sSU6w5EZWtKe087RpTlPt0H
        jstu2fTWAj1lZG44qMRm4Ksp4l6MLiiYhbpV72AjXtob4Hzm3VzZwyUy61AlT4ltWfgAKi4sluNCH
        te/IC+ag==;
Received: from willy by bombadil.infradead.org with local (Exim 4.92.3 #3 (Red Hat Linux))
        id 1jeVE3-0008Rb-84; Fri, 29 May 2020 02:58:27 +0000
From:   Matthew Wilcox <willy@infradead.org>
To:     linux-fsdevel@vger.kernel.org
Cc:     "Matthew Wilcox (Oracle)" <willy@infradead.org>,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        Christoph Hellwig <hch@lst.de>
Subject: [PATCH v5 18/39] iomap: Inline data shouldn't see large pages
Date:   Thu, 28 May 2020 19:58:03 -0700
Message-Id: <20200529025824.32296-19-willy@infradead.org>
X-Mailer: git-send-email 2.21.1
In-Reply-To: <20200529025824.32296-1-willy@infradead.org>
References: <20200529025824.32296-1-willy@infradead.org>
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
index 8767241ae535..5b37844b7d97 100644
--- a/fs/iomap/buffered-io.c
+++ b/fs/iomap/buffered-io.c
@@ -221,6 +221,7 @@ iomap_read_inline_data(struct inode *inode, struct page *page,
 		return;
 
 	BUG_ON(page->index);
+	BUG_ON(PageCompound(page));
 	BUG_ON(size > PAGE_SIZE - offset_in_page(iomap->inline_data));
 
 	addr = kmap_atomic(page);
@@ -736,6 +737,7 @@ iomap_write_end_inline(struct inode *inode, struct page *page,
 	void *addr;
 
 	WARN_ON_ONCE(!PageUptodate(page));
+	BUG_ON(PageCompound(page));
 	BUG_ON(pos + copied > PAGE_SIZE - offset_in_page(iomap->inline_data));
 
 	addr = kmap_atomic(page);
-- 
2.26.2

