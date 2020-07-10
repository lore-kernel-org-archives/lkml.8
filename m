Return-Path: <SRS0=2Lxt=AV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9F348C433DF
	for <linux-kernel@archiver.kernel.org>; Fri, 10 Jul 2020 03:02:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 78BFF20767
	for <linux-kernel@archiver.kernel.org>; Fri, 10 Jul 2020 03:02:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1594350169;
	bh=kAsBqQZRZQ5C/sbtKjmCiPtuu3wHYS/cK2L+QzdWOnc=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=1E66vqO0ObF9W9TTY5C/WJO1/1S1LhSYeJziO6kZB8vwgPA512iWu6cBtMeWG9+b4
	 l91KIOKLfdJULwIcxtZtk6ff74q+HVEEhd2o/mO6pkTyLMyvfXgF1R0H+1/LAt8Fqb
	 lxtzEWqV3/rryHOL7La9lc5v4j5zGTZjervM5Erk=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726921AbgGJDCs (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 9 Jul 2020 23:02:48 -0400
Received: from mail.kernel.org ([198.145.29.99]:44324 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726509AbgGJDCr (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Jul 2020 23:02:47 -0400
Received: from localhost (unknown [104.132.1.66])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 295B82073A;
        Fri, 10 Jul 2020 03:02:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1594350167;
        bh=kAsBqQZRZQ5C/sbtKjmCiPtuu3wHYS/cK2L+QzdWOnc=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=tqHGwKlTh3pB/U89lbrCjuUTdiwUZEC2BCFgH+77JglaOhDpyn9Q8CuHHd8esUQEm
         ubL9ago1UFinysqXO7P8lb65P0L5AgHWks6mT7aNQ5MKO3FwNJYLot71b9/i2GwuPo
         FqTJYk/VtPS+E0m9qU/WNpqoI/rn+hin3jwpm3Qc=
Date:   Thu, 9 Jul 2020 20:02:46 -0700
From:   Jaegeuk Kim <jaegeuk@kernel.org>
To:     Daeho Jeong <daeho43@gmail.com>
Cc:     linux-kernel@vger.kernel.org,
        linux-f2fs-devel@lists.sourceforge.net, kernel-team@android.com,
        Daeho Jeong <daehojeong@google.com>
Subject: Re: [f2fs-dev] [PATCH] f2fs: change the way of handling range.len in
 F2FS_IOC_SEC_TRIM_FILE
Message-ID: <20200710030246.GA545837@google.com>
References: <20200710021505.2405872-1-daeho43@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200710021505.2405872-1-daeho43@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 07/10, Daeho Jeong wrote:
> From: Daeho Jeong <daehojeong@google.com>
> 
> Changed the way of handling range.len of F2FS_IOC_SEC_TRIM_FILE.
>  1. Added -1 value support for range.len to signify the end of file.
>  2. If the end of the range passes over the end of file, it means until
>     the end of file.
>  3. ignored the case of that range.len is zero to prevent the function
>     from making end_addr zero and triggering different behaviour of
>     the function.
> 
> Signed-off-by: Daeho Jeong <daehojeong@google.com>
> ---
>  fs/f2fs/file.c | 16 +++++++---------
>  1 file changed, 7 insertions(+), 9 deletions(-)
> 
> diff --git a/fs/f2fs/file.c b/fs/f2fs/file.c
> index 368c80f8e2a1..1c4601f99326 100644
> --- a/fs/f2fs/file.c
> +++ b/fs/f2fs/file.c
> @@ -3813,21 +3813,19 @@ static int f2fs_sec_trim_file(struct file *filp, unsigned long arg)
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
> -	}
> -	end_addr = range.start + range.len;
> +	if (range.len == (u64)-1 || inode->i_size - range.start < range.len)
> +		end_addr = inode->i_size;

Hmm, what if there are blocks beyond i_size? Do we need to check i_blocks for
ending criteria?

> +	else
> +		end_addr = range.start + range.len;
>  
>  	to_end = (end_addr == inode->i_size);
>  	if (!IS_ALIGNED(range.start, F2FS_BLKSIZE) ||
> -- 
> 2.27.0.383.g050319c2ae-goog
> 
> 
> 
> _______________________________________________
> Linux-f2fs-devel mailing list
> Linux-f2fs-devel@lists.sourceforge.net
> https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel
