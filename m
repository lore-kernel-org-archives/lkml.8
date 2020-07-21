Return-Path: <SRS0=jpuI=BA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6350CC433DF
	for <linux-kernel@archiver.kernel.org>; Tue, 21 Jul 2020 03:21:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2E80320729
	for <linux-kernel@archiver.kernel.org>; Tue, 21 Jul 2020 03:21:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="shNVykVm"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728581AbgGUDVV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 20 Jul 2020 23:21:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34010 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726068AbgGUDVU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Jul 2020 23:21:20 -0400
Received: from mail-pf1-x444.google.com (mail-pf1-x444.google.com [IPv6:2607:f8b0:4864:20::444])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 51FD8C061794
        for <linux-kernel@vger.kernel.org>; Mon, 20 Jul 2020 20:21:20 -0700 (PDT)
Received: by mail-pf1-x444.google.com with SMTP id 1so10066507pfn.9
        for <linux-kernel@vger.kernel.org>; Mon, 20 Jul 2020 20:21:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=b4jBTQ9w3hKKL5eQIBF+wgVny7k4e4tDr60/TnpUEIQ=;
        b=shNVykVmK9YTKRI9LqxFWCbEUPkuboyTDs8cg0kdtN67sakrmpt2MHw9uJjbBbrZa/
         KoRGHlOKQYyiAa/B0g1WWWPCgZue3oMr0/1UpBFRxDuBChD63EnWXtzfVT/5XOGoz4KW
         7l/nnKPtQvh2oGlibThrck1tVvwEGW2Rlw8A/I/IDhS55zGr/8+0E91jpM3xB17u63p0
         9oPLPYUzEKUN0n8QD+aCguE3hgdcW0VLFommW/eh05jRAbIcG8UcZB10esG7Jkh8q8VP
         HnXB1sSMgKLn3FTXMCnmqnf8pDxXeFw61yPQfb9KK4cq98ES/L90d9Ov+zJ9vt8SEQmI
         FAbw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=b4jBTQ9w3hKKL5eQIBF+wgVny7k4e4tDr60/TnpUEIQ=;
        b=knuitzkeYn4/uI/dVe3t3NMRNyVhOk50XmXTzQ6vNyluZLuVlCqGtjdUslr6Ut4HKl
         oGyQ48N1mNvPT3MMmEjygu3DkHOw+vAVUM2sH9Gfq3lqZmnX6kNHT6GwdGJdyLjItTyK
         +K71bkTyvNBCLqrziDRxo5LxQkk9B1IdxGYiKdNP2DS/vDqYRprx3spkr1c/tELhFsyY
         PK+ilbHtEmncBA+4lXDLrr1t/KGdlKMXL7Ns9EMrgxJA9E6joUDPk/nsXN00OdspDjZp
         +Zp1gjjGqqAU2oXZMzR6OHYl6fhE2QvnKbn3Ziv5SN+0IW453oWdGFjLU703VQ2ezOK0
         RKSQ==
X-Gm-Message-State: AOAM530DWR+j4bztZg5bjSRhNz4mDzzhgcmUoXz6SgBWX4SpyWEvN0AU
        ii7p93bYRITfPdjG5y8QJjBzWSO1JY+Xfg==
X-Google-Smtp-Source: ABdhPJyWWGOJEIWtzlCIe1DtnoJNZj19w2RJwn5jx7Y+viyb4ALvwVOaFmu4QPtnjVy7AWIOVguq4A==
X-Received: by 2002:a63:df54:: with SMTP id h20mr20454028pgj.319.1595301679092;
        Mon, 20 Jul 2020 20:21:19 -0700 (PDT)
Received: from daehojeong1.seo.corp.google.com ([2401:fa00:d:1:a6ae:11ff:fe18:6ce2])
        by smtp.gmail.com with ESMTPSA id mg17sm1035016pjb.55.2020.07.20.20.21.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 20 Jul 2020 20:21:18 -0700 (PDT)
From:   Daeho Jeong <daeho43@gmail.com>
To:     linux-kernel@vger.kernel.org,
        linux-f2fs-devel@lists.sourceforge.net, kernel-team@android.com
Cc:     Daeho Jeong <daehojeong@google.com>, Chao Yu <yuchao0@huawei.com>,
        Jaegeuk Kim <jaegeuk@kernel.org>
Subject: [PATCH v7] f2fs: add F2FS_IOC_SEC_TRIM_FILE ioctl
Date:   Tue, 21 Jul 2020 12:21:11 +0900
Message-Id: <20200721032111.3709411-1-daeho43@gmail.com>
X-Mailer: git-send-email 2.28.0.rc0.105.gf9edc3c819-goog
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Daeho Jeong <daehojeong@google.com>

Added a new ioctl to send discard commands or/and zero out
to selected data area of a regular file for security reason.

The way of handling range.len of F2FS_IOC_SEC_TRIM_FILE:
1. Added -1 value support for range.len to secure trim the whole blocks
   starting from range.start regardless of i_size.
2. If the end of the range passes over the end of file, it means until
   the end of file (i_size).
3. ignored the case of that range.len is zero to prevent the function
   from making end_addr zero and triggering different behaviour of
   the function.

Signed-off-by: Daeho Jeong <daehojeong@google.com>
Reviewed-by: Chao Yu <yuchao0@huawei.com>
Signed-off-by: Jaegeuk Kim <jaegeuk@kernel.org>
---
Changes in v7:
 - Polish coding style
---
Changes in v6:
 - Support zeroout for encrypted files
---
 fs/f2fs/f2fs.h |  15 ++++
 fs/f2fs/file.c | 191 +++++++++++++++++++++++++++++++++++++++++++++++++
 2 files changed, 206 insertions(+)

diff --git a/fs/f2fs/f2fs.h b/fs/f2fs/f2fs.h
index a555377cf51f..6d0ce33ed65e 100644
--- a/fs/f2fs/f2fs.h
+++ b/fs/f2fs/f2fs.h
@@ -430,6 +430,8 @@ static inline bool __has_cursum_space(struct f2fs_journal *journal,
 					_IOR(F2FS_IOCTL_MAGIC, 18, __u64)
 #define F2FS_IOC_RESERVE_COMPRESS_BLOCKS				\
 					_IOR(F2FS_IOCTL_MAGIC, 19, __u64)
+#define F2FS_IOC_SEC_TRIM_FILE		_IOW(F2FS_IOCTL_MAGIC, 20,	\
+						struct f2fs_sectrim_range)
 
 /*
  * should be same as XFS_IOC_GOINGDOWN.
@@ -442,6 +444,13 @@ static inline bool __has_cursum_space(struct f2fs_journal *journal,
 #define F2FS_GOING_DOWN_METAFLUSH	0x3	/* going down with meta flush */
 #define F2FS_GOING_DOWN_NEED_FSCK	0x4	/* going down to trigger fsck */
 
+/*
+ * Flags used by F2FS_IOC_SEC_TRIM_FILE
+ */
+#define F2FS_TRIM_FILE_DISCARD		0x1	/* send discard command */
+#define F2FS_TRIM_FILE_ZEROOUT		0x2	/* zero out */
+#define F2FS_TRIM_FILE_MASK		0x3
+
 struct f2fs_gc_range {
 	u32 sync;
 	u64 start;
@@ -465,6 +474,12 @@ struct f2fs_flush_device {
 	u32 segments;		/* # of segments to flush */
 };
 
+struct f2fs_sectrim_range {
+	u64 start;
+	u64 len;
+	u64 flags;
+};
+
 /* for inline stuff */
 #define DEF_INLINE_RESERVED_SIZE	1
 static inline int get_extra_isize(struct inode *inode);
diff --git a/fs/f2fs/file.c b/fs/f2fs/file.c
index 521987cd8772..cc7f5670390f 100644
--- a/fs/f2fs/file.c
+++ b/fs/f2fs/file.c
@@ -21,6 +21,7 @@
 #include <linux/uuid.h>
 #include <linux/file.h>
 #include <linux/nls.h>
+#include <linux/sched/signal.h>
 
 #include "f2fs.h"
 #include "node.h"
@@ -3759,6 +3760,193 @@ static int f2fs_reserve_compress_blocks(struct file *filp, unsigned long arg)
 	return ret;
 }
 
+static int f2fs_secure_erase(struct block_device *bdev, struct inode *inode,
+		pgoff_t off, block_t block, block_t len, u32 flags)
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
+	if (!ret && (flags & F2FS_TRIM_FILE_ZEROOUT)) {
+		if (IS_ENCRYPTED(inode))
+			ret = fscrypt_zeroout_range(inode, off, block, len);
+		else
+			ret = blkdev_issue_zeroout(bdev, sector, nr_sects,
+					GFP_NOFS, 0);
+	}
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
+	struct f2fs_sectrim_range range;
+	pgoff_t index, pg_end, prev_index = 0;
+	block_t prev_block = 0, len = 0;
+	loff_t end_addr;
+	bool to_end = false;
+	int ret = 0;
+
+	if (!(filp->f_mode & FMODE_WRITE))
+		return -EBADF;
+
+	if (copy_from_user(&range, (struct f2fs_sectrim_range __user *)arg,
+				sizeof(range)))
+		return -EFAULT;
+
+	if (range.flags == 0 || (range.flags & ~F2FS_TRIM_FILE_MASK) ||
+			!S_ISREG(inode->i_mode))
+		return -EINVAL;
+
+	if (((range.flags & F2FS_TRIM_FILE_DISCARD) &&
+			!f2fs_hw_support_discard(sbi)) ||
+			((range.flags & F2FS_TRIM_FILE_ZEROOUT) &&
+			 IS_ENCRYPTED(inode) && f2fs_is_multi_device(sbi)))
+		return -EOPNOTSUPP;
+
+	file_start_write(filp);
+	inode_lock(inode);
+
+	if (f2fs_is_atomic_file(inode) || f2fs_compressed_file(inode) ||
+			range.start >= inode->i_size) {
+		ret = -EINVAL;
+		goto err;
+	}
+
+	if (range.len == 0)
+		goto err;
+
+	if (inode->i_size - range.start > range.len) {
+		end_addr = range.start + range.len;
+	} else {
+		end_addr = range.len == (u64)-1 ?
+			sbi->sb->s_maxbytes : inode->i_size;
+		to_end = true;
+	}
+
+	if (!IS_ALIGNED(range.start, F2FS_BLKSIZE) ||
+			(!to_end && !IS_ALIGNED(end_addr, F2FS_BLKSIZE))) {
+		ret = -EINVAL;
+		goto err;
+	}
+
+	index = F2FS_BYTES_TO_BLK(range.start);
+	pg_end = DIV_ROUND_UP(end_addr, F2FS_BLKSIZE);
+
+	ret = f2fs_convert_inline_inode(inode);
+	if (ret)
+		goto err;
+
+	down_write(&F2FS_I(inode)->i_gc_rwsem[WRITE]);
+	down_write(&F2FS_I(inode)->i_mmap_sem);
+
+	ret = filemap_write_and_wait_range(mapping, range.start,
+			to_end ? LLONG_MAX : end_addr - 1);
+	if (ret)
+		goto out;
+
+	truncate_inode_pages_range(mapping, range.start,
+			to_end ? -1 : end_addr - 1);
+
+	while (index < pg_end) {
+		struct dnode_of_data dn;
+		pgoff_t end_offset, count;
+		int i;
+
+		set_new_dnode(&dn, inode, NULL, NULL, 0);
+		ret = f2fs_get_dnode_of_data(&dn, index, LOOKUP_NODE);
+		if (ret) {
+			if (ret == -ENOENT) {
+				index = f2fs_get_next_page_offset(&dn, index);
+				continue;
+			}
+			goto out;
+		}
+
+		end_offset = ADDRS_PER_PAGE(dn.node_page, inode);
+		count = min(end_offset - dn.ofs_in_node, pg_end - index);
+		for (i = 0; i < count; i++, index++, dn.ofs_in_node++) {
+			struct block_device *cur_bdev;
+			block_t blkaddr = f2fs_data_blkaddr(&dn);
+
+			if (!__is_valid_data_blkaddr(blkaddr))
+				continue;
+
+			if (!f2fs_is_valid_blkaddr(sbi, blkaddr,
+						DATA_GENERIC_ENHANCE)) {
+				ret = -EFSCORRUPTED;
+				f2fs_put_dnode(&dn);
+				goto out;
+			}
+
+			cur_bdev = f2fs_target_device(sbi, blkaddr, NULL);
+			if (f2fs_is_multi_device(sbi)) {
+				int di = f2fs_target_device_index(sbi, blkaddr);
+
+				blkaddr -= FDEV(di).start_blk;
+			}
+
+			if (len) {
+				if (prev_bdev == cur_bdev &&
+						index == prev_index + len &&
+						blkaddr == prev_block + len) {
+					len++;
+				} else {
+					ret = f2fs_secure_erase(prev_bdev,
+						inode, prev_index, prev_block,
+						len, range.flags);
+					if (ret) {
+						f2fs_put_dnode(&dn);
+						goto out;
+					}
+
+					len = 0;
+				}
+			}
+
+			if (!len) {
+				prev_bdev = cur_bdev;
+				prev_index = index;
+				prev_block = blkaddr;
+				len = 1;
+			}
+		}
+
+		f2fs_put_dnode(&dn);
+
+		if (fatal_signal_pending(current)) {
+			ret = -EINTR;
+			goto out;
+		}
+		cond_resched();
+	}
+
+	if (len)
+		ret = f2fs_secure_erase(prev_bdev, inode, prev_index,
+				prev_block, len, range.flags);
+out:
+	up_write(&F2FS_I(inode)->i_mmap_sem);
+	up_write(&F2FS_I(inode)->i_gc_rwsem[WRITE]);
+err:
+	inode_unlock(inode);
+	file_end_write(filp);
+
+	return ret;
+}
+
 long f2fs_ioctl(struct file *filp, unsigned int cmd, unsigned long arg)
 {
 	if (unlikely(f2fs_cp_error(F2FS_I_SB(file_inode(filp)))))
@@ -3845,6 +4033,8 @@ long f2fs_ioctl(struct file *filp, unsigned int cmd, unsigned long arg)
 		return f2fs_release_compress_blocks(filp, arg);
 	case F2FS_IOC_RESERVE_COMPRESS_BLOCKS:
 		return f2fs_reserve_compress_blocks(filp, arg);
+	case F2FS_IOC_SEC_TRIM_FILE:
+		return f2fs_sec_trim_file(filp, arg);
 	default:
 		return -ENOTTY;
 	}
@@ -4014,6 +4204,7 @@ long f2fs_compat_ioctl(struct file *file, unsigned int cmd, unsigned long arg)
 	case F2FS_IOC_GET_COMPRESS_BLOCKS:
 	case F2FS_IOC_RELEASE_COMPRESS_BLOCKS:
 	case F2FS_IOC_RESERVE_COMPRESS_BLOCKS:
+	case F2FS_IOC_SEC_TRIM_FILE:
 		break;
 	default:
 		return -ENOIOCTLCMD;
-- 
2.28.0.rc0.105.gf9edc3c819-goog

