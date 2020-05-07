Return-Path: <SRS0=0sZ+=6V=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 79C9BC35280
	for <linux-kernel@archiver.kernel.org>; Thu,  7 May 2020 21:45:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 44D30208DB
	for <linux-kernel@archiver.kernel.org>; Thu,  7 May 2020 21:45:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=cloud.ionos.com header.i=@cloud.ionos.com header.b="BwT/Zh3w"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727859AbgEGVpF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 7 May 2020 17:45:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60620 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726792AbgEGVoV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 May 2020 17:44:21 -0400
Received: from mail-ed1-x542.google.com (mail-ed1-x542.google.com [IPv6:2a00:1450:4864:20::542])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 56C58C05BD09
        for <linux-kernel@vger.kernel.org>; Thu,  7 May 2020 14:44:20 -0700 (PDT)
Received: by mail-ed1-x542.google.com with SMTP id r7so6725906edo.11
        for <linux-kernel@vger.kernel.org>; Thu, 07 May 2020 14:44:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cloud.ionos.com; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=nRmHX3IZZP32x36RObq8cJr3jcmYRzNNrV24AaRSD3Q=;
        b=BwT/Zh3w5Ab/2fyrWKjcImjnCLggazQc5C+NxIqfPv7fWBCfut0N3l156Zqibr5H47
         cI5J4ono9XJ8qJ9rDaMRJlcuwuIZBxSUTRJOrkFEJ9EPJmu38UutefuP0qibEyeDhguL
         sU5BY7JZW4JNRQrJiYUJtzEVYWJpPYwSQZRdF+8sI3Z+F/CK/fiJAysAbbLy+Vp3naDf
         gUQvavWsolWGkgXU9XkGB6E5mPg7vARWDkkNfUITP5FYfD30vkbWgx6WwVpiDtHEOUZZ
         C4ecKMvVonzP+dt4s0jxzpuO3NCSo6CE9eOd9AOyPnNqOtiBMzlmw2TTULpRknpxApAN
         QLNA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=nRmHX3IZZP32x36RObq8cJr3jcmYRzNNrV24AaRSD3Q=;
        b=CdpBRZmAPjUBlt09md37UO99Eithd9JK3X0qakYC5SZu4pkwe8fZ6Y4oh6QntASes6
         0ot6lrUTlsKVZ5DAs/RZBxNCyOOAkPZC3MCviNHhk0VHQiwsGKOqvkNjRCYGEKqOFOP8
         PXIltjnljiiwwckKpDGoJNeYqMUMyIIwj/lAI+bn9ha251QHc7FDdgLRtAW07vUm8SBk
         4CvIhNvqzVq45jcYhYKwh1mUfq/XlLbCLhPXZiWQjiryM8NBJsE8uyYhq7rI9Ho9KyV4
         54pk3xqz2t25VhMsKcZg5PkToqJ/fVV6dxm4tjWrLrK7JfY7EiPCQDy0LIPPjBjHDQu6
         hRPA==
X-Gm-Message-State: AGi0PubOdtzbWXNgr8R5epRXAAyVhVshCaDVUZKpz1GjztucwKaOodGA
        PWygGCaxL07wW0YhKSo2GPJsUQ==
X-Google-Smtp-Source: APiQypLzMcqBJI/17Vgt7qv4BkMPLnn8Kb2liCXz1NippJB7rxuZ91wxVX1EIVwT7gew8QEwlM4s9Q==
X-Received: by 2002:a50:88a6:: with SMTP id d35mr8080403edd.238.1588887859059;
        Thu, 07 May 2020 14:44:19 -0700 (PDT)
Received: from ls00508.pb.local ([2001:1438:4010:2540:a1ee:a39a:b93a:c084])
        by smtp.gmail.com with ESMTPSA id k3sm613530edi.60.2020.05.07.14.44.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 07 May 2020 14:44:18 -0700 (PDT)
From:   Guoqing Jiang <guoqing.jiang@cloud.ionos.com>
To:     linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     david@fromorbit.com, hch@infradead.org, willy@infradead.org,
        Guoqing Jiang <guoqing.jiang@cloud.ionos.com>,
        Song Liu <song@kernel.org>, linux-raid@vger.kernel.org
Subject: [RFC PATCH V3 02/10] md: remove __clear_page_buffers and use attach/detach_page_private
Date:   Thu,  7 May 2020 23:43:52 +0200
Message-Id: <20200507214400.15785-3-guoqing.jiang@cloud.ionos.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200507214400.15785-1-guoqing.jiang@cloud.ionos.com>
References: <20200507214400.15785-1-guoqing.jiang@cloud.ionos.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

After introduce attach/detach_page_private in pagemap.h, we can remove
the duplicat code and call the new functions.

Cc: Song Liu <song@kernel.org>
Cc: linux-raid@vger.kernel.org
Signed-off-by: Guoqing Jiang <guoqing.jiang@cloud.ionos.com>
---
RFC V2 -> RFC V3
1. rename clear_page_private to detach_page_private.

RFC -> RFC V2
1. change the name of new functions to attach/clear_page_private.

 drivers/md/md-bitmap.c | 12 ++----------
 1 file changed, 2 insertions(+), 10 deletions(-)

diff --git a/drivers/md/md-bitmap.c b/drivers/md/md-bitmap.c
index b952bd45bd6a..95a5f3757fa3 100644
--- a/drivers/md/md-bitmap.c
+++ b/drivers/md/md-bitmap.c
@@ -324,14 +324,6 @@ static void end_bitmap_write(struct buffer_head *bh, int uptodate)
 		wake_up(&bitmap->write_wait);
 }
 
-/* copied from buffer.c */
-static void
-__clear_page_buffers(struct page *page)
-{
-	ClearPagePrivate(page);
-	set_page_private(page, 0);
-	put_page(page);
-}
 static void free_buffers(struct page *page)
 {
 	struct buffer_head *bh;
@@ -345,7 +337,7 @@ static void free_buffers(struct page *page)
 		free_buffer_head(bh);
 		bh = next;
 	}
-	__clear_page_buffers(page);
+	detach_page_private(page);
 	put_page(page);
 }
 
@@ -374,7 +366,7 @@ static int read_page(struct file *file, unsigned long index,
 		ret = -ENOMEM;
 		goto out;
 	}
-	attach_page_buffers(page, bh);
+	attach_page_private(page, bh);
 	blk_cur = index << (PAGE_SHIFT - inode->i_blkbits);
 	while (bh) {
 		block = blk_cur;
-- 
2.17.1

