Return-Path: <SRS0=jpuI=BA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.0 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 67429C433DF
	for <linux-kernel@archiver.kernel.org>; Tue, 21 Jul 2020 08:09:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 373DC2080D
	for <linux-kernel@archiver.kernel.org>; Tue, 21 Jul 2020 08:09:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20150623.gappssmtp.com header.i=@baylibre-com.20150623.gappssmtp.com header.b="pOt1GBD7"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728072AbgGUIJZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 21 Jul 2020 04:09:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51886 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725984AbgGUIJZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Jul 2020 04:09:25 -0400
Received: from mail-wr1-x442.google.com (mail-wr1-x442.google.com [IPv6:2a00:1450:4864:20::442])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B1AADC061794
        for <linux-kernel@vger.kernel.org>; Tue, 21 Jul 2020 01:09:24 -0700 (PDT)
Received: by mail-wr1-x442.google.com with SMTP id q5so20231421wru.6
        for <linux-kernel@vger.kernel.org>; Tue, 21 Jul 2020 01:09:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=references:user-agent:from:to:subject:in-reply-to:date:message-id
         :mime-version;
        bh=DGQiBnudDDICkkg4xVI7HW77Z0RigV8LIlLadbU+EEQ=;
        b=pOt1GBD79wodpEEnJKqsbHLQBYjgXCYPSIAtjLHVfjAvHSMCpGXHkNl2hiqSRHV4Dn
         i/dmGtoz8SVUHBJkkOpMzfkuQ0Uhkt06fasqf3Fzw+r+05rKMbbkb1QLbZi3iZh3kmrR
         d7CS5BPoQdV1a9V7+A2DAzJ4TKkYm6qeWip4sv5yORePAserRGanXb1s9gkB6k684EFk
         0WBYLSmIyAN0aPhuUX8PkLYWU3au4Cej8zBjetTQ+zqMc6TT5ep3qTmgvxJJh+aV5tLc
         1bnQcrX3REmhzdl1gweGYyDwBqtfANbyKSKUIb9irV18E2pMKxusDYUYzqQDLq+8XwRY
         8f+A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:references:user-agent:from:to:subject
         :in-reply-to:date:message-id:mime-version;
        bh=DGQiBnudDDICkkg4xVI7HW77Z0RigV8LIlLadbU+EEQ=;
        b=aUjkDEYNG4ctAI77u6penxgS8g9JsBAWZxdSJhXLVdZDbO3wpdpTEv9SVTBJ2QkVHn
         11gpsPdbODNMmQJJxblZ25OH/g0dThmV1FpCXmEJeSFgZtWNuPIk0QxlSoiW1U9HZAS7
         /ZjILPrH4+Ix28VOYUpxHozlInaSqDjuk3zYT6F59QtDZtFidXHwPbLEvgnpMqYFJG7c
         E596MNvrVAx9Wc6XFH99lETHWUwb2pM94+IxvWhMO9sSw9VJCVJDy/i/FPVyNYTsGySm
         6K+fUTZtV+AtBLqnCcq4jzqL1qFHFyUaRer046Vn+ZeLhQ4DAVOhqylb1A0FJyxgtYFr
         8lkQ==
X-Gm-Message-State: AOAM532ToQ+4mbQuyavcENiZ8jzhvJKFPFxMkt6xjSqv2fcalRIgzy6J
        PASxtcgN5nZ6BbuPj2lpo3bVGw==
X-Google-Smtp-Source: ABdhPJx/gcL0C20PlaU7xNS8FDsl7n66y1Y9HoeAVCVF/CO4s1gXYPovy87PbavDyBgnD3TTrt0DHw==
X-Received: by 2002:a5d:4bc8:: with SMTP id l8mr24973415wrt.159.1595318963399;
        Tue, 21 Jul 2020 01:09:23 -0700 (PDT)
Received: from localhost (laubervilliers-658-1-213-31.w90-63.abo.wanadoo.fr. [90.63.244.31])
        by smtp.gmail.com with ESMTPSA id c24sm11466819wrb.11.2020.07.21.01.09.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 21 Jul 2020 01:09:21 -0700 (PDT)
References: <20200718052258.2890-1-christianshewitt@gmail.com> <20200718052258.2890-2-christianshewitt@gmail.com>
User-agent: mu4e 1.3.3; emacs 26.3
From:   Jerome Brunet <jbrunet@baylibre.com>
To:     Christian Hewitt <christianshewitt@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Kevin Hilman <khilman@baylibre.com>,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-amlogic@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/2] arm64: dts: meson: add initial Beelink GS-King-X device-tree
In-reply-to: <20200718052258.2890-2-christianshewitt@gmail.com>
Date:   Tue, 21 Jul 2020 10:09:20 +0200
Message-ID: <1jy2nd8f2n.fsf@starbuckisacylon.baylibre.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On Sat 18 Jul 2020 at 07:22, Christian Hewitt <christianshewitt@gmail.com> wrote:

> The Shenzen AZW (Beelink) GS-King-X is based on the Amlogic W400 reference
> board with an S922X-H chip.
>
> - 4GB LPDDR4 RAM
> - 64GB eMMC storage
> - 10/100/1000 Base-T Ethernet
> - AP6356S Wireless (802.11 a/b/g/n/ac, BT 4.1)
> - HDMI 2.1 video
> - S/PDIF optical output
> - 2x ESS9018 audio DACs
> - 4x Ricor RT6862 audio amps
> - Analogue headphone output
> - 1x USB 2.0 OTG port
> - 3x USB 3.0 ports
> - IR receiver
> - 1x micro SD card slot (internal)
> - USB SATA controller with 2x 3.5" drive bays
> - 1x Power on/off button
>
> Signed-off-by: Christian Hewitt <christianshewitt@gmail.com>
> ---
>  arch/arm64/boot/dts/amlogic/Makefile          |   1 +
>  .../boot/dts/amlogic/meson-g12b-gsking-x.dts  | 170 ++++++++++++++++++
>  2 files changed, 171 insertions(+)
>  create mode 100644 arch/arm64/boot/dts/amlogic/meson-g12b-gsking-x.dts
>
> diff --git a/arch/arm64/boot/dts/amlogic/Makefile b/arch/arm64/boot/dts/amlogic/Makefile
> index 5cac4d1d487d..99a6e8e0b644 100644
> --- a/arch/arm64/boot/dts/amlogic/Makefile
> +++ b/arch/arm64/boot/dts/amlogic/Makefile
> @@ -3,6 +3,7 @@ dtb-$(CONFIG_ARCH_MESON) += meson-axg-s400.dtb
>  dtb-$(CONFIG_ARCH_MESON) += meson-g12a-sei510.dtb
>  dtb-$(CONFIG_ARCH_MESON) += meson-g12a-u200.dtb
>  dtb-$(CONFIG_ARCH_MESON) += meson-g12a-x96-max.dtb
> +dtb-$(CONFIG_ARCH_MESON) += meson-g12b-gsking-x.dtb
>  dtb-$(CONFIG_ARCH_MESON) += meson-g12b-gtking.dtb
>  dtb-$(CONFIG_ARCH_MESON) += meson-g12b-gtking-pro.dtb
>  dtb-$(CONFIG_ARCH_MESON) += meson-g12b-a311d-khadas-vim3.dtb
> diff --git a/arch/arm64/boot/dts/amlogic/meson-g12b-gsking-x.dts b/arch/arm64/boot/dts/amlogic/meson-g12b-gsking-x.dts
> new file mode 100644
> index 000000000000..60b681d6cfe3
> --- /dev/null
> +++ b/arch/arm64/boot/dts/amlogic/meson-g12b-gsking-x.dts
> @@ -0,0 +1,170 @@
> +// SPDX-License-Identifier: (GPL-2.0+ OR MIT)
> +/*
> + * Copyright (c) 2019 BayLibre, SAS
> + * Author: Neil Armstrong <narmstrong@baylibre.com>
> + * Copyright (c) 2019 Christian Hewitt <christianshewitt@gmail.com>
> + */
> +
> +/dts-v1/;
> +
> +#include "meson-g12b-w400.dtsi"
> +#include <dt-bindings/leds/common.h>
> +#include <dt-bindings/sound/meson-g12a-tohdmitx.h>
> +
> +/ {
> +	compatible = "azw,gsking-x", "amlogic,g12b";
> +	model = "Beelink GS-King X";
> +
> +	gpio-keys-polled {
> +		compatible = "gpio-keys-polled";
> +		#address-cells = <1>;
> +		#size-cells = <0>;
> +		poll-interval = <100>;
> +
> +		power-button {
> +			label = "power";
> +			linux,code = <KEY_POWER>;
> +			gpios = <&gpio_ao GPIOAO_3 GPIO_ACTIVE_HIGH>;
> +		};
> +	};
> +
> +	leds {
> +		compatible = "gpio-leds";
> +
> +		blue {
> +			color = <LED_COLOR_ID_BLUE>;
> +			function = LED_FUNCTION_STATUS;
> +			gpios = <&gpio_ao GPIOAO_11 GPIO_ACTIVE_HIGH>;
> +			default-state = "on";
> +		};
> +	};
> +
> +	spdif_dit: audio-codec-1 {
> +		#sound-dai-cells = <0>;
> +		compatible = "linux,spdif-dit";
> +		status = "okay";
> +		sound-name-prefix = "DIT";
> +	};
> +
> +	sound {
> +		compatible = "amlogic,axg-sound-card";
> +		model = "G12B-GSKING-X";
> +		audio-aux-devs = <&tdmout_b>;
> +		audio-routing = "TDMOUT_B IN 0", "FRDDR_A OUT 1",
> +				"TDMOUT_B IN 1", "FRDDR_B OUT 1",
> +				"TDMOUT_B IN 2", "FRDDR_C OUT 1",
> +				"TDM_B Playback", "TDMOUT_B OUT",
> +				"SPDIFOUT IN 0", "FRDDR_A OUT 3",
> +				"SPDIFOUT IN 1", "FRDDR_B OUT 3",
> +				"SPDIFOUT IN 2", "FRDDR_C OUT 3";
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
> +		/* spdif hdmi or toslink interface */
> +		dai-link-4 {
> +			sound-dai = <&spdifout>;
> +
> +			codec-0 {
> +				sound-dai = <&spdif_dit>;
> +			};
> +
> +			codec-1 {
> +				sound-dai = <&tohdmitx TOHDMITX_SPDIF_IN_A>;
> +			};
> +		};
> +
> +		/* spdif hdmi interface */
> +		dai-link-5 {
> +			sound-dai = <&spdifout_b>;
> +
> +			codec {
> +				sound-dai = <&tohdmitx TOHDMITX_SPDIF_IN_B>;
> +			};
> +		};

This can't have been tested, it is not not supported by the HDMI
controller. Also spdifout B is not even connected to a FIFO interface,
there is not route to it

Please drop the HDMI-SPDIF related stuff, include spdifout_b

> +
> +		/* hdmi glue */
> +		dai-link-6 {
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
> +&clkc_audio {
> +	status = "okay";
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
> +&spdifout {
> +	pinctrl-0 = <&spdif_out_h_pins>;
> +	pinctrl-names = "default";
> +	status = "okay";
> +};
> +
> +&spdifout_b {
> +	status = "okay";
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

