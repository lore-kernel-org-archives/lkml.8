Return-Path: <SRS0=fG1M=4C=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0821AC2BA83
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Feb 2020 08:44:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C663424649
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Feb 2020 08:44:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1581669850;
	bh=Iw3Ml8k1sQrUId5oLMwMuXtZF3l7A5X0eHLT2b4+Kxg=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=IIKtiM+Wc9HppczxfH7G7zuKIsoapzWFmge1m9vWOCHSWIkPUN2NA2Ya0lwF3e6A/
	 yYc2N9AEqmXGdoFuavY4XDrgKkiZ8M0POne5AzNFsC5hj3vJ/71ZRmgmAjIwl1kJXo
	 JzwCcSG5LWsFJkfrW/rERyGRO8kb0gD26P8XRK2s=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728954AbgBNIoK (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 14 Feb 2020 03:44:10 -0500
Received: from mail.kernel.org ([198.145.29.99]:38134 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726179AbgBNIoJ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Feb 2020 03:44:09 -0500
Received: from dragon (80.251.214.228.16clouds.com [80.251.214.228])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id BD3E82187F;
        Fri, 14 Feb 2020 08:44:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1581669848;
        bh=Iw3Ml8k1sQrUId5oLMwMuXtZF3l7A5X0eHLT2b4+Kxg=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=hO0HbIUqNHFtRroYrPOWGs8+GL4z4nAF9qXnN0QK2Zf3ySNH9fJLqz6SuxYVaa2Mu
         OqfpsaYR5I7mQnjjTViEDmwjNQFLFNkyUrI1tkrsGa6aI5UDrCxmSvi8yvTw5uFLq9
         kevuuj0ru1/liMbMh/omQVZRGB1Oscx+kgaRjdPw=
Date:   Fri, 14 Feb 2020 16:44:00 +0800
From:   Shawn Guo <shawnguo@kernel.org>
To:     Oleksandr Suvorov <oleksandr.suvorov@toradex.com>
Cc:     devicetree@vger.kernel.org,
        Marcel Ziswiler <marcel.ziswiler@toradex.com>,
        Igor Opaniuk <igor.opaniuk@toradex.com>,
        Philippe Schenker <philippe.schenker@toradex.com>,
        Fabio Estevam <festevam@gmail.com>,
        Mark Rutland <mark.rutland@arm.com>,
        NXP Linux Team <linux-imx@nxp.com>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Rob Herring <robh+dt@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 6/6] ARM: dts: imx7-colibri: add support for Toradex
 Aster carrier board
Message-ID: <20200214084356.GD25543@dragon>
References: <20200204111151.3426090-1-oleksandr.suvorov@toradex.com>
 <20200204111151.3426090-7-oleksandr.suvorov@toradex.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200204111151.3426090-7-oleksandr.suvorov@toradex.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Feb 04, 2020 at 01:11:51PM +0200, Oleksandr Suvorov wrote:
> Add support for the Toradex Aster carrier board.
> 
> Follow the usual hierarchic include model, maintaining shared
> configuration imx7-colibri-aster.dtsi.
> 
> Signed-off-by: Oleksandr Suvorov <oleksandr.suvorov@toradex.com>
> ---
> 
>  arch/arm/boot/dts/Makefile                    |   3 +
>  arch/arm/boot/dts/imx7-colibri-aster.dtsi     | 191 ++++++++++++++++++
>  arch/arm/boot/dts/imx7-colibri.dtsi           |   2 -
>  arch/arm/boot/dts/imx7d-colibri-aster.dts     |  20 ++
>  .../arm/boot/dts/imx7d-colibri-emmc-aster.dts |  20 ++
>  arch/arm/boot/dts/imx7s-colibri-aster.dts     |  15 ++
>  6 files changed, 249 insertions(+), 2 deletions(-)
>  create mode 100644 arch/arm/boot/dts/imx7-colibri-aster.dtsi
>  create mode 100644 arch/arm/boot/dts/imx7d-colibri-aster.dts
>  create mode 100644 arch/arm/boot/dts/imx7d-colibri-emmc-aster.dts
>  create mode 100644 arch/arm/boot/dts/imx7s-colibri-aster.dts
> 
> diff --git a/arch/arm/boot/dts/Makefile b/arch/arm/boot/dts/Makefile
> index e006fef77499..6165d5d3a008 100644
> --- a/arch/arm/boot/dts/Makefile
> +++ b/arch/arm/boot/dts/Makefile
> @@ -610,6 +610,8 @@ dtb-$(CONFIG_SOC_IMX6UL) += \
>  	imx6ulz-14x14-evk.dtb
>  dtb-$(CONFIG_SOC_IMX7D) += \
>  	imx7d-cl-som-imx7.dtb \
> +	imx7d-colibri-aster.dtb \
> +	imx7d-colibri-emmc-aster.dtb \
>  	imx7d-colibri-emmc-eval-v3.dtb \
>  	imx7d-colibri-eval-v3.dtb \
>  	imx7d-mba7.dtb \
> @@ -623,6 +625,7 @@ dtb-$(CONFIG_SOC_IMX7D) += \
>  	imx7d-sdb-sht11.dtb \
>  	imx7d-zii-rmu2.dtb \
>  	imx7d-zii-rpu2.dtb \
> +	imx7s-colibri-aster.dtb \
>  	imx7s-colibri-eval-v3.dtb \
>  	imx7s-mba7.dtb \
>  	imx7s-warp.dtb
> diff --git a/arch/arm/boot/dts/imx7-colibri-aster.dtsi b/arch/arm/boot/dts/imx7-colibri-aster.dtsi
> new file mode 100644
> index 000000000000..776dacdbbe30
> --- /dev/null
> +++ b/arch/arm/boot/dts/imx7-colibri-aster.dtsi
> @@ -0,0 +1,191 @@
> +// SPDX-License-Identifier: (GPL-2.0 OR X11)

MIT

> +/*
> + * Copyright 2017-2020 Toradex AG
> + *
> + */
> +
> +
> +#include <dt-bindings/input/input.h>
> +#include <dt-bindings/pwm/pwm.h>
> +
> +/ {
> +	chosen {
> +		stdout-path = "serial0:115200n8";
> +	};
> +
> +	gpio-keys {
> +		compatible = "gpio-keys";
> +		pinctrl-names = "default";
> +		pinctrl-0 = <&pinctrl_gpiokeys>;
> +
> +		power {
> +			label = "Wake-Up";
> +			gpios = <&gpio1 1 GPIO_ACTIVE_HIGH>;
> +			linux,code = <KEY_WAKEUP>;
> +			debounce-interval = <10>;
> +			wakeup-source;
> +		};
> +	};
> +
> +	panel: panel {
> +		compatible = "edt,et057090dhu";
> +		backlight = <&bl>;
> +		power-supply = <&reg_3v3>;
> +
> +		port {
> +			panel_in: endpoint {
> +				remote-endpoint = <&lcdif_out>;
> +			};
> +		};
> +	};
> +
> +	reg_3v3: regulator-3v3 {
> +		compatible = "regulator-fixed";
> +		regulator-name = "3.3V";
> +		regulator-min-microvolt = <3300000>;
> +		regulator-max-microvolt = <3300000>;
> +	};
> +
> +	reg_5v0: regulator-5v0 {
> +		compatible = "regulator-fixed";
> +		regulator-name = "5V";
> +		regulator-min-microvolt = <5000000>;
> +		regulator-max-microvolt = <5000000>;
> +	};
> +
> +	reg_usbh_vbus: regulator-usbh-vbus {
> +		compatible = "regulator-fixed";
> +		pinctrl-names = "default";
> +		pinctrl-0 = <&pinctrl_usbh_reg>;
> +		regulator-name = "VCC_USB[1-4]";
> +		regulator-min-microvolt = <5000000>;
> +		regulator-max-microvolt = <5000000>;
> +		gpio = <&gpio4 7 GPIO_ACTIVE_LOW>;
> +		vin-supply = <&reg_5v0>;
> +	};
> +};
> +
> +&bl {
> +	brightness-levels = <0 4 8 16 32 64 128 255>;
> +	default-brightness-level = <6>;
> +	power-supply = <&reg_3v3>;
> +

Drop this newline.

> +	status = "okay";
> +};
> +
> +&adc1 {

Sort nodes alphabetically.

> +	status = "okay";
> +};
> +
> +/*
> + * ADC2 is not available on the Aster board and
> + * conflicts with AD7879 resistive touchscreen.
> + */
> +&adc2 {
> +	status = "disabled";
> +};
> +
> +&ecspi3 {
> +	cs-gpios = <
> +		&gpio4 11 GPIO_ACTIVE_HIGH
> +		&gpio4 23 GPIO_ACTIVE_HIGH
> +	>;
> +	status = "okay";
> +
> +	spidev0: spidev@0 {
> +		compatible = "toradex,evalspi";

Undocumented compatible?

> +		reg = <0>;
> +		spi-max-frequency = <23000000>;
> +	};
> +
> +	spidev1: spidev@1 {
> +		compatible = "toradex,evalspi";
> +		reg = <1>;
> +		spi-max-frequency = <23000000>;
> +	};
> +};
> +
> +&fec1 {
> +	status = "okay";
> +};
> +
> +&i2c4 {
> +	status = "okay";
> +
> +	/* Microchip/Atmel maxtouch controller */
> +	touchscreen@4a {
> +		compatible = "atmel,maxtouch";
> +		pinctrl-names = "default";
> +		pinctrl-0 = <&pinctrl_gpiotouch>;
> +		reg = <0x4a>;
> +		interrupt-parent = <&gpio2>;
> +		interrupts = <15 IRQ_TYPE_EDGE_FALLING>;	/* SODIMM 107 */
> +		reset-gpios = <&gpio2 28 GPIO_ACTIVE_HIGH>;	/* SODIMM 106 */
> +		status = "okay";

We use okay status to flip disabled device.  It's not really necessary
here, right?

> +	};
> +
> +	/* M41T0M6 real time clock on carrier board */
> +	rtc: m41t0m6@68 {
> +		compatible = "st,m41t0";
> +		reg = <0x68>;
> +	};
> +};
> +
> +&lcdif {
> +	status = "okay";
> +
> +	port {
> +		lcdif_out: endpoint {
> +			remote-endpoint = <&panel_in>;
> +		};
> +	};
> +};
> +
> +&pwm1 {
> +	status = "okay";
> +};
> +
> +&pwm2 {
> +	status = "okay";
> +};
> +
> +&pwm3 {
> +	status = "okay";
> +};
> +
> +&pwm4 {
> +	status = "okay";
> +};
> +
> +&uart1 {
> +	status = "okay";
> +};
> +
> +&uart2 {
> +	status = "okay";
> +};
> +
> +&uart3 {
> +	status = "okay";
> +};
> +
> +&usbotg1 {
> +	status = "okay";
> +};
> +
> +&usdhc1 {
> +	keep-power-in-suspend;
> +	no-1-8-v;
> +	wakeup-source;
> +	vmmc-supply = <&reg_3v3>;
> +	status = "okay";
> +};
> +
> +&iomuxc {
> +	pinctrl_gpiotouch: touchgpios {
> +		fsl,pins = <
> +			MX7D_PAD_EPDC_DATA15__GPIO2_IO15        0x74
> +			MX7D_PAD_EPDC_BDR0__GPIO2_IO28          0x14
> +		>;
> +	};
> +};
> diff --git a/arch/arm/boot/dts/imx7-colibri.dtsi b/arch/arm/boot/dts/imx7-colibri.dtsi
> index 7b4e81412381..fc075f2465eb 100644
> --- a/arch/arm/boot/dts/imx7-colibri.dtsi
> +++ b/arch/arm/boot/dts/imx7-colibri.dtsi
> @@ -321,7 +321,6 @@ MX7D_PAD_LCD_RESET__GPIO3_IO4		0x14 /* SODIMM 93 */
>  			MX7D_PAD_EPDC_DATA13__GPIO2_IO13	0x14 /* SODIMM 95 */
>  			MX7D_PAD_ENET1_RGMII_TXC__GPIO7_IO11	0x14 /* SODIMM 99 */
>  			MX7D_PAD_EPDC_DATA10__GPIO2_IO10	0x74 /* SODIMM 105 */
> -			MX7D_PAD_EPDC_DATA15__GPIO2_IO15	0x74 /* SODIMM 107 */
>  			MX7D_PAD_EPDC_DATA00__GPIO2_IO0		0x14 /* SODIMM 111 */
>  			MX7D_PAD_EPDC_DATA01__GPIO2_IO1		0x14 /* SODIMM 113 */
>  			MX7D_PAD_EPDC_DATA02__GPIO2_IO2		0x14 /* SODIMM 115 */
> @@ -338,7 +337,6 @@ MX7D_PAD_SAI1_RX_BCLK__GPIO6_IO17	0x14 /* SODIMM 24 */
>  			MX7D_PAD_SD2_DATA2__GPIO5_IO16		0x14 /* SODIMM 100 */
>  			MX7D_PAD_SD2_DATA3__GPIO5_IO17		0x14 /* SODIMM 102 */
>  			MX7D_PAD_EPDC_GDSP__GPIO2_IO27		0x14 /* SODIMM 104 */
> -			MX7D_PAD_EPDC_BDR0__GPIO2_IO28		0x74 /* SODIMM 106 */
>  			MX7D_PAD_EPDC_BDR1__GPIO2_IO29		0x14 /* SODIMM 110 */
>  			MX7D_PAD_EPDC_PWR_COM__GPIO2_IO30	0x14 /* SODIMM 112 */
>  			MX7D_PAD_EPDC_SDCLK__GPIO2_IO16		0x14 /* SODIMM 114 */
> diff --git a/arch/arm/boot/dts/imx7d-colibri-aster.dts b/arch/arm/boot/dts/imx7d-colibri-aster.dts
> new file mode 100644
> index 000000000000..1e84e47a00fc
> --- /dev/null
> +++ b/arch/arm/boot/dts/imx7d-colibri-aster.dts
> @@ -0,0 +1,20 @@
> +// SPDX-License-Identifier: (GPL-2.0 OR X11)
> +/*
> + * Copyright 2017-2020 Toradex AG
> + *
> + */
> +
> +/dts-v1/;
> +#include "imx7d-colibri.dtsi"
> +#include "imx7-colibri-aster.dtsi"
> +
> +/ {
> +	model = "Toradex Colibri iMX7D on Colibri Aster Board";
> +	compatible = "toradex,colibri-imx7d-aster", "toradex,colibri-imx7d",

Any new compatible needs to be documented.

Shawn

> +		     "fsl,imx7d";
> +};
> +
> +&usbotg2 {
> +	vbus-supply = <&reg_usbh_vbus>;
> +	status = "okay";
> +};
> diff --git a/arch/arm/boot/dts/imx7d-colibri-emmc-aster.dts b/arch/arm/boot/dts/imx7d-colibri-emmc-aster.dts
> new file mode 100644
> index 000000000000..9caaac6ecf5c
> --- /dev/null
> +++ b/arch/arm/boot/dts/imx7d-colibri-emmc-aster.dts
> @@ -0,0 +1,20 @@
> +// SPDX-License-Identifier: GPL-2.0 OR X11
> +/*
> + * Copyright 2017-2020 Toradex AG
> + *
> + */
> +
> +/dts-v1/;
> +#include "imx7d-colibri-emmc.dtsi"
> +#include "imx7-colibri-aster.dtsi"
> +
> +/ {
> +	model = "Toradex Colibri iMX7D 1GB (eMMC) on Colibri Aster Board";
> +	compatible = "toradex,colibri-imx7d-emmc-aster",
> +		     "toradex,colibri-imx7d-emmc", "fsl,imx7d";
> +};
> +
> +&usbotg2 {
> +	vbus-supply = <&reg_usbh_vbus>;
> +	status = "okay";
> +};
> diff --git a/arch/arm/boot/dts/imx7s-colibri-aster.dts b/arch/arm/boot/dts/imx7s-colibri-aster.dts
> new file mode 100644
> index 000000000000..6fb981f3f801
> --- /dev/null
> +++ b/arch/arm/boot/dts/imx7s-colibri-aster.dts
> @@ -0,0 +1,15 @@
> +// SPDX-License-Identifier: (GPL-2.0 OR X11)
> +/*
> + * Copyright 2017-2020 Toradex AG
> + *
> + */
> +
> +/dts-v1/;
> +#include "imx7s-colibri.dtsi"
> +#include "imx7-colibri-aster.dtsi"
> +
> +/ {
> +	model = "Toradex Colibri iMX7S on Colibri Aster Board";
> +	compatible = "toradex,colibri-imx7s-aster", "toradex,colibri-imx7s",
> +		     "fsl,imx7s";
> +};
> -- 
> 2.24.1
> 
