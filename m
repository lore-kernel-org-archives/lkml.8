Return-Path: <SRS0=CVC0=7X=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 49A6CC433E0
	for <linux-kernel@archiver.kernel.org>; Wed, 10 Jun 2020 20:16:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 196CC2065C
	for <linux-kernel@archiver.kernel.org>; Wed, 10 Jun 2020 20:16:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="kzXLN9R5"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730902AbgFJUQk (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 10 Jun 2020 16:16:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60524 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730549AbgFJUNu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 Jun 2020 16:13:50 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:e::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 557C8C00862D;
        Wed, 10 Jun 2020 13:13:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=Content-Transfer-Encoding:
        MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender
        :Reply-To:Content-Type:Content-ID:Content-Description;
        bh=ZdmHI6xA8It9U2TlgFLx4kPuqY4+rF2vVFre5EFi3Ak=; b=kzXLN9R5EqQ0rOFb3IvKNQFB95
        gcRS4OD44bdayszrjbTk5VR2un4Ss2fUTtW86fPimwIsWyHg9S8wTmoag/6dtNpsyaBfBRgVnuZEv
        VVevEOiXoa1RCDIuimQ7iOalqNeUusacHTopUoDke0oCtn/XDQkk9zDB4d4bWZDnEWxyQDV/PqNlo
        dZGOScNRnJpoyKJWYoSeakEOz2CQ03uOWGE+ZXJE+MW3iGv/pI2KqfA1DAbQQn5E3s7PjtXvFMqSl
        OvH/poDMCVaIQB/DZa3mOYICYxSbiH+e3zsvgr43516uZdgqTE+ZZMRAUWXkOFKPC/Qhn7KYnvg/T
        E2AE87Ng==;
Received: from willy by bombadil.infradead.org with local (Exim 4.92.3 #3 (Red Hat Linux))
        id 1jj76Z-0003U6-NE; Wed, 10 Jun 2020 20:13:47 +0000
From:   Matthew Wilcox <willy@infradead.org>
To:     linux-fsdevel@vger.kernel.org
Cc:     "Matthew Wilcox (Oracle)" <willy@infradead.org>,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        David Hildenbrand <david@redhat.com>
Subject: [PATCH v6 12/51] mm: Introduce offset_in_thp
Date:   Wed, 10 Jun 2020 13:13:06 -0700
Message-Id: <20200610201345.13273-13-willy@infradead.org>
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

Mirroring offset_in_page(), this gives you the offset within this
particular page, no matter what size page it is.  It optimises down
to offset_in_page() if CONFIG_TRANSPARENT_HUGEPAGE is not set.

Signed-off-by: Matthew Wilcox (Oracle) <willy@infradead.org>
Reviewed-by: David Hildenbrand <david@redhat.com>
---
 include/linux/mm.h | 1 +
 1 file changed, 1 insertion(+)

diff --git a/include/linux/mm.h b/include/linux/mm.h
index 6c29b663135f..3fc7e8121216 100644
--- a/include/linux/mm.h
+++ b/include/linux/mm.h
@@ -1583,6 +1583,7 @@ static inline void clear_page_pfmemalloc(struct page *page)
 extern void pagefault_out_of_memory(void);
 
 #define offset_in_page(p)	((unsigned long)(p) & ~PAGE_MASK)
+#define offset_in_thp(page, p)	((unsigned long)(p) & (thp_size(page) - 1))
 
 /*
  * Flags passed to show_mem() and show_free_areas() to suppress output in
-- 
2.26.2

