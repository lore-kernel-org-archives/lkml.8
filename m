Return-Path: <SRS0=kGB5=CE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.5 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,NICE_REPLY_A,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5B11BC433DF
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Aug 2020 19:57:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2CA81207BC
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Aug 2020 19:57:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="T5C+bXP9"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727103AbgHZT5x (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 26 Aug 2020 15:57:53 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:23760 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1727050AbgHZT5t (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Aug 2020 15:57:49 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1598471868;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=DXuqJrwfbCwnI98H5NI02hcjDkuIvuf4O5Gqzi6vDmc=;
        b=T5C+bXP9yTkp0VGZqwi6N7EooR2fkreYYa71jlYsWaKfXbCfRJIa28++RVi5+W2xINswhc
        /do7x372nJKTa4LKK51bgnfo3dVzCl6rT11hJlR/gFrhG9tfvAztPksAlrVUxYFo0HuXkO
        1u1U9kMOovWBI49AEZSvAWB+XnYuaCY=
Received: from mail-ed1-f70.google.com (mail-ed1-f70.google.com
 [209.85.208.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-550-a4V4BgvVPmew4ejly-wZVg-1; Wed, 26 Aug 2020 15:57:46 -0400
X-MC-Unique: a4V4BgvVPmew4ejly-wZVg-1
Received: by mail-ed1-f70.google.com with SMTP id c3so1087075edm.7
        for <linux-kernel@vger.kernel.org>; Wed, 26 Aug 2020 12:57:45 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=DXuqJrwfbCwnI98H5NI02hcjDkuIvuf4O5Gqzi6vDmc=;
        b=r20ROUM7hE/+Uftp9soK9SHH0IPQNOTAU7mrwHMYrZzmyXgPSiFGjv51rLGGguzBBx
         YeBvySt6y620KEV1qViMRL0XJkndlwRB6svHDRUp4JREDnkQp0NfRYoMIWRiDdukxQVZ
         8AHS8zDApt4c3fdfp8dwNLAbExKwv2eFHHBjN/e/aXTyvBeUG0sELrXAqBtAJqhUVf/W
         V53YkgvmDdYadBPZ0O+1rrslOsuW3sgwMw3K8FMgOqAPU5BYarJPjPOaVQHf6yLwry/p
         x8+SG0UjFZR6XSNbLmasuS2/iz1Rb1TVReSdXNNHAuWys0q/twaiFXB70nzOwPTFlmTf
         4ykg==
X-Gm-Message-State: AOAM5334gU4x+3y/Kqnfxf0mPSd0Fd+3E2kn3wOHk4mQCbEwZQVgUd8d
        08QnaxzKjf6a08zLlHcPAdma0hrgFG/G0+3Ju0ObEgGfivvXE5vnO57j5iNIkc8sDCPTVwksFaU
        vmAl75/ZGTy8E5Py5bW6RfGA6
X-Received: by 2002:a17:906:c146:: with SMTP id dp6mr14384794ejc.38.1598471864818;
        Wed, 26 Aug 2020 12:57:44 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJymm84HHrEaEJR60+VZu48mdqNVVXAmjgsvlGr83z6u0tjMLua+wnc0FDeay9ZxJELtATkZ8g==
X-Received: by 2002:a17:906:c146:: with SMTP id dp6mr14384775ejc.38.1598471864635;
        Wed, 26 Aug 2020 12:57:44 -0700 (PDT)
Received: from x1.localdomain (2001-1c00-0c0c-fe00-d2ea-f29d-118b-24dc.cable.dynamic.v6.ziggo.nl. [2001:1c00:c0c:fe00:d2ea:f29d:118b:24dc])
        by smtp.gmail.com with ESMTPSA id qk7sm3204480ejb.17.2020.08.26.12.57.43
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 26 Aug 2020 12:57:43 -0700 (PDT)
Subject: Re: [PATCH 01/24] Input: bcm-keypad - Simplify with dev_err_probe()
To:     Krzysztof Kozlowski <krzk@kernel.org>,
        Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        Bastien Nocera <hadess@hadess.net>,
        Sangwon Jee <jeesw@melfas.com>,
        Eugen Hristev <eugen.hristev@microchip.com>,
        "Gustavo A. R. Silva" <gustavoars@kernel.org>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        linux-input@vger.kernel.org, linux-kernel@vger.kernel.org,
        platform-driver-x86@vger.kernel.org
References: <20200826181706.11098-1-krzk@kernel.org>
From:   Hans de Goede <hdegoede@redhat.com>
Message-ID: <858aaca7-5648-83a0-6cb4-213c62fee4a6@redhat.com>
Date:   Wed, 26 Aug 2020 21:57:43 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20200826181706.11098-1-krzk@kernel.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

As someone who has added the if (error != -EPROBE_DEFER) dev_err()
pattern in way too many places myself, I'm quite happy to see this
new (I presume?) helper and this nice cleanup series.

The entire series looks good to me, and you can add my:

Reviewed-by: Hans de Goede <hdegoede@redhat.com>

To the entire series.

Regards,

Hans



On 8/26/20 8:16 PM, Krzysztof Kozlowski wrote:
> Common pattern of handling deferred probe can be simplified with
> dev_err_probe().  Less code and also it prints the error value.
> 
> Signed-off-by: Krzysztof Kozlowski <krzk@kernel.org>
> ---
>   drivers/input/keyboard/bcm-keypad.c | 8 +++-----
>   1 file changed, 3 insertions(+), 5 deletions(-)
> 
> diff --git a/drivers/input/keyboard/bcm-keypad.c b/drivers/input/keyboard/bcm-keypad.c
> index 2b771c3a5578..1bf71e7c9e0d 100644
> --- a/drivers/input/keyboard/bcm-keypad.c
> +++ b/drivers/input/keyboard/bcm-keypad.c
> @@ -379,11 +379,9 @@ static int bcm_kp_probe(struct platform_device *pdev)
>   	kp->clk = devm_clk_get(&pdev->dev, "peri_clk");
>   	if (IS_ERR(kp->clk)) {
>   		error = PTR_ERR(kp->clk);
> -		if (error != -ENOENT) {
> -			if (error != -EPROBE_DEFER)
> -				dev_err(&pdev->dev, "Failed to get clock\n");
> -			return error;
> -		}
> +		if (error != -ENOENT)
> +			return dev_err_probe(&pdev->dev, error, "Failed to get clock\n");
> +
>   		dev_dbg(&pdev->dev,
>   			"No clock specified. Assuming it's enabled\n");
>   		kp->clk = NULL;
> 

