Return-Path: <SRS0=+GcV=BG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=BAYES_00,
	BODY_QUOTE_MALF_MSGID,DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 05EECC433E1
	for <linux-kernel@archiver.kernel.org>; Mon, 27 Jul 2020 12:26:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D144E2074F
	for <linux-kernel@archiver.kernel.org>; Mon, 27 Jul 2020 12:26:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="ufvCrz6Z"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728292AbgG0M0M (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 27 Jul 2020 08:26:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46908 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727078AbgG0M0M (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Jul 2020 08:26:12 -0400
Received: from mail-wm1-x344.google.com (mail-wm1-x344.google.com [IPv6:2a00:1450:4864:20::344])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B587BC061794
        for <linux-kernel@vger.kernel.org>; Mon, 27 Jul 2020 05:26:10 -0700 (PDT)
Received: by mail-wm1-x344.google.com with SMTP id 3so7629862wmi.1
        for <linux-kernel@vger.kernel.org>; Mon, 27 Jul 2020 05:26:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to;
        bh=6rri9mhUlxebznKAimXAy/9Cm8FbvWLt4+hoq73h+fg=;
        b=ufvCrz6ZcjseH/gYg4ZTe6zEzxxBdDu/FZzW+/moozUD7jvBaNfqZjv5A34h1JVTTs
         1xUt+sX775nu+Yzz4gUmHcEUURBPs8CEXsKysjYQa3Jsp/Slud4vARhsOSDOw9frRPSL
         oWDSF2sO2uCcLCHI1HE4FMsLLnvI0/JbptlThAhgwh3XZnV36rbo77kCysTpTKvl71AY
         19eYrNtuElNUaUVL1ockn7C2N7XlkPEmKnXxUizQp/NjgFHkdR58DfsHP8TtcZ3DBqkO
         hyNR6OVv0YaBW1U3E4gv93FjcTVb38WOk7tfeX1re5BF3t/j120PMfmQ1AZi7wqTcv0b
         Fi0A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=6rri9mhUlxebznKAimXAy/9Cm8FbvWLt4+hoq73h+fg=;
        b=kWctxm5dvnZt45v/ek2RW7fkAKhlg25Y9sTWv8DxPyhmbIxsr0kFbCzx/prUuFvMbJ
         z9kJMDm30fA3X87xs+T6+TQmKW3bNZQjWXOhLuVGfoiIJM104rtPN1TXgeSl1RV6a9y+
         dri0oCK2oRvfR2atm2GTQ/ZZZVlWExYd39AkX1SIAlTUtQSseYj0nXamxCqU/Z+07zY9
         OfVCcCHFoAEsgBq7Zri8wF4ANU9t37yUZDeHz4ZDyddBa2TQTuzrZRtqH8709gwBnO1I
         WjZm5qV6mEE/3TFHDF9H0TNxPJKKp/QnACBNMNX8LoFqHLIMPUPipr9vmYQi3btekD9R
         10Cw==
X-Gm-Message-State: AOAM532dIL2+v5OJAbJeZOz1dWp8yer6lS1qUy1JuDVjfZF8BcnPG1Qp
        K3eNd+O1KlOGboSbG+MV5Hmiag==
X-Google-Smtp-Source: ABdhPJxWRBzQIb/NGY4w/mLgO/880v6aJtaTUgabR7iHW48GPvS3Zr/z4csjZpZBpu9zq+g/LhATtQ==
X-Received: by 2002:a05:600c:285:: with SMTP id 5mr21108863wmk.41.1595852769343;
        Mon, 27 Jul 2020 05:26:09 -0700 (PDT)
Received: from dell ([2.27.167.73])
        by smtp.gmail.com with ESMTPSA id n189sm7842688wmn.40.2020.07.27.05.26.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 27 Jul 2020 05:26:08 -0700 (PDT)
Date:   Mon, 27 Jul 2020 13:26:06 +0100
From:   Lee Jones <lee.jones@linaro.org>
To:     Gene Chen <gene.chen.richtek@gmail.com>
Cc:     matthias.bgg@gmail.com, linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org, linux-kernel@vger.kernel.org,
        gene_chen@richtek.com, benjamin.chao@mediatek.com,
        shufan_lee@richtek.com, cy_huang@richtek.com
Subject: Re: [PATCH v2 8/9] mfd: mt6360: Fix flow which is used to check ic
 exist
Message-ID: <20200727122557.GO1850026@dell>
References: <1594983811-25908-1-git-send-email-gene.chen.richtek@gmail.com>
 <1594983811-25908-9-git-send-email-gene.chen.richtek@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <1594983811-25908-9-git-send-email-gene.chen.richtek@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 17 Jul 2020, Gene Chen wrote:

> From: Gene Chen <gene_chen@richtek.com>
> 
> Fix flow which is used to check ic exist.
> 
> Signed-off-by: Gene Chen <gene_chen@richtek.com>
> ---
>  drivers/mfd/mt6360-core.c | 28 +++++++++++++++++++---------
>  1 file changed, 19 insertions(+), 9 deletions(-)
> 
> diff --git a/drivers/mfd/mt6360-core.c b/drivers/mfd/mt6360-core.c
> index 5a68228..3186a7c 100644
> --- a/drivers/mfd/mt6360-core.c
> +++ b/drivers/mfd/mt6360-core.c
> @@ -293,6 +293,23 @@ static const struct mfd_cell mt6360_devs[] = {
>  		    NULL, 0, 0, "mediatek,mt6360-tcpc"),
>  };
>  
> +static int mt6360_check_vendor_info(struct mt6360_data *data)
> +{
> +	u32 info;
> +	int ret;
> +
> +	ret = regmap_read(data->regmap, MT6360_PMU_DEV_INFO, &info);
> +	if (ret < 0)
> +		return ret;
> +
> +	if ((info & CHIP_VEN_MASK) != CHIP_VEN_MT6360)
> +		return -ENODEV;
> +
> +	data->chip_rev = info & CHIP_REV_MASK;
> +
> +	return 0;
> +}
> +
>  static const unsigned short mt6360_slave_addr[MT6360_SLAVE_MAX] = {
>  	MT6360_PMU_SLAVEID,
>  	MT6360_PMIC_SLAVEID,
> @@ -303,7 +320,6 @@ static const unsigned short mt6360_slave_addr[MT6360_SLAVE_MAX] = {
>  static int mt6360_probe(struct i2c_client *client)
>  {
>  	struct mt6360_data *data;
> -	unsigned int reg_data;
>  	int i, ret;
>  
>  	data = devm_kzalloc(&client->dev, sizeof(*data), GFP_KERNEL);
> @@ -319,16 +335,10 @@ static int mt6360_probe(struct i2c_client *client)
>  		return PTR_ERR(data->regmap);
>  	}
>  
> -	ret = regmap_read(data->regmap, MT6360_PMU_DEV_INFO, &reg_data);
> +	ret = mt6360_check_vendor_info(data);
>  	if (ret) {
> -		dev_err(&client->dev, "Device not found\n");
> -		return ret;
> -	}
> -
> -	data->chip_rev = reg_data & CHIP_REV_MASK;
> -	if (data->chip_rev != CHIP_VEN_MT6360) {
>  		dev_err(&client->dev, "Device not supported\n");

Can you move this into mt6360_check_vendor_info() too please?

> -		return -ENODEV;
> +		return ret;
>  	}
>  
>  	ret = devm_regmap_add_irq_chip(&client->dev, data->regmap, client->irq,

-- 
Lee Jones [李琼斯]
Senior Technical Lead - Developer Services
Linaro.org │ Open source software for Arm SoCs
Follow Linaro: Facebook | Twitter | Blog
