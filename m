Return-Path: <SRS0=F/Af=7W=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3B1CAC433DF
	for <linux-kernel@archiver.kernel.org>; Tue,  9 Jun 2020 06:01:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0738C20812
	for <linux-kernel@archiver.kernel.org>; Tue,  9 Jun 2020 06:01:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="UyT/VVi1"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727825AbgFIGBt (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 9 Jun 2020 02:01:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44860 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726886AbgFIGBq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 9 Jun 2020 02:01:46 -0400
Received: from mail-pl1-x644.google.com (mail-pl1-x644.google.com [IPv6:2607:f8b0:4864:20::644])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EE9CEC03E969
        for <linux-kernel@vger.kernel.org>; Mon,  8 Jun 2020 23:01:45 -0700 (PDT)
Received: by mail-pl1-x644.google.com with SMTP id t16so7603432plo.7
        for <linux-kernel@vger.kernel.org>; Mon, 08 Jun 2020 23:01:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=w3OWjopJiJ8RsgPU4aTIHZRKWMBVX2D/YDzUOaSnLoQ=;
        b=UyT/VVi1snnSqFHNUyttnXaR9uah6ahY070/Xb5R9zRJ3xhO0zVVme2UuiB5NeXaqn
         mhbyu4oa1JQ8Kc+LUeJgptjBsxdwGF1rVL7l64Wq3LjS6i+E3SWWWx2H8zoWMnmOyvXA
         ieTE7gJyCLJhl8BYqlUnFZWFdYvbSCNC3dYeRnGZmbLxuYfT7xC9XFtEgKwRuFcfRrwq
         95A28EvW0iZVs546Mu38rd1G0TC5t1F0+ZcabhSEkUj45++vT09KUrx0h7g8r2lQASWs
         FxuxUPzVkM9Az+d7h1vdDDR7w6Go04q9hgMaYjiF1zQ+53ny2bG8Yf3bKsXhsQnyd6Jg
         B8Tg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=w3OWjopJiJ8RsgPU4aTIHZRKWMBVX2D/YDzUOaSnLoQ=;
        b=N+vdabw9xDHVxt8xZV6UNz64RrJFgvI6sApmF7JzhNp3oXzPqaWK+LSi73fX8FKQX+
         4WLp+azcTB1KboMONT06Qjl+Gs1ouu+RrifSqc9Gf3zKcUTriOL58jYKRWll11YDZbFs
         yTFmdyWAHWNHGj7BrnG1J/NcXjH9tXV4iXa9md9B6WMj8B8Q12iaRX1BC9oBChG5FjVj
         vqDA4FyTFpnl3/Y4IggvqWxcC83cKrjCN0FOawMtBitFZbegRBJxnjqEpnLv/9YYi+1S
         wAFjn4vP6JQkwaxOf+BFElfHSet4CoDZpNwjfYaj1wVFCXvVatSXvRgyEnRW4YJKTzVK
         2Nnw==
X-Gm-Message-State: AOAM530A4zKmww5hq5zcZMGOhQFr0xULkQIFsKYtllEtwU1ka5Sc1r18
        O2mCFf4x46Csw5L9ZB1tMqjSDHg23qU=
X-Google-Smtp-Source: ABdhPJz3HuVYZAgcD8FQONTJpDKkWt6Ww80j38zfYBQl1EAqdrF5Dwf+v/7voEdjJ7hGVKzGtJTf9w==
X-Received: by 2002:a17:902:599a:: with SMTP id p26mr1990863pli.322.1591682504716;
        Mon, 08 Jun 2020 23:01:44 -0700 (PDT)
Received: from daehojeong1.seo.corp.google.com ([2401:fa00:d:1:b8f4:bbde:37ba:20bd])
        by smtp.gmail.com with ESMTPSA id k7sm6462153pfp.84.2020.06.08.23.01.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 08 Jun 2020 23:01:43 -0700 (PDT)
From:   Daeho Jeong <daeho43@gmail.com>
To:     linux-kernel@vger.kernel.org,
        linux-f2fs-devel@lists.sourceforge.net, kernel-team@android.com
Cc:     Daeho Jeong <daehojeong@google.com>
Subject: [PATCH] f2fs: add F2FS_IOC_SEC_TRIM_FILE ioctl
Date:   Tue,  9 Jun 2020 15:01:37 +0900
Message-Id: <20200609060137.143501-1-daeho43@gmail.com>
X-Mailer: git-send-email 2.27.0.278.ge193c7cf3a9-goog
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Daeho Jeong <daehojeong@google.com>

Added a new ioctl to send discard commands or/and zero out
to whole data area of a regular file for security reason.

Signed-off-by: Daeho Jeong <daehojeong@google.com>
---
 fs/f2fs/f2fs.h |   8 +++
 fs/f2fs/file.c | 149 +++++++++++++++++++++++++++++++++++++++++++++++++
 2 files changed, 157 insertions(+)

diff --git a/fs/f2fs/f2fs.h b/fs/f2fs/f2fs.h
index c812fb8e2d9c..ca139fac5a73 100644
--- a/fs/f2fs/f2fs.h
+++ b/fs/f2fs/f2fs.h
@@ -434,6 +434,7 @@ static inline bool __has_cursum_space(struct f2fs_journal *journal,
 					_IOR(F2FS_IOCTL_MAGIC, 18, __u64)
 #define F2FS_IOC_RESERVE_COMPRESS_BLOCKS				\
 					_IOR(F2FS_IOCTL_MAGIC, 19, __u64)
+#define F2FS_IOC_SEC_TRIM_FILE		_IOW(F2FS_IOCTL_MAGIC, 20, __u32)
 
 #define F2FS_IOC_GET_VOLUME_NAME	FS_IOC_GETFSLABEL
 #define F2FS_IOC_SET_VOLUME_NAME	FS_IOC_SETFSLABEL
@@ -453,6 +454,13 @@ static inline bool __has_cursum_space(struct f2fs_journal *journal,
 #define F2FS_GOING_DOWN_METAFLUSH	0x3	/* going down with meta flush */
 #define F2FS_GOING_DOWN_NEED_FSCK	0x4	/* going down to trigger fsck */
 
+/*
+ * Flags used by F2FS_IOC_SEC_TRIM_FILE
+ */
+#define F2FS_TRIM_FILE_DISCARD		0x1	/* send discard command */
+#define F2FS_TRIM_FILE_ZEROOUT		0x2	/* zero out */
+#define F2FS_TRIM_FILE_MASK		0x3
+
 #if defined(__KERNEL__) && defined(CONFIG_COMPAT)
 /*
  * ioctl commands in 32 bit emulation
diff --git a/fs/f2fs/file.c b/fs/f2fs/file.c
index dfa1ac2d751a..df5149a4a627 100644
--- a/fs/f2fs/file.c
+++ b/fs/f2fs/file.c
@@ -3749,6 +3749,152 @@ static int f2fs_reserve_compress_blocks(struct file *filp, unsigned long arg)
 	return ret;
 }
 
+static int f2fs_secure_erase(struct block_device *bdev, block_t block,
+					block_t len, u32 flags)
+{
+	struct request_queue *q = bdev_get_queue(bdev);
+	sector_t sector = SECTOR_FROM_BLOCK(block);
+	sector_t nr_sects = SECTOR_FROM_BLOCK(len);
+	int ret = 0;
+
+	if (!q)
+		return -ENXIO;
+
+	if (flags & F2FS_TRIM_FILE_DISCARD)
+		ret = blkdev_issue_discard(bdev, sector, nr_sects, GFP_NOFS,
+						blk_queue_secure_erase(q) ?
+						BLKDEV_DISCARD_SECURE : 0);
+
+	if (!ret && flags & F2FS_TRIM_FILE_ZEROOUT)
+		ret = blkdev_issue_zeroout(bdev, sector, nr_sects, GFP_NOFS, 0);
+
+	return ret;
+}
+
+static int f2fs_sec_trim_file(struct file *filp, unsigned long arg)
+{
+	struct inode *inode = file_inode(filp);
+	struct f2fs_sb_info *sbi = F2FS_I_SB(inode);
+	struct address_space *mapping = inode->i_mapping;
+	struct block_device *prev_bdev = NULL;
+	loff_t file_size;
+	pgoff_t index, pg_start = 0, pg_end;
+	block_t prev_block = 0, len = 0;
+	u32 flags;
+	int ret = 0;
+
+	if (!S_ISREG(inode->i_mode) || f2fs_is_atomic_file(inode) ||
+			f2fs_compressed_file(inode))
+		return -EINVAL;
+
+	if (f2fs_readonly(sbi->sb))
+		return -EROFS;
+
+	if (f2fs_lfs_mode(sbi))
+		return -EOPNOTSUPP;
+
+	if (get_user(flags, (u32 __user *)arg))
+		return -EFAULT;
+	if (!(flags & F2FS_TRIM_FILE_MASK))
+		return -EINVAL;
+
+	if (flags & F2FS_TRIM_FILE_DISCARD && !f2fs_hw_support_discard(sbi))
+		return -EOPNOTSUPP;
+
+	ret = mnt_want_write_file(filp);
+	if (ret)
+		return ret;
+
+	inode_lock(inode);
+
+	file_size = i_size_read(inode);
+	if (!file_size)
+		goto err;
+	pg_end = (pgoff_t)round_up(file_size, PAGE_SIZE) >> PAGE_SHIFT;
+
+	ret = f2fs_convert_inline_inode(inode);
+	if (ret)
+		goto err;
+
+	down_write(&F2FS_I(inode)->i_gc_rwsem[WRITE]);
+	down_write(&F2FS_I(inode)->i_mmap_sem);
+
+	ret = filemap_write_and_wait(mapping);
+	if (ret)
+		goto out;
+
+	truncate_inode_pages(mapping, 0);
+
+	for (index = pg_start; index < pg_end;) {
+		struct dnode_of_data dn;
+		unsigned int end_offset;
+
+		set_new_dnode(&dn, inode, NULL, NULL, 0);
+		ret = f2fs_get_dnode_of_data(&dn, index, LOOKUP_NODE);
+		if (ret)
+			goto out;
+
+		end_offset = ADDRS_PER_PAGE(dn.node_page, inode);
+		if (pg_end < end_offset + index)
+			end_offset = pg_end - index;
+
+		for (; dn.ofs_in_node < end_offset;
+				dn.ofs_in_node++, index++) {
+			struct block_device *cur_bdev;
+			block_t blkaddr = f2fs_data_blkaddr(&dn);
+
+			if (__is_valid_data_blkaddr(blkaddr)) {
+				if (!f2fs_is_valid_blkaddr(F2FS_I_SB(inode),
+					blkaddr, DATA_GENERIC_ENHANCE)) {
+					ret = -EFSCORRUPTED;
+					goto out;
+				}
+			} else
+				continue;
+
+			cur_bdev = f2fs_target_device(sbi, blkaddr, NULL);
+			if (f2fs_is_multi_device(sbi)) {
+				int i = f2fs_target_device_index(sbi, blkaddr);
+
+				blkaddr -= FDEV(i).start_blk;
+			}
+
+			if (len) {
+				if (prev_bdev == cur_bdev &&
+					blkaddr == prev_block + len) {
+					len++;
+				} else {
+					ret = f2fs_secure_erase(prev_bdev,
+							prev_block, len, flags);
+					if (ret)
+						goto out;
+
+					len = 0;
+				}
+			}
+
+			if (!len) {
+				prev_bdev = cur_bdev;
+				prev_block = blkaddr;
+				len = 1;
+			}
+		}
+
+		f2fs_put_dnode(&dn);
+	}
+
+	if (len)
+		ret = f2fs_secure_erase(prev_bdev, prev_block, len, flags);
+out:
+	up_write(&F2FS_I(inode)->i_mmap_sem);
+	up_write(&F2FS_I(inode)->i_gc_rwsem[WRITE]);
+err:
+	inode_unlock(inode);
+	mnt_drop_write_file(filp);
+
+	return ret;
+}
+
 long f2fs_ioctl(struct file *filp, unsigned int cmd, unsigned long arg)
 {
 	if (unlikely(f2fs_cp_error(F2FS_I_SB(file_inode(filp)))))
@@ -3835,6 +3981,8 @@ long f2fs_ioctl(struct file *filp, unsigned int cmd, unsigned long arg)
 		return f2fs_release_compress_blocks(filp, arg);
 	case F2FS_IOC_RESERVE_COMPRESS_BLOCKS:
 		return f2fs_reserve_compress_blocks(filp, arg);
+	case F2FS_IOC_SEC_TRIM_FILE:
+		return f2fs_sec_trim_file(filp, arg);
 	default:
 		return -ENOTTY;
 	}
@@ -4004,6 +4152,7 @@ long f2fs_compat_ioctl(struct file *file, unsigned int cmd, unsigned long arg)
 	case F2FS_IOC_GET_COMPRESS_BLOCKS:
 	case F2FS_IOC_RELEASE_COMPRESS_BLOCKS:
 	case F2FS_IOC_RESERVE_COMPRESS_BLOCKS:
+	case F2FS_IOC_SEC_TRIM_FILE:
 		break;
 	default:
 		return -ENOIOCTLCMD;
-- 
2.27.0.278.ge193c7cf3a9-goog

