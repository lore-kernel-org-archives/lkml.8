Return-Path: <SRS0=uMsS=BS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 71264C433E0
	for <linux-kernel@archiver.kernel.org>; Sat,  8 Aug 2020 21:23:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3C0BA206C3
	for <linux-kernel@archiver.kernel.org>; Sat,  8 Aug 2020 21:23:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=ideasonboard.com header.i=@ideasonboard.com header.b="JgLFQoiW"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726450AbgHHVXP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 8 Aug 2020 17:23:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46612 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726069AbgHHVXO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 8 Aug 2020 17:23:14 -0400
Received: from perceval.ideasonboard.com (perceval.ideasonboard.com [IPv6:2001:4b98:dc2:55:216:3eff:fef7:d647])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 44A74C061756;
        Sat,  8 Aug 2020 14:23:14 -0700 (PDT)
Received: from pendragon.ideasonboard.com (85-76-78-184-nat.elisa-mobile.fi [85.76.78.184])
        by perceval.ideasonboard.com (Postfix) with ESMTPSA id EFF39F9;
        Sat,  8 Aug 2020 23:23:11 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ideasonboard.com;
        s=mail; t=1596921792;
        bh=wah33bHeNU0X6YBF8nXGdLWbYvjbAVAO3ObRVCqsqvw=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=JgLFQoiWi57iObihazMl4yd8g/HAVBqOQh2n7NVAISahkNuovw1MA2wNN0WqAXufR
         gbs61mFJ3GcMG2LaC89FY5Zj7T6EQzV8ZOui5k9LHUEqyHF2i3kz1SX1B6ygIlskHY
         UcbhCA464dT1NrI0xfkPI+zuKRhlR5NOpDPSv2tA=
Date:   Sun, 9 Aug 2020 00:22:59 +0300
From:   Laurent Pinchart <laurent.pinchart@ideasonboard.com>
To:     Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
Cc:     Geert Uytterhoeven <geert+renesas@glider.be>,
        Kieran Bingham <kieran.bingham+renesas@ideasonboard.com>,
        David Airlie <airlied@linux.ie>,
        Rob Herring <robh+dt@kernel.org>,
        Magnus Damm <magnus.damm@gmail.com>,
        Daniel Vetter <daniel@ffwll.ch>,
        dri-devel@lists.freedesktop.org, linux-renesas-soc@vger.kernel.org,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        Prabhakar <prabhakar.csengg@gmail.com>
Subject: Re: [PATCH 7/7] ARM: dts: r8a7742-iwg21d-q7: Add LCD support
Message-ID: <20200808212259.GT6186@pendragon.ideasonboard.com>
References: <20200807174954.14448-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
 <20200807174954.14448-8-prabhakar.mahadev-lad.rj@bp.renesas.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20200807174954.14448-8-prabhakar.mahadev-lad.rj@bp.renesas.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Prabhakar,

Thank you for the patch.

On Fri, Aug 07, 2020 at 06:49:54PM +0100, Lad Prabhakar wrote:
> The iwg21d comes with a 7" capacitive touch screen, therefore
> add support for it.

I can't review most of this properly as I don't have access to the
schematics. Is there a way to get it ?

> Signed-off-by: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
> Reviewed-by: Marian-Cristian Rotariu <marian-cristian.rotariu.rb@bp.renesas.com>
> ---
>  arch/arm/boot/dts/r8a7742-iwg21d-q7.dts | 84 +++++++++++++++++++++++++
>  1 file changed, 84 insertions(+)
> 
> diff --git a/arch/arm/boot/dts/r8a7742-iwg21d-q7.dts b/arch/arm/boot/dts/r8a7742-iwg21d-q7.dts
> index b3461a61a4bf..cf59fd61e422 100644
> --- a/arch/arm/boot/dts/r8a7742-iwg21d-q7.dts
> +++ b/arch/arm/boot/dts/r8a7742-iwg21d-q7.dts
> @@ -30,6 +30,7 @@
>  
>  /dts-v1/;
>  #include "r8a7742-iwg21m.dtsi"
> +#include <dt-bindings/pwm/pwm.h>
>  
>  / {
>  	model = "iWave Systems RainboW-G21D-Qseven board based on RZ/G1H";
> @@ -52,6 +53,50 @@
>  		clock-frequency = <26000000>;
>  	};
>  
> +	lcd_backlight: backlight {
> +		compatible = "pwm-backlight";
> +		pwms = <&tpu 2 5000000 0>;
> +		brightness-levels = <0 4 8 16 32 64 128 255>;
> +		pinctrl-0 = <&backlight_pins>;
> +		pinctrl-names = "default";
> +		default-brightness-level = <7>;
> +		enable-gpios = <&gpio3 11 GPIO_ACTIVE_HIGH>;
> +	};
> +
> +	lvds-receiver {
> +		compatible = "ti,ds90cf384a", "lvds-decoder";
> +		powerdown-gpios = <&gpio5 28 GPIO_ACTIVE_LOW>;
> +
> +		ports {
> +			#address-cells = <1>;
> +			#size-cells = <0>;
> +
> +			port@0 {
> +				reg = <0>;
> +				lvds_receiver_in: endpoint {
> +					remote-endpoint = <&lvds0_out>;
> +				};
> +			};
> +			port@1 {
> +				reg = <1>;
> +				lvds_receiver_out: endpoint {
> +					remote-endpoint = <&panel_in>;
> +				};
> +			};
> +		};
> +	};
> +
> +	panel {
> +		compatible = "edt,etm0700g0dh6";
> +		backlight = <&lcd_backlight>;
> +
> +		port {
> +			panel_in: endpoint {
> +				remote-endpoint = <&lvds_receiver_out>;
> +			};
> +		};
> +	};
> +
>  	reg_1p5v: 1p5v {
>  		compatible = "regulator-fixed";
>  		regulator-name = "1P5V";
> @@ -129,12 +174,31 @@
>  		VDDIO-supply = <&reg_3p3v>;
>  		VDDD-supply = <&reg_1p5v>;
>  	};
> +
> +	touch: touchpanel@38 {
> +		compatible = "edt,edt-ft5406";
> +		reg = <0x38>;
> +		interrupt-parent = <&gpio0>;
> +		interrupts = <24 IRQ_TYPE_EDGE_FALLING>;
> +	};
>  };
>  
>  &cmt0 {
>  	status = "okay";
>  };
>  
> +&du {
> +	status = "okay";
> +};
> +
> +&gpio0 {
> +	touch-interrupt {
> +		gpio-hog;
> +		gpios = <24 GPIO_ACTIVE_LOW>;
> +		input;

Is this required, won't requesting the interrupt be enough to configure
the pin properly ?

> +	};
> +};
> +
>  &hsusb {
>  	pinctrl-0 = <&usb0_pins>;
>  	pinctrl-names = "default";
> @@ -165,6 +229,11 @@
>  		function = "avb";
>  	};
>  
> +	backlight_pins: backlight {
> +		groups = "tpu0_to2";
> +		function = "tpu0";
> +	};
> +
>  	i2c2_pins: i2c2 {
>  		groups = "i2c2_b";
>  		function = "i2c2";
> @@ -208,6 +277,17 @@
>  	};
>  };
>  
> +&lvds0 {
> +	status = "okay";
> +	ports {
> +		port@1 {
> +			lvds0_out: endpoint {
> +				remote-endpoint = <&lvds_receiver_in>;
> +			};
> +		};
> +	};
> +};
> +
>  &rcar_sound {
>  	pinctrl-0 = <&sound_pins>;
>  	pinctrl-names = "default";
> @@ -261,6 +341,10 @@
>  	shared-pin;
>  };
>  
> +&tpu {
> +	status = "okay";
> +};
> +
>  &usbphy {
>  	status = "okay";
>  };

-- 
Regards,

Laurent Pinchart
