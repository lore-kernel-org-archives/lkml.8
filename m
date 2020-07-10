Return-Path: <SRS0=2Lxt=AV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1231DC433E1
	for <linux-kernel@archiver.kernel.org>; Fri, 10 Jul 2020 14:25:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D651A2063A
	for <linux-kernel@archiver.kernel.org>; Fri, 10 Jul 2020 14:25:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Kh/kxXRH"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728121AbgGJOZ1 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 10 Jul 2020 10:25:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43326 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726832AbgGJOZ0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Jul 2020 10:25:26 -0400
Received: from mail-wr1-x442.google.com (mail-wr1-x442.google.com [IPv6:2a00:1450:4864:20::442])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8B7ABC08C5CE
        for <linux-kernel@vger.kernel.org>; Fri, 10 Jul 2020 07:25:26 -0700 (PDT)
Received: by mail-wr1-x442.google.com with SMTP id q5so6158259wru.6
        for <linux-kernel@vger.kernel.org>; Fri, 10 Jul 2020 07:25:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=J2TSVXXxCrTLY4NrTstCcWcFdBTWUGySy01vayP2bug=;
        b=Kh/kxXRH/GEtgV9DtbuSQvl6bi8+nr5NoUiKjZvT2mwAx0kw7PUBc+dKtaDXIpMj9u
         +0LeqXHZEx0f3DAhy/N/wlZx6RLlOBZLsopWYGpUMb61BWTtg1WeMC+h9e1VQTPc8454
         Laaw2eMrQ+SuMcZf+zrBZpakhXkNnqwsi6jFZi8uTaRGQge9jFMUuQzP8fIA7CCamag6
         KA0iZOFxg9JWGVneGDaX3CJ4mlyYh6AEP8KOypKCU0iPVO/U2Y7gXbIWdYs/9YN2GSeb
         eEfaMqxU0FMe4yINqY4dUNf5aPsMdR2cSgRd80NV4jtMBzgWp0JfT4Kf/YY4MpBIZQXq
         1O2Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=J2TSVXXxCrTLY4NrTstCcWcFdBTWUGySy01vayP2bug=;
        b=Pj+TJHjCHsnzv6DfDTA/bP8tCCRn47gOTG4W5HXNtJfSH/cgJ/AD1DRJ6gqepLVmaA
         eYmH9GcbRsGcUndPOb7yWRBUrujyXDMXf8fDQDixYrYO3I9hdhIfs0y++Z+ZbGttu8rj
         baRoesb8FDMaS9RIuPtd92ro6ns+dp9PnC9gxM+nvlRvBp5LszbwYlDMQaOkEAm51L/0
         rW9YHkNsfaIG55m5mwwAO+l7udVPy0bUivexzgnD/n95BvO+WA65glsp/eO5lBIhbD8f
         lXmPQ9Zp6jT2rfBL0ncEDVIzX09cuNhWMk5SunprPnICUeCPYVH48OgiN/llbu6hsFsE
         Rbrg==
X-Gm-Message-State: AOAM533QjhZbUusbDRQlGIiE+lnFY5ORJeABDuIta9GtUmOKnI2+odJA
        p88DzqpX98yMmbksj08kA4Q=
X-Google-Smtp-Source: ABdhPJzpZ+aplToWnYe5A8tOusuTfhg+dlCf/JDDNEaD96yPyy2zwuPkJBHGPTp5yt6O2xlLKPTiJA==
X-Received: by 2002:adf:dc90:: with SMTP id r16mr68810902wrj.264.1594391125277;
        Fri, 10 Jul 2020 07:25:25 -0700 (PDT)
Received: from ziggy.stardust ([213.195.114.245])
        by smtp.gmail.com with ESMTPSA id g13sm10429136wro.84.2020.07.10.07.25.24
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 10 Jul 2020 07:25:24 -0700 (PDT)
Subject: Re: [PATCH 3/4] mfd: mt6360: Fix flow which is used to check ic exist
To:     Gene Chen <gene.chen.richtek@gmail.com>, lee.jones@linaro.org
Cc:     linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org, linux-kernel@vger.kernel.org,
        gene_chen@richtek.com, shufan_lee@richtek.com,
        cy_huang@richtek.com, benjamin.chao@mediatek.com
References: <1594117856-14343-1-git-send-email-gene.chen.richtek@gmail.com>
 <1594117856-14343-4-git-send-email-gene.chen.richtek@gmail.com>
From:   Matthias Brugger <matthias.bgg@gmail.com>
Message-ID: <3205bb9b-c7b4-c99a-2673-f3a56cc0addf@gmail.com>
Date:   Fri, 10 Jul 2020 16:25:23 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.9.0
MIME-Version: 1.0
In-Reply-To: <1594117856-14343-4-git-send-email-gene.chen.richtek@gmail.com>
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
> Fix flow which is used to check ic exist
> 
> Signed-off-by: Gene Chen <gene_chen@richtek.com>
> ---
>   drivers/mfd/mt6360-core.c  | 28 +++++++++++++++++++---------
>   include/linux/mfd/mt6360.h |  8 ++++----
>   2 files changed, 23 insertions(+), 13 deletions(-)
> 
> diff --git a/drivers/mfd/mt6360-core.c b/drivers/mfd/mt6360-core.c
> index 2dd5918..4bb2949 100644
> --- a/drivers/mfd/mt6360-core.c
> +++ b/drivers/mfd/mt6360-core.c
> @@ -293,6 +293,23 @@ static const struct mfd_cell mt6360_devs[] = {
>   		    NULL, 0, 0, "mediatek,mt6360-tcpc"),
>   };
>   
> +static int mt6360_check_vendor_info(struct mt6360_data *data)
> +{
> +	u32 info;
> +	int ret;
> +
> +	ret = regmap_read(data->regmap, MT6360_REG_PMU_DEVINFO, &info);
> +	if (ret < 0)
> +		return ret;
> +
> +	if ((info & MT6360_CHIPVEN_MASK) != MT6360_CHIPVEN_VAL)
> +		return -ENODEV;
> +
> +	data->chip_rev = info & MT6360_CHIPREV_MASK;
> +
> +	return 0;
> +}
> +
>   static const unsigned short mt6360_slave_addr[MT6360_SLAVE_MAX] = {
>   	MT6360_PMU_SLAVEID,
>   	MT6360_PMIC_SLAVEID,
> @@ -303,7 +320,6 @@ static const unsigned short mt6360_slave_addr[MT6360_SLAVE_MAX] = {
>   static int mt6360_probe(struct i2c_client *client)
>   {
>   	struct mt6360_data *data;
> -	unsigned int reg_data;
>   	int i, ret;
>   
>   	data = devm_kzalloc(&client->dev, sizeof(*data), GFP_KERNEL);
> @@ -319,16 +335,10 @@ static int mt6360_probe(struct i2c_client *client)
>   		return PTR_ERR(data->regmap);
>   	}
>   
> -	ret = regmap_read(data->regmap, MT6360_PMU_DEV_INFO, &reg_data);
> +	ret = mt6360_check_vendor_info(data);
>   	if (ret) {
> -		dev_err(&client->dev, "Device not found\n");
> -		return ret;
> -	}
> -
> -	data->chip_rev = reg_data & CHIP_REV_MASK;
> -	if (data->chip_rev != CHIP_VEN_MT6360) {

Why not only applying the MASK here instead of put this all in a new function?

>   		dev_err(&client->dev, "Device not supported\n");
> -		return -ENODEV;
> +		return ret;
>   	}
>   
>   	ret = devm_regmap_add_irq_chip(&client->dev, data->regmap, client->irq,
> diff --git a/include/linux/mfd/mt6360.h b/include/linux/mfd/mt6360.h
> index 9fc6718..5ec0f5d 100644
> --- a/include/linux/mfd/mt6360.h
> +++ b/include/linux/mfd/mt6360.h
> @@ -30,7 +30,7 @@ struct mt6360_data {
>   };
>   
>   /* PMU register defininition */
> -#define MT6360_PMU_DEV_INFO			(0x00)
> +#define MT6360_REG_PMU_DEVINFO			(0x00)
>   #define MT6360_PMU_CORE_CTRL1			(0x01)
>   #define MT6360_PMU_RST1				(0x02)
>   #define MT6360_PMU_CRCEN			(0x03)
> @@ -233,8 +233,8 @@ struct mt6360_data {
>   #define MT6360_IRQ_REGNUM	16
>   #define MT6360_IRQ_RETRIG	BIT(2)
>   
> -#define CHIP_VEN_MASK				(0xF0)
> -#define CHIP_VEN_MT6360				(0x50)
> -#define CHIP_REV_MASK				(0x0F)
> +#define MT6360_CHIPVEN_MASK			(0xF0)
> +#define MT6360_CHIPVEN_VAL			(0x50)
> +#define MT6360_CHIPREV_MASK			(0x0F)

Same here as in the other patches. Don't just rename defines if there is no good 
reason.

Regards,
Matthias

>   
>   #endif /* __MT6360_H__ */
> 
