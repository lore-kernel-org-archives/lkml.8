Return-Path: <SRS0=fzvl=3P=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.9 required=3.0 tests=DATE_IN_PAST_12_24,
	DKIMWL_WL_HIGH,DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1358DC3F68F
	for <linux-kernel@archiver.kernel.org>; Sun, 26 Jan 2020 07:43:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DCFED214AF
	for <linux-kernel@archiver.kernel.org>; Sun, 26 Jan 2020 07:43:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1580024582;
	bh=UcAPO1fkxYC4ytyKX1oTy8cKaRy2y2XXPJoZZhR3HRM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=fAobPMzBCP8Kqf9y+WbCV0jdkQbrhLH2Txl6D5IaYEmIsAJpEEBYkgRoMlncZgqh4
	 5MeUKwjYdf1/h8ksQI7vFjQGjm0Mad68T4pXHVCrcrHkCwzR3Hvbrsns7P8yOmbsRf
	 Nf4SZibfOWnpBRowJiO52yPYQ36cZ1aJmKg+1sT0=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729134AbgAZHnA (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 26 Jan 2020 02:43:00 -0500
Received: from mail.kernel.org ([198.145.29.99]:48278 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726426AbgAZHnA (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 26 Jan 2020 02:43:00 -0500
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 84A662071E;
        Sun, 26 Jan 2020 07:42:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1580024579;
        bh=UcAPO1fkxYC4ytyKX1oTy8cKaRy2y2XXPJoZZhR3HRM=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=MUnjdjSiO+93K2gosmx9muHilww8DDnIaDl1yb9MgidpGc7L+ryjgf5HzNKDBiUwL
         28mGAvCoph4j5xoP/y1tqIvdGLc/UaMxw1rKvSKnmoch64U/bSAqIdVM+FK1gd2MLO
         Sr7HJFObHfskjwzYafH+gR+IPkCGl5HML8cEdnrQ=
Date:   Sat, 25 Jan 2020 14:38:14 +0100
From:   "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>
To:     Pragat Pandya <pragat.pandya@gmail.com>
Cc:     "valdis.kletnieks@vt.edu" <valdis.kletnieks@vt.edu>,
        ppandya2103@gmail.com,
        "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>,
        "devel@driverdev.osuosl.org" <devel@driverdev.osuosl.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        linux-kernel-mentees@lists.linuxfoundation.org
Subject: Re: [RESEND PATCH] staging: exfat: Fix alignment warnings
Message-ID: <20200125133814.GA3518118@kroah.com>
References: <7278a1cb979cd574bccbbbccaf1a9c90acd514b5.camel@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <7278a1cb979cd574bccbbbccaf1a9c90acd514b5.camel@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Jan 25, 2020 at 05:49:48PM +0530, Pragat Pandya wrote:
> Fix checkpatch warning "Alignment should match open parenthesis".
> 
> Signed-off-by: Pragat Pandya <pragat.pandya@gmail.com>
> ---
>  drivers/staging/exfat/exfat_blkdev.c |  4 ++--
>  drivers/staging/exfat/exfat_core.c   | 29 ++++++++++++++--------------
>  drivers/staging/exfat/exfat_super.c  |  2 +-
>  3 files changed, 18 insertions(+), 17 deletions(-)
> 
> diff --git a/drivers/staging/exfat/exfat_blkdev.c
> b/drivers/staging/exfat/exfat_blkdev.c
> index 7bcd98b13109..3068bfda39e4 100644
> --- a/drivers/staging/exfat/exfat_blkdev.c
> +++ b/drivers/staging/exfat/exfat_blkdev.c
> @@ -31,7 +31,7 @@ void exfat_bdev_close(struct super_block *sb)
>  }
>  
>  int exfat_bdev_read(struct super_block *sb, sector_t secno, struct
> buffer_head **bh,
> -             u32 num_secs, bool read)
> +                   u32 num_secs, bool read)

Hi,

This is the friendly patch-bot of Greg Kroah-Hartman.  You have sent him
a patch that has triggered this response.  He used to manually respond
to these common problems, but in order to save his sanity (he kept
writing the same thing over and over, yet to different people), I was
created.  Hopefully you will not take offence and will fix the problem
in your patch and resubmit it so that it can be accepted into the Linux
kernel tree.

You are receiving this message because of the following common error(s)
as indicated below:

- Your patch is malformed (tabs converted to spaces, linewrapped, etc.)
  and can not be applied.  Please read the file,
  Documentation/email-clients.txt in order to fix this.

If you wish to discuss this problem further, or you have questions about
how to resolve this issue, please feel free to respond to this email and
Greg will reply once he has dug out from the pending patches received
from other developers.

thanks,

greg k-h's patch email bot
