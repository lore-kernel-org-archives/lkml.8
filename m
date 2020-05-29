Return-Path: <SRS0=LUA0=7L=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 70C7EC433DF
	for <linux-kernel@archiver.kernel.org>; Fri, 29 May 2020 09:30:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 56DCA2072D
	for <linux-kernel@archiver.kernel.org>; Fri, 29 May 2020 09:30:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726451AbgE2JaJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 29 May 2020 05:30:09 -0400
Received: from szxga04-in.huawei.com ([45.249.212.190]:5391 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725601AbgE2JaI (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 29 May 2020 05:30:08 -0400
Received: from DGGEMS405-HUB.china.huawei.com (unknown [172.30.72.59])
        by Forcepoint Email with ESMTP id 9C4A5505144E1C536119;
        Fri, 29 May 2020 17:30:06 +0800 (CST)
Received: from szvp000203569.huawei.com (10.120.216.130) by
 DGGEMS405-HUB.china.huawei.com (10.3.19.205) with Microsoft SMTP Server id
 14.3.487.0; Fri, 29 May 2020 17:30:00 +0800
From:   Chao Yu <yuchao0@huawei.com>
To:     <jaegeuk@kernel.org>
CC:     <linux-f2fs-devel@lists.sourceforge.net>,
        <linux-kernel@vger.kernel.org>, <chao@kernel.org>,
        Chao Yu <yuchao0@huawei.com>
Subject: [PATCH] Revert "f2fs: fix quota_sync failure due to f2fs_lock_op"
Date:   Fri, 29 May 2020 17:29:47 +0800
Message-ID: <20200529092947.7890-1-yuchao0@huawei.com>
X-Mailer: git-send-email 2.18.0.rc1
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.120.216.130]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Under heavy fsstress, we may triggle panic while issuing discard,
because __check_sit_bitmap() detects that discard command may earse
valid data blocks, the root cause is as below race stack described,
since we removed lock when flushing quota data, quota data writeback
may race with write_checkpoint(), so that it causes inconsistency in
between cached discard entry and segment bitmap.

- f2fs_write_checkpoint
 - block_operations
  - set_sbi_flag(sbi, SBI_QUOTA_SKIP_FLUSH)
 - f2fs_flush_sit_entries
  - add_discard_addrs
   - __set_bit_le(i, (void *)de->discard_map);
						- f2fs_write_data_pages
						 - f2fs_write_single_data_page
						   : inode is quota one, cp_rwsem won't be locked
						  - f2fs_do_write_data_page
						   - f2fs_allocate_data_block
						    - f2fs_wait_discard_bio
						      : discard entry has not been added yet.
						    - update_sit_entry
 - f2fs_clear_prefree_segments
  - f2fs_issue_discard
  : add discard entry

This patch fixes this issue by reverting 435cbab95e39 ("f2fs: fix quota_sync
failure due to f2fs_lock_op").

Fixes: 435cbab95e39 ("f2fs: fix quota_sync failure due to f2fs_lock_op")
Signed-off-by: Chao Yu <yuchao0@huawei.com>
---
 fs/f2fs/compress.c | 8 +++-----
 fs/f2fs/data.c     | 4 ++--
 2 files changed, 5 insertions(+), 7 deletions(-)

diff --git a/fs/f2fs/compress.c b/fs/f2fs/compress.c
index a53578a89211..62c4857ae46d 100644
--- a/fs/f2fs/compress.c
+++ b/fs/f2fs/compress.c
@@ -1097,7 +1097,7 @@ static int f2fs_write_compressed_pages(struct compress_ctx *cc,
 	loff_t psize;
 	int i, err;
 
-	if (!IS_NOQUOTA(inode) && !f2fs_trylock_op(sbi))
+	if (!f2fs_trylock_op(sbi))
 		return -EAGAIN;
 
 	set_new_dnode(&dn, cc->inode, NULL, NULL, 0);
@@ -1204,8 +1204,7 @@ static int f2fs_write_compressed_pages(struct compress_ctx *cc,
 		set_inode_flag(inode, FI_FIRST_BLOCK_WRITTEN);
 
 	f2fs_put_dnode(&dn);
-	if (!IS_NOQUOTA(inode))
-		f2fs_unlock_op(sbi);
+	f2fs_unlock_op(sbi);
 
 	spin_lock(&fi->i_size_lock);
 	if (fi->last_disk_size < psize)
@@ -1231,8 +1230,7 @@ static int f2fs_write_compressed_pages(struct compress_ctx *cc,
 out_put_dnode:
 	f2fs_put_dnode(&dn);
 out_unlock_op:
-	if (!IS_NOQUOTA(inode))
-		f2fs_unlock_op(sbi);
+	f2fs_unlock_op(sbi);
 	return -EAGAIN;
 }
 
diff --git a/fs/f2fs/data.c b/fs/f2fs/data.c
index 999a36ff05f1..d983ad54f318 100644
--- a/fs/f2fs/data.c
+++ b/fs/f2fs/data.c
@@ -2724,8 +2724,8 @@ int f2fs_write_single_data_page(struct page *page, int *submitted,
 			f2fs_available_free_memory(sbi, BASE_CHECK))))
 		goto redirty_out;
 
-	/* Dentry/quota blocks are controlled by checkpoint */
-	if (S_ISDIR(inode->i_mode) || IS_NOQUOTA(inode)) {
+	/* Dentry blocks are controlled by checkpoint */
+	if (S_ISDIR(inode->i_mode)) {
 		fio.need_lock = LOCK_DONE;
 		err = f2fs_do_write_data_page(&fio);
 		goto done;
-- 
2.18.0.rc1

