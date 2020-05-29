Return-Path: <SRS0=LUA0=7L=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5751DC433DF
	for <linux-kernel@archiver.kernel.org>; Fri, 29 May 2020 03:00:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2D03C20B80
	for <linux-kernel@archiver.kernel.org>; Fri, 29 May 2020 03:00:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="tdfOQN47"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391744AbgE2DAZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 28 May 2020 23:00:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46064 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2407327AbgE2C6i (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 May 2020 22:58:38 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:e::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 23BFCC008638;
        Thu, 28 May 2020 19:58:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=Content-Transfer-Encoding:
        MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender
        :Reply-To:Content-Type:Content-ID:Content-Description;
        bh=EpnkLjZqk1S3DSmVdcLM12MdJ2sgIE4S7yU2k8eu7Iw=; b=tdfOQN47ixQcIS59HBJ/adc3h+
        v161Zlg3qrKZORVIqfucBzRS/BqLXJep/iLDIPzwRTRGgcB58AFsFmZIhE69PDslw1F8cRGPxS+oT
        HfZw8IKOOr100Fgkf69Nv01A51CEcFAQHLp0A4CGOdQPV7/DPC9IFUSDQ5ZOOoLWVty9/l0Cop8DF
        CUcprLI5rM6hJTXn9u6ujR+5177GkD8rE+sRDd1aMces8PmU3K02Rw8/GQUxXlzJJgf87uMC4pjyg
        CUvVL+2AlC7aeFKHs/umeTGLqGa1KIib3FquC958n0zQcBSJLflL/KWwTYPeXW1/+Tbaqgevld405
        zveWKzOw==;
Received: from willy by bombadil.infradead.org with local (Exim 4.92.3 #3 (Red Hat Linux))
        id 1jeVE3-0008TV-SO; Fri, 29 May 2020 02:58:27 +0000
From:   Matthew Wilcox <willy@infradead.org>
To:     linux-fsdevel@vger.kernel.org
Cc:     "Matthew Wilcox (Oracle)" <willy@infradead.org>,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org
Subject: [PATCH v5 33/39] mm: Support tail pages in wait_for_stable_page
Date:   Thu, 28 May 2020 19:58:18 -0700
Message-Id: <20200529025824.32296-34-willy@infradead.org>
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

page->mapping is undefined for tail pages, so operate exclusively on
the head page.

Signed-off-by: Matthew Wilcox (Oracle) <willy@infradead.org>
---
 mm/page-writeback.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/mm/page-writeback.c b/mm/page-writeback.c
index 7326b54ab728..e2da7d7e93b8 100644
--- a/mm/page-writeback.c
+++ b/mm/page-writeback.c
@@ -2841,6 +2841,7 @@ EXPORT_SYMBOL_GPL(wait_on_page_writeback);
  */
 void wait_for_stable_page(struct page *page)
 {
+	page = compound_head(page);
 	if (bdi_cap_stable_pages_required(inode_to_bdi(page->mapping->host)))
 		wait_on_page_writeback(page);
 }
-- 
2.26.2

