Return-Path: <SRS0=qBN/=CU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,NICE_REPLY_A,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 06B64C43461
	for <linux-kernel@archiver.kernel.org>; Fri, 11 Sep 2020 12:05:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id AE15E20732
	for <linux-kernel@archiver.kernel.org>; Fri, 11 Sep 2020 12:05:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="wPkzFbHn"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725776AbgIKMFr (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 11 Sep 2020 08:05:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58734 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725808AbgIKMEo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Sep 2020 08:04:44 -0400
Received: from mail-wm1-x344.google.com (mail-wm1-x344.google.com [IPv6:2a00:1450:4864:20::344])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5DCA1C061573
        for <linux-kernel@vger.kernel.org>; Fri, 11 Sep 2020 05:04:43 -0700 (PDT)
Received: by mail-wm1-x344.google.com with SMTP id k18so4534727wmj.5
        for <linux-kernel@vger.kernel.org>; Fri, 11 Sep 2020 05:04:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=WLNDPPEnv/63zSa4lOCllaWXboquu+chiB81j8h0QmQ=;
        b=wPkzFbHnj5oK8khkVlZrovmxVc3N0jKG8UJiHvJEArwxYiaYxNjIfoeq5/IHLf5qaP
         OhICu2AqBmKOfS1SUnRVGx46RHk+IeWXAFmZvX++9kNKF2uoc4kgD4LrEVbU6FLo5TC6
         DWqmnzOjNiecfE0ip/Uw4mll8WVWQZtl2dOPCdyNQzt48QvHYepxYPTFe80/EFDleGi4
         zBf8jcACvM5RQcWDX3+2pVffhJbx9OJJBq2XyhpAnR5RadwcHS8u3W5SfqrocxdrYYke
         wR+/5/IuVvrve2v+oSMwdYC9OiAOa704Ab7OwL8dSuuoQ8JR0ope08y5UfF0K+bRiX0R
         jQlg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=WLNDPPEnv/63zSa4lOCllaWXboquu+chiB81j8h0QmQ=;
        b=OMW0BlwZz9EBzShs0BiofvRCIYAVKOvUEbuTt7tubInPW9C+mKnCLwNoJVJhAt8gzx
         JvIwb/3jHuYJz0ZLatjm4YB2QNxhE2+K3Xv/3PqJOK/WA9yM2qD2MZvFV0psuaD8DDgf
         ajzgTBsKHYwz9P4+HVgdTr7HZyVnf0utU9b+LNwb3rncowCDh7wrygSf/jbwDfwxRWuv
         CU2WkYA9GCv+dp/8iKQqSPvPVx7rxpQt2riik+VhWeof40VVC3WeVZSCNtDMKtfHwCIM
         qeGW/Kv9e9Sc/attSlfs3PSko6dL/wPNVJ6GVlPA65kCHLV1Xp6ICw2UQhWgdYgRc6Oi
         g55g==
X-Gm-Message-State: AOAM531lP4FRKPggyun3dUuzikN+y9tjt1R54zOYzu8Ai5leDgH0FXXO
        VmkWYRni4mbkxlku4g5s5VX/JA==
X-Google-Smtp-Source: ABdhPJyPpYjxV2wUTl6HJw2UQBsdoRmSWYJN9cVSkopJDuPUTJ0ZmeC0qXBuP+stDN58Dye7RArQKw==
X-Received: by 2002:a1c:bb88:: with SMTP id l130mr1925793wmf.143.1599825882052;
        Fri, 11 Sep 2020 05:04:42 -0700 (PDT)
Received: from [192.168.86.34] (cpc86377-aztw32-2-0-cust226.18-1.cable.virginm.net. [92.233.226.227])
        by smtp.googlemail.com with ESMTPSA id o4sm4073407wru.55.2020.09.11.05.04.41
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 11 Sep 2020 05:04:41 -0700 (PDT)
Subject: Re: [PATCH] nvmem: switch to simpler IDA interface
To:     Bartosz Golaszewski <brgl@bgdev.pl>
Cc:     linux-kernel@vger.kernel.org,
        Bartosz Golaszewski <bgolaszewski@baylibre.com>
References: <20200908132755.11944-1-brgl@bgdev.pl>
From:   Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Message-ID: <e6dc9989-8fff-afdb-654b-c23e9cf12bc5@linaro.org>
Date:   Fri, 11 Sep 2020 13:04:40 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <20200908132755.11944-1-brgl@bgdev.pl>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 08/09/2020 14:27, Bartosz Golaszewski wrote:
> From: Bartosz Golaszewski <bgolaszewski@baylibre.com>
> 
> We don't need to specify any ranges when allocating IDs so we can switch
> to ida_alloc() and ida_free() instead of the ida_simple_ counterparts.
> 
> ida_simple_get(ida, 0, 0, gfp) is equivalent to
> ida_alloc_range(ida, 0, UINT_MAX, gfp) which is equivalent to
> ida_alloc(ida, gfp). Note: IDR will never actually allocate an ID
> larger than INT_MAX.
> 
> Signed-off-by: Bartosz Golaszewski <bgolaszewski@baylibre.com>
> ---
>   drivers/nvmem/core.c | 6 +++---
>   1 file changed, 3 insertions(+), 3 deletions(-)

thanks Applied!

--srini
> 
> diff --git a/drivers/nvmem/core.c b/drivers/nvmem/core.c
> index 6cd3edb2eaf6..cd332d711dd1 100644
> --- a/drivers/nvmem/core.c
> +++ b/drivers/nvmem/core.c
> @@ -321,7 +321,7 @@ static void nvmem_release(struct device *dev)
>   {
>   	struct nvmem_device *nvmem = to_nvmem_device(dev);
>   
> -	ida_simple_remove(&nvmem_ida, nvmem->id);
> +	ida_free(&nvmem_ida, nvmem->id);
>   	gpiod_put(nvmem->wp_gpio);
>   	kfree(nvmem);
>   }
> @@ -596,7 +596,7 @@ struct nvmem_device *nvmem_register(const struct nvmem_config *config)
>   	if (!nvmem)
>   		return ERR_PTR(-ENOMEM);
>   
> -	rval  = ida_simple_get(&nvmem_ida, 0, 0, GFP_KERNEL);
> +	rval  = ida_alloc(&nvmem_ida, GFP_KERNEL);
>   	if (rval < 0) {
>   		kfree(nvmem);
>   		return ERR_PTR(rval);
> @@ -608,7 +608,7 @@ struct nvmem_device *nvmem_register(const struct nvmem_config *config)
>   		nvmem->wp_gpio = gpiod_get_optional(config->dev, "wp",
>   						    GPIOD_OUT_HIGH);
>   	if (IS_ERR(nvmem->wp_gpio)) {
> -		ida_simple_remove(&nvmem_ida, nvmem->id);
> +		ida_free(&nvmem_ida, nvmem->id);
>   		rval = PTR_ERR(nvmem->wp_gpio);
>   		kfree(nvmem);
>   		return ERR_PTR(rval);
> 
