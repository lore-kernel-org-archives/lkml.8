Return-Path: <SRS0=SbvM=AM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.0 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2490EC433DF
	for <linux-kernel@archiver.kernel.org>; Wed,  1 Jul 2020 11:26:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 017BC2073E
	for <linux-kernel@archiver.kernel.org>; Wed,  1 Jul 2020 11:26:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730318AbgGAL0B (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 1 Jul 2020 07:26:01 -0400
Received: from szxga05-in.huawei.com ([45.249.212.191]:6793 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1730159AbgGAL0B (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Jul 2020 07:26:01 -0400
Received: from DGGEMS406-HUB.china.huawei.com (unknown [172.30.72.58])
        by Forcepoint Email with ESMTP id B6201EE0AAC0EB1C54FF;
        Wed,  1 Jul 2020 19:25:57 +0800 (CST)
Received: from huawei.com (10.175.127.227) by DGGEMS406-HUB.china.huawei.com
 (10.3.19.206) with Microsoft SMTP Server id 14.3.487.0; Wed, 1 Jul 2020
 19:25:50 +0800
From:   Zhihao Cheng <chengzhihao1@huawei.com>
To:     <linux-mtd@lists.infradead.org>, <linux-kernel@vger.kernel.org>
CC:     <richard@nod.at>, <yi.zhang@huawei.com>
Subject: [PATCH] ubifs: Fix a potential space leak problem while linking tmpfile
Date:   Wed, 1 Jul 2020 19:26:43 +0800
Message-ID: <20200701112643.726986-1-chengzhihao1@huawei.com>
X-Mailer: git-send-email 2.25.4
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.175.127.227]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

There is a potential space leak problem while linking tmpfile, in which
case, inode node (with nlink=0) is valid in tnc (on flash), which leads
to space leak. Meanwhile, the corresponding data nodes won't be released
from tnc. For example, (A reproducer can be found in Link):

$ mount UBIFS
  [process A]            [process B]         [TNC]         [orphan area]

 ubifs_tmpfile                          inode_A (nlink=0)     inode_A
                          do_commit     inode_A (nlink=0)     inode_A
			       ↑
      (comment: It makes sure not replay inode_A in next mount)
 ubifs_link                             inode_A (nlink=0)     inode_A
   ubifs_delete_orphan                  inode_A (nlink=0)
                          do_commit     inode_A (nlink=0)
                           ---> POWERCUT <---
   (ubifs_jnl_update)

$ mount UBIFS
  inode_A will neither be replayed in ubifs_replay_journal() nor
  ubifs_mount_orphans(). inode_A (nlink=0) with its data nodes will
  always on tnc, it occupy space but is non-visable for users.

Commit ee1438ce5dc4d ("ubifs: Check link count of inodes when killing
orphans.") handles problem in mistakenly deleting relinked tmpfile
while replaying orphan area. Since that, tmpfile inode should always
live in orphan area even it is linked. Fix it by reverting commit
32fe905c17f001 ("ubifs: Fix O_TMPFILE corner case in ubifs_link()").

Signed-off-by: Zhihao Cheng <chengzhihao1@huawei.com>
Cc: <stable@vger.kernel.org>  # v5.3+
Fixes: 32fe905c17f001 ("ubifs: Fix O_TMPFILE corner case in ubifs_link()")
Link: https://bugzilla.kernel.org/show_bug.cgi?id=208405
---
 fs/ubifs/dir.c | 7 -------
 1 file changed, 7 deletions(-)

diff --git a/fs/ubifs/dir.c b/fs/ubifs/dir.c
index ef85ec167a84..9534c4bb598f 100644
--- a/fs/ubifs/dir.c
+++ b/fs/ubifs/dir.c
@@ -722,11 +722,6 @@ static int ubifs_link(struct dentry *old_dentry, struct inode *dir,
 		goto out_fname;
 
 	lock_2_inodes(dir, inode);
-
-	/* Handle O_TMPFILE corner case, it is allowed to link a O_TMPFILE. */
-	if (inode->i_nlink == 0)
-		ubifs_delete_orphan(c, inode->i_ino);
-
 	inc_nlink(inode);
 	ihold(inode);
 	inode->i_ctime = current_time(inode);
@@ -747,8 +742,6 @@ static int ubifs_link(struct dentry *old_dentry, struct inode *dir,
 	dir->i_size -= sz_change;
 	dir_ui->ui_size = dir->i_size;
 	drop_nlink(inode);
-	if (inode->i_nlink == 0)
-		ubifs_add_orphan(c, inode->i_ino);
 	unlock_2_inodes(dir, inode);
 	ubifs_release_budget(c, &req);
 	iput(inode);
-- 
2.25.4

