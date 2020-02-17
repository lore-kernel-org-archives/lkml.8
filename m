Return-Path: <SRS0=PfNx=4F=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5127FC7619F
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Feb 2020 09:40:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2892A2070B
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Feb 2020 09:40:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1581932441;
	bh=fksEsw2TEJe3oWeqVvBmZb9SfqjxPG70zCcZxBZL/mc=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=aXNeR7H/j978rpOE2M9N/yCu0/ty7xcaYfpKBBA1p/qzSSu7/jCDImOX6mjUDlaE8
	 2prA1xz0xl2FMhl+dgauLhADt7AnBWHmO6cYV5gAlaQChblWR5hyZH9ACJI116DnBY
	 Is2HiSHt2FunUqp2ThdajffFHG68g17VZwzq/v1Q=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729000AbgBQJkk (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 17 Feb 2020 04:40:40 -0500
Received: from mail.kernel.org ([198.145.29.99]:40512 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728919AbgBQJkj (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Feb 2020 04:40:39 -0500
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 96F742070B;
        Mon, 17 Feb 2020 09:40:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1581932439;
        bh=fksEsw2TEJe3oWeqVvBmZb9SfqjxPG70zCcZxBZL/mc=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=SVkGBK7bQk9qU8H1FYIAn2BmVTJNjUnYYLY3ulODrRl30OKVNL5RxzZjstyEFcwrM
         t5f07SSslsDClvAsEY/plVTMx6Sm1LzPCeEnKhu+op3yYDyr249Y2Ejy+AlPgvLvV9
         UQY5goxPYdqOEnpnP5/2jSsU15GHFsjkx7QkD6gA=
Date:   Mon, 17 Feb 2020 10:40:36 +0100
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Joe Perches <joe@perches.com>
Cc:     Alan Stern <stern@rowland.harvard.edu>, linux-usb@vger.kernel.org,
        usb-storage@lists.one-eyed-alien.net,
        linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] usb-storage: Use const to reduce object data size
Message-ID: <20200217094036.GA47231@kroah.com>
References: <60559197a1af9e0af7f329cc3427989e5756846f.camel@perches.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <60559197a1af9e0af7f329cc3427989e5756846f.camel@perches.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Feb 14, 2020 at 10:15:57AM -0800, Joe Perches wrote:
> Make structs const to reduce data size ~20KB.
> 
> Change function arguments and prototypes as necessary to compile.
> 
> $ size (x86-64 defconfig pre)
>    text	   data	    bss	    dec	    hex	filename
>   12281	  10948	    480	  23709	   5c9d	./drivers/usb/storage/usb.o
>     111	  10528	      8	  10647	   2997	./drivers/usb/storage/usual-tables.o
> 
> $ size (x86-64 defconfig post)
>    text	   data	    bss	    dec	    hex	filename
>   22809	    420	    480	  23709	   5c9d	drivers/usb/storage/usb.o
>   10551	      0	      0	  10551	   2937	drivers/usb/storage/usual-tables.o
> 
> Signed-off-by: Joe Perches <joe@perches.com>
> ---
> 
> compile tested only
> 
>  drivers/usb/storage/usb.c          | 10 +++++-----
>  drivers/usb/storage/usb.h          |  5 +++--
>  drivers/usb/storage/usual-tables.c |  6 +++---
>  include/linux/usb_usual.h          |  2 +-
>  4 files changed, 12 insertions(+), 11 deletions(-)
> 
> diff --git a/drivers/usb/storage/usb.c b/drivers/usb/storage/usb.c
> index 9a79cd..94a6472 100644
> --- a/drivers/usb/storage/usb.c
> +++ b/drivers/usb/storage/usb.c
> @@ -121,12 +121,12 @@ MODULE_PARM_DESC(quirks, "supplemental list of
> device IDs and their quirks");
>  	.initFunction = init_function,	\
>  }
>  
> -static struct us_unusual_dev us_unusual_dev_list[] = {
> +static const struct us_unusual_dev us_unusual_dev_list[] = {
>  #	include "unusual_devs.h"
>  	{ }		/* Terminating entry */
>  };
>  
> -static struct us_unusual_dev for_dynamic_ids =
> +static const struct us_unusual_dev for_dynamic_ids =
>  		USUAL_DEV(USB_SC_SCSI, USB_PR_BULK);
>  
>  #undef UNUSUAL_DEV
> @@ -583,7 +583,7 @@ EXPORT_SYMBOL_GPL(usb_stor_adjust_quirks);
>  
>  /* Get the unusual_devs entries and the string descriptors */
>  static int get_device_info(struct us_data *us, const struct
> usb_device_id *id,

Patch is line-wrapped and does not apply at all :(

