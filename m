Return-Path: <SRS0=NmTw=4N=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8FDFDC35DF9
	for <linux-kernel@archiver.kernel.org>; Tue, 25 Feb 2020 10:17:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6203821556
	for <linux-kernel@archiver.kernel.org>; Tue, 25 Feb 2020 10:17:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730122AbgBYKRa (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 25 Feb 2020 05:17:30 -0500
Received: from szxga07-in.huawei.com ([45.249.212.35]:53784 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1729129AbgBYKR3 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Feb 2020 05:17:29 -0500
Received: from DGGEMS401-HUB.china.huawei.com (unknown [172.30.72.60])
        by Forcepoint Email with ESMTP id 394B0841A307DA2C4BF4;
        Tue, 25 Feb 2020 18:17:26 +0800 (CST)
Received: from szvp000203569.huawei.com (10.120.216.130) by
 DGGEMS401-HUB.china.huawei.com (10.3.19.201) with Microsoft SMTP Server id
 14.3.439.0; Tue, 25 Feb 2020 18:17:19 +0800
From:   Chao Yu <yuchao0@huawei.com>
To:     <jaegeuk@kernel.org>
CC:     <linux-f2fs-devel@lists.sourceforge.net>,
        <linux-kernel@vger.kernel.org>, <chao@kernel.org>,
        Chao Yu <yuchao0@huawei.com>,
        Park Ju Hyung <qkrwngud825@gmail.com>
Subject: [PATCH v2] f2fs: use kmem_cache pool during inline xattr lookups
Date:   Tue, 25 Feb 2020 18:17:10 +0800
Message-ID: <20200225101710.40123-1-yuchao0@huawei.com>
X-Mailer: git-send-email 2.18.0.rc1
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.120.216.130]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

It's been observed that kzalloc() on lookup_all_xattrs() are called millions
of times on Android, quickly becoming the top abuser of slub memory allocator.

Use a dedicated kmem cache pool for xattr lookups to mitigate this.

Signed-off-by: Park Ju Hyung <qkrwngud825@gmail.com>
Signed-off-by: Chao Yu <yuchao0@huawei.com>
---
v2:
- avoid compile warning in f2fs_destroy_xattr_caches().
 fs/f2fs/f2fs.h  |  3 +++
 fs/f2fs/super.c | 10 ++++++++-
 fs/f2fs/xattr.c | 54 ++++++++++++++++++++++++++++++++++++++++++++-----
 fs/f2fs/xattr.h |  4 ++++
 4 files changed, 65 insertions(+), 6 deletions(-)

diff --git a/fs/f2fs/f2fs.h b/fs/f2fs/f2fs.h
index 12a197e89a3e..23b93a116c73 100644
--- a/fs/f2fs/f2fs.h
+++ b/fs/f2fs/f2fs.h
@@ -1486,6 +1486,9 @@ struct f2fs_sb_info {
 	__u32 s_chksum_seed;
 
 	struct workqueue_struct *post_read_wq;	/* post read workqueue */
+
+	struct kmem_cache *inline_xattr_slab;	/* inline xattr entry */
+	unsigned int inline_xattr_slab_size;	/* default inline xattr slab size */
 };
 
 struct f2fs_private_dio {
diff --git a/fs/f2fs/super.c b/fs/f2fs/super.c
index d241e07c0bfa..0b16204d3b7d 100644
--- a/fs/f2fs/super.c
+++ b/fs/f2fs/super.c
@@ -1201,6 +1201,7 @@ static void f2fs_put_super(struct super_block *sb)
 	kvfree(sbi->raw_super);
 
 	destroy_device_list(sbi);
+	f2fs_destroy_xattr_caches(sbi);
 	mempool_destroy(sbi->write_io_dummy);
 #ifdef CONFIG_QUOTA
 	for (i = 0; i < MAXQUOTAS; i++)
@@ -3457,12 +3458,17 @@ static int f2fs_fill_super(struct super_block *sb, void *data, int silent)
 		}
 	}
 
+	/* init per sbi slab cache */
+	err = f2fs_init_xattr_caches(sbi);
+	if (err)
+		goto free_io_dummy;
+
 	/* get an inode for meta space */
 	sbi->meta_inode = f2fs_iget(sb, F2FS_META_INO(sbi));
 	if (IS_ERR(sbi->meta_inode)) {
 		f2fs_err(sbi, "Failed to read F2FS meta data inode");
 		err = PTR_ERR(sbi->meta_inode);
-		goto free_io_dummy;
+		goto free_xattr_cache;
 	}
 
 	err = f2fs_get_valid_checkpoint(sbi);
@@ -3735,6 +3741,8 @@ static int f2fs_fill_super(struct super_block *sb, void *data, int silent)
 	make_bad_inode(sbi->meta_inode);
 	iput(sbi->meta_inode);
 	sbi->meta_inode = NULL;
+free_xattr_cache:
+	f2fs_destroy_xattr_caches(sbi);
 free_io_dummy:
 	mempool_destroy(sbi->write_io_dummy);
 free_percpu:
diff --git a/fs/f2fs/xattr.c b/fs/f2fs/xattr.c
index a3360a97e624..e46a10eb0e42 100644
--- a/fs/f2fs/xattr.c
+++ b/fs/f2fs/xattr.c
@@ -23,6 +23,25 @@
 #include "xattr.h"
 #include "segment.h"
 
+static void *xattr_alloc(struct f2fs_sb_info *sbi, int size, bool *is_inline)
+{
+	*is_inline = (size == sbi->inline_xattr_slab_size);
+
+	if (*is_inline)
+		return kmem_cache_zalloc(sbi->inline_xattr_slab, GFP_NOFS);
+
+	return f2fs_kzalloc(sbi, size, GFP_NOFS);
+}
+
+static void xattr_free(struct f2fs_sb_info *sbi, void *xattr_addr,
+							bool is_inline)
+{
+	if (is_inline)
+		kmem_cache_free(sbi->inline_xattr_slab, xattr_addr);
+	else
+		kvfree(xattr_addr);
+}
+
 static int f2fs_xattr_generic_get(const struct xattr_handler *handler,
 		struct dentry *unused, struct inode *inode,
 		const char *name, void *buffer, size_t size)
@@ -301,7 +320,8 @@ static int read_xattr_block(struct inode *inode, void *txattr_addr)
 static int lookup_all_xattrs(struct inode *inode, struct page *ipage,
 				unsigned int index, unsigned int len,
 				const char *name, struct f2fs_xattr_entry **xe,
-				void **base_addr, int *base_size)
+				void **base_addr, int *base_size,
+				bool *is_inline)
 {
 	void *cur_addr, *txattr_addr, *last_txattr_addr;
 	void *last_addr = NULL;
@@ -313,7 +333,7 @@ static int lookup_all_xattrs(struct inode *inode, struct page *ipage,
 		return -ENODATA;
 
 	*base_size = XATTR_SIZE(inode) + XATTR_PADDING_SIZE;
-	txattr_addr = f2fs_kzalloc(F2FS_I_SB(inode), *base_size, GFP_NOFS);
+	txattr_addr = xattr_alloc(F2FS_I_SB(inode), *base_size, is_inline);
 	if (!txattr_addr)
 		return -ENOMEM;
 
@@ -362,7 +382,7 @@ static int lookup_all_xattrs(struct inode *inode, struct page *ipage,
 	*base_addr = txattr_addr;
 	return 0;
 out:
-	kvfree(txattr_addr);
+	xattr_free(F2FS_I_SB(inode), txattr_addr, *is_inline);
 	return err;
 }
 
@@ -499,6 +519,7 @@ int f2fs_getxattr(struct inode *inode, int index, const char *name,
 	unsigned int size, len;
 	void *base_addr = NULL;
 	int base_size;
+	bool is_inline;
 
 	if (name == NULL)
 		return -EINVAL;
@@ -509,7 +530,7 @@ int f2fs_getxattr(struct inode *inode, int index, const char *name,
 
 	down_read(&F2FS_I(inode)->i_xattr_sem);
 	error = lookup_all_xattrs(inode, ipage, index, len, name,
-				&entry, &base_addr, &base_size);
+				&entry, &base_addr, &base_size, &is_inline);
 	up_read(&F2FS_I(inode)->i_xattr_sem);
 	if (error)
 		return error;
@@ -532,7 +553,7 @@ int f2fs_getxattr(struct inode *inode, int index, const char *name,
 	}
 	error = size;
 out:
-	kvfree(base_addr);
+	xattr_free(F2FS_I_SB(inode), base_addr, is_inline);
 	return error;
 }
 
@@ -767,3 +788,26 @@ int f2fs_setxattr(struct inode *inode, int index, const char *name,
 	f2fs_update_time(sbi, REQ_TIME);
 	return err;
 }
+
+int f2fs_init_xattr_caches(struct f2fs_sb_info *sbi)
+{
+	dev_t dev = sbi->sb->s_bdev->bd_dev;
+	char slab_name[32];
+
+	sprintf(slab_name, "f2fs_xattr_entry-%u:%u", MAJOR(dev), MINOR(dev));
+
+	sbi->inline_xattr_slab_size = F2FS_OPTION(sbi).inline_xattr_size *
+					sizeof(__le32) + XATTR_PADDING_SIZE;
+
+	sbi->inline_xattr_slab = f2fs_kmem_cache_create(slab_name,
+					sbi->inline_xattr_slab_size);
+	if (!sbi->inline_xattr_slab)
+		return -ENOMEM;
+
+	return 0;
+}
+
+void f2fs_destroy_xattr_caches(struct f2fs_sb_info *sbi)
+{
+	kmem_cache_destroy(sbi->inline_xattr_slab);
+}
diff --git a/fs/f2fs/xattr.h b/fs/f2fs/xattr.h
index 574beea46494..0153b4c9ef21 100644
--- a/fs/f2fs/xattr.h
+++ b/fs/f2fs/xattr.h
@@ -131,6 +131,8 @@ extern int f2fs_setxattr(struct inode *, int, const char *,
 extern int f2fs_getxattr(struct inode *, int, const char *, void *,
 						size_t, struct page *);
 extern ssize_t f2fs_listxattr(struct dentry *, char *, size_t);
+extern int f2fs_init_xattr_caches(struct f2fs_sb_info *);
+extern void f2fs_destroy_xattr_caches(struct f2fs_sb_info *);
 #else
 
 #define f2fs_xattr_handlers	NULL
@@ -151,6 +153,8 @@ static inline ssize_t f2fs_listxattr(struct dentry *dentry, char *buffer,
 {
 	return -EOPNOTSUPP;
 }
+static int f2fs_init_xattr_caches(struct f2fs_sb_info *sbi) { return 0; }
+static void f2fs_destroy_xattr_caches(struct f2fs_sb_info *sbi) { }
 #endif
 
 #ifdef CONFIG_F2FS_FS_SECURITY
-- 
2.18.0.rc1

