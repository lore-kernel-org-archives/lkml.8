Return-Path: <SRS0=wESH=6W=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5D85BC38A2A
	for <linux-kernel@archiver.kernel.org>; Fri,  8 May 2020 09:47:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 425AC208D6
	for <linux-kernel@archiver.kernel.org>; Fri,  8 May 2020 09:47:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727082AbgEHJrU (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 8 May 2020 05:47:20 -0400
Received: from szxga04-in.huawei.com ([45.249.212.190]:4351 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725815AbgEHJrU (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 May 2020 05:47:20 -0400
Received: from DGGEMS406-HUB.china.huawei.com (unknown [172.30.72.58])
        by Forcepoint Email with ESMTP id 5F697D520C64F886C4E0;
        Fri,  8 May 2020 17:47:18 +0800 (CST)
Received: from szvp000203569.huawei.com (10.120.216.130) by
 DGGEMS406-HUB.china.huawei.com (10.3.19.206) with Microsoft SMTP Server id
 14.3.487.0; Fri, 8 May 2020 17:47:11 +0800
From:   Chao Yu <yuchao0@huawei.com>
To:     <jaegeuk@kernel.org>
CC:     <linux-f2fs-devel@lists.sourceforge.net>,
        <linux-kernel@vger.kernel.org>, <chao@kernel.org>,
        Chao Yu <yuchao0@huawei.com>
Subject: [PATCH] f2fs: compress: allow lz4 to compress data partially
Date:   Fri, 8 May 2020 17:47:09 +0800
Message-ID: <20200508094709.40048-1-yuchao0@huawei.com>
X-Mailer: git-send-email 2.18.0.rc1
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.120.216.130]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

For lz4 worst compress case, caller should allocate buffer with size
of LZ4_compressBound(inputsize) for target compressed data storing.

However lz4 supports partial data compression, so we can get rid of
output buffer size limitation now, then we can avoid 2 * 4KB size
intermediate buffer allocation when log_cluster_size is 2, and avoid
unnecessary compressing work of compressor if we can not save at
least 4KB space.

Suggested-by: Daeho Jeong <daehojeong@google.com>
Signed-off-by: Chao Yu <yuchao0@huawei.com>
---
 fs/f2fs/compress.c | 15 +++++++++------
 1 file changed, 9 insertions(+), 6 deletions(-)

diff --git a/fs/f2fs/compress.c b/fs/f2fs/compress.c
index 5e4947250262..23825f559bcf 100644
--- a/fs/f2fs/compress.c
+++ b/fs/f2fs/compress.c
@@ -228,7 +228,12 @@ static int lz4_init_compress_ctx(struct compress_ctx *cc)
 	if (!cc->private)
 		return -ENOMEM;
 
-	cc->clen = LZ4_compressBound(PAGE_SIZE << cc->log_cluster_size);
+	/*
+	 * we do not change cc->clen to LZ4_compressBound(inputsize) to
+	 * adapt worst compress case, because lz4 algorithm supports partial
+	 * compression.
+	 */
+	cc->clen = cc->rlen - PAGE_SIZE - COMPRESS_HEADER_SIZE;
 	return 0;
 }
 
@@ -244,11 +249,9 @@ static int lz4_compress_pages(struct compress_ctx *cc)
 
 	len = LZ4_compress_default(cc->rbuf, cc->cbuf->cdata, cc->rlen,
 						cc->clen, cc->private);
-	if (!len) {
-		printk_ratelimited("%sF2FS-fs (%s): lz4 compress failed\n",
-				KERN_ERR, F2FS_I_SB(cc->inode)->sb->s_id);
-		return -EIO;
-	}
+	if (!len)
+		return -EAGAIN;
+
 	cc->clen = len;
 	return 0;
 }
-- 
2.18.0.rc1

