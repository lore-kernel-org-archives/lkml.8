Return-Path: <SRS0=Oudi=B7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.7 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BA687C433E1
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Aug 2020 22:16:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8E7F7207DF
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Aug 2020 22:16:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726977AbgHUWQ4 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 21 Aug 2020 18:16:56 -0400
Received: from smtprelay0014.hostedemail.com ([216.40.44.14]:41464 "EHLO
        smtprelay.hostedemail.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726870AbgHUWQu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Aug 2020 18:16:50 -0400
Received: from filter.hostedemail.com (clb03-v110.bra.tucows.net [216.40.38.60])
        by smtprelay08.hostedemail.com (Postfix) with ESMTP id ACFEB182CED2A;
        Fri, 21 Aug 2020 22:16:47 +0000 (UTC)
X-Session-Marker: 6A6F6540706572636865732E636F6D
X-HE-Tag: part96_4d155de2703c
X-Filterd-Recvd-Size: 18083
Received: from joe-laptop.perches.com (unknown [47.151.133.149])
        (Authenticated sender: joe@perches.com)
        by omf12.hostedemail.com (Postfix) with ESMTPA;
        Fri, 21 Aug 2020 22:16:46 +0000 (UTC)
From:   Joe Perches <joe@perches.com>
To:     Konstantin Komarov <almaz.alexandrovich@paragon-software.com>
Cc:     linux-kernel@vger.kernel.org
Subject: [PATCH 2/3] ntfs3: Rename logging macros and uses
Date:   Fri, 21 Aug 2020 15:16:39 -0700
Message-Id: <e75eabecdfa09cef53e47fea72bd3023731e9b65.1598047822.git.joe@perches.com>
X-Mailer: git-send-email 2.26.0
In-Reply-To: <cover.1598047822.git.joe@perches.com>
References: <cover.1598047822.git.joe@perches.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Rename the ntfs_warning and ntfs_error macros to the more common style of
ntfs_warn and ntfs_err.  _inode_ variants too.

Miscellanea:

o Realign arguments
o Fix a typo

Signed-off-by: Joe Perches <joe@perches.com>
---
 fs/ntfs3/debug.h   |  8 +++----
 fs/ntfs3/dir.c     | 22 +++++++++----------
 fs/ntfs3/file.c    | 27 ++++++++++-------------
 fs/ntfs3/frecord.c |  2 +-
 fs/ntfs3/fslog.c   |  4 ++--
 fs/ntfs3/fsntfs.c  | 23 ++++++++++---------
 fs/ntfs3/inode.c   | 14 ++++++------
 fs/ntfs3/ntfs_fs.h |  4 ++--
 fs/ntfs3/super.c   | 55 +++++++++++++++++++++-------------------------
 9 files changed, 73 insertions(+), 86 deletions(-)

diff --git a/fs/ntfs3/debug.h b/fs/ntfs3/debug.h
index b8f09f41508a..1ad0e8730745 100644
--- a/fs/ntfs3/debug.h
+++ b/fs/ntfs3/debug.h
@@ -33,16 +33,16 @@ void ntfs_inode_printk(struct inode *inode, const char *fmt, ...);
 
 #define ntfs_trace(sb, fmt, ...)					\
 	ntfs_printk(sb, KERN_NOTICE fmt, ##__VA_ARGS__)
-#define ntfs_error(sb, fmt, ...)					\
+#define ntfs_err(sb, fmt, ...)						\
 	ntfs_printk(sb, KERN_ERR fmt, ##__VA_ARGS__)
-#define ntfs_warning(sb, fmt, ...)					\
+#define ntfs_warn(sb, fmt, ...)					\
 	ntfs_printk(sb, KERN_WARNING fmt, ##__VA_ARGS__)
 
 #define ntfs_fs_error(sb, fmt, ...)					\
 	__ntfs_fs_error(sb, 1, fmt, ##__VA_ARGS__)
-#define ntfs_inode_error(inode, fmt, ...)				\
+#define ntfs_inode_err(inode, fmt, ...)					\
 	ntfs_inode_printk(inode, KERN_ERR fmt, ##__VA_ARGS__)
-#define ntfs_inode_warning(inode, fmt, ...)				\
+#define ntfs_inode_warn(inode, fmt, ...)				\
 	ntfs_inode_printk(inode, KERN_WARNING fmt, ##__VA_ARGS__)
 
 static inline void *ntfs_alloc(size_t size, int zero)
diff --git a/fs/ntfs3/dir.c b/fs/ntfs3/dir.c
index 5f1105f1283c..e174d7111719 100644
--- a/fs/ntfs3/dir.c
+++ b/fs/ntfs3/dir.c
@@ -34,9 +34,8 @@ int uni_to_x8(ntfs_sb_info *sbi, const struct le_str *uni, u8 *buf, int buf_len)
 		int charlen;
 
 		if (buf_len < NLS_MAX_CHARSET_SIZE) {
-			ntfs_warning(
-				sbi->sb,
-				"filename was truncated while converting.");
+			ntfs_warn(sbi->sb,
+				  "filename was truncated while converting");
 			break;
 		}
 
@@ -94,12 +93,12 @@ int x8_to_uni(ntfs_sb_info *sbi, const u8 *name, u32 name_len,
 
 		if (!warn) {
 			warn = 1;
-			ntfs_warning(
-				sbi->sb,
-				"%s -> unicode failed: '%.*s', pos %d, chars %x %x %x",
-				nls->charset, name_len, name, (int)(str - name),
-				str[0], tail > 1 ? str[1] : 0,
-				tail > 2 ? str[2] : 0);
+			ntfs_warn(sbi->sb,
+				  "%s -> unicode failed: '%.*s', pos %d, chars %x %x %x",
+				  nls->charset, name_len, name,
+				  (int)(str - name),
+				  str[0], tail > 1 ? str[1] : 0,
+				  tail > 2 ? str[2] : 0);
 		}
 
 		if (ret + 3 > max_ulen)
@@ -233,8 +232,7 @@ static inline int ntfs_filldir(ntfs_sb_info *sbi, ntfs_inode *ni,
 	name_len = uni_to_x8(sbi, (struct le_str *)&fname->name_len, name,
 			     PATH_MAX);
 	if (name_len <= 0) {
-		ntfs_warning(sbi->sb, "failed to convert name for inode %lx.",
-			     ino);
+		ntfs_warn(sbi->sb, "failed to convert name for inode %lx", ino);
 		return 0;
 	}
 
@@ -397,7 +395,7 @@ static int ntfs_readdir(struct file *file, struct dir_context *ctx)
 	goto next_vcn;
 
 fs_error:
-	ntfs_inode_error(dir, "Looks like your dir is corrupt");
+	ntfs_inode_err(dir, "Looks like your dir is corrupt");
 	err = -EINVAL;
 out:
 
diff --git a/fs/ntfs3/file.c b/fs/ntfs3/file.c
index e4f971d65586..271cc1dfc690 100644
--- a/fs/ntfs3/file.c
+++ b/fs/ntfs3/file.c
@@ -187,8 +187,8 @@ static int ntfs_extend_initialized_size(struct file *file, ntfs_inode *ni,
 
 out:
 	ni->i_valid = valid;
-	ntfs_inode_warning(inode, "failed to extend initialized size to %llx.",
-			   new_valid);
+	ntfs_inode_warn(inode, "failed to extend initialized size to %llx",
+			new_valid);
 	return err;
 }
 
@@ -294,9 +294,8 @@ static int ntfs_extend_initialized_size_cmpr(struct file *file, ntfs_inode *ni,
 
 out:
 	ni->i_valid = valid;
-	ntfs_inode_warning(
-		inode, "failed to extend initialized compressed size to %llx.",
-		new_valid);
+	ntfs_inode_warn(inode, "failed to extend initialized compressed size to %llx",
+			new_valid);
 	return err;
 }
 
@@ -337,9 +336,8 @@ void ntfs_sparse_cluster(struct inode *inode, struct page *page0, loff_t vbo,
 		    likely(!page_has_buffers(page))) {
 			create_empty_buffers(page, blocksize, 0);
 			if (!page_has_buffers(page)) {
-				ntfs_inode_error(
-					inode,
-					"failed to allocate page buffers.");
+				ntfs_inode_err(inode,
+					       "failed to allocate page buffers");
 				/*err = -ENOMEM;*/
 				goto unlock_page;
 			}
@@ -1059,26 +1057,23 @@ static ssize_t ntfs_file_write_iter(struct kiocb *iocb, struct iov_iter *from)
 	ntfs_inode *ni = ntfs_i(inode);
 
 	if (is_encrypted(ni)) {
-		ntfs_inode_warning(inode, "encrypted i/o not supported");
+		ntfs_inode_warn(inode, "encrypted i/o not supported");
 		return -EOPNOTSUPP;
 	}
 
 	if (is_compressed(ni) && (iocb->ki_flags & IOCB_DIRECT)) {
-		ntfs_inode_warning(inode,
-				   "direct i/o + compressed not supported");
+		ntfs_inode_warn(inode, "direct i/o + compressed not supported");
 		return -EOPNOTSUPP;
 	}
 
 	if (ni->ni_flags & NI_FLAG_COMPRESSED_MASK) {
-		ntfs_inode_warning(
-			inode,
-			"write into external compressed file not supported (temporary)");
+		ntfs_inode_warn(inode,
+				"write into external compressed file not supported (temporary)");
 		return -EOPNOTSUPP;
 	}
 
 	if (is_dedup(ni)) {
-		ntfs_inode_warning(inode,
-				   "write into deduplicated not supported");
+		ntfs_inode_warn(inode, "write into deduplicated not supported");
 		return -EOPNOTSUPP;
 	}
 
diff --git a/fs/ntfs3/frecord.c b/fs/ntfs3/frecord.c
index 918291e7f629..89a32832da19 100644
--- a/fs/ntfs3/frecord.c
+++ b/fs/ntfs3/frecord.c
@@ -2165,7 +2165,7 @@ int ni_write_inode(struct inode *inode, int sync, const char *hint)
 	ni_unlock(ni);
 
 	if (err) {
-		ntfs_error(sb, "%s r=%lx failed, %d.", hint, inode->i_ino, err);
+		ntfs_err(sb, "%s r=%lx failed, %d", hint, inode->i_ino, err);
 		ntfs_set_state(sbi, NTFS_DIRTY_ERROR);
 		return err;
 	}
diff --git a/fs/ntfs3/fslog.c b/fs/ntfs3/fslog.c
index 40a2bad0c858..598fc0742ba5 100644
--- a/fs/ntfs3/fslog.c
+++ b/fs/ntfs3/fslog.c
@@ -4094,8 +4094,8 @@ int log_replay(ntfs_inode *ni)
 	case 0x20000:
 		break;
 	default:
-		ntfs_warning(sbi->sb, "$LogFile version %d.%d is not supported",
-			     log->major_ver, log->minor_ver);
+		ntfs_warn(sbi->sb, "$LogFile version %d.%d is not supported",
+			  log->major_ver, log->minor_ver);
 		err = -EOPNOTSUPP;
 		log->set_dirty = true;
 		goto out;
diff --git a/fs/ntfs3/fsntfs.c b/fs/ntfs3/fsntfs.c
index 47d6498094df..12d8cf7f1725 100644
--- a/fs/ntfs3/fsntfs.c
+++ b/fs/ntfs3/fsntfs.c
@@ -182,7 +182,7 @@ int ntfs_extend_init(ntfs_sb_info *sbi)
 	inode = ntfs_iget5(sb, &ref, &NAME_EXTEND);
 	if (IS_ERR(inode)) {
 		err = PTR_ERR(inode);
-		ntfs_error(sbi->sb, "Failed to load $Extend.");
+		ntfs_err(sbi->sb, "Failed to load $Extend");
 		inode = NULL;
 		goto out;
 	}
@@ -245,7 +245,7 @@ int ntfs_loadlog_and_replay(ntfs_inode *ni, ntfs_sb_info *sbi)
 
 	/* Check for 4GB */
 	if (inode->i_size >= 0x100000000ull) {
-		ntfs_error(sb, "$LogFile is too big");
+		ntfs_err(sb, "$LogFile is too big");
 		err = -EINVAL;
 		goto out;
 	}
@@ -275,7 +275,7 @@ int ntfs_loadlog_and_replay(ntfs_inode *ni, ntfs_sb_info *sbi)
 
 	if (!inode) {
 		err = -EINVAL;
-		ntfs_error(sb, "Failed to load $MFT.");
+		ntfs_err(sb, "Failed to load $MFT");
 		goto out;
 	}
 
@@ -372,8 +372,8 @@ int ntfs_look_for_free_space(ntfs_sb_info *sbi, CLST lcn, CLST len,
 			zlen = wnd_zone_len(wnd);
 
 			if (!zlen) {
-				ntfs_error(sbi->sb,
-					   "no free space to extend mft");
+				ntfs_err(sbi->sb,
+					 "no free space to extend mft");
 				err = -ENOSPC;
 				goto out;
 			}
@@ -1065,8 +1065,8 @@ int ntfs_sb_write(struct super_block *sb, u64 lbo, size_t bytes,
 		if (op < blocksize) {
 			bh = __bread(bdev, block, blocksize);
 			if (!bh) {
-				ntfs_error(sb, "failed to read block %llx",
-					   (u64)block);
+				ntfs_err(sb, "failed to read block %llx",
+					 (u64)block);
 				return -EIO;
 			}
 		} else {
@@ -1094,10 +1094,9 @@ int ntfs_sb_write(struct super_block *sb, u64 lbo, size_t bytes,
 			int err = sync_dirty_buffer(bh);
 
 			if (err) {
-				ntfs_error(
-					sb,
-					"failed to sync buffer at block %llx, error %d",
-					(u64)block, err);
+				ntfs_err(sb,
+					 "failed to sync buffer at block %llx, error %d",
+					 (u64)block, err);
 				put_bh(bh);
 				return err;
 			}
@@ -1553,7 +1552,7 @@ int ntfs_security_init(ntfs_sb_info *sbi)
 	inode = ntfs_iget5(sb, &ref, &NAME_SECURE);
 	if (IS_ERR(inode)) {
 		err = PTR_ERR(inode);
-		ntfs_error(sbi->sb, "Failed to load $Secure.");
+		ntfs_err(sbi->sb, "Failed to load $Secure");
 		inode = NULL;
 		goto out;
 	}
diff --git a/fs/ntfs3/inode.c b/fs/ntfs3/inode.c
index e34c2f241cd6..ebfcb1420f5f 100644
--- a/fs/ntfs3/inode.c
+++ b/fs/ntfs3/inode.c
@@ -80,12 +80,12 @@ static struct inode *ntfs_read_mft(struct inode *inode,
 		;
 	else if (ref->seq != rec->seq) {
 		err = -EINVAL;
-		ntfs_error(sb, "MFT: r=%lx, expect seq=%x instead of %x!", ino,
-			   le16_to_cpu(ref->seq), le16_to_cpu(rec->seq));
+		ntfs_err(sb, "MFT: r=%lx, expect seq=%x instead of %x!",
+			 ino, le16_to_cpu(ref->seq), le16_to_cpu(rec->seq));
 		goto out;
 	} else if (!is_rec_inuse(rec)) {
 		err = -EINVAL;
-		ntfs_error(sb, "Inode r=%x is not in use!", (u32)ino);
+		ntfs_err(sb, "Inode r=%x is not in use!", (u32)ino);
 		goto out;
 	}
 
@@ -792,8 +792,8 @@ int ntfs_readpage(struct file *file, struct page *page)
 		if (PageLocked(page))
 			wait_on_page_bit(page, PG_locked);
 		if (PageError(page)) {
-			ntfs_inode_warning(inode, "file garbadge at 0x%llx",
-					   valid);
+			ntfs_inode_warn(inode, "file garbadge at 0x%llx",
+					valid);
 			goto out;
 		}
 		zero_user_segment(page, valid & (PAGE_SIZE - 1), PAGE_SIZE);
@@ -913,7 +913,7 @@ static ssize_t ntfs_direct_IO(struct kiocb *iocb, struct iov_iter *iter)
 out:
 	return ret;
 fix_error:
-	ntfs_inode_warning(inode, "file garbadge at 0x%llx", valid);
+	ntfs_inode_warn(inode, "file garbage at 0x%llx", valid);
 	goto out;
 }
 
@@ -1428,7 +1428,7 @@ int ntfs_create_inode(struct inode *dir, struct dentry *dentry,
 		nsize = ntfs_reparse_bytes(err);
 
 		if (nsize > sbi->reparse.max_size) {
-			ntfs_warning(sb, "Symbolic link %u is too big", size);
+			ntfs_warn(sb, "Symbolic link %u is too big", size);
 			err = -EFBIG;
 			goto out4;
 		}
diff --git a/fs/ntfs3/ntfs_fs.h b/fs/ntfs3/ntfs_fs.h
index 4609467e211c..340836822be4 100644
--- a/fs/ntfs3/ntfs_fs.h
+++ b/fs/ntfs3/ntfs_fs.h
@@ -857,8 +857,8 @@ static inline struct buffer_head *ntfs_bread(struct super_block *sb,
 	if (bh)
 		return bh;
 
-	ntfs_error(sb, "failed to read volume at offset 0x%llx",
-		   (u64)block << sb->s_blocksize_bits);
+	ntfs_err(sb, "failed to read volume at offset 0x%llx",
+		 (u64)block << sb->s_blocksize_bits);
 	return NULL;
 }
 
diff --git a/fs/ntfs3/super.c b/fs/ntfs3/super.c
index 3a8a0a6c2cb8..d72d06f4adbe 100644
--- a/fs/ntfs3/super.c
+++ b/fs/ntfs3/super.c
@@ -103,11 +103,11 @@ void __ntfs_fs_error(struct super_block *sb, int report, const char *fmt, ...)
 		va_start(args, fmt);
 		vaf.fmt = fmt;
 		vaf.va = &args;
-		ntfs_error(sb, "%pV", &vaf);
+		ntfs_err(sb, "%pV", &vaf);
 		va_end(args);
 	}
 	sb->s_flags |= SB_RDONLY;
-	ntfs_error(sb, "**** filesystem has been set read-only");
+	ntfs_err(sb, "**** filesystem has been set read-only");
 }
 
 /*
@@ -534,9 +534,8 @@ static int ntfs_init_from_boot(struct super_block *sb, u32 sector_size,
 	 * - Volume formatted 512 and mounted as 4K
 	 */
 	if (sbi->sector_size != sector_size) {
-		ntfs_warning(
-			sb,
-			"Different NTFS' sector size and media sector size");
+		ntfs_warn(sb,
+			  "Different NTFS' sector size and media sector size");
 		dev_size += sector_size - 1;
 	}
 
@@ -579,10 +578,9 @@ static int ntfs_init_from_boot(struct super_block *sb, u32 sector_size,
 		u32 mb0, gb0;
 
 		gb0 = format_size_gb(dev_size, &mb0);
-		ntfs_warning(
-			sb,
-			"RAW NTFS volume: Filesystem size %u.%02u Gb > volume size %u.%02u Gb. Mount in read-only",
-			gb, mb, gb0, mb0);
+		ntfs_warn(sb,
+			  "RAW NTFS volume: Filesystem size %u.%02u Gb > volume size %u.%02u Gb. Mount in read-only",
+			  gb, mb, gb0, mb0);
 		sb->s_flags |= SB_RDONLY;
 	}
 
@@ -775,10 +773,9 @@ static int ntfs_parse_options(struct super_block *sb, char *options, int silent,
 		/* unknown option */
 		default:
 			if (!silent)
-				ntfs_error(
-					sb,
-					"Unrecognized mount option \"%s\" or missing value",
-					p);
+				ntfs_err(sb,
+					 "Unrecognized mount option \"%s\" or missing value",
+					 p);
 			//return -EINVAL;
 		}
 	}
@@ -788,7 +785,7 @@ static int ntfs_parse_options(struct super_block *sb, char *options, int silent,
 		sbi->nls = load_nls(nls_name);
 		if (!sbi->nls) {
 			/* critical ?*/
-			ntfs_error(sb, "failed to load \"%s\"\n", nls_name);
+			ntfs_err(sb, "failed to load \"%s\"", nls_name);
 			//return -EINVAL;
 		}
 	}
@@ -797,7 +794,7 @@ static int ntfs_parse_options(struct super_block *sb, char *options, int silent,
 		sbi->nls = load_nls_default();
 		if (!sbi->nls) {
 			/* critical */
-			ntfs_error(sb, "failed to load default nls");
+			ntfs_err(sb, "failed to load default nls");
 			return -EINVAL;
 		}
 	}
@@ -892,7 +889,7 @@ static int ntfs_fill_super(struct super_block *sb, void *data, int silent)
 	inode = ntfs_iget5(sb, &ref, &NAME_VOLUME);
 	if (IS_ERR(inode)) {
 		err = PTR_ERR(inode);
-		ntfs_error(sb, "Failed to load $Volume.");
+		ntfs_err(sb, "Failed to load $Volume");
 		inode = NULL;
 		goto out;
 	}
@@ -942,7 +939,7 @@ static int ntfs_fill_super(struct super_block *sb, void *data, int silent)
 	inode = ntfs_iget5(sb, &ref, &NAME_MIRROR);
 	if (IS_ERR(inode)) {
 		err = PTR_ERR(inode);
-		ntfs_error(sb, "Failed to load $MFTMirr.");
+		ntfs_err(sb, "Failed to load $MFTMirr");
 		inode = NULL;
 		goto out;
 	}
@@ -958,7 +955,7 @@ static int ntfs_fill_super(struct super_block *sb, void *data, int silent)
 	inode = ntfs_iget5(sb, &ref, &NAME_LOGFILE);
 	if (IS_ERR(inode)) {
 		err = PTR_ERR(inode);
-		ntfs_error(sb, "Failed to load $LogFile.");
+		ntfs_err(sb, "Failed to load $LogFile");
 		inode = NULL;
 		goto out;
 	}
@@ -976,17 +973,15 @@ static int ntfs_fill_super(struct super_block *sb, void *data, int silent)
 
 	if (sbi->flags & NTFS_FLAGS_NEED_REPLAY) {
 		if (!is_ro) {
-			ntfs_warning(
-				sb,
-				"failed to replay log file. Can't mount rw!");
+			ntfs_warn(sb,
+				  "failed to replay log file. Can't mount rw!");
 			err = -EINVAL;
 			goto out;
 		}
 	} else if (sbi->volume.flags & VOLUME_FLAG_DIRTY) {
 		if (!is_ro && !sbi->options.force) {
-			ntfs_warning(
-				sb,
-				"volume is dirty and \"force\" flag is not set!");
+			ntfs_warn(sb,
+				  "volume is dirty and \"force\" flag is not set!");
 			err = -EINVAL;
 			goto out;
 		}
@@ -999,7 +994,7 @@ static int ntfs_fill_super(struct super_block *sb, void *data, int silent)
 	inode = ntfs_iget5(sb, &ref, &NAME_MFT);
 	if (IS_ERR(inode)) {
 		err = PTR_ERR(inode);
-		ntfs_error(sb, "Failed to load $MFT.");
+		ntfs_err(sb, "Failed to load $MFT");
 		inode = NULL;
 		goto out;
 	}
@@ -1026,7 +1021,7 @@ static int ntfs_fill_super(struct super_block *sb, void *data, int silent)
 	inode = ntfs_iget5(sb, &ref, &NAME_BADCLUS);
 	if (IS_ERR(inode)) {
 		err = PTR_ERR(inode);
-		ntfs_error(sb, "Failed to load $BadClus.");
+		ntfs_err(sb, "Failed to load $BadClus");
 		inode = NULL;
 		goto out;
 	}
@@ -1051,7 +1046,7 @@ static int ntfs_fill_super(struct super_block *sb, void *data, int silent)
 	inode = ntfs_iget5(sb, &ref, &NAME_BITMAP);
 	if (IS_ERR(inode)) {
 		err = PTR_ERR(inode);
-		ntfs_error(sbi->sb, "Failed to load $Bitmap.");
+		ntfs_err(sbi->sb, "Failed to load $Bitmap");
 		inode = NULL;
 		goto out;
 	}
@@ -1091,7 +1086,7 @@ static int ntfs_fill_super(struct super_block *sb, void *data, int silent)
 	inode = ntfs_iget5(sbi->sb, &ref, &NAME_ATTRDEF);
 	if (IS_ERR(inode)) {
 		err = PTR_ERR(inode);
-		ntfs_error(sbi->sb, "Failed to load $AttrDef -> %d", err);
+		ntfs_err(sbi->sb, "Failed to load $AttrDef -> %d", err);
 		inode = NULL;
 		goto out;
 	}
@@ -1151,7 +1146,7 @@ static int ntfs_fill_super(struct super_block *sb, void *data, int silent)
 	inode = ntfs_iget5(sb, &ref, &NAME_UPCASE);
 	if (IS_ERR(inode)) {
 		err = PTR_ERR(inode);
-		ntfs_error(sbi->sb, "Failed to load $LogFile.");
+		ntfs_err(sbi->sb, "Failed to load $LogFile");
 		inode = NULL;
 		goto out;
 	}
@@ -1237,7 +1232,7 @@ static int ntfs_fill_super(struct super_block *sb, void *data, int silent)
 	inode = ntfs_iget5(sb, &ref, &NAME_ROOT);
 	if (IS_ERR(inode)) {
 		err = PTR_ERR(inode);
-		ntfs_error(sb, "Failed to load root.");
+		ntfs_err(sb, "Failed to load root");
 		inode = NULL;
 		goto out;
 	}
-- 
2.26.0

