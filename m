Return-Path: <SRS0=/Won=67=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D6538C433E1
	for <linux-kernel@archiver.kernel.org>; Sun, 17 May 2020 21:48:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B4CF3207E8
	for <linux-kernel@archiver.kernel.org>; Sun, 17 May 2020 21:48:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=cloud.ionos.com header.i=@cloud.ionos.com header.b="fsRyW6JU"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726855AbgEQVrb (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 17 May 2020 17:47:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42910 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726675AbgEQVr0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 17 May 2020 17:47:26 -0400
Received: from mail-wm1-x344.google.com (mail-wm1-x344.google.com [IPv6:2a00:1450:4864:20::344])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 80222C05BD0C
        for <linux-kernel@vger.kernel.org>; Sun, 17 May 2020 14:47:26 -0700 (PDT)
Received: by mail-wm1-x344.google.com with SMTP id k12so7386119wmj.3
        for <linux-kernel@vger.kernel.org>; Sun, 17 May 2020 14:47:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cloud.ionos.com; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=+sXDQn+tHUOh9SIPzqzmWte4isSDMZVcRgamzXYrMfM=;
        b=fsRyW6JUqPQ1+/hWtCHzifCFhBGggUz6ITJtW7Ztcvq0eZzL9pzaVOQeFm4Qbqsqjd
         pe/ukm8NBWI1UOqbr44aTITm54zpoWXLTUOCQYs58r8ARyXTEeKn7IaQlNLmh31ctU74
         DnzSIYR2KByDxyXL2+CVUIY2KD8fuZTZetvjJKcjqRMdVSyHb9ulrWI/qrLelxg2JgqI
         7h0Y3Z6psRrmTg+qlCYunBGQcgkXV+kTh2qMic4DwpzyQcJpF1KRy8/y9TENRCLv/4D9
         1U9+P49tMec0FSvLHKyG3wtvGs3k2vVqi139PE8B4o+A7rQn3TI7+HBy4H2nSSrf0knZ
         x9Og==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=+sXDQn+tHUOh9SIPzqzmWte4isSDMZVcRgamzXYrMfM=;
        b=DFDg4cgCgPk91ewyp+BDFjrXBkS0H9sroDsttmFapHNjo4wstcgHsuWPqNaSCWiWI3
         JR7y5aHWrQzpi+5Nm0MueCbc9BUPhg0L3I/XcE8c6LA54jYgRnbtyaKaAC36j9BC5F4b
         FTckGs/2Jp9i38fB57h5dMtu3NIrKI5vTMT9/3fsCB2AVzcouqWYHXChw5Nr4OW8dg8V
         yYzbOZYUMrD/F5UvhcymDAM4+us45yd0h7hiXdgFcbEjlUhyCutVnbx/b5yOLpM6HajI
         EWrmVwpaTQGHdWultt2w/TL+15OR8PTc6V6TlLtc+UVbqSt0NzDRZNsqurRqDfLdbV3P
         ydZA==
X-Gm-Message-State: AOAM531Lth9BIHm7Ilvg47psUF+fmrnZZ4Fww8erUHynDZbc4++io9nI
        +wVA+gP5dyxmM2VRlX2NuzCwYg==
X-Google-Smtp-Source: ABdhPJzAh5ZbzGwM484BqH7IgM0CW+qCHHxinBIRHM5LFisVcKfxAOMV4VKIMk3KZTlOHztxEct0Kw==
X-Received: by 2002:a1c:b406:: with SMTP id d6mr15746163wmf.89.1589752045136;
        Sun, 17 May 2020 14:47:25 -0700 (PDT)
Received: from ls00508.pb.local ([2001:1438:4010:2540:bc3e:92a1:7010:2763])
        by smtp.gmail.com with ESMTPSA id v126sm14441244wmb.4.2020.05.17.14.47.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 17 May 2020 14:47:24 -0700 (PDT)
From:   Guoqing Jiang <guoqing.jiang@cloud.ionos.com>
To:     akpm@linux-foundation.org, viro@zeniv.linux.org.uk
Cc:     linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        david@fromorbit.com, hch@infradead.org, willy@infradead.org,
        Guoqing Jiang <guoqing.jiang@cloud.ionos.com>,
        Song Liu <song@kernel.org>, linux-raid@vger.kernel.org
Subject: [PATCH 02/10] md: remove __clear_page_buffers and use attach/detach_page_private
Date:   Sun, 17 May 2020 23:47:10 +0200
Message-Id: <20200517214718.468-3-guoqing.jiang@cloud.ionos.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200517214718.468-1-guoqing.jiang@cloud.ionos.com>
References: <20200517214718.468-1-guoqing.jiang@cloud.ionos.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

After introduce attach/detach_page_private in pagemap.h, we can remove
the duplicat code and call the new functions.

Cc: Song Liu <song@kernel.org>
Cc: linux-raid@vger.kernel.org
Acked-by: Song Liu <song@kernel.org>
Signed-off-by: Guoqing Jiang <guoqing.jiang@cloud.ionos.com>
---
No change since RFC V3.

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

