Return-Path: <SRS0=/Won=67=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0F5D8C433E0
	for <linux-kernel@archiver.kernel.org>; Sun, 17 May 2020 16:27:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id EA72D20671
	for <linux-kernel@archiver.kernel.org>; Sun, 17 May 2020 16:27:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728117AbgEQQ1s (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 17 May 2020 12:27:48 -0400
Received: from relay7-d.mail.gandi.net ([217.70.183.200]:51431 "EHLO
        relay7-d.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728035AbgEQQ1s (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 17 May 2020 12:27:48 -0400
X-Originating-IP: 91.175.115.186
Received: from localhost (91-175-115-186.subs.proxad.net [91.175.115.186])
        (Authenticated sender: gregory.clement@bootlin.com)
        by relay7-d.mail.gandi.net (Postfix) with ESMTPSA id E27A220006;
        Sun, 17 May 2020 16:27:44 +0000 (UTC)
From:   Gregory CLEMENT <gregory.clement@bootlin.com>
To:     Pawel Dembicki <paweldembicki@gmail.com>
Cc:     Pawel Dembicki <paweldembicki@gmail.com>,
        Andrew Lunn <andrew@lunn.ch>, Rob Herring <robh+dt@kernel.org>,
        Jason Cooper <jason@lakedaemon.net>,
        Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH v3] ARM: dts: kirkwood: Add Check Point L-50 board
In-Reply-To: <20200422150007.29119-1-paweldembicki@gmail.com>
References: <20200422150007.29119-1-paweldembicki@gmail.com>
Date:   Sun, 17 May 2020 18:27:44 +0200
Message-ID: <878shqh6gv.fsf@FE-laptop>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello Pawel,

> This patch adds dts for the Check Point L-50 from 600/1100 series
> routers.
>
> Specification:
> -CPU: Marvell Kirkwood 88F6821 1200MHz
> -RAM: 512MB
> -Flash: NAND 512MB
> -WiFi: mPCIe card based on Atheros AR9287 b/g/n
> -WAN: 1 Gigabit Port (Marvell 88E1116R PHY)
> -LAN: 9 Gigabit Ports (2x Marvell 88E6171(5+4))
> -USB: 2x USB2.0
> -Express card slot
> -SD card slot
> -Serial console: RJ-45 115200 8n1
> -Unsupported DSL
>
> Reviewed-by: Andrew Lunn <andrew@lunn.ch>
> Signed-off-by: Pawel Dembicki <paweldembicki@gmail.com>

I've missed there was a v3, so I replaced the v2 patch by this patch.

Gregory

> ---
> Changes in v3:
> - fix typo and code style issues pointed by OpenWrt guys
> Changes in v2:
> - none
>
>  arch/arm/boot/dts/Makefile          |   1 +
>  arch/arm/boot/dts/kirkwood-l-50.dts | 438 ++++++++++++++++++++++++++++
>  2 files changed, 439 insertions(+)
>  create mode 100644 arch/arm/boot/dts/kirkwood-l-50.dts
>
> diff --git a/arch/arm/boot/dts/Makefile b/arch/arm/boot/dts/Makefile
> index e8dd99201397..eba030b3ba69 100644
> --- a/arch/arm/boot/dts/Makefile
> +++ b/arch/arm/boot/dts/Makefile
> @@ -279,6 +279,7 @@ dtb-$(CONFIG_MACH_KIRKWOOD) += \
>  	kirkwood-iomega_ix2_200.dtb \
>  	kirkwood-is2.dtb \
>  	kirkwood-km_kirkwood.dtb \
> +	kirkwood-l-50.dtb \
>  	kirkwood-laplug.dtb \
>  	kirkwood-linkstation-lsqvl.dtb \
>  	kirkwood-linkstation-lsvl.dtb \
> diff --git a/arch/arm/boot/dts/kirkwood-l-50.dts b/arch/arm/boot/dts/kirkwood-l-50.dts
> new file mode 100644
> index 000000000000..0d81c43a6a73
> --- /dev/null
> +++ b/arch/arm/boot/dts/kirkwood-l-50.dts
> @@ -0,0 +1,438 @@
> +// SPDX-License-Identifier: GPL-2.0
> +/*
> + * Check Point L-50 Board Description
> + * Copyright 2020 Pawel Dembicki <paweldembicki@gmail.com>
> + */
> +
> +/dts-v1/;
> +
> +#include "kirkwood.dtsi"
> +#include "kirkwood-6281.dtsi"
> +
> +/ {
> +	model = "Check Point L-50";
> +	compatible = "checkpoint,l-50", "marvell,kirkwood-88f6281", "marvell,kirkwood";
> +
> +	memory {
> +		device_type = "memory";
> +		reg = <0x00000000 0x20000000>;
> +	};
> +
> +	chosen {
> +		bootargs = "console=ttyS0,115200n8";
> +		stdout-path = &uart0;
> +	};
> +
> +	ocp@f1000000 {
> +		pinctrl: pin-controller@10000 {
> +			pinctrl-0 = <&pmx_led38 &pmx_sysrst &pmx_button29>;
> +			pinctrl-names = "default";
> +
> +			pmx_sysrst: pmx-sysrst {
> +				marvell,pins = "mpp6";
> +				marvell,function = "sysrst";
> +			};
> +
> +			pmx_button29: pmx_button29 {
> +				marvell,pins = "mpp29";
> +				marvell,function = "gpio";
> +			};
> +
> +			pmx_led38: pmx_led38 {
> +				marvell,pins = "mpp38";
> +				marvell,function = "gpio";
> +			};
> +
> +			pmx_sdio_cd: pmx-sdio-cd {
> +				marvell,pins = "mpp46";
> +				marvell,function = "gpio";
> +			};
> +		};
> +
> +		serial@12000 {
> +			status = "okay";
> +		};
> +
> +		mvsdio@90000 {
> +			status = "okay";
> +			cd-gpios = <&gpio1 14 9>;
> +		};
> +
> +		i2c@11000 {
> +			status = "okay";
> +			clock-frequency = <400000>;
> +
> +			gpio2: gpio-expander@20{
> +				#gpio-cells = <2>;
> +				#interrupt-cells = <2>;
> +				compatible = "semtech,sx1505q";
> +				reg = <0x20>;
> +
> +				gpio-controller;
> +			};
> +
> +			/* Three GPIOs from 0x21 exp. are undescribed in dts:
> +			 * 1: DSL module reset (active low)
> +			 * 5: mPCIE reset (active low)
> +			 * 6: Express card reset (active low)
> +			 */
> +			gpio3: gpio-expander@21{
> +				#gpio-cells = <2>;
> +				#interrupt-cells = <2>;
> +				compatible = "semtech,sx1505q";
> +				reg = <0x21>;
> +
> +				gpio-controller;
> +			};
> +
> +			rtc@30 {
> +				compatible = "s35390a";
> +				reg = <0x30>;
> +			};
> +		};
> +	};
> +
> +	leds {
> +		compatible = "gpio-leds";
> +
> +		status_green {
> +			label = "l-50:green:status";
> +			gpios = <&gpio1 6 GPIO_ACTIVE_LOW>;
> +		};
> +
> +		status_red {
> +			label = "l-50:red:status";
> +			gpios = <&gpio3 2 GPIO_ACTIVE_LOW>;
> +		};
> +
> +		wifi {
> +			label = "l-50:green:wifi";
> +			gpios = <&gpio2 7 GPIO_ACTIVE_LOW>;
> +			linux,default-trigger = "phy0tpt";
> +		};
> +
> +		internet_green {
> +			label = "l-50:green:internet";
> +			gpios = <&gpio2 3 GPIO_ACTIVE_LOW>;
> +		};
> +
> +		internet_red {
> +			label = "l-50:red:internet";
> +			gpios = <&gpio2 1 GPIO_ACTIVE_LOW>;
> +		};
> +
> +		usb1_green {
> +			label = "l-50:green:usb1";
> +			gpios = <&gpio2 0 GPIO_ACTIVE_LOW>;
> +			linux,default-trigger = "usbport";
> +			trigger-sources = <&hub_port3>;
> +		};
> +
> +		usb1_red {
> +			label = "l-50:red:usb1";
> +			gpios = <&gpio2 4 GPIO_ACTIVE_LOW>;
> +		};
> +
> +		usb2_green {
> +			label = "l-50:green:usb2";
> +			gpios = <&gpio2 2 GPIO_ACTIVE_LOW>;
> +			linux,default-trigger = "usbport";
> +			trigger-sources = <&hub_port1>;
> +		};
> +
> +		usb2_red {
> +			label = "l-50:red:usb2";
> +			gpios = <&gpio2 5 GPIO_ACTIVE_LOW>;
> +		};
> +	};
> +
> +	usb2_pwr {
> +		compatible = "regulator-fixed";
> +		regulator-name = "usb2_pwr";
> +
> +		regulator-min-microvolt = <5000000>;
> +		regulator-max-microvolt = <5000000>;
> +		gpio = <&gpio3 3 GPIO_ACTIVE_LOW>;
> +		regulator-always-on;
> +	};
> +
> +	usb1_pwr {
> +		compatible = "regulator-fixed";
> +		regulator-name = "usb1_pwr";
> +
> +		regulator-min-microvolt = <5000000>;
> +		regulator-max-microvolt = <5000000>;
> +		gpio = <&gpio3 4 GPIO_ACTIVE_LOW>;
> +		regulator-always-on;
> +	};
> +
> +	mpcie_pwr {
> +		compatible = "regulator-fixed";
> +		regulator-name = "mpcie_pwr";
> +
> +		regulator-min-microvolt = <3300000>;
> +		regulator-max-microvolt = <3300000>;
> +		gpio = <&gpio3 5 GPIO_ACTIVE_HIGH>;
> +		enable-active-high;
> +		regulator-always-on;
> +	};
> +
> +	express_card_pwr {
> +		compatible = "regulator-fixed";
> +		regulator-name = "express_card_pwr";
> +
> +		regulator-min-microvolt = <3300000>;
> +		regulator-max-microvolt = <3300000>;
> +		gpio = <&gpio3 7 GPIO_ACTIVE_HIGH>;
> +		enable-active-high;
> +		regulator-always-on;
> +	};
> +
> +	keys {
> +		compatible = "gpio-keys";
> +
> +		factory_defaults {
> +			label = "factory_defaults";
> +			gpios = <&gpio0 29 GPIO_ACTIVE_LOW>;
> +			linux,code = <KEY_RESTART>;
> +		};
> +	};
> +};
> +
> +&mdio {
> +	status = "okay";
> +
> +	ethphy8: ethernet-phy@8 {
> +		reg = <0x08>;
> +	};
> +
> +	switch0: switch@10 {
> +		compatible = "marvell,mv88e6085";
> +		#address-cells = <1>;
> +		#size-cells = <0>;
> +		reg = <0x10>;
> +		dsa,member = <0 0>;
> +
> +		ports {
> +			#address-cells = <1>;
> +			#size-cells = <0>;
> +
> +			port@0 {
> +				reg = <0>;
> +				label = "lan5";
> +			};
> +
> +			port@1 {
> +			       reg = <1>;
> +			       label = "lan1";
> +			};
> +
> +			port@2 {
> +			       reg = <2>;
> +			       label = "lan6";
> +			};
> +
> +			port@3 {
> +			       reg = <3>;
> +			       label = "lan2";
> +			};
> +
> +			port@4 {
> +				reg = <4>;
> +				label = "lan7";
> +			};
> +
> +			switch0port5: port@5 {
> +				reg = <5>;
> +				phy-mode = "rgmii-txid";
> +				link = <&switch1port5>;
> +				fixed-link {
> +					speed = <1000>;
> +					full-duplex;
> +				};
> +			};
> +
> +			port@6 {
> +				reg = <6>;
> +				label = "cpu";
> +				phy-mode = "rgmii-id";
> +				ethernet = <&eth1port>;
> +				fixed-link {
> +					speed = <1000>;
> +					full-duplex;
> +				};
> +			};
> +		};
> +	};
> +
> +	switch@11 {
> +		compatible = "marvell,mv88e6085";
> +		#address-cells = <1>;
> +		#size-cells = <0>;
> +		reg = <0x11>;
> +		dsa,member = <0 1>;
> +
> +		ports {
> +			#address-cells = <1>;
> +			#size-cells = <0>;
> +
> +			port@0 {
> +				reg = <0>;
> +				label = "lan3";
> +			};
> +
> +			port@1 {
> +			       reg = <1>;
> +			       label = "lan8";
> +			};
> +
> +			port@2 {
> +			       reg = <2>;
> +			       label = "lan4";
> +			};
> +
> +			port@3 {
> +			       reg = <3>;
> +			       label = "dmz";
> +			};
> +
> +			switch1port5: port@5 {
> +				reg = <5>;
> +				phy-mode = "rgmii-txid";
> +				link = <&switch0port5>;
> +				fixed-link {
> +					speed = <1000>;
> +					full-duplex;
> +				};
> +			};
> +
> +			port@6 {
> +				reg = <6>;
> +				label = "dsl";
> +				fixed-link {
> +					speed = <100>;
> +					full-duplex;
> +				};
> +			};
> +		};
> +	};
> +};
> +
> +&eth0 {
> +	status = "okay";
> +	ethernet0-port@0 {
> +		phy-handle = <&ethphy8>;
> +	};
> +};
> +
> +&eth1 {
> +	status = "okay";
> +	ethernet1-port@0 {
> +		speed = <1000>;
> +		duplex = <1>;
> +	};
> +};
> +
> +&nand {
> +	status = "okay";
> +	pinctrl-0 = <&pmx_nand>;
> +	pinctrl-names = "default";
> +
> +	partition@0 {
> +		label = "u-boot";
> +		reg = <0x00000000 0x000c0000>;
> +	};
> +
> +	partition@a0000 {
> +		label = "bootldr-env";
> +		reg = <0x000c0000 0x00040000>;
> +	};
> +
> +	partition@100000 {
> +		label = "kernel-1";
> +		reg = <0x00100000 0x00800000>;
> +	};
> +
> +	partition@900000 {
> +		label = "rootfs-1";
> +		reg = <0x00900000 0x07100000>;
> +	};
> +
> +	partition@7a00000 {
> +		label = "kernel-2";
> +		reg = <0x07a00000 0x00800000>;
> +	};
> +
> +	partition@8200000 {
> +		label = "rootfs-2";
> +		reg = <0x08200000 0x07100000>;
> +	};
> +
> +	partition@f300000 {
> +		label = "default_sw";
> +		reg = <0x0f300000 0x07900000>;
> +	};
> +
> +	partition@16c00000 {
> +		label = "logs";
> +		reg = <0x16c00000 0x01800000>;
> +	};
> +
> +	partition@18400000 {
> +		label = "preset_cfg";
> +		reg = <0x18400000 0x00100000>;
> +	};
> +
> +	partition@18500000 {
> +		label = "adsl";
> +		reg = <0x18500000 0x00100000>;
> +	};
> +
> +	partition@18600000 {
> +		label = "storage";
> +		reg = <0x18600000 0x07a00000>;
> +	};
> +};
> +
> +&rtc {
> +	status = "disabled";
> +};
> +
> +&pciec {
> +	status = "okay";
> +};
> +
> +&pcie0 {
> +	status = "okay";
> +};
> +
> +&sata_phy0 {
> +	status = "disabled";
> +};
> +
> +&sata_phy1 {
> +	status = "disabled";
> +};
> +
> +&usb0 {
> +	#address-cells = <1>;
> +	#size-cells = <0>;
> +	status = "okay";
> +
> +	port@1 {
> +		#address-cells = <1>;
> +		#size-cells = <0>;
> +		reg = <1>;
> +		#trigger-source-cells = <0>;
> +
> +		hub_port1: port@1 {
> +			reg = <1>;
> +			#trigger-source-cells = <0>;
> +		};
> +
> +		hub_port3: port@3 {
> +			reg = <3>;
> +			#trigger-source-cells = <0>;
> +		};
> +	};
> +};
> --
> 2.20.1
>

-- 
Gregory Clement, Bootlin
Embedded Linux and Kernel engineering
http://bootlin.com
