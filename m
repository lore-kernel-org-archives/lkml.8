Return-Path: <SRS0=EnQK=B5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.6 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 42153C433E4
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Aug 2020 12:48:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1AF9F206B5
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Aug 2020 12:48:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1597841321;
	bh=vSfytZP8+I0+ZyXxWN8mIaFVW1Syu2+avDpGWRu8uOY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=b2Eqof+Rr8G7gqvKLC84xi/4x2Fev3+Y9mJcDSyAzFFr/VAIMia6ewdEyvXJnVWH8
	 0Lh0Zt4Y9cLaultTcL4oR2Fka20AlvC7Vsfls/og0VmfUXOHYJQpkUn5jX50MG5a0O
	 r555TeQozlWStywk5Ti6RfV4lwh98/EvB3x7PRRE=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728403AbgHSMsk convert rfc822-to-8bit (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 19 Aug 2020 08:48:40 -0400
Received: from mail-ej1-f68.google.com ([209.85.218.68]:42452 "EHLO
        mail-ej1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728192AbgHSMsh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Aug 2020 08:48:37 -0400
Received: by mail-ej1-f68.google.com with SMTP id g19so26097503ejc.9;
        Wed, 19 Aug 2020 05:48:36 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=XfTWVsSwjI65UWFf8mFq+y/lWsZWshehQWdU+KFwzuU=;
        b=HKzMBdh+PxyjxnrUOI6ZeqHAslPkTLw8gDc4YiBgR8EIqyzfrX4fbeRGVfz+JNRPx0
         DfT/nBraFeSHPztXPTWiIwSxiemI4l5abcmLOgHGoVvDXGHKHoW0TmP28Zc7cRB6XY5e
         0RhtohupN6lxLEWCgslG/LJ0Os1DTOp6UfN5u2KS5Kt3Pqyj0mjsARXQ6sgYk3nrth0l
         f0E9reNcEWQYg9ob3r9abBRk7C0LQdWYYLeDnZlWSvBuJXdtBVBaBrRCIsHrp3/9Knzz
         g7hMla0MMX82O8kER2jlXE4HN/XCmVccuQwBR/73i8KcSPufQWYWPzGlvKXh6JJrLQre
         ebSw==
X-Gm-Message-State: AOAM533SXQe+NUeAGJCrD16bN7f0IVvhNid67x4w6hXaP+1lGVHzp4+f
        8Ve+R9e3lEgTaACznBX7yT8=
X-Google-Smtp-Source: ABdhPJzZe31W/+8QBDGcHi1xcG1tLh3FVP1X/kz/OeUtmPGjjH2C8BtqdYDfN27v2jUrKeIpCLdHcw==
X-Received: by 2002:a17:906:840c:: with SMTP id n12mr24102300ejx.246.1597841315755;
        Wed, 19 Aug 2020 05:48:35 -0700 (PDT)
Received: from kozik-lap ([194.230.155.216])
        by smtp.googlemail.com with ESMTPSA id m26sm19793213ejn.92.2020.08.19.05.48.34
        (version=TLS1_2 cipher=ECDHE-ECDSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 19 Aug 2020 05:48:35 -0700 (PDT)
Date:   Wed, 19 Aug 2020 14:48:33 +0200
From:   Krzysztof Kozlowski <krzk@kernel.org>
To:     =?utf-8?Q?=C5=81ukasz?= Stelmach <l.stelmach@samsung.com>
Cc:     Kukjin Kim <kgene@kernel.org>, Andi Shyti <andi@etezian.org>,
        Mark Brown <broonie@kernel.org>, linux-spi@vger.kernel.org,
        linux-samsung-soc@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        m.szyprowski@samsung.com, b.zolnierkie@samsung.com
Subject: Re: [PATCH 6/8] spi: spi-s3c64xx: Check return values
Message-ID: <20200819124833.GF18122@kozik-lap>
References: <20200819123208.12337-1-l.stelmach@samsung.com>
 <CGME20200819123227eucas1p11ec027714c16d5a66c89c6ef1f7b3604@eucas1p1.samsung.com>
 <20200819123208.12337-7-l.stelmach@samsung.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8BIT
In-Reply-To: <20200819123208.12337-7-l.stelmach@samsung.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Aug 19, 2020 at 02:32:06PM +0200, Łukasz Stelmach wrote:
> Signed-off-by: Łukasz Stelmach <l.stelmach@samsung.com>
> ---
>  drivers/spi/spi-s3c64xx.c | 12 ++++++++++++
>  1 file changed, 12 insertions(+)

Oh, come on, stop fixing the same local issue without fixing bigger
picture... or at least documenting why bigger picture does not have to be
fixed and simple 'return' is enough.

That's the third, same fix for the same problem.

https://lore.kernel.org/lkml/20190314064202.14864-1-kjlu@umn.edu/
https://lore.kernel.org/lkml/20170207204520.h2eo3yn5kge56lk7@kozik-lap/

Best regards,
Krzysztof

> 
> diff --git a/drivers/spi/spi-s3c64xx.c b/drivers/spi/spi-s3c64xx.c
> index 505789f91fdf..27d77600a820 100644
> --- a/drivers/spi/spi-s3c64xx.c
> +++ b/drivers/spi/spi-s3c64xx.c
> @@ -273,6 +273,7 @@ static void prepare_dma(struct s3c64xx_spi_dma_data *dma,
>  	struct s3c64xx_spi_driver_data *sdd;
>  	struct dma_slave_config config;
>  	struct dma_async_tx_descriptor *desc;
> +	int ret;
>  
>  	memset(&config, 0, sizeof(config));
>  
> @@ -296,11 +297,22 @@ static void prepare_dma(struct s3c64xx_spi_dma_data *dma,
>  
>  	desc = dmaengine_prep_slave_sg(dma->ch, sgt->sgl, sgt->nents,
>  				       dma->direction, DMA_PREP_INTERRUPT);
> +	if (!desc) {
> +		dev_err(&sdd->pdev->dev, "unable to prepare %s scatterlist",
> +			dma->direction == DMA_DEV_TO_MEM ? "rx" : "tx");
> +		return;
> +	}
>  
>  	desc->callback = s3c64xx_spi_dmacb;
>  	desc->callback_param = dma;
>  
>  	dma->cookie = dmaengine_submit(desc);
> +	ret = dma_submit_error(dma->cookie);
> +	if (ret) {
> +		dev_err(&sdd->pdev->dev, "dmaengine_submit() failed %d", ret);
> +		return;
> +	}
> +
>  	dma_async_issue_pending(dma->ch);
>  }
>  
> -- 
> 2.26.2
> 
