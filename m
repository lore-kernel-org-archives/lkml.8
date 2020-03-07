Return-Path: <SRS0=IBMW=4Y=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8039CC10F00
	for <linux-kernel@archiver.kernel.org>; Sat,  7 Mar 2020 00:24:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4D5E9206E6
	for <linux-kernel@archiver.kernel.org>; Sat,  7 Mar 2020 00:24:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1583540682;
	bh=B72rG1jwLbG2y/Xk21RtChGVMs08LLX26UA7wxJK7XI=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=0VEd/SToA0G7jmz7U2OpQijPBfPY4c4hRtcqf4XOLEgnV0gj/bBctR7VlonTpzJ7M
	 9YCPaQq86eT5a9ULqoSXwbnRH5WKb2fEu9cohXJEEmiGlWuTkhyA34Jze3Y/QfzsIU
	 GaEcfKbYw3ktIuhDQbFJtegOZH7rLoElGW8VY89M=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726769AbgCGAYl (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 6 Mar 2020 19:24:41 -0500
Received: from mail.kernel.org ([198.145.29.99]:59696 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726368AbgCGAYl (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 6 Mar 2020 19:24:41 -0500
Received: from localhost (unknown [104.132.1.66])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 901C0206E2;
        Sat,  7 Mar 2020 00:24:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1583540680;
        bh=B72rG1jwLbG2y/Xk21RtChGVMs08LLX26UA7wxJK7XI=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=tpSqdkzjbvlHV87zP5VZdFv9lE0mA/6eQJkWRgcGgYArXxTgvSeCyV8Z8vgOiD8Ku
         91oZt4IM9h1yIscyunfSHVvMeIaPPVyKpdb/Rv1cNXPvtx77nBUxiEHWy/UCmZ5nLp
         E1SSOAedqG+uu7BrqfC++0gy/ad+A7ngWYpF2or8=
Date:   Fri, 6 Mar 2020 16:24:40 -0800
From:   Jaegeuk Kim <jaegeuk@kernel.org>
To:     linux-kernel@vger.kernel.org,
        linux-f2fs-devel@lists.sourceforge.net
Cc:     Daniel Rosenberg <drosen@google.com>, kernel-team@android.com
Subject: Re: [PATCH v2] f2fs: fix wrong check on F2FS_IOC_FSSETXATTR
Message-ID: <20200307002440.GA7944@google.com>
References: <20200305234822.178708-1-jaegeuk@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200305234822.178708-1-jaegeuk@kernel.org>
User-Agent: Mutt/1.12.2 (2019-09-21)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This fixes the incorrect failure when enabling project quota on casefold-enabled
file.

Cc: Daniel Rosenberg <drosen@google.com>
Cc: kernel-team@android.com
Signed-off-by: Jaegeuk Kim <jaegeuk@kernel.org>
---
 log from v1:
  - fix the last check

 fs/f2fs/file.c | 13 ++++++++-----
 1 file changed, 8 insertions(+), 5 deletions(-)

diff --git a/fs/f2fs/file.c b/fs/f2fs/file.c
index b443dc2947c7..07f636732199 100644
--- a/fs/f2fs/file.c
+++ b/fs/f2fs/file.c
@@ -1794,12 +1794,15 @@ static int f2fs_file_flush(struct file *file, fl_owner_t id)
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
@@ -1813,9 +1816,9 @@ static int f2fs_setflags_common(struct inode *inode, u32 iflags, u32 mask)
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
@@ -1832,8 +1835,8 @@ static int f2fs_setflags_common(struct inode *inode, u32 iflags, u32 mask)
 			set_compress_context(inode);
 		}
 	}
-	if ((iflags ^ fi->i_flags) & F2FS_NOCOMP_FL) {
-		if (fi->i_flags & F2FS_COMPR_FL)
+	if ((iflags ^ masked_flags) & F2FS_NOCOMP_FL) {
+		if (masked_flags & F2FS_COMPR_FL)
 			return -EINVAL;
 	}
 
-- 
2.25.1.481.gfbce0eb801-goog

