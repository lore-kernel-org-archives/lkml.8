Return-Path: <SRS0=e3tL=6T=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F1BC5C47247
	for <linux-kernel@archiver.kernel.org>; Tue,  5 May 2020 18:19:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id BEC31206CC
	for <linux-kernel@archiver.kernel.org>; Tue,  5 May 2020 18:19:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1588702784;
	bh=yZzkSmvvKpe0G5yUuD0K6ah1YcmbfcINzZSizvYm2fE=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=D8PMlT1OJhT30nM2ghHOe5tiCxWtZK0uZ9v+vFVWziDdQLbM85u5LXcz6RmTGdsvR
	 MtAPo97H89OavmJPwFksGLq7uyODH2FMczNCS4PVTSQ7xowjPvetf0HAzjwz3yl8Ss
	 S2mK6I8dNAVx6chKHd3bE8EUypzeTJPQXrdXub08=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730798AbgEESTo (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 5 May 2020 14:19:44 -0400
Received: from mail.kernel.org ([198.145.29.99]:33662 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730258AbgEESTn (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 May 2020 14:19:43 -0400
Received: from gmail.com (unknown [104.132.1.76])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id A218E20663;
        Tue,  5 May 2020 18:19:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1588702782;
        bh=yZzkSmvvKpe0G5yUuD0K6ah1YcmbfcINzZSizvYm2fE=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=R67Z/lbPtsO5THBxKzX2UlLhSUm2vt0TOUX9sbZh4djBdEvxdDZsZKamROXY/lUDk
         45RwmPjXsu/PJUGCFkivx2adACAXmQgXLE9PpopTyfNZZUgoXkvJRiKgv2s65OjKWz
         ZxQGDWUnKqLxY8xjBuFDHX627MfXB7blez9pNJvE=
Date:   Tue, 5 May 2020 11:19:41 -0700
From:   Eric Biggers <ebiggers@kernel.org>
To:     Jaegeuk Kim <jaegeuk@kernel.org>
Cc:     linux-kernel@vger.kernel.org,
        linux-f2fs-devel@lists.sourceforge.net, kernel-team@android.com
Subject: Re: [f2fs-dev] [PATCH] f2fs: get parent inode when recovering pino
Message-ID: <20200505181941.GC98848@gmail.com>
References: <20200505153139.201697-1-jaegeuk@kernel.org>
 <20200505165847.GA98848@gmail.com>
 <20200505181323.GA55221@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200505181323.GA55221@google.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, May 05, 2020 at 11:13:23AM -0700, Jaegeuk Kim wrote:
> On 05/05, Eric Biggers wrote:
> > On Tue, May 05, 2020 at 08:31:39AM -0700, Jaegeuk Kim wrote:
> > > We had to grab the inode before retrieving i_ino.
> > > 
> > > Signed-off-by: Jaegeuk Kim <jaegeuk@kernel.org>
> > > ---
> > >  fs/f2fs/file.c | 8 +++++++-
> > >  1 file changed, 7 insertions(+), 1 deletion(-)
> > > 
> > > diff --git a/fs/f2fs/file.c b/fs/f2fs/file.c
> > > index a0a4413d6083b..9d4c3e3503567 100644
> > > --- a/fs/f2fs/file.c
> > > +++ b/fs/f2fs/file.c
> > > @@ -168,6 +168,7 @@ static const struct vm_operations_struct f2fs_file_vm_ops = {
> > >  static int get_parent_ino(struct inode *inode, nid_t *pino)
> > >  {
> > >  	struct dentry *dentry;
> > > +	struct inode *parent;
> > >  
> > >  	inode = igrab(inode);
> > >  	dentry = d_find_any_alias(inode);
> > > @@ -175,8 +176,13 @@ static int get_parent_ino(struct inode *inode, nid_t *pino)
> > >  	if (!dentry)
> > >  		return 0;
> > >  
> > > -	*pino = parent_ino(dentry);
> > > +	parent = igrab(d_inode(dentry->d_parent));
> > >  	dput(dentry);
> > > +	if (!parent)
> > > +		return 0;
> > > +
> > > +	*pino = parent->i_ino;
> > > +	iput(parent);
> > >  	return 1;
> 
> Hi Eric,
> 
> > 
> > This doesn't appear to be necessary.  parent_ino() is:
> > 
> > 	spin_lock(&dentry->d_lock);
> > 	res = dentry->d_parent->d_inode->i_ino;
> > 	spin_unlock(&dentry->d_lock);
> > 
> > Since dentry is locked and referenced, ->d_parent is stable and positive.
> 
> I see, thanks. :)
> 
> > 
> > In the encrypt+casefold patch I was reviewing, it's indeed necessary, but only
> > because there was a check of inode->i_flags added outside the locked region.
> > The following would be simpler:
> > 
> >         spin_lock(&dentry->d_lock);
> >         dir = dentry->d_parent->d_inode;
> >         *pino = dir->i_ino;
> >         needs_recovery = IS_ENCRYPTED(dir) && IS_CASEFOLDED(dir);
> >         spin_unlock(&dentry->d_lock);
> 
> Ack.
> 
> > 
> > BTW, d_find_any_alias() is unnecessary too.  This code should just be using
> > file_dentry(file) from f2fs_do_sync_file().
> 
> How about this?
> 
> From 9aee969a413b1ed22b48573071bc93fbb4a2002d Mon Sep 17 00:00:00 2001
> From: Jaegeuk Kim <jaegeuk@kernel.org>
> Date: Tue, 5 May 2020 11:08:58 -0700
> Subject: [PATCH] f2fs: remove unnecessary dentry locks
> 
> As Eric commented, let's kill unnecessary dentry ops when recovering
> parent inode number.
> 
> Suggested-by: Eric Biggers <ebiggers@kernel.org>
> Signed-off-by: Jaegeuk Kim <jaegeuk@kernel.org>
> ---
>  fs/f2fs/file.c | 26 ++++++--------------------
>  1 file changed, 6 insertions(+), 20 deletions(-)
> 
> diff --git a/fs/f2fs/file.c b/fs/f2fs/file.c
> index a0a4413d6083b..711cebad36fc5 100644
> --- a/fs/f2fs/file.c
> +++ b/fs/f2fs/file.c
> @@ -165,21 +165,6 @@ static const struct vm_operations_struct f2fs_file_vm_ops = {
>  	.page_mkwrite	= f2fs_vm_page_mkwrite,
>  };
>  
> -static int get_parent_ino(struct inode *inode, nid_t *pino)
> -{
> -	struct dentry *dentry;
> -
> -	inode = igrab(inode);
> -	dentry = d_find_any_alias(inode);
> -	iput(inode);
> -	if (!dentry)
> -		return 0;
> -
> -	*pino = parent_ino(dentry);
> -	dput(dentry);
> -	return 1;
> -}
> -
>  static inline enum cp_reason_type need_do_checkpoint(struct inode *inode)
>  {
>  	struct f2fs_sb_info *sbi = F2FS_I_SB(inode);
> @@ -223,14 +208,15 @@ static bool need_inode_page_update(struct f2fs_sb_info *sbi, nid_t ino)
>  	return ret;
>  }
>  
> -static void try_to_fix_pino(struct inode *inode)
> +static void try_to_fix_pino(struct dentry *dentry)
>  {
> +	struct inode *inode = d_inode(dentry);
>  	struct f2fs_inode_info *fi = F2FS_I(inode);
> -	nid_t pino;
>  
>  	down_write(&fi->i_sem);
> -	if (file_wrong_pino(inode) && inode->i_nlink == 1 &&
> -			get_parent_ino(inode, &pino)) {
> +	if (file_wrong_pino(inode) && inode->i_nlink == 1) {
> +		nid_t pino = parent_ino(dentry);
> +
>  		f2fs_i_pino_write(inode, pino);
>  		file_got_pino(inode);
>  	}
> @@ -310,7 +296,7 @@ static int f2fs_do_sync_file(struct file *file, loff_t start, loff_t end,
>  		 * We've secured consistency through sync_fs. Following pino
>  		 * will be used only for fsynced inodes after checkpoint.
>  		 */
> -		try_to_fix_pino(inode);
> +		try_to_fix_pino(file_dentry(file));
>  		clear_inode_flag(inode, FI_APPEND_WRITE);
>  		clear_inode_flag(inode, FI_UPDATE_WRITE);
>  		goto out;

Actually, I think this is wrong because the fsync can be done via a file
descriptor that was opened to a now-deleted link to the file.

We need to find the dentry whose parent directory is still exists, i.e. the
parent directory that is counting towards 'inode->i_nlink == 1'.

I think d_find_alias() is what we're looking for.

diff --git a/fs/f2fs/file.c b/fs/f2fs/file.c
index 6ab8f621a3c5..855f27468baa 100644
--- a/fs/f2fs/file.c
+++ b/fs/f2fs/file.c
@@ -165,13 +165,13 @@ static int get_parent_ino(struct inode *inode, nid_t *pino)
 {
        struct dentry *dentry;

-       inode = igrab(inode);
-       dentry = d_find_any_alias(inode);
-       iput(inode);
+       dentry = d_find_alias(inode);
        if (!dentry)
                return 0;

