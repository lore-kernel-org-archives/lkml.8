Return-Path: <SRS0=eifh=6G=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 18B9FC55189
	for <linux-kernel@archiver.kernel.org>; Wed, 22 Apr 2020 07:49:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E53E22070B
	for <linux-kernel@archiver.kernel.org>; Wed, 22 Apr 2020 07:49:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1587541745;
	bh=Ukxttx4AhV/zn7a60uC4aTwvTrGOtjh/OZY1M5vynZ0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=mDLGetg6e1ttny5mjuyM+CedbresxGc9Pmpc4a6ferOIi7uekOy+mRjtagZUOQCig
	 VTsl+CheLdnrXYJ4eZYxOyOFLtbr/vxg8XzYmer74quo47o2gJvR19Lk2FJoWTVBOO
	 zwXGU5a6UaBamllVH/Pb9nuisOsMoy0joQ34IyIY=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726660AbgDVHtF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 22 Apr 2020 03:49:05 -0400
Received: from mail-lj1-f193.google.com ([209.85.208.193]:43728 "EHLO
        mail-lj1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726465AbgDVHtE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Apr 2020 03:49:04 -0400
Received: by mail-lj1-f193.google.com with SMTP id l19so1196734lje.10;
        Wed, 22 Apr 2020 00:49:02 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=epLkk574xfUuwBYwyvkq3l716pcv348uQ4qJKUQHi4U=;
        b=QQmRpP8qUwwXXpYQHOlJPCrw9P+RsiQtId6ba1aS5qRY7JJhXBvtwxOiY3/hywH4/n
         J6dWHLnEGTtgKn4d7N49qpZq0kQYqsO05tcRzFXF2RPfIWvIYL6CwL+hZ9IxnnnnoqIS
         5u4LkHiMvy5CZDtoS+qSYrMbCh5B9YIUWhUCcMH4YZX6nd1RscYOgP6Rr8piB58B4UKL
         ECKt8xAFK38PsgCdcexqCJzIfKCyliD3wYlSa9Lgr01bGxVrO7zIq0CjP4NYzuQOvSHr
         sFGopWDZGs3VDU3q0NPwla/apvDKDLzvhIdckB+v95CiUfyI2QMG+ZQZsHj0xiBp3VdQ
         62rg==
X-Gm-Message-State: AGi0PuaMdhVCGB/Et0pBCiTS1qz3OF+GMhAHOFPw5I+ZXpmuXaAZ1zxW
        VS5dR9czyin5TQza9xFPXrOPghaT
X-Google-Smtp-Source: APiQypIiUoAOJBfWMzQsrwByW5AXVw1jusi/WALzJ+lUAL5lDZ8V+Sd50eIz7PgI1BH+IjrTkUeSpQ==
X-Received: by 2002:a2e:b53b:: with SMTP id z27mr11767732ljm.114.1587541741978;
        Wed, 22 Apr 2020 00:49:01 -0700 (PDT)
Received: from xi.terra (c-beaee455.07-184-6d6c6d4.bbcust.telenor.se. [85.228.174.190])
        by smtp.gmail.com with ESMTPSA id u13sm3872384lji.27.2020.04.22.00.49.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 22 Apr 2020 00:49:01 -0700 (PDT)
Received: from johan by xi.terra with local (Exim 4.92.3)
        (envelope-from <johan@kernel.org>)
        id 1jRA84-0006dZ-5Z; Wed, 22 Apr 2020 09:49:08 +0200
Date:   Wed, 22 Apr 2020 09:49:08 +0200
From:   Johan Hovold <johan@kernel.org>
To:     Jason Yan <yanaijie@huawei.com>
Cc:     johan@kernel.org, gregkh@linuxfoundation.org,
        linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] USB: serial: garmin_gps: remove some defined but not
 used variables
Message-ID: <20200422074908.GJ18608@localhost>
References: <20200409085143.46078-1-yanaijie@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20200409085143.46078-1-yanaijie@huawei.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Apr 09, 2020 at 04:51:43PM +0800, Jason Yan wrote:
> Fix the following gcc warning:
> 
> drivers/usb/serial/garmin_gps.c:192:28: warning: ‘PRIVATE_REQ’ defined
> but not used [-Wunused-const-variable=]
>  static unsigned char const PRIVATE_REQ[]
>                             ^~~~~~~~~~~
> drivers/usb/serial/garmin_gps.c:186:28: warning: ‘GARMIN_STOP_PVT_REQ’
> defined but not used [-Wunused-const-variable=]
>  static unsigned char const GARMIN_STOP_PVT_REQ[]
>                             ^~~~~~~~~~~~~~~~~~~
> drivers/usb/serial/garmin_gps.c:184:28: warning: ‘GARMIN_START_PVT_REQ’
> defined but not used [-Wunused-const-variable=]
>  static unsigned char const GARMIN_START_PVT_REQ[]
>                             ^~~~~~~~~~~~~~~~~~~~
> drivers/usb/serial/garmin_gps.c:182:28: warning:
> ‘GARMIN_APP_LAYER_REPLY’ defined but not used [-Wunused-const-variable=]
>  static unsigned char const GARMIN_APP_LAYER_REPLY[]
>                             ^~~~~~~~~~~~~~~~~~~~~~
> 
> Reported-by: Hulk Robot <hulkci@huawei.com>
> Signed-off-by: Jason Yan <yanaijie@huawei.com>

You should mention that this is a W=1 one warning which isn't enabled
by default.

> ---
>  drivers/usb/serial/garmin_gps.c | 9 ---------
>  1 file changed, 9 deletions(-)
> 
> diff --git a/drivers/usb/serial/garmin_gps.c b/drivers/usb/serial/garmin_gps.c
> index ffd984142171..3b39d1e39fbf 100644
> --- a/drivers/usb/serial/garmin_gps.c
> +++ b/drivers/usb/serial/garmin_gps.c
> @@ -179,19 +179,10 @@ static unsigned char const GARMIN_START_SESSION_REPLY[]
>  	= { 0, 0, 0, 0,  6, 0, 0, 0, 4, 0, 0, 0 };
>  static unsigned char const GARMIN_BULK_IN_AVAIL_REPLY[]
>  	= { 0, 0, 0, 0,  2, 0, 0, 0, 0, 0, 0, 0 };
> -static unsigned char const GARMIN_APP_LAYER_REPLY[]
> -	= { 0x14, 0, 0, 0 };
> -static unsigned char const GARMIN_START_PVT_REQ[]
> -	= { 20, 0, 0, 0,  10, 0, 0, 0, 2, 0, 0, 0, 49, 0 };
> -static unsigned char const GARMIN_STOP_PVT_REQ[]
> -	= { 20, 0, 0, 0,  10, 0, 0, 0, 2, 0, 0, 0, 50, 0 };
>  static unsigned char const GARMIN_STOP_TRANSFER_REQ[]
>  	= { 20, 0, 0, 0,  10, 0, 0, 0, 2, 0, 0, 0, 0, 0 };
>  static unsigned char const GARMIN_STOP_TRANSFER_REQ_V2[]
>  	= { 20, 0, 0, 0,  10, 0, 0, 0, 1, 0, 0, 0, 0 };
> -static unsigned char const PRIVATE_REQ[]
> -	=    { 0x4B, 0x6E, 0x10, 0x01,  0xFF, 0, 0, 0, 0xFF, 0, 0, 0 };
> -

I'm reluctant to simply remove these as they document the protocol
without any real downsides besides the W=1 warning.

Johan
