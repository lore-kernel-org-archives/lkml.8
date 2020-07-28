Return-Path: <SRS0=jZ1s=BH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.6 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6C72FC433EC
	for <linux-kernel@archiver.kernel.org>; Tue, 28 Jul 2020 09:21:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 326822074F
	for <linux-kernel@archiver.kernel.org>; Tue, 28 Jul 2020 09:21:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1595928117;
	bh=NNX64QXYODFJKL2lS3ScmVOI0V1ZbmJSSxEld6Bu0ec=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=hlZBVFDfhdXPPXC+5XckJG7JMLEsTigGB2MmPq8ClYwl2xZUKiaEQWngGiil+TPTP
	 BlKKCehO737HVB/pK3U3nxRjwRs0unILfCluYl4sXbmb5PfDvE86QknjPQ2NPpN3p5
	 SG15ONJvmkib0ubj6kugH+88wMGp20iS9+s8KyJI=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728188AbgG1JV4 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 28 Jul 2020 05:21:56 -0400
Received: from mail-ej1-f65.google.com ([209.85.218.65]:43221 "EHLO
        mail-ej1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728072AbgG1JVz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Jul 2020 05:21:55 -0400
Received: by mail-ej1-f65.google.com with SMTP id a21so19897102ejj.10
        for <linux-kernel@vger.kernel.org>; Tue, 28 Jul 2020 02:21:54 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=blEvJmYWDDpXTqOrA29wAv2+DlaWptNCopG8+WOshLc=;
        b=LF4UOdEK5tQUeM3DIj12vsdeF0pl9UUlom/1VaQ7ZKR+hfIIepSahFQuEVENsJIUic
         KeyFTgaw0RlB0BGfMCimHsUOk0Um1QNXA4PJJUMczlJRm+MBIATnWXYZwfWGlaXROEVq
         ul5hrnPs+LR9fZLW0c/Aj1m65+g4V547wV5FQiM1a6rRxYEnmB5SIx2/emI9EpmxQC1u
         7W14tCQ4oIYtikhLuHRnHl89aBulEjQ59FjvBf/YPvW/8uGqtOB+CjP0RugxTPjwyZHv
         uqv2CKCcdEDfb42Vi8YAiJzRg/kRHiMEWa5tyTwp2SwJCx4CDcXb5FXb7pgQseLtzo16
         xd1w==
X-Gm-Message-State: AOAM533fvjB66LAfy4E51+tGLPmp+OsYSRAidrI7jNg8WQpfjaeQ02I7
        UdWhqTATGgsrqJ0z6KTs2V8NnacpSzN1+Q==
X-Google-Smtp-Source: ABdhPJxqssDWolTBu19aP3SY8QQGu/wBriOUXo1BodfY+f/dYyir8UG6F37kIK5CkTpfOFqgJyX9rQ==
X-Received: by 2002:a17:906:698:: with SMTP id u24mr22664926ejb.57.1595928113714;
        Tue, 28 Jul 2020 02:21:53 -0700 (PDT)
Received: from kozik-lap ([194.230.155.213])
        by smtp.googlemail.com with ESMTPSA id n2sm9334398edq.73.2020.07.28.02.21.52
        (version=TLS1_2 cipher=ECDHE-ECDSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 28 Jul 2020 02:21:52 -0700 (PDT)
Date:   Tue, 28 Jul 2020 11:21:50 +0200
From:   Krzysztof Kozlowski <krzk@kernel.org>
To:     Paul Cercueil <paul@crapouillou.net>
Cc:     od@zcrc.me, linux-kernel@vger.kernel.org,
        "H . Nikolaus Schaller" <hns@goldelico.com>
Subject: Re: [PATCH] memory: jz4780_nemc: Only request IO memory the driver
 will use
Message-ID: <20200728092150.GA4437@kozik-lap>
References: <20200727162034.12334-1-paul@crapouillou.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20200727162034.12334-1-paul@crapouillou.net>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jul 27, 2020 at 06:20:34PM +0200, Paul Cercueil wrote:
> The driver only uses the registers up to offset 0x54. Since the EFUSE
> registers are in the middle of the NEMC registers, we only request
> the registers we will use for now - that way the EFUSE driver can
> probe too.
> 
> Tested-by: H. Nikolaus Schaller <hns@goldelico.com>
> Signed-off-by: Paul Cercueil <paul@crapouillou.net>
> ---
>  drivers/memory/jz4780-nemc.c | 15 ++++++++++++++-
>  1 file changed, 14 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/memory/jz4780-nemc.c b/drivers/memory/jz4780-nemc.c
> index b232ed279fc3..647267ea8c63 100644
> --- a/drivers/memory/jz4780-nemc.c
> +++ b/drivers/memory/jz4780-nemc.c
> @@ -8,6 +8,7 @@
>  
>  #include <linux/clk.h>
>  #include <linux/init.h>
> +#include <linux/io.h>
>  #include <linux/math64.h>
>  #include <linux/of.h>
>  #include <linux/of_address.h>
> @@ -288,7 +289,19 @@ static int jz4780_nemc_probe(struct platform_device *pdev)
>  	nemc->dev = dev;
>  
>  	res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
> -	nemc->base = devm_ioremap_resource(dev, res);
> +
> +	/*
> +	 * The driver only uses the registers up to offset 0x54. Since the EFUSE
> +	 * registers are in the middle of the NEMC registers, we only request
> +	 * the registers we will use for now - that way the EFUSE driver can
> +	 * probe too.
> +	 */
> +	if (!devm_request_mem_region(dev, res->start, 0x54, dev_name(dev))) {
> +		dev_err(dev, "unable to request I/O memory region\n");
> +		return -EBUSY;
> +	}
> +
> +	nemc->base = devm_ioremap(dev, res->start, resource_size(res));

Shouldn't you map only 0x54 size as well?

Best regards,
Krzysztof
