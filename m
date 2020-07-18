Return-Path: <SRS0=rxDU=A5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.5 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	NICE_REPLY_A,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A93E1C433E2
	for <linux-kernel@archiver.kernel.org>; Sat, 18 Jul 2020 08:52:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8539D2173E
	for <linux-kernel@archiver.kernel.org>; Sat, 18 Jul 2020 08:52:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20150623.gappssmtp.com header.i=@baylibre-com.20150623.gappssmtp.com header.b="n93979QF"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726381AbgGRIw3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 18 Jul 2020 04:52:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44084 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726055AbgGRIw3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 18 Jul 2020 04:52:29 -0400
Received: from mail-wr1-x444.google.com (mail-wr1-x444.google.com [IPv6:2a00:1450:4864:20::444])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 06731C0619D3
        for <linux-kernel@vger.kernel.org>; Sat, 18 Jul 2020 01:52:29 -0700 (PDT)
Received: by mail-wr1-x444.google.com with SMTP id s10so13336428wrw.12
        for <linux-kernel@vger.kernel.org>; Sat, 18 Jul 2020 01:52:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=subject:to:references:from:message-id:date:user-agent:mime-version
         :in-reply-to:content-transfer-encoding;
        bh=9ayyodkGKOpYivSbbjMTJTNckO5WX56Y6RqfjhxjCBI=;
        b=n93979QFLxxXKf9glRQf3YuTidR5ReP3Bl3WKjAa8NMu+CyyI18OY/AOEZpzMHOXqW
         H+2NEg1ebSLylQVCFKWKZMexiDFTpv7QglvmSm2Sp+POKmqLGjFxw3EcGuXG6lf1kBCp
         b5XWmNdF/k9BTOMAtSsqiR+0ri3CvM/DNd/ihuYDjA3a/1OmgB7dTOgUTjHZuYIM6iFT
         p06J8pZIRaFiZUnlBho+qAk/Hhh1f0n2GvT2peLk+T2MBlopq0HGHa8XsqkZ7/T2Bz5F
         vftWQYLqpoGV63d2c3N+IYAhC+O6/yCwQ6gVzDE30/eJO34l8iJcoaIdx77YRAsSTpYf
         iPwA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding;
        bh=9ayyodkGKOpYivSbbjMTJTNckO5WX56Y6RqfjhxjCBI=;
        b=i1w82HfvfsYKHYQd/UlntxhNxhYiG+hw15O7ii6rzrkN7fUlsjIxdV7jugmQvHvm3U
         ghK6T+c+tBUs7ZNpfesLywQMtkZIE99qw2by8utwq1UvKwCxnJuqZeRuCeznPZrYS6Hb
         v/GCzvB0SJhbE8qqkzSvb44BJJs9FF957aASoDPNe3PB5bAB9RWBB7s3wkvOEveRm3qb
         0Foc68ZYLzBca3E2svpUyEaPbuDolX5pJhYPx6QydJ4CAgPH1ZfRdg6MekheuJqc62Jt
         ysREZGmhaRw3XxdagziVchN2xGnl/aE+pAl1o96BUhpZcdawFvTCJySkhZjZyVNJMrL4
         eYhw==
X-Gm-Message-State: AOAM533HnUUs6CBkIN6itiXb3ja+eG2ln7psENsC9Hs47Wxbpo5ov8mh
        ccG3/FbcbP/OrRoWTMC1ApAheIppmwD1JQ==
X-Google-Smtp-Source: ABdhPJxu4y0gjLiyjMK9hGTuvtnSu+8ye3iOWiy3oiNkYI8prBjdwxks3f2RiBU44j7b4u5K1qIlbw==
X-Received: by 2002:adf:9307:: with SMTP id 7mr13579644wro.414.1595062347034;
        Sat, 18 Jul 2020 01:52:27 -0700 (PDT)
Received: from Armstrongs-MacBook-Pro.local ([2a01:e35:2ec0:82b0:9d0:bf63:799d:4aa1])
        by smtp.gmail.com with ESMTPSA id l14sm19932531wrn.18.2020.07.18.01.52.25
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 18 Jul 2020 01:52:26 -0700 (PDT)
Subject: Re: [PATCH 2/2] arm64: dts: meson: add support for the WeTek Core 2
To:     Christian Hewitt <christianshewitt@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Kevin Hilman <khilman@baylibre.com>,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-amlogic@lists.infradead.org, linux-kernel@vger.kernel.org
References: <20200718050056.1713-1-christianshewitt@gmail.com>
 <20200718050056.1713-2-christianshewitt@gmail.com>
From:   Neil Armstrong <narmstrong@baylibre.com>
Message-ID: <2ab5e28a-77f6-cac1-68ed-f0a23d5f2a24@baylibre.com>
Date:   Sat, 18 Jul 2020 10:52:26 +0200
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.13; rv:45.0)
 Gecko/20100101 Thunderbird/45.8.0
MIME-Version: 1.0
In-Reply-To: <20200718050056.1713-2-christianshewitt@gmail.com>
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



Le 18/07/2020 à 07:00, Christian Hewitt a écrit :
> The WeTek Core2 is a commercial device based on the Amlogic Q200 reference
> design but with the following differences:
> 
> - 3GB RAM, 32GB eMMC
> - Blue and Red LEDs used to signal on/off status
> - uart_AO can be accessed after opening the case; soldering required
> - USB OTG is not accessible (inside the case)
> - Realtek RTL8152 Ethernet (internal USB connection)
> 
> Signed-off-by: Christian Hewitt <christianshewitt@gmail.com>
> ---
>  arch/arm64/boot/dts/amlogic/Makefile          |  1 +
>  .../dts/amlogic/meson-gxm-wetek-core2.dts     | 90 +++++++++++++++++++
>  2 files changed, 91 insertions(+)
>  create mode 100644 arch/arm64/boot/dts/amlogic/meson-gxm-wetek-core2.dts
> 
> diff --git a/arch/arm64/boot/dts/amlogic/Makefile b/arch/arm64/boot/dts/amlogic/Makefile
> index 5cac4d1d487d..4e2239ffcaa5 100644
> --- a/arch/arm64/boot/dts/amlogic/Makefile
> +++ b/arch/arm64/boot/dts/amlogic/Makefile
> @@ -41,6 +41,7 @@ dtb-$(CONFIG_ARCH_MESON) += meson-gxm-q201.dtb
>  dtb-$(CONFIG_ARCH_MESON) += meson-gxm-rbox-pro.dtb
>  dtb-$(CONFIG_ARCH_MESON) += meson-gxm-s912-libretech-pc.dtb
>  dtb-$(CONFIG_ARCH_MESON) += meson-gxm-vega-s96.dtb
> +dtb-$(CONFIG_ARCH_MESON) += meson-gxm-wetek-core2.dtb
>  dtb-$(CONFIG_ARCH_MESON) += meson-sm1-sei610.dtb
>  dtb-$(CONFIG_ARCH_MESON) += meson-sm1-khadas-vim3l.dtb
>  dtb-$(CONFIG_ARCH_MESON) += meson-sm1-odroid-c4.dtb
> diff --git a/arch/arm64/boot/dts/amlogic/meson-gxm-wetek-core2.dts b/arch/arm64/boot/dts/amlogic/meson-gxm-wetek-core2.dts
> new file mode 100644
> index 000000000000..44fc5ea38dc0
> --- /dev/null
> +++ b/arch/arm64/boot/dts/amlogic/meson-gxm-wetek-core2.dts
> @@ -0,0 +1,90 @@
> +// SPDX-License-Identifier: (GPL-2.0+ OR MIT)
> +/*
> + * Copyright (c) 2020 Christian Hewitt <christianshewitt@gmail.com>
> + */
> +
> +/dts-v1/;
> +
> +#include "meson-gxm.dtsi"
> +#include "meson-gx-p23x-q20x.dtsi"
> +#include <dt-bindings/input/input.h>
> +#include <dt-bindings/leds/common.h>
> +
> +/ {
> +	compatible = "wetek,core2", "amlogic,s912", "amlogic,meson-gxm";
> +	model = "WeTek Core 2";
> +
> +	memory@0 {
> +		device_type = "memory";
> +		reg = <0x0 0x0 0x0 0x80000000>; /* 2 GiB or 3 GiB */
> +	};
> +
> +	leds {
> +		compatible = "gpio-leds";
> +
> +		blue {
> +			color = <LED_COLOR_ID_BLUE>;
> +			function = LED_FUNCTION_STATUS;
> +			gpios = <&gpio GPIODV_24 GPIO_ACTIVE_HIGH>;
> +			default-state = "on";
> +		};
> +	};
> +
> +	adc-keys {
> +		compatible = "adc-keys";
> +		io-channels = <&saradc 0>;
> +		io-channel-names = "buttons";
> +		keyup-threshold-microvolt = <1710000>;
> +
> +		button-update {
> +			label = "update";
> +			linux,code = <KEY_VENDOR>;
> +			press-threshold-microvolt = <10000>;
> +		};
> +	};
> +
> +	gpio-keys-polled {
> +		compatible = "gpio-keys-polled";
> +		#address-cells = <1>;
> +		#size-cells = <0>;
> +		poll-interval = <100>;
> +
> +		button-power {
> +			label = "power";
> +			linux,code = <KEY_POWER>;
> +			gpios = <&gpio_ao GPIOAO_2 GPIO_ACTIVE_LOW>;
> +		};
> +	};
> +};
> +
> +/* This is disabled as Realtek RTL8152 USB provides Ethernet */
> +&ethmac {
> +	status = "disabled";
> +	phy-mode = "rmii";
> +	phy-handle = <&internal_phy>;

I think you can remove these 2 lines

> +};
> +
> +&internal_phy {
> +	pinctrl-0 = <&eth_link_led_pins>, <&eth_act_led_pins>;
> +	pinctrl-names = "default";

Simply add :
status = "disabled";

> +};
> +
> +&ir {
> +	linux,rc-map-name = "rc-wetek-play2";
> +};
> +
> +/* This is connected to the Bluetooth module: */
> +&uart_A {
> +	status = "okay";
> +	pinctrl-0 = <&uart_a_pins>, <&uart_a_cts_rts_pins>;
> +	pinctrl-names = "default";
> +	uart-has-rtscts;
> +
> +	bluetooth {
> +		compatible = "brcm,bcm43438-bt";
> +		enable-gpios = <&gpio GPIOX_17 GPIO_ACTIVE_HIGH>;
> +		max-speed = <2000000>;
> +		clocks = <&wifi32k>;
> +		clock-names = "lpo";
> +	};
> +};
> 


Otherwise looks good

Neil
