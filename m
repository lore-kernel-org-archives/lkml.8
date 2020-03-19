Return-Path: <SRS0=Q7wL=5E=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 05501C4332B
	for <linux-kernel@archiver.kernel.org>; Thu, 19 Mar 2020 14:52:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CB69B20782
	for <linux-kernel@archiver.kernel.org>; Thu, 19 Mar 2020 14:52:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=aosc.io header.i=@aosc.io header.b="o7VpwL9T"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727612AbgCSOwD (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 19 Mar 2020 10:52:03 -0400
Received: from hermes.aosc.io ([199.195.250.187]:47676 "EHLO hermes.aosc.io"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726943AbgCSOwC (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Mar 2020 10:52:02 -0400
Received: from localhost (localhost [127.0.0.1]) (Authenticated sender: icenowy@aosc.io)
        by hermes.aosc.io (Postfix) with ESMTPSA id 15C8C4C7F0;
        Thu, 19 Mar 2020 14:51:49 +0000 (UTC)
Message-ID: <d32e59aeb8395af1ae7ac2daa1ce985c56c14acc.camel@aosc.io>
Subject: Re: [linux-sunxi] [PATCH v2 5/5] arm64: allwinner: dts: a64: add
 LCD-related device nodes for PinePhone
From:   Icenowy Zheng <icenowy@aosc.io>
To:     Thierry Reding <thierry.reding@gmail.com>,
        Sam Ravnborg <sam@ravnborg.org>,
        Rob Herring <robh+dt@kernel.org>,
        Maxime Ripard <mripard@kernel.org>,
        Chen-Yu Tsai <wens@csie.org>, Ondrej Jirman <megous@megous.com>
Cc:     dri-devel@lists.freedesktop.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-sunxi@googlegroups.com
Date:   Thu, 19 Mar 2020 22:51:36 +0800
In-Reply-To: <20200316133503.144650-6-icenowy@aosc.io>
References: <20200316133503.144650-1-icenowy@aosc.io>
         <20200316133503.144650-6-icenowy@aosc.io>
Content-Type: text/plain; charset="UTF-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=aosc.io; s=dkim;
        t=1584629521;
        h=from:subject:date:message-id:to:cc:mime-version:content-type:content-transfer-encoding:in-reply-to:references;
        bh=p5Ck7dUiaERSo0QVXTsJS7JDgXxthBKb9LsSdQI8mXo=;
        b=o7VpwL9TrDlUsvQeexpwLURHqEq8rejngmj+gnMy03J0jB/SMkZO1e6NwjBPfVaszHVf1e
        SlvcX4TTjNKpkULnFXRvaxuIelgtPfyfZAd8bYOGtiRdwbs8acvJJU3uviggbQlY9O9Mv+
        QoltOKGJe07JmvTwJPNdAQJ2EcrtG20=
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

在 2020-03-16星期一的 21:35 +0800，Icenowy Zheng写道：
> PinePhone uses PWM backlight and a XBD599 LCD panel over DSI for
> display.
> 
> Add its device nodes.
> 
> Signed-off-by: Icenowy Zheng <icenowy@aosc.io>
> ---
> No changes in v2.
> 
>  .../dts/allwinner/sun50i-a64-pinephone.dtsi   | 37
> +++++++++++++++++++
>  1 file changed, 37 insertions(+)
> 
> diff --git a/arch/arm64/boot/dts/allwinner/sun50i-a64-pinephone.dtsi
> b/arch/arm64/boot/dts/allwinner/sun50i-a64-pinephone.dtsi
> index cefda145c3c9..96d9150423e0 100644
> --- a/arch/arm64/boot/dts/allwinner/sun50i-a64-pinephone.dtsi
> +++ b/arch/arm64/boot/dts/allwinner/sun50i-a64-pinephone.dtsi
> @@ -16,6 +16,15 @@ aliases {
>  		serial0 = &uart0;
>  	};
>  
> +	backlight: backlight {
> +		compatible = "pwm-backlight";
> +		pwms = <&r_pwm 0 50000 PWM_POLARITY_INVERTED>;
> +		brightness-levels = <0 16 18 20 22 24 26 29 32 35 38 42
> 46 51 56 62 68 75 83 91 100>;

Should I drop the 0 here and replace it with 14?

I have heard community complaining about setting 0 to brightness make
the screen black.

(I think in this situation bl_power or blank the DSI panel can still
totally shut down the backlight).

> +		default-brightness-level = <15>;
> +		enable-gpios = <&pio 7 10 GPIO_ACTIVE_HIGH>; /* PH10 */
> +		power-supply = <&reg_ldo_io0>;
> +	};
> +
>  	chosen {
>  		stdout-path = "serial0:115200n8";
>  	};
> @@ -84,6 +93,30 @@ &dai {
>  	status = "okay";
>  };
>  
> +&de {
> +	status = "okay";
> +};
> +
> +&dphy {
> +	status = "okay";
> +};
> +
> +&dsi {
> +	vcc-dsi-supply = <&reg_dldo1>;
> +	#address-cells = <1>;
> +	#size-cells = <0>;
> +	status = "okay";
> +
> +	panel@0 {
> +		compatible = "xingbangda,xbd599";
> +		reg = <0>;
> +		reset-gpios = <&pio 3 23 GPIO_ACTIVE_LOW>; /* PD23 */
> +		iovcc-supply = <&reg_dldo2>;
> +		vcc-supply = <&reg_ldo_io0>;
> +		backlight = <&backlight>;
> +	};
> +};
> +
>  &ehci0 {
>  	status = "okay";
>  };
> @@ -188,6 +221,10 @@ &r_pio {
>  	 */
>  };
>  
> +&r_pwm {
> +	status = "okay";
> +};
> +
>  &r_rsb {
>  	status = "okay";
>  
> -- 
> 2.24.1
> 

