Return-Path: <SRS0=NZ+o=5N=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	UNWANTED_LANGUAGE_BODY,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7EF90C43331
	for <linux-kernel@archiver.kernel.org>; Sat, 28 Mar 2020 09:41:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 59521206F2
	for <linux-kernel@archiver.kernel.org>; Sat, 28 Mar 2020 09:41:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726258AbgC1JlA (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 28 Mar 2020 05:41:00 -0400
Received: from szxga07-in.huawei.com ([45.249.212.35]:48778 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725937AbgC1Jk7 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 28 Mar 2020 05:40:59 -0400
Received: from DGGEMS406-HUB.china.huawei.com (unknown [172.30.72.58])
        by Forcepoint Email with ESMTP id 24377F02718C82F69AF3;
        Sat, 28 Mar 2020 17:40:54 +0800 (CST)
Received: from szvp000203569.huawei.com (10.120.216.130) by
 DGGEMS406-HUB.china.huawei.com (10.3.19.206) with Microsoft SMTP Server id
 14.3.487.0; Sat, 28 Mar 2020 17:40:47 +0800
From:   Chao Yu <yuchao0@huawei.com>
To:     <jaegeuk@kernel.org>
CC:     <linux-f2fs-devel@lists.sourceforge.net>,
        <linux-kernel@vger.kernel.org>, <chao@kernel.org>,
        Chao Yu <yuchao0@huawei.com>
Subject: [PATCH WIP] f2fs: support fiemap on compressed inode
Date:   Sat, 28 Mar 2020 17:40:40 +0800
Message-ID: <20200328094040.3785-1-yuchao0@huawei.com>
X-Mailer: git-send-email 2.18.0.rc1
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.120.216.130]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Map normal/compressed cluster of compressed inode correctly, and give
the right fiemap flag FIEMAP_EXTENT_ENCODED on mapped compressed extent.

Signed-off-by: Chao Yu <yuchao0@huawei.com>
---
 fs/f2fs/data.c | 55 ++++++++++++++++++++++++++++++++++++++++++++++++--
 1 file changed, 53 insertions(+), 2 deletions(-)

diff --git a/fs/f2fs/data.c b/fs/f2fs/data.c
index 89b73ee74120..363f7f1b6dc0 100644
--- a/fs/f2fs/data.c
+++ b/fs/f2fs/data.c
@@ -1808,6 +1808,25 @@ static int f2fs_xattr_fiemap(struct inode *inode,
 	return (err < 0 ? err : 0);
 }
 
+static loff_t max_inode_blocks(struct inode *inode)
+{
+	loff_t result = ADDRS_PER_INODE(inode);
+	loff_t leaf_count = ADDRS_PER_BLOCK(inode);
+
+	/* two direct node blocks */
+	result += (leaf_count * 2);
+
+	/* two indirect node blocks */
+	leaf_count *= NIDS_PER_BLOCK;
+	result += (leaf_count * 2);
+
+	/* one double indirect node block */
+	leaf_count *= NIDS_PER_BLOCK;
+	result += leaf_count;
+
+	return result;
+}
+
 int f2fs_fiemap(struct inode *inode, struct fiemap_extent_info *fieinfo,
 		u64 start, u64 len)
 {
@@ -1817,6 +1836,8 @@ int f2fs_fiemap(struct inode *inode, struct fiemap_extent_info *fieinfo,
 	u64 logical = 0, phys = 0, size = 0;
 	u32 flags = 0;
 	int ret = 0;
+	bool compr_cluster = false;
+	unsigned int cluster_size = F2FS_I(inode)->i_cluster_size;
 
 	if (fieinfo->fi_flags & FIEMAP_FLAG_CACHE) {
 		ret = f2fs_precache_extents(inode);
@@ -1851,6 +1872,9 @@ int f2fs_fiemap(struct inode *inode, struct fiemap_extent_info *fieinfo,
 	memset(&map_bh, 0, sizeof(struct buffer_head));
 	map_bh.b_size = len;
 
+	if (compr_cluster)
+		map_bh.b_size = blk_to_logical(inode, cluster_size - 1);
+
 	ret = get_data_block(inode, start_blk, &map_bh, 0,
 					F2FS_GET_BLOCK_FIEMAP, &next_pgofs);
 	if (ret)
@@ -1861,7 +1885,7 @@ int f2fs_fiemap(struct inode *inode, struct fiemap_extent_info *fieinfo,
 		start_blk = next_pgofs;
 
 		if (blk_to_logical(inode, start_blk) < blk_to_logical(inode,
-					F2FS_I_SB(inode)->max_file_blocks))
+						max_inode_blocks(inode)))
 			goto prep_next;
 
 		flags |= FIEMAP_EXTENT_LAST;
@@ -1873,11 +1897,38 @@ int f2fs_fiemap(struct inode *inode, struct fiemap_extent_info *fieinfo,
 
 		ret = fiemap_fill_next_extent(fieinfo, logical,
 				phys, size, flags);
+		if (ret)
+			goto out;
+		size = 0;
 	}
 
-	if (start_blk > last_blk || ret)
+	if (start_blk > last_blk)
 		goto out;
 
+	if (compr_cluster) {
+		compr_cluster = false;
+
+
+		logical = blk_to_logical(inode, start_blk - 1);
+		phys = blk_to_logical(inode, map_bh.b_blocknr);
+		size = blk_to_logical(inode, cluster_size);
+
+		flags |= FIEMAP_EXTENT_ENCODED;
+
+		start_blk += cluster_size - 1;
+
+		if (start_blk > last_blk)
+			goto out;
+
+		goto prep_next;
+	}
+
+	if (map_bh.b_blocknr == COMPRESS_ADDR) {
+		compr_cluster = true;
+		start_blk++;
+		goto prep_next;
+	}
+
 	logical = blk_to_logical(inode, start_blk);
 	phys = blk_to_logical(inode, map_bh.b_blocknr);
 	size = map_bh.b_size;
-- 
2.18.0.rc1

