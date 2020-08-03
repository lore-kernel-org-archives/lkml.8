Return-Path: <SRS0=5bHT=BN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 16D4DC433E0
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Aug 2020 12:52:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E29A320678
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Aug 2020 12:52:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728046AbgHCMwd (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 3 Aug 2020 08:52:33 -0400
Received: from relay11.mail.gandi.net ([217.70.178.231]:51833 "EHLO
        relay11.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728212AbgHCMv5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Aug 2020 08:51:57 -0400
Received: from localhost (pop.92-184-100-115.mobile.abo.orange.fr [92.184.100.115])
        (Authenticated sender: alexandre.belloni@bootlin.com)
        by relay11.mail.gandi.net (Postfix) with ESMTPSA id 6E524100004;
        Mon,  3 Aug 2020 12:51:40 +0000 (UTC)
Date:   Mon, 3 Aug 2020 14:51:30 +0200
From:   Alexandre Belloni <alexandre.belloni@bootlin.com>
To:     Claudiu.Beznea@microchip.com
Cc:     Nicolas.Ferre@microchip.com, Ludovic.Desroches@microchip.com,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/3] ARM: at91: pm: add per soc validation of pm modes
Message-ID: <20200803125130.GH3679@piout.net>
References: <1596439517-12993-1-git-send-email-claudiu.beznea@microchip.com>
 <1596439517-12993-3-git-send-email-claudiu.beznea@microchip.com>
 <20200803083436.GG3679@piout.net>
 <f8282c6f-7f4c-0047-f233-4f40096755f9@microchip.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <f8282c6f-7f4c-0047-f233-4f40096755f9@microchip.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 03/08/2020 10:54:51+0000, Claudiu.Beznea@microchip.com wrote:
> >> diff --git a/arch/arm/mach-at91/at91rm9200.c b/arch/arm/mach-at91/at91rm9200.c
> >> index 4f8186211619..7318d8e16797 100644
> >> --- a/arch/arm/mach-at91/at91rm9200.c
> >> +++ b/arch/arm/mach-at91/at91rm9200.c
> >> @@ -13,12 +13,20 @@
> >>  #include <asm/mach/arch.h>
> >>
> >>  #include "generic.h"
> >> +#include "pm.h"
> >> +
> >> +/* AT91RM9200 valid PM modes. */
> >> +static const int at91rm9200_pm_modes[] = {
> >> +     AT91_PM_STANDBY,
> >> +     AT91_PM_ULP0,
> >> +};
> >>
> >>  static void __init at91rm9200_dt_device_init(void)
> >>  {
> >>       of_platform_default_populate(NULL, NULL, NULL);
> >>
> >> -     at91rm9200_pm_init();
> >> +     at91rm9200_pm_init(at91rm9200_pm_modes,
> >> +                        ARRAY_SIZE(at91rm9200_pm_modes));
> >>  }
> >>
> > 
> > You can avoid the changes in the soc files and leave everything
> > contained in pm.c as each <soc>_pm_init has a known list of mode that
> > will very likely never change. Bonus points if you make the arrays
> > __initdata.
> 
> That was my initial approach. I went with the one in this patch to avoid
> adding yet another struct of_device_id array in pm.c and keep code in pm.c
> somehow platform independent. If you feel is better your way, then OK, I
> have no problems with moving it in pm.c.
> 

You don't need an other struct of_device_id array as you already have
all the _pm_init functions broken out by soc family.

Going further, for at91rm9200_pm_init and at91sam9_pm_init, maybe you
can simply enforce soc_pm.data.standby_mode = AT91_PM_STANDBY and
soc_pm.data.suspend_mode = AT91_PM_ULP0 instead of checking the modes.


> > 
> >>  static const char *const at91rm9200_dt_board_compat[] __initconst = {
> >> diff --git a/arch/arm/mach-at91/at91sam9.c b/arch/arm/mach-at91/at91sam9.c
> >> index 7e572189a5eb..683f2c35a116 100644
> >> --- a/arch/arm/mach-at91/at91sam9.c
> >> +++ b/arch/arm/mach-at91/at91sam9.c
> >> @@ -13,12 +13,19 @@
> >>  #include <asm/system_misc.h>
> >>
> >>  #include "generic.h"
> >> +#include "pm.h"
> >> +
> >> +/* AT91SAM9 valid PM modes. */
> >> +static const int at91sam9_pm_modes[] = {
> >> +     AT91_PM_STANDBY,
> >> +     AT91_PM_ULP0,
> >> +};
> >>
> >>  static void __init at91sam9_init(void)
> >>  {
> >>       of_platform_default_populate(NULL, NULL, NULL);
> >>
> >> -     at91sam9_pm_init();
> >> +     at91sam9_pm_init(at91sam9_pm_modes, ARRAY_SIZE(at91sam9_pm_modes));
> >>  }
> >>
> >>  static const char *const at91_dt_board_compat[] __initconst = {
> >> diff --git a/arch/arm/mach-at91/generic.h b/arch/arm/mach-at91/generic.h
> >> index 0a4cdcb4985b..610a12e5a71c 100644
> >> --- a/arch/arm/mach-at91/generic.h
> >> +++ b/arch/arm/mach-at91/generic.h
> >> @@ -9,17 +9,17 @@
> >>  #define _AT91_GENERIC_H
> >>
> >>  #ifdef CONFIG_PM
> >> -extern void __init at91rm9200_pm_init(void);
> >> -extern void __init at91sam9_pm_init(void);
> >> -extern void __init sam9x60_pm_init(void);
> >> -extern void __init sama5_pm_init(void);
> >> -extern void __init sama5d2_pm_init(void);
> >> +extern void __init at91rm9200_pm_init(const int *modes, int len);
> >> +extern void __init at91sam9_pm_init(const int *modes, int len);
> >> +extern void __init sam9x60_pm_init(const int *modes, int len);
> >> +extern void __init sama5_pm_init(const int *modes, int len);
> >> +extern void __init sama5d2_pm_init(const int *modes, int len);
> >>  #else
> >> -static inline void __init at91rm9200_pm_init(void) { }
> >> -static inline void __init at91sam9_pm_init(void) { }
> >> -static inline void __init sam9x60_pm_init(void) { }
> >> -static inline void __init sama5_pm_init(void) { }
> >> -static inline void __init sama5d2_pm_init(void) { }
> >> +static inline void __init at91rm9200_pm_init(const int *modes, int len) { }
> >> +static inline void __init at91sam9_pm_init(const int *modes, int len) { }
> >> +static inline void __init sam9x60_pm_init(const int *modes, int len) { }
> >> +static inline void __init sama5_pm_init(const int *modes, int len) { }
> >> +static inline void __init sama5d2_pm_init(const int *modes, int len) { }
> >>  #endif
> >>
> > 
> > Then this change is not necessary.
> > 
> >>  #endif /* _AT91_GENERIC_H */
> >> diff --git a/arch/arm/mach-at91/pm.c b/arch/arm/mach-at91/pm.c
> >> index 04fdcbd57100..caf87efc7eeb 100644
> >> --- a/arch/arm/mach-at91/pm.c
> >> +++ b/arch/arm/mach-at91/pm.c
> >> @@ -785,6 +785,59 @@ static const struct of_device_id atmel_pmc_ids[] __initconst = {
> >>       { /* sentinel */ },
> >>  };
> >>
> >> +static void __init at91_pm_modes_validate(const int *modes, int len)
> >> +{
> >> +     u8 i, located = 0;
> >> +     int mode;
> >> +
> >> +#define STANDBY      BIT(0)
> >> +#define SUSPEND      BIT(1)
> >> +
> >> +     for (i = 0; i < len; i++) {
> >> +             if ((located & STANDBY) && (located & SUSPEND))
> >> +                     break;
> >> +
> >> +             if (modes[i] == soc_pm.data.standby_mode &&
> >> +                 !(located & STANDBY)) {
> >> +                     located |= STANDBY;
> >> +                     continue;
> >> +             }
> >> +
> >> +             if (modes[i] == soc_pm.data.suspend_mode &&
> >> +                 !(located & SUSPEND)) {
> >> +                     located |= SUSPEND;
> >> +                     continue;
> >> +             }
> >> +     }
> >> +
> >> +     if (!(located & STANDBY)) {
> >> +             if (soc_pm.data.suspend_mode == AT91_PM_STANDBY)
> >> +                     mode = AT91_PM_ULP0;
> >> +             else
> >> +                     mode = AT91_PM_STANDBY;
> >> +
> >> +             pr_warn("AT91: PM: %s mode not supported! Using %s.\n",
> >> +                     pm_modes[soc_pm.data.standby_mode].pattern,
> >> +                     pm_modes[mode].pattern);
> >> +             soc_pm.data.standby_mode = mode;
> >> +     }
> >> +
> >> +     if (!(located & SUSPEND)) {
> >> +             if (soc_pm.data.standby_mode == AT91_PM_ULP0)
> >> +                     mode = AT91_PM_STANDBY;
> >> +             else
> >> +                     mode = AT91_PM_ULP0;
> >> +
> >> +             pr_warn("AT91: PM: %s mode not supported! Using %s.\n",
> >> +                     pm_modes[soc_pm.data.suspend_mode].pattern,
> >> +                     pm_modes[mode].pattern);
> >> +             soc_pm.data.suspend_mode = mode;
> >> +     }
> >> +
> >> +#undef STANDBY
> >> +#undef SUSPEND
> > 
> > You should use two booleans instead of a bit array, this would not make
> > the code longer and will avoid this #def/#undef thing.
> 
> OK, I have no strong opinion on this. I'll switch to booleans.
> 
> > 
> >> +}
> >> +
> >>  static void __init at91_pm_init(void (*pm_idle)(void))
> >>  {
> >>       struct device_node *pmc_np;
> >> @@ -821,11 +874,12 @@ static void __init at91_pm_init(void (*pm_idle)(void))
> >>       }
> >>  }
> >>
> >> -void __init at91rm9200_pm_init(void)
> >> +void __init at91rm9200_pm_init(const int *modes, int len)
> >>  {
> >>       if (!IS_ENABLED(CONFIG_SOC_AT91RM9200))
> >>               return;
> >>
> >> +     at91_pm_modes_validate(modes, len);
> >>       at91_dt_ramc();
> >>
> >>       /*
> >> @@ -836,11 +890,12 @@ void __init at91rm9200_pm_init(void)
> >>       at91_pm_init(at91rm9200_idle);
> >>  }
> >>
> >> -void __init sam9x60_pm_init(void)
> >> +void __init sam9x60_pm_init(const int *modes, int len)
> >>  {
> >>       if (!IS_ENABLED(CONFIG_SOC_SAM9X60))
> >>               return;
> >>
> >> +     at91_pm_modes_validate(modes, len);
> >>       at91_pm_modes_init();
> >>       at91_dt_ramc();
> >>       at91_pm_init(at91sam9x60_idle);
> >> @@ -849,31 +904,33 @@ void __init sam9x60_pm_init(void)
> >>       soc_pm.config_pmc_ws = at91_sam9x60_config_pmc_ws;
> >>  }
> >>
> >> -void __init at91sam9_pm_init(void)
> >> +void __init at91sam9_pm_init(const int *modes, int len)
> >>  {
> >>       if (!IS_ENABLED(CONFIG_SOC_AT91SAM9))
> >>               return;
> >>
> >> +     at91_pm_modes_validate(modes, len);
> >>       at91_dt_ramc();
> >>       at91_pm_init(at91sam9_idle);
> >>  }
> >>
> >> -void __init sama5_pm_init(void)
> >> +void __init sama5_pm_init(const int *modes, int len)
> >>  {
> >>       if (!IS_ENABLED(CONFIG_SOC_SAMA5))
> >>               return;
> >>
> >> +     at91_pm_modes_validate(modes, len);
> >>       at91_dt_ramc();
> >>       at91_pm_init(NULL);
> >>  }
> >>
> >> -void __init sama5d2_pm_init(void)
> >> +void __init sama5d2_pm_init(const int *modes, int len)
> >>  {
> >>       if (!IS_ENABLED(CONFIG_SOC_SAMA5D2))
> >>               return;
> >>
> >> +     sama5_pm_init(modes, len);
> >>       at91_pm_modes_init();
> >> -     sama5_pm_init();
> >>
> >>       soc_pm.ws_ids = sama5d2_ws_ids;
> >>       soc_pm.config_shdwc_ws = at91_sama5d2_config_shdwc_ws;
> >> diff --git a/arch/arm/mach-at91/sam9x60.c b/arch/arm/mach-at91/sam9x60.c
> >> index d8c739d25458..d7c869c7b542 100644
> >> --- a/arch/arm/mach-at91/sam9x60.c
> >> +++ b/arch/arm/mach-at91/sam9x60.c
> >> @@ -14,12 +14,21 @@
> >>  #include <asm/system_misc.h>
> >>
> >>  #include "generic.h"
> >> +#include "pm.h"
> >> +
> >> +/* SAM9X60 valid PM modes. */
> >> +static const int sam9x60_pm_modes[] = {
> >> +     AT91_PM_STANDBY,
> >> +     AT91_PM_ULP0,
> >> +     AT91_PM_ULP0_FAST,
> >> +     AT91_PM_ULP1,
> >> +};
> >>
> >>  static void __init sam9x60_init(void)
> >>  {
> >>       of_platform_default_populate(NULL, NULL, NULL);
> >>
> >> -     sam9x60_pm_init();
> >> +     sam9x60_pm_init(sam9x60_pm_modes, ARRAY_SIZE(sam9x60_pm_modes));
> >>  }
> >>
> >>  static const char *const sam9x60_dt_board_compat[] __initconst = {
> >> diff --git a/arch/arm/mach-at91/sama5.c b/arch/arm/mach-at91/sama5.c
> >> index 89dab7cf01e8..7eb124612a10 100644
> >> --- a/arch/arm/mach-at91/sama5.c
> >> +++ b/arch/arm/mach-at91/sama5.c
> >> @@ -14,11 +14,19 @@
> >>  #include <asm/system_misc.h>
> >>
> >>  #include "generic.h"
> >> +#include "pm.h"
> >> +
> >> +/* SAMA5 valid PM modes. */
> >> +static const int sama5_pm_modes[] = {
> >> +     AT91_PM_STANDBY,
> >> +     AT91_PM_ULP0,
> >> +     AT91_PM_ULP0_FAST,
> >> +};
> >>
> >>  static void __init sama5_dt_device_init(void)
> >>  {
> >>       of_platform_default_populate(NULL, NULL, NULL);
> >> -     sama5_pm_init();
> >> +     sama5_pm_init(sama5_pm_modes, ARRAY_SIZE(sama5_pm_modes));
> >>  }
> >>
> >>  static const char *const sama5_dt_board_compat[] __initconst = {
> >> @@ -44,10 +52,19 @@ DT_MACHINE_START(sama5_alt_dt, "Atmel SAMA5")
> >>       .l2c_aux_mask   = ~0UL,
> >>  MACHINE_END
> >>
> >> +/* sama5d2 PM modes. */
> >> +static const int sama5d2_pm_modes[] = {
> >> +     AT91_PM_STANDBY,
> >> +     AT91_PM_ULP0,
> >> +     AT91_PM_ULP0_FAST,
> >> +     AT91_PM_ULP1,
> >> +     AT91_PM_BACKUP,
> >> +};
> >> +
> >>  static void __init sama5d2_init(void)
> >>  {
> >>       of_platform_default_populate(NULL, NULL, NULL);
> >> -     sama5d2_pm_init();
> >> +     sama5d2_pm_init(sama5d2_pm_modes, ARRAY_SIZE(sama5d2_pm_modes));
> >>  }

-- 
Alexandre Belloni, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com
