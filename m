Return-Path: <SRS0=4orP=BD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.0 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C3C62C433DF
	for <linux-kernel@archiver.kernel.org>; Fri, 24 Jul 2020 10:21:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A6D1820714
	for <linux-kernel@archiver.kernel.org>; Fri, 24 Jul 2020 10:21:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726764AbgGXKVu (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 24 Jul 2020 06:21:50 -0400
Received: from szxga06-in.huawei.com ([45.249.212.32]:48130 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726271AbgGXKVt (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Jul 2020 06:21:49 -0400
Received: from DGGEMS411-HUB.china.huawei.com (unknown [172.30.72.58])
        by Forcepoint Email with ESMTP id 1ADC89BEDA3108C50F5C;
        Fri, 24 Jul 2020 18:21:48 +0800 (CST)
Received: from szvp000203569.huawei.com (10.120.216.130) by
 DGGEMS411-HUB.china.huawei.com (10.3.19.211) with Microsoft SMTP Server id
 14.3.487.0; Fri, 24 Jul 2020 18:21:42 +0800
From:   Chao Yu <yuchao0@huawei.com>
To:     <jaegeuk@kernel.org>
CC:     <linux-f2fs-devel@lists.sourceforge.net>,
        <linux-kernel@vger.kernel.org>, <chao@kernel.org>,
        Chao Yu <yuchao0@huawei.com>
Subject: [PATCH 2/2] f2fs: compress: delay temp page allocation
Date:   Fri, 24 Jul 2020 18:21:37 +0800
Message-ID: <20200724102137.78696-2-yuchao0@huawei.com>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20200724102137.78696-1-yuchao0@huawei.com>
References: <20200724102137.78696-1-yuchao0@huawei.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.120.216.130]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Currently, we allocate temp pages which is used to pad hole in
cluster during read IO submission, it may take long time before
releasing them in f2fs_decompress_pages(), since they are only
used as temp output buffer in decompression context, so let's
just do the allocation in that context to reduce time of memory
pool resource occupation.

Signed-off-by: Chao Yu <yuchao0@huawei.com>
---
 fs/f2fs/compress.c | 33 +++++++++++++++++----------------
 1 file changed, 17 insertions(+), 16 deletions(-)

diff --git a/fs/f2fs/compress.c b/fs/f2fs/compress.c
index a20c9f3272af..337a272d7112 100644
--- a/fs/f2fs/compress.c
+++ b/fs/f2fs/compress.c
@@ -670,6 +670,7 @@ void f2fs_decompress_pages(struct bio *bio, struct page *page, bool verity)
 	const struct f2fs_compress_ops *cops =
 			f2fs_cops[fi->i_compress_algorithm];
 	int ret;
+	int i;
 
 	dec_page_count(sbi, F2FS_RD_DATA);
 
@@ -688,6 +689,22 @@ void f2fs_decompress_pages(struct bio *bio, struct page *page, bool verity)
 		goto out_free_dic;
 	}
 
+	dic->tpages = f2fs_kzalloc(sbi, sizeof(struct page *) *
+					dic->cluster_size, GFP_NOFS);
+	if (!dic->tpages)
+		goto out_free_dic;
+
+	for (i = 0; i < dic->cluster_size; i++) {
+		if (dic->rpages[i]) {
+			dic->tpages[i] = dic->rpages[i];
+			continue;
+		}
+
+		dic->tpages[i] = f2fs_compress_alloc_page();
+		if (!dic->tpages[i])
+			goto out_free_dic;
+	}
+
 	if (cops->init_decompress_ctx) {
 		ret = cops->init_decompress_ctx(dic);
 		if (ret)
@@ -1449,22 +1466,6 @@ struct decompress_io_ctx *f2fs_alloc_dic(struct compress_ctx *cc)
 		dic->cpages[i] = page;
 	}
 
-	dic->tpages = f2fs_kzalloc(sbi, sizeof(struct page *) *
-					dic->cluster_size, GFP_NOFS);
-	if (!dic->tpages)
-		goto out_free;
-
-	for (i = 0; i < dic->cluster_size; i++) {
-		if (cc->rpages[i]) {
-			dic->tpages[i] = cc->rpages[i];
-			continue;
-		}
-
-		dic->tpages[i] = f2fs_compress_alloc_page();
-		if (!dic->tpages[i])
-			goto out_free;
-	}
-
 	return dic;
 
 out_free:
-- 
2.26.2

