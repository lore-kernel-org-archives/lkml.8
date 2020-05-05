Return-Path: <SRS0=e3tL=6T=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AE48FC47247
	for <linux-kernel@archiver.kernel.org>; Tue,  5 May 2020 18:20:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 82B5420746
	for <linux-kernel@archiver.kernel.org>; Tue,  5 May 2020 18:20:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1588702844;
	bh=ZeZCawDZUxiAGh0E3Qdw7+DHNfklBHHQq4cW7/Bml1U=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=tASzaYun8qePKUS55uEY/Q9dkWsAvNJYiueCZxZFAv8Ddcn2UgC1ydZ92bQTrziWM
	 3m8blGoHlJ0D0mxYJQYnuDkXaJ408MhCg1zr2HR84F6UNdKz+quvbPLZNWtwe/oM18
	 YyNyEw1CtWXbnphJh4oWowbGwbtpnoNOVCohLEck=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730829AbgEESUn (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 5 May 2020 14:20:43 -0400
Received: from mail.kernel.org ([198.145.29.99]:33964 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730258AbgEESUn (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 May 2020 14:20:43 -0400
Received: from localhost (unknown [104.132.1.66])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id BF34120663;
        Tue,  5 May 2020 18:20:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1588702842;
        bh=ZeZCawDZUxiAGh0E3Qdw7+DHNfklBHHQq4cW7/Bml1U=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=Qr8sn+d/XkZ7CgQ1XtQVpjFRuDwIcGITLQPkbrbVzG5PSjG6JGHdc/ShQxFBdAV5V
         gw2WRMZ5iN+VkVXnZ3C7AfsCUyVLU8TGOQrOTGHeE4P9FPT/TTS59GUv94ZIqMIABI
         MbmoyN8KRbxCwflXMmYOETX6jNAL3NCyNirFJkk8=
Date:   Tue, 5 May 2020 11:20:42 -0700
From:   Jaegeuk Kim <jaegeuk@kernel.org>
To:     Eric Biggers <ebiggers@kernel.org>
Cc:     kernel-team@android.com, linux-kernel@vger.kernel.org,
        linux-f2fs-devel@lists.sourceforge.net
Subject: Re: [f2fs-dev] [PATCH] f2fs: get parent inode when recovering pino
Message-ID: <20200505182042.GB55221@google.com>
References: <20200505153139.201697-1-jaegeuk@kernel.org>
 <20200505165847.GA98848@gmail.com>
 <20200505175907.GB98848@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200505175907.GB98848@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 05/05, Eric Biggers wrote:
> On Tue, May 05, 2020 at 09:58:47AM -0700, Eric Biggers wrote:
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
> > 
> > This doesn't appear to be necessary.  parent_ino() is:
> > 
> > 	spin_lock(&dentry->d_lock);
> > 	res = dentry->d_parent->d_inode->i_ino;
> > 	spin_unlock(&dentry->d_lock);
> > 
> > Since dentry is locked and referenced, ->d_parent is stable and positive.
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
> > 
> > BTW, d_find_any_alias() is unnecessary too.  This code should just be using
> > file_dentry(file) from f2fs_do_sync_file().
> > 
> 
> Also, what is this code trying to accomplish?  If it's trying to find the parent
> directory of an inode with i_nlink == 1, this isn't the correct way to do it.
> The fsync could be done via a deleted file, which would make the wrong p_ino be
> set.  I think the correct approach would be to iterate through all the dentry's
> aliases, and choose the parent directory that's !IS_DEADDIR().

The intention is to give a chance to recover the pino to avoid performance
drop on fsync() by avoiding checkpoint(). And the purpose of this is to
find a file having single linked file. Otherwise, we'll do checkpoint().

> 
> - Eric
