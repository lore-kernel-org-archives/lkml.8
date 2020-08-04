Return-Path: <SRS0=pusq=BO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.0 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 16CC7C433E0
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Aug 2020 16:00:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 069A920738
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Aug 2020 16:00:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729157AbgHDQAe (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 4 Aug 2020 12:00:34 -0400
Received: from relay3-d.mail.gandi.net ([217.70.183.195]:48521 "EHLO
        relay3-d.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726037AbgHDQAb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Aug 2020 12:00:31 -0400
X-Originating-IP: 86.202.118.225
Received: from localhost (lfbn-lyo-1-23-225.w86-202.abo.wanadoo.fr [86.202.118.225])
        (Authenticated sender: alexandre.belloni@bootlin.com)
        by relay3-d.mail.gandi.net (Postfix) with ESMTPSA id 20F0E6000C;
        Tue,  4 Aug 2020 16:00:28 +0000 (UTC)
Date:   Tue, 4 Aug 2020 18:00:28 +0200
From:   Alexandre Belloni <alexandre.belloni@bootlin.com>
To:     Claudiu Beznea <claudiu.beznea@microchip.com>
Cc:     mturquette@baylibre.com, sboyd@kernel.org,
        nicolas.ferre@microchip.com, ludovic.desroches@microchip.com,
        mturquette@linaro.org, bbrezillon@kernel.org,
        linux-clk@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] clk: at91: clk-main: update key before writing
 AT91_CKGR_MOR
Message-ID: <20200804160028.GD10725@piout.net>
References: <1596099803-1393-1-git-send-email-claudiu.beznea@microchip.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1596099803-1393-1-git-send-email-claudiu.beznea@microchip.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 30/07/2020 12:03:23+0300, Claudiu Beznea wrote:
> SAMA5D2 datasheet specifies on chapter 33.22.8 (PMC Clock Generator
> Main Oscillator Register) that writing any value other than
> 0x37 on KEY field aborts the write operation. Use the key when
> selecting main clock parent.
> 
> Fixes: 27cb1c2083373 ("clk: at91: rework main clk implementation")
> Signed-off-by: Claudiu Beznea <claudiu.beznea@microchip.com>

Reviewed-by: Alexandre Belloni <alexandre.belloni@bootlin.com>

> ---
>  drivers/clk/at91/clk-main.c | 11 ++++++++---
>  1 file changed, 8 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/clk/at91/clk-main.c b/drivers/clk/at91/clk-main.c
> index 5c83e899084f..cfae2f59df66 100644
> --- a/drivers/clk/at91/clk-main.c
> +++ b/drivers/clk/at91/clk-main.c
> @@ -437,12 +437,17 @@ static int clk_sam9x5_main_set_parent(struct clk_hw *hw, u8 index)
>  		return -EINVAL;
>  
>  	regmap_read(regmap, AT91_CKGR_MOR, &tmp);
> -	tmp &= ~MOR_KEY_MASK;
>  
>  	if (index && !(tmp & AT91_PMC_MOSCSEL))
> -		regmap_write(regmap, AT91_CKGR_MOR, tmp | AT91_PMC_MOSCSEL);
> +		tmp = AT91_PMC_MOSCSEL;
>  	else if (!index && (tmp & AT91_PMC_MOSCSEL))
> -		regmap_write(regmap, AT91_CKGR_MOR, tmp & ~AT91_PMC_MOSCSEL);
> +		tmp = 0;
> +	else
> +		return 0;
> +
> +	regmap_update_bits(regmap, AT91_CKGR_MOR,
> +			   AT91_PMC_MOSCSEL | MOR_KEY_MASK,
> +			   tmp | AT91_PMC_KEY);
>  
>  	while (!clk_sam9x5_main_ready(regmap))
>  		cpu_relax();
> -- 
> 2.7.4
> 

-- 
Alexandre Belloni, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com
