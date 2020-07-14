Return-Path: <SRS0=dAmO=AZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.5 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,NICE_REPLY_A,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D7719C433E0
	for <linux-kernel@archiver.kernel.org>; Tue, 14 Jul 2020 15:12:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A51E22076C
	for <linux-kernel@archiver.kernel.org>; Tue, 14 Jul 2020 15:12:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727821AbgGNPME (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 14 Jul 2020 11:12:04 -0400
Received: from comms.puri.sm ([159.203.221.185]:51992 "EHLO comms.puri.sm"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725876AbgGNPMC (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Jul 2020 11:12:02 -0400
Received: from localhost (localhost [127.0.0.1])
        by comms.puri.sm (Postfix) with ESMTP id CA3ABE0183;
        Tue, 14 Jul 2020 08:12:00 -0700 (PDT)
Received: from comms.puri.sm ([127.0.0.1])
        by localhost (comms.puri.sm [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id EHWqlWBl-6be; Tue, 14 Jul 2020 08:11:57 -0700 (PDT)
Subject: Re: [PATCH v3 1/2] arm64: dts: Add a device tree for the Librem 5
 phone
To:     Shawn Guo <shawnguo@kernel.org>
Cc:     robh@kernel.org, kernel@puri.sm, s.hauer@pengutronix.de,
        kernel@pengutronix.de, festevam@gmail.com, linux-imx@nxp.com,
        mchehab@kernel.org, Anson.Huang@nxp.com, agx@sigxcpu.org,
        angus@akkea.ca, broonie@kernel.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        Daniel Baluta <daniel.baluta@nxp.com>
References: <20200617073821.16737-1-martin.kepplinger@puri.sm>
 <20200711133716.GC21277@dragon>
From:   Martin Kepplinger <martin.kepplinger@puri.sm>
Autocrypt: addr=martin.kepplinger@puri.sm; keydata=
 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
 ekMtxgNYb/8oDry09UFHbGHLsWn6oBo=
Message-ID: <6532b58a-35c7-3cc1-4bf3-66b813dcd04d@puri.sm>
Date:   Tue, 14 Jul 2020 17:11:48 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
In-Reply-To: <20200711133716.GC21277@dragon>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 11.07.20 15:37, Shawn Guo wrote:
> On Wed, Jun 17, 2020 at 09:38:20AM +0200, Martin Kepplinger wrote:
>> From: "Angus Ainslie (Purism)" <angus@akkea.ca>
>>
>> Add a devicetree description for the Librem 5 phone. The early batches
>> that have been sold are supported as well as the mass-produced device
>> available later this year, see https://puri.sm/products/librem-5/
>>
>> This boots to a working console with working WWAN modem, wifi usdhc,
>> IMU sensor device, proximity sensor, haptic motor, gpio keys, GNSS and LEDs.
>>
>> Signed-off-by: Martin Kepplinger <martin.kepplinger@puri.sm>
>> Signed-off-by: Angus Ainslie (Purism) <angus@akkea.ca>
>> Signed-off-by: Guido Günther <agx@sigxcpu.org>
>> For audio related part:
>> Reviewed-by: Daniel Baluta <daniel.baluta@nxp.com>
>> ---
>>
>> revision history
>> ----------------
>> v3:
>> thanks a lot Mark for reviewing! changes since v2:
>>  * nicer audio cards names
>>  * squash unneeded audio_pwr regulator
>>  * remove the unneeded susphy_quirk from dwc3_1 after more testing
>>  * add usdhc2 card detect via gpio
>>  * add headphone detect for audio card
>>
>> v2:
>> thanks a lot Marco, Daniel and Pavel for reviewing. changes since v1:
>>  * alphabetical sortings / more consistent node names
>>  * remove unused regulator and pinctrl descriptions
>>  * generic labels for leds, backlight, flash and torch
>>  * audio clk settings moved to sai2 node
>> https://lore.kernel.org/linux-arm-kernel/20200604084756.586-1-martin.kepplinger@puri.sm/T/
>>
>> v1:
>> https://lore.kernel.org/linux-arm-kernel/20200514155737.12160-1-martin.kepplinger@puri.sm/
>>
>>
>>
>>  arch/arm64/boot/dts/freescale/Makefile        |    1 +
>>  .../boot/dts/freescale/imx8mq-librem5.dts     | 1137 +++++++++++++++++
>>  2 files changed, 1138 insertions(+)
>>  create mode 100644 arch/arm64/boot/dts/freescale/imx8mq-librem5.dts
>>
>> diff --git a/arch/arm64/boot/dts/freescale/Makefile b/arch/arm64/boot/dts/freescale/Makefile
>> index cd38d04da5a7..342579121f98 100644
>> --- a/arch/arm64/boot/dts/freescale/Makefile
>> +++ b/arch/arm64/boot/dts/freescale/Makefile
>> @@ -34,6 +34,7 @@ dtb-$(CONFIG_ARCH_MXC) += imx8mn-ddr4-evk.dtb
>>  dtb-$(CONFIG_ARCH_MXC) += imx8mp-evk.dtb
>>  dtb-$(CONFIG_ARCH_MXC) += imx8mq-evk.dtb
>>  dtb-$(CONFIG_ARCH_MXC) += imx8mq-hummingboard-pulse.dtb
>> +dtb-$(CONFIG_ARCH_MXC) += imx8mq-librem5.dtb
>>  dtb-$(CONFIG_ARCH_MXC) += imx8mq-librem5-devkit.dtb
>>  dtb-$(CONFIG_ARCH_MXC) += imx8mq-nitrogen.dtb
>>  dtb-$(CONFIG_ARCH_MXC) += imx8mq-phanbell.dtb
>> diff --git a/arch/arm64/boot/dts/freescale/imx8mq-librem5.dts b/arch/arm64/boot/dts/freescale/imx8mq-librem5.dts
>> new file mode 100644
>> index 000000000000..06ffa12e60f7
>> --- /dev/null
>> +++ b/arch/arm64/boot/dts/freescale/imx8mq-librem5.dts
>> @@ -0,0 +1,1137 @@
>> +// SPDX-License-Identifier: GPL-2.0+
>> +/*
>> + * Copyright 2018-2020 Purism SPC
>> + */
>> +
>> +/dts-v1/;
>> +
>> +#include "dt-bindings/input/input.h"
>> +#include "dt-bindings/pwm/pwm.h"
>> +#include "dt-bindings/usb/pd.h"
>> +#include "imx8mq.dtsi"
>> +
>> +/ {
>> +	model = "Purism Librem 5";
>> +	compatible = "purism,librem5", "fsl,imx8mq";
> 
> Is the compatible documented?

no, I forgot that and will add it for the next revision. thanks!

> 
>> +
>> +	backlight_dsi: backlight-dsi {
>> +		compatible = "led-backlight";
>> +		leds = <&led_backlight>;
>> +		brightness-levels = <255>;
>> +		default-brightness-level = <100>;
> 
> I'm not sure these two properties are coded correctly, you may want to
> double check the bindings doc.
> 
>> +	};
>> +
>> +	pmic_osc: clock-pmic {
>> +		compatible = "fixed-clock";
>> +		#clock-cells = <0>;
>> +		clock-frequency = <32768>;
>> +		clock-output-names = "pmic_osc";
>> +	};
>> +
>> +	chosen {
>> +		stdout-path = &uart1;
>> +	};
>> +
>> +	gpio-keys {
>> +		compatible = "gpio-keys";
>> +		pinctrl-names = "default";
>> +		pinctrl-0 = <&pinctrl_keys>;
>> +
>> +		vol-down {
>> +			label = "VOL_DOWN";
>> +			gpios = <&gpio1 17 GPIO_ACTIVE_LOW>;
>> +			linux,code = <KEY_VOLUMEDOWN>;
>> +		};
>> +
>> +		vol-up {
>> +			label = "VOL_UP";
>> +			gpios = <&gpio1 16 GPIO_ACTIVE_LOW>;
>> +			linux,code = <KEY_VOLUMEUP>;
>> +		};
>> +	};
>> +
>> +	pwmleds {
>> +		compatible = "pwm-leds";
>> +
>> +		blue {
>> +			label = "blue:status";
>> +			max-brightness = <248>;
>> +			pwms = <&pwm2 0 50000>;
>> +		};
>> +
>> +		green {
>> +			label = "green:status";
>> +			max-brightness = <248>;
>> +			pwms = <&pwm4 0 50000>;
>> +		};
>> +
>> +		red {
>> +			label = "red:status";
>> +			max-brightness = <248>;
>> +			pwms = <&pwm3 0 50000>;
>> +		};
>> +	};
>> +
>> +	reg_aud_1v8: regulator-audio-1v8 {
>> +		compatible = "regulator-fixed";
>> +		pinctrl-names = "default";
>> +		pinctrl-0 = <&pinctrl_audiopwr>;
>> +		regulator-name = "AUDIO_PWR_EN";
>> +		regulator-min-microvolt = <1800000>;
>> +		regulator-max-microvolt = <1800000>;
>> +		gpio = <&gpio1 4 GPIO_ACTIVE_HIGH>;
>> +		enable-active-high;
>> +	};
>> +
>> +	reg_gnss: regulator-gnss {
>> +		compatible = "regulator-fixed";
>> +		pinctrl-names = "default";
>> +		pinctrl-0 = <&pinctrl_gnsspwr>;
>> +		regulator-name = "GNSS";
>> +		regulator-min-microvolt = <3300000>;
>> +		regulator-max-microvolt = <3300000>;
>> +		gpio = <&gpio3 12 GPIO_ACTIVE_HIGH>;
>> +		enable-active-high;
>> +	};
>> +
>> +	reg_hub: regulator-hub {
>> +		compatible = "regulator-fixed";
>> +		pinctrl-names = "default";
>> +		pinctrl-0 = <&pinctrl_hub_pwr>;
>> +		regulator-name = "HUB";
>> +		regulator-min-microvolt = <3300000>;
>> +		regulator-max-microvolt = <3300000>;
>> +		gpio = <&gpio1 14 GPIO_ACTIVE_HIGH>;
>> +		enable-active-high;
>> +	};
>> +
>> +	reg_lcd_3v4: regulator-lcd-3v4 {
>> +		compatible = "regulator-fixed";
>> +		regulator-name = "LCD_3V4";
>> +		pinctrl-names = "default";
>> +		pinctrl-0 = <&pinctrl_dsibiasen>;
>> +		vin-supply = <&reg_vsys_3v4>;
>> +		enable-active-high;
> 
> Nit: can we consistently put 'enable-active-high' after 'gpio' node?
> 
>> +		gpio = <&gpio1 20 GPIO_ACTIVE_HIGH>;
>> +	};
>> +
>> +	reg_vdd_sen: regulator-vdd-sen {
>> +		compatible = "regulator-fixed";
>> +		regulator-name = "VDD_SEN";
>> +		regulator-min-microvolt = <3300000>;
>> +		regulator-max-microvolt = <3300000>;
>> +	};
>> +
>> +	reg_vdd_3v3: regulator-vdd-3v3 {
>> +		compatible = "regulator-fixed";
>> +		regulator-name = "VDD_3V3";
>> +		regulator-min-microvolt = <3300000>;
>> +		regulator-max-microvolt = <3300000>;
>> +	};
>> +
>> +	reg_vdd_1v8: regulator-vdd-1v8 {
>> +		compatible = "regulator-fixed";
>> +		regulator-name = "VCC_1V8";
>> +		regulator-min-microvolt = <1800000>;
>> +		regulator-max-microvolt = <1800000>;
>> +	};
>> +
>> +	reg_vsys_3v4: regulator-vsys-3v4 {
>> +		compatible = "regulator-fixed";
>> +		regulator-name = "VSYS_3V4";
>> +		regulator-min-microvolt = <3400000>;
>> +		regulator-max-microvolt = <3400000>;
>> +		regulator-always-on;
>> +	};
>> +
>> +	reg_wifi_3v3: regulator-wifi-3v3 {
>> +		compatible = "regulator-fixed";
>> +		regulator-name = "3V3_WIFI";
>> +		regulator-min-microvolt = <3300000>;
>> +		regulator-max-microvolt = <3300000>;
>> +	};
>> +
>> +	sound {
>> +		compatible = "simple-audio-card";
>> +		pinctrl-0 = <&pinctrl_hp>;
>> +		simple-audio-card,name = "Librem 5";
>> +		simple-audio-card,format = "i2s";
>> +		simple-audio-card,widgets =
>> +			"Headphone", "Headphones",
>> +			"Microphone", "Headset Mic",
>> +			"Microphone", "Digital Mic",
>> +			"Speaker", "Speaker";
>> +		simple-audio-card,routing =
>> +			"Headphones", "HPOUTL",
>> +			"Headphones", "HPOUTR",
>> +			"Speaker", "SPKOUTL",
>> +			"Speaker", "SPKOUTR",
>> +			"Headset Mic", "MICBIAS",
>> +			"IN3R", "Headset Mic",
>> +			"DMICDAT", "Digital Mic";
>> +		simple-audio-card,hp-det-gpio = <&gpio3 9 GPIO_ACTIVE_HIGH>;
>> +
>> +		simple-audio-card,cpu {
>> +			sound-dai = <&sai2>;
>> +		};
>> +
>> +		simple-audio-card,codec {
>> +			sound-dai = <&codec>;
>> +			clocks = <&clk IMX8MQ_CLK_SAI2_ROOT>;
>> +			frame-master;
>> +			bitclock-master;
>> +		};
>> +	};
>> +
>> +	sound-wwan {
>> +		compatible = "simple-audio-card";
>> +		simple-audio-card,name = "Modem";
>> +		simple-audio-card,format = "i2s";
>> +
>> +		simple-audio-card,cpu {
>> +			sound-dai = <&sai6>;
>> +			frame-inversion;
>> +		};
>> +
>> +		simple-audio-card,codec {
>> +			sound-dai = <&bm818_codec>;
>> +			frame-master;
>> +			bitclock-master;
>> +		};
>> +	};
>> +
>> +	bm818_codec: sound-wwan-codec {
>> +		compatible = "broadmobi,bm818", "option,gtm601";
>> +		#sound-dai-cells = <0>;
>> +	};
>> +
>> +	vibrator {
>> +		compatible = "pwm-vibrator";
>> +		pwms = <&pwm1 0 1000000000 0>;
>> +		pwm-names = "enable";
>> +		vcc-supply = <&reg_vdd_3v3>;
>> +	};
>> +};
>> +
>> +&A53_0 {
>> +	cpu-supply = <&buck2_reg>;
>> +};
>> +
>> +&A53_1 {
>> +	cpu-supply = <&buck2_reg>;
>> +};
>> +
>> +&A53_2 {
>> +	cpu-supply = <&buck2_reg>;
>> +};
>> +
>> +&A53_3 {
>> +	cpu-supply = <&buck2_reg>;
>> +};
>> +
>> +&ddrc {
>> +	operating-points-v2 = <&ddrc_opp_table>;
>> +
>> +	ddrc_opp_table: ddrc-opp-table {
>> +		compatible = "operating-points-v2";
>> +
>> +		opp-25M {
>> +			opp-hz = /bits/ 64 <25000000>;
>> +		};
> 
> Have a newline between nodes.
> 
>> +		opp-100M {
>> +			opp-hz = /bits/ 64 <100000000>;
>> +		};
>> +		opp-800M {
>> +			opp-hz = /bits/ 64 <800000000>;
>> +		};
>> +	};
>> +};
>> +
>> +&dphy {
>> +	status = "okay";
>> +};
>> +
>> +&ecspi1 {
>> +	pinctrl-names = "default";
>> +	pinctrl-0 = <&pinctrl_ecspi1>;
>> +	cs-gpios = <&gpio5 9 GPIO_ACTIVE_HIGH>;
>> +	#address-cells = <1>;
>> +	#size-cells = <0>;
>> +	status = "okay";
>> +
>> +	nor_flash: flash@0 {
>> +		compatible = "jedec,spi-nor";
>> +		reg = <0>;
>> +		spi-max-frequency = <1000000>;
>> +	};
>> +};
>> +
>> +&gpio1 {
>> +	pinctrl-names = "default";
>> +	pinctrl-0 = <&pinctrl_pmic_5v>;
>> +
>> +	pmic-5v {
>> +		gpio-hog;
>> +		gpio = <&gpio1 1 GPIO_ACTIVE_HIGH>;
>> +		input;
>> +	};
>> +};
>> +
>> +&iomuxc {
>> +	pinctrl_audiopwr: audiopwrgrp {
>> +		fsl,pins = <
>> +			/* AUDIO_POWER_EN_3V3 */
>> +			MX8MQ_IOMUXC_GPIO1_IO04_GPIO1_IO4	0x83
>> +		>;
>> +	};
>> +
>> +	pinctrl_bl: blgrp {
>> +		fsl,pins = <
>> +			/* BACKLINGE_EN */
>> +			MX8MQ_IOMUXC_NAND_DQS_GPIO3_IO14	0x83
>> +		>;
>> +	};
>> +
>> +	pinctrl_charger_in: chargeringrp {
>> +		fsl,pins = <
>> +			/* CHRG_INT */
>> +			MX8MQ_IOMUXC_NAND_CE2_B_GPIO3_IO3	0x80
>> +			/* CHG_STATUS_B */
>> +			MX8MQ_IOMUXC_NAND_ALE_GPIO3_IO0		0x80
>> +		>;
>> +	};
>> +
>> +	pinctrl_dsibiasen: dsibiasengrp {
>> +		fsl,pins = <
>> +			/* DSI_BIAS_EN */
>> +			MX8MQ_IOMUXC_ENET_TD1_GPIO1_IO20	0x83
>> +		>;
>> +	};
>> +
>> +	pinctrl_dsien: dsiengrp {
>> +		fsl,pins = <
>> +			/* DSI_EN_3V3 */
>> +			MX8MQ_IOMUXC_GPIO1_IO05_GPIO1_IO5	0x83
>> +		>;
>> +	};
>> +
>> +	pinctrl_ecspi1: spi1grp {
>> +		fsl,pins = <
>> +			MX8MQ_IOMUXC_ECSPI1_MOSI_ECSPI1_MOSI	0x83
>> +			MX8MQ_IOMUXC_ECSPI1_MISO_ECSPI1_MISO	0x83
>> +			MX8MQ_IOMUXC_ECSPI1_SS0_GPIO5_IO9	0x19
>> +			MX8MQ_IOMUXC_ECSPI1_SCLK_ECSPI1_SCLK	0x83
>> +		>;
>> +	};
>> +
>> +	pinctrl_gauge: gaugegrp {
>> +		fsl,pins = <
>> +			/* BAT_LOW */
>> +			MX8MQ_IOMUXC_SAI5_RXC_GPIO3_IO20	0x80
>> +		>;
>> +	};
>> +
>> +	pinctrl_gnsspwr: gnsspwrgrp {
>> +		fsl,pins = <
>> +			/* GPS3V3_EN */
>> +			MX8MQ_IOMUXC_NAND_DATA06_GPIO3_IO12	0x83
>> +		>;
>> +	};
>> +
>> +	pinctrl_haptic: hapticgrp {
>> +		fsl,pins = <
>> +			/* MOTO */
>> +			MX8MQ_IOMUXC_SPDIF_EXT_CLK_PWM1_OUT	0x83
>> +		>;
>> +	};
>> +
>> +	pinctrl_hp: hpgrp {
>> +		fsl,pins = <
>> +			/* HEADPHONE_DET_1V8 */
>> +			MX8MQ_IOMUXC_NAND_DATA03_GPIO3_IO9	0x180
>> +		>;
>> +	};
>> +
>> +	pinctrl_hub_pwr: hubpwrgrp {
>> +		fsl,pins = <
>> +			/* HUB_PWR_3V3_EN */
>> +			MX8MQ_IOMUXC_GPIO1_IO14_GPIO1_IO14	0x83
>> +		>;
>> +	};
>> +
>> +	pinctrl_i2c1: i2c1grp {
>> +		fsl,pins = <
>> +			MX8MQ_IOMUXC_I2C1_SCL_I2C1_SCL		0x40000026
>> +			MX8MQ_IOMUXC_I2C1_SDA_I2C1_SDA		0x40000026
>> +		>;
>> +	};
>> +
>> +	pinctrl_i2c2: i2c2grp {
>> +		fsl,pins = <
>> +			MX8MQ_IOMUXC_I2C2_SCL_I2C2_SCL		0x40000026
>> +			MX8MQ_IOMUXC_I2C2_SDA_I2C2_SDA		0x40000026
>> +		>;
>> +	};
>> +
>> +	pinctrl_i2c3: i2c3grp {
>> +		fsl,pins = <
>> +			MX8MQ_IOMUXC_I2C3_SCL_I2C3_SCL		0x40000026
>> +			MX8MQ_IOMUXC_I2C3_SDA_I2C3_SDA		0x40000026
>> +		>;
>> +	};
>> +
>> +	pinctrl_i2c4: i2c4grp {
>> +		fsl,pins = <
>> +			MX8MQ_IOMUXC_I2C4_SCL_I2C4_SCL		0x40000026
>> +			MX8MQ_IOMUXC_I2C4_SDA_I2C4_SDA		0x40000026
>> +		>;
>> +	};
>> +
>> +	pinctrl_keys: keysgrp {
>> +		fsl,pins = <
>> +			/* VOL- */
>> +			MX8MQ_IOMUXC_ENET_MDIO_GPIO1_IO17	0x01C0
>> +			/* VOL+ */
>> +			MX8MQ_IOMUXC_ENET_MDC_GPIO1_IO16	0x01C0
>> +		>;
>> +	};
>> +
>> +	pinctrl_led_b: ledbgrp {
>> +		fsl,pins = <
>> +			/* LED_B */
>> +			MX8MQ_IOMUXC_GPIO1_IO13_PWM2_OUT	0x06
>> +		>;
>> +	};
>> +
>> +	pinctrl_led_g: ledggrp {
>> +		fsl,pins = <
>> +			/* LED_G */
>> +			MX8MQ_IOMUXC_SAI3_MCLK_PWM4_OUT		0x06
>> +		>;
>> +	};
>> +
>> +	pinctrl_led_r: ledrgrp {
>> +		fsl,pins = <
>> +			/* LED_R */
>> +			MX8MQ_IOMUXC_SPDIF_TX_PWM3_OUT		0x06
>> +		>;
>> +	};
>> +
>> +	pinctrl_mag: maggrp {
>> +		fsl,pins = <
>> +			/* INT_MAG */
>> +			MX8MQ_IOMUXC_SAI5_RXD1_GPIO3_IO22	0x80
>> +		>;
>> +	};
>> +
>> +	pinctrl_pmic: pmicgrp {
>> +		fsl,pins = <
>> +			/* PMIC_NINT */
>> +			MX8MQ_IOMUXC_GPIO1_IO07_GPIO1_IO7	0x80
>> +		>;
>> +	};
>> +
>> +	pinctrl_pmic_5v: pmic5vgrp {
>> +		fsl,pins = <
>> +			/* PMIC_5V */
>> +			MX8MQ_IOMUXC_GPIO1_IO01_GPIO1_IO1	0x80
>> +		>;
>> +	};
>> +
>> +	pinctrl_prox: proxgrp {
>> +		fsl,pins = <
>> +			/* INT_LIGHT */
>> +			MX8MQ_IOMUXC_NAND_DATA01_GPIO3_IO7	0x80
>> +		>;
>> +	};
>> +
>> +	pinctrl_rtc: rtcgrp {
>> +		fsl,pins = <
>> +			/* RTC_INT */
>> +			MX8MQ_IOMUXC_GPIO1_IO09_GPIO1_IO9	0x80
>> +		>;
>> +	};
>> +
>> +	pinctrl_sai2: sai2grp {
>> +		fsl,pins = <
>> +			MX8MQ_IOMUXC_SAI2_TXD0_SAI2_TX_DATA0	0xd6
>> +			MX8MQ_IOMUXC_SAI2_TXFS_SAI2_TX_SYNC	0xd6
>> +			MX8MQ_IOMUXC_SAI2_MCLK_SAI2_MCLK	0xd6
>> +			MX8MQ_IOMUXC_SAI2_RXD0_SAI2_RX_DATA0	0xd6
>> +			MX8MQ_IOMUXC_SAI2_TXC_SAI2_TX_BCLK	0xd6
>> +		>;
>> +	};
>> +
>> +	pinctrl_sai6: sai6grp {
>> +		fsl,pins = <
>> +			MX8MQ_IOMUXC_SAI1_RXD5_SAI6_RX_DATA0	0xd6
>> +			MX8MQ_IOMUXC_SAI1_RXD6_SAI6_RX_SYNC	0xd6
>> +			MX8MQ_IOMUXC_SAI1_TXD4_SAI6_RX_BCLK	0xd6
>> +			MX8MQ_IOMUXC_SAI1_TXD5_SAI6_TX_DATA0	0xd6
>> +		>;
>> +	};
>> +
>> +	pinctrl_tcpc: tcpcgrp {
>> +		fsl,pins = <
>> +			/* TCPC_INT */
>> +			MX8MQ_IOMUXC_GPIO1_IO10_GPIO1_IO10	0x01C0
>> +		>;
>> +	};
>> +
>> +	pinctrl_typec: typecgrp {
>> +		fsl,pins = <
>> +			/* TYPEC_MUX_EN */
>> +			MX8MQ_IOMUXC_GPIO1_IO11_GPIO1_IO11	0x83
>> +		>;
>> +	};
>> +
>> +	pinctrl_uart1: uart1grp {
>> +		fsl,pins = <
>> +			MX8MQ_IOMUXC_UART1_RXD_UART1_DCE_RX	0x49
>> +			MX8MQ_IOMUXC_UART1_TXD_UART1_DCE_TX	0x49
>> +		>;
>> +	};
>> +
>> +	pinctrl_uart2: uart2grp {
>> +		fsl,pins = <
>> +			MX8MQ_IOMUXC_UART2_TXD_UART2_DCE_TX	0x49
>> +			MX8MQ_IOMUXC_UART2_RXD_UART2_DCE_RX	0x49
>> +		>;
>> +	};
>> +
>> +	pinctrl_uart3: uart3grp {
>> +		fsl,pins = <
>> +			MX8MQ_IOMUXC_UART3_RXD_UART3_DCE_RX	0x49
>> +			MX8MQ_IOMUXC_UART3_TXD_UART3_DCE_TX	0x49
>> +		>;
>> +	};
>> +
>> +	pinctrl_uart4: uart4grp {
>> +		fsl,pins = <
>> +			MX8MQ_IOMUXC_ECSPI2_SCLK_UART4_DCE_RX		0x49
>> +			MX8MQ_IOMUXC_ECSPI2_MOSI_UART4_DCE_TX		0x49
>> +			MX8MQ_IOMUXC_ECSPI2_MISO_UART4_DCE_CTS_B	0x49
>> +			MX8MQ_IOMUXC_ECSPI2_SS0_UART4_DCE_RTS_B		0x49
>> +		>;
>> +	};
>> +
>> +	pinctrl_usdhc1: usdhc1grp {
>> +		fsl,pins = <
>> +			MX8MQ_IOMUXC_SD1_CLK_USDHC1_CLK			0x83
>> +			MX8MQ_IOMUXC_SD1_CMD_USDHC1_CMD			0xc3
>> +			MX8MQ_IOMUXC_SD1_DATA0_USDHC1_DATA0		0xc3
>> +			MX8MQ_IOMUXC_SD1_DATA1_USDHC1_DATA1		0xc3
>> +			MX8MQ_IOMUXC_SD1_DATA2_USDHC1_DATA2		0xc3
>> +			MX8MQ_IOMUXC_SD1_DATA3_USDHC1_DATA3		0xc3
>> +			MX8MQ_IOMUXC_SD1_DATA4_USDHC1_DATA4		0xc3
>> +			MX8MQ_IOMUXC_SD1_DATA5_USDHC1_DATA5		0xc3
>> +			MX8MQ_IOMUXC_SD1_DATA6_USDHC1_DATA6		0xc3
>> +			MX8MQ_IOMUXC_SD1_DATA7_USDHC1_DATA7		0xc3
>> +			MX8MQ_IOMUXC_SD1_STROBE_USDHC1_STROBE		0x83
>> +			MX8MQ_IOMUXC_SD1_RESET_B_USDHC1_RESET_B		0xc1
>> +		>;
>> +	};
>> +
>> +	pinctrl_usdhc1_100mhz: usdhc1grp100mhz {
>> +		fsl,pins = <
>> +			MX8MQ_IOMUXC_SD1_CLK_USDHC1_CLK			0x8d
>> +			MX8MQ_IOMUXC_SD1_CMD_USDHC1_CMD			0xcd
>> +			MX8MQ_IOMUXC_SD1_DATA0_USDHC1_DATA0		0xcd
>> +			MX8MQ_IOMUXC_SD1_DATA1_USDHC1_DATA1		0xcd
>> +			MX8MQ_IOMUXC_SD1_DATA2_USDHC1_DATA2		0xcd
>> +			MX8MQ_IOMUXC_SD1_DATA3_USDHC1_DATA3		0xcd
>> +			MX8MQ_IOMUXC_SD1_DATA4_USDHC1_DATA4		0xcd
>> +			MX8MQ_IOMUXC_SD1_DATA5_USDHC1_DATA5		0xcd
>> +			MX8MQ_IOMUXC_SD1_DATA6_USDHC1_DATA6		0xcd
>> +			MX8MQ_IOMUXC_SD1_DATA7_USDHC1_DATA7		0xcd
>> +			MX8MQ_IOMUXC_SD1_STROBE_USDHC1_STROBE		0x8d
>> +			MX8MQ_IOMUXC_SD1_RESET_B_USDHC1_RESET_B		0xc1
>> +		>;
>> +	};
>> +
>> +	pinctrl_usdhc1_200mhz: usdhc1grp200mhz {
>> +		fsl,pins = <
>> +			MX8MQ_IOMUXC_SD1_CLK_USDHC1_CLK			0x9f
>> +			MX8MQ_IOMUXC_SD1_CMD_USDHC1_CMD			0xdf
>> +			MX8MQ_IOMUXC_SD1_DATA0_USDHC1_DATA0		0xdf
>> +			MX8MQ_IOMUXC_SD1_DATA1_USDHC1_DATA1		0xdf
>> +			MX8MQ_IOMUXC_SD1_DATA2_USDHC1_DATA2		0xdf
>> +			MX8MQ_IOMUXC_SD1_DATA3_USDHC1_DATA3		0xdf
>> +			MX8MQ_IOMUXC_SD1_DATA4_USDHC1_DATA4		0xdf
>> +			MX8MQ_IOMUXC_SD1_DATA5_USDHC1_DATA5		0xdf
>> +			MX8MQ_IOMUXC_SD1_DATA6_USDHC1_DATA6		0xdf
>> +			MX8MQ_IOMUXC_SD1_DATA7_USDHC1_DATA7		0xdf
>> +			MX8MQ_IOMUXC_SD1_STROBE_USDHC1_STROBE		0x9f
>> +			MX8MQ_IOMUXC_SD1_RESET_B_USDHC1_RESET_B		0xc1
>> +		>;
>> +	};
>> +
>> +	pinctrl_usdhc2: usdhc2grp {
>> +		fsl,pins = <
>> +			MX8MQ_IOMUXC_SD2_CD_B_GPIO2_IO12	0x80
>> +			MX8MQ_IOMUXC_SD2_CLK_USDHC2_CLK		0x83
>> +			MX8MQ_IOMUXC_SD2_CMD_USDHC2_CMD		0xc3
>> +			MX8MQ_IOMUXC_SD2_DATA0_USDHC2_DATA0	0xc3
>> +			MX8MQ_IOMUXC_SD2_DATA1_USDHC2_DATA1	0xc3
>> +			MX8MQ_IOMUXC_SD2_DATA2_USDHC2_DATA2	0xc3
>> +			MX8MQ_IOMUXC_SD2_DATA3_USDHC2_DATA3	0xc3
>> +			MX8MQ_IOMUXC_SD2_RESET_B_USDHC2_RESET_B 0xc1
>> +		>;
>> +	};
>> +
>> +	pinctrl_usdhc2_100mhz: usdhc2grp100mhz {
>> +		fsl,pins = <
>> +			MX8MQ_IOMUXC_SD2_CD_B_GPIO2_IO12	0x80
>> +			MX8MQ_IOMUXC_SD2_CLK_USDHC2_CLK		0x8d
>> +			MX8MQ_IOMUXC_SD2_CMD_USDHC2_CMD		0xcd
>> +			MX8MQ_IOMUXC_SD2_DATA0_USDHC2_DATA0	0xcd
>> +			MX8MQ_IOMUXC_SD2_DATA1_USDHC2_DATA1	0xcd
>> +			MX8MQ_IOMUXC_SD2_DATA2_USDHC2_DATA2	0xcd
>> +			MX8MQ_IOMUXC_SD2_DATA3_USDHC2_DATA3	0xcd
>> +			MX8MQ_IOMUXC_SD2_RESET_B_USDHC2_RESET_B 0xc1
>> +		>;
>> +	};
>> +
>> +	pinctrl_usdhc2_200mhz: usdhc2grp200mhz {
>> +		fsl,pins = <
>> +			MX8MQ_IOMUXC_SD2_CD_B_GPIO2_IO12	0x80
>> +			MX8MQ_IOMUXC_SD2_CLK_USDHC2_CLK		0x9f
>> +			MX8MQ_IOMUXC_SD2_CMD_USDHC2_CMD		0xcf
>> +			MX8MQ_IOMUXC_SD2_DATA0_USDHC2_DATA0	0xcf
>> +			MX8MQ_IOMUXC_SD2_DATA1_USDHC2_DATA1	0xcf
>> +			MX8MQ_IOMUXC_SD2_DATA2_USDHC2_DATA2	0xcf
>> +			MX8MQ_IOMUXC_SD2_DATA3_USDHC2_DATA3	0xcf
>> +			MX8MQ_IOMUXC_SD2_RESET_B_USDHC2_RESET_B 0xc1
>> +		>;
>> +	};
>> +
>> +	pinctrl_wdog: wdoggrp {
>> +		fsl,pins = <
>> +			/* nWDOG */
>> +			MX8MQ_IOMUXC_GPIO1_IO02_WDOG1_WDOG_B	0x1f
>> +		>;
>> +	};
>> +};
>> +
>> +&i2c1 {
>> +	clock-frequency = <387000>;
> 
> This frequency setting looks special.  Why cannot it be 400k?
> 

because of an erratum we see in the imx8mq:

e7805I2C: When the I2C clock speed is configured for 400 kHz, the SCL
low period violates the I2C spec of1.3 uS min

source:
https://www.nxp.com/docs/en/errata/IMX8MDQLQ_2N14W.pdf


>> +	pinctrl-names = "default";
>> +	pinctrl-0 = <&pinctrl_i2c1>;
>> +	status = "okay";
>> +
>> +	typec_pd: usb-pd@3f {
>> +		compatible = "ti,tps6598x";
>> +		reg = <0x3f>;
>> +		pinctrl-names = "default";
>> +		pinctrl-0 = <&pinctrl_typec>, <&pinctrl_tcpc>;
>> +		interrupt-parent = <&gpio1>;
>> +		interrupts = <10 IRQ_TYPE_LEVEL_LOW>;
>> +
>> +		connector {
>> +			ports {
>> +				#address-cells = <1>;
>> +				#size-cells = <0>;
>> +
>> +				port@0 {
>> +					reg = <0>;
>> +
>> +					usb_con_hs: endpoint {
>> +						remote-endpoint = <&typec_hs>;
>> +					};
>> +				};
>> +
>> +				port@1 {
>> +					reg = <1>;
>> +
>> +					usb_con_ss: endpoint {
>> +						remote-endpoint = <&typec_ss>;
>> +					};
>> +				};
>> +			};
>> +		};
>> +	};
>> +
>> +	pmic: pmic@4b {
>> +		compatible = "rohm,bd71837";
>> +		reg = <0x4b>;
>> +		pinctrl-names = "default";
>> +		pinctrl-0 = <&pinctrl_pmic>;
>> +		clocks = <&pmic_osc>;
>> +		clock-names = "osc";
>> +		clock-output-names = "pmic_clk";
>> +		interrupt-parent = <&gpio1>;
>> +		interrupts = <7 GPIO_ACTIVE_LOW>;
>> +		interrupt-names = "irq";
>> +		rohm,reset-snvs-powered;
>> +
>> +		regulators {
>> +			buck1_reg: BUCK1 {
>> +				regulator-name = "BUCK1";
>> +				regulator-min-microvolt = <700000>;
>> +				regulator-max-microvolt = <1300000>;
>> +				regulator-ramp-delay = <1250>;
>> +				rohm,dvs-run-voltage = <900000>;
>> +				rohm,dvs-idle-voltage = <850000>;
>> +				rohm,dvs-suspend-voltage = <800000>;
>> +				regulator-always-on;
>> +			};
>> +
>> +			buck2_reg: BUCK2 {
>> +				regulator-name = "BUCK2";
>> +				regulator-min-microvolt = <700000>;
>> +				regulator-max-microvolt = <1300000>;
>> +				regulator-ramp-delay = <1250>;
>> +				rohm,dvs-run-voltage = <1000000>;
>> +				rohm,dvs-idle-voltage = <900000>;
>> +				regulator-always-on;
>> +			};
>> +
>> +			buck3_reg: BUCK3 {
>> +				regulator-name = "BUCK3";
>> +				regulator-min-microvolt = <700000>;
>> +				regulator-max-microvolt = <1300000>;
>> +				rohm,dvs-run-voltage = <900000>;
>> +				regulator-always-on;
>> +			};
>> +
>> +			buck4_reg: BUCK4 {
>> +				regulator-name = "BUCK4";
>> +				regulator-min-microvolt = <700000>;
>> +				regulator-max-microvolt = <1300000>;
>> +				rohm,dvs-run-voltage = <1000000>;
>> +			};
>> +
>> +			buck5_reg: BUCK5 {
>> +				regulator-name = "BUCK5";
>> +				regulator-min-microvolt = <700000>;
>> +				regulator-max-microvolt = <1350000>;
>> +				regulator-always-on;
>> +			};
>> +
>> +			buck6_reg: BUCK6 {
>> +				regulator-name = "BUCK6";
>> +				regulator-min-microvolt = <3000000>;
>> +				regulator-max-microvolt = <3300000>;
>> +				regulator-always-on;
>> +			};
>> +
>> +			buck7_reg: BUCK7 {
>> +				regulator-name = "BUCK7";
>> +				regulator-min-microvolt = <1605000>;
>> +				regulator-max-microvolt = <1995000>;
>> +				regulator-always-on;
>> +			};
>> +
>> +			buck8_reg: BUCK8 {
>> +				regulator-name = "BUCK8";
>> +				regulator-min-microvolt = <800000>;
>> +				regulator-max-microvolt = <1400000>;
>> +				regulator-always-on;
>> +			};
>> +
>> +			ldo1_reg: LDO1 {
>> +				regulator-name = "LDO1";
>> +				regulator-min-microvolt = <3000000>;
>> +				regulator-max-microvolt = <3300000>;
>> +				/* leave on for snvs power button */
>> +				regulator-always-on;
>> +			};
>> +
>> +			ldo2_reg: LDO2 {
>> +				regulator-name = "LDO2";
>> +				regulator-min-microvolt = <900000>;
>> +				regulator-max-microvolt = <900000>;
>> +				/* leave on for snvs power button */
>> +				regulator-always-on;
>> +			};
>> +
>> +			ldo3_reg: LDO3 {
>> +				regulator-name = "LDO3";
>> +				regulator-min-microvolt = <1800000>;
>> +				regulator-max-microvolt = <3300000>;
>> +				regulator-always-on;
>> +			};
>> +
>> +			ldo4_reg: LDO4 {
>> +				regulator-name = "LDO4";
>> +				regulator-min-microvolt = <900000>;
>> +				regulator-max-microvolt = <1800000>;
>> +				regulator-always-on;
>> +			};
>> +
>> +			ldo5_reg: LDO5 {
>> +				/* VDD_PHY_0V9 - MIPI and HDMI domains */
>> +				regulator-name = "LDO5";
>> +				regulator-min-microvolt = <1800000>;
>> +				regulator-max-microvolt = <3300000>;
>> +				regulator-always-on;
>> +			};
>> +
>> +			ldo6_reg: LDO6 {
>> +				/* VDD_PHY_0V9 - MIPI, HDMI and USB domains */
>> +				regulator-name = "LDO6";
>> +				regulator-min-microvolt = <900000>;
>> +				regulator-max-microvolt = <1800000>;
>> +				regulator-always-on;
>> +			};
>> +
>> +			ldo7_reg: LDO7 {
>> +				/* VDD_PHY_3V3 - USB domain */
>> +				regulator-name = "LDO7";
>> +				regulator-min-microvolt = <1800000>;
>> +				regulator-max-microvolt = <3300000>;
>> +				regulator-always-on;
>> +			};
>> +		};
>> +	};
>> +
>> +	rtc@68 {
>> +		compatible = "microcrystal,rv4162";
>> +		reg = <0x68>;
>> +		pinctrl-names = "default";
>> +		pinctrl-0 = <&pinctrl_rtc>;
>> +		interrupt-parent = <&gpio1>;
>> +		interrupts = <9 IRQ_TYPE_LEVEL_LOW>;
>> +	};
>> +};
>> +
>> +&i2c2 {
>> +	clock-frequency = <387000>;
>> +	pinctrl-names = "default";
>> +	pinctrl-0 = <&pinctrl_i2c2>;
>> +	status = "okay";
>> +
>> +	magnetometer@1e	{
>> +		compatible = "st,lsm9ds1-magn";
>> +		reg = <0x1e>;
>> +		pinctrl-names = "default";
>> +		pinctrl-0 = <&pinctrl_mag>;
>> +		interrupt-parent = <&gpio3>;
>> +		interrupts = <22 IRQ_TYPE_LEVEL_HIGH>;
>> +		vdd-supply = <&reg_vdd_sen>;
>> +		vddio-supply = <&reg_vdd_1v8>;
>> +	};
>> +
>> +	regulator@3e {
>> +		compatible = "tps65132";
>> +		reg = <0x3e>;
> 
> Have a newline between property list and child node.
> 
>> +		outp {
>> +			regulator-name = "LCD_AVDD";
>> +			vin-supply = <&reg_lcd_3v4>;
>> +		};
>> +
>> +		outn {
>> +			regulator-name = "LCD_AVEE";
>> +			vin-supply = <&reg_lcd_3v4>;
>> +		};
>> +	};
>> +
>> +	flash@53 {
>> +		compatible = "lm3560";
>> +		reg = <0x53>;
>> +		#address-cells = <1>;
>> +		#size-cells = <0>;
>> +		flash@0 {
>> +			reg = <0x0>;
>> +			flash-timeout-us = <150000>;
>> +			flash-max-microamp = <320000>;
>> +			led-max-microamp = <60000>;
>> +			label = "flash";
>> +		};
>> +
>> +		torch@1 {
>> +			reg = <0x1>;
>> +			led-max-microamp = <10000>;
>> +			label = "torch";
>> +		};
>> +
>> +	};
>> +
>> +	prox@60 {
>> +		compatible = "vishay,vcnl4040";
>> +		reg = <0x60>;
>> +		pinctrl-0 = <&pinctrl_prox>;
>> +		interrupt-parent = <&gpio3>;
>> +		interrupts = <7 IRQ_TYPE_LEVEL_LOW>;
>> +	};
>> +
>> +	accel-gyro@6a	{
>> +		compatible = "st,lsm9ds1-imu";
>> +		reg = <0x6a>;
>> +		vdd-supply = <&reg_vdd_sen>;
>> +		vddio-supply = <&reg_vdd_1v8>;
>> +		mount-matrix =  "1",  "0",  "0",
>> +				"0",  "1",  "0",
>> +				"0",  "0", "-1";
>> +	};
>> +};
>> +
>> +&i2c3 {
>> +	clock-frequency = <387000>;
>> +	pinctrl-names = "default";
>> +	pinctrl-0 = <&pinctrl_i2c3>;
>> +	status = "okay";
>> +
>> +	codec: audio-codec@1a {
>> +		compatible = "wlf,wm8962";
>> +		reg = <0x1a>; // 0x4a is the test address
>> +		clocks = <&clk IMX8MQ_CLK_SAI2_ROOT>;
>> +		assigned-clocks = <&clk IMX8MQ_CLK_SAI2>;
>> +		assigned-clock-parents = <&clk IMX8MQ_AUDIO_PLL1_OUT>;
>> +		assigned-clock-rates = <24576000>;
>> +		#sound-dai-cells = <0>;
>> +		mic-cfg = <0x200>;
>> +		DCVDD-supply = <&reg_aud_1v8>;
>> +		DBVDD-supply = <&reg_aud_1v8>;
>> +		AVDD-supply = <&reg_aud_1v8>;
>> +		CPVDD-supply = <&reg_aud_1v8>;
>> +		MICVDD-supply = <&reg_aud_1v8>;
>> +		PLLVDD-supply = <&reg_aud_1v8>;
>> +		SPKVDD1-supply = <&reg_vsys_3v4>;
>> +		SPKVDD2-supply = <&reg_vsys_3v4>;
>> +		gpio-cfg = <
>> +			0x0000 /* n/c */
>> +			0x0001 /* gpio2, 1: default */
>> +			0x0013 /* gpio3, 2: dmicclk */
>> +			0x0000 /* n/c, 3: default */
>> +			0x8014 /* gpio5, 4: dmic_dat */
>> +			0x0000 /* gpio6, 5: default */
>> +		>;
>> +	};
>> +
>> +	backlight@36 {
>> +		compatible = "ti,lm36922";
>> +		reg = <0x36>;
>> +		pinctrl-names = "default";
>> +		pinctrl-0 = <&pinctrl_bl>;
>> +		#address-cells = <1>;
>> +		#size-cells = <0>;
>> +
> 
> Drop this newline.
> 
> Shawn
> 

thanks a lot Shawn! I'll take all your comments into account,

                             martin

