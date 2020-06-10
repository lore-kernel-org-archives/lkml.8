Return-Path: <SRS0=CVC0=7X=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 84F1EC433DF
	for <linux-kernel@archiver.kernel.org>; Wed, 10 Jun 2020 20:15:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 54D30206F7
	for <linux-kernel@archiver.kernel.org>; Wed, 10 Jun 2020 20:15:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="Pbb6eP2r"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728023AbgFJUPK (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 10 Jun 2020 16:15:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60498 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730580AbgFJUNw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 Jun 2020 16:13:52 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:e::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3BD5EC08C5C3;
        Wed, 10 Jun 2020 13:13:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=Content-Transfer-Encoding:
        MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender
        :Reply-To:Content-Type:Content-ID:Content-Description;
        bh=N4mF7LsOQy9p4C9kHzIXaco2T4XYfdDlUPlC4E84MzA=; b=Pbb6eP2rMdef2upRDhntGlFJFl
        IIHSHixhHLaxiEd6ofKCTfBsbQ/+y1OzZB2K1PbAyb3Ia66m+/QoJNRHj+zYjM2ORzsxtO0j1cNtU
        6vmM/l0XviygY97jTLFGdEZ59HXDgvDLExHLt9xYIyRdhdpNG8eADURaLxV7kAIG34vxwcw7hzSU0
        Jsjk7xZgQ4uyEjjgS9WSyA+u1aKrSmHmkHeAuaZ3MlXIxZHuI40FWwCeKfV3K03yBZAgy9g6iLZ45
        qKCqdO2D/5WbMi5iRxQS+8Ah1Ws1HFtamZwPs2dJUY63FAn2yYlx31B5vNQokJ1eyUh9xRr1VmikZ
        bCJEQmVw==;
Received: from willy by bombadil.infradead.org with local (Exim 4.92.3 #3 (Red Hat Linux))
        id 1jj76b-0003Xk-2c; Wed, 10 Jun 2020 20:13:49 +0000
From:   Matthew Wilcox <willy@infradead.org>
To:     linux-fsdevel@vger.kernel.org
Cc:     "Matthew Wilcox (Oracle)" <willy@infradead.org>,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org
Subject: [PATCH v6 44/51] mm: Support retrieving tail pages from the page cache
Date:   Wed, 10 Jun 2020 13:13:38 -0700
Message-Id: <20200610201345.13273-45-willy@infradead.org>
X-Mailer: git-send-email 2.21.1
In-Reply-To: <20200610201345.13273-1-willy@infradead.org>
References: <20200610201345.13273-1-willy@infradead.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: "Matthew Wilcox (Oracle)" <willy@infradead.org>

page->index is not meaningful for tail pages; we have to use
page_to_index() in this assertion.

Signed-off-by: Matthew Wilcox (Oracle) <willy@infradead.org>
---
 mm/filemap.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/mm/filemap.c b/mm/filemap.c
index 17db007f0277..869b970fe1ab 100644
--- a/mm/filemap.c
+++ b/mm/filemap.c
@@ -1652,7 +1652,7 @@ struct page *pagecache_get_page(struct address_space *mapping, pgoff_t index,
 			put_page(page);
 			goto repeat;
 		}
-		VM_BUG_ON_PAGE(page->index != index, page);
+		VM_BUG_ON_PAGE(page_to_index(page) != index, page);
 	}
 
 	if (fgp_flags & FGP_ACCESSED)
-- 
2.26.2

