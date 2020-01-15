Return-Path: <SRS0=7RkH=3E=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5F6DFC33CB1
	for <linux-kernel@archiver.kernel.org>; Wed, 15 Jan 2020 10:50:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2DE82222C3
	for <linux-kernel@archiver.kernel.org>; Wed, 15 Jan 2020 10:50:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="enLnaSMd"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729208AbgAOKuN (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 15 Jan 2020 05:50:13 -0500
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:26864 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1725999AbgAOKuN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Jan 2020 05:50:13 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1579085412;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=0zPdYw55o/NQ5YWQsGG35pXdQyrv0EYjb0Mj4Frs9Ks=;
        b=enLnaSMdQxg+rRqxahneSLTdm2ENo+aATIEUZtQA2tqAwvbISHbgPbixf3Eor8fwwAk0nB
        EMq/4H0Du/BMPxSuhv4qGZy5Anvj2yJ5Or3zK3NA8u2mKOT4E0XCszC+XssAFAXZJdFejI
        f/W/R+QCilNe+DPKwTNLXTq8FysZxsA=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-207-cbxP8LseO_KtS8U4TNSm7A-1; Wed, 15 Jan 2020 05:50:11 -0500
X-MC-Unique: cbxP8LseO_KtS8U4TNSm7A-1
Received: by mail-wr1-f69.google.com with SMTP id z10so7778391wrt.21
        for <linux-kernel@vger.kernel.org>; Wed, 15 Jan 2020 02:50:11 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=0zPdYw55o/NQ5YWQsGG35pXdQyrv0EYjb0Mj4Frs9Ks=;
        b=UCKEM3ITB6//Y5zYU0jt0F+zS+J/CdSKm/HDThMFzx1VEG4Q8iKZs0RiVr9UmxnE8C
         yCc6jNSKR6B+XJxrtydBOkmZ7KKiW9/3OAz2+sQ+yudpAYmeKcdQyFjv3fzfbA7URRVq
         vCKK97EuxEomEoxwUKISebUU99ydrLGw2FpyVH2C6XvI05Nu8vS98l0o2+VV0bjP0v/h
         8fT2qjnb7OevGdJKnl+nQQKbQLT/4U/o6imbW5g7DIxIJPAbFzTMj4yU/KZvnB2ycE0y
         ys/r8rS8Grty97cw1CZs1T1jCfo6ko1Rq/vWqUpibBwGFPzSql/rxdtxI33IUTn1bp1Y
         FL8A==
X-Gm-Message-State: APjAAAXUU2S++tEQ4nUn+FzzYH5WZtCo+UMRmcB6QrfAfj57gDrdBz1H
        7OySClGwUhwl0GdUT+F68kcZV81zJAjOcHcj8JcaVQN1lBlZ2ekzOnpQq5rtGobVXThmF+2xg5w
        k7pOj4NPAa5aDw4Q1izx2JY7N
X-Received: by 2002:a7b:c1c7:: with SMTP id a7mr31182570wmj.168.1579085409810;
        Wed, 15 Jan 2020 02:50:09 -0800 (PST)
X-Google-Smtp-Source: APXvYqxXY+dnsYNXC/k0VTIyQlvYqpGEx/a/AJP7STlMcs8KdLZzeEcSOCesRyRmKX4FhdBaQrIkKw==
X-Received: by 2002:a7b:c1c7:: with SMTP id a7mr31182549wmj.168.1579085409606;
        Wed, 15 Jan 2020 02:50:09 -0800 (PST)
Received: from shalem.localdomain (2001-1c00-0c0c-fe00-7e79-4dac-39d0-9c14.cable.dynamic.v6.ziggo.nl. [2001:1c00:c0c:fe00:7e79:4dac:39d0:9c14])
        by smtp.gmail.com with ESMTPSA id r68sm22683998wmr.43.2020.01.15.02.50.08
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 15 Jan 2020 02:50:08 -0800 (PST)
Subject: Re: [PATCH v2 1/2] Input: axp20x-pek - Respect userspace wakeup
 configuration
To:     Samuel Holland <samuel@sholland.org>,
        Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        Chen-Yu Tsai <wens@csie.org>
Cc:     linux-input@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-sunxi@googlegroups.com
References: <20200115051253.32603-1-samuel@sholland.org>
 <20200115051253.32603-2-samuel@sholland.org>
From:   Hans de Goede <hdegoede@redhat.com>
Message-ID: <674932c7-c120-092f-0255-5fa94925155d@redhat.com>
Date:   Wed, 15 Jan 2020 11:50:08 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.3.1
MIME-Version: 1.0
In-Reply-To: <20200115051253.32603-2-samuel@sholland.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On 15-01-2020 06:12, Samuel Holland wrote:
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

Patch looks good to me:

Reviewed-by: Hans de Goede <hdegoede@redhat.com>

Regards,

Hans



> ---
>   drivers/input/misc/axp20x-pek.c | 37 ++++++++++++++++++++++++++++++++-
>   1 file changed, 36 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/input/misc/axp20x-pek.c b/drivers/input/misc/axp20x-pek.c
> index 17c1cca74498..0ace3fe3d7dc 100644
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
> @@ -352,6 +352,40 @@ static int axp20x_pek_probe(struct platform_device *pdev)
>   	return 0;
>   }
>   
> +static int __maybe_unused axp20x_pek_suspend(struct device *dev)
> +{
> +	struct axp20x_pek *axp20x_pek = dev_get_drvdata(dev);
> +
> +	/*
> +	 * As nested threaded IRQs are not automatically disabled during
> +	 * suspend, we must explicitly disable non-wakeup IRQs.
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
> +static int __maybe_unused axp20x_pek_resume(struct device *dev)
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
> +
>   static int __maybe_unused axp20x_pek_resume_noirq(struct device *dev)
>   {
>   	struct axp20x_pek *axp20x_pek = dev_get_drvdata(dev);
> @@ -371,6 +405,7 @@ static int __maybe_unused axp20x_pek_resume_noirq(struct device *dev)
>   }
>   
>   static const struct dev_pm_ops axp20x_pek_pm_ops = {
> +	SET_SYSTEM_SLEEP_PM_OPS(axp20x_pek_suspend, axp20x_pek_resume)
>   #ifdef CONFIG_PM_SLEEP
>   	.resume_noirq = axp20x_pek_resume_noirq,
>   #endif
> 

