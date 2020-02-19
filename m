Return-Path: <SRS0=ZTvs=4H=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 791A4C34047
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Feb 2020 10:52:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4A62A2464E
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Feb 2020 10:52:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="J4R47UwD"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726773AbgBSKwY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 19 Feb 2020 05:52:24 -0500
Received: from mail-wr1-f67.google.com ([209.85.221.67]:44311 "EHLO
        mail-wr1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726469AbgBSKwX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Feb 2020 05:52:23 -0500
Received: by mail-wr1-f67.google.com with SMTP id m16so27603984wrx.11
        for <linux-kernel@vger.kernel.org>; Wed, 19 Feb 2020 02:52:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=lt0NY5ib1Jfzy6tElePJc/SbaXVWZpjySCmieUMPpiA=;
        b=J4R47UwDGmz+YjGbKXDX5CSCOZO416NJh6ZdqrxFKG3dhVEUsE3rOv1EF8B+Y0iK3q
         bsAwG3EeaVeX+IyXwpE7L/9wnR807IGNztzxmqCG+FpwrRKwiqUCnGtY5lsp9rM3tizK
         symTQZXecIKJZdkEExDae2REdzOidfh6IJH2KAITdcgOK0E2OT+I/V0FjmI2CZkhmPZk
         HsWCrOE44uICeo36LlKHQkB26Bm0LnJRpKN41aLb4wxAmzemJ9M55qSaNKWKA2PQ0I8y
         fgocye9J0gLkdY02OJ8zNS3SBSK/6saMb2e/ypV11YVYGCbhZ9jejZUJWEMsgpX7HbJz
         eICA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=lt0NY5ib1Jfzy6tElePJc/SbaXVWZpjySCmieUMPpiA=;
        b=jijFRG8g6CmwZWx8ED1Arfu2prmtvFOJ9wfwhY9JqYI/6K4oGB1xn3u1ZAA2VCQ5WM
         qXM8+hSDnx+yXOG8o9/YPIE6Mjeg2wUSwJTxUw0WRse0e1f6TplnJS/CFzTCC/ZuQIIB
         ObR+wF1gVAGHQrSMv+6D7aBw9Q8G8uLXYAvQXgG5rwOpVFvwqV7notg+UeWzo9i4zPQs
         GanNSZ2FbR4oLIZ8+86LSHBQn8d/VCnTJf0RFJKvf0DiGG2678GsHIzVXrGaL6TmGmDD
         PA5My1NVt1vwtCTFZO8G50pKTa+ES04l3oDxaleHCN3EBP4+GZY0/bbfHGlcK7FsM80z
         S2Sw==
X-Gm-Message-State: APjAAAVbbBQPVP9PP43p3o35yfJvneT18Z0cyc8ThGx7V11Xn3vSllIp
        zMLgBA9adxgxuAZ0dk9AXdmxeA==
X-Google-Smtp-Source: APXvYqxaU/hV+JRB683FKtQ1VLsdZn0+2CYY0PgX0KgoVd13wMkS8esIg98BvQAndfE6+8aniFhDyw==
X-Received: by 2002:a5d:5381:: with SMTP id d1mr34595050wrv.259.1582109542207;
        Wed, 19 Feb 2020 02:52:22 -0800 (PST)
Received: from [192.168.86.34] (cpc89974-aztw32-2-0-cust43.18-1.cable.virginm.net. [86.30.250.44])
        by smtp.googlemail.com with ESMTPSA id z133sm2623662wmb.7.2020.02.19.02.52.21
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 19 Feb 2020 02:52:21 -0800 (PST)
Subject: Re: [PATCH v3 1/7] nvmem: fix memory leak in error path
To:     Bartosz Golaszewski <brgl@bgdev.pl>,
        Linus Walleij <linus.walleij@linaro.org>,
        Khouloud Touil <ktouil@baylibre.com>,
        Geert Uytterhoeven <geert@linux-m68k.org>
Cc:     linux-gpio@vger.kernel.org, linux-kernel@vger.kernel.org,
        Bartosz Golaszewski <bgolaszewski@baylibre.com>
References: <20200219092218.18143-1-brgl@bgdev.pl>
 <20200219092218.18143-2-brgl@bgdev.pl>
From:   Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Message-ID: <e1882a57-5a54-b94e-aa0d-3515c671bc3f@linaro.org>
Date:   Wed, 19 Feb 2020 10:52:20 +0000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <20200219092218.18143-2-brgl@bgdev.pl>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 19/02/2020 09:22, Bartosz Golaszewski wrote:
> From: Bartosz Golaszewski<bgolaszewski@baylibre.com>
> 
> We need to free the ida mapping and nvmem struct if the write-protect
> GPIO lookup fails.
> 
> Fixes: 2a127da461a9 ("nvmem: add support for the write-protect pin")
> Signed-off-by: Bartosz Golaszewski<bgolaszewski@baylibre.com>
> ---
>   drivers/nvmem/core.c | 7 +++++--
>   1 file changed, 5 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/nvmem/core.c b/drivers/nvmem/core.c
> index ef326f243f36..89974e40d250 100644
> --- a/drivers/nvmem/core.c
> +++ b/drivers/nvmem/core.c
> @@ -352,8 +352,11 @@ struct nvmem_device *nvmem_register(const struct nvmem_config *config)
>   	else
>   		nvmem->wp_gpio = gpiod_get_optional(config->dev, "wp",
>   						    GPIOD_OUT_HIGH);
> -	if (IS_ERR(nvmem->wp_gpio))
> -		return ERR_CAST(nvmem->wp_gpio);
> +	if (IS_ERR(nvmem->wp_gpio)) {
> +		ida_simple_remove(&nvmem_ida, nvmem->id);
> +		kfree(nvmem);
> +		return ERR_PTR(rval);

Why are you returning rval here?
This points return value of ida_simple_get and not the actual error code 
from wp_gpio.

--srini

> +	}
