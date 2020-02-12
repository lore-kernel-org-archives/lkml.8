Return-Path: <SRS0=shi3=4A=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7E95AC2BA83
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Feb 2020 04:20:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 56AC32082F
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Feb 2020 04:20:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="mal+r4/h"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728216AbgBLEUO (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 11 Feb 2020 23:20:14 -0500
Received: from bombadil.infradead.org ([198.137.202.133]:53888 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727963AbgBLESq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Feb 2020 23:18:46 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=Content-Transfer-Encoding:
        MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender
        :Reply-To:Content-Type:Content-ID:Content-Description;
        bh=Kw58gaPv+7G0ZzcrVuIkBegsWMsGq2FXs/Of17fNElw=; b=mal+r4/hnQop8UfcokebKYPdWH
        QakKSQKRGopYdR/y5IwkPMXDj+TzY65rYD857LwOYVY3BwyfthEHdBIJwtgW7PJc92A4zSeOhDE6A
        ol8njve22guWjTH1ZN0rlVNVpKZbD+nwTbSl2kMw5KawiE5uMVi7Ov0r8CTY+gUY6Yiw4bfR3aPMl
        poW55S1VNKJ2nym/OaNZxHoxi2m5Yj16Wl9LwaHREI8mBQU5e/li4ijO+rbv2FTBBVfu/JPKoUu1E
        7caUPh3pIAyqpTmz/fJwTdZgeV9V9Vm6+MVimiv3Mo1VYsSmT6tKmy/9atmLWdqGvdSFrOZWtN+FU
        UA9jI2sw==;
Received: from willy by bombadil.infradead.org with local (Exim 4.92.3 #3 (Red Hat Linux))
        id 1j1jU6-0006md-Ke; Wed, 12 Feb 2020 04:18:46 +0000
From:   Matthew Wilcox <willy@infradead.org>
To:     linux-fsdevel@vger.kernel.org, linux-mm@kvack.org
Cc:     "Matthew Wilcox (Oracle)" <willy@infradead.org>,
        linux-kernel@vger.kernel.org
Subject: [PATCH v2 04/25] mm: Unexport find_get_entry
Date:   Tue, 11 Feb 2020 20:18:24 -0800
Message-Id: <20200212041845.25879-5-willy@infradead.org>
X-Mailer: git-send-email 2.21.1
In-Reply-To: <20200212041845.25879-1-willy@infradead.org>
References: <20200212041845.25879-1-willy@infradead.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: "Matthew Wilcox (Oracle)" <willy@infradead.org>

No in-tree users (proc, madvise, memcg, mincore) can be built as a module.

Signed-off-by: Matthew Wilcox (Oracle) <willy@infradead.org>
---
 mm/filemap.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/mm/filemap.c b/mm/filemap.c
index 1beb7716276b..83ce9ce0bee1 100644
--- a/mm/filemap.c
+++ b/mm/filemap.c
@@ -1536,7 +1536,6 @@ struct page *find_get_entry(struct address_space *mapping, pgoff_t offset)
 
 	return page;
 }
-EXPORT_SYMBOL(find_get_entry);
 
 /**
  * find_lock_entry - locate, pin and lock a page cache entry
-- 
2.25.0

