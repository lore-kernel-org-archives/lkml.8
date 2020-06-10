Return-Path: <SRS0=CVC0=7X=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.7 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,UNWANTED_LANGUAGE_BODY,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1557BC433DF
	for <linux-kernel@archiver.kernel.org>; Wed, 10 Jun 2020 20:18:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D8E3C2074B
	for <linux-kernel@archiver.kernel.org>; Wed, 10 Jun 2020 20:17:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="enb+c39t"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728022AbgFJURy (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 10 Jun 2020 16:17:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60498 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730523AbgFJUNs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 Jun 2020 16:13:48 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:e::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C7F7DC08C5C5;
        Wed, 10 Jun 2020 13:13:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=Content-Transfer-Encoding:
        MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender
        :Reply-To:Content-Type:Content-ID:Content-Description;
        bh=gx5dzaclcqLvRwdwg62Y129njOqoREHSy9PwwIfrnGA=; b=enb+c39tttjAMEhbGFU3C4fuYh
        R4EasE+JPjlKSH8Sn5bzwqozpn3biKPMl0hwkAsw8XFfjkSvWEPrS7SGBFQkNs07fk5mky5CE7+qs
        9qopi0rY9KJI4hB2REfzZ1iGt+uyXlr+b22RynpFdk0VNyr4jPkQj8jiJOlFBdnkmCudVD/sZMdSo
        bKpPoO+C5QElTvYW4bnOjLwaCf49QqhXdaJKY49MhLsKJ+JDfD4i0MtB0da5Vy92NwzQhkXnWA+HB
        SU4LPG1hv/DZhXQ4nOaYvdpTFPvzHmgO/bUCKV4WrAUd59s2kF1wn6m5UPJjSbzUePQDu460FbbHq
        i4LHWOAw==;
Received: from willy by bombadil.infradead.org with local (Exim 4.92.3 #3 (Red Hat Linux))
        id 1jj76Z-0003U1-Lf; Wed, 10 Jun 2020 20:13:47 +0000
From:   Matthew Wilcox <willy@infradead.org>
To:     linux-fsdevel@vger.kernel.org
Cc:     "Matthew Wilcox (Oracle)" <willy@infradead.org>,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org
Subject: [PATCH v6 11/51] mm: Add thp_head
Date:   Wed, 10 Jun 2020 13:13:05 -0700
Message-Id: <20200610201345.13273-12-willy@infradead.org>
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

This is like compound_head() but compiles away when
CONFIG_TRANSPARENT_HUGEPAGE is not enabled.

Signed-off-by: Matthew Wilcox (Oracle) <willy@infradead.org>
---
 include/linux/huge_mm.h | 15 +++++++++++++++
 1 file changed, 15 insertions(+)

diff --git a/include/linux/huge_mm.h b/include/linux/huge_mm.h
index dcdfd21763a3..bd13e9ac3437 100644
--- a/include/linux/huge_mm.h
+++ b/include/linux/huge_mm.h
@@ -266,6 +266,15 @@ static inline spinlock_t *pud_trans_huge_lock(pud_t *pud,
 		return NULL;
 }
 
+/**
+ * thp_head - Head page of a transparent huge page.
+ * @page: Any page (tail, head or regular) found in the page cache.
+ */
+static inline struct page *thp_head(struct page *page)
+{
+	return compound_head(page);
+}
+
 /**
  * thp_order - Order of a transparent huge page.
  * @page: Head page of a transparent huge page.
@@ -342,6 +351,12 @@ static inline struct list_head *page_deferred_list(struct page *page)
 #define HPAGE_PUD_MASK ({ BUILD_BUG(); 0; })
 #define HPAGE_PUD_SIZE ({ BUILD_BUG(); 0; })
 
+static inline struct page *thp_head(struct page *page)
+{
+	VM_BUG_ON_PGFLAGS(PageTail(page), page);
+	return page;
+}
+
 static inline unsigned int thp_order(struct page *page)
 {
 	VM_BUG_ON_PGFLAGS(PageTail(page), page);
-- 
2.26.2

