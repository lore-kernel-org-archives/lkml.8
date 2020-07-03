Return-Path: <SRS0=gItQ=AO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A9ABBC433E2
	for <linux-kernel@archiver.kernel.org>; Fri,  3 Jul 2020 16:43:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8ABBB207FF
	for <linux-kernel@archiver.kernel.org>; Fri,  3 Jul 2020 16:43:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1593794635;
	bh=JKqba4dum7CUcdPT3b9HmjLgGzNPTd8lylgjy8ENnz4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=k031UNFH5fnlBAESwBbKJ8/d5VO0pxPDzEUPyksH4fJ6C1bAzMrcpZydKZn/7DupH
	 hBlXXmmLUdzUgxNGJ1qTnI45J6UOq069N+wbegcVGjcjuXaMBP/S9maXFAcc0f6tJz
	 7cGokYQbS+1qD7p1AxKKd9c9ptCdayQMsirX9pAc=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726554AbgGCQny (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 3 Jul 2020 12:43:54 -0400
Received: from mail-ej1-f68.google.com ([209.85.218.68]:37901 "EHLO
        mail-ej1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726108AbgGCQnx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 Jul 2020 12:43:53 -0400
Received: by mail-ej1-f68.google.com with SMTP id w16so34920920ejj.5;
        Fri, 03 Jul 2020 09:43:52 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=Rkk6OrgsOeSgtd2LsYzmaJPd2S3kmEEwYFVFbwumjEo=;
        b=S+YU0dXIPsNupYIPrrDfKj7DWIYz1EeYpyrY2DnSLsG+rgH/40RKyQwanxinfioNVw
         2B72tOE5J0TfoB74l+pSKr/WbuDsYG+QPWLRCxM75ziA/cLXeMbgXiZZHkUimDtBzXlw
         LUhHXwfuFPIEH0siefkOJpNe5ezcws7LX7QNR8lB9n0yUx2XYGH3SB8ulm5NX2KRV/hF
         KIhB0ej30my4vIU8pfeYcCWH7bgkrgwk9afH36/YF9KGcm7/hzIHORJQ6Za+wPFjjUW1
         dRG0DafN0W/yXeLLromvcMpzyGXhJvXY3pVcADiP8W5+NhxgFxC1sJ8hfdqikHMxZgo0
         EWlw==
X-Gm-Message-State: AOAM532FvlK9l6ZjnAWmM04Qe+YaMAZ4pKHW5E1lX41ZZByjuImGBNYO
        50cIi3AGJmgJDb4aiGg93F4=
X-Google-Smtp-Source: ABdhPJxSig7o5zgKxKiDVXDwxMN/PbN7CZaC4mj/1cwidQ/8xnp0CyN1AS5npbV5bwvuESV662XTHg==
X-Received: by 2002:a17:906:3a0d:: with SMTP id z13mr25390578eje.109.1593794631769;
        Fri, 03 Jul 2020 09:43:51 -0700 (PDT)
Received: from kozik-lap ([194.230.155.195])
        by smtp.googlemail.com with ESMTPSA id o18sm9722250ejr.45.2020.07.03.09.43.50
        (version=TLS1_2 cipher=ECDHE-ECDSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 03 Jul 2020 09:43:51 -0700 (PDT)
Date:   Fri, 3 Jul 2020 18:43:49 +0200
From:   Krzysztof Kozlowski <krzk@kernel.org>
To:     Anand Moon <linux.amoon@gmail.com>
Cc:     linux-arm-kernel@lists.infradead.org,
        linux-samsung-soc@vger.kernel.org, linux-kernel@vger.kernel.org,
        Kishon Vijay Abraham I <kishon@ti.com>,
        Vinod Koul <vkoul@kernel.org>, Kukjin Kim <kgene@kernel.org>,
        Marek Szyprowski <m.szyprowski@samsung.com>
Subject: Re: [PATCH] phy: samsung: Use readl_poll_timeout function
Message-ID: <20200703164349.GA2914@kozik-lap>
References: <20200703132012.579-1-linux.amoon@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20200703132012.579-1-linux.amoon@gmail.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jul 03, 2020 at 01:20:12PM +0000, Anand Moon wrote:
> User readl_poll_timeout function instead of open
> coded handling in crport_handshake function.
> 
> Signed-off-by: Anand Moon <linux.amoon@gmail.com>
> ---
>  drivers/phy/samsung/phy-exynos5-usbdrd.c | 37 +++++++++---------------
>  1 file changed, 13 insertions(+), 24 deletions(-)
> 
> diff --git a/drivers/phy/samsung/phy-exynos5-usbdrd.c b/drivers/phy/samsung/phy-exynos5-usbdrd.c
> index e510732afb8b..83274c5e3820 100644
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
> @@ -556,40 +557,28 @@ static int exynos5_usbdrd_phy_power_off(struct phy *phy)
>  static int crport_handshake(struct exynos5_usbdrd_phy *phy_drd,
>  			    u32 val, u32 cmd)
>  {
> -	u32 usec = 100;
> +	u32 timeout_us = 1000, sleep_us = 10;
>  	unsigned int result;

You silently (without mentioning in commit msg and explaining why)
changed both the sleep time and total timeout.

Nope, please explain why you chosen such values and change them in
separate patch.

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
> +			result,	(result & PHYREG1_CR_ACK), sleep_us, timeout_us);
> +	if (err) {
> +		dev_err(phy_drd->dev, "CRPORT handshake timeout1 (0x%08x)\n", val);
>  		return -ETIME;
>  	}
>  
> -	usec = 100;
> +	timeout_us = 1000;
> +	sleep_us = 10;

The same.

Best regards,
Krzysztof

