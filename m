Return-Path: <SRS0=3e5Q=77=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	UNPARSEABLE_RELAY,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2B80AC433E0
	for <linux-kernel@archiver.kernel.org>; Thu, 18 Jun 2020 12:48:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 07BD22071A
	for <linux-kernel@archiver.kernel.org>; Thu, 18 Jun 2020 12:48:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729965AbgFRMsV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 18 Jun 2020 08:48:21 -0400
Received: from mail.wingtech.com ([180.166.216.14]:35640 "EHLO
        mail.wingtech.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S1729800AbgFRMsU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 18 Jun 2020 08:48:20 -0400
Received: from mx.wingtech.com ([192.168.2.43])
        by mail.wingtech.com  with SMTP id 05ICmHNS002869-05ICmHNT002869
        for <linux-kernel@vger.kernel.org>; Thu, 18 Jun 2020 20:48:17 +0800
Received: from 192.168.51.143 (HELO ZHAOWUYUN.WINGTECH.COM); Thu, 18 Jun 2020 20:48:14 +0800
From:   zhaowuyun@wingtech.com
To:     yuchao0@huawei.com, jaegeuk@kernel.org
Cc:     linux-f2fs-devel@lists.sourceforge.net,
        linux-kernel@vger.kernel.org, zhaowuyun@wingtech.com
Subject: [PATCH] f2fs-tools: set cold flag for non-dir node
Date:   Thu, 18 Jun 2020 20:48:07 +0800
Message-Id: <1592484487-12072-1-git-send-email-zhaowuyun@wingtech.com>
X-Mailer: git-send-email 2.7.4
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Wuyun Zhao <zhaowuyun@wingtech.com>

Signed-off-by: Wuyun Zhao <zhaowuyun@wingtech.com>
---
 fsck/dir.c  |  1 +
 fsck/node.c |  1 +
 fsck/node.h | 11 +++++++++++
 3 files changed, 13 insertions(+)

diff --git a/fsck/dir.c b/fsck/dir.c
index 5f4f75e..dc03c98 100644
--- a/fsck/dir.c
+++ b/fsck/dir.c
@@ -522,6 +522,7 @@ static void init_inode_block(struct f2fs_sb_info *sbi,
 	node_blk->footer.nid = cpu_to_le32(de->ino);
 	node_blk->footer.flag = 0;
 	node_blk->footer.cp_ver = ckpt->checkpoint_ver;
+	set_cold_node(node_blk, S_ISDIR(mode));
 
 	if (S_ISDIR(mode)) {
 		make_empty_dir(sbi, node_blk);
diff --git a/fsck/node.c b/fsck/node.c
index 229a99c..1d291ca 100644
--- a/fsck/node.c
+++ b/fsck/node.c
@@ -79,6 +79,7 @@ block_t new_node_block(struct f2fs_sb_info *sbi,
 	node_blk->footer.ino = f2fs_inode->footer.ino;
 	node_blk->footer.flag = cpu_to_le32(ofs << OFFSET_BIT_SHIFT);
 	node_blk->footer.cp_ver = ckpt->checkpoint_ver;
+	set_cold_node(node_blk, S_ISDIR(le16_to_cpu(f2fs_inode->i.i_mode)));
 
 	type = CURSEG_COLD_NODE;
 	if (IS_DNODE(node_blk)) {
diff --git a/fsck/node.h b/fsck/node.h
index 6bce1fb..99139b1 100644
--- a/fsck/node.h
+++ b/fsck/node.h
@@ -161,6 +161,17 @@ static inline int is_node(struct f2fs_node *node_blk, int type)
 	return le32_to_cpu(node_blk->footer.flag) & (1 << type);
 }
 
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
 #define is_fsync_dnode(node_blk)	is_node(node_blk, FSYNC_BIT_SHIFT)
 #define is_dent_dnode(node_blk)		is_node(node_blk, DENT_BIT_SHIFT)
 
-- 
2.7.4

