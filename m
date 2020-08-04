Return-Path: <SRS0=pusq=BO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4BD68C433DF
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Aug 2020 11:42:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 35C0020738
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Aug 2020 11:42:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730148AbgHDLm2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 4 Aug 2020 07:42:28 -0400
Received: from relay11.mail.gandi.net ([217.70.178.231]:42973 "EHLO
        relay11.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728028AbgHDLm1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Aug 2020 07:42:27 -0400
Received: from localhost (lfbn-lyo-1-1932-79.w90-66.abo.wanadoo.fr [90.66.108.79])
        (Authenticated sender: alexandre.belloni@bootlin.com)
        by relay11.mail.gandi.net (Postfix) with ESMTPSA id 0F74B100004;
        Tue,  4 Aug 2020 11:42:23 +0000 (UTC)
Date:   Tue, 4 Aug 2020 13:42:23 +0200
From:   Alexandre Belloni <alexandre.belloni@bootlin.com>
To:     Claudiu Beznea <claudiu.beznea@microchip.com>
Cc:     nicolas.ferre@microchip.com, ludovic.desroches@microchip.com,
        wenyou.yang@atmel.com, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 2/3] ARM: at91: pm: add per soc validation of pm modes
Message-ID: <20200804114223.GC7836@piout.net>
References: <1596539258-20719-1-git-send-email-claudiu.beznea@microchip.com>
 <1596539258-20719-3-git-send-email-claudiu.beznea@microchip.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1596539258-20719-3-git-send-email-claudiu.beznea@microchip.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

On 04/08/2020 14:07:37+0300, Claudiu Beznea wrote:
>  void __init at91rm9200_pm_init(void)
>  {
> +	static const int modes[] __initconst = {

You don't need that to be static as it is now local to the function.

> +		AT91_PM_STANDBY, AT91_PM_ULP0
> +	};
> +
>  	if (!IS_ENABLED(CONFIG_SOC_AT91RM9200))
>  		return;
>  
> +	at91_pm_modes_validate(modes, ARRAY_SIZE(modes));

For rm9200 and at91sam9, I would not allow changing the pm_modes and
simply enforce standby_mode = AT91_PM_STANDBY and suspend_mode =
AT91_PM_ULP0. I don't think you have any user that ever changed that
behaviour also that avoids increasing the boot time for those slow SoCs.

>  	at91_dt_ramc();
>  
>  	/*
> @@ -838,9 +888,14 @@ void __init at91rm9200_pm_init(void)
>  
>  void __init sam9x60_pm_init(void)
>  {
> +	static const int modes[] __initconst = {
> +		AT91_PM_STANDBY, AT91_PM_ULP0, AT91_PM_ULP0_FAST, AT91_PM_ULP1,
> +	};
> +
>  	if (!IS_ENABLED(CONFIG_SOC_SAM9X60))
>  		return;
>  
> +	at91_pm_modes_validate(modes, ARRAY_SIZE(modes));
>  	at91_pm_modes_init();
>  	at91_dt_ramc();
>  	at91_pm_init(at91sam9x60_idle);
> @@ -851,14 +906,19 @@ void __init sam9x60_pm_init(void)
>  
>  void __init at91sam9_pm_init(void)
>  {
> +	static const int modes[] __initconst = {
> +		AT91_PM_STANDBY, AT91_PM_ULP0,
> +	};
> +
>  	if (!IS_ENABLED(CONFIG_SOC_AT91SAM9))
>  		return;
>  
> +	at91_pm_modes_validate(modes, ARRAY_SIZE(modes));
>  	at91_dt_ramc();
>  	at91_pm_init(at91sam9_idle);
>  }
>  
> -void __init sama5_pm_init(void)
> +static void __init sama5_pm(void)
>  {
>  	if (!IS_ENABLED(CONFIG_SOC_SAMA5))
>  		return;
> @@ -867,13 +927,32 @@ void __init sama5_pm_init(void)
>  	at91_pm_init(NULL);
>  }
>  
> +void __init sama5_pm_init(void)
> +{
> +	static const int modes[] __initconst = {
> +		AT91_PM_STANDBY, AT91_PM_ULP0, AT91_PM_ULP0_FAST,
> +	};
> +
> +	if (!IS_ENABLED(CONFIG_SOC_SAMA5))
> +		return;
> +
> +	at91_pm_modes_validate(modes, ARRAY_SIZE(modes));
> +	sama5_pm();
> +}
> +
>  void __init sama5d2_pm_init(void)
>  {
> +	static const int modes[] __initconst = {
> +		AT91_PM_STANDBY, AT91_PM_ULP0, AT91_PM_ULP0_FAST, AT91_PM_ULP1,
> +		AT91_PM_BACKUP,
> +	};
> +
>  	if (!IS_ENABLED(CONFIG_SOC_SAMA5D2))
>  		return;
>  
> +	at91_pm_modes_validate(modes, ARRAY_SIZE(modes));
>  	at91_pm_modes_init();
> -	sama5_pm_init();
> +	sama5_pm();

I would call those two directly:
	at91_dt_ramc();
	at91_pm_init(NULL);

instead of having a function that doesn't do much.

-- 
Alexandre Belloni, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com
