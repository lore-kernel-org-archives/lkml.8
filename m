Return-Path: <SRS0=KWFo=BR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.0 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2482CC433E0
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Aug 2020 01:23:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 19DC9206B5
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Aug 2020 01:23:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726394AbgHGBXa (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 6 Aug 2020 21:23:30 -0400
Received: from szxga04-in.huawei.com ([45.249.212.190]:9350 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726276AbgHGBX0 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Aug 2020 21:23:26 -0400
Received: from DGGEMS411-HUB.china.huawei.com (unknown [172.30.72.58])
        by Forcepoint Email with ESMTP id 231C2A365779A84C8704;
        Fri,  7 Aug 2020 09:23:24 +0800 (CST)
Received: from szvp000203569.huawei.com (10.120.216.130) by
 DGGEMS411-HUB.china.huawei.com (10.3.19.211) with Microsoft SMTP Server id
 14.3.487.0; Fri, 7 Aug 2020 09:23:13 +0800
From:   Chao Yu <yuchao0@huawei.com>
To:     <jaegeuk@kernel.org>
CC:     <linux-f2fs-devel@lists.sourceforge.net>,
        <linux-kernel@vger.kernel.org>, <chao@kernel.org>,
        Chao Yu <yuchao0@huawei.com>
Subject: [PATCH] f2fs: compress: remove unneeded code
Date:   Fri, 7 Aug 2020 09:23:10 +0800
Message-ID: <20200807012310.112639-1-yuchao0@huawei.com>
X-Mailer: git-send-email 2.26.2
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.120.216.130]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

- f2fs_write_multi_pages
 - f2fs_compress_pages
  - init_compress_ctx
  - compress_pages
  - destroy_compress_ctx  --- 1
 - f2fs_write_compressed_pages
 - destroy_compress_ctx  --- 2

destroy_compress_ctx() in f2fs_write_multi_pages() is redundant, remove
it.

Signed-off-by: Chao Yu <yuchao0@huawei.com>
---
 fs/f2fs/compress.c | 4 ----
 1 file changed, 4 deletions(-)

diff --git a/fs/f2fs/compress.c b/fs/f2fs/compress.c
index 6e7db450006c..3bb112e91cf6 100644
--- a/fs/f2fs/compress.c
+++ b/fs/f2fs/compress.c
@@ -1388,9 +1388,6 @@ int f2fs_write_multi_pages(struct compress_ctx *cc,
 					struct writeback_control *wbc,
 					enum iostat_type io_type)
 {
-	struct f2fs_inode_info *fi = F2FS_I(cc->inode);
-	const struct f2fs_compress_ops *cops =
-			f2fs_cops[fi->i_compress_algorithm];
 	int err;
 
 	*submitted = 0;
@@ -1405,7 +1402,6 @@ int f2fs_write_multi_pages(struct compress_ctx *cc,
 
 		err = f2fs_write_compressed_pages(cc, submitted,
 							wbc, io_type);
-		cops->destroy_compress_ctx(cc);
 		kfree(cc->cpages);
 		cc->cpages = NULL;
 		if (!err)
-- 
2.26.2

