Return-Path: <SRS0=j27y=4W=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 40F18C3F2D2
	for <linux-kernel@archiver.kernel.org>; Thu,  5 Mar 2020 18:45:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 18622207FD
	for <linux-kernel@archiver.kernel.org>; Thu,  5 Mar 2020 18:45:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1583433923;
	bh=psjSyz6vdZGPl/xqFFUayAS2GQX1IEdZO+cta5jUIwc=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=z9KuOHZIBTjFfKR7fMwb8Dfz6GVHUrGb/QkPPWcXNoqJdfIWFNh/cf+ss+NX1EaQb
	 jK/H0tbZ3frn34iQeM198NVU6fNjMB8XaeoL12A0wHiIhsJudwjgviuyIACsSzyEOS
	 3Y/leMOiszrTIapz2+lxwWUCIf4pQduhOkR3q2q4=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726811AbgCESpW (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 5 Mar 2020 13:45:22 -0500
Received: from mail.kernel.org ([198.145.29.99]:45916 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726275AbgCESpV (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Mar 2020 13:45:21 -0500
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 8692C2072D;
        Thu,  5 Mar 2020 18:45:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1583433920;
        bh=psjSyz6vdZGPl/xqFFUayAS2GQX1IEdZO+cta5jUIwc=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=xq/t4n1rMZB+lbOw37tYhQzBztl2fGM/23HLuK70yNAC3quB28r8n/MjElg0f9vVt
         lo8WWomFsAEbA225T9MNvASYCjaSHxYaVkJA/mWYUfGlC4PueoNzepaS0s7CYlXNWW
         fI230MSCnOkOdPxsqyklMKSYmG9M71BHtju/IeCI=
Date:   Thu, 5 Mar 2020 19:45:17 +0100
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Angelo Dureghello <angelo.dureghello@timesys.com>
Cc:     linux-kernel@vger.kernel.org, zbr@ioremap.net
Subject: Re: [PATCH] w1: ds2430: non functional fixes
Message-ID: <20200305184517.GA2141048@kroah.com>
References: <20200305183951.2647785-1-angelo.dureghello@timesys.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200305183951.2647785-1-angelo.dureghello@timesys.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Mar 05, 2020 at 07:39:51PM +0100, Angelo Dureghello wrote:
> Mainly discovered a typo in the eeprom size that may lead to
> misunderstandings.
> 
> Signed-off-by: Angelo Dureghello <angelo.dureghello@timesys.com>
> ---
>  drivers/w1/slaves/w1_ds2430.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/w1/slaves/w1_ds2430.c b/drivers/w1/slaves/w1_ds2430.c
> index 6fb0563fb2ae..67d168ddfb60 100644
> --- a/drivers/w1/slaves/w1_ds2430.c
> +++ b/drivers/w1/slaves/w1_ds2430.c
> @@ -1,7 +1,7 @@
>  // SPDX-License-Identifier: GPL-2.0-only
>  /*
>   * w1_ds2430.c - w1 family 14 (DS2430) driver
> - **
> + *
>   * Copyright (c) 2019 Angelo Dureghello <angelo.dureghello@timesys.com>
>   *
>   * Cloned and modified from ds2431
> @@ -290,6 +290,6 @@ static struct w1_family w1_family_14 = {
>  module_w1_family(w1_family_14);
>  
>  MODULE_AUTHOR("Angelo Dureghello <angelo.dureghello@timesys.com>");
> -MODULE_DESCRIPTION("w1 family 14 driver for DS2430, 256kb EEPROM");
> +MODULE_DESCRIPTION("w1 family 14 driver for DS2430, 256b EEPROM");
>  MODULE_LICENSE("GPL");
>  MODULE_ALIAS("w1-family-" __stringify(W1_EEPROM_DS2430));
> -- 
> 2.25.0
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
