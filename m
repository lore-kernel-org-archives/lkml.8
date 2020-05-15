Return-Path: <SRS0=BsgQ=65=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D9D72C433DF
	for <linux-kernel@archiver.kernel.org>; Fri, 15 May 2020 15:40:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id BA697207C3
	for <linux-kernel@archiver.kernel.org>; Fri, 15 May 2020 15:40:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726388AbgEOPj7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 15 May 2020 11:39:59 -0400
Received: from relay10.mail.gandi.net ([217.70.178.230]:50141 "EHLO
        relay10.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726248AbgEOPj7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 May 2020 11:39:59 -0400
Received: from localhost (lfbn-lyo-1-1912-bdcst.w90-65.abo.wanadoo.fr [90.65.91.255])
        (Authenticated sender: alexandre.belloni@bootlin.com)
        by relay10.mail.gandi.net (Postfix) with ESMTPSA id 22947240005;
        Fri, 15 May 2020 15:39:57 +0000 (UTC)
Date:   Fri, 15 May 2020 17:39:56 +0200
From:   Alexandre Belloni <alexandre.belloni@bootlin.com>
To:     Codrin Ciubotariu <codrin.ciubotariu@microchip.com>
Cc:     linux-clk@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, mturquette@baylibre.com,
        sboyd@kernel.org, nicolas.ferre@microchip.com,
        ludovic.desroches@microchip.com, eugen.hristev@microchip.com
Subject: Re: [PATCH] ARM: dts: at91: Configure SCL gpio of i2c2 node as open
 drain
Message-ID: <20200515153956.GX34497@piout.net>
References: <20200515153239.323944-1-codrin.ciubotariu@microchip.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200515153239.323944-1-codrin.ciubotariu@microchip.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 15/05/2020 18:32:39+0300, Codrin Ciubotariu wrote:
> The SCL gpio pin of i2c2 node used for recovery needs to be configured as
> open drain.
> 
> Fixes: 455fec938bbb ("ARM: dts: at91: sama5d2: add i2c gpio pinctrl")
> Signed-off-by: Codrin Ciubotariu <codrin.ciubotariu@microchip.com>
> ---
>  arch/arm/boot/dts/at91-sama5d2_xplained.dts | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 

Squashed in the previous one, thanks.

> diff --git a/arch/arm/boot/dts/at91-sama5d2_xplained.dts b/arch/arm/boot/dts/at91-sama5d2_xplained.dts
> index 5846720fc9dc..851b8587068b 100644
> --- a/arch/arm/boot/dts/at91-sama5d2_xplained.dts
> +++ b/arch/arm/boot/dts/at91-sama5d2_xplained.dts
> @@ -344,7 +344,7 @@ i2c2: i2c@600 {
>  					pinctrl-0 = <&pinctrl_flx0_default>;
>  					pinctrl-1 = <&pinctrl_i2c2_gpio>;
>  					sda-gpios = <&pioA PIN_PB28 GPIO_ACTIVE_HIGH>;
> -					scl-gpios = <&pioA PIN_PB29 GPIO_ACTIVE_HIGH>;
> +					scl-gpios = <&pioA PIN_PB29 (GPIO_ACTIVE_HIGH | GPIO_OPEN_DRAIN)>;
>  					i2c-sda-hold-time-ns = <350>;
>  					i2c-analog-filter;
>  					i2c-digital-filter;
> -- 
> 2.25.1
> 

-- 
Alexandre Belloni, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com
