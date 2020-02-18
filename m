Return-Path: <SRS0=52rg=4G=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1078FC34033
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Feb 2020 09:42:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DA942206E2
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Feb 2020 09:42:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="AU8BMEdH"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726648AbgBRJmJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 18 Feb 2020 04:42:09 -0500
Received: from mail-wm1-f68.google.com ([209.85.128.68]:38617 "EHLO
        mail-wm1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726323AbgBRJmJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Feb 2020 04:42:09 -0500
Received: by mail-wm1-f68.google.com with SMTP id a9so2092651wmj.3
        for <linux-kernel@vger.kernel.org>; Tue, 18 Feb 2020 01:42:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=iSpUEW7beHak9UFrM6ih/G70K0ztc6Y3OmsEa5YMS5I=;
        b=AU8BMEdHS2+zOtGQ5oh+Xfc3PTOg7SSXbjXfZNjvQDQEGL28W3Vzys5I6GuBWU+WzU
         IRIornPAr3QGw9Fs/tV2y1jjC7nXn1lCWsonLmvTw2grML8+9n/KLfvHeJVt3PYFEYVD
         hv7v4pnz3i6grhRfKP/20gv3cMmQkw4WFElD3Pibh3Wd9mLUhFjKt4JwrIsfMX2LAzkq
         GiJ9zKeEvg91pVZbaIRA+kHY4LfgQXbCmA02PlIhViCERfDyxc3nLfc37o0+bt28UkR9
         WmSNh9UtraWmEHah/zTkR6LkYVuA/Trb8SY4XxRIShbSGdPxRgTcS6UcxuqU91yype3P
         S1LQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=iSpUEW7beHak9UFrM6ih/G70K0ztc6Y3OmsEa5YMS5I=;
        b=pBAE3ZowRdbZEhAHO+1bg8dQsMJ/2KJf9d4iz+xN++hKTkGSECkxOyjtCIq/oEEHV+
         OYw6Ot0c3qP6pEA0c0tGiMnfMaGE6p5UX5IIZPCHAJ6KS7gUhU1SO68raIS3RX7Kly/7
         lAxPa0yVVXHfxES5T9eUZdDtOnUhJ+tjT3mpFxlC8i+wK5SunFl1Uq5cBkGWlO7/T+Q1
         mCYSSVeiwO+3kkiwIqQgoLBJ0MTAP3064G6RWkcMhxjPHvw77OsI14aR+s8Rbe9uQ2Nu
         PtQyvfNE6Ta9FLHOyGbfRjvI0mlQ5ov8jyQooi45v17c7c8R9SE1+bxuR7gc8WYnqPbX
         tDWw==
X-Gm-Message-State: APjAAAXY6b6o2GfA6QZKo/zmOqpB4ezrrD+UhzIKAelE/hKcBZsojIXW
        UK7Hr/a6E1etnyKduzsde9C/Jg==
X-Google-Smtp-Source: APXvYqwMloa/+poSBCxwhlV66qSC7pyEfKb3TWpN7dVptDyzjqcUEWDGxXop8faC5858jO3UJIYwYQ==
X-Received: by 2002:a7b:ce18:: with SMTP id m24mr2105877wmc.123.1582018926170;
        Tue, 18 Feb 2020 01:42:06 -0800 (PST)
Received: from [192.168.86.34] (cpc89974-aztw32-2-0-cust43.18-1.cable.virginm.net. [86.30.250.44])
        by smtp.googlemail.com with ESMTPSA id y17sm5041589wrs.82.2020.02.18.01.42.05
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 18 Feb 2020 01:42:05 -0800 (PST)
Subject: Re: [PATCH 2/6] nvmem: fix memory leak in error path
To:     Bartosz Golaszewski <brgl@bgdev.pl>,
        Linus Walleij <linus.walleij@linaro.org>,
        Khouloud Touil <ktouil@baylibre.com>
Cc:     linux-gpio@vger.kernel.org, linux-kernel@vger.kernel.org,
        Bartosz Golaszewski <bgolaszewski@baylibre.com>
References: <20200217195435.9309-1-brgl@bgdev.pl>
 <20200217195435.9309-3-brgl@bgdev.pl>
From:   Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Message-ID: <f539c993-52b5-766d-d6e5-51836998f445@linaro.org>
Date:   Tue, 18 Feb 2020 09:42:04 +0000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <20200217195435.9309-3-brgl@bgdev.pl>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 17/02/2020 19:54, Bartosz Golaszewski wrote:
> From: Bartosz Golaszewski <bgolaszewski@baylibre.com>
> 
> We need to remove the ida mapping when returning from nvmem_register()
> with an error.
> 
> Signed-off-by: Bartosz Golaszewski <bgolaszewski@baylibre.com>
Was too quick in my last reply..

> ---
>   drivers/nvmem/core.c | 4 +++-
>   1 file changed, 3 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/nvmem/core.c b/drivers/nvmem/core.c
> index ef326f243f36..b0be03d5f240 100644
> --- a/drivers/nvmem/core.c
> +++ b/drivers/nvmem/core.c
> @@ -353,7 +353,7 @@ struct nvmem_device *nvmem_register(const struct nvmem_config *config)
>   		nvmem->wp_gpio = gpiod_get_optional(config->dev, "wp",
>   						    GPIOD_OUT_HIGH);
>   	if (IS_ERR(nvmem->wp_gpio))
> -		return ERR_CAST(nvmem->wp_gpio);
> +		goto err_ida_remove;

Looks like this is adding  nvmem leak here.
May be something like this should help:


if (IS_ERR(nvmem->wp_gpio)) {
	rval =  ERR_CAST(nvmem->wp_gpio);
	ida_simple_remove(&nvmem_ida, nvmem->id);
	kfree(nvmem);
	return rval;

}

--srini
>   
>   
>   	kref_init(&nvmem->refcnt);
> @@ -430,6 +430,8 @@ struct nvmem_device *nvmem_register(const struct nvmem_config *config)
>   	device_del(&nvmem->dev);
>   err_put_device:
>   	put_device(&nvmem->dev);
> +err_ida_remove:
> +	ida_simple_remove(&nvmem_ida, nvmem->id);
>   
>   	return ERR_PTR(rval);
>   }
> 
