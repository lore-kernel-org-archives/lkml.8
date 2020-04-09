Return-Path: <SRS0=n+Ub=5Z=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,URIBL_DBL_SPAM,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DE9DCC2BB54
	for <linux-kernel@archiver.kernel.org>; Thu,  9 Apr 2020 09:12:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B764F20A8B
	for <linux-kernel@archiver.kernel.org>; Thu,  9 Apr 2020 09:12:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726683AbgDIJMX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 9 Apr 2020 05:12:23 -0400
Received: from szxga07-in.huawei.com ([45.249.212.35]:48320 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725783AbgDIJMX (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Apr 2020 05:12:23 -0400
Received: from DGGEMS412-HUB.china.huawei.com (unknown [172.30.72.58])
        by Forcepoint Email with ESMTP id B625F651FF0BBC36EBA3;
        Thu,  9 Apr 2020 17:11:55 +0800 (CST)
Received: from SZXY1L005141301.china.huawei.com (10.40.90.207) by
 DGGEMS412-HUB.china.huawei.com (10.3.19.212) with Microsoft SMTP Server id
 14.3.487.0; Thu, 9 Apr 2020 17:11:45 +0800
From:   Zhe Li <lizhe67@huawei.com>
To:     <dwmw2@infradead.org>, <richard@nod.at>, <wenwen@cs.uga.edu>,
        <linux-mtd@lists.infradead.org>, <linux-kernel@vger.kernel.org>
CC:     <yihuaijie@huawei.com>
Subject: [PATCH] jffs2: fix jffs2 mounting failure
Date:   Thu, 9 Apr 2020 17:11:34 +0800
Message-ID: <20200409091134.61364-1-lizhe67@huawei.com>
X-Mailer: git-send-email 2.21.0.windows.1
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.40.90.207]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

There is a scene that may easily case mounting failure while using
nand flash with jffs2. The steps are listed below.
1.erase nand flash
2.mount jffs2 on it (this mounting operation will be successful)
3.do chown or chmod to the mount point directory
4.umount jffs2
5.mount jffs2 on nand flash
Step 5 will return I/O ERROR

The reason for this mounting failure is that at the end of function
jffs2_scan_medium(), jffs2 will check the used_size and some info
of nr_blocks.If conditions are met, it will return -EIO.

In the steps listed above, step 3 will write jffs2_raw_inode into
flash without jffs2_raw_dirent, which will cause that there are some
jffs2_raw_inode but no jffs2_raw_dirent on flash. This will meet
the condition at the end of function jffs2_scan_medium() and return
-EIO if we umount jffs2 and mount it again.

Typical image of this problem is like:
Empty space found from 0x00000000 to 0x008a0000
Inode node at xx, totlen 0x00000044, #ino 1, version 1, isize 0...

This patch add a flag to fix this problem. Appropriate bits of the
flag will be set if we scan a jffs2_raw_inode with ino != 1 and
ino == 1. And the flag will be check at the judgment of return
-EIO,which is mentioned above.

Signed-off-by: Zhe Li <lizhe67@huawei.com>
---
 fs/jffs2/build.c       |  1 +
 fs/jffs2/jffs2_fs_sb.h | 26 ++++++++++++++++++++++++++
 fs/jffs2/scan.c        |  8 +++++++-
 3 files changed, 34 insertions(+), 1 deletion(-)

diff --git a/fs/jffs2/build.c b/fs/jffs2/build.c
index b288c8a..d9fda40 100644
--- a/fs/jffs2/build.c
+++ b/fs/jffs2/build.c
@@ -405,6 +405,7 @@ int jffs2_do_mount_fs(struct jffs2_sb_info *c)
 	INIT_LIST_HEAD(&c->bad_used_list);
 	c->highest_ino = 1;
 	c->summary = NULL;
+	c->inode_flag = INODE_FLAG_INIT;
 
 	ret = jffs2_sum_init(c);
 	if (ret)
diff --git a/fs/jffs2/jffs2_fs_sb.h b/fs/jffs2/jffs2_fs_sb.h
index 778275f..a01b5f4 100644
--- a/fs/jffs2/jffs2_fs_sb.h
+++ b/fs/jffs2/jffs2_fs_sb.h
@@ -27,6 +27,10 @@
 #define JFFS2_SB_FLAG_SCANNING 2 /* Flash scanning is in progress */
 #define JFFS2_SB_FLAG_BUILDING 4 /* File system building is in progress */
 
+#define INODE_FLAG_INIT 0
+#define INODE_FLAG_HAS_ROOT_INODE  (0x01 << 0)
+#define INODE_FLAG_HAS_OTHER_INODE (0x01 << 1)
+
 struct jffs2_inodirty;
 
 struct jffs2_mount_opts {
@@ -157,6 +161,28 @@ struct jffs2_sb_info {
 #endif
 	/* OS-private pointer for getting back to master superblock info */
 	void *os_priv;
+	/* this flag show the contained inodes info */
+	int inode_flag;
 };
 
+static inline void set_root_inode_flag(struct jffs2_sb_info *c)
+{
+	c->inode_flag |= INODE_FLAG_HAS_ROOT_INODE;
+}
+
+static inline void set_other_inode_flag(struct jffs2_sb_info *c)
+{
+	c->inode_flag |= INODE_FLAG_HAS_OTHER_INODE;
+}
+
+static inline int has_root_inode(struct jffs2_sb_info *c)
+{
+	return (c->inode_flag & INODE_FLAG_HAS_ROOT_INODE);
+}
+
+static inline int has_other_inode(struct jffs2_sb_info *c)
+{
+	return (c->inode_flag & INODE_FLAG_HAS_OTHER_INODE);
+}
+
 #endif /* _JFFS2_FS_SB */
diff --git a/fs/jffs2/scan.c b/fs/jffs2/scan.c
index 5f7e284..ec13e08 100644
--- a/fs/jffs2/scan.c
+++ b/fs/jffs2/scan.c
@@ -261,7 +261,8 @@ int jffs2_scan_medium(struct jffs2_sb_info *c)
 	}
 #endif
 	if (c->nr_erasing_blocks) {
-		if ( !c->used_size && ((c->nr_free_blocks+empty_blocks+bad_blocks)!= c->nr_blocks || bad_blocks == c->nr_blocks) ) {
+		if (!c->used_size && ((c->nr_free_blocks+empty_blocks+bad_blocks) != c->nr_blocks || bad_blocks == c->nr_blocks) &&
+		    !(has_root_inode(c) && !has_other_inode(c))) {
 			pr_notice("Cowardly refusing to erase blocks on filesystem with no valid JFFS2 nodes\n");
 			pr_notice("empty_blocks %d, bad_blocks %d, c->nr_blocks %d\n",
 				  empty_blocks, bad_blocks, c->nr_blocks);
@@ -1036,6 +1037,11 @@ static int jffs2_scan_inode_node(struct jffs2_sb_info *c, struct jffs2_erasebloc
 		jffs2_sum_add_inode_mem(s, ri, ofs - jeb->offset);
 	}
 
+	if (likely(ino != 1))
+		set_other_inode_flag(c);
+	else
+		set_root_inode_flag(c);
+
 	return 0;
 }
 
-- 
2.7.4

