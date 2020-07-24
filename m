Return-Path: <SRS0=4orP=BD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.9 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,NICE_REPLY_A,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 55BF0C433E3
	for <linux-kernel@archiver.kernel.org>; Fri, 24 Jul 2020 14:56:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3503F206D8
	for <linux-kernel@archiver.kernel.org>; Fri, 24 Jul 2020 14:56:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="y0Ar8Nd1"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726904AbgGXO4B (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 24 Jul 2020 10:56:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51070 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726366AbgGXO4A (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Jul 2020 10:56:00 -0400
Received: from mail-wm1-x341.google.com (mail-wm1-x341.google.com [IPv6:2a00:1450:4864:20::341])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0D7E8C0619E4
        for <linux-kernel@vger.kernel.org>; Fri, 24 Jul 2020 07:56:00 -0700 (PDT)
Received: by mail-wm1-x341.google.com with SMTP id x5so7654785wmi.2
        for <linux-kernel@vger.kernel.org>; Fri, 24 Jul 2020 07:55:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=Tn0xV71BdxHqqdeiVwu0NskWrwlLub68mratHXXmGoY=;
        b=y0Ar8Nd1SOUY6XTfiucrpoakRsTb13Zv0fp3nEkhFP4wndNFt7tnbYAbrduY5ah9Qp
         RzWL69KmddC+HH6Cj42f29VzqWgkSloKkeOunoXW8tovZhyUpP5WDCMxIzrPgNNKnvz5
         NXaA1Wl+fW9Jdgtp82ZwiSUTDdxEwRj3ecq47VlyjP/ODjNisHFIqtpPAJFLCfuV2E5l
         65/0qPV9DL064uOLdPr4Z+Vz1nqu3RAG+VD+wCPC4yKM/ICuZN8+0Se9U0B/RKFxGKJz
         +jnFxa+Yxr+9Uea+3UYcElGCb053VRZXJENyZMWmRQ68IG9ZQVW9JnYq/7sD7wpU2xfO
         Xv9Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=Tn0xV71BdxHqqdeiVwu0NskWrwlLub68mratHXXmGoY=;
        b=nstHVtTSSq09kSXXr3v3R4o8oP2N4lY/EI6fH/gmh5mKfDvRqWjtB/05/D66ebJzWp
         Otkz4OZ3lQPgcRt4S4L5NnOQsdeez9xEVJ3T/zGg1hO9B8W0xXI+gTglEPdMFZHANkjY
         kTlFC6guJn+oJihisj/18lbz8svCb3/+hkZgtQfznXWArqNhES8X9QZlRhG0l8+8Bzvk
         geypNuyWMKu96Wd+tByjmeXOLZym8yiQMQueszaXxoBYnnJnq/WOs0JNJAUi5eBhUSbN
         tkGe9z6QhGgHbMLc3uDdVuKy+wA77C38dNCQerrwihY6yQeLuX4c3nVJF/k51jLtHBmo
         6SJg==
X-Gm-Message-State: AOAM532Maqr0EUgTY6wRYZ7gaSZiQCgBibf0JScWJ3wfOxewa4AJh2MR
        Aktq+zdnnkNtQ+jdryCaTqTXRQ==
X-Google-Smtp-Source: ABdhPJy2vBTyHXgc0SdIUGd9i2IIAA4tJrpQpHruxxap4iQehB3h4JswktfeLnkt9mZEjdWf7ZZE6A==
X-Received: by 2002:a1c:9994:: with SMTP id b142mr8748915wme.141.1595602558827;
        Fri, 24 Jul 2020 07:55:58 -0700 (PDT)
Received: from [192.168.1.4] ([195.24.90.54])
        by smtp.googlemail.com with ESMTPSA id n5sm7512960wmi.34.2020.07.24.07.55.56
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 24 Jul 2020 07:55:58 -0700 (PDT)
Subject: Re: [PATCH v4 2/5] media: venus: core: Fix error handling in probe
To:     Rajendra Nayak <rnayak@codeaurora.org>, robh+dt@kernel.org,
        agross@kernel.org, bjorn.andersson@linaro.org
Cc:     linux-arm-msm@vger.kernel.org, linux-media@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        mka@chromium.org
References: <1595503612-2901-1-git-send-email-rnayak@codeaurora.org>
 <1595503612-2901-3-git-send-email-rnayak@codeaurora.org>
From:   Stanimir Varbanov <stanimir.varbanov@linaro.org>
Message-ID: <08c2fec5-47a7-9a31-12a6-bae56d18b37c@linaro.org>
Date:   Fri, 24 Jul 2020 17:55:55 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <1595503612-2901-3-git-send-email-rnayak@codeaurora.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 7/23/20 2:26 PM, Rajendra Nayak wrote:
> Post a successful pm_ops->core_get, an error in probe
> should exit by doing a pm_ops->core_put which seems
> to be missing. So fix it.
> 
> Signed-off-by: Rajendra Nayak <rnayak@codeaurora.org>
> ---
>  drivers/media/platform/qcom/venus/core.c | 15 ++++++++++-----
>  1 file changed, 10 insertions(+), 5 deletions(-)

Acked-by: Stanimir Varbanov <stanimir.varbanov@linaro.org>

> 
> diff --git a/drivers/media/platform/qcom/venus/core.c b/drivers/media/platform/qcom/venus/core.c
> index 203c653..bfcaba3 100644
> --- a/drivers/media/platform/qcom/venus/core.c
> +++ b/drivers/media/platform/qcom/venus/core.c
> @@ -224,13 +224,15 @@ static int venus_probe(struct platform_device *pdev)
>  
>  	ret = dma_set_mask_and_coherent(dev, core->res->dma_mask);
>  	if (ret)
> -		return ret;
> +		goto err_core_put;
>  
>  	if (!dev->dma_parms) {
>  		dev->dma_parms = devm_kzalloc(dev, sizeof(*dev->dma_parms),
>  					      GFP_KERNEL);
> -		if (!dev->dma_parms)
> -			return -ENOMEM;
> +		if (!dev->dma_parms) {
> +			ret = -ENOMEM;
> +			goto err_core_put;
> +		}
>  	}
>  	dma_set_max_seg_size(dev, DMA_BIT_MASK(32));
>  
> @@ -242,11 +244,11 @@ static int venus_probe(struct platform_device *pdev)
>  					IRQF_TRIGGER_HIGH | IRQF_ONESHOT,
>  					"venus", core);
>  	if (ret)
> -		return ret;
> +		goto err_core_put;
>  
>  	ret = hfi_create(core, &venus_core_ops);
>  	if (ret)
> -		return ret;
> +		goto err_core_put;
>  
>  	pm_runtime_enable(dev);
>  
> @@ -302,6 +304,9 @@ static int venus_probe(struct platform_device *pdev)
>  	pm_runtime_set_suspended(dev);
>  	pm_runtime_disable(dev);
>  	hfi_destroy(core);
> +err_core_put:
> +	if (core->pm_ops->core_put)
> +		core->pm_ops->core_put(dev);
>  	return ret;
>  }
>  
> 

-- 
regards,
Stan
