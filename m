Return-Path: <SRS0=bl3x=A7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 38E5BC433E5
	for <linux-kernel@archiver.kernel.org>; Mon, 20 Jul 2020 18:09:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1FC9F22CAF
	for <linux-kernel@archiver.kernel.org>; Mon, 20 Jul 2020 18:09:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="tN8yesRP"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389332AbgGTSJw (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 20 Jul 2020 14:09:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33880 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1733095AbgGTSJt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Jul 2020 14:09:49 -0400
Received: from mail-qt1-x842.google.com (mail-qt1-x842.google.com [IPv6:2607:f8b0:4864:20::842])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D1182C061794
        for <linux-kernel@vger.kernel.org>; Mon, 20 Jul 2020 11:09:48 -0700 (PDT)
Received: by mail-qt1-x842.google.com with SMTP id 6so13909971qtt.0
        for <linux-kernel@vger.kernel.org>; Mon, 20 Jul 2020 11:09:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=dwEJsfwlCgYoOoc7ZO6uJZf/vr4ZXlXX4a+d3KSul78=;
        b=tN8yesRPMfvGOoe7LjdmwksRHEV9CfANZwTGD2WB1She1GOgdXPPh/yBn8ZOYyE4QH
         4jnnVTgXbnN06EmDApSrk15aC4ZKnEPr7fNu2s3mlwbz9Na8nsqp4P4FTmsRnjt8FgnD
         wfFNtv/iDHFLKxOZQs64LrvoRiQZuMnQtE+eVWjHK6Y1Mf9INicJj5m4RRrXwnGJqR3H
         4U/IAoJf/wy+wjfvimt6GfwehyO85dH7HSeT7EcAAbjbzzR6PHuodGEvcRgf3lmSOzQ1
         lwDXCoCccdB8HCgFX4AkyDO/HxEgtevAkoUmjoviHstoTu8Oz6807p55OpTD+xLq0ZsY
         vSNw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=dwEJsfwlCgYoOoc7ZO6uJZf/vr4ZXlXX4a+d3KSul78=;
        b=s73XSY4H9FQV0TRjarj3urjrgvuwGE68Xy+ozFjBdkkXkLnwejNGIfItbKQpd4StuC
         baCqOX8Z9pLU7klz4dG6QR6ogOxlZxpNr3Epo8l1hkQRD8EjOgA6iY0awkU4vkT0soyt
         7ifO/rr37xxGbwRk0za2AvOuh7WlJWwxlpmpjcg5fmyQO3H+Eq2eHTXhVGcqatWXEG0j
         apH0gHSC0iG/zSn5BzfGkfCIGQYiXs/1Qzvytuc/uVKeyhJ4if6XI+cnSZwLOjfnKjOa
         HzFnfjMSCQpoxKJFe160vudRUKF4zcvdtrEGjvR0mCXREbUqlAUMbbXRpC8XW4caMliz
         Zc9Q==
X-Gm-Message-State: AOAM531h30a/ufsTXDM2etGoGxa9qEtTZHK+NvR8lFLcJFtyuFCv5P2b
        wAe2lUQ84/w0QEmLNJqOIpc=
X-Google-Smtp-Source: ABdhPJwRPEqgd7V9ut9+6Hy1hWEBVav428Xzxi706m1O9CYbZz2Rqgiku2MLIW3nnVOSMo4aO11hsw==
X-Received: by 2002:aed:252c:: with SMTP id v41mr25356387qtc.234.1595268587842;
        Mon, 20 Jul 2020 11:09:47 -0700 (PDT)
Received: from ubuntu-n2-xlarge-x86 ([2604:1380:45d1:2600::1])
        by smtp.gmail.com with ESMTPSA id x3sm274009qkd.62.2020.07.20.11.09.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 20 Jul 2020 11:09:47 -0700 (PDT)
Date:   Mon, 20 Jul 2020 11:09:45 -0700
From:   Nathan Chancellor <natechancellor@gmail.com>
To:     Luca Stefani <luca.stefani.ge1@gmail.com>
Cc:     akpm@linux-foundation.org, freak07 <michalechner92@googlemail.com>,
        Anton Altaparmakov <anton@tuxera.com>,
        linux-ntfs-dev@lists.sourceforge.net, linux-kernel@vger.kernel.org,
        clang-built-linux@googlegroups.com
Subject: Re: [PATCH v2] ntfs: Fix ntfs_test_inode and ntfs_init_locked_inode
 function type
Message-ID: <20200720180945.GA6045@ubuntu-n2-xlarge-x86>
References: <20200627190230.1191796-1-luca.stefani.ge1@gmail.com>
 <20200718112513.533800-1-luca.stefani.ge1@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200718112513.533800-1-luca.stefani.ge1@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Jul 18, 2020 at 01:25:13PM +0200, Luca Stefani wrote:
> Clang's Control Flow Integrity (CFI) is a security mechanism that can
> help prevent JOP chains, deployed extensively in downstream kernels
> used in Android.
> 
> It's deployment is hindered by mismatches in function signatures.  For
> this case, we make callbacks match their intended function signature,
> and cast parameters within them rather than casting the callback when
> passed as a parameter.
> 
> When running `mount -t ntfs ...` we observe the following trace:
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
> Signed-off-by: Luca Stefani <luca.stefani.ge1@gmail.com>
> Tested-by: freak07 <michalechner92@googlemail.com>
> Acked-by: Anton Altaparmakov <anton@tuxera.com>

Reviewed-by: Nathan Chancellor <natechancellor@gmail.com>

> ---
>  fs/ntfs/dir.c   |  2 +-
>  fs/ntfs/inode.c | 27 ++++++++++++++-------------
>  fs/ntfs/inode.h |  4 +---
>  fs/ntfs/mft.c   |  4 ++--
>  4 files changed, 18 insertions(+), 19 deletions(-)
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
> index d4359a1df3d5..9bb9f0952b18 100644
> --- a/fs/ntfs/inode.c
> +++ b/fs/ntfs/inode.c
> @@ -30,10 +30,10 @@
>  /**
>   * ntfs_test_inode - compare two (possibly fake) inodes for equality
>   * @vi:		vfs inode which to test
> - * @na:		ntfs attribute which is being tested with
> + * @data:	data which is being tested with
>   *
>   * Compare the ntfs attribute embedded in the ntfs specific part of the vfs
> - * inode @vi for equality with the ntfs attribute @na.
> + * inode @vi for equality with the ntfs attribute @data.
>   *
>   * If searching for the normal file/directory inode, set @na->type to AT_UNUSED.
>   * @na->name and @na->name_len are then ignored.
> @@ -43,8 +43,9 @@
>   * NOTE: This function runs with the inode_hash_lock spin lock held so it is not
>   * allowed to sleep.
>   */
> -int ntfs_test_inode(struct inode *vi, ntfs_attr *na)
> +int ntfs_test_inode(struct inode *vi, void *data)
>  {
> +	ntfs_attr *na = (ntfs_attr *)data;
>  	ntfs_inode *ni;
>  
>  	if (vi->i_ino != na->mft_no)
> @@ -72,9 +73,9 @@ int ntfs_test_inode(struct inode *vi, ntfs_attr *na)
>  /**
>   * ntfs_init_locked_inode - initialize an inode
>   * @vi:		vfs inode to initialize
> - * @na:		ntfs attribute which to initialize @vi to
> + * @data:	data which to initialize @vi to
>   *
> - * Initialize the vfs inode @vi with the values from the ntfs attribute @na in
> + * Initialize the vfs inode @vi with the values from the ntfs attribute @data in
>   * order to enable ntfs_test_inode() to do its work.
>   *
>   * If initializing the normal file/directory inode, set @na->type to AT_UNUSED.
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
> 2.27.0
> 
