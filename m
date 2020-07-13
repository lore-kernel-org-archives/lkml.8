Return-Path: <SRS0=gGKB=AY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.6 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 19E34C433DF
	for <linux-kernel@archiver.kernel.org>; Mon, 13 Jul 2020 02:52:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E158E206F4
	for <linux-kernel@archiver.kernel.org>; Mon, 13 Jul 2020 02:52:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1594608776;
	bh=yvd6X2UZ5Ila+w9m/nnk2oVx6EhMXX4+gaUJhZftPQE=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=OuBZTHFDPt0GN48hHAseQHTUQzML6nPvW7gi4z+71mgHbc7I1IFdF1vjaxZqDYD4u
	 86fJIaMtmN88zJ2tFbyhTJgmC3iHG1BArGpEKEj+xjfmgtCbxcrVpP4fAgSSJbMomj
	 7tJLTntH87OQAZzTHXz2W1A0HaB3+mlAOCt4H9qI=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728471AbgGMCwy (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 12 Jul 2020 22:52:54 -0400
Received: from mail.kernel.org ([198.145.29.99]:58994 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726261AbgGMCwy (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 12 Jul 2020 22:52:54 -0400
Received: from dragon (80.251.214.228.16clouds.com [80.251.214.228])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id E7D85206B6;
        Mon, 13 Jul 2020 02:52:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1594608773;
        bh=yvd6X2UZ5Ila+w9m/nnk2oVx6EhMXX4+gaUJhZftPQE=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=EaEF50exEfM9O9HqAFRMM9TLhVNou9fsfZnXtr+4FWwB6HP1LTKo9BoqBB/pmHKzl
         GixuggLalKcmL3xFAkfgizcHueT+E8sVrUNNvoANAquiwLbFbBtHoDQyObIASGCNi2
         erOnDTzqm39deFhhgWuoxywXI9kZ1+FXfJw0ACv4=
Date:   Mon, 13 Jul 2020 10:52:47 +0800
From:   Shawn Guo <shawnguo@kernel.org>
To:     Bruno Thomsen <bruno.thomsen@gmail.com>
Cc:     linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        devicetree@vger.kernel.org, Rob Herring <robh+dt@kernel.org>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>,
        NXP Linux Team <linux-imx@nxp.com>, bth@kamstrup.com,
        Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
Subject: Re: [PATCH 2/3] ARM: dts: imx7: add support for kamstrup flex
 concentrator
Message-ID: <20200713025246.GY21277@dragon>
References: <20200629114927.17379-1-bruno.thomsen@gmail.com>
 <20200629114927.17379-2-bruno.thomsen@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200629114927.17379-2-bruno.thomsen@gmail.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jun 29, 2020 at 01:49:26PM +0200, Bruno Thomsen wrote:
> This adds support for the OMNIA Flex Concentrator product
> from Kamstrup A/S. It's providing radio mesh communication
> infrastructure for smart electricity meters.
> 
> Kamstrup OMNIA is a modular and scalable smart grid platform.
> 
> Signed-off-by: Bruno Thomsen <bruno.thomsen@gmail.com>
> ---
>  arch/arm/boot/dts/Makefile                    |   2 +
>  .../boot/dts/imx7d-flex-concentrator-mfg.dts  |  25 ++
>  arch/arm/boot/dts/imx7d-flex-concentrator.dts | 307 ++++++++++++++++++
>  3 files changed, 334 insertions(+)
>  create mode 100644 arch/arm/boot/dts/imx7d-flex-concentrator-mfg.dts
>  create mode 100644 arch/arm/boot/dts/imx7d-flex-concentrator.dts
> 
> diff --git a/arch/arm/boot/dts/Makefile b/arch/arm/boot/dts/Makefile
> index e6a1cac0bfc7..bf5c5d86a2e8 100644
> --- a/arch/arm/boot/dts/Makefile
> +++ b/arch/arm/boot/dts/Makefile
> @@ -628,6 +628,8 @@ dtb-$(CONFIG_SOC_IMX7D) += \
>  	imx7d-colibri-emmc-aster.dtb \
>  	imx7d-colibri-emmc-eval-v3.dtb \
>  	imx7d-colibri-eval-v3.dtb \
> +	imx7d-flex-concentrator.dtb \
> +	imx7d-flex-concentrator-mfg.dtb \
>  	imx7d-mba7.dtb \
>  	imx7d-meerkat96.dtb \
>  	imx7d-nitrogen7.dtb \
> diff --git a/arch/arm/boot/dts/imx7d-flex-concentrator-mfg.dts b/arch/arm/boot/dts/imx7d-flex-concentrator-mfg.dts
> new file mode 100644
> index 000000000000..789f0837058f
> --- /dev/null
> +++ b/arch/arm/boot/dts/imx7d-flex-concentrator-mfg.dts
> @@ -0,0 +1,25 @@
> +// SPDX-License-Identifier: GPL-2.0
> +/*
> + * Device Tree Source for Kamstrup OMNIA Flex Concentrator in
> + * manufacturing/debugging mode.
> + *
> + * Copyright (C) 2020 Kamstrup A/S
> + * Author: Bruno Thomsen <bruno.thomsen@gmail.com>
> + */
> +
> +/dts-v1/;
> +
> +#include "imx7d-flex-concentrator.dts"
> +
> +/ {
> +	model = "Kamstrup OMNIA Flex Concentrator - Manufacturing";
> +	compatible = "kam,imx7d-flex-concentrator-mfg", "kam,imx7d-flex-concentrator", "fsl,imx7d";
> +
> +	chosen {
> +		stdout-path = &uart4;
> +	};
> +};
> +
> +&uart4 {
> +	status = "okay";
> +};
> diff --git a/arch/arm/boot/dts/imx7d-flex-concentrator.dts b/arch/arm/boot/dts/imx7d-flex-concentrator.dts
> new file mode 100644
> index 000000000000..887135cca650
> --- /dev/null
> +++ b/arch/arm/boot/dts/imx7d-flex-concentrator.dts
> @@ -0,0 +1,307 @@
> +// SPDX-License-Identifier: GPL-2.0
> +/*
> + * Device Tree Source for Kamstrup OMNIA Flex Concentrator.
> + *
> + * Copyright (C) 2020 Kamstrup A/S
> + * Author: Bruno Thomsen <bruno.thomsen@gmail.com>
> + */
> +
> +/dts-v1/;
> +
> +#include "imx7d-tqma7.dtsi"
> +
> +/* Some I2C devices on TQMa7 SoM are not mounted */
> +/delete-node/ &m24c64;
> +/delete-node/ &ds1339;
> +
> +/ {
> +	model = "Kamstrup OMNIA Flex Concentrator";
> +	compatible = "kam,imx7d-flex-concentrator", "fsl,imx7d";
> +
> +	memory@80000000 {
> +		device_type = "memory";
> +		/* 1024 MB - TQMa7D board configuration */
> +		reg = <0x80000000 0x40000000>;
> +	};
> +
> +	reg_usb_otg2_vbus: regulator-usb-otg2-vbus {
> +		compatible = "regulator-fixed";
> +		regulator-name = "VBUS_USBOTG2";
> +		regulator-min-microvolt = <5000000>;
> +		regulator-max-microvolt = <5000000>;
> +		gpio = <&gpio1 7 GPIO_ACTIVE_HIGH>;
> +		enable-active-high;
> +	};
> +
> +	reg_vref_1v8: regulator-vref-1v8 {
> +		compatible = "regulator-fixed";
> +		regulator-name = "VCC1V8_REF";
> +		regulator-min-microvolt = <1800000>;
> +		regulator-max-microvolt = <1800000>;
> +		regulator-always-on;
> +		vin-supply = <&sw2_reg>;
> +	};
> +
> +	/*
> +	 * Human Machine Interface consists of 4 dual red/green LEDs.
> +	 * hmi-a-green is controlled directly by the switch-mode power supply.
> +	 * hmi-a-red is not used.
> +	 */
> +	gpio-leds {
> +		compatible = "gpio-leds";
> +		pinctrl-names = "default";
> +		pinctrl-0 = <&pinctrl_leds>;
> +
> +		hmi-b-red {
> +			label = "hmi-b:red:provisioning";
> +			gpios = <&gpio3 6 GPIO_ACTIVE_HIGH>;
> +			default-state = "off";
> +		};
> +
> +		hmi-b-green {
> +			label = "hmi-b:green:operation";
> +			gpios = <&gpio2 28 GPIO_ACTIVE_HIGH>;
> +			default-state = "off";
> +		};
> +
> +		hmi-c-red {
> +			label = "hmi-c:red:mesh-error";
> +			gpios = <&gpio2 29 GPIO_ACTIVE_HIGH>;
> +			default-state = "off";
> +		};
> +
> +		hmi-c-green {
> +			label = "hmi-c:green:mesh-activity";
> +			gpios = <&gpio2 30 GPIO_ACTIVE_HIGH>;
> +			default-state = "off";
> +		};
> +
> +		hmi-d-red {
> +			label = "hmi-d:red:wan-down";
> +			gpios = <&gpio2 31 GPIO_ACTIVE_HIGH>;
> +			default-state = "off";
> +		};
> +
> +		hmi-d-green {
> +			label = "hmi-d:green:ipsec-up";
> +			gpios = <&gpio4 3 GPIO_ACTIVE_HIGH>;
> +			default-state = "off";
> +		};
> +	};
> +
> +	/*
> +	 * Errata e10574 board restart workaround.
> +	 */
> +	gpio-restart {
> +		pinctrl-names = "default";
> +		pinctrl-0 = <&pinctrl_restart>;
> +		compatible = "gpio-restart";
> +		gpios = <&gpio7 12 GPIO_ACTIVE_LOW>;
> +		priority = <200>;
> +	};
> +};
> +
> +/*
> + * External watchdog feature provided by pcf2127.
> + */
> +&wdog1 {

Please keep these labeling nodes sort alphabetically.

> +	status = "disabled";
> +};
> +
> +/*
> + * Detection signals for internal USB modules.
> + * Used for robust USB plug and play handling such as USB downstream port
> + * power-cycle and USB hub reset in case of misbehaving or crashed modules.
> + *
> + * SMPS - AC input monitor based on zero crossing.
> + * Used for last gasp notification.
> + */
> +&gpio3 {
> +	gpio-line-names = "", "", "", "", "", "", "", "",
> +	"", "", "", "", "smps-ac-monitor", "", "usb-hub-reset", "",
> +	"", "", "", "", "", "", "", "",
> +	"", "module-b-detection", "", "module-a-detection", "", "", "", "";
> +};
> +
> +/*
> + * Tamper IRQ trigger timestamp reading.
> + * Used for sealed cover opened notification.
> + */
> +&gpio5 {
> +	gpio-line-names = "", "", "", "", "", "", "", "",
> +	"", "", "", "", "rtc-tamper-irq", "", "", "",
> +	"", "", "", "", "", "", "", "",
> +	"", "", "", "", "", "", "", "";
> +};
> +
> +/*
> + * Analog signals
> + * ADC1_IN0: SMPS - 5V output monitor (voltage divider: 1/0.2806)
> + */
> +&adc1 {
> +	vref-supply = <&reg_vref_1v8>;
> +	status = "okay";
> +};
> +
> +&ecspi2 {
> +	pinctrl-names = "default";
> +	pinctrl-0 = <&pinctrl_ecspi2>;
> +	num-chipselects = <1>;
> +	cs-gpios = <&gpio4 23 GPIO_ACTIVE_LOW>;
> +	status = "okay";
> +
> +	pcf2127: rtc@0 {
> +		compatible = "nxp,pcf2127";
> +		reg = <0>;
> +		spi-max-frequency = <2000000>;
> +	};
> +};
> +
> +&ecspi4 {
> +	pinctrl-names = "default";
> +	pinctrl-0 = <&pinctrl_ecspi4>;
> +	num-chipselects = <1>;
> +	cs-gpios = <&gpio3 3 GPIO_ACTIVE_LOW>;
> +	status = "okay";
> +
> +	/*
> +	 * ST chip maximum SPI clock frequency is 33 MHz.
> +	 *
> +	 * TCG specification - Section 6.4.1 Clocking:
> +	 * TPM shall support a SPI clock frequency range of 10-24 MHz.
> +	 */
> +	st33htph: tpm-tis@0 {
> +		compatible = "st,st33htpm-spi", "tcg,tpm_tis-spi";
> +		reg = <0>;
> +		spi-max-frequency = <24000000>;
> +	};
> +};
> +
> +&fec1 {
> +	pinctrl-names = "default";
> +	pinctrl-0 = <&pinctrl_enet1>;
> +	phy-mode = "rmii";
> +	phy-reset-gpios = <&gpio7 15 GPIO_ACTIVE_LOW>;
> +	phy-reset-duration = <100>;
> +	phy-reset-post-delay = <1000>;

These properties are deprecated.

> +	phy-handle = <&ethphy>;
> +	status = "okay";
> +
> +	mdio {
> +		#address-cells = <1>;
> +		#size-cells = <0>;
> +		ethphy: ethernet-phy@1 {
> +			/* Micrel KSZ8051RNLV */
> +			compatible = "ethernet-phy-ieee802.3-c22";
> +			reg = <1>;
> +		};
> +	};
> +};
> +
> +&iomuxc {
> +	pinctrl-names = "default";
> +	pinctrl-0 = <&pinctrl_misc>;
> +
> +	pinctrl_ecspi2: ecspi2grp {
> +		fsl,pins = <
> +			MX7D_PAD_ECSPI2_MISO__ECSPI2_MISO		0x7c /* X2-15 */
> +			MX7D_PAD_ECSPI2_MOSI__ECSPI2_MOSI		0x74 /* X2-18 */
> +			MX7D_PAD_ECSPI2_SCLK__ECSPI2_SCLK		0x74 /* X2-13 */
> +			MX7D_PAD_ECSPI2_SS0__GPIO4_IO23			0x74 /* X2-20 */
> +			/* RTC - Tamper IRQ */
> +			MX7D_PAD_SD2_CLK__GPIO5_IO12			0x3c /* X1-92 */
> +		>;
> +	};
> +
> +	pinctrl_ecspi4: ecspi4grp {
> +		fsl,pins = <
> +			MX7D_PAD_LCD_CLK__ECSPI4_MISO			0x7c /* X2-72 */
> +			MX7D_PAD_LCD_ENABLE__ECSPI4_MOSI		0x74 /* X2-68 */
> +			MX7D_PAD_LCD_HSYNC__ECSPI4_SCLK			0x74 /* X2-76 */
> +			MX7D_PAD_LCD_VSYNC__GPIO3_IO3			0x74 /* X2-78 */
> +		>;
> +	};
> +
> +	pinctrl_leds: ledsgrp {
> +		fsl,pins = <
> +			MX7D_PAD_LCD_DATA01__GPIO3_IO6			0x14 /* X2-82 */
> +			MX7D_PAD_EPDC_BDR0__GPIO2_IO28			0x14 /* X1-82 */
> +			MX7D_PAD_EPDC_BDR1__GPIO2_IO29			0x14 /* X1-84 */
> +			MX7D_PAD_EPDC_PWR_COM__GPIO2_IO30		0x14 /* X1-86 */
> +			MX7D_PAD_EPDC_PWR_STAT__GPIO2_IO31		0x14 /* X1-88 */
> +			MX7D_PAD_UART2_TX_DATA__GPIO4_IO3		0x14 /* X1-90 */
> +		>;
> +	};
> +
> +	pinctrl_enet1: enet1grp {

Please keep these pinctrl entries sort alphabetically.

Shawn

> +		fsl,pins = <
> +			MX7D_PAD_GPIO1_IO10__ENET1_MDIO			0x03 /* X2-48 */
> +			MX7D_PAD_GPIO1_IO11__ENET1_MDC			0x03 /* X2-46 */
> +			MX7D_PAD_ENET1_RGMII_TD0__ENET1_RGMII_TD0	0x71 /* X2-53 */
> +			MX7D_PAD_ENET1_RGMII_TD1__ENET1_RGMII_TD1	0x71 /* X2-55 */
> +			MX7D_PAD_ENET1_RGMII_TX_CTL__ENET1_RGMII_TX_CTL	0x71 /* X2-61 */
> +			MX7D_PAD_ENET1_RGMII_RD0__ENET1_RGMII_RD0	0x79 /* X2-56 */
> +			MX7D_PAD_ENET1_RGMII_RD1__ENET1_RGMII_RD1	0x79 /* X2-58 */
> +			MX7D_PAD_ENET1_RGMII_RX_CTL__ENET1_RGMII_RX_CTL	0x79 /* X2-64 */
> +			MX7D_PAD_ENET1_RGMII_RXC__ENET1_RX_ER		0x73 /* X2-52 */
> +			/* PHY reset: SION, 100kPU, SRE_FAST, DSE_X1 */
> +			MX7D_PAD_ENET1_COL__GPIO7_IO15		0x40000070 /* X1-96 */
> +			/* Clock from PHY to MAC */
> +			MX7D_PAD_GPIO1_IO12__CCM_ENET_REF_CLK1	0x40000073 /* X3-4 */
> +		>;
> +	};
> +
> +	pinctrl_misc: miscgrp {
> +		fsl,pins = <
> +			/* Module A detection (low = present) */
> +			MX7D_PAD_LCD_DATA22__GPIO3_IO27			0x7c /* X2-105 */
> +			/* Module B detection (low = present) */
> +			MX7D_PAD_LCD_DATA20__GPIO3_IO25			0x7c /* X2-103 */
> +			/* SMPS - AC input monitor (high = failure) */
> +			MX7D_PAD_LCD_DATA07__GPIO3_IO12			0x7c /* X2-88 */
> +			/* USB - Hub reset */
> +			MX7D_PAD_LCD_DATA09__GPIO3_IO14			0x74 /* X2-92 */
> +		>;
> +	};
> +
> +	pinctrl_uart4: uart4grp {
> +		fsl,pins = <
> +			MX7D_PAD_SAI2_TX_SYNC__UART4_DCE_RX	0x7e /* X3-14 */
> +			MX7D_PAD_SAI2_TX_BCLK__UART4_DCE_TX	0x76 /* X3-16 */
> +		>;
> +	};
> +
> +	pinctrl_restart: restartgrp {
> +		fsl,pins = <
> +			MX7D_PAD_ENET1_TX_CLK__GPIO7_IO12	0x74 /* X1-94 */
> +		>;
> +	};
> +};
> +
> +&iomuxc_lpsr {
> +	pinctrl_usbotg2: usbotg2grp {
> +		fsl,pins = <
> +			MX7D_PAD_LPSR_GPIO1_IO06__USB_OTG2_OC	0x5c /* X3-11 */
> +			MX7D_PAD_LPSR_GPIO1_IO07__GPIO1_IO7	0x59 /* X3-9 */
> +		>;
> +	};
> +
> +};
> +
> +&usbotg2 {
> +	pinctrl-names = "default";
> +	pinctrl-0 = <&pinctrl_usbotg2>;
> +	vbus-supply = <&reg_usb_otg2_vbus>;
> +	srp-disable;
> +	hnp-disable;
> +	adp-disable;
> +	dr_mode = "host";
> +	status = "okay";
> +};
> +
> +&uart4 {
> +	pinctrl-names = "default";
> +	pinctrl-0 = <&pinctrl_uart4>;
> +	assigned-clocks = <&clks IMX7D_UART4_ROOT_SRC>;
> +	assigned-clock-parents = <&clks IMX7D_OSC_24M_CLK>;
> +};
> -- 
> 2.26.2
> 
