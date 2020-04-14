Return-Path: <SRS0=4xmc=56=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3654FC2BB1D
	for <linux-kernel@archiver.kernel.org>; Tue, 14 Apr 2020 20:18:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 106CA2074D
	for <linux-kernel@archiver.kernel.org>; Tue, 14 Apr 2020 20:18:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ZqS4I9LR"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2632994AbgDNUSk (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 14 Apr 2020 16:18:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37000 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S2632986AbgDNUSg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Apr 2020 16:18:36 -0400
Received: from mail-ot1-x343.google.com (mail-ot1-x343.google.com [IPv6:2607:f8b0:4864:20::343])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CDDD5C061A10
        for <linux-kernel@vger.kernel.org>; Tue, 14 Apr 2020 13:18:35 -0700 (PDT)
Received: by mail-ot1-x343.google.com with SMTP id j4so1016587otr.11
        for <linux-kernel@vger.kernel.org>; Tue, 14 Apr 2020 13:18:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:reply-to:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=rLY3E9TB/AARP5ZcaClXMaDKsCbI8tUQJ+pv7T0Vfno=;
        b=ZqS4I9LRZs9vfonnUEXi4MrM6h+oq5OJhahQ9xq6CTRHyTB4R9s1z5sb+llkZJoYJS
         x/Wm1suRUG1Cws+auj6F2IEVbrzhqIf7KS+n69S/s3S0DPdhUe5xtFePYdkSWNUnw6fY
         cLFVA1EZQUnpmbyMGur1vb0ND99t6xhV8h1rJTO/tr4Oi+6CLxpMJxwl8xRqmsybrefV
         6BZmhpDQsc1pKGodFruNncZbGzwI6SWALyiRCnRu0Wxca9IrgARZ/h3umrdNdR3CxGvn
         u6dWLYvzZggf80uAcnCzNT5B3Gkk2QtEzVTsDtZVLxr0vfqQVPCk9KmhEgo5T2iRve/y
         FeIA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :reply-to:references:mime-version:content-disposition:in-reply-to
         :user-agent;
        bh=rLY3E9TB/AARP5ZcaClXMaDKsCbI8tUQJ+pv7T0Vfno=;
        b=Jr+/Cq48Vd9TUaRYXIC9dQGjnd09jfAvyuovCqytIV18dle3J59nFGZS5iH9aEQp+u
         LIQeRFzi9wCP/91ICADJD4FMnJB05kDtUI02I5sEqz7cMtToVf6K2j7Zu/VvqQllUK2m
         XGp/ypYtGG4Oo2rpp7kCa/1g+pH+aqp0TCTHxkLCt0tTWNYbc9Sbs3w41Sv83W42r8nJ
         kys3yIIWfpCPY2ZWr03SGHkT8JeiSSonDAPmFrixaY3tjoyD1zslBG1j8/KQP4gd2j6w
         zQMbL2jutVwt14PPAadZewmWnn/7C1NUqAF2xrSHEy1lXrHfB9aMWMmQZ9lnmtklN+ch
         aOuA==
X-Gm-Message-State: AGi0Pua09Bre8W367AMa7ZRUMNjfy8+qj45e4jHizZ5g3krBBwooBcOQ
        edxlceMbYBq0LMVg8HHjEQ==
X-Google-Smtp-Source: APiQypITkTCya6Z7MQTVnb9o1d9yzK8+NK79ZCFn/twBseE2eVwuqCIU1xYHRvAbOd5C4Ny5y9S5ww==
X-Received: by 2002:a9d:1d45:: with SMTP id m63mr11854342otm.271.1586895515050;
        Tue, 14 Apr 2020 13:18:35 -0700 (PDT)
Received: from serve.minyard.net ([47.184.149.130])
        by smtp.gmail.com with ESMTPSA id p25sm5802615oth.49.2020.04.14.13.18.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 14 Apr 2020 13:18:34 -0700 (PDT)
Received: from minyard.net (unknown [IPv6:2001:470:b8f6:1b:8b39:c3f3:f502:5c4e])
        by serve.minyard.net (Postfix) with ESMTPSA id A90F8181888;
        Tue, 14 Apr 2020 20:18:33 +0000 (UTC)
Date:   Tue, 14 Apr 2020 15:18:32 -0500
From:   Corey Minyard <minyard@acm.org>
To:     Tang Bin <tangbin@cmss.chinamobile.com>
Cc:     arnd@arndb.de, gregkh@linuxfoundation.org,
        openipmi-developer@lists.sourceforge.net,
        linux-kernel@vger.kernel.org,
        Shengju Zhang <zhangshengju@cmss.chinamobile.com>
Subject: Re: [PATCH 3/3] ipmi:bt-bmc: Fix error handling and status check
Message-ID: <20200414201832.GJ3587@minyard.net>
Reply-To: minyard@acm.org
References: <20200414141423.4968-1-tangbin@cmss.chinamobile.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200414141423.4968-1-tangbin@cmss.chinamobile.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Apr 14, 2020 at 10:14:24PM +0800, Tang Bin wrote:
> If the function platform_get_irq() failed, the negative
> value returned will not be detected here. So fix error
> handling in bt_bmc_config_irq(). And if devm_request_irq()
> failed, 'bt_bmc->irq' is assigned to zero maybe redundant,
> it may be more suitable for using the correct negative values
> to make the status check in the function bt_bmc_remove().

Comments inline..

> 
> Signed-off-by: Tang Bin <tangbin@cmss.chinamobile.com>
> Signed-off-by: Shengju Zhang <zhangshengju@cmss.chinamobile.com>
> ---
>  drivers/char/ipmi/bt-bmc.c | 12 +++++-------
>  1 file changed, 5 insertions(+), 7 deletions(-)
> 
> diff --git a/drivers/char/ipmi/bt-bmc.c b/drivers/char/ipmi/bt-bmc.c
> index 1d4bf5c65..1740c6dc8 100644
> --- a/drivers/char/ipmi/bt-bmc.c
> +++ b/drivers/char/ipmi/bt-bmc.c
> @@ -399,16 +399,14 @@ static int bt_bmc_config_irq(struct bt_bmc *bt_bmc,
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
> -	if (rc < 0) {
> -		bt_bmc->irq = 0;
> +	if (rc < 0)
>  		return rc;

I don't think this part is correct.  You will want to set bt_bmc->irq to
rc here to match what is done elsewhere so it's the error if negative.

Also, I believe this function should no longer return an error.  It
should just set the irq to the error if one happens.  The driver needs
to continue to operate even if it can't get its interrupt.

The rest of the changes are correct, I believe.

-corey

> -	}
>  
>  	/*
>  	 * Configure IRQs on the bmc clearing the H2B and HBUSY bits;
> @@ -499,7 +497,7 @@ static int bt_bmc_remove(struct platform_device *pdev)
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
