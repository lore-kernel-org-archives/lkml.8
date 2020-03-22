Return-Path: <SRS0=o5Nk=5H=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 17DBBC4332B
	for <linux-kernel@archiver.kernel.org>; Sun, 22 Mar 2020 13:57:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CB9EB20732
	for <linux-kernel@archiver.kernel.org>; Sun, 22 Mar 2020 13:57:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1584885452;
	bh=A5H1ZtSSWht0l+9RgYS/x0cT+AQ7hGfZSVtHvqAviao=;
	h=From:To:Cc:Subject:Date:List-ID:From;
	b=hPthWMGGpTJEpeltGgORpPbMSNIvap0wAUFHeV/fE6TSRCy0CP3phyzTHZ3gUJ3el
	 nmZUrFQ4x+z+l9DbWcJbzvXIi2PRqlVg23ZDoNWG8BzwBYG6CbU8lWGTxpu/Ydj2Bl
	 tuWveqF0dUlYaCs18zoiWuXjdX+e3Hm1gguqucyU=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726871AbgCVN5O (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 22 Mar 2020 09:57:14 -0400
Received: from mail.kernel.org ([198.145.29.99]:55310 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725997AbgCVN5N (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 22 Mar 2020 09:57:13 -0400
Received: from localhost.localdomain (unknown [49.65.245.234])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 597AA20724;
        Sun, 22 Mar 2020 13:56:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1584885432;
        bh=A5H1ZtSSWht0l+9RgYS/x0cT+AQ7hGfZSVtHvqAviao=;
        h=From:To:Cc:Subject:Date:From;
        b=AsHpyjZd+FNqxFrf9nnCkMIgcA0+RF8+pglLgBKSXS5Ry/f1JHcO6wnTDY05kLOa2
         X/aHK5L73FLMlAc6sMfGeCvrvkV+XzQvH4h9bEb7q2CYNC8jduFAadqKVCYdlxuGF+
         PpokrwHuWJeHObe4550WcOYcSk61aqkUGOS6IxYk=
From:   Chao Yu <chao@kernel.org>
To:     jaegeuk@kernel.org
Cc:     linux-f2fs-devel@lists.sourceforge.net,
        linux-kernel@vger.kernel.org, Chao Yu <yuchao0@huawei.com>
Subject: [PATCH v2] f2fs: fix potential .flags overflow on 32bit architecture
Date:   Sun, 22 Mar 2020 21:56:14 +0800
Message-Id: <20200322135614.10413-1-chao@kernel.org>
X-Mailer: git-send-email 2.22.0
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Chao Yu <yuchao0@huawei.com>

f2fs_inode_info.flags is unsigned long variable, it has 32 bits
in 32bit architecture, since we introduced FI_MMAP_FILE flag
when we support data compression, we may access memory cross
the border of .flags field, corrupting .i_sem field, result in
below deadlock.

To fix this issue, let's expand .flags as an array to grab enough
space to store new flags.

Call Trace:
 __schedule+0x8d0/0x13fc
 ? mark_held_locks+0xac/0x100
 schedule+0xcc/0x260
 rwsem_down_write_slowpath+0x3ab/0x65d
 down_write+0xc7/0xe0
 f2fs_drop_nlink+0x3d/0x600 [f2fs]
 f2fs_delete_inline_entry+0x300/0x440 [f2fs]
 f2fs_delete_entry+0x3a1/0x7f0 [f2fs]
 f2fs_unlink+0x500/0x790 [f2fs]
 vfs_unlink+0x211/0x490
 do_unlinkat+0x483/0x520
 sys_unlink+0x4a/0x70
 do_fast_syscall_32+0x12b/0x683
 entry_SYSENTER_32+0xaa/0x102

Fixes: 4c8ff7095bef ("f2fs: support data compression")
Signed-off-by: Chao Yu <yuchao0@huawei.com>
---
- change .flags as an array to expand scalability
- fix wrong condition pointed out by Ondřej Jirman
 fs/f2fs/f2fs.h  | 118 ++++++++++++++++++++++++++----------------------
 fs/f2fs/inode.c |   4 +-
 2 files changed, 68 insertions(+), 54 deletions(-)

diff --git a/fs/f2fs/f2fs.h b/fs/f2fs/f2fs.h
index fcafa68212eb..83496fd67a01 100644
--- a/fs/f2fs/f2fs.h
+++ b/fs/f2fs/f2fs.h
@@ -682,6 +682,47 @@ enum {
 	MAX_GC_FAILURE
 };
 
+/* used for f2fs_inode_info->flags */
+enum {
+	FI_NEW_INODE,		/* indicate newly allocated inode */
+	FI_DIRTY_INODE,		/* indicate inode is dirty or not */
+	FI_AUTO_RECOVER,	/* indicate inode is recoverable */
+	FI_DIRTY_DIR,		/* indicate directory has dirty pages */
+	FI_INC_LINK,		/* need to increment i_nlink */
+	FI_ACL_MODE,		/* indicate acl mode */
+	FI_NO_ALLOC,		/* should not allocate any blocks */
+	FI_FREE_NID,		/* free allocated nide */
+	FI_NO_EXTENT,		/* not to use the extent cache */
+	FI_INLINE_XATTR,	/* used for inline xattr */
+	FI_INLINE_DATA,		/* used for inline data*/
+	FI_INLINE_DENTRY,	/* used for inline dentry */
+	FI_APPEND_WRITE,	/* inode has appended data */
+	FI_UPDATE_WRITE,	/* inode has in-place-update data */
+	FI_NEED_IPU,		/* used for ipu per file */
+	FI_ATOMIC_FILE,		/* indicate atomic file */
+	FI_ATOMIC_COMMIT,	/* indicate the state of atomical committing */
+	FI_VOLATILE_FILE,	/* indicate volatile file */
+	FI_FIRST_BLOCK_WRITTEN,	/* indicate #0 data block was written */
+	FI_DROP_CACHE,		/* drop dirty page cache */
+	FI_DATA_EXIST,		/* indicate data exists */
+	FI_INLINE_DOTS,		/* indicate inline dot dentries */
+	FI_DO_DEFRAG,		/* indicate defragment is running */
+	FI_DIRTY_FILE,		/* indicate regular/symlink has dirty pages */
+	FI_NO_PREALLOC,		/* indicate skipped preallocated blocks */
+	FI_HOT_DATA,		/* indicate file is hot */
+	FI_EXTRA_ATTR,		/* indicate file has extra attribute */
+	FI_PROJ_INHERIT,	/* indicate file inherits projectid */
+	FI_PIN_FILE,		/* indicate file should not be gced */
+	FI_ATOMIC_REVOKE_REQUEST, /* request to drop atomic data */
+	FI_VERITY_IN_PROGRESS,	/* building fs-verity Merkle tree */
+	FI_COMPRESSED_FILE,	/* indicate file's data can be compressed */
+	FI_MMAP_FILE,		/* indicate file was mmapped */
+	FI_MAX,			/* max flag, never be used */
+};
+
+/* f2fs_inode_info.flags array size */
+#define FI_ARRAY_SIZE		(BIT_WORD(FI_MAX) + 1)
+
 struct f2fs_inode_info {
 	struct inode vfs_inode;		/* serve a vfs inode */
 	unsigned long i_flags;		/* keep an inode flags for ioctl */
@@ -694,7 +735,7 @@ struct f2fs_inode_info {
 	umode_t i_acl_mode;		/* keep file acl mode temporarily */
 
 	/* Use below internally in f2fs*/
-	unsigned long flags;		/* use to pass per-file flags */
+	unsigned long flags[FI_ARRAY_SIZE];	/* use to pass per-file flags */
 	struct rw_semaphore i_sem;	/* protect fi info */
 	atomic_t dirty_pages;		/* # of dirty pages */
 	f2fs_hash_t chash;		/* hash value of given file name */
@@ -2531,45 +2572,8 @@ static inline __u32 f2fs_mask_flags(umode_t mode, __u32 flags)
 		return flags & F2FS_OTHER_FLMASK;
 }
 
-/* used for f2fs_inode_info->flags */
-enum {
-	FI_NEW_INODE,		/* indicate newly allocated inode */
-	FI_DIRTY_INODE,		/* indicate inode is dirty or not */
-	FI_AUTO_RECOVER,	/* indicate inode is recoverable */
-	FI_DIRTY_DIR,		/* indicate directory has dirty pages */
-	FI_INC_LINK,		/* need to increment i_nlink */
-	FI_ACL_MODE,		/* indicate acl mode */
-	FI_NO_ALLOC,		/* should not allocate any blocks */
-	FI_FREE_NID,		/* free allocated nide */
-	FI_NO_EXTENT,		/* not to use the extent cache */
-	FI_INLINE_XATTR,	/* used for inline xattr */
-	FI_INLINE_DATA,		/* used for inline data*/
-	FI_INLINE_DENTRY,	/* used for inline dentry */
-	FI_APPEND_WRITE,	/* inode has appended data */
-	FI_UPDATE_WRITE,	/* inode has in-place-update data */
-	FI_NEED_IPU,		/* used for ipu per file */
-	FI_ATOMIC_FILE,		/* indicate atomic file */
-	FI_ATOMIC_COMMIT,	/* indicate the state of atomical committing */
-	FI_VOLATILE_FILE,	/* indicate volatile file */
-	FI_FIRST_BLOCK_WRITTEN,	/* indicate #0 data block was written */
-	FI_DROP_CACHE,		/* drop dirty page cache */
-	FI_DATA_EXIST,		/* indicate data exists */
-	FI_INLINE_DOTS,		/* indicate inline dot dentries */
-	FI_DO_DEFRAG,		/* indicate defragment is running */
-	FI_DIRTY_FILE,		/* indicate regular/symlink has dirty pages */
-	FI_NO_PREALLOC,		/* indicate skipped preallocated blocks */
-	FI_HOT_DATA,		/* indicate file is hot */
-	FI_EXTRA_ATTR,		/* indicate file has extra attribute */
-	FI_PROJ_INHERIT,	/* indicate file inherits projectid */
-	FI_PIN_FILE,		/* indicate file should not be gced */
-	FI_ATOMIC_REVOKE_REQUEST, /* request to drop atomic data */
-	FI_VERITY_IN_PROGRESS,	/* building fs-verity Merkle tree */
-	FI_COMPRESSED_FILE,	/* indicate file's data can be compressed */
-	FI_MMAP_FILE,		/* indicate file was mmapped */
-};
-
 static inline void __mark_inode_dirty_flag(struct inode *inode,
-						int flag, bool set)
+					unsigned long long flag, bool set)
 {
 	switch (flag) {
 	case FI_INLINE_XATTR:
@@ -2586,22 +2590,32 @@ static inline void __mark_inode_dirty_flag(struct inode *inode,
 	}
 }
 
+static inline void __set_inode_flag(struct inode *inode, int flag)
+{
+	if (!test_bit(flag % BITS_PER_LONG,
+			&F2FS_I(inode)->flags[BIT_WORD(flag)]))
+		set_bit(flag % BITS_PER_LONG,
+			&F2FS_I(inode)->flags[BIT_WORD(flag)]);
+}
+
 static inline void set_inode_flag(struct inode *inode, int flag)
 {
-	if (!test_bit(flag, &F2FS_I(inode)->flags))
-		set_bit(flag, &F2FS_I(inode)->flags);
+	__set_inode_flag(inode, flag);
 	__mark_inode_dirty_flag(inode, flag, true);
 }
 
 static inline int is_inode_flag_set(struct inode *inode, int flag)
 {
-	return test_bit(flag, &F2FS_I(inode)->flags);
+	return test_bit(flag % BITS_PER_LONG,
+			&F2FS_I(inode)->flags[BIT_WORD(flag)]);
 }
 
 static inline void clear_inode_flag(struct inode *inode, int flag)
 {
-	if (test_bit(flag, &F2FS_I(inode)->flags))
-		clear_bit(flag, &F2FS_I(inode)->flags);
+	if (test_bit(flag % BITS_PER_LONG,
+			&F2FS_I(inode)->flags[BIT_WORD(flag)]))
+		clear_bit(flag % BITS_PER_LONG,
+			&F2FS_I(inode)->flags[BIT_WORD(flag)]);
 	__mark_inode_dirty_flag(inode, flag, false);
 }
 
@@ -2689,22 +2703,20 @@ static inline void f2fs_i_pino_write(struct inode *inode, nid_t pino)
 
 static inline void get_inline_info(struct inode *inode, struct f2fs_inode *ri)
 {
-	struct f2fs_inode_info *fi = F2FS_I(inode);
-
 	if (ri->i_inline & F2FS_INLINE_XATTR)
-		set_bit(FI_INLINE_XATTR, &fi->flags);
+		__set_inode_flag(inode, FI_INLINE_XATTR);
 	if (ri->i_inline & F2FS_INLINE_DATA)
-		set_bit(FI_INLINE_DATA, &fi->flags);
+		__set_inode_flag(inode, FI_INLINE_DATA);
 	if (ri->i_inline & F2FS_INLINE_DENTRY)
-		set_bit(FI_INLINE_DENTRY, &fi->flags);
+		__set_inode_flag(inode, FI_INLINE_DENTRY);
 	if (ri->i_inline & F2FS_DATA_EXIST)
-		set_bit(FI_DATA_EXIST, &fi->flags);
+		__set_inode_flag(inode, FI_DATA_EXIST);
 	if (ri->i_inline & F2FS_INLINE_DOTS)
-		set_bit(FI_INLINE_DOTS, &fi->flags);
+		__set_inode_flag(inode, FI_INLINE_DOTS);
 	if (ri->i_inline & F2FS_EXTRA_ATTR)
-		set_bit(FI_EXTRA_ATTR, &fi->flags);
+		__set_inode_flag(inode, FI_EXTRA_ATTR);
 	if (ri->i_inline & F2FS_PIN_FILE)
-		set_bit(FI_PIN_FILE, &fi->flags);
+		__set_inode_flag(inode, FI_PIN_FILE);
 }
 
 static inline void set_raw_inline(struct inode *inode, struct f2fs_inode *ri)
diff --git a/fs/f2fs/inode.c b/fs/f2fs/inode.c
index 44e08bf2e2b4..5e441fdd4858 100644
--- a/fs/f2fs/inode.c
+++ b/fs/f2fs/inode.c
@@ -328,6 +328,7 @@ static int do_read_inode(struct inode *inode)
 	struct f2fs_inode *ri;
 	projid_t i_projid;
 	int err;
+	int i;
 
 	/* Check if ino is within scope */
 	if (f2fs_check_nid_range(sbi, inode->i_ino))
@@ -362,7 +363,8 @@ static int do_read_inode(struct inode *inode)
 	fi->i_flags = le32_to_cpu(ri->i_flags);
 	if (S_ISREG(inode->i_mode))
 		fi->i_flags &= ~F2FS_PROJINHERIT_FL;
-	fi->flags = 0;
+	for (i = 0; i < FI_ARRAY_SIZE; i++)
+		fi->flags[i] = 0;
 	fi->i_advise = ri->i_advise;
 	fi->i_pino = le32_to_cpu(ri->i_pino);
 	fi->i_dir_level = ri->i_dir_level;
-- 
2.22.0

