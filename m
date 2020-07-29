Return-Path: <SRS0=g5yc=BI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.3 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,NICE_REPLY_A,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E9BDDC433E0
	for <linux-kernel@archiver.kernel.org>; Wed, 29 Jul 2020 08:07:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C638D22B42
	for <linux-kernel@archiver.kernel.org>; Wed, 29 Jul 2020 08:07:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727941AbgG2IH3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 29 Jul 2020 04:07:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57454 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726336AbgG2IH3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Jul 2020 04:07:29 -0400
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8D648C061794
        for <linux-kernel@vger.kernel.org>; Wed, 29 Jul 2020 01:07:28 -0700 (PDT)
Received: from gallifrey.ext.pengutronix.de ([2001:67c:670:201:5054:ff:fe8d:eefb] helo=[127.0.0.1])
        by metis.ext.pengutronix.de with esmtp (Exim 4.92)
        (envelope-from <a.fatoum@pengutronix.de>)
        id 1k0h7X-0000xu-6N; Wed, 29 Jul 2020 10:07:27 +0200
Subject: Re: [PATCH v5 3/3] ARM: dts: stm32: add initial support for
 stm32mp157-odyssey board
To:     Marcin Sloniewski <marcin.sloniewski@gmail.com>,
        linux-arm-kernel@lists.infradead.org
Cc:     robh+dt@kernel.org, mcoquelin.stm32@gmail.com,
        alexandre.torgue@st.com, mani@kernel.org, sam@ravnborg.org,
        linus.walleij@linaro.org, heiko.stuebner@theobroma-systems.com,
        stephan@gerhold.net, lkundrak@v3.sk, broonie@kernel.org,
        allen.chen@ite.com.tw, robh@kernel.org, devicetree@vger.kernel.org,
        linux-stm32@st-md-mailman.stormreply.com,
        linux-kernel@vger.kernel.org
References: <20200724145107.35772-1-marcin.sloniewski@gmail.com>
 <20200724145107.35772-3-marcin.sloniewski@gmail.com>
From:   Ahmad Fatoum <a.fatoum@pengutronix.de>
Message-ID: <4a160bb6-bc73-0a18-86c4-decd985104ad@pengutronix.de>
Date:   Wed, 29 Jul 2020 10:07:20 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.9.0
MIME-Version: 1.0
In-Reply-To: <20200724145107.35772-3-marcin.sloniewski@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-SA-Exim-Connect-IP: 2001:67c:670:201:5054:ff:fe8d:eefb
X-SA-Exim-Mail-From: a.fatoum@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-kernel@vger.kernel.org
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello Marcin,

On 7/24/20 4:51 PM, Marcin Sloniewski wrote:
> Add support for Seeed Studio's stm32mp157c odyssey board.
> Board consists of SoM with stm32mp157c with 4GB eMMC and 512 MB DDR3 RAM
> and carrier board with USB and ETH interfaces, SD card connector,
> wifi and BT chip AP6236.
> 
> In this patch only basic kernel boot is supported and interfacing
> SD card and on-board eMMC.
> 
> Signed-off-by: Marcin Sloniewski <marcin.sloniewski@gmail.com>
> ---
> 
> Changes in v5:
> - fix schema for board's dts
> 
> Changes in v4:
> - add seeed,stm32mp157c-odyssey-som in compatible
>   for carrier board
> - fix sdmmc2 interface by changing one of the pins
>   to use
> - change eth phy address to 7
> 
> Changes in v3:
> - fix compilation on tip of stm32-next
>   due to change in names for pinctrl
> - fix deprecated binding for led node
> - fix redundant "okay" statuses
> - add phy part number for eth in comment
> 
> Changes in v2:
> - add new odyssey dts to Makefile
> 
>  arch/arm/boot/dts/Makefile                    |   3 +-
>  .../arm/boot/dts/stm32mp157c-odyssey-som.dtsi | 294 ++++++++++++++++++
>  arch/arm/boot/dts/stm32mp157c-odyssey.dts     |  73 +++++
>  3 files changed, 369 insertions(+), 1 deletion(-)
>  create mode 100644 arch/arm/boot/dts/stm32mp157c-odyssey-som.dtsi
>  create mode 100644 arch/arm/boot/dts/stm32mp157c-odyssey.dts
> 
> diff --git a/arch/arm/boot/dts/Makefile b/arch/arm/boot/dts/Makefile
> index e6a1cac0bfc7..a3ea2301c82c 100644
> --- a/arch/arm/boot/dts/Makefile
> +++ b/arch/arm/boot/dts/Makefile
> @@ -1047,7 +1047,8 @@ dtb-$(CONFIG_ARCH_STM32) += \
>  	stm32mp157c-dk2.dtb \
>  	stm32mp157c-ed1.dtb \
>  	stm32mp157c-ev1.dtb \
> -	stm32mp157c-lxa-mc1.dtb
> +	stm32mp157c-lxa-mc1.dtb \
> +	stm32mp157c-odyssey.dtb
>  dtb-$(CONFIG_MACH_SUN4I) += \
>  	sun4i-a10-a1000.dtb \
>  	sun4i-a10-ba10-tvbox.dtb \
> diff --git a/arch/arm/boot/dts/stm32mp157c-odyssey-som.dtsi b/arch/arm/boot/dts/stm32mp157c-odyssey-som.dtsi
> new file mode 100644
> index 000000000000..9875c93bb136
> --- /dev/null
> +++ b/arch/arm/boot/dts/stm32mp157c-odyssey-som.dtsi
> @@ -0,0 +1,294 @@
> +// SPDX-License-Identifier: (GPL-2.0+ OR BSD-3-Clause)
> +/*
> + * Copyright (C) 2020 Marcin Sloniewski <marcin.sloniewski@gmail.com>.
> + */
> +
> +/dts-v1/;
> +
> +#include "stm32mp157.dtsi"
> +#include "stm32mp15xc.dtsi"
> +#include "stm32mp15-pinctrl.dtsi"
> +#include "stm32mp15xxac-pinctrl.dtsi"
> +#include <dt-bindings/gpio/gpio.h>
> +#include <dt-bindings/leds/common.h>
> +#include <dt-bindings/mfd/st,stpmic1.h>
> +
> +/ {
> +	model = "Seeed Studio Odyssey-STM32MP157C SOM";
> +	compatible = "seeed,stm32mp157c-odyssey-som", "st,stm32mp157";
> +
> +	memory@c0000000 {
> +		device_type = "memory";
> +		reg = <0xc0000000 0x20000000>;
> +	};
> +
> +	reserved-memory {
> +		#address-cells = <1>;
> +		#size-cells = <1>;
> +		ranges;
> +
> +		mcuram2: mcuram2@10000000 {
> +			compatible = "shared-dma-pool";
> +			reg = <0x10000000 0x40000>;
> +			no-map;
> +		};
> +
> +		vdev0vring0: vdev0vring0@10040000 {
> +			compatible = "shared-dma-pool";
> +			reg = <0x10040000 0x1000>;
> +			no-map;
> +		};
> +
> +		vdev0vring1: vdev0vring1@10041000 {
> +			compatible = "shared-dma-pool";
> +			reg = <0x10041000 0x1000>;
> +			no-map;
> +		};
> +
> +		vdev0buffer: vdev0buffer@10042000 {
> +			compatible = "shared-dma-pool";
> +			reg = <0x10042000 0x4000>;
> +			no-map;
> +		};
> +
> +		mcuram: mcuram@30000000 {
> +			compatible = "shared-dma-pool";
> +			reg = <0x30000000 0x40000>;
> +			no-map;
> +		};
> +
> +		retram: retram@38000000 {
> +			compatible = "shared-dma-pool";
> +			reg = <0x38000000 0x10000>;
> +			no-map;
> +		};
> +
> +		gpu_reserved: gpu@d4000000 {
> +			reg = <0xd4000000 0x4000000>;
> +			no-map;
> +		};
> +	};
> +
> +	led {
> +		compatible = "gpio-leds";
> +		led-blue {
> +			color = <LED_COLOR_ID_BLUE>;
> +			function = LED_FUNCTION_HEARTBEAT;
> +			gpios = <&gpiog 3 GPIO_ACTIVE_HIGH>;
> +			linux,default-trigger = "heartbeat";
> +		};
> +	};
> +};
> +
> +&gpu {
> +	contiguous-area = <&gpu_reserved>;
> +	status = "okay";
> +};
> +
> +&i2c2 {
> +	pinctrl-names = "default";
> +	pinctrl-0 = <&i2c2_pins_a>;
> +	i2c-scl-rising-time-ns = <185>;
> +	i2c-scl-falling-time-ns = <20>;
> +	status = "okay";
> +	/* spare dmas for other usage */
> +	/delete-property/dmas;
> +	/delete-property/dma-names;
> +
> +	pmic: stpmic@33 {
> +		compatible = "st,stpmic1";
> +		reg = <0x33>;
> +		interrupts-extended = <&gpioa 0 IRQ_TYPE_EDGE_FALLING>;
> +		interrupt-controller;
> +		#interrupt-cells = <2>;
> +
> +		regulators {
> +			compatible = "st,stpmic1-regulators";
> +			ldo1-supply = <&v3v3>;
> +			ldo3-supply = <&vdd_ddr>;
> +			ldo6-supply = <&v3v3>;
> +			pwr_sw1-supply = <&bst_out>;
> +			pwr_sw2-supply = <&bst_out>;
> +
> +			vddcore: buck1 {
> +				regulator-name = "vddcore";
> +				regulator-min-microvolt = <800000>;
> +				regulator-max-microvolt = <1350000>;
> +				regulator-always-on;
> +				regulator-initial-mode = <0>;
> +				regulator-over-current-protection;
> +			};
> +
> +			vdd_ddr: buck2 {
> +				regulator-name = "vdd_ddr";
> +				regulator-min-microvolt = <1350000>;
> +				regulator-max-microvolt = <1350000>;
> +				regulator-always-on;
> +				regulator-initial-mode = <0>;
> +				regulator-over-current-protection;
> +			};
> +
> +			vdd: buck3 {
> +				regulator-name = "vdd";
> +				regulator-min-microvolt = <3300000>;
> +				regulator-max-microvolt = <3300000>;
> +				regulator-always-on;
> +				st,mask-reset;
> +				regulator-initial-mode = <0>;
> +				regulator-over-current-protection;
> +			};
> +
> +			v3v3: buck4 {
> +				regulator-name = "v3v3";
> +				regulator-min-microvolt = <3300000>;
> +				regulator-max-microvolt = <3300000>;
> +				regulator-always-on;
> +				regulator-over-current-protection;
> +				regulator-initial-mode = <0>;
> +			};
> +
> +			v1v8_audio: ldo1 {
> +				regulator-name = "v1v8_audio";
> +				regulator-min-microvolt = <1800000>;
> +				regulator-max-microvolt = <1800000>;
> +				regulator-always-on;
> +				interrupts = <IT_CURLIM_LDO1 0>;
> +			};
> +
> +			v3v3_hdmi: ldo2 {
> +				regulator-name = "v3v3_hdmi";
> +				regulator-min-microvolt = <3300000>;
> +				regulator-max-microvolt = <3300000>;
> +				regulator-always-on;
> +				interrupts = <IT_CURLIM_LDO2 0>;
> +			};
> +
> +			vtt_ddr: ldo3 {
> +				regulator-name = "vtt_ddr";
> +				regulator-min-microvolt = <500000>;
> +				regulator-max-microvolt = <750000>;
> +				regulator-always-on;
> +				regulator-over-current-protection;
> +			};
> +
> +			vdd_usb: ldo4 {
> +				regulator-name = "vdd_usb";
> +				regulator-min-microvolt = <3300000>;
> +				regulator-max-microvolt = <3300000>;
> +				interrupts = <IT_CURLIM_LDO4 0>;
> +			};
> +
> +			vdda: ldo5 {
> +				regulator-name = "vdda";
> +				regulator-min-microvolt = <2900000>;
> +				regulator-max-microvolt = <2900000>;
> +				interrupts = <IT_CURLIM_LDO5 0>;
> +				regulator-boot-on;
> +			};
> +
> +			v1v2_hdmi: ldo6 {
> +				regulator-name = "v1v2_hdmi";
> +				regulator-min-microvolt = <1200000>;
> +				regulator-max-microvolt = <1200000>;
> +				regulator-always-on;
> +				interrupts = <IT_CURLIM_LDO6 0>;
> +			};
> +
> +			vref_ddr: vref_ddr {
> +				regulator-name = "vref_ddr";
> +				regulator-always-on;
> +				regulator-over-current-protection;
> +			};
> +
> +			 bst_out: boost {
> +				regulator-name = "bst_out";
> +				interrupts = <IT_OCP_BOOST 0>;
> +			 };
> +
> +			vbus_otg: pwr_sw1 {
> +				regulator-name = "vbus_otg";
> +				interrupts = <IT_OCP_OTG 0>;
> +			 };
> +
> +			 vbus_sw: pwr_sw2 {
> +				regulator-name = "vbus_sw";
> +				interrupts = <IT_OCP_SWOUT 0>;
> +				regulator-active-discharge;
> +			 };
> +		};
> +
> +		onkey {
> +			compatible = "st,stpmic1-onkey";
> +			interrupts = <IT_PONKEY_F 0>, <IT_PONKEY_R 0>;
> +			interrupt-names = "onkey-falling", "onkey-rising";
> +			power-off-time-sec = <10>;
> +		};
> +
> +		watchdog {
> +			compatible = "st,stpmic1-wdt";
> +			status = "disabled";
> +		};
> +	};
> +};
> +
> +&ipcc {
> +	status = "okay";
> +};
> +
> +&iwdg2 {
> +	timeout-sec = <32>;
> +	status = "okay";
> +};
> +
> +&m4_rproc {
> +	memory-region = <&retram>, <&mcuram>, <&mcuram2>, <&vdev0vring0>,
> +			<&vdev0vring1>, <&vdev0buffer>;
> +	mboxes = <&ipcc 0>, <&ipcc 1>, <&ipcc 2>;
> +	mbox-names = "vq0", "vq1", "shutdown";
> +	interrupt-parent = <&exti>;
> +	interrupts = <68 1>;
> +	status = "okay";
> +};
> +
> +&rng1 {
> +	status = "okay";
> +};
> +
> +&rtc {
> +	status = "okay";
> +};
> +
> +&sdmmc2_d47_pins_a {
> +	pins {
> +		pinmux = <STM32_PINMUX('A', 8, AF9)>, /* SDMMC2_D4 */
> +			 <STM32_PINMUX('A', 9, AF10)>, /* SDMMC2_D5 */
> +			 <STM32_PINMUX('E', 5, AF9)>, /* SDMMC2_D6 */
> +			 <STM32_PINMUX('C', 7, AF10)>; /* SDMMC2_D7 */
> +	};
> +};
> +
> +&sdmmc2_d47_sleep_pins_a {
> +	pins {
> +		pinmux = <STM32_PINMUX('A', 8, ANALOG)>, /* SDMMC2_D4 */
> +			 <STM32_PINMUX('A', 9, ANALOG)>, /* SDMMC2_D5 */
> +			 <STM32_PINMUX('E', 5, ANALOG)>, /* SDMMC2_D6 */
> +			 <STM32_PINMUX('C', 7, ANALOG)>; /* SDMMC2_D7 */
> +	};
> +};

When I sent out the device trees for the lxa-mc1, Alex wanted
all pinctrl nodes to be collected in stm32mp15-pinctrl.dtsi.

@Alex, should this be done here as well?

> +
> +&sdmmc2 {
> +	pinctrl-names = "default", "opendrain", "sleep";
> +	pinctrl-0 = <&sdmmc2_b4_pins_a &sdmmc2_d47_pins_a>;
> +	pinctrl-1 = <&sdmmc2_b4_od_pins_a &sdmmc2_d47_pins_a>;
> +	pinctrl-2 = <&sdmmc2_b4_sleep_pins_a &sdmmc2_d47_sleep_pins_a>;
> +	non-removable;
> +	no-sd;
> +	no-sdio;
> +	st,neg-edge;
> +	bus-width = <8>;
> +	vmmc-supply = <&v3v3>;
> +	vqmmc-supply = <&v3v3>;
> +	mmc-ddr-3_3v;
> +	status = "okay";
> +};
> +
> diff --git a/arch/arm/boot/dts/stm32mp157c-odyssey.dts b/arch/arm/boot/dts/stm32mp157c-odyssey.dts
> new file mode 100644
> index 000000000000..619243807842
> --- /dev/null
> +++ b/arch/arm/boot/dts/stm32mp157c-odyssey.dts
> @@ -0,0 +1,73 @@
> +// SPDX-License-Identifier: (GPL-2.0+ OR BSD-3-Clause)
> +/*
> + * Copyright (C) 2020 Marcin Sloniewski <marcin.sloniewski@gmail.com>.
> + */
> +
> +/dts-v1/;
> +
> +#include "stm32mp157c-odyssey-som.dtsi"
> +
> +/ {
> +	model = "Seeed Studio Odyssey-STM32MP157C Board";
> +	compatible = "seeed,stm32mp157c-odyssey",
> +		     "seeed,stm32mp157c-odyssey-som", "st,stm32mp157";
> +
> +	aliases {
> +		ethernet0 = &ethernet0;
> +		serial0 = &uart4;
> +	};
> +
> +	chosen {
> +		stdout-path = "serial0:115200n8";
> +	};
> +};
> +
> +&ethernet0 {
> +	status = "okay";
> +	pinctrl-0 = <&ethernet0_rgmii_pins_a>;
> +	pinctrl-1 = <&ethernet0_rgmii_sleep_pins_a>;
> +	pinctrl-names = "default", "sleep";
> +	phy-mode = "rgmii-id";
> +	max-speed = <1000>;
> +	phy-handle = <&phy0>;
> +
> +	mdio0 {
> +		#address-cells = <1>;
> +		#size-cells = <0>;
> +		compatible = "snps,dwmac-mdio";
> +		phy0: ethernet-phy@7 { /* KSZ9031RN */
> +			reg = <7>;

reset-gpios is missing. I see that the vendor u-boot does it
in board code, but you don't want Linux to depend on this.

> +		};
> +	};
> +};
> +
> +&i2c1 {
> +	pinctrl-names = "default", "sleep";
> +	pinctrl-0 = <&i2c1_pins_a>;
> +	pinctrl-1 = <&i2c1_sleep_pins_a>;
> +	i2c-scl-rising-time-ns = <100>;
> +	i2c-scl-falling-time-ns = <7>;
> +	status = "okay";
> +	/delete-property/dmas;
> +	/delete-property/dma-names;
> +};
> +
> +&sdmmc1 {
> +	pinctrl-names = "default", "opendrain", "sleep";
> +	pinctrl-0 = <&sdmmc1_b4_pins_a>;
> +	pinctrl-1 = <&sdmmc1_b4_od_pins_a>;
> +	pinctrl-2 = <&sdmmc1_b4_sleep_pins_a>;
> +	cd-gpios = <&gpiob 7 (GPIO_ACTIVE_LOW | GPIO_PULL_UP)>;
> +	disable-wp;
> +	st,neg-edge;
> +	bus-width = <4>;
> +	vmmc-supply = <&v3v3>;
> +	status = "okay";
> +};
> +
> +&uart4 {
> +	pinctrl-names = "default";
> +	pinctrl-0 = <&uart4_pins_a>;
> +	status = "okay";
> +};
> +
> 

-- 
Pengutronix e.K.                           |                             |
Steuerwalder Str. 21                       | http://www.pengutronix.de/  |
31137 Hildesheim, Germany                  | Phone: +49-5121-206917-0    |
Amtsgericht Hildesheim, HRA 2686           | Fax:   +49-5121-206917-5555 |
