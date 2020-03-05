Return-Path: <SRS0=j27y=4W=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 31CCAC3F2CD
	for <linux-kernel@archiver.kernel.org>; Thu,  5 Mar 2020 08:06:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0807A2073D
	for <linux-kernel@archiver.kernel.org>; Thu,  5 Mar 2020 08:06:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726067AbgCEIEy (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 5 Mar 2020 03:04:54 -0500
Received: from szxga04-in.huawei.com ([45.249.212.190]:11147 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725946AbgCEIEy (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Mar 2020 03:04:54 -0500
Received: from DGGEMS401-HUB.china.huawei.com (unknown [172.30.72.60])
        by Forcepoint Email with ESMTP id 01B143C07C6844C0EBC2;
        Thu,  5 Mar 2020 16:04:50 +0800 (CST)
Received: from szvp000203569.huawei.com (10.120.216.130) by
 DGGEMS401-HUB.china.huawei.com (10.3.19.201) with Microsoft SMTP Server id
 14.3.439.0; Thu, 5 Mar 2020 16:04:44 +0800
From:   Chao Yu <yuchao0@huawei.com>
To:     <jaegeuk@kernel.org>
CC:     <linux-f2fs-devel@lists.sourceforge.net>,
        <linux-kernel@vger.kernel.org>, <chao@kernel.org>,
        Chao Yu <yuchao0@huawei.com>
Subject: [PATCH v3] f2fs: introduce F2FS_IOC_RELEASE_COMPRESS_BLOCKS
Date:   Thu, 5 Mar 2020 16:04:38 +0800
Message-ID: <20200305080438.106061-1-yuchao0@huawei.com>
X-Mailer: git-send-email 2.18.0.rc1
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.120.216.130]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

There are still reserved blocks on compressed inode, this patch
introduce a new ioctl to help release reserved blocks back to
filesystem, so that userspace can reuse those freed space.

Signed-off-by: Chao Yu <yuchao0@huawei.com>
---
v3:
- do sanity check on blkaddr in prior to block release.
- fix to call put_user if @ret is not negative.
- set SBI_NEED_FSCK if we release reserved blocks partially.
 fs/f2fs/f2fs.h |   6 ++
 fs/f2fs/file.c | 154 ++++++++++++++++++++++++++++++++++++++++++++++++-
 2 files changed, 159 insertions(+), 1 deletion(-)

diff --git a/fs/f2fs/f2fs.h b/fs/f2fs/f2fs.h
index 5ea712a52d46..5ca9efaf2ddc 100644
--- a/fs/f2fs/f2fs.h
+++ b/fs/f2fs/f2fs.h
@@ -427,6 +427,8 @@ static inline bool __has_cursum_space(struct f2fs_journal *journal,
 #define F2FS_IOC_PRECACHE_EXTENTS	_IO(F2FS_IOCTL_MAGIC, 15)
 #define F2FS_IOC_RESIZE_FS		_IOW(F2FS_IOCTL_MAGIC, 16, __u64)
 #define F2FS_IOC_GET_COMPRESS_BLOCKS	_IOR(F2FS_IOCTL_MAGIC, 17, __u64)
+#define F2FS_IOC_RELEASE_COMPRESS_BLOCKS				\
+					_IOR(F2FS_IOCTL_MAGIC, 18, __u64)
 
 #define F2FS_IOC_GET_VOLUME_NAME	FS_IOC_GETFSLABEL
 #define F2FS_IOC_SET_VOLUME_NAME	FS_IOC_SETFSLABEL
@@ -3957,6 +3959,10 @@ static inline void f2fs_i_compr_blocks_update(struct inode *inode,
 {
 	int diff = F2FS_I(inode)->i_cluster_size - blocks;
 
+	/* don't update i_compr_blocks if saved blocks were released */
+	if (!add && !F2FS_I(inode)->i_compr_blocks)
+		return;
+
 	if (add) {
 		F2FS_I(inode)->i_compr_blocks += diff;
 		stat_add_compr_blocks(inode, diff);
diff --git a/fs/f2fs/file.c b/fs/f2fs/file.c
index fb070816a8a5..48ff7406598d 100644
--- a/fs/f2fs/file.c
+++ b/fs/f2fs/file.c
@@ -557,6 +557,7 @@ void f2fs_truncate_data_blocks_range(struct dnode_of_data *dn, int count)
 	bool compressed_cluster = false;
 	int cluster_index = 0, valid_blocks = 0;
 	int cluster_size = F2FS_I(dn->inode)->i_cluster_size;
+	bool released = !F2FS_I(dn->inode)->i_compr_blocks;
 
 	if (IS_INODE(dn->node_page) && f2fs_has_extra_attr(dn->inode))
 		base = get_extra_isize(dn->inode);
@@ -595,7 +596,9 @@ void f2fs_truncate_data_blocks_range(struct dnode_of_data *dn, int count)
 			clear_inode_flag(dn->inode, FI_FIRST_BLOCK_WRITTEN);
 
 		f2fs_invalidate_blocks(sbi, blkaddr);
-		nr_free++;
+
+		if (released && blkaddr != COMPRESS_ADDR)
+			nr_free++;
 	}
 
 	if (compressed_cluster)
@@ -3410,6 +3413,152 @@ static int f2fs_get_compress_blocks(struct file *filp, unsigned long arg)
 	return put_user(blocks, (u64 __user *)arg);
 }
 
+static int release_compress_blocks(struct dnode_of_data *dn, pgoff_t count)
+{
+	struct f2fs_sb_info *sbi = F2FS_I_SB(dn->inode);
+	unsigned int released_blocks = 0;
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
+			if (__is_valid_data_blkaddr(blkaddr))
+				compr_blocks++;
+
+			if (blkaddr != NEW_ADDR)
+				continue;
+
+			dn->data_blkaddr = NULL_ADDR;
+			f2fs_set_data_blkaddr(dn);
+		}
+
+		f2fs_i_compr_blocks_update(dn->inode, compr_blocks, false);
+		dec_valid_block_count(sbi, dn->inode,
+					cluster_size - compr_blocks);
+
+		released_blocks += cluster_size - compr_blocks;
+next:
+		count -= cluster_size;
+	}
+
+	return released_blocks;
+}
+
+static int f2fs_release_compress_blocks(struct file *filp, unsigned long arg)
+{
+	struct inode *inode = file_inode(filp);
+	struct f2fs_sb_info *sbi = F2FS_I_SB(inode);
+	pgoff_t page_idx = 0, last_idx;
+	unsigned int released_blocks = 0;
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
+	if (!F2FS_I(inode)->i_compr_blocks)
+		goto out;
+
+	f2fs_balance_fs(F2FS_I_SB(inode), true);
+
+	inode_lock(inode);
+
+	if (!IS_IMMUTABLE(inode)) {
+		F2FS_I(inode)->i_flags |= F2FS_IMMUTABLE_FL;
+		f2fs_set_inode_flags(inode);
+		inode->i_ctime = current_time(inode);
+		f2fs_mark_inode_dirty_sync(inode, true);
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
+
+		ret = release_compress_blocks(&dn, count);
+
+		f2fs_put_dnode(&dn);
+
+		if (ret < 0)
+			break;
+
+		page_idx += count;
+		released_blocks += ret;
+	}
+
+	up_write(&F2FS_I(inode)->i_gc_rwsem[WRITE]);
+	up_write(&F2FS_I(inode)->i_mmap_sem);
+
+	inode_unlock(inode);
+out:
+	mnt_drop_write_file(filp);
+
+	if (ret >= 0) {
+		ret = put_user(released_blocks, (u64 __user *)arg);
+	} else if (released_blocks && F2FS_I(inode)->i_compr_blocks) {
+		set_sbi_flag(sbi, SBI_NEED_FSCK);
+		f2fs_warn(sbi, "%s: partial blocks were released i_ino=%lx "
+			"iblocks=%llu, released=%u, compr_blocks=%llu, "
+			"run fsck to fix.",
+			__func__, inode->i_ino, inode->i_blocks,
+			released_blocks,
+			F2FS_I(inode)->i_compr_blocks);
+	}
+
+	return ret;
+}
+
 long f2fs_ioctl(struct file *filp, unsigned int cmd, unsigned long arg)
 {
 	if (unlikely(f2fs_cp_error(F2FS_I_SB(file_inode(filp)))))
@@ -3490,6 +3639,8 @@ long f2fs_ioctl(struct file *filp, unsigned int cmd, unsigned long arg)
 		return f2fs_set_volume_name(filp, arg);
 	case F2FS_IOC_GET_COMPRESS_BLOCKS:
 		return f2fs_get_compress_blocks(filp, arg);
+	case F2FS_IOC_RELEASE_COMPRESS_BLOCKS:
+		return f2fs_release_compress_blocks(filp, arg);
 	default:
 		return -ENOTTY;
 	}
@@ -3650,6 +3801,7 @@ long f2fs_compat_ioctl(struct file *file, unsigned int cmd, unsigned long arg)
 	case F2FS_IOC_GET_VOLUME_NAME:
 	case F2FS_IOC_SET_VOLUME_NAME:
 	case F2FS_IOC_GET_COMPRESS_BLOCKS:
+	case F2FS_IOC_RELEASE_COMPRESS_BLOCKS:
 		break;
 	default:
 		return -ENOIOCTLCMD;
-- 
2.18.0.rc1

