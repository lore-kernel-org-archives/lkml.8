Return-Path: <SRS0=nwpL=6I=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 464F6C55186
	for <linux-kernel@archiver.kernel.org>; Fri, 24 Apr 2020 03:35:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 150B02073A
	for <linux-kernel@archiver.kernel.org>; Fri, 24 Apr 2020 03:35:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1587699330;
	bh=X4SrWJkSoc3Enbcge8Fd0LvQVeH/UDL4vww6M2ZMQP0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=HA/wtBktfdbR7r1dkrgXDNUvLnWPTH6J/DUbKQAZ8iF0tK1Afnu2doziHGl7VTni8
	 6SEFRpFTn5tsuAqEu2mwa2u3+SYunuxmIXexRUWmIavInKjZFEQgjLCQH+xKzVg1fN
	 ho00kUJppgx9X1Mut3hG54SeNWEgIQJTi1drjKfw=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726415AbgDXDf3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 23 Apr 2020 23:35:29 -0400
Received: from mail.kernel.org ([198.145.29.99]:42624 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725884AbgDXDf2 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Apr 2020 23:35:28 -0400
Received: from localhost (unknown [104.132.1.66])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 35C24206D7;
        Fri, 24 Apr 2020 03:35:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1587699328;
        bh=X4SrWJkSoc3Enbcge8Fd0LvQVeH/UDL4vww6M2ZMQP0=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=XJFpTycSwL3dRrWsMY+tgEUrJ06u5mgJKl5PDT/SRSRuZptbbNM0xDPU7s+Mshgn1
         uwXm7TubOigHs4yp+miarFIfiiYgSursUT2Nu37RUYptafjuEGc0N+xMHhoIefB2dV
         OukxSDbO1uoxXQGqsKSy+iVqwf8CyQBT+ZTyze28=
Date:   Thu, 23 Apr 2020 20:35:27 -0700
From:   Jaegeuk Kim <jaegeuk@kernel.org>
To:     Chao Yu <yuchao0@huawei.com>
Cc:     linux-kernel@vger.kernel.org,
        linux-f2fs-devel@lists.sourceforge.net, kernel-team@android.com
Subject: Re: [f2fs-dev] [PATCH v2] f2fs: fix quota_sync failure due to
 f2fs_lock_op
Message-ID: <20200424033527.GA106894@google.com>
References: <20200409173056.229855-1-jaegeuk@kernel.org>
 <77e9f2e6-f3f3-8ca9-e6b5-3d57c4d2acc5@huawei.com>
 <20200416213946.GA196168@google.com>
 <fd8b116a-7830-809c-70a4-a3a12da1eb14@huawei.com>
 <20200423194952.GA99191@google.com>
 <e67273bc-7416-c86e-58ba-c025029e8099@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <e67273bc-7416-c86e-58ba-c025029e8099@huawei.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 04/24, Chao Yu wrote:
> On 2020/4/24 3:49, Jaegeuk Kim wrote:
> > On 04/23, Chao Yu wrote:
> >> On 2020/4/17 5:39, Jaegeuk Kim wrote:
> >>> f2fs_quota_sync() uses f2fs_lock_op() before flushing dirty pages, but
> >>> f2fs_write_data_page() returns EAGAIN.
> >>> Likewise dentry blocks, we can just bypass getting the lock, since quota
> >>> blocks are also maintained by checkpoint.
> >>>
> >>> Signed-off-by: Jaegeuk Kim <jaegeuk@kernel.org>
> >>> ---
> >>> v2:
> >>>  - fix multipage write case
> >>>
> >>>  fs/f2fs/compress.c | 2 +-
> >>>  fs/f2fs/data.c     | 4 ++--
> >>>  2 files changed, 3 insertions(+), 3 deletions(-)
> >>>
> >>> diff --git a/fs/f2fs/compress.c b/fs/f2fs/compress.c
> >>> index df7b2d15eacde..faaa358289010 100644
> >>> --- a/fs/f2fs/compress.c
> >>> +++ b/fs/f2fs/compress.c
> >>> @@ -985,7 +985,7 @@ static int f2fs_write_compressed_pages(struct compress_ctx *cc,
> >>>  	loff_t psize;
> >>>  	int i, err;
> >>>  
> >>> -	if (!f2fs_trylock_op(sbi))
> >>> +	if (!IS_NOQUOTA(inode) && !f2fs_trylock_op(sbi))
> >>>  		return -EAGAIN;
> >>
> >> I encounter deadlock..
> >>
> >> Should call f2fs_unlock_op() for non-quota compressed inode later.
> > 
> > Could you elaborate a bit?
> 
> I meant we need to change as below, otherwise, cp_rwsem can be negative
> after f2fs_unlock_op if writebacked datas are belong to compressed quota
> file.

Ah, I see. Fixed.

Thanks,

> 
> >From 817dc629c47d3000c595640ecb3099b880519d47 Mon Sep 17 00:00:00 2001
> From: Jaegeuk Kim <jaegeuk@kernel.org>
> Date: Thu, 9 Apr 2020 10:25:21 -0700
> Subject: [PATCH] f2fs: fix quota_sync failure due to f2fs_lock_op
> 
> f2fs_quota_sync() uses f2fs_lock_op() before flushing dirty pages, but
> f2fs_write_data_page() returns EAGAIN.
> Likewise dentry blocks, we can just bypass getting the lock, since quota
> blocks are also maintained by checkpoint.
> 
> Reviewed-by: Chao Yu <yuchao0@huawei.com>
> Signed-off-by: Jaegeuk Kim <jaegeuk@kernel.org>
> ---
>  fs/f2fs/compress.c | 8 +++++---
>  fs/f2fs/data.c     | 4 ++--
>  2 files changed, 7 insertions(+), 5 deletions(-)
> 
> diff --git a/fs/f2fs/compress.c b/fs/f2fs/compress.c
> index df7b2d15eacd..26b071afe48a 100644
> --- a/fs/f2fs/compress.c
> +++ b/fs/f2fs/compress.c
> @@ -985,7 +985,7 @@ static int f2fs_write_compressed_pages(struct compress_ctx *cc,
>  	loff_t psize;
>  	int i, err;
> 
> -	if (!f2fs_trylock_op(sbi))
> +	if (!IS_NOQUOTA(inode) && !f2fs_trylock_op(sbi))
>  		return -EAGAIN;
> 
>  	set_new_dnode(&dn, cc->inode, NULL, NULL, 0);
> @@ -1092,7 +1092,8 @@ static int f2fs_write_compressed_pages(struct compress_ctx *cc,
>  		set_inode_flag(inode, FI_FIRST_BLOCK_WRITTEN);
> 
>  	f2fs_put_dnode(&dn);
> -	f2fs_unlock_op(sbi);
> +	if (!IS_NOQUOTA(inode))
> +		f2fs_unlock_op(sbi);
> 
>  	spin_lock(&fi->i_size_lock);
>  	if (fi->last_disk_size < psize)
> @@ -1118,7 +1119,8 @@ static int f2fs_write_compressed_pages(struct compress_ctx *cc,
>  out_put_dnode:
>  	f2fs_put_dnode(&dn);
>  out_unlock_op:
> -	f2fs_unlock_op(sbi);
> +	if (!IS_NOQUOTA(inode))
> +		f2fs_unlock_op(sbi);
>  	return -EAGAIN;
>  }
> 
> diff --git a/fs/f2fs/data.c b/fs/f2fs/data.c
> index 8dd48c5b6c0d..dd439dbb134d 100644
> --- a/fs/f2fs/data.c
> +++ b/fs/f2fs/data.c
> @@ -2660,8 +2660,8 @@ int f2fs_write_single_data_page(struct page *page, int *submitted,
>  			f2fs_available_free_memory(sbi, BASE_CHECK))))
>  		goto redirty_out;
> 
> -	/* Dentry blocks are controlled by checkpoint */
> -	if (S_ISDIR(inode->i_mode)) {
> +	/* Dentry/quota blocks are controlled by checkpoint */
> +	if (S_ISDIR(inode->i_mode) || IS_NOQUOTA(inode)) {
>  		fio.need_lock = LOCK_DONE;
>  		err = f2fs_do_write_data_page(&fio);
>  		goto done;
> -- 
> 2.18.0.rc1
> 
> 
> 
> > 
> >>
> >> Thanks,
> >>
> >>>  
> >>>  	set_new_dnode(&dn, cc->inode, NULL, NULL, 0);
> >>> diff --git a/fs/f2fs/data.c b/fs/f2fs/data.c
> >>> index accd28728642a..5c8d3823d7593 100644
> >>> --- a/fs/f2fs/data.c
> >>> +++ b/fs/f2fs/data.c
> >>> @@ -2656,8 +2656,8 @@ int f2fs_write_single_data_page(struct page *page, int *submitted,
> >>>  			f2fs_available_free_memory(sbi, BASE_CHECK))))
> >>>  		goto redirty_out;
> >>>  
> >>> -	/* Dentry blocks are controlled by checkpoint */
> >>> -	if (S_ISDIR(inode->i_mode)) {
> >>> +	/* Dentry/quota blocks are controlled by checkpoint */
> >>> +	if (S_ISDIR(inode->i_mode) || IS_NOQUOTA(inode)) {
> >>>  		fio.need_lock = LOCK_DONE;
> >>>  		err = f2fs_do_write_data_page(&fio);
> >>>  		goto done;
> >>>
> > .
> > 
