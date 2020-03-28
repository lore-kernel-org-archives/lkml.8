Return-Path: <SRS0=NZ+o=5N=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 24778C43331
	for <linux-kernel@archiver.kernel.org>; Sat, 28 Mar 2020 08:40:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 01CAF2071B
	for <linux-kernel@archiver.kernel.org>; Sat, 28 Mar 2020 08:40:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726369AbgC1IkQ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 28 Mar 2020 04:40:16 -0400
Received: from szxga04-in.huawei.com ([45.249.212.190]:12143 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725947AbgC1IkQ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 28 Mar 2020 04:40:16 -0400
Received: from DGGEMS408-HUB.china.huawei.com (unknown [172.30.72.59])
        by Forcepoint Email with ESMTP id 483F33832ECACFC86A19;
        Sat, 28 Mar 2020 16:40:02 +0800 (CST)
Received: from szvp000203569.huawei.com (10.120.216.130) by
 DGGEMS408-HUB.china.huawei.com (10.3.19.208) with Microsoft SMTP Server id
 14.3.487.0; Sat, 28 Mar 2020 16:39:54 +0800
From:   Chao Yu <yuchao0@huawei.com>
To:     <jaegeuk@kernel.org>
CC:     <linux-f2fs-devel@lists.sourceforge.net>,
        <linux-kernel@vger.kernel.org>, <chao@kernel.org>,
        Chao Yu <yuchao0@huawei.com>
Subject: [PATCH v2] f2fs: introduce f2fs_bmap_compress()
Date:   Sat, 28 Mar 2020 16:39:47 +0800
Message-ID: <20200328083947.125066-1-yuchao0@huawei.com>
X-Mailer: git-send-email 2.18.0.rc1
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.120.216.130]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

to support bmap() on compressed inode: if queried block locates in
non-compressed cluster, return its physical block address.

Signed-off-by: Chao Yu <yuchao0@huawei.com>
---
v2:
- give blkaddr on non-compressed cluster suggested by Jaegeuk.
 fs/f2fs/data.c | 34 ++++++++++++++++++++++++++++++++++
 1 file changed, 34 insertions(+)

diff --git a/fs/f2fs/data.c b/fs/f2fs/data.c
index 24643680489b..89b73ee74120 100644
--- a/fs/f2fs/data.c
+++ b/fs/f2fs/data.c
@@ -3585,6 +3585,37 @@ static int f2fs_set_data_page_dirty(struct page *page)
 	return 0;
 }
 
+
+static sector_t f2fs_bmap_compress(struct inode *inode, sector_t block)
+{
+#ifdef CONFIG_F2FS_FS_COMPRESSION
+	struct dnode_of_data dn;
+	sector_t start_idx, blknr = 0;
+	int ret;
+
+	start_idx = rounddown(block, F2FS_I(inode)->i_cluster_size);
+
+	set_new_dnode(&dn, inode, NULL, NULL, 0);
+	ret = f2fs_get_dnode_of_data(&dn, start_idx, LOOKUP_NODE);
+	if (ret)
+		return 0;
+
+	if (dn.data_blkaddr != COMPRESS_ADDR) {
+		dn.ofs_in_node += block - start_idx;
+		blknr = f2fs_data_blkaddr(&dn);
+		if (!__is_valid_data_blkaddr(blknr))
+			blknr = 0;
+	}
+
+	f2fs_put_dnode(&dn);
+
+	return blknr;
+#else
+	return -EOPNOTSUPP;
+#endif
+}
+
+
 static sector_t f2fs_bmap(struct address_space *mapping, sector_t block)
 {
 	struct inode *inode = mapping->host;
@@ -3596,6 +3627,9 @@ static sector_t f2fs_bmap(struct address_space *mapping, sector_t block)
 	if (mapping_tagged(mapping, PAGECACHE_TAG_DIRTY))
 		filemap_write_and_wait(mapping);
 
+	if (f2fs_compressed_file(inode))
+		return f2fs_bmap_compress(inode, block);
+
 	return generic_block_bmap(mapping, block, get_data_block_bmap);
 }
 
-- 
2.18.0.rc1

