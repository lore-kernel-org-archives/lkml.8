Return-Path: <SRS0=+GcV=BG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.0 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 42588C433E1
	for <linux-kernel@archiver.kernel.org>; Mon, 27 Jul 2020 13:36:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1B2202083E
	for <linux-kernel@archiver.kernel.org>; Mon, 27 Jul 2020 13:36:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1595856965;
	bh=2Yq+MaLWcEj3edk4hAYe+/GUUNPl7bYKU7VolZjMk8Q=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=Z1C76US6gu//PLIbLgqu6E7L0dJp72vfRy7cDbVoF6ri6N0PcrTlRZ7Yta4ylUd2B
	 UGr9b6zBKM+nwH74YkPfACEZQBR8MwtS0dyFKLIdpio5b2C01ZF3+xV7XBQbRatlo/
	 ecHNyYD6PlQ2Fyk6SO0puHDK+TeK88J4JHOT3SMg=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728993AbgG0NgD (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 27 Jul 2020 09:36:03 -0400
Received: from mail.kernel.org ([198.145.29.99]:38386 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726298AbgG0NgD (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Jul 2020 09:36:03 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 6E1732073E;
        Mon, 27 Jul 2020 13:36:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1595856963;
        bh=2Yq+MaLWcEj3edk4hAYe+/GUUNPl7bYKU7VolZjMk8Q=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=cOdBxxBt/q+rrdy3v0XAXcFUS9vLPTef2+ciFH6pn48TwW3z9CDqh5QGLeWXVS+bH
         XVsm7rkGWrJ+1AopPHwnzOS1Uw3vKOllI2CF4R2i0T0l2LyF+0Pnkv3M2Zy8ffsd9r
         o3wA/ex3iBmweMnlQ6936OrNIRMYqlRTwIuIfOm8=
Date:   Mon, 27 Jul 2020 15:35:58 +0200
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Dan Carpenter <dan.carpenter@oracle.com>
Cc:     Miquel Raynal <miquel.raynal@bootlin.com>,
        Richard Weinberger <richard@nod.at>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        linux-mtd@lists.infradead.org, linux-kernel@vger.kernel.org,
        kernel-janitors@vger.kernel.org
Subject: Re: [PATCH] mtd: unlock on error in ioctl
Message-ID: <20200727133558.GA28751@kroah.com>
References: <20200727112050.GF389488@mwanda>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200727112050.GF389488@mwanda>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jul 27, 2020 at 02:20:50PM +0300, Dan Carpenter wrote:
> We need to unlock before returning on this error path.
> 
> Fixes: 210bec567936 ("mtd: properly check all write ioctls for permissions")
> Signed-off-by: Dan Carpenter <dan.carpenter@oracle.com>
> ---
>  drivers/mtd/mtdchar.c | 7 +++++--
>  1 file changed, 5 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/mtd/mtdchar.c b/drivers/mtd/mtdchar.c
> index 52c120f9fb0d..05f9218592df 100644
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
> +			goto unlock;
> +		}
>  
>  		if (copy_from_user(&buf, argp, sizeof(buf)))
>  			ret = -EFAULT;
> @@ -1117,6 +1119,7 @@ static long mtdchar_compat_ioctl(struct file *file, unsigned int cmd,
>  		ret = mtdchar_ioctl(file, cmd, (unsigned long)argp);
>  	}
>  
> +unlock:
>  	mutex_unlock(&mtd_mutex);
>  
>  	return ret;
> -- 
> 2.27.0
> 

I think this is already fixed up in the mtd tree.

thanks,

greg k-h
