Return-Path: <SRS0=3CHW=6C=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C6DA1C38A2F
	for <linux-kernel@archiver.kernel.org>; Sat, 18 Apr 2020 13:51:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9E4C021BE5
	for <linux-kernel@archiver.kernel.org>; Sat, 18 Apr 2020 13:51:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="RXa5FtMJ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727888AbgDRNvV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 18 Apr 2020 09:51:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53126 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726752AbgDRNtO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 18 Apr 2020 09:49:14 -0400
Received: from mail-ot1-x342.google.com (mail-ot1-x342.google.com [IPv6:2607:f8b0:4864:20::342])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 36D1CC061A0C
        for <linux-kernel@vger.kernel.org>; Sat, 18 Apr 2020 06:49:13 -0700 (PDT)
Received: by mail-ot1-x342.google.com with SMTP id m13so3920839otf.6
        for <linux-kernel@vger.kernel.org>; Sat, 18 Apr 2020 06:49:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:reply-to:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=QcE1hGsY8v1IWMkz0gHh3/1b09zcFk27FkCpIkWG0MA=;
        b=RXa5FtMJHDfUeFK312R9qWGKjTQOeeQvy1263PO2Mrhp7G1hyzV2JyZGfSr7ZeEXe2
         RzgnwVXAzwvp7VWCvlDg1DpCO/d6zGoLa+6oNp030sBVw9cEYKlcvlmWO2Wg7gxlNz3W
         qyHd5dx7oCiul+7eccxdg4KXCBa4aIwRvno6LMOA+dnLD+DqOX225n6uHXOfRsQ+fkQe
         YZzB/o4D3nHuIXYovJJTi+BpiDFYcwbe+S8yK3CYQe0p41O0EY3X22IEayHRixzwyBlQ
         SmMa0EMtrz6FE8wTn9XL3giRj29Ly2bySQrC9llegLxESILJKYE9u6c53gKLnKdZrpiy
         u0Aw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :reply-to:references:mime-version:content-disposition:in-reply-to
         :user-agent;
        bh=QcE1hGsY8v1IWMkz0gHh3/1b09zcFk27FkCpIkWG0MA=;
        b=lCaRrFdsx7fAGlrKknyjTiP+k26W4Mo4hHNJArXmcmRvBfyyHc5ykTc/vWnjjybBIg
         2zzUlMid39vnUEh+uKltEjvv+jPm0Eed0+DmMAN6e8KKSYeZChXKqknyy1jSXyH8cK9W
         SSdKmhi4bo6qF/FI4JvqxK3n8VKrZRLDTkEow7bs6Y1gdvNmID7lgmuIoX87aiPYCll5
         TQ0IvGXj6/oZlRl5JH4f7kvcqe4VZbMfzkjssQ4lwsak5fnba1RRcVPHkqtRc5s8Psmg
         vK3HOiTwtothzjrRISm4gTvupBunG2NrgBcKZmj5vhNTASvMTNnL9ek09gQVwgZmnWjP
         aMVA==
X-Gm-Message-State: AGi0PubutMCNzBaLDvlLjJXZLeT3W4VrzfltkOQfmT3SXhdp8Kp/rjQL
        /kuXGWkYapg1LyhkRkRe5A==
X-Google-Smtp-Source: APiQypIRs+lg2ocbUhW9deNQjYD5mCVoF35HtSrcWBwbEa0d/JCLCh365KXETC7D2OJYqs/Mwkxqcg==
X-Received: by 2002:a9d:6a53:: with SMTP id h19mr574443otn.8.1587217752080;
        Sat, 18 Apr 2020 06:49:12 -0700 (PDT)
Received: from serve.minyard.net ([47.184.149.130])
        by smtp.gmail.com with ESMTPSA id s25sm4174458ooh.22.2020.04.18.06.49.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 18 Apr 2020 06:49:11 -0700 (PDT)
Received: from minyard.net (unknown [IPv6:2001:470:b8f6:1b:8b39:c3f3:f502:5c4e])
        by serve.minyard.net (Postfix) with ESMTPSA id A427F181888;
        Sat, 18 Apr 2020 13:49:10 +0000 (UTC)
Date:   Sat, 18 Apr 2020 08:49:09 -0500
From:   Corey Minyard <minyard@acm.org>
To:     Tang Bin <tangbin@cmss.chinamobile.com>
Cc:     arnd@arndb.de, gregkh@linuxfoundation.org,
        openipmi-developer@lists.sourceforge.net,
        linux-kernel@vger.kernel.org,
        Shengju Zhang <zhangshengju@cmss.chinamobile.com>
Subject: Re: [PATCH v2] ipmi:bt-bmc: Fix error handling and status check
Message-ID: <20200418134909.GF6246@minyard.net>
Reply-To: minyard@acm.org
References: <20200418080228.19028-1-tangbin@cmss.chinamobile.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200418080228.19028-1-tangbin@cmss.chinamobile.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Apr 18, 2020 at 04:02:29PM +0800, Tang Bin wrote:
> If the function platform_get_irq() failed, the negative
> value returned will not be detected here. So fix error
> handling in bt_bmc_config_irq(). And if devm_request_irq()
> failed, 'bt_bmc->irq' is assigned to zero maybe redundant,
> it may be more suitable for using the correct negative values
> to make the status check in the function bt_bmc_remove().

You need to mention changing platform_get_irq to
platform_get_irq_optional in the header.

Another comment inline below.

Otherwise, this looks good.

> 
> Signed-off-by: Shengju Zhang <zhangshengju@cmss.chinamobile.com>
> Signed-off-by: Tang Bin <tangbin@cmss.chinamobile.com>
> ---
> Changes from v1
>  - fix the code of status check
> ---
>  drivers/char/ipmi/bt-bmc.c | 11 +++++------
>  1 file changed, 5 insertions(+), 6 deletions(-)
> 
> diff --git a/drivers/char/ipmi/bt-bmc.c b/drivers/char/ipmi/bt-bmc.c
> index cd0349bff..33d3a5d50 100644
> --- a/drivers/char/ipmi/bt-bmc.c
> +++ b/drivers/char/ipmi/bt-bmc.c
> @@ -399,15 +399,14 @@ static int bt_bmc_config_irq(struct bt_bmc *bt_bmc,
>  	struct device *dev = &pdev->dev;
>  	int rc;
>  
> -	bt_bmc->irq = platform_get_irq(pdev, 0);
> -	if (!bt_bmc->irq)
> -		return -ENODEV;
> +	bt_bmc->irq = platform_get_irq_optional(pdev, 0);
> +	if (bt_bmc->irq < 0)
> +		return bt_bmc->irq;
>  
>  	rc = devm_request_irq(dev, bt_bmc->irq, bt_bmc_irq, IRQF_SHARED,
>  			      DEVICE_NAME, bt_bmc);
>  	if (rc < 0) {
>  		dev_warn(dev, "Unable to request IRQ %d\n", bt_bmc->irq);
> -		bt_bmc->irq = 0;

You need to set this to rc.  Otherwise it will remain the interrupt
number assigned by platform_get_irq_optional().

-corey

>  		return rc;
>  	}
>  
> @@ -474,7 +473,7 @@ static int bt_bmc_probe(struct platform_device *pdev)
>  
>  	bt_bmc_config_irq(bt_bmc, pdev);
>  
> -	if (bt_bmc->irq) {
> +	if (bt_bmc->irq >= 0) {
>  		dev_info(dev, "Using IRQ %d\n", bt_bmc->irq);
>  	} else {
>  		dev_info(dev, "No IRQ; using timer\n");
> @@ -500,7 +499,7 @@ static int bt_bmc_remove(struct platform_device *pdev)
>  	struct bt_bmc *bt_bmc = dev_get_drvdata(&pdev->dev);
>  
>  	misc_deregister(&bt_bmc->miscdev);
> -	if (!bt_bmc->irq)
> +	if (bt_bmc->irq < 0)
>  		del_timer_sync(&bt_bmc->poll_timer);
>  	return 0;
>  }
> -- 
> 2.20.1.windows.1
> 
> 
> 
