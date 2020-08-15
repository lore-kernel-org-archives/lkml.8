Return-Path: <SRS0=qJsj=BZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.0 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EB222C433E1
	for <linux-kernel@archiver.kernel.org>; Sat, 15 Aug 2020 22:00:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D1AA823358
	for <linux-kernel@archiver.kernel.org>; Sat, 15 Aug 2020 22:00:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729634AbgHOWAQ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 15 Aug 2020 18:00:16 -0400
Received: from mailex.mailcore.me ([94.136.40.62]:44384 "EHLO
        mailex.mailcore.me" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729445AbgHOWAN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 15 Aug 2020 18:00:13 -0400
Received: from 82-69-79-175.dsl.in-addr.zen.co.uk ([82.69.79.175] helo=phoenix.fritz.box)
        by smtp04.mailcore.me with esmtpa (Exim 4.92.3)
        (envelope-from <phillip@squashfs.org.uk>)
        id 1k6nJo-0006KR-8t; Sat, 15 Aug 2020 04:57:20 +0100
From:   Phillip Lougher <phillip@squashfs.org.uk>
To:     linux-kernel@vger.kernel.org
Cc:     akpm@linux-foundation.org, pliard@google.com, hch@lst.de,
        adrien+dev@schischi.me, groeck@chromium.org, drosen@google.com,
        Phillip Lougher <phillip@squashfs.org.uk>,
        Nicolas Prochazka <nicolas.prochazka@gmail.com>,
        Tomoatsu Shimada <shimada@walbrix.com>
Subject: [PATCH] squashfs: avoid bio_alloc() failure with 1Mbyte blocks
Date:   Sat, 15 Aug 2020 04:56:37 +0100
Message-Id: <20200815035637.15319-1-phillip@squashfs.org.uk>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailcore-Auth: 439913985
X-Mailcore-Domain: 1686784
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This is a regression introduced by the "migrate from ll_rw_block usage
to BIO" patch.

Bio_alloc() is limited to 256 pages (1 Mbyte).   This can cause a
failure when reading 1 Mbyte block filesystems.  The problem is
a datablock can be fully (or almost uncompressed), requiring 256
pages, but, because blocks are not aligned to page boundaries, it
may require 257 pages to read.

Bio_kmalloc() can handle 1024 pages, and so use this for the
edge condition.

Reported-by: Nicolas Prochazka <nicolas.prochazka@gmail.com>
Reported-by: Tomoatsu Shimada <shimada@walbrix.com>
Signed-off-by: Phillip Lougher <phillip@squashfs.org.uk>
---
 fs/squashfs/block.c | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/fs/squashfs/block.c b/fs/squashfs/block.c
index 76bb1c846845..8a19773b5a0b 100644
--- a/fs/squashfs/block.c
+++ b/fs/squashfs/block.c
@@ -87,7 +87,11 @@ static int squashfs_bio_read(struct super_block *sb, u64 index, int length,
 	int error, i;
 	struct bio *bio;
 
-	bio = bio_alloc(GFP_NOIO, page_count);
+	if (page_count <= BIO_MAX_PAGES)
+		bio = bio_alloc(GFP_NOIO, page_count);
+	else
+		bio = bio_kmalloc(GFP_NOIO, page_count);
+
 	if (!bio)
 		return -ENOMEM;
 
-- 
2.20.1

