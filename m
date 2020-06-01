Return-Path: <SRS0=8+oI=7O=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 28E5AC433E0
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Jun 2020 05:24:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0400D2073E
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Jun 2020 05:24:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="dA2CB31s"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725999AbgFAFYk (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 1 Jun 2020 01:24:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59656 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725778AbgFAFYj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 Jun 2020 01:24:39 -0400
Received: from mail-wm1-x344.google.com (mail-wm1-x344.google.com [IPv6:2a00:1450:4864:20::344])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 55D2CC061A0E
        for <linux-kernel@vger.kernel.org>; Sun, 31 May 2020 22:24:39 -0700 (PDT)
Received: by mail-wm1-x344.google.com with SMTP id d128so10055491wmc.1
        for <linux-kernel@vger.kernel.org>; Sun, 31 May 2020 22:24:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to;
        bh=6ZL8Ph/G4JgUrG27yx5jOAVsjITYufkbj9OoG3EiYg8=;
        b=dA2CB31sQ3Af0qUnmPd1S0YDJqELMRRu+gA7/hUSep7Gkrb1fo/neGae7TZlSgmco4
         HuxnDn48VwRNdoJ4L4uznitZuO9+exNsJ1l42htH3amQN9vybXbGG124lC0jd1xEVUuf
         eilKDyn8QzkVREVQgOffBb5rn7EA+xEt5rVQBeRE9rrW+5ErUH4IkiUf7nZzE85UeLjx
         wMl+bwp5zYT7i2PB+V7kmz8U8UVkoyPrAC8EDZ51yPG8DcTDCH6OYvZKreMNQATXxb2s
         6friPAu8HN+1J1eniSAR69g+bQgojly4qQfVzIHoiU9eaCNF2yAH49QNbpivLxONxzfR
         vQBg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=6ZL8Ph/G4JgUrG27yx5jOAVsjITYufkbj9OoG3EiYg8=;
        b=rgLeOyFM8vEX0wLdzKncpJJ36YHWnYdwosjQCf8pb6FVFGJuKZXXmTpN0tM1mDvp0I
         pFhJESwlHh3NOtfYn4tB8wZQB8seE75k3wnI9LqRO/YGU0I1RUOTws7OITQAQm/+cBPg
         IB8pSUInaiATLcG0RJWeycBbFHqcMHu9TSiwO3TwW/WGv0XsjdWOtaPUv1pOK5MjHEEk
         sLAkUuffxnngh9ny816qU2PWiqIYkxiwMf3lEmTg4/nPVmR7YTFYjmU4iacZHeT9bo2B
         CWMc6M3Mf5uDMx5GoTMsUPUfrRHlj3zVo4lXUu+4XqNPZ1ErP6U/7qwj/lFK5V0mgJt8
         X5Vg==
X-Gm-Message-State: AOAM533epY9Eykf3TKmI2wBO0ED/ABabKfj43iNT/P5ZJdJM6ee7O0qh
        l6Tth6P4UzKi9r0AeZPQylBW/2oVcUY=
X-Google-Smtp-Source: ABdhPJxhx9/WQeqXLPdXyUP/V3m+hF0vRniSFumysbnrVtMqhxlQzfSXBPMnW0DCYiw90xvl8UL1fQ==
X-Received: by 2002:a1c:2e41:: with SMTP id u62mr21047004wmu.91.1590989075882;
        Sun, 31 May 2020 22:24:35 -0700 (PDT)
Received: from dell ([95.147.198.92])
        by smtp.gmail.com with ESMTPSA id k12sm17543313wrn.42.2020.05.31.22.24.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 31 May 2020 22:24:35 -0700 (PDT)
Date:   Mon, 1 Jun 2020 06:24:33 +0100
From:   Lee Jones <lee.jones@linaro.org>
To:     Charles Keepax <ckeepax@opensource.cirrus.com>
Cc:     s.nawrocki@samsung.com, linux-kernel@vger.kernel.org,
        patches@opensource.cirrus.com
Subject: Re: [PATCH 2/3] mfd: madera: Fix minor formatting issues
Message-ID: <20200601052433.GA3714@dell>
References: <20200529155742.18399-1-ckeepax@opensource.cirrus.com>
 <20200529155742.18399-2-ckeepax@opensource.cirrus.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20200529155742.18399-2-ckeepax@opensource.cirrus.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 29 May 2020, Charles Keepax wrote:

Still needs a commit log.

> Signed-off-by: Charles Keepax <ckeepax@opensource.cirrus.com>
> ---
>  drivers/mfd/madera-core.c        | 12 ++++++------
>  drivers/mfd/madera-i2c.c         |  1 -
>  include/linux/mfd/madera/pdata.h |  1 -
>  3 files changed, 6 insertions(+), 8 deletions(-)
> 
> diff --git a/drivers/mfd/madera-core.c b/drivers/mfd/madera-core.c
> index 7e0835cb062b1..4724c1a01a39f 100644
> --- a/drivers/mfd/madera-core.c
> +++ b/drivers/mfd/madera-core.c
> @@ -44,7 +44,7 @@ static const char * const madera_core_supplies[] = {
>  };
>  
>  static const struct mfd_cell madera_ldo1_devs[] = {
> -	{ .name = "madera-ldo1" },
> +	{ .name = "madera-ldo1", },

What issue does this solve?

Why are ','s a requirement, even for single entries?

>  };
>  
>  static const char * const cs47l15_supplies[] = {
> @@ -55,8 +55,8 @@ static const char * const cs47l15_supplies[] = {
>  
>  static const struct mfd_cell cs47l15_devs[] = {
>  	{ .name = "madera-pinctrl", },
> -	{ .name = "madera-irq" },
> -	{ .name = "madera-gpio" },
> +	{ .name = "madera-irq", },
> +	{ .name = "madera-gpio", },
>  	{
>  		.name = "madera-extcon",
>  		.parent_supplies = cs47l15_supplies,
> @@ -108,7 +108,7 @@ static const char * const cs47l85_supplies[] = {
>  static const struct mfd_cell cs47l85_devs[] = {
>  	{ .name = "madera-pinctrl", },
>  	{ .name = "madera-irq", },
> -	{ .name = "madera-micsupp" },
> +	{ .name = "madera-micsupp", },
>  	{ .name = "madera-gpio", },
>  	{
>  		.name = "madera-extcon",
> @@ -155,10 +155,10 @@ static const char * const cs47l92_supplies[] = {
>  };
>  
>  static const struct mfd_cell cs47l92_devs[] = {
> -	{ .name = "madera-pinctrl" },
> +	{ .name = "madera-pinctrl", },
>  	{ .name = "madera-irq", },
>  	{ .name = "madera-micsupp", },
> -	{ .name = "madera-gpio" },
> +	{ .name = "madera-gpio", },
>  	{
>  		.name = "madera-extcon",
>  		.parent_supplies = cs47l92_supplies,
> diff --git a/drivers/mfd/madera-i2c.c b/drivers/mfd/madera-i2c.c
> index 6b965eb034b6c..7df5b9ba58554 100644
> --- a/drivers/mfd/madera-i2c.c
> +++ b/drivers/mfd/madera-i2c.c
> @@ -88,7 +88,6 @@ static int madera_i2c_probe(struct i2c_client *i2c,
>  	if (!madera)
>  		return -ENOMEM;
>  
> -
>  	madera->regmap = devm_regmap_init_i2c(i2c, regmap_16bit_config);
>  	if (IS_ERR(madera->regmap)) {
>  		ret = PTR_ERR(madera->regmap);
> diff --git a/include/linux/mfd/madera/pdata.h b/include/linux/mfd/madera/pdata.h
> index fa9595dd42ba5..601cbbc10370c 100644
> --- a/include/linux/mfd/madera/pdata.h
> +++ b/include/linux/mfd/madera/pdata.h
> @@ -21,7 +21,6 @@
>  
>  struct gpio_desc;
>  struct pinctrl_map;
> -struct madera_codec_pdata;

This is not a formatting issue.

>  /**
>   * struct madera_pdata - Configuration data for Madera devices

-- 
Lee Jones [李琼斯]
Linaro Services Technical Lead
Linaro.org │ Open source software for ARM SoCs
Follow Linaro: Facebook | Twitter | Blog
