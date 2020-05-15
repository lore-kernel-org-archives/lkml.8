Return-Path: <SRS0=BsgQ=65=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 83ACEC433DF
	for <linux-kernel@archiver.kernel.org>; Fri, 15 May 2020 10:05:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 53E9D20709
	for <linux-kernel@archiver.kernel.org>; Fri, 15 May 2020 10:05:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1589537109;
	bh=yf/Bcnv7O6skIG8X503CVl+4UYSemnxT3mdUADsqf+k=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=GxWXs0g4V/0DdBZcHPnyuJH6Rovz2mB5irbJDrljQCjWCtaHF84879c9m45PW8FaL
	 HtIezpqzleU/X8kSqGLF77KPJDJgLWaSjEneHrcmAovuiUijh82+ztgLMe9jAq1uC2
	 SJTFQWO6vZ6f/uw0ic3Pwjk2aiuMW54JNjnz7y4c=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728113AbgEOKFI (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 15 May 2020 06:05:08 -0400
Received: from mail.kernel.org ([198.145.29.99]:55968 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728005AbgEOKFI (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 May 2020 06:05:08 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 62B69206F1;
        Fri, 15 May 2020 10:05:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1589537107;
        bh=yf/Bcnv7O6skIG8X503CVl+4UYSemnxT3mdUADsqf+k=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=1GhbEZ3d0a3dHufS6XzHsCXiHUvI0b5g6OyB49Az5W7tvoM6SosxiScjVanKbanXk
         wBygtkr7yJGgqB8CfyZCpG2AB9bHAOx+wCkW6o8XemJoZFbPjUNPybxsfukjHacpoX
         hC9uv7MZtEGlnXw6BV5bz6ewkJ1UQ+3BP+zKZid8=
Date:   Fri, 15 May 2020 12:05:05 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     heshuai1 <hexiaoshuaishuai@gmail.com>
Cc:     vkor@vkten.in, nishkadg.linux@gmail.com,
        devel@driverdev.osuosl.org, linux-kernel@vger.kernel.org,
        heshuai1 <heshuai1@xiaomi.com>
Subject: Re: [PATCH] rtl8723bs: core: fix a coding style error
Message-ID: <20200515100505.GA1619720@kroah.com>
References: <1589535644-6820-1-git-send-email-heshuai1@xiaomi.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1589535644-6820-1-git-send-email-heshuai1@xiaomi.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, May 15, 2020 at 05:40:44PM +0800, heshuai1 wrote:
> Fix this coding style error reported by checkpatch.pl:
>   ERROR: do not use assignment in if condition
>   #1120: FILE: drivers/staging/rtl8723bs/core/rtw_ieee80211.c:1120::
>   +	 if ((addr = of_get_property(np, "local-mac-address", &len)) &&
> 
> Signed-off-by: heshuai1 <heshuai1@xiaomi.com>
> ---
>  drivers/staging/rtl8723bs/core/rtw_ieee80211.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/staging/rtl8723bs/core/rtw_ieee80211.c b/drivers/staging/rtl8723bs/core/rtw_ieee80211.c
> index ca98274..06be1d4 100644
> --- a/drivers/staging/rtl8723bs/core/rtw_ieee80211.c
> +++ b/drivers/staging/rtl8723bs/core/rtw_ieee80211.c
> @@ -1117,8 +1117,8 @@ void rtw_macaddr_cfg(struct device *dev, u8 *mac_addr)
>  	}
>  
>  	if (is_broadcast_ether_addr(mac) || is_zero_ether_addr(mac)) {
> -		if ((addr = of_get_property(np, "local-mac-address", &len)) &&
> -		    len == ETH_ALEN) {
> +		addr = of_get_property(np, "local-mac-address", &len);
> +		if (addr && len == ETH_ALEN) {
>  			ether_addr_copy(mac_addr, addr);
>  		} else {
>  			eth_random_addr(mac_addr);
> -- 
> 2.7.4


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

- You did not write a descriptive Subject: for the patch, allowing Greg,
  and everyone else, to know what this patch is all about.  Please read
  the section entitled "The canonical patch format" in the kernel file,
  Documentation/SubmittingPatches for what a proper Subject: line should
  look like.

- It looks like you did not use your "real" name for the patch on either
  the Signed-off-by: line, or the From: line (both of which have to
  match).  Please read the kernel file, Documentation/SubmittingPatches
  for how to do this correctly.

If you wish to discuss this problem further, or you have questions about
how to resolve this issue, please feel free to respond to this email and
Greg will reply once he has dug out from the pending patches received
from other developers.

thanks,

greg k-h's patch email bot
