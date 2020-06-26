Return-Path: <SRS0=rtH4=AH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0379FC433DF
	for <linux-kernel@archiver.kernel.org>; Fri, 26 Jun 2020 21:04:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E3A682070A
	for <linux-kernel@archiver.kernel.org>; Fri, 26 Jun 2020 21:04:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726118AbgFZVEA (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 26 Jun 2020 17:04:00 -0400
Received: from relay9-d.mail.gandi.net ([217.70.183.199]:40659 "EHLO
        relay9-d.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725781AbgFZVEA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 Jun 2020 17:04:00 -0400
X-Originating-IP: 86.202.110.81
Received: from localhost (lfbn-lyo-1-15-81.w86-202.abo.wanadoo.fr [86.202.110.81])
        (Authenticated sender: alexandre.belloni@bootlin.com)
        by relay9-d.mail.gandi.net (Postfix) with ESMTPSA id 4CC30FF804;
        Fri, 26 Jun 2020 21:03:57 +0000 (UTC)
Date:   Fri, 26 Jun 2020 23:03:57 +0200
From:   Alexandre Belloni <alexandre.belloni@bootlin.com>
To:     Claudiu Beznea <claudiu.beznea@microchip.com>
Cc:     mturquette@baylibre.com, sboyd@kernel.org,
        nicolas.ferre@microchip.com, ludovic.desroches@microchip.com,
        linux-kernel@vger.kernel.org, mturquette@linaro.org,
        bbrezillon@kernel.org, linux-clk@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH 2/2] clk: at91: main: do not continue if oscillators
 already prepared
Message-ID: <20200626210357.GX131826@piout.net>
References: <1593079768-9349-1-git-send-email-claudiu.beznea@microchip.com>
 <1593079768-9349-2-git-send-email-claudiu.beznea@microchip.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1593079768-9349-2-git-send-email-claudiu.beznea@microchip.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 25/06/2020 13:09:28+0300, Claudiu Beznea wrote:
> Return in clk_main_osc_prepare()/clk_main_rc_osc_prepare() if
> oscillators are already enabled.
> 
> Fixes: 27cb1c2083373 ("clk: at91: rework main clk implementation")
> Fixes: 1bdf02326b71e ("clk: at91: make use of syscon/regmap internally")

Is this really a fix? What is the observed issue?

> Signed-off-by: Claudiu Beznea <claudiu.beznea@microchip.com>
> ---
>  drivers/clk/at91/clk-main.c | 18 +++++++++---------
>  1 file changed, 9 insertions(+), 9 deletions(-)
> 
> diff --git a/drivers/clk/at91/clk-main.c b/drivers/clk/at91/clk-main.c
> index 37c22667e831..46b4d2131989 100644
> --- a/drivers/clk/at91/clk-main.c
> +++ b/drivers/clk/at91/clk-main.c
> @@ -74,13 +74,11 @@ static int clk_main_osc_prepare(struct clk_hw *hw)
>  	regmap_read(regmap, AT91_CKGR_MOR, &tmp);
>  	tmp &= ~MOR_KEY_MASK;
>  
> -	if (tmp & AT91_PMC_OSCBYPASS)
> +	if (tmp & (AT91_PMC_OSCBYPASS | AT91_PMC_MOSCEN))
>  		return 0;

While this seems like a good optimization, it is also not correct.
Having AT91_PMC_MOSCEN set doesn't mean that the clock is ready, you
need to at least check MOSCS once.

>  
> -	if (!(tmp & AT91_PMC_MOSCEN)) {
> -		tmp |= AT91_PMC_MOSCEN | AT91_PMC_KEY;
> -		regmap_write(regmap, AT91_CKGR_MOR, tmp);
> -	}
> +	tmp |= AT91_PMC_MOSCEN | AT91_PMC_KEY;
> +	regmap_write(regmap, AT91_CKGR_MOR, tmp);
>  
>  	while (!clk_main_osc_ready(regmap))
>  		cpu_relax();
> @@ -186,10 +184,12 @@ static int clk_main_rc_osc_prepare(struct clk_hw *hw)
>  
>  	regmap_read(regmap, AT91_CKGR_MOR, &mor);
>  
> -	if (!(mor & AT91_PMC_MOSCRCEN))
> -		regmap_update_bits(regmap, AT91_CKGR_MOR,
> -				   MOR_KEY_MASK | AT91_PMC_MOSCRCEN,
> -				   AT91_PMC_MOSCRCEN | AT91_PMC_KEY);
> +	if (mor & AT91_PMC_MOSCRCEN)
> +		return 0;
> +
> +	regmap_update_bits(regmap, AT91_CKGR_MOR,
> +			   MOR_KEY_MASK | AT91_PMC_MOSCRCEN,
> +			   AT91_PMC_MOSCRCEN | AT91_PMC_KEY);
>  
>  	while (!clk_main_rc_osc_ready(regmap))
>  		cpu_relax();
> -- 
> 2.7.4
> 

-- 
Alexandre Belloni, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com
