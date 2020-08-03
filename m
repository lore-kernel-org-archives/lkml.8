Return-Path: <SRS0=5bHT=BN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.0 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7425EC433E0
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Aug 2020 08:34:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 52D08206D7
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Aug 2020 08:34:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726218AbgHCIek (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 3 Aug 2020 04:34:40 -0400
Received: from relay4-d.mail.gandi.net ([217.70.183.196]:53323 "EHLO
        relay4-d.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725831AbgHCIek (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Aug 2020 04:34:40 -0400
X-Originating-IP: 90.66.108.79
Received: from localhost (lfbn-lyo-1-1932-79.w90-66.abo.wanadoo.fr [90.66.108.79])
        (Authenticated sender: alexandre.belloni@bootlin.com)
        by relay4-d.mail.gandi.net (Postfix) with ESMTPSA id 8DBF6E0006;
        Mon,  3 Aug 2020 08:34:36 +0000 (UTC)
Date:   Mon, 3 Aug 2020 10:34:36 +0200
From:   Alexandre Belloni <alexandre.belloni@bootlin.com>
To:     Claudiu Beznea <claudiu.beznea@microchip.com>
Cc:     nicolas.ferre@microchip.com, ludovic.desroches@microchip.com,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/3] ARM: at91: pm: add per soc validation of pm modes
Message-ID: <20200803083436.GG3679@piout.net>
References: <1596439517-12993-1-git-send-email-claudiu.beznea@microchip.com>
 <1596439517-12993-3-git-send-email-claudiu.beznea@microchip.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1596439517-12993-3-git-send-email-claudiu.beznea@microchip.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 03/08/2020 10:25:16+0300, Claudiu Beznea wrote:
> Not all SoCs supports all the PM mode. User may end up settings,
> e.g. backup mode, on a non SAMA5D2 device, but the mode to not be valid.
> If backup mode is used on a devices not supporting it there will be no
> way of resuming other than rebooting.

I don't think this actually happens as if backup mode is requested on a
non sama5d2 device, of_find_compatible_node(NULL, NULL,
"atmel,sama5d2-sfrbu") will fail and the PM will default to
AT91_PM_ULP0.

ULP1 will also default to ULP0 if the shdwc is not from sama5d2 or
sam9x60.

I'm guessing the actual issue is introduced with ulp0 fast.

> 
> Signed-off-by: Claudiu Beznea <claudiu.beznea@microchip.com>
> ---
>  arch/arm/mach-at91/at91rm9200.c | 10 +++++-
>  arch/arm/mach-at91/at91sam9.c   |  9 +++++-
>  arch/arm/mach-at91/generic.h    | 20 ++++++------
>  arch/arm/mach-at91/pm.c         | 69 +++++++++++++++++++++++++++++++++++++----
>  arch/arm/mach-at91/sam9x60.c    | 11 ++++++-
>  arch/arm/mach-at91/sama5.c      | 21 +++++++++++--
>  6 files changed, 119 insertions(+), 21 deletions(-)
> 
> diff --git a/arch/arm/mach-at91/at91rm9200.c b/arch/arm/mach-at91/at91rm9200.c
> index 4f8186211619..7318d8e16797 100644
> --- a/arch/arm/mach-at91/at91rm9200.c
> +++ b/arch/arm/mach-at91/at91rm9200.c
> @@ -13,12 +13,20 @@
>  #include <asm/mach/arch.h>
>  
>  #include "generic.h"
> +#include "pm.h"
> +
> +/* AT91RM9200 valid PM modes. */
> +static const int at91rm9200_pm_modes[] = {
> +	AT91_PM_STANDBY,
> +	AT91_PM_ULP0,
> +};
>  
>  static void __init at91rm9200_dt_device_init(void)
>  {
>  	of_platform_default_populate(NULL, NULL, NULL);
>  
> -	at91rm9200_pm_init();
> +	at91rm9200_pm_init(at91rm9200_pm_modes,
> +			   ARRAY_SIZE(at91rm9200_pm_modes));
>  }
>  

You can avoid the changes in the soc files and leave everything
contained in pm.c as each <soc>_pm_init has a known list of mode that
will very likely never change. Bonus points if you make the arrays
__initdata.

>  static const char *const at91rm9200_dt_board_compat[] __initconst = {
> diff --git a/arch/arm/mach-at91/at91sam9.c b/arch/arm/mach-at91/at91sam9.c
> index 7e572189a5eb..683f2c35a116 100644
> --- a/arch/arm/mach-at91/at91sam9.c
> +++ b/arch/arm/mach-at91/at91sam9.c
> @@ -13,12 +13,19 @@
>  #include <asm/system_misc.h>
>  
>  #include "generic.h"
> +#include "pm.h"
> +
> +/* AT91SAM9 valid PM modes. */
> +static const int at91sam9_pm_modes[] = {
> +	AT91_PM_STANDBY,
> +	AT91_PM_ULP0,
> +};
>  
>  static void __init at91sam9_init(void)
>  {
>  	of_platform_default_populate(NULL, NULL, NULL);
>  
> -	at91sam9_pm_init();
> +	at91sam9_pm_init(at91sam9_pm_modes, ARRAY_SIZE(at91sam9_pm_modes));
>  }
>  
>  static const char *const at91_dt_board_compat[] __initconst = {
> diff --git a/arch/arm/mach-at91/generic.h b/arch/arm/mach-at91/generic.h
> index 0a4cdcb4985b..610a12e5a71c 100644
> --- a/arch/arm/mach-at91/generic.h
> +++ b/arch/arm/mach-at91/generic.h
> @@ -9,17 +9,17 @@
>  #define _AT91_GENERIC_H
>  
>  #ifdef CONFIG_PM
> -extern void __init at91rm9200_pm_init(void);
> -extern void __init at91sam9_pm_init(void);
> -extern void __init sam9x60_pm_init(void);
> -extern void __init sama5_pm_init(void);
> -extern void __init sama5d2_pm_init(void);
> +extern void __init at91rm9200_pm_init(const int *modes, int len);
> +extern void __init at91sam9_pm_init(const int *modes, int len);
> +extern void __init sam9x60_pm_init(const int *modes, int len);
> +extern void __init sama5_pm_init(const int *modes, int len);
> +extern void __init sama5d2_pm_init(const int *modes, int len);
>  #else
> -static inline void __init at91rm9200_pm_init(void) { }
> -static inline void __init at91sam9_pm_init(void) { }
> -static inline void __init sam9x60_pm_init(void) { }
> -static inline void __init sama5_pm_init(void) { }
> -static inline void __init sama5d2_pm_init(void) { }
> +static inline void __init at91rm9200_pm_init(const int *modes, int len) { }
> +static inline void __init at91sam9_pm_init(const int *modes, int len) { }
> +static inline void __init sam9x60_pm_init(const int *modes, int len) { }
> +static inline void __init sama5_pm_init(const int *modes, int len) { }
> +static inline void __init sama5d2_pm_init(const int *modes, int len) { }
>  #endif
>  

Then this change is not necessary.

>  #endif /* _AT91_GENERIC_H */
> diff --git a/arch/arm/mach-at91/pm.c b/arch/arm/mach-at91/pm.c
> index 04fdcbd57100..caf87efc7eeb 100644
> --- a/arch/arm/mach-at91/pm.c
> +++ b/arch/arm/mach-at91/pm.c
> @@ -785,6 +785,59 @@ static const struct of_device_id atmel_pmc_ids[] __initconst = {
>  	{ /* sentinel */ },
>  };
>  
> +static void __init at91_pm_modes_validate(const int *modes, int len)
> +{
> +	u8 i, located = 0;
> +	int mode;
> +
> +#define STANDBY	BIT(0)
> +#define SUSPEND	BIT(1)
> +
> +	for (i = 0; i < len; i++) {
> +		if ((located & STANDBY) && (located & SUSPEND))
> +			break;
> +
> +		if (modes[i] == soc_pm.data.standby_mode &&
> +		    !(located & STANDBY)) {
> +			located |= STANDBY;
> +			continue;
> +		}
> +
> +		if (modes[i] == soc_pm.data.suspend_mode &&
> +		    !(located & SUSPEND)) {
> +			located |= SUSPEND;
> +			continue;
> +		}
> +	}
> +
> +	if (!(located & STANDBY)) {
> +		if (soc_pm.data.suspend_mode == AT91_PM_STANDBY)
> +			mode = AT91_PM_ULP0;
> +		else
> +			mode = AT91_PM_STANDBY;
> +
> +		pr_warn("AT91: PM: %s mode not supported! Using %s.\n",
> +			pm_modes[soc_pm.data.standby_mode].pattern,
> +			pm_modes[mode].pattern);
> +		soc_pm.data.standby_mode = mode;
> +	}
> +
> +	if (!(located & SUSPEND)) {
> +		if (soc_pm.data.standby_mode == AT91_PM_ULP0)
> +			mode = AT91_PM_STANDBY;
> +		else
> +			mode = AT91_PM_ULP0;
> +
> +		pr_warn("AT91: PM: %s mode not supported! Using %s.\n",
> +			pm_modes[soc_pm.data.suspend_mode].pattern,
> +			pm_modes[mode].pattern);
> +		soc_pm.data.suspend_mode = mode;
> +	}
> +
> +#undef STANDBY
> +#undef SUSPEND

You should use two booleans instead of a bit array, this would not make
the code longer and will avoid this #def/#undef thing.

> +}
> +
>  static void __init at91_pm_init(void (*pm_idle)(void))
>  {
>  	struct device_node *pmc_np;
> @@ -821,11 +874,12 @@ static void __init at91_pm_init(void (*pm_idle)(void))
>  	}
>  }
>  
> -void __init at91rm9200_pm_init(void)
> +void __init at91rm9200_pm_init(const int *modes, int len)
>  {
>  	if (!IS_ENABLED(CONFIG_SOC_AT91RM9200))
>  		return;
>  
> +	at91_pm_modes_validate(modes, len);
>  	at91_dt_ramc();
>  
>  	/*
> @@ -836,11 +890,12 @@ void __init at91rm9200_pm_init(void)
>  	at91_pm_init(at91rm9200_idle);
>  }
>  
> -void __init sam9x60_pm_init(void)
> +void __init sam9x60_pm_init(const int *modes, int len)
>  {
>  	if (!IS_ENABLED(CONFIG_SOC_SAM9X60))
>  		return;
>  
> +	at91_pm_modes_validate(modes, len);
>  	at91_pm_modes_init();
>  	at91_dt_ramc();
>  	at91_pm_init(at91sam9x60_idle);
> @@ -849,31 +904,33 @@ void __init sam9x60_pm_init(void)
>  	soc_pm.config_pmc_ws = at91_sam9x60_config_pmc_ws;
>  }
>  
> -void __init at91sam9_pm_init(void)
> +void __init at91sam9_pm_init(const int *modes, int len)
>  {
>  	if (!IS_ENABLED(CONFIG_SOC_AT91SAM9))
>  		return;
>  
> +	at91_pm_modes_validate(modes, len);
>  	at91_dt_ramc();
>  	at91_pm_init(at91sam9_idle);
>  }
>  
> -void __init sama5_pm_init(void)
> +void __init sama5_pm_init(const int *modes, int len)
>  {
>  	if (!IS_ENABLED(CONFIG_SOC_SAMA5))
>  		return;
>  
> +	at91_pm_modes_validate(modes, len);
>  	at91_dt_ramc();
>  	at91_pm_init(NULL);
>  }
>  
> -void __init sama5d2_pm_init(void)
> +void __init sama5d2_pm_init(const int *modes, int len)
>  {
>  	if (!IS_ENABLED(CONFIG_SOC_SAMA5D2))
>  		return;
>  
> +	sama5_pm_init(modes, len);
>  	at91_pm_modes_init();
> -	sama5_pm_init();
>  
>  	soc_pm.ws_ids = sama5d2_ws_ids;
>  	soc_pm.config_shdwc_ws = at91_sama5d2_config_shdwc_ws;
> diff --git a/arch/arm/mach-at91/sam9x60.c b/arch/arm/mach-at91/sam9x60.c
> index d8c739d25458..d7c869c7b542 100644
> --- a/arch/arm/mach-at91/sam9x60.c
> +++ b/arch/arm/mach-at91/sam9x60.c
> @@ -14,12 +14,21 @@
>  #include <asm/system_misc.h>
>  
>  #include "generic.h"
> +#include "pm.h"
> +
> +/* SAM9X60 valid PM modes. */
> +static const int sam9x60_pm_modes[] = {
> +	AT91_PM_STANDBY,
> +	AT91_PM_ULP0,
> +	AT91_PM_ULP0_FAST,
> +	AT91_PM_ULP1,
> +};
>  
>  static void __init sam9x60_init(void)
>  {
>  	of_platform_default_populate(NULL, NULL, NULL);
>  
> -	sam9x60_pm_init();
> +	sam9x60_pm_init(sam9x60_pm_modes, ARRAY_SIZE(sam9x60_pm_modes));
>  }
>  
>  static const char *const sam9x60_dt_board_compat[] __initconst = {
> diff --git a/arch/arm/mach-at91/sama5.c b/arch/arm/mach-at91/sama5.c
> index 89dab7cf01e8..7eb124612a10 100644
> --- a/arch/arm/mach-at91/sama5.c
> +++ b/arch/arm/mach-at91/sama5.c
> @@ -14,11 +14,19 @@
>  #include <asm/system_misc.h>
>  
>  #include "generic.h"
> +#include "pm.h"
> +
> +/* SAMA5 valid PM modes. */
> +static const int sama5_pm_modes[] = {
> +	AT91_PM_STANDBY,
> +	AT91_PM_ULP0,
> +	AT91_PM_ULP0_FAST,
> +};
>  
>  static void __init sama5_dt_device_init(void)
>  {
>  	of_platform_default_populate(NULL, NULL, NULL);
> -	sama5_pm_init();
> +	sama5_pm_init(sama5_pm_modes, ARRAY_SIZE(sama5_pm_modes));
>  }
>  
>  static const char *const sama5_dt_board_compat[] __initconst = {
> @@ -44,10 +52,19 @@ DT_MACHINE_START(sama5_alt_dt, "Atmel SAMA5")
>  	.l2c_aux_mask	= ~0UL,
>  MACHINE_END
>  
> +/* sama5d2 PM modes. */
> +static const int sama5d2_pm_modes[] = {
> +	AT91_PM_STANDBY,
> +	AT91_PM_ULP0,
> +	AT91_PM_ULP0_FAST,
> +	AT91_PM_ULP1,
> +	AT91_PM_BACKUP,
> +};
> +
>  static void __init sama5d2_init(void)
>  {
>  	of_platform_default_populate(NULL, NULL, NULL);
> -	sama5d2_pm_init();
> +	sama5d2_pm_init(sama5d2_pm_modes, ARRAY_SIZE(sama5d2_pm_modes));
>  }
>  
>  static const char *const sama5d2_compat[] __initconst = {
> -- 
> 2.7.4
> 

-- 
Alexandre Belloni, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com
