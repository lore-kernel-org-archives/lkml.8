Return-Path: <SRS0=w5GM=A4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.0 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7F517C433E2
	for <linux-kernel@archiver.kernel.org>; Fri, 17 Jul 2020 15:07:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 679C920657
	for <linux-kernel@archiver.kernel.org>; Fri, 17 Jul 2020 15:07:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726812AbgGQPHs (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 17 Jul 2020 11:07:48 -0400
Received: from relay11.mail.gandi.net ([217.70.178.231]:58199 "EHLO
        relay11.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726359AbgGQPHr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Jul 2020 11:07:47 -0400
Received: from localhost (lfbn-lyo-1-1676-121.w90-65.abo.wanadoo.fr [90.65.108.121])
        (Authenticated sender: alexandre.belloni@bootlin.com)
        by relay11.mail.gandi.net (Postfix) with ESMTPSA id 9B101100005;
        Fri, 17 Jul 2020 15:07:44 +0000 (UTC)
Date:   Fri, 17 Jul 2020 17:07:44 +0200
From:   Alexandre Belloni <alexandre.belloni@bootlin.com>
To:     Claudiu Beznea <claudiu.beznea@microchip.com>
Cc:     mturquette@baylibre.com, sboyd@kernel.org,
        nicolas.ferre@microchip.com, ludovic.desroches@microchip.com,
        bbrezillon@kernel.org, linux-kernel@vger.kernel.org,
        linux-clk@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH 10/19] clk: at91: replace conditional operator with
 double logical not
Message-ID: <20200717150744.GU3428@piout.net>
References: <1594812267-6697-1-git-send-email-claudiu.beznea@microchip.com>
 <1594812267-6697-11-git-send-email-claudiu.beznea@microchip.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1594812267-6697-11-git-send-email-claudiu.beznea@microchip.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On 15/07/2020 14:24:18+0300, Claudiu Beznea wrote:
> Replace conditional operator with double logical not.

I think you need to elaborate why you do it as the generated
instructions are exactly the same.

> 
> Signed-off-by: Claudiu Beznea <claudiu.beznea@microchip.com>
> ---
>  drivers/clk/at91/clk-generated.c  | 2 +-
>  drivers/clk/at91/clk-main.c       | 6 +++---
>  drivers/clk/at91/clk-master.c     | 2 +-
>  drivers/clk/at91/clk-peripheral.c | 2 +-
>  drivers/clk/at91/clk-system.c     | 4 ++--
>  5 files changed, 8 insertions(+), 8 deletions(-)
> 
> diff --git a/drivers/clk/at91/clk-generated.c b/drivers/clk/at91/clk-generated.c
> index f8e557e0e1b8..2448bdc63425 100644
> --- a/drivers/clk/at91/clk-generated.c
> +++ b/drivers/clk/at91/clk-generated.c
> @@ -83,7 +83,7 @@ static int clk_generated_is_enabled(struct clk_hw *hw)
>  	regmap_read(gck->regmap, gck->layout->offset, &status);
>  	spin_unlock_irqrestore(gck->lock, flags);
>  
> -	return status & AT91_PMC_PCR_GCKEN ? 1 : 0;
> +	return !!(status & AT91_PMC_PCR_GCKEN);
>  }
>  
>  static unsigned long
> diff --git a/drivers/clk/at91/clk-main.c b/drivers/clk/at91/clk-main.c
> index 37c22667e831..5c83e899084f 100644
> --- a/drivers/clk/at91/clk-main.c
> +++ b/drivers/clk/at91/clk-main.c
> @@ -175,7 +175,7 @@ static bool clk_main_rc_osc_ready(struct regmap *regmap)
>  
>  	regmap_read(regmap, AT91_PMC_SR, &status);
>  
> -	return status & AT91_PMC_MOSCRCS;
> +	return !!(status & AT91_PMC_MOSCRCS);
>  }
>  
>  static int clk_main_rc_osc_prepare(struct clk_hw *hw)
> @@ -336,7 +336,7 @@ static int clk_rm9200_main_is_prepared(struct clk_hw *hw)
>  
>  	regmap_read(clkmain->regmap, AT91_CKGR_MCFR, &status);
>  
> -	return status & AT91_PMC_MAINRDY ? 1 : 0;
> +	return !!(status & AT91_PMC_MAINRDY);
>  }
>  
>  static unsigned long clk_rm9200_main_recalc_rate(struct clk_hw *hw,
> @@ -398,7 +398,7 @@ static inline bool clk_sam9x5_main_ready(struct regmap *regmap)
>  
>  	regmap_read(regmap, AT91_PMC_SR, &status);
>  
> -	return status & AT91_PMC_MOSCSELS ? 1 : 0;
> +	return !!(status & AT91_PMC_MOSCSELS);
>  }
>  
>  static int clk_sam9x5_main_prepare(struct clk_hw *hw)
> diff --git a/drivers/clk/at91/clk-master.c b/drivers/clk/at91/clk-master.c
> index e7e0ba652de1..88d545b1698c 100644
> --- a/drivers/clk/at91/clk-master.c
> +++ b/drivers/clk/at91/clk-master.c
> @@ -33,7 +33,7 @@ static inline bool clk_master_ready(struct regmap *regmap)
>  
>  	regmap_read(regmap, AT91_PMC_SR, &status);
>  
> -	return status & AT91_PMC_MCKRDY ? 1 : 0;
> +	return !!(status & AT91_PMC_MCKRDY);
>  }
>  
>  static int clk_master_prepare(struct clk_hw *hw)
> diff --git a/drivers/clk/at91/clk-peripheral.c b/drivers/clk/at91/clk-peripheral.c
> index c2ab4860a2bf..4c9a4147dfe5 100644
> --- a/drivers/clk/at91/clk-peripheral.c
> +++ b/drivers/clk/at91/clk-peripheral.c
> @@ -208,7 +208,7 @@ static int clk_sam9x5_peripheral_is_enabled(struct clk_hw *hw)
>  	regmap_read(periph->regmap, periph->layout->offset, &status);
>  	spin_unlock_irqrestore(periph->lock, flags);
>  
> -	return status & AT91_PMC_PCR_EN ? 1 : 0;
> +	return !!(status & AT91_PMC_PCR_EN);
>  }
>  
>  static unsigned long
> diff --git a/drivers/clk/at91/clk-system.c b/drivers/clk/at91/clk-system.c
> index c4b3877aa445..f83ec0de86c3 100644
> --- a/drivers/clk/at91/clk-system.c
> +++ b/drivers/clk/at91/clk-system.c
> @@ -34,7 +34,7 @@ static inline bool clk_system_ready(struct regmap *regmap, int id)
>  
>  	regmap_read(regmap, AT91_PMC_SR, &status);
>  
> -	return status & (1 << id) ? 1 : 0;
> +	return !!(status & (1 << id));
>  }
>  
>  static int clk_system_prepare(struct clk_hw *hw)
> @@ -74,7 +74,7 @@ static int clk_system_is_prepared(struct clk_hw *hw)
>  
>  	regmap_read(sys->regmap, AT91_PMC_SR, &status);
>  
> -	return status & (1 << sys->id) ? 1 : 0;
> +	return !!(status & (1 << sys->id));
>  }
>  
>  static const struct clk_ops system_ops = {
> -- 
> 2.7.4
> 

-- 
Alexandre Belloni, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com
