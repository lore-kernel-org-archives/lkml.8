Return-Path: <SRS0=3e5Q=77=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D8838C433E1
	for <linux-kernel@archiver.kernel.org>; Thu, 18 Jun 2020 06:36:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id BFBD721852
	for <linux-kernel@archiver.kernel.org>; Thu, 18 Jun 2020 06:36:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727869AbgFRGgo (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 18 Jun 2020 02:36:44 -0400
Received: from szxga04-in.huawei.com ([45.249.212.190]:6361 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727115AbgFRGgn (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 18 Jun 2020 02:36:43 -0400
Received: from DGGEMS410-HUB.china.huawei.com (unknown [172.30.72.60])
        by Forcepoint Email with ESMTP id 839A2A6925E4F01565F6;
        Thu, 18 Jun 2020 14:36:40 +0800 (CST)
Received: from szvp000203569.huawei.com (10.120.216.130) by
 DGGEMS410-HUB.china.huawei.com (10.3.19.210) with Microsoft SMTP Server id
 14.3.487.0; Thu, 18 Jun 2020 14:36:32 +0800
From:   Chao Yu <yuchao0@huawei.com>
To:     <jaegeuk@kernel.org>
CC:     <linux-f2fs-devel@lists.sourceforge.net>,
        <linux-kernel@vger.kernel.org>, <chao@kernel.org>,
        Chao Yu <yuchao0@huawei.com>
Subject: [PATCH 4/5] f2fs: clean up parameter of f2fs_allocate_data_block()
Date:   Thu, 18 Jun 2020 14:36:24 +0800
Message-ID: <20200618063625.110273-4-yuchao0@huawei.com>
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

Use validation of @fio to inidcate whether caller want to serialize IOs
in io.io_list or not, then @add_list will be redundant, remove it.

Signed-off-by: Chao Yu <yuchao0@huawei.com>
---
 fs/f2fs/data.c    | 2 +-
 fs/f2fs/f2fs.h    | 2 +-
 fs/f2fs/gc.c      | 2 +-
 fs/f2fs/segment.c | 6 +++---
 4 files changed, 6 insertions(+), 6 deletions(-)

diff --git a/fs/f2fs/data.c b/fs/f2fs/data.c
index cbdf062d3562..dfd322515357 100644
--- a/fs/f2fs/data.c
+++ b/fs/f2fs/data.c
@@ -1366,7 +1366,7 @@ static int __allocate_data_block(struct dnode_of_data *dn, int seg_type)
 	set_summary(&sum, dn->nid, dn->ofs_in_node, ni.version);
 	old_blkaddr = dn->data_blkaddr;
 	f2fs_allocate_data_block(sbi, NULL, old_blkaddr, &dn->data_blkaddr,
-					&sum, seg_type, NULL, false);
+					&sum, seg_type, NULL);
 	if (GET_SEGNO(sbi, old_blkaddr) != NULL_SEGNO)
 		invalidate_mapping_pages(META_MAPPING(sbi),
 					old_blkaddr, old_blkaddr);
diff --git a/fs/f2fs/f2fs.h b/fs/f2fs/f2fs.h
index b74f0f5fcf3a..72a667f1d678 100644
--- a/fs/f2fs/f2fs.h
+++ b/fs/f2fs/f2fs.h
@@ -3350,7 +3350,7 @@ void f2fs_replace_block(struct f2fs_sb_info *sbi, struct dnode_of_data *dn,
 void f2fs_allocate_data_block(struct f2fs_sb_info *sbi, struct page *page,
 			block_t old_blkaddr, block_t *new_blkaddr,
 			struct f2fs_summary *sum, int type,
-			struct f2fs_io_info *fio, bool add_list);
+			struct f2fs_io_info *fio);
 void f2fs_wait_on_page_writeback(struct page *page,
 			enum page_type type, bool ordered, bool locked);
 void f2fs_wait_on_block_writeback(struct inode *inode, block_t blkaddr);
diff --git a/fs/f2fs/gc.c b/fs/f2fs/gc.c
index 3d27b939627e..bfc4eb2d8038 100644
--- a/fs/f2fs/gc.c
+++ b/fs/f2fs/gc.c
@@ -859,7 +859,7 @@ static int move_data_block(struct inode *inode, block_t bidx,
 	}
 
 	f2fs_allocate_data_block(fio.sbi, NULL, fio.old_blkaddr, &newaddr,
-					&sum, CURSEG_COLD_DATA, NULL, false);
+					&sum, CURSEG_COLD_DATA, NULL);
 
 	fio.encrypted_page = f2fs_pagecache_get_page(META_MAPPING(fio.sbi),
 				newaddr, FGP_LOCK | FGP_CREAT, GFP_NOFS);
diff --git a/fs/f2fs/segment.c b/fs/f2fs/segment.c
index cb861ed98ee3..113114f98087 100644
--- a/fs/f2fs/segment.c
+++ b/fs/f2fs/segment.c
@@ -3089,7 +3089,7 @@ static int __get_segment_type(struct f2fs_io_info *fio)
 void f2fs_allocate_data_block(struct f2fs_sb_info *sbi, struct page *page,
 		block_t old_blkaddr, block_t *new_blkaddr,
 		struct f2fs_summary *sum, int type,
-		struct f2fs_io_info *fio, bool add_list)
+		struct f2fs_io_info *fio)
 {
 	struct sit_info *sit_i = SIT_I(sbi);
 	struct curseg_info *curseg = CURSEG_I(sbi, type);
@@ -3157,7 +3157,7 @@ void f2fs_allocate_data_block(struct f2fs_sb_info *sbi, struct page *page,
 	if (F2FS_IO_ALIGNED(sbi))
 		fio->retry = false;
 
-	if (add_list) {
+	if (fio) {
 		struct f2fs_bio_info *io;
 
 		INIT_LIST_HEAD(&fio->list);
@@ -3206,7 +3206,7 @@ static void do_write_page(struct f2fs_summary *sum, struct f2fs_io_info *fio)
 		down_read(&fio->sbi->io_order_lock);
 reallocate:
 	f2fs_allocate_data_block(fio->sbi, fio->page, fio->old_blkaddr,
-			&fio->new_blkaddr, sum, type, fio, true);
+			&fio->new_blkaddr, sum, type, fio);
 	if (GET_SEGNO(fio->sbi, fio->old_blkaddr) != NULL_SEGNO)
 		invalidate_mapping_pages(META_MAPPING(fio->sbi),
 					fio->old_blkaddr, fio->old_blkaddr);
-- 
2.18.0.rc1

