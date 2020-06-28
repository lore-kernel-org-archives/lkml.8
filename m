Return-Path: <SRS0=fM4p=AJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.0 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 96187C433E0
	for <linux-kernel@archiver.kernel.org>; Sun, 28 Jun 2020 02:58:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6B7992080C
	for <linux-kernel@archiver.kernel.org>; Sun, 28 Jun 2020 02:58:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725998AbgF1C6i (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 27 Jun 2020 22:58:38 -0400
Received: from szxga07-in.huawei.com ([45.249.212.35]:44796 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725880AbgF1C6h (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 27 Jun 2020 22:58:37 -0400
Received: from DGGEMS413-HUB.china.huawei.com (unknown [172.30.72.60])
        by Forcepoint Email with ESMTP id C0C51489BF0EB5B79EAD;
        Sun, 28 Jun 2020 10:58:34 +0800 (CST)
Received: from szvp000203569.huawei.com (10.120.216.130) by
 DGGEMS413-HUB.china.huawei.com (10.3.19.213) with Microsoft SMTP Server id
 14.3.487.0; Sun, 28 Jun 2020 10:58:27 +0800
From:   Chao Yu <yuchao0@huawei.com>
To:     <jaegeuk@kernel.org>
CC:     <linux-f2fs-devel@lists.sourceforge.net>,
        <linux-kernel@vger.kernel.org>, <chao@kernel.org>,
        Chao Yu <yuchao0@huawei.com>
Subject: [PATCH v2 1/5] f2fs: fix to wait page writeback before update
Date:   Sun, 28 Jun 2020 10:58:17 +0800
Message-ID: <20200628025817.90623-1-yuchao0@huawei.com>
X-Mailer: git-send-email 2.26.2
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.120.216.130]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Filesystem including f2fs should support stable page for special
device like software raid, however there is one missing path that
page could be updated while it is writeback state as below, fix
this.

- gc_node_segment
 - f2fs_move_node_page
  - __write_node_page
   - set_page_writeback

- do_read_inode
 - f2fs_init_extent_tree
  - __f2fs_init_extent_tree
    i_ext->len = 0;

Signed-off-by: Chao Yu <yuchao0@huawei.com>
---
v2:
- add call path into message.
- remove unrelated changes.
 fs/f2fs/extent_cache.c | 18 +++++++++---------
 fs/f2fs/f2fs.h         |  2 +-
 fs/f2fs/inode.c        |  3 +--
 3 files changed, 11 insertions(+), 12 deletions(-)

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
index cba9c0129f09..54cde692d88d 100644
--- a/fs/f2fs/f2fs.h
+++ b/fs/f2fs/f2fs.h
@@ -3821,7 +3821,7 @@ struct rb_entry *f2fs_lookup_rb_tree_ret(struct rb_root_cached *root,
 bool f2fs_check_rb_tree_consistence(struct f2fs_sb_info *sbi,
 						struct rb_root_cached *root);
 unsigned int f2fs_shrink_extent_tree(struct f2fs_sb_info *sbi, int nr_shrink);
-bool f2fs_init_extent_tree(struct inode *inode, struct f2fs_extent *i_ext);
+void f2fs_init_extent_tree(struct inode *inode, struct page *ipage);
 void f2fs_drop_extent_tree(struct inode *inode);
 unsigned int f2fs_destroy_extent_node(struct inode *inode);
 void f2fs_destroy_extent_tree(struct inode *inode);
diff --git a/fs/f2fs/inode.c b/fs/f2fs/inode.c
index 33affa788588..66969ae852b9 100644
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
2.26.2

