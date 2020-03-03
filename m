Return-Path: <SRS0=fZJt=4U=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 349A3C3F2C6
	for <linux-kernel@archiver.kernel.org>; Tue,  3 Mar 2020 08:57:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 17E7F20842
	for <linux-kernel@archiver.kernel.org>; Tue,  3 Mar 2020 08:57:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727941AbgCCI52 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 3 Mar 2020 03:57:28 -0500
Received: from szxga07-in.huawei.com ([45.249.212.35]:50654 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725818AbgCCI51 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Mar 2020 03:57:27 -0500
Received: from DGGEMS408-HUB.china.huawei.com (unknown [172.30.72.60])
        by Forcepoint Email with ESMTP id C58212A6F2CE941394F8;
        Tue,  3 Mar 2020 16:57:20 +0800 (CST)
Received: from szvp000203569.huawei.com (10.120.216.130) by
 DGGEMS408-HUB.china.huawei.com (10.3.19.208) with Microsoft SMTP Server id
 14.3.439.0; Tue, 3 Mar 2020 16:57:10 +0800
From:   Chao Yu <yuchao0@huawei.com>
To:     <jaegeuk@kernel.org>
CC:     <linux-f2fs-devel@lists.sourceforge.net>,
        <linux-kernel@vger.kernel.org>, <chao@kernel.org>,
        Chao Yu <yuchao0@huawei.com>
Subject: [PATCH 2/2] f2fs: compress: add .{init,destroy}_decompress_ctx callback
Date:   Tue, 3 Mar 2020 16:57:07 +0800
Message-ID: <20200303085707.45104-2-yuchao0@huawei.com>
X-Mailer: git-send-email 2.18.0.rc1
In-Reply-To: <20200303085707.45104-1-yuchao0@huawei.com>
References: <20200303085707.45104-1-yuchao0@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.120.216.130]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add below two callback interfaces in struct f2fs_compress_ops:

	int (*init_decompress_ctx)(struct decompress_io_ctx *dic);
	void (*destroy_decompress_ctx)(struct decompress_io_ctx *dic);

Which will be used by zstd compress algorithm later.

In addition, this patch adds callback function pointer check, so that
specified algorithm can avoid defining unneeded functions.

Signed-off-by: Chao Yu <yuchao0@huawei.com>
---
 fs/f2fs/compress.c | 27 +++++++++++++++++++++------
 1 file changed, 21 insertions(+), 6 deletions(-)

diff --git a/fs/f2fs/compress.c b/fs/f2fs/compress.c
index b373102ed4af..6688fe091281 100644
--- a/fs/f2fs/compress.c
+++ b/fs/f2fs/compress.c
@@ -20,6 +20,8 @@ struct f2fs_compress_ops {
 	int (*init_compress_ctx)(struct compress_ctx *cc);
 	void (*destroy_compress_ctx)(struct compress_ctx *cc);
 	int (*compress_pages)(struct compress_ctx *cc);
+	int (*init_decompress_ctx)(struct decompress_io_ctx *dic);
+	void (*destroy_decompress_ctx)(struct decompress_io_ctx *dic);
 	int (*decompress_pages)(struct decompress_io_ctx *dic);
 };
 
@@ -334,9 +336,11 @@ static int f2fs_compress_pages(struct compress_ctx *cc)
 	trace_f2fs_compress_pages_start(cc->inode, cc->cluster_idx,
 				cc->cluster_size, fi->i_compress_algorithm);
 
-	ret = cops->init_compress_ctx(cc);
-	if (ret)
-		goto out;
+	if (cops->init_compress_ctx) {
+		ret = cops->init_compress_ctx(cc);
+		if (ret)
+			goto out;
+	}
 
 	max_len = COMPRESS_HEADER_SIZE + cc->clen;
 	cc->nr_cpages = DIV_ROUND_UP(max_len, PAGE_SIZE);
@@ -398,7 +402,8 @@ static int f2fs_compress_pages(struct compress_ctx *cc)
 		cc->cpages[i] = NULL;
 	}
 
-	cops->destroy_compress_ctx(cc);
+	if (cops->destroy_compress_ctx)
+		cops->destroy_compress_ctx(cc);
 
 	cc->nr_cpages = nr_cpages;
 
@@ -418,7 +423,8 @@ static int f2fs_compress_pages(struct compress_ctx *cc)
 	kfree(cc->cpages);
 	cc->cpages = NULL;
 destroy_compress_ctx:
-	cops->destroy_compress_ctx(cc);
+	if (cops->destroy_compress_ctx)
+		cops->destroy_compress_ctx(cc);
 out:
 	trace_f2fs_compress_pages_end(cc->inode, cc->cluster_idx,
 							cc->clen, ret);
@@ -452,10 +458,16 @@ void f2fs_decompress_pages(struct bio *bio, struct page *page, bool verity)
 		goto out_free_dic;
 	}
 
+	if (cops->init_decompress_ctx) {
+		ret = cops->init_decompress_ctx(dic);
+		if (ret)
+			goto out_free_dic;
+	}
+
 	dic->rbuf = vmap(dic->tpages, dic->cluster_size, VM_MAP, PAGE_KERNEL);
 	if (!dic->rbuf) {
 		ret = -ENOMEM;
-		goto out_free_dic;
+		goto destroy_decompress_ctx;
 	}
 
 	dic->cbuf = vmap(dic->cpages, dic->nr_cpages, VM_MAP, PAGE_KERNEL_RO);
@@ -478,6 +490,9 @@ void f2fs_decompress_pages(struct bio *bio, struct page *page, bool verity)
 	vunmap(dic->cbuf);
 out_vunmap_rbuf:
 	vunmap(dic->rbuf);
+destroy_decompress_ctx:
+	if (cops->destroy_decompress_ctx)
+		cops->destroy_decompress_ctx(dic);
 out_free_dic:
 	if (!verity)
 		f2fs_decompress_end_io(dic->rpages, dic->cluster_size,
-- 
2.18.0.rc1

