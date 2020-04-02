Return-Path: <SRS0=iZC5=5S=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7F685C43331
	for <linux-kernel@archiver.kernel.org>; Thu,  2 Apr 2020 06:17:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5B97B2078E
	for <linux-kernel@archiver.kernel.org>; Thu,  2 Apr 2020 06:17:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729061AbgDBGRf (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 2 Apr 2020 02:17:35 -0400
Received: from szxga07-in.huawei.com ([45.249.212.35]:46938 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725789AbgDBGRf (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Apr 2020 02:17:35 -0400
Received: from DGGEMS405-HUB.china.huawei.com (unknown [172.30.72.58])
        by Forcepoint Email with ESMTP id 5DA1D78E4EF831D79B48;
        Thu,  2 Apr 2020 14:17:15 +0800 (CST)
Received: from huawei.com (10.175.124.28) by DGGEMS405-HUB.china.huawei.com
 (10.3.19.205) with Microsoft SMTP Server id 14.3.487.0; Thu, 2 Apr 2020
 14:17:08 +0800
From:   Jason Yan <yanaijie@huawei.com>
To:     <jaegeuk@kernel.org>, <chao@kernel.org>,
        <linux-f2fs-devel@lists.sourceforge.net>,
        <linux-kernel@vger.kernel.org>
CC:     Jason Yan <yanaijie@huawei.com>
Subject: [PATCH -next] f2fs: remove set but not used variable 'params'
Date:   Thu, 2 Apr 2020 14:15:45 +0800
Message-ID: <20200402061545.23208-1-yanaijie@huawei.com>
X-Mailer: git-send-email 2.17.2
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.175.124.28]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fix the following gcc warning:

fs/f2fs/compress.c:375:18: warning: variable 'params' set but not used [-Wunused-but-set-variable]
  ZSTD_parameters params;
                  ^~~~~~

Reported-by: Hulk Robot <hulkci@huawei.com>
Signed-off-by: Jason Yan <yanaijie@huawei.com>
---
 fs/f2fs/compress.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/fs/f2fs/compress.c b/fs/f2fs/compress.c
index f05ecf4cb899..df7b2d15eacd 100644
--- a/fs/f2fs/compress.c
+++ b/fs/f2fs/compress.c
@@ -372,12 +372,10 @@ static int zstd_compress_pages(struct compress_ctx *cc)
 
 static int zstd_init_decompress_ctx(struct decompress_io_ctx *dic)
 {
-	ZSTD_parameters params;
 	ZSTD_DStream *stream;
 	void *workspace;
 	unsigned int workspace_size;
 
-	params = ZSTD_getParams(F2FS_ZSTD_DEFAULT_CLEVEL, dic->clen, 0);
 	workspace_size = ZSTD_DStreamWorkspaceBound(MAX_COMPRESS_WINDOW_SIZE);
 
 	workspace = f2fs_kvmalloc(F2FS_I_SB(dic->inode),
-- 
2.17.2

