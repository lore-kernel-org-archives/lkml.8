Return-Path: <SRS0=shi3=4A=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A9012C2BA83
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Feb 2020 07:59:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7CD91206DB
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Feb 2020 07:59:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1581494374;
	bh=i14A9J9hpgpvFg3Uo6lAkikCx/JaXzNhPWUOPAr8/xI=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=x3sdYHS8fvE9CqhslD1JIrzjsXXnMtg+OyTQM4z60+4xDfCAP5U3lBmVzS4N2IE7u
	 +FbzvgH043wdHs9Am9zb6vO2UoA01e+wSzcFzS5fqgj0q/jZ8GdKn9NXvRRdCxmxS/
	 ZmkV/pI6eUCyU7QyDYRwJddomVwbuUI/NhJ1IBlI=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728442AbgBLH7d (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 12 Feb 2020 02:59:33 -0500
Received: from mail-lj1-f196.google.com ([209.85.208.196]:44440 "EHLO
        mail-lj1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728250AbgBLH7d (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Feb 2020 02:59:33 -0500
Received: by mail-lj1-f196.google.com with SMTP id q8so1157903ljj.11;
        Tue, 11 Feb 2020 23:59:32 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=ckD3dBez4wVRfdf+Cbf8pOGR+4nkWo4QLK+apFAS7kQ=;
        b=HO8ROIUa3Fx9Cf2VlGk0CfxVIeOHxjYTY3bIiUeXgVrpV4MnIpEm54VLNmMKQzs/r2
         EnlR6Se7MM1U2v9s2WZkvnY3lrlAD3T9T3/65NU393gMwCyn/XKXGtvdqdlzxbhvJCQu
         ZuTWof6JXi1u5TA1OmUSCFwlG/0nN5ASmcUFG5Xlw1nNvFDqqF7pZ7c1N2EcjJ4ze7nW
         tnvjR1kRAHfFhxEIclsrGSIwKsY8HFKAIKqbnOJ25jc7vHIKodDNxZutBvK/vr656i1X
         e1UwB6DBiI6WSyrnDjMC0dkeAQ97B99uBgQFUBtyMK5IcP7GUqek8144MYdPsXclzzMA
         zVZQ==
X-Gm-Message-State: APjAAAXJUGXHbY46iuhsIkxAzfSJJ6A9iX+MVOGDMhQyxZowyqAIt8Z5
        0r1ObZLCCjbeYN7eyLMV6ZM=
X-Google-Smtp-Source: APXvYqykknzoF6XL4gncXU2NZtkDtiRKMRvFI6HHf1YJH7oaEpQm3+1gGStpZKikF9eqqqZrOZ/8EQ==
X-Received: by 2002:a05:651c:327:: with SMTP id b7mr6441062ljp.22.1581494371256;
        Tue, 11 Feb 2020 23:59:31 -0800 (PST)
Received: from xi.terra (c-12aae455.07-184-6d6c6d4.bbcust.telenor.se. [85.228.170.18])
        by smtp.gmail.com with ESMTPSA id g15sm3513421ljk.8.2020.02.11.23.59.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 11 Feb 2020 23:59:30 -0800 (PST)
Received: from johan by xi.terra with local (Exim 4.92.3)
        (envelope-from <johan@kernel.org>)
        id 1j1mvh-0006qy-GF; Wed, 12 Feb 2020 08:59:29 +0100
Date:   Wed, 12 Feb 2020 08:59:29 +0100
From:   Johan Hovold <johan@kernel.org>
To:     "Gustavo A. R. Silva" <gustavo@embeddedor.com>
Cc:     Johan Hovold <johan@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] USB: serial: ti_usb_3410_5052: Replace zero-length array
 with flexible-array member
Message-ID: <20200212075929.GE4150@localhost>
References: <20200211232420.GA22388@embeddedor>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200211232420.GA22388@embeddedor>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Feb 11, 2020 at 05:24:20PM -0600, Gustavo A. R. Silva wrote:
> The current codebase makes use of the zero-length array language
> extension to the C90 standard, but the preferred mechanism to declare
> variable-length types such as these ones is a flexible array member[1][2],
> introduced in C99:
> 
> struct foo {
>         int stuff;
>         struct boo array[];
> };
> 
> By making use of the mechanism above, we will get a compiler warning
> in case the flexible array does not occur last in the structure, which
> will help us prevent some kind of undefined behavior bugs from being
> inadvertenly introduced[3] to the codebase from now on.
> 
> This issue was found with the help of Coccinelle.

Same here, the scripts may need to be updated as you missed a couple of
instances:

	$ git grep '\[0\];' drivers/usb/serial
	...
	drivers/usb/serial/io_usbvend.h:        __u8    Data[0];                // Data starts here
	drivers/usb/serial/io_usbvend.h:        __u8    Data[0];                // Download starts here
	...

Could you replace these as well so that is done in one patch per
subsystem?

> [1] https://gcc.gnu.org/onlinedocs/gcc/Zero-Length.html
> [2] https://github.com/KSPP/linux/issues/21
> [3] commit 76497732932f ("cxgb3/l2t: Fix undefined behaviour")
> 
> Signed-off-by: Gustavo A. R. Silva <gustavo@embeddedor.com>
> ---
>  drivers/usb/serial/ti_usb_3410_5052.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/usb/serial/ti_usb_3410_5052.c b/drivers/usb/serial/ti_usb_3410_5052.c
> index dd0ad67aa71e..db3ab25d9228 100644
> --- a/drivers/usb/serial/ti_usb_3410_5052.c
> +++ b/drivers/usb/serial/ti_usb_3410_5052.c
> @@ -219,7 +219,7 @@ struct ti_write_data_bytes {
>  	u8	bDataCounter;
>  	__be16	wBaseAddrHi;
>  	__be16	wBaseAddrLo;
> -	u8	bData[0];
> +	u8	bData[];
>  } __packed;
>  
>  struct ti_read_data_request {
> @@ -234,7 +234,7 @@ struct ti_read_data_bytes {
>  	__u8	bCmdCode;
>  	__u8	bModuleId;
>  	__u8	bErrorCode;
> -	__u8	bData[0];
> +	__u8	bData[];
>  } __packed;
>  
>  /* Interrupt struct */

Thanks,
Johan
