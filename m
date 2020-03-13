Return-Path: <SRS0=CUu6=46=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 156C0C10DCE
	for <linux-kernel@archiver.kernel.org>; Fri, 13 Mar 2020 10:29:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1E2E220746
	for <linux-kernel@archiver.kernel.org>; Fri, 13 Mar 2020 10:29:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726591AbgCMK3j (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 13 Mar 2020 06:29:39 -0400
Received: from szxga05-in.huawei.com ([45.249.212.191]:11675 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726364AbgCMK3i (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 Mar 2020 06:29:38 -0400
Received: from DGGEMS408-HUB.china.huawei.com (unknown [172.30.72.58])
        by Forcepoint Email with ESMTP id 096E12A12EEA7BB4DAD2;
        Fri, 13 Mar 2020 18:27:29 +0800 (CST)
Received: from szvp000203569.huawei.com (10.120.216.130) by
 DGGEMS408-HUB.china.huawei.com (10.3.19.208) with Microsoft SMTP Server id
 14.3.487.0; Fri, 13 Mar 2020 18:27:22 +0800
From:   Chao Yu <yuchao0@huawei.com>
To:     <jaegeuk@kernel.org>
CC:     <linux-f2fs-devel@lists.sourceforge.net>,
        <linux-kernel@vger.kernel.org>, <chao@kernel.org>,
        Chao Yu <yuchao0@huawei.com>
Subject: [PATCH] f2fs: support partial truncation on compressed inode
Date:   Fri, 13 Mar 2020 18:27:20 +0800
Message-ID: <20200313102720.6742-1-yuchao0@huawei.com>
X-Mailer: git-send-email 2.18.0.rc1
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.120.216.130]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Supports to truncate compressed/normal cluster partially on compressed
inode.

Signed-off-by: Chao Yu <yuchao0@huawei.com>
---
 fs/f2fs/compress.c | 48 ++++++++++++++++++++++++++++++++++++++++++++++
 fs/f2fs/f2fs.h     |  2 ++
 fs/f2fs/file.c     | 19 +++++++++++++-----
 3 files changed, 64 insertions(+), 5 deletions(-)

diff --git a/fs/f2fs/compress.c b/fs/f2fs/compress.c
index 744ce2eb6ca7..659c77155ef7 100644
--- a/fs/f2fs/compress.c
+++ b/fs/f2fs/compress.c
@@ -956,6 +956,54 @@ bool f2fs_compress_write_end(struct inode *inode, void *fsdata,
 	return first_index;
 }
 
+int f2fs_truncate_partial_cluster(struct inode *inode, u64 from, bool lock)
+{
+	void *fsdata = NULL;
+	struct page *pagep;
+	int log_cluster_size = F2FS_I(inode)->i_log_cluster_size;
+	pgoff_t start_idx = from >> (PAGE_SHIFT + log_cluster_size);
+	int err;
+
+	err = f2fs_is_compressed_cluster(inode, start_idx);
+	if (err < 0)
+		return err;
+
+	/* truncate normal cluster */
+	if (!err)
+		return f2fs_do_truncate_blocks(inode, from, lock);
+
+	/* truncate compressed cluster */
+	err = f2fs_prepare_compress_overwrite(inode, &pagep,
+						start_idx, &fsdata);
+
+	/* should not be a normal cluster */
+	f2fs_bug_on(F2FS_I_SB(inode), err == 0);
+
+	if (err <= 0)
+		return err;
+
+	if (err > 0) {
+		struct page **rpages = fsdata;
+		int cluster_size = F2FS_I(inode)->i_cluster_size;
+		int i;
+
+		for (i = cluster_size - 1; i >= 0; i--) {
+			loff_t start = rpages[i]->index << PAGE_SHIFT;
+
+			if (from <= start) {
+				zero_user_segment(rpages[i], 0, PAGE_SIZE);
+			} else {
+				zero_user_segment(rpages[i], from - start,
+								PAGE_SIZE);
+				break;
+			}
+		}
+
+		f2fs_compress_write_end(inode, fsdata, start_idx, true);
+	}
+	return 0;
+}
+
 static int f2fs_write_compressed_pages(struct compress_ctx *cc,
 					int *submitted,
 					struct writeback_control *wbc,
diff --git a/fs/f2fs/f2fs.h b/fs/f2fs/f2fs.h
index 76d2a99520bf..f5c55c966ed7 100644
--- a/fs/f2fs/f2fs.h
+++ b/fs/f2fs/f2fs.h
@@ -3076,6 +3076,7 @@ static inline void f2fs_clear_page_private(struct page *page)
  */
 int f2fs_sync_file(struct file *file, loff_t start, loff_t end, int datasync);
 void f2fs_truncate_data_blocks(struct dnode_of_data *dn);
+int f2fs_do_truncate_blocks(struct inode *inode, u64 from, bool lock);
 int f2fs_truncate_blocks(struct inode *inode, u64 from, bool lock);
 int f2fs_truncate(struct inode *inode);
 int f2fs_getattr(const struct path *path, struct kstat *stat,
@@ -3796,6 +3797,7 @@ int f2fs_prepare_compress_overwrite(struct inode *inode,
 			struct page **pagep, pgoff_t index, void **fsdata);
 bool f2fs_compress_write_end(struct inode *inode, void *fsdata,
 					pgoff_t index, unsigned copied);
+int f2fs_truncate_partial_cluster(struct inode *inode, u64 from, bool lock);
 void f2fs_compress_write_end_io(struct bio *bio, struct page *page);
 bool f2fs_is_compress_backend_ready(struct inode *inode);
 void f2fs_decompress_pages(struct bio *bio, struct page *page, bool verity);
diff --git a/fs/f2fs/file.c b/fs/f2fs/file.c
index 8dfbcf3b4c4c..257b3b629ee1 100644
--- a/fs/f2fs/file.c
+++ b/fs/f2fs/file.c
@@ -646,9 +646,6 @@ static int truncate_partial_data_page(struct inode *inode, u64 from,
 		return 0;
 	}
 
-	if (f2fs_compressed_file(inode))
-		return 0;
-
 	page = f2fs_get_lock_data_page(inode, index, true);
 	if (IS_ERR(page))
 		return PTR_ERR(page) == -ENOENT ? 0 : PTR_ERR(page);
@@ -664,7 +661,7 @@ static int truncate_partial_data_page(struct inode *inode, u64 from,
 	return 0;
 }
 
-static int do_truncate_blocks(struct inode *inode, u64 from, bool lock)
+int f2fs_do_truncate_blocks(struct inode *inode, u64 from, bool lock)
 {
 	struct f2fs_sb_info *sbi = F2FS_I_SB(inode);
 	struct dnode_of_data dn;
@@ -732,7 +729,9 @@ static int do_truncate_blocks(struct inode *inode, u64 from, bool lock)
 int f2fs_truncate_blocks(struct inode *inode, u64 from, bool lock)
 {
 	u64 free_from = from;
+	int err;
 
+#ifdef CONFIG_F2FS_FS_COMPRESSION
 	/*
 	 * for compressed file, only support cluster size
 	 * aligned truncation.
@@ -747,8 +746,18 @@ int f2fs_truncate_blocks(struct inode *inode, u64 from, bool lock)
 			free_from++;
 		free_from <<= cluster_shift;
 	}
+#endif
+
+	err = f2fs_do_truncate_blocks(inode, free_from, lock);
+	if (err)
+		return err;
+
+#ifdef CONFIG_F2FS_FS_COMPRESSION
+	if (from != free_from)
+		err = f2fs_truncate_partial_cluster(inode, from, lock);
+#endif
 
-	return do_truncate_blocks(inode, free_from, lock);
+	return err;
 }
 
 int f2fs_truncate(struct inode *inode)
-- 
2.18.0.rc1

