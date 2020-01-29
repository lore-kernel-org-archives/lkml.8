Return-Path: <SRS0=xNW4=3S=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BB03AC33CB7
	for <linux-kernel@archiver.kernel.org>; Wed, 29 Jan 2020 11:25:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 800FE20708
	for <linux-kernel@archiver.kernel.org>; Wed, 29 Jan 2020 11:25:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="WRPl+u3K"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726528AbgA2LZa (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 29 Jan 2020 06:25:30 -0500
Received: from mail-wm1-f65.google.com ([209.85.128.65]:53378 "EHLO
        mail-wm1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726192AbgA2LZa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Jan 2020 06:25:30 -0500
Received: by mail-wm1-f65.google.com with SMTP id s10so5802488wmh.3
        for <linux-kernel@vger.kernel.org>; Wed, 29 Jan 2020 03:25:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=subject:to:cc:references:from:autocrypt:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=q2r+NiaiJMEESA43i7jCeKOjP+ATflwWpGBlXGxHFBU=;
        b=WRPl+u3KlsfSNBCjpt5woD6hvxMENDIanu6qf/SkGNzVtZzYhIxK7KEkvg4etX+X/o
         njlnQUIZybxJgW7ZXoJV0sRGPCAkax00yXhcyvmSTiiYinwdrk3jJ4nHE3y/+UnOmQDC
         g7l7aEkEeZCASrcEq/pthGwC+v9Ceeqrs1AeqozWrpwAs7a3zJsACHFDBjB8YXdIMjZz
         ExNbedI9oGjdNn0bmxK6EA9d4UOogcBcHlKFrRq/ULUrCR934ej/wTAYKcZ59Z8jsQT2
         dMFqGfXlhY6XU1g7/PuBBC42OvE230fijZmCSNd8seQ5c3p+1YzldJhBnIc/XUaPP98v
         asrA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:autocrypt
         :message-id:date:user-agent:mime-version:in-reply-to
         :content-language:content-transfer-encoding;
        bh=q2r+NiaiJMEESA43i7jCeKOjP+ATflwWpGBlXGxHFBU=;
        b=niMqtaEJl3DgfA6kzBkuiCON2YurtZ8v967OzDduftPIX1F8tq0B+t6Fdp1WD9QXVr
         ycEqS3A/8EGEzMpy0sBR/l8StBVPfZ6FwLsUM66PR87v1wZ8s89PTyyWpAoNLqaTNOLo
         RmvYwz7pHWamvrQqyakI2UEk8GKGFDe/UKAfjQQgtrIe6Z/avFlroZ1Zx7Smd+/9O/mn
         YT5MXsALGUVpMjeU/yVawx4owLleZryJXLzzdPBQj07QLwicdEeeCqmo/PbCCprTNOkJ
         /fFYT6R5NKJdF1FN3xJ5DkJfmRJIwHC1oRRioXbN7DqzhuV07uMOcO0e73/DmxuNOnCs
         TM2Q==
X-Gm-Message-State: APjAAAVErpUlvsyLPdL7phB00vy+3Rmk+5R6Czxi7+EJ/EFZFiqdarvF
        z7ev51Ry5wsAiAyJNWwqEZisgw==
X-Google-Smtp-Source: APXvYqzmWf+sm3bDfQkOdQaV3jVVn/fZVBB/2rbFYU/FrN5qPq7vW0IygAz1bGwt/1/qKnc1Nrib+A==
X-Received: by 2002:a05:600c:10d2:: with SMTP id l18mr10882511wmd.122.1580297126838;
        Wed, 29 Jan 2020 03:25:26 -0800 (PST)
Received: from ?IPv6:2a01:e34:ed2f:f020:e1e4:cd83:e1c2:8d16? ([2a01:e34:ed2f:f020:e1e4:cd83:e1c2:8d16])
        by smtp.googlemail.com with ESMTPSA id x10sm2487570wrp.58.2020.01.29.03.25.25
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 29 Jan 2020 03:25:25 -0800 (PST)
Subject: Re: [PATCH v2 1/4] clocksource: fttmr010: Parametrise shutdown
To:     Joel Stanley <joel@jms.id.au>, Rob Herring <robh+dt@kernel.org>
Cc:     =?UTF-8?Q?C=c3=a9dric_Le_Goater?= <clg@kaod.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        Linus Walleij <linus.walleij@linaro.org>,
        Andrew Jeffery <andrew@aj.id.au>
References: <20191107094218.13210-1-joel@jms.id.au>
 <20191107094218.13210-2-joel@jms.id.au>
From:   Daniel Lezcano <daniel.lezcano@linaro.org>
Autocrypt: addr=daniel.lezcano@linaro.org; prefer-encrypt=mutual; keydata=
 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
Message-ID: <747e3c0a-ee10-4a41-d0b7-1d54e0f56dd0@linaro.org>
Date:   Wed, 29 Jan 2020 12:25:24 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.1
MIME-Version: 1.0
In-Reply-To: <20191107094218.13210-2-joel@jms.id.au>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 07/11/2019 10:42, Joel Stanley wrote:
> In preparation for supporting the ast2600 which uses a different method
> to clear bits in the control register, use a callback for performing the
> shutdown sequence.
> 
> Reviewed-by: Cédric Le Goater <clg@kaod.org>
> Reviewed-by: Linus Walleij <linus.walleij@linaro.org>
> Signed-off-by: Joel Stanley <joel@jms.id.au>

It will be cleaner if you create a struct of_device_id array where you
store the different variant data.

eg.
struct myops {
	int (*shutdown)(struct clock_event_device *evt);
};

struct fttmr010 {
	...
	struct myops *ops;
};

...

static const struct of_device_id fttmr010_of_match[] = {
	{ .compatible = "faraday,fttmr010",     .data = &fttmr010_ops },
	...
	{ .compatible = "aspeed,ast2600-timer", .data = &as2600_ops, },
	{ /* sentinel */ }
};

Keep the generic timer_shutdown function, get the ops from there and
then call the shutdown callback.

At init time:

...

const struct of_device_id *match;

...

match = of_match_node(fttmr010_of_match, node);
fttmr010->ops = (struct myops *)match->data;

...

(also if you have time, remove the is_aspeed boolean test by a
corresponding callback).

> ---
>  drivers/clocksource/timer-fttmr010.c | 19 ++++++++-----------
>  1 file changed, 8 insertions(+), 11 deletions(-)
> 
> diff --git a/drivers/clocksource/timer-fttmr010.c b/drivers/clocksource/timer-fttmr010.c
> index fadff7915dd9..c2d30eb9dc72 100644
> --- a/drivers/clocksource/timer-fttmr010.c
> +++ b/drivers/clocksource/timer-fttmr010.c
> @@ -97,6 +97,7 @@ struct fttmr010 {
>  	bool is_aspeed;
>  	u32 t1_enable_val;
>  	struct clock_event_device clkevt;
> +	int (*timer_shutdown)(struct clock_event_device *evt);
>  #ifdef CONFIG_ARM
>  	struct delay_timer delay_timer;
>  #endif
> @@ -140,9 +141,7 @@ static int fttmr010_timer_set_next_event(unsigned long cycles,
>  	u32 cr;
>  
>  	/* Stop */
> -	cr = readl(fttmr010->base + TIMER_CR);
> -	cr &= ~fttmr010->t1_enable_val;
> -	writel(cr, fttmr010->base + TIMER_CR);
> +	fttmr010->timer_shutdown(evt);
>  
>  	if (fttmr010->is_aspeed) {
>  		/*
> @@ -183,9 +182,7 @@ static int fttmr010_timer_set_oneshot(struct clock_event_device *evt)
>  	u32 cr;
>  
>  	/* Stop */
> -	cr = readl(fttmr010->base + TIMER_CR);
> -	cr &= ~fttmr010->t1_enable_val;
> -	writel(cr, fttmr010->base + TIMER_CR);
> +	fttmr010->timer_shutdown(evt);
>  
>  	/* Setup counter start from 0 or ~0 */
>  	writel(0, fttmr010->base + TIMER1_COUNT);
> @@ -211,9 +208,7 @@ static int fttmr010_timer_set_periodic(struct clock_event_device *evt)
>  	u32 cr;
>  
>  	/* Stop */
> -	cr = readl(fttmr010->base + TIMER_CR);
> -	cr &= ~fttmr010->t1_enable_val;
> -	writel(cr, fttmr010->base + TIMER_CR);
> +	fttmr010->timer_shutdown(evt);
>  
>  	/* Setup timer to fire at 1/HZ intervals. */
>  	if (fttmr010->is_aspeed) {
> @@ -350,6 +345,8 @@ static int __init fttmr010_common_init(struct device_node *np, bool is_aspeed)
>  				     fttmr010->tick_rate);
>  	}
>  
> +	fttmr010->timer_shutdown = fttmr010_timer_shutdown;
> +
>  	/*
>  	 * Setup clockevent timer (interrupt-driven) on timer 1.
>  	 */
> @@ -370,10 +367,10 @@ static int __init fttmr010_common_init(struct device_node *np, bool is_aspeed)
>  	fttmr010->clkevt.features = CLOCK_EVT_FEAT_PERIODIC |
>  		CLOCK_EVT_FEAT_ONESHOT;
>  	fttmr010->clkevt.set_next_event = fttmr010_timer_set_next_event;
> -	fttmr010->clkevt.set_state_shutdown = fttmr010_timer_shutdown;
> +	fttmr010->clkevt.set_state_shutdown = fttmr010->timer_shutdown;
>  	fttmr010->clkevt.set_state_periodic = fttmr010_timer_set_periodic;
>  	fttmr010->clkevt.set_state_oneshot = fttmr010_timer_set_oneshot;
> -	fttmr010->clkevt.tick_resume = fttmr010_timer_shutdown;
> +	fttmr010->clkevt.tick_resume = fttmr010->timer_shutdown;
>  	fttmr010->clkevt.cpumask = cpumask_of(0);
>  	fttmr010->clkevt.irq = irq;
>  	clockevents_config_and_register(&fttmr010->clkevt,
> 


-- 
 <http://www.linaro.org/> Linaro.org │ Open source software for ARM SoCs

Follow Linaro:  <http://www.facebook.com/pages/Linaro> Facebook |
<http://twitter.com/#!/linaroorg> Twitter |
<http://www.linaro.org/linaro-blog/> Blog

