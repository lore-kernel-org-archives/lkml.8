Return-Path: <SRS0=ysYr=B3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.6 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 19E14C433E3
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Aug 2020 08:51:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D96C820758
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Aug 2020 08:51:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1597654290;
	bh=F9VeCW5mlrgQXeTJIgY5pn1QK8iZFMKdcr0HP2c8YQY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=QK6BdpTrvYxdXhkh9XK/U0xDtAGHbicvyuzhtRujqc6pdGneRRSIg3wO/2eUwCxoO
	 kgMUYtEDanwWxtjiiS3ftbSwNuhxxdVxSG8BiqVRaFFs2xnGeb6lJ/lhjYVqJicSCp
	 BVtXDGHov+8zxD47w/mu7AprBksXC5i71dxwp4ls=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726581AbgHQIv2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 17 Aug 2020 04:51:28 -0400
Received: from mail.kernel.org ([198.145.29.99]:36394 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726779AbgHQIv0 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Aug 2020 04:51:26 -0400
Received: from dragon (80.251.214.228.16clouds.com [80.251.214.228])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 100F12067C;
        Mon, 17 Aug 2020 08:51:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1597654284;
        bh=F9VeCW5mlrgQXeTJIgY5pn1QK8iZFMKdcr0HP2c8YQY=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=djsglwcJuxw060dK7xuI2fW5WwwlebDILE3DDoRcNOnR9yZ0RWMe8RmLrojW0P/mi
         pD1+h37QC13qMz/rYHa6zUa6kfP5Td3KVPpgSQec+bbBDfjPRRgHwnUu/Pz1eygcH8
         A6jTQaF/xIlELLqtMe06JzUdFj3kZQlkt5EnmG34=
Date:   Mon, 17 Aug 2020 16:51:13 +0800
From:   Shawn Guo <shawnguo@kernel.org>
To:     Schrempf Frieder <frieder.schrempf@kontron.de>
Cc:     Anson Huang <Anson.Huang@nxp.com>,
        Fabio Estevam <festevam@gmail.com>,
        Li Yang <leoyang.li@nxp.com>,
        Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
        Marcel Ziswiler <marcel.ziswiler@toradex.com>,
        Michael Walle <michael@walle.cc>,
        NXP Linux Team <linux-imx@nxp.com>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Robert Jones <rjones@gateworks.com>,
        Rob Herring <robh@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        =?iso-8859-1?Q?S=E9bastien?= Szymanski 
        <sebastien.szymanski@armadeus.com>,
        Andreas Kemnade <andreas@kemnade.info>,
        devicetree@vger.kernel.org, Krzysztof Kozlowski <krzk@kernel.org>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 1/2] arm64: dts: Add the Kontron i.MX8M Mini SoMs and
 baseboards
Message-ID: <20200817085111.GE16951@dragon>
References: <20200716161216.15461-1-frieder.schrempf@kontron.de>
 <20200716161216.15461-2-frieder.schrempf@kontron.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200716161216.15461-2-frieder.schrempf@kontron.de>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jul 16, 2020 at 06:11:58PM +0200, Schrempf Frieder wrote:
> From: Frieder Schrempf <frieder.schrempf@kontron.de>
> 
> Kontron Electronics GmbH offers small and powerful SoMs based on the
> i.MX8M Mini SoC including PMIC, LPDDR4-RAM, eMMC and SPI NOR.
> 
> The matching baseboards have the same form factor and similar interfaces
> as the other boards from the Kontron "Board-Line" family, including
> SD card, 1G Ethernet, 100M Ethernet, USB Host/OTG, digital IOs, RS232,
> RS485, CAN, LVDS or HDMI, RTC and much more.
> 
> Signed-off-by: Frieder Schrempf <frieder.schrempf@kontron.de>
> ---
> Changes for v2:
> * Make the licensing less strict (GPL-2.0+ OR MIT)
> * Merge the SoM and baseboard DTs for N8010 and N8011 into one as
>   they only differ in DDR and eMMC size.
> * Change compatibles and model strings to "n810x" and "N8010X".
> * Only use a common memory node that will be updated by the
>   bootloader reflecting the detected DDR size.
> * Improve naming for 16MHz CAN fixed oscillator and set
>   "clock-output-names".
> * Consistently use "reg_" prefix for regulators.
> * Remove "userspi" node.
> * Slightly improve commit message.
> ---
>  .../dts/freescale/imx8mm-kontron-n801x-s.dts  | 327 ++++++++++++++++++
>  .../freescale/imx8mm-kontron-n801x-som.dtsi   | 294 ++++++++++++++++
>  2 files changed, 621 insertions(+)
>  create mode 100644 arch/arm64/boot/dts/freescale/imx8mm-kontron-n801x-s.dts
>  create mode 100644 arch/arm64/boot/dts/freescale/imx8mm-kontron-n801x-som.dtsi
> 
> diff --git a/arch/arm64/boot/dts/freescale/imx8mm-kontron-n801x-s.dts b/arch/arm64/boot/dts/freescale/imx8mm-kontron-n801x-s.dts
> new file mode 100644
> index 000000000000..25b8ef569edd
> --- /dev/null
> +++ b/arch/arm64/boot/dts/freescale/imx8mm-kontron-n801x-s.dts
> @@ -0,0 +1,327 @@
> +// SPDX-License-Identifier: GPL-2.0+ OR MIT
> +/*
> + * Copyright (C) 2019 Kontron Electronics GmbH
> + */
> +
> +/dts-v1/;
> +
> +#include "imx8mm-kontron-n801x-som.dtsi"
> +
> +/ {
> +	model = "Kontron i.MX8MM N801X S";
> +	compatible = "kontron,imx8mm-n801x-s", "kontron,imx8mm-n801x-som", "fsl,imx8mm";
> +
> +	aliases {
> +		ethernet1 = &usbnet;
> +	};
> +
> +	/* fixed crystal dedicated to mcp2515 */
> +	osc_can: clock-osc-can {
> +		compatible = "fixed-clock";
> +		#clock-cells = <0>;
> +		clock-frequency = <16000000>;
> +		clock-output-names = "osc-can";
> +	};
> +
> +	leds {
> +		compatible = "gpio-leds";
> +		pinctrl-names = "default";
> +		pinctrl-0 = <&pinctrl_gpio_led>;
> +
> +		led1 {
> +			label = "led1";
> +			gpios = <&gpio4 17 GPIO_ACTIVE_LOW>;
> +			linux,default-trigger = "heartbeat";
> +		};
> +
> +		led2 {
> +			label = "led2";
> +			gpios = <&gpio4 19 GPIO_ACTIVE_LOW>;
> +		};
> +
> +		led3 {
> +			label = "led3";
> +			gpios = <&gpio4 18 GPIO_ACTIVE_LOW>;
> +		};
> +
> +		led4 {
> +			label = "led4";
> +			gpios = <&gpio4 8 GPIO_ACTIVE_LOW>;
> +		};
> +
> +		led5 {
> +			label = "led5";
> +			gpios = <&gpio4 9 GPIO_ACTIVE_LOW>;
> +		};
> +
> +		led6 {
> +			label = "led6";
> +			gpios = <&gpio4 7 GPIO_ACTIVE_LOW>;
> +		};
> +	};
> +
> +	pwm-beeper {
> +		compatible = "pwm-beeper";
> +		pwms = <&pwm2 0 5000 0>;
> +	};
> +
> +	reg_rst_eth2: regulator-rst-eth2 {
> +		compatible = "regulator-fixed";
> +		regulator-name = "rst-usb-eth2";
> +		pinctrl-names = "default";
> +		pinctrl-0 = <&pinctrl_usb_eth2>;
> +		gpio = <&gpio3 2 GPIO_ACTIVE_LOW>;
> +		status = "okay";

We usually use 'okay' to flip 'disabled' status set in <soc>.dtsi.  It's
not really needed here.

> +	};
> +
> +	reg_vdd_5v: regulator-5v {
> +		compatible = "regulator-fixed";
> +		regulator-name = "vdd-5v";
> +		regulator-min-microvolt = <5000000>;
> +		regulator-max-microvolt = <5000000>;
> +		regulator-boot-on;
> +		regulator-always-on;

What's the point of having these for a regulator that doesn't have
on/off control?

> +		status = "okay";
> +	};
> +};
> +
> +&ecspi2 {
> +	pinctrl-names = "default";
> +	pinctrl-0 = <&pinctrl_ecspi2>;
> +	cs-gpios = <&gpio5 13 GPIO_ACTIVE_LOW>;
> +	status = "okay";
> +
> +	can0: can@0 {
> +		compatible = "microchip,mcp2515";
> +		reg = <0>;
> +		pinctrl-names = "default";
> +		pinctrl-0 = <&pinctrl_can>;
> +		clocks = <&osc_can>;
> +		interrupt-parent = <&gpio4>;
> +		interrupts = <28 IRQ_TYPE_EDGE_FALLING>;
> +		spi-max-frequency = <100000>;
> +		vdd-supply = <&reg_vdd_3v3>;
> +		xceiver-supply = <&reg_vdd_5v>;
> +		status = "okay";
> +	};
> +};
> +
> +&ecspi3 {
> +	pinctrl-names = "default";
> +	pinctrl-0 = <&pinctrl_ecspi3>;
> +	cs-gpios = <&gpio5 25 GPIO_ACTIVE_LOW>;
> +	status = "okay";
> +};
> +
> +&fec1 {
> +	pinctrl-names = "default";
> +	pinctrl-0 = <&pinctrl_enet>;
> +	phy-mode = "rgmii";
> +	phy-reset-gpios = <&gpio4 27 GPIO_ACTIVE_LOW>;
> +	phy-reset-duration = <100>;
> +	phy-reset-post-delay = <100>;

These properties are deprecated.

> +	phy-handle = <&ethphy>;
> +	status = "okay";
> +
> +	mdio {
> +		#address-cells = <1>;
> +		#size-cells = <0>;
> +
> +		ethphy: ethernet-phy@0 {
> +			reg = <0>;
> +		};
> +	};
> +};
> +
> +&i2c4 {
> +	clock-frequency = <100000>;
> +	pinctrl-names = "default";
> +	pinctrl-0 = <&pinctrl_i2c4>;
> +	status = "okay";
> +
> +	rtc@32 {
> +		compatible = "epson,rx8900";
> +		reg = <0x32>;
> +	};
> +};
> +
> +&pwm2 {
> +	pinctrl-names = "default";
> +	pinctrl-0 = <&pinctrl_pwm2>;
> +	status = "okay";
> +};
> +
> +&uart1 {
> +	pinctrl-names = "default";
> +	pinctrl-0 = <&pinctrl_uart1>;
> +	uart-has-rtscts;
> +	status = "okay";
> +};
> +
> +&uart2 {
> +	pinctrl-names = "default";
> +	pinctrl-0 = <&pinctrl_uart2>;
> +	linux,rs485-enabled-at-boot-time;
> +	uart-has-rtscts;
> +	status = "okay";
> +};
> +
> +&usbotg1 {
> +	dr_mode = "otg";
> +	status = "okay";
> +};
> +
> +&usbotg2 {
> +	dr_mode = "host";
> +	disable-over-current;
> +	#address-cells = <1>;
> +	#size-cells = <0>;
> +	status = "okay";
> +
> +	usb1@1 {
> +		compatible = "usb424,9514";
> +		reg = <1>;
> +		#address-cells = <1>;
> +		#size-cells = <0>;
> +
> +		usbnet: usbether@1 {
> +			compatible = "usb424,ec00";
> +			reg = <1>;
> +			mac-address = [ 00 00 00 00 00 00 ];
> +		};
> +	};
> +};
> +
> +&usdhc2 {
> +	pinctrl-names = "default";
> +	pinctrl-0 = <&pinctrl_usdhc2>;
> +	vmmc-supply = <&reg_vdd_3v3>;
> +	vqmmc-supply = <&reg_nvcc_sd>;
> +	cd-gpios = <&gpio2 12 GPIO_ACTIVE_LOW>;
> +	bus-width = <4>;
> +	status = "okay";
> +};
> +
> +&iomuxc {
> +	pinctrl-names = "default";
> +	pinctrl-0 = <&pinctrl_gpio>;
> +
> +	pinctrl_can: cangrp {
> +		fsl,pins = <
> +			MX8MM_IOMUXC_SAI3_RXFS_GPIO4_IO28		0x19
> +		>;
> +	};
> +
> +	pinctrl_ecspi2: ecspi2grp {
> +		fsl,pins = <
> +			MX8MM_IOMUXC_ECSPI2_MISO_ECSPI2_MISO		0x82
> +			MX8MM_IOMUXC_ECSPI2_MOSI_ECSPI2_MOSI		0x82
> +			MX8MM_IOMUXC_ECSPI2_SCLK_ECSPI2_SCLK		0x82
> +			MX8MM_IOMUXC_ECSPI2_SS0_GPIO5_IO13		0x19
> +		>;
> +	};
> +
> +	pinctrl_ecspi3: ecspi3grp {
> +		fsl,pins = <
> +			MX8MM_IOMUXC_UART2_RXD_ECSPI3_MISO		0x82
> +			MX8MM_IOMUXC_UART1_TXD_ECSPI3_MOSI		0x82
> +			MX8MM_IOMUXC_UART1_RXD_ECSPI3_SCLK		0x82
> +			MX8MM_IOMUXC_UART2_TXD_GPIO5_IO25		0x19
> +		>;
> +	};
> +
> +	pinctrl_enet: enetgrp {
> +		fsl,pins = <
> +			MX8MM_IOMUXC_ENET_MDC_ENET1_MDC			0x3
> +			MX8MM_IOMUXC_ENET_MDIO_ENET1_MDIO		0x3
> +			MX8MM_IOMUXC_ENET_TD3_ENET1_RGMII_TD3		0x1f
> +			MX8MM_IOMUXC_ENET_TD2_ENET1_RGMII_TD2		0x1f
> +			MX8MM_IOMUXC_ENET_TD1_ENET1_RGMII_TD1		0x1f
> +			MX8MM_IOMUXC_ENET_TD0_ENET1_RGMII_TD0		0x1f
> +			MX8MM_IOMUXC_ENET_RD3_ENET1_RGMII_RD3		0x91
> +			MX8MM_IOMUXC_ENET_RD2_ENET1_RGMII_RD2		0x91
> +			MX8MM_IOMUXC_ENET_RD1_ENET1_RGMII_RD1		0x91
> +			MX8MM_IOMUXC_ENET_RD0_ENET1_RGMII_RD0		0x91
> +			MX8MM_IOMUXC_ENET_TXC_ENET1_RGMII_TXC		0x1f
> +			MX8MM_IOMUXC_ENET_RXC_ENET1_RGMII_RXC		0x91
> +			MX8MM_IOMUXC_ENET_RX_CTL_ENET1_RGMII_RX_CTL	0x91
> +			MX8MM_IOMUXC_ENET_TX_CTL_ENET1_RGMII_TX_CTL	0x1f
> +			MX8MM_IOMUXC_SAI2_MCLK_GPIO4_IO27		0x19 /* PHY RST */
> +			MX8MM_IOMUXC_SAI2_TXC_GPIO4_IO25		0x19 /* ETH IRQ */
> +		>;
> +	};
> +
> +	pinctrl_gpio_led: gpioledgrp {
> +		fsl,pins = <
> +			MX8MM_IOMUXC_NAND_READY_B_GPIO3_IO16		0x19
> +			MX8MM_IOMUXC_SAI1_RXD5_GPIO4_IO7		0x19
> +			MX8MM_IOMUXC_SAI1_RXD6_GPIO4_IO8		0x19
> +			MX8MM_IOMUXC_SAI1_RXD7_GPIO4_IO9		0x19
> +			MX8MM_IOMUXC_SAI1_TXD5_GPIO4_IO17		0x19
> +			MX8MM_IOMUXC_SAI1_TXD6_GPIO4_IO18		0x19
> +			MX8MM_IOMUXC_SAI1_TXD7_GPIO4_IO19		0x19
> +		>;
> +	};
> +
> +	pinctrl_gpio: gpiogrp {
> +		fsl,pins = <
> +			MX8MM_IOMUXC_GPIO1_IO03_GPIO1_IO3		0x19
> +			MX8MM_IOMUXC_GPIO1_IO07_GPIO1_IO7		0x19
> +			MX8MM_IOMUXC_GPIO1_IO09_GPIO1_IO9		0x19
> +			MX8MM_IOMUXC_GPIO1_IO11_GPIO1_IO11		0x19
> +			MX8MM_IOMUXC_GPIO1_IO06_GPIO1_IO6		0x19
> +			MX8MM_IOMUXC_GPIO1_IO08_GPIO1_IO8		0x19
> +			MX8MM_IOMUXC_GPIO1_IO10_GPIO1_IO10		0x19
> +			MX8MM_IOMUXC_SAI3_MCLK_GPIO5_IO2		0x19
> +		>;
> +	};
> +
> +	pinctrl_i2c4: i2c4grp {
> +		fsl,pins = <
> +			MX8MM_IOMUXC_I2C4_SCL_I2C4_SCL			0x400001c3
> +			MX8MM_IOMUXC_I2C4_SDA_I2C4_SDA			0x400001c3
> +		>;
> +	};
> +
> +	pinctrl_pwm2: pwm2grp {
> +		fsl,pins = <
> +			MX8MM_IOMUXC_SPDIF_RX_PWM2_OUT			0x19
> +		>;
> +	};
> +
> +	pinctrl_uart1: uart1grp {
> +		fsl,pins = <
> +			MX8MM_IOMUXC_SAI2_RXC_UART1_DCE_RX		0x140
> +			MX8MM_IOMUXC_SAI2_RXFS_UART1_DCE_TX		0x140
> +			MX8MM_IOMUXC_SAI2_RXD0_UART1_DCE_RTS_B		0x140
> +			MX8MM_IOMUXC_SAI2_TXFS_UART1_DCE_CTS_B		0x140
> +		>;
> +	};
> +
> +	pinctrl_uart2: uart2grp {
> +		fsl,pins = <
> +			MX8MM_IOMUXC_SAI3_TXFS_UART2_DCE_RX		0x140
> +			MX8MM_IOMUXC_SAI3_TXC_UART2_DCE_TX		0x140
> +			MX8MM_IOMUXC_SAI3_RXD_UART2_DCE_RTS_B		0x140
> +			MX8MM_IOMUXC_SAI3_RXC_UART2_DCE_CTS_B		0x140
> +		>;
> +	};
> +
> +	pinctrl_usb_eth2: usbeth2grp {
> +		fsl,pins = <
> +			MX8MM_IOMUXC_NAND_CE1_B_GPIO3_IO2		0x19
> +		>;
> +	};
> +
> +	pinctrl_usdhc2: usdhc2grp {
> +		fsl,pins = <
> +			MX8MM_IOMUXC_SD2_CLK_USDHC2_CLK			0x190
> +			MX8MM_IOMUXC_SD2_CMD_USDHC2_CMD			0x1d0
> +			MX8MM_IOMUXC_SD2_DATA0_USDHC2_DATA0		0x1d0
> +			MX8MM_IOMUXC_SD2_DATA1_USDHC2_DATA1		0x1d0
> +			MX8MM_IOMUXC_SD2_DATA2_USDHC2_DATA2		0x1d0
> +			MX8MM_IOMUXC_SD2_DATA3_USDHC2_DATA3		0x1d0
> +			MX8MM_IOMUXC_SD2_CD_B_GPIO2_IO12		0x019
> +		>;
> +	};
> +};
> diff --git a/arch/arm64/boot/dts/freescale/imx8mm-kontron-n801x-som.dtsi b/arch/arm64/boot/dts/freescale/imx8mm-kontron-n801x-som.dtsi
> new file mode 100644
> index 000000000000..6ff06d1cb23a
> --- /dev/null
> +++ b/arch/arm64/boot/dts/freescale/imx8mm-kontron-n801x-som.dtsi
> @@ -0,0 +1,294 @@
> +// SPDX-License-Identifier: GPL-2.0+ OR MIT
> +/*
> + * Copyright (C) 2019 Kontron Electronics GmbH
> + */
> +
> +#include "imx8mm.dtsi"
> +
> +/ {
> +	model = "Kontron i.MX8MM N801X SoM";
> +	compatible = "kontron,imx8mm-n801x-som", "fsl,imx8mm";
> +
> +	memory@40000000 {
> +		device_type = "memory";
> +		/*
> +		 * There are multiple SoM flavors with different DDR sizes.
> +		 * The smallest is 1GB. For larger sizes the bootloader will
> +		 * update the reg property.
> +		 */
> +		reg = <0x0 0x40000000 0 0x80000000>;
> +	};
> +
> +	chosen {
> +		stdout-path = &uart3;
> +	};
> +};
> +
> +&A53_0 {
> +	cpu-supply = <&reg_vdd_arm>;
> +};
> +
> +&A53_1 {
> +	cpu-supply = <&reg_vdd_arm>;
> +};
> +
> +&A53_2 {
> +	cpu-supply = <&reg_vdd_arm>;
> +};
> +
> +&A53_3 {
> +	cpu-supply = <&reg_vdd_arm>;
> +};
> +
> +&ddrc {
> +	operating-points-v2 = <&ddrc_opp_table>;
> +
> +	ddrc_opp_table: opp-table {
> +		compatible = "operating-points-v2";
> +
> +		opp-25M {
> +			opp-hz = /bits/ 64 <25000000>;
> +		};
> +
> +		opp-100M {
> +			opp-hz = /bits/ 64 <100000000>;
> +		};
> +
> +		opp-750M {
> +			opp-hz = /bits/ 64 <750000000>;
> +		};
> +	};

Why is this a board level setting?

> +};
> +
> +&ecspi1 {
> +	pinctrl-names = "default";
> +	pinctrl-0 = <&pinctrl_ecspi1>;
> +	cs-gpios = <&gpio5 9 GPIO_ACTIVE_HIGH>;
> +	status = "okay";
> +
> +	spi-flash@0 {
> +		compatible = "mxicy,mx25r1635f", "jedec,spi-nor";
> +		spi-max-frequency = <80000000>;
> +		reg = <0>;
> +	};
> +};
> +
> +&i2c1 {
> +	clock-frequency = <400000>;
> +	pinctrl-names = "default";
> +	pinctrl-0 = <&pinctrl_i2c1>;
> +	status = "okay";
> +
> +	pmic: pca9450@25 {

Node name should be generic while label could be specific.  So it should
be better to name it like:

	pca9450: pmic@25

Shawn

> +		compatible = "nxp,pca9450a";
> +		reg = <0x25>;
> +		pinctrl-0 = <&pinctrl_pmic>;
> +		interrupt-parent = <&gpio1>;
> +		interrupts = <0 GPIO_ACTIVE_LOW>;
> +
> +		regulators {
> +			reg_vdd_soc: BUCK1 {
> +				regulator-name = "BUCK1";
> +				regulator-min-microvolt = <800000>;
> +				regulator-max-microvolt = <900000>;
> +				regulator-boot-on;
> +				regulator-always-on;
> +				regulator-ramp-delay = <3125>;
> +			};
> +
> +			reg_vdd_arm: BUCK2 {
> +				regulator-name = "BUCK2";
> +				regulator-min-microvolt = <850000>;
> +				regulator-max-microvolt = <950000>;
> +				regulator-boot-on;
> +				regulator-ramp-delay = <3125>;
> +				nxp,dvs-run-voltage = <950000>;
> +				nxp,dvs-standby-voltage = <850000>;
> +			};
> +
> +			reg_vdd_dram: BUCK3 {
> +				regulator-name = "BUCK3";
> +				regulator-min-microvolt = <850000>;
> +				regulator-max-microvolt = <900000>;
> +				regulator-boot-on;
> +				regulator-always-on;
> +			};
> +
> +			reg_vdd_3v3: BUCK4 {
> +				regulator-name = "BUCK4";
> +				regulator-min-microvolt = <3300000>;
> +				regulator-max-microvolt = <3300000>;
> +				regulator-boot-on;
> +				regulator-always-on;
> +			};
> +
> +			reg_vdd_1v8: BUCK5 {
> +				regulator-name = "BUCK5";
> +				regulator-min-microvolt = <1800000>;
> +				regulator-max-microvolt = <1800000>;
> +				regulator-boot-on;
> +				regulator-always-on;
> +			};
> +
> +			reg_nvcc_dram: BUCK6 {
> +				regulator-name = "BUCK6";
> +				regulator-min-microvolt = <1100000>;
> +				regulator-max-microvolt = <1100000>;
> +				regulator-boot-on;
> +				regulator-always-on;
> +			};
> +
> +			reg_nvcc_snvs: LDO1 {
> +				regulator-name = "LDO1";
> +				regulator-min-microvolt = <1800000>;
> +				regulator-max-microvolt = <1800000>;
> +				regulator-boot-on;
> +				regulator-always-on;
> +			};
> +
> +			reg_vdd_snvs: LDO2 {
> +				regulator-compatible = "ldo2";
> +				regulator-name = "LDO2";
> +				regulator-min-microvolt = <900000>;
> +				regulator-max-microvolt = <900000>;
> +				regulator-boot-on;
> +				regulator-always-on;
> +			};
> +
> +			reg_vdda: LDO3 {
> +				regulator-name = "LDO3";
> +				regulator-min-microvolt = <1800000>;
> +				regulator-max-microvolt = <1800000>;
> +				regulator-boot-on;
> +				regulator-always-on;
> +			};
> +
> +			reg_vdd_phy: LDO4 {
> +				regulator-name = "LDO4";
> +				regulator-min-microvolt = <900000>;
> +				regulator-max-microvolt = <900000>;
> +				regulator-boot-on;
> +				regulator-always-on;
> +			};
> +
> +			reg_nvcc_sd: LDO5 {
> +				regulator-name = "LDO5";
> +				regulator-min-microvolt = <1800000>;
> +				regulator-max-microvolt = <3300000>;
> +			};
> +		};
> +	};
> +};
> +
> +&uart3 { /* console */
> +	pinctrl-names = "default";
> +	pinctrl-0 = <&pinctrl_uart3>;
> +	status = "okay";
> +};
> +
> +&usdhc1 {
> +	pinctrl-names = "default", "state_100mhz", "state_200mhz";
> +	pinctrl-0 = <&pinctrl_usdhc1>;
> +	pinctrl-1 = <&pinctrl_usdhc1_100mhz>;
> +	pinctrl-2 = <&pinctrl_usdhc1_200mhz>;
> +	vmmc-supply = <&reg_vdd_3v3>;
> +	vqmmc-supply = <&reg_vdd_1v8>;
> +	bus-width = <8>;
> +	non-removable;
> +	status = "okay";
> +};
> +
> +&wdog1 {
> +	pinctrl-names = "default";
> +	pinctrl-0 = <&pinctrl_wdog>;
> +	fsl,ext-reset-output;
> +	status = "okay";
> +};
> +
> +&iomuxc {
> +	pinctrl_ecspi1: ecspi1grp {
> +		fsl,pins = <
> +			MX8MM_IOMUXC_ECSPI1_MISO_ECSPI1_MISO		0x82
> +			MX8MM_IOMUXC_ECSPI1_MOSI_ECSPI1_MOSI		0x82
> +			MX8MM_IOMUXC_ECSPI1_SCLK_ECSPI1_SCLK		0x82
> +			MX8MM_IOMUXC_ECSPI1_SS0_GPIO5_IO9		0x19
> +		>;
> +	};
> +
> +	pinctrl_i2c1: i2c1grp {
> +		fsl,pins = <
> +			MX8MM_IOMUXC_I2C1_SCL_I2C1_SCL			0x400001c3
> +			MX8MM_IOMUXC_I2C1_SDA_I2C1_SDA			0x400001c3
> +		>;
> +	};
> +
> +	pinctrl_pmic: pmicgrp {
> +		fsl,pins = <
> +			MX8MM_IOMUXC_GPIO1_IO00_GPIO1_IO0		0x41
> +		>;
> +	};
> +
> +	pinctrl_uart3: uart3grp {
> +		fsl,pins = <
> +			MX8MM_IOMUXC_UART3_RXD_UART3_DCE_RX		0x140
> +			MX8MM_IOMUXC_UART3_TXD_UART3_DCE_TX		0x140
> +		>;
> +	};
> +
> +	pinctrl_usdhc1: usdhc1grp {
> +		fsl,pins = <
> +			MX8MM_IOMUXC_SD1_CLK_USDHC1_CLK			0x190
> +			MX8MM_IOMUXC_SD1_CMD_USDHC1_CMD			0x1d0
> +			MX8MM_IOMUXC_SD1_DATA0_USDHC1_DATA0		0x1d0
> +			MX8MM_IOMUXC_SD1_DATA1_USDHC1_DATA1		0x1d0
> +			MX8MM_IOMUXC_SD1_DATA2_USDHC1_DATA2		0x1d0
> +			MX8MM_IOMUXC_SD1_DATA3_USDHC1_DATA3		0x1d0
> +			MX8MM_IOMUXC_SD1_DATA4_USDHC1_DATA4		0x1d0
> +			MX8MM_IOMUXC_SD1_DATA5_USDHC1_DATA5		0x1d0
> +			MX8MM_IOMUXC_SD1_DATA6_USDHC1_DATA6		0x1d0
> +			MX8MM_IOMUXC_SD1_DATA7_USDHC1_DATA7		0x1d0
> +			MX8MM_IOMUXC_SD1_RESET_B_USDHC1_RESET_B		0x019
> +			MX8MM_IOMUXC_SD1_STROBE_USDHC1_STROBE		0x190
> +		>;
> +	};
> +
> +	pinctrl_usdhc1_100mhz: usdhc1grp100mhz {
> +		fsl,pins = <
> +			MX8MM_IOMUXC_SD1_CLK_USDHC1_CLK			0x194
> +			MX8MM_IOMUXC_SD1_CMD_USDHC1_CMD			0x1d4
> +			MX8MM_IOMUXC_SD1_DATA0_USDHC1_DATA0		0x1d4
> +			MX8MM_IOMUXC_SD1_DATA1_USDHC1_DATA1		0x1d4
> +			MX8MM_IOMUXC_SD1_DATA2_USDHC1_DATA2		0x1d4
> +			MX8MM_IOMUXC_SD1_DATA3_USDHC1_DATA3		0x1d4
> +			MX8MM_IOMUXC_SD1_DATA4_USDHC1_DATA4		0x1d4
> +			MX8MM_IOMUXC_SD1_DATA5_USDHC1_DATA5		0x1d4
> +			MX8MM_IOMUXC_SD1_DATA6_USDHC1_DATA6		0x1d4
> +			MX8MM_IOMUXC_SD1_DATA7_USDHC1_DATA7		0x1d4
> +			MX8MM_IOMUXC_SD1_RESET_B_USDHC1_RESET_B		0x019
> +			MX8MM_IOMUXC_SD1_STROBE_USDHC1_STROBE		0x194
> +		>;
> +	};
> +
> +	pinctrl_usdhc1_200mhz: usdhc1grp200mhz {
> +		fsl,pins = <
> +			MX8MM_IOMUXC_SD1_CLK_USDHC1_CLK			0x196
> +			MX8MM_IOMUXC_SD1_CMD_USDHC1_CMD			0x1d6
> +			MX8MM_IOMUXC_SD1_DATA0_USDHC1_DATA0		0x1d6
> +			MX8MM_IOMUXC_SD1_DATA1_USDHC1_DATA1		0x1d6
> +			MX8MM_IOMUXC_SD1_DATA2_USDHC1_DATA2		0x1d6
> +			MX8MM_IOMUXC_SD1_DATA3_USDHC1_DATA3		0x1d6
> +			MX8MM_IOMUXC_SD1_DATA4_USDHC1_DATA4		0x1d6
> +			MX8MM_IOMUXC_SD1_DATA5_USDHC1_DATA5		0x1d6
> +			MX8MM_IOMUXC_SD1_DATA6_USDHC1_DATA6		0x1d6
> +			MX8MM_IOMUXC_SD1_DATA7_USDHC1_DATA7		0x1d6
> +			MX8MM_IOMUXC_SD1_RESET_B_USDHC1_RESET_B		0x019
> +			MX8MM_IOMUXC_SD1_STROBE_USDHC1_STROBE		0x196
> +		>;
> +	};
> +
> +	pinctrl_wdog: wdoggrp {
> +		fsl,pins = <
> +			MX8MM_IOMUXC_GPIO1_IO02_WDOG1_WDOG_B		0xc6
> +		>;
> +	};
> +};
> -- 
> 2.17.1
> 
