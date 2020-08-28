Return-Path: <SRS0=aBbL=CG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 88AF1C433E6
	for <linux-kernel@archiver.kernel.org>; Fri, 28 Aug 2020 16:39:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 515EE20872
	for <linux-kernel@archiver.kernel.org>; Fri, 28 Aug 2020 16:39:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728333AbgH1QjU (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 28 Aug 2020 12:39:20 -0400
Received: from smtprelay0173.hostedemail.com ([216.40.44.173]:43104 "EHLO
        smtprelay.hostedemail.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1728169AbgH1QjO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Aug 2020 12:39:14 -0400
Received: from filter.hostedemail.com (clb03-v110.bra.tucows.net [216.40.38.60])
        by smtprelay04.hostedemail.com (Postfix) with ESMTP id D055318026A0C;
        Fri, 28 Aug 2020 16:39:12 +0000 (UTC)
X-Session-Marker: 6A6F6540706572636865732E636F6D
X-HE-Tag: club31_270d19427077
X-Filterd-Recvd-Size: 22594
Received: from joe-laptop.perches.com (unknown [47.151.133.149])
        (Authenticated sender: joe@perches.com)
        by omf17.hostedemail.com (Postfix) with ESMTPA;
        Fri, 28 Aug 2020 16:39:11 +0000 (UTC)
From:   Joe Perches <joe@perches.com>
To:     Konstantin Komarov <almaz.alexandrovich@paragon-software.com>
Cc:     linux-kernel@vger.kernel.org
Subject: [PATCH 1/3] ntfs3: Add and use logging macros
Date:   Fri, 28 Aug 2020 09:39:03 -0700
Message-Id: <3b52b62bafe9f723b9c2dfbc68cf0a6d3adbf3fa.1598632661.git.joe@perches.com>
X-Mailer: git-send-email 2.26.0
In-Reply-To: <cover.1598632661.git.joe@perches.com>
References: <cover.1598632661.git.joe@perches.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Use more common kernel style by removing direct uses of KERN_<LEVEL>.

Miscellanea:

o Correct spelling of garbage in logging

Signed-off-by: Joe Perches <joe@perches.com>
---
 fs/ntfs3/debug.h   | 12 +++++++++
 fs/ntfs3/dir.c     | 24 ++++++++----------
 fs/ntfs3/file.c    | 47 +++++++++++++----------------------
 fs/ntfs3/frecord.c | 11 +++------
 fs/ntfs3/fslog.c   |  6 ++---
 fs/ntfs3/fsntfs.c  | 43 ++++++++++++--------------------
 fs/ntfs3/index.c   |  2 +-
 fs/ntfs3/inode.c   | 18 +++++---------
 fs/ntfs3/ntfs_fs.h |  4 +--
 fs/ntfs3/super.c   | 61 +++++++++++++++++-----------------------------
 10 files changed, 93 insertions(+), 135 deletions(-)

diff --git a/fs/ntfs3/debug.h b/fs/ntfs3/debug.h
index eff8e52b1560..cd3d23dff2d9 100644
--- a/fs/ntfs3/debug.h
+++ b/fs/ntfs3/debug.h
@@ -40,6 +40,18 @@ static inline __printf(2, 3) void ntfs_inode_printk(struct inode *inode,
 }
 #endif
 
+#define ntfs_err(sb, fmt, ...)						\
+	ntfs_printk(sb, KERN_ERR fmt, ##__VA_ARGS__)
+#define ntfs_warn(sb, fmt, ...)						\
+	ntfs_printk(sb, KERN_WARNING fmt, ##__VA_ARGS__)
+#define ntfs_notice(sb, fmt, ...)					\
+	ntfs_printk(sb, KERN_NOTICE fmt, ##__VA_ARGS__)
+
+#define ntfs_inode_err(inode, fmt, ...)					\
+	ntfs_inode_printk(inode, KERN_ERR fmt, ##__VA_ARGS__)
+#define ntfs_inode_warn(inode, fmt, ...)				\
+	ntfs_inode_printk(inode, KERN_WARNING fmt, ##__VA_ARGS__)
+
 #define ntfs_alloc(s, z) kmalloc(s, z ? (GFP_NOFS | __GFP_ZERO) : GFP_NOFS)
 #define ntfs_free(p) kfree(p)
 #define ntfs_memdup(src, len) kmemdup(src, len, GFP_NOFS)
diff --git a/fs/ntfs3/dir.c b/fs/ntfs3/dir.c
index 5bf0297f6b2f..5a06c6db16ce 100644
--- a/fs/ntfs3/dir.c
+++ b/fs/ntfs3/dir.c
@@ -47,8 +47,8 @@ int ntfs_utf16_to_nls(struct ntfs_sb_info *sbi, const struct le_str *uni,
 		int charlen;
 
 		if (buf_len < NLS_MAX_CHARSET_SIZE) {
-			ntfs_printk(sbi->sb, KERN_WARNING
-				    "filename was truncated while converting.");
+			ntfs_warn(sbi->sb,
+				  "filename was truncated while converting");
 			break;
 		}
 
@@ -199,13 +199,12 @@ int ntfs_nls_to_utf16(struct ntfs_sb_info *sbi, const u8 *name, u32 name_len,
 
 		if (!warn) {
 			warn = 1;
-			ntfs_printk(
-				sbi->sb,
-				KERN_ERR
-				"%s -> utf16 failed: '%.*s', pos %d, chars %x %x %x",
-				nls->charset, name_len, name, (int)(str - name),
-				str[0], tail > 1 ? str[1] : 0,
-				tail > 2 ? str[2] : 0);
+			ntfs_err(sbi->sb,
+				 "%s -> utf16 failed: '%.*s', pos %d, chars %x %x %x",
+				 nls->charset, name_len, name,
+				 (int)(str - name),
+				 str[0], tail > 1 ? str[1] : 0,
+				 tail > 2 ? str[2] : 0);
 		}
 
 		if (max_ulen < 3)
@@ -348,10 +347,7 @@ static inline int ntfs_filldir(struct ntfs_sb_info *sbi, struct ntfs_inode *ni,
 	name_len = ntfs_utf16_to_nls(sbi, (struct le_str *)&fname->name_len,
 				     name, PATH_MAX);
 	if (name_len <= 0) {
-		ntfs_printk(sbi->sb,
-			    KERN_WARNING
-			    "failed to convert name for inode %lx.",
-			    ino);
+		ntfs_warn(sbi->sb, "failed to convert name for inode %lx", ino);
 		return 0;
 	}
 
@@ -515,7 +511,7 @@ static int ntfs_readdir(struct file *file, struct dir_context *ctx)
 	}
 
 fs_error:
-	ntfs_inode_printk(dir, KERN_ERR "Looks like your dir is corrupt");
+	ntfs_inode_err(dir, "Looks like your dir is corrupt");
 	err = -EINVAL;
 out:
 
diff --git a/fs/ntfs3/file.c b/fs/ntfs3/file.c
index 72c6a263b5bc..52511299b4b7 100644
--- a/fs/ntfs3/file.c
+++ b/fs/ntfs3/file.c
@@ -187,10 +187,8 @@ static int ntfs_extend_initialized_size(struct file *file,
 
 out:
 	ni->i_valid = valid;
-	ntfs_inode_printk(inode,
-			  KERN_WARNING
-			  "failed to extend initialized size to %llx.",
-			  new_valid);
+	ntfs_inode_warn(inode, "failed to extend initialized size to %llx",
+			new_valid);
 	return err;
 }
 
@@ -296,11 +294,9 @@ static int ntfs_extend_initialized_size_cmpr(struct file *file,
 
 out:
 	ni->i_valid = valid;
-	ntfs_inode_printk(
-		inode,
-		KERN_WARNING
-		"failed to extend initialized compressed size to %llx.",
-		new_valid);
+	ntfs_inode_warn(inode,
+			"failed to extend initialized compressed size to %llx",
+			new_valid);
 	return err;
 }
 
@@ -341,9 +337,8 @@ void ntfs_sparse_cluster(struct inode *inode, struct page *page0, loff_t vbo,
 		    likely(!page_has_buffers(page))) {
 			create_empty_buffers(page, blocksize, 0);
 			if (!page_has_buffers(page)) {
-				ntfs_inode_printk(
-					inode, KERN_ERR
-					"failed to allocate page buffers.");
+				ntfs_inode_err(inode,
+					       "failed to allocate page buffers");
 				/*err = -ENOMEM;*/
 				goto unlock_page;
 			}
@@ -829,27 +824,23 @@ static ssize_t ntfs_file_read_iter(struct kiocb *iocb, struct iov_iter *iter)
 	struct ntfs_inode *ni = ntfs_i(inode);
 
 	if (is_encrypted(ni)) {
-		ntfs_inode_printk(inode,
-				  KERN_WARNING "encrypted i/o not supported");
+		ntfs_inode_warn(inode, "encrypted i/o not supported");
 		return -EOPNOTSUPP;
 	}
 
 	if (is_compressed(ni) && (iocb->ki_flags & IOCB_DIRECT)) {
-		ntfs_inode_printk(inode, KERN_WARNING
-				  "direct i/o + compressed not supported");
+		ntfs_inode_warn(inode, "direct i/o + compressed not supported");
 		return -EOPNOTSUPP;
 	}
 
 	if (ni->ni_flags & NI_FLAG_COMPRESSED_MASK) {
-		ntfs_inode_printk(
-			inode, KERN_WARNING
-			"read external compressed file not supported (temporary)");
+		ntfs_inode_warn(inode,
+				"read external compressed file not supported (temporary)");
 		return -EOPNOTSUPP;
 	}
 
 	if (is_dedup(ni)) {
-		ntfs_inode_printk(inode, KERN_WARNING
-				  "read deduplicated not supported");
+		ntfs_inode_warn(inode, "read deduplicated not supported");
 		return -EOPNOTSUPP;
 	}
 
@@ -1073,27 +1064,23 @@ static ssize_t ntfs_file_write_iter(struct kiocb *iocb, struct iov_iter *from)
 	struct ntfs_inode *ni = ntfs_i(inode);
 
 	if (is_encrypted(ni)) {
-		ntfs_inode_printk(inode,
-				  KERN_WARNING "encrypted i/o not supported");
+		ntfs_inode_warn(inode, "encrypted i/o not supported");
 		return -EOPNOTSUPP;
 	}
 
 	if (is_compressed(ni) && (iocb->ki_flags & IOCB_DIRECT)) {
-		ntfs_inode_printk(inode, KERN_WARNING
-				  "direct i/o + compressed not supported");
+		ntfs_inode_warn(inode, "direct i/o + compressed not supported");
 		return -EOPNOTSUPP;
 	}
 
 	if (ni->ni_flags & NI_FLAG_COMPRESSED_MASK) {
-		ntfs_inode_printk(
-			inode, KERN_WARNING
-			"write into external compressed file not supported (temporary)");
+		ntfs_inode_warn(inode,
+				"write into external compressed file not supported (temporary)");
 		return -EOPNOTSUPP;
 	}
 
 	if (is_dedup(ni)) {
-		ntfs_inode_printk(inode, KERN_WARNING
-				  "write into deduplicated not supported");
+		ntfs_inode_warn(inode, "write into deduplicated not supported");
 		return -EOPNOTSUPP;
 	}
 
diff --git a/fs/ntfs3/frecord.c b/fs/ntfs3/frecord.c
index ad09fca5d7db..3402863c8352 100644
--- a/fs/ntfs3/frecord.c
+++ b/fs/ntfs3/frecord.c
@@ -2298,11 +2298,9 @@ int ni_write_inode(struct inode *inode, int sync, const char *hint)
 		/*ntfs_iget5 may sleep*/
 		dir = ntfs_iget5(sb, &fname->home, NULL);
 		if (IS_ERR(dir)) {
-			ntfs_inode_printk(
-				inode,
-				KERN_WARNING
-				"failed to open parent directory r=%lx to update",
-				(long)ino_get(&fname->home));
+			ntfs_inode_warn(inode,
+					"failed to open parent directory r=%lx to update",
+					(long)ino_get(&fname->home));
 			continue;
 		}
 
@@ -2362,8 +2360,7 @@ int ni_write_inode(struct inode *inode, int sync, const char *hint)
 	ni_unlock(ni);
 
 	if (err) {
-		ntfs_printk(sb, KERN_ERR "%s r=%lx failed, %d.", hint,
-			    inode->i_ino, err);
+		ntfs_err(sb, "%s r=%lx failed, %d", hint, inode->i_ino, err);
 		ntfs_set_state(sbi, NTFS_DIRTY_ERROR);
 		return err;
 	}
diff --git a/fs/ntfs3/fslog.c b/fs/ntfs3/fslog.c
index e9d41b7d99dd..f282e96a45cb 100644
--- a/fs/ntfs3/fslog.c
+++ b/fs/ntfs3/fslog.c
@@ -4096,10 +4096,8 @@ int log_replay(struct ntfs_inode *ni)
 	case 0x20000:
 		break;
 	default:
-		ntfs_printk(sbi->sb,
-			    KERN_WARNING
-			    "$LogFile version %d.%d is not supported",
-			    log->major_ver, log->minor_ver);
+		ntfs_warn(sbi->sb, "$LogFile version %d.%d is not supported",
+			  log->major_ver, log->minor_ver);
 		err = -EOPNOTSUPP;
 		log->set_dirty = true;
 		goto out;
diff --git a/fs/ntfs3/fsntfs.c b/fs/ntfs3/fsntfs.c
index c5ab623763aa..d142b42f2cc2 100644
--- a/fs/ntfs3/fsntfs.c
+++ b/fs/ntfs3/fsntfs.c
@@ -172,7 +172,7 @@ int ntfs_extend_init(struct ntfs_sb_info *sbi)
 	struct MFT_REF ref;
 
 	if (sbi->volume.major_ver < 3) {
-		ntfs_printk(sb, KERN_NOTICE "Skip $Extend 'cause NTFS version");
+		ntfs_notice(sb, "Skip $Extend 'cause NTFS version");
 		return 0;
 	}
 
@@ -182,7 +182,7 @@ int ntfs_extend_init(struct ntfs_sb_info *sbi)
 	inode = ntfs_iget5(sb, &ref, &NAME_EXTEND);
 	if (IS_ERR(inode)) {
 		err = PTR_ERR(inode);
-		ntfs_printk(sb, KERN_ERR "Failed to load $Extend.");
+		ntfs_err(sb, "Failed to load $Extend");
 		inode = NULL;
 		goto out;
 	}
@@ -244,7 +244,7 @@ int ntfs_loadlog_and_replay(struct ntfs_inode *ni, struct ntfs_sb_info *sbi)
 
 	/* Check for 4GB */
 	if (inode->i_size >= 0x100000000ull) {
-		ntfs_printk(sb, KERN_ERR "$LogFile is too big");
+		ntfs_err(sb, "$LogFile is too big");
 		err = -EINVAL;
 		goto out;
 	}
@@ -273,7 +273,7 @@ int ntfs_loadlog_and_replay(struct ntfs_inode *ni, struct ntfs_sb_info *sbi)
 
 	if (!inode) {
 		err = -EINVAL;
-		ntfs_printk(sb, KERN_ERR "Failed to load $MFT.");
+		ntfs_err(sb, "Failed to load $MFT");
 		goto out;
 	}
 
@@ -371,8 +371,8 @@ int ntfs_look_for_free_space(struct ntfs_sb_info *sbi, CLST lcn, CLST len,
 			zlen = wnd_zone_len(wnd);
 
 			if (!zlen) {
-				ntfs_printk(sbi->sb, KERN_ERR
-					    "no free space to extend mft");
+				ntfs_err(sbi->sb,
+					 "no free space to extend mft");
 				err = -ENOSPC;
 				goto out;
 			}
@@ -443,11 +443,8 @@ int ntfs_look_for_free_space(struct ntfs_sb_info *sbi, CLST lcn, CLST len,
 	}
 
 no_space:
-	ntfs_printk(
-		sb,
-		KERN_NOTICE
-		"Can not allocate %x cluster(s), Zone: %zx, free %zx, flags %d",
-		(u32)len, zlen, wnd_zeroes(wnd), (int)opt);
+	ntfs_notice(sb, "Can not allocate %x cluster(s), Zone: %zx, free %zx, flags %d",
+		    (u32)len, zlen, wnd_zeroes(wnd), (int)opt);
 
 	up_write(&wnd->rw_lock);
 
@@ -615,9 +612,7 @@ int ntfs_look_free_mft(struct ntfs_sb_info *sbi, CLST *rno, bool mft,
 			i = ntfs_iget5(sb, &ref, NULL);
 			if (IS_ERR(i)) {
 next:
-				ntfs_printk(sb,
-					    KERN_NOTICE
-					    "Invalid reserved record %x",
+				ntfs_notice(sb, "Invalid reserved record %x",
 					    ref.low);
 				continue;
 			}
@@ -846,7 +841,7 @@ int ntfs_refresh_zone(struct ntfs_sb_info *sbi)
 	/* Try to allocate clusters after last MFT run */
 	zlen = wnd_find(wnd, zone_max, lcn_s, 0, &lcn_s);
 	if (!zlen) {
-		ntfs_printk(sbi->sb, KERN_NOTICE "MftZone: unavailable");
+		ntfs_notice(sbi->sb, "MftZone: unavailable");
 		return 0;
 	}
 
@@ -975,8 +970,7 @@ int ntfs_set_state(struct ntfs_sb_info *sbi, enum NTFS_DIRTY_FLAGS dirty)
 
 	switch (dirty) {
 	case NTFS_DIRTY_ERROR:
-		ntfs_printk(sbi->sb, KERN_NOTICE
-			    "Mark volume as dirty due to NTFS errors");
+		ntfs_notice(sbi->sb, "Mark volume as dirty due to NTFS errors");
 		sbi->volume.real_dirty = true;
 		fallthrough;
 	case NTFS_DIRTY_DIRTY:
@@ -1067,10 +1061,8 @@ int ntfs_sb_write(struct super_block *sb, u64 lbo, size_t bytes,
 		if (op < blocksize) {
 			bh = __bread(bdev, block, blocksize);
 			if (!bh) {
-				ntfs_printk(sb,
-					    KERN_ERR
-					    "failed to read block %llx",
-					    (u64)block);
+				ntfs_err(sb, "failed to read block %llx",
+					 (u64)block);
 				return -EIO;
 			}
 		} else {
@@ -1098,11 +1090,8 @@ int ntfs_sb_write(struct super_block *sb, u64 lbo, size_t bytes,
 			int err = sync_dirty_buffer(bh);
 
 			if (err) {
-				ntfs_printk(
-					sb,
-					KERN_ERR
-					"failed to sync buffer at block %llx, error %d",
-					(u64)block, err);
+				ntfs_err(sb, "failed to sync buffer at block %llx, error %d",
+					 (u64)block, err);
 				put_bh(bh);
 				return err;
 			}
@@ -1570,7 +1559,7 @@ int ntfs_security_init(struct ntfs_sb_info *sbi)
 	inode = ntfs_iget5(sb, &ref, &NAME_SECURE);
 	if (IS_ERR(inode)) {
 		err = PTR_ERR(inode);
-		ntfs_printk(sb, KERN_ERR "Failed to load $Secure.");
+		ntfs_err(sb, "Failed to load $Secure");
 		inode = NULL;
 		goto out;
 	}
diff --git a/fs/ntfs3/index.c b/fs/ntfs3/index.c
index 37ea369318ec..43853daa3a48 100644
--- a/fs/ntfs3/index.c
+++ b/fs/ntfs3/index.c
@@ -1707,7 +1707,7 @@ static int indx_insert_into_root(struct ntfs_index *indx, struct ntfs_inode *ni,
 		 * new entry classic case when mft record is 1K and index
 		 * buffer 4K the problem should not occurs
 		 */
-		ntfs_printk(sbi->sb, KERN_NOTICE
+		ntfs_notice(sbi->sb,
 			    "Failed: root + new entry > index. Reinsert");
 		ntfs_free(re);
 		indx_write(indx, ni, n, 0);
diff --git a/fs/ntfs3/inode.c b/fs/ntfs3/inode.c
index ddc1b5810959..117800126c17 100644
--- a/fs/ntfs3/inode.c
+++ b/fs/ntfs3/inode.c
@@ -79,13 +79,12 @@ static struct inode *ntfs_read_mft(struct inode *inode,
 		;
 	else if (ref->seq != rec->seq) {
 		err = -EINVAL;
-		ntfs_printk(sb,
-			    KERN_ERR "MFT: r=%lx, expect seq=%x instead of %x!",
-			    ino, le16_to_cpu(ref->seq), le16_to_cpu(rec->seq));
+		ntfs_err(sb, "MFT: r=%lx, expect seq=%x instead of %x!",
+			 ino, le16_to_cpu(ref->seq), le16_to_cpu(rec->seq));
 		goto out;
 	} else if (!is_rec_inuse(rec)) {
 		err = -EINVAL;
-		ntfs_printk(sb, KERN_ERR "Inode r=%x is not in use!", (u32)ino);
+		ntfs_err(sb, "Inode r=%x is not in use!", (u32)ino);
 		goto out;
 	}
 
@@ -781,10 +780,7 @@ int ntfs_readpage(struct file *file, struct page *page)
 		if (PageLocked(page))
 			wait_on_page_bit(page, PG_locked);
 		if (PageError(page)) {
-			ntfs_inode_printk(inode,
-					  KERN_WARNING
-					  "file garbadge at 0x%llx",
-					  valid);
+			ntfs_inode_warn(inode, "file garbage at 0x%llx", valid);
 			goto out;
 		}
 		zero_user_segment(page, valid & (PAGE_SIZE - 1), PAGE_SIZE);
@@ -904,7 +900,7 @@ static ssize_t ntfs_direct_IO(struct kiocb *iocb, struct iov_iter *iter)
 out:
 	return ret;
 fix_error:
-	ntfs_inode_printk(inode, KERN_WARNING "file garbadge at 0x%llx", valid);
+	ntfs_inode_warn(inode, "file garbage at 0x%llx", valid);
 	goto out;
 }
 
@@ -1414,9 +1410,7 @@ int ntfs_create_inode(struct inode *dir, struct dentry *dentry,
 		nsize = ntfs_reparse_bytes(err);
 
 		if (nsize > sbi->reparse.max_size) {
-			ntfs_printk(sb,
-				    KERN_WARNING "Symbolic link %u is too big",
-				    size);
+			ntfs_warn(sb, "Symbolic link %u is too big", size);
 			err = -EFBIG;
 			goto out4;
 		}
diff --git a/fs/ntfs3/ntfs_fs.h b/fs/ntfs3/ntfs_fs.h
index a28ccc36b288..066c5d0549b1 100644
--- a/fs/ntfs3/ntfs_fs.h
+++ b/fs/ntfs3/ntfs_fs.h
@@ -892,8 +892,8 @@ static inline struct buffer_head *ntfs_bread(struct super_block *sb,
 	if (bh)
 		return bh;
 
-	ntfs_printk(sb, KERN_ERR "failed to read volume at offset 0x%llx",
-		    (u64)block << sb->s_blocksize_bits);
+	ntfs_err(sb, "failed to read volume at offset 0x%llx",
+		 (u64)block << sb->s_blocksize_bits);
 	return NULL;
 }
 
diff --git a/fs/ntfs3/super.c b/fs/ntfs3/super.c
index e9a1fe191dab..8c8cba759471 100644
--- a/fs/ntfs3/super.c
+++ b/fs/ntfs3/super.c
@@ -524,9 +524,7 @@ static int ntfs_init_from_boot(struct super_block *sb, u32 sector_size,
 	 * - Volume formatted 512 and mounted as 4K
 	 */
 	if (sbi->sector_size != sector_size) {
-		ntfs_printk(
-			sb, KERN_WARNING
-			"Different NTFS' sector size and media sector size");
+		ntfs_warn(sb, "Different NTFS' sector size and media sector size");
 		dev_size += sector_size - 1;
 	}
 
@@ -569,11 +567,8 @@ static int ntfs_init_from_boot(struct super_block *sb, u32 sector_size,
 		u32 mb0, gb0;
 
 		gb0 = format_size_gb(dev_size, &mb0);
-		ntfs_printk(
-			sb,
-			KERN_WARNING
-			"RAW NTFS volume: Filesystem size %u.%02u Gb > volume size %u.%02u Gb. Mount in read-only",
-			gb, mb, gb0, mb0);
+		ntfs_warn(sb, "RAW NTFS volume: Filesystem size %u.%02u Gb > volume size %u.%02u Gb. Mount in read-only",
+			  gb, mb, gb0, mb0);
 		sb->s_flags |= SB_RDONLY;
 	}
 
@@ -585,11 +580,8 @@ static int ntfs_init_from_boot(struct super_block *sb, u32 sector_size,
 #else
 	/* 32 bits per cluster */
 	if (clusters >> 32) {
-		ntfs_printk(
-			sb,
-			KERN_NOTICE
-			"NTFS %u.%02u Gb is too big to use 32 bits per cluster",
-			gb, mb);
+		ntfs_notice(sb, "NTFS %u.%02u Gb is too big to use 32 bits per cluster",
+			    gb, mb);
 		goto out;
 	}
 #endif
@@ -773,11 +765,8 @@ static int ntfs_parse_options(struct super_block *sb, char *options, int silent,
 		/* unknown option */
 		default:
 			if (!silent)
-				ntfs_printk(
-					sb,
-					KERN_ERR
-					"Unrecognized mount option \"%s\" or missing value",
-					p);
+				ntfs_err(sb, "Unrecognized mount option \"%s\" or missing value",
+					 p);
 			//return -EINVAL;
 		}
 	}
@@ -786,14 +775,13 @@ static int ntfs_parse_options(struct super_block *sb, char *options, int silent,
 	if (nls_name[0]) {
 		sbi->nls = load_nls(nls_name);
 		if (!sbi->nls) {
-			ntfs_printk(sb, KERN_ERR "failed to load \"%s\"",
-				    nls_name);
+			ntfs_err(sb, "failed to load \"%s\"", nls_name);
 			return -EINVAL;
 		}
 	} else {
 		sbi->nls = load_nls_default();
 		if (!sbi->nls) {
-			ntfs_printk(sb, KERN_ERR "failed to load default nls");
+			ntfs_err(sb, "failed to load default nls");
 			return -EINVAL;
 		}
 	}
@@ -892,7 +880,7 @@ static int ntfs_fill_super(struct super_block *sb, void *data, int silent)
 	inode = ntfs_iget5(sb, &ref, &NAME_VOLUME);
 	if (IS_ERR(inode)) {
 		err = PTR_ERR(inode);
-		ntfs_printk(sb, KERN_ERR "Failed to load $Volume.");
+		ntfs_err(sb, "Failed to load $Volume");
 		inode = NULL;
 		goto out;
 	}
@@ -943,7 +931,7 @@ static int ntfs_fill_super(struct super_block *sb, void *data, int silent)
 	inode = ntfs_iget5(sb, &ref, &NAME_MIRROR);
 	if (IS_ERR(inode)) {
 		err = PTR_ERR(inode);
-		ntfs_printk(sb, KERN_ERR "Failed to load $MFTMirr.");
+		ntfs_err(sb, "Failed to load $MFTMirr");
 		inode = NULL;
 		goto out;
 	}
@@ -959,7 +947,7 @@ static int ntfs_fill_super(struct super_block *sb, void *data, int silent)
 	inode = ntfs_iget5(sb, &ref, &NAME_LOGFILE);
 	if (IS_ERR(inode)) {
 		err = PTR_ERR(inode);
-		ntfs_printk(sb, KERN_ERR "Failed to load $LogFile.");
+		ntfs_err(sb, "Failed to load $LogFile");
 		inode = NULL;
 		goto out;
 	}
@@ -977,17 +965,15 @@ static int ntfs_fill_super(struct super_block *sb, void *data, int silent)
 
 	if (sbi->flags & NTFS_FLAGS_NEED_REPLAY) {
 		if (!is_ro) {
-			ntfs_printk(
-				sb, KERN_WARNING
-				"failed to replay log file. Can't mount rw!");
+			ntfs_warn(sb,
+				  "failed to replay log file. Can't mount rw!");
 			err = -EINVAL;
 			goto out;
 		}
 	} else if (sbi->volume.flags & VOLUME_FLAG_DIRTY) {
 		if (!is_ro && !sbi->options.force) {
-			ntfs_printk(
-				sb, KERN_WARNING
-				"volume is dirty and \"force\" flag is not set!");
+			ntfs_warn(sb,
+				  "volume is dirty and \"force\" flag is not set!");
 			err = -EINVAL;
 			goto out;
 		}
@@ -1000,7 +986,7 @@ static int ntfs_fill_super(struct super_block *sb, void *data, int silent)
 	inode = ntfs_iget5(sb, &ref, &NAME_MFT);
 	if (IS_ERR(inode)) {
 		err = PTR_ERR(inode);
-		ntfs_printk(sb, KERN_ERR "Failed to load $MFT.");
+		ntfs_err(sb, "Failed to load $MFT");
 		inode = NULL;
 		goto out;
 	}
@@ -1027,7 +1013,7 @@ static int ntfs_fill_super(struct super_block *sb, void *data, int silent)
 	inode = ntfs_iget5(sb, &ref, &NAME_BADCLUS);
 	if (IS_ERR(inode)) {
 		err = PTR_ERR(inode);
-		ntfs_printk(sb, KERN_ERR "Failed to load $BadClus.");
+		ntfs_err(sb, "Failed to load $BadClus");
 		inode = NULL;
 		goto out;
 	}
@@ -1039,8 +1025,7 @@ static int ntfs_fill_super(struct super_block *sb, void *data, int silent)
 			continue;
 
 		if (!sbi->bad_clusters)
-			ntfs_printk(sb,
-				    KERN_NOTICE "Volume contains bad blocks");
+			ntfs_notice(sb, "Volume contains bad blocks");
 
 		sbi->bad_clusters += len;
 	}
@@ -1053,7 +1038,7 @@ static int ntfs_fill_super(struct super_block *sb, void *data, int silent)
 	inode = ntfs_iget5(sb, &ref, &NAME_BITMAP);
 	if (IS_ERR(inode)) {
 		err = PTR_ERR(inode);
-		ntfs_printk(sb, KERN_ERR "Failed to load $Bitmap.");
+		ntfs_err(sb, "Failed to load $Bitmap");
 		inode = NULL;
 		goto out;
 	}
@@ -1093,7 +1078,7 @@ static int ntfs_fill_super(struct super_block *sb, void *data, int silent)
 	inode = ntfs_iget5(sbi->sb, &ref, &NAME_ATTRDEF);
 	if (IS_ERR(inode)) {
 		err = PTR_ERR(inode);
-		ntfs_printk(sb, KERN_ERR "Failed to load $AttrDef -> %d", err);
+		ntfs_err(sb, "Failed to load $AttrDef -> %d", err);
 		inode = NULL;
 		goto out;
 	}
@@ -1153,7 +1138,7 @@ static int ntfs_fill_super(struct super_block *sb, void *data, int silent)
 	inode = ntfs_iget5(sb, &ref, &NAME_UPCASE);
 	if (IS_ERR(inode)) {
 		err = PTR_ERR(inode);
-		ntfs_printk(sb, KERN_ERR "Failed to load $LogFile.");
+		ntfs_err(sb, "Failed to load $LogFile");
 		inode = NULL;
 		goto out;
 	}
@@ -1239,7 +1224,7 @@ static int ntfs_fill_super(struct super_block *sb, void *data, int silent)
 	inode = ntfs_iget5(sb, &ref, &NAME_ROOT);
 	if (IS_ERR(inode)) {
 		err = PTR_ERR(inode);
-		ntfs_printk(sb, KERN_ERR "Failed to load root.");
+		ntfs_err(sb, "Failed to load root");
 		inode = NULL;
 		goto out;
 	}
-- 
2.26.0

