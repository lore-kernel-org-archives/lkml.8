Return-Path: <SRS0=3e5Q=77=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C09B5C433DF
	for <linux-kernel@archiver.kernel.org>; Thu, 18 Jun 2020 06:36:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9C55A2186A
	for <linux-kernel@archiver.kernel.org>; Thu, 18 Jun 2020 06:36:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727909AbgFRGgw (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 18 Jun 2020 02:36:52 -0400
Received: from szxga04-in.huawei.com ([45.249.212.190]:6358 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727116AbgFRGgu (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 18 Jun 2020 02:36:50 -0400
Received: from DGGEMS410-HUB.china.huawei.com (unknown [172.30.72.60])
        by Forcepoint Email with ESMTP id 7405A757C8AE3F8E0EF6;
        Thu, 18 Jun 2020 14:36:40 +0800 (CST)
Received: from szvp000203569.huawei.com (10.120.216.130) by
 DGGEMS410-HUB.china.huawei.com (10.3.19.210) with Microsoft SMTP Server id
 14.3.487.0; Thu, 18 Jun 2020 14:36:31 +0800
From:   Chao Yu <yuchao0@huawei.com>
To:     <jaegeuk@kernel.org>
CC:     <linux-f2fs-devel@lists.sourceforge.net>,
        <linux-kernel@vger.kernel.org>, <chao@kernel.org>,
        Chao Yu <yuchao0@huawei.com>
Subject: [PATCH 2/5] f2fs: add prefix for exported symbols
Date:   Thu, 18 Jun 2020 14:36:22 +0800
Message-ID: <20200618063625.110273-2-yuchao0@huawei.com>
X-Mailer: git-send-email 2.18.0.rc1
In-Reply-To: <20200618063625.110273-1-yuchao0@huawei.com>
References: <20200618063625.110273-1-yuchao0@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.120.216.130]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

to avoid polluting global symbol namespace.

Signed-off-by: Chao Yu <yuchao0@huawei.com>
---
 fs/f2fs/compress.c |  4 ++--
 fs/f2fs/data.c     | 14 +++++++-------
 fs/f2fs/f2fs.h     |  4 ++--
 fs/f2fs/file.c     |  4 ++--
 fs/f2fs/gc.c       |  2 +-
 fs/f2fs/segment.c  |  2 +-
 6 files changed, 15 insertions(+), 15 deletions(-)

diff --git a/fs/f2fs/compress.c b/fs/f2fs/compress.c
index 1e02a8c106b0..36b51795b0c3 100644
--- a/fs/f2fs/compress.c
+++ b/fs/f2fs/compress.c
@@ -949,7 +949,7 @@ static int prepare_compress_overwrite(struct compress_ctx *cc,
 	}
 
 	if (prealloc) {
-		__do_map_lock(sbi, F2FS_GET_BLOCK_PRE_AIO, true);
+		f2fs_do_map_lock(sbi, F2FS_GET_BLOCK_PRE_AIO, true);
 
 		set_new_dnode(&dn, cc->inode, NULL, NULL, 0);
 
@@ -964,7 +964,7 @@ static int prepare_compress_overwrite(struct compress_ctx *cc,
 				break;
 		}
 
-		__do_map_lock(sbi, F2FS_GET_BLOCK_PRE_AIO, false);
+		f2fs_do_map_lock(sbi, F2FS_GET_BLOCK_PRE_AIO, false);
 	}
 
 	if (likely(!ret)) {
diff --git a/fs/f2fs/data.c b/fs/f2fs/data.c
index 326c63879ddc..c78ce08f6400 100644
--- a/fs/f2fs/data.c
+++ b/fs/f2fs/data.c
@@ -1426,7 +1426,7 @@ int f2fs_preallocate_blocks(struct kiocb *iocb, struct iov_iter *from)
 	return err;
 }
 
-void __do_map_lock(struct f2fs_sb_info *sbi, int flag, bool lock)
+void f2fs_do_map_lock(struct f2fs_sb_info *sbi, int flag, bool lock)
 {
 	if (flag == F2FS_GET_BLOCK_PRE_AIO) {
 		if (lock)
@@ -1491,7 +1491,7 @@ int f2fs_map_blocks(struct inode *inode, struct f2fs_map_blocks *map,
 
 next_dnode:
 	if (map->m_may_create)
-		__do_map_lock(sbi, flag, true);
+		f2fs_do_map_lock(sbi, flag, true);
 
 	/* When reading holes, we need its node page */
 	set_new_dnode(&dn, inode, NULL, NULL, 0);
@@ -1640,7 +1640,7 @@ int f2fs_map_blocks(struct inode *inode, struct f2fs_map_blocks *map,
 	f2fs_put_dnode(&dn);
 
 	if (map->m_may_create) {
-		__do_map_lock(sbi, flag, false);
+		f2fs_do_map_lock(sbi, flag, false);
 		f2fs_balance_fs(sbi, dn.node_changed);
 	}
 	goto next_dnode;
@@ -1666,7 +1666,7 @@ int f2fs_map_blocks(struct inode *inode, struct f2fs_map_blocks *map,
 	f2fs_put_dnode(&dn);
 unlock_out:
 	if (map->m_may_create) {
-		__do_map_lock(sbi, flag, false);
+		f2fs_do_map_lock(sbi, flag, false);
 		f2fs_balance_fs(sbi, dn.node_changed);
 	}
 out:
@@ -3217,7 +3217,7 @@ static int prepare_write_begin(struct f2fs_sb_info *sbi,
 
 	if (f2fs_has_inline_data(inode) ||
 			(pos & PAGE_MASK) >= i_size_read(inode)) {
-		__do_map_lock(sbi, flag, true);
+		f2fs_do_map_lock(sbi, flag, true);
 		locked = true;
 	}
 
@@ -3254,7 +3254,7 @@ static int prepare_write_begin(struct f2fs_sb_info *sbi,
 			err = f2fs_get_dnode_of_data(&dn, index, LOOKUP_NODE);
 			if (err || dn.data_blkaddr == NULL_ADDR) {
 				f2fs_put_dnode(&dn);
-				__do_map_lock(sbi, F2FS_GET_BLOCK_PRE_AIO,
+				f2fs_do_map_lock(sbi, F2FS_GET_BLOCK_PRE_AIO,
 								true);
 				WARN_ON(flag != F2FS_GET_BLOCK_PRE_AIO);
 				locked = true;
@@ -3270,7 +3270,7 @@ static int prepare_write_begin(struct f2fs_sb_info *sbi,
 	f2fs_put_dnode(&dn);
 unlock_out:
 	if (locked)
-		__do_map_lock(sbi, flag, false);
+		f2fs_do_map_lock(sbi, flag, false);
 	return err;
 }
 
diff --git a/fs/f2fs/f2fs.h b/fs/f2fs/f2fs.h
index 326c12fa0da5..b74f0f5fcf3a 100644
--- a/fs/f2fs/f2fs.h
+++ b/fs/f2fs/f2fs.h
@@ -3325,7 +3325,7 @@ block_t f2fs_get_unusable_blocks(struct f2fs_sb_info *sbi);
 int f2fs_disable_cp_again(struct f2fs_sb_info *sbi, block_t unusable);
 void f2fs_release_discard_addrs(struct f2fs_sb_info *sbi);
 int f2fs_npages_for_summary_flush(struct f2fs_sb_info *sbi, bool for_ra);
-void allocate_segment_for_resize(struct f2fs_sb_info *sbi, int type,
+void f2fs_allocate_segment_for_resize(struct f2fs_sb_info *sbi, int type,
 					unsigned int start, unsigned int end);
 void f2fs_allocate_new_segments(struct f2fs_sb_info *sbi, int type);
 int f2fs_trim_fs(struct f2fs_sb_info *sbi, struct fstrim_range *range);
@@ -3448,7 +3448,7 @@ struct page *f2fs_get_lock_data_page(struct inode *inode, pgoff_t index,
 struct page *f2fs_get_new_data_page(struct inode *inode,
 			struct page *ipage, pgoff_t index, bool new_i_size);
 int f2fs_do_write_data_page(struct f2fs_io_info *fio);
-void __do_map_lock(struct f2fs_sb_info *sbi, int flag, bool lock);
+void f2fs_do_map_lock(struct f2fs_sb_info *sbi, int flag, bool lock);
 int f2fs_map_blocks(struct inode *inode, struct f2fs_map_blocks *map,
 			int create, int flag);
 int f2fs_fiemap(struct inode *inode, struct fiemap_extent_info *fieinfo,
diff --git a/fs/f2fs/file.c b/fs/f2fs/file.c
index 1862073b96d2..9d95e3bd4dfe 100644
--- a/fs/f2fs/file.c
+++ b/fs/f2fs/file.c
@@ -105,11 +105,11 @@ static vm_fault_t f2fs_vm_page_mkwrite(struct vm_fault *vmf)
 
 	if (need_alloc) {
 		/* block allocation */
-		__do_map_lock(sbi, F2FS_GET_BLOCK_PRE_AIO, true);
+		f2fs_do_map_lock(sbi, F2FS_GET_BLOCK_PRE_AIO, true);
 		set_new_dnode(&dn, inode, NULL, NULL, 0);
 		err = f2fs_get_block(&dn, page->index);
 		f2fs_put_dnode(&dn);
-		__do_map_lock(sbi, F2FS_GET_BLOCK_PRE_AIO, false);
+		f2fs_do_map_lock(sbi, F2FS_GET_BLOCK_PRE_AIO, false);
 	}
 
 #ifdef CONFIG_F2FS_FS_COMPRESSION
diff --git a/fs/f2fs/gc.c b/fs/f2fs/gc.c
index 5b95d5a146eb..3d27b939627e 100644
--- a/fs/f2fs/gc.c
+++ b/fs/f2fs/gc.c
@@ -1434,7 +1434,7 @@ static int free_segment_range(struct f2fs_sb_info *sbi,
 
 	/* Move out cursegs from the target range */
 	for (type = CURSEG_HOT_DATA; type < NR_CURSEG_TYPE; type++)
-		allocate_segment_for_resize(sbi, type, start, end);
+		f2fs_allocate_segment_for_resize(sbi, type, start, end);
 
 	/* do GC to move out valid blocks in the range */
 	for (segno = start; segno <= end; segno += sbi->segs_per_sec) {
diff --git a/fs/f2fs/segment.c b/fs/f2fs/segment.c
index 196f31503511..5b2a6f865a6d 100644
--- a/fs/f2fs/segment.c
+++ b/fs/f2fs/segment.c
@@ -2674,7 +2674,7 @@ static void allocate_segment_by_default(struct f2fs_sb_info *sbi,
 	stat_inc_seg_type(sbi, curseg);
 }
 
-void allocate_segment_for_resize(struct f2fs_sb_info *sbi, int type,
+void f2fs_allocate_segment_for_resize(struct f2fs_sb_info *sbi, int type,
 					unsigned int start, unsigned int end)
 {
 	struct curseg_info *curseg = CURSEG_I(sbi, type);
-- 
2.18.0.rc1

