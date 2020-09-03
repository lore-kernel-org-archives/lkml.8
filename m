Return-Path: <SRS0=vQOp=CM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.0 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,UNWANTED_LANGUAGE_BODY,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 370B7C433E7
	for <linux-kernel@archiver.kernel.org>; Thu,  3 Sep 2020 03:03:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0A05920773
	for <linux-kernel@archiver.kernel.org>; Thu,  3 Sep 2020 03:03:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="vS4O4DyS"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728134AbgICDDa (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 2 Sep 2020 23:03:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43668 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726528AbgICDD3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Sep 2020 23:03:29 -0400
Received: from mail-pg1-x544.google.com (mail-pg1-x544.google.com [IPv6:2607:f8b0:4864:20::544])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 81E73C061244
        for <linux-kernel@vger.kernel.org>; Wed,  2 Sep 2020 20:03:29 -0700 (PDT)
Received: by mail-pg1-x544.google.com with SMTP id p37so917919pgl.3
        for <linux-kernel@vger.kernel.org>; Wed, 02 Sep 2020 20:03:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=1mX3kJYbEoZZc2Q4KR/3QraEllIF94cqfK4th0XU5bM=;
        b=vS4O4DySMAN86hBme/s0rJyXHneSq4ZEJO6/+3JxAXCwjd9sXZtGqiIeAYs5FaTp53
         bBFJH5GkjWW1JXoEBCGTf5YAx9BQWKhxSj+3eRra0xP/CziPBQadT0QhRsW8RQRigX+q
         ZhQcerCsRhskqruY30BqsLkYun+ATtS0zZwYOK3szAWn6jJ13iF9dCrLQQII62pQ8mOZ
         Mbw6KbtdqeHjD6JTrhJXXWQy4uZ1dNXZKZksuuZA1m/FsxYqWtHWdw7nDH3UUM5CLzNj
         I+IDcOyiTnFWzDxwHaPW+l+o+bjNOiQ4rue7PwTYr9ubq7fedPyrbNSBRv1PKSfuyDQm
         H8Nw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=1mX3kJYbEoZZc2Q4KR/3QraEllIF94cqfK4th0XU5bM=;
        b=nI8zsX2h0U4kIjl+PdhO75l7SHm73yde4KQlR0lyAyt8BmvdI6IG4J+p5tiOqUcv9I
         MjzamzDgq7i9wfUmHjgBa9jTTrWYPoFPlSpo3WGOZyzxrMndoiTHI3KzSEVvK2jUrLe4
         2+ioF80g4C99nWPmQGPc8WGuzvNiyS2ZRNNmUbiog0yVC2mEKb9gfqcuAQBd/uiasH2W
         9GWlg+SBsmQ+YVBHaDocR1u5yZW+E0sgv5f7QODHjwZ0XqRbxT1P9TPSa4jWkn2Uub9/
         5fKujQi8eFL1tVu+zXKtiXbjqP+h7B39sCFyUY+qeOq5J52coMa4ucZfvNWOrjsxQQM6
         +Sdw==
X-Gm-Message-State: AOAM530xEawe+ZbdtD35DSMpOos/jO0vrqv8rvuIyh3xIm/ALgxW4ODK
        EmW0SF9AM2cpD6b8iZA+NGiqJb4N0qA=
X-Google-Smtp-Source: ABdhPJwhRPIpHJkC4/vYcND5JKcBRFyJbiuHSVgK/Pw0ZmBdHv28sUMFwvL0Bak6TvIFyIK9Uwc2jw==
X-Received: by 2002:a65:6913:: with SMTP id s19mr961755pgq.116.1599102208236;
        Wed, 02 Sep 2020 20:03:28 -0700 (PDT)
Received: from daehojeong1.seo.corp.google.com ([2401:fa00:d:1:a6ae:11ff:fe18:6ce2])
        by smtp.gmail.com with ESMTPSA id j1sm697737pgp.93.2020.09.02.20.03.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 02 Sep 2020 20:03:27 -0700 (PDT)
From:   Daeho Jeong <daeho43@gmail.com>
To:     linux-kernel@vger.kernel.org,
        linux-f2fs-devel@lists.sourceforge.net, kernel-team@android.com
Cc:     Daeho Jeong <daehojeong@google.com>
Subject: [PATCH v2] f2fs: change i_compr_blocks of inode to atomic value
Date:   Thu,  3 Sep 2020 12:03:20 +0900
Message-Id: <20200903030320.330507-1-daeho43@gmail.com>
X-Mailer: git-send-email 2.28.0.526.ge36021eeef-goog
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Daeho Jeong <daehojeong@google.com>

writepages() can be concurrently invoked for the same file by different
threads such as a thread fsyncing the file and a kworker kernel thread.
So, changing i_compr_blocks without protection is racy and we need to
protect it by changing it with atomic type value. Plus, we don't need
a 64bit value for i_compr_blocks, so just we will use a atomic value,
not atomic64.

Signed-off-by: Daeho Jeong <daehojeong@google.com>
---
Changes in v2:
 - Change atomic64 to atomic and remove unnecessary part
---
 fs/f2fs/f2fs.h  | 18 ++++++++----------
 fs/f2fs/file.c  | 22 ++++++++++++----------
 fs/f2fs/inode.c | 11 +++++++----
 fs/f2fs/super.c |  1 +
 4 files changed, 28 insertions(+), 24 deletions(-)

diff --git a/fs/f2fs/f2fs.h b/fs/f2fs/f2fs.h
index f60414805e05..f6b8ac10a55c 100644
--- a/fs/f2fs/f2fs.h
+++ b/fs/f2fs/f2fs.h
@@ -801,7 +801,7 @@ struct f2fs_inode_info {
 	struct timespec64 i_disk_time[4];/* inode disk times */
 
 	/* for file compress */
-	u64 i_compr_blocks;			/* # of compressed blocks */
+	atomic_t i_compr_blocks;		/* # of compressed blocks */
 	unsigned char i_compress_algorithm;	/* algorithm type */
 	unsigned char i_log_cluster_size;	/* log of cluster size */
 	unsigned int i_cluster_size;		/* cluster size */
@@ -3936,12 +3936,9 @@ static inline u64 f2fs_disable_compressed_file(struct inode *inode)
 
 	if (!f2fs_compressed_file(inode))
 		return 0;
-	if (S_ISREG(inode->i_mode)) {
-		if (get_dirty_pages(inode))
-			return 1;
-		if (fi->i_compr_blocks)
-			return fi->i_compr_blocks;
-	}
+	if (S_ISREG(inode->i_mode) &&
+		(get_dirty_pages(inode) || atomic_read(&fi->i_compr_blocks)))
+		return 1;
 
 	fi->i_flags &= ~F2FS_COMPR_FL;
 	stat_dec_compr_inode(inode);
@@ -4057,16 +4054,17 @@ static inline void f2fs_i_compr_blocks_update(struct inode *inode,
 						u64 blocks, bool add)
 {
 	int diff = F2FS_I(inode)->i_cluster_size - blocks;
+	struct f2fs_inode_info *fi = F2FS_I(inode);
 
 	/* don't update i_compr_blocks if saved blocks were released */
-	if (!add && !F2FS_I(inode)->i_compr_blocks)
+	if (!add && !atomic_read(&fi->i_compr_blocks))
 		return;
 
 	if (add) {
-		F2FS_I(inode)->i_compr_blocks += diff;
+		atomic_add(diff, &fi->i_compr_blocks);
 		stat_add_compr_blocks(inode, diff);
 	} else {
-		F2FS_I(inode)->i_compr_blocks -= diff;
+		atomic_sub(diff, &fi->i_compr_blocks);
 		stat_sub_compr_blocks(inode, diff);
 	}
 	f2fs_mark_inode_dirty_sync(inode, true);
diff --git a/fs/f2fs/file.c b/fs/f2fs/file.c
index cc7f5670390f..adc4acad488a 100644
--- a/fs/f2fs/file.c
+++ b/fs/f2fs/file.c
@@ -564,7 +564,7 @@ void f2fs_truncate_data_blocks_range(struct dnode_of_data *dn, int count)
 	bool compressed_cluster = false;
 	int cluster_index = 0, valid_blocks = 0;
 	int cluster_size = F2FS_I(dn->inode)->i_cluster_size;
-	bool released = !F2FS_I(dn->inode)->i_compr_blocks;
+	bool released = !atomic_read(&F2FS_I(dn->inode)->i_compr_blocks);
 
 	if (IS_INODE(dn->node_page) && f2fs_has_extra_attr(dn->inode))
 		base = get_extra_isize(dn->inode);
@@ -3436,7 +3436,7 @@ static int f2fs_get_compress_blocks(struct file *filp, unsigned long arg)
 	if (!f2fs_compressed_file(inode))
 		return -EINVAL;
 
-	blocks = F2FS_I(inode)->i_compr_blocks;
+	blocks = atomic_read(&F2FS_I(inode)->i_compr_blocks);
 	return put_user(blocks, (u64 __user *)arg);
 }
 
@@ -3535,7 +3535,7 @@ static int f2fs_release_compress_blocks(struct file *filp, unsigned long arg)
 	if (ret)
 		goto out;
 
-	if (!F2FS_I(inode)->i_compr_blocks)
+	if (!atomic_read(&F2FS_I(inode)->i_compr_blocks))
 		goto out;
 
 	F2FS_I(inode)->i_flags |= F2FS_IMMUTABLE_FL;
@@ -3588,14 +3588,15 @@ static int f2fs_release_compress_blocks(struct file *filp, unsigned long arg)
 
 	if (ret >= 0) {
 		ret = put_user(released_blocks, (u64 __user *)arg);
-	} else if (released_blocks && F2FS_I(inode)->i_compr_blocks) {
+	} else if (released_blocks &&
+			atomic_read(&F2FS_I(inode)->i_compr_blocks)) {
 		set_sbi_flag(sbi, SBI_NEED_FSCK);
 		f2fs_warn(sbi, "%s: partial blocks were released i_ino=%lx "
-			"iblocks=%llu, released=%u, compr_blocks=%llu, "
+			"iblocks=%llu, released=%u, compr_blocks=%u, "
 			"run fsck to fix.",
 			__func__, inode->i_ino, inode->i_blocks,
 			released_blocks,
-			F2FS_I(inode)->i_compr_blocks);
+			atomic_read(&F2FS_I(inode)->i_compr_blocks));
 	}
 
 	return ret;
@@ -3683,7 +3684,7 @@ static int f2fs_reserve_compress_blocks(struct file *filp, unsigned long arg)
 	if (ret)
 		return ret;
 
-	if (F2FS_I(inode)->i_compr_blocks)
+	if (atomic_read(&F2FS_I(inode)->i_compr_blocks))
 		goto out;
 
 	f2fs_balance_fs(F2FS_I_SB(inode), true);
@@ -3747,14 +3748,15 @@ static int f2fs_reserve_compress_blocks(struct file *filp, unsigned long arg)
 
 	if (ret >= 0) {
 		ret = put_user(reserved_blocks, (u64 __user *)arg);
-	} else if (reserved_blocks && F2FS_I(inode)->i_compr_blocks) {
+	} else if (reserved_blocks &&
+			atomic_read(&F2FS_I(inode)->i_compr_blocks)) {
 		set_sbi_flag(sbi, SBI_NEED_FSCK);
 		f2fs_warn(sbi, "%s: partial blocks were released i_ino=%lx "
-			"iblocks=%llu, reserved=%u, compr_blocks=%llu, "
+			"iblocks=%llu, reserved=%u, compr_blocks=%u, "
 			"run fsck to fix.",
 			__func__, inode->i_ino, inode->i_blocks,
 			reserved_blocks,
-			F2FS_I(inode)->i_compr_blocks);
+			atomic_read(&F2FS_I(inode)->i_compr_blocks));
 	}
 
 	return ret;
diff --git a/fs/f2fs/inode.c b/fs/f2fs/inode.c
index 66969ae852b9..2ed935c13aed 100644
--- a/fs/f2fs/inode.c
+++ b/fs/f2fs/inode.c
@@ -442,7 +442,8 @@ static int do_read_inode(struct inode *inode)
 					(fi->i_flags & F2FS_COMPR_FL)) {
 		if (F2FS_FITS_IN_INODE(ri, fi->i_extra_isize,
 					i_log_cluster_size)) {
-			fi->i_compr_blocks = le64_to_cpu(ri->i_compr_blocks);
+			atomic_set(&fi->i_compr_blocks,
+					le64_to_cpu(ri->i_compr_blocks));
 			fi->i_compress_algorithm = ri->i_compress_algorithm;
 			fi->i_log_cluster_size = ri->i_log_cluster_size;
 			fi->i_cluster_size = 1 << fi->i_log_cluster_size;
@@ -460,7 +461,7 @@ static int do_read_inode(struct inode *inode)
 	stat_inc_inline_inode(inode);
 	stat_inc_inline_dir(inode);
 	stat_inc_compr_inode(inode);
-	stat_add_compr_blocks(inode, F2FS_I(inode)->i_compr_blocks);
+	stat_add_compr_blocks(inode, atomic_read(&fi->i_compr_blocks));
 
 	return 0;
 }
@@ -619,7 +620,8 @@ void f2fs_update_inode(struct inode *inode, struct page *node_page)
 			F2FS_FITS_IN_INODE(ri, F2FS_I(inode)->i_extra_isize,
 							i_log_cluster_size)) {
 			ri->i_compr_blocks =
-				cpu_to_le64(F2FS_I(inode)->i_compr_blocks);
+				cpu_to_le64(atomic_read(
+					&F2FS_I(inode)->i_compr_blocks));
 			ri->i_compress_algorithm =
 				F2FS_I(inode)->i_compress_algorithm;
 			ri->i_log_cluster_size =
@@ -768,7 +770,8 @@ void f2fs_evict_inode(struct inode *inode)
 	stat_dec_inline_dir(inode);
 	stat_dec_inline_inode(inode);
 	stat_dec_compr_inode(inode);
-	stat_sub_compr_blocks(inode, F2FS_I(inode)->i_compr_blocks);
+	stat_sub_compr_blocks(inode,
+			atomic_read(&F2FS_I(inode)->i_compr_blocks));
 
 	if (likely(!f2fs_cp_error(sbi) &&
 				!is_sbi_flag_set(sbi, SBI_CP_DISABLED)))
diff --git a/fs/f2fs/super.c b/fs/f2fs/super.c
index 83bf9a02f83f..813aa207824c 100644
--- a/fs/f2fs/super.c
+++ b/fs/f2fs/super.c
@@ -1011,6 +1011,7 @@ static struct inode *f2fs_alloc_inode(struct super_block *sb)
 
 	/* Initialize f2fs-specific inode info */
 	atomic_set(&fi->dirty_pages, 0);
+	atomic_set(&fi->i_compr_blocks, 0);
 	init_rwsem(&fi->i_sem);
 	spin_lock_init(&fi->i_size_lock);
 	INIT_LIST_HEAD(&fi->dirty_list);
-- 
2.28.0.526.ge36021eeef-goog

