Return-Path: <SRS0=r24B=6M=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BABB1C83007
	for <linux-kernel@archiver.kernel.org>; Tue, 28 Apr 2020 10:20:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 921D9206D6
	for <linux-kernel@archiver.kernel.org>; Tue, 28 Apr 2020 10:20:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1588069239;
	bh=4OeVg93gCmdUJAPkUzPIsytJfzhNuFzitSg+GbhXwnQ=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=XUWrDeIB6yXt6Z6J+WhjvErouT8QnVI4scc1q3O0oq5HSftiBMCwOyLhaAOSdQjEU
	 MN66QyxFmpif/C2JWHD9Yro8+6biarrmEFcclplV4nSevnx5MSoLN+p1dSDjp5O2+z
	 JoWQbFIcgz2Y5NeYyJDyMuqR6sCRd6J+v8YnTfas=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727969AbgD1KUj convert rfc822-to-8bit (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 28 Apr 2020 06:20:39 -0400
Received: from mail-ed1-f68.google.com ([209.85.208.68]:42134 "EHLO
        mail-ed1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727114AbgD1KUc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Apr 2020 06:20:32 -0400
Received: by mail-ed1-f68.google.com with SMTP id s10so15956940edy.9;
        Tue, 28 Apr 2020 03:20:29 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=8XVZLy+Z2aeMWzOQ+xj/bdTQQafaM8Qg8Ml+JBIWjas=;
        b=cl+J/wqdAjDYff7hircxN1GX+7chdHuwQocv0aAK+LKe478kxYFx8i6rFmibpAqpJt
         twq8SRbuQGWwi9Gu20OD+tbiPiquq55K2IlkHpQLCmPHf0GnIpbHAMItVIVRsVNZu0II
         414E/STEIMcImUppioMniADemUgoRv+AsGtq/hPXwlVEpTNlMAsqHOJuUsqilB8z86ZO
         ZetMs4wybnQ4bxyWfJYUaEX7YfN6NeQclyyNctHVAFQ1+0nWcahF3X+/KL2qGQ2nrG4A
         qZUn6rsBudVvu3VnZ9ztCiQhE7KUw2HfxDoAkUbyDlOOt7M59HtrudyhPcjtwnSHIzAR
         km3Q==
X-Gm-Message-State: AGi0PubF6bIEPkQeSZJG1WVu00+njBdzs2pR/MPSnppOHQ7TOsvgReJ+
        SVHA3hTHAeJWqIicFZ7gGRQ=
X-Google-Smtp-Source: APiQypIlj9J3oWIIsF+MLx39oTKzFj0RUM+Tt9CdhuA54Gum3uRwO43yYz3yLqCIKNQNoLSMIfC2Hw==
X-Received: by 2002:aa7:d5d4:: with SMTP id d20mr22422707eds.369.1588069228872;
        Tue, 28 Apr 2020 03:20:28 -0700 (PDT)
Received: from kozik-lap ([194.230.155.237])
        by smtp.googlemail.com with ESMTPSA id r19sm260813edo.12.2020.04.28.03.20.27
        (version=TLS1_2 cipher=ECDHE-ECDSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 28 Apr 2020 03:20:28 -0700 (PDT)
Date:   Tue, 28 Apr 2020 12:20:26 +0200
From:   Krzysztof Kozlowski <krzk@kernel.org>
To:     Jonathan Bakker <xc-racer2@live.ca>
Cc:     kgene@kernel.org, robh+dt@kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-samsung-soc@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        =?utf-8?B?UGF3ZcWC?= Chmiel <pawel.mikolaj.chmiel@gmail.com>
Subject: Re: [PATCH 06/13] arm: dts: s5pv210: aries: Add support for more
 devices
Message-ID: <20200428102026.GB23963@kozik-lap>
References: <20200426183604.28494-1-xc-racer2@live.ca>
 <BN6PR04MB0660563639D091548BFCCFF2A3AE0@BN6PR04MB0660.namprd04.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8BIT
In-Reply-To: <BN6PR04MB0660563639D091548BFCCFF2A3AE0@BN6PR04MB0660.namprd04.prod.outlook.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Apr 26, 2020 at 11:35:57AM -0700, Jonathan Bakker wrote:
> Add support for following devices:
>   - touchkeys connected over i2c-gpio
>   - s6e63m0 panel connected over spi-gpio
>   - fsa9480 microusb switch over i2c-gpio
>   - wm8994 over i2c-gpio (no machine driver yet)
>   - all common i2c-gpio devices

Please split it per functionality, e.g.:
1. Add sound,
2. Add panel,
3. Add touchkeys (unless part of panel),
4. The remaining i2c-gpio devices without bindings could go as one.

> 
> Signed-off-by: Jonathan Bakker <xc-racer2@live.ca>
> Signed-off-by: Paweł Chmiel <pawel.mikolaj.chmiel@gmail.com>
> ---
>  arch/arm/boot/dts/s5pv210-aries.dtsi      | 282 ++++++++++++++++++++--
>  arch/arm/boot/dts/s5pv210-fascinate4g.dts |   6 +
>  2 files changed, 270 insertions(+), 18 deletions(-)
> 
> diff --git a/arch/arm/boot/dts/s5pv210-aries.dtsi b/arch/arm/boot/dts/s5pv210-aries.dtsi
> index f83df426f2b6..ef966d13d83d 100644
> --- a/arch/arm/boot/dts/s5pv210-aries.dtsi
> +++ b/arch/arm/boot/dts/s5pv210-aries.dtsi
> @@ -12,8 +12,14 @@
>  	compatible = "samsung,aries", "samsung,s5pv210";
>  
>  	aliases {
> +		i2c4 = &i2c_sound;
> +		i2c5 = &i2c_accel;
>  		i2c6 = &i2c_pmic;
> +		i2c7 = &i2c_musb;
>  		i2c9 = &i2c_fuel;
> +		i2c10 = &i2c_touchkey;
> +		i2c11 = &i2c_prox;
> +		i2c12 = &i2c_magnetometer;
>  	};
>  
>  	memory@30000000 {
> @@ -48,6 +54,18 @@
>  		gpio = <&gpj1 1 GPIO_ACTIVE_HIGH>;
>  	};
>  
> +	touchkey_vdd: regulator-fixed-1 {
> +		compatible = "regulator-fixed";
> +		regulator-name = "VTOUCH_3.3V";
> +		regulator-min-microvolt = <3300000>;
> +		regulator-max-microvolt = <3300000>;
> +		enable-active-high;
> +		gpio = <&gpj3 2 GPIO_ACTIVE_HIGH>;
> +
> +		pinctrl-names = "default";
> +		pinctrl-0 = <&touchkey_vdd_ena>;
> +	};
> +
>  	wifi_pwrseq: wifi-pwrseq {
>  		compatible = "mmc-pwrseq-simple";
>  		reset-gpios = <&gpg1 2 GPIO_ACTIVE_LOW>;
> @@ -57,7 +75,69 @@
>  		power-off-delay-us = <500>;
>  	};
>  
> -	i2c_pmic: i2c-gpio-0 {
> +	i2c_sound: i2c-gpio-0 {
> +		compatible = "i2c-gpio";
> +		sda-gpios = <&mp05 3 (GPIO_ACTIVE_HIGH | GPIO_OPEN_DRAIN)>;
> +		scl-gpios = <&mp05 2 (GPIO_ACTIVE_HIGH | GPIO_OPEN_DRAIN)>;
> +		i2c-gpio,delay-us = <2>;
> +		#address-cells = <1>;
> +		#size-cells = <0>;
> +
> +		pinctrl-names = "default";
> +		pinctrl-0 = <&sound_i2c_pins>;
> +
> +		wm8994: wm8994@1a {
> +			compatible = "wlf,wm8994";
> +			reg = <0x1a>;
> +
> +			#sound-dai-cells = <0>;
> +
> +			gpio-controller;
> +			#gpio-cells = <2>;
> +
> +			clocks = <&clocks MOUT_CLKOUT>;
> +			clock-names = "MCLK1";
> +
> +			AVDD2-supply = <&buck3_reg>;
> +			DBVDD-supply = <&buck3_reg>;

No such supply, check the bindings.

> +			CPVDD-supply = <&buck3_reg>;
> +			SPKVDD1-supply = <&buck3_reg>;
> +			SPKVDD2-supply = <&buck3_reg>;
> +
> +			wlf,gpio-cfg = <0xa101 0x8100 0x0100 0x0100 0x8100
> +					0xa101 0x0100 0x8100 0x0100 0x0100
> +					0x0100>;
> +
> +			wlf,ldo1ena = <&gpf3 4 GPIO_ACTIVE_HIGH>;
> +			wlf,ldo2ena = <&gpf3 4 GPIO_ACTIVE_HIGH>;
> +
> +			wlf,lineout1-se;
> +			wlf,lineout2-se;
> +
> +			assigned-clocks = <&clocks MOUT_CLKOUT>;
> +			assigned-clock-rates = <0>;
> +			assigned-clock-parents = <&xusbxti>;
> +
> +			pinctrl-names = "default";
> +			pinctrl-0 = <&codec_ldo>;
> +		};
> +	};
> +
> +	i2c_accel: i2c-gpio-1 {
> +		compatible = "i2c-gpio";
> +		sda-gpios = <&gpj3 6 (GPIO_ACTIVE_HIGH | GPIO_OPEN_DRAIN)>;
> +		scl-gpios = <&gpj3 7 (GPIO_ACTIVE_HIGH | GPIO_OPEN_DRAIN)>;
> +		i2c-gpio,delay-us = <2>;
> +		#address-cells = <1>;
> +		#size-cells = <0>;
> +
> +		pinctrl-names = "default";
> +		pinctrl-0 = <&accel_i2c_pins>;
> +
> +		/* bma023 accelerometer, no mainline binding */

status disabled ... unless you need it for user-space I2C tools?

> +	};
> +
> +	i2c_pmic: i2c-gpio-2 {
>  		compatible = "i2c-gpio";
>  		sda-gpios = <&gpj4 0 (GPIO_ACTIVE_HIGH | GPIO_OPEN_DRAIN)>;
>  		scl-gpios = <&gpj4 3 (GPIO_ACTIVE_HIGH | GPIO_OPEN_DRAIN)>;
> @@ -137,8 +217,6 @@
>  					regulator-name = "VLCD_1.8V";
>  					regulator-min-microvolt = <1800000>;
>  					regulator-max-microvolt = <1800000>;
> -					/* Till we get panel driver */
> -					regulator-always-on;
>  
>  					regulator-state-mem {
>  						regulator-off-in-suspend;
> @@ -237,8 +315,6 @@
>  					regulator-name = "VCC_3.0V_LCD";
>  					regulator-min-microvolt = <3000000>;
>  					regulator-max-microvolt = <3000000>;
> -					/* Till we get panel driver */
> -					regulator-always-on;
>  
>  					regulator-state-mem {
>  						regulator-off-in-suspend;
> @@ -309,7 +385,26 @@
>  		};
>  	};
>  
> -	i2c_fuel: i2c-gpio-1 {
> +	i2c_musb: i2c-gpio-3 {
> +		compatible = "i2c-gpio";
> +		sda-gpios = <&gpj3 4 (GPIO_ACTIVE_HIGH | GPIO_OPEN_DRAIN)>;
> +		scl-gpios = <&gpj3 5 (GPIO_ACTIVE_HIGH | GPIO_OPEN_DRAIN)>;
> +		i2c-gpio,delay-us = <2>;
> +		#address-cells = <1>;
> +		#size-cells = <0>;
> +
> +		pinctrl-names = "default";
> +		pinctrl-0 = <&musb_i2c_pins>;
> +
> +		fsa9480: musb@25 {
> +			compatible = "fcs,fsa9480";
> +			reg = <0x25>;
> +			interrupt-parent = <&gph2>;
> +			interrupts = <7 IRQ_TYPE_EDGE_FALLING>;
> +		};
> +	};
> +
> +	i2c_fuel: i2c-gpio-4 {
>  		compatible = "i2c-gpio";
>  		sda-gpios = <&mp05 1 (GPIO_ACTIVE_HIGH | GPIO_OPEN_DRAIN)>;
>  		scl-gpios = <&mp05 0 (GPIO_ACTIVE_HIGH | GPIO_OPEN_DRAIN)>;
> @@ -328,6 +423,60 @@
>  		};
>  	};
>  
> +	i2c_touchkey: i2c-gpio-5 {
> +		compatible = "i2c-gpio";
> +		sda-gpios = <&gpj3 0 (GPIO_ACTIVE_HIGH | GPIO_OPEN_DRAIN)>;
> +		scl-gpios = <&gpj3 1 (GPIO_ACTIVE_HIGH | GPIO_OPEN_DRAIN)>;
> +		i2c-gpio,delay-us = <2>;
> +		#address-cells = <1>;
> +		#size-cells = <0>;
> +
> +		pinctrl-names = "default";
> +		pinctrl-0 = <&touchkey_i2c_pins>;
> +
> +		touchkey@20 {
> +			compatible = "cypress,aries-touchkey";
> +			reg = <0x20>;
> +			vdd-supply = <&touchkey_vdd>;
> +			vcc-supply = <&buck3_reg>;
> +			linux,keycodes = <KEY_MENU KEY_BACK
> +					  KEY_HOMEPAGE KEY_SEARCH>;
> +			interrupt-parent = <&gpj4>;
> +			interrupts = <1 IRQ_TYPE_LEVEL_LOW>;
> +
> +			pinctrl-names = "default";
> +			pinctrl-0 = <&touchkey_irq>;
> +		};
> +	};
> +
> +	i2c_prox: i2c-gpio-6 {
> +		compatible = "i2c-gpio";
> +		sda-gpios = <&gpg2 2 (GPIO_ACTIVE_HIGH | GPIO_OPEN_DRAIN)>;
> +		scl-gpios = <&gpg0 2 (GPIO_ACTIVE_HIGH | GPIO_OPEN_DRAIN)>;
> +		i2c-gpio,delay-us = <2>;
> +		#address-cells = <1>;
> +		#size-cells = <0>;
> +
> +		pinctrl-names = "default";
> +		pinctrl-0 = <&prox_i2c_pins>;
> +
> +		/* Sharp gp2a prox/light sensor, incomplete mainline binding */

The same - disable, unless you access it from user-space.

> +	};
> +
> +	i2c_magnetometer: i2c-gpio-7 {
> +		compatible = "i2c-gpio";
> +		sda-gpios = <&gpj0 1 (GPIO_ACTIVE_HIGH | GPIO_OPEN_DRAIN)>;
> +		scl-gpios = <&gpj0 0 (GPIO_ACTIVE_HIGH | GPIO_OPEN_DRAIN)>;
> +		i2c-gpio,delay-us = <2>;
> +		#address-cells = <1>;
> +		#size-cells = <0>;
> +
> +		pinctrl-names = "default";
> +		pinctrl-0 = <&magnetometer_i2c_pins>;
> +
> +		/* Yamaha yas529 magnetometer, no mainline binding */

The same - disable, unless you access it from user-space.

> +	};
> +
>  	vibrator: pwm-vibrator {
>  		compatible = "pwm-vibrator";
>  		pwms = <&pwm 1 44642 0>;
> @@ -343,6 +492,39 @@
>  		offset = <0x681c>; /* PS_HOLD_CONTROL */
>  		value = <0x5200>;
>  	};
> +
> +	spi_lcd: spi-gpio-0 {
> +		compatible = "spi-gpio";
> +		#address-cells = <1>;
> +		#size-cells = <0>;
> +
> +		sck-gpios = <&mp04 1 GPIO_ACTIVE_HIGH>;
> +		mosi-gpios = <&mp04 3 GPIO_ACTIVE_HIGH>;
> +		cs-gpios = <&mp01 1 GPIO_ACTIVE_HIGH>;
> +		num-chipselects = <1>;
> +
> +		pinctrl-names = "default";
> +		pinctrl-0 = <&lcd_spi_pins>;
> +
> +		panel@0 {
> +			compatible = "samsung,s6e63m0";
> +			reg = <0>;
> +			reset-gpios = <&mp05 5 GPIO_ACTIVE_LOW>;
> +			vdd3-supply = <&ldo7_reg>;
> +			vci-supply = <&ldo17_reg>;
> +			spi-cs-high;
> +			spi-max-frequency = <1200000>;
> +
> +			pinctrl-names = "default";
> +			pinctrl-0 = <&panel_rst>;
> +
> +			port {
> +				lcd_ep: endpoint {
> +					remote-endpoint = <&fimd_ep>;
> +				};
> +			};
> +		};
> +	};
>  };
>  
>  &fimd {
> @@ -353,18 +535,13 @@
>  	samsung,invert-vden;
>  	samsung,invert-vclk;
>  
> -	display-timings {
> -		timing-0 {
> -			/* 480x800@60Hz */
> -			clock-frequency = <25628040>;
> -			hactive = <480>;
> -			vactive = <800>;
> -			hfront-porch = <16>;
> -			hback-porch = <16>;
> -			hsync-len = <2>;
> -			vfront-porch = <28>;
> -			vback-porch = <1>;
> -			vsync-len = <2>;
> +	#address-cells = <1>;
> +	#size-cells = <0>;
> +
> +	port@3 {
> +		reg = <3>;
> +		fimd_ep: endpoint {
> +			remote-endpoint = <&lcd_ep>;
>  		};
>  	};
>  };
> @@ -405,6 +582,19 @@
>  		samsung,pin-val = <1>;
>  	};
>  
> +	codec_ldo: codec-ldo {
> +		samsung,pins = "gpf3-4";
> +		samsung,pin-function = <EXYNOS_PIN_FUNC_OUTPUT>;
> +		samsung,pin-pud = <S3C64XX_PIN_PULL_NONE>;
> +	};
> +
> +	prox_i2c_pins: gp2a-i2c-pins {
> +		samsung,pins = "gpg0-2", "gpg2-2";
> +		samsung,pin-function = <EXYNOS_PIN_FUNC_F>;
> +		samsung,pin-pud = <S3C64XX_PIN_PULL_NONE>;
> +		samsung,pin-drv = <EXYNOS4_PIN_DRV_LV1>;
> +	};
> +
>  	wlan_gpio_rst: wlan-gpio-rst {
>  		samsung,pins = "gpg1-2";
>  		samsung,pin-function = <EXYNOS_PIN_FUNC_OUTPUT>;
> @@ -438,6 +628,13 @@
>  		samsung,pin-pud = <S3C64XX_PIN_PULL_NONE>;
>  	};
>  
> +	magnetometer_i2c_pins: yas529-i2c-pins {
> +		samsung,pins = "gpj0-0", "gpj0-1";
> +		samsung,pin-function = <EXYNOS_PIN_FUNC_F>;
> +		samsung,pin-pud = <S3C64XX_PIN_PULL_NONE>;
> +		samsung,pin-drv = <EXYNOS4_PIN_DRV_LV1>;
> +	};
> +
>  	ts_irq: ts-irq {
>  		samsung,pins = "gpj0-5";
>  		samsung,pin-function = <EXYNOS_PIN_FUNC_INPUT>;
> @@ -445,17 +642,66 @@
>  		samsung,pin-drv = <EXYNOS4_PIN_DRV_LV1>;
>  	};
>  
> +	touchkey_i2c_pins: touchkey-i2c-pins {
> +		samsung,pins = "gpj3-0", "gpj3-1";
> +		samsung,pin-pud = <S3C64XX_PIN_PULL_NONE>;
> +		samsung,pin-drv = <EXYNOS4_PIN_DRV_LV1>;
> +	};
> +
> +	touchkey_vdd_ena: touchkey-vdd-ena {
> +		samsung,pins = "gpj3-2";
> +		samsung,pin-pud = <S3C64XX_PIN_PULL_NONE>;
> +		samsung,pin-drv = <EXYNOS4_PIN_DRV_LV1>;
> +	};
> +
> +	musb_i2c_pins: musb-i2c-pins {
> +		samsung,pins = "gpj3-4", "gpj3-5";
> +		samsung,pin-pud = <S3C64XX_PIN_PULL_NONE>;
> +		samsung,pin-drv = <EXYNOS4_PIN_DRV_LV1>;
> +	};
> +
> +	accel_i2c_pins: accel-i2c-pins {
> +		samsung,pins = "gpj3-6", "gpj3-7";
> +		samsung,pin-pud = <S3C64XX_PIN_PULL_NONE>;
> +		samsung,pin-drv = <EXYNOS4_PIN_DRV_LV1>;
> +	};
> +
>  	pmic_i2c_pins: pmic-i2c-pins {
>  		samsung,pins = "gpj4-0", "gpj4-3";
>  		samsung,pin-pud = <S3C64XX_PIN_PULL_NONE>;
>  		samsung,pin-drv = <EXYNOS4_PIN_DRV_LV1>;
>  	};
>  
> +	touchkey_irq: touchkey-irq {
> +		samsung,pins = "gpj4-1";
> +		samsung,pin-function = <EXYNOS_PIN_FUNC_INPUT>;
> +		samsung,pin-pud = <S3C64XX_PIN_PULL_UP>;
> +		samsung,pin-drv = <EXYNOS4_PIN_DRV_LV1>;
> +	};
> +
> +	lcd_spi_pins: spi-lcd-pins {
> +		samsung,pins = "mp01-1", "mp04-1", "mp04-3";
> +		samsung,pin-pud = <S3C64XX_PIN_PULL_NONE>;
> +		samsung,pin-drv = <EXYNOS4_PIN_DRV_LV1>;
> +	};
> +
>  	fg_i2c_pins: fg-i2c-pins {
>  		samsung,pins = "mp05-0", "mp05-1";
>  		samsung,pin-pud = <S3C64XX_PIN_PULL_NONE>;
>  		samsung,pin-drv = <EXYNOS4_PIN_DRV_LV1>;
>  	};
> +
> +	sound_i2c_pins: sound-i2c-pins {
> +		samsung,pins = "mp05-2", "mp05-3";
> +		samsung,pin-pud = <S3C64XX_PIN_PULL_NONE>;
> +		samsung,pin-drv = <EXYNOS4_PIN_DRV_LV1>;
> +	};
> +
> +	panel_rst: panel-rst {
> +		samsung,pins = "mp05-5";
> +		samsung,pin-pud = <S3C64XX_PIN_PULL_NONE>;
> +		samsung,pin-drv = <EXYNOS4_PIN_DRV_LV1>;
> +	};
>  };
>  
>  &pwm {
> diff --git a/arch/arm/boot/dts/s5pv210-fascinate4g.dts b/arch/arm/boot/dts/s5pv210-fascinate4g.dts
> index 94dcb9b64b9a..42e6e2de197d 100644
> --- a/arch/arm/boot/dts/s5pv210-fascinate4g.dts
> +++ b/arch/arm/boot/dts/s5pv210-fascinate4g.dts
> @@ -278,3 +278,9 @@
>  		PIN_SLP(mp07-7, INPUT, DOWN);
>  	};
>  };
> +
> +&wm8994 {
> +	/* GPIO3 (BCLK2) and GPIO4 (LRCLK2) as outputs */
> +	wlf,gpio-cfg = <0xa101 0x8100 0x8100 0x8100 0x8100 0xa101
> +		0x0100 0x8100 0x0100 0x0100 0x0100>;

Indent the line till opening <.

Best regards,
Krzysztof
