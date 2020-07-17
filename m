Return-Path: <SRS0=w5GM=A4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.0 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DF09BC433E4
	for <linux-kernel@archiver.kernel.org>; Fri, 17 Jul 2020 09:12:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C09772070E
	for <linux-kernel@archiver.kernel.org>; Fri, 17 Jul 2020 09:12:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726528AbgGQJMn (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 17 Jul 2020 05:12:43 -0400
Received: from relay9-d.mail.gandi.net ([217.70.183.199]:58229 "EHLO
        relay9-d.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725864AbgGQJMm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Jul 2020 05:12:42 -0400
X-Originating-IP: 90.65.108.121
Received: from localhost (lfbn-lyo-1-1676-121.w90-65.abo.wanadoo.fr [90.65.108.121])
        (Authenticated sender: alexandre.belloni@bootlin.com)
        by relay9-d.mail.gandi.net (Postfix) with ESMTPSA id E4FFEFF80C;
        Fri, 17 Jul 2020 09:12:38 +0000 (UTC)
Date:   Fri, 17 Jul 2020 11:12:38 +0200
From:   Alexandre Belloni <alexandre.belloni@bootlin.com>
To:     Claudiu Beznea <claudiu.beznea@microchip.com>
Cc:     mturquette@baylibre.com, sboyd@kernel.org,
        nicolas.ferre@microchip.com, ludovic.desroches@microchip.com,
        bbrezillon@kernel.org, linux-kernel@vger.kernel.org,
        linux-clk@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH 07/19] clk: at91: sam9x60-pll: use frac when setting
 frequency
Message-ID: <20200717091238.GL3428@piout.net>
References: <1594812267-6697-1-git-send-email-claudiu.beznea@microchip.com>
 <1594812267-6697-8-git-send-email-claudiu.beznea@microchip.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1594812267-6697-8-git-send-email-claudiu.beznea@microchip.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 15/07/2020 14:24:15+0300, Claudiu Beznea wrote:
> In commit a436c2a447e59 ("clk: at91: add sam9x60 PLL driver")
> the fractional part of PLL wasn't set on registers but it was
> calculated and taken into account for determining div and mul
> (see sam9x60_pll_get_best_div_mul()).
> 

I think this becomes an issue only once 4/19 is applied so you should
probably squash those two together.

> Fixes: a436c2a447e59 ("clk: at91: add sam9x60 PLL driver")
> Signed-off-by: Claudiu Beznea <claudiu.beznea@microchip.com>
> ---
>  drivers/clk/at91/clk-sam9x60-pll.c | 9 ++++++---
>  1 file changed, 6 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/clk/at91/clk-sam9x60-pll.c b/drivers/clk/at91/clk-sam9x60-pll.c
> index 00f2afd6e9b6..13e15bd48770 100644
> --- a/drivers/clk/at91/clk-sam9x60-pll.c
> +++ b/drivers/clk/at91/clk-sam9x60-pll.c
> @@ -16,6 +16,7 @@
>  
>  #define	PMC_PLL_CTRL0_DIV_MSK	GENMASK(7, 0)
>  #define	PMC_PLL_CTRL1_MUL_MSK	GENMASK(31, 24)
> +#define	PMC_PLL_CTRL1_FRACR_MSK	GENMASK(21, 0)
>  
>  #define PLL_DIV_MAX		(FIELD_GET(PMC_PLL_CTRL0_DIV_MSK, UINT_MAX) + 1)
>  #define UPLL_DIV		2
> @@ -55,7 +56,7 @@ static int sam9x60_pll_prepare(struct clk_hw *hw)
>  	unsigned long flags;
>  	u8 div;
>  	u16 mul;
> -	u32 val;
> +	u32 val, frac;
>  
>  	spin_lock_irqsave(pll->lock, flags);
>  	regmap_write(regmap, AT91_PMC_PLL_UPDT, pll->id);
> @@ -65,9 +66,10 @@ static int sam9x60_pll_prepare(struct clk_hw *hw)
>  
>  	regmap_read(regmap, AT91_PMC_PLL_CTRL1, &val);
>  	mul = FIELD_GET(PMC_PLL_CTRL1_MUL_MSK, val);
> +	frac = FIELD_GET(PMC_PLL_CTRL1_FRACR_MSK, val);
>  
>  	if (sam9x60_pll_ready(regmap, pll->id) &&
> -	    (div == pll->div && mul == pll->mul)) {
> +	    (div == pll->div && mul == pll->mul && frac == pll->frac)) {
>  		spin_unlock_irqrestore(pll->lock, flags);
>  		return 0;
>  	}
> @@ -80,7 +82,8 @@ static int sam9x60_pll_prepare(struct clk_hw *hw)
>  	regmap_write(regmap, AT91_PMC_PLL_ACR, val);
>  
>  	regmap_write(regmap, AT91_PMC_PLL_CTRL1,
> -		     FIELD_PREP(PMC_PLL_CTRL1_MUL_MSK, pll->mul));
> +		     FIELD_PREP(PMC_PLL_CTRL1_MUL_MSK, pll->mul) |
> +		     FIELD_PREP(PMC_PLL_CTRL1_FRACR_MSK, pll->frac));
>  
>  	if (pll->characteristics->upll) {
>  		/* Enable the UTMI internal bandgap */
> -- 
> 2.7.4
> 

-- 
Alexandre Belloni, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com
