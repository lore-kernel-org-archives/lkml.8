Return-Path: <SRS0=j27y=4W=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E9698C3F2D2
	for <linux-kernel@archiver.kernel.org>; Thu,  5 Mar 2020 23:48:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9EC6A207FD
	for <linux-kernel@archiver.kernel.org>; Thu,  5 Mar 2020 23:48:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1583452105;
	bh=Y8k9h7kxv3IqWsza/9KnsqFOgRnXjD8bfknBAcC9/r0=;
	h=From:To:Cc:Subject:Date:List-ID:From;
	b=2WgMp3zC09eWkoG5ZBvwnaURvOp7rLUFfaDyByCSGejPN6LM3ENgiVEdSCqYDm2uG
	 BDmLHbdVjTCz3exiAS19Qlk+Q5IS7R/zt9vammdaZjDOiys751l0RcZ1uUG2+zT3OK
	 X8BWp7AdYZ9vaH+AvOLj/lvkRY0+FBJ7k4WRo4ns=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726565AbgCEXsY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 5 Mar 2020 18:48:24 -0500
Received: from mail.kernel.org ([198.145.29.99]:40776 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726128AbgCEXsY (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Mar 2020 18:48:24 -0500
Received: from localhost (unknown [104.132.1.66])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id B6DF520717;
        Thu,  5 Mar 2020 23:48:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1583452103;
        bh=Y8k9h7kxv3IqWsza/9KnsqFOgRnXjD8bfknBAcC9/r0=;
        h=From:To:Cc:Subject:Date:From;
        b=wH8SH9C9ro8FdneBLDrrJ9SUXN2tdQghLktAMkrilfz1+rzpfUrw4lqDYaesj5Ca0
         m8DCIKEmQrBXBoFYP8hEPOgYZUrOUQMeYOkApWlw3JCa9cf0zI3LbAUatrnc/5Q8Af
         TsavOfgjoF0U0sMouWvpP2kureiblQOZM9PxOX/c=
From:   Jaegeuk Kim <jaegeuk@kernel.org>
To:     linux-kernel@vger.kernel.org,
        linux-f2fs-devel@lists.sourceforge.net
Cc:     Jaegeuk Kim <jaegeuk@kernel.org>,
        Daniel Rosenberg <drosen@google.com>
Subject: [PATCH] f2fs: fix wrong check on F2FS_IOC_FSSETXATTR
Date:   Thu,  5 Mar 2020 15:48:22 -0800
Message-Id: <20200305234822.178708-1-jaegeuk@kernel.org>
X-Mailer: git-send-email 2.25.1.481.gfbce0eb801-goog
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This fixes the incorrect failure when enabling project quota on casefold-enabled
file.

Cc: Daniel Rosenberg <drosen@google.com>
Signed-off-by: Jaegeuk Kim <jaegeuk@kernel.org>
---
 fs/f2fs/file.c | 19 +++++++++++--------
 1 file changed, 11 insertions(+), 8 deletions(-)

diff --git a/fs/f2fs/file.c b/fs/f2fs/file.c
index fb070816a8a5..8a41afac0346 100644
--- a/fs/f2fs/file.c
+++ b/fs/f2fs/file.c
@@ -1789,12 +1789,15 @@ static int f2fs_file_flush(struct file *file, fl_owner_t id)
 static int f2fs_setflags_common(struct inode *inode, u32 iflags, u32 mask)
 {
 	struct f2fs_inode_info *fi = F2FS_I(inode);
+	u32 masked_flags = fi->i_flags & mask;
+
+	f2fs_bug_on(F2FS_I_SB(inode), (iflags & ~mask));
 
 	/* Is it quota file? Do not allow user to mess with it */
 	if (IS_NOQUOTA(inode))
 		return -EPERM;
 
-	if ((iflags ^ fi->i_flags) & F2FS_CASEFOLD_FL) {
+	if ((iflags ^ masked_flags) & F2FS_CASEFOLD_FL) {
 		if (!f2fs_sb_has_casefold(F2FS_I_SB(inode)))
 			return -EOPNOTSUPP;
 		if (!f2fs_empty_dir(inode))
@@ -1808,9 +1811,9 @@ static int f2fs_setflags_common(struct inode *inode, u32 iflags, u32 mask)
 			return -EINVAL;
 	}
 
-	if ((iflags ^ fi->i_flags) & F2FS_COMPR_FL) {
+	if ((iflags ^ masked_flags) & F2FS_COMPR_FL) {
 		if (S_ISREG(inode->i_mode) &&
-			(fi->i_flags & F2FS_COMPR_FL || i_size_read(inode) ||
+			(masked_flags & F2FS_COMPR_FL || i_size_read(inode) ||
 						F2FS_HAS_BLOCKS(inode)))
 			return -EINVAL;
 		if (iflags & F2FS_NOCOMP_FL)
@@ -1827,16 +1830,16 @@ static int f2fs_setflags_common(struct inode *inode, u32 iflags, u32 mask)
 			set_compress_context(inode);
 		}
 	}
-	if ((iflags ^ fi->i_flags) & F2FS_NOCOMP_FL) {
-		if (fi->i_flags & F2FS_COMPR_FL)
+	if ((iflags ^ masked_flags) & F2FS_NOCOMP_FL) {
+		if (masked_flags & F2FS_COMPR_FL)
 			return -EINVAL;
 	}
 
 	fi->i_flags = iflags | (fi->i_flags & ~mask);
-	f2fs_bug_on(F2FS_I_SB(inode), (fi->i_flags & F2FS_COMPR_FL) &&
-					(fi->i_flags & F2FS_NOCOMP_FL));
+	f2fs_bug_on(F2FS_I_SB(inode), (masked_flags & F2FS_COMPR_FL) &&
+					(masked_flags & F2FS_NOCOMP_FL));
 
-	if (fi->i_flags & F2FS_PROJINHERIT_FL)
+	if (masked_flags & F2FS_PROJINHERIT_FL)
 		set_inode_flag(inode, FI_PROJ_INHERIT);
 	else
 		clear_inode_flag(inode, FI_PROJ_INHERIT);
-- 
2.25.1.481.gfbce0eb801-goog

