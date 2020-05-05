Return-Path: <SRS0=e3tL=6T=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D1ED1C47247
	for <linux-kernel@archiver.kernel.org>; Tue,  5 May 2020 11:49:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A73FD206A4
	for <linux-kernel@archiver.kernel.org>; Tue,  5 May 2020 11:49:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Y+FbbwF8"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728717AbgEELtM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 5 May 2020 07:49:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54072 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1728497AbgEELtL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 May 2020 07:49:11 -0400
Received: from mail-oi1-x243.google.com (mail-oi1-x243.google.com [IPv6:2607:f8b0:4864:20::243])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 50EC5C061A0F
        for <linux-kernel@vger.kernel.org>; Tue,  5 May 2020 04:49:11 -0700 (PDT)
Received: by mail-oi1-x243.google.com with SMTP id k133so1493793oih.12
        for <linux-kernel@vger.kernel.org>; Tue, 05 May 2020 04:49:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:reply-to:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=GjKB5+P+lowciw8hYvavcWELEVof+DOw/wkBRXTnIl0=;
        b=Y+FbbwF8AszDk+hX7j6caODIk2+tXo9cx0GEKnAvrEC1XU0hoQeG212yS6+Y31FpET
         47hfcPoZ54v3U/0wiHFoLRfPKkYF+eG9HaLYO5Wp3JFRXPhG0wBunbmsVoVB7StKsRGg
         CGMU+Ujxzmlc9qNAyF5U5fJHYukK7GLidxS8+7uh7R0ZmzGCfRdMWG2JVc502ZwH4TRy
         fxY+mg0eBBQGVKYm2bSxJfNZey/ItSR0eHjsFW96YjVeD2dZOaSnwKbD5RNzINq+ScTW
         NSkiNdlMTy2yxGjJZv4TZimZGuhB4IG6ZB1LJNYxj1XnzgyfLJ2qDAoybjpBsebBTC4q
         bjrg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :reply-to:references:mime-version:content-disposition:in-reply-to
         :user-agent;
        bh=GjKB5+P+lowciw8hYvavcWELEVof+DOw/wkBRXTnIl0=;
        b=tpBQVgJ8BMCZ/rB64EB32xa+iUTBeBJzGE2yc9Jt2joiStgX+pyDSXwhiF+Sxkf6Ze
         AcWDQUB5+iCtTtQBjC3ZytoK2OyqXwh2fpPpyyU/s2DWi7+6Izlu55+FeWiNhcZILBdb
         G7JxL/5PctS+1UocCdE8t+kKNQVeJ5/MrvRFZG5YFYVO9YxBe+69CVlY8iLzIfvVyvPu
         0Ec9KNYtr9d0w849x1ZNiHZJR2KRByHQNVEvS2EUbRPnXt3146nfftFdWE2fDmB1QqIU
         Wbv5y7vdf4/So+fsGgqvjJlTpx/8YgDhi4y0CZtUvxr2DieEL5Yt7m1vbT9a1YqftUVh
         nUfw==
X-Gm-Message-State: AGi0PuZZEXlzhpOT8znvlWYYb99Z5dRfeYBFW+Q2LlSgXK72PsG3uqSq
        whQDfl2LmHtROmmsnWq9vcWRi1o=
X-Google-Smtp-Source: APiQypKivc2n7zxKfx6n0Z2kIjLy5lMbbRxLMyWMZfJo/IvpuhNYfC98AC0OwQEN/Q/osS1xtthGTQ==
X-Received: by 2002:aca:d485:: with SMTP id l127mr1936931oig.119.1588679350648;
        Tue, 05 May 2020 04:49:10 -0700 (PDT)
Received: from serve.minyard.net ([47.184.149.130])
        by smtp.gmail.com with ESMTPSA id j137sm493737oih.23.2020.05.05.04.49.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 05 May 2020 04:49:09 -0700 (PDT)
Received: from minyard.net (unknown [IPv6:2001:470:b8f6:1b:8b39:c3f3:f502:5c4e])
        by serve.minyard.net (Postfix) with ESMTPSA id 252CB180050;
        Tue,  5 May 2020 11:49:09 +0000 (UTC)
Date:   Tue, 5 May 2020 06:49:07 -0500
From:   Corey Minyard <minyard@acm.org>
To:     Tang Bin <tangbin@cmss.chinamobile.com>
Cc:     arnd@arndb.de, gregkh@linuxfoundation.org,
        openipmi-developer@lists.sourceforge.net,
        linux-kernel@vger.kernel.org,
        Shengju Zhang <zhangshengju@cmss.chinamobile.com>
Subject: Re: [PATCH v3] ipmi:bt-bmc: Fix error handling and status check
Message-ID: <20200505114907.GK9902@minyard.net>
Reply-To: minyard@acm.org
References: <20200505102906.17196-1-tangbin@cmss.chinamobile.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200505102906.17196-1-tangbin@cmss.chinamobile.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, May 05, 2020 at 06:29:06PM +0800, Tang Bin wrote:
> If the function platform_get_irq() failed, the negative value
> returned will not be detected here. So fix error handling in
> bt_bmc_config_irq(). And in the function bt_bmc_probe(),
> when get irq failed, it will print error message. So use
> platform_get_irq_optional() to simplify code. Finally in the
> function bt_bmc_remove() should make the right status check
> if get irq failed.

Ok, this is included in my tree.

Thanks,

-corey

> 
> Signed-off-by: Shengju Zhang <zhangshengju@cmss.chinamobile.com>
> Signed-off-by: Tang Bin <tangbin@cmss.chinamobile.com>
> ---
> Changes from v2
>  - fix the commit message and the code of status check
> Changes from v1
>  - fix the code of status check
> ---
>  drivers/char/ipmi/bt-bmc.c | 10 +++++-----
>  1 file changed, 5 insertions(+), 5 deletions(-)
> 
> diff --git a/drivers/char/ipmi/bt-bmc.c b/drivers/char/ipmi/bt-bmc.c
> index d36aeacb2..88ee54767 100644
> --- a/drivers/char/ipmi/bt-bmc.c
> +++ b/drivers/char/ipmi/bt-bmc.c
> @@ -399,9 +399,9 @@ static int bt_bmc_config_irq(struct bt_bmc *bt_bmc,
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
> @@ -477,7 +477,7 @@ static int bt_bmc_probe(struct platform_device *pdev)
>  
>  	bt_bmc_config_irq(bt_bmc, pdev);
>  
> -	if (bt_bmc->irq) {
> +	if (bt_bmc->irq >= 0) {
>  		dev_info(dev, "Using IRQ %d\n", bt_bmc->irq);
>  	} else {
>  		dev_info(dev, "No IRQ; using timer\n");
> @@ -503,7 +503,7 @@ static int bt_bmc_remove(struct platform_device *pdev)
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
