Return-Path: <SRS0=QAx1=7P=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 280BEC433E1
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Jun 2020 04:31:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id F3DB620738
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Jun 2020 04:31:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1591072261;
	bh=0nbg6kMD7WBNVbmFBlzuDH0AdewvD0E4QqajyuVMm+w=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=zYGZaXHlYaWbp+pzZkjn6imQjEzq/ahRMmOOaev2CLsmBm+tMYnlUqzGwIbRHaKXU
	 DnnQhgnV81YHkgaW96k/7wmzyf7szgtRMIgS+Skipe2q4LY+KzFuUeHkO1gHyhrYUl
	 kiG3JSgP4aab2UA0ER2w3JAM4cCOFBs3t1N2nafA=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726096AbgFBEbA (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 2 Jun 2020 00:31:00 -0400
Received: from mail.kernel.org ([198.145.29.99]:59616 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725793AbgFBEbA (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 Jun 2020 00:31:00 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id E86D1206C3;
        Tue,  2 Jun 2020 04:30:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1591072259;
        bh=0nbg6kMD7WBNVbmFBlzuDH0AdewvD0E4QqajyuVMm+w=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=BBLYv321uyAisaAZKs2pq3wAP5vv/KPdcAWHcKxg0/bj8PnF3H43n1yaJY+Ky3YQI
         IbixkDcpUpUOGIyp2xozrXAUFhbe42q/He/3fouHREN5FIbuaO7RscestsCM7wFvWI
         nZWmAATvhEzomrLM3Sm52JhZ7VPtw5/rPaepre8w=
Date:   Tue, 2 Jun 2020 06:30:56 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Barry Song <song.bao.hua@hisilicon.com>
Cc:     rafael@kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] driver core: platform: need consistent spacing around '-'
Message-ID: <20200602043056.GA2142385@kroah.com>
References: <20200602034717.71788-1-song.bao.hua@hisilicon.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200602034717.71788-1-song.bao.hua@hisilicon.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jun 02, 2020 at 03:47:17PM +1200, Barry Song wrote:
> Signed-off-by: Barry Song <song.bao.hua@hisilicon.com>
> ---
>  drivers/base/platform.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/base/platform.c b/drivers/base/platform.c
> index b27d0f6c18c9..ab9408182a0d 100644
> --- a/drivers/base/platform.c
> +++ b/drivers/base/platform.c
> @@ -1005,7 +1005,7 @@ static ssize_t modalias_show(struct device *dev, struct device_attribute *a,
>  	if (len != -ENODEV)
>  		return len;
>  
> -	len = acpi_device_modalias(dev, buf, PAGE_SIZE -1);
> +	len = acpi_device_modalias(dev, buf, PAGE_SIZE - 1);
>  	if (len != -ENODEV)
>  		return len;
>  
> -- 
> 2.23.0
> 
> 

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

- You did not specify a description of why the patch is needed, or
  possibly, any description at all, in the email body.  Please read the
  section entitled "The canonical patch format" in the kernel file,
  Documentation/SubmittingPatches for what is needed in order to
  properly describe the change.

If you wish to discuss this problem further, or you have questions about
how to resolve this issue, please feel free to respond to this email and
Greg will reply once he has dug out from the pending patches received
from other developers.

thanks,

greg k-h's patch email bot
