Return-Path: <SRS0=eufF=BE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.0 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9514AC433DF
	for <linux-kernel@archiver.kernel.org>; Sat, 25 Jul 2020 06:37:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6B11D20719
	for <linux-kernel@archiver.kernel.org>; Sat, 25 Jul 2020 06:37:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1595659036;
	bh=TqBid881gbTdHYWUqMo1o1X4MNRMshLRJeGzN4al/UU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=OIGyqz4YEOiGuG+pkNWqZsIOhQVONDTCd/HoKPyIAsozrR86t8fRPr+tZt/JwRQ9o
	 xaoZAKN8eKyRLkw+Zo1FvtpYbqsEpnlLT8xv5AV+PXQw/YVvW7G+LLYpCJ3y7JPCKp
	 f12BpxOxbNweIHCIC+M9pbxRPJ4cmwKUzkmH22jw=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726981AbgGYGhC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 25 Jul 2020 02:37:02 -0400
Received: from mail.kernel.org ([198.145.29.99]:41688 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725941AbgGYGhB (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 25 Jul 2020 02:37:01 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id C2F812070E;
        Sat, 25 Jul 2020 06:37:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1595659021;
        bh=TqBid881gbTdHYWUqMo1o1X4MNRMshLRJeGzN4al/UU=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=itgm4LppO2guNmU4POTZuG0/5SrzYDgkpKnsojwJbWKL13TF4trwhVTzHL4dK4H2t
         u1VlQ6Ruhosttf2w2vRaksx89173u1V9PZqyhPR9wlYaghf58p6UN/6hc0yJySZsaf
         PFrQuP4Wn818Gk4flt289c+few8n9VH7cA/WNK1Q=
Date:   Sat, 25 Jul 2020 08:37:01 +0200
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Wei Yongjun <weiyongjun1@huawei.com>
Cc:     Miquel Raynal <miquel.raynal@bootlin.com>,
        Richard Weinberger <richard@nod.at>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        linux-mtd@lists.infradead.org, linux-kernel@vger.kernel.org,
        kernel-janitors@vger.kernel.org, Hulk Robot <hulkci@huawei.com>
Subject: Re: [PATCH -next] mtd: fix missing unlock on error in
 mtdchar_compat_ioctl()
Message-ID: <20200725063701.GA1058480@kroah.com>
References: <20200725063416.172037-1-weiyongjun1@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200725063416.172037-1-weiyongjun1@huawei.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Jul 25, 2020 at 06:34:16AM +0000, Wei Yongjun wrote:
> Add the missing unlock before return from function mtdchar_compat_ioctl()
> in the error handling case.
> 
> Fixes: 210bec567936 ("mtd: properly check all write ioctls for permissions")
> Reported-by: Hulk Robot <hulkci@huawei.com>
> Signed-off-by: Wei Yongjun <weiyongjun1@huawei.com>
> ---
>  drivers/mtd/mtdchar.c | 6 ++++--
>  1 file changed, 4 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/mtd/mtdchar.c b/drivers/mtd/mtdchar.c
> index 52c120f9fb0d..b40f46a43fc6 100644
> --- a/drivers/mtd/mtdchar.c
> +++ b/drivers/mtd/mtdchar.c
> @@ -1064,8 +1064,10 @@ static long mtdchar_compat_ioctl(struct file *file, unsigned int cmd,
>  		struct mtd_oob_buf32 buf;
>  		struct mtd_oob_buf32 __user *buf_user = argp;
>  
> -		if (!(file->f_mode & FMODE_WRITE))
> -			return -EPERM;
> +		if (!(file->f_mode & FMODE_WRITE)) {
> +			ret = -EPERM;
> +			break;
> +		}
>  
>  		if (copy_from_user(&buf, argp, sizeof(buf)))
>  			ret = -EFAULT;
> 
> 
> 

I think Richard already resolved this in his tree, but I could be wrong.

And nice detection by your bot, that's good to see.

thanks,

greg k-h
