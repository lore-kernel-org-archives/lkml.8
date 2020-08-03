Return-Path: <SRS0=5bHT=BN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.0 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,NICE_REPLY_A,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AE0FEC433E1
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Aug 2020 21:41:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id BDF61207FC
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Aug 2020 21:41:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728845AbgHCVlp (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 3 Aug 2020 17:41:45 -0400
Received: from foss.arm.com ([217.140.110.172]:34728 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728038AbgHCVlo (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Aug 2020 17:41:44 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id A163D1FB;
        Mon,  3 Aug 2020 14:41:43 -0700 (PDT)
Received: from [10.57.35.143] (unknown [10.57.35.143])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 6BFD73F718;
        Mon,  3 Aug 2020 14:41:42 -0700 (PDT)
Subject: Re: [PATCH v2 3/3] arm64: dts: rockchip: add rk3318 A95X Z2 board
To:     Johan Jonker <jbx6244@gmail.com>, heiko@sntech.de
Cc:     devicetree@vger.kernel.org, robh+dt@kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-rockchip@lists.infradead.org
References: <20200718105343.5152-1-jbx6244@gmail.com>
 <20200718105343.5152-4-jbx6244@gmail.com>
From:   Robin Murphy <robin.murphy@arm.com>
Message-ID: <6d028007-4360-e552-3707-3dd2712f2501@arm.com>
Date:   Mon, 3 Aug 2020 22:41:40 +0100
User-Agent: Mozilla/5.0 (Windows NT 10.0; rv:68.0) Gecko/20100101
 Thunderbird/68.11.0
MIME-Version: 1.0
In-Reply-To: <20200718105343.5152-4-jbx6244@gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-GB
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2020-07-18 11:53, Johan Jonker wrote:
> The rk3318 A95X Z2 boards are sold as TV box.
> No further documentation is given, but from the dts files
> extracted it seems that the rk3318 processor is simulair
> to the rk3328. This dts file contains only the basic nodes
> that have support in the mainline kernel.
> 
> Features:
> 
> CPU: RK3318 Quad-Core Cortex-A53
> GPU: Mali-450
> RAM: 2/4GB DDR3
> ROM: EMMC 16/32/64GB
> HDMI: HDMI 2.0a for 4k@60Hz
> Ethernet: 10/100M standard RJ-45
> WiFi: 2.4G+5G WIFI, 802.11 b/g/n
> Bluetooth: 4.0
> 1 x USB 3.0
> 1 x USB 2.0
> 1 x Micro SD card slot
> 1 x SPDIF
> 1 x AV
> 1 x DC IN
> 
> Signed-off-by: Johan Jonker <jbx6244@gmail.com>
> ---
>   arch/arm64/boot/dts/rockchip/Makefile           |   1 +
>   arch/arm64/boot/dts/rockchip/rk3318-a95x-z2.dts | 393 ++++++++++++++++++++++++
>   2 files changed, 394 insertions(+)
>   create mode 100644 arch/arm64/boot/dts/rockchip/rk3318-a95x-z2.dts
> 
> diff --git a/arch/arm64/boot/dts/rockchip/Makefile b/arch/arm64/boot/dts/rockchip/Makefile
> index b87b1f773..aa508bc4a 100644
> --- a/arch/arm64/boot/dts/rockchip/Makefile
> +++ b/arch/arm64/boot/dts/rockchip/Makefile
> @@ -2,6 +2,7 @@
>   dtb-$(CONFIG_ARCH_ROCKCHIP) += px30-evb.dtb
>   dtb-$(CONFIG_ARCH_ROCKCHIP) += rk3308-evb.dtb
>   dtb-$(CONFIG_ARCH_ROCKCHIP) += rk3308-roc-cc.dtb
> +dtb-$(CONFIG_ARCH_ROCKCHIP) += rk3318-a95x-z2.dtb
>   dtb-$(CONFIG_ARCH_ROCKCHIP) += rk3326-odroid-go2.dtb
>   dtb-$(CONFIG_ARCH_ROCKCHIP) += rk3328-a1.dtb
>   dtb-$(CONFIG_ARCH_ROCKCHIP) += rk3328-evb.dtb
> diff --git a/arch/arm64/boot/dts/rockchip/rk3318-a95x-z2.dts b/arch/arm64/boot/dts/rockchip/rk3318-a95x-z2.dts
> new file mode 100644
> index 000000000..413418ea1
> --- /dev/null
> +++ b/arch/arm64/boot/dts/rockchip/rk3318-a95x-z2.dts
> @@ -0,0 +1,393 @@
> +// SPDX-License-Identifier: (GPL-2.0+ OR MIT)
> +
> +/dts-v1/;
> +#include <dt-bindings/input/input.h>
> +#include "rk3328.dtsi"
> +
> +/ {
> +	model = "A95X Z2";
> +	compatible = "zkmagic,a95x-z2", "rockchip,rk3318";
> +
> +	chosen {
> +		stdout-path = "serial2:1500000n8";
> +	};
> +
> +	adc-keys {
> +		compatible = "adc-keys";
> +		io-channels = <&saradc 0>;
> +		io-channel-names = "buttons";
> +		keyup-threshold-microvolt = <1800000>;
> +		poll-interval = <100>;
> +
> +		vol-up-key {
> +			label = "volume up";
> +			linux,code = <KEY_VOLUMEUP>;

Really? If as usual this is actually the recovery button hidden inside 
the box, it's somewhat questionable whether it's worth describing in DT 
at all. At the very least it should probably be presented as something 
more realistic than half a volume control.

> +			press-threshold-microvolt = <17000>;
> +		};
> +	};
> +
> +	ir-receiver {
> +		compatible = "gpio-ir-receiver";
> +		gpios = <&gpio2 RK_PA2 GPIO_ACTIVE_LOW>;
> +		pinctrl-0 = <&ir_int>;
> +		pinctrl-names = "default";
> +	};
> +
> +	leds {
> +		compatible = "gpio-leds";
> +		pinctrl-0 = <&cyx_led_pin>;
> +		pinctrl-names = "default";
> +
> +		cyx_led: led-0 {

What needs a phandle to this node to warrant a label?

> +			default-state = "on";
> +			gpios = <&gpio2 RK_PC7 GPIO_ACTIVE_LOW>;
> +			label = "CYX_LED";
> +		};
> +	};
> +
> +	sdio_pwrseq: sdio-pwrseq {
> +		compatible = "mmc-pwrseq-simple";
> +		pinctrl-0 = <&wifi_enable_h>;
> +		pinctrl-names = "default";
> +		reset-gpios = <&gpio1 RK_PC2 GPIO_ACTIVE_LOW>;
> +	};
> +
> +	spdif-sound {
> +		compatible = "simple-audio-card";
> +		simple-audio-card,name = "spdif";
> +
> +		simple-audio-card,cpu {
> +			sound-dai = <&spdif>;
> +		};
> +
> +		simple-audio-card,codec {
> +			sound-dai = <&spdif_out>;
> +		};
> +	};
> +
> +	spdif_out: spdif-out {
> +		compatible = "linux,spdif-dit";
> +		#sound-dai-cells = <0>;
> +	};
> +
> +	/* Power tree */
> +	regulators {

Don't create fake "buses" for regulators, especially if they don't even 
contain most of the regulators anyway.

> +		compatible = "simple-mfd";
> +		#address-cells = <1>;
> +		#size-cells = <0>;
> +
> +		vccio_1v8_reg: regulator@0 {
> +			compatible = "regulator-fixed";
> +			reg = <0>;
> +			regulator-name = "vccio_1v8";
> +			regulator-min-microvolt = <1800000>;
> +			regulator-max-microvolt = <1800000>;
> +			regulator-always-on;
> +		};
> +
> +		vccio_3v3_reg: regulator@1 {
> +			compatible = "regulator-fixed";
> +			reg = <1>;
> +			regulator-name = "vccio_3v3";
> +			regulator-min-microvolt = <3300000>;
> +			regulator-max-microvolt = <3300000>;
> +			regulator-always-on;
> +		};
> +	};
> +
> +	vcc_otg_vbus: otg-vbus-regulator {
> +		compatible = "regulator-fixed";
> +		gpio = <&gpio0 RK_PA2 GPIO_ACTIVE_HIGH>;
> +		pinctrl-0 = <&otg_vbus_drv>;
> +		pinctrl-names = "default";
> +		regulator-name = "vcc_otg_vbus";
> +		regulator-min-microvolt = <5000000>;
> +		regulator-max-microvolt = <5000000>;
> +		enable-active-high;
> +	};
> +
> +	vcc_phy: vcc-phy-regulator {
> +		compatible = "regulator-fixed";
> +		regulator-name = "vcc_phy";
> +		regulator-always-on;
> +		regulator-boot-on;
> +	};

Is this actually a distinct regulator? The reference design has the 
internal FEPHY block powered pretty much directly from the general 1V8 
and 1V0 supplies that also power USB/HDMI/etc., so I'd rather expect 
low-end boxes to follow suit. Either way there doesn't seem to be a 
great deal of value in describing something with no controls, no voltage 
information, and no connection to the power tree.

> +
> +	vcc_sd: sdmmc-regulator {
> +		compatible = "regulator-fixed";
> +		gpio = <&gpio0 RK_PD6 GPIO_ACTIVE_LOW>;
> +		pinctrl-0 = <&sdmmc0m1_gpio>;
> +		pinctrl-names = "default";
> +		regulator-name = "vcc_sd";
> +		regulator-min-microvolt = <3300000>;
> +		regulator-max-microvolt = <3300000>;
> +		vin-supply = <&vccio_3v3_reg>;
> +	};
> +
> +	vdd_arm: vdd-arm {
> +		compatible = "pwm-regulator";
> +		pwms = <&pwm0 0 5000 1>;
> +		regulator-name = "vdd_arm";
> +		regulator-min-microvolt = <950000>;
> +		regulator-max-microvolt = <1400000>;
> +		regulator-settling-time-up-us = <250>;
> +		regulator-always-on;
> +		regulator-boot-on;
> +	};
> +
> +	vdd_log: vdd-log {
> +		compatible = "pwm-regulator";
> +		pwms = <&pwm1 0 5000 1>;
> +		regulator-name = "vdd_log";
> +		regulator-min-microvolt = <900000>;
> +		regulator-max-microvolt = <1300000>;
> +		regulator-settling-time-up-us = <250>;
> +		regulator-always-on;
> +		regulator-boot-on;
> +	};
> +};
> +
> +&analog_sound {
> +	status = "okay";
> +};
> +
> +&codec {
> +	status = "okay";
> +};
> +
> +&cpu0 {
> +	cpu-supply = <&vdd_arm>;
> +};
> +
> +&cpu1 {
> +	cpu-supply = <&vdd_arm>;
> +};
> +
> +&cpu2 {
> +	cpu-supply = <&vdd_arm>;
> +};
> +
> +&cpu3 {
> +	cpu-supply = <&vdd_arm>;
> +};
> +
> +&cpu0_opp_table {
> +	opp-1200000000 {
> +		status = "disabled";
> +	};
> +
> +	opp-1296000000 {
> +		status = "disabled";
> +	};
> +};
> +
> +&emmc {
> +	bus-width = <8>;
> +	cap-mmc-highspeed;
> +	non-removable;
> +	pinctrl-0 = <&emmc_clk &emmc_cmd &emmc_bus8>;
> +	pinctrl-names = "default";
> +	status = "okay";
> +};
> +
> +&gmac2phy {
> +	assigned-clock-parents = <&cru SCLK_MAC2PHY_SRC>;
> +	assigned-clock-rate = <50000000>;
> +	assigned-clocks = <&cru SCLK_MAC2PHY>;
> +	clock_in_out = "output";
> +	phy-supply = <&vcc_phy>;
> +	status = "okay";
> +};
> +
> +&gpu {
> +	mali-supply = <&vdd_log>;
> +};
> +
> +&hdmi {
> +	ddc-i2c-scl-high-time-ns = <9625>;
> +	ddc-i2c-scl-low-time-ns = <10000>;
> +	status = "okay";
> +};
> +
> +&hdmiphy {
> +	status = "okay";
> +};
> +
> +&hdmi_sound {
> +	status = "okay";
> +};
> +
> +&i2s0 {
> +	status = "okay";
> +};
> +
> +&i2s1 {
> +	status = "okay";
> +};
> +
> +&io_domains {
> +	pmuio-supply = <&vccio_3v3_reg>;
> +	vccio1-supply = <&vccio_3v3_reg>;
> +	vccio2-supply = <&vccio_1v8_reg>;
> +	vccio3-supply = <&vccio_3v3_reg>;
> +	vccio4-supply = <&vccio_1v8_reg>;
> +	vccio5-supply = <&vccio_3v3_reg>;
> +	vccio6-supply = <&vccio_3v3_reg>;
> +	status = "okay";
> +};
> +
> +&pinctrl {
> +	ir {
> +		ir_int: ir-int {
> +			rockchip,pins = <2 RK_PA2 RK_FUNC_GPIO &pcfg_pull_none>;
> +		};
> +	};
> +
> +	leds {
> +		cyx_led_pin: cyx-led-pin {
> +			rockchip,pins = <2 RK_PC7 RK_FUNC_GPIO &pcfg_pull_none>;
> +		};
> +	};
> +
> +	pwm0 {
> +		pwm0_pin_pull_up: pwm0-pin-pull-up {
> +			rockchip,pins = <2 RK_PA4 1 &pcfg_pull_up>;
> +		};
> +	};
> +
> +	pwm1 {
> +		pwm1_pin_pull_up: pwm1-pin-pull-up {
> +			rockchip,pins = <2 RK_PA5 1 &pcfg_pull_up>;
> +		};
> +	};
> +
> +	sdio-pwrseq {
> +		wifi_enable_h: wifi-enable-h {
> +			rockchip,pins = <1 RK_PC2 RK_FUNC_GPIO &pcfg_pull_none>;
> +		};
> +	};
> +
> +	sdmmc1 {
> +		clk_32k_out: clk-32k-out {
> +			rockchip,pins = <1 RK_PD4 1 &pcfg_pull_none>;
> +		};
> +	};
> +
> +	usb {
> +		host_vbus_drv: host-vbus-drv {
> +			rockchip,pins = <0 RK_PA0 RK_FUNC_GPIO &pcfg_pull_none>;
> +		};
> +
> +		otg_vbus_drv: otg-vbus-drv {
> +			rockchip,pins = <0 RK_PA2 RK_FUNC_GPIO &pcfg_pull_none>;
> +		};
> +	};
> +};
> +
> +&pwm0 {
> +	pinctrl-0 = <&pwm0_pin_pull_up>;
> +	pinctrl-names = "active";
> +	status = "okay";
> +};
> +
> +&pwm1 {
> +	pinctrl-0 = <&pwm1_pin_pull_up>;
> +	pinctrl-names = "active";
> +	status = "okay";
> +};
> +
> +&saradc {
> +	vref-supply = <&vccio_1v8_reg>;
> +	status = "okay";
> +};
> +
> +&sdio {
> +	bus-width = <4>;
> +	cap-sd-highspeed;
> +	cap-sdio-irq;
> +	keep-power-in-suspend;
> +	max-frequency = <125000000>;
> +	mmc-pwrseq = <&sdio_pwrseq>;
> +	non-removable;
> +	pinctrl-0 = <&sdmmc1_bus4 &sdmmc1_cmd &sdmmc1_clk &clk_32k_out>;
> +	pinctrl-names = "default";
> +	sd-uhs-sdr104;
> +	status = "okay";
> +};
> +
> +&sdmmc {
> +	bus-width = <4>;
> +	cap-sd-highspeed;
> +	disable-wp;
> +	pinctrl-0 = <&sdmmc0_clk &sdmmc0_cmd &sdmmc0_dectn &sdmmc0_bus4>;
> +	pinctrl-names = "default";
> +	vmmc-supply = <&vcc_sd>;
> +	status = "okay";
> +};
> +
> +&spdif {
> +	pinctrl-0 = <&spdifm0_tx>;
> +	pinctrl-names = "default";
> +	status = "okay";
> +};
> +
> +&soc_crit {
> +	temperature = <115000>; /* millicelsius */
> +};
> +
> +&target {
> +	temperature = <105000>; /* millicelsius */
> +};
> +
> +&threshold {
> +	temperature = <90000>; /* millicelsius */
> +};
> +
> +&tsadc {
> +	rockchip,hw-tshut-temp = <120000>;
> +	status = "okay";
> +};
> +
> +&u2phy {
> +	status = "okay";
> +
> +	u2phy_host: host-port {

Just refer to the ports normally by label rather than duplicate a random 
snippet of DTSI hierarchy - I'm not sure why this particular pattern 
seems to get copied around so much.

Robin.

> +		status = "okay";
> +	};
> +
> +	u2phy_otg: otg-port {
> +		phy-supply = <&vcc_otg_vbus>;
> +		status = "okay";
> +	};
> +};
> +
> +&uart0 {
> +	pinctrl-0 = <&uart0_xfer &uart0_cts>;
> +	pinctrl-names = "default";
> +	status = "okay";
> +};
> +
> +&uart2 {
> +	status = "okay";
> +};
> +
> +&usb20_otg {
> +	dr_mode = "host";
> +	status = "okay";
> +};
> +
> +&usb_host0_ehci {
> +	status = "okay";
> +};
> +
> +&usb_host0_ohci {
> +	status = "okay";
> +};
> +
> +&vop {
> +	status = "okay";
> +};
> +
> +&vop_mmu {
> +	status = "okay";
> +};
> 
