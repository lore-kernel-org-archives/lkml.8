Return-Path: <SRS0=fR4S=7I=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 399A6C433E1
	for <linux-kernel@archiver.kernel.org>; Tue, 26 May 2020 08:24:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0D3D02070A
	for <linux-kernel@archiver.kernel.org>; Tue, 26 May 2020 08:24:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="tR54phAv"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731485AbgEZIYp (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 26 May 2020 04:24:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46424 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727879AbgEZIYo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 May 2020 04:24:44 -0400
Received: from mail-wm1-x344.google.com (mail-wm1-x344.google.com [IPv6:2a00:1450:4864:20::344])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7BBF5C08C5C1
        for <linux-kernel@vger.kernel.org>; Tue, 26 May 2020 01:24:43 -0700 (PDT)
Received: by mail-wm1-x344.google.com with SMTP id u188so2359988wmu.1
        for <linux-kernel@vger.kernel.org>; Tue, 26 May 2020 01:24:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to;
        bh=LgltQhjcYnkoGoTgu09kfY7YAa0ELaS/ueJqPNen18o=;
        b=tR54phAvEvyyLoWxP1++txz7eCykGm2adySPXVjv9fQl2s+E9wYa1KGC3XHFMPRBqH
         rCQQmaG6Qnd03Qu+92ceNmQMcsYrSmMx5nb8k6wvg3AsElybp5FQpJ1gwo6u9+v3hOxZ
         qEoV5Co5u6jN1uwJswZflTJeZs2n/pBaIU1k6AHzP2U3tRtyYDdyuLmp49zDetLCj39y
         CW3upp1HBRi/LbzjBLOtJNwjrrIud5Trmfa4+mcNCiqWWZmad1sMxjPzB+24wBkpZHT5
         da4A/eHxq62YY7DXBUx/6bVTy9YhLWEGz/o+EHJ0ON3cOCYyxVW/UUP57Twgj/ox4dmj
         DOiw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=LgltQhjcYnkoGoTgu09kfY7YAa0ELaS/ueJqPNen18o=;
        b=ocmmWVbkJCDXpx0Vm4Jz6j/9PxXCjlx/AraZTPC5AAAtEbPr6PcCvnGIVsXR/5tsgA
         D6jC6v7F26uTvqR9GK6/Urr2VwNehv9LaU/6Eg+r/4mKoqgSDCLTjFgLbQfwhsup2lWM
         aoGyEV6fIk5zdWcYYzZdWARZIPbGffI3YxIob84JO8E1LpWVeQfCpagzvLcJAEiklb0Q
         sls9OfHPxg/YUTLyCs9NvP87uuYRRqF7ByCBJvziBdI01VrDYUmqkZppe3ArHh8DDvY6
         5Gj5kCG336G59wdmEtfo0cZlS2d1nTDbEWA0KFD+6GHzrIJG5q6MHXm04R72AWebX4Kz
         UOzg==
X-Gm-Message-State: AOAM5317rKPDh/ErHh57msFArh8RpnxunIeHYrL2nAk6cF8+kjhuOvOY
        BYNjoKY3QOIo8D+AaniRhC09RQ==
X-Google-Smtp-Source: ABdhPJwU3vDP1pmQms3HlCvAD8FpWYZXgN7hjUiCROFu1XYPc5ZuF2/JH4ntEbGZVDgFEOg01aXO7A==
X-Received: by 2002:a1c:f202:: with SMTP id s2mr289549wmc.98.1590481482125;
        Tue, 26 May 2020 01:24:42 -0700 (PDT)
Received: from dell ([95.149.164.102])
        by smtp.gmail.com with ESMTPSA id z11sm15962877wrw.67.2020.05.26.01.24.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 26 May 2020 01:24:41 -0700 (PDT)
Date:   Tue, 26 May 2020 09:24:40 +0100
From:   Lee Jones <lee.jones@linaro.org>
To:     Dmitry Osipenko <digetx@gmail.com>
Cc:     Tony Lindgren <tony@atomide.com>,
        Thierry Reding <thierry.reding@gmail.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        =?utf-8?B?TWljaGHFgiBNaXJvc8WCYXc=?= <mirq-linux@rere.qmqm.pl>,
        Zack Pearsall <zpearsall@yahoo.com>,
        linux-tegra@vger.kernel.org, linux-omap@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] mfd: tps65910: Correct power-off programming sequence
Message-ID: <20200526082440.GI3628@dell>
References: <20200524192643.18207-1-digetx@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20200524192643.18207-1-digetx@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 24 May 2020, Dmitry Osipenko wrote:

> This patch fixes system shutdown on a devices that use TPS65910 as a
> system's power controller. In accordance to the TPS65910 datasheet, the
> PMIC's state-machine transitions into the OFF state only when DEV_OFF
> bit of DEVCTRL_REG is set. The ON / SLEEP states also should be cleared,
> otherwise PMIC won't get into a proper state on shutdown. Devices like
> Nexus 7 tablet and Ouya game console are now shutting down properly.
> 
> Tested-by: Zack Pearsall <zpearsall@yahoo.com>
> Signed-off-by: Dmitry Osipenko <digetx@gmail.com>
> ---
> 
> Changelog:
> 
> v2: - Now using a single tps65910_reg_update_bits() instead of set+clear.
>       Thanks to Michał Mirosław for the suggestion.

Michał should review.

>  drivers/mfd/tps65910.c | 9 +++++++--
>  1 file changed, 7 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/mfd/tps65910.c b/drivers/mfd/tps65910.c
> index 11959021b50a..3f4483dec871 100644
> --- a/drivers/mfd/tps65910.c
> +++ b/drivers/mfd/tps65910.c
> @@ -440,8 +440,13 @@ static void tps65910_power_off(void)
>  			DEVCTRL_PWR_OFF_MASK) < 0)
>  		return;
>  
> -	tps65910_reg_clear_bits(tps65910, TPS65910_DEVCTRL,
> -			DEVCTRL_DEV_ON_MASK);
> +	if (tps65910_reg_clear_bits(tps65910, TPS65910_DEVCTRL,
> +			DEVCTRL_DEV_SLP_MASK) < 0)
> +		return;
> +
> +	tps65910_reg_update_bits(tps65910, TPS65910_DEVCTRL,
> +				 DEVCTRL_DEV_OFF_MASK | DEVCTRL_DEV_ON_MASK,
> +				 DEVCTRL_DEV_OFF_MASK);
>  }
>  
>  static int tps65910_i2c_probe(struct i2c_client *i2c,

-- 
Lee Jones [李琼斯]
Linaro Services Technical Lead
Linaro.org │ Open source software for ARM SoCs
Follow Linaro: Facebook | Twitter | Blog
