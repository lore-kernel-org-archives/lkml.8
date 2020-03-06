Return-Path: <SRS0=glOU=4X=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5D991C3F2D6
	for <linux-kernel@archiver.kernel.org>; Fri,  6 Mar 2020 06:36:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 346062073D
	for <linux-kernel@archiver.kernel.org>; Fri,  6 Mar 2020 06:36:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726083AbgCFGf7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 6 Mar 2020 01:35:59 -0500
Received: from szxga04-in.huawei.com ([45.249.212.190]:11161 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725853AbgCFGf6 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 6 Mar 2020 01:35:58 -0500
Received: from DGGEMS404-HUB.china.huawei.com (unknown [172.30.72.59])
        by Forcepoint Email with ESMTP id F195D3212EC2AA14781D;
        Fri,  6 Mar 2020 14:35:45 +0800 (CST)
Received: from szvp000203569.huawei.com (10.120.216.130) by
 DGGEMS404-HUB.china.huawei.com (10.3.19.204) with Microsoft SMTP Server id
 14.3.439.0; Fri, 6 Mar 2020 14:35:38 +0800
From:   Chao Yu <yuchao0@huawei.com>
To:     <jaegeuk@kernel.org>
CC:     <linux-f2fs-devel@lists.sourceforge.net>,
        <linux-kernel@vger.kernel.org>, <chao@kernel.org>,
        Chao Yu <yuchao0@huawei.com>
Subject: [PATCH v2] f2fs: introduce F2FS_IOC_RESERVE_COMPRESS_BLOCKS
Date:   Fri, 6 Mar 2020 14:35:33 +0800
Message-ID: <20200306063533.22277-1-yuchao0@huawei.com>
X-Mailer: git-send-email 2.18.0.rc1
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.120.216.130]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch introduces a new ioctl to rollback all compress inode
status:
- add reserved blocks in dnode blocks
- increase i_compr_blocks, i_blocks, total_valid_block_count
- remove immutable flag

Then compress inode can be restored to support overwrite
functionality again.

Signee-off-by: Chao Yu <yuchao0@huawei.com>
---
v2:
fix to align parameter @count to cluster size.
 fs/f2fs/f2fs.h |   2 +
 fs/f2fs/file.c | 162 +++++++++++++++++++++++++++++++++++++++++++++++++
 2 files changed, 164 insertions(+)

diff --git a/fs/f2fs/f2fs.h b/fs/f2fs/f2fs.h
index 09270854cce8..bc45f738e3e0 100644
--- a/fs/f2fs/f2fs.h
+++ b/fs/f2fs/f2fs.h
@@ -429,6 +429,8 @@ static inline bool __has_cursum_space(struct f2fs_journal *journal,
 #define F2FS_IOC_GET_COMPRESS_BLOCKS	_IOR(F2FS_IOCTL_MAGIC, 17, __u64)
 #define F2FS_IOC_RELEASE_COMPRESS_BLOCKS				\
 					_IOR(F2FS_IOCTL_MAGIC, 18, __u64)
+#define F2FS_IOC_RESERVE_COMPRESS_BLOCKS				\
+					_IOR(F2FS_IOCTL_MAGIC, 19, __u64)
 
 #define F2FS_IOC_GET_VOLUME_NAME	FS_IOC_GETFSLABEL
 #define F2FS_IOC_SET_VOLUME_NAME	FS_IOC_SETFSLABEL
diff --git a/fs/f2fs/file.c b/fs/f2fs/file.c
index 12cd9a25bf38..fe4adb6aae97 100644
--- a/fs/f2fs/file.c
+++ b/fs/f2fs/file.c
@@ -3560,6 +3560,165 @@ static int f2fs_release_compress_blocks(struct file *filp, unsigned long arg)
 	return ret;
 }
 
+static int reserve_compress_blocks(struct dnode_of_data *dn, pgoff_t count)
+{
+	struct f2fs_sb_info *sbi = F2FS_I_SB(dn->inode);
+	unsigned int reserved_blocks = 0;
+	int cluster_size = F2FS_I(dn->inode)->i_cluster_size;
+	block_t blkaddr;
+	int i;
+
+	for (i = 0; i < count; i++) {
+		blkaddr = data_blkaddr(dn->inode, dn->node_page,
+						dn->ofs_in_node + i);
+
+		if (!__is_valid_data_blkaddr(blkaddr))
+			continue;
+		if (unlikely(!f2fs_is_valid_blkaddr(sbi, blkaddr,
+					DATA_GENERIC_ENHANCE)))
+			return -EFSCORRUPTED;
+	}
+
+	while (count) {
+		int compr_blocks = 0;
+		blkcnt_t reserved;
+		int ret;
+
+		for (i = 0; i < cluster_size; i++, dn->ofs_in_node++) {
+			blkaddr = f2fs_data_blkaddr(dn);
+
+			if (i == 0) {
+				if (blkaddr == COMPRESS_ADDR)
+					continue;
+				dn->ofs_in_node += cluster_size;
+				goto next;
+			}
+
+			if (__is_valid_data_blkaddr(blkaddr)) {
+				compr_blocks++;
+				continue;
+			}
+
+			dn->data_blkaddr = NEW_ADDR;
+			f2fs_set_data_blkaddr(dn);
+		}
+
+		reserved = cluster_size - compr_blocks;
+		ret = inc_valid_block_count(sbi, dn->inode, &reserved);
+		if (ret)
+			return ret;
+
+		if (reserved != cluster_size - compr_blocks)
+			return -ENOSPC;
+
+		f2fs_i_compr_blocks_update(dn->inode, compr_blocks, true);
+
+		reserved_blocks += reserved;
+next:
+		count -= cluster_size;
+	}
+
+	return reserved_blocks;
+}
+
+static int f2fs_reserve_compress_blocks(struct file *filp, unsigned long arg)
+{
+	struct inode *inode = file_inode(filp);
+	struct f2fs_sb_info *sbi = F2FS_I_SB(inode);
+	pgoff_t page_idx = 0, last_idx;
+	unsigned int reserved_blocks = 0;
+	int ret;
+
+	if (!f2fs_sb_has_compression(F2FS_I_SB(inode)))
+		return -EOPNOTSUPP;
+
+	if (!f2fs_compressed_file(inode))
+		return -EINVAL;
+
+	if (f2fs_readonly(sbi->sb))
+		return -EROFS;
+
+	ret = mnt_want_write_file(filp);
+	if (ret)
+		return ret;
+
+	if (F2FS_I(inode)->i_compr_blocks)
+		goto out;
+
+	f2fs_balance_fs(F2FS_I_SB(inode), true);
+
+	inode_lock(inode);
+
+	if (!IS_IMMUTABLE(inode)) {
+		ret = -EINVAL;
+		goto unlock_inode;
+	}
+
+	down_write(&F2FS_I(inode)->i_gc_rwsem[WRITE]);
+	down_write(&F2FS_I(inode)->i_mmap_sem);
+
+	last_idx = DIV_ROUND_UP(i_size_read(inode), PAGE_SIZE);
+
+	while (page_idx < last_idx) {
+		struct dnode_of_data dn;
+		pgoff_t end_offset, count;
+
+		set_new_dnode(&dn, inode, NULL, NULL, 0);
+		ret = f2fs_get_dnode_of_data(&dn, page_idx, LOOKUP_NODE);
+		if (ret) {
+			if (ret == -ENOENT) {
+				page_idx = f2fs_get_next_page_offset(&dn,
+								page_idx);
+				ret = 0;
+				continue;
+			}
+			break;
+		}
+
+		end_offset = ADDRS_PER_PAGE(dn.node_page, inode);
+		count = min(end_offset - dn.ofs_in_node, last_idx - page_idx);
+		count = roundup(count, F2FS_I(inode)->i_cluster_size);
+
+		ret = reserve_compress_blocks(&dn, count);
+
+		f2fs_put_dnode(&dn);
+
+		if (ret < 0)
+			break;
+
+		page_idx += count;
+		reserved_blocks += ret;
+	}
+
+	up_write(&F2FS_I(inode)->i_gc_rwsem[WRITE]);
+	up_write(&F2FS_I(inode)->i_mmap_sem);
+
+	if (ret >= 0) {
+		F2FS_I(inode)->i_flags &= ~F2FS_IMMUTABLE_FL;
+		f2fs_set_inode_flags(inode);
+		inode->i_ctime = current_time(inode);
+		f2fs_mark_inode_dirty_sync(inode, true);
+	}
+unlock_inode:
+	inode_unlock(inode);
+out:
+	mnt_drop_write_file(filp);
+
+	if (ret >= 0) {
+		ret = put_user(reserved_blocks, (u64 __user *)arg);
+	} else if (reserved_blocks && F2FS_I(inode)->i_compr_blocks) {
+		set_sbi_flag(sbi, SBI_NEED_FSCK);
+		f2fs_warn(sbi, "%s: partial blocks were released i_ino=%lx "
+			"iblocks=%llu, reserved=%u, compr_blocks=%llu, "
+			"run fsck to fix.",
+			__func__, inode->i_ino, inode->i_blocks,
+			reserved_blocks,
+			F2FS_I(inode)->i_compr_blocks);
+	}
+
+	return ret;
+}
+
 long f2fs_ioctl(struct file *filp, unsigned int cmd, unsigned long arg)
 {
 	if (unlikely(f2fs_cp_error(F2FS_I_SB(file_inode(filp)))))
@@ -3642,6 +3801,8 @@ long f2fs_ioctl(struct file *filp, unsigned int cmd, unsigned long arg)
 		return f2fs_get_compress_blocks(filp, arg);
 	case F2FS_IOC_RELEASE_COMPRESS_BLOCKS:
 		return f2fs_release_compress_blocks(filp, arg);
+	case F2FS_IOC_RESERVE_COMPRESS_BLOCKS:
+		return f2fs_reserve_compress_blocks(filp, arg);
 	default:
 		return -ENOTTY;
 	}
@@ -3803,6 +3964,7 @@ long f2fs_compat_ioctl(struct file *file, unsigned int cmd, unsigned long arg)
 	case F2FS_IOC_SET_VOLUME_NAME:
 	case F2FS_IOC_GET_COMPRESS_BLOCKS:
 	case F2FS_IOC_RELEASE_COMPRESS_BLOCKS:
+	case F2FS_IOC_RESERVE_COMPRESS_BLOCKS:
 		break;
 	default:
 		return -ENOIOCTLCMD;
-- 
2.18.0.rc1

