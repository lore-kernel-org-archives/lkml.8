Return-Path: <SRS0=PJcK=74=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 06339C433E0
	for <linux-kernel@archiver.kernel.org>; Mon, 15 Jun 2020 09:39:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id CBE2B2065F
	for <linux-kernel@archiver.kernel.org>; Mon, 15 Jun 2020 09:39:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="mvzt6E/I"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729284AbgFOJj0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 15 Jun 2020 05:39:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49488 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728411AbgFOJjZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 Jun 2020 05:39:25 -0400
Received: from mail-wr1-x444.google.com (mail-wr1-x444.google.com [IPv6:2a00:1450:4864:20::444])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E2D39C061A0E
        for <linux-kernel@vger.kernel.org>; Mon, 15 Jun 2020 02:39:23 -0700 (PDT)
Received: by mail-wr1-x444.google.com with SMTP id j10so16354212wrw.8
        for <linux-kernel@vger.kernel.org>; Mon, 15 Jun 2020 02:39:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=x9qVcMyMnAhIbMYyOKNI3DNf1/EsHJJwGDoEeZdbbEc=;
        b=mvzt6E/Ip29QYzcw4SeSGZLcTRX6vuGws4dsFpmc6bjwwLEAXvsQuthjvhj+xyg7eD
         E8PjWN+AhT/v927ry9Ls0aGhJRkbVVOH+L+ALMpyFslZ8tBov/yszBQdS9BVk+T8PZac
         4I/3GSp2Z6+FMQopuHYZWbaJDvUTTyULUnkLyP2FJfuJh7drpG4vBXKQlCF6sYxubYm1
         8pGLnIAG5fFpvWDtUl3wPWZV3BpBD62B60Q0sRtm7lVkDHSBVgYHUl57OUGw0rpJPUiV
         uX6KNkq6q+bg+zlUJkGh4wMqoYXOokwuja3vh3aTcQnlbb+u9UrGiN7yZTK+DUHHzYZ0
         uNzw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=x9qVcMyMnAhIbMYyOKNI3DNf1/EsHJJwGDoEeZdbbEc=;
        b=GF+UO84D6JMr0yRp7lT8l1XDCw0Gv3Y8eN6or8yR+nTfuMsfsVYx4wPR5nlNVBnl4w
         A5byJTYtQ6fuH4u4A9FpD0PYBklkguqyqHxkwW7Qgx0K5z2hPln+q/WkFAF/H7+VGOHL
         phvns7yiC56g30+x0KPk0cdCi5zSzLHo2vPnUXHtKia4mse3+VrQViaO7fvYqa+Dmtfv
         0XcMhfD2FOcjkosMQNseqZV7TPYju03O4PdUYIOK+zg9xrMMCCaFzX7R6VfjBkId7I8b
         OOLTgnYffv9aB2cJ+1u/vR7IK/ausQI6hezSrUgT13kNJ+c3QEJsl9wM+WkkOSkEJp0e
         jChQ==
X-Gm-Message-State: AOAM533EaAqYghnjQ45Cn6Huio7/j0KE8xAHu/7NCLXAYZ7WCnrQ+qxG
        6/ut6E1tGe+m8nVj0bE36/yuLw==
X-Google-Smtp-Source: ABdhPJwg4yBzXAAfc5/XyddS3tc1Y/ihkvQBUtTGCQEGFf9ytyOkVlVpb/Yg9ey/vqcPIxF00eExpQ==
X-Received: by 2002:a5d:5270:: with SMTP id l16mr28075101wrc.80.1592213962660;
        Mon, 15 Jun 2020 02:39:22 -0700 (PDT)
Received: from [192.168.86.34] (cpc89974-aztw32-2-0-cust43.18-1.cable.virginm.net. [86.30.250.44])
        by smtp.googlemail.com with ESMTPSA id k12sm23824737wrn.42.2020.06.15.02.39.21
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 15 Jun 2020 02:39:22 -0700 (PDT)
Subject: Re: [PATCH] nvmem: sc27xx: add sc2730 efuse support
To:     Chunyan Zhang <zhang.lyra@gmail.com>
Cc:     linux-kernel@vger.kernel.org, Orson Zhai <orsonzhai@gmail.com>,
        Baolin Wang <baolin.wang7@gmail.com>,
        Chunyan Zhang <chunyan.zhang@unisoc.com>,
        Freeman Liu <freeman.liu@unisoc.com>
References: <20200615032347.10586-1-zhang.lyra@gmail.com>
From:   Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Message-ID: <504216f8-34f6-11a0-d98e-84ff3901ed52@linaro.org>
Date:   Mon, 15 Jun 2020 10:39:21 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <20200615032347.10586-1-zhang.lyra@gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 15/06/2020 04:23, Chunyan Zhang wrote:
> From: Freeman Liu <freeman.liu@unisoc.com>
> 
> Add support to the new efuse IP which is integrated in the SC2730
> which includes multiple blocks in a single chip.
> 
> Signed-off-by: Freeman Liu <freeman.liu@unisoc.com>
> Signed-off-by: Chunyan Zhang <chunyan.zhang@unisoc.com>
> ---
>   drivers/nvmem/sc27xx-efuse.c | 34 +++++++++++++++++++++++++++++++---
>   1 file changed, 31 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/nvmem/sc27xx-efuse.c b/drivers/nvmem/sc27xx-efuse.c
> index ab5e7e0bc3d8..7d453c9d80da 100644
> --- a/drivers/nvmem/sc27xx-efuse.c
> +++ b/drivers/nvmem/sc27xx-efuse.c

...

>   
> @@ -187,8 +206,15 @@ static int sc27xx_efuse_probe(struct platform_device *pdev)
>   	struct nvmem_config econfig = { };
>   	struct nvmem_device *nvmem;
>   	struct sc27xx_efuse *efuse;
> +	const struct sc27xx_efuse_variant_data *pdata;
>   	int ret;
>   
> +	pdata = of_device_get_match_data(&pdev->dev);
> +	if (!pdata) {

This check is totally unnecessary as you would not end up here unless 
there is a matching compatible!


You could move this after kmalloc and assign efuse->var_data directly!!


--srini

> +		dev_err(&pdev->dev, "No matching driver data found\n");
> +		return -EINVAL;
> +	}
> +
>   	efuse = devm_kzalloc(&pdev->dev, sizeof(*efuse), GFP_KERNEL);
>   	if (!efuse)
>   		return -ENOMEM;
> @@ -219,6 +245,7 @@ static int sc27xx_efuse_probe(struct platform_device *pdev)
>   
>   	mutex_init(&efuse->mutex);
>   	efuse->dev = &pdev->dev;
> +	efuse->var_data = pdata;
>   
