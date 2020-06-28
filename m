Return-Path: <SRS0=fM4p=AJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D26EAC433E0
	for <linux-kernel@archiver.kernel.org>; Sun, 28 Jun 2020 03:00:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A40C6206A1
	for <linux-kernel@archiver.kernel.org>; Sun, 28 Jun 2020 03:00:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="pEr0IljX"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726059AbgF1DAj (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 27 Jun 2020 23:00:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39558 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725880AbgF1DAj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 27 Jun 2020 23:00:39 -0400
Received: from mail-pf1-x443.google.com (mail-pf1-x443.google.com [IPv6:2607:f8b0:4864:20::443])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1B582C061794
        for <linux-kernel@vger.kernel.org>; Sat, 27 Jun 2020 20:00:39 -0700 (PDT)
Received: by mail-pf1-x443.google.com with SMTP id d66so6395876pfd.6
        for <linux-kernel@vger.kernel.org>; Sat, 27 Jun 2020 20:00:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=GJyVY2pi0ndePjxf9rQC8thJc78Irh06qbg6ML5wkWY=;
        b=pEr0IljXHL/ELB6Xtte83pik/3yh9Fk0gk0hjSg/5qGQFcxMe+lv06AOeJOoDn2ZPt
         NzI6ieaqty+1fRIahEtRKnsvttnRbxLNaRw3cJZT1QjSdbJ8qO9Mtjtsyb4MHkX0oa/B
         xBuykrqpGwbo5mpp4ZxyyfnHjS8nW8snATYLwSuiMdfEuq03eyjpTU6tOnrcDRI7W2L6
         lZncbGhOdLwoVZGEVqtp9gfzjHEubfYqBPmILGgsCvNN90vPcixXNI9WNyRpqaoe9j3L
         l9+7LDxPrm+5+5IF+RUmmwVP9D97eR284nQb6LZRbQRf4gLRSHDhjLo2qP9xrCDvsrYe
         yRwg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=GJyVY2pi0ndePjxf9rQC8thJc78Irh06qbg6ML5wkWY=;
        b=W0wV3B0KwvHbziSk6l2bKHHSIu0z7c2wYahPktynGqw6aXIcRVXUW8qxCgZ3XJDgOU
         huiKqiXE9jC1DhCRU+O3yUWt5riSnAMsLW1hoXRjrcQd/4WJV6gIFxC+0hDg7WcStzUl
         G5CawmpGe9ng1G7WmsTOSFz70wdM3l/4NaGD20mVyWJlS4GG5dtycOer/+gjShnpczdF
         hn+PFPxYXpyU3zWV8JQuSJsg6wJ8151J3jbPtiNFUy2XVnupHk5oixdG0V8LTIC8AsYh
         hlCC/Q4FtCnqxGwv3/nPvcVG6pbsUATSNkOM6NTP6WAguHiBBWmOtDbtJfZ0+zoukC7k
         ahHQ==
X-Gm-Message-State: AOAM533DX9r7a/E0+C62nfTcV11ZKTzv2h6Ab4AV0bYL/EFU5Gd1+ovq
        iMTygbJqnZm7EE3g1tCux/Y=
X-Google-Smtp-Source: ABdhPJz23EaYGAsvNOU1coMbFIv0IMao9JaZ7RZWd9d8NbGlWdj+pnwhWxxJxOr0pojv1bYVuTqDtw==
X-Received: by 2002:a62:834c:: with SMTP id h73mr9496980pfe.221.1593313238348;
        Sat, 27 Jun 2020 20:00:38 -0700 (PDT)
Received: from ubuntu-s3-xlarge-x86 ([2604:1380:1000:7a00::1])
        by smtp.gmail.com with ESMTPSA id a12sm15040842pjw.35.2020.06.27.20.00.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 27 Jun 2020 20:00:37 -0700 (PDT)
Date:   Sat, 27 Jun 2020 20:00:36 -0700
From:   Nathan Chancellor <natechancellor@gmail.com>
To:     Luca Stefani <luca.stefani.ge1@gmail.com>
Cc:     clang-built-linux@googlegroups.com,
        freak07 <michalechner92@googlemail.com>,
        Anton Altaparmakov <anton@tuxera.com>,
        linux-ntfs-dev@lists.sourceforge.net, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] ntfs: Fix ntfs_test_inode and ntfs_init_locked_inode
 function type
Message-ID: <20200628030036.GA782635@ubuntu-s3-xlarge-x86>
References: <20200627190230.1191796-1-luca.stefani.ge1@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200627190230.1191796-1-luca.stefani.ge1@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Luca,

On Sat, Jun 27, 2020 at 09:02:30PM +0200, Luca Stefani wrote:
> If the kernel is built with CFI we hit a __cfi_check_fail
> while mounting a partition
> 
> Call trace:
> __cfi_check_fail+0x1c/0x24
> name_to_dev_t+0x0/0x404
> iget5_locked+0x594/0x5e8
> ntfs_fill_super+0xbfc/0x43ec
> mount_bdev+0x30c/0x3cc
> ntfs_mount+0x18/0x24
> mount_fs+0x1b0/0x380
> vfs_kern_mount+0x90/0x398
> do_mount+0x5d8/0x1a10
> SyS_mount+0x108/0x144
> el0_svc_naked+0x34/0x38
> 
> Fixing iget5_locked and ilookup5 callers seems enough
> 
> Signed-off-by: Luca Stefani <luca.stefani.ge1@gmail.com>
> Tested-by: freak07 <michalechner92@googlemail.com>
> ---
>  fs/ntfs/dir.c   |  2 +-
>  fs/ntfs/inode.c | 23 ++++++++++++-----------
>  fs/ntfs/inode.h |  4 +---
>  fs/ntfs/mft.c   |  4 ++--
>  4 files changed, 16 insertions(+), 17 deletions(-)
> 
> diff --git a/fs/ntfs/dir.c b/fs/ntfs/dir.c
> index 3c4811469ae8..e278bfc5ee7f 100644
> --- a/fs/ntfs/dir.c
> +++ b/fs/ntfs/dir.c
> @@ -1503,7 +1503,7 @@ static int ntfs_dir_fsync(struct file *filp, loff_t start, loff_t end,
>  	na.type = AT_BITMAP;
>  	na.name = I30;
>  	na.name_len = 4;
> -	bmp_vi = ilookup5(vi->i_sb, vi->i_ino, (test_t)ntfs_test_inode, &na);
> +	bmp_vi = ilookup5(vi->i_sb, vi->i_ino, ntfs_test_inode, &na);
>  	if (bmp_vi) {
>   		write_inode_now(bmp_vi, !datasync);
>  		iput(bmp_vi);
> diff --git a/fs/ntfs/inode.c b/fs/ntfs/inode.c
> index d4359a1df3d5..a5d3bebe7a85 100644
> --- a/fs/ntfs/inode.c
> +++ b/fs/ntfs/inode.c
> @@ -30,7 +30,7 @@
>  /**
>   * ntfs_test_inode - compare two (possibly fake) inodes for equality
>   * @vi:		vfs inode which to test
> - * @na:		ntfs attribute which is being tested with
> + * @data:		data which is being tested with

I know you didn't write this comment but I don't think the ending "with"
is necessary.

>   *
>   * Compare the ntfs attribute embedded in the ntfs specific part of the vfs
>   * inode @vi for equality with the ntfs attribute @na.

                                                     ^ @data

and looks like there is a comment below that needs to be updated too.

> @@ -43,8 +43,9 @@
>   * NOTE: This function runs with the inode_hash_lock spin lock held so it is not
>   * allowed to sleep.
>   */
> -int ntfs_test_inode(struct inode *vi, ntfs_attr *na)
> +int ntfs_test_inode(struct inode *vi, void *data)
>  {
> +	ntfs_attr *na = (ntfs_attr *)data;

This cast is technically unnecessary but it doesn't hurt anything
either. Different maintainers prefer different styles.

>  	ntfs_inode *ni;
>  
>  	if (vi->i_ino != na->mft_no)
> @@ -72,7 +73,7 @@ int ntfs_test_inode(struct inode *vi, ntfs_attr *na)
>  /**
>   * ntfs_init_locked_inode - initialize an inode
>   * @vi:		vfs inode to initialize
> - * @na:		ntfs attribute which to initialize @vi to
> + * @data:		data which to initialize @vi to

Same deal as above; know you didn't write the comment but this is
currently clunky. Might be better as either

"data to initialize @vi" or "data to initialize @vi with"

>   *
>   * Initialize the vfs inode @vi with the values from the ntfs attribute @na in

                                                                           ^ @data

and same deal as above, full comment needs updating with new data
member.

>   * order to enable ntfs_test_inode() to do its work.
> @@ -87,8 +88,9 @@ int ntfs_test_inode(struct inode *vi, ntfs_attr *na)
>   * NOTE: This function runs with the inode->i_lock spin lock held so it is not
>   * allowed to sleep. (Hence the GFP_ATOMIC allocation.)
>   */
> -static int ntfs_init_locked_inode(struct inode *vi, ntfs_attr *na)
> +static int ntfs_init_locked_inode(struct inode *vi, void *data)
>  {
> +	ntfs_attr *na = (ntfs_attr *)data;
>  	ntfs_inode *ni = NTFS_I(vi);
>  
>  	vi->i_ino = na->mft_no;
> @@ -131,7 +133,6 @@ static int ntfs_init_locked_inode(struct inode *vi, ntfs_attr *na)
>  	return 0;
>  }
>  
> -typedef int (*set_t)(struct inode *, void *);
>  static int ntfs_read_locked_inode(struct inode *vi);
>  static int ntfs_read_locked_attr_inode(struct inode *base_vi, struct inode *vi);
>  static int ntfs_read_locked_index_inode(struct inode *base_vi,
> @@ -164,8 +165,8 @@ struct inode *ntfs_iget(struct super_block *sb, unsigned long mft_no)
>  	na.name = NULL;
>  	na.name_len = 0;
>  
> -	vi = iget5_locked(sb, mft_no, (test_t)ntfs_test_inode,
> -			(set_t)ntfs_init_locked_inode, &na);
> +	vi = iget5_locked(sb, mft_no, ntfs_test_inode,
> +			ntfs_init_locked_inode, &na);
>  	if (unlikely(!vi))
>  		return ERR_PTR(-ENOMEM);
>  
> @@ -225,8 +226,8 @@ struct inode *ntfs_attr_iget(struct inode *base_vi, ATTR_TYPE type,
>  	na.name = name;
>  	na.name_len = name_len;
>  
> -	vi = iget5_locked(base_vi->i_sb, na.mft_no, (test_t)ntfs_test_inode,
> -			(set_t)ntfs_init_locked_inode, &na);
> +	vi = iget5_locked(base_vi->i_sb, na.mft_no, ntfs_test_inode,
> +			ntfs_init_locked_inode, &na);
>  	if (unlikely(!vi))
>  		return ERR_PTR(-ENOMEM);
>  
> @@ -280,8 +281,8 @@ struct inode *ntfs_index_iget(struct inode *base_vi, ntfschar *name,
>  	na.name = name;
>  	na.name_len = name_len;
>  
> -	vi = iget5_locked(base_vi->i_sb, na.mft_no, (test_t)ntfs_test_inode,
> -			(set_t)ntfs_init_locked_inode, &na);
> +	vi = iget5_locked(base_vi->i_sb, na.mft_no, ntfs_test_inode,
> +			ntfs_init_locked_inode, &na);
>  	if (unlikely(!vi))
>  		return ERR_PTR(-ENOMEM);
>  
> diff --git a/fs/ntfs/inode.h b/fs/ntfs/inode.h
> index 98e670fbdd31..363e4e820673 100644
> --- a/fs/ntfs/inode.h
> +++ b/fs/ntfs/inode.h
> @@ -253,9 +253,7 @@ typedef struct {
>  	ATTR_TYPE type;
>  } ntfs_attr;
>  
> -typedef int (*test_t)(struct inode *, void *);
> -
> -extern int ntfs_test_inode(struct inode *vi, ntfs_attr *na);
> +extern int ntfs_test_inode(struct inode *vi, void *data);
>  
>  extern struct inode *ntfs_iget(struct super_block *sb, unsigned long mft_no);
>  extern struct inode *ntfs_attr_iget(struct inode *base_vi, ATTR_TYPE type,
> diff --git a/fs/ntfs/mft.c b/fs/ntfs/mft.c
> index fbb9f1bc623d..0d62cd5bb7f8 100644
> --- a/fs/ntfs/mft.c
> +++ b/fs/ntfs/mft.c
> @@ -958,7 +958,7 @@ bool ntfs_may_write_mft_record(ntfs_volume *vol, const unsigned long mft_no,
>  		 * dirty code path of the inode dirty code path when writing
>  		 * $MFT occurs.
>  		 */
> -		vi = ilookup5_nowait(sb, mft_no, (test_t)ntfs_test_inode, &na);
> +		vi = ilookup5_nowait(sb, mft_no, ntfs_test_inode, &na);
>  	}
>  	if (vi) {
>  		ntfs_debug("Base inode 0x%lx is in icache.", mft_no);
> @@ -1019,7 +1019,7 @@ bool ntfs_may_write_mft_record(ntfs_volume *vol, const unsigned long mft_no,
>  		vi = igrab(mft_vi);
>  		BUG_ON(vi != mft_vi);
>  	} else
> -		vi = ilookup5_nowait(sb, na.mft_no, (test_t)ntfs_test_inode,
> +		vi = ilookup5_nowait(sb, na.mft_no, ntfs_test_inode,
>  				&na);
>  	if (!vi) {
>  		/*
> -- 
> 2.26.2
> 

Other than those minor nits,

Reviewed-by: Nathan Chancellor <natechancellor@gmail.com>
