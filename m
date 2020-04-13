Return-Path: <SRS0=sVLE=55=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 68B12C2BBC7
	for <linux-kernel@archiver.kernel.org>; Mon, 13 Apr 2020 12:51:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 499DE2075E
	for <linux-kernel@archiver.kernel.org>; Mon, 13 Apr 2020 12:51:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1586782284;
	bh=Rayx+MRYCQEtj89eA+kyobt0P8lMJiZzafHkc2EDbQw=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=lWe1qAHQDG3eCjfRIQ2OuK66m51GIxVgDyQ3pw3mqIEy5Jg5d31mj5xx7lIEztm5L
	 eEel573f5Fr+TO8Po2/fCWlEV9yOv//CMV6TRKNLm7prEWHIzeQ5zSuisrbZviTA+8
	 iBm51azbREbWfU/n4MkcHzBc9ydIhtzsf9emF+6I=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729556AbgDMMuT (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 13 Apr 2020 08:50:19 -0400
Received: from mail.kernel.org ([198.145.29.99]:52120 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727797AbgDMMuS (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Apr 2020 08:50:18 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 3664F2073E;
        Mon, 13 Apr 2020 12:50:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1586782217;
        bh=Rayx+MRYCQEtj89eA+kyobt0P8lMJiZzafHkc2EDbQw=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=aMoMyywzHZmjaH6IWib62vFVj99zzfia6ejQsc7H18hNH6FjKuJEjXj18MAuqYboP
         NxJ11byYyrPjOVzy/jmK8BpEl2wXZ68g8lw8IQWBaA3RcHOI/fvYJIxi4B7lb9AX8q
         rZYdoYnnCRbscuuW35AW3wRqc9CPYMhaHoLb96hQ=
Date:   Mon, 13 Apr 2020 14:50:15 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Camylla Goncalves Cantanheide <c.cantanheide@gmail.com>
Cc:     navid.emamdoost@gmail.com, sylphrenadin@gmail.com,
        nishkadg.linux@gmail.com, stephen@brennan.io,
        devel@driverdev.osuosl.org, linux-kernel@vger.kernel.org,
        lkcamp@lists.libreplanetbr.org
Subject: Re: [PATCH 1/2] staging: rtl8192u: Refactoring setKey function
Message-ID: <20200413125015.GA3077651@kroah.com>
References: <20200413030129.861-1-c.cantanheide@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200413030129.861-1-c.cantanheide@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Apr 13, 2020 at 03:01:28AM +0000, Camylla Goncalves Cantanheide wrote:
> Changes of the local variable value and
> modification in the seletive repetition structure.
> 
> Signed-off-by: Camylla Goncalves Cantanheide <c.cantanheide@gmail.com>
> ---
>  drivers/staging/rtl8192u/r8192U_core.c | 52 ++++++++++++--------------
>  1 file changed, 24 insertions(+), 28 deletions(-)
> 
> diff --git a/drivers/staging/rtl8192u/r8192U_core.c b/drivers/staging/rtl8192u/r8192U_core.c
> index 9b8d85a4855d..87c02aee3854 100644
> --- a/drivers/staging/rtl8192u/r8192U_core.c
> +++ b/drivers/staging/rtl8192u/r8192U_core.c
> @@ -4880,7 +4880,7 @@ void EnableHWSecurityConfig8192(struct net_device *dev)
>  void setKey(struct net_device *dev, u8 entryno, u8 keyindex, u16 keytype,
>  	    u8 *macaddr, u8 defaultkey, u32 *keycontent)
>  {
> -	u32 target_command = 0;
> +	u32 target_command = CAM_CONTENT_COUNT * entryno |  BIT(31) | BIT(16);
>  	u32 target_content = 0;
>  	u16 us_config = 0;
>  	u8 i;
> @@ -4890,39 +4890,35 @@ void setKey(struct net_device *dev, u8 entryno, u8 keyindex, u16 keytype,
>  
>  	RT_TRACE(COMP_SEC,
>  		 "====>to %s, dev:%p, EntryNo:%d, KeyIndex:%d, KeyType:%d, MacAddr%pM\n",
> -        	 __func__, dev, entryno, keyindex, keytype, macaddr);
> +		 __func__, dev, entryno, keyindex, keytype, macaddr);
>  
>  	if (defaultkey)
>  		us_config |= BIT(15) | (keytype << 2);
>  	else
>  		us_config |= BIT(15) | (keytype << 2) | keyindex;
>  
> -	for (i = 0; i < CAM_CONTENT_COUNT; i++) {
> -		target_command  = i + CAM_CONTENT_COUNT * entryno;
> -		target_command |= BIT(31) | BIT(16);
> -
> -		if (i == 0) { /* MAC|Config */
> -			target_content = (u32)(*(macaddr + 0)) << 16 |
> -					(u32)(*(macaddr + 1)) << 24 |
> -					(u32)us_config;
> -
> -			write_nic_dword(dev, WCAMI, target_content);
> -			write_nic_dword(dev, RWCAM, target_command);
> -		} else if (i == 1) { /* MAC */
> -			target_content = (u32)(*(macaddr + 2))	 |
> -					(u32)(*(macaddr + 3)) <<  8 |
> -					(u32)(*(macaddr + 4)) << 16 |
> -					(u32)(*(macaddr + 5)) << 24;
> -			write_nic_dword(dev, WCAMI, target_content);
> -			write_nic_dword(dev, RWCAM, target_command);
> -		} else {
> -			/* Key Material */
> -			if (keycontent) {
> -				write_nic_dword(dev, WCAMI,
> -						*(keycontent + i - 2));
> -				write_nic_dword(dev, RWCAM, target_command);
> -                	}
> -		}
> +	target_content = macaddr[0] << 16 |
> +			 macaddr[0] << 24 |
> +			(u32)us_config;
> +
> +	write_nic_dword(dev, WCAMI, target_content);
> +	write_nic_dword(dev, RWCAM, target_command++);
> +
> +	/* MAC */
> +	target_content = macaddr[2]	  |
> +			 macaddr[3] <<  8 |
> +			 macaddr[4] << 16 |
> +			 macaddr[5] << 24;
> +	write_nic_dword(dev, WCAMI, target_content);
> +	write_nic_dword(dev, RWCAM, target_command++);
> +
> +	/* Key Material */
> +	if (!keycontent)
> +		return;
> +
> +	for (i = 2; i < CAM_CONTENT_COUNT; i++) {
> +		write_nic_dword(dev, WCAMI, *keycontent++);
> +		write_nic_dword(dev, RWCAM, target_command++);
>  	}
>  }
>  
> -- 
> 2.20.1
> 
> _______________________________________________
> devel mailing list
> devel@linuxdriverproject.org
> http://driverdev.linuxdriverproject.org/mailman/listinfo/driverdev-devel

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

- Your patch did many different things all at once, making it difficult
  to review.  All Linux kernel patches need to only do one thing at a
  time.  If you need to do multiple things (such as clean up all coding
  style issues in a file/driver), do it in a sequence of patches, each
  one doing only one thing.  This will make it easier to review the
  patches to ensure that they are correct, and to help alleviate any
  merge issues that larger patches can cause.

- You did not specify a description of why the patch is needed, or
  possibly, any description at all, in the email body.  Please read the
  section entitled "The canonical patch format" in the kernel file,
  Documentation/SubmittingPatches for what is needed in order to
  properly describe the change.

- You did not write a descriptive Subject: for the patch, allowing Greg,
  and everyone else, to know what this patch is all about.  Please read
  the section entitled "The canonical patch format" in the kernel file,
  Documentation/SubmittingPatches for what a proper Subject: line should
  look like.

If you wish to discuss this problem further, or you have questions about
how to resolve this issue, please feel free to respond to this email and
Greg will reply once he has dug out from the pending patches received
from other developers.

thanks,

greg k-h's patch email bot
