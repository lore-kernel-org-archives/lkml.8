Return-Path: <SRS0=fG1M=4C=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 91777C2BA83
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Feb 2020 09:45:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 64F19222C4
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Feb 2020 09:45:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729149AbgBNJpL (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 14 Feb 2020 04:45:11 -0500
Received: from szxga05-in.huawei.com ([45.249.212.191]:10176 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1729110AbgBNJpL (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Feb 2020 04:45:11 -0500
Received: from DGGEMS407-HUB.china.huawei.com (unknown [172.30.72.59])
        by Forcepoint Email with ESMTP id 1B1926252407A682C1C8;
        Fri, 14 Feb 2020 17:45:06 +0800 (CST)
Received: from szvp000203569.huawei.com (10.120.216.130) by
 DGGEMS407-HUB.china.huawei.com (10.3.19.207) with Microsoft SMTP Server id
 14.3.439.0; Fri, 14 Feb 2020 17:44:59 +0800
From:   Chao Yu <yuchao0@huawei.com>
To:     <jaegeuk@kernel.org>
CC:     <linux-f2fs-devel@lists.sourceforge.net>,
        <linux-kernel@vger.kernel.org>, <chao@kernel.org>,
        Chao Yu <yuchao0@huawei.com>
Subject: [PATCH 1/4] f2fs: clean up codes with {f2fs_,}data_blkaddr()
Date:   Fri, 14 Feb 2020 17:44:10 +0800
Message-ID: <20200214094413.12784-1-yuchao0@huawei.com>
X-Mailer: git-send-email 2.18.0.rc1
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.120.216.130]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

- rename datablock_addr() to data_blkaddr().
- wrap data_blkaddr() with f2fs_data_blkaddr() to clean up
parameters.

Signed-off-by: Chao Yu <yuchao0@huawei.com>
---
 fs/f2fs/compress.c |  7 +++----
 fs/f2fs/data.c     | 12 +++++-------
 fs/f2fs/f2fs.h     |  7 ++++++-
 fs/f2fs/file.c     | 15 +++++----------
 fs/f2fs/gc.c       |  2 +-
 fs/f2fs/node.c     |  3 +--
 fs/f2fs/recovery.c |  7 +++----
 7 files changed, 24 insertions(+), 29 deletions(-)

diff --git a/fs/f2fs/compress.c b/fs/f2fs/compress.c
index d8a64be90a50..0282149aa4c8 100644
--- a/fs/f2fs/compress.c
+++ b/fs/f2fs/compress.c
@@ -554,7 +554,7 @@ static int f2fs_compressed_blocks(struct compress_ctx *cc)
 		for (i = 1; i < cc->cluster_size; i++) {
 			block_t blkaddr;
 
-			blkaddr = datablock_addr(dn.inode,
+			blkaddr = data_blkaddr(dn.inode,
 					dn.node_page, dn.ofs_in_node + i);
 			if (blkaddr != NULL_ADDR)
 				ret++;
@@ -794,7 +794,7 @@ static int f2fs_write_compressed_pages(struct compress_ctx *cc,
 		goto out_unlock_op;
 
 	for (i = 0; i < cc->cluster_size; i++) {
-		if (datablock_addr(dn.inode, dn.node_page,
+		if (data_blkaddr(dn.inode, dn.node_page,
 					dn.ofs_in_node + i) == NULL_ADDR)
 			goto out_put_dnode;
 	}
@@ -843,8 +843,7 @@ static int f2fs_write_compressed_pages(struct compress_ctx *cc,
 	for (i = 0; i < cc->cluster_size; i++, dn.ofs_in_node++) {
 		block_t blkaddr;
 
-		blkaddr = datablock_addr(dn.inode, dn.node_page,
-							dn.ofs_in_node);
+		blkaddr = f2fs_data_blkaddr(&dn);
 		fio.page = cic->rpages[i];
 		fio.old_blkaddr = blkaddr;
 
diff --git a/fs/f2fs/data.c b/fs/f2fs/data.c
index 1f9f755dc8c2..ec4b030e2466 100644
--- a/fs/f2fs/data.c
+++ b/fs/f2fs/data.c
@@ -1047,8 +1047,7 @@ int f2fs_reserve_new_blocks(struct dnode_of_data *dn, blkcnt_t count)
 	f2fs_wait_on_page_writeback(dn->node_page, NODE, true, true);
 
 	for (; count > 0; dn->ofs_in_node++) {
-		block_t blkaddr = datablock_addr(dn->inode,
-					dn->node_page, dn->ofs_in_node);
+		block_t blkaddr = f2fs_data_blkaddr(dn);
 		if (blkaddr == NULL_ADDR) {
 			dn->data_blkaddr = NEW_ADDR;
 			__set_data_blkaddr(dn);
@@ -1300,8 +1299,7 @@ static int __allocate_data_block(struct dnode_of_data *dn, int seg_type)
 	if (err)
 		return err;
 
-	dn->data_blkaddr = datablock_addr(dn->inode,
-				dn->node_page, dn->ofs_in_node);
+	dn->data_blkaddr = f2fs_data_blkaddr(dn);
 	if (dn->data_blkaddr != NULL_ADDR)
 		goto alloc;
 
@@ -1467,7 +1465,7 @@ int f2fs_map_blocks(struct inode *inode, struct f2fs_map_blocks *map,
 	end_offset = ADDRS_PER_PAGE(dn.node_page, inode);
 
 next_block:
-	blkaddr = datablock_addr(dn.inode, dn.node_page, dn.ofs_in_node);
+	blkaddr = f2fs_data_blkaddr(&dn);
 
 	if (__is_valid_data_blkaddr(blkaddr) &&
 		!f2fs_is_valid_blkaddr(sbi, blkaddr, DATA_GENERIC_ENHANCE)) {
@@ -2067,7 +2065,7 @@ int f2fs_read_multi_pages(struct compress_ctx *cc, struct bio **bio_ret,
 	for (i = 1; i < cc->cluster_size; i++) {
 		block_t blkaddr;
 
-		blkaddr = datablock_addr(dn.inode, dn.node_page,
+		blkaddr = data_blkaddr(dn.inode, dn.node_page,
 						dn.ofs_in_node + i);
 
 		if (!__is_valid_data_blkaddr(blkaddr))
@@ -2096,7 +2094,7 @@ int f2fs_read_multi_pages(struct compress_ctx *cc, struct bio **bio_ret,
 		struct page *page = dic->cpages[i];
 		block_t blkaddr;
 
-		blkaddr = datablock_addr(dn.inode, dn.node_page,
+		blkaddr = data_blkaddr(dn.inode, dn.node_page,
 						dn.ofs_in_node + i + 1);
 
 		if (bio && !page_is_mergeable(sbi, bio,
diff --git a/fs/f2fs/f2fs.h b/fs/f2fs/f2fs.h
index 5355be6b6755..5152e9bf432b 100644
--- a/fs/f2fs/f2fs.h
+++ b/fs/f2fs/f2fs.h
@@ -2378,7 +2378,7 @@ static inline __le32 *blkaddr_in_node(struct f2fs_node *node)
 }
 
 static inline int f2fs_has_extra_attr(struct inode *inode);
-static inline block_t datablock_addr(struct inode *inode,
+static inline block_t data_blkaddr(struct inode *inode,
 			struct page *node_page, unsigned int offset)
 {
 	struct f2fs_node *raw_node;
@@ -2400,6 +2400,11 @@ static inline block_t datablock_addr(struct inode *inode,
 	return le32_to_cpu(addr_array[base + offset]);
 }
 
+static inline block_t f2fs_data_blkaddr(struct dnode_of_data *dn)
+{
+	return data_blkaddr(dn->inode, dn->node_page, dn->ofs_in_node);
+}
+
 static inline int f2fs_test_bit(unsigned int nr, char *addr)
 {
 	int mask;
diff --git a/fs/f2fs/file.c b/fs/f2fs/file.c
index c9dd45f82fbd..5a0f84751091 100644
--- a/fs/f2fs/file.c
+++ b/fs/f2fs/file.c
@@ -455,8 +455,7 @@ static loff_t f2fs_seek_block(struct file *file, loff_t offset, int whence)
 				data_ofs = (loff_t)pgofs << PAGE_SHIFT) {
 			block_t blkaddr;
 
-			blkaddr = datablock_addr(dn.inode,
-					dn.node_page, dn.ofs_in_node);
+			blkaddr = f2fs_data_blkaddr(&dn);
 
 			if (__is_valid_data_blkaddr(blkaddr) &&
 				!f2fs_is_valid_blkaddr(F2FS_I_SB(inode),
@@ -1122,8 +1121,7 @@ static int __read_out_blkaddrs(struct inode *inode, block_t *blkaddr,
 	done = min((pgoff_t)ADDRS_PER_PAGE(dn.node_page, inode) -
 							dn.ofs_in_node, len);
 	for (i = 0; i < done; i++, blkaddr++, do_replace++, dn.ofs_in_node++) {
-		*blkaddr = datablock_addr(dn.inode,
-					dn.node_page, dn.ofs_in_node);
+		*blkaddr = f2fs_data_blkaddr(&dn);
 
 		if (__is_valid_data_blkaddr(*blkaddr) &&
 			!f2fs_is_valid_blkaddr(sbi, *blkaddr,
@@ -1212,8 +1210,7 @@ static int __clone_blkaddrs(struct inode *src_inode, struct inode *dst_inode,
 				ADDRS_PER_PAGE(dn.node_page, dst_inode) -
 						dn.ofs_in_node, len - i);
 			do {
-				dn.data_blkaddr = datablock_addr(dn.inode,
-						dn.node_page, dn.ofs_in_node);
+				dn.data_blkaddr = f2fs_data_blkaddr(&dn);
 				f2fs_truncate_data_blocks_range(&dn, 1);
 
 				if (do_replace[i]) {
@@ -1389,8 +1386,7 @@ static int f2fs_do_zero_range(struct dnode_of_data *dn, pgoff_t start,
 	int ret;
 
 	for (; index < end; index++, dn->ofs_in_node++) {
-		if (datablock_addr(dn->inode, dn->node_page,
-					dn->ofs_in_node) == NULL_ADDR)
+		if (f2fs_data_blkaddr(dn) == NULL_ADDR)
 			count++;
 	}
 
@@ -1401,8 +1397,7 @@ static int f2fs_do_zero_range(struct dnode_of_data *dn, pgoff_t start,
 
 	dn->ofs_in_node = ofs_in_node;
 	for (index = start; index < end; index++, dn->ofs_in_node++) {
-		dn->data_blkaddr = datablock_addr(dn->inode,
-					dn->node_page, dn->ofs_in_node);
+		dn->data_blkaddr = f2fs_data_blkaddr(dn);
 		/*
 		 * f2fs_reserve_new_blocks will not guarantee entire block
 		 * allocation.
diff --git a/fs/f2fs/gc.c b/fs/f2fs/gc.c
index db8725d473b5..53312d7bc78b 100644
--- a/fs/f2fs/gc.c
+++ b/fs/f2fs/gc.c
@@ -634,7 +634,7 @@ static bool is_alive(struct f2fs_sb_info *sbi, struct f2fs_summary *sum,
 	}
 
 	*nofs = ofs_of_node(node_page);
-	source_blkaddr = datablock_addr(NULL, node_page, ofs_in_node);
+	source_blkaddr = data_blkaddr(NULL, node_page, ofs_in_node);
 	f2fs_put_page(node_page, 1);
 
 	if (source_blkaddr != blkaddr) {
diff --git a/fs/f2fs/node.c b/fs/f2fs/node.c
index 3314a0f3405e..332cebc2033c 100644
--- a/fs/f2fs/node.c
+++ b/fs/f2fs/node.c
@@ -809,8 +809,7 @@ int f2fs_get_dnode_of_data(struct dnode_of_data *dn, pgoff_t index, int mode)
 	dn->nid = nids[level];
 	dn->ofs_in_node = offset[level];
 	dn->node_page = npage[level];
-	dn->data_blkaddr = datablock_addr(dn->inode,
-				dn->node_page, dn->ofs_in_node);
+	dn->data_blkaddr = f2fs_data_blkaddr(dn);
 	return 0;
 
 release_pages:
diff --git a/fs/f2fs/recovery.c b/fs/f2fs/recovery.c
index 763d5c0951d1..348e8d463b3e 100644
--- a/fs/f2fs/recovery.c
+++ b/fs/f2fs/recovery.c
@@ -496,8 +496,7 @@ static int check_index_in_prev_nodes(struct f2fs_sb_info *sbi,
 	return 0;
 
 truncate_out:
-	if (datablock_addr(tdn.inode, tdn.node_page,
-					tdn.ofs_in_node) == blkaddr)
+	if (f2fs_data_blkaddr(&tdn) == blkaddr)
 		f2fs_truncate_data_blocks_range(&tdn, 1);
 	if (dn->inode->i_ino == nid && !dn->inode_page_locked)
 		unlock_page(dn->inode_page);
@@ -560,8 +559,8 @@ static int do_recover_data(struct f2fs_sb_info *sbi, struct inode *inode,
 	for (; start < end; start++, dn.ofs_in_node++) {
 		block_t src, dest;
 
-		src = datablock_addr(dn.inode, dn.node_page, dn.ofs_in_node);
-		dest = datablock_addr(dn.inode, page, dn.ofs_in_node);
+		src = f2fs_data_blkaddr(&dn);
+		dest = data_blkaddr(dn.inode, page, dn.ofs_in_node);
 
 		if (__is_valid_data_blkaddr(src) &&
 			!f2fs_is_valid_blkaddr(sbi, src, META_POR)) {
-- 
2.18.0.rc1

