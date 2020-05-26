Return-Path: <SRS0=fR4S=7I=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2BB13C433DF
	for <linux-kernel@archiver.kernel.org>; Tue, 26 May 2020 08:23:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id EFA6120885
	for <linux-kernel@archiver.kernel.org>; Tue, 26 May 2020 08:23:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="qnYTe/s6"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731357AbgEZIXV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 26 May 2020 04:23:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46204 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726926AbgEZIXU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 May 2020 04:23:20 -0400
Received: from mail-wr1-x443.google.com (mail-wr1-x443.google.com [IPv6:2a00:1450:4864:20::443])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F005BC03E97E
        for <linux-kernel@vger.kernel.org>; Tue, 26 May 2020 01:23:19 -0700 (PDT)
Received: by mail-wr1-x443.google.com with SMTP id c3so15231422wru.12
        for <linux-kernel@vger.kernel.org>; Tue, 26 May 2020 01:23:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to;
        bh=lxyCshKXQK670lp3eg0wD7289YcA1Lwkj3Ng7mmafLs=;
        b=qnYTe/s6t787vLOjZrCR7E8kILNC01/sv1hS76lMbRsLDOrfbA7kGX+kNDSF86jFTM
         Hq1mzT/L91NqmeoB7Q6FXxkElurNzzNTDf8EOOtylCiivKchDq/CSm2/OSv/v+uuCbSG
         51nFk7CWUqzsSUk43uroRWMxXwNp7+sB0BE/cxMcWU5jPvPvuBwx2VTGWd80lqFtGfdO
         HZMRy+Mh7r3qwakuAq3VL0l1I8uYr/pB4dLF6aZm3nYlKqktb9GJBXcQgaRl5zGV7d6a
         y4IUCrOhX5af617QUDVJlTm9qvQfZot0+kUuVR949x3/l2Tr0r2qE/ouRe9LQX1pbQXO
         2fjA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=lxyCshKXQK670lp3eg0wD7289YcA1Lwkj3Ng7mmafLs=;
        b=dbTsd9ooaaQB6y/GewGtK+k62GWNaLICjZzGlcdew3VclUuF3B3lDB+vb93mrf9Rem
         P6hPAtC/1jz2/TTbayf933NOkBJrKgaO+H1fc/oj8PoIsTdrKBbs9txjsDm7yI2FcM9T
         KqhVAV7uX8q/GHpG/u6nU4GxHaVL1Z9fJdUYmDTVIxx11iqWhf8PfZMr3TboeRHK7Odp
         AdCvGr1+0TrH4eGgJg2PgrUXMXXBGhmvKqwiPEia74qnAtsx2h4nrSIQEBU/Z5ugsDk8
         WViqPvezNCX7A9xU1bzSqlms85H4/C1KCfHang200n+MOU91Kca2TeImf4u5ndImUnBk
         3uhw==
X-Gm-Message-State: AOAM530EFFP6NNUp93NWe2zAy5G8QbF1PeKNKswHURWIvC8dkqBlnXdB
        5/nHGRvCvfhBQAdWmrI4JLsaDg==
X-Google-Smtp-Source: ABdhPJxwzw/7BRBfWh8fTKXxRUv9sUdwTSl737C6HaTrkgjVB2HZ6sVbcxRq22/JT54nalDRNQP8Cw==
X-Received: by 2002:a5d:4bc5:: with SMTP id l5mr15619295wrt.104.1590481398187;
        Tue, 26 May 2020 01:23:18 -0700 (PDT)
Received: from dell ([95.149.164.102])
        by smtp.gmail.com with ESMTPSA id x8sm2791180wrs.43.2020.05.26.01.23.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 26 May 2020 01:23:17 -0700 (PDT)
Date:   Tue, 26 May 2020 09:23:16 +0100
From:   Lee Jones <lee.jones@linaro.org>
To:     Baolin Wang <baolin.wang7@gmail.com>
Cc:     orsonzhai@gmail.com, zhang.lyra@gmail.com,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] mfd: sprd: Add wakeup capability for PMIC irq
Message-ID: <20200526082316.GH3628@dell>
References: <7361f34d712b027f0cd85dc36ee158f9b6076cef.1588833125.git.baolin.wang7@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <7361f34d712b027f0cd85dc36ee158f9b6076cef.1588833125.git.baolin.wang7@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 07 May 2020, Baolin Wang wrote:

> When changing to use suspend-to-idle to save power, the PMIC irq can not
> wakeup the system due to lack of wakeup capability, which will cause
> the sub-irqs (such as power key) of the PMIC can not wake up the system.
> Thus we can add the wakeup capability for PMIC irq to solve this issue,
> as well as removing the IRQF_NO_SUSPEND flag to allow PMIC irq to be
> a wakeup source.
> 
> Reported-by: Chunyan Zhang <zhang.lyra@gmail.com>
> Signed-off-by: Baolin Wang <baolin.wang7@gmail.com>
> ---
>  drivers/mfd/sprd-sc27xx-spi.c | 30 +++++++++++++++++++++++++++++-
>  1 file changed, 29 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/mfd/sprd-sc27xx-spi.c b/drivers/mfd/sprd-sc27xx-spi.c
> index ebdf2f1..3064a60 100644
> --- a/drivers/mfd/sprd-sc27xx-spi.c
> +++ b/drivers/mfd/sprd-sc27xx-spi.c
> @@ -256,7 +256,7 @@ static int sprd_pmic_probe(struct spi_device *spi)
>  	}
>  
>  	ret = devm_regmap_add_irq_chip(&spi->dev, ddata->regmap, ddata->irq,
> -				       IRQF_ONESHOT | IRQF_NO_SUSPEND, 0,
> +				       IRQF_ONESHOT, 0,
>  				       &ddata->irq_chip, &ddata->irq_data);
>  	if (ret) {
>  		dev_err(&spi->dev, "Failed to add PMIC irq chip %d\n", ret);
> @@ -272,9 +272,36 @@ static int sprd_pmic_probe(struct spi_device *spi)
>  		return ret;
>  	}
>  
> +	device_init_wakeup(&spi->dev, 1);

This is a bool.  Please use 'true'.

>  	return 0;
>  }
>  
> +#ifdef CONFIG_PM_SLEEP
> +static int sprd_pmic_suspend(struct device *dev)
> +{
> +	struct spi_device *spi = to_spi_device(dev);
> +	struct sprd_pmic *ddata = spi_get_drvdata(spi);

Why don't you just use:

  dev_get_drvdata(dev)

... and skip the superfluous step?

> +	if (device_may_wakeup(dev))
> +		enable_irq_wake(ddata->irq);
> +
> +	return 0;
> +}
> +
> +static int sprd_pmic_resume(struct device *dev)
> +{
> +	struct spi_device *spi = to_spi_device(dev);
> +	struct sprd_pmic *ddata = spi_get_drvdata(spi);

As above.

> +	if (device_may_wakeup(dev))
> +		disable_irq_wake(ddata->irq);
> +
> +	return 0;
> +}
> +#endif
> +
> +static SIMPLE_DEV_PM_OPS(sprd_pmic_pm_ops, sprd_pmic_suspend, sprd_pmic_resume);
> +
>  static const struct of_device_id sprd_pmic_match[] = {
>  	{ .compatible = "sprd,sc2731", .data = &sc2731_data },
>  	{},
> @@ -286,6 +313,7 @@ static int sprd_pmic_probe(struct spi_device *spi)
>  		.name = "sc27xx-pmic",
>  		.bus = &spi_bus_type,
>  		.of_match_table = sprd_pmic_match,
> +		.pm = &sprd_pmic_pm_ops,
>  	},
>  	.probe = sprd_pmic_probe,
>  };

-- 
Lee Jones [李琼斯]
Linaro Services Technical Lead
Linaro.org │ Open source software for ARM SoCs
Follow Linaro: Facebook | Twitter | Blog
