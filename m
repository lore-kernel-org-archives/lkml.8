Return-Path: <SRS0=52rg=4G=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3AE0AC34026
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Feb 2020 10:22:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1B03321D7D
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Feb 2020 10:22:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726610AbgBRKWi (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 18 Feb 2020 05:22:38 -0500
Received: from szxga07-in.huawei.com ([45.249.212.35]:40680 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726557AbgBRKWi (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Feb 2020 05:22:38 -0500
Received: from DGGEMS404-HUB.china.huawei.com (unknown [172.30.72.59])
        by Forcepoint Email with ESMTP id 8C999F519A43A6A7AAB9;
        Tue, 18 Feb 2020 18:22:35 +0800 (CST)
Received: from szvp000203569.huawei.com (10.120.216.130) by
 DGGEMS404-HUB.china.huawei.com (10.3.19.204) with Microsoft SMTP Server id
 14.3.439.0; Tue, 18 Feb 2020 18:22:28 +0800
From:   Chao Yu <yuchao0@huawei.com>
To:     <jaegeuk@kernel.org>
CC:     <linux-f2fs-devel@lists.sourceforge.net>,
        <linux-kernel@vger.kernel.org>, <chao@kernel.org>,
        Chao Yu <yuchao0@huawei.com>
Subject: [PATCH 2/3] f2fs: fix to avoid triggering IO in write path
Date:   Tue, 18 Feb 2020 18:21:35 +0800
Message-ID: <20200218102136.32150-2-yuchao0@huawei.com>
X-Mailer: git-send-email 2.18.0.rc1
In-Reply-To: <20200218102136.32150-1-yuchao0@huawei.com>
References: <20200218102136.32150-1-yuchao0@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.120.216.130]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

If we are in write IO path, we need to avoid using GFP_KERNEL.

Signed-off-by: Chao Yu <yuchao0@huawei.com>
---
 fs/f2fs/compress.c |  2 +-
 fs/f2fs/data.c     | 24 +++++++++++++-----------
 fs/f2fs/f2fs.h     |  2 +-
 3 files changed, 15 insertions(+), 13 deletions(-)

diff --git a/fs/f2fs/compress.c b/fs/f2fs/compress.c
index b9ea531ffbb6..b1bc057ee266 100644
--- a/fs/f2fs/compress.c
+++ b/fs/f2fs/compress.c
@@ -653,7 +653,7 @@ static int prepare_compress_overwrite(struct compress_ctx *cc,
 		struct bio *bio = NULL;
 
 		ret = f2fs_read_multi_pages(cc, &bio, cc->cluster_size,
-						&last_block_in_bio, false);
+					&last_block_in_bio, false, true);
 		f2fs_destroy_compress_ctx(cc);
 		if (ret)
 			goto release_pages;
diff --git a/fs/f2fs/data.c b/fs/f2fs/data.c
index 3a4ece26928c..716277d6be48 100644
--- a/fs/f2fs/data.c
+++ b/fs/f2fs/data.c
@@ -924,14 +924,15 @@ static inline bool f2fs_need_verity(const struct inode *inode, pgoff_t idx)
 
 static struct bio *f2fs_grab_read_bio(struct inode *inode, block_t blkaddr,
 				      unsigned nr_pages, unsigned op_flag,
-				      pgoff_t first_idx)
+				      pgoff_t first_idx, bool for_write)
 {
 	struct f2fs_sb_info *sbi = F2FS_I_SB(inode);
 	struct bio *bio;
 	struct bio_post_read_ctx *ctx;
 	unsigned int post_read_steps = 0;
 
-	bio = f2fs_bio_alloc(sbi, min_t(int, nr_pages, BIO_MAX_PAGES), false);
+	bio = f2fs_bio_alloc(sbi, min_t(int, nr_pages, BIO_MAX_PAGES),
+								for_write);
 	if (!bio)
 		return ERR_PTR(-ENOMEM);
 	f2fs_target_device(sbi, blkaddr, bio);
@@ -966,12 +967,12 @@ static void f2fs_release_read_bio(struct bio *bio)
 
 /* This can handle encryption stuffs */
 static int f2fs_submit_page_read(struct inode *inode, struct page *page,
-							block_t blkaddr)
+						block_t blkaddr, bool for_write)
 {
 	struct f2fs_sb_info *sbi = F2FS_I_SB(inode);
 	struct bio *bio;
 
-	bio = f2fs_grab_read_bio(inode, blkaddr, 1, 0, page->index);
+	bio = f2fs_grab_read_bio(inode, blkaddr, 1, 0, page->index, for_write);
 	if (IS_ERR(bio))
 		return PTR_ERR(bio);
 
@@ -1157,7 +1158,7 @@ struct page *f2fs_get_read_data_page(struct inode *inode, pgoff_t index,
 		return page;
 	}
 
-	err = f2fs_submit_page_read(inode, page, dn.data_blkaddr);
+	err = f2fs_submit_page_read(inode, page, dn.data_blkaddr, for_write);
 	if (err)
 		goto put_err;
 	return page;
@@ -1974,7 +1975,8 @@ static int f2fs_read_single_page(struct inode *inode, struct page *page,
 	}
 	if (bio == NULL) {
 		bio = f2fs_grab_read_bio(inode, block_nr, nr_pages,
-				is_readahead ? REQ_RAHEAD : 0, page->index);
+				is_readahead ? REQ_RAHEAD : 0, page->index,
+				false);
 		if (IS_ERR(bio)) {
 			ret = PTR_ERR(bio);
 			bio = NULL;
@@ -2009,7 +2011,7 @@ static int f2fs_read_single_page(struct inode *inode, struct page *page,
 #ifdef CONFIG_F2FS_FS_COMPRESSION
 int f2fs_read_multi_pages(struct compress_ctx *cc, struct bio **bio_ret,
 				unsigned nr_pages, sector_t *last_block_in_bio,
-				bool is_readahead)
+				bool is_readahead, bool for_write)
 {
 	struct dnode_of_data dn;
 	struct inode *inode = cc->inode;
@@ -2103,7 +2105,7 @@ int f2fs_read_multi_pages(struct compress_ctx *cc, struct bio **bio_ret,
 		if (!bio) {
 			bio = f2fs_grab_read_bio(inode, blkaddr, nr_pages,
 					is_readahead ? REQ_RAHEAD : 0,
-					page->index);
+					page->index, for_write);
 			if (IS_ERR(bio)) {
 				ret = PTR_ERR(bio);
 				bio = NULL;
@@ -2208,7 +2210,7 @@ int f2fs_mpage_readpages(struct address_space *mapping,
 				ret = f2fs_read_multi_pages(&cc, &bio,
 							max_nr_pages,
 							&last_block_in_bio,
-							is_readahead);
+							is_readahead, false);
 				f2fs_destroy_compress_ctx(&cc);
 				if (ret)
 					goto set_error_page;
@@ -2251,7 +2253,7 @@ int f2fs_mpage_readpages(struct address_space *mapping,
 				ret = f2fs_read_multi_pages(&cc, &bio,
 							max_nr_pages,
 							&last_block_in_bio,
-							is_readahead);
+							is_readahead, false);
 				f2fs_destroy_compress_ctx(&cc);
 			}
 		}
@@ -3291,7 +3293,7 @@ static int f2fs_write_begin(struct file *file, struct address_space *mapping,
 			err = -EFSCORRUPTED;
 			goto fail;
 		}
-		err = f2fs_submit_page_read(inode, page, blkaddr);
+		err = f2fs_submit_page_read(inode, page, blkaddr, true);
 		if (err)
 			goto fail;
 
diff --git a/fs/f2fs/f2fs.h b/fs/f2fs/f2fs.h
index 65f569949d42..5d047c0bbbbb 100644
--- a/fs/f2fs/f2fs.h
+++ b/fs/f2fs/f2fs.h
@@ -3799,7 +3799,7 @@ int f2fs_write_multi_pages(struct compress_ctx *cc,
 int f2fs_is_compressed_cluster(struct inode *inode, pgoff_t index);
 int f2fs_read_multi_pages(struct compress_ctx *cc, struct bio **bio_ret,
 				unsigned nr_pages, sector_t *last_block_in_bio,
-				bool is_readahead);
+				bool is_readahead, bool for_write);
 struct decompress_io_ctx *f2fs_alloc_dic(struct compress_ctx *cc);
 void f2fs_free_dic(struct decompress_io_ctx *dic);
 void f2fs_decompress_end_io(struct page **rpages,
-- 
2.18.0.rc1

