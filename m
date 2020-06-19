Return-Path: <SRS0=bWCJ=AA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	UNPARSEABLE_RELAY,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 01566C433DF
	for <linux-kernel@archiver.kernel.org>; Fri, 19 Jun 2020 06:37:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id DA255207DD
	for <linux-kernel@archiver.kernel.org>; Fri, 19 Jun 2020 06:37:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727096AbgFSGha (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 19 Jun 2020 02:37:30 -0400
Received: from mx.wingtech.com ([180.166.216.14]:46082 "EHLO mail.wingtech.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725446AbgFSGh3 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 19 Jun 2020 02:37:29 -0400
Received: from mx.wingtech.com ([192.168.2.43])
        by mail.wingtech.com  with SMTP id 05J6bO4v003599-05J6bO4w003599
        for <linux-kernel@vger.kernel.org>; Fri, 19 Jun 2020 14:37:24 +0800
Received: from 192.168.51.143 (HELO ZHAOWUYUN.WINGTECH.COM); Fri, 19 Jun 2020 14:37:22 +0800
From:   zhaowuyun@wingtech.com
To:     jaegeuk@kernel.org, yuchao0@huawei.com
Cc:     linux-f2fs-devel@lists.sourceforge.net,
        linux-kernel@vger.kernel.org, zhaowuyun@wingtech.com
Subject: [PATCH v2] f2fs-tools: introduce set_node_footer to initialize node footer
Date:   Fri, 19 Jun 2020 14:37:14 +0800
Message-Id: <1592548634-1065-1-git-send-email-zhaowuyun@wingtech.com>
X-Mailer: git-send-email 2.7.4
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Wuyun Zhao <zhaowuyun@wingtech.com>

the filesystem will use the cold flag, so deal with it to avoid
potential issue of inconsistency

Signed-off-by: Wuyun Zhao <zhaowuyun@wingtech.com>
---
 fsck/dir.c         |  6 +-----
 fsck/node.c        |  9 +++++----
 include/f2fs_fs.h  | 20 ++++++++++++++++++++
 mkfs/f2fs_format.c | 14 +++++---------
 4 files changed, 31 insertions(+), 18 deletions(-)

diff --git a/fsck/dir.c b/fsck/dir.c
index 5f4f75e..64aa539 100644
--- a/fsck/dir.c
+++ b/fsck/dir.c
@@ -517,11 +517,7 @@ static void init_inode_block(struct f2fs_sb_info *sbi,
 	}
 
 	set_file_temperature(sbi, node_blk, de->name);
-
-	node_blk->footer.ino = cpu_to_le32(de->ino);
-	node_blk->footer.nid = cpu_to_le32(de->ino);
-	node_blk->footer.flag = 0;
-	node_blk->footer.cp_ver = ckpt->checkpoint_ver;
+	set_node_footer(node_blk, de->ino, de->ino, 0, le64_to_cpu(ckpt->checkpoint_ver), S_ISDIR(mode));
 
 	if (S_ISDIR(mode)) {
 		make_empty_dir(sbi, node_blk);
diff --git a/fsck/node.c b/fsck/node.c
index 229a99c..66e8a81 100644
--- a/fsck/node.c
+++ b/fsck/node.c
@@ -69,16 +69,17 @@ block_t new_node_block(struct f2fs_sb_info *sbi,
 	block_t blkaddr = NULL_ADDR;
 	int type;
 	int ret;
+	u32 ino;
+	u64 cp_ver;
 
 	f2fs_inode = dn->inode_blk;
 
 	node_blk = calloc(BLOCK_SZ, 1);
 	ASSERT(node_blk);
 
-	node_blk->footer.nid = cpu_to_le32(dn->nid);
-	node_blk->footer.ino = f2fs_inode->footer.ino;
-	node_blk->footer.flag = cpu_to_le32(ofs << OFFSET_BIT_SHIFT);
-	node_blk->footer.cp_ver = ckpt->checkpoint_ver;
+	ino = le32_to_cpu(f2fs_inode->footer.ino);
+	cp_ver = le64_to_cpu(ckpt->checkpoint_ver);
+	set_node_footer(node_blk, dn->nid, ino, ofs, cp_ver, S_ISDIR(le16_to_cpu(f2fs_inode->i.i_mode)));
 
 	type = CURSEG_COLD_NODE;
 	if (IS_DNODE(node_blk)) {
diff --git a/include/f2fs_fs.h b/include/f2fs_fs.h
index 709bfd8..3583df4 100644
--- a/include/f2fs_fs.h
+++ b/include/f2fs_fs.h
@@ -923,6 +923,26 @@ struct f2fs_node {
 	struct node_footer footer;
 } __attribute__((packed));
 
+static inline void set_cold_node(struct f2fs_node *rn, bool is_dir)
+{
+	unsigned int flag = le32_to_cpu(rn->footer.flag);
+
+	if (is_dir)
+		flag &= ~(0x1 << COLD_BIT_SHIFT);
+	else
+		flag |= (0x1 << COLD_BIT_SHIFT);
+	rn->footer.flag = cpu_to_le32(flag);
+}
+
+static inline void set_node_footer(struct f2fs_node *rn, u32 nid, u32 ino, u32 ofs, u64 ver, bool is_dir)
+{
+	rn->footer.nid = cpu_to_le32(nid);
+	rn->footer.ino = cpu_to_le32(ino);
+	rn->footer.flag = cpu_to_le32(ofs << OFFSET_BIT_SHIFT);
+	rn->footer.cp_ver = cpu_to_le64(ver);
+	set_cold_node(rn, is_dir);
+}
+
 /*
  * For NAT entries
  */
diff --git a/mkfs/f2fs_format.c b/mkfs/f2fs_format.c
index 44575e0..b371adf 100644
--- a/mkfs/f2fs_format.c
+++ b/mkfs/f2fs_format.c
@@ -1101,9 +1101,7 @@ static int f2fs_write_root_inode(void)
 		return -1;
 	}
 
-	raw_node->footer.nid = sb->root_ino;
-	raw_node->footer.ino = sb->root_ino;
-	raw_node->footer.cp_ver = cpu_to_le64(1);
+	set_node_footer(raw_node, le32_to_cpu(sb->root_ino), le32_to_cpu(sb->root_ino), 0, 1, 1);
 	raw_node->footer.next_blkaddr = cpu_to_le32(
 			get_sb(main_blkaddr) +
 			c.cur_seg[CURSEG_HOT_NODE] *
@@ -1256,6 +1254,7 @@ static int f2fs_write_qf_inode(int qtype)
 	u_int64_t main_area_node_seg_blk_offset = 0;
 	__le32 raw_id;
 	int i;
+	u32 qf_ino;
 
 	raw_node = calloc(F2FS_BLKSIZE, 1);
 	if (raw_node == NULL) {
@@ -1263,9 +1262,8 @@ static int f2fs_write_qf_inode(int qtype)
 		return -1;
 	}
 
-	raw_node->footer.nid = sb->qf_ino[qtype];
-	raw_node->footer.ino = sb->qf_ino[qtype];
-	raw_node->footer.cp_ver = cpu_to_le64(1);
+	qf_ino = le32_to_cpu(sb->qf_ino[qtype]);
+	set_node_footer(raw_node, qf_ino, qf_ino, 0, 1, 0);
 	raw_node->footer.next_blkaddr = cpu_to_le32(
 			get_sb(main_blkaddr) +
 			c.cur_seg[CURSEG_HOT_NODE] *
@@ -1457,9 +1455,7 @@ static int f2fs_write_lpf_inode(void)
 		return -1;
 	}
 
-	raw_node->footer.nid = cpu_to_le32(c.lpf_ino);
-	raw_node->footer.ino = raw_node->footer.nid;
-	raw_node->footer.cp_ver = cpu_to_le64(1);
+	set_node_footer(raw_node, c.lpf_ino, c.lpf_ino, 0, 1, 1);
 	raw_node->footer.next_blkaddr = cpu_to_le32(
 			get_sb(main_blkaddr) +
 			c.cur_seg[CURSEG_HOT_NODE] * c.blks_per_seg +
-- 
2.7.4

