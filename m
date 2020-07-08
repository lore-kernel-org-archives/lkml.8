Return-Path: <SRS0=/IhT=AT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DF9F8C433E0
	for <linux-kernel@archiver.kernel.org>; Wed,  8 Jul 2020 03:57:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B3AAC20720
	for <linux-kernel@archiver.kernel.org>; Wed,  8 Jul 2020 03:57:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="JGbBrRma"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729252AbgGHD5e (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 7 Jul 2020 23:57:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36470 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728001AbgGHD5e (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Jul 2020 23:57:34 -0400
Received: from mail-pg1-x543.google.com (mail-pg1-x543.google.com [IPv6:2607:f8b0:4864:20::543])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 15C01C061755
        for <linux-kernel@vger.kernel.org>; Tue,  7 Jul 2020 20:57:34 -0700 (PDT)
Received: by mail-pg1-x543.google.com with SMTP id m22so10646717pgv.9
        for <linux-kernel@vger.kernel.org>; Tue, 07 Jul 2020 20:57:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=z9xDGWiWNhqxBos92VKlsJJl8JqQTIwwlNq2XYhQwHA=;
        b=JGbBrRmabx5c6VLbbCmjZTCudG52gT6t2J+dTwym8AqH3xDVir0jEl4o06tX/Yj9R7
         WsT57Md76xWuvD88h6nJ9LhPa5m+gdWW9W8cKEyG3V8dm697RpthIOGykB2DWxKWogZi
         B2D+ihOxMW0HgmiN9RvcZFdfKSOEXbQ0b+zyUqp9UES6w4QZX77b4YJQ1YXxuzVWFe3g
         NVigfJN8q9J/iocVuu049LlmJUaQCNF+rKjNiZYkEC/orlnyC1ril4xrb/zQaijentwv
         N6aI0tULlZ8vUPkUjZ8RGH94ZaFcEcHjH5oudy9J2qxnFFrqTUQFWq5+sRxqwkRsxXMr
         g6jQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=z9xDGWiWNhqxBos92VKlsJJl8JqQTIwwlNq2XYhQwHA=;
        b=YdZGsbwafHxmdHoVMllda+REQ2UEDjunh2uOmAj0PHKiHVDgDNvvB5ksybiyIc3x3B
         /qJ4tjRLkyMckfA0KnKBRGzQUJ+W+jrWfhvTvkNUyfou+ZOMn3ei/Fz6l441mbAuZ/gn
         1VfnTceZyNulrksti8VexVMR2PMqpwr5HGWm1mm/hrVxdf2XQ6C2y+bhBkkyfKAtfQSk
         oVaFiAUzzxbeFGZdZ/jIjcgd7ID18KSBccCq+lsfi6qQd9+TdyYp3SN44RANkDGU+dyY
         qMsGUmyrVvAb8B7CD5DMhuNA9CLvHd1EEJJNrBa6J9wSH762DlWYA1+l6wzeG7rR2AWk
         PUCw==
X-Gm-Message-State: AOAM530oBnqfl2cXCsGDPyOv1rzyp158seJ12IsNuFgTyIjo8yt8ln+4
        nVHKCoKM9r7AS3R6vyq4Gk5U0OQDyw4=
X-Google-Smtp-Source: ABdhPJyA+2edR/jphXkfTYKosuC9Ld8ZjDtR9oCeBBF5l5nT6e8bv4UYZdSf3338rEeICNHxtWdzsw==
X-Received: by 2002:a63:d951:: with SMTP id e17mr46889325pgj.318.1594180653048;
        Tue, 07 Jul 2020 20:57:33 -0700 (PDT)
Received: from daehojeong1.seo.corp.google.com ([2401:fa00:d:1:a6ae:11ff:fe18:6ce2])
        by smtp.gmail.com with ESMTPSA id c188sm23603092pfc.143.2020.07.07.20.57.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 07 Jul 2020 20:57:32 -0700 (PDT)
From:   Daeho Jeong <daeho43@gmail.com>
To:     linux-kernel@vger.kernel.org,
        linux-f2fs-devel@lists.sourceforge.net, kernel-team@android.com
Cc:     Daeho Jeong <daehojeong@google.com>, Chao Yu <yuchao0@huawei.com>,
        Jaegeuk Kim <jaegeuk@kernel.org>
Subject: [PATCH v5] f2fs: add F2FS_IOC_SEC_TRIM_FILE ioctl
Date:   Wed,  8 Jul 2020 12:57:25 +0900
Message-Id: <20200708035725.1130254-1-daeho43@gmail.com>
X-Mailer: git-send-email 2.27.0.383.g050319c2ae-goog
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Daeho Jeong <daehojeong@google.com>

Added a new ioctl to send discard commands or/and zero out
to selected data area of a regular file for security reason.

Signed-off-by: Daeho Jeong <daehojeong@google.com>
Reviewed-by: Chao Yu <yuchao0@huawei.com>
Signed-off-by: Jaegeuk Kim <jaegeuk@kernel.org>
---
 fs/f2fs/f2fs.h |  15 ++++
 fs/f2fs/file.c | 181 +++++++++++++++++++++++++++++++++++++++++++++++++
 2 files changed, 196 insertions(+)

diff --git a/fs/f2fs/f2fs.h b/fs/f2fs/f2fs.h
index b35a50f4953c..917fb2f63cd7 100644
--- a/fs/f2fs/f2fs.h
+++ b/fs/f2fs/f2fs.h
@@ -434,6 +434,8 @@ static inline bool __has_cursum_space(struct f2fs_journal *journal,
 					_IOR(F2FS_IOCTL_MAGIC, 18, __u64)
 #define F2FS_IOC_RESERVE_COMPRESS_BLOCKS				\
 					_IOR(F2FS_IOCTL_MAGIC, 19, __u64)
+#define F2FS_IOC_SEC_TRIM_FILE		_IOW(F2FS_IOCTL_MAGIC, 20,	\
+						struct f2fs_sectrim_range)
 
 #define F2FS_IOC_GET_VOLUME_NAME	FS_IOC_GETFSLABEL
 #define F2FS_IOC_SET_VOLUME_NAME	FS_IOC_SETFSLABEL
@@ -453,6 +455,13 @@ static inline bool __has_cursum_space(struct f2fs_journal *journal,
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
@@ -488,6 +497,12 @@ struct f2fs_flush_device {
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
index 98721f9bef25..41d057ffa8c3 100644
--- a/fs/f2fs/file.c
+++ b/fs/f2fs/file.c
@@ -21,6 +21,7 @@
 #include <linux/uuid.h>
 #include <linux/file.h>
 #include <linux/nls.h>
+#include <linux/sched/signal.h>
 
 #include "f2fs.h"
 #include "node.h"
@@ -3754,6 +3755,183 @@ static int f2fs_reserve_compress_blocks(struct file *filp, unsigned long arg)
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
+	if (!ret && (flags & F2FS_TRIM_FILE_ZEROOUT))
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
+	struct f2fs_sectrim_range range;
+	pgoff_t index, pg_end;
+	block_t prev_block = 0, len = 0;
+	loff_t end_addr;
+	bool to_end;
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
+	if ((range.flags & F2FS_TRIM_FILE_DISCARD) &&
+			!f2fs_hw_support_discard(sbi))
+		return -EOPNOTSUPP;
+
+	file_start_write(filp);
+	inode_lock(inode);
+
+	if (f2fs_is_atomic_file(inode) || f2fs_compressed_file(inode)) {
+		ret = -EINVAL;
+		goto err;
+	}
+
+	if (range.start >= inode->i_size) {
+		ret = -EINVAL;
+		goto err;
+	}
+
+	if (inode->i_size - range.start < range.len) {
+		ret = -E2BIG;
+		goto err;
+	}
+	end_addr = range.start + range.len;
+
+	to_end = (end_addr == inode->i_size);
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
+	ret = filemap_write_and_wait_range(mapping, range.start, end_addr - 1);
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
+		for (i = 0; i < count; i++, dn.ofs_in_node++) {
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
+					blkaddr == prev_block + len) {
+					len++;
+				} else {
+					ret = f2fs_secure_erase(prev_bdev,
+						prev_block, len, range.flags);
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
+				prev_block = blkaddr;
+				len = 1;
+			}
+		}
+
+		f2fs_put_dnode(&dn);
+		index += count;
+
+		if (fatal_signal_pending(current)) {
+			ret = -EINTR;
+			goto out;
+		}
+		cond_resched();
+	}
+
+	if (len)
+		ret = f2fs_secure_erase(prev_bdev, prev_block, len,
+				range.flags);
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
@@ -3840,6 +4018,8 @@ long f2fs_ioctl(struct file *filp, unsigned int cmd, unsigned long arg)
 		return f2fs_release_compress_blocks(filp, arg);
 	case F2FS_IOC_RESERVE_COMPRESS_BLOCKS:
 		return f2fs_reserve_compress_blocks(filp, arg);
+	case F2FS_IOC_SEC_TRIM_FILE:
+		return f2fs_sec_trim_file(filp, arg);
 	default:
 		return -ENOTTY;
 	}
@@ -4009,6 +4189,7 @@ long f2fs_compat_ioctl(struct file *file, unsigned int cmd, unsigned long arg)
 	case F2FS_IOC_GET_COMPRESS_BLOCKS:
 	case F2FS_IOC_RELEASE_COMPRESS_BLOCKS:
 	case F2FS_IOC_RESERVE_COMPRESS_BLOCKS:
+	case F2FS_IOC_SEC_TRIM_FILE:
 		break;
 	default:
 		return -ENOIOCTLCMD;
-- 
2.27.0.383.g050319c2ae-goog

