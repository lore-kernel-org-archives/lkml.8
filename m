Return-Path: <SRS0=pusq=BO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.0 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DCEB8C433DF
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Aug 2020 13:15:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C2D30207FC
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Aug 2020 13:15:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728576AbgHDNP6 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 4 Aug 2020 09:15:58 -0400
Received: from szxga04-in.huawei.com ([45.249.212.190]:9327 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1728322AbgHDNPa (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Aug 2020 09:15:30 -0400
Received: from DGGEMS406-HUB.china.huawei.com (unknown [172.30.72.58])
        by Forcepoint Email with ESMTP id 5ABCB5F9F89507360207;
        Tue,  4 Aug 2020 21:15:28 +0800 (CST)
Received: from szvp000203569.huawei.com (10.120.216.130) by
 DGGEMS406-HUB.china.huawei.com (10.3.19.206) with Microsoft SMTP Server id
 14.3.487.0; Tue, 4 Aug 2020 21:15:18 +0800
From:   Chao Yu <yuchao0@huawei.com>
To:     <jaegeuk@kernel.org>
CC:     <linux-f2fs-devel@lists.sourceforge.net>,
        <linux-kernel@vger.kernel.org>, <chao@kernel.org>,
        Chao Yu <yuchao0@huawei.com>
Subject: [PATCH v2 4/5] f2fs: support 64-bits key in f2fs rb-tree node entry
Date:   Tue, 4 Aug 2020 21:14:48 +0800
Message-ID: <20200804131449.50517-5-yuchao0@huawei.com>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20200804131449.50517-1-yuchao0@huawei.com>
References: <20200804131449.50517-1-yuchao0@huawei.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.120.216.130]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

then, we can add specified entry into rb-tree with 64-bits segment time
as key.

Signed-off-by: Chao Yu <yuchao0@huawei.com>
---
 fs/f2fs/extent_cache.c | 37 +++++++++++++++++++++++++++++++++++--
 fs/f2fs/f2fs.h         | 15 ++++++++++++---
 fs/f2fs/segment.c      |  4 ++--
 3 files changed, 49 insertions(+), 7 deletions(-)

diff --git a/fs/f2fs/extent_cache.c b/fs/f2fs/extent_cache.c
index 686c68b98610..3ebf976a682d 100644
--- a/fs/f2fs/extent_cache.c
+++ b/fs/f2fs/extent_cache.c
@@ -58,6 +58,29 @@ struct rb_entry *f2fs_lookup_rb_tree(struct rb_root_cached *root,
 	return re;
 }
 
+struct rb_node **f2fs_lookup_rb_tree_ext(struct f2fs_sb_info *sbi,
+					struct rb_root_cached *root,
+					struct rb_node **parent,
+					unsigned long long key, bool *leftmost)
+{
+	struct rb_node **p = &root->rb_root.rb_node;
+	struct rb_entry *re;
+
+	while (*p) {
+		*parent = *p;
+		re = rb_entry(*parent, struct rb_entry, rb_node);
+
+		if (key < re->key) {
+			p = &(*p)->rb_left;
+		} else {
+			p = &(*p)->rb_right;
+			*leftmost = false;
+		}
+	}
+
+	return p;
+}
+
 struct rb_node **f2fs_lookup_rb_tree_for_insert(struct f2fs_sb_info *sbi,
 				struct rb_root_cached *root,
 				struct rb_node **parent,
@@ -166,7 +189,7 @@ struct rb_entry *f2fs_lookup_rb_tree_ret(struct rb_root_cached *root,
 }
 
 bool f2fs_check_rb_tree_consistence(struct f2fs_sb_info *sbi,
-						struct rb_root_cached *root)
+				struct rb_root_cached *root, bool check_key)
 {
 #ifdef CONFIG_F2FS_CHECK_FS
 	struct rb_node *cur = rb_first_cached(root), *next;
@@ -183,13 +206,23 @@ bool f2fs_check_rb_tree_consistence(struct f2fs_sb_info *sbi,
 		cur_re = rb_entry(cur, struct rb_entry, rb_node);
 		next_re = rb_entry(next, struct rb_entry, rb_node);
 
+		if (check_key) {
+			if (cur_re->key > next_re->key) {
+				f2fs_info(sbi, "inconsistent rbtree, "
+					"cur(%llu) next(%llu)",
+					cur_re->key, next_re->key);
+				return false;
+			}
+			goto next;
+		}
+
 		if (cur_re->ofs + cur_re->len > next_re->ofs) {
 			f2fs_info(sbi, "inconsistent rbtree, cur(%u, %u) next(%u, %u)",
 				  cur_re->ofs, cur_re->len,
 				  next_re->ofs, next_re->len);
 			return false;
 		}
-
+next:
 		cur = next;
 	}
 #endif
diff --git a/fs/f2fs/f2fs.h b/fs/f2fs/f2fs.h
index 20da627249c0..44445b9ccc1b 100644
--- a/fs/f2fs/f2fs.h
+++ b/fs/f2fs/f2fs.h
@@ -612,8 +612,13 @@ enum {
 
 struct rb_entry {
 	struct rb_node rb_node;		/* rb node located in rb-tree */
-	unsigned int ofs;		/* start offset of the entry */
-	unsigned int len;		/* length of the entry */
+	union {
+		struct {
+			unsigned int ofs;	/* start offset of the entry */
+			unsigned int len;	/* length of the entry */
+		};
+		unsigned long long key;		/* 64-bits key */
+	};
 };
 
 struct extent_info {
@@ -3801,6 +3806,10 @@ void f2fs_leave_shrinker(struct f2fs_sb_info *sbi);
  */
 struct rb_entry *f2fs_lookup_rb_tree(struct rb_root_cached *root,
 				struct rb_entry *cached_re, unsigned int ofs);
+struct rb_node **f2fs_lookup_rb_tree_ext(struct f2fs_sb_info *sbi,
+				struct rb_root_cached *root,
+				struct rb_node **parent,
+				unsigned long long key, bool *left_most);
 struct rb_node **f2fs_lookup_rb_tree_for_insert(struct f2fs_sb_info *sbi,
 				struct rb_root_cached *root,
 				struct rb_node **parent,
@@ -3811,7 +3820,7 @@ struct rb_entry *f2fs_lookup_rb_tree_ret(struct rb_root_cached *root,
 		struct rb_node ***insert_p, struct rb_node **insert_parent,
 		bool force, bool *leftmost);
 bool f2fs_check_rb_tree_consistence(struct f2fs_sb_info *sbi,
-						struct rb_root_cached *root);
+				struct rb_root_cached *root, bool check_key);
 unsigned int f2fs_shrink_extent_tree(struct f2fs_sb_info *sbi, int nr_shrink);
 void f2fs_init_extent_tree(struct inode *inode, struct page *ipage);
 void f2fs_drop_extent_tree(struct inode *inode);
diff --git a/fs/f2fs/segment.c b/fs/f2fs/segment.c
index 503d7799ea88..f89219db72a2 100644
--- a/fs/f2fs/segment.c
+++ b/fs/f2fs/segment.c
@@ -1521,7 +1521,7 @@ static int __issue_discard_cmd(struct f2fs_sb_info *sbi,
 			goto next;
 		if (unlikely(dcc->rbtree_check))
 			f2fs_bug_on(sbi, !f2fs_check_rb_tree_consistence(sbi,
-								&dcc->root));
+							&dcc->root, false));
 		blk_start_plug(&plug);
 		list_for_each_entry_safe(dc, tmp, pend_list, list) {
 			f2fs_bug_on(sbi, dc->state != D_PREP);
@@ -2888,7 +2888,7 @@ static unsigned int __issue_discard_cmd_range(struct f2fs_sb_info *sbi,
 	mutex_lock(&dcc->cmd_lock);
 	if (unlikely(dcc->rbtree_check))
 		f2fs_bug_on(sbi, !f2fs_check_rb_tree_consistence(sbi,
-								&dcc->root));
+							&dcc->root, false));
 
 	dc = (struct discard_cmd *)f2fs_lookup_rb_tree_ret(&dcc->root,
 					NULL, start,
-- 
2.26.2

