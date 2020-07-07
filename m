Return-Path: <SRS0=aTFg=AS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D4043C433E1
	for <linux-kernel@archiver.kernel.org>; Tue,  7 Jul 2020 11:36:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B54B7206DF
	for <linux-kernel@archiver.kernel.org>; Tue,  7 Jul 2020 11:36:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1594121812;
	bh=0NyNP3p9AO30DGaSQbT8qjnRElflhinNpFwpYZSO7z4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=brreN/6UTMVRQFOOoeyZ1giy4jU1LiFomGcuHdojfqJHNPwnrPuYGOW4XTUokQqgi
	 zp138KgRVQtEYJoz6xE3693gh5IbNzH0yNBVQ1B5UgeZfAIwQpUyFhKHI7tJlksuQx
	 qwG6S9smmQkoCJgNpb+e0V6VuBPDPze4EoBNA6gY=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728249AbgGGLgv (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 7 Jul 2020 07:36:51 -0400
Received: from mail-wr1-f66.google.com ([209.85.221.66]:38194 "EHLO
        mail-wr1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726745AbgGGLgu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Jul 2020 07:36:50 -0400
Received: by mail-wr1-f66.google.com with SMTP id z13so44786373wrw.5;
        Tue, 07 Jul 2020 04:36:49 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=g8eYN4DcaE4cWGmQIJYjXftOZqfTHMZ6RPDgEcxyfN4=;
        b=PSmZYdUmOKsnB+kTyNp3fcu5M5IJjcno0zdBVaWtiVcZQn8zL2CuqWCxo7LtPHPypi
         CRtT3+OTskT4e/1jg0V9GwNeq/GA0Zscpoy2jEafT+0YjrZ9clIzbHxLBJbaSw/TKCpU
         iPBYre8Fak3sfoCwjhhQhI/N4qvBTuWIOpVj4slroCaJg0x+vrG9HP4//hSs415I+sFj
         tuc/p23AueHA4hiPabVamlXSfY6oqui392yD6BHgVQc2SeRMKVOvyQXIKNJr6PEslmwW
         yiOuhNSoleJ/zdL/UFpjMI7w5Mor84GUCNGzYSjk7+TwGt81SaCpPj3WZHRPLjh2St9Q
         oXfQ==
X-Gm-Message-State: AOAM533fnS/3GheMtzw6p0kWg697ayYcO3eefo/Im6hsdfa/nH6MmWYY
        JO9iAzWq6Pr25h6fl4FnJeA=
X-Google-Smtp-Source: ABdhPJwKCEvXtM2zZL2ji1JGazyFrHq5dOKCyuwKbPn7zy2n+xmnz/++1EwOm1VFpfZBrfngSrd0cw==
X-Received: by 2002:a5d:4991:: with SMTP id r17mr25847697wrq.1.1594121808402;
        Tue, 07 Jul 2020 04:36:48 -0700 (PDT)
Received: from kozik-lap ([194.230.155.195])
        by smtp.googlemail.com with ESMTPSA id v24sm764491wrd.92.2020.07.07.04.36.47
        (version=TLS1_2 cipher=ECDHE-ECDSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 07 Jul 2020 04:36:47 -0700 (PDT)
Date:   Tue, 7 Jul 2020 13:36:45 +0200
From:   Krzysztof Kozlowski <krzk@kernel.org>
To:     Anand Moon <linux.amoon@gmail.com>
Cc:     linux-arm-kernel@lists.infradead.org,
        linux-samsung-soc@vger.kernel.org, linux-kernel@vger.kernel.org,
        Kishon Vijay Abraham I <kishon@ti.com>,
        Vinod Koul <vkoul@kernel.org>, Kukjin Kim <kgene@kernel.org>,
        Marek Szyprowski <m.szyprowski@samsung.com>
Subject: Re: [PATCH v3] phy: samsung: Use readl_poll_timeout function
Message-ID: <20200707113645.GA27280@kozik-lap>
References: <20200707095908.372-1-linux.amoon@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20200707095908.372-1-linux.amoon@gmail.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jul 07, 2020 at 09:59:08AM +0000, Anand Moon wrote:
> Instead of a busy waiting loop while loop using udelay

You doubled "loop".

> use readl_poll_timeout function to check the condition
> is met or timeout occurs in crport_handshake function.

Still you did not mention that you convert the function to use sleeping
primitive.  You also did not mention whether it is actually allowed in
this context and I am not sure if you investigated it.

Best regards,
Krzysztof

> 
> Fixes: d8c80bb3b55b ("phy: exynos5-usbdrd: Calibrate LOS levels for exynos5420/5800")
> Signed-off-by: Anand Moon <linux.amoon@gmail.com>
> ---
> Changes v3:
> --Fix the commit message.
> --Drop the variable, used the value directly.
> Changes v2:
> --used the default timeout values.
> --Added missing Fixed tags.
> ---
>  drivers/phy/samsung/phy-exynos5-usbdrd.c | 35 +++++++-----------------
>  1 file changed, 10 insertions(+), 25 deletions(-)
> 
> diff --git a/drivers/phy/samsung/phy-exynos5-usbdrd.c b/drivers/phy/samsung/phy-exynos5-usbdrd.c
> index e510732afb8b..fa75fa88da33 100644
> --- a/drivers/phy/samsung/phy-exynos5-usbdrd.c
> +++ b/drivers/phy/samsung/phy-exynos5-usbdrd.c
> @@ -16,6 +16,7 @@
>  #include <linux/of.h>
>  #include <linux/of_address.h>
>  #include <linux/of_device.h>
> +#include <linux/iopoll.h>
>  #include <linux/phy/phy.h>
>  #include <linux/platform_device.h>
>  #include <linux/mutex.h>
> @@ -556,40 +557,24 @@ static int exynos5_usbdrd_phy_power_off(struct phy *phy)
>  static int crport_handshake(struct exynos5_usbdrd_phy *phy_drd,
>  			    u32 val, u32 cmd)
>  {
> -	u32 usec = 100;
>  	unsigned int result;
> +	int err;
>  
>  	writel(val | cmd, phy_drd->reg_phy + EXYNOS5_DRD_PHYREG0);
>  
> -	do {
> -		result = readl(phy_drd->reg_phy + EXYNOS5_DRD_PHYREG1);
> -		if (result & PHYREG1_CR_ACK)
> -			break;
> -
> -		udelay(1);
> -	} while (usec-- > 0);
> -
> -	if (!usec) {
> -		dev_err(phy_drd->dev,
> -			"CRPORT handshake timeout1 (0x%08x)\n", val);
> +	err = readl_poll_timeout(phy_drd->reg_phy + EXYNOS5_DRD_PHYREG1,
> +			result,	(result & PHYREG1_CR_ACK), 1, 100);
> +	if (err) {
> +		dev_err(phy_drd->dev, "CRPORT handshake timeout1 (0x%08x)\n", val);
>  		return -ETIME;
>  	}
>  
> -	usec = 100;
> -
>  	writel(val, phy_drd->reg_phy + EXYNOS5_DRD_PHYREG0);
>  
> -	do {
> -		result = readl(phy_drd->reg_phy + EXYNOS5_DRD_PHYREG1);
> -		if (!(result & PHYREG1_CR_ACK))
> -			break;
> -
> -		udelay(1);
> -	} while (usec-- > 0);
> -
> -	if (!usec) {
> -		dev_err(phy_drd->dev,
> -			"CRPORT handshake timeout2 (0x%08x)\n", val);
> +	err = readl_poll_timeout(phy_drd->reg_phy + EXYNOS5_DRD_PHYREG1,
> +			result,	!(result & PHYREG1_CR_ACK), 1, 100);
> +	if (err) {
> +		dev_err(phy_drd->dev, "CRPORT handshake timeout2 (0x%08x)\n", val);
>  		return -ETIME;
>  	}
>  
> -- 
> 2.27.0
> 
