Return-Path: <SRS0=e3tL=6T=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1B49AC47247
	for <linux-kernel@archiver.kernel.org>; Tue,  5 May 2020 18:13:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id EDF6820721
	for <linux-kernel@archiver.kernel.org>; Tue,  5 May 2020 18:13:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1588702406;
	bh=GmW9mQvHRC2Cd+ADxz/wgUVnW2SrOFLgvsOsFvoyrWg=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=f01xP127TvH11qGviDeLtSl0frpCdS+Navhp8xHJFaVDdUQkgE9MkOerHuDOTK6Eu
	 9anjoGZyA24MFu8NpZw6QMlTtaEbOOiSfG0xCT4UVTo3IKSGbIDdUVe/lqq+cka2bZ
	 EY8wd1Hw0B4SqAoFxjoNnmhnmISvdV74VMd63ifE=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730679AbgEESNZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 5 May 2020 14:13:25 -0400
Received: from mail.kernel.org ([198.145.29.99]:58180 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730184AbgEESNY (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 May 2020 14:13:24 -0400
Received: from localhost (unknown [104.132.1.66])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id CF9A7206B8;
        Tue,  5 May 2020 18:13:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1588702403;
        bh=GmW9mQvHRC2Cd+ADxz/wgUVnW2SrOFLgvsOsFvoyrWg=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=gZ60ss3C4IR6xeevDKzqUS/95khLsTvk+PrFSive0K2J/tK0Pb+U/Lk9j6H+h94rX
         vMBKXVsyALZ8Dlz1Wzz9PlgjkuKR3w8AucNWlYg/j8iWZ51Or7chsj5JUuwpRaogf1
         c61ueuFcl4mPNdrnLAkBFK5mQBjJ+LH0IdQnQKA4=
Date:   Tue, 5 May 2020 11:13:23 -0700
From:   Jaegeuk Kim <jaegeuk@kernel.org>
To:     Eric Biggers <ebiggers@kernel.org>
Cc:     linux-kernel@vger.kernel.org,
        linux-f2fs-devel@lists.sourceforge.net, kernel-team@android.com
Subject: Re: [f2fs-dev] [PATCH] f2fs: get parent inode when recovering pino
Message-ID: <20200505181323.GA55221@google.com>
References: <20200505153139.201697-1-jaegeuk@kernel.org>
 <20200505165847.GA98848@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200505165847.GA98848@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 05/05, Eric Biggers wrote:
> On Tue, May 05, 2020 at 08:31:39AM -0700, Jaegeuk Kim wrote:
> > We had to grab the inode before retrieving i_ino.
> > 
> > Signed-off-by: Jaegeuk Kim <jaegeuk@kernel.org>
> > ---
> >  fs/f2fs/file.c | 8 +++++++-
> >  1 file changed, 7 insertions(+), 1 deletion(-)
> > 
> > diff --git a/fs/f2fs/file.c b/fs/f2fs/file.c
> > index a0a4413d6083b..9d4c3e3503567 100644
> > --- a/fs/f2fs/file.c
> > +++ b/fs/f2fs/file.c
> > @@ -168,6 +168,7 @@ static const struct vm_operations_struct f2fs_file_vm_ops = {
> >  static int get_parent_ino(struct inode *inode, nid_t *pino)
> >  {
> >  	struct dentry *dentry;
> > +	struct inode *parent;
> >  
> >  	inode = igrab(inode);
> >  	dentry = d_find_any_alias(inode);
> > @@ -175,8 +176,13 @@ static int get_parent_ino(struct inode *inode, nid_t *pino)
> >  	if (!dentry)
> >  		return 0;
> >  
> > -	*pino = parent_ino(dentry);
> > +	parent = igrab(d_inode(dentry->d_parent));
> >  	dput(dentry);
> > +	if (!parent)
> > +		return 0;
> > +
> > +	*pino = parent->i_ino;
> > +	iput(parent);
> >  	return 1;

Hi Eric,

> 
> This doesn't appear to be necessary.  parent_ino() is:
> 
> 	spin_lock(&dentry->d_lock);
> 	res = dentry->d_parent->d_inode->i_ino;
> 	spin_unlock(&dentry->d_lock);
> 
> Since dentry is locked and referenced, ->d_parent is stable and positive.

I see, thanks. :)

> 
> In the encrypt+casefold patch I was reviewing, it's indeed necessary, but only
> because there was a check of inode->i_flags added outside the locked region.
> The following would be simpler:
> 
>         spin_lock(&dentry->d_lock);
>         dir = dentry->d_parent->d_inode;
>         *pino = dir->i_ino;
>         needs_recovery = IS_ENCRYPTED(dir) && IS_CASEFOLDED(dir);
>         spin_unlock(&dentry->d_lock);

Ack.

> 
> BTW, d_find_any_alias() is unnecessary too.  This code should just be using
> file_dentry(file) from f2fs_do_sync_file().

How about this?

From 9aee969a413b1ed22b48573071bc93fbb4a2002d Mon Sep 17 00:00:00 2001
From: Jaegeuk Kim <jaegeuk@kernel.org>
Date: Tue, 5 May 2020 11:08:58 -0700
Subject: [PATCH] f2fs: remove unnecessary dentry locks

As Eric commented, let's kill unnecessary dentry ops when recovering
parent inode number.

Suggested-by: Eric Biggers <ebiggers@kernel.org>
Signed-off-by: Jaegeuk Kim <jaegeuk@kernel.org>
---
 fs/f2fs/file.c | 26 ++++++--------------------
 1 file changed, 6 insertions(+), 20 deletions(-)

diff --git a/fs/f2fs/file.c b/fs/f2fs/file.c
index a0a4413d6083b..711cebad36fc5 100644
--- a/fs/f2fs/file.c
+++ b/fs/f2fs/file.c
@@ -165,21 +165,6 @@ static const struct vm_operations_struct f2fs_file_vm_ops = {
 	.page_mkwrite	= f2fs_vm_page_mkwrite,
 };
 
-static int get_parent_ino(struct inode *inode, nid_t *pino)
-{
-	struct dentry *dentry;
-
-	inode = igrab(inode);
-	dentry = d_find_any_alias(inode);
-	iput(inode);
-	if (!dentry)
-		return 0;
-
-	*pino = parent_ino(dentry);
-	dput(dentry);
-	return 1;
-}
-
 static inline enum cp_reason_type need_do_checkpoint(struct inode *inode)
 {
 	struct f2fs_sb_info *sbi = F2FS_I_SB(inode);
@@ -223,14 +208,15 @@ static bool need_inode_page_update(struct f2fs_sb_info *sbi, nid_t ino)
 	return ret;
 }
 
-static void try_to_fix_pino(struct inode *inode)
+static void try_to_fix_pino(struct dentry *dentry)
 {
+	struct inode *inode = d_inode(dentry);
 	struct f2fs_inode_info *fi = F2FS_I(inode);
-	nid_t pino;
 
 	down_write(&fi->i_sem);
-	if (file_wrong_pino(inode) && inode->i_nlink == 1 &&
-			get_parent_ino(inode, &pino)) {
+	if (file_wrong_pino(inode) && inode->i_nlink == 1) {
+		nid_t pino = parent_ino(dentry);
+
 		f2fs_i_pino_write(inode, pino);
 		file_got_pino(inode);
 	}
@@ -310,7 +296,7 @@ static int f2fs_do_sync_file(struct file *file, loff_t start, loff_t end,
 		 * We've secured consistency through sync_fs. Following pino
 		 * will be used only for fsynced inodes after checkpoint.
 		 */
-		try_to_fix_pino(inode);
+		try_to_fix_pino(file_dentry(file));
 		clear_inode_flag(inode, FI_APPEND_WRITE);
 		clear_inode_flag(inode, FI_UPDATE_WRITE);
 		goto out;
-- 
2.26.2.526.g744177e7f7-goog

