Return-Path: <SRS0=fG1M=4C=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6995EC3B194
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Feb 2020 03:30:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3F5A8218AC
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Feb 2020 03:30:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1581651042;
	bh=cFymu8WHwzOuB2faV3iSaCil+S4/VFHZmiQjjhggf/c=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=KTdwWwln36cu8BPCp+rGzFMxDuqFpqlpt0Rb555gcCQD2vKfoCGB+Ert2fcGn+OZ7
	 PxdGVNmDt7g7wxuRGfE84p+PVBl8zqDdl4dfFNvkSeieUOGUlf0uj+f9pTIdzDr9KA
	 vtxlrmBZJGG1TlnQbMEM8mjO6kU/fKHIfj7g8LPM=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728416AbgBNDal (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 13 Feb 2020 22:30:41 -0500
Received: from mail.kernel.org ([198.145.29.99]:48666 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728053AbgBNDal (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Feb 2020 22:30:41 -0500
Received: from dragon (80.251.214.228.16clouds.com [80.251.214.228])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 388E0217F4;
        Fri, 14 Feb 2020 03:30:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1581651039;
        bh=cFymu8WHwzOuB2faV3iSaCil+S4/VFHZmiQjjhggf/c=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=vS7e75lbp8XciOJBp9sW6LWZAZT89snsi8eCasoMxvtvX5jwgvgWwpoHegvvx4M+9
         NUOegkb9XK9tzpo9iqlw9RMAbROCoSF5kKDqNyRvT7tm4L+P9yUtHsBEFrqNXkHqjR
         KMR5NzRIqH1poVYmaCGWqkmCfNniyLihRRSHr99E=
Date:   Fri, 14 Feb 2020 11:30:31 +0800
From:   Shawn Guo <shawnguo@kernel.org>
To:     =?iso-8859-1?Q?Andr=E9?= Draszik <git@andred.net>
Cc:     linux-kernel@vger.kernel.org, Ilya Ledvich <ilya@compulab.co.il>,
        Igor Grinberg <grinberg@compulab.co.il>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>,
        NXP Linux Team <linux-imx@nxp.com>,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH v3 12/12] ARM: dts: imx7d: sbc-iot-imx7: add basic board
 support
Message-ID: <20200214033030.GO22842@dragon>
References: <20200131083638.6118-1-git@andred.net>
 <20200131083638.6118-12-git@andred.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20200131083638.6118-12-git@andred.net>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jan 31, 2020 at 08:36:38AM +0000, André Draszik wrote:
> This is a forward-port of Compulab's downstream commit
> against linux 4.9.11, including updates to work with
> more recent kernels.
> 
> Original commit message:
>     The SB-IOT-iMX7 base board together with CL-SOM-iMX7
>     SoM forms SBC-IOT-iMX7 single board computer.
>     SBC-IOT-iMX7 is a single board computer optimized for
>     industrial control and monitoring, extensive wireless
>     and wired connectivity, ideal solution for
>     cost-sensitive systems. It is based on the Freescale
>     i.MX7 system-on-chip. SBC-IOT-iMX7 is implemented with
>     the CL-SOM-iMX7 System-on-Module providing most of the
>     functions,and SB-IOT-iMX7 carrier board providing
>     additional peripheral functions and connectors.
> 
>     https://www.compulab.com/products/computer-on-modules/cl-som-imx7-freescale-i-mx-7-system-on-module/
>     https://www.compulab.com/products/sbcs/sbc-iot-imx7-nxp-i-mx-7-internet-of-things-single-board-computer/
> 
> This commit adds basic board support, including:
> * SD-card (note that write-protect is not connected
>   on this carrier board)
> * SPI (available on expansion header)
> * i2c3 & i2c4 (including bus recovery information)
> * additional UARTs
> * all USB ports
> * SNVS powerkey
> 
> Compared to the downtream commit, this commit doesn't
> add / enable the PCIe and LCD interface, as PCIe
> support needs an additional patch to the PCI controller
> first, and I can't test the LCD.
> 
> Signed-off-by: André Draszik <git@andred.net>
> Cc: Ilya Ledvich <ilya@compulab.co.il>
> Cc: Igor Grinberg <grinberg@compulab.co.il>
> Cc: Rob Herring <robh+dt@kernel.org>
> Cc: Mark Rutland <mark.rutland@arm.com>
> Cc: Shawn Guo <shawnguo@kernel.org>
> Cc: Sascha Hauer <s.hauer@pengutronix.de>
> Cc: Pengutronix Kernel Team <kernel@pengutronix.de>
> Cc: Fabio Estevam <festevam@gmail.com>
> Cc: NXP Linux Team <linux-imx@nxp.com>
> Cc: devicetree@vger.kernel.org
> Cc: linux-arm-kernel@lists.infradead.org
> 
> ---
> v3:
> * enable snvs_pwrkey node
> 
> v2:
> * use standard uart-has-rtscts instead of fsl,uart-has-rtscts
> 
> ARM: dts: imx7d: sbc-iot-imx7: has a power key
> 
> Signed-off-by: André Draszik <git@andred.net>
> ---
>  arch/arm/boot/dts/Makefile               |   1 +
>  arch/arm/boot/dts/imx7d-sbc-iot-imx7.dts | 202 +++++++++++++++++++++++
>  2 files changed, 203 insertions(+)
>  create mode 100644 arch/arm/boot/dts/imx7d-sbc-iot-imx7.dts
> 
> diff --git a/arch/arm/boot/dts/Makefile b/arch/arm/boot/dts/Makefile
> index 08011dc8c7a6..6efbfa613366 100644
> --- a/arch/arm/boot/dts/Makefile
> +++ b/arch/arm/boot/dts/Makefile
> @@ -603,6 +603,7 @@ dtb-$(CONFIG_SOC_IMX7D) += \
>  	imx7d-pico-hobbit.dtb \
>  	imx7d-pico-pi.dtb \
>  	imx7d-sbc-imx7.dtb \
> +	imx7d-sbc-iot-imx7.dtb \
>  	imx7d-sdb.dtb \
>  	imx7d-sdb-reva.dtb \
>  	imx7d-sdb-sht11.dtb \
> diff --git a/arch/arm/boot/dts/imx7d-sbc-iot-imx7.dts b/arch/arm/boot/dts/imx7d-sbc-iot-imx7.dts
> new file mode 100644
> index 000000000000..4ffa67f2e530
> --- /dev/null
> +++ b/arch/arm/boot/dts/imx7d-sbc-iot-imx7.dts
> @@ -0,0 +1,202 @@
> +// SPDX-License-Identifier: GPL-2.0+ OR MIT
> +//
> +// Copyright 2017 CompuLab Ltd. - http://www.compulab.co.il/
> +/*
> + * Support for CompuLab SBC-IOT-iMX7 Single Board Computer
> + */
> +
> +#include "imx7d-cl-som-imx7.dts"
> +
> +/ {
> +	model = "CompuLab,SBC-IOT-iMX7";
> +	compatible = "compulab,sbc-iot-imx7", "compulab,cl-som-imx7", "fsl,imx7d";

Any new compatibles need to be documented.

> +
> +	reg_usb_vbus: regulator-usb-vbus {
> +		compatible = "regulator-fixed";
> +		regulator-name = "usb_vbus";
> +		regulator-min-microvolt = <5000000>;
> +		regulator-max-microvolt = <5000000>;
> +		regulator-always-on;
> +	};
> +};
> +
> +&ecspi3 {
> +	pinctrl-names = "default";
> +	pinctrl-0 = <&pinctrl_ecspi3 &pinctrl_ecspi3_cs>;
> +	cs-gpios = <&gpio4 11 GPIO_ACTIVE_HIGH>;
> +	status = "okay";
> +};
> +
> +&i2c3 {
> +	clock-frequency = <100000>;
> +	pinctrl-names = "default", "gpio";
> +	pinctrl-0 = <&pinctrl_i2c3>;
> +	pinctrl-1 = <&pinctrl_i2c3_recovery>;
> +	sda-gpios = <&gpio1 9 GPIO_ACTIVE_HIGH>;
> +	scl-gpios = <&gpio1 8 (GPIO_ACTIVE_HIGH | GPIO_OPEN_DRAIN)>;
> +	status = "okay";
> +};
> +
> +&i2c4 {
> +	clock-frequency = <100000>;
> +	pinctrl-names = "default", "gpio";
> +	pinctrl-0 = <&pinctrl_i2c4>;
> +	pinctrl-1 = <&pinctrl_i2c4_recovery>;
> +	sda-gpios = <&gpio1 11 GPIO_ACTIVE_HIGH>;
> +	scl-gpios = <&gpio1 10 (GPIO_ACTIVE_HIGH | GPIO_OPEN_DRAIN)>;
> +	status = "okay";
> +
> +	eeprom_iot@54 {

The '_iot' in the node name doesn't make a lot sense.

> +		compatible = "atmel,24c08";
> +		reg = <0x54>;
> +		pagesize = <16>;
> +	};
> +};
> +
> +&snvs_pwrkey {

Keep the node sort alphabetically.

Shawn

> +	status = "okay";
> +};
> +
> +&iomuxc {
> +	pinctrl-1 = <&pinctrl_xpen>;
> +
> +	/* SB-IOT-iMX7 Xpension Header P7 */
> +	pinctrl_xpen: xpengrp {
> +		fsl,pins = <
> +			MX7D_PAD_LCD_DATA13__GPIO3_IO18		0x34 /* P7-4 - gpio82 */
> +			MX7D_PAD_LCD_DATA12__GPIO3_IO17		0x34 /* P7-5 - gpio81 */
> +		>;
> +	};
> +
> +	pinctrl_ecspi3: ecspi3grp {
> +		fsl,pins = <
> +			MX7D_PAD_I2C1_SDA__ECSPI3_MOSI		0xf /* P7-7 */
> +			MX7D_PAD_I2C1_SCL__ECSPI3_MISO		0xf /* P7-8 */
> +			MX7D_PAD_I2C2_SCL__ECSPI3_SCLK		0xf /* P7-6 */
> +		>;
> +	};
> +
> +	pinctrl_ecspi3_cs: ecspi3_cs_grp {
> +		fsl,pins = <
> +			MX7D_PAD_I2C2_SDA__GPIO4_IO11		0x34 /* P7-9 */
> +		>;
> +	};
> +
> +	pinctrl_i2c3: i2c3grp {
> +		fsl,pins = <
> +			MX7D_PAD_GPIO1_IO09__I2C3_SDA		0x4000000f /* P7-3 */
> +			MX7D_PAD_GPIO1_IO08__I2C3_SCL		0x4000000f /* P7-2 */
> +		>;
> +	};
> +
> +	pinctrl_i2c3_recovery: i2c3recoverygrp {
> +		fsl,pins = <
> +			MX7D_PAD_GPIO1_IO09__GPIO1_IO9		0x4000000f /* P7-3 */
> +			MX7D_PAD_GPIO1_IO08__GPIO1_IO8		0x4000000f /* P7-2 */
> +		>;
> +	};
> +
> +	pinctrl_i2c4: i2c4grp {
> +		fsl,pins = <
> +			MX7D_PAD_GPIO1_IO11__I2C4_SDA		0x4000000f
> +			MX7D_PAD_GPIO1_IO10__I2C4_SCL		0x4000000f
> +		>;
> +	};
> +
> +	pinctrl_i2c4_recovery: i2c4recoverygrp {
> +		fsl,pins = <
> +			MX7D_PAD_GPIO1_IO11__GPIO1_IO11		0x4000000f
> +			MX7D_PAD_GPIO1_IO10__GPIO1_IO10		0x4000000f
> +		>;
> +	};
> +
> +	pinctrl_uart2: uart2grp {
> +		fsl,pins = <
> +			MX7D_PAD_LCD_ENABLE__UART2_DCE_TX	0x79 /* P7-12 */
> +			MX7D_PAD_LCD_CLK__UART2_DCE_RX		0x79 /* P7-13 */
> +			MX7D_PAD_LCD_VSYNC__UART2_DCE_CTS	0x79 /* P7-11 */
> +			MX7D_PAD_LCD_HSYNC__UART2_DCE_RTS	0x79 /* P7-10 */
> +		>;
> +	};
> +
> +	pinctrl_uart5: uart5grp {
> +		fsl,pins = <
> +			MX7D_PAD_I2C4_SDA__UART5_DCE_TX		0x79 /* RS232-TX */
> +			MX7D_PAD_I2C4_SCL__UART5_DCE_RX		0x79 /* RS232-RX */
> +			MX7D_PAD_I2C3_SDA__UART5_DCE_RTS	0x79 /* RS232-RTS */
> +			MX7D_PAD_I2C3_SCL__UART5_DCE_CTS	0x79 /* RS232-CTS */
> +		>;
> +	};
> +
> +	pinctrl_uart7: uart7grp {
> +		fsl,pins = <
> +			MX7D_PAD_ECSPI2_MOSI__UART7_DCE_TX	0x79 /* R485-TX */
> +			MX7D_PAD_ECSPI2_SCLK__UART7_DCE_RX	0x79 /* R485-RX */
> +			MX7D_PAD_ECSPI2_SS0__UART7_DCE_CTS	0x79 /* R485-CTS */
> +			MX7D_PAD_ECSPI2_MISO__UART7_DCE_RTS	0x79 /* R485-TTS */
> +		>;
> +	};
> +
> +	pinctrl_usdhc1: usdhc1grp {
> +		fsl,pins = <
> +			MX7D_PAD_SD1_CMD__SD1_CMD		0x59
> +			MX7D_PAD_SD1_CLK__SD1_CLK		0x19
> +			MX7D_PAD_SD1_DATA0__SD1_DATA0		0x59
> +			MX7D_PAD_SD1_DATA1__SD1_DATA1		0x59
> +			MX7D_PAD_SD1_DATA2__SD1_DATA2		0x59
> +			MX7D_PAD_SD1_DATA3__SD1_DATA3		0x59
> +			MX7D_PAD_SD1_CD_B__GPIO5_IO0		0x59 /* CD */
> +		>;
> +	};
> +};
> +
> +&uart2 {
> +	pinctrl-names = "default";
> +	pinctrl-0 = <&pinctrl_uart2>;
> +	assigned-clocks = <&clks IMX7D_UART2_ROOT_SRC>;
> +	assigned-clock-parents = <&clks IMX7D_OSC_24M_CLK>;
> +	uart-has-rtscts;
> +	status = "okay";
> +};
> +
> +&uart5 {
> +	pinctrl-names = "default";
> +	pinctrl-0 = <&pinctrl_uart5>;
> +	assigned-clocks = <&clks IMX7D_UART5_ROOT_SRC>;
> +	assigned-clock-parents = <&clks IMX7D_PLL_SYS_MAIN_240M_CLK>;
> +	uart-has-rtscts;
> +	status = "okay";
> +};
> +
> +&uart7 {
> +	pinctrl-names = "default";
> +	pinctrl-0 = <&pinctrl_uart7>;
> +	assigned-clocks = <&clks IMX7D_UART7_ROOT_SRC>;
> +	assigned-clock-parents = <&clks IMX7D_PLL_SYS_MAIN_240M_CLK>;
> +	uart-has-rtscts;
> +	status = "okay";
> +};
> +
> +&usbotg1 {
> +	vbus-supply = <&reg_usb_vbus>;
> +	status = "okay";
> +};
> +
> +&usbotg2 {
> +	dr_mode = "host";
> +	vbus-supply = <&reg_usb_vbus>;
> +	status = "okay";
> +};
> +
> +&usbh {
> +	vbus-supply = <&reg_usb_vbus>;
> +	status = "okay";
> +};
> +
> +&usdhc1 {
> +	pinctrl-names = "default";
> +	pinctrl-0 = <&pinctrl_usdhc1>;
> +	cd-gpios = <&gpio5 0 GPIO_ACTIVE_LOW>;
> +	wakeup-source;
> +	status = "okay";
> +};
> -- 
> 2.23.0.rc1
> 
