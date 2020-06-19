Return-Path: <SRS0=bWCJ=AA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	UNPARSEABLE_RELAY,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D9C0BC433E0
	for <linux-kernel@archiver.kernel.org>; Fri, 19 Jun 2020 08:46:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id BB54720734
	for <linux-kernel@archiver.kernel.org>; Fri, 19 Jun 2020 08:46:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731288AbgFSIqD (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 19 Jun 2020 04:46:03 -0400
Received: from mail.wingtech.com ([180.166.216.14]:49695 "EHLO
        mail.wingtech.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S1730924AbgFSIp6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 19 Jun 2020 04:45:58 -0400
Received: from mx.wingtech.com ([192.168.2.43])
        by mail.wingtech.com  with SMTP id 05J8jr84032183-05J8jr85032183
        for <linux-kernel@vger.kernel.org>; Fri, 19 Jun 2020 16:45:53 +0800
Received: from 192.168.51.143 (HELO ZHAOWUYUN.WINGTECH.COM); Fri, 19 Jun 2020 16:45:50 +0800
From:   zhaowuyun@wingtech.com
To:     yuchao0@huawei.com, jaegeuk@kernel.org
Cc:     linux-f2fs-devel@lists.sourceforge.net,
        linux-kernel@vger.kernel.org, zhaowuyun@wingtech.com
Subject: [PATCH v3] f2fs-tools: introduce set_node_footer to initialize node footer
Date:   Fri, 19 Jun 2020 16:45:44 +0800
Message-Id: <1592556344-2301-1-git-send-email-zhaowuyun@wingtech.com>
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
 fsck/dir.c         |  7 ++-----
 fsck/node.c        | 12 +++++-------
 include/f2fs_fs.h  | 23 +++++++++++++++++++++++
 mkfs/f2fs_format.c | 34 +++++++++++++---------------------
 4 files changed, 43 insertions(+), 33 deletions(-)

diff --git a/fsck/dir.c b/fsck/dir.c
index 5f4f75e..b067aec 100644
--- a/fsck/dir.c
+++ b/fsck/dir.c
@@ -517,11 +517,8 @@ static void init_inode_block(struct f2fs_sb_info *sbi,
 	}
 
 	set_file_temperature(sbi, node_blk, de->name);
-
-	node_blk->footer.ino = cpu_to_le32(de->ino);
-	node_blk->footer.nid = cpu_to_le32(de->ino);
-	node_blk->footer.flag = 0;
-	node_blk->footer.cp_ver = ckpt->checkpoint_ver;
+	set_node_footer(node_blk, de->ino, de->ino, 0,
+			le64_to_cpu(ckpt->checkpoint_ver), 0, S_ISDIR(mode));
 
 	if (S_ISDIR(mode)) {
 		make_empty_dir(sbi, node_blk);
diff --git a/fsck/node.c b/fsck/node.c
index 229a99c..ef7ed0b 100644
--- a/fsck/node.c
+++ b/fsck/node.c
@@ -61,7 +61,7 @@ void set_data_blkaddr(struct dnode_of_data *dn)
 block_t new_node_block(struct f2fs_sb_info *sbi,
 				struct dnode_of_data *dn, unsigned int ofs)
 {
-	struct f2fs_node *f2fs_inode;
+	struct f2fs_node *f2fs_inode = dn->inode_blk;
 	struct f2fs_node *node_blk;
 	struct f2fs_checkpoint *ckpt = F2FS_CKPT(sbi);
 	struct f2fs_summary sum;
@@ -69,16 +69,14 @@ block_t new_node_block(struct f2fs_sb_info *sbi,
 	block_t blkaddr = NULL_ADDR;
 	int type;
 	int ret;
-
-	f2fs_inode = dn->inode_blk;
+	nid_t ino = le32_to_cpu(f2fs_inode->footer.ino);
+	u64 cp_ver = le64_to_cpu(ckpt->checkpoint_ver);
 
 	node_blk = calloc(BLOCK_SZ, 1);
 	ASSERT(node_blk);
 
-	node_blk->footer.nid = cpu_to_le32(dn->nid);
-	node_blk->footer.ino = f2fs_inode->footer.ino;
-	node_blk->footer.flag = cpu_to_le32(ofs << OFFSET_BIT_SHIFT);
-	node_blk->footer.cp_ver = ckpt->checkpoint_ver;
+	set_node_footer(node_blk, dn->nid, ino, ofs, cp_ver, 0,
+			S_ISDIR(le16_to_cpu(f2fs_inode->i.i_mode)));
 
 	type = CURSEG_COLD_NODE;
 	if (IS_DNODE(node_blk)) {
diff --git a/include/f2fs_fs.h b/include/f2fs_fs.h
index 709bfd8..ab19eb7 100644
--- a/include/f2fs_fs.h
+++ b/include/f2fs_fs.h
@@ -923,6 +923,29 @@ struct f2fs_node {
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
+static inline void set_node_footer(struct f2fs_node *rn, nid_t nid, nid_t ino,
+					u32 ofs, u64 ver, block_t blkaddr,
+					bool is_dir)
+{
+	rn->footer.nid = cpu_to_le32(nid);
+	rn->footer.ino = cpu_to_le32(ino);
+	rn->footer.flag = cpu_to_le32(ofs << OFFSET_BIT_SHIFT);
+	rn->footer.cp_ver = cpu_to_le64(ver);
+	rn->footer.next_blkaddr = cpu_to_le32(blkaddr);
+	set_cold_node(rn, is_dir);
+}
+
 /*
  * For NAT entries
  */
diff --git a/mkfs/f2fs_format.c b/mkfs/f2fs_format.c
index 44575e0..656023a 100644
--- a/mkfs/f2fs_format.c
+++ b/mkfs/f2fs_format.c
@@ -1094,6 +1094,9 @@ static int f2fs_write_root_inode(void)
 	struct f2fs_node *raw_node = NULL;
 	u_int64_t blk_size_bytes, data_blk_nor;
 	u_int64_t main_area_node_seg_blk_offset = 0;
+	nid_t nid = le32_to_cpu(sb->root_ino);
+	block_t blkaddr = get_sb(main_blkaddr) +
+				c.cur_seg[CURSEG_HOT_NODE] * c.blks_per_seg + 1;
 
 	raw_node = calloc(F2FS_BLKSIZE, 1);
 	if (raw_node == NULL) {
@@ -1101,13 +1104,7 @@ static int f2fs_write_root_inode(void)
 		return -1;
 	}
 
-	raw_node->footer.nid = sb->root_ino;
-	raw_node->footer.ino = sb->root_ino;
-	raw_node->footer.cp_ver = cpu_to_le64(1);
-	raw_node->footer.next_blkaddr = cpu_to_le32(
-			get_sb(main_blkaddr) +
-			c.cur_seg[CURSEG_HOT_NODE] *
-			c.blks_per_seg + 1);
+	set_node_footer(raw_node, nid, nid, 0, 1, blkaddr, 1);
 
 	raw_node->i.i_mode = cpu_to_le16(0x41ed);
 	if (c.lpf_ino)
@@ -1256,6 +1253,10 @@ static int f2fs_write_qf_inode(int qtype)
 	u_int64_t main_area_node_seg_blk_offset = 0;
 	__le32 raw_id;
 	int i;
+	nid_t qf_ino = le32_to_cpu(sb->qf_ino[qtype]);
+	block_t blkaddr = get_sb(main_blkaddr) +
+					c.cur_seg[CURSEG_HOT_NODE] *
+					c.blks_per_seg + 1 + qtype + 1;
 
 	raw_node = calloc(F2FS_BLKSIZE, 1);
 	if (raw_node == NULL) {
@@ -1263,13 +1264,7 @@ static int f2fs_write_qf_inode(int qtype)
 		return -1;
 	}
 
-	raw_node->footer.nid = sb->qf_ino[qtype];
-	raw_node->footer.ino = sb->qf_ino[qtype];
-	raw_node->footer.cp_ver = cpu_to_le64(1);
-	raw_node->footer.next_blkaddr = cpu_to_le32(
-			get_sb(main_blkaddr) +
-			c.cur_seg[CURSEG_HOT_NODE] *
-			c.blks_per_seg + 1 + qtype + 1);
+	set_node_footer(raw_node, qf_ino, qf_ino, 0, 1, blkaddr, 0);
 
 	raw_node->i.i_mode = cpu_to_le16(0x8180);
 	raw_node->i.i_links = cpu_to_le32(1);
@@ -1447,6 +1442,9 @@ static int f2fs_write_lpf_inode(void)
 	struct f2fs_node *raw_node;
 	u_int64_t blk_size_bytes, main_area_node_seg_blk_offset;
 	block_t data_blk_nor;
+	block_t blkaddr = get_sb(main_blkaddr) +
+				c.cur_seg[CURSEG_HOT_NODE] * c.blks_per_seg +
+				1 + c.quota_inum + 1;
 	int err = 0;
 
 	ASSERT(c.lpf_ino);
@@ -1457,13 +1455,7 @@ static int f2fs_write_lpf_inode(void)
 		return -1;
 	}
 
-	raw_node->footer.nid = cpu_to_le32(c.lpf_ino);
-	raw_node->footer.ino = raw_node->footer.nid;
-	raw_node->footer.cp_ver = cpu_to_le64(1);
-	raw_node->footer.next_blkaddr = cpu_to_le32(
-			get_sb(main_blkaddr) +
-			c.cur_seg[CURSEG_HOT_NODE] * c.blks_per_seg +
-			1 + c.quota_inum + 1);
+	set_node_footer(raw_node, c.lpf_ino, c.lpf_ino, 0, 1, blkaddr, 1);
 
 	raw_node->i.i_mode = cpu_to_le16(0x41c0); /* 0700 */
 	raw_node->i.i_links = cpu_to_le32(2);
-- 
2.7.4

