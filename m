Return-Path: <SRS0=NukP=4I=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B93A8C11D25
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Feb 2020 21:38:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8600C208E4
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Feb 2020 21:38:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="rQTVaInb"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729236AbgBTViJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 20 Feb 2020 16:38:09 -0500
Received: from mail-qt1-f195.google.com ([209.85.160.195]:43594 "EHLO
        mail-qt1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727561AbgBTViJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Feb 2020 16:38:09 -0500
Received: by mail-qt1-f195.google.com with SMTP id g21so4009287qtq.10
        for <linux-kernel@vger.kernel.org>; Thu, 20 Feb 2020 13:38:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=ya7BzNWkK/aNL6Tv2iIJrxyXJnuSHN2DAiGDBEKCFME=;
        b=rQTVaInbOR0nNBRyjg7OUiy8zpk8uVI/C0yvF8JrYqzIEQXaLVgUUhJRN1dp8pKmNm
         Gwz9SKu9e2EeGhGibjXdXOkIWcD65V5R0kSHQo/FV8h/yDspwYoe45a0PxLatb83l2R2
         E+gKsNlBxI/ALyh7kYSXTVAZqLVIqD1E9iGgDyO2G+22xyqxeW2MvHdqZdc0W14QJYTg
         2f96GaDm7RjwtN9iVrbBKVYzKK61yLmEFQTwQqwxAVhOpMiVh+lWjrYiqOjcNWiCuzsd
         sjrS1O0nXJqPVxmVmzKMUoIMysA64KkWboAHu9Tn9hwDODRe1zlRhxtx+7BVuZW96B3M
         t8fg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=ya7BzNWkK/aNL6Tv2iIJrxyXJnuSHN2DAiGDBEKCFME=;
        b=BixUIP5aigBGdqMU+K4vWF3NMqMeu0/kA6Zol1/cP91ovcdAT2A2tUhePtgLVTKr/0
         Jq4I2vOqOdYWKYZrneMuJjphuen3syacCfeSrQE6CtMFJSwo/98yrrExc7uLiYs+7C1k
         2+wI5NotV8EUUWNJSBvDsD0nUpCz2Rzudj6JaxVe5vOXAdVlYhF1ekMMJdtb7IMKPSs7
         WY42OgvQ+hWNc47R/z07qfX0Ozo2uM2BAqvP2v3tq2Ot8xLGFhsutTdoQgM9Jm6s0z27
         lDUdMlilANAZvw5+kgQuZ1yAS/HxdfXQCRpU9QYo9CNs2Yf1HU1Aw6p2PSRZ3TshgwSW
         eo2Q==
X-Gm-Message-State: APjAAAWBKtF5IThlYe+DYYxcSwWiK2KWa7sAZm7qD1CkNnzSyuS5/OPk
        MQ+eN0XuV6n5sFRxX1NLQaVM+vMMrCCa+39Sg6M=
X-Google-Smtp-Source: APXvYqx9EZC0JNyWfusuB4QXxIWZmS+pIpitlsLm35JVfJohfpkIicI2phemogyTKUpyQwwnIXHCmtWvSi7373Q46BM=
X-Received: by 2002:aed:2510:: with SMTP id v16mr28785378qtc.306.1582234686749;
 Thu, 20 Feb 2020 13:38:06 -0800 (PST)
MIME-Version: 1.0
References: <20200220083508.792071-1-anarsoul@gmail.com> <20200220083508.792071-7-anarsoul@gmail.com>
 <20200220141725.GG4998@pendragon.ideasonboard.com>
In-Reply-To: <20200220141725.GG4998@pendragon.ideasonboard.com>
From:   Vasily Khoruzhick <anarsoul@gmail.com>
Date:   Thu, 20 Feb 2020 13:37:53 -0800
Message-ID: <CA+E=qVe7vMwK3m-AfTiK+mL=9+rD7dNWjYSXBLgZZnMU1zPeSg@mail.gmail.com>
Subject: Re: [PATCH 6/6] arm64: allwinner: a64: enable LCD-related hardware
 for Pinebook
To:     Laurent Pinchart <laurent.pinchart@ideasonboard.com>
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
        dri-devel <dri-devel@lists.freedesktop.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        arm-linux <linux-arm-kernel@lists.infradead.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Feb 20, 2020 at 6:17 AM Laurent Pinchart
<laurent.pinchart@ideasonboard.com> wrote:
>
> Hi Vasily,

Hi Laurent,

> Thank you for the patch.
>
> On Thu, Feb 20, 2020 at 12:35:08AM -0800, Vasily Khoruzhick wrote:
> > From: Icenowy Zheng <icenowy@aosc.io>
> >
> > Pinebook has an ANX6345 bridge connected to the RGB666 LCD output and
> > eDP panel input. The bridge is controlled via I2C that's connected to
> > R_I2C bus.
> >
> > Enable all this hardware in device tree.
> >
> > Signed-off-by: Icenowy Zheng <icenowy@aosc.io>
> > Signed-off-by: Vasily Khoruzhick <anarsoul@gmail.com>
> > ---
> >  .../dts/allwinner/sun50i-a64-pinebook.dts     | 69 ++++++++++++++++++-
> >  1 file changed, 68 insertions(+), 1 deletion(-)
> >
> > diff --git a/arch/arm64/boot/dts/allwinner/sun50i-a64-pinebook.dts b/arch/arm64/boot/dts/allwinner/sun50i-a64-pinebook.dts
> > index c06c540e6c08..f5633f550d8a 100644
> > --- a/arch/arm64/boot/dts/allwinner/sun50i-a64-pinebook.dts
> > +++ b/arch/arm64/boot/dts/allwinner/sun50i-a64-pinebook.dts
> > @@ -48,6 +48,18 @@ lid_switch {
> >               };
> >       };
> >
> > +     panel_edp: panel-edp {
> > +             compatible = "neweast,wjfh116008a";
> > +             backlight = <&backlight>;
> > +             power-supply = <&reg_dc1sw>;
> > +
> > +             port {
> > +                     panel_edp_in: endpoint {
> > +                             remote-endpoint = <&anx6345_out_edp>;
> > +                     };
> > +             };
> > +     };
> > +
> >       reg_vbklt: vbklt {
> >               compatible = "regulator-fixed";
> >               regulator-name = "vbklt";
> > @@ -109,6 +121,10 @@ &dai {
> >       status = "okay";
> >  };
> >
> > +&de {
> > +     status = "okay";
> > +};
> > +
> >  &ehci0 {
> >       phys = <&usbphy 0>;
> >       phy-names = "usb";
> > @@ -119,6 +135,10 @@ &ehci1 {
> >       status = "okay";
> >  };
> >
> > +&mixer0 {
> > +     status = "okay";
> > +};
> > +
> >  &mmc0 {
> >       pinctrl-names = "default";
> >       pinctrl-0 = <&mmc0_pins>;
> > @@ -177,12 +197,45 @@ &pwm {
> >       status = "okay";
> >  };
> >
> > -/* The ANX6345 eDP-bridge is on r_i2c */
> >  &r_i2c {
> >       clock-frequency = <100000>;
> >       pinctrl-names = "default";
> >       pinctrl-0 = <&r_i2c_pl89_pins>;
> >       status = "okay";
> > +
> > +     anx6345: anx6345@38 {
> > +             compatible = "analogix,anx6345";
> > +             reg = <0x38>;
> > +             reset-gpios = <&pio 3 24 GPIO_ACTIVE_LOW>; /* PD24 */
> > +             dvdd25-supply = <&reg_dldo2>;
> > +             dvdd12-supply = <&reg_fldo1>;
> > +
> > +             ports {
> > +                     #address-cells = <1>;
> > +                     #size-cells = <0>;
> > +
> > +                     anx6345_in: port@0 {
> > +                             #address-cells = <1>;
> > +                             #size-cells = <0>;
> > +                             reg = <0>;
> > +                             anx6345_in_tcon0: endpoint@0 {
> > +                                     reg = <0>;
> > +                                     remote-endpoint = <&tcon0_out_anx6345>;
> > +                             };
>
> As there's a single endpoint, you can drop the reg property, the @0
> suffix, and the #address-cells and #size-cells property in the port@0
> node (but not in the ports node).

Will do

> > +                     };
> > +
> > +                     anx6345_out: port@1 {
> > +                             #address-cells = <1>;
> > +                             #size-cells = <0>;
> > +                             reg = <1>;
> > +
> > +                             anx6345_out_edp: endpoint@0 {
> > +                                     reg = <0>;
> > +                                     remote-endpoint = <&panel_edp_in>;
> > +                             };
>
> Same here.

Will do

> Reviewed-by: Laurent Pinchart <laurent.pinchart@ideasonboard.com>

Thanks for reviewing the series!


>
> > +                     };
> > +             };
> > +     };
> >  };
> >
> >  &r_pio {
> > @@ -357,6 +410,20 @@ &sound {
> >                       "MIC2", "Internal Microphone Right";
> >  };
> >
> > +&tcon0 {
> > +     pinctrl-names = "default";
> > +     pinctrl-0 = <&lcd_rgb666_pins>;
> > +
> > +     status = "okay";
> > +};
> > +
> > +&tcon0_out {
> > +     tcon0_out_anx6345: endpoint@0 {
> > +             reg = <0>;
> > +             remote-endpoint = <&anx6345_in_tcon0>;
> > +     };
> > +};
> > +
> >  &uart0 {
> >       pinctrl-names = "default";
> >       pinctrl-0 = <&uart0_pb_pins>;
>
> --
> Regards,
>
> Laurent Pinchart
