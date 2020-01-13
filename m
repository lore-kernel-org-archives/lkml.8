Return-Path: <SRS0=WByN=3C=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CF56EC33CAF
	for <linux-kernel@archiver.kernel.org>; Mon, 13 Jan 2020 10:48:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9CB7A20661
	for <linux-kernel@archiver.kernel.org>; Mon, 13 Jan 2020 10:48:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Pw7hqJKx"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728748AbgAMKsl (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 13 Jan 2020 05:48:41 -0500
Received: from us-smtp-1.mimecast.com ([205.139.110.61]:24310 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726109AbgAMKsl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Jan 2020 05:48:41 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1578912519;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=aa4HX84hAhpIknxyck8cItGKlnCo160P9lSeifojd4I=;
        b=Pw7hqJKxUHHVf1tmILm4pso94Y46UstrHxGeLF5Fwwb0btv+5RRQvozquX6VSRZj1fo1Zb
        eUHovQ3kly4o0L/1DuB3aWbv/9YtFYCHY976ca8X1xLTZGM/xrjSYu+MCF8HLMACMuW6jP
        BXNkJSPm2kt+z8GJkOhYalZ3uHooEWg=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-234-TFB8nvnTNcegc9SYAWGbRQ-1; Mon, 13 Jan 2020 05:48:38 -0500
X-MC-Unique: TFB8nvnTNcegc9SYAWGbRQ-1
Received: by mail-wm1-f69.google.com with SMTP id w205so2384063wmb.5
        for <linux-kernel@vger.kernel.org>; Mon, 13 Jan 2020 02:48:38 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=aa4HX84hAhpIknxyck8cItGKlnCo160P9lSeifojd4I=;
        b=iuhK8ZC0L9IQXFCxu0aXYTkp4XiaqFJV9DboBiGnKYEHB1OXppMc5DkZFjBDUbR+Op
         TUhfcPbNzDLCP+4JMC6l3/ypODy3bmiZY96LkIN8/aU9UXryLr+dCYtS33D0+3glTjUU
         HmbB4qKcfoyPzCssvR325S4cejRA4tToYj5V76WCuGM5s/tNtRDoiFWod2KqdH/xf8bd
         EBdySORl5OESx63HU9VnvBQjy4eA1a9vzRhLM6quBPb3q4f78BQZxvXOq9fDzunEIEIn
         MI/ieHJn1wtVZqbTPUtacxJ7eivgd8y9VtfV5+t/q0D6s3Waif8sdzd3CkrHy+wCxt8m
         QcJQ==
X-Gm-Message-State: APjAAAWlPNQSW6Sl9/bbg1NCOzZA3RzEUnNmRj4dN+J51ENl28GrSa1m
        ExO8l3KQW7U3BHvlOkcUKX2X5Dgs4HZLI87sdRM6KIeABKV9uWahMONvlWKmwLGE0t0REhui73f
        T8nkEMcNCV8bJg920A+L2v2as
X-Received: by 2002:a05:600c:2301:: with SMTP id 1mr20201096wmo.147.1578912517301;
        Mon, 13 Jan 2020 02:48:37 -0800 (PST)
X-Google-Smtp-Source: APXvYqwKENwunxCdMWeG76eu+rMyEWGpQTWLzeQekZOw+tDy7yAhORK6tXXWFIWoyp/n8k8zUDPnRA==
X-Received: by 2002:a05:600c:2301:: with SMTP id 1mr20201081wmo.147.1578912517114;
        Mon, 13 Jan 2020 02:48:37 -0800 (PST)
Received: from shalem.localdomain (2001-1c00-0c0c-fe00-7e79-4dac-39d0-9c14.cable.dynamic.v6.ziggo.nl. [2001:1c00:c0c:fe00:7e79:4dac:39d0:9c14])
        by smtp.gmail.com with ESMTPSA id o129sm13871135wmb.1.2020.01.13.02.48.35
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 13 Jan 2020 02:48:35 -0800 (PST)
Subject: Re: [PATCH 2/3] Input: axp20x-pek - Respect userspace wakeup
 configuration
To:     Samuel Holland <samuel@sholland.org>,
        Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        Chen-Yu Tsai <wens@csie.org>
Cc:     linux-input@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-sunxi@googlegroups.com
References: <20200113032032.38709-1-samuel@sholland.org>
 <20200113032032.38709-2-samuel@sholland.org>
From:   Hans de Goede <hdegoede@redhat.com>
Message-ID: <84e9f44e-81e1-ab3d-3dd0-08388951b074@redhat.com>
Date:   Mon, 13 Jan 2020 11:48:35 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.3.1
MIME-Version: 1.0
In-Reply-To: <20200113032032.38709-2-samuel@sholland.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On 13-01-2020 04:20, Samuel Holland wrote:
> Unlike most other power button drivers, this driver unconditionally
> enables its wakeup IRQ. It should be using device_may_wakeup() to
> respect the userspace configuration of wakeup sources.
> 
> Because the AXP20x MFD device uses regmap-irq, the AXP20x PEK IRQs are
> nested off of regmap-irq's threaded interrupt handler. The device core
> ignores such interrupts, so to actually disable wakeup, we must
> explicitly disable all non-wakeup interrupts during suspend.
> 
> Signed-off-by: Samuel Holland <samuel@sholland.org>
> ---
>   drivers/input/misc/axp20x-pek.c | 42 ++++++++++++++++++++++++++++++++-
>   1 file changed, 41 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/input/misc/axp20x-pek.c b/drivers/input/misc/axp20x-pek.c
> index 7d0ee5bececb..38cd4a4aeb65 100644
> --- a/drivers/input/misc/axp20x-pek.c
> +++ b/drivers/input/misc/axp20x-pek.c
> @@ -280,7 +280,7 @@ static int axp20x_pek_probe_input_device(struct axp20x_pek *axp20x_pek,
>   	}
>   
>   	if (axp20x_pek->axp20x->variant == AXP288_ID)
> -		enable_irq_wake(axp20x_pek->irq_dbr);
> +		device_init_wakeup(&pdev->dev, true);
>   
>   	return 0;
>   }
> @@ -352,6 +352,45 @@ static int axp20x_pek_probe(struct platform_device *pdev)
>   	return 0;
>   }
>   
> +#if CONFIG_PM_SLEEP

As the kbuild test robot pointed out, you need to use #ifdef here.

Otherwise this patch looks good to me:

Reviewed-by: Hans de Goede <hdegoede@redhat.com>

Regards,

Hans



> +static int axp20x_pek_suspend(struct device *dev)
> +{
> +	struct axp20x_pek *axp20x_pek = dev_get_drvdata(dev);
> +
> +	/*
> +	 * Nested threaded interrupts are not automatically
> +	 * disabled, so we must do it explicitly.
> +	 */
> +	if (device_may_wakeup(dev)) {
> +		enable_irq_wake(axp20x_pek->irq_dbf);
> +		enable_irq_wake(axp20x_pek->irq_dbr);
> +	} else {
> +		disable_irq(axp20x_pek->irq_dbf);
> +		disable_irq(axp20x_pek->irq_dbr);
> +	}
> +
> +	return 0;
> +}
> +
> +static int axp20x_pek_resume(struct device *dev)
> +{
> +	struct axp20x_pek *axp20x_pek = dev_get_drvdata(dev);
> +
> +	if (device_may_wakeup(dev)) {
> +		disable_irq_wake(axp20x_pek->irq_dbf);
> +		disable_irq_wake(axp20x_pek->irq_dbr);
> +	} else {
> +		enable_irq(axp20x_pek->irq_dbf);
> +		enable_irq(axp20x_pek->irq_dbr);
> +	}
> +
> +	return 0;
> +}
> +#endif
> +
> +static SIMPLE_DEV_PM_OPS(axp20x_pek_pm_ops, axp20x_pek_suspend,
> +					    axp20x_pek_resume);
> +
>   static const struct platform_device_id axp_pek_id_match[] = {
>   	{
>   		.name = "axp20x-pek",
> @@ -371,6 +410,7 @@ static struct platform_driver axp20x_pek_driver = {
>   	.driver		= {
>   		.name		= "axp20x-pek",
>   		.dev_groups	= axp20x_groups,
> +		.pm		= &axp20x_pek_pm_ops,
>   	},
>   };
>   module_platform_driver(axp20x_pek_driver);
> 

