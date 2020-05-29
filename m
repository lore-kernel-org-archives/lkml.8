Return-Path: <SRS0=LUA0=7L=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4B599C433E0
	for <linux-kernel@archiver.kernel.org>; Fri, 29 May 2020 03:03:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1A3F520888
	for <linux-kernel@archiver.kernel.org>; Fri, 29 May 2020 03:03:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="Qd/YWzTp"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391700AbgE2DDV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 28 May 2020 23:03:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46024 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2391659AbgE2C6g (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 May 2020 22:58:36 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:e::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EC57FC008632;
        Thu, 28 May 2020 19:58:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=Content-Transfer-Encoding:
        MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender
        :Reply-To:Content-Type:Content-ID:Content-Description;
        bh=YKb3NpGTsiuUGhpc+X61UYaJ3Rs5k3/gbVypi/+l+Vk=; b=Qd/YWzTpP/lyUCX/Mc1tVy3C08
        n+Zpjb5Jh6UV14RkiERLFn5JhzyGo2VGvztybwOued6PCAp71n6oHv/SLPH2b791Ijl2JOtvks2Xl
        9yP+Xsi8euRfYd3NbVsvNs6/cFUsCuHF8ZpdwPVLcz/QkbgW+0sHFH3JImrjpsQO18bC6spiVj8MW
        dOETWMduENRJyCPPLnZBPwrqdpDfrf/vWe6uYGHwgg++TvgbDvQiJMmtV2Xzx19Lx8v2QeBX5PAio
        qhCYkepa5RM9hAqcFlBypd54GrCupOh418gcSJyQxQNt7KnAIa77miYcpBk7ofqcmn1DJE0ty/Qgl
        wGHJoX2g==;
Received: from willy by bombadil.infradead.org with local (Exim 4.92.3 #3 (Red Hat Linux))
        id 1jeVE3-0008RD-4g; Fri, 29 May 2020 02:58:27 +0000
From:   Matthew Wilcox <willy@infradead.org>
To:     linux-fsdevel@vger.kernel.org
Cc:     "Matthew Wilcox (Oracle)" <willy@infradead.org>,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org
Subject: [PATCH v5 15/39] iomap: Support large pages in invalidatepage
Date:   Thu, 28 May 2020 19:58:00 -0700
Message-Id: <20200529025824.32296-16-willy@infradead.org>
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

If we're punching a hole in a large page, we need to remove the per-page
iomap data, but not clear the dirty bit from the page, so separate the
two conditions.

Signed-off-by: Matthew Wilcox (Oracle) <willy@infradead.org>
---
 fs/iomap/buffered-io.c | 8 ++++++--
 1 file changed, 6 insertions(+), 2 deletions(-)

diff --git a/fs/iomap/buffered-io.c b/fs/iomap/buffered-io.c
index 423ffc9d4a97..23eaaf1de906 100644
--- a/fs/iomap/buffered-io.c
+++ b/fs/iomap/buffered-io.c
@@ -493,17 +493,21 @@ EXPORT_SYMBOL_GPL(iomap_releasepage);
 void
 iomap_invalidatepage(struct page *page, unsigned int offset, unsigned int len)
 {
+	bool full_page = (offset == 0) && (len == thp_size(page));
 	trace_iomap_invalidatepage(page->mapping->host, offset, len);
 
 	/*
 	 * If we are invalidating the entire page, clear the dirty state from it
 	 * and release it to avoid unnecessary buildup of the LRU.
 	 */
-	if (offset == 0 && len == PAGE_SIZE) {
+	if (full_page) {
 		WARN_ON_ONCE(PageWriteback(page));
 		cancel_dirty_page(page);
-		iomap_page_release(page);
 	}
+
+	/* Punching a hole in a THP requires releasing the iop */
+	if (full_page || thp_order(page) > 0)
+		iomap_page_release(page);
 }
 EXPORT_SYMBOL_GPL(iomap_invalidatepage);
 
-- 
2.26.2

