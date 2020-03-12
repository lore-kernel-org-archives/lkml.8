Return-Path: <SRS0=+FT0=45=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3E5BFC0044D
	for <linux-kernel@archiver.kernel.org>; Thu, 12 Mar 2020 02:45:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6423920735
	for <linux-kernel@archiver.kernel.org>; Thu, 12 Mar 2020 02:45:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387650AbgCLCpt (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 11 Mar 2020 22:45:49 -0400
Received: from szxga06-in.huawei.com ([45.249.212.32]:59718 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S2387396AbgCLCps (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Mar 2020 22:45:48 -0400
Received: from DGGEMS413-HUB.china.huawei.com (unknown [172.30.72.59])
        by Forcepoint Email with ESMTP id C9BC4A2E5D5E8479C3A3;
        Thu, 12 Mar 2020 10:45:42 +0800 (CST)
Received: from szvp000203569.huawei.com (10.120.216.130) by
 DGGEMS413-HUB.china.huawei.com (10.3.19.213) with Microsoft SMTP Server id
 14.3.487.0; Thu, 12 Mar 2020 10:45:33 +0800
From:   Chao Yu <yuchao0@huawei.com>
To:     <jaegeuk@kernel.org>
CC:     <linux-f2fs-devel@lists.sourceforge.net>,
        <linux-kernel@vger.kernel.org>, <chao@kernel.org>,
        Chao Yu <yuchao0@huawei.com>
Subject: [PATCH] f2fs: fix to account compressed blocks in f2fs_compressed_blocks()
Date:   Thu, 12 Mar 2020 10:45:29 +0800
Message-ID: <20200312024529.4668-1-yuchao0@huawei.com>
X-Mailer: git-send-email 2.18.0.rc1
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.120.216.130]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

por_fsstress reports inconsistent status in orphan inode, the root cause
of this is in f2fs_write_raw_pages() we decrease i_compr_blocks incorrectly
due to wrong calculation in f2fs_compressed_blocks().

So this patch exposes below two functions based on __f2fs_cluster_blocks:
- f2fs_compressed_blocks: get count of compressed blocks in compressed cluster
- f2fs_cluster_blocks: get count of valid blocks (including reserved blocks)
in compressed cluster.

Then use f2fs_compress_blocks() to get correct compressed blocks count in
f2fs_write_raw_pages().

sanity_check_inode: inode (ino=ad80) hash inconsistent i_compr_blocks:2, i_blocks:1, run fsck to fix

Signed-off-by: Chao Yu <yuchao0@huawei.com>
---
 fs/f2fs/compress.c | 28 ++++++++++++++++++++++------
 1 file changed, 22 insertions(+), 6 deletions(-)

diff --git a/fs/f2fs/compress.c b/fs/f2fs/compress.c
index 8a9691a1d1d5..744ce2eb6ca7 100644
--- a/fs/f2fs/compress.c
+++ b/fs/f2fs/compress.c
@@ -719,8 +719,7 @@ static bool __cluster_may_compress(struct compress_ctx *cc)
 	return true;
 }
 
-/* return # of compressed block addresses */
-static int f2fs_compressed_blocks(struct compress_ctx *cc)
+static int __f2fs_cluster_blocks(struct compress_ctx *cc, bool compr)
 {
 	struct dnode_of_data dn;
 	int ret;
@@ -743,8 +742,13 @@ static int f2fs_compressed_blocks(struct compress_ctx *cc)
 
 			blkaddr = data_blkaddr(dn.inode,
 					dn.node_page, dn.ofs_in_node + i);
-			if (blkaddr != NULL_ADDR)
-				ret++;
+			if (compr) {
+				if (__is_valid_data_blkaddr(blkaddr))
+					ret++;
+			} else {
+				if (blkaddr != NULL_ADDR)
+					ret++;
+			}
 		}
 	}
 fail:
@@ -752,6 +756,18 @@ static int f2fs_compressed_blocks(struct compress_ctx *cc)
 	return ret;
 }
 
+/* return # of compressed blocks in compressed cluster */
+static int f2fs_compressed_blocks(struct compress_ctx *cc)
+{
+	return __f2fs_cluster_blocks(cc, true);
+}
+
+/* return # of valid blocks in compressed cluster */
+static int f2fs_cluster_blocks(struct compress_ctx *cc, bool compr)
+{
+	return __f2fs_cluster_blocks(cc, false);
+}
+
 int f2fs_is_compressed_cluster(struct inode *inode, pgoff_t index)
 {
 	struct compress_ctx cc = {
@@ -761,7 +777,7 @@ int f2fs_is_compressed_cluster(struct inode *inode, pgoff_t index)
 		.cluster_idx = index >> F2FS_I(inode)->i_log_cluster_size,
 	};
 
-	return f2fs_compressed_blocks(&cc);
+	return f2fs_cluster_blocks(&cc, false);
 }
 
 static bool cluster_may_compress(struct compress_ctx *cc)
@@ -810,7 +826,7 @@ static int prepare_compress_overwrite(struct compress_ctx *cc,
 	bool prealloc;
 
 retry:
-	ret = f2fs_compressed_blocks(cc);
+	ret = f2fs_cluster_blocks(cc, false);
 	if (ret <= 0)
 		return ret;
 
-- 
2.18.0.rc1

