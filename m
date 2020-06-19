Return-Path: <SRS0=bWCJ=AA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B56A9C433DF
	for <linux-kernel@archiver.kernel.org>; Fri, 19 Jun 2020 05:56:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8F7D520809
	for <linux-kernel@archiver.kernel.org>; Fri, 19 Jun 2020 05:56:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1592546204;
	bh=9lQMKLDkxfUoyF2wJGr/cl+gMGQit45i/+nfTpmUwJI=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=1uHY0kDoHOowmTl51rWM0gbov297WLUQRU3a0ASeBEg+yLD6RtIfDTtpMBmOwl5r8
	 JefeEI6I+3rmTg5iYm7vFc6dXUD1JTkrfaNVaPfv6yqNiOskHBpyTr6iJjKPVfop42
	 QNwIfsNi62xeZWsMQQRhFF6h2vd2DqWcEQxGaf/k=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728321AbgFSF4m (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 19 Jun 2020 01:56:42 -0400
Received: from mail.kernel.org ([198.145.29.99]:56378 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725446AbgFSF4m (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 19 Jun 2020 01:56:42 -0400
Received: from localhost (unknown [104.132.1.66])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 6B7A9207DD;
        Fri, 19 Jun 2020 05:56:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1592546201;
        bh=9lQMKLDkxfUoyF2wJGr/cl+gMGQit45i/+nfTpmUwJI=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=uNyadC1mwnLWhHwUt+8csXiE/lsUF5oJSfigS3rFy6B8uhc0tavJ6DOO3AGawjuBU
         I1CBJH9egCmg6ovDJCCmT7oUGDf82nuO3V4v/8WQQUv2wjHwRTVS16Ec8IPwBnDjmd
         VsJ9t+YjDSZGhTNqSaHdPxLUf2bhFTe4Vgj+KTLA=
Date:   Thu, 18 Jun 2020 22:56:40 -0700
From:   Jaegeuk Kim <jaegeuk@kernel.org>
To:     Chao Yu <yuchao0@huawei.com>
Cc:     linux-f2fs-devel@lists.sourceforge.net,
        linux-kernel@vger.kernel.org, chao@kernel.org
Subject: Re: [PATCH 3/5] f2fs: shrink node_write lock coverage
Message-ID: <20200619055640.GD227771@google.com>
References: <20200618063625.110273-1-yuchao0@huawei.com>
 <20200618063625.110273-3-yuchao0@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200618063625.110273-3-yuchao0@huawei.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 06/18, Chao Yu wrote:
> - to avoid race between checkpoint and quota file writeback, it
> just needs to hold read lock of node_write in writeback path.
> - node_write lock has covered all LFS data write paths, it's not
> necessary, we only need to hold node_write lock at write path of
> quota file.

I've added this:

This refactors commit ca7f76e68074 ("f2fs: fix wrong discard space").

> 
> Signed-off-by: Chao Yu <yuchao0@huawei.com>
> ---
>  fs/f2fs/compress.c | 18 +++++++++++++++---
>  fs/f2fs/data.c     | 12 ++++++++++++
>  fs/f2fs/segment.c  | 11 -----------
>  3 files changed, 27 insertions(+), 14 deletions(-)
> 
> diff --git a/fs/f2fs/compress.c b/fs/f2fs/compress.c
> index 36b51795b0c3..3ff6c0305ec6 100644
> --- a/fs/f2fs/compress.c
> +++ b/fs/f2fs/compress.c
> @@ -1096,8 +1096,16 @@ static int f2fs_write_compressed_pages(struct compress_ctx *cc,
>  	loff_t psize;
>  	int i, err;
>  
> -	if (!IS_NOQUOTA(inode) && !f2fs_trylock_op(sbi))
> +	if (IS_NOQUOTA(inode)) {
> +		/*
> +		 * We need to wait for node_write to avoid block allocation during
> +		 * checkpoint. This can only happen to quota writes which can cause
> +		 * the below discard race condition.
> +		 */
> +		down_read(&sbi->node_write);
> +	} else if (!f2fs_trylock_op(sbi)) {
>  		return -EAGAIN;
> +	}
>  
>  	set_new_dnode(&dn, cc->inode, NULL, NULL, 0);
>  
> @@ -1203,7 +1211,9 @@ static int f2fs_write_compressed_pages(struct compress_ctx *cc,
>  		set_inode_flag(inode, FI_FIRST_BLOCK_WRITTEN);
>  
>  	f2fs_put_dnode(&dn);
> -	if (!IS_NOQUOTA(inode))
> +	if (IS_NOQUOTA(inode))
> +		up_read(&sbi->node_write);
> +	else
>  		f2fs_unlock_op(sbi);
>  
>  	spin_lock(&fi->i_size_lock);
> @@ -1230,7 +1240,9 @@ static int f2fs_write_compressed_pages(struct compress_ctx *cc,
>  out_put_dnode:
>  	f2fs_put_dnode(&dn);
>  out_unlock_op:
> -	if (!IS_NOQUOTA(inode))
> +	if (IS_NOQUOTA(inode))
> +		up_read(&sbi->node_write);
> +	else
>  		f2fs_unlock_op(sbi);
>  	return -EAGAIN;
>  }
> diff --git a/fs/f2fs/data.c b/fs/f2fs/data.c
> index c78ce08f6400..cbdf062d3562 100644
> --- a/fs/f2fs/data.c
> +++ b/fs/f2fs/data.c
> @@ -2719,8 +2719,20 @@ int f2fs_write_single_data_page(struct page *page, int *submitted,
>  
>  	/* Dentry/quota blocks are controlled by checkpoint */
>  	if (S_ISDIR(inode->i_mode) || IS_NOQUOTA(inode)) {
> +		/*
> +		 * We need to wait for node_write to avoid block allocation during
> +		 * checkpoint. This can only happen to quota writes which can cause
> +		 * the below discard race condition.
> +		 */
> +		if (IS_NOQUOTA(inode))
> +			down_read(&sbi->node_write);
> +
>  		fio.need_lock = LOCK_DONE;
>  		err = f2fs_do_write_data_page(&fio);
> +
> +		if (IS_NOQUOTA(inode))
> +			up_read(&sbi->node_write);
> +
>  		goto done;
>  	}
>  
> diff --git a/fs/f2fs/segment.c b/fs/f2fs/segment.c
> index 5b2a6f865a6d..cb861ed98ee3 100644
> --- a/fs/f2fs/segment.c
> +++ b/fs/f2fs/segment.c
> @@ -3107,14 +3107,6 @@ void f2fs_allocate_data_block(struct f2fs_sb_info *sbi, struct page *page,
>  		type = CURSEG_COLD_DATA;
>  	}
>  
> -	/*
> -	 * We need to wait for node_write to avoid block allocation during
> -	 * checkpoint. This can only happen to quota writes which can cause
> -	 * the below discard race condition.
> -	 */
> -	if (IS_DATASEG(type))
> -		down_write(&sbi->node_write);
> -
>  	down_read(&SM_I(sbi)->curseg_lock);
>  
>  	mutex_lock(&curseg->curseg_mutex);
> @@ -3180,9 +3172,6 @@ void f2fs_allocate_data_block(struct f2fs_sb_info *sbi, struct page *page,
>  
>  	up_read(&SM_I(sbi)->curseg_lock);
>  
> -	if (IS_DATASEG(type))
> -		up_write(&sbi->node_write);
> -
>  	if (put_pin_sem)
>  		up_read(&sbi->pin_sem);
>  }
> -- 
> 2.18.0.rc1
