Return-Path: <SRS0=jpuI=BA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.2 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,UNWANTED_LANGUAGE_BODY
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 48318C433EC
	for <linux-kernel@archiver.kernel.org>; Tue, 21 Jul 2020 08:18:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 20A772080D
	for <linux-kernel@archiver.kernel.org>; Tue, 21 Jul 2020 08:18:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20150623.gappssmtp.com header.i=@baylibre-com.20150623.gappssmtp.com header.b="zIIeo0cQ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728519AbgGUIS3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 21 Jul 2020 04:18:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53274 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726529AbgGUIS2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Jul 2020 04:18:28 -0400
Received: from mail-wm1-x343.google.com (mail-wm1-x343.google.com [IPv6:2a00:1450:4864:20::343])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9F496C0619D7
        for <linux-kernel@vger.kernel.org>; Tue, 21 Jul 2020 01:18:27 -0700 (PDT)
Received: by mail-wm1-x343.google.com with SMTP id c80so1914544wme.0
        for <linux-kernel@vger.kernel.org>; Tue, 21 Jul 2020 01:18:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=references:user-agent:from:to:subject:in-reply-to:date:message-id
         :mime-version;
        bh=uFols3Vwy8k+lqla1bufgTAtZft6D6LnLJ5Qc7u5vII=;
        b=zIIeo0cQiwEviByTgiHHNai5h5U5Rf782O2PWltyl3GbkQSbOanQbppvj3h0oSMWs1
         aKSrWnY895L/0WDPl4eqql+Hc2jz4xYDL0cdoy7YLcodAvW9U6dso7m3+X/fR6OvZPxe
         K3jQymDXl1HhwsU/GFhhOtifl9XS+5QmAMgmvmPSAzQwQHjUhu8317u7r4ZBuMnXt+TM
         FqP3+uK46+hYVyNzneHw/6aWzl0SSfzURKz2ovPhosS9ayCOBpw6vP4j2Pf3ABflegml
         mZAdA/jq7a4B1jlXP95xs2NEXfBdEr5tenut24DCP3N02+31flVpnC63sNnQViGAjXFA
         GFaA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:references:user-agent:from:to:subject
         :in-reply-to:date:message-id:mime-version;
        bh=uFols3Vwy8k+lqla1bufgTAtZft6D6LnLJ5Qc7u5vII=;
        b=gcFQVgeeqdEwJkMn77iN+ALFc5boZQO5eQnv88ZxzWRaD75MIJS+7XpGiB5QtuXVrN
         8E3NQiZZW3okqf6s3v1lPrpDx3bVIPAGoeeVTO1wO+QwG5gkaMi1PBeFzgUIYCtl73Oe
         hFumOLchYo8IhfSxmZ6N9CcplAzJdkxSHlOkVEkjS8neA3IqrR9flUneMiV+uE+zDmk6
         TxekEW7qfE2q4atGnYCtBL0jkFvc6pf9t9V7FCm6M1uey/cJmTY/5OnwG0bUmggP2+82
         It+MtRoARc1GG+sCLg7Fyr/3X5q9LgLG5WVzPdze8EOk2sKw3fdwYMBHO7aMPk+X7zxC
         8zTw==
X-Gm-Message-State: AOAM5331c0q1x05V+kpAukupH5XK6/zdqfZNpmQJjIbjHBvENRidTDet
        WcHZJkjSAM3M86nUWdyWuDFqZA==
X-Google-Smtp-Source: ABdhPJxaxh+KiYHr8PnZ0bN843vkvicXfutHx9gtMYIJpxCBwkEhTh9yheXqd/6ys9g0Xahm9ORLDg==
X-Received: by 2002:a7b:ca52:: with SMTP id m18mr2924047wml.92.1595319506349;
        Tue, 21 Jul 2020 01:18:26 -0700 (PDT)
Received: from localhost (laubervilliers-658-1-213-31.w90-63.abo.wanadoo.fr. [90.63.244.31])
        by smtp.gmail.com with ESMTPSA id u20sm2313872wmc.42.2020.07.21.01.18.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 21 Jul 2020 01:18:25 -0700 (PDT)
References: <20200718065739.7802-1-christianshewitt@gmail.com> <20200718065739.7802-5-christianshewitt@gmail.com>
User-agent: mu4e 1.3.3; emacs 26.3
From:   Jerome Brunet <jbrunet@baylibre.com>
To:     Christian Hewitt <christianshewitt@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Kevin Hilman <khilman@baylibre.com>,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-amlogic@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 04/12] arm64: dts: meson: add audio playback to nexbox-a1
In-reply-to: <20200718065739.7802-5-christianshewitt@gmail.com>
Date:   Tue, 21 Jul 2020 10:18:25 +0200
Message-ID: <1jwo2x8eni.fsf@starbuckisacylon.baylibre.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On Sat 18 Jul 2020 at 08:57, Christian Hewitt <christianshewitt@gmail.com> wrote:

> Add initial support is limited to HDMI i2s and SPDIF (LPCM).
>
> Signed-off-by: Christian Hewitt <christianshewitt@gmail.com>
> ---
>  .../boot/dts/amlogic/meson-gxm-nexbox-a1.dts  | 80 +++++++++++++++++++
>  1 file changed, 80 insertions(+)
>
> diff --git a/arch/arm64/boot/dts/amlogic/meson-gxm-nexbox-a1.dts b/arch/arm64/boot/dts/amlogic/meson-gxm-nexbox-a1.dts
> index 83eca3af44ce..faca6fafc164 100644
> --- a/arch/arm64/boot/dts/amlogic/meson-gxm-nexbox-a1.dts
> +++ b/arch/arm64/boot/dts/amlogic/meson-gxm-nexbox-a1.dts
> @@ -10,6 +10,7 @@
>  /dts-v1/;
>  
>  #include "meson-gxm.dtsi"
> +#include <dt-bindings/sound/meson-aiu.h>
>  
>  / {
>  	compatible = "nexbox,a1", "amlogic,s912", "amlogic,meson-gxm";
> @@ -24,11 +25,37 @@
>  		stdout-path = "serial0:115200n8";
>  	};
>  
> +	spdif_dit: audio-codec-0 {
> +		#sound-dai-cells = <0>;
> +		compatible = "linux,spdif-dit";
> +		status = "okay";
> +		sound-name-prefix = "DIT";
> +	};
> +
>  	memory@0 {
>  		device_type = "memory";
>  		reg = <0x0 0x0 0x0 0x80000000>;
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

Please explain how this is related to change decribed in the commit
description.

> +
>  	vddio_boot: regulator-vddio-boot {
>  		compatible = "regulator-fixed";
>  		regulator-name = "VDDIO_BOOT";
> @@ -75,6 +102,59 @@
>  			};
>  		};
>  	};
> +
> +	sound {
> +		compatible = "amlogic,gx-sound-card";
> +		model = "GXM-NEXBOX-A1";
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
>  &cec_AO {

