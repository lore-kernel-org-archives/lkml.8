Return-Path: <SRS0=LUA0=7L=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C1287C433E0
	for <linux-kernel@archiver.kernel.org>; Fri, 29 May 2020 03:00:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9698C20721
	for <linux-kernel@archiver.kernel.org>; Fri, 29 May 2020 03:00:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="G6/o1Skz"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391730AbgE2DAV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 28 May 2020 23:00:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46062 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2407322AbgE2C6i (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 May 2020 22:58:38 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:e::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 17FCEC008637;
        Thu, 28 May 2020 19:58:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=Content-Transfer-Encoding:
        MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender
        :Reply-To:Content-Type:Content-ID:Content-Description;
        bh=ZvCAGtrDAcAsja+QmzFW6sNRVbIwR7f84uLooOJs50k=; b=G6/o1SkzUI+vKbdXJspiSmkq4i
        0qxhVfZeZ5jLXewappHyXeyvTFFJFmvXH6PZJG9D62B6XPJo1HV4pDCbFrIz7FQNrtxxFm7hcv9Bh
        WZ7TXliWfnjKo+RYXuvGslzANGWAjhyvNgpEwIQ9JxfDdllFyeEpz0Z7zRSyzHOg1FCuGIrxMEsT1
        fjPpbcMzIGUW6igMRqSEfs6LPepYHTM9zLHBkzS7pFw6g3yHB5qNu/QSuCNwAsPkCAzdEpcfiYAX6
        O4i8gsB1pme/Kl7o5WzwD8PNWimcRlEwwfZ7J/PICohml87RYQ+MsK1hBqeu733e++rq8Q2hjTS2I
        cfamU/DQ==;
Received: from willy by bombadil.infradead.org with local (Exim 4.92.3 #3 (Red Hat Linux))
        id 1jeVE3-0008TI-QK; Fri, 29 May 2020 02:58:27 +0000
From:   Matthew Wilcox <willy@infradead.org>
To:     linux-fsdevel@vger.kernel.org
Cc:     "Matthew Wilcox (Oracle)" <willy@infradead.org>,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org
Subject: [PATCH v5 32/39] mm: Support retrieving tail pages from the page cache
Date:   Thu, 28 May 2020 19:58:17 -0700
Message-Id: <20200529025824.32296-33-willy@infradead.org>
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

page->index is not meaningful for tail pages; we have to use
page_to_index() in this assertion.

Signed-off-by: Matthew Wilcox (Oracle) <willy@infradead.org>
---
 mm/filemap.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/mm/filemap.c b/mm/filemap.c
index 0ec7f25a07b2..56eb086acef8 100644
--- a/mm/filemap.c
+++ b/mm/filemap.c
@@ -1655,7 +1655,7 @@ struct page *pagecache_get_page(struct address_space *mapping, pgoff_t index,
 			put_page(page);
 			goto repeat;
 		}
-		VM_BUG_ON_PAGE(page->index != index, page);
+		VM_BUG_ON_PAGE(page_to_index(page) != index, page);
 	}
 
 	if (fgp_flags & FGP_ACCESSED)
-- 
2.26.2

