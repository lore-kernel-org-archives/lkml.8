Return-Path: <SRS0=w5GM=A4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.0 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 361B9C433DF
	for <linux-kernel@archiver.kernel.org>; Fri, 17 Jul 2020 09:13:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1D4352070E
	for <linux-kernel@archiver.kernel.org>; Fri, 17 Jul 2020 09:13:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726557AbgGQJNa (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 17 Jul 2020 05:13:30 -0400
Received: from relay1-d.mail.gandi.net ([217.70.183.193]:36455 "EHLO
        relay1-d.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725864AbgGQJNa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Jul 2020 05:13:30 -0400
X-Originating-IP: 90.65.108.121
Received: from localhost (lfbn-lyo-1-1676-121.w90-65.abo.wanadoo.fr [90.65.108.121])
        (Authenticated sender: alexandre.belloni@bootlin.com)
        by relay1-d.mail.gandi.net (Postfix) with ESMTPSA id 922C0240017;
        Fri, 17 Jul 2020 09:13:27 +0000 (UTC)
Date:   Fri, 17 Jul 2020 11:13:27 +0200
From:   Alexandre Belloni <alexandre.belloni@bootlin.com>
To:     Claudiu Beznea <claudiu.beznea@microchip.com>
Cc:     mturquette@baylibre.com, sboyd@kernel.org,
        nicolas.ferre@microchip.com, ludovic.desroches@microchip.com,
        bbrezillon@kernel.org, linux-kernel@vger.kernel.org,
        linux-clk@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH 05/19] clk: at91: sam9x60-pll: use logical or for range
 check
Message-ID: <20200717091327.GM3428@piout.net>
References: <1594812267-6697-1-git-send-email-claudiu.beznea@microchip.com>
 <1594812267-6697-6-git-send-email-claudiu.beznea@microchip.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1594812267-6697-6-git-send-email-claudiu.beznea@microchip.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 15/07/2020 14:24:13+0300, Claudiu Beznea wrote:
> Use logical or for range check. In case bestrate is not in
> characteristics->output[0].min..characteristics->output[0].max
> range we should return -ERANGE.
> 
> Fixes: a436c2a447e59 ("clk: at91: add sam9x60 PLL driver")
> Signed-off-by: Claudiu Beznea <claudiu.beznea@microchip.com>
Reviewed-by: Alexandre Belloni <alexandre.belloni@bootlin.com>

> ---
>  drivers/clk/at91/clk-sam9x60-pll.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/clk/at91/clk-sam9x60-pll.c b/drivers/clk/at91/clk-sam9x60-pll.c
> index d3152c0afcbf..dfb91c190bd1 100644
> --- a/drivers/clk/at91/clk-sam9x60-pll.c
> +++ b/drivers/clk/at91/clk-sam9x60-pll.c
> @@ -232,7 +232,7 @@ static long sam9x60_pll_get_best_div_mul(struct sam9x60_pll *pll,
>  	}
>  
>  	/* Check if bestrate is a valid output rate  */
> -	if (bestrate < characteristics->output[0].min &&
> +	if (bestrate < characteristics->output[0].min ||
>  	    bestrate > characteristics->output[0].max)
>  		return -ERANGE;
>  
> -- 
> 2.7.4
> 

-- 
Alexandre Belloni, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com
