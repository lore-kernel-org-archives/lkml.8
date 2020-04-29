Return-Path: <SRS0=ObIu=6N=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9FFFCC8300A
	for <linux-kernel@archiver.kernel.org>; Wed, 29 Apr 2020 19:11:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8272C205C9
	for <linux-kernel@archiver.kernel.org>; Wed, 29 Apr 2020 19:11:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20150623.gappssmtp.com header.i=@baylibre-com.20150623.gappssmtp.com header.b="qcTL7rWJ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727049AbgD2TLG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 29 Apr 2020 15:11:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49226 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726456AbgD2TLF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Apr 2020 15:11:05 -0400
Received: from mail-wr1-x441.google.com (mail-wr1-x441.google.com [IPv6:2a00:1450:4864:20::441])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1445EC035493
        for <linux-kernel@vger.kernel.org>; Wed, 29 Apr 2020 12:11:05 -0700 (PDT)
Received: by mail-wr1-x441.google.com with SMTP id j2so3890019wrs.9
        for <linux-kernel@vger.kernel.org>; Wed, 29 Apr 2020 12:11:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=references:user-agent:from:to:subject:in-reply-to:date:message-id
         :mime-version;
        bh=HwBlAhl9IzjqWMkaY5fyYm/8tsGpWsJDdfPbj+qf/cw=;
        b=qcTL7rWJWMCsNYOvmkLnkfwL1OYQTFMr1oCDP+/LG+yoZ54Rb09KxnGDEhScoCYRWF
         H4Q948HySr2ev6c5+yXIJk0A7XgdS9Jt3n5zOvgZKwn5N+n/aQSPjIl4Gf4r4dHVsHSg
         RvkXVOyk5xjFz/WTsFhLoJro+kI6XofIpdZKh8fLCvAcvWp1ZRbzSB86WvgZ12nBDKN4
         awslm7Rk+FHcP8VphplAImX5lym/fvkXDhdhz7pvJ9MLmKnFP+K3Suau4ZfAzHeXFHz1
         iPHQ2IVMe8S4FWhMm2gEO/iyjzisibU4+dyYf1sMXI8acPoXKyG8lI9ahmeW+YAHoovv
         VOyw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:references:user-agent:from:to:subject
         :in-reply-to:date:message-id:mime-version;
        bh=HwBlAhl9IzjqWMkaY5fyYm/8tsGpWsJDdfPbj+qf/cw=;
        b=i+ImA18XhqSE/tK4f2XS6fhQGWakRxfd9b3Xk/zsfYpu1ECckxF3GOVaXkdCJK9Uzs
         E8NkfCkWhbB9fTgqQySQKvvp88L9XdW8x/tVVFT4cc32PggKnubWGuDlhOEOUZnalvo6
         ObrFaMNBjNdevUKsDlBWxyAyI+5BH7nAl3n0dgGmqxZ/tRXAG2OjN0Ahc3gCD6QZekht
         IwobzZKS9EZpP6i5Pkd2Hgz7Gw5daHyLE3G6tmpEtnbLK8ONqOyMn1KFkjPN0/NOIxIW
         CBhxdbQQqndutJJ+7jitwvmOizXB9Udns/eHzPTIIB77XD998fBq9kB9lZJ3c+l2YbyO
         VnIQ==
X-Gm-Message-State: AGi0PuZo/+rCDNOVBNiitXOnV8HxBUbgvb+BAGLCaoEqwcHc9gLvZXA7
        0U5WrVTyatCCfiJl1f83K5elKA==
X-Google-Smtp-Source: APiQypKJQgl13isxg5O+xfkBHxn3MAO2tiktrpReGj1EhlU4/X2r3NgW/pVCXn/XoI3DnPrTA122NQ==
X-Received: by 2002:adf:cd84:: with SMTP id q4mr38584918wrj.320.1588187463599;
        Wed, 29 Apr 2020 12:11:03 -0700 (PDT)
Received: from localhost (cag06-3-82-243-161-21.fbx.proxad.net. [82.243.161.21])
        by smtp.gmail.com with ESMTPSA id m8sm254005wrx.54.2020.04.29.12.11.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 29 Apr 2020 12:11:02 -0700 (PDT)
References: <20200415102320.4606-1-christianshewitt@gmail.com>
User-agent: mu4e 1.3.3; emacs 26.3
From:   Jerome Brunet <jbrunet@baylibre.com>
To:     chewitt <christianshewitt@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Kevin Hilman <khilman@baylibre.com>,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-amlogic@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] arm64: dts: meson: sm1-khadas-vim3l: add audio playback to vim3l
In-reply-to: <20200415102320.4606-1-christianshewitt@gmail.com>
Date:   Wed, 29 Apr 2020 21:11:02 +0200
Message-ID: <1jmu6uhzuh.fsf@starbuckisacylon.baylibre.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On Wed 15 Apr 2020 at 12:23, chewitt <christianshewitt@gmail.com> wrote:

> From: Christian Hewitt <christianshewitt@gmail.com>
>
> Add the sound and related audio nodes to the VIM3L board.
>
> Signed-off-by: Christian Hewitt <christianshewitt@gmail.com>
> ---
>  .../dts/amlogic/meson-sm1-khadas-vim3l.dts    | 88 +++++++++++++++++++
>  1 file changed, 88 insertions(+)
>
> diff --git a/arch/arm64/boot/dts/amlogic/meson-sm1-khadas-vim3l.dts b/arch/arm64/boot/dts/amlogic/meson-sm1-khadas-vim3l.dts
> index dbbf29a0dbf6..b900a433ef7a 100644
> --- a/arch/arm64/boot/dts/amlogic/meson-sm1-khadas-vim3l.dts
> +++ b/arch/arm64/boot/dts/amlogic/meson-sm1-khadas-vim3l.dts
> @@ -8,6 +8,7 @@
>  
>  #include "meson-sm1.dtsi"
>  #include "meson-khadas-vim3.dtsi"
> +#include <dt-bindings/sound/meson-g12a-tohdmitx.h>
>  
>  / {
>  	compatible = "khadas,vim3l", "amlogic,sm1";
> @@ -31,6 +32,69 @@
>  		regulator-boot-on;
>  		regulator-always-on;
>  	};
> +
> +	sound {
> +		compatible = "amlogic,axg-sound-card";
> +		model = "SM1-KHADAS-VIM3L";
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

VIM3(L) should not use TDMOUT B or C for the HDMI interface
* B is on the 40pin header
* C is on the m2 connector

A is not routed to the outside world and should prefered for this.

See :
https://lore.kernel.org/linux-amlogic/20200421141814.639480-1-jbrunet@baylibre.com/

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
> +&clkc_audio {
> +	status = "okay";
>  };
>  
>  &cpu0 {
> @@ -61,6 +125,18 @@
>  	clock-latency = <50000>;
>  };
>  
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
>  &pwm_AO_cd {
>  	pinctrl-0 = <&pwm_ao_d_e_pins>;
>  	pinctrl-names = "default";
> @@ -93,3 +169,15 @@
>  	phy-names = "usb2-phy0", "usb2-phy1";
>  };
>   */
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

