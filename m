Return-Path: <SRS0=z/zp=5X=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 94114C2BA80
	for <linux-kernel@archiver.kernel.org>; Tue,  7 Apr 2020 13:40:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6596A206F7
	for <linux-kernel@archiver.kernel.org>; Tue,  7 Apr 2020 13:40:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="VHuyf2fE"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728889AbgDGNkS (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 7 Apr 2020 09:40:18 -0400
Received: from mail-oi1-f195.google.com ([209.85.167.195]:40168 "EHLO
        mail-oi1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728482AbgDGNkS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Apr 2020 09:40:18 -0400
Received: by mail-oi1-f195.google.com with SMTP id y71so1493552oia.7
        for <linux-kernel@vger.kernel.org>; Tue, 07 Apr 2020 06:40:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:reply-to:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=qEVjxeIlS9igveaV+xU6VqWnT7ciWNXB+lD5YjOf0YY=;
        b=VHuyf2fEUTXsrAaVoC8SK0zXMcw6H5Lk0weP/eaRiRqQzlAWTFGOpNCdDus81NDfPz
         YG8CY3OGpqJ1tRTflaBPTBnNrpeTZ8FWwLEjdtikemnsFhR4EtIB2XRRoXV0hVY4h8Gj
         uAFOBds2Hknlr2vemVncYRkIyeFsi6O1uGCjGDkUx7KOn+6xKvt7BgAf7zmvLTPWznwh
         Gp0kzKD3OJssr0u6oIs4pXxvBwVRRJmbQkhHvdwiZqjTLdmB3vkzemwcWlXs9ajYx7S/
         W5owG2bMhZxG9TAFNYqj42yls/6yGBFi3IawvVKai9Ruq0Q0frHjwm7CqG+HUgLrnGag
         8a9Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :reply-to:references:mime-version:content-disposition:in-reply-to
         :user-agent;
        bh=qEVjxeIlS9igveaV+xU6VqWnT7ciWNXB+lD5YjOf0YY=;
        b=forYGO3haqlZRW7PWb4mT/GCx7N9d5Tiawh25r8IbrxDYgrfNatpI7rEoFg2MWtRH0
         jr0gS55mzaJmrsI1sXOPKV1+Cy8ZuSqzBH5lxXVRwCYhn5HMyVSTBxZceke4o22ck+MJ
         7BY6bRDi6CLtCKJTU71q3UF3ysQkAnYIYRCAdWJsVR0VC8mytEbuiiYik8LHGX0r8pD2
         57Mui3SVPBdbkq4Yzs2Gv3aTGij3k489Mfl+vbVLXdtWzjOJ2CWAwtun4TW7rDV41/yk
         qqUBo8GR/sC8RE7zQZJlQ+YY4wQOaT+/cduTbUWmrvWE7Pr57W67PaRjY0drb2NUoB4P
         IYYQ==
X-Gm-Message-State: AGi0PuZtArZ/3dX0t1QljgUSzRwVpl+pSVeFaTnKj9BqZwSUod76tmMq
        7V/NbqYqMtLzhG0PXFEveg==
X-Google-Smtp-Source: APiQypJD+WzFC0CWDwX7/blmcYgI8Ij3wnrYGadb+0+fHv7uVjysyC3QPl3npzT4r8M7LGUL1Rcv4A==
X-Received: by 2002:aca:474e:: with SMTP id u75mr1710905oia.52.1586266817428;
        Tue, 07 Apr 2020 06:40:17 -0700 (PDT)
Received: from serve.minyard.net (serve.minyard.net. [2001:470:b8f6:1b::1])
        by smtp.gmail.com with ESMTPSA id a3sm1129086oop.36.2020.04.07.06.40.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 07 Apr 2020 06:40:14 -0700 (PDT)
Received: from minyard.net (unknown [IPv6:2001:470:b8f6:1b:8b39:c3f3:f502:5c4e])
        by serve.minyard.net (Postfix) with ESMTPSA id 39A47180053;
        Tue,  7 Apr 2020 13:40:13 +0000 (UTC)
Date:   Tue, 7 Apr 2020 08:40:12 -0500
From:   Corey Minyard <minyard@acm.org>
To:     Tang Bin <tangbin@cmss.chinamobile.com>
Cc:     arnd@arndb.de, gregkh@linuxfoundation.org,
        openipmi-developer@lists.sourceforge.net,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2]ipmi:bt-bmc:Avoid unnecessary judgement
Message-ID: <20200407134012.GC6130@minyard.net>
Reply-To: minyard@acm.org
References: <20200406043415.12292-1-tangbin@cmss.chinamobile.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200406043415.12292-1-tangbin@cmss.chinamobile.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Apr 06, 2020 at 12:34:15PM +0800, Tang Bin wrote:
> In this driver,only the platform_device and platform_driver
> matches,can trigger bt_bmc_probe(),and the trigger mode is
> just Device Tree.Thus remove redundant judgments.

How about the following commit message:

bt_bmc_probe() is only called with an openfirmware platform device.
Therefore there is no need to check that the passed in device is NULL or
that it has an openfirmware node.

Also, how did you find this?

Thanks,

-corey

> 
> Signed-off-by: Tang Bin <tangbin@cmss.chinamobile.com>
> ---
> Changes from v1:
>  - improve the commit message.
> 
>  drivers/char/ipmi/bt-bmc.c | 3 ---
>  1 file changed, 3 deletions(-)
> 
> diff --git a/drivers/char/ipmi/bt-bmc.c b/drivers/char/ipmi/bt-bmc.c
> index d36aeacb2..890ad55aa 100644
> --- a/drivers/char/ipmi/bt-bmc.c
> +++ b/drivers/char/ipmi/bt-bmc.c
> @@ -430,9 +430,6 @@ static int bt_bmc_probe(struct platform_device *pdev)
>  	struct device *dev;
>  	int rc;
>  
> -	if (!pdev || !pdev->dev.of_node)
> -		return -ENODEV;
> -
>  	dev = &pdev->dev;
>  	dev_info(dev, "Found bt bmc device\n");
>  
> -- 
> 2.20.1.windows.1
> 
> 
> 
