Return-Path: <SRS0=jpuI=BA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.5 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	NICE_REPLY_A,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 019C4C433EB
	for <linux-kernel@archiver.kernel.org>; Tue, 21 Jul 2020 08:06:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C7F282080D
	for <linux-kernel@archiver.kernel.org>; Tue, 21 Jul 2020 08:06:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20150623.gappssmtp.com header.i=@baylibre-com.20150623.gappssmtp.com header.b="ylDCuhMQ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728755AbgGUIGb (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 21 Jul 2020 04:06:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51438 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727086AbgGUIG3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Jul 2020 04:06:29 -0400
Received: from mail-wm1-x343.google.com (mail-wm1-x343.google.com [IPv6:2a00:1450:4864:20::343])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 656A4C0619D7
        for <linux-kernel@vger.kernel.org>; Tue, 21 Jul 2020 01:06:29 -0700 (PDT)
Received: by mail-wm1-x343.google.com with SMTP id 184so1943962wmb.0
        for <linux-kernel@vger.kernel.org>; Tue, 21 Jul 2020 01:06:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:autocrypt:organization:message-id
         :date:user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=lBZXJ1NkCT9hSNITFGevem19yQGrpjevufwWgOoM5yE=;
        b=ylDCuhMQ0LRO/jhERrFIGEyms5LynQqwmRo5OcmdVCATrwSsvs+27T8SzacA1aLo8T
         Iaql7P5LXqtkTi1PaBOwc1Y+2qk/9sdpmhnlt2DJVwKbRgpRGkIn17GgtTkuuIYW4p13
         9o9+kwzbZ1nnBsQGZvXicOY5wxvGUB/ZG1epw/4BxhH+k4lg/SXOrUNEe0ftkBHt1Gfq
         XHucWVKa7+Wdxu69/IqrEmUT9ud7iodZOPbgnaoQXGi2qkiee6RjFhRKwJ/pTr903WCo
         oC0WhcVu7VSqOMWtde1G03DjXtxLrOz1LftdBYD1LJdQJ4hFTHJkj6zYhOE66Xxc1d0z
         na5g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:autocrypt
         :organization:message-id:date:user-agent:mime-version:in-reply-to
         :content-language:content-transfer-encoding;
        bh=lBZXJ1NkCT9hSNITFGevem19yQGrpjevufwWgOoM5yE=;
        b=ZM+0l1Yqsn7a//06u6tIKE0Z6atQ/Ca6zNFtbt2xcHypKqPxI8l7LTADtUN+2YPxNH
         qOW6BEnixBh7hA7CrrRfTIF/sgK91rKQKDOYcV0jgPxV4EZeBoAvyu4RNDw2IE3Z0KPE
         pOk0TK5lXbKjN0HmloISeYO05yJ2RflKKCo+TMkaplu39stTwDnyGkL5bsX2WCsiLw++
         BxZjHRJX6Ys0H3hpeqL2NKDhSl8lQSDVWy0k/iJPP7nsV5YpJAqDjMlWAO8Da/fsi1O3
         ade9dZG+1i8gCiyfOnJ9A80Gkmssl5//qvLz07NOK7dSoAg6HFlk1o+bqj3cOsIzxwY9
         D7fg==
X-Gm-Message-State: AOAM532FFkTKofE6tOxOB9xnmjqb7x/8MWIG7ZFmr4EEviUjHCbZblht
        PYOo3qXspSdFO2HVAtmYzPbOug==
X-Google-Smtp-Source: ABdhPJyy+VZ9FVkQTfNuh0YKjAW9VJFVko9f9YZWDYH5w6+nEj6hNQvXefG4yPC9lUBDkLJZigu0TQ==
X-Received: by 2002:a1c:6384:: with SMTP id x126mr3029764wmb.144.1595318787685;
        Tue, 21 Jul 2020 01:06:27 -0700 (PDT)
Received: from [10.1.2.12] (laubervilliers-658-1-213-31.w90-63.abo.wanadoo.fr. [90.63.244.31])
        by smtp.gmail.com with ESMTPSA id i67sm2530721wma.12.2020.07.21.01.06.26
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 21 Jul 2020 01:06:26 -0700 (PDT)
Subject: Re: [PATCH 1/3] arm64: dts: meson: convert ODROID-N2 to dtsi
To:     Christian Hewitt <christianshewitt@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Kevin Hilman <khilman@baylibre.com>,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-amlogic@lists.infradead.org, linux-kernel@vger.kernel.org
Cc:     Dongjin Kim <tobetter@hardkernel.com>
References: <20200719141034.8403-1-christianshewitt@gmail.com>
 <20200719141034.8403-2-christianshewitt@gmail.com>
From:   Neil Armstrong <narmstrong@baylibre.com>
Autocrypt: addr=narmstrong@baylibre.com; prefer-encrypt=mutual; keydata=
 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
 BSwxi7g3Mu7u5kUByanqHyA=
Organization: Baylibre
Message-ID: <0e035458-ae9b-9597-ed55-9498b0faafe3@baylibre.com>
Date:   Tue, 21 Jul 2020 10:06:26 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20200719141034.8403-2-christianshewitt@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 19/07/2020 16:10, Christian Hewitt wrote:
> Convert the current ODROID-N2 dts into a common dtsi in preparation
> for adding ODROID-N2+ support.
> 
> Signed-off-by: Christian Hewitt <christianshewitt@gmail.com>
> ---
>  .../boot/dts/amlogic/meson-g12b-odroid-n2.dts | 493 +----------------
>  .../dts/amlogic/meson-g12b-odroid-n2.dtsi     | 500 ++++++++++++++++++
>  2 files changed, 501 insertions(+), 492 deletions(-)
>  create mode 100644 arch/arm64/boot/dts/amlogic/meson-g12b-odroid-n2.dtsi
> 
> diff --git a/arch/arm64/boot/dts/amlogic/meson-g12b-odroid-n2.dts b/arch/arm64/boot/dts/amlogic/meson-g12b-odroid-n2.dts
> index 169ea283d4ee..5fd51a87ae9b 100644
> --- a/arch/arm64/boot/dts/amlogic/meson-g12b-odroid-n2.dts
> +++ b/arch/arm64/boot/dts/amlogic/meson-g12b-odroid-n2.dts
> @@ -6,500 +6,9 @@
>  
>  /dts-v1/;
>  
> -#include "meson-g12b-s922x.dtsi"
> -#include <dt-bindings/input/input.h>
> -#include <dt-bindings/gpio/meson-g12a-gpio.h>
> -#include <dt-bindings/sound/meson-g12a-tohdmitx.h>
> +#include "meson-g12b-odroid-n2.dtsi"
>  
>  / {
>  	compatible = "hardkernel,odroid-n2", "amlogic,s922x", "amlogic,g12b";
>  	model = "Hardkernel ODROID-N2";
> -
> -	aliases {
> -		serial0 = &uart_AO;
> -		ethernet0 = &ethmac;
> -	};
> -
> -	chosen {
> -		stdout-path = "serial0:115200n8";
> -	};
> -
> -	memory@0 {
> -		device_type = "memory";
> -		reg = <0x0 0x0 0x0 0x40000000>;
> -	};
> -
> -	emmc_pwrseq: emmc-pwrseq {
> -		compatible = "mmc-pwrseq-emmc";
> -		reset-gpios = <&gpio BOOT_12 GPIO_ACTIVE_LOW>;
> -	};
> -
> -	leds {
> -		compatible = "gpio-leds";
> -
> -		blue {
> -			label = "n2:blue";
> -			gpios = <&gpio_ao GPIOAO_11 GPIO_ACTIVE_HIGH>;
> -			linux,default-trigger = "heartbeat";
> -		};
> -	};
> -
> -	tflash_vdd: regulator-tflash_vdd {
> -		compatible = "regulator-fixed";
> -
> -		regulator-name = "TFLASH_VDD";
> -		regulator-min-microvolt = <3300000>;
> -		regulator-max-microvolt = <3300000>;
> -
> -		gpio = <&gpio_ao GPIOAO_8 GPIO_ACTIVE_HIGH>;
> -		enable-active-high;
> -		regulator-always-on;
> -	};
> -
> -	tf_io: gpio-regulator-tf_io {
> -		compatible = "regulator-gpio";
> -
> -		regulator-name = "TF_IO";
> -		regulator-min-microvolt = <1800000>;
> -		regulator-max-microvolt = <3300000>;
> -
> -		gpios = <&gpio_ao GPIOAO_9 GPIO_ACTIVE_HIGH>;
> -		gpios-states = <0>;
> -
> -		states = <3300000 0>,
> -			 <1800000 1>;
> -	};
> -
> -	flash_1v8: regulator-flash_1v8 {
> -		compatible = "regulator-fixed";
> -		regulator-name = "FLASH_1V8";
> -		regulator-min-microvolt = <1800000>;
> -		regulator-max-microvolt = <1800000>;
> -		vin-supply = <&vcc_3v3>;
> -		regulator-always-on;
> -	};
> -
> -	main_12v: regulator-main_12v {
> -		compatible = "regulator-fixed";
> -		regulator-name = "12V";
> -		regulator-min-microvolt = <12000000>;
> -		regulator-max-microvolt = <12000000>;
> -		regulator-always-on;
> -	};
> -
> -	vcc_5v: regulator-vcc_5v {
> -		compatible = "regulator-fixed";
> -		regulator-name = "5V";
> -		regulator-min-microvolt = <5000000>;
> -		regulator-max-microvolt = <5000000>;
> -		regulator-always-on;
> -		vin-supply = <&main_12v>;
> -	};
> -
> -	vcc_1v8: regulator-vcc_1v8 {
> -		compatible = "regulator-fixed";
> -		regulator-name = "VCC_1V8";
> -		regulator-min-microvolt = <1800000>;
> -		regulator-max-microvolt = <1800000>;
> -		vin-supply = <&vcc_3v3>;
> -		regulator-always-on;
> -	};
> -
> -	vcc_3v3: regulator-vcc_3v3 {
> -		compatible = "regulator-fixed";
> -		regulator-name = "VCC_3V3";
> -		regulator-min-microvolt = <3300000>;
> -		regulator-max-microvolt = <3300000>;
> -		vin-supply = <&vddao_3v3>;
> -		regulator-always-on;
> -		/* FIXME: actually controlled by VDDCPU_B_EN */
> -	};
> -
> -	vddcpu_a: regulator-vddcpu-a {
> -		/*
> -		 * MP8756GD Regulator.
> -		 */
> -		compatible = "pwm-regulator";
> -
> -		regulator-name = "VDDCPU_A";
> -		regulator-min-microvolt = <721000>;
> -		regulator-max-microvolt = <1022000>;
> -
> -		vin-supply = <&main_12v>;
> -
> -		pwms = <&pwm_ab 0 1250 0>;
> -		pwm-dutycycle-range = <100 0>;
> -
> -		regulator-boot-on;
> -		regulator-always-on;
> -	};
> -
> -	vddcpu_b: regulator-vddcpu-b {
> -		/*
> -		 * Silergy SY8120B1ABC Regulator.
> -		 */
> -		compatible = "pwm-regulator";
> -
> -		regulator-name = "VDDCPU_B";
> -		regulator-min-microvolt = <721000>;
> -		regulator-max-microvolt = <1022000>;
> -
> -		vin-supply = <&main_12v>;
> -
> -		pwms = <&pwm_AO_cd 1 1250 0>;
> -		pwm-dutycycle-range = <100 0>;
> -
> -		regulator-boot-on;
> -		regulator-always-on;
> -	};
> -
> -	hub_5v: regulator-hub_5v {
> -		compatible = "regulator-fixed";
> -		regulator-name = "HUB_5V";
> -		regulator-min-microvolt = <5000000>;
> -		regulator-max-microvolt = <5000000>;
> -		vin-supply = <&vcc_5v>;
> -
> -		/* Connected to the Hub CHIPENABLE, LOW sets low power state */
> -		gpio = <&gpio GPIOH_5 GPIO_ACTIVE_HIGH>;
> -		enable-active-high;
> -	};
> -
> -	usb_pwr_en: regulator-usb_pwr_en {
> -		compatible = "regulator-fixed";
> -		regulator-name = "USB_PWR_EN";
> -		regulator-min-microvolt = <5000000>;
> -		regulator-max-microvolt = <5000000>;
> -		vin-supply = <&vcc_5v>;
> -
> -		/* Connected to the microUSB port power enable */
> -		gpio = <&gpio GPIOH_6 GPIO_ACTIVE_HIGH>;
> -		enable-active-high;
> -	};
> -
> -	vddao_1v8: regulator-vddao_1v8 {
> -		compatible = "regulator-fixed";
> -		regulator-name = "VDDAO_1V8";
> -		regulator-min-microvolt = <1800000>;
> -		regulator-max-microvolt = <1800000>;
> -		vin-supply = <&vddao_3v3>;
> -		regulator-always-on;
> -	};
> -
> -	vddao_3v3: regulator-vddao_3v3 {
> -		compatible = "regulator-fixed";
> -		regulator-name = "VDDAO_3V3";
> -		regulator-min-microvolt = <3300000>;
> -		regulator-max-microvolt = <3300000>;
> -		vin-supply = <&main_12v>;
> -		regulator-always-on;
> -	};
> -
> -	hdmi-connector {
> -		compatible = "hdmi-connector";
> -		type = "a";
> -
> -		port {
> -			hdmi_connector_in: endpoint {
> -				remote-endpoint = <&hdmi_tx_tmds_out>;
> -			};
> -		};
> -	};
> -
> -	sound {
> -		compatible = "amlogic,axg-sound-card";
> -		model = "G12B-ODROID-N2";
> -		audio-aux-devs = <&tdmout_b>;
> -		audio-routing = "TDMOUT_B IN 0", "FRDDR_A OUT 1",
> -				"TDMOUT_B IN 1", "FRDDR_B OUT 1",
> -				"TDMOUT_B IN 2", "FRDDR_C OUT 1",
> -				"TDM_B Playback", "TDMOUT_B OUT";
> -
> -		assigned-clocks = <&clkc CLKID_MPLL2>,
> -				  <&clkc CLKID_MPLL0>,
> -				  <&clkc CLKID_MPLL1>;
> -		assigned-clock-parents = <0>, <0>, <0>;
> -		assigned-clock-rates = <294912000>,
> -				       <270950400>,
> -				       <393216000>;
> -		status = "okay";
> -
> -		dai-link-0 {
> -			sound-dai = <&frddr_a>;
> -		};
> -
> -		dai-link-1 {
> -			sound-dai = <&frddr_b>;
> -		};
> -
> -		dai-link-2 {
> -			sound-dai = <&frddr_c>;
> -		};
> -
> -		/* 8ch hdmi interface */
> -		dai-link-3 {
> -			sound-dai = <&tdmif_b>;
> -			dai-format = "i2s";
> -			dai-tdm-slot-tx-mask-0 = <1 1>;
> -			dai-tdm-slot-tx-mask-1 = <1 1>;
> -			dai-tdm-slot-tx-mask-2 = <1 1>;
> -			dai-tdm-slot-tx-mask-3 = <1 1>;
> -			mclk-fs = <256>;
> -
> -			codec {
> -				sound-dai = <&tohdmitx TOHDMITX_I2S_IN_B>;
> -			};
> -		};
> -
> -		/* hdmi glue */
> -		dai-link-4 {
> -			sound-dai = <&tohdmitx TOHDMITX_I2S_OUT>;
> -
> -			codec {
> -				sound-dai = <&hdmi_tx>;
> -			};
> -		};
> -	};
> -};
> -
> -&arb {
> -	status = "okay";
> -};
> -
> -&cec_AO {
> -	pinctrl-0 = <&cec_ao_a_h_pins>;
> -	pinctrl-names = "default";
> -	status = "disabled";
> -	hdmi-phandle = <&hdmi_tx>;
> -};
> -
> -&cecb_AO {
> -	pinctrl-0 = <&cec_ao_b_h_pins>;
> -	pinctrl-names = "default";
> -	status = "okay";
> -	hdmi-phandle = <&hdmi_tx>;
> -};
> -
> -&clkc_audio {
> -	status = "okay";
> -};
> -
> -&cpu0 {
> -	cpu-supply = <&vddcpu_b>;
> -	operating-points-v2 = <&cpu_opp_table_0>;
> -	clocks = <&clkc CLKID_CPU_CLK>;
> -	clock-latency = <50000>;
> -};
> -
> -&cpu1 {
> -	cpu-supply = <&vddcpu_b>;
> -	operating-points-v2 = <&cpu_opp_table_0>;
> -	clocks = <&clkc CLKID_CPU_CLK>;
> -	clock-latency = <50000>;
> -};
> -
> -&cpu100 {
> -	cpu-supply = <&vddcpu_a>;
> -	operating-points-v2 = <&cpub_opp_table_1>;
> -	clocks = <&clkc CLKID_CPUB_CLK>;
> -	clock-latency = <50000>;
> -};
> -
> -&cpu101 {
> -	cpu-supply = <&vddcpu_a>;
> -	operating-points-v2 = <&cpub_opp_table_1>;
> -	clocks = <&clkc CLKID_CPUB_CLK>;
> -	clock-latency = <50000>;
> -};
> -
> -&cpu102 {
> -	cpu-supply = <&vddcpu_a>;
> -	operating-points-v2 = <&cpub_opp_table_1>;
> -	clocks = <&clkc CLKID_CPUB_CLK>;
> -	clock-latency = <50000>;
> -};
> -
> -&cpu103 {
> -	cpu-supply = <&vddcpu_a>;
> -	operating-points-v2 = <&cpub_opp_table_1>;
> -	clocks = <&clkc CLKID_CPUB_CLK>;
> -	clock-latency = <50000>;
> -};
> -
> -&ext_mdio {
> -	external_phy: ethernet-phy@0 {
> -		/* Realtek RTL8211F (0x001cc916) */	
> -		reg = <0>;
> -		max-speed = <1000>;
> -
> -		reset-assert-us = <10000>;
> -		reset-deassert-us = <30000>;
> -		reset-gpios = <&gpio GPIOZ_15 (GPIO_ACTIVE_LOW | GPIO_OPEN_DRAIN)>;
> -
> -		interrupt-parent = <&gpio_intc>;
> -		/* MAC_INTR on GPIOZ_14 */
> -		interrupts = <26 IRQ_TYPE_LEVEL_LOW>;
> -	};
> -};
> -
> -&ethmac {
> -	pinctrl-0 = <&eth_pins>, <&eth_rgmii_pins>;
> -	pinctrl-names = "default";
> -	status = "okay";
> -	phy-mode = "rgmii";
> -	phy-handle = <&external_phy>;
> -	amlogic,tx-delay-ns = <2>;
> -};
> -
> -&frddr_a {
> -	status = "okay";
> -};
> -
> -&frddr_b {
> -	status = "okay";
> -};
> -
> -&frddr_c {
> -	status = "okay";
> -};
> -
> -&gpio {
> -	/*
> -	 * WARNING: The USB Hub on the Odroid-N2 needs a reset signal
> -	 * to be turned high in order to be detected by the USB Controller
> -	 * This signal should be handled by a USB specific power sequence
> -	 * in order to reset the Hub when USB bus is powered down.
> -	 */
> -	usb-hub {
> -		gpio-hog;
> -		gpios = <GPIOH_4 GPIO_ACTIVE_HIGH>;
> -		output-high;
> -		line-name = "usb-hub-reset";
> -	};
> -};
> -
> -&hdmi_tx {
> -	status = "okay";
> -	pinctrl-0 = <&hdmitx_hpd_pins>, <&hdmitx_ddc_pins>;
> -	pinctrl-names = "default";
> -	hdmi-supply = <&vcc_5v>;
> -};
> -
> -&hdmi_tx_tmds_port {
> -	hdmi_tx_tmds_out: endpoint {
> -		remote-endpoint = <&hdmi_connector_in>;
> -	};
> -};
> -
> -&ir {
> -	status = "okay";
> -	pinctrl-0 = <&remote_input_ao_pins>;
> -	pinctrl-names = "default";
> -	linux,rc-map-name = "rc-odroid";
> -};
> -
> -&pwm_ab {
> -	pinctrl-0 = <&pwm_a_e_pins>;
> -	pinctrl-names = "default";
> -	clocks = <&xtal>;
> -	clock-names = "clkin0";
> -	status = "okay";
> -};
> -
> -&pwm_AO_cd {
> -	pinctrl-0 = <&pwm_ao_d_e_pins>;
> -	pinctrl-names = "default";
> -	clocks = <&xtal>;
> -	clock-names = "clkin1";
> -	status = "okay";
> -};
> -
> -/* SD card */
> -&sd_emmc_b {
> -	status = "okay";
> -	pinctrl-0 = <&sdcard_c_pins>;
> -	pinctrl-1 = <&sdcard_clk_gate_c_pins>;
> -	pinctrl-names = "default", "clk-gate";
> -
> -	bus-width = <4>;
> -	cap-sd-highspeed;
> -	max-frequency = <50000000>;
> -	disable-wp;
> -
> -	cd-gpios = <&gpio GPIOC_6 GPIO_ACTIVE_LOW>;
> -	vmmc-supply = <&tflash_vdd>;
> -	vqmmc-supply = <&tf_io>;
> -
> -};
> -
> -/* eMMC */
> -&sd_emmc_c {
> -	status = "okay";
> -	pinctrl-0 = <&emmc_ctrl_pins>, <&emmc_data_8b_pins>, <&emmc_ds_pins>;
> -	pinctrl-1 = <&emmc_clk_gate_pins>;
> -	pinctrl-names = "default", "clk-gate";
> -
> -	bus-width = <8>;
> -	cap-mmc-highspeed;
> -	mmc-ddr-1_8v;
> -	mmc-hs200-1_8v;
> -	max-frequency = <200000000>;
> -	disable-wp;
> -
> -	mmc-pwrseq = <&emmc_pwrseq>;
> -	vmmc-supply = <&vcc_3v3>;
> -	vqmmc-supply = <&flash_1v8>;
> -};
> -
> -/*
> - * EMMC_D4, EMMC_D5, EMMC_D6 and EMMC_D7 pins are shared between SPI NOR pins
> - * and eMMC Data 4 to 7 pins.
> - * Replace emmc_data_8b_pins to emmc_data_4b_pins from sd_emmc_c pinctrl-0,
> - * and change bus-width to 4 then spifc can be enabled.
> - * The SW1 slide should also be set to the correct position.
> - */
> -&spifc {
> -	status = "disabled";
> -	pinctrl-0 = <&nor_pins>;
> -	pinctrl-names = "default";
> -
> -	mx25u64: spi-flash@0 {
> -		#address-cells = <1>;
> -		#size-cells = <1>;
> -		compatible = "mxicy,mx25u6435f", "jedec,spi-nor";
> -		reg = <0>;
> -		spi-max-frequency = <104000000>;
> -	};
> -};
> -
> -&tdmif_b {
> -	status = "okay";
> -};
> -
> -&tdmout_b {
> -	status = "okay";
> -};
> -
> -&tohdmitx {
> -	status = "okay";
> -};
> -
> -&uart_AO {
> -	status = "okay";
> -	pinctrl-0 = <&uart_ao_a_pins>;
> -	pinctrl-names = "default";
> -};
> -
> -&usb {
> -	status = "okay";
> -	vbus-supply = <&usb_pwr_en>;
> -};
> -
> -&usb2_phy0 {
> -	phy-supply = <&vcc_5v>;
> -};
> -
> -&usb2_phy1 {
> -	/* Enable the hub which is connected to this port */
> -	phy-supply = <&hub_5v>;
>  };
> diff --git a/arch/arm64/boot/dts/amlogic/meson-g12b-odroid-n2.dtsi b/arch/arm64/boot/dts/amlogic/meson-g12b-odroid-n2.dtsi
> new file mode 100644
> index 000000000000..ce49973678b8
> --- /dev/null
> +++ b/arch/arm64/boot/dts/amlogic/meson-g12b-odroid-n2.dtsi
> @@ -0,0 +1,500 @@
> +// SPDX-License-Identifier: (GPL-2.0+ OR MIT)
> +/*
> + * Copyright (c) 2019 BayLibre, SAS
> + * Author: Neil Armstrong <narmstrong@baylibre.com>
> + */
> +
> +#include "meson-g12b-s922x.dtsi"
> +#include <dt-bindings/input/input.h>
> +#include <dt-bindings/gpio/meson-g12a-gpio.h>
> +#include <dt-bindings/sound/meson-g12a-tohdmitx.h>
> +
> +/ {
> +	aliases {
> +		serial0 = &uart_AO;
> +		ethernet0 = &ethmac;
> +	};
> +
> +	chosen {
> +		stdout-path = "serial0:115200n8";
> +	};
> +
> +	memory@0 {
> +		device_type = "memory";
> +		reg = <0x0 0x0 0x0 0x40000000>;
> +	};
> +
> +	emmc_pwrseq: emmc-pwrseq {
> +		compatible = "mmc-pwrseq-emmc";
> +		reset-gpios = <&gpio BOOT_12 GPIO_ACTIVE_LOW>;
> +	};
> +
> +	leds {
> +		compatible = "gpio-leds";
> +
> +		blue {
> +			label = "n2:blue";
> +			gpios = <&gpio_ao GPIOAO_11 GPIO_ACTIVE_HIGH>;
> +			linux,default-trigger = "heartbeat";
> +		};
> +	};
> +
> +	tflash_vdd: regulator-tflash_vdd {
> +		compatible = "regulator-fixed";
> +
> +		regulator-name = "TFLASH_VDD";
> +		regulator-min-microvolt = <3300000>;
> +		regulator-max-microvolt = <3300000>;
> +
> +		gpio = <&gpio_ao GPIOAO_8 GPIO_ACTIVE_HIGH>;
> +		enable-active-high;
> +		regulator-always-on;
> +	};
> +
> +	tf_io: gpio-regulator-tf_io {
> +		compatible = "regulator-gpio";
> +
> +		regulator-name = "TF_IO";
> +		regulator-min-microvolt = <1800000>;
> +		regulator-max-microvolt = <3300000>;
> +
> +		gpios = <&gpio_ao GPIOAO_9 GPIO_ACTIVE_HIGH>;
> +		gpios-states = <0>;
> +
> +		states = <3300000 0>,
> +			 <1800000 1>;
> +	};
> +
> +	flash_1v8: regulator-flash_1v8 {
> +		compatible = "regulator-fixed";
> +		regulator-name = "FLASH_1V8";
> +		regulator-min-microvolt = <1800000>;
> +		regulator-max-microvolt = <1800000>;
> +		vin-supply = <&vcc_3v3>;
> +		regulator-always-on;
> +	};
> +
> +	main_12v: regulator-main_12v {
> +		compatible = "regulator-fixed";
> +		regulator-name = "12V";
> +		regulator-min-microvolt = <12000000>;
> +		regulator-max-microvolt = <12000000>;
> +		regulator-always-on;
> +	};
> +
> +	vcc_5v: regulator-vcc_5v {
> +		compatible = "regulator-fixed";
> +		regulator-name = "5V";
> +		regulator-min-microvolt = <5000000>;
> +		regulator-max-microvolt = <5000000>;
> +		regulator-always-on;
> +		vin-supply = <&main_12v>;
> +	};
> +
> +	vcc_1v8: regulator-vcc_1v8 {
> +		compatible = "regulator-fixed";
> +		regulator-name = "VCC_1V8";
> +		regulator-min-microvolt = <1800000>;
> +		regulator-max-microvolt = <1800000>;
> +		vin-supply = <&vcc_3v3>;
> +		regulator-always-on;
> +	};
> +
> +	vcc_3v3: regulator-vcc_3v3 {
> +		compatible = "regulator-fixed";
> +		regulator-name = "VCC_3V3";
> +		regulator-min-microvolt = <3300000>;
> +		regulator-max-microvolt = <3300000>;
> +		vin-supply = <&vddao_3v3>;
> +		regulator-always-on;
> +		/* FIXME: actually controlled by VDDCPU_B_EN */
> +	};
> +
> +	vddcpu_a: regulator-vddcpu-a {
> +		/*
> +		 * MP8756GD Regulator.
> +		 */
> +		compatible = "pwm-regulator";
> +
> +		regulator-name = "VDDCPU_A";
> +		regulator-min-microvolt = <721000>;
> +		regulator-max-microvolt = <1022000>;
> +
> +		vin-supply = <&main_12v>;
> +
> +		pwms = <&pwm_ab 0 1250 0>;
> +		pwm-dutycycle-range = <100 0>;
> +
> +		regulator-boot-on;
> +		regulator-always-on;
> +	};
> +
> +	vddcpu_b: regulator-vddcpu-b {
> +		/*
> +		 * Silergy SY8120B1ABC Regulator.
> +		 */
> +		compatible = "pwm-regulator";
> +
> +		regulator-name = "VDDCPU_B";
> +		regulator-min-microvolt = <721000>;
> +		regulator-max-microvolt = <1022000>;
> +
> +		vin-supply = <&main_12v>;
> +
> +		pwms = <&pwm_AO_cd 1 1250 0>;
> +		pwm-dutycycle-range = <100 0>;
> +
> +		regulator-boot-on;
> +		regulator-always-on;
> +	};
> +
> +	hub_5v: regulator-hub_5v {
> +		compatible = "regulator-fixed";
> +		regulator-name = "HUB_5V";
> +		regulator-min-microvolt = <5000000>;
> +		regulator-max-microvolt = <5000000>;
> +		vin-supply = <&vcc_5v>;
> +
> +		/* Connected to the Hub CHIPENABLE, LOW sets low power state */
> +		gpio = <&gpio GPIOH_5 GPIO_ACTIVE_HIGH>;
> +		enable-active-high;
> +	};
> +
> +	usb_pwr_en: regulator-usb_pwr_en {
> +		compatible = "regulator-fixed";
> +		regulator-name = "USB_PWR_EN";
> +		regulator-min-microvolt = <5000000>;
> +		regulator-max-microvolt = <5000000>;
> +		vin-supply = <&vcc_5v>;
> +
> +		/* Connected to the microUSB port power enable */
> +		gpio = <&gpio GPIOH_6 GPIO_ACTIVE_HIGH>;
> +		enable-active-high;
> +	};
> +
> +	vddao_1v8: regulator-vddao_1v8 {
> +		compatible = "regulator-fixed";
> +		regulator-name = "VDDAO_1V8";
> +		regulator-min-microvolt = <1800000>;
> +		regulator-max-microvolt = <1800000>;
> +		vin-supply = <&vddao_3v3>;
> +		regulator-always-on;
> +	};
> +
> +	vddao_3v3: regulator-vddao_3v3 {
> +		compatible = "regulator-fixed";
> +		regulator-name = "VDDAO_3V3";
> +		regulator-min-microvolt = <3300000>;
> +		regulator-max-microvolt = <3300000>;
> +		vin-supply = <&main_12v>;
> +		regulator-always-on;
> +	};
> +
> +	hdmi-connector {
> +		compatible = "hdmi-connector";
> +		type = "a";
> +
> +		port {
> +			hdmi_connector_in: endpoint {
> +				remote-endpoint = <&hdmi_tx_tmds_out>;
> +			};
> +		};
> +	};
> +
> +	sound {
> +		compatible = "amlogic,axg-sound-card";
> +		model = "G12B-ODROID-N2";
> +		audio-aux-devs = <&tdmout_b>;
> +		audio-routing = "TDMOUT_B IN 0", "FRDDR_A OUT 1",
> +				"TDMOUT_B IN 1", "FRDDR_B OUT 1",
> +				"TDMOUT_B IN 2", "FRDDR_C OUT 1",
> +				"TDM_B Playback", "TDMOUT_B OUT";
> +
> +		assigned-clocks = <&clkc CLKID_MPLL2>,
> +				  <&clkc CLKID_MPLL0>,
> +				  <&clkc CLKID_MPLL1>;
> +		assigned-clock-parents = <0>, <0>, <0>;
> +		assigned-clock-rates = <294912000>,
> +				       <270950400>,
> +				       <393216000>;
> +		status = "okay";
> +
> +		dai-link-0 {
> +			sound-dai = <&frddr_a>;
> +		};
> +
> +		dai-link-1 {
> +			sound-dai = <&frddr_b>;
> +		};
> +
> +		dai-link-2 {
> +			sound-dai = <&frddr_c>;
> +		};
> +
> +		/* 8ch hdmi interface */
> +		dai-link-3 {
> +			sound-dai = <&tdmif_b>;
> +			dai-format = "i2s";
> +			dai-tdm-slot-tx-mask-0 = <1 1>;
> +			dai-tdm-slot-tx-mask-1 = <1 1>;
> +			dai-tdm-slot-tx-mask-2 = <1 1>;
> +			dai-tdm-slot-tx-mask-3 = <1 1>;
> +			mclk-fs = <256>;
> +
> +			codec {
> +				sound-dai = <&tohdmitx TOHDMITX_I2S_IN_B>;
> +			};
> +		};
> +
> +		/* hdmi glue */
> +		dai-link-4 {
> +			sound-dai = <&tohdmitx TOHDMITX_I2S_OUT>;
> +
> +			codec {
> +				sound-dai = <&hdmi_tx>;
> +			};
> +		};
> +	};
> +};
> +
> +&arb {
> +	status = "okay";
> +};
> +
> +&cec_AO {
> +	pinctrl-0 = <&cec_ao_a_h_pins>;
> +	pinctrl-names = "default";
> +	status = "disabled";
> +	hdmi-phandle = <&hdmi_tx>;
> +};
> +
> +&cecb_AO {
> +	pinctrl-0 = <&cec_ao_b_h_pins>;
> +	pinctrl-names = "default";
> +	status = "okay";
> +	hdmi-phandle = <&hdmi_tx>;
> +};
> +
> +&clkc_audio {
> +	status = "okay";
> +};
> +
> +&cpu0 {
> +	cpu-supply = <&vddcpu_b>;
> +	operating-points-v2 = <&cpu_opp_table_0>;
> +	clocks = <&clkc CLKID_CPU_CLK>;
> +	clock-latency = <50000>;
> +};
> +
> +&cpu1 {
> +	cpu-supply = <&vddcpu_b>;
> +	operating-points-v2 = <&cpu_opp_table_0>;
> +	clocks = <&clkc CLKID_CPU_CLK>;
> +	clock-latency = <50000>;
> +};
> +
> +&cpu100 {
> +	cpu-supply = <&vddcpu_a>;
> +	operating-points-v2 = <&cpub_opp_table_1>;
> +	clocks = <&clkc CLKID_CPUB_CLK>;
> +	clock-latency = <50000>;
> +};
> +
> +&cpu101 {
> +	cpu-supply = <&vddcpu_a>;
> +	operating-points-v2 = <&cpub_opp_table_1>;
> +	clocks = <&clkc CLKID_CPUB_CLK>;
> +	clock-latency = <50000>;
> +};
> +
> +&cpu102 {
> +	cpu-supply = <&vddcpu_a>;
> +	operating-points-v2 = <&cpub_opp_table_1>;
> +	clocks = <&clkc CLKID_CPUB_CLK>;
> +	clock-latency = <50000>;
> +};
> +
> +&cpu103 {
> +	cpu-supply = <&vddcpu_a>;
> +	operating-points-v2 = <&cpub_opp_table_1>;
> +	clocks = <&clkc CLKID_CPUB_CLK>;
> +	clock-latency = <50000>;
> +};
> +
> +&ext_mdio {
> +	external_phy: ethernet-phy@0 {
> +		/* Realtek RTL8211F (0x001cc916) */
> +		reg = <0>;
> +		max-speed = <1000>;
> +
> +		reset-assert-us = <10000>;
> +		reset-deassert-us = <30000>;
> +		reset-gpios = <&gpio GPIOZ_15 (GPIO_ACTIVE_LOW | GPIO_OPEN_DRAIN)>;
> +
> +		interrupt-parent = <&gpio_intc>;
> +		/* MAC_INTR on GPIOZ_14 */
> +		interrupts = <26 IRQ_TYPE_LEVEL_LOW>;
> +	};
> +};
> +
> +&ethmac {
> +	pinctrl-0 = <&eth_pins>, <&eth_rgmii_pins>;
> +	pinctrl-names = "default";
> +	status = "okay";
> +	phy-mode = "rgmii";
> +	phy-handle = <&external_phy>;
> +	amlogic,tx-delay-ns = <2>;
> +};
> +
> +&frddr_a {
> +	status = "okay";
> +};
> +
> +&frddr_b {
> +	status = "okay";
> +};
> +
> +&frddr_c {
> +	status = "okay";
> +};
> +
> +&gpio {
> +	/*
> +	 * WARNING: The USB Hub on the Odroid-N2 needs a reset signal
> +	 * to be turned high in order to be detected by the USB Controller
> +	 * This signal should be handled by a USB specific power sequence
> +	 * in order to reset the Hub when USB bus is powered down.
> +	 */
> +	usb-hub {
> +		gpio-hog;
> +		gpios = <GPIOH_4 GPIO_ACTIVE_HIGH>;
> +		output-high;
> +		line-name = "usb-hub-reset";
> +	};
> +};
> +
> +&hdmi_tx {
> +	status = "okay";
> +	pinctrl-0 = <&hdmitx_hpd_pins>, <&hdmitx_ddc_pins>;
> +	pinctrl-names = "default";
> +	hdmi-supply = <&vcc_5v>;
> +};
> +
> +&hdmi_tx_tmds_port {
> +	hdmi_tx_tmds_out: endpoint {
> +		remote-endpoint = <&hdmi_connector_in>;
> +	};
> +};
> +
> +&ir {
> +	status = "okay";
> +	pinctrl-0 = <&remote_input_ao_pins>;
> +	pinctrl-names = "default";
> +	linux,rc-map-name = "rc-odroid";
> +};
> +
> +&pwm_ab {
> +	pinctrl-0 = <&pwm_a_e_pins>;
> +	pinctrl-names = "default";
> +	clocks = <&xtal>;
> +	clock-names = "clkin0";
> +	status = "okay";
> +};
> +
> +&pwm_AO_cd {
> +	pinctrl-0 = <&pwm_ao_d_e_pins>;
> +	pinctrl-names = "default";
> +	clocks = <&xtal>;
> +	clock-names = "clkin1";
> +	status = "okay";
> +};
> +
> +/* SD card */
> +&sd_emmc_b {
> +	status = "okay";
> +	pinctrl-0 = <&sdcard_c_pins>;
> +	pinctrl-1 = <&sdcard_clk_gate_c_pins>;
> +	pinctrl-names = "default", "clk-gate";
> +
> +	bus-width = <4>;
> +	cap-sd-highspeed;
> +	max-frequency = <50000000>;
> +	disable-wp;
> +
> +	cd-gpios = <&gpio GPIOC_6 GPIO_ACTIVE_LOW>;
> +	vmmc-supply = <&tflash_vdd>;
> +	vqmmc-supply = <&tf_io>;
> +
> +};
> +
> +/* eMMC */
> +&sd_emmc_c {
> +	status = "okay";
> +	pinctrl-0 = <&emmc_ctrl_pins>, <&emmc_data_8b_pins>, <&emmc_ds_pins>;
> +	pinctrl-1 = <&emmc_clk_gate_pins>;
> +	pinctrl-names = "default", "clk-gate";
> +
> +	bus-width = <8>;
> +	cap-mmc-highspeed;
> +	mmc-ddr-1_8v;
> +	mmc-hs200-1_8v;
> +	max-frequency = <200000000>;
> +	disable-wp;
> +
> +	mmc-pwrseq = <&emmc_pwrseq>;
> +	vmmc-supply = <&vcc_3v3>;
> +	vqmmc-supply = <&flash_1v8>;
> +};
> +
> +/*
> + * EMMC_D4, EMMC_D5, EMMC_D6 and EMMC_D7 pins are shared between SPI NOR pins
> + * and eMMC Data 4 to 7 pins.
> + * Replace emmc_data_8b_pins to emmc_data_4b_pins from sd_emmc_c pinctrl-0,
> + * and change bus-width to 4 then spifc can be enabled.
> + * The SW1 slide should also be set to the correct position.
> + */
> +&spifc {
> +	status = "disabled";
> +	pinctrl-0 = <&nor_pins>;
> +	pinctrl-names = "default";
> +
> +	mx25u64: spi-flash@0 {
> +		#address-cells = <1>;
> +		#size-cells = <1>;
> +		compatible = "mxicy,mx25u6435f", "jedec,spi-nor";
> +		reg = <0>;
> +		spi-max-frequency = <104000000>;
> +	};
> +};
> +
> +&tdmif_b {
> +	status = "okay";
> +};
> +
> +&tdmout_b {
> +	status = "okay";
> +};
> +
> +&tohdmitx {
> +	status = "okay";
> +};
> +
> +&uart_AO {
> +	status = "okay";
> +	pinctrl-0 = <&uart_ao_a_pins>;
> +	pinctrl-names = "default";
> +};
> +
> +&usb {
> +	status = "okay";
> +	vbus-supply = <&usb_pwr_en>;
> +};
> +
> +&usb2_phy0 {
> +	phy-supply = <&vcc_5v>;
> +};
> +
> +&usb2_phy1 {
> +	/* Enable the hub which is connected to this port */
> +	phy-supply = <&hub_5v>;
> +};
> 

Acked-by: Neil Armstrong <narmstrong@baylibre.com>
