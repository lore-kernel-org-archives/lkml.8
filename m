Return-Path: <SRS0=Xzqw=5F=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B0E66C4332D
	for <linux-kernel@archiver.kernel.org>; Fri, 20 Mar 2020 19:08:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 804B220775
	for <linux-kernel@archiver.kernel.org>; Fri, 20 Mar 2020 19:08:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1584731283;
	bh=misA3EzkdffBZ3aysYeGsyJ9FFPtYgTX3fo69Cz7vtY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=QagN6xhXdQYprnpqZw2tfFM+x9zQo/W6dMo8Iqal33dj4krgFzybbutdAgLkx3fgJ
	 OWZJNOqzTUNLEYXu4tAA2YHro3IyQRhEU9hQxC6CW1FZqUh8LXpWJVDBGCRtjZ2aXD
	 1hEEIXqeMfYxGLXRcSSYZidFerjaPdS1v8B0Yxzw=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727224AbgCTTIC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 20 Mar 2020 15:08:02 -0400
Received: from mail.kernel.org ([198.145.29.99]:52070 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726738AbgCTTIC (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 Mar 2020 15:08:02 -0400
Received: from sol.localdomain (c-107-3-166-239.hsd1.ca.comcast.net [107.3.166.239])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 15BC920767;
        Fri, 20 Mar 2020 19:08:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1584731281;
        bh=misA3EzkdffBZ3aysYeGsyJ9FFPtYgTX3fo69Cz7vtY=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=Tef5Vl944UuHb2eojwiNWF6ceUS3tnRapEQ2gk6xcj5X2wBygT7ThCakDv9IvvBot
         oY2+1hgbgzo+xbysOofBVsn1o2h9HVGtcXlHH6M+kduDa0/mZG4vlge64+hqKgC/X2
         800BYcn8nWfY5V7xWkq9k79mOh4TJWZSdLP2yenI=
Date:   Fri, 20 Mar 2020 12:07:59 -0700
From:   Eric Biggers <ebiggers@kernel.org>
To:     Chao Yu <yuchao0@huawei.com>
Cc:     jaegeuk@kernel.org, linux-kernel@vger.kernel.org,
        linux-f2fs-devel@lists.sourceforge.net
Subject: Re: [PATCH] f2fs: clean up f2fs_may_encrypt()
Message-ID: <20200320190759.GK851@sol.localdomain>
References: <20200320101831.70611-1-yuchao0@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200320101831.70611-1-yuchao0@huawei.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Mar 20, 2020 at 06:18:31PM +0800, Chao Yu wrote:
> Merge below two conditions into f2fs_may_encrypt() for cleanup
> - IS_ENCRYPTED()
> - DUMMY_ENCRYPTION_ENABLED()
> 
> Signed-off-by: Chao Yu <yuchao0@huawei.com>
> ---
>  fs/f2fs/dir.c   |  4 +---
>  fs/f2fs/f2fs.h  | 13 +++++++++----
>  fs/f2fs/namei.c |  4 +---
>  3 files changed, 11 insertions(+), 10 deletions(-)
> 
> diff --git a/fs/f2fs/dir.c b/fs/f2fs/dir.c
> index 0971ccc4664a..2accfc5e38d0 100644
> --- a/fs/f2fs/dir.c
> +++ b/fs/f2fs/dir.c
> @@ -471,7 +471,6 @@ struct page *f2fs_init_inode_metadata(struct inode *inode, struct inode *dir,
>  			struct page *dpage)
>  {
>  	struct page *page;
> -	int dummy_encrypt = DUMMY_ENCRYPTION_ENABLED(F2FS_I_SB(dir));
>  	int err;
>  
>  	if (is_inode_flag_set(inode, FI_NEW_INODE)) {
> @@ -498,8 +497,7 @@ struct page *f2fs_init_inode_metadata(struct inode *inode, struct inode *dir,
>  		if (err)
>  			goto put_error;
>  
> -		if ((IS_ENCRYPTED(dir) || dummy_encrypt) &&
> -					f2fs_may_encrypt(inode)) {
> +		if (f2fs_may_encrypt(dir, inode)) {
>  			err = fscrypt_inherit_context(dir, inode, page, false);
>  			if (err)
>  				goto put_error;
> diff --git a/fs/f2fs/f2fs.h b/fs/f2fs/f2fs.h
> index 09db79a20f8e..fcafa68212eb 100644
> --- a/fs/f2fs/f2fs.h
> +++ b/fs/f2fs/f2fs.h
> @@ -3946,15 +3946,20 @@ static inline bool f2fs_lfs_mode(struct f2fs_sb_info *sbi)
>  	return F2FS_OPTION(sbi).fs_mode == FS_MODE_LFS;
>  }
>  
> -static inline bool f2fs_may_encrypt(struct inode *inode)
> +static inline bool f2fs_may_encrypt(struct inode *dir, struct inode *inode)
>  {
>  #ifdef CONFIG_FS_ENCRYPTION
> +	struct f2fs_sb_info *sbi = F2FS_I_SB(dir);
>  	umode_t mode = inode->i_mode;
>  
> -	return (S_ISREG(mode) || S_ISDIR(mode) || S_ISLNK(mode));
> -#else
> -	return false;
> +	/*
> +	 * If the directory encrypted or dummy encryption enabled,
> +	 * then we should encrypt the inode.
> +	 */
> +	if (IS_ENCRYPTED(dir) || DUMMY_ENCRYPTION_ENABLED(sbi))
> +		return (S_ISREG(mode) || S_ISDIR(mode) || S_ISLNK(mode));
>  #endif
> +	return false;
>  }
>  
>  static inline bool f2fs_may_compress(struct inode *inode)
> diff --git a/fs/f2fs/namei.c b/fs/f2fs/namei.c
> index b75c70813f9e..95cfbce062e8 100644
> --- a/fs/f2fs/namei.c
> +++ b/fs/f2fs/namei.c
> @@ -75,9 +75,7 @@ static struct inode *f2fs_new_inode(struct inode *dir, umode_t mode)
>  
>  	set_inode_flag(inode, FI_NEW_INODE);
>  
> -	/* If the directory encrypted, then we should encrypt the inode. */
> -	if ((IS_ENCRYPTED(dir) || DUMMY_ENCRYPTION_ENABLED(sbi)) &&
> -				f2fs_may_encrypt(inode))
> +	if (f2fs_may_encrypt(dir, inode))
>  		f2fs_set_encrypted_inode(inode);
>  
>  	if (f2fs_sb_has_extra_attr(sbi)) {
> -- 

Can't f2fs_init_inode_metadata() just check IS_ENCRYPTED(inode) instead?
(inode, not dir.)  The encrypt flag was already set by f2fs_new_inode(), right?

If so, then f2fs_may_encrypt() would only have one caller and it could be
inlined into f2fs_new_inode(), similar to __ext4_new_inode().

- Eric
