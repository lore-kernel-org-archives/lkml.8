Return-Path: <SRS0=n6RB=27=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 93D63C33CA2
	for <linux-kernel@archiver.kernel.org>; Fri, 10 Jan 2020 10:16:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 623E02051A
	for <linux-kernel@archiver.kernel.org>; Fri, 10 Jan 2020 10:16:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="WC57lZpe"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727499AbgAJKQJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 10 Jan 2020 05:16:09 -0500
Received: from mail-wm1-f66.google.com ([209.85.128.66]:53715 "EHLO
        mail-wm1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727240AbgAJKQJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Jan 2020 05:16:09 -0500
Received: by mail-wm1-f66.google.com with SMTP id m24so1363964wmc.3
        for <linux-kernel@vger.kernel.org>; Fri, 10 Jan 2020 02:16:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=kJcJ3Z4R5O84gZeCwxxOsOYiPBXfsGpmbGOuOvGKfLU=;
        b=WC57lZpeU1EKop2f9LUfJAg0AHr9oR5rtcFEMs3p0v2qn/5EYxPqx46Y2rmsyge8EY
         /rcwSWq073bel2NfqTfXjxzzbkR/mvUm36x9W8+SfDWjHLY3cm6gSEQjta0UjFF2myEp
         RqQVOiaUDfKp9gZmYyCQzLI41aAFLrUQ17BRjDnEMgQviCmNIuI0PwQHBGk3oTOAqLQx
         6kHgpA8DseNx7Oys8jjSxt64aekC7OJal53HqlKDeHAJXk+AhpPQdT93oPJDWCU3vjkY
         v7B1fTEw9p2jAH7/YtEE+W9qXAZfsxuKN3rAfQOC/qgTlG89D8hvYdTKyxVRd61qcN8i
         bbXg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=kJcJ3Z4R5O84gZeCwxxOsOYiPBXfsGpmbGOuOvGKfLU=;
        b=oxONomUCeSMq3O/5FhY/RqqNFCsESrGHw1eqy8FZUahb+JRO8sNEiXI7pmRuSxX0//
         quAs5ST6CAHOOvkkRb+VTwR+lGP2aJ8YsgG5wTZJrz3UsTDU/oMtI0oBE53Rvrk8rtWG
         bXv56++HyQarZFqfybjF1+h66E30HgU4UTq/tWWavTUbcKzxofONL07rQpbRWlNibjs2
         IQnb1y8SoT7yq0STl72TSPnsyvGOnqrs7o8xuu2KTS8kvfKXHIMQT69/kLWB9UQQqD5i
         TurTCkxUOF/gbfMxkOkpQA2mj4W3GA4qpijXL7CZRFwhPr9kLFz9bH0lOq5FMfJEMk09
         hd6w==
X-Gm-Message-State: APjAAAUVVA1dCT9eg+WQmv7OmHZLC2ZwoU+nDvfCjOESYPjSX+ohFFsh
        0UBoPKS8eECSf56Gj24EmjbhiOVZbmg=
X-Google-Smtp-Source: APXvYqypT+B79XnHkYFVVKZAVMkW/X9U+ndnBnu0W9qxAqVphbZJrWbtDaid8Q4GoLU5jkkm2pUFqQ==
X-Received: by 2002:a7b:c084:: with SMTP id r4mr3157095wmh.99.1578651366594;
        Fri, 10 Jan 2020 02:16:06 -0800 (PST)
Received: from [192.168.86.34] (cpc89974-aztw32-2-0-cust43.18-1.cable.virginm.net. [86.30.250.44])
        by smtp.googlemail.com with ESMTPSA id q68sm1772493wme.14.2020.01.10.02.16.04
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 10 Jan 2020 02:16:04 -0800 (PST)
Subject: Re: [PATCH -next] nvmem: fix a 'makes pointer from integer without a
 cast' build warning
To:     Bartosz Golaszewski <brgl@bgdev.pl>,
        Linus Walleij <linus.walleij@linaro.org>,
        Khouloud Touil <ktouil@baylibre.com>,
        Stephen Rothwell <sfr@canb.auug.org.au>
Cc:     linux-kernel@vger.kernel.org,
        Bartosz Golaszewski <bgolaszewski@baylibre.com>,
        kbuild test robot <lkp@intel.com>
References: <20200110082441.8300-1-brgl@bgdev.pl>
From:   Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Message-ID: <ea048751-2a4a-31c9-0b46-849d77356a71@linaro.org>
Date:   Fri, 10 Jan 2020 10:16:03 +0000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <20200110082441.8300-1-brgl@bgdev.pl>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Thanks for the patch.

On 10/01/2020 08:24, Bartosz Golaszewski wrote:
> From: Bartosz Golaszewski <bgolaszewski@baylibre.com>
> 
> nvmem_register() returns a pointer, not a long int. Use ERR_CAST() to
> cast the struct gpio_desc pointer to struct nvmem_device.
> 
> Reported-by: kbuild test robot <lkp@intel.com>
> Fixes: 2a127da461a9 ("nvmem: add support for the write-protect pin")
> Signed-off-by: Bartosz Golaszewski <bgolaszewski@baylibre.com>
> ---

Acked-by: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>

>   drivers/nvmem/core.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/nvmem/core.c b/drivers/nvmem/core.c
> index 3e1c94c4eee8..408ce702347e 100644
> --- a/drivers/nvmem/core.c
> +++ b/drivers/nvmem/core.c
> @@ -351,7 +351,7 @@ struct nvmem_device *nvmem_register(const struct nvmem_config *config)
>   		nvmem->wp_gpio = gpiod_get_optional(config->dev, "wp",
>   						    GPIOD_OUT_HIGH);
>   	if (IS_ERR(nvmem->wp_gpio))
> -		return PTR_ERR(nvmem->wp_gpio);
> +		return ERR_CAST(nvmem->wp_gpio);
>   
>   
>   	kref_init(&nvmem->refcnt);
> 
