Return-Path: <SRS0=3e5Q=77=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BE8ABC433E0
	for <linux-kernel@archiver.kernel.org>; Thu, 18 Jun 2020 06:36:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A7D2121852
	for <linux-kernel@archiver.kernel.org>; Thu, 18 Jun 2020 06:36:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727889AbgFRGgq (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 18 Jun 2020 02:36:46 -0400
Received: from szxga04-in.huawei.com ([45.249.212.190]:6359 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726940AbgFRGgo (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 18 Jun 2020 02:36:44 -0400
Received: from DGGEMS410-HUB.china.huawei.com (unknown [172.30.72.60])
        by Forcepoint Email with ESMTP id 798B494F5464E55442C0;
        Thu, 18 Jun 2020 14:36:40 +0800 (CST)
Received: from szvp000203569.huawei.com (10.120.216.130) by
 DGGEMS410-HUB.china.huawei.com (10.3.19.210) with Microsoft SMTP Server id
 14.3.487.0; Thu, 18 Jun 2020 14:36:30 +0800
From:   Chao Yu <yuchao0@huawei.com>
To:     <jaegeuk@kernel.org>
CC:     <linux-f2fs-devel@lists.sourceforge.net>,
        <linux-kernel@vger.kernel.org>, <chao@kernel.org>,
        Chao Yu <yuchao0@huawei.com>
Subject: [PATCH 1/5] f2fs: fix to wait page writeback before update
Date:   Thu, 18 Jun 2020 14:36:21 +0800
Message-ID: <20200618063625.110273-1-yuchao0@huawei.com>
X-Mailer: git-send-email 2.18.0.rc1
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.120.216.130]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

to make page content stable for special device like raid.

Signed-off-by: Chao Yu <yuchao0@huawei.com>
---
 fs/f2fs/dir.c          |  2 ++
 fs/f2fs/extent_cache.c | 18 +++++++++---------
 fs/f2fs/f2fs.h         |  2 +-
 fs/f2fs/file.c         |  1 +
 fs/f2fs/inline.c       |  2 ++
 fs/f2fs/inode.c        |  3 +--
 6 files changed, 16 insertions(+), 12 deletions(-)

diff --git a/fs/f2fs/dir.c b/fs/f2fs/dir.c
index d35976785e8c..91e86747a604 100644
--- a/fs/f2fs/dir.c
+++ b/fs/f2fs/dir.c
@@ -495,6 +495,8 @@ static int make_empty_dir(struct inode *inode,
 	if (IS_ERR(dentry_page))
 		return PTR_ERR(dentry_page);
 
+	f2fs_bug_on(F2FS_I_SB(inode), PageWriteback(dentry_page));
+
 	dentry_blk = page_address(dentry_page);
 
 	make_dentry_ptr_block(NULL, &d, dentry_blk);
diff --git a/fs/f2fs/extent_cache.c b/fs/f2fs/extent_cache.c
index e60078460ad1..686c68b98610 100644
--- a/fs/f2fs/extent_cache.c
+++ b/fs/f2fs/extent_cache.c
@@ -325,9 +325,10 @@ static void __drop_largest_extent(struct extent_tree *et,
 }
 
 /* return true, if inode page is changed */
-static bool __f2fs_init_extent_tree(struct inode *inode, struct f2fs_extent *i_ext)
+static void __f2fs_init_extent_tree(struct inode *inode, struct page *ipage)
 {
 	struct f2fs_sb_info *sbi = F2FS_I_SB(inode);
+	struct f2fs_extent *i_ext = ipage ? &F2FS_INODE(ipage)->i_ext : NULL;
 	struct extent_tree *et;
 	struct extent_node *en;
 	struct extent_info ei;
@@ -335,16 +336,18 @@ static bool __f2fs_init_extent_tree(struct inode *inode, struct f2fs_extent *i_e
 	if (!f2fs_may_extent_tree(inode)) {
 		/* drop largest extent */
 		if (i_ext && i_ext->len) {
+			f2fs_wait_on_page_writeback(ipage, NODE, true, true);
 			i_ext->len = 0;
-			return true;
+			set_page_dirty(ipage);
+			return;
 		}
-		return false;
+		return;
 	}
 
 	et = __grab_extent_tree(inode);
 
 	if (!i_ext || !i_ext->len)
-		return false;
+		return;
 
 	get_extent_info(&ei, i_ext);
 
@@ -360,17 +363,14 @@ static bool __f2fs_init_extent_tree(struct inode *inode, struct f2fs_extent *i_e
 	}
 out:
 	write_unlock(&et->lock);
-	return false;
 }
 
-bool f2fs_init_extent_tree(struct inode *inode, struct f2fs_extent *i_ext)
+void f2fs_init_extent_tree(struct inode *inode, struct page *ipage)
 {
-	bool ret =  __f2fs_init_extent_tree(inode, i_ext);
+	__f2fs_init_extent_tree(inode, ipage);
 
 	if (!F2FS_I(inode)->extent_tree)
 		set_inode_flag(inode, FI_NO_EXTENT);
-
-	return ret;
 }
 
 static bool f2fs_lookup_extent_tree(struct inode *inode, pgoff_t pgofs,
diff --git a/fs/f2fs/f2fs.h b/fs/f2fs/f2fs.h
index b35a50f4953c..326c12fa0da5 100644
--- a/fs/f2fs/f2fs.h
+++ b/fs/f2fs/f2fs.h
@@ -3795,7 +3795,7 @@ struct rb_entry *f2fs_lookup_rb_tree_ret(struct rb_root_cached *root,
 bool f2fs_check_rb_tree_consistence(struct f2fs_sb_info *sbi,
 						struct rb_root_cached *root);
 unsigned int f2fs_shrink_extent_tree(struct f2fs_sb_info *sbi, int nr_shrink);
-bool f2fs_init_extent_tree(struct inode *inode, struct f2fs_extent *i_ext);
+void f2fs_init_extent_tree(struct inode *inode, struct page *ipage);
 void f2fs_drop_extent_tree(struct inode *inode);
 unsigned int f2fs_destroy_extent_node(struct inode *inode);
 void f2fs_destroy_extent_tree(struct inode *inode);
diff --git a/fs/f2fs/file.c b/fs/f2fs/file.c
index 3268f8dd59bb..1862073b96d2 100644
--- a/fs/f2fs/file.c
+++ b/fs/f2fs/file.c
@@ -1250,6 +1250,7 @@ static int __clone_blkaddrs(struct inode *src_inode, struct inode *dst_inode,
 				f2fs_put_page(psrc, 1);
 				return PTR_ERR(pdst);
 			}
+			f2fs_wait_on_page_writeback(pdst, DATA, true, true);
 			f2fs_copy_page(psrc, pdst);
 			set_page_dirty(pdst);
 			f2fs_put_page(pdst, 1);
diff --git a/fs/f2fs/inline.c b/fs/f2fs/inline.c
index dbade310dc79..4bcbc486c9e2 100644
--- a/fs/f2fs/inline.c
+++ b/fs/f2fs/inline.c
@@ -340,6 +340,8 @@ int f2fs_make_empty_inline_dir(struct inode *inode, struct inode *parent,
 	struct f2fs_dentry_ptr d;
 	void *inline_dentry;
 
+	f2fs_wait_on_page_writeback(ipage, NODE, true, true);
+
 	inline_dentry = inline_data_addr(inode, ipage);
 
 	make_dentry_ptr_inline(inode, &d, inline_dentry);
diff --git a/fs/f2fs/inode.c b/fs/f2fs/inode.c
index 44582a4db513..7c156eb26dd7 100644
--- a/fs/f2fs/inode.c
+++ b/fs/f2fs/inode.c
@@ -367,8 +367,7 @@ static int do_read_inode(struct inode *inode)
 	fi->i_pino = le32_to_cpu(ri->i_pino);
 	fi->i_dir_level = ri->i_dir_level;
 
-	if (f2fs_init_extent_tree(inode, &ri->i_ext))
-		set_page_dirty(node_page);
+	f2fs_init_extent_tree(inode, node_page);
 
 	get_inline_info(inode, ri);
 
-- 
2.18.0.rc1

