Return-Path: <SRS0=1210=4J=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2747BC35656
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Feb 2020 16:42:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F1FD924653
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Feb 2020 16:42:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="Z5vwtae1"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726773AbgBUQmj (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 21 Feb 2020 11:42:39 -0500
Received: from mail-wr1-f67.google.com ([209.85.221.67]:39463 "EHLO
        mail-wr1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726387AbgBUQmi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Feb 2020 11:42:38 -0500
Received: by mail-wr1-f67.google.com with SMTP id y11so2763274wrt.6
        for <linux-kernel@vger.kernel.org>; Fri, 21 Feb 2020 08:42:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=dU2FhZUg2nCekHubWuHKH9Qi01Tr3wAsi874rYY3BI8=;
        b=Z5vwtae1LsCNztwbIoExKjaWqzNs/h/oWnLldNPNgBEuLaJZaLgrERr0VI3ivLsJmb
         hc7nHMh/yNMDUb2h7uYOii6r04XrlNTY14jG/kRzfIhUJ/mVaYqibeawq5FNeYpvH4su
         aIOP3j3BLeXWHsdm8C561jaKIzzttgeoW7xKDrOmzUPAHsogqIimdULOucFzTbWr8rhN
         uW0h0UmYZqOS0dczW5jLvRMW8ZwyjACq1t/GnLI/UfiGFATr4Nw0J6Y62XGPL0HA2OQ4
         eNv/qEaSCv36XIelTbD5XG6qWcP5dvdxxy9fcbE1frMYhgVIBMdAEc4msYW1K0ud2khJ
         v0Zw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=dU2FhZUg2nCekHubWuHKH9Qi01Tr3wAsi874rYY3BI8=;
        b=GsKRUbf+TIxCf1IZcJRihNKltm4mhoDgHVxyTGFpRShCcQxeDZ4K0ssu+n9lZQOI5n
         mtfuTnl1RVtzS1VTjIMkxnMJ5Gs+D32ttDrbOrBoQmjR+3uyW/DJ44F3TzbcUz17HHcJ
         cgZNR/CnpfC+U1fGWhJsV1ez7rN6pkS5cveM8U+0B/iDMrDPGfhOi0JKe2ZGXoOancSk
         23jy1+SiWnPC83dW5bz9N79pCcsU1Fswgvvj06ZvTyfoNJeMOkLb1dxusBBIoeBlHdHl
         R8DB5P5DX0rzmE0BzLdScyzpLJEPHhEHC0XZjXvzS8/DFHkMoCzR5vQ4x1yK537SxevA
         O09g==
X-Gm-Message-State: APjAAAWk0xjH8JVl1akmXoIALF73nyyib1dML6Qu/2Kp1qZNSVSZXvA6
        z60IWCnQFOSQCQfb7htoWKeFEw==
X-Google-Smtp-Source: APXvYqzEW8eMMaKghIYJJvqFmuMwp40oiakJn3yx4aBzoUuiaoFVtdKXFaak7l01hmWSQmn3qzzK4Q==
X-Received: by 2002:adf:dd46:: with SMTP id u6mr47574637wrm.13.1582303356072;
        Fri, 21 Feb 2020 08:42:36 -0800 (PST)
Received: from [192.168.86.34] (cpc89974-aztw32-2-0-cust43.18-1.cable.virginm.net. [86.30.250.44])
        by smtp.googlemail.com with ESMTPSA id j15sm4709860wrp.9.2020.02.21.08.42.34
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 21 Feb 2020 08:42:35 -0800 (PST)
Subject: Re: [PATCH v5 1/5] nvmem: fix memory leak in error path
To:     Bartosz Golaszewski <brgl@bgdev.pl>,
        Linus Walleij <linus.walleij@linaro.org>,
        Khouloud Touil <ktouil@baylibre.com>,
        Geert Uytterhoeven <geert@linux-m68k.org>
Cc:     linux-gpio@vger.kernel.org, linux-kernel@vger.kernel.org,
        Bartosz Golaszewski <bgolaszewski@baylibre.com>
References: <20200221154837.18845-1-brgl@bgdev.pl>
 <20200221154837.18845-2-brgl@bgdev.pl>
From:   Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Message-ID: <39750efc-47e0-5711-2619-2a14cb4dbc65@linaro.org>
Date:   Fri, 21 Feb 2020 16:42:34 +0000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <20200221154837.18845-2-brgl@bgdev.pl>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 21/02/2020 15:48, Bartosz Golaszewski wrote:
> From: Bartosz Golaszewski <bgolaszewski@baylibre.com>
> 
> We need to free the ida mapping and nvmem struct if the write-protect
> GPIO lookup fails.
> 
> Fixes: 2a127da461a9 ("nvmem: add support for the write-protect pin")
> Signed-off-by: Bartosz Golaszewski <bgolaszewski@baylibre.com>


Applied this and 5/5

Thanks,
srini

> ---
>   drivers/nvmem/core.c | 8 ++++++--
>   1 file changed, 6 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/nvmem/core.c b/drivers/nvmem/core.c
> index 503da67dde06..2758d90d63b7 100644
> --- a/drivers/nvmem/core.c
> +++ b/drivers/nvmem/core.c
> @@ -353,8 +353,12 @@ struct nvmem_device *nvmem_register(const struct nvmem_config *config)
>   	else
>   		nvmem->wp_gpio = gpiod_get_optional(config->dev, "wp",
>   						    GPIOD_OUT_HIGH);
> -	if (IS_ERR(nvmem->wp_gpio))
> -		return ERR_CAST(nvmem->wp_gpio);
> +	if (IS_ERR(nvmem->wp_gpio)) {
> +		ida_simple_remove(&nvmem_ida, nvmem->id);
> +		rval = PTR_ERR(nvmem->wp_gpio);
> +		kfree(nvmem);
> +		return ERR_PTR(rval);
> +	}
>   
>   	kref_init(&nvmem->refcnt);
>   	INIT_LIST_HEAD(&nvmem->cells);
> 
