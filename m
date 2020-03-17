Return-Path: <SRS0=kRID=5C=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 08C0CC1975A
	for <linux-kernel@archiver.kernel.org>; Tue, 17 Mar 2020 23:44:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D0739206EC
	for <linux-kernel@archiver.kernel.org>; Tue, 17 Mar 2020 23:44:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727201AbgCQXoV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 17 Mar 2020 19:44:21 -0400
Received: from smtprelay0254.hostedemail.com ([216.40.44.254]:59092 "EHLO
        smtprelay.hostedemail.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726721AbgCQXoV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Mar 2020 19:44:21 -0400
Received: from filter.hostedemail.com (clb03-v110.bra.tucows.net [216.40.38.60])
        by smtprelay04.hostedemail.com (Postfix) with ESMTP id 1A290180A631E;
        Tue, 17 Mar 2020 23:44:20 +0000 (UTC)
X-Session-Marker: 6A6F6540706572636865732E636F6D
X-HE-Tag: silk39_5fef4fb1a8f52
X-Filterd-Recvd-Size: 7129
Received: from XPS-9350.home (unknown [47.151.143.254])
        (Authenticated sender: joe@perches.com)
        by omf19.hostedemail.com (Postfix) with ESMTPA;
        Tue, 17 Mar 2020 23:44:19 +0000 (UTC)
Message-ID: <12f7e30cabca4cb16989a65ab0fb69f8457d53b2.camel@perches.com>
Subject: [PATCH] exfat: Remove unnecessary newlines from logging
From:   Joe Perches <joe@perches.com>
To:     Namjae Jeon <namjae.jeon@samsung.com>,
        Sungjong Seo <sj1557.seo@samsung.com>
Cc:     linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Date:   Tue, 17 Mar 2020 16:42:30 -0700
Content-Type: text/plain; charset="ISO-8859-1"
User-Agent: Evolution 3.34.1-2 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

None of these message formats should end in a newline as
exfat_msg and its callers already appends messages with one.

Miscellanea:

o Remove unnecessary trailing periods from formats.

Signed-off-by: Joe Perches <joe@perches.com>
---
 fs/exfat/dir.c    | 4 ++--
 fs/exfat/fatent.c | 8 ++++----
 fs/exfat/file.c   | 2 +-
 fs/exfat/inode.c  | 6 +++---
 fs/exfat/misc.c   | 2 +-
 fs/exfat/nls.c    | 4 ++--
 fs/exfat/super.c  | 4 ++--
 7 files changed, 15 insertions(+), 15 deletions(-)

diff --git a/fs/exfat/dir.c b/fs/exfat/dir.c
index 4b91af..a213520 100644
--- a/fs/exfat/dir.c
+++ b/fs/exfat/dir.c
@@ -750,7 +750,7 @@ struct exfat_dentry *exfat_get_dentry(struct super_block *sb,
 	sector_t sec;
 
 	if (p_dir->dir == DIR_DELETED) {
-		exfat_msg(sb, KERN_ERR, "abnormal access to deleted dentry\n");
+		exfat_msg(sb, KERN_ERR, "abnormal access to deleted dentry");
 		return NULL;
 	}
 
@@ -853,7 +853,7 @@ struct exfat_entry_set_cache *exfat_get_dentry_set(struct super_block *sb,
 	struct buffer_head *bh;
 
 	if (p_dir->dir == DIR_DELETED) {
-		exfat_msg(sb, KERN_ERR, "access to deleted dentry\n");
+		exfat_msg(sb, KERN_ERR, "access to deleted dentry");
 		return NULL;
 	}
 
diff --git a/fs/exfat/fatent.c b/fs/exfat/fatent.c
index a855b17..dcf840 100644
--- a/fs/exfat/fatent.c
+++ b/fs/exfat/fatent.c
@@ -305,7 +305,7 @@ int exfat_zeroed_cluster(struct inode *dir, unsigned int clu)
 	return 0;
 
 release_bhs:
-	exfat_msg(sb, KERN_ERR, "failed zeroed sect %llu\n",
+	exfat_msg(sb, KERN_ERR, "failed zeroed sect %llu",
 		(unsigned long long)blknr);
 	for (i = 0; i < n; i++)
 		bforget(bhs[i]);
@@ -325,7 +325,7 @@ int exfat_alloc_cluster(struct inode *inode, unsigned int num_alloc,
 
 	if (unlikely(total_cnt < sbi->used_clusters)) {
 		exfat_fs_error_ratelimit(sb,
-			"%s: invalid used clusters(t:%u,u:%u)\n",
+			"%s: invalid used clusters(t:%u,u:%u)",
 			__func__, total_cnt, sbi->used_clusters);
 		return -EIO;
 	}
@@ -338,7 +338,7 @@ int exfat_alloc_cluster(struct inode *inode, unsigned int num_alloc,
 	if (hint_clu == EXFAT_EOF_CLUSTER) {
 		if (sbi->clu_srch_ptr < EXFAT_FIRST_CLUSTER) {
 			exfat_msg(sb, KERN_ERR,
-				"sbi->clu_srch_ptr is invalid (%u)\n",
+				"sbi->clu_srch_ptr is invalid (%u)",
 				sbi->clu_srch_ptr);
 			sbi->clu_srch_ptr = EXFAT_FIRST_CLUSTER;
 		}
@@ -350,7 +350,7 @@ int exfat_alloc_cluster(struct inode *inode, unsigned int num_alloc,
 
 	/* check cluster validation */
 	if (hint_clu < EXFAT_FIRST_CLUSTER && hint_clu >= sbi->num_clusters) {
-		exfat_msg(sb, KERN_ERR, "hint_cluster is invalid (%u)\n",
+		exfat_msg(sb, KERN_ERR, "hint_cluster is invalid (%u)",
 			hint_clu);
 		hint_clu = EXFAT_FIRST_CLUSTER;
 		if (p_chain->flags == ALLOC_NO_FAT_CHAIN) {
diff --git a/fs/exfat/file.c b/fs/exfat/file.c
index 483f68..146024 100644
--- a/fs/exfat/file.c
+++ b/fs/exfat/file.c
@@ -235,7 +235,7 @@ void exfat_truncate(struct inode *inode, loff_t size)
 		/*
 		 * Empty start_clu != ~0 (not allocated)
 		 */
-		exfat_fs_error(sb, "tried to truncate zeroed cluster.");
+		exfat_fs_error(sb, "tried to truncate zeroed cluster");
 		goto write_size;
 	}
 
diff --git a/fs/exfat/inode.c b/fs/exfat/inode.c
index 068874..a84819 100644
--- a/fs/exfat/inode.c
+++ b/fs/exfat/inode.c
@@ -181,7 +181,7 @@ static int exfat_map_cluster(struct inode *inode, unsigned int clu_offset,
 		/* allocate a cluster */
 		if (num_to_be_allocated < 1) {
 			/* Broken FAT (i_sze > allocated FAT) */
-			exfat_fs_error(sb, "broken FAT chain.");
+			exfat_fs_error(sb, "broken FAT chain");
 			return -EIO;
 		}
 
@@ -351,7 +351,7 @@ static int exfat_get_block(struct inode *inode, sector_t iblock,
 		err = exfat_map_new_buffer(ei, bh_result, pos);
 		if (err) {
 			exfat_fs_error(sb,
-					"requested for bmap out of range(pos : (%llu) > i_size_aligned(%llu)\n",
+					"requested for bmap out of range(pos : (%llu) > i_size_aligned(%llu)",
 					pos, ei->i_size_aligned);
 			goto unlock_ret;
 		}
@@ -428,7 +428,7 @@ static int exfat_write_end(struct file *file, struct address_space *mapping,
 
 	if (EXFAT_I(inode)->i_size_aligned < i_size_read(inode)) {
 		exfat_fs_error(inode->i_sb,
-			"invalid size(size(%llu) > aligned(%llu)\n",
+			"invalid size(size(%llu) > aligned(%llu)",
 			i_size_read(inode), EXFAT_I(inode)->i_size_aligned);
 		return -EIO;
 	}
diff --git a/fs/exfat/misc.c b/fs/exfat/misc.c
index 14a330..d480b5a 100644
--- a/fs/exfat/misc.c
+++ b/fs/exfat/misc.c
@@ -32,7 +32,7 @@ void __exfat_fs_error(struct super_block *sb, int report, const char *fmt, ...)
 		va_start(args, fmt);
 		vaf.fmt = fmt;
 		vaf.va = &args;
-		exfat_msg(sb, KERN_ERR, "error, %pV\n", &vaf);
+		exfat_msg(sb, KERN_ERR, "error, %pV", &vaf);
 		va_end(args);
 	}
 
diff --git a/fs/exfat/nls.c b/fs/exfat/nls.c
index 6d1c3a..9e07e1 100644
--- a/fs/exfat/nls.c
+++ b/fs/exfat/nls.c
@@ -688,7 +688,7 @@ static int exfat_load_upcase_table(struct super_block *sb,
 		bh = sb_bread(sb, sector);
 		if (!bh) {
 			exfat_msg(sb, KERN_ERR,
-				"failed to read sector(0x%llx)\n",
+				"failed to read sector(0x%llx)",
 				(unsigned long long)sector);
 			ret = -EIO;
 			goto free_table;
@@ -723,7 +723,7 @@ static int exfat_load_upcase_table(struct super_block *sb,
 		return 0;
 
 	exfat_msg(sb, KERN_ERR,
-			"failed to load upcase table (idx : 0x%08x, chksum : 0x%08x, utbl_chksum : 0x%08x)\n",
+			"failed to load upcase table (idx : 0x%08x, chksum : 0x%08x, utbl_chksum : 0x%08x)",
 			index, checksum, utbl_checksum);
 	ret = -EINVAL;
 free_table:
diff --git a/fs/exfat/super.c b/fs/exfat/super.c
index 16ed202e..3e3c606 100644
--- a/fs/exfat/super.c
+++ b/fs/exfat/super.c
@@ -573,7 +573,7 @@ static int exfat_fill_super(struct super_block *sb, struct fs_context *fc)
 
 	root_inode = new_inode(sb);
 	if (!root_inode) {
-		exfat_msg(sb, KERN_ERR, "failed to allocate root inode.");
+		exfat_msg(sb, KERN_ERR, "failed to allocate root inode");
 		err = -ENOMEM;
 		goto free_table;
 	}
@@ -582,7 +582,7 @@ static int exfat_fill_super(struct super_block *sb, struct fs_context *fc)
 	inode_set_iversion(root_inode, 1);
 	err = exfat_read_root(root_inode);
 	if (err) {
-		exfat_msg(sb, KERN_ERR, "failed to initialize root inode.");
+		exfat_msg(sb, KERN_ERR, "failed to initialize root inode");
 		goto put_inode;
 	}
 

