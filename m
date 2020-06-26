Return-Path: <SRS0=rtH4=AH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 676AFC433E0
	for <linux-kernel@archiver.kernel.org>; Fri, 26 Jun 2020 20:58:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 47F8320720
	for <linux-kernel@archiver.kernel.org>; Fri, 26 Jun 2020 20:58:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725900AbgFZU6u (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 26 Jun 2020 16:58:50 -0400
Received: from relay6-d.mail.gandi.net ([217.70.183.198]:52951 "EHLO
        relay6-d.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725793AbgFZU6u (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 Jun 2020 16:58:50 -0400
X-Originating-IP: 86.202.110.81
Received: from localhost (lfbn-lyo-1-15-81.w86-202.abo.wanadoo.fr [86.202.110.81])
        (Authenticated sender: alexandre.belloni@bootlin.com)
        by relay6-d.mail.gandi.net (Postfix) with ESMTPSA id ABA74C0003;
        Fri, 26 Jun 2020 20:58:47 +0000 (UTC)
Date:   Fri, 26 Jun 2020 22:58:47 +0200
From:   Alexandre Belloni <alexandre.belloni@bootlin.com>
To:     Claudiu Beznea <claudiu.beznea@microchip.com>
Cc:     mturquette@baylibre.com, sboyd@kernel.org,
        nicolas.ferre@microchip.com, ludovic.desroches@microchip.com,
        linux-kernel@vger.kernel.org, mturquette@linaro.org,
        bbrezillon@kernel.org, linux-clk@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH 1/2] clk: at91: remove the checking of parent_name
Message-ID: <20200626205847.GW131826@piout.net>
References: <1593079768-9349-1-git-send-email-claudiu.beznea@microchip.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1593079768-9349-1-git-send-email-claudiu.beznea@microchip.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 25/06/2020 13:09:27+0300, Claudiu Beznea wrote:
> There is no need to check parent_name variable while assigning it to
> init.parent_names. parent_name variable is already checked at
> the beginning of at91_clk_register_sam9x5_peripheral() function.
> Same thing with init.num_parents: it could only be 1.
> 
> Fixes: 6114067e437eb ("clk: at91: add PMC peripheral clocks")
> Signed-off-by: Claudiu Beznea <claudiu.beznea@microchip.com>
Reviewed-by: Alexandre Belloni <alexandre.belloni@bootlin.com>

> ---
>  drivers/clk/at91/clk-peripheral.c | 8 ++++----
>  1 file changed, 4 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/clk/at91/clk-peripheral.c b/drivers/clk/at91/clk-peripheral.c
> index c2ab4860a2bf..4a0f40738fe3 100644
> --- a/drivers/clk/at91/clk-peripheral.c
> +++ b/drivers/clk/at91/clk-peripheral.c
> @@ -111,8 +111,8 @@ at91_clk_register_peripheral(struct regmap *regmap, const char *name,
>  
>  	init.name = name;
>  	init.ops = &peripheral_ops;
> -	init.parent_names = (parent_name ? &parent_name : NULL);
> -	init.num_parents = (parent_name ? 1 : 0);
> +	init.parent_names = &parent_name;
> +	init.num_parents = 1;
>  	init.flags = 0;
>  
>  	periph->id = id;
> @@ -340,8 +340,8 @@ at91_clk_register_sam9x5_peripheral(struct regmap *regmap, spinlock_t *lock,
>  
>  	init.name = name;
>  	init.ops = &sam9x5_peripheral_ops;
> -	init.parent_names = (parent_name ? &parent_name : NULL);
> -	init.num_parents = (parent_name ? 1 : 0);
> +	init.parent_names = &parent_name;
> +	init.num_parents = 1;
>  	init.flags = 0;
>  
>  	periph->id = id;
> -- 
> 2.7.4
> 

-- 
Alexandre Belloni, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com
