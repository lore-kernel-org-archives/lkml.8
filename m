Return-Path: <SRS0=LUA0=7L=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3F606C433DF
	for <linux-kernel@archiver.kernel.org>; Fri, 29 May 2020 02:59:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0E65020814
	for <linux-kernel@archiver.kernel.org>; Fri, 29 May 2020 02:59:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="S30SMl1A"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388880AbgE2C7g (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 28 May 2020 22:59:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46030 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2407400AbgE2C6k (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 May 2020 22:58:40 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:e::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 40D68C08C5CA;
        Thu, 28 May 2020 19:58:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=Content-Transfer-Encoding:
        MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender
        :Reply-To:Content-Type:Content-ID:Content-Description;
        bh=NOeVvS/Xe8KyQK/jGHWOfgM4edh2SPt/XfnzQhgpf2k=; b=S30SMl1AinKd+Zgi5pubws24Mn
        s8xlXkZe1lDBI9STBHnSM5nLj0KNraX38WPIFuCf2pEvjIx4hYqSdy0lciAMVWGgxT2bob9z1iweE
        5gPJn6lppPwxLIoGLEHqu+aGeevNAyQUmO8KHy8i3udRj0jI1OqgXRO28svI1munPlluxG1r+jiWo
        OKFZ5WprUfq1nRDnGtp6p96UjBRUbz9XeBtQOQgsRNDuowsbb3LgmmEiXpbKVCfHtGTKMmEA6mz5w
        fl9b04wNmiOM+EKdDgb/pP0mkwsCnhmZstTeorJT3e1KAhPAEuUYCoKrgN7rJqpdUfBGzvJpLianN
        ppKQEbiw==;
Received: from willy by bombadil.infradead.org with local (Exim 4.92.3 #3 (Red Hat Linux))
        id 1jeVE2-0008QC-QE; Fri, 29 May 2020 02:58:26 +0000
From:   Matthew Wilcox <willy@infradead.org>
To:     linux-fsdevel@vger.kernel.org
Cc:     "Matthew Wilcox (Oracle)" <willy@infradead.org>,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        David Hildenbrand <david@redhat.com>
Subject: [PATCH v5 06/39] mm: Introduce offset_in_thp
Date:   Thu, 28 May 2020 19:57:51 -0700
Message-Id: <20200529025824.32296-7-willy@infradead.org>
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

Mirroring offset_in_page(), this gives you the offset within this
particular page, no matter what size page it is.  It optimises down
to offset_in_page() if CONFIG_TRANSPARENT_HUGEPAGE is not set.

Signed-off-by: Matthew Wilcox (Oracle) <willy@infradead.org>
Reviewed-by: David Hildenbrand <david@redhat.com>
---
 include/linux/mm.h | 1 +
 1 file changed, 1 insertion(+)

diff --git a/include/linux/mm.h b/include/linux/mm.h
index 088acbda722d..9a55dce6a535 100644
--- a/include/linux/mm.h
+++ b/include/linux/mm.h
@@ -1577,6 +1577,7 @@ static inline void clear_page_pfmemalloc(struct page *page)
 extern void pagefault_out_of_memory(void);
 
 #define offset_in_page(p)	((unsigned long)(p) & ~PAGE_MASK)
+#define offset_in_thp(page, p)	((unsigned long)(p) & (thp_size(page) - 1))
 
 /*
  * Flags passed to show_mem() and show_free_areas() to suppress output in
-- 
2.26.2

