Return-Path: <SRS0=6raZ=AQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2DFA2C433E0
	for <linux-kernel@archiver.kernel.org>; Sun,  5 Jul 2020 18:02:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0EAE020708
	for <linux-kernel@archiver.kernel.org>; Sun,  5 Jul 2020 18:02:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1593972176;
	bh=+AoCgWZsUCnFW+SEdgd8ByRUF6SgDVmc8jdOn2zLvo4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=ouiOF/NERkK4zs5lgirXZ0aQnvY3BjqASsQk5l/2EE2CQlj5v8jAu0BmpDh2cAqyF
	 HSmTwAX/1uwR/zCeMrV6kRFhxywPJKWXW2jqcY32QQoJNRqpThVHzopptU/tcBcFX7
	 HqAfacTSgAl/sqU3IpeYN5LAZdhPCoU3KK3MPZYM=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727896AbgGESCy (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 5 Jul 2020 14:02:54 -0400
Received: from mail-wm1-f65.google.com ([209.85.128.65]:54388 "EHLO
        mail-wm1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727803AbgGESCx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 5 Jul 2020 14:02:53 -0400
Received: by mail-wm1-f65.google.com with SMTP id o8so36776406wmh.4;
        Sun, 05 Jul 2020 11:02:52 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=uPHomDteoTeqD1Zdsfu51U2CvSKbygx5cXktKVzxSNQ=;
        b=SJZ6nrkPHfbGh5k/coEtKtpKoXOle9+mPZD3hbqxce2nspFHJyx5i6aV1dV7FO6PbR
         MQiik9H+EoK3U6mpGRzoTC8Onoip4YRRghUBAiA01udpB4H5Bpe7KZGPPFey13XHRrzd
         i7ACU70MUvBfNeh1LlCjNbXqTm7mnvQgcO8ECUPzWw9qD6uYDQ8HfPhAEUvY8TomOcRO
         +a81Lnu5V51bnYUKT9xRKsg4Zy9o89V1GdTAWM1EDoZPTTkjRoj+EVQWJ50ouSBUYjmv
         xTjjr2QBp2HOP2/MOi4woqm/lQWvXeZnkULaXLly+XrKvqydZz2SjqfeFR900HSGMc6I
         q0hA==
X-Gm-Message-State: AOAM531Lf5lFSUclI1eDuanX63mUHMDBogRSvVkdQWmBnzw5xzDPqV/1
        n8MdowUzLq4VgokSOgnzUSE=
X-Google-Smtp-Source: ABdhPJwnfTrvsdcHqKUfAzn5bksiQ7r5jv+emzW58WvipXFMrOlRo1gOQT1r+OV6UuZiEEBDtCYzwQ==
X-Received: by 2002:a7b:ce97:: with SMTP id q23mr46389395wmj.89.1593972171899;
        Sun, 05 Jul 2020 11:02:51 -0700 (PDT)
Received: from kozik-lap ([194.230.155.195])
        by smtp.googlemail.com with ESMTPSA id d28sm22653770wrc.50.2020.07.05.11.02.50
        (version=TLS1_2 cipher=ECDHE-ECDSA-CHACHA20-POLY1305 bits=256/256);
        Sun, 05 Jul 2020 11:02:51 -0700 (PDT)
Date:   Sun, 5 Jul 2020 20:02:48 +0200
From:   Krzysztof Kozlowski <krzk@kernel.org>
To:     Anand Moon <linux.amoon@gmail.com>
Cc:     linux-arm-kernel@lists.infradead.org,
        linux-samsung-soc@vger.kernel.org, linux-kernel@vger.kernel.org,
        Kishon Vijay Abraham I <kishon@ti.com>,
        Vinod Koul <vkoul@kernel.org>, Kukjin Kim <kgene@kernel.org>,
        Marek Szyprowski <m.szyprowski@samsung.com>
Subject: Re: [PATCH v2] phy: samsung: Use readl_poll_timeout function
Message-ID: <20200705180248.GA2765@kozik-lap>
References: <20200705060435.504-1-linux.amoon@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20200705060435.504-1-linux.amoon@gmail.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Jul 05, 2020 at 06:04:35AM +0000, Anand Moon wrote:
> User readl_poll_timeout function instead of open
> coded handling in crport_handshake function.

Your change does not replace only the "open coded handling" with
readl_poll_timeout(). Your change does more - switches busy waiting with
udelay to a sleeping mode. I am not sure if it is correct but definitly
it should be mentioned.  Otherwise how can we be sure that you checked
if this is allowed in this section? Did you test everything with
DEBUG_ATOMIC_SLEEP?

> 
> Fixes: d8c80bb3b55b ("phy: exynos5-usbdrd: Calibrate LOS levels for exynos5420/5800")
> Signed-off-by: Anand Moon <linux.amoon@gmail.com>
> ---
> Changes v2:
> --used the default timeout values.
> --Added missing Fixed tags.
> ---
>  drivers/phy/samsung/phy-exynos5-usbdrd.c | 37 +++++++++---------------
>  1 file changed, 13 insertions(+), 24 deletions(-)
> 
> diff --git a/drivers/phy/samsung/phy-exynos5-usbdrd.c b/drivers/phy/samsung/phy-exynos5-usbdrd.c
> index e510732afb8b..c97f5fb6a9a0 100644
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
> +	u32 timeout_us = 100, sleep_us = 1;

No need for the variables actually and their type does not match. Just
use the values directly.

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
> +			result,	(result & PHYREG1_CR_ACK), sleep_us, timeout_us);
> +	if (err) {
> +		dev_err(phy_drd->dev, "CRPORT handshake timeout1 (0x%08x)\n", val);
>  		return -ETIME;
>  	}
>  
> -	usec = 100;
> +	timeout_us = 100;
> +	sleep_us = 1;

Why defining then again?

Best regards,
Krzysztof


>  
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
> +			result,	!(result & PHYREG1_CR_ACK), sleep_us, timeout_us);
> +	if (err) {
> +		dev_err(phy_drd->dev, "CRPORT handshake timeout2 (0x%08x)\n", val);
>  		return -ETIME;
>  	}
>  
> -- 
> 2.27.0
> 
