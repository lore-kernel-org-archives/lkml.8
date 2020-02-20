Return-Path: <SRS0=NukP=4I=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6B1BCC11D05
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Feb 2020 14:17:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3EA21206E2
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Feb 2020 14:17:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=ideasonboard.com header.i=@ideasonboard.com header.b="KGwHxUG7"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728303AbgBTORq (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 20 Feb 2020 09:17:46 -0500
Received: from perceval.ideasonboard.com ([213.167.242.64]:54786 "EHLO
        perceval.ideasonboard.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727088AbgBTORp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Feb 2020 09:17:45 -0500
Received: from pendragon.ideasonboard.com (81-175-216-236.bb.dnainternet.fi [81.175.216.236])
        by perceval.ideasonboard.com (Postfix) with ESMTPSA id B7561563;
        Thu, 20 Feb 2020 15:17:43 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ideasonboard.com;
        s=mail; t=1582208263;
        bh=bI53Zug+890prNNaPfPGhR8GpYv+Klbg8yJ37Qnbv4A=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=KGwHxUG7b/Z2UkYUp9M/oxLXj3mb0DpKs8DSFQyfN6VrcdC9FiYW/vH3DHE9hKJiM
         qtAGmy5/ZUui2EMb2r4xc911A8o4H9PS8FCT7JlsTFVzthx1bNVc/UHvri25X+ueKc
         abTm7XDPazs+OtI+5sUlO+NXZFjNOd/npqA+0alY=
Date:   Thu, 20 Feb 2020 16:17:25 +0200
From:   Laurent Pinchart <laurent.pinchart@ideasonboard.com>
To:     Vasily Khoruzhick <anarsoul@gmail.com>
Cc:     Thierry Reding <thierry.reding@gmail.com>,
        Sam Ravnborg <sam@ravnborg.org>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Maxime Ripard <maxime@cerno.tech>,
        Chen-Yu Tsai <wens@csie.org>,
        Andrzej Hajda <a.hajda@samsung.com>,
        Neil Armstrong <narmstrong@baylibre.com>,
        Jonas Karlman <jonas@kwiboo.se>,
        Jernej Skrabec <jernej.skrabec@siol.net>,
        Icenowy Zheng <icenowy@aosc.io>, Torsten Duwe <duwe@suse.de>,
        Heiko Stuebner <heiko.stuebner@theobroma-systems.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        Stephan Gerhold <stephan@gerhold.net>,
        Mark Brown <broonie@kernel.org>,
        Stephen Rothwell <sfr@canb.auug.org.au>,
        Samuel Holland <samuel@sholland.org>,
        dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH 6/6] arm64: allwinner: a64: enable LCD-related hardware
 for Pinebook
Message-ID: <20200220141725.GG4998@pendragon.ideasonboard.com>
References: <20200220083508.792071-1-anarsoul@gmail.com>
 <20200220083508.792071-7-anarsoul@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20200220083508.792071-7-anarsoul@gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Vasily,

Thank you for the patch.

On Thu, Feb 20, 2020 at 12:35:08AM -0800, Vasily Khoruzhick wrote:
> From: Icenowy Zheng <icenowy@aosc.io>
> 
> Pinebook has an ANX6345 bridge connected to the RGB666 LCD output and
> eDP panel input. The bridge is controlled via I2C that's connected to
> R_I2C bus.
> 
> Enable all this hardware in device tree.
> 
> Signed-off-by: Icenowy Zheng <icenowy@aosc.io>
> Signed-off-by: Vasily Khoruzhick <anarsoul@gmail.com>
> ---
>  .../dts/allwinner/sun50i-a64-pinebook.dts     | 69 ++++++++++++++++++-
>  1 file changed, 68 insertions(+), 1 deletion(-)
> 
> diff --git a/arch/arm64/boot/dts/allwinner/sun50i-a64-pinebook.dts b/arch/arm64/boot/dts/allwinner/sun50i-a64-pinebook.dts
> index c06c540e6c08..f5633f550d8a 100644
> --- a/arch/arm64/boot/dts/allwinner/sun50i-a64-pinebook.dts
> +++ b/arch/arm64/boot/dts/allwinner/sun50i-a64-pinebook.dts
> @@ -48,6 +48,18 @@ lid_switch {
>  		};
>  	};
>  
> +	panel_edp: panel-edp {
> +		compatible = "neweast,wjfh116008a";
> +		backlight = <&backlight>;
> +		power-supply = <&reg_dc1sw>;
> +
> +		port {
> +			panel_edp_in: endpoint {
> +				remote-endpoint = <&anx6345_out_edp>;
> +			};
> +		};
> +	};
> +
>  	reg_vbklt: vbklt {
>  		compatible = "regulator-fixed";
>  		regulator-name = "vbklt";
> @@ -109,6 +121,10 @@ &dai {
>  	status = "okay";
>  };
>  
> +&de {
> +	status = "okay";
> +};
> +
>  &ehci0 {
>  	phys = <&usbphy 0>;
>  	phy-names = "usb";
> @@ -119,6 +135,10 @@ &ehci1 {
>  	status = "okay";
>  };
>  
> +&mixer0 {
> +	status = "okay";
> +};
> +
>  &mmc0 {
>  	pinctrl-names = "default";
>  	pinctrl-0 = <&mmc0_pins>;
> @@ -177,12 +197,45 @@ &pwm {
>  	status = "okay";
>  };
>  
> -/* The ANX6345 eDP-bridge is on r_i2c */
>  &r_i2c {
>  	clock-frequency = <100000>;
>  	pinctrl-names = "default";
>  	pinctrl-0 = <&r_i2c_pl89_pins>;
>  	status = "okay";
> +
> +	anx6345: anx6345@38 {
> +		compatible = "analogix,anx6345";
> +		reg = <0x38>;
> +		reset-gpios = <&pio 3 24 GPIO_ACTIVE_LOW>; /* PD24 */
> +		dvdd25-supply = <&reg_dldo2>;
> +		dvdd12-supply = <&reg_fldo1>;
> +
> +		ports {
> +			#address-cells = <1>;
> +			#size-cells = <0>;
> +
> +			anx6345_in: port@0 {
> +				#address-cells = <1>;
> +				#size-cells = <0>;
> +				reg = <0>;
> +				anx6345_in_tcon0: endpoint@0 {
> +					reg = <0>;
> +					remote-endpoint = <&tcon0_out_anx6345>;
> +				};

As there's a single endpoint, you can drop the reg property, the @0
suffix, and the #address-cells and #size-cells property in the port@0
node (but not in the ports node).

> +			};
> +
> +			anx6345_out: port@1 {
> +				#address-cells = <1>;
> +				#size-cells = <0>;
> +				reg = <1>;
> +
> +				anx6345_out_edp: endpoint@0 {
> +					reg = <0>;
> +					remote-endpoint = <&panel_edp_in>;
> +				};

Same here.

Reviewed-by: Laurent Pinchart <laurent.pinchart@ideasonboard.com>

> +			};
> +		};
> +	};
>  };
>  
>  &r_pio {
> @@ -357,6 +410,20 @@ &sound {
>  			"MIC2", "Internal Microphone Right";
>  };
>  
> +&tcon0 {
> +	pinctrl-names = "default";
> +	pinctrl-0 = <&lcd_rgb666_pins>;
> +
> +	status = "okay";
> +};
> +
> +&tcon0_out {
> +	tcon0_out_anx6345: endpoint@0 {
> +		reg = <0>;
> +		remote-endpoint = <&anx6345_in_tcon0>;
> +	};
> +};
> +
>  &uart0 {
>  	pinctrl-names = "default";
>  	pinctrl-0 = <&uart0_pb_pins>;

-- 
Regards,

Laurent Pinchart
