Return-Path: <SRS0=TdnH=CB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.6 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 90E34C433E1
	for <linux-kernel@archiver.kernel.org>; Sun, 23 Aug 2020 01:42:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 650E4207C3
	for <linux-kernel@archiver.kernel.org>; Sun, 23 Aug 2020 01:42:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1598146964;
	bh=IcqGcxQ3S0dgJgCwSRJLHV4Wxr6R23nHndaBD1txYDQ=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=rhSIm913mEKP8WasBcpMvpJcj/yoC7xrRBSmwJ6PtZenWIHqanw3teTl4AYCzYWwU
	 KnnW4q2hn8TiEhgeU/k1nllRZ+5XZdH1OVRzooPMcYFLTyVo+Blhpg7r091bmJtYT2
	 qPGsN0KbfNKqJuhDZkrfclicWujtTCYWKOFCMlyM=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726513AbgHWBmk (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 22 Aug 2020 21:42:40 -0400
Received: from mail.kernel.org ([198.145.29.99]:45588 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725906AbgHWBmi (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 22 Aug 2020 21:42:38 -0400
Received: from dragon (80.251.214.228.16clouds.com [80.251.214.228])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 39FCE2078D;
        Sun, 23 Aug 2020 01:42:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1598146957;
        bh=IcqGcxQ3S0dgJgCwSRJLHV4Wxr6R23nHndaBD1txYDQ=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=U+b6XDXxBPwJUiOEI0Bpb8QV6ZCsb6GEMHdMwNEmEbPkB7BM9AnrHvu7VBwfbTs/m
         MHTTnAwn1Q8vI4RTFsxMDGsa3GzyFzZwbkrKPmGi4LCkblY3tNhAqGMVPAK4LK4RiI
         fp9/5SrDGF+CV6pQWX+LdBOt8EtGC7LdPQPWDDD4=
Date:   Sun, 23 Aug 2020 09:42:31 +0800
From:   Shawn Guo <shawnguo@kernel.org>
To:     Andreas Kemnade <andreas@kemnade.info>
Cc:     robh+dt@kernel.org, s.hauer@pengutronix.de, kernel@pengutronix.de,
        festevam@gmail.com, linux-imx@nxp.com, Anson.Huang@nxp.com,
        marcel.ziswiler@toradex.com, sebastien.szymanski@armadeus.com,
        michael@walle.cc, rjones@gateworks.com, leoyang.li@nxp.com,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, j.neuschaefer@gmx.net,
        letux-kernel@openphoenux.org
Subject: Re: [PATCH RFC 2/2] ARM: dts: imx: add devicetree for Tolino Shine 2
 HD
Message-ID: <20200823014226.GG30094@dragon>
References: <20200815193336.21598-1-andreas@kemnade.info>
 <20200815193336.21598-3-andreas@kemnade.info>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200815193336.21598-3-andreas@kemnade.info>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Aug 15, 2020 at 09:33:36PM +0200, Andreas Kemnade wrote:
> This adds a devicetree for the Tolino Shine 2 HD Ebook reader. It is based
> on boards marked with "37NB-E60QF0+4A2". It is equipped with an i.MX6SL
> SoC.
> 
> Expected to work:
> - Buttons
> - Wifi
> - Touchscreen
> - LED
> - uSD
> - USB
> - RTC
> 
> Not working due to missing drivers:
> - Backlight (requires NTXEC driver)
> - EPD
> 
> Not working due to unknown reasons:
> - deep sleep (echo standby >/sys/power/state works),
>   wakeup fails when imx_gpc_pre_suspend(true) was called.
> 
> Signed-off-by: Andreas Kemnade <andreas@kemnade.info>
> ---
> Reason for RFC: The suspend trouble might be caused by bad devicetree.
> But as the devicetree is already useful I decided to submit it.
> 
>  arch/arm/boot/dts/Makefile                   |   1 +
>  arch/arm/boot/dts/imx6sl-tolino-shine2hd.dts | 582 +++++++++++++++++++
>  2 files changed, 583 insertions(+)
>  create mode 100644 arch/arm/boot/dts/imx6sl-tolino-shine2hd.dts
> 
> diff --git a/arch/arm/boot/dts/Makefile b/arch/arm/boot/dts/Makefile
> index e6a1cac0bfc7..c65fa3852246 100644
> --- a/arch/arm/boot/dts/Makefile
> +++ b/arch/arm/boot/dts/Makefile
> @@ -581,6 +581,7 @@ dtb-$(CONFIG_SOC_IMX6Q) += \
>  	imx6qp-zii-rdu2.dtb
>  dtb-$(CONFIG_SOC_IMX6SL) += \
>  	imx6sl-evk.dtb \
> +	imx6sl-tolino-shine2hd.dtb \
>  	imx6sl-tolino-shine3.dtb \
>  	imx6sl-warp.dtb
>  dtb-$(CONFIG_SOC_IMX6SLL) += \
> diff --git a/arch/arm/boot/dts/imx6sl-tolino-shine2hd.dts b/arch/arm/boot/dts/imx6sl-tolino-shine2hd.dts
> new file mode 100644
> index 000000000000..7b28e19a1d98
> --- /dev/null
> +++ b/arch/arm/boot/dts/imx6sl-tolino-shine2hd.dts
> @@ -0,0 +1,582 @@
> +// SPDX-License-Identifier: (GPL-2.0)
> +/*
> + * Device tree for the Tolino Shine 2 HD ebook reader
> + *
> + * Name on mainboard is: 37NB-E60QF0+4A2
> + * Serials start with: E60QF2
> + *
> + * Copyright 2020 Andreas Kemnade
> + */
> +
> +/dts-v1/;
> +
> +#include <dt-bindings/input/input.h>
> +#include <dt-bindings/gpio/gpio.h>
> +#include "imx6sl.dtsi"
> +
> +/ {
> +	model = "Tolino Shine 2 HD";
> +	compatible = "kobo,tolino-shine2hd", "fsl,imx6sl";
> +
> +	chosen {
> +		stdout-path = &uart1;
> +	};
> +
> +	gpio_keys: gpio-keys {
> +		compatible = "gpio-keys";
> +		pinctrl-names = "default";
> +		pinctrl-0 = <&pinctrl_gpio_keys>;
> +
> +		cover {
> +			label = "Cover";
> +			gpios = <&gpio5 12 GPIO_ACTIVE_LOW>;
> +			linux,code = <SW_LID>;
> +			linux,input-type = <EV_SW>;
> +			wakeup-source;
> +		};
> +
> +		fl {
> +			label = "Frontlight";
> +			gpios = <&gpio3 26 GPIO_ACTIVE_LOW>;
> +			linux,code = <KEY_BRIGHTNESS_CYCLE>;
> +		};
> +
> +		home {
> +			label = "Home";
> +			gpios = <&gpio3 25 GPIO_ACTIVE_LOW>;
> +			linux,code = <KEY_HOME>;
> +		};
> +
> +		power {
> +			label = "Power";
> +			gpios = <&gpio5 8 GPIO_ACTIVE_LOW>;
> +			linux,code = <KEY_POWER>;
> +			wakeup-source;
> +		};
> +	};
> +
> +	leds: leds {
> +		compatible = "gpio-leds";
> +		pinctrl-names = "default";
> +		pinctrl-0 = <&pinctrl_led>;
> +
> +		on {
> +			label = "tolinoshine2hd:white:on";
> +			gpios = <&gpio5 13 GPIO_ACTIVE_LOW>;
> +			linux,default-trigger = "timer";
> +		};
> +	};
> +
> +	memory@80000000 {
> +		device_type = "memory";
> +		reg = <0x80000000 0x20000000>;
> +	};
> +
> +	reg_wifi: regulator-wifi {
> +		compatible = "regulator-fixed";
> +		pinctrl-names = "default";
> +		pinctrl-0 = <&pinctrl_wifi_power>;
> +		regulator-name = "SD3_SPWR";
> +		regulator-min-microvolt = <3000000>;
> +		regulator-max-microvolt = <3000000>;
> +		gpio = <&gpio4 29 GPIO_ACTIVE_HIGH>;

Missing enable-active-high?

> +	};
> +
> +	wifi_pwrseq: wifi_pwrseq {
> +		compatible = "mmc-pwrseq-simple";
> +		pinctrl-names = "default";
> +		pinctrl-0 = <&pinctrl_wifi_reset>;
> +		post-power-on-delay-ms = <20>;
> +		reset-gpios = <&gpio5 0 GPIO_ACTIVE_LOW>;
> +	};
> +};
> +
> +&i2c1 {
> +	pinctrl-names = "default","sleep";
> +	pinctrl-0 = <&pinctrl_i2c1>;
> +	pinctrl-1 = <&pinctrl_i2c1_sleep>;
> +	status = "okay";
> +
> +	/* TODO: embedded controller at 0x43 (driver missing) */
> +
> +};
> +
> +&i2c2 {
> +	pinctrl-names = "default","sleep";
> +	pinctrl-0 = <&pinctrl_i2c2>;
> +	pinctrl-1 = <&pinctrl_i2c2_sleep>;
> +	clock-frequency = <100000>;
> +	status = "okay";
> +
> +	zforce: touchscreen@50 {
> +		compatible = "neonode,zforce";
> +		pinctrl-names = "default";
> +		pinctrl-0 = <&pinctrl_zforce>;
> +		reg = <0x50>;
> +		interrupt-parent = <&gpio5>;
> +		interrupts = <6 IRQ_TYPE_EDGE_FALLING>;
> +		vdd-supply = <&ldo1_reg>;
> +

Unnecessary newline.

> +		reset-gpios = <&gpio5 9 GPIO_ACTIVE_LOW>;
> +		x-size = <1072>;
> +		y-size = <1448>;
> +	};
> +
> +	/* TODO: TPS65185 PMIC for E Ink at 0x68 */
> +
> +};
> +
> +&i2c3 {
> +	pinctrl-names = "default";
> +	pinctrl-0 = <&pinctrl_i2c3>;
> +	clock-frequency = <400000>;
> +	status = "okay";
> +
> +	ricoh619: pmic@32 {
> +		compatible = "ricoh,rc5t619";
> +		pinctrl-names = "default";
> +		pinctrl-0 = <&pinctrl_ricoh_gpio>;
> +		reg = <0x32>;
> +		interrupt-parent = <&gpio5>;
> +		interrupts = <11 IRQ_TYPE_EDGE_FALLING>;
> +		system-power-controller;
> +
> +		regulators {
> +			dcdc1_reg: DCDC1 {
> +				regulator-name = "DCDC1";
> +				regulator-min-microvolt = <300000>;
> +				regulator-max-microvolt = <1875000>;
> +				regulator-always-on;
> +				regulator-boot-on;
> +
> +				regulator-state-mem {
> +					regulator-on-in-suspend;
> +					regulator-suspend-max-microvolt = <900000>;
> +					regulator-suspend-min-microvolt = <900000>;
> +				};
> +			};
> +
> +			/* Core3_3V3 */
> +			dcdc2_reg: DCDC2 {
> +				regulator-name = "DCDC2";
> +				regulator-always-on;
> +				regulator-boot-on;
> +
> +				regulator-state-mem {
> +					regulator-on-in-suspend;
> +					regulator-suspend-max-microvolt = <3100000>;
> +					regulator-suspend-min-microvolt = <3100000>;
> +				};
> +			};
> +
> +			dcdc3_reg: DCDC3 {
> +				regulator-name = "DCDC3";
> +				regulator-min-microvolt = <300000>;
> +				regulator-max-microvolt = <1875000>;
> +				regulator-always-on;
> +				regulator-boot-on;
> +
> +				regulator-state-mem {
> +					regulator-on-in-suspend;
> +					regulator-suspend-max-microvolt = <1140000>;
> +					regulator-suspend-min-microvolt = <1140000>;
> +				};
> +			};
> +
> +			/* Core4_1V2 */
> +			dcdc4_reg: DCDC4 {
> +				regulator-name = "DCDC4";
> +				regulator-min-microvolt = <1200000>;
> +				regulator-max-microvolt = <1200000>;
> +				regulator-always-on;
> +				regulator-boot-on;
> +
> +				regulator-state-mem {
> +					regulator-on-in-suspend;
> +					regulator-suspend-max-microvolt = <1140000>;
> +					regulator-suspend-min-microvolt = <1140000>;
> +				};
> +			};
> +
> +			/* Core4_1V8 */
> +			dcdc5_reg: DCDC5 {
> +				regulator-name = "DCDC5";
> +				regulator-min-microvolt = <1800000>;
> +				regulator-max-microvolt = <1800000>;
> +				regulator-always-on;
> +				regulator-boot-on;
> +
> +				regulator-state-mem {
> +					regulator-on-in-suspend;
> +					regulator-suspend-max-microvolt = <1700000>;
> +					regulator-suspend-min-microvolt = <1700000>;
> +				};
> +			};
> +
> +			/* IR_3V3 */
> +			ldo1_reg: LDO1  {
> +				regulator-name = "LDO1";
> +				regulator-boot-on;
> +			};
> +
> +			/* Core1_3V3 */
> +			ldo2_reg: LDO2  {
> +				regulator-name = "LDO2";
> +				regulator-always-on;
> +				regulator-boot-on;
> +
> +				regulator-state-mem {
> +					regulator-on-in-suspend;
> +					regulator-suspend-max-microvolt = <3000000>;
> +					regulator-suspend-min-microvolt = <3000000>;
> +				};
> +			};
> +
> +			/* Core5_1V2 */
> +			ldo3_reg: LDO3  {
> +				regulator-name = "LDO3";
> +				regulator-always-on;
> +				regulator-boot-on;
> +			};
> +
> +			ldo4_reg: LDO4 {
> +				regulator-name = "LDO4";
> +				regulator-boot-on;
> +			};
> +
> +			/* SPD_3V3 */
> +			ldo5_reg: LDO5 {
> +				regulator-name = "LDO5";
> +				regulator-always-on;
> +				regulator-boot-on;
> +			};
> +
> +			/* DDR_0V6 */
> +			ldo6_reg: LDO6 {
> +				regulator-name = "LDO6";
> +				regulator-always-on;
> +				regulator-boot-on;
> +			};
> +
> +			/* VDD_PWM */
> +			ldo7_reg: LDO7 {
> +				regulator-name = "LDO7";
> +				regulator-always-on;
> +				regulator-boot-on;
> +			};
> +
> +			/* ldo_1v8 */
> +			ldo8_reg: LDO8 {
> +				regulator-name = "LDO8";
> +				regulator-min-microvolt = <1800000>;
> +				regulator-max-microvolt = <1800000>;
> +				regulator-always-on;
> +				regulator-boot-on;
> +			};
> +
> +			ldo9_reg: LDO9 {
> +				regulator-name = "LDO9";
> +				regulator-boot-on;
> +			};
> +
> +			ldo10_reg: LDO10 {
> +				regulator-name = "LDO10";
> +				regulator-boot-on;
> +			};
> +
> +			ldortc1_reg: LDORTC1  {
> +				regulator-name = "LDORTC1";
> +				regulator-always-on;
> +				regulator-boot-on;
> +			};
> +		};
> +	};
> +};
> +
> +&iomuxc {
> +	pinctrl-names = "default";
> +	pinctrl-0 = <&pinctrl_hog>;
> +
> +	pinctrl_gpio_keys: gpio-keysgrp {
> +		fsl,pins = <
> +			MX6SL_PAD_SD1_DAT1__GPIO5_IO08  0x17059
> +			MX6SL_PAD_SD1_DAT4__GPIO5_IO12  0x17059
> +			MX6SL_PAD_KEY_COL1__GPIO3_IO26  0x17059
> +			MX6SL_PAD_KEY_ROW0__GPIO3_IO25  0x17059
> +		>;
> +	};
> +
> +	pinctrl_hog: hoggrp {
> +		fsl,pins = <
> +			MX6SL_PAD_LCD_DAT0__GPIO2_IO20	0x79
> +			MX6SL_PAD_LCD_DAT1__GPIO2_IO21	0x79
> +			MX6SL_PAD_LCD_DAT2__GPIO2_IO22	0x79
> +			MX6SL_PAD_LCD_DAT3__GPIO2_IO23	0x79
> +			MX6SL_PAD_LCD_DAT4__GPIO2_IO24	0x79
> +			MX6SL_PAD_LCD_DAT5__GPIO2_IO25	0x79
> +			MX6SL_PAD_LCD_DAT6__GPIO2_IO26	0x79
> +			MX6SL_PAD_LCD_DAT7__GPIO2_IO27	0x79
> +			MX6SL_PAD_LCD_DAT8__GPIO2_IO28	0x79
> +			MX6SL_PAD_LCD_DAT9__GPIO2_IO29	0x79
> +			MX6SL_PAD_LCD_DAT10__GPIO2_IO30	0x79
> +			MX6SL_PAD_LCD_DAT11__GPIO2_IO31	0x79
> +			MX6SL_PAD_LCD_DAT12__GPIO3_IO00	0x79
> +			MX6SL_PAD_LCD_DAT13__GPIO3_IO01	0x79
> +			MX6SL_PAD_LCD_DAT14__GPIO3_IO02	0x79
> +			MX6SL_PAD_LCD_DAT15__GPIO3_IO03	0x79
> +			MX6SL_PAD_LCD_DAT16__GPIO3_IO04	0x79
> +			MX6SL_PAD_LCD_DAT17__GPIO3_IO05	0x79
> +			MX6SL_PAD_LCD_DAT18__GPIO3_IO06	0x79
> +			MX6SL_PAD_LCD_DAT19__GPIO3_IO07	0x79
> +			MX6SL_PAD_LCD_DAT20__GPIO3_IO08	0x79
> +			MX6SL_PAD_LCD_DAT21__GPIO3_IO09	0x79
> +			MX6SL_PAD_LCD_DAT22__GPIO3_IO10	0x79
> +			MX6SL_PAD_LCD_DAT23__GPIO3_IO11	0x79
> +			MX6SL_PAD_LCD_CLK__GPIO2_IO15		0x79
> +			MX6SL_PAD_LCD_ENABLE__GPIO2_IO16	0x79
> +			MX6SL_PAD_LCD_HSYNC__GPIO2_IO17	0x79
> +			MX6SL_PAD_LCD_VSYNC__GPIO2_IO18	0x79
> +			MX6SL_PAD_LCD_RESET__GPIO2_IO19	0x79
> +			MX6SL_PAD_KEY_COL3__GPIO3_IO30		0x79
> +			MX6SL_PAD_KEY_ROW7__GPIO4_IO07		0x79
> +			MX6SL_PAD_ECSPI2_MOSI__GPIO4_IO13	0x79
> +			MX6SL_PAD_KEY_COL5__GPIO4_IO02		0x79
> +			MX6SL_PAD_KEY_ROW6__GPIO4_IO05		0x79
> +		>;
> +	};
> +
> +	pinctrl_i2c1: i2c1grp {
> +		fsl,pins = <
> +			MX6SL_PAD_I2C1_SCL__I2C1_SCL	 0x4001f8b1
> +			MX6SL_PAD_I2C1_SDA__I2C1_SDA	 0x4001f8b1
> +		>;
> +	};
> +
> +	pinctrl_i2c1_sleep: i2c1grp-sleep {
> +		fsl,pins = <
> +			MX6SL_PAD_I2C1_SCL__I2C1_SCL	 0x400108b1
> +			MX6SL_PAD_I2C1_SDA__I2C1_SDA	 0x400108b1
> +		>;
> +	};
> +
> +	pinctrl_i2c2: i2c2grp {
> +		fsl,pins = <
> +			MX6SL_PAD_I2C2_SCL__I2C2_SCL	 0x4001f8b1
> +			MX6SL_PAD_I2C2_SDA__I2C2_SDA	 0x4001f8b1
> +		>;
> +	};
> +
> +	pinctrl_i2c2_sleep: i2c2grp-sleep {
> +		fsl,pins = <
> +			MX6SL_PAD_I2C2_SCL__I2C2_SCL	 0x400108b1
> +			MX6SL_PAD_I2C2_SDA__I2C2_SDA	 0x400108b1
> +		>;
> +	};
> +
> +	pinctrl_i2c3: i2c3grp {
> +		fsl,pins = <
> +			MX6SL_PAD_REF_CLK_24M__I2C3_SCL  0x4001f8b1
> +			MX6SL_PAD_REF_CLK_32K__I2C3_SDA  0x4001f8b1
> +		>;
> +	};
> +
> +	pinctrl_led: ledgrp {
> +		fsl,pins = <
> +			MX6SL_PAD_SD1_DAT2__GPIO5_IO13 0x17059
> +		>;
> +	};
> +
> +	pinctrl_ricoh_gpio: ricoh_gpiogrp {
> +		fsl,pins = <
> +			MX6SL_PAD_SD1_CLK__GPIO5_IO15	0x1b8b1 /* ricoh619 chg */
> +			MX6SL_PAD_SD1_DAT0__GPIO5_IO11	0x1b8b1 /* ricoh619 irq */
> +			MX6SL_PAD_KEY_COL2__GPIO3_IO28	0x1b8b1 /* ricoh619 bat_low_int */
> +		>;
> +	};
> +
> +	pinctrl_uart1: uart1grp {
> +		fsl,pins = <
> +			MX6SL_PAD_UART1_TXD__UART1_TX_DATA 0x1b0b1
> +			MX6SL_PAD_UART1_RXD__UART1_TX_DATA 0x1b0b1
> +		>;
> +	};
> +
> +	pinctrl_usbotg1: usbotg1grp {
> +		fsl,pins = <
> +			MX6SL_PAD_EPDC_PWRCOM__USB_OTG1_ID 0x17059
> +		>;
> +	};
> +
> +	pinctrl_usdhc2: usdhc2grp {
> +		fsl,pins = <
> +			MX6SL_PAD_SD2_CMD__SD2_CMD		0x17059
> +			MX6SL_PAD_SD2_CLK__SD2_CLK		0x13059
> +			MX6SL_PAD_SD2_DAT0__SD2_DATA0		0x17059
> +			MX6SL_PAD_SD2_DAT1__SD2_DATA1		0x17059
> +			MX6SL_PAD_SD2_DAT2__SD2_DATA2		0x17059
> +			MX6SL_PAD_SD2_DAT3__SD2_DATA3		0x17059
> +		>;
> +	};
> +
> +	pinctrl_usdhc2_100mhz: usdhc2grp-100mhz {
> +		fsl,pins = <
> +			MX6SL_PAD_SD2_CMD__SD2_CMD		0x170b9
> +			MX6SL_PAD_SD2_CLK__SD2_CLK		0x130b9
> +			MX6SL_PAD_SD2_DAT0__SD2_DATA0		0x170b9
> +			MX6SL_PAD_SD2_DAT1__SD2_DATA1		0x170b9
> +			MX6SL_PAD_SD2_DAT2__SD2_DATA2		0x170b9
> +			MX6SL_PAD_SD2_DAT3__SD2_DATA3		0x170b9
> +		>;
> +	};
> +
> +	pinctrl_usdhc2_200mhz: usdhc2grp-200mhz {
> +		fsl,pins = <
> +			MX6SL_PAD_SD2_CMD__SD2_CMD		0x170f9
> +			MX6SL_PAD_SD2_CLK__SD2_CLK		0x130f9
> +			MX6SL_PAD_SD2_DAT0__SD2_DATA0		0x170f9
> +			MX6SL_PAD_SD2_DAT1__SD2_DATA1		0x170f9
> +			MX6SL_PAD_SD2_DAT2__SD2_DATA2		0x170f9
> +			MX6SL_PAD_SD2_DAT3__SD2_DATA3		0x170f9
> +		>;
> +	};
> +
> +	pinctrl_usdhc2_sleep: usdhc2grp-sleep {
> +		fsl,pins = <
> +			MX6SL_PAD_SD2_CMD__GPIO5_IO04		0x100f9
> +			MX6SL_PAD_SD2_CLK__GPIO5_IO05		0x100f9
> +			MX6SL_PAD_SD2_DAT0__GPIO5_IO01		0x100f9
> +			MX6SL_PAD_SD2_DAT1__GPIO4_IO30		0x100f9
> +			MX6SL_PAD_SD2_DAT2__GPIO5_IO03		0x100f9
> +			MX6SL_PAD_SD2_DAT3__GPIO4_IO28		0x100f9
> +		>;
> +	};
> +
> +	pinctrl_usdhc3: usdhc3grp {
> +		fsl,pins = <
> +			MX6SL_PAD_SD3_CMD__SD3_CMD	0x11059
> +			MX6SL_PAD_SD3_CLK__SD3_CLK	0x11059
> +			MX6SL_PAD_SD3_DAT0__SD3_DATA0	0x11059
> +			MX6SL_PAD_SD3_DAT1__SD3_DATA1	0x11059
> +			MX6SL_PAD_SD3_DAT2__SD3_DATA2	0x11059
> +			MX6SL_PAD_SD3_DAT3__SD3_DATA3	0x11059
> +		>;
> +	};
> +
> +	pinctrl_usdhc3_100mhz: usdhc3grp-100mhz {
> +		fsl,pins = <
> +			MX6SL_PAD_SD3_CMD__SD3_CMD	0x170b9
> +			MX6SL_PAD_SD3_CLK__SD3_CLK	0x170b9
> +			MX6SL_PAD_SD3_DAT0__SD3_DATA0	0x170b9
> +			MX6SL_PAD_SD3_DAT1__SD3_DATA1	0x170b9
> +			MX6SL_PAD_SD3_DAT2__SD3_DATA2	0x170b9
> +			MX6SL_PAD_SD3_DAT3__SD3_DATA3	0x170b9
> +		>;
> +	};
> +
> +	pinctrl_usdhc3_200mhz: usdhc3grp-200mhz {
> +		fsl,pins = <
> +			MX6SL_PAD_SD3_CMD__SD3_CMD	0x170f9
> +			MX6SL_PAD_SD3_CLK__SD3_CLK	0x170f9
> +			MX6SL_PAD_SD3_DAT0__SD3_DATA0	0x170f9
> +			MX6SL_PAD_SD3_DAT1__SD3_DATA1	0x170f9
> +			MX6SL_PAD_SD3_DAT2__SD3_DATA2	0x170f9
> +			MX6SL_PAD_SD3_DAT3__SD3_DATA3	0x170f9
> +		>;
> +	};
> +
> +	pinctrl_usdhc3_sleep: usdhc3grp-sleep {
> +		fsl,pins = <
> +			MX6SL_PAD_SD3_CMD__GPIO5_IO21	0x100c1
> +			MX6SL_PAD_SD3_CLK__GPIO5_IO18	0x100c1
> +			MX6SL_PAD_SD3_DAT0__GPIO5_IO19	0x100c1
> +			MX6SL_PAD_SD3_DAT1__GPIO5_IO20	0x100c1
> +			MX6SL_PAD_SD3_DAT2__GPIO5_IO16	0x100c1
> +			MX6SL_PAD_SD3_DAT3__GPIO5_IO17	0x100c1
> +		>;
> +	};
> +
> +	pinctrl_wifi_power: wifi-powergrp {
> +		fsl,pins = <
> +			MX6SL_PAD_SD2_DAT6__GPIO4_IO29	0x10059	/* WIFI_3V3_ON */
> +		>;
> +	};
> +
> +	pinctrl_wifi_reset: wifi-resetgrp {
> +		fsl,pins = <
> +			MX6SL_PAD_SD2_DAT7__GPIO5_IO00	0x10059	/* WIFI_RST */
> +		>;
> +	};
> +
> +	pinctrl_zforce: zforcegrp {
> +		fsl,pins = <
> +			MX6SL_PAD_SD1_DAT3__GPIO5_IO06		0x17059 /* TP_INT */
> +			MX6SL_PAD_SD1_DAT5__GPIO5_IO09		0x10059 /* TP_RST */
> +		>;
> +	};
> +};
> +
> +&reg_vdd1p1 {
> +	vin-supply = <&dcdc2_reg>;
> +};
> +
> +&reg_vdd2p5 {
> +	vin-supply = <&dcdc2_reg>;
> +};
> +
> +&reg_arm {
> +	vin-supply = <&dcdc3_reg>;
> +};
> +
> +&reg_soc {
> +	vin-supply = <&dcdc1_reg>;
> +};
> +
> +&reg_pu {
> +	vin-supply = <&dcdc1_reg>;
> +};
> +
> +&snvs_rtc {
> +	/* we are using the RTC in the PMIC, not disabled in imx6sl.dtsi */
> +	status = "disabled";
> +};
> +
> +&uart1 {
> +	pinctrl-names = "default";
> +	pinctrl-0 = <&pinctrl_uart1>;
> +	status = "okay";
> +};
> +
> +&usdhc2 {
> +	pinctrl-names = "default", "state_100mhz", "state_200mhz", "sleep";
> +	pinctrl-0 = <&pinctrl_usdhc2>;
> +	pinctrl-1 = <&pinctrl_usdhc2_100mhz>;
> +	pinctrl-2 = <&pinctrl_usdhc2_200mhz>;
> +	pinctrl-3 = <&pinctrl_usdhc2_sleep>;
> +	non-removable;
> +	status = "okay";
> +};
> +
> +&usdhc3 {
> +	pinctrl-names = "default", "state_100mhz", "state_200mhz", "sleep";
> +	pinctrl-0 = <&pinctrl_usdhc3>;
> +	pinctrl-1 = <&pinctrl_usdhc3_100mhz>;
> +	pinctrl-2 = <&pinctrl_usdhc3_200mhz>;
> +	pinctrl-3 = <&pinctrl_usdhc3_sleep>;
> +	vmmc-supply = <&reg_wifi>;
> +	mmc-pwrseq = <&wifi_pwrseq>;
> +	cap-power-off-card;
> +	non-removable;
> +	status = "okay";
> +
> +	/* CyberTan WC121 SDIO WiFi */
> +};
> +
> +

One newline is good enough.

Shawn

> +&usbotg1 {
> +	pinctrl-names = "default";
> +	disable-over-current;
> +	srp-disable;
> +	hnp-disable;
> +	adp-disable;
> +	status = "okay";
> +};
> -- 
> 2.20.1
> 
> 
> _______________________________________________
> linux-arm-kernel mailing list
> linux-arm-kernel@lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
