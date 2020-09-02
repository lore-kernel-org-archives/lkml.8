Return-Path: <SRS0=728o=CL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B271EC433E6
	for <linux-kernel@archiver.kernel.org>; Wed,  2 Sep 2020 06:29:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8AC7C2078B
	for <linux-kernel@archiver.kernel.org>; Wed,  2 Sep 2020 06:29:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="mJRww8wf"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726489AbgIBG3T (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 2 Sep 2020 02:29:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51584 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726140AbgIBG3S (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Sep 2020 02:29:18 -0400
Received: from mail-pf1-x442.google.com (mail-pf1-x442.google.com [IPv6:2607:f8b0:4864:20::442])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8CEE8C061244
        for <linux-kernel@vger.kernel.org>; Tue,  1 Sep 2020 23:29:18 -0700 (PDT)
Received: by mail-pf1-x442.google.com with SMTP id d22so2274412pfn.5
        for <linux-kernel@vger.kernel.org>; Tue, 01 Sep 2020 23:29:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=EsYUU8I5g60A3ycIDJI/Ukd4xor/sPtJdrvcDFwTS0g=;
        b=mJRww8wfz9kGBfMY76OD7lV9GZgpleY9nIqAuKr4QKbvETL6E2CvnzQrMhrgPbNgkV
         VwcI+CCch9v74mSMITURijnGb+UI/7FZgM4jqhL+k7JAwY0D+nq+QIbbEA9eAsKTTUsf
         z7jp76is0GZHwSI8rvB0Dog5SXFRFnNbWwv3DJZgc+os6UhPKAx2sjQRWFZSYH5elm/2
         dbAjrRqKaqz3SyLvFV9HaaFevgiHPyoDIxzgpxc2YN9ByQobqA8AGz5UDElefdL8Y/LQ
         YEJvNznxCcfHMhmP3J7RCbP1h3UI3+42SpHZ2rBHnNLXL13u64avv+W9HLYbuK4JZu7c
         DnRg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=EsYUU8I5g60A3ycIDJI/Ukd4xor/sPtJdrvcDFwTS0g=;
        b=D3pUihjTUnhT8U+K3mIfc8sNx5sYgrYqXmGtoPWaiK8YgcHJ5COKs58bFkPhIN4NXr
         gNromgXb6SHXb+d3C7F5SWxa962ZTVlrZql3g3V/RD7EyI+v8EvdPx0riqUr6XI1s7aJ
         0jvyLjWkiPKQK9oG9g4ZT6f+BifnxWcTehf2n8Ly7e/lzxOAM4Yb5pqV5ioow+JHQzSm
         VzL1DKhuushiewlwlzanWCTAGZXEs8vOS7itH5JYGqC5DZHIF+rCWNzEXA7HFLWjXSbp
         Hk8kzmte1oDe3kVb9ynli8T6qv5Tm17atmlYoXeTZwETDmCiaQnmTLTYuHntGdhBaupY
         yH9A==
X-Gm-Message-State: AOAM531YXK4w3V6OHYaOXQn9ivtZgqyqOy8E5iSYCAFyEO7xOvVejEAw
        rifMOCS3NbRT9SsCiEu8BuxKHbtsK/Y=
X-Google-Smtp-Source: ABdhPJw0LM7jsycQU0UI4IXXA7jR/Agzl4Fk5XRkkDaiv9eU9Xnrh5doNT2wZ2xKtgoiCr3Yjk9J5g==
X-Received: by 2002:a05:6a00:23c5:: with SMTP id g5mr1904665pfc.160.1599028157433;
        Tue, 01 Sep 2020 23:29:17 -0700 (PDT)
Received: from daehojeong1.seo.corp.google.com ([2401:fa00:d:1:a6ae:11ff:fe18:6ce2])
        by smtp.gmail.com with ESMTPSA id b64sm4059390pfa.200.2020.09.01.23.29.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 01 Sep 2020 23:29:16 -0700 (PDT)
From:   Daeho Jeong <daeho43@gmail.com>
To:     linux-kernel@vger.kernel.org,
        linux-f2fs-devel@lists.sourceforge.net, kernel-team@android.com
Cc:     Daeho Jeong <daehojeong@google.com>
Subject: [PATCH] f2fs: change i_compr_blocks of inode to atomic value
Date:   Wed,  2 Sep 2020 15:29:10 +0900
Message-Id: <20200902062910.4061083-1-daeho43@gmail.com>
X-Mailer: git-send-email 2.28.0.402.g5ffc5be6b7-goog
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
protect it by changing it with atomic type value.

Signed-off-by: Daeho Jeong <daehojeong@google.com>
---
 fs/f2fs/f2fs.h  | 15 +++++++++------
 fs/f2fs/file.c  | 18 ++++++++++--------
 fs/f2fs/inode.c | 11 +++++++----
 fs/f2fs/super.c |  1 +
 4 files changed, 27 insertions(+), 18 deletions(-)

diff --git a/fs/f2fs/f2fs.h b/fs/f2fs/f2fs.h
index f60414805e05..633957e14944 100644
--- a/fs/f2fs/f2fs.h
+++ b/fs/f2fs/f2fs.h
@@ -801,7 +801,7 @@ struct f2fs_inode_info {
 	struct timespec64 i_disk_time[4];/* inode disk times */
 
 	/* for file compress */
-	u64 i_compr_blocks;			/* # of compressed blocks */
+	atomic64_t i_compr_blocks;		/* # of compressed blocks */
 	unsigned char i_compress_algorithm;	/* algorithm type */
 	unsigned char i_log_cluster_size;	/* log of cluster size */
 	unsigned int i_cluster_size;		/* cluster size */
@@ -3933,14 +3933,16 @@ static inline void set_compress_context(struct inode *inode)
 static inline u64 f2fs_disable_compressed_file(struct inode *inode)
 {
 	struct f2fs_inode_info *fi = F2FS_I(inode);
+	u64 i_compr_blocks;
 
 	if (!f2fs_compressed_file(inode))
 		return 0;
 	if (S_ISREG(inode->i_mode)) {
 		if (get_dirty_pages(inode))
 			return 1;
-		if (fi->i_compr_blocks)
-			return fi->i_compr_blocks;
+		i_compr_blocks = atomic64_read(&fi->i_compr_blocks);
+		if (i_compr_blocks)
+			return i_compr_blocks;
 	}
 
 	fi->i_flags &= ~F2FS_COMPR_FL;
@@ -4057,16 +4059,17 @@ static inline void f2fs_i_compr_blocks_update(struct inode *inode,
 						u64 blocks, bool add)
 {
 	int diff = F2FS_I(inode)->i_cluster_size - blocks;
+	struct f2fs_inode_info *fi = F2FS_I(inode);
 
 	/* don't update i_compr_blocks if saved blocks were released */
-	if (!add && !F2FS_I(inode)->i_compr_blocks)
+	if (!add && !atomic64_read(&fi->i_compr_blocks))
 		return;
 
 	if (add) {
-		F2FS_I(inode)->i_compr_blocks += diff;
+		atomic64_add(diff, &fi->i_compr_blocks);
 		stat_add_compr_blocks(inode, diff);
 	} else {
-		F2FS_I(inode)->i_compr_blocks -= diff;
+		atomic64_sub(diff, &fi->i_compr_blocks);
 		stat_sub_compr_blocks(inode, diff);
 	}
 	f2fs_mark_inode_dirty_sync(inode, true);
diff --git a/fs/f2fs/file.c b/fs/f2fs/file.c
index cc7f5670390f..4e4e369b97e5 100644
--- a/fs/f2fs/file.c
+++ b/fs/f2fs/file.c
@@ -564,7 +564,7 @@ void f2fs_truncate_data_blocks_range(struct dnode_of_data *dn, int count)
 	bool compressed_cluster = false;
 	int cluster_index = 0, valid_blocks = 0;
 	int cluster_size = F2FS_I(dn->inode)->i_cluster_size;
-	bool released = !F2FS_I(dn->inode)->i_compr_blocks;
+	bool released = !atomic64_read(&F2FS_I(dn->inode)->i_compr_blocks);
 
 	if (IS_INODE(dn->node_page) && f2fs_has_extra_attr(dn->inode))
 		base = get_extra_isize(dn->inode);
@@ -3436,7 +3436,7 @@ static int f2fs_get_compress_blocks(struct file *filp, unsigned long arg)
 	if (!f2fs_compressed_file(inode))
 		return -EINVAL;
 
-	blocks = F2FS_I(inode)->i_compr_blocks;
+	blocks = atomic64_read(&F2FS_I(inode)->i_compr_blocks);
 	return put_user(blocks, (u64 __user *)arg);
 }
 
@@ -3535,7 +3535,7 @@ static int f2fs_release_compress_blocks(struct file *filp, unsigned long arg)
 	if (ret)
 		goto out;
 
-	if (!F2FS_I(inode)->i_compr_blocks)
+	if (!atomic64_read(&F2FS_I(inode)->i_compr_blocks))
 		goto out;
 
 	F2FS_I(inode)->i_flags |= F2FS_IMMUTABLE_FL;
@@ -3588,14 +3588,15 @@ static int f2fs_release_compress_blocks(struct file *filp, unsigned long arg)
 
 	if (ret >= 0) {
 		ret = put_user(released_blocks, (u64 __user *)arg);
-	} else if (released_blocks && F2FS_I(inode)->i_compr_blocks) {
+	} else if (released_blocks &&
+			atomic64_read(&F2FS_I(inode)->i_compr_blocks)) {
 		set_sbi_flag(sbi, SBI_NEED_FSCK);
 		f2fs_warn(sbi, "%s: partial blocks were released i_ino=%lx "
 			"iblocks=%llu, released=%u, compr_blocks=%llu, "
 			"run fsck to fix.",
 			__func__, inode->i_ino, inode->i_blocks,
 			released_blocks,
-			F2FS_I(inode)->i_compr_blocks);
+			atomic64_read(&F2FS_I(inode)->i_compr_blocks));
 	}
 
 	return ret;
@@ -3683,7 +3684,7 @@ static int f2fs_reserve_compress_blocks(struct file *filp, unsigned long arg)
 	if (ret)
 		return ret;
 
-	if (F2FS_I(inode)->i_compr_blocks)
+	if (atomic64_read(&F2FS_I(inode)->i_compr_blocks))
 		goto out;
 
 	f2fs_balance_fs(F2FS_I_SB(inode), true);
@@ -3747,14 +3748,15 @@ static int f2fs_reserve_compress_blocks(struct file *filp, unsigned long arg)
 
 	if (ret >= 0) {
 		ret = put_user(reserved_blocks, (u64 __user *)arg);
-	} else if (reserved_blocks && F2FS_I(inode)->i_compr_blocks) {
+	} else if (reserved_blocks &&
+			atomic64_read(&F2FS_I(inode)->i_compr_blocks)) {
 		set_sbi_flag(sbi, SBI_NEED_FSCK);
 		f2fs_warn(sbi, "%s: partial blocks were released i_ino=%lx "
 			"iblocks=%llu, reserved=%u, compr_blocks=%llu, "
 			"run fsck to fix.",
 			__func__, inode->i_ino, inode->i_blocks,
 			reserved_blocks,
-			F2FS_I(inode)->i_compr_blocks);
+			atomic64_read(&F2FS_I(inode)->i_compr_blocks));
 	}
 
 	return ret;
diff --git a/fs/f2fs/inode.c b/fs/f2fs/inode.c
index 66969ae852b9..e86857af9699 100644
--- a/fs/f2fs/inode.c
+++ b/fs/f2fs/inode.c
@@ -442,7 +442,8 @@ static int do_read_inode(struct inode *inode)
 					(fi->i_flags & F2FS_COMPR_FL)) {
 		if (F2FS_FITS_IN_INODE(ri, fi->i_extra_isize,
 					i_log_cluster_size)) {
-			fi->i_compr_blocks = le64_to_cpu(ri->i_compr_blocks);
+			atomic64_set(&fi->i_compr_blocks,
+					le64_to_cpu(ri->i_compr_blocks));
 			fi->i_compress_algorithm = ri->i_compress_algorithm;
 			fi->i_log_cluster_size = ri->i_log_cluster_size;
 			fi->i_cluster_size = 1 << fi->i_log_cluster_size;
@@ -460,7 +461,7 @@ static int do_read_inode(struct inode *inode)
 	stat_inc_inline_inode(inode);
 	stat_inc_inline_dir(inode);
 	stat_inc_compr_inode(inode);
-	stat_add_compr_blocks(inode, F2FS_I(inode)->i_compr_blocks);
+	stat_add_compr_blocks(inode, atomic64_read(&fi->i_compr_blocks));
 
 	return 0;
 }
@@ -619,7 +620,8 @@ void f2fs_update_inode(struct inode *inode, struct page *node_page)
 			F2FS_FITS_IN_INODE(ri, F2FS_I(inode)->i_extra_isize,
 							i_log_cluster_size)) {
 			ri->i_compr_blocks =
-				cpu_to_le64(F2FS_I(inode)->i_compr_blocks);
+				cpu_to_le64(atomic64_read(
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
+			atomic64_read(&F2FS_I(inode)->i_compr_blocks));
 
 	if (likely(!f2fs_cp_error(sbi) &&
 				!is_sbi_flag_set(sbi, SBI_CP_DISABLED)))
diff --git a/fs/f2fs/super.c b/fs/f2fs/super.c
index 83bf9a02f83f..65613500e1ab 100644
--- a/fs/f2fs/super.c
+++ b/fs/f2fs/super.c
@@ -1011,6 +1011,7 @@ static struct inode *f2fs_alloc_inode(struct super_block *sb)
 
 	/* Initialize f2fs-specific inode info */
 	atomic_set(&fi->dirty_pages, 0);
+	atomic64_set(&fi->i_compr_blocks, 0);
 	init_rwsem(&fi->i_sem);
 	spin_lock_init(&fi->i_size_lock);
 	INIT_LIST_HEAD(&fi->dirty_list);
-- 
2.28.0.402.g5ffc5be6b7-goog

