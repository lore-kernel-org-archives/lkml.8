Return-Path: <SRS0=N8G3=3G=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 71563C33CB6
	for <linux-kernel@archiver.kernel.org>; Fri, 17 Jan 2020 21:29:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4A36C2072E
	for <linux-kernel@archiver.kernel.org>; Fri, 17 Jan 2020 21:29:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729262AbgAQV3W (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 17 Jan 2020 16:29:22 -0500
Received: from relay11.mail.gandi.net ([217.70.178.231]:43619 "EHLO
        relay11.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728249AbgAQV3W (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Jan 2020 16:29:22 -0500
Received: from localhost (lfbn-lyo-1-1913-102.w90-65.abo.wanadoo.fr [90.65.92.102])
        (Authenticated sender: alexandre.belloni@bootlin.com)
        by relay11.mail.gandi.net (Postfix) with ESMTPSA id 80FDC100008;
        Fri, 17 Jan 2020 21:29:20 +0000 (UTC)
Date:   Fri, 17 Jan 2020 22:29:20 +0100
From:   Alexandre Belloni <alexandre.belloni@bootlin.com>
To:     Claudiu Beznea <claudiu.beznea@microchip.com>
Cc:     mturquette@baylibre.com, sboyd@kernel.org,
        nicolas.ferre@microchip.com, ludovic.desroches@microchip.com,
        linux-clk@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 4/4] clk: at91: usb: introduce num_parents in driver's
 structure
Message-ID: <20200117212920.GC3036@piout.net>
References: <1579261009-4573-1-git-send-email-claudiu.beznea@microchip.com>
 <1579261009-4573-5-git-send-email-claudiu.beznea@microchip.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1579261009-4573-5-git-send-email-claudiu.beznea@microchip.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 17/01/2020 13:36:49+0200, Claudiu Beznea wrote:
> SAM9X60 USB clock may have up to 3 parents. Save the number of parents in
> driver's data structure and validate against it when setting parent.
> 
> Signed-off-by: Claudiu Beznea <claudiu.beznea@microchip.com>
Acked-by: Alexandre Belloni <alexandre.belloni@bootlin.com>

> ---
>  drivers/clk/at91/clk-usb.c | 4 +++-
>  1 file changed, 3 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/clk/at91/clk-usb.c b/drivers/clk/at91/clk-usb.c
> index c0895c993cce..31d5c45e30d7 100644
> --- a/drivers/clk/at91/clk-usb.c
> +++ b/drivers/clk/at91/clk-usb.c
> @@ -25,6 +25,7 @@ struct at91sam9x5_clk_usb {
>  	struct clk_hw hw;
>  	struct regmap *regmap;
>  	u32 usbs_mask;
> +	u8 num_parents;
>  };
>  
>  #define to_at91sam9x5_clk_usb(hw) \
> @@ -110,7 +111,7 @@ static int at91sam9x5_clk_usb_set_parent(struct clk_hw *hw, u8 index)
>  {
>  	struct at91sam9x5_clk_usb *usb = to_at91sam9x5_clk_usb(hw);
>  
> -	if (index > 1)
> +	if (index >= usb->num_parents)
>  		return -EINVAL;
>  
>  	regmap_update_bits(usb->regmap, AT91_PMC_USB, usb->usbs_mask, index);
> @@ -215,6 +216,7 @@ _at91sam9x5_clk_register_usb(struct regmap *regmap, const char *name,
>  	usb->hw.init = &init;
>  	usb->regmap = regmap;
>  	usb->usbs_mask = usbs_mask;
> +	usb->num_parents = num_parents;
>  
>  	hw = &usb->hw;
>  	ret = clk_hw_register(NULL, &usb->hw);
> -- 
> 2.7.4
> 

-- 
Alexandre Belloni, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com
