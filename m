Return-Path: <SRS0=LUA0=7L=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0C4C4C433E0
	for <linux-kernel@archiver.kernel.org>; Fri, 29 May 2020 02:59:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D0F362075F
	for <linux-kernel@archiver.kernel.org>; Fri, 29 May 2020 02:59:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="LSg3zjLm"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391675AbgE2C7R (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 28 May 2020 22:59:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46046 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2407336AbgE2C6j (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 May 2020 22:58:39 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:e::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2DE78C008639;
        Thu, 28 May 2020 19:58:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=Content-Transfer-Encoding:
        MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender
        :Reply-To:Content-Type:Content-ID:Content-Description;
        bh=3qQKXoQh4g5s8eDI27YZDDnW8Glo9jzDEC+FUmQG6Xw=; b=LSg3zjLmffQHADrEul/AJqBr/D
        G+SIrQRxm2P3vQv3+86yfDMdR9C61SYmTr1u4o7pqrtbt4Xq4NXQmEcYh9syXEpgo6uzz1uRwZp40
        R093rV/2v5K+1NdC+tHqxsVA8+CsIuh4Lf/KHZB5M2Bltc5YpMSj2duRilK7s4WrIynpH+XibWYfy
        t2G/eqQTyJrykbUvBHOt7FjuzwBMttlCU9QGSnIYhu1jm0pP/OuXmqzR7mjEZoEUHl25YOJ0uiQAn
        2Y/zGT1bqZxrOV9M8Sq2XwmPpahh3rBkyz65XwaH8sHnK8qq22mvGQOxD/nJGMwV0HqFKV1CMC3a4
        jG0Dl3BQ==;
Received: from willy by bombadil.infradead.org with local (Exim 4.92.3 #3 (Red Hat Linux))
        id 1jeVE3-0008Td-TR; Fri, 29 May 2020 02:58:27 +0000
From:   Matthew Wilcox <willy@infradead.org>
To:     linux-fsdevel@vger.kernel.org
Cc:     "Matthew Wilcox (Oracle)" <willy@infradead.org>,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org
Subject: [PATCH v5 34/39] mm: Add DEFINE_READAHEAD
Date:   Thu, 28 May 2020 19:58:19 -0700
Message-Id: <20200529025824.32296-35-willy@infradead.org>
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

Allow for a more concise definition of a struct readahead_control.

Signed-off-by: Matthew Wilcox (Oracle) <willy@infradead.org>
---
 include/linux/pagemap.h | 7 +++++++
 mm/readahead.c          | 6 +-----
 2 files changed, 8 insertions(+), 5 deletions(-)

diff --git a/include/linux/pagemap.h b/include/linux/pagemap.h
index 0b4a4b62b585..84ba69477e3b 100644
--- a/include/linux/pagemap.h
+++ b/include/linux/pagemap.h
@@ -719,6 +719,13 @@ struct readahead_control {
 	unsigned int _batch_count;
 };
 
+#define DEFINE_READAHEAD(rac, f, m, i)					\
+	struct readahead_control rac = {				\
+		.file = f,						\
+		.mapping = m,						\
+		._index = i,						\
+	}
+
 /**
  * readahead_page - Get the next page to read.
  * @rac: The current readahead request.
diff --git a/mm/readahead.c b/mm/readahead.c
index 3c9a8dd7c56c..2126a2754e22 100644
--- a/mm/readahead.c
+++ b/mm/readahead.c
@@ -179,11 +179,7 @@ void page_cache_readahead_unbounded(struct address_space *mapping,
 {
 	LIST_HEAD(page_pool);
 	gfp_t gfp_mask = readahead_gfp_mask(mapping);
-	struct readahead_control rac = {
-		.mapping = mapping,
-		.file = file,
-		._index = index,
-	};
+	DEFINE_READAHEAD(rac, file, mapping, index);
 	unsigned long i;
 
 	/*
-- 
2.26.2

