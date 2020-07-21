Return-Path: <SRS0=jpuI=BA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.0 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 94DDFC433DF
	for <linux-kernel@archiver.kernel.org>; Tue, 21 Jul 2020 08:21:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6E33F20720
	for <linux-kernel@archiver.kernel.org>; Tue, 21 Jul 2020 08:21:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20150623.gappssmtp.com header.i=@baylibre-com.20150623.gappssmtp.com header.b="TvvwtPFH"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728792AbgGUIVb (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 21 Jul 2020 04:21:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53748 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726521AbgGUIVa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Jul 2020 04:21:30 -0400
Received: from mail-wm1-x344.google.com (mail-wm1-x344.google.com [IPv6:2a00:1450:4864:20::344])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 85F57C0619D7
        for <linux-kernel@vger.kernel.org>; Tue, 21 Jul 2020 01:21:30 -0700 (PDT)
Received: by mail-wm1-x344.google.com with SMTP id o2so1975518wmh.2
        for <linux-kernel@vger.kernel.org>; Tue, 21 Jul 2020 01:21:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=references:user-agent:from:to:subject:in-reply-to:date:message-id
         :mime-version;
        bh=uMWFGyYaTk9SRaKtXrAbhRNUe/iVRjZ0CQr2Oah93dc=;
        b=TvvwtPFHKZTUhwEr9W9AXtSlqbKNq06vH+t3GLZT2QS1OMIA96GNjTtRytz3C2Gi5w
         u3Rq95KzXXgL8JGyaQyIVdaKNvOELpTtT6c5FqM6xl83SDIBSB2V++v9f6n16C2enp6R
         lBDDJIoz2oPhubdn47BHyeCSgDAuag+Wqc7jmuXtuVAyQLWOok4RCScH49qQaTDkkiy2
         phywHN1eA411+5AlQP/vD3klsOlgfMF87S5OVp1R2HUgNr2z20/rlg/tfH/4ezLsBEeu
         mUIbMZHvJcUPCHVRvPYYBHK+3l+HaBkOfvZ5WI5y9syy1exLBUcoYhJUmfbUjOgVRZwm
         ty+w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:references:user-agent:from:to:subject
         :in-reply-to:date:message-id:mime-version;
        bh=uMWFGyYaTk9SRaKtXrAbhRNUe/iVRjZ0CQr2Oah93dc=;
        b=H0HbUuCq6FMbKoZx4cSLSz8De7L4TJJsEnFUmFAunjA0S4NHBnP6JmAGu0FProTqqf
         0vynB+xLH7EYBk6bFUNonEu6aXUOSC4DYn6eWrv3Auw1xS9vJS+gJv3jDQ3nQkGfwHP2
         L8URJKaPRuEg+u3e3a7TQ6Sotyh4X/7bHgT1LmQ+sTd6zZldf3HRWpS42wvwk3AcQTdV
         PLGy+bOjCb0zVN440Ah3OsXDqbUCn8Crxzao9RcCXSVf+qO5KmG1aSu72+y5LDCQzBFh
         olFuuS6WuZGu7mBF80AWz+M1Y3WXrcxaDYNi9JLuQ8G0bjnriSRggJy36vu731Rtoxs9
         FMGg==
X-Gm-Message-State: AOAM532t3rtSg1GenY1sTb/pGkIZ4QyaIPkv+m12/xY4CFpXS7KIp0Ry
        vDtTAkok4Hj/3vO79Ll9e3NKvhwqj8g=
X-Google-Smtp-Source: ABdhPJzRv+7pl9/WdCZxywp6d8aVxlktytPK5D5woF8AKJK9Czov2HPw0/JkawnYD0SQovjvrLrsKQ==
X-Received: by 2002:a1c:750a:: with SMTP id o10mr3065841wmc.165.1595319689264;
        Tue, 21 Jul 2020 01:21:29 -0700 (PDT)
Received: from localhost (laubervilliers-658-1-213-31.w90-63.abo.wanadoo.fr. [90.63.244.31])
        by smtp.gmail.com with ESMTPSA id t202sm2519588wmt.20.2020.07.21.01.21.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 21 Jul 2020 01:21:28 -0700 (PDT)
References: <20200718065739.7802-1-christianshewitt@gmail.com> <20200718065739.7802-10-christianshewitt@gmail.com>
User-agent: mu4e 1.3.3; emacs 26.3
From:   Jerome Brunet <jbrunet@baylibre.com>
To:     Christian Hewitt <christianshewitt@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Kevin Hilman <khilman@baylibre.com>,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-amlogic@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 09/12] arm64: dts: meson: add audio playback to rbox-pro
In-reply-to: <20200718065739.7802-10-christianshewitt@gmail.com>
Date:   Tue, 21 Jul 2020 10:21:27 +0200
Message-ID: <1jv9ih8eig.fsf@starbuckisacylon.baylibre.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On Sat 18 Jul 2020 at 08:57, Christian Hewitt <christianshewitt@gmail.com> wrote:

> Add initial support limited to HDMI i2s and SPDIF (LPCM).
>
> Signed-off-by: Christian Hewitt <christianshewitt@gmail.com>
> ---
>  .../boot/dts/amlogic/meson-gxm-rbox-pro.dts   | 80 +++++++++++++++++++
>  1 file changed, 80 insertions(+)
>
> diff --git a/arch/arm64/boot/dts/amlogic/meson-gxm-rbox-pro.dts b/arch/arm64/boot/dts/amlogic/meson-gxm-rbox-pro.dts
> index c89c9f846fb1..7b23b3da27ff 100644
> --- a/arch/arm64/boot/dts/amlogic/meson-gxm-rbox-pro.dts
> +++ b/arch/arm64/boot/dts/amlogic/meson-gxm-rbox-pro.dts
> @@ -14,6 +14,7 @@
>  /dts-v1/;
>  
>  #include "meson-gxm.dtsi"
> +#include <dt-bindings/sound/meson-aiu.h>
>  
>  / {
>  	compatible = "kingnovel,r-box-pro", "amlogic,s912", "amlogic,meson-gxm";
> @@ -33,6 +34,13 @@
>  		reg = <0x0 0x0 0x0 0x80000000>; /* 2 GiB or 3 GiB */
>  	};
>  
> +	spdif_dit: audio-codec-0 {
> +		#sound-dai-cells = <0>;
> +		compatible = "linux,spdif-dit";
> +		status = "okay";
> +		sound-name-prefix = "DIT";
> +	};
> +
>  	leds {
>  		compatible = "gpio-leds";
>  
> @@ -51,6 +59,25 @@
>  		};
>  	};
>  
> +	vddio_ao18: regulator-vddio_ao18 {
> +		compatible = "regulator-fixed";
> +		regulator-name = "VDDIO_AO18";
> +		regulator-min-microvolt = <1800000>;
> +		regulator-max-microvolt = <1800000>;
> +	};
> +
> +	hdmi_5v: regulator-hdmi-5v {
> +		compatible = "regulator-fixed";
> +
> +		regulator-name = "HDMI_5V";
> +		regulator-min-microvolt = <5000000>;
> +		regulator-max-microvolt = <5000000>;
> +
> +		gpio = <&gpio GPIOH_3 GPIO_ACTIVE_HIGH>;
> +		enable-active-high;
> +		regulator-always-on;
> +	};

Same comment here ...

> +
>  	vddio_boot: regulator-vddio-boot {
>  		compatible = "regulator-fixed";
>  		regulator-name = "VDDIO_BOOT";
> @@ -90,6 +117,59 @@
>  		clocks = <&wifi32k>;
>  		clock-names = "ext_clock";
>  	};
> +
> +	sound {
> +		compatible = "amlogic,gx-sound-card";
> +		model = "GXM-RBOX-PRO";
> +		assigned-clocks = <&clkc CLKID_MPLL0>,
> +				  <&clkc CLKID_MPLL1>,
> +				  <&clkc CLKID_MPLL2>;
> +		assigned-clock-parents = <0>, <0>, <0>;
> +		assigned-clock-rates = <294912000>,
> +				       <270950400>,
> +				       <393216000>;
> +		status = "okay";
> +
> +		dai-link-0 {
> +			sound-dai = <&aiu AIU_CPU CPU_I2S_FIFO>;
> +		};
> +
> +		dai-link-1 {
> +			sound-dai = <&aiu AIU_CPU CPU_SPDIF_FIFO>;
> +		};
> +
> +		dai-link-2 {
> +			sound-dai = <&aiu AIU_CPU CPU_I2S_ENCODER>;
> +			dai-format = "i2s";
> +			mclk-fs = <256>;
> +
> +			codec-0 {
> +				sound-dai = <&aiu AIU_HDMI CTRL_I2S>;
> +			};
> +		};
> +
> +		dai-link-3 {
> +			sound-dai = <&aiu AIU_CPU CPU_SPDIF_ENCODER>;
> +
> +			codec-0 {
> +				sound-dai = <&spdif_dit>;
> +			};
> +		};
> +
> +		dai-link-4 {
> +			sound-dai = <&aiu AIU_HDMI CTRL_OUT>;
> +
> +			codec-0 {
> +				sound-dai = <&hdmi_tx>;
> +			};
> +		};
> +	};
> +};
> +
> +&aiu {
> +	status = "okay";
> +	pinctrl-0 = <&spdif_out_h_pins>;
> +	pinctrl-names = "default";
>  };
>  
>  &ethmac {

