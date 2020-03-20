Return-Path: <SRS0=Xzqw=5F=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D9F6AC4332B
	for <linux-kernel@archiver.kernel.org>; Fri, 20 Mar 2020 10:18:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B700F20773
	for <linux-kernel@archiver.kernel.org>; Fri, 20 Mar 2020 10:18:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727163AbgCTKSq (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 20 Mar 2020 06:18:46 -0400
Received: from szxga05-in.huawei.com ([45.249.212.191]:12170 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726527AbgCTKSq (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 Mar 2020 06:18:46 -0400
Received: from DGGEMS406-HUB.china.huawei.com (unknown [172.30.72.58])
        by Forcepoint Email with ESMTP id 077008B8674EF2BC430E;
        Fri, 20 Mar 2020 18:18:43 +0800 (CST)
Received: from szvp000203569.huawei.com (10.120.216.130) by
 DGGEMS406-HUB.china.huawei.com (10.3.19.206) with Microsoft SMTP Server id
 14.3.487.0; Fri, 20 Mar 2020 18:18:33 +0800
From:   Chao Yu <yuchao0@huawei.com>
To:     <jaegeuk@kernel.org>
CC:     <linux-f2fs-devel@lists.sourceforge.net>,
        <linux-kernel@vger.kernel.org>, <chao@kernel.org>,
        Chao Yu <yuchao0@huawei.com>
Subject: [PATCH] f2fs: clean up f2fs_may_encrypt()
Date:   Fri, 20 Mar 2020 18:18:31 +0800
Message-ID: <20200320101831.70611-1-yuchao0@huawei.com>
X-Mailer: git-send-email 2.18.0.rc1
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.120.216.130]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Merge below two conditions into f2fs_may_encrypt() for cleanup
- IS_ENCRYPTED()
- DUMMY_ENCRYPTION_ENABLED()

Signed-off-by: Chao Yu <yuchao0@huawei.com>
---
 fs/f2fs/dir.c   |  4 +---
 fs/f2fs/f2fs.h  | 13 +++++++++----
 fs/f2fs/namei.c |  4 +---
 3 files changed, 11 insertions(+), 10 deletions(-)

diff --git a/fs/f2fs/dir.c b/fs/f2fs/dir.c
index 0971ccc4664a..2accfc5e38d0 100644
--- a/fs/f2fs/dir.c
+++ b/fs/f2fs/dir.c
@@ -471,7 +471,6 @@ struct page *f2fs_init_inode_metadata(struct inode *inode, struct inode *dir,
 			struct page *dpage)
 {
 	struct page *page;
-	int dummy_encrypt = DUMMY_ENCRYPTION_ENABLED(F2FS_I_SB(dir));
 	int err;
 
 	if (is_inode_flag_set(inode, FI_NEW_INODE)) {
@@ -498,8 +497,7 @@ struct page *f2fs_init_inode_metadata(struct inode *inode, struct inode *dir,
 		if (err)
 			goto put_error;
 
-		if ((IS_ENCRYPTED(dir) || dummy_encrypt) &&
-					f2fs_may_encrypt(inode)) {
+		if (f2fs_may_encrypt(dir, inode)) {
 			err = fscrypt_inherit_context(dir, inode, page, false);
 			if (err)
 				goto put_error;
diff --git a/fs/f2fs/f2fs.h b/fs/f2fs/f2fs.h
index 09db79a20f8e..fcafa68212eb 100644
--- a/fs/f2fs/f2fs.h
+++ b/fs/f2fs/f2fs.h
@@ -3946,15 +3946,20 @@ static inline bool f2fs_lfs_mode(struct f2fs_sb_info *sbi)
 	return F2FS_OPTION(sbi).fs_mode == FS_MODE_LFS;
 }
 
-static inline bool f2fs_may_encrypt(struct inode *inode)
+static inline bool f2fs_may_encrypt(struct inode *dir, struct inode *inode)
 {
 #ifdef CONFIG_FS_ENCRYPTION
+	struct f2fs_sb_info *sbi = F2FS_I_SB(dir);
 	umode_t mode = inode->i_mode;
 
-	return (S_ISREG(mode) || S_ISDIR(mode) || S_ISLNK(mode));
-#else
-	return false;
+	/*
+	 * If the directory encrypted or dummy encryption enabled,
+	 * then we should encrypt the inode.
+	 */
+	if (IS_ENCRYPTED(dir) || DUMMY_ENCRYPTION_ENABLED(sbi))
+		return (S_ISREG(mode) || S_ISDIR(mode) || S_ISLNK(mode));
 #endif
+	return false;
 }
 
 static inline bool f2fs_may_compress(struct inode *inode)
diff --git a/fs/f2fs/namei.c b/fs/f2fs/namei.c
index b75c70813f9e..95cfbce062e8 100644
--- a/fs/f2fs/namei.c
+++ b/fs/f2fs/namei.c
@@ -75,9 +75,7 @@ static struct inode *f2fs_new_inode(struct inode *dir, umode_t mode)
 
 	set_inode_flag(inode, FI_NEW_INODE);
 
-	/* If the directory encrypted, then we should encrypt the inode. */
-	if ((IS_ENCRYPTED(dir) || DUMMY_ENCRYPTION_ENABLED(sbi)) &&
-				f2fs_may_encrypt(inode))
+	if (f2fs_may_encrypt(dir, inode))
 		f2fs_set_encrypted_inode(inode);
 
 	if (f2fs_sb_has_extra_attr(sbi)) {
-- 
2.18.0.rc1

