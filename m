Return-Path: <SRS0=3e5Q=77=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2163DC433DF
	for <linux-kernel@archiver.kernel.org>; Thu, 18 Jun 2020 06:37:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 05F4621924
	for <linux-kernel@archiver.kernel.org>; Thu, 18 Jun 2020 06:37:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727926AbgFRGg7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 18 Jun 2020 02:36:59 -0400
Received: from szxga04-in.huawei.com ([45.249.212.190]:6360 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726952AbgFRGg7 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 18 Jun 2020 02:36:59 -0400
Received: from DGGEMS410-HUB.china.huawei.com (unknown [172.30.72.60])
        by Forcepoint Email with ESMTP id 7EA343DA2EC6CFCA4384;
        Thu, 18 Jun 2020 14:36:40 +0800 (CST)
Received: from szvp000203569.huawei.com (10.120.216.130) by
 DGGEMS410-HUB.china.huawei.com (10.3.19.210) with Microsoft SMTP Server id
 14.3.487.0; Thu, 18 Jun 2020 14:36:32 +0800
From:   Chao Yu <yuchao0@huawei.com>
To:     <jaegeuk@kernel.org>
CC:     <linux-f2fs-devel@lists.sourceforge.net>,
        <linux-kernel@vger.kernel.org>, <chao@kernel.org>,
        Chao Yu <yuchao0@huawei.com>
Subject: [PATCH 3/5] f2fs: shrink node_write lock coverage
Date:   Thu, 18 Jun 2020 14:36:23 +0800
Message-ID: <20200618063625.110273-3-yuchao0@huawei.com>
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

- to avoid race between checkpoint and quota file writeback, it
just needs to hold read lock of node_write in writeback path.
- node_write lock has covered all LFS data write paths, it's not
necessary, we only need to hold node_write lock at write path of
quota file.

Signed-off-by: Chao Yu <yuchao0@huawei.com>
---
 fs/f2fs/compress.c | 18 +++++++++++++++---
 fs/f2fs/data.c     | 12 ++++++++++++
 fs/f2fs/segment.c  | 11 -----------
 3 files changed, 27 insertions(+), 14 deletions(-)

diff --git a/fs/f2fs/compress.c b/fs/f2fs/compress.c
index 36b51795b0c3..3ff6c0305ec6 100644
--- a/fs/f2fs/compress.c
+++ b/fs/f2fs/compress.c
@@ -1096,8 +1096,16 @@ static int f2fs_write_compressed_pages(struct compress_ctx *cc,
 	loff_t psize;
 	int i, err;
 
-	if (!IS_NOQUOTA(inode) && !f2fs_trylock_op(sbi))
+	if (IS_NOQUOTA(inode)) {
+		/*
+		 * We need to wait for node_write to avoid block allocation during
+		 * checkpoint. This can only happen to quota writes which can cause
+		 * the below discard race condition.
+		 */
+		down_read(&sbi->node_write);
+	} else if (!f2fs_trylock_op(sbi)) {
 		return -EAGAIN;
+	}
 
 	set_new_dnode(&dn, cc->inode, NULL, NULL, 0);
 
@@ -1203,7 +1211,9 @@ static int f2fs_write_compressed_pages(struct compress_ctx *cc,
 		set_inode_flag(inode, FI_FIRST_BLOCK_WRITTEN);
 
 	f2fs_put_dnode(&dn);
-	if (!IS_NOQUOTA(inode))
+	if (IS_NOQUOTA(inode))
+		up_read(&sbi->node_write);
+	else
 		f2fs_unlock_op(sbi);
 
 	spin_lock(&fi->i_size_lock);
@@ -1230,7 +1240,9 @@ static int f2fs_write_compressed_pages(struct compress_ctx *cc,
 out_put_dnode:
 	f2fs_put_dnode(&dn);
 out_unlock_op:
-	if (!IS_NOQUOTA(inode))
+	if (IS_NOQUOTA(inode))
+		up_read(&sbi->node_write);
+	else
 		f2fs_unlock_op(sbi);
 	return -EAGAIN;
 }
diff --git a/fs/f2fs/data.c b/fs/f2fs/data.c
index c78ce08f6400..cbdf062d3562 100644
--- a/fs/f2fs/data.c
+++ b/fs/f2fs/data.c
@@ -2719,8 +2719,20 @@ int f2fs_write_single_data_page(struct page *page, int *submitted,
 
 	/* Dentry/quota blocks are controlled by checkpoint */
 	if (S_ISDIR(inode->i_mode) || IS_NOQUOTA(inode)) {
+		/*
+		 * We need to wait for node_write to avoid block allocation during
+		 * checkpoint. This can only happen to quota writes which can cause
+		 * the below discard race condition.
+		 */
+		if (IS_NOQUOTA(inode))
+			down_read(&sbi->node_write);
+
 		fio.need_lock = LOCK_DONE;
 		err = f2fs_do_write_data_page(&fio);
+
+		if (IS_NOQUOTA(inode))
+			up_read(&sbi->node_write);
+
 		goto done;
 	}
 
diff --git a/fs/f2fs/segment.c b/fs/f2fs/segment.c
index 5b2a6f865a6d..cb861ed98ee3 100644
--- a/fs/f2fs/segment.c
+++ b/fs/f2fs/segment.c
@@ -3107,14 +3107,6 @@ void f2fs_allocate_data_block(struct f2fs_sb_info *sbi, struct page *page,
 		type = CURSEG_COLD_DATA;
 	}
 
-	/*
-	 * We need to wait for node_write to avoid block allocation during
-	 * checkpoint. This can only happen to quota writes which can cause
-	 * the below discard race condition.
-	 */
-	if (IS_DATASEG(type))
-		down_write(&sbi->node_write);
-
 	down_read(&SM_I(sbi)->curseg_lock);
 
 	mutex_lock(&curseg->curseg_mutex);
@@ -3180,9 +3172,6 @@ void f2fs_allocate_data_block(struct f2fs_sb_info *sbi, struct page *page,
 
 	up_read(&SM_I(sbi)->curseg_lock);
 
-	if (IS_DATASEG(type))
-		up_write(&sbi->node_write);
-
 	if (put_pin_sem)
 		up_read(&sbi->pin_sem);
 }
-- 
2.18.0.rc1

