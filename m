Return-Path: <SRS0=NukP=4I=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AC40EC11D05
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Feb 2020 10:36:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 795BC2467A
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Feb 2020 10:36:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="vCKjmQ4a"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727905AbgBTKgx (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 20 Feb 2020 05:36:53 -0500
Received: from mail-wm1-f68.google.com ([209.85.128.68]:38203 "EHLO
        mail-wm1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726885AbgBTKgx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Feb 2020 05:36:53 -0500
Received: by mail-wm1-f68.google.com with SMTP id a9so1453700wmj.3
        for <linux-kernel@vger.kernel.org>; Thu, 20 Feb 2020 02:36:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=subject:to:cc:references:from:autocrypt:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=c1ucrX6kDoqvuZrczpj1ygyv9b4mpN9HnFpGLVezX98=;
        b=vCKjmQ4avuiQBvVA6v1AT5yPxgLjWilXAa3IbRPPoqQSGbbDHfykkYQPTrFbu56HLx
         4toUN2RbU7MBOB98GLjqCAO/p9LXZSFr/IjZ9kCUzwASPIZ/GfzylD/kfmWocSS6haw0
         XjERbolm52cqchB3EvtAZ1aJbzaK8FwcMmNckqYrt+LeMMZz/hIUyea22WTPpsOIoPKt
         mPjODwb7mqsc5bjW72nf7XJdjQobxwJB8tJXrGevmtVRZUpLi0fA0C6YDPewhbSZsuLa
         XxsH77CuRbdlr8AMV54/KN31JofLp/cyBvDSmgFm4P6h7cTQBZn5gYO4EH5W9S3EOOEP
         HLcw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:autocrypt
         :message-id:date:user-agent:mime-version:in-reply-to
         :content-language:content-transfer-encoding;
        bh=c1ucrX6kDoqvuZrczpj1ygyv9b4mpN9HnFpGLVezX98=;
        b=BkjW17QiJz+3ecWC9TW3vyjBkLq8cCJIxEkhKuhJ+tOEoZyUqa0vQEHf4vi9LD9WGI
         s7nkcmfNQMdvAqGS2bwnnFfd9yz8wWDk7beK5c3Wiuf2/mRIvvVuTQbtBdi6NLpvsUfE
         knC1ZHWovmGVTu8DGRSC92vO1q8y14mY51ZXLTv7cFbzfs+QF+oiQreOM4QvFxpGhKwN
         HgMtN6p8LEwJIqUXnid794hwmab+AYJWcsKOYaaD0jDmVcqWGLHk+RHLw30jQDs9QqxM
         aeXVuC74buBe7XKOzAuvhqLCyx7/j0+5UZtfxPYTPtP8vC08O2ct8ozELB81cBsv4iE3
         7UBw==
X-Gm-Message-State: APjAAAVrGd01zs+9vLK4eBgEE6J0/Q8n24KVcOf8COOGuJLocT299kZ4
        1qYrGZFRgIeOr1wPT+I5jfuMPcmswxA=
X-Google-Smtp-Source: APXvYqyhMe/4kMqii0zRl6GDawQWobGJyJ0OvQlM3cE7fc+wpSIzdtfNPunm+Sili4biQo/BAg/QwA==
X-Received: by 2002:a1c:b486:: with SMTP id d128mr3753873wmf.69.1582195009938;
        Thu, 20 Feb 2020 02:36:49 -0800 (PST)
Received: from [192.168.0.41] (6.198.22.93.rev.sfr.net. [93.22.198.6])
        by smtp.googlemail.com with ESMTPSA id x7sm3996843wrq.41.2020.02.20.02.36.48
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 20 Feb 2020 02:36:49 -0800 (PST)
Subject: Re: [PATCH v4 3/3] clocksource: Add Low Power STM32 timers driver
To:     Benjamin Gaignard <benjamin.gaignard@st.com>, lee.jones@linaro.org,
        robh+dt@kernel.org, mark.rutland@arm.com,
        mcoquelin.stm32@gmail.com, alexandre.torgue@st.com,
        tglx@linutronix.de, fabrice.gasnier@st.com
Cc:     devicetree@vger.kernel.org,
        linux-stm32@st-md-mailman.stormreply.com,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Benjamin Gaignard <benjamin.gaignard@linaro.org>,
        Pascal Paillet <p.paillet@st.com>
References: <20200217134546.14562-1-benjamin.gaignard@st.com>
 <20200217134546.14562-4-benjamin.gaignard@st.com>
From:   Daniel Lezcano <daniel.lezcano@linaro.org>
Autocrypt: addr=daniel.lezcano@linaro.org; prefer-encrypt=mutual; keydata=
 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
Message-ID: <687ab83c-6381-57aa-3bc1-3628e27644b5@linaro.org>
Date:   Thu, 20 Feb 2020 11:36:47 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.1
MIME-Version: 1.0
In-Reply-To: <20200217134546.14562-4-benjamin.gaignard@st.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 17/02/2020 14:45, Benjamin Gaignard wrote:
> From: Benjamin Gaignard <benjamin.gaignard@linaro.org>
> 
> Implement clock event driver using low power STM32 timers.
> Low power timer counters running even when CPUs are stopped.
> It could be used as clock event broadcaster to wake up CPUs but not like
> a clocksource because each it rise an interrupt the counter restart from 0.
> 
> Low power timers have a 16 bits counter and a prescaler which allow to
> divide the clock per power of 2 to up 128 to target a 32KHz rate.
> 
> Signed-off-by: Benjamin Gaignard <benjamin.gaignard@linaro.org>
> Signed-off-by: Pascal Paillet <p.paillet@st.com>
> ---
> version 4:
> - move defines in mfd/stm32-lptimer.h
> - change compatiblename
> - reword commit message
> - make driver Kconfig depends of MFD_STM32_LPTIMER
> - remove useless include
> - remove rate and clk fields from the private structure
> - to add comments about the registers sequence in stm32_clkevent_lp_set_timer
> - rework probe function and use devm_request_irq()
> - do not allow module to be removed
> - make sure that wakeup interrupt is set
> 
>  drivers/clocksource/Kconfig          |   7 ++
>  drivers/clocksource/Makefile         |   1 +
>  drivers/clocksource/timer-stm32-lp.c | 213 +++++++++++++++++++++++++++++++++++
>  3 files changed, 221 insertions(+)
>  create mode 100644 drivers/clocksource/timer-stm32-lp.c
> 
> diff --git a/drivers/clocksource/Kconfig b/drivers/clocksource/Kconfig
> index cc909e465823..9fc2b513db6f 100644
> --- a/drivers/clocksource/Kconfig
> +++ b/drivers/clocksource/Kconfig
> @@ -292,6 +292,13 @@ config CLKSRC_STM32
>  	select CLKSRC_MMIO
>  	select TIMER_OF
>  
> +config CLKSRC_STM32_LP
> +	bool "Low power clocksource for STM32 SoCs"
> +	depends on MFD_STM32_LPTIMER || COMPILE_TEST
> +	help
> +	  This option enables support for STM32 low power clockevent available
> +	  on STM32 SoCs
> +
>  config CLKSRC_MPS2
>  	bool "Clocksource for MPS2 SoCs" if COMPILE_TEST
>  	depends on GENERIC_SCHED_CLOCK
> diff --git a/drivers/clocksource/Makefile b/drivers/clocksource/Makefile
> index 713686faa549..c00fffbd4769 100644
> --- a/drivers/clocksource/Makefile
> +++ b/drivers/clocksource/Makefile
> @@ -44,6 +44,7 @@ obj-$(CONFIG_BCM_KONA_TIMER)	+= bcm_kona_timer.o
>  obj-$(CONFIG_CADENCE_TTC_TIMER)	+= timer-cadence-ttc.o
>  obj-$(CONFIG_CLKSRC_EFM32)	+= timer-efm32.o
>  obj-$(CONFIG_CLKSRC_STM32)	+= timer-stm32.o
> +obj-$(CONFIG_CLKSRC_STM32_LP)	+= timer-stm32-lp.o
>  obj-$(CONFIG_CLKSRC_EXYNOS_MCT)	+= exynos_mct.o
>  obj-$(CONFIG_CLKSRC_LPC32XX)	+= timer-lpc32xx.o
>  obj-$(CONFIG_CLKSRC_MPS2)	+= mps2-timer.o
> diff --git a/drivers/clocksource/timer-stm32-lp.c b/drivers/clocksource/timer-stm32-lp.c
> new file mode 100644
> index 000000000000..50eecdb88216
> --- /dev/null
> +++ b/drivers/clocksource/timer-stm32-lp.c
> @@ -0,0 +1,213 @@
> +// SPDX-License-Identifier: GPL-2.0
> +/*
> + * Copyright (C) STMicroelectronics 2019 - All Rights Reserved
> + * Authors: Benjamin Gaignard <benjamin.gaignard@st.com> for STMicroelectronics.
> + *	    Pascal Paillet <p.paillet@st.com> for STMicroelectronics.
> + */
> +
> +#include <linux/clk.h>
> +#include <linux/clockchips.h>
> +#include <linux/interrupt.h>
> +#include <linux/mfd/stm32-lptimer.h>
> +#include <linux/module.h>
> +#include <linux/of_address.h>
> +#include <linux/of_irq.h>
> +#include <linux/platform_device.h>
> +#include <linux/pm_wakeirq.h>
> +
> +#define CFGR_PSC_OFFSET		9
> +#define STM32_LP_RATING		400
> +#define STM32_TARGET_CLKRATE	(32000 * HZ)
> +#define STM32_LP_MAX_PSC	7
> +
> +struct stm32_lp_private {
> +	struct regmap *reg;
> +	struct clock_event_device clkevt;
> +	unsigned long period;
> +};
> +
> +static struct stm32_lp_private*
> +to_priv(struct clock_event_device *clkevt)
> +{
> +	return container_of(clkevt, struct stm32_lp_private, clkevt);
> +}
> +
> +static int stm32_clkevent_lp_shutdown(struct clock_event_device *clkevt)
> +{
> +	struct stm32_lp_private *priv = to_priv(clkevt);
> +
> +	regmap_write(priv->reg, STM32_LPTIM_CR, 0);
> +	regmap_write(priv->reg, STM32_LPTIM_IER, 0);
> +	/* clear pending flags */
> +	regmap_write(priv->reg, STM32_LPTIM_ICR, STM32_LPTIM_ARRMCF);
> +
> +	return 0;
> +}
> +
> +static int stm32_clkevent_lp_set_timer(unsigned long evt,
> +				       struct clock_event_device *clkevt,
> +				       int is_periodic)
> +{
> +	struct stm32_lp_private *priv = to_priv(clkevt);
> +
> +	/* disable LPTIMER to be able to write into IER register*/
> +	regmap_write(priv->reg, STM32_LPTIM_CR, 0);
> +	/* enable ARR interrupt */
> +	regmap_write(priv->reg, STM32_LPTIM_IER, STM32_LPTIM_ARRMIE);
> +	/* enable LPTIMER to be able to write into ARR register */
> +	regmap_write(priv->reg, STM32_LPTIM_CR, STM32_LPTIM_ENABLE);
> +	/* set next event counter */
> +	regmap_write(priv->reg, STM32_LPTIM_ARR, evt);
> +
> +	/* start counter */
> +	if (is_periodic)
> +		regmap_write(priv->reg, STM32_LPTIM_CR,
> +			     STM32_LPTIM_CNTSTRT | STM32_LPTIM_ENABLE);
> +	else
> +		regmap_write(priv->reg, STM32_LPTIM_CR,
> +			     STM32_LPTIM_SNGSTRT | STM32_LPTIM_ENABLE);

The regmap config in stm32-lptimer is not defined with the fast_io flag
(on purpose or not?) that means we can potentially deadlock here as the
lock is a mutex.

Isn't it detected with the lock validation scheme?

> +	return 0;
> +}
> +static int stm32_clkevent_lp_remove(struct platform_device *pdev)
> +{
> +	return -EBUSY; /* cannot unregister clockevent */
> +}

Won't be the mfd into an inconsistent state here? The other subsystems
will be removed but this one will prevent to unload the module leading
to a situation where the mfd is partially removed but still there
without a possible recovery, no?

> +static const struct of_device_id stm32_clkevent_lp_of_match[] = {
> +	{ .compatible = "st,stm32-lptimer-timer", },
> +	{},
> +};
> +MODULE_DEVICE_TABLE(of, stm32_clkevent_lp_of_match);
> +
> +static struct platform_driver stm32_clkevent_lp_driver = {
> +	.probe	= stm32_clkevent_lp_probe,
> +	.remove = stm32_clkevent_lp_remove,
> +	.driver	= {
> +		.name = "stm32-lptimer-timer",
> +		.of_match_table = of_match_ptr(stm32_clkevent_lp_of_match),
> +	},
> +};


-- 
 <http://www.linaro.org/> Linaro.org │ Open source software for ARM SoCs

Follow Linaro:  <http://www.facebook.com/pages/Linaro> Facebook |
<http://twitter.com/#!/linaroorg> Twitter |
<http://www.linaro.org/linaro-blog/> Blog

