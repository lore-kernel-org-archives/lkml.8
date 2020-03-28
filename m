Return-Path: <SRS0=NZ+o=5N=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1684EC43331
	for <linux-kernel@archiver.kernel.org>; Sat, 28 Mar 2020 09:33:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DB482206F2
	for <linux-kernel@archiver.kernel.org>; Sat, 28 Mar 2020 09:33:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726170AbgC1Jdp (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 28 Mar 2020 05:33:45 -0400
Received: from szxga05-in.huawei.com ([45.249.212.191]:12211 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725865AbgC1Jdp (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 28 Mar 2020 05:33:45 -0400
Received: from DGGEMS402-HUB.china.huawei.com (unknown [172.30.72.59])
        by Forcepoint Email with ESMTP id 87C9AAC658DD25D9171B;
        Sat, 28 Mar 2020 17:33:39 +0800 (CST)
Received: from szvp000203569.huawei.com (10.120.216.130) by
 DGGEMS402-HUB.china.huawei.com (10.3.19.202) with Microsoft SMTP Server id
 14.3.487.0; Sat, 28 Mar 2020 17:33:30 +0800
From:   Chao Yu <yuchao0@huawei.com>
To:     <jaegeuk@kernel.org>
CC:     <linux-f2fs-devel@lists.sourceforge.net>,
        <linux-kernel@vger.kernel.org>, <chao@kernel.org>,
        Chao Yu <yuchao0@huawei.com>
Subject: [PATCH] f2fs: clean up {cic,dic}.ref handling
Date:   Sat, 28 Mar 2020 17:33:23 +0800
Message-ID: <20200328093323.130902-1-yuchao0@huawei.com>
X-Mailer: git-send-email 2.18.0.rc1
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.120.216.130]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

{cic,dic}.ref should be initialized to number of compressed pages,
let's initialize it directly rather than doing w/
f2fs_set_compressed_page().

Signed-off-by: Chao Yu <yuchao0@huawei.com>
---
 fs/f2fs/compress.c | 16 ++++++----------
 1 file changed, 6 insertions(+), 10 deletions(-)

diff --git a/fs/f2fs/compress.c b/fs/f2fs/compress.c
index 9cc279ea3bfb..c0e7ba245c74 100644
--- a/fs/f2fs/compress.c
+++ b/fs/f2fs/compress.c
@@ -55,7 +55,7 @@ bool f2fs_is_compressed_page(struct page *page)
 }
 
 static void f2fs_set_compressed_page(struct page *page,
-		struct inode *inode, pgoff_t index, void *data, refcount_t *r)
+		struct inode *inode, pgoff_t index, void *data)
 {
 	SetPagePrivate(page);
 	set_page_private(page, (unsigned long)data);
@@ -63,8 +63,6 @@ static void f2fs_set_compressed_page(struct page *page,
 	/* i_crypto_info and iv index */
 	page->index = index;
 	page->mapping = inode->i_mapping;
-	if (r)
-		refcount_inc(r);
 }
 
 static void f2fs_put_compressed_page(struct page *page)
@@ -662,7 +660,7 @@ void f2fs_decompress_pages(struct bio *bio, struct page *page, bool verity)
 		cops->destroy_decompress_ctx(dic);
 out_free_dic:
 	if (verity)
-		refcount_add(dic->nr_cpages - 1, &dic->ref);
+		refcount_set(&dic->ref, dic->nr_cpages);
 	if (!verity)
 		f2fs_decompress_end_io(dic->rpages, dic->cluster_size,
 								ret, false);
@@ -1067,7 +1065,7 @@ static int f2fs_write_compressed_pages(struct compress_ctx *cc,
 
 	cic->magic = F2FS_COMPRESSED_PAGE_MAGIC;
 	cic->inode = inode;
-	refcount_set(&cic->ref, 1);
+	refcount_set(&cic->ref, cc->nr_cpages);
 	cic->rpages = f2fs_kzalloc(sbi, sizeof(struct page *) <<
 			cc->log_cluster_size, GFP_NOFS);
 	if (!cic->rpages)
@@ -1077,8 +1075,7 @@ static int f2fs_write_compressed_pages(struct compress_ctx *cc,
 
 	for (i = 0; i < cc->nr_cpages; i++) {
 		f2fs_set_compressed_page(cc->cpages[i], inode,
-					cc->rpages[i + 1]->index,
-					cic, i ? &cic->ref : NULL);
+					cc->rpages[i + 1]->index, cic);
 		fio.compressed_page = cc->cpages[i];
 		if (fio.encrypted) {
 			fio.page = cc->rpages[i + 1];
@@ -1328,7 +1325,7 @@ struct decompress_io_ctx *f2fs_alloc_dic(struct compress_ctx *cc)
 
 	dic->magic = F2FS_COMPRESSED_PAGE_MAGIC;
 	dic->inode = cc->inode;
-	refcount_set(&dic->ref, 1);
+	refcount_set(&dic->ref, cc->nr_cpages);
 	dic->cluster_idx = cc->cluster_idx;
 	dic->cluster_size = cc->cluster_size;
 	dic->log_cluster_size = cc->log_cluster_size;
@@ -1352,8 +1349,7 @@ struct decompress_io_ctx *f2fs_alloc_dic(struct compress_ctx *cc)
 			goto out_free;
 
 		f2fs_set_compressed_page(page, cc->inode,
-					start_idx + i + 1,
-					dic, i ? &dic->ref : NULL);
+					start_idx + i + 1, dic);
 		dic->cpages[i] = page;
 	}
 
-- 
2.18.0.rc1

