Return-Path: <SRS0=NukP=4I=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 84628C11D04
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Feb 2020 12:05:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 502A9208C4
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Feb 2020 12:05:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="x63miHRi"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727789AbgBTMFv (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 20 Feb 2020 07:05:51 -0500
Received: from mail-wr1-f68.google.com ([209.85.221.68]:44194 "EHLO
        mail-wr1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727298AbgBTMFv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Feb 2020 07:05:51 -0500
Received: by mail-wr1-f68.google.com with SMTP id m16so4295256wrx.11
        for <linux-kernel@vger.kernel.org>; Thu, 20 Feb 2020 04:05:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=Z0vvlPPE+vtUh7ARyCdvaIb9a1HOM3y7M504uXCh/wc=;
        b=x63miHRikl8gYWEUkXxSkAwph1c9LntSaX7SnxaRAWsno52GtGklGstN18OM8xPQWs
         lYueTvr3Dzz87f+dW2+FqRwnFFLzFc+wqP3wSr0rzhThXZBqshbtHsgKCAvZIQ05ok/n
         6IjcQbtM2uCd9/nBUu/v1DHfGLIpjgb7l8cZi5BgzU6NXF+ZNuzIGdfHImVXm3Ud1LXN
         mAaqjrKFx7tpIUieP0R5STbF/SlwocIr9iBl5pNdBLEFZPDH7Z/FsJssZmVBBQlEy0Ob
         eKJKhWEFYR8GLgB4LPkBeYNQIT+tDsbXY/90sel+i3OWViAIZm+IGCDsiyV4AJy+bsvx
         3Yyg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=Z0vvlPPE+vtUh7ARyCdvaIb9a1HOM3y7M504uXCh/wc=;
        b=lSrJwfjg2OQobVXSr38VBYlNj4Ly9ZdaLovv6vkNA7dcCpWF4gTHJKn1ztml2dv0Yk
         9GnLk76PoZTBw/wKMldc6BROo0EDecpVW78TDrYES0rXdVrgmGm+5mQXFT3ht1m9A/Dk
         /JFPtR4DbPV4xV3ST/s7fDp3o9dEYfyiIpH40u9Ydt3Zy5o9U5FzQb0hPpCxf3avK2SD
         4d8QCu13DMD4Ogn1aMetiB68FUOJxTK1TCCputujHp8q5O6cY1baqbVa/T43dZV+83xr
         v1m2v0UlYkqj73ju+1vO8SFm87MmL95EX3OJTK8olCK8JsWrn61BwhKyaa/udoLYJEe1
         iW7Q==
X-Gm-Message-State: APjAAAU45wI1QlmjZjzNlCCS3gpQO8WRlzEzZXJ5GZzS+0TStHwpmsgD
        O3xFbkz4LkRP8ineubBMCRxX0HdIyVo=
X-Google-Smtp-Source: APXvYqyB+oY/ge35t24bXWV6fvPSUKYqtt6iPcklGzSbb5LpcwrwIDdwymH2LuyKdlA9YKxVNh/WsQ==
X-Received: by 2002:adf:ec0d:: with SMTP id x13mr41779387wrn.400.1582200350410;
        Thu, 20 Feb 2020 04:05:50 -0800 (PST)
Received: from [192.168.86.34] (cpc89974-aztw32-2-0-cust43.18-1.cable.virginm.net. [86.30.250.44])
        by smtp.googlemail.com with ESMTPSA id v16sm4084878wml.11.2020.02.20.04.05.49
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 20 Feb 2020 04:05:49 -0800 (PST)
Subject: Re: [PATCH v4 2/4] gpiolib: use kref in gpio_desc
To:     Bartosz Golaszewski <brgl@bgdev.pl>,
        Linus Walleij <linus.walleij@linaro.org>,
        Khouloud Touil <ktouil@baylibre.com>,
        Geert Uytterhoeven <geert@linux-m68k.org>
Cc:     linux-gpio@vger.kernel.org, linux-kernel@vger.kernel.org,
        Bartosz Golaszewski <bgolaszewski@baylibre.com>
References: <20200220100141.5905-1-brgl@bgdev.pl>
 <20200220100141.5905-3-brgl@bgdev.pl>
From:   Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Message-ID: <5970b17a-b29b-154f-033e-6da007d6a289@linaro.org>
Date:   Thu, 20 Feb 2020 12:05:48 +0000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <20200220100141.5905-3-brgl@bgdev.pl>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 20/02/2020 10:01, Bartosz Golaszewski wrote:
> --- a/drivers/gpio/gpiolib.c
> +++ b/drivers/gpio/gpiolib.c
> @@ -2798,6 +2798,8 @@ static int gpiod_request_commit(struct gpio_desc *desc, const char *label)
>   		goto done;
>   	}
>   
> +	kref_init(&desc->ref);
> +

Should we not decrement refcount on the error path of this function?

--srini

>   	if (chip->request) {
>   		/* chip->request may sleep */
>   		spin_unlock_irqrestore(&gpio_lock, flags);
> @@ -2933,6 +2935,13 @@ void gpiod_free(struct gpio_desc *desc)
>   	}
>   }
