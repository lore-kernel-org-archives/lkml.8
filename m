Return-Path: <SRS0=ysYr=B3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6510DC433E1
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Aug 2020 10:21:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 388282078E
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Aug 2020 10:21:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727973AbgHQKVt (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 17 Aug 2020 06:21:49 -0400
Received: from relay12.mail.gandi.net ([217.70.178.232]:60481 "EHLO
        relay12.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727952AbgHQKVr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Aug 2020 06:21:47 -0400
Received: from localhost (sto93-h02-176-184-36-142.dsl.sta.abo.bbox.fr [176.184.36.142])
        (Authenticated sender: alexandre.belloni@bootlin.com)
        by relay12.mail.gandi.net (Postfix) with ESMTPSA id E5CC3200002;
        Mon, 17 Aug 2020 10:21:41 +0000 (UTC)
Date:   Mon, 17 Aug 2020 12:21:36 +0200
From:   Alexandre Belloni <alexandre.belloni@bootlin.com>
To:     Reto Schneider <code@reto-schneider.ch>
Cc:     linux-arm-kernel@lists.infradead.org,
        Reto Schneider <reto.schneider@husqvarnagroup.com>,
        Stefan Roese <sr@denx.de>,
        Michael Zimmermann <michael.zimmermann@grandcentrix.net>,
        Rob Herring <robh+dt@kernel.org>,
        Nicolas Ferre <nicolas.ferre@microchip.com>,
        Ludovic Desroches <ludovic.desroches@microchip.com>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>,
        open list <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] ARM: at91: Add GARDENA smart Gateway AT91SAM board
Message-ID: <20200817102136.GC4500@piout.net>
References: <20200810171921.8679-1-code@reto-schneider.ch>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200810171921.8679-1-code@reto-schneider.ch>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

Thank you for this submission.

On 10/08/2020 19:19:19+0200, Reto Schneider wrote:
> From: Reto Schneider <reto.schneider@husqvarnagroup.com>
> 
> This patch adds support for the GARDENA smart Gateway, which is based on
> the Atmel AT91SAM9G25. It is equipped with 128 MiB of DDR2 RAM and
> 256 MiB NAND storage.
> 
> Please note that this gateway is not actually based on a AT91SAM9x5 EK
> board, but is close enough to allow its DT to be used.
> 
> Co-developed-by: Stefan Roese <sr@denx.de>
> Signed-off-by: Stefan Roese <sr@denx.de>
> Co-developed-by: Michael Zimmermann <michael.zimmermann@grandcentrix.net>
> Signed-off-by: Michael Zimmermann <michael.zimmermann@grandcentrix.net>
> Signed-off-by: Reto Schneider <reto.schneider@husqvarnagroup.com>
> ---
>  arch/arm/boot/dts/Makefile                    |   1 +
>  .../dts/at91sam9g25-gardena-smart-gateway.dts | 186 ++++++++++++++++++
>  2 files changed, 187 insertions(+)
>  create mode 100644 arch/arm/boot/dts/at91sam9g25-gardena-smart-gateway.dts
> 
> diff --git a/arch/arm/boot/dts/Makefile b/arch/arm/boot/dts/Makefile
> index 4572db3fa5ae..d38d256f59fa 100644
> --- a/arch/arm/boot/dts/Makefile
> +++ b/arch/arm/boot/dts/Makefile
> @@ -44,6 +44,7 @@ dtb-$(CONFIG_SOC_AT91SAM9) += \
>  	at91-wb45n.dtb \
>  	at91sam9g15ek.dtb \
>  	at91sam9g25ek.dtb \
> +	at91sam9g25-gardena-smart-gateway.dtb \
>  	at91sam9g35ek.dtb \
>  	at91sam9x25ek.dtb \
>  	at91sam9x35ek.dtb
> diff --git a/arch/arm/boot/dts/at91sam9g25-gardena-smart-gateway.dts b/arch/arm/boot/dts/at91sam9g25-gardena-smart-gateway.dts
> new file mode 100644
> index 000000000000..19b0f67a7af6
> --- /dev/null
> +++ b/arch/arm/boot/dts/at91sam9g25-gardena-smart-gateway.dts
> @@ -0,0 +1,186 @@
> +// SPDX-License-Identifier: GPL-2.0+
> +/*
> + * Device Tree file for the GARDENA smart Gateway (AT91SAM)
> + *
> + *  Copyright (C) 2020 GARDENA GmbH
> + */
> +
> +/dts-v1/;
> +
> +#include "at91sam9g25.dtsi"
> +#include "at91sam9x5ek.dtsi"
> +#include <dt-bindings/input/input.h>
> +
> +/ {
> +	model = "GARDENA smart Gateway (AT91SAM)";
> +	compatible = "gardena,smart-gateway-at91sam", "atmel,at91sam9g25", "atmel,at91sam9x5", "atmel,at91sam9";

You should document the vendor string. And ideally,
gardena,smart-gateway-at91sam should be documented in
Documentation/devicetree/bindings/arm/atmel-at91.yaml

> +
> +	aliases {
> +		serial1 = &usart3;
> +	};
> +
> +	chosen {
> +		stdout-path = "serial0:115200n8";

This is already in at91sam9x5ek.dtsi

> +	};
> +
> +	memory {
> +		reg = <0x20000000 0x8000000>;

This is already in at91sam9x5cm.dtsi, included fromat91sam9x5ek.dtsi

> +	};
> +
> +	gpio-keys {
> +		compatible = "gpio-keys";
> +
> +		user_btn1 {
> +			label = "USER_BTN1";
> +			gpios = <&pioA 24 GPIO_ACTIVE_LOW>;
> +			linux,code = <KEY_PROG1>;
> +		};
> +	};
> +
> +	1wire_cm {
> +		status = "disabled";
> +	};
> +
> +	leds {
> +		compatible = "gpio-leds";
> +
> +		power_blue {
> +			label = "smartgw:power:blue";
> +			gpios = <&pioC 21 GPIO_ACTIVE_HIGH>;
> +			default-state = "off";
> +		};
> +
> +		power_green {
> +			label = "smartgw:power:green";
> +			gpios = <&pioC 20 GPIO_ACTIVE_HIGH>;
> +			default-state = "on";
> +		};
> +
> +		power_red {
> +			label = "smartgw:power:red";
> +			gpios = <&pioC 19 GPIO_ACTIVE_HIGH>;
> +			default-state = "off";
> +		};
> +
> +		radio_blue {
> +			label = "smartgw:radio:blue";
> +			gpios = <&pioC 18 GPIO_ACTIVE_HIGH>;
> +			default-state = "off";
> +		};
> +
> +		radio_green {
> +			label = "smartgw:radio:green";
> +			gpios = <&pioC 17 GPIO_ACTIVE_HIGH>;
> +			default-state = "off";
> +		};
> +
> +		radio_red {
> +			label = "smartgw:radio:red";
> +			gpios = <&pioC 16 GPIO_ACTIVE_HIGH>;
> +			default-state = "off";
> +		};
> +
> +		internet_blue {
> +			label = "smartgw:internet:blue";
> +			gpios = <&pioC 15 GPIO_ACTIVE_HIGH>;
> +			default-state = "off";
> +		};
> +
> +		internet_green {
> +			label = "smartgw:internet:green";
> +			gpios = <&pioC 14 GPIO_ACTIVE_HIGH>;
> +			default-state = "off";
> +		};
> +
> +		internet_red {
> +			label = "smartgw:internet:red";
> +			gpios = <&pioC 13 GPIO_ACTIVE_HIGH>;
> +			default-state = "off";
> +		};
> +
> +		heartbeat {
> +			label = "smartgw:heartbeat";
> +			gpios = <&pioB 8 GPIO_ACTIVE_HIGH>;
> +			linux,default-trigger = "heartbeat";
> +		};
> +
> +		pb18 {
> +			status = "disabled";
> +		};
> +
> +		pd21 {
> +			status = "disabled";
> +		};
> +	};
> +};
> +
> +&dbgu {
> +	status = "okay";
> +};

This is already in at91sam9x5ek.dtsi and is duplicated below

> +
> +&macb0 {
> +	phy-mode = "rmii";
> +	status = "okay";
> +};
> +
> +&nand_controller {
> +	status = "okay";

This is already in at91sam9x5cm.dtsi

> +};
> +
> +&usb0 {
> +	status = "okay";
> +	num-ports = <3>;

This is already in at91sam9x5ek.dtsi

> +};
> +
> +&usb1 {
> +	status = "okay";
This is already in at91sam9x5ek.dtsi
> +};
> +
> +&usart0 {
> +	status = "disabled";
> +};
> +
> +&usart2 {
> +	status = "disabled";
> +};
> +
> +&dbgu {
> +	status = "okay";
> +};
> +
> +&usart3 {
> +	status = "okay";
> +
> +	pinctrl-0 = <&pinctrl_usart3
> +		     &pinctrl_usart3_rts
> +		     &pinctrl_usart3_cts
> +		    >;
> +};
> +
> +&watchdog {
> +	status = "okay";
> +};
> +
> +&mmc0 {
> +	status = "disabled";
> +};
> +
> +&mmc1 {
> +	status = "disabled";
> +};
> +
> +&spi0 {
> +	status = "disabled";
> +};
> +
> +&i2c0 {
> +	status = "disabled";
> +};
> +
> +&adc0 {
> +	status = "disabled";
> +};
> +
> +&ssc0 {
> +	status = "disabled";
> +};

Overall, I'm not convinced it is a good idea to start from
at91sam9x5ek.dtsi as it makes you dtb bigger than necessary but if you
want it that way, I'm fine with that.

-- 
Alexandre Belloni, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com
