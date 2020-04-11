Return-Path: <SRS0=xbEg=53=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6EBCCC2BB86
	for <linux-kernel@archiver.kernel.org>; Sat, 11 Apr 2020 01:32:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4161520787
	for <linux-kernel@archiver.kernel.org>; Sat, 11 Apr 2020 01:32:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="S/eCNosL"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726791AbgDKBcr (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 10 Apr 2020 21:32:47 -0400
Received: from mail-pg1-f195.google.com ([209.85.215.195]:45271 "EHLO
        mail-pg1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726641AbgDKBcr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Apr 2020 21:32:47 -0400
Received: by mail-pg1-f195.google.com with SMTP id w11so1682772pga.12;
        Fri, 10 Apr 2020 18:32:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:subject:to:cc:references:from:autocrypt:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=e4zi8LwNA/UXYoau/TjMCALU61pg2IXev+OrCC4j0GE=;
        b=S/eCNosLzrWUxCPcXxm8zYDUasRZSO0+RB1k2xlQVTnCLXO9aVk3BXKk2B2Y7cWdCz
         4aQB7QbJ+03qEbI4lbagB/N0JuNheFptvvSdszNZo4dN3B3l5wrAkI9YuqHQ5W4v8DOy
         PGgiJ/yWaWY+KUpwERZ215DPb8wIuZijnklRHYvCwK7Dk+ROx54BitICPBaNmNqOL5rp
         R8KbgRk0DGaapP8GYDm/YTzdl8BqyUBjyXufcntMWFi7oLZwGs4juZ208c9/HGcu550A
         qMrpQr0SqwRhPQy6wdT8m8ZZ4bl/W4zgOVBkAJus/WtilB+roIWize+uq7XbDkVHulBJ
         OZUg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:subject:to:cc:references:from:autocrypt
         :message-id:date:user-agent:mime-version:in-reply-to
         :content-language:content-transfer-encoding;
        bh=e4zi8LwNA/UXYoau/TjMCALU61pg2IXev+OrCC4j0GE=;
        b=JDe1nMiD2uEhf/F7JUy0FR7o8OPYrgGX6T745jDm8hIG1Umn5Dn5HOZAu8l2I0zdTc
         LctfXn3Byw9x0rAJPtU4WP7MZaQTutUx4oiTRzBBley4pVAFaJRHN1Xmv29VBQkKOIyB
         mWJss5FT3eyf9U66dOEMpvkiwzcFbnH3zFerxgURQRktnVBe4z8lA0zZB3iU6g/8QjGJ
         WC2L63CF4Ws7o/aIngLdZh8y6MjXn+HGm+LPItQAnxbcmfxwTyEHDJW8GtXvNxUhiQ6v
         Yhch8To6l20YnHK2uurKeXI9l6O+KNyBjf5EOo/H//C2fTtdl+TaWn0hVA2UA5GUZ7rL
         eKHQ==
X-Gm-Message-State: AGi0PubqzQcM43DMu83TWac5pbi4PVYMNmFBucPNzAC6i/T+Bt7jcxP3
        fR/sjTmoO32ykMQM3CaUxacLZgfL
X-Google-Smtp-Source: APiQypL6SBE7seiKjUBWKhDkxPeQ+jQcYm+rr7TL/O/lwINkEBRct0mzYY5GyqX7icB2NOjma/KmfA==
X-Received: by 2002:a63:f13:: with SMTP id e19mr6773567pgl.135.1586568763842;
        Fri, 10 Apr 2020 18:32:43 -0700 (PDT)
Received: from server.roeck-us.net ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id w134sm2913695pfd.41.2020.04.10.18.32.42
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 10 Apr 2020 18:32:43 -0700 (PDT)
Subject: Re: [PATCH 1/6] thermal: hwmon: Replace the call the
 thermal_cdev_update()
To:     Daniel Lezcano <daniel.lezcano@linaro.org>, rui.zhang@intel.com
Cc:     amit.kucheria@verdurent.com, linux-kernel@vger.kernel.org,
        Kamil Debski <kamil@wypas.org>,
        Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>,
        Jean Delvare <jdelvare@suse.com>,
        "open list:PWM FAN DRIVER" <linux-hwmon@vger.kernel.org>
References: <20200410221236.6484-1-daniel.lezcano@linaro.org>
 <20200410221236.6484-2-daniel.lezcano@linaro.org>
From:   Guenter Roeck <linux@roeck-us.net>
Autocrypt: addr=linux@roeck-us.net; keydata=
 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
 mDW4+i+XlNFUPUYMrIKi9joBhu18ssf5i5Q=
Message-ID: <4ded7975-499d-024a-283f-de4f82d295f3@roeck-us.net>
Date:   Fri, 10 Apr 2020 18:32:42 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.1
MIME-Version: 1.0
In-Reply-To: <20200410221236.6484-2-daniel.lezcano@linaro.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 4/10/20 3:12 PM, Daniel Lezcano wrote:
> The function thermal_cdev_upadte is called from the throttling

misspelled

> functions in the governors not from the cooling device itself.
> 
> The cooling device is set to its maximum state and then updated. Even
> if I don't get the purpose of probing the pwm-fan to its maximum
> cooling state, we can replace the thermal_cdev_update() call to the
> internal set_cur_state() function directly.
> 
> Signed-off-by: Daniel Lezcano <daniel.lezcano@linaro.org>
> ---
>  drivers/hwmon/pwm-fan.c | 3 +--
>  1 file changed, 1 insertion(+), 2 deletions(-)
> 
> diff --git a/drivers/hwmon/pwm-fan.c b/drivers/hwmon/pwm-fan.c
> index 30b7b3ea8836..a654ecdf21ab 100644
> --- a/drivers/hwmon/pwm-fan.c
> +++ b/drivers/hwmon/pwm-fan.c
> @@ -372,7 +372,6 @@ static int pwm_fan_probe(struct platform_device *pdev)
>  	if (ret)
>  		return ret;
>  
> -	ctx->pwm_fan_state = ctx->pwm_fan_max_state;
>  	if (IS_ENABLED(CONFIG_THERMAL)) {
>  		cdev = devm_thermal_of_cooling_device_register(dev,
>  			dev->of_node, "pwm-fan", ctx, &pwm_fan_cooling_ops);
> @@ -384,7 +383,7 @@ static int pwm_fan_probe(struct platform_device *pdev)
>  			return ret;
>  		}
>  		ctx->cdev = cdev;
> -		thermal_cdev_update(cdev);
> +		pwm_fan_set_cur_state(cdev, ctx->pwm_fan_max_state);

So far the function would only change the state if the new
state is not equal to the old state. This was the case because
pwm_fan_state was set to pwm_fan_max_state, and the call to
thermal_cdev_update() and thus pwm_fan_set_cur_state() would
do nothing except update statistics. The old code _assumed_
that the current state is pwm_fan_max_state. The new code
enforces it. That is a substantial semantic change, and it
is not really reflected in the commit message. Is that really
what you want ? If so, the commit message needs to state that
and explain the rationale.

Thanks,
Guenter

>  	}
>  
>  	return 0;
> 

