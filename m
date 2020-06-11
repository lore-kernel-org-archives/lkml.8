Return-Path: <SRS0=NqQd=7Y=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A0039C433E1
	for <linux-kernel@archiver.kernel.org>; Thu, 11 Jun 2020 13:48:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 633E8206C3
	for <linux-kernel@archiver.kernel.org>; Thu, 11 Jun 2020 13:48:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="SLDm7Bhy"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726444AbgFKNsC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 11 Jun 2020 09:48:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53590 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726109AbgFKNsB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 11 Jun 2020 09:48:01 -0400
Received: from mail-pl1-x643.google.com (mail-pl1-x643.google.com [IPv6:2607:f8b0:4864:20::643])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 62162C03E96F;
        Thu, 11 Jun 2020 06:48:01 -0700 (PDT)
Received: by mail-pl1-x643.google.com with SMTP id d8so2334738plo.12;
        Thu, 11 Jun 2020 06:48:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:subject:to:cc:references:from:autocrypt:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=pgWnGYzRHIcnS1DH21zZ8RbB2zYK6ezsDQzVEWjcEPA=;
        b=SLDm7Bhy5bO19am7bCj5SCoXIXMiMTC9QK24iE1Bu/wlBexkgW5YDEeHOnlptMS65o
         CtGAX+ErULopyUAGrTkwzA434YUOoiG6Ava3CzkRcU+59ic3Bhjqjmw8nJqVHw/1aWPy
         h/2HrgChJHB07u/dc0koqL+UoNPGq0lryr7M1wEXbdZOE3qzUAQK6IsdjXgH4TQQbmFn
         vyj4qw/U2uEdmuTGDF6usCjty+57Lnat15pX0IQCRxjIyKva9k/Xm04rfq7xv8d2YZGv
         3+6ttdKcSVvp0TgwFEon5XPB8EwZfHyvbOz8odjETbFmiT8z8VYeML4O8XUQxJBQqXx5
         c6TA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:subject:to:cc:references:from:autocrypt
         :message-id:date:user-agent:mime-version:in-reply-to
         :content-language:content-transfer-encoding;
        bh=pgWnGYzRHIcnS1DH21zZ8RbB2zYK6ezsDQzVEWjcEPA=;
        b=cOhK1gi7QBorNzLkz1mv84qXxN6EC1giJe8tlDKYjeIfUEfFP2hhD8kA0pD9ZzSf25
         Y2rpJeg2lGblYKoIOtQe7yfRv8GxGzxj3GzEfMjO2kvNMgLVTjonJnS4aeZ93EMlDOmw
         vQ1Ro5lmpPgdPaPnFHSioPVMFAwj0ESPxJVvIgto20Jtlz6iVD/EWYUnoLnfXUG9uKJ8
         37uhmZIv4R8XxDzejOgpvtEuIUyBk8CCYQ7WRlyByUe6G0l4ixbk18syDZz2Nuaihuwu
         xOvZRrnlM+Pvh0fpLTuPhJtDs5M7ceT8DxJjtMhVr1QW+jChNsJwiIPXiMKIwQFCVBZI
         LO0w==
X-Gm-Message-State: AOAM531BkjOjS4A8n0q1t9rCax4ofk+dw2Jn2TZZbRKVtzGxpwWvjmhB
        60f5JkM8ZcsfYsCskfPt0tkCTa6s
X-Google-Smtp-Source: ABdhPJy3RTTX3VtL6mjC7qqCq2hrQYOpWtQ7Lzr9csxNr/R6hjZh+zDIADGA0BaqDxA6DZoymGDJ8w==
X-Received: by 2002:a17:902:bb85:: with SMTP id m5mr7070772pls.23.1591883280441;
        Thu, 11 Jun 2020 06:48:00 -0700 (PDT)
Received: from server.roeck-us.net ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id s36sm2880958pgl.35.2020.06.11.06.47.58
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 11 Jun 2020 06:47:59 -0700 (PDT)
Subject: Re: [PATCH 2/2] hwmon: (gsc): add 16bit pre-scaled voltage mode
To:     Tim Harvey <tharvey@gateworks.com>,
        Rob Herring <robh+dt@kernel.org>,
        Jean Delvare <jdelvare@suse.com>
Cc:     Lee Jones <lee.jones@linaro.org>,
        Robert Jones <rjones@gateworks.com>,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-hwmon@vger.kernel.org
References: <1591714640-10332-1-git-send-email-tharvey@gateworks.com>
 <1591714640-10332-3-git-send-email-tharvey@gateworks.com>
From:   Guenter Roeck <linux@roeck-us.net>
Autocrypt: addr=linux@roeck-us.net; keydata=
 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
 mDW4+i+XlNFUPUYMrIKi9joBhu18ssf5i5Q=
Message-ID: <5ec904cf-d950-6214-e0b3-65b229402ba1@roeck-us.net>
Date:   Thu, 11 Jun 2020 06:47:58 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
MIME-Version: 1.0
In-Reply-To: <1591714640-10332-3-git-send-email-tharvey@gateworks.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 6/9/20 7:57 AM, Tim Harvey wrote:
> add a 16-bit pre-scaled voltage mode to adc and clarify that existing
> pre-scaled mode is 24bit.
> 
> Signed-off-by: Tim Harvey <tharvey@gateworks.com>

For my reference:

Reviewed-by: Guenter Roeck <linux@roeck-us.net>

We'll have to wait for DT approval.

Guenter

> ---
>  drivers/hwmon/gsc-hwmon.c               | 8 +++++---
>  include/linux/platform_data/gsc_hwmon.h | 3 ++-
>  2 files changed, 7 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/hwmon/gsc-hwmon.c b/drivers/hwmon/gsc-hwmon.c
> index 2137bc6..3dfe2ca 100644
> --- a/drivers/hwmon/gsc-hwmon.c
> +++ b/drivers/hwmon/gsc-hwmon.c
> @@ -159,7 +159,7 @@ gsc_hwmon_read(struct device *dev, enum hwmon_sensor_types type, u32 attr,
>  		return -EOPNOTSUPP;
>  	}
>  
> -	sz = (ch->mode == mode_voltage) ? 3 : 2;
> +	sz = (ch->mode == mode_voltage_24bit) ? 3 : 2;
>  	ret = regmap_bulk_read(hwmon->regmap, ch->reg, buf, sz);
>  	if (ret)
>  		return ret;
> @@ -186,7 +186,8 @@ gsc_hwmon_read(struct device *dev, enum hwmon_sensor_types type, u32 attr,
>  		/* adjust by uV offset */
>  		tmp += ch->mvoffset;
>  		break;
> -	case mode_voltage:
> +	case mode_voltage_24bit:
> +	case mode_voltage_16bit:
>  		/* no adjustment needed */
>  		break;
>  	}
> @@ -336,7 +337,8 @@ static int gsc_hwmon_probe(struct platform_device *pdev)
>  						     HWMON_T_LABEL;
>  			i_temp++;
>  			break;
> -		case mode_voltage:
> +		case mode_voltage_24bit:
> +		case mode_voltage_16bit:
>  		case mode_voltage_raw:
>  			if (i_in == GSC_HWMON_MAX_IN_CH) {
>  				dev_err(gsc->dev, "too many input channels\n");
> diff --git a/include/linux/platform_data/gsc_hwmon.h b/include/linux/platform_data/gsc_hwmon.h
> index ec1611a..37a8f554d 100644
> --- a/include/linux/platform_data/gsc_hwmon.h
> +++ b/include/linux/platform_data/gsc_hwmon.h
> @@ -4,8 +4,9 @@
>  
>  enum gsc_hwmon_mode {
>  	mode_temperature,
> -	mode_voltage,
> +	mode_voltage_24bit,
>  	mode_voltage_raw,
> +	mode_voltage_16bit,
>  	mode_max,
>  };
>  
> 

