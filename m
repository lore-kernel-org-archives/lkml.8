Return-Path: <SRS0=2Lxt=AV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,UNWANTED_LANGUAGE_BODY,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 87FCDC433E2
	for <linux-kernel@archiver.kernel.org>; Fri, 10 Jul 2020 14:22:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5DA9520674
	for <linux-kernel@archiver.kernel.org>; Fri, 10 Jul 2020 14:22:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="X9+/pEXd"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728189AbgGJOWe (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 10 Jul 2020 10:22:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42880 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727107AbgGJOWe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Jul 2020 10:22:34 -0400
Received: from mail-wr1-x441.google.com (mail-wr1-x441.google.com [IPv6:2a00:1450:4864:20::441])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CC6E2C08C5CE
        for <linux-kernel@vger.kernel.org>; Fri, 10 Jul 2020 07:22:32 -0700 (PDT)
Received: by mail-wr1-x441.google.com with SMTP id f2so6112706wrp.7
        for <linux-kernel@vger.kernel.org>; Fri, 10 Jul 2020 07:22:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=LEJ3zYvTfGrKmD+ae/cPl+VgTxAxQL0fzNUPamOViPo=;
        b=X9+/pEXdpr1K4+XSEpiihmAVrzlTSh9AvhCpZ1TT5EtzVA8SYaVCzSQ9BMSanw+fKK
         WdlhXgKWZwECObQPt26ubfSqHlU3O2ktgUFH2XTbZXurl+94BgHmVlJWInN/I1EHmcQb
         Xb8v6waUWAlg5Ru3NZ7BFYlugCUr3PGrRbbzVdCplVs7JHkyKRZF3Ooa8EBncSMB9mDm
         K73NYwapKl57R36txM6pqc5U8Be96pM5Tx8yNyoqyZ4sPa/4vjndKAVeo2OG6tK3PUG6
         vvKk8AJfidqMUv66SWHxXl46EqaFF6AUv//8GZVRq2oZLXEDUEkC/Bxbu+0I0w9vIJo6
         NbZA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=LEJ3zYvTfGrKmD+ae/cPl+VgTxAxQL0fzNUPamOViPo=;
        b=asxvbDDGmsSi6pv836XwmiY7iCX3e0Atq9/ajI+ZmhLvT22/GNvm8K5C8zhtuN8Pak
         oGyPLFWPoaEOMdi9QXNsAsS0HHD5U6v0mdsd1YsIb0P8vyC+aVV38oYNrxL+QBAbfTCx
         NBuTp5saIvd/wym5+63ibDjmTX6RubQ1ODifaDmmub4JROTQJHPvmaokRlBSepydHs/4
         9j+rltS2q6F2abWkEF+xVsRWr//7pvxnGZiADLLcuzYPtHXDn/pfbwUKsfVr874qZNAU
         F+7a2/VbWA9CephfI7t5v2fNJN4kej7iiuJRMHiy87aRn7O0UK79XDNf0aJ2AvyOUh5x
         VO5Q==
X-Gm-Message-State: AOAM531+pLdcevtbGy5Xkct1HBK1KcJF7G+jh3oyAb0tvXLZ8qioFk7y
        XLR8jFMTjfBoM9Zxz9SkXJw=
X-Google-Smtp-Source: ABdhPJz1Za73KdbK9/8MGC1MEJtJodCx3hWEMA1G66Dae+DZ3G7snbuf+Xb/YCQtgqSP7L7TPVGyuA==
X-Received: by 2002:a5d:5084:: with SMTP id a4mr70431336wrt.191.1594390951534;
        Fri, 10 Jul 2020 07:22:31 -0700 (PDT)
Received: from ziggy.stardust ([213.195.114.245])
        by smtp.gmail.com with ESMTPSA id h199sm3888351wme.42.2020.07.10.07.22.30
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 10 Jul 2020 07:22:30 -0700 (PDT)
Subject: Re: [PATCH 2/4] mfd: mt6360: Remove handle_post_irq callback function
To:     Gene Chen <gene.chen.richtek@gmail.com>, lee.jones@linaro.org
Cc:     linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org, linux-kernel@vger.kernel.org,
        gene_chen@richtek.com, shufan_lee@richtek.com,
        cy_huang@richtek.com, benjamin.chao@mediatek.com
References: <1594117856-14343-1-git-send-email-gene.chen.richtek@gmail.com>
 <1594117856-14343-3-git-send-email-gene.chen.richtek@gmail.com>
From:   Matthias Brugger <matthias.bgg@gmail.com>
Message-ID: <8fa489a0-7672-cbbd-ec04-32803ca69084@gmail.com>
Date:   Fri, 10 Jul 2020 16:22:29 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.9.0
MIME-Version: 1.0
In-Reply-To: <1594117856-14343-3-git-send-email-gene.chen.richtek@gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 07/07/2020 12:30, Gene Chen wrote:
> From: Gene Chen <gene_chen@richtek.com>
> 
> Remove handle_post_irq which is used to retrigger irq.
> Set irq level low trigger to keep irq always be handled.
> 
> Signed-off-by: Gene Chen <gene_chen@richtek.com>
> ---
>   drivers/mfd/mt6360-core.c  | 25 ++++++++-----------------
>   include/linux/mfd/mt6360.h |  6 +++---
>   2 files changed, 11 insertions(+), 20 deletions(-)
> 
> diff --git a/drivers/mfd/mt6360-core.c b/drivers/mfd/mt6360-core.c
> index 5dfc13e..2dd5918 100644
> --- a/drivers/mfd/mt6360-core.c
> +++ b/drivers/mfd/mt6360-core.c
> @@ -208,24 +208,16 @@ static const struct regmap_irq mt6360_irqs[] =  {
>   	REGMAP_IRQ_REG_LINE(MT6360_LDO7_PGB_EVT, 8),
>   };
>   
> -static int mt6360_pmu_handle_post_irq(void *irq_drv_data)
> -{
> -	struct mt6360_data *data = irq_drv_data;
> -
> -	return regmap_update_bits(data->regmap,
> -		MT6360_PMU_IRQ_SET, MT6360_IRQ_RETRIG, MT6360_IRQ_RETRIG);
> -}
> -
> -static struct regmap_irq_chip mt6360_irq_chip = {
> +static const struct regmap_irq_chip mt6360_irq_chip = {
> +	.name = "mt6360_irqs",
>   	.irqs = mt6360_irqs,
>   	.num_irqs = ARRAY_SIZE(mt6360_irqs),
> -	.num_regs = MT6360_PMU_IRQ_REGNUM,
> -	.mask_base = MT6360_PMU_CHG_MASK1,
> -	.status_base = MT6360_PMU_CHG_IRQ1,
> -	.ack_base = MT6360_PMU_CHG_IRQ1,
> +	.num_regs = MT6360_IRQ_REGNUM,
> +	.mask_base = MT6360_REG_PMU_CHGMASK1,
> +	.status_base = MT6360_REG_PMU_CHGIRQ1,
> +	.ack_base = MT6360_REG_PMU_CHGIRQ1,

Non relevant patches for the commit. Please drop this.

>   	.init_ack_masked = true,
>   	.use_ack = true,
> -	.handle_post_irq = mt6360_pmu_handle_post_irq,
>   };
>   
>   static const struct regmap_config mt6360_pmu_regmap_config = {
> @@ -339,10 +331,9 @@ static int mt6360_probe(struct i2c_client *client)
>   		return -ENODEV;
>   	}
>   
> -	mt6360_irq_chip.irq_drv_data = data;
>   	ret = devm_regmap_add_irq_chip(&client->dev, data->regmap, client->irq,
> -				       IRQF_TRIGGER_FALLING, 0,
> -				       &mt6360_irq_chip, &data->irq_data);
> +				       IRQF_ONESHOT, 0, &mt6360_irq_chip,

 From what I see IRQF_ONESHOT is set implicitly in regmap_add_irq_chip_fwnode. 
Actually I think what you want to add is IRQF_TRIGGER_LOW.

> +				       &data->irq_data);
>   	if (ret) {
>   		dev_err(&client->dev, "Failed to add Regmap IRQ Chip\n");
>   		return ret;
> diff --git a/include/linux/mfd/mt6360.h b/include/linux/mfd/mt6360.h
> index 76077e4..9fc6718 100644
> --- a/include/linux/mfd/mt6360.h
> +++ b/include/linux/mfd/mt6360.h
> @@ -179,7 +179,7 @@ struct mt6360_data {
>   #define MT6360_PMU_SPARE2			(0xA0)
>   #define MT6360_PMU_SPARE3			(0xB0)
>   #define MT6360_PMU_SPARE4			(0xC0)
> -#define MT6360_PMU_CHG_IRQ1			(0xD0)
> +#define MT6360_REG_PMU_CHGIRQ1			(0xD0)
>   #define MT6360_PMU_CHG_IRQ2			(0xD1)
>   #define MT6360_PMU_CHG_IRQ3			(0xD2)
>   #define MT6360_PMU_CHG_IRQ4			(0xD3)
> @@ -211,7 +211,7 @@ struct mt6360_data {
>   #define MT6360_PMU_BUCK2_STAT			(0xED)
>   #define MT6360_PMU_LDO_STAT1			(0xEE)
>   #define MT6360_PMU_LDO_STAT2			(0xEF)
> -#define MT6360_PMU_CHG_MASK1			(0xF0)
> +#define MT6360_REG_PMU_CHGMASK1			(0xF0)
>   #define MT6360_PMU_CHG_MASK2			(0xF1)
>   #define MT6360_PMU_CHG_MASK3			(0xF2)
>   #define MT6360_PMU_CHG_MASK4			(0xF3)
> @@ -230,7 +230,7 @@ struct mt6360_data {
>   #define MT6360_PMU_MAXREG			(MT6360_PMU_LDO_MASK2)
>   
>   /* MT6360_PMU_IRQ_SET */
> -#define MT6360_PMU_IRQ_REGNUM	(MT6360_PMU_LDO_IRQ2 - MT6360_PMU_CHG_IRQ1 + 1)

Not relevant for the commit. But why did you use this strange computation in the 
first place?

> +#define MT6360_IRQ_REGNUM	16
>   #define MT6360_IRQ_RETRIG	BIT(2)
>   
>   #define CHIP_VEN_MASK				(0xF0)
> 
