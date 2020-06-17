Return-Path: <SRS0=qsSF=76=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7A61AC433DF
	for <linux-kernel@archiver.kernel.org>; Wed, 17 Jun 2020 21:34:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5C9192184D
	for <linux-kernel@archiver.kernel.org>; Wed, 17 Jun 2020 21:34:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727029AbgFQVer (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 17 Jun 2020 17:34:47 -0400
Received: from relay6-d.mail.gandi.net ([217.70.183.198]:54827 "EHLO
        relay6-d.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726763AbgFQVer (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 Jun 2020 17:34:47 -0400
X-Originating-IP: 86.202.110.81
Received: from localhost (lfbn-lyo-1-15-81.w86-202.abo.wanadoo.fr [86.202.110.81])
        (Authenticated sender: alexandre.belloni@bootlin.com)
        by relay6-d.mail.gandi.net (Postfix) with ESMTPSA id 90FF2C0003;
        Wed, 17 Jun 2020 21:34:38 +0000 (UTC)
Date:   Wed, 17 Jun 2020 23:34:38 +0200
From:   Alexandre Belloni <alexandre.belloni@bootlin.com>
To:     Codrin Ciubotariu <codrin.ciubotariu@microchip.com>
Cc:     devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, robh+dt@kernel.org,
        nicolas.ferre@microchip.com, ludovic.desroches@microchip.com,
        claudiu.beznea@microchip.com
Subject: Re: [PATCH 3/3] Revert "ARM: at91/dt: sama5d2 Xplained: add pdmic
 node"
Message-ID: <20200617213438.GF3675@piout.net>
References: <20200615095525.43414-1-codrin.ciubotariu@microchip.com>
 <20200615095525.43414-3-codrin.ciubotariu@microchip.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200615095525.43414-3-codrin.ciubotariu@microchip.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

The correct subject line prefix is "ARM: dts: at91:"

On 15/06/2020 12:55:25+0300, Codrin Ciubotariu wrote:
> There are no PDM microphones on SAMA5D2 Xplained, to exercize the
> PDMIC.
> 
> This reverts commit ca6349a8c51f2e3d6f2acdb36431e7d7328261f7.
> 
> Signed-off-by: Codrin Ciubotariu <codrin.ciubotariu@microchip.com>
> ---
>  arch/arm/boot/dts/at91-sama5d2_xplained.dts | 16 ----------------
>  1 file changed, 16 deletions(-)
> 

This patch doesn't apply and I think you'll have to motivate the removal
a bit more because this seems like a change of policy to me.

> diff --git a/arch/arm/boot/dts/at91-sama5d2_xplained.dts b/arch/arm/boot/dts/at91-sama5d2_xplained.dts
> index 54d96649da77..c0a255bda477 100644
> --- a/arch/arm/boot/dts/at91-sama5d2_xplained.dts
> +++ b/arch/arm/boot/dts/at91-sama5d2_xplained.dts
> @@ -109,16 +109,6 @@ timer1: timer@1 {
>  				};
>  			};
>  
> -			pdmic@f8018000 {
> -				pinctrl-names = "default";
> -				pinctrl-0 = <&pinctrl_pdmic_default>;
> -				atmel,model = "PDMIC @ sama5d2_xplained";
> -				atmel,mic-min-freq = <1000000>;
> -				atmel,mic-max-freq = <3246000>;
> -				atmel,mic-offset = <0x0>;
> -				status = "okay";
> -			};
> -
>  			uart1: serial@f8020000 {
>  				pinctrl-names = "default";
>  				pinctrl-0 = <&pinctrl_uart1_default>;
> @@ -533,12 +523,6 @@ pinctrl_macb0_phy_irq: macb0_phy_irq {
>  					bias-disable;
>  				};
>  
> -				pinctrl_pdmic_default: pdmic_default {
> -					pinmux = <PIN_PB26__PDMIC_DAT>,
> -						<PIN_PB27__PDMIC_CLK>;
> -					bias-disable;
> -				};
> -
>  				pinctrl_sdmmc0_default: sdmmc0_default {
>  					cmd_data {
>  						pinmux = <PIN_PA1__SDMMC0_CMD>,
> -- 
> 2.25.1
> 

-- 
Alexandre Belloni, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com
