Return-Path: <SRS0=w5GM=A4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.0 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B0F68C433E1
	for <linux-kernel@archiver.kernel.org>; Fri, 17 Jul 2020 09:11:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 94F0020684
	for <linux-kernel@archiver.kernel.org>; Fri, 17 Jul 2020 09:11:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726769AbgGQJLO (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 17 Jul 2020 05:11:14 -0400
Received: from relay11.mail.gandi.net ([217.70.178.231]:32769 "EHLO
        relay11.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725912AbgGQJLM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Jul 2020 05:11:12 -0400
Received: from localhost (lfbn-lyo-1-1676-121.w90-65.abo.wanadoo.fr [90.65.108.121])
        (Authenticated sender: alexandre.belloni@bootlin.com)
        by relay11.mail.gandi.net (Postfix) with ESMTPSA id 545E4100016;
        Fri, 17 Jul 2020 09:11:05 +0000 (UTC)
Date:   Fri, 17 Jul 2020 11:11:05 +0200
From:   Alexandre Belloni <alexandre.belloni@bootlin.com>
To:     Claudiu Beznea <claudiu.beznea@microchip.com>
Cc:     mturquette@baylibre.com, sboyd@kernel.org,
        nicolas.ferre@microchip.com, ludovic.desroches@microchip.com,
        bbrezillon@kernel.org, linux-kernel@vger.kernel.org,
        linux-clk@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH 03/19] clk: at91: clk-sam9x60-pll: fix mul mask
Message-ID: <20200717091105.GK3428@piout.net>
References: <1594812267-6697-1-git-send-email-claudiu.beznea@microchip.com>
 <1594812267-6697-4-git-send-email-claudiu.beznea@microchip.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1594812267-6697-4-git-send-email-claudiu.beznea@microchip.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 15/07/2020 14:24:11+0300, Claudiu Beznea wrote:
> According to datasheet mul mask is on bits 31..24.
> 
> Fixes: a436c2a447e59 ("clk: at91: add sam9x60 PLL driver")
> Signed-off-by: Claudiu Beznea <claudiu.beznea@microchip.com>
Reviewed-by: Alexandre Belloni <alexandre.belloni@bootlin.com>

> ---
>  drivers/clk/at91/clk-sam9x60-pll.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/clk/at91/clk-sam9x60-pll.c b/drivers/clk/at91/clk-sam9x60-pll.c
> index e699803986e5..3522eae2edd6 100644
> --- a/drivers/clk/at91/clk-sam9x60-pll.c
> +++ b/drivers/clk/at91/clk-sam9x60-pll.c
> @@ -15,7 +15,7 @@
>  #include "pmc.h"
>  
>  #define	PMC_PLL_CTRL0_DIV_MSK	GENMASK(7, 0)
> -#define	PMC_PLL_CTRL1_MUL_MSK	GENMASK(30, 24)
> +#define	PMC_PLL_CTRL1_MUL_MSK	GENMASK(31, 24)
>  
>  #define PLL_DIV_MAX		(FIELD_GET(PMC_PLL_CTRL0_DIV_MSK, UINT_MAX) + 1)
>  #define UPLL_DIV		2
> -- 
> 2.7.4
> 

-- 
Alexandre Belloni, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com
