Return-Path: <SRS0=8dav=5Y=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F1DE9C2D0EA
	for <linux-kernel@archiver.kernel.org>; Wed,  8 Apr 2020 11:56:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CC4A420780
	for <linux-kernel@archiver.kernel.org>; Wed,  8 Apr 2020 11:56:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727939AbgDHL4P (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 8 Apr 2020 07:56:15 -0400
Received: from szxga06-in.huawei.com ([45.249.212.32]:55242 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726521AbgDHL4O (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Apr 2020 07:56:14 -0400
Received: from DGGEMS411-HUB.china.huawei.com (unknown [172.30.72.58])
        by Forcepoint Email with ESMTP id EEEB813D232B48F409D6;
        Wed,  8 Apr 2020 19:55:29 +0800 (CST)
Received: from szvp000203569.huawei.com (10.120.216.130) by
 DGGEMS411-HUB.china.huawei.com (10.3.19.211) with Microsoft SMTP Server id
 14.3.487.0; Wed, 8 Apr 2020 19:55:21 +0800
From:   Chao Yu <yuchao0@huawei.com>
To:     <jaegeuk@kernel.org>
CC:     <linux-f2fs-devel@lists.sourceforge.net>,
        <linux-kernel@vger.kernel.org>, <chao@kernel.org>,
        Chao Yu <yuchao0@huawei.com>
Subject: [PATCH] f2fs: use round_up to enhance calculation
Date:   Wed, 8 Apr 2020 19:55:17 +0800
Message-ID: <20200408115517.15370-1-yuchao0@huawei.com>
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

Signed-off-by: Chao Yu <yuchao0@huawei.com>
---
 fs/f2fs/file.c | 17 +++++------------
 1 file changed, 5 insertions(+), 12 deletions(-)

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

