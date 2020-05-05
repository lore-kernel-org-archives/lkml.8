Return-Path: <SRS0=e3tL=6T=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 03C56C47259
	for <linux-kernel@archiver.kernel.org>; Tue,  5 May 2020 16:58:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id CD17C20836
	for <linux-kernel@archiver.kernel.org>; Tue,  5 May 2020 16:58:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1588697935;
	bh=N18rhaJtm01k8g6a0UjT7Q6LzqEp+W4aYkEI1nt+QGM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=WQ8bJ7fnGFz6wEYALjRBuE3mpc81fiB90dCjtviqVFLF6Njyb8dxBjLPx2uWVvL5R
	 RAtEkeTm8tk1jagc1eX1TNRdt9UQLZKo07fyZV2YzajQ5t7FOI7eX2ZhItm/lNEHDY
	 xqpZ3zcw/jl/bGAug2poEStN0/0SBUd0UsFP5lu8=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730706AbgEEQ6z (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 5 May 2020 12:58:55 -0400
Received: from mail.kernel.org ([198.145.29.99]:38888 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730672AbgEEQ6t (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 May 2020 12:58:49 -0400
Received: from gmail.com (unknown [104.132.1.76])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id B49B120757;
        Tue,  5 May 2020 16:58:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1588697928;
        bh=N18rhaJtm01k8g6a0UjT7Q6LzqEp+W4aYkEI1nt+QGM=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=MGVAziaxz2CPuV6fer1oeWX2KYKiEaAs3iXbuxTffNfh5rfa2+3lCDNDfJR97mRGz
         FR7XkyVbck8+3uHqPfXEA9DYmQ1TwPHGVfgOLtQD/FNDGlHK7UNxn86jwi3KrNKcaH
         bIefYvdqDROf14QqFG54fWlXC7ASGAUqAj+Gy+d4=
Date:   Tue, 5 May 2020 09:58:47 -0700
From:   Eric Biggers <ebiggers@kernel.org>
To:     Jaegeuk Kim <jaegeuk@kernel.org>
Cc:     linux-kernel@vger.kernel.org,
        linux-f2fs-devel@lists.sourceforge.net, kernel-team@android.com
Subject: Re: [f2fs-dev] [PATCH] f2fs: get parent inode when recovering pino
Message-ID: <20200505165847.GA98848@gmail.com>
References: <20200505153139.201697-1-jaegeuk@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200505153139.201697-1-jaegeuk@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, May 05, 2020 at 08:31:39AM -0700, Jaegeuk Kim wrote:
> We had to grab the inode before retrieving i_ino.
> 
> Signed-off-by: Jaegeuk Kim <jaegeuk@kernel.org>
> ---
>  fs/f2fs/file.c | 8 +++++++-
>  1 file changed, 7 insertions(+), 1 deletion(-)
> 
> diff --git a/fs/f2fs/file.c b/fs/f2fs/file.c
> index a0a4413d6083b..9d4c3e3503567 100644
> --- a/fs/f2fs/file.c
> +++ b/fs/f2fs/file.c
> @@ -168,6 +168,7 @@ static const struct vm_operations_struct f2fs_file_vm_ops = {
>  static int get_parent_ino(struct inode *inode, nid_t *pino)
>  {
>  	struct dentry *dentry;
> +	struct inode *parent;
>  
>  	inode = igrab(inode);
>  	dentry = d_find_any_alias(inode);
> @@ -175,8 +176,13 @@ static int get_parent_ino(struct inode *inode, nid_t *pino)
>  	if (!dentry)
>  		return 0;
>  
> -	*pino = parent_ino(dentry);
> +	parent = igrab(d_inode(dentry->d_parent));
>  	dput(dentry);
> +	if (!parent)
> +		return 0;
> +
> +	*pino = parent->i_ino;
> +	iput(parent);
>  	return 1;

This doesn't appear to be necessary.  parent_ino() is:

	spin_lock(&dentry->d_lock);
	res = dentry->d_parent->d_inode->i_ino;
	spin_unlock(&dentry->d_lock);

Since dentry is locked and referenced, ->d_parent is stable and positive.

In the encrypt+casefold patch I was reviewing, it's indeed necessary, but only
because there was a check of inode->i_flags added outside the locked region.
The following would be simpler:

        spin_lock(&dentry->d_lock);
        dir = dentry->d_parent->d_inode;
        *pino = dir->i_ino;
        needs_recovery = IS_ENCRYPTED(dir) && IS_CASEFOLDED(dir);
        spin_unlock(&dentry->d_lock);

BTW, d_find_any_alias() is unnecessary too.  This code should just be using
file_dentry(file) from f2fs_do_sync_file().

- Eric
