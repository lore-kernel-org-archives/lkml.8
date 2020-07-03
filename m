Return-Path: <SRS0=gItQ=AO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 74DECC433DF
	for <linux-kernel@archiver.kernel.org>; Fri,  3 Jul 2020 08:59:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 57C4A207DA
	for <linux-kernel@archiver.kernel.org>; Fri,  3 Jul 2020 08:59:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726513AbgGCI7A (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 3 Jul 2020 04:59:00 -0400
Received: from relay4-d.mail.gandi.net ([217.70.183.196]:39501 "EHLO
        relay4-d.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726482AbgGCI7A (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 Jul 2020 04:59:00 -0400
X-Originating-IP: 86.202.118.225
Received: from localhost (lfbn-lyo-1-23-225.w86-202.abo.wanadoo.fr [86.202.118.225])
        (Authenticated sender: alexandre.belloni@bootlin.com)
        by relay4-d.mail.gandi.net (Postfix) with ESMTPSA id E9876E0012;
        Fri,  3 Jul 2020 08:58:55 +0000 (UTC)
Date:   Fri, 3 Jul 2020 10:58:55 +0200
From:   Alexandre Belloni <alexandre.belloni@bootlin.com>
To:     Ahmad Fatoum <a.fatoum@pengutronix.de>
Cc:     Nicolas Ferre <nicolas.ferre@microchip.com>,
        Ludovic Desroches <ludovic.desroches@microchip.com>,
        Stephen Boyd <sboyd@kernel.org>, kernel@pengutronix.de,
        Michael Turquette <mturquette@baylibre.com>,
        linux-clk@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] clk: at91: fix possible dead lock in new drivers
Message-ID: <20200703085855.GD6538@piout.net>
References: <20200703073236.23923-1-a.fatoum@pengutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200703073236.23923-1-a.fatoum@pengutronix.de>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 03/07/2020 09:32:35+0200, Ahmad Fatoum wrote:
> syscon_node_to_regmap() will make the created regmap get and enable the
> first clock it can parse from the device tree. This clock is not needed to
> access the registers and should not be enabled at that time.
> 
> Use device_node_to_regmap to resolve this as it looks up the regmap in
> the same list but doesn't care about the clocks. This issue is detected
> by lockdep when booting the sama5d3 with a device tree containing the
> new clk bindings.
> 
> This fix already happened in 6956eb33abb5 ("clk: at91: fix possible
> deadlock") for the drivers that had been migrated to the new clk binding
> back then. This does the same for the new drivers as well.
> 
> Fixes: 01e2113de9a5 ("clk: at91: add sam9x60 pmc driver")
> Signed-off-by: Ahmad Fatoum <a.fatoum@pengutronix.de>
Acked-by: Alexandre Belloni <alexandre.belloni@bootlin.com>

> ---
> Only boot tested on the sama5d3.
> ---
>  drivers/clk/at91/at91sam9g45.c | 2 +-
>  drivers/clk/at91/at91sam9n12.c | 2 +-
>  drivers/clk/at91/sam9x60.c     | 2 +-
>  drivers/clk/at91/sama5d3.c     | 2 +-
>  4 files changed, 4 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/clk/at91/at91sam9g45.c b/drivers/clk/at91/at91sam9g45.c
> index 9873b583c260..fe9d391adeba 100644
> --- a/drivers/clk/at91/at91sam9g45.c
> +++ b/drivers/clk/at91/at91sam9g45.c
> @@ -111,7 +111,7 @@ static void __init at91sam9g45_pmc_setup(struct device_node *np)
>  		return;
>  	mainxtal_name = of_clk_get_parent_name(np, i);
>  
> -	regmap = syscon_node_to_regmap(np);
> +	regmap = device_node_to_regmap(np);
>  	if (IS_ERR(regmap))
>  		return;
>  
> diff --git a/drivers/clk/at91/at91sam9n12.c b/drivers/clk/at91/at91sam9n12.c
> index 630dc5d87171..4aa97e672bd6 100644
> --- a/drivers/clk/at91/at91sam9n12.c
> +++ b/drivers/clk/at91/at91sam9n12.c
> @@ -124,7 +124,7 @@ static void __init at91sam9n12_pmc_setup(struct device_node *np)
>  		return;
>  	mainxtal_name = of_clk_get_parent_name(np, i);
>  
> -	regmap = syscon_node_to_regmap(np);
> +	regmap = device_node_to_regmap(np);
>  	if (IS_ERR(regmap))
>  		return;
>  
> diff --git a/drivers/clk/at91/sam9x60.c b/drivers/clk/at91/sam9x60.c
> index 3e20aa68259f..2b4c67485eee 100644
> --- a/drivers/clk/at91/sam9x60.c
> +++ b/drivers/clk/at91/sam9x60.c
> @@ -178,7 +178,7 @@ static void __init sam9x60_pmc_setup(struct device_node *np)
>  		return;
>  	mainxtal_name = of_clk_get_parent_name(np, i);
>  
> -	regmap = syscon_node_to_regmap(np);
> +	regmap = device_node_to_regmap(np);
>  	if (IS_ERR(regmap))
>  		return;
>  
> diff --git a/drivers/clk/at91/sama5d3.c b/drivers/clk/at91/sama5d3.c
> index 5e4e44dd4c37..5609b04e6565 100644
> --- a/drivers/clk/at91/sama5d3.c
> +++ b/drivers/clk/at91/sama5d3.c
> @@ -121,7 +121,7 @@ static void __init sama5d3_pmc_setup(struct device_node *np)
>  		return;
>  	mainxtal_name = of_clk_get_parent_name(np, i);
>  
> -	regmap = syscon_node_to_regmap(np);
> +	regmap = device_node_to_regmap(np);
>  	if (IS_ERR(regmap))
>  		return;
>  
> -- 
> 2.27.0
> 

-- 
Alexandre Belloni, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com
