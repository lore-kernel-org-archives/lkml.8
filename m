Return-Path: <SRS0=g5yc=BI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.0 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AEEBBC433DF
	for <linux-kernel@archiver.kernel.org>; Wed, 29 Jul 2020 03:27:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8A44220714
	for <linux-kernel@archiver.kernel.org>; Wed, 29 Jul 2020 03:27:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726862AbgG2D1A (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 28 Jul 2020 23:27:00 -0400
Received: from smtpout.cincibell.syn-alias.com ([64.8.71.14]:29708 "EHLO
        smtp.fuse.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726820AbgG2D07 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Jul 2020 23:26:59 -0400
X-Greylist: delayed 1201 seconds by postgrey-1.27 at vger.kernel.org; Tue, 28 Jul 2020 23:26:58 EDT
X_CMAE_Category: , ,
X-CNFS-Analysis: v=2.3 cv=auTM9hRV c=1 sm=1 tr=0 a=DpjRPou7YFguvYe1QozIfA==:117 a=DpjRPou7YFguvYe1QozIfA==:17 a=KGjhK52YXX0A:10 a=_RQrkK6FrEwA:10 a=bLztB8koN2gA:10 a=D8kloWStAAAA:8 a=JpqZlOa9nmrr5y5q09YA:9 a=lToRegeunbQ_6iXc:21 a=GPCyfixGGpL8Pf8g:21 a=o-EAUcH4Qu12IBblF9Ex:22
X-CM-Score: 0
X-Scanned-by: Cloudmark Authority Engine
X-Authed-Username: Y2thbmVAY29sZW1hbmthbmUub3Jn
X_CMAE_Category: , ,
X-CNFS-Analysis: 
X-CM-Score: 
X-Scanned-by: Cloudmark Authority Engine
Received: from [216.196.174.247] ([216.196.174.247:18901] helo=mail.colemankane.org)
        by smtpout.cincibell.syn-alias.com (envelope-from <ckane@colemankane.org>)
        (ecelerity 3.6.25.56547 r(Core:3.6.25.0)) with ESMTP
        id 52/25-30032-0D7E02F5; Tue, 28 Jul 2020 23:06:57 -0400
Received: by mail.colemankane.org (Postfix, from userid 58)
        id B0A2C135; Tue, 28 Jul 2020 23:06:56 -0400 (EDT)
Received: from localhost (unknown [172.20.1.71])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.colemankane.org (Postfix) with ESMTPSA id 65704133;
        Tue, 28 Jul 2020 23:06:53 -0400 (EDT)
From:   Coleman Kane <ckane@colemankane.org>
To:     OGAWA Hirofumi <hirofumi@mail.parknet.co.jp>
Cc:     linux-kernel@vger.kernel.org, Coleman Kane <ckane@colemankane.org>
Subject: [PATCH] fat: Add newline after declarations
Date:   Tue, 28 Jul 2020 23:05:14 -0400
Message-Id: <20200729030514.269070-1-ckane@colemankane.org>
X-Mailer: git-send-email 2.27.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add a newline after declarations in muliple places within the fat driver
where checkpatch.pl identified this problem.

Signed-off-by: Coleman Kane <ckane@colemankane.org>
---
 fs/fat/cache.c       |  1 +
 fs/fat/dir.c         |  6 ++++++
 fs/fat/fatent.c      |  8 ++++++++
 fs/fat/file.c        |  2 ++
 fs/fat/inode.c       | 14 ++++++++++++++
 fs/fat/misc.c        |  2 ++
 fs/fat/namei_msdos.c |  1 +
 fs/fat/namei_vfat.c  |  4 ++++
 fs/fat/nfs.c         |  3 +++
 9 files changed, 41 insertions(+)

diff --git a/fs/fat/cache.c b/fs/fat/cache.c
index 738e427e2d21..8031e5ca15d1 100644
--- a/fs/fat/cache.c
+++ b/fs/fat/cache.c
@@ -167,6 +167,7 @@ static void fat_cache_add(struct inode *inode, struct fat_cache_id *new)
 			cache = tmp;
 		} else {
 			struct list_head *p = MSDOS_I(inode)->cache_lru.prev;
+
 			cache = list_entry(p, struct fat_cache, cache_list);
 		}
 		cache->fcluster = new->fcluster;
diff --git a/fs/fat/dir.c b/fs/fat/dir.c
index b4ddf48fa444..50b8b88d68c7 100644
--- a/fs/fat/dir.c
+++ b/fs/fat/dir.c
@@ -182,6 +182,7 @@ static inline int fat_uni_to_x8(struct super_block *sb, const wchar_t *uni,
 				unsigned char *buf, int size)
 {
 	struct msdos_sb_info *sbi = MSDOS_SB(sb);
+
 	if (sbi->options.utf8)
 		return utf16s_to_utf8s(uni, FAT_MAX_UNI_CHARS,
 				UTF16_HOST_ENDIAN, buf, size);
@@ -431,6 +432,7 @@ static int fat_parse_short(struct super_block *sb,
 			uni_len = j;
 			if (isvfat) {
 				int offset = min(chl, MSDOS_NAME-k);
+
 				k += offset;
 				i += offset;
 			} else {
@@ -669,6 +671,7 @@ static int __fat_readdir(struct inode *inode, struct file *file,
 		unsigned long inum;
 		loff_t i_pos = fat_make_i_pos(sb, bh, de);
 		struct inode *tmp = fat_iget(sb, i_pos);
+
 		if (tmp) {
 			inum = tmp->i_ino;
 			iput(tmp);
@@ -1343,6 +1346,7 @@ int fat_add_entries(struct inode *dir, void *slots, int nr_slots,
 		/* Fill the long name slots. */
 		for (i = 0; i < long_bhs; i++) {
 			int copy = min_t(int, sb->s_blocksize - offset, size);
+
 			memcpy(bhs[i]->b_data + offset, slots, copy);
 			mark_buffer_dirty_inode(bhs[i], dir);
 			offset = 0;
@@ -1353,7 +1357,9 @@ int fat_add_entries(struct inode *dir, void *slots, int nr_slots,
 			err = fat_sync_bhs(bhs, long_bhs);
 		if (!err && i < nr_bhs) {
 			/* Fill the short name slot. */
+
 			int copy = min_t(int, sb->s_blocksize - offset, size);
+
 			memcpy(bhs[i]->b_data + offset, slots, copy);
 			mark_buffer_dirty_inode(bhs[i], dir);
 			if (IS_DIRSYNC(dir))
diff --git a/fs/fat/fatent.c b/fs/fat/fatent.c
index bbfe18c07417..872550ffbc9b 100644
--- a/fs/fat/fatent.c
+++ b/fs/fat/fatent.c
@@ -24,6 +24,7 @@ static void fat12_ent_blocknr(struct super_block *sb, int entry,
 {
 	struct msdos_sb_info *sbi = MSDOS_SB(sb);
 	int bytes = entry + (entry >> 1);
+
 	WARN_ON(!fat_valid_entry(sbi, entry));
 	*offset = bytes & (sb->s_blocksize - 1);
 	*blocknr = sbi->fat_start + (bytes >> sb->s_blocksize_bits);
@@ -34,6 +35,7 @@ static void fat_ent_blocknr(struct super_block *sb, int entry,
 {
 	struct msdos_sb_info *sbi = MSDOS_SB(sb);
 	int bytes = (entry << sbi->fatent_shift);
+
 	WARN_ON(!fat_valid_entry(sbi, entry));
 	*offset = bytes & (sb->s_blocksize - 1);
 	*blocknr = sbi->fat_start + (bytes >> sb->s_blocksize_bits);
@@ -42,6 +44,7 @@ static void fat_ent_blocknr(struct super_block *sb, int entry,
 static void fat12_ent_set_ptr(struct fat_entry *fatent, int offset)
 {
 	struct buffer_head **bhs = fatent->bhs;
+
 	if (fatent->nr_bhs == 1) {
 		WARN_ON(offset >= (bhs[0]->b_size - 1));
 		fatent->u.ent12_p[0] = bhs[0]->b_data + offset;
@@ -136,6 +139,7 @@ static int fat12_ent_get(struct fat_entry *fatent)
 static int fat16_ent_get(struct fat_entry *fatent)
 {
 	int next = le16_to_cpu(*fatent->u.ent16_p);
+
 	WARN_ON((unsigned long)fatent->u.ent16_p & (2 - 1));
 	if (next >= BAD_FAT16)
 		next = FAT_ENT_EOF;
@@ -145,6 +149,7 @@ static int fat16_ent_get(struct fat_entry *fatent)
 static int fat32_ent_get(struct fat_entry *fatent)
 {
 	int next = le32_to_cpu(*fatent->u.ent32_p) & 0x0fffffff;
+
 	WARN_ON((unsigned long)fatent->u.ent32_p & (4 - 1));
 	if (next >= BAD_FAT32)
 		next = FAT_ENT_EOF;
@@ -226,6 +231,7 @@ static int fat12_ent_next(struct fat_entry *fatent)
 static int fat16_ent_next(struct fat_entry *fatent)
 {
 	const struct buffer_head *bh = fatent->bhs[0];
+
 	fatent->entry++;
 	if (fatent->u.ent16_p < (__le16 *)(bh->b_data + (bh->b_size - 2))) {
 		fatent->u.ent16_p++;
@@ -238,6 +244,7 @@ static int fat16_ent_next(struct fat_entry *fatent)
 static int fat32_ent_next(struct fat_entry *fatent)
 {
 	const struct buffer_head *bh = fatent->bhs[0];
+
 	fatent->entry++;
 	if (fatent->u.ent32_p < (__le32 *)(bh->b_data + (bh->b_size - 4))) {
 		fatent->u.ent32_p++;
@@ -750,6 +757,7 @@ int fat_count_free_clusters(struct super_block *sb)
 static int fat_trim_clusters(struct super_block *sb, u32 clus, u32 nr_clus)
 {
 	struct msdos_sb_info *sbi = MSDOS_SB(sb);
+
 	return sb_issue_discard(sb, fat_clus_to_blknr(sbi, clus),
 				nr_clus * sbi->sec_per_clus, GFP_NOFS, 0);
 }
diff --git a/fs/fat/file.c b/fs/fat/file.c
index 42134c58c87e..a78da5fa5732 100644
--- a/fs/fat/file.c
+++ b/fs/fat/file.c
@@ -119,6 +119,7 @@ static int fat_ioctl_set_attributes(struct file *file, u32 __user *user_attr)
 static int fat_ioctl_get_volume_id(struct inode *inode, u32 __user *user_attr)
 {
 	struct msdos_sb_info *sbi = MSDOS_SB(inode->i_sb);
+
 	return put_user(sbi->vol_id, user_attr);
 }
 
@@ -398,6 +399,7 @@ int fat_getattr(const struct path *path, struct kstat *stat,
 		u32 request_mask, unsigned int flags)
 {
 	struct inode *inode = d_inode(path->dentry);
+
 	generic_fillattr(inode, stat);
 	stat->blksize = MSDOS_SB(inode->i_sb)->cluster_size;
 
diff --git a/fs/fat/inode.c b/fs/fat/inode.c
index a0cf99debb1e..4202944a1bc0 100644
--- a/fs/fat/inode.c
+++ b/fs/fat/inode.c
@@ -246,6 +246,7 @@ static int fat_write_end(struct file *file, struct address_space *mapping,
 {
 	struct inode *inode = mapping->host;
 	int err;
+
 	err = generic_write_end(file, mapping, pos, len, copied, pagep, fsdata);
 	if (err < len)
 		fat_write_failed(mapping, pos + len);
@@ -277,6 +278,7 @@ static ssize_t fat_direct_IO(struct kiocb *iocb, struct iov_iter *iter)
 		 * Return 0, and fallback to normal buffered write.
 		 */
 		loff_t size = offset + count;
+
 		if (MSDOS_I(inode)->mmu_private < size)
 			return 0;
 	}
@@ -421,6 +423,7 @@ void fat_attach(struct inode *inode, loff_t i_pos)
 	 */
 	if (S_ISDIR(inode->i_mode) && sbi->options.nfs) {
 		struct hlist_head *d_head = sbi->dir_hashtable;
+
 		d_head += fat_dir_hash(MSDOS_I(inode)->i_logstart);
 
 		spin_lock(&sbi->dir_hash_lock);
@@ -433,6 +436,7 @@ EXPORT_SYMBOL_GPL(fat_attach);
 void fat_detach(struct inode *inode)
 {
 	struct msdos_sb_info *sbi = MSDOS_SB(inode->i_sb);
+
 	spin_lock(&sbi->inode_hash_lock);
 	MSDOS_I(inode)->i_pos = 0;
 	hlist_del_init(&MSDOS_I(inode)->i_fat_hash);
@@ -721,6 +725,7 @@ static void fat_reset_iocharset(struct fat_mount_options *opts)
 static void delayed_free(struct rcu_head *p)
 {
 	struct msdos_sb_info *sbi = container_of(p, struct msdos_sb_info, rcu);
+
 	unload_nls(sbi->nls_disk);
 	unload_nls(sbi->nls_io);
 	fat_reset_iocharset(&sbi->options);
@@ -744,6 +749,7 @@ static struct kmem_cache *fat_inode_cachep;
 static struct inode *fat_alloc_inode(struct super_block *sb)
 {
 	struct msdos_inode_info *ei;
+
 	ei = kmem_cache_alloc(fat_inode_cachep, GFP_NOFS);
 	if (!ei)
 		return NULL;
@@ -803,6 +809,7 @@ static int fat_remount(struct super_block *sb, int *flags, char *data)
 {
 	bool new_rdonly;
 	struct msdos_sb_info *sbi = MSDOS_SB(sb);
+
 	*flags |= SB_NODIRATIME | (sbi->options.isvfat ? 0 : SB_NOATIME);
 
 	sync_filesystem(sb);
@@ -827,6 +834,7 @@ static int fat_statfs(struct dentry *dentry, struct kstatfs *buf)
 	/* If the count of free cluster is still unknown, counts it here. */
 	if (sbi->free_clusters == -1 || !sbi->free_clus_valid) {
 		int err = fat_count_free_clusters(dentry->d_sb);
+
 		if (err)
 			return err;
 	}
@@ -887,6 +895,7 @@ static int __fat_write_inode(struct inode *inode, int wait)
 			  &raw_entry->date, NULL);
 	if (sbi->options.isvfat) {
 		__le16 atime;
+
 		fat_time_unix2fat(sbi, &inode->i_ctime, &raw_entry->ctime,
 				  &raw_entry->cdate, &raw_entry->ctime_cs);
 		fat_time_unix2fat(sbi, &inode->i_atime, &atime,
@@ -1164,6 +1173,7 @@ static int parse_options(struct super_block *sb, char *options, int is_vfat,
 
 	while ((p = strsep(&options, ",")) != NULL) {
 		int token;
+
 		if (!*p)
 			continue;
 
@@ -1422,6 +1432,7 @@ static unsigned long calc_fat_clusters(struct super_block *sb)
 	/* Divide first to avoid overflow */
 	if (!is_fat12(sbi)) {
 		unsigned long ent_per_sec = sb->s_blocksize * 8 / sbi->fat_bits;
+
 		return ent_per_sec * sbi->fat_length;
 	}
 
@@ -1876,6 +1887,7 @@ int fat_fill_super(struct super_block *sb, void *data, int silent, int isvfat,
 
 	if (sbi->options.discard) {
 		struct request_queue *q = bdev_get_queue(sb->s_bdev);
+
 		if (!blk_queue_discard(q))
 			fat_msg(sb, KERN_WARNING,
 					"mounting with \"discard\" option, but "
@@ -1937,6 +1949,7 @@ static int writeback_inode(struct inode *inode)
 int fat_flush_inodes(struct super_block *sb, struct inode *i1, struct inode *i2)
 {
 	int ret = 0;
+
 	if (!MSDOS_SB(sb)->options.flush)
 		return 0;
 	if (i1)
@@ -1945,6 +1958,7 @@ int fat_flush_inodes(struct super_block *sb, struct inode *i1, struct inode *i2)
 		ret = writeback_inode(i2);
 	if (!ret) {
 		struct address_space *mapping = sb->s_bdev->bd_inode->i_mapping;
+
 		ret = filemap_flush(mapping);
 	}
 	return ret;
diff --git a/fs/fat/misc.c b/fs/fat/misc.c
index f1b2a1fc2a6a..8fa964bcca55 100644
--- a/fs/fat/misc.c
+++ b/fs/fat/misc.c
@@ -127,6 +127,7 @@ int fat_chain_add(struct inode *inode, int new_dclus, int nr_cluster)
 		ret = fat_ent_read(inode, &fatent, last);
 		if (ret >= 0) {
 			int wait = inode_needs_sync(inode);
+
 			ret = fat_ent_write(inode, &fatent, new_dclus, wait);
 			fatent_brelse(&fatent);
 		}
@@ -235,6 +236,7 @@ void fat_time_unix2fat(struct msdos_sb_info *sbi, struct timespec64 *ts,
 		       __le16 *time, __le16 *date, u8 *time_cs)
 {
 	struct tm tm;
+
 	time64_to_tm(ts->tv_sec, -fat_tz_offset(sbi), &tm);
 
 	/*  FAT can only support year between 1980 to 2107 */
diff --git a/fs/fat/namei_msdos.c b/fs/fat/namei_msdos.c
index 9d062886fbc1..90c1d4fbe57c 100644
--- a/fs/fat/namei_msdos.c
+++ b/fs/fat/namei_msdos.c
@@ -580,6 +580,7 @@ static int do_msdos_rename(struct inode *old_dir, unsigned char *old_name,
 		 * shouldn't be serious corruption.
 		 */
 		int err2 = fat_remove_entries(new_dir, &sinfo);
+
 		if (corrupt)
 			corrupt |= err2;
 		sinfo.bh = NULL;
diff --git a/fs/fat/namei_vfat.c b/fs/fat/namei_vfat.c
index 0cdd0fb9f742..9c315b3acff7 100644
--- a/fs/fat/namei_vfat.c
+++ b/fs/fat/namei_vfat.c
@@ -46,6 +46,7 @@ static inline void vfat_d_version_set(struct dentry *dentry,
 static int vfat_revalidate_shortname(struct dentry *dentry)
 {
 	int ret = 1;
+
 	spin_lock(&dentry->d_lock);
 	if (!inode_eq_iversion(d_inode(dentry->d_parent), vfat_d_version(dentry)))
 		ret = 0;
@@ -237,6 +238,7 @@ static int vfat_find_form(struct inode *dir, unsigned char *name)
 {
 	struct fat_slot_info sinfo;
 	int err = fat_scan(dir, name, &sinfo);
+
 	if (err)
 		return -ENOENT;
 	brelse(sinfo.bh);
@@ -693,6 +695,7 @@ static int vfat_find(struct inode *dir, const struct qstr *qname,
 		     struct fat_slot_info *sinfo)
 {
 	unsigned int len = vfat_striptail_len(qname);
+
 	if (len == 0)
 		return -ENOENT;
 	return fat_search_long(dir, qname->name, len, sinfo);
@@ -1012,6 +1015,7 @@ static int vfat_rename(struct inode *old_dir, struct dentry *old_dentry,
 		 * shouldn't be serious corruption.
 		 */
 		int err2 = fat_remove_entries(new_dir, &sinfo);
+
 		if (corrupt)
 			corrupt |= err2;
 		sinfo.bh = NULL;
diff --git a/fs/fat/nfs.c b/fs/fat/nfs.c
index af191371c352..ed1288849dc8 100644
--- a/fs/fat/nfs.c
+++ b/fs/fat/nfs.c
@@ -67,6 +67,7 @@ static struct inode *__fat_nfs_get_inode(struct super_block *sb,
 		struct msdos_dir_entry *de ;
 		sector_t blocknr;
 		int offset;
+
 		fat_get_blknr_offset(MSDOS_SB(sb), i_pos, &blocknr, &offset);
 		bh = sb_bread(sb, blocknr);
 		if (!bh) {
@@ -221,6 +222,7 @@ struct inode *fat_rebuild_parent(struct super_block *sb, int parent_logstart)
 	struct msdos_sb_info *sbi = MSDOS_SB(sb);
 	sector_t blknr = fat_clus_to_blknr(sbi, parent_logstart);
 	struct buffer_head *parent_bh = sb_bread(sb, blknr);
+
 	if (!parent_bh) {
 		fat_msg(sb, KERN_ERR,
 			"unable to read cluster of parent directory");
@@ -269,6 +271,7 @@ static struct dentry *fat_get_parent(struct dentry *child_dir)
 
 	if (!fat_get_dotdot_entry(d_inode(child_dir), &bh, &de)) {
 		int parent_logstart = fat_get_start(sbi, de);
+
 		parent_inode = fat_dget(sb, parent_logstart);
 		if (!parent_inode && sbi->options.nfs == FAT_NFS_NOSTALE_RO)
 			parent_inode = fat_rebuild_parent(sb, parent_logstart);
-- 
2.27.0

