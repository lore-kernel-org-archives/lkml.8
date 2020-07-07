Return-Path: <SRS0=aTFg=AS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4C08FC433DF
	for <linux-kernel@archiver.kernel.org>; Tue,  7 Jul 2020 12:51:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0E40B20708
	for <linux-kernel@archiver.kernel.org>; Tue,  7 Jul 2020 12:51:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728121AbgGGMvK (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 7 Jul 2020 08:51:10 -0400
Received: from szxga07-in.huawei.com ([45.249.212.35]:51842 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726757AbgGGMvJ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Jul 2020 08:51:09 -0400
Received: from DGGEMS402-HUB.china.huawei.com (unknown [172.30.72.60])
        by Forcepoint Email with ESMTP id ECE0491359C37657ECA9;
        Tue,  7 Jul 2020 20:51:00 +0800 (CST)
Received: from huawei.com (10.175.127.227) by DGGEMS402-HUB.china.huawei.com
 (10.3.19.202) with Microsoft SMTP Server id 14.3.487.0; Tue, 7 Jul 2020
 20:50:53 +0800
From:   Zhihao Cheng <chengzhihao1@huawei.com>
To:     <linux-mtd@lists.infradead.org>, <linux-kernel@vger.kernel.org>
CC:     <richard@nod.at>, <yi.zhang@huawei.com>
Subject: [PATCH v2] ubifs: Fix wrong orphan node deletion in ubifs_jnl_update|rename
Date:   Tue, 7 Jul 2020 20:51:40 +0800
Message-ID: <20200707125140.267982-1-chengzhihao1@huawei.com>
X-Mailer: git-send-email 2.25.4
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.175.127.227]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

There a wrong orphan node deleting in error handling path in
ubifs_jnl_update() and ubifs_jnl_rename(), which may cause
following error msg:

  UBIFS error (ubi0:0 pid 1522): ubifs_delete_orphan [ubifs]:
  missing orphan ino 65

Fix this by checking whether the node has been operated for
adding to orphan list before being deleted,

Signed-off-by: Zhihao Cheng <chengzhihao1@huawei.com>
Fixes: 823838a486888cf484e ("ubifs: Add hashes to the tree node cache")
---
 fs/ubifs/journal.c | 10 ++++++----
 1 file changed, 6 insertions(+), 4 deletions(-)

diff --git a/fs/ubifs/journal.c b/fs/ubifs/journal.c
index e5ec1afe1c66..2cf05f87565c 100644
--- a/fs/ubifs/journal.c
+++ b/fs/ubifs/journal.c
@@ -539,7 +539,7 @@ int ubifs_jnl_update(struct ubifs_info *c, const struct inode *dir,
 		     const struct fscrypt_name *nm, const struct inode *inode,
 		     int deletion, int xent)
 {
-	int err, dlen, ilen, len, lnum, ino_offs, dent_offs;
+	int err, dlen, ilen, len, lnum, ino_offs, dent_offs, orphan_added = 0;
 	int aligned_dlen, aligned_ilen, sync = IS_DIRSYNC(dir);
 	int last_reference = !!(deletion && inode->i_nlink == 0);
 	struct ubifs_inode *ui = ubifs_inode(inode);
@@ -630,6 +630,7 @@ int ubifs_jnl_update(struct ubifs_info *c, const struct inode *dir,
 			goto out_finish;
 		}
 		ui->del_cmtno = c->cmt_no;
+		orphan_added = 1;
 	}
 
 	err = write_head(c, BASEHD, dent, len, &lnum, &dent_offs, sync);
@@ -702,7 +703,7 @@ int ubifs_jnl_update(struct ubifs_info *c, const struct inode *dir,
 	kfree(dent);
 out_ro:
 	ubifs_ro_mode(c, err);
-	if (last_reference)
+	if (orphan_added)
 		ubifs_delete_orphan(c, inode->i_ino);
 	finish_reservation(c);
 	return err;
@@ -1218,7 +1219,7 @@ int ubifs_jnl_rename(struct ubifs_info *c, const struct inode *old_dir,
 	void *p;
 	union ubifs_key key;
 	struct ubifs_dent_node *dent, *dent2;
-	int err, dlen1, dlen2, ilen, lnum, offs, len;
+	int err, dlen1, dlen2, ilen, lnum, offs, len, orphan_added = 0;
 	int aligned_dlen1, aligned_dlen2, plen = UBIFS_INO_NODE_SZ;
 	int last_reference = !!(new_inode && new_inode->i_nlink == 0);
 	int move = (old_dir != new_dir);
@@ -1334,6 +1335,7 @@ int ubifs_jnl_rename(struct ubifs_info *c, const struct inode *old_dir,
 			goto out_finish;
 		}
 		new_ui->del_cmtno = c->cmt_no;
+		orphan_added = 1;
 	}
 
 	err = write_head(c, BASEHD, dent, len, &lnum, &offs, sync);
@@ -1415,7 +1417,7 @@ int ubifs_jnl_rename(struct ubifs_info *c, const struct inode *old_dir,
 	release_head(c, BASEHD);
 out_ro:
 	ubifs_ro_mode(c, err);
-	if (last_reference)
+	if (orphan_added)
 		ubifs_delete_orphan(c, new_inode->i_ino);
 out_finish:
 	finish_reservation(c);
-- 
2.25.4

