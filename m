Return-Path: <SRS0=2gBQ=CN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.0 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,NICE_REPLY_A,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B4368C433E2
	for <linux-kernel@archiver.kernel.org>; Fri,  4 Sep 2020 12:36:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7CBCA2078E
	for <linux-kernel@archiver.kernel.org>; Fri,  4 Sep 2020 12:36:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="SaRph567"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730240AbgIDMgz (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 4 Sep 2020 08:36:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42836 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728588AbgIDMgu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Sep 2020 08:36:50 -0400
Received: from mail-wr1-x442.google.com (mail-wr1-x442.google.com [IPv6:2a00:1450:4864:20::442])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2B009C061244
        for <linux-kernel@vger.kernel.org>; Fri,  4 Sep 2020 05:36:50 -0700 (PDT)
Received: by mail-wr1-x442.google.com with SMTP id x14so6553999wrl.12
        for <linux-kernel@vger.kernel.org>; Fri, 04 Sep 2020 05:36:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=np94MTQE9NKdnGZ67MfbTTvlO7C2gqHJUt/DiThTMys=;
        b=SaRph567ym3v8YdMCsc0XS/3EYhsj2P50NxqfS/BQ3EhN0ZQ9O5XPsrd1Psqn25dus
         Fmw2OHw654aTPf7/eKZHN/is9vY0rzUmqfjCw4G5CT54TqnyaRl1elwECZBA23Q70//N
         Vj7FTBzLNh7X+TI25J6v9NFzdjNk+X5EL5yIAyNIqxyb6jb9eCVUYwpu59K78qM4dCmy
         XkDTgfEEJGpYsU64/zMjAiqYVh88vSts8UwLsn4q0qz0hhIgSC+RwacGRKpPOTBy3mlX
         VdmFksKEcsPGfNzElspeKkCwjr0Rxn/DFamW3fjpKeXxckZltJgV/jmDX1tIu3C1IMiP
         EgBw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=np94MTQE9NKdnGZ67MfbTTvlO7C2gqHJUt/DiThTMys=;
        b=E+XmUMl8b47uPhJNg//roGq53SHADfqe9vYXq5xIuhrjui8ssfwPmvqakKZb6nGwbQ
         6LbwsEYVgzcO0DAaADYM5LfPn/707R+TUH2T5ntR9JB4QYWsqqviQaRdD0wg2rsu0mvO
         1Fn6B1DAe8iNQo9QNy9wIyCHVY2XY10RUpbByfRTnOBSzUOoXl7cq6t+NVoPp/nwzBm5
         UErajChltHc2IZpSNEXcquqLM2u9xaNZfEmDCYZjlu42LCBQfWjXsbzufZKv6pNSq0D6
         7lXB/KsmAMno93WWOBMquOVRtOtweX+xViUYcnqbhIgzPzLdyKquVFwPQ1DmMxGCKP4E
         UQGw==
X-Gm-Message-State: AOAM531ZjdzMDS2AqHlOtoJWJvm0nADmPSEuHlwIgK2lQg0lYI4WFVCR
        HMwds4UzZQEXDAt+x+rYwXfljw==
X-Google-Smtp-Source: ABdhPJwdC1s5sUhd9OGEnsZiv6vJiji/rFQIMTY3M+BKGv7Lr+l/10sIqBHA3tNVujMJZkpOcBIwGA==
X-Received: by 2002:adf:8b1d:: with SMTP id n29mr7101681wra.383.1599223008793;
        Fri, 04 Sep 2020 05:36:48 -0700 (PDT)
Received: from [192.168.86.34] (cpc86377-aztw32-2-0-cust226.18-1.cable.virginm.net. [92.233.226.227])
        by smtp.googlemail.com with ESMTPSA id 185sm3595116wma.18.2020.09.04.05.36.47
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 04 Sep 2020 05:36:48 -0700 (PDT)
Subject: Re: [PATCH] nvmem: core: Use kobj_to_dev() instead of container_of()
To:     Tian Tao <tiantao6@hisilicon.com>, linux-kernel@vger.kernel.org
Cc:     linuxarm@huawei.com
References: <1597915683-44794-1-git-send-email-tiantao6@hisilicon.com>
From:   Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Message-ID: <40984cd3-978b-49fc-07f0-676743d6d5f3@linaro.org>
Date:   Fri, 4 Sep 2020 13:36:47 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <1597915683-44794-1-git-send-email-tiantao6@hisilicon.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 20/08/2020 10:28, Tian Tao wrote:
> Use kobj_to_dev() instead of container_of()
> 
> Signed-off-by: Tian Tao <tiantao6@hisilicon.com>

Applied thanks,

--srini
> ---
>   drivers/nvmem/core.c | 6 +++---
>   1 file changed, 3 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/nvmem/core.c b/drivers/nvmem/core.c
> index 6cd3edb..7641e56 100644
> --- a/drivers/nvmem/core.c
> +++ b/drivers/nvmem/core.c
> @@ -128,7 +128,7 @@ static ssize_t bin_attr_nvmem_read(struct file *filp, struct kobject *kobj,
>   	if (attr->private)
>   		dev = attr->private;
>   	else
> -		dev = container_of(kobj, struct device, kobj);
> +		dev = kobj_to_dev(kobj);
>   	nvmem = to_nvmem_device(dev);
>   
>   	/* Stop the user from reading */
> @@ -168,7 +168,7 @@ static ssize_t bin_attr_nvmem_write(struct file *filp, struct kobject *kobj,
>   	if (attr->private)
>   		dev = attr->private;
>   	else
> -		dev = container_of(kobj, struct device, kobj);
> +		dev = kobj_to_dev(kobj);
>   	nvmem = to_nvmem_device(dev);
>   
>   	/* Stop the user from writing */
> @@ -219,7 +219,7 @@ static umode_t nvmem_bin_attr_get_umode(struct nvmem_device *nvmem)
>   static umode_t nvmem_bin_attr_is_visible(struct kobject *kobj,
>   					 struct bin_attribute *attr, int i)
>   {
> -	struct device *dev = container_of(kobj, struct device, kobj);
> +	struct device *dev = kobj_to_dev(kobj);
>   	struct nvmem_device *nvmem = to_nvmem_device(dev);
>   
>   	return nvmem_bin_attr_get_umode(nvmem);
> 
