Return-Path: <SRS0=Mt+e=5P=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 17AFAC43331
	for <linux-kernel@archiver.kernel.org>; Mon, 30 Mar 2020 10:04:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E3252206E6
	for <linux-kernel@archiver.kernel.org>; Mon, 30 Mar 2020 10:04:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728801AbgC3KEI (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 30 Mar 2020 06:04:08 -0400
Received: from szxga05-in.huawei.com ([45.249.212.191]:12215 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727522AbgC3KEH (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 Mar 2020 06:04:07 -0400
Received: from DGGEMS403-HUB.china.huawei.com (unknown [172.30.72.60])
        by Forcepoint Email with ESMTP id C8A8DB2069DA181647F6;
        Mon, 30 Mar 2020 18:04:03 +0800 (CST)
Received: from szvp000203569.huawei.com (10.120.216.130) by
 DGGEMS403-HUB.china.huawei.com (10.3.19.203) with Microsoft SMTP Server id
 14.3.487.0; Mon, 30 Mar 2020 18:03:57 +0800
From:   Chao Yu <yuchao0@huawei.com>
To:     <jaegeuk@kernel.org>
CC:     <linux-f2fs-devel@lists.sourceforge.net>,
        <linux-kernel@vger.kernel.org>, <chao@kernel.org>,
        Chao Yu <yuchao0@huawei.com>
Subject: [PATCH] f2fs: use round_up()/DIV_ROUND_UP()
Date:   Mon, 30 Mar 2020 18:03:49 +0800
Message-ID: <20200330100349.56127-1-yuchao0@huawei.com>
X-Mailer: git-send-email 2.18.0.rc1
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.120.216.130]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

.i_cluster_size should be power of 2, so we can use round_up() instead
of roundup() to enhance the calculation.

In addition, use DIV_ROUND_UP to clean up codes.

Signed-off-by: Chao Yu <yuchao0@huawei.com>
---
 fs/f2fs/data.c | 16 ++++++----------
 fs/f2fs/file.c | 17 +++++------------
 2 files changed, 11 insertions(+), 22 deletions(-)

diff --git a/fs/f2fs/data.c b/fs/f2fs/data.c
index 0a829a89f596..8257d5e7aa3b 100644
--- a/fs/f2fs/data.c
+++ b/fs/f2fs/data.c
@@ -1969,8 +1969,6 @@ static int f2fs_read_single_page(struct inode *inode, struct page *page,
 					bool is_readahead)
 {
 	struct bio *bio = *bio_ret;
-	const unsigned blkbits = inode->i_blkbits;
-	const unsigned blocksize = 1 << blkbits;
 	sector_t block_in_file;
 	sector_t last_block;
 	sector_t last_block_in_file;
@@ -1979,8 +1977,8 @@ static int f2fs_read_single_page(struct inode *inode, struct page *page,
 
 	block_in_file = (sector_t)page_index(page);
 	last_block = block_in_file + nr_pages;
-	last_block_in_file = (f2fs_readpage_limit(inode) + blocksize - 1) >>
-							blkbits;
+	last_block_in_file = DIV_ROUND_UP(f2fs_readpage_limit(inode),
+								PAGE_SIZE);
 	if (last_block > last_block_in_file)
 		last_block = last_block_in_file;
 
@@ -2062,7 +2060,7 @@ static int f2fs_read_single_page(struct inode *inode, struct page *page,
 	 */
 	f2fs_wait_on_block_writeback(inode, block_nr);
 
-	if (bio_add_page(bio, page, blocksize, 0) < blocksize)
+	if (bio_add_page(bio, page, PAGE_SIZE, 0) < PAGE_SIZE)
 		goto submit_and_realloc;
 
 	inc_page_count(F2FS_I_SB(inode), F2FS_RD_DATA);
@@ -2091,16 +2089,14 @@ int f2fs_read_multi_pages(struct compress_ctx *cc, struct bio **bio_ret,
 	struct bio *bio = *bio_ret;
 	unsigned int start_idx = cc->cluster_idx << cc->log_cluster_size;
 	sector_t last_block_in_file;
-	const unsigned blkbits = inode->i_blkbits;
-	const unsigned blocksize = 1 << blkbits;
 	struct decompress_io_ctx *dic = NULL;
 	int i;
 	int ret = 0;
 
 	f2fs_bug_on(sbi, f2fs_cluster_is_empty(cc));
 
-	last_block_in_file = (f2fs_readpage_limit(inode) +
-					blocksize - 1) >> blkbits;
+	last_block_in_file = DIV_ROUND_UP(f2fs_readpage_limit(inode),
+								PAGE_SIZE);
 
 	/* get rid of pages beyond EOF */
 	for (i = 0; i < cc->cluster_size; i++) {
@@ -2197,7 +2193,7 @@ int f2fs_read_multi_pages(struct compress_ctx *cc, struct bio **bio_ret,
 
 		f2fs_wait_on_block_writeback(inode, blkaddr);
 
-		if (bio_add_page(bio, page, blocksize, 0) < blocksize)
+		if (bio_add_page(bio, page, PAGE_SIZE, 0) < PAGE_SIZE)
 			goto submit_and_realloc;
 
 		inc_page_count(sbi, F2FS_RD_DATA);
diff --git a/fs/f2fs/file.c b/fs/f2fs/file.c
index c2d38a1c4972..0f8be076620c 100644
--- a/fs/f2fs/file.c
+++ b/fs/f2fs/file.c
@@ -736,16 +736,9 @@ int f2fs_truncate_blocks(struct inode *inode, u64 from, bool lock)
 	 * for compressed file, only support cluster size
 	 * aligned truncation.
 	 */
-	if (f2fs_compressed_file(inode)) {
-		size_t cluster_shift = PAGE_SHIFT +
-					F2FS_I(inode)->i_log_cluster_size;
-		size_t cluster_mask = (1 << cluster_shift) - 1;
-
-		free_from = from >> cluster_shift;
-		if (from & cluster_mask)
-			free_from++;
-		free_from <<= cluster_shift;
-	}
+	if (f2fs_compressed_file(inode))
+		free_from = round_up(from,
+				F2FS_I(inode)->i_cluster_size << PAGE_SHIFT);
 #endif
 
 	err = f2fs_do_truncate_blocks(inode, free_from, lock);
@@ -3537,7 +3530,7 @@ static int f2fs_release_compress_blocks(struct file *filp, unsigned long arg)
 
 		end_offset = ADDRS_PER_PAGE(dn.node_page, inode);
 		count = min(end_offset - dn.ofs_in_node, last_idx - page_idx);
-		count = roundup(count, F2FS_I(inode)->i_cluster_size);
+		count = round_up(count, F2FS_I(inode)->i_cluster_size);
 
 		ret = release_compress_blocks(&dn, count);
 
@@ -3689,7 +3682,7 @@ static int f2fs_reserve_compress_blocks(struct file *filp, unsigned long arg)
 
 		end_offset = ADDRS_PER_PAGE(dn.node_page, inode);
 		count = min(end_offset - dn.ofs_in_node, last_idx - page_idx);
-		count = roundup(count, F2FS_I(inode)->i_cluster_size);
+		count = round_up(count, F2FS_I(inode)->i_cluster_size);
 
 		ret = reserve_compress_blocks(&dn, count);
 
-- 
2.18.0.rc1

