Return-Path: <SRS0=dgGg=75=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,UNWANTED_LANGUAGE_BODY,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 100BBC433E0
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Jun 2020 08:30:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D628F20656
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Jun 2020 08:30:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="vSVHKdp/"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727899AbgFPIaO (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 16 Jun 2020 04:30:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35044 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726626AbgFPIaM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 Jun 2020 04:30:12 -0400
Received: from mail-wm1-x344.google.com (mail-wm1-x344.google.com [IPv6:2a00:1450:4864:20::344])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7E5F5C05BD43
        for <linux-kernel@vger.kernel.org>; Tue, 16 Jun 2020 01:30:11 -0700 (PDT)
Received: by mail-wm1-x344.google.com with SMTP id c71so1990511wmd.5
        for <linux-kernel@vger.kernel.org>; Tue, 16 Jun 2020 01:30:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=+JydJY/My9fURmwQCAj++V8Jq/K4UqX9zWSCI7W6qNg=;
        b=vSVHKdp/QEr/48OBVoFgzPcRgOSEgexAnlTDPSRJufS/P8CvVyDX7fj6Q5ZaEcOoTZ
         o7K1xPooir8FXIvBLIdK3Of0TjCIeSn5vUkvueF9gMMKuf7xMjbNnIKxaabLS/Xy2qWI
         x/9L0q0383P9rP00rjVFDWBnmu5NDuxXEKsBWOulv82Mx01kaiO6NnU+2H7N5VfiKHDX
         fR0ro0UfDfxasnTbEMnR9Q0rVYv5f3v8nK+sJJ/WoOmaw0Xpf+iCQwvmUm3MTqpIkJ64
         ZCDISMgNdBOuH0upuI1/T1dbJk8s9zX6nlSX3HbLBYO49cv4I2bUAtJfIAwWfcs5nkVT
         CSEA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=+JydJY/My9fURmwQCAj++V8Jq/K4UqX9zWSCI7W6qNg=;
        b=YSl06UGNeBif7YgILYDIEm3JZAKu+t29M8SD0GZnibouX0ZSD+2kubKZOywbk3p+IV
         GMaenT+jcYdAWvjP1+qb7FwFru2AnYd4A6iZ6uLMi14HqilhC8NuGnvjGf9RrbBXrLuL
         lvZqf4utXAzFQo/pRTFfVmNcc2/HGFmR+gGQXCZQRjTveT7Ob2vipToBMl6dU45H3BrY
         Qzqd1sDABSCrw7VcVUIju4gTSNCgCzUDALrVZ3GmL0cGBxP9pEfupiIzUloaFiVlJcEZ
         2ZJDq7nDWE56OemDV1+TRApLvTt2Tdr4oa8U1v35IKvTWRCrjrsdHoR+1/HxmPNZfVqS
         Dcsg==
X-Gm-Message-State: AOAM530xYFYrfCxpWpvS/8WfzuDjtpJna//W4ZNexK/qvpF4PUBO10ue
        sxAu/CR4M4XY9DsrqesVx5+iSw==
X-Google-Smtp-Source: ABdhPJzvqGu8QKJYIDridXmmRtugkNUTV4tS5D3sej1Ks3NtltCUx185KoWRcQiiLo5AU6aSTKAAQg==
X-Received: by 2002:a1c:814c:: with SMTP id c73mr1958518wmd.140.1592296210162;
        Tue, 16 Jun 2020 01:30:10 -0700 (PDT)
Received: from [192.168.86.34] (cpc89974-aztw32-2-0-cust43.18-1.cable.virginm.net. [86.30.250.44])
        by smtp.googlemail.com with ESMTPSA id x205sm3011958wmx.21.2020.06.16.01.30.09
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 16 Jun 2020 01:30:09 -0700 (PDT)
Subject: Re: [PATCH V2] nvmem: sc27xx: add sc2730 efuse support
To:     Chunyan Zhang <zhang.lyra@gmail.com>
Cc:     linux-kernel@vger.kernel.org, Orson Zhai <orsonzhai@gmail.com>,
        Baolin Wang <baolin.wang7@gmail.com>,
        Chunyan Zhang <chunyan.zhang@unisoc.com>,
        Freeman Liu <freeman.liu@unisoc.com>
References: <20200616020515.13494-1-zhang.lyra@gmail.com>
From:   Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Message-ID: <3b41564b-f34a-6b31-8142-c3edcc1699e8@linaro.org>
Date:   Tue, 16 Jun 2020 09:30:08 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <20200616020515.13494-1-zhang.lyra@gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 16/06/2020 03:05, Chunyan Zhang wrote:
> From: Freeman Liu <freeman.liu@unisoc.com>
> 
> Add support to the new efuse IP which is integrated in the SC2730
> which includes multiple blocks in a single chip.
> 
> Signed-off-by: Freeman Liu <freeman.liu@unisoc.com>
> Signed-off-by: Chunyan Zhang <chunyan.zhang@unisoc.com>
> Reviewed-by: Baolin Wang <baolin.wang7@gmail.com>


Applied thanks,

-srini

> ---
> Changes from v1:
> * Addressed comments from Srinivas;
> * Added reviewed-by from Baolin.
> ---
>   drivers/nvmem/sc27xx-efuse.c | 27 ++++++++++++++++++++++++---
>   1 file changed, 24 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/nvmem/sc27xx-efuse.c b/drivers/nvmem/sc27xx-efuse.c
> index ab5e7e0bc3d8..c825fc902d10 100644
> --- a/drivers/nvmem/sc27xx-efuse.c
> +++ b/drivers/nvmem/sc27xx-efuse.c
> @@ -4,12 +4,14 @@
>   #include <linux/hwspinlock.h>
>   #include <linux/module.h>
>   #include <linux/of.h>
> +#include <linux/of_device.h>
>   #include <linux/platform_device.h>
>   #include <linux/regmap.h>
>   #include <linux/nvmem-provider.h>
>   
>   /* PMIC global registers definition */
>   #define SC27XX_MODULE_EN		0xc08
> +#define SC2730_MODULE_EN		0x1808
>   #define SC27XX_EFUSE_EN			BIT(6)
>   
>   /* Efuse controller registers definition */
> @@ -49,12 +51,29 @@
>   #define SC27XX_EFUSE_POLL_TIMEOUT	3000000
>   #define SC27XX_EFUSE_POLL_DELAY_US	10000
>   
> +/*
> + * Since different PMICs of SC27xx series can have different
> + * address , we should save address in the device data structure.
> + */
> +struct sc27xx_efuse_variant_data {
> +	u32 module_en;
> +};
> +
>   struct sc27xx_efuse {
>   	struct device *dev;
>   	struct regmap *regmap;
>   	struct hwspinlock *hwlock;
>   	struct mutex mutex;
>   	u32 base;
> +	const struct sc27xx_efuse_variant_data *var_data;
> +};
> +
> +static const struct sc27xx_efuse_variant_data sc2731_edata = {
> +	.module_en = SC27XX_MODULE_EN,
> +};
> +
> +static const struct sc27xx_efuse_variant_data sc2730_edata = {
> +	.module_en = SC2730_MODULE_EN,
>   };
>   
>   /*
> @@ -119,7 +138,7 @@ static int sc27xx_efuse_read(void *context, u32 offset, void *val, size_t bytes)
>   		return ret;
>   
>   	/* Enable the efuse controller. */
> -	ret = regmap_update_bits(efuse->regmap, SC27XX_MODULE_EN,
> +	ret = regmap_update_bits(efuse->regmap, efuse->var_data->module_en,
>   				 SC27XX_EFUSE_EN, SC27XX_EFUSE_EN);
>   	if (ret)
>   		goto unlock_efuse;
> @@ -169,7 +188,7 @@ static int sc27xx_efuse_read(void *context, u32 offset, void *val, size_t bytes)
>   
>   disable_efuse:
>   	/* Disable the efuse controller after reading. */
> -	regmap_update_bits(efuse->regmap, SC27XX_MODULE_EN, SC27XX_EFUSE_EN, 0);
> +	regmap_update_bits(efuse->regmap, efuse->var_data->module_en, SC27XX_EFUSE_EN, 0);
>   unlock_efuse:
>   	sc27xx_efuse_unlock(efuse);
>   
> @@ -219,6 +238,7 @@ static int sc27xx_efuse_probe(struct platform_device *pdev)
>   
>   	mutex_init(&efuse->mutex);
>   	efuse->dev = &pdev->dev;
> +	efuse->var_data = of_device_get_match_data(&pdev->dev);
>   
>   	econfig.stride = 1;
>   	econfig.word_size = 1;
> @@ -238,7 +258,8 @@ static int sc27xx_efuse_probe(struct platform_device *pdev)
>   }
>   
>   static const struct of_device_id sc27xx_efuse_of_match[] = {
> -	{ .compatible = "sprd,sc2731-efuse" },
> +	{ .compatible = "sprd,sc2731-efuse", .data = &sc2731_edata},
> +	{ .compatible = "sprd,sc2730-efuse", .data = &sc2730_edata},
>   	{ }
>   };
>   
> 
