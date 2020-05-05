Return-Path: <SRS0=e3tL=6T=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6F1EAC47247
	for <linux-kernel@archiver.kernel.org>; Tue,  5 May 2020 19:08:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3CEC1206FA
	for <linux-kernel@archiver.kernel.org>; Tue,  5 May 2020 19:08:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1588705713;
	bh=mVzsMafczB2qs5W4j7HW8BQBAAFyRC6PAqX0Q2mK0f0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=LFgn8B7FTLnFME1VzLP5JcWwXeC66pS9pUw4T1QqrvUP+xo0PDGR8ZPenALBqaZGj
	 ynMG8NbGk/B2OX1mw8L3Vw4OWgXVM9/9UdzOpcelJCvJCsYph436CQLX1hi+mKhuvr
	 zXYN06aSrp1Z6Jn1rils8pArrXq/8aPkzZbNt2H4=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728885AbgEETIc (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 5 May 2020 15:08:32 -0400
Received: from mail.kernel.org ([198.145.29.99]:52082 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726350AbgEETIb (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 May 2020 15:08:31 -0400
Received: from localhost (unknown [104.132.1.66])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id DD2D8206B9;
        Tue,  5 May 2020 19:08:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1588705711;
        bh=mVzsMafczB2qs5W4j7HW8BQBAAFyRC6PAqX0Q2mK0f0=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=RU4+H/3k94TUb+vRJxvUd8LSDzIgogLbrBNFDkfR3mygf+YHJmSZMOf+B+YiBYuNy
         1wG0m+djLQeonwmVQbvpOrvhow9qHKFDC45NJzjo4/v0QI/fVWF3fc0opCi9eht0R9
         RiOUZpZAAL3vMsupVogRK1IKdHnQvjZgpCQQyPtg=
Date:   Tue, 5 May 2020 12:08:30 -0700
From:   Jaegeuk Kim <jaegeuk@kernel.org>
To:     Eric Biggers <ebiggers@kernel.org>
Cc:     linux-kernel@vger.kernel.org,
        linux-f2fs-devel@lists.sourceforge.net, kernel-team@android.com
Subject: Re: [f2fs-dev] [PATCH] f2fs: get parent inode when recovering pino
Message-ID: <20200505190830.GD55221@google.com>
References: <20200505153139.201697-1-jaegeuk@kernel.org>
 <20200505165847.GA98848@gmail.com>
 <20200505181323.GA55221@google.com>
 <20200505181941.GC98848@gmail.com>
 <20200505184932.GC55221@google.com>
 <20200505190108.GB128280@sol.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200505190108.GB128280@sol.localdomain>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 05/05, Eric Biggers wrote:
> On Tue, May 05, 2020 at 11:49:32AM -0700, Jaegeuk Kim wrote:
> > How about this?
> > 
> > From 2a6b0e53e592854306062a2dc35db2d8f79062f2 Mon Sep 17 00:00:00 2001
> > From: Jaegeuk Kim <jaegeuk@kernel.org>
> > Date: Tue, 5 May 2020 11:33:29 -0700
> > Subject: [PATCH] f2fs: find a living dentry when finding parent ino
> > 
> > We need to check any dentry still alive to get parent inode number.
> > 
> > Suggested-by: Eric Biggers <ebiggers@kernel.org>
> > Signed-off-by: Jaegeuk Kim <jaegeuk@kernel.org>
> > ---
> >  fs/f2fs/file.c | 5 ++---
> >  1 file changed, 2 insertions(+), 3 deletions(-)
> > 
> > diff --git a/fs/f2fs/file.c b/fs/f2fs/file.c
> > index a0a4413d6083b..95139cb85faca 100644
> > --- a/fs/f2fs/file.c
> > +++ b/fs/f2fs/file.c
> > @@ -169,9 +169,8 @@ static int get_parent_ino(struct inode *inode, nid_t *pino)
> >  {
> >  	struct dentry *dentry;
> >  
> > -	inode = igrab(inode);
> > -	dentry = d_find_any_alias(inode);
> > -	iput(inode);
> > +	/* Need to check if valid dentry still exists. */
> > +	dentry = d_find_alias(inode);
> >  	if (!dentry)
> >  		return 0;
> >  
> 
> It's fine, but it could use some more explanation.  (What's a "valid dentry"?)
> How about the following?

Cool, I took this. Thanks,

> 
> >From f8fe7d57eead1423e8548ac7a5ec881d701466a5 Mon Sep 17 00:00:00 2001
> From: Eric Biggers <ebiggers@google.com>
> Date: Tue, 5 May 2020 11:41:11 -0700
> Subject: [PATCH] f2fs: correctly fix the parent inode number during fsync()
> 
> fsync() may be called on a deleted file that's still open.  So when
> fsync() tries to set the parent inode number when the inode has
> LOST_PINO and i_nlink == 1 (to avoid later checkpoints), it needs to
> make sure to get the parent directory via a non-deleted alias.
> 
> Also remove the unnecessary igrab() and iput(), as the caller already
> holds a reference to the inode.
> 
> Signed-off-by: Eric Biggers <ebiggers@google.com>
> ---
>  fs/f2fs/file.c | 8 +++++---
>  1 file changed, 5 insertions(+), 3 deletions(-)
> 
> diff --git a/fs/f2fs/file.c b/fs/f2fs/file.c
> index 6ab8f621a3c5a2..b3069188fd3478 100644
> --- a/fs/f2fs/file.c
> +++ b/fs/f2fs/file.c
> @@ -165,9 +165,11 @@ static int get_parent_ino(struct inode *inode, nid_t *pino)
>  {
>  	struct dentry *dentry;
>  
> -	inode = igrab(inode);
> -	dentry = d_find_any_alias(inode);
> -	iput(inode);
> +	/*
> +	 * Make sure to get the non-deleted alias.  The alias associated with
> +	 * the open file descriptor being fsync()'ed may be deleted already.
> +	 */
> +	dentry = d_find_alias(inode);
>  	if (!dentry)
>  		return 0;
>  
> -- 
> 2.26.2
