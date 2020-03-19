Return-Path: <SRS0=Q7wL=5E=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 79B9EC4332D
	for <linux-kernel@archiver.kernel.org>; Thu, 19 Mar 2020 16:10:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 519C52080C
	for <linux-kernel@archiver.kernel.org>; Thu, 19 Mar 2020 16:10:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=megous.com header.i=@megous.com header.b="m00v60jz"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728087AbgCSQKF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 19 Mar 2020 12:10:05 -0400
Received: from vps.xff.cz ([195.181.215.36]:59430 "EHLO vps.xff.cz"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727064AbgCSQKE (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Mar 2020 12:10:04 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=megous.com; s=mail;
        t=1584634202; bh=JE6As6CIZS8cuj7+7+rzHQMv4MweXNHp5Nj8F2f/1sA=;
        h=Date:From:To:Cc:Subject:References:X-My-GPG-KeyId:From;
        b=m00v60jzWPKSy4jXWtAUn2BxQ5ECTDL76y74ZABR/+zsxyxNzOa9abxC1yecgnHjx
         KyWqFQ4mWOj4PlpaJGOWIf7n5O1LgS0Mx1dDT4j3JRi//FLpLhUvc7wcVlo8MsbAN0
         kGfArbhAbc0qZa9JaF5PXOh0PrQ1KuPwEaZS+Odk=
Date:   Thu, 19 Mar 2020 17:10:02 +0100
From:   =?utf-8?Q?Ond=C5=99ej?= Jirman <megous@megous.com>
To:     Icenowy Zheng <icenowy@aosc.io>
Cc:     Thierry Reding <thierry.reding@gmail.com>,
        Sam Ravnborg <sam@ravnborg.org>,
        Rob Herring <robh+dt@kernel.org>,
        Maxime Ripard <mripard@kernel.org>,
        Chen-Yu Tsai <wens@csie.org>, dri-devel@lists.freedesktop.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-sunxi@googlegroups.com
Subject: Re: [linux-sunxi] [PATCH v2 5/5] arm64: allwinner: dts: a64: add
 LCD-related device nodes for PinePhone
Message-ID: <20200319161002.kmivhr3ouhoyn4bt@core.my.home>
Mail-Followup-To: =?utf-8?Q?Ond=C5=99ej?= Jirman <megous@megous.com>,
        Icenowy Zheng <icenowy@aosc.io>,
        Thierry Reding <thierry.reding@gmail.com>,
        Sam Ravnborg <sam@ravnborg.org>, Rob Herring <robh+dt@kernel.org>,
        Maxime Ripard <mripard@kernel.org>, Chen-Yu Tsai <wens@csie.org>,
        dri-devel@lists.freedesktop.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-sunxi@googlegroups.com
References: <20200316133503.144650-1-icenowy@aosc.io>
 <20200316133503.144650-6-icenowy@aosc.io>
 <d32e59aeb8395af1ae7ac2daa1ce985c56c14acc.camel@aosc.io>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <d32e59aeb8395af1ae7ac2daa1ce985c56c14acc.camel@aosc.io>
X-My-GPG-KeyId: EBFBDDE11FB918D44D1F56C1F9F0A873BE9777ED
 <https://xff.cz/key.txt>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Mar 19, 2020 at 10:51:36PM +0800, Icenowy Zheng wrote:
> 在 2020-03-16星期一的 21:35 +0800，Icenowy Zheng写道：
> > PinePhone uses PWM backlight and a XBD599 LCD panel over DSI for
> > display.
> > 
> > Add its device nodes.
> > 
> > Signed-off-by: Icenowy Zheng <icenowy@aosc.io>
> > ---
> > No changes in v2.
> > 
> >  .../dts/allwinner/sun50i-a64-pinephone.dtsi   | 37
> > +++++++++++++++++++
> >  1 file changed, 37 insertions(+)
> > 
> > diff --git a/arch/arm64/boot/dts/allwinner/sun50i-a64-pinephone.dtsi
> > b/arch/arm64/boot/dts/allwinner/sun50i-a64-pinephone.dtsi
> > index cefda145c3c9..96d9150423e0 100644
> > --- a/arch/arm64/boot/dts/allwinner/sun50i-a64-pinephone.dtsi
> > +++ b/arch/arm64/boot/dts/allwinner/sun50i-a64-pinephone.dtsi
> > @@ -16,6 +16,15 @@ aliases {
> >  		serial0 = &uart0;
> >  	};
> >  
> > +	backlight: backlight {
> > +		compatible = "pwm-backlight";
> > +		pwms = <&r_pwm 0 50000 PWM_POLARITY_INVERTED>;
> > +		brightness-levels = <0 16 18 20 22 24 26 29 32 35 38 42
> > 46 51 56 62 68 75 83 91 100>;
> 
> Should I drop the 0 here and replace it with 14?

Almost all boards in arm/boot/dts start at 0.

> I have heard community complaining about setting 0 to brightness make
> the screen black.

Level 0 (first value in the list) is special, and turns off the backlight:

123         if (brightness > 0) {
124                 pwm_get_state(pb->pwm, &state);
125                 state.duty_cycle = compute_duty_cycle(pb, brightness);
126                 pwm_apply_state(pb->pwm, &state);
127                 pwm_backlight_power_on(pb);
128         } else {
129                 pwm_backlight_power_off(pb);
130         }

	o.

> (I think in this situation bl_power or blank the DSI panel can still
> totally shut down the backlight).
> 
> > +		default-brightness-level = <15>;
> > +		enable-gpios = <&pio 7 10 GPIO_ACTIVE_HIGH>; /* PH10 */
> > +		power-supply = <&reg_ldo_io0>;
> > +	};
> > +
> >  	chosen {
> >  		stdout-path = "serial0:115200n8";
> >  	};
> > @@ -84,6 +93,30 @@ &dai {
> >  	status = "okay";
> >  };
> >  
> > +&de {
> > +	status = "okay";
> > +};
> > +
> > +&dphy {
> > +	status = "okay";
> > +};
> > +
> > +&dsi {
> > +	vcc-dsi-supply = <&reg_dldo1>;
> > +	#address-cells = <1>;
> > +	#size-cells = <0>;
> > +	status = "okay";
> > +
> > +	panel@0 {
> > +		compatible = "xingbangda,xbd599";
> > +		reg = <0>;
> > +		reset-gpios = <&pio 3 23 GPIO_ACTIVE_LOW>; /* PD23 */
> > +		iovcc-supply = <&reg_dldo2>;
> > +		vcc-supply = <&reg_ldo_io0>;
> > +		backlight = <&backlight>;
> > +	};
> > +};
> > +
> >  &ehci0 {
> >  	status = "okay";
> >  };
> > @@ -188,6 +221,10 @@ &r_pio {
> >  	 */
> >  };
> >  
> > +&r_pwm {
> > +	status = "okay";
> > +};
> > +
> >  &r_rsb {
> >  	status = "okay";
> >  
> > -- 
> > 2.24.1
> > 
> 
