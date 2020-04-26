Return-Path: <SRS0=PEot=6K=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D9B48C54FCB
	for <linux-kernel@archiver.kernel.org>; Sun, 26 Apr 2020 13:20:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A0F9E206DD
	for <linux-kernel@archiver.kernel.org>; Sun, 26 Apr 2020 13:20:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hTZDt+UO"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726171AbgDZNUd (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 26 Apr 2020 09:20:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54528 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726135AbgDZNUd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 26 Apr 2020 09:20:33 -0400
Received: from mail-lj1-x243.google.com (mail-lj1-x243.google.com [IPv6:2a00:1450:4864:20::243])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AA934C061A0F
        for <linux-kernel@vger.kernel.org>; Sun, 26 Apr 2020 06:20:32 -0700 (PDT)
Received: by mail-lj1-x243.google.com with SMTP id l19so14673972lje.10
        for <linux-kernel@vger.kernel.org>; Sun, 26 Apr 2020 06:20:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=j7Fii5jk1y1j//YzZmaIqRKVJwElKDW7GmCxBplBXjs=;
        b=hTZDt+UOzrWi1wzESnHDV3BAiyN75y1SuJClUMmbNi871mBi04kjZi17iDpHKziO6q
         VbGxO3ik4e1yDsW2RhIbMoYBc019BRKmSA/HpSaQTVLk1Xb+nFRfIPGpwSW50HA0By97
         G8Ish2CFvazLPJlCgzUGwDySrLXjl9//sgfSrKIISR1/cG746BsseoFHkrcMRG7qsUov
         LGbZXFjk85P30UvkQljeo5/cAQFsSxBoBb0n3sP+Shv+HpoxMuLhgyLzSOba5J+wlceq
         ExKALFMhuFW87C2p4Nx2NoShjqA1NzcSE1RZR+3icg68xUKjHX4SOadWYwcn7tfQLrjh
         wyqw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=j7Fii5jk1y1j//YzZmaIqRKVJwElKDW7GmCxBplBXjs=;
        b=N1tICpx5eqjhZfgL01hjn5nvF0XlM4UMt7ZBmcgSZcsrjn0+Vfncn+Rij3cQ+/u2Nd
         We+xAws3PnCHPR5/2cYy4zgZ3pHEZF+D+fSccPUY/OvkH9nxg+PH9eWUnis1LwYBfj8S
         X3wLjZza4Nn9Sib56tkaDXL9n/m82bSo4TSj6PgDDl/N9JJXzWKSfYbf/kplJBs0Judo
         JX8LOTqDP+Yy+oeoLECSpCy6XERnx8eFimLSt13/4Knd+phRExy8AtQ80H3VOUeq2znV
         HjQasGkTVJHV26wQRngN6i1HXPo+gfh5FJpzyVM7v2I4v9F3riMfldtkXHTjShwSJ276
         CqDg==
X-Gm-Message-State: AGi0PubOGrPSlqlddtaBJZvyshNis/ahn89gbOUcLgMFmoTrAJqic9yv
        xQmhmIzXXgvFcvm4OMrUUPw=
X-Google-Smtp-Source: APiQypLmJ4SrLcpU+sAQvZTBaTaKgwBpOQRz7Aruo92D9Pf7jqd3qHk8EmpDHC1ByT7ACaDal1dAog==
X-Received: by 2002:a2e:b88b:: with SMTP id r11mr11425396ljp.116.1587907230807;
        Sun, 26 Apr 2020 06:20:30 -0700 (PDT)
Received: from [172.16.20.20] ([87.200.95.144])
        by smtp.gmail.com with ESMTPSA id s30sm9050396lfc.93.2020.04.26.06.20.28
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 26 Apr 2020 06:20:30 -0700 (PDT)
Content-Type: text/plain;
        charset=utf-8
Mime-Version: 1.0 (Mac OS X Mail 12.4 \(3445.104.14\))
Subject: Re: [PATCH 2/2] arm64: dts: meson-sm1: add support for Hardkernel
 ODROID-C4
From:   Christian Hewitt <christianshewitt@gmail.com>
In-Reply-To: <20200424124406.13870-3-narmstrong@baylibre.com>
Date:   Sun, 26 Apr 2020 17:20:26 +0400
Cc:     khilman@baylibre.com, Dongjin Kim <tobetter@gmail.com>,
        linux-amlogic@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org
Content-Transfer-Encoding: quoted-printable
Message-Id: <622EC76B-9D98-4AA5-B91E-CBEE98DC12FE@gmail.com>
References: <20200424124406.13870-1-narmstrong@baylibre.com>
 <20200424124406.13870-3-narmstrong@baylibre.com>
To:     Neil Armstrong <narmstrong@baylibre.com>
X-Mailer: Apple Mail (2.3445.104.14)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


> On 24 Apr 2020, at 4:44 pm, Neil Armstrong <narmstrong@baylibre.com> =
wrote:
>=20
> From: Dongjin Kim <tobetter@gmail.com>
>=20
> Add the board support for the Hardkernel Odroid-C4 single board =
computer.
>=20
> The Odroid-C4 is the Odroid-C2 successor with same form factor, but =
using
> a modern Amlogic S905X3 (SM1) SoC and 4x USB3 ports.
>=20
> Signed-off-by: Dongjin Kim <tobetter@gmail.com>
> Signed-off-by: Neil Armstrong <narmstrong@baylibre.com>
> ---
> arch/arm64/boot/dts/amlogic/Makefile          |   1 +
> .../boot/dts/amlogic/meson-sm1-odroid-c4.dts  | 399 ++++++++++++++++++
> 2 files changed, 400 insertions(+)
> create mode 100644 arch/arm64/boot/dts/amlogic/meson-sm1-odroid-c4.dts
>=20
> diff --git a/arch/arm64/boot/dts/amlogic/Makefile =
b/arch/arm64/boot/dts/amlogic/Makefile
> index eef0045320f2..5daab72f5639 100644
> --- a/arch/arm64/boot/dts/amlogic/Makefile
> +++ b/arch/arm64/boot/dts/amlogic/Makefile
> @@ -40,4 +40,5 @@ dtb-$(CONFIG_ARCH_MESON) +=3D =
meson-gxm-s912-libretech-pc.dtb
> dtb-$(CONFIG_ARCH_MESON) +=3D meson-gxm-vega-s96.dtb
> dtb-$(CONFIG_ARCH_MESON) +=3D meson-sm1-sei610.dtb
> dtb-$(CONFIG_ARCH_MESON) +=3D meson-sm1-khadas-vim3l.dtb
> +dtb-$(CONFIG_ARCH_MESON) +=3D meson-sm1-odroid-c4.dtb
> dtb-$(CONFIG_ARCH_MESON) +=3D meson-a1-ad401.dtb
> diff --git a/arch/arm64/boot/dts/amlogic/meson-sm1-odroid-c4.dts =
b/arch/arm64/boot/dts/amlogic/meson-sm1-odroid-c4.dts
> new file mode 100644
> index 000000000000..4882c604a7e0
> --- /dev/null
> +++ b/arch/arm64/boot/dts/amlogic/meson-sm1-odroid-c4.dts
> @@ -0,0 +1,399 @@
> +// SPDX-License-Identifier: (GPL-2.0+ OR MIT)
> +/*
> + * Copyright (c) 2020 Dongjin Kim <tobetter@gmail.com>
> + */
> +
> +/dts-v1/;
> +
> +#include "meson-sm1.dtsi"
> +#include <dt-bindings/gpio/meson-g12a-gpio.h>
> +#include <dt-bindings/leds/common.h>
> +
> +/ {
> +	compatible =3D "hardkernel,odroid-c4", "amlogic,sm1";
> +	model =3D "Hardkernel ODROID-C4";
> +
> +	aliases {
> +		serial0 =3D &uart_AO;
> +		ethernet0 =3D &ethmac;
> +	};
> +
> +	chosen {
> +		stdout-path =3D "serial0:115200n8";
> +	};
> +
> +	memory@0 {
> +		device_type =3D "memory";
> +		reg =3D <0x0 0x0 0x0 0x40000000>;
> +	};
> +
> +	emmc_pwrseq: emmc-pwrseq {
> +		compatible =3D "mmc-pwrseq-emmc";
> +		reset-gpios =3D <&gpio BOOT_12 GPIO_ACTIVE_LOW>;
> +	};
> +
> +	leds {
> +		compatible =3D "gpio-leds";
> +
> +		led-blue {
> +			color =3D <LED_COLOR_ID_BLUE>;
> +			function =3D LED_FUNCTION_STATUS;
> +			gpios =3D <&gpio_ao GPIOAO_11 GPIO_ACTIVE_HIGH>;
> +			linux,default-trigger =3D "heartbeat";
> +			panic-indicator;
> +		};
> +	};
> +
> +	tflash_vdd: regulator-tflash_vdd {
> +		compatible =3D "regulator-fixed";
> +
> +		regulator-name =3D "TFLASH_VDD";
> +		regulator-min-microvolt =3D <3300000>;
> +		regulator-max-microvolt =3D <3300000>;
> +
> +		gpio =3D <&gpio_ao GPIOAO_3 GPIO_ACTIVE_HIGH>;
> +		enable-active-high;
> +		regulator-always-on;
> +	};
> +
> +	tf_io: gpio-regulator-tf_io {
> +		compatible =3D "regulator-gpio";
> +
> +		regulator-name =3D "TF_IO";
> +		regulator-min-microvolt =3D <1800000>;
> +		regulator-max-microvolt =3D <3300000>;
> +
> +		gpios =3D <&gpio_ao GPIOAO_6 GPIO_ACTIVE_HIGH>;
> +		gpios-states =3D <0>;
> +
> +		states =3D <3300000 0>,
> +			 <1800000 1>;
> +	};
> +
> +	flash_1v8: regulator-flash_1v8 {
> +		compatible =3D "regulator-fixed";
> +		regulator-name =3D "FLASH_1V8";
> +		regulator-min-microvolt =3D <1800000>;
> +		regulator-max-microvolt =3D <1800000>;
> +		vin-supply =3D <&vcc_3v3>;
> +		regulator-always-on;
> +	};
> +
> +	main_12v: regulator-main_12v {
> +		compatible =3D "regulator-fixed";
> +		regulator-name =3D "12V";
> +		regulator-min-microvolt =3D <12000000>;
> +		regulator-max-microvolt =3D <12000000>;
> +		regulator-always-on;
> +	};
> +
> +	vcc_5v: regulator-vcc_5v {
> +		compatible =3D "regulator-fixed";
> +		regulator-name =3D "5V";
> +		regulator-min-microvolt =3D <5000000>;
> +		regulator-max-microvolt =3D <5000000>;
> +		regulator-always-on;
> +		vin-supply =3D <&main_12v>;
> +	};
> +
> +	vcc_1v8: regulator-vcc_1v8 {
> +		compatible =3D "regulator-fixed";
> +		regulator-name =3D "VCC_1V8";
> +		regulator-min-microvolt =3D <1800000>;
> +		regulator-max-microvolt =3D <1800000>;
> +		vin-supply =3D <&vcc_3v3>;
> +		regulator-always-on;
> +	};
> +
> +	vcc_3v3: regulator-vcc_3v3 {
> +		compatible =3D "regulator-fixed";
> +		regulator-name =3D "VCC_3V3";
> +		regulator-min-microvolt =3D <3300000>;
> +		regulator-max-microvolt =3D <3300000>;
> +		vin-supply =3D <&vddao_3v3>;
> +		regulator-always-on;
> +		/* FIXME: actually controlled by VDDCPU_B_EN */
> +	};
> +
> +	vddcpu: regulator-vddcpu {
> +		/*
> +		 * MP8756GD Regulator.
> +		 */
> +		compatible =3D "pwm-regulator";
> +
> +		regulator-name =3D "VDDCPU";
> +		regulator-min-microvolt =3D <721000>;
> +		regulator-max-microvolt =3D <1022000>;
> +
> +		vin-supply =3D <&main_12v>;
> +
> +		pwms =3D <&pwm_AO_cd 1 1250 0>;
> +		pwm-dutycycle-range =3D <100 0>;
> +
> +		regulator-boot-on;
> +		regulator-always-on;
> +	};
> +
> +	hub_5v: regulator-hub_5v {
> +		compatible =3D "regulator-fixed";
> +		regulator-name =3D "HUB_5V";
> +		regulator-min-microvolt =3D <5000000>;
> +		regulator-max-microvolt =3D <5000000>;
> +		vin-supply =3D <&vcc_5v>;
> +
> +		/* Connected to the Hub CHIPENABLE, LOW sets low power =
state */
> +		gpio =3D <&gpio GPIOH_4 GPIO_ACTIVE_HIGH>;
> +		enable-active-high;
> +	};
> +
> +	usb_pwr_en: regulator-usb_pwr_en {
> +		compatible =3D "regulator-fixed";
> +		regulator-name =3D "USB_PWR_EN";
> +		regulator-min-microvolt =3D <5000000>;
> +		regulator-max-microvolt =3D <5000000>;
> +		vin-supply =3D <&vcc_5v>;
> +
> +		/* Connected to the microUSB port power enable */
> +		gpio =3D <&gpio_ao GPIOAO_2 GPIO_ACTIVE_HIGH>;
> +		enable-active-high;
> +	};
> +
> +	vddao_1v8: regulator-vddao_1v8 {
> +		compatible =3D "regulator-fixed";
> +		regulator-name =3D "VDDAO_1V8";
> +		regulator-min-microvolt =3D <1800000>;
> +		regulator-max-microvolt =3D <1800000>;
> +		vin-supply =3D <&vddao_3v3>;
> +		regulator-always-on;
> +	};
> +
> +	vddao_3v3: regulator-vddao_3v3 {
> +		compatible =3D "regulator-fixed";
> +		regulator-name =3D "VDDAO_3V3";
> +		regulator-min-microvolt =3D <3300000>;
> +		regulator-max-microvolt =3D <3300000>;
> +		vin-supply =3D <&main_12v>;
> +		regulator-always-on;
> +	};
> +
> +	hdmi-connector {
> +		compatible =3D "hdmi-connector";
> +		type =3D "a";
> +
> +		port {
> +			hdmi_connector_in: endpoint {
> +				remote-endpoint =3D <&hdmi_tx_tmds_out>;
> +			};
> +		};
> +	};
> +};
> +
> +&cpu0 {
> +	cpu-supply =3D <&vddcpu>;
> +	operating-points-v2 =3D <&cpu_opp_table>;
> +	clocks =3D <&clkc CLKID_CPU_CLK>;
> +	clock-latency =3D <50000>;
> +};
> +
> +&cpu1 {
> +	cpu-supply =3D <&vddcpu>;
> +	operating-points-v2 =3D <&cpu_opp_table>;
> +	clocks =3D <&clkc CLKID_CPU1_CLK>;
> +	clock-latency =3D <50000>;
> +};
> +
> +&cpu2 {
> +	cpu-supply =3D <&vddcpu>;
> +	operating-points-v2 =3D <&cpu_opp_table>;
> +	clocks =3D <&clkc CLKID_CPU2_CLK>;
> +	clock-latency =3D <50000>;
> +};
> +
> +&cpu3 {
> +	cpu-supply =3D <&vddcpu>;
> +	operating-points-v2 =3D <&cpu_opp_table>;
> +	clocks =3D <&clkc CLKID_CPU3_CLK>;
> +	clock-latency =3D <50000>;
> +};
> +
> +&ext_mdio {
> +	external_phy: ethernet-phy@0 {
> +		/* Realtek RTL8211F (0x001cc916) */
> +		reg =3D <0>;
> +		max-speed =3D <1000>;
> +
> +		reset-assert-us =3D <10000>;
> +		reset-deassert-us =3D <30000>;
> +		reset-gpios =3D <&gpio GPIOZ_15 (GPIO_ACTIVE_LOW | =
GPIO_OPEN_DRAIN)>;
> +
> +		interrupt-parent =3D <&gpio_intc>;
> +		/* MAC_INTR on GPIOZ_14 */
> +		interrupts =3D <26 IRQ_TYPE_LEVEL_LOW>;
> +	};
> +};
> +
> +&ethmac {
> +	pinctrl-0 =3D <&eth_pins>, <&eth_rgmii_pins>;
> +	pinctrl-names =3D "default";
> +	status =3D "okay";
> +	phy-mode =3D "rgmii";
> +	phy-handle =3D <&external_phy>;
> +	amlogic,tx-delay-ns =3D <2>;
> +};
> +
> +&gpio {
> +	gpio-line-names =3D
> +		/* GPIOZ */
> +		"", "", "", "", "", "", "", "",
> +		"", "", "", "", "", "", "", "",
> +		/* GPIOH */
> +		"", "", "", "", "",
> +		"PIN_36", /* GPIOH_5 */
> +		"PIN_26", /* GPIOH_6 */
> +		"PIN_32", /* GPIOH_7 */
> +		"",
> +		/* BOOT */
> +		"", "", "", "", "", "", "", "",
> +		"", "", "", "", "", "", "", "",
> +		/* GPIOC */
> +		"", "", "", "", "", "", "", "",
> +		/* GPIOA */
> +		"", "", "", "", "", "", "", "",
> +		"", "", "", "", "", "",
> +		"PIN_27", /* GPIOA_14 */
> +		"PIN_28", /* GPIOA_15 */
> +		/* GPIOX */
> +		"PIN_16", /* GPIOX_0 */
> +		"PIN_18", /* GPIOX_1 */
> +		"PIN_22", /* GPIOX_2 */
> +		"PIN_11", /* GPIOX_3 */
> +		"PIN_13", /* GPIOX_4 */
> +		"PIN_7",  /* GPIOX_5 */
> +		"PIN_33", /* GPIOX_6 */
> +		"PIN_15", /* GPIOX_7 */
> +		"PIN_19", /* GPIOX_8 */
> +		"PIN_21", /* GPIOX_9 */
> +		"PIN_24", /* GPIOX_10 */
> +		"PIN_23", /* GPIOX_11 */
> +		"PIN_8",  /* GPIOX_12 */
> +		"PIN_10", /* GPIOX_13 */
> +		"PIN_29", /* GPIOX_14 */
> +		"PIN_31", /* GPIOX_15 */
> +		"PIN_12", /* GPIOX_16 */
> +		"PIN_3",  /* GPIOX_17 */
> +		"PIN_5",  /* GPIOX_18 */
> +		"PIN_35"; /* GPIOX_19 */
> +
> +	/*
> +	 * WARNING: The USB Hub on the Odroid-C4 needs a reset signal
> +	 * to be turned high in order to be detected by the USB =
Controller
> +	 * This signal should be handled by a USB specific power =
sequence
> +	 * in order to reset the Hub when USB bus is powered down.
> +	 */
> +	usb-hub {
> +		gpio-hog;
> +		gpios =3D <GPIOH_4 GPIO_ACTIVE_HIGH>;
> +		output-high;
> +		line-name =3D "usb-hub-reset";
> +	};
> +};
> +
> +&gpio_ao {
> +	gpio-line-names =3D
> +		/* GPIOAO */
> +		"", "", "", "",
> +		"PIN_47", /* GPIOAO_4 */
> +		"", "",
> +		"PIN_45", /* GPIOAO_7 */
> +		"PIN_46", /* GPIOAO_8 */
> +		"PIN_44", /* GPIOAO_9 */
> +		"PIN_42", /* GPIOAO_10 */
> +		"",
> +		/* GPIOE */
> +		"", "", "";
> +};
> +
> +&hdmi_tx {
> +	status =3D "okay";
> +	pinctrl-0 =3D <&hdmitx_hpd_pins>, <&hdmitx_ddc_pins>;
> +	pinctrl-names =3D "default";
> +	hdmi-supply =3D <&vcc_5v>;
> +};
> +
> +&hdmi_tx_tmds_port {
> +	hdmi_tx_tmds_out: endpoint {
> +		remote-endpoint =3D <&hdmi_connector_in>;
> +	};
> +};
> +

&ir {
	status =3D "okay";
	pinctrl-0 =3D <&remote_input_ao_pins>;
	pinctrl-names =3D "default";
	linux,rc-map-name =3D =E2=80=9Crc-odroid";
};

^ C4 is sold with the same odroid remote as C2/N2

> +&pwm_AO_cd {
> +	pinctrl-0 =3D <&pwm_ao_d_e_pins>;
> +	pinctrl-names =3D "default";
> +	clocks =3D <&xtal>;
> +	clock-names =3D "clkin1";
> +	status =3D "okay";
> +};
> +
> +&saradc {
> +	status =3D "okay";
> +};
> +
> +/* SD card */
> +&sd_emmc_b {
> +	status =3D "okay";
> +	pinctrl-0 =3D <&sdcard_c_pins>;
> +	pinctrl-1 =3D <&sdcard_clk_gate_c_pins>;
> +	pinctrl-names =3D "default", "clk-gate";
> +
> +	bus-width =3D <4>;
> +	cap-sd-highspeed;
> +	max-frequency =3D <200000000>;
> +	sd-uhs-sdr12;
> +	sd-uhs-sdr25;
> +	sd-uhs-sdr50;
> +	sd-uhs-sdr104;
> +	disable-wp;
> +
> +	cd-gpios =3D <&gpio GPIOC_6 GPIO_ACTIVE_LOW>;
> +	vmmc-supply =3D <&tflash_vdd>;
> +	vqmmc-supply =3D <&tf_io>;
> +};
> +
> +/* eMMC */
> +&sd_emmc_c {
> +	status =3D "okay";
> +	pinctrl-0 =3D <&emmc_ctrl_pins>, <&emmc_data_8b_pins>, =
<&emmc_ds_pins>;
> +	pinctrl-1 =3D <&emmc_clk_gate_pins>;
> +	pinctrl-names =3D "default", "clk-gate";
> +
> +	bus-width =3D <8>;
> +	cap-mmc-highspeed;
> +	mmc-ddr-1_8v;
> +	mmc-hs200-1_8v;
> +	max-frequency =3D <200000000>;
> +	disable-wp;
> +
> +	mmc-pwrseq =3D <&emmc_pwrseq>;
> +	vmmc-supply =3D <&vcc_3v3>;
> +	vqmmc-supply =3D <&flash_1v8>;
> +};
> +
> +&uart_AO {
> +	status =3D "okay";
> +	pinctrl-0 =3D <&uart_ao_a_pins>;
> +	pinctrl-names =3D "default";
> +};
> +
> +&usb {
> +	status =3D "okay";
> +	vbus-supply =3D <&usb_pwr_en>;
> +};
> +
> +&usb2_phy0 {
> +	phy-supply =3D <&vcc_5v>;
> +};
> +
> +&usb2_phy1 {
> +	/* Enable the hub which is connected to this port */
> +	phy-supply =3D <&hub_5v>;
> +};
> --=20
> 2.22.0

otherwise works fine (and with ir node added)

Tested-by: Christian Hewitt <christianshewitt@gmail.com>

