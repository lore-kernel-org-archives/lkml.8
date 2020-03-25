Return-Path: <SRS0=vy7l=5K=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 68E33C54FD0
	for <linux-kernel@archiver.kernel.org>; Wed, 25 Mar 2020 09:55:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4BA1020772
	for <linux-kernel@archiver.kernel.org>; Wed, 25 Mar 2020 09:55:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727518AbgCYJzT (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 25 Mar 2020 05:55:19 -0400
Received: from relay12.mail.gandi.net ([217.70.178.232]:50535 "EHLO
        relay12.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726103AbgCYJzT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 Mar 2020 05:55:19 -0400
Received: from localhost (lfbn-lyo-1-9-35.w86-202.abo.wanadoo.fr [86.202.105.35])
        (Authenticated sender: alexandre.belloni@bootlin.com)
        by relay12.mail.gandi.net (Postfix) with ESMTPSA id 73404200004;
        Wed, 25 Mar 2020 09:55:16 +0000 (UTC)
Date:   Wed, 25 Mar 2020 10:55:16 +0100
From:   Alexandre Belloni <alexandre.belloni@bootlin.com>
To:     =?utf-8?B?TWljaGHFgiBNaXJvc8WCYXc=?= <mirq-linux@rere.qmqm.pl>
Cc:     Ludovic Desroches <ludovic.desroches@microchip.com>,
        Michael Turquette <mturquette@baylibre.com>,
        Nicolas Ferre <nicolas.ferre@microchip.com>,
        Stephen Boyd <sboyd@kernel.org>, linux-clk@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 3/3] clk: at91: sama5d2: allow setting all PMC clock
 parents via DT
Message-ID: <20200325095516.GT5504@piout.net>
References: <cover.1584825247.git.mirq-linux@rere.qmqm.pl>
 <135082dfafaa8bc106286dfbe7dd94b708c33f4b.1584825247.git.mirq-linux@rere.qmqm.pl>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <135082dfafaa8bc106286dfbe7dd94b708c33f4b.1584825247.git.mirq-linux@rere.qmqm.pl>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 21/03/2020 22:18:04+0100, Michał Mirosław wrote:
> We need to have clocks accessible via phandle to select them
> as peripheral clock parent using assigned-clock-parents in DT.
> PLLACK and AUDIOPLLCK were missing for sama5d2. Add them.
> 

If we go this route, because PLLA is available on all the SoC then it
makes sense adding it in all the PMC drivers instead of just the
sama5d2.

> Signed-off-by: Michał Mirosław <mirq-linux@rere.qmqm.pl>
> ---
> v2: rebase to clk/clk-at91 branch
> v3: no changes
> ---
>  drivers/clk/at91/sama5d2.c       | 6 +++++-
>  include/dt-bindings/clock/at91.h | 2 ++
>  2 files changed, 7 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/clk/at91/sama5d2.c b/drivers/clk/at91/sama5d2.c
> index ae5e83cadb3d..b3fa2291ccd8 100644
> --- a/drivers/clk/at91/sama5d2.c
> +++ b/drivers/clk/at91/sama5d2.c
> @@ -166,7 +166,7 @@ static void __init sama5d2_pmc_setup(struct device_node *np)
>  	if (IS_ERR(regmap))
>  		return;
>  
> -	sama5d2_pmc = pmc_data_allocate(PMC_I2S1_MUX + 1,
> +	sama5d2_pmc = pmc_data_allocate(PMC_AUDIOPLLCK + 1,
>  					nck(sama5d2_systemck),
>  					nck(sama5d2_periph32ck),
>  					nck(sama5d2_gck), 3);
> @@ -202,6 +202,8 @@ static void __init sama5d2_pmc_setup(struct device_node *np)
>  	if (IS_ERR(hw))
>  		goto err_free;
>  
> +	sama5d2_pmc->chws[PMC_PLLACK] = hw;
> +
>  	hw = at91_clk_register_audio_pll_frac(regmap, "audiopll_fracck",
>  					      "mainck");
>  	if (IS_ERR(hw))
> @@ -217,6 +219,8 @@ static void __init sama5d2_pmc_setup(struct device_node *np)
>  	if (IS_ERR(hw))
>  		goto err_free;
>  
> +	sama5d2_pmc->chws[PMC_AUDIOPLLCK] = hw;
> +
>  	regmap_sfr = syscon_regmap_lookup_by_compatible("atmel,sama5d2-sfr");
>  	if (IS_ERR(regmap_sfr))
>  		regmap_sfr = NULL;
> diff --git a/include/dt-bindings/clock/at91.h b/include/dt-bindings/clock/at91.h
> index c3f4aa6a2d29..e57362e98129 100644
> --- a/include/dt-bindings/clock/at91.h
> +++ b/include/dt-bindings/clock/at91.h
> @@ -21,6 +21,8 @@
>  #define PMC_MCK2		4
>  #define PMC_I2S0_MUX		5
>  #define PMC_I2S1_MUX		6
> +#define PMC_PLLACK		7
> +#define PMC_AUDIOPLLCK		8
>  
>  #ifndef AT91_PMC_MOSCS
>  #define AT91_PMC_MOSCS		0		/* MOSCS Flag */
> -- 
> 2.20.1
> 

-- 
Alexandre Belloni, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com
