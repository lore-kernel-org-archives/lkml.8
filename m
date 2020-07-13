Return-Path: <SRS0=gGKB=AY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5F628C433E1
	for <linux-kernel@archiver.kernel.org>; Mon, 13 Jul 2020 18:11:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2483B206F5
	for <linux-kernel@archiver.kernel.org>; Mon, 13 Jul 2020 18:11:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1594663915;
	bh=EU4XBUKixkiBQkaZjve6Zl3d8EFVm2Xr3DvAAaRr9v8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=s9KvTeLueAOtUQqZonu3ztozMpfeqE6/E+U5KZS2Nr13JP02vrGSkD5udyFS/jfOQ
	 nM4kRDPm4n4IRem9xjSuQXGxOQzxBM+Grp2d0iswOhjeah02WCbzrDNuXxOpzz8hqW
	 4FJZD4RnfPBcVUfMnB0orlup7MSmQ2SCCCVmZ4ns=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730279AbgGMSLy (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 13 Jul 2020 14:11:54 -0400
Received: from mail.kernel.org ([198.145.29.99]:47702 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729689AbgGMSLx (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Jul 2020 14:11:53 -0400
Received: from localhost (unknown [104.132.1.66])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id A1DC92067D;
        Mon, 13 Jul 2020 18:11:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1594663912;
        bh=EU4XBUKixkiBQkaZjve6Zl3d8EFVm2Xr3DvAAaRr9v8=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=u3FM4191eqbzPrCOk4wonTAFKU839z1y72CQ7CG/VQrqIhDysamckyPYvP2M5CG9x
         QqUkL6WCl4ZUrs6hVIJkYShQ346si7hwOtESi9PWTx43Q0inHqphIWL2KRkYcKBkUs
         i79cEVoYHX/hPgGFKVqMSjQgQaC9iV6lqbANXEms=
Date:   Mon, 13 Jul 2020 11:11:52 -0700
From:   Jaegeuk Kim <jaegeuk@kernel.org>
To:     Daeho Jeong <daeho43@gmail.com>
Cc:     linux-kernel@vger.kernel.org,
        linux-f2fs-devel@lists.sourceforge.net, kernel-team@android.com,
        Daeho Jeong <daehojeong@google.com>
Subject: Re: [PATCH v2] f2fs: change the way of handling range.len in
 F2FS_IOC_SEC_TRIM_FILE
Message-ID: <20200713181152.GC2910046@google.com>
References: <20200713031252.3873546-1-daeho43@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200713031252.3873546-1-daeho43@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Daeho,

Please take a look at this.

https://git.kernel.org/pub/scm/linux/kernel/git/jaegeuk/f2fs.git/commit/?h=dev&id=35245180459aebf6d70fde88a538f0400a794aa6

Thanks,

On 07/13, Daeho Jeong wrote:
> From: Daeho Jeong <daehojeong@google.com>
> 
> Changed the way of handling range.len of F2FS_IOC_SEC_TRIM_FILE.
>  1. Added -1 value support for range.len to secure trim the whole blocks
>     starting from range.start regardless of i_size.
>  2. If the end of the range passes over the end of file, it means until
>     the end of file (i_size).
>  3. ignored the case of that range.len is zero to prevent the function
>     from making end_addr zero and triggering different behaviour of
>     the function.
> 
> Signed-off-by: Daeho Jeong <daehojeong@google.com>
> ---
> Changes in v2:
>  - Changed -1 range.len option to mean the whole blocks starting from
>    range.start regardless of i_size
> ---
>  fs/f2fs/file.c | 23 ++++++++++++-----------
>  1 file changed, 12 insertions(+), 11 deletions(-)
> 
> diff --git a/fs/f2fs/file.c b/fs/f2fs/file.c
> index 368c80f8e2a1..2485841e3b2d 100644
> --- a/fs/f2fs/file.c
> +++ b/fs/f2fs/file.c
> @@ -3792,7 +3792,7 @@ static int f2fs_sec_trim_file(struct file *filp, unsigned long arg)
>  	pgoff_t index, pg_end;
>  	block_t prev_block = 0, len = 0;
>  	loff_t end_addr;
> -	bool to_end;
> +	bool to_end = false;
>  	int ret = 0;
>  
>  	if (!(filp->f_mode & FMODE_WRITE))
> @@ -3813,23 +3813,23 @@ static int f2fs_sec_trim_file(struct file *filp, unsigned long arg)
>  	file_start_write(filp);
>  	inode_lock(inode);
>  
> -	if (f2fs_is_atomic_file(inode) || f2fs_compressed_file(inode)) {
> +	if (f2fs_is_atomic_file(inode) || f2fs_compressed_file(inode) ||
> +			range.start >= inode->i_size) {
>  		ret = -EINVAL;
>  		goto err;
>  	}
>  
> -	if (range.start >= inode->i_size) {
> -		ret = -EINVAL;
> +	if (range.len == 0)
>  		goto err;
> -	}
>  
> -	if (inode->i_size - range.start < range.len) {
> -		ret = -E2BIG;
> -		goto err;
> +	if (inode->i_size - range.start > range.len) {
> +		end_addr = range.start + range.len;
> +	} else {
> +		end_addr = range.len == (u64)-1 ?
> +			sbi->sb->s_maxbytes : inode->i_size;
> +		to_end = true;
>  	}
> -	end_addr = range.start + range.len;
>  
> -	to_end = (end_addr == inode->i_size);
>  	if (!IS_ALIGNED(range.start, F2FS_BLKSIZE) ||
>  			(!to_end && !IS_ALIGNED(end_addr, F2FS_BLKSIZE))) {
>  		ret = -EINVAL;
> @@ -3846,7 +3846,8 @@ static int f2fs_sec_trim_file(struct file *filp, unsigned long arg)
>  	down_write(&F2FS_I(inode)->i_gc_rwsem[WRITE]);
>  	down_write(&F2FS_I(inode)->i_mmap_sem);
>  
> -	ret = filemap_write_and_wait_range(mapping, range.start, end_addr - 1);
> +	ret = filemap_write_and_wait_range(mapping, range.start,
> +			to_end ? LLONG_MAX : end_addr - 1);
>  	if (ret)
>  		goto out;
>  
> -- 
> 2.27.0.383.g050319c2ae-goog
