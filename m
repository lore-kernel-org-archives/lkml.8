Return-Path: <SRS0=7TUr=4M=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 84A2FC11D2F
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Feb 2020 12:59:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 528DD20828
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Feb 2020 12:59:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=megous.com header.i=@megous.com header.b="ReGabWjx"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727869AbgBXM7t (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 24 Feb 2020 07:59:49 -0500
Received: from vps.xff.cz ([195.181.215.36]:56912 "EHLO vps.xff.cz"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727501AbgBXM7s (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Feb 2020 07:59:48 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=megous.com; s=mail;
        t=1582549185; bh=9fyMxLMlwNi2Pk+BMp46DoE3AKNIuGLa/wjI2H1/1TI=;
        h=Date:From:To:Cc:Subject:References:X-My-GPG-KeyId:From;
        b=ReGabWjx50JtBWZQvXOEPZalcv6O4nOrPEOA0yDYfRykQcuZ3agnsQV5wgtsd6W4n
         yr1RWff/zDZU/rJ9AOp3C5rmlya4/6RRiVFTVr0OB/lw8G8mIBPKbgQXFCBpoiysjw
         yzyyjqY5Fxsqg1cDwZhOnyUI+uM9SHFXIx4UYacg=
Date:   Mon, 24 Feb 2020 13:59:45 +0100
From:   =?utf-8?Q?Ond=C5=99ej?= Jirman <megous@megous.com>
To:     Maxime Ripard <maxime@cerno.tech>
Cc:     linux-sunxi@googlegroups.com, Rob Herring <robh+dt@kernel.org>,
        Chen-Yu Tsai <wens@csie.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Corentin Labbe <clabbe@baylibre.com>,
        Georgii Staroselskii <georgii.staroselskii@emlid.com>,
        Samuel Holland <samuel@sholland.org>,
        Martijn Braam <martijn@brixit.nl>, Luca Weiss <luca@z3ntu.xyz>,
        Bhushan Shah <bshah@kde.org>, Icenowy Zheng <icenowy@aosc.io>,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/3] arm64: dts: sun50i-a64: Add i2c2 pins
Message-ID: <20200224125945.dyl7reaqqiqds4ee@core.my.home>
Mail-Followup-To: Maxime Ripard <maxime@cerno.tech>,
        linux-sunxi@googlegroups.com, Rob Herring <robh+dt@kernel.org>,
        Chen-Yu Tsai <wens@csie.org>, Mark Rutland <mark.rutland@arm.com>,
        Corentin Labbe <clabbe@baylibre.com>,
        Georgii Staroselskii <georgii.staroselskii@emlid.com>,
        Samuel Holland <samuel@sholland.org>,
        Martijn Braam <martijn@brixit.nl>, Luca Weiss <luca@z3ntu.xyz>,
        Bhushan Shah <bshah@kde.org>, Icenowy Zheng <icenowy@aosc.io>,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org
References: <20200223172916.843379-1-megous@megous.com>
 <20200223172916.843379-2-megous@megous.com>
 <20200224110100.acwln7zv3j5y67b2@gilmour.lan>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200224110100.acwln7zv3j5y67b2@gilmour.lan>
X-My-GPG-KeyId: EBFBDDE11FB918D44D1F56C1F9F0A873BE9777ED
 <https://xff.cz/key.txt>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Feb 24, 2020 at 12:01:00PM +0100, Maxime Ripard wrote:
> On Sun, Feb 23, 2020 at 06:29:14PM +0100, Ondrej Jirman wrote:
> > PinePhone needs I2C2 pins description. Add it.
> >
> > Signed-off-by: Ondrej Jirman <megous@megous.com>
> > ---
> >  arch/arm64/boot/dts/allwinner/sun50i-a64.dtsi | 5 +++++
> >  1 file changed, 5 insertions(+)
> >
> > diff --git a/arch/arm64/boot/dts/allwinner/sun50i-a64.dtsi b/arch/arm64/boot/dts/allwinner/sun50i-a64.dtsi
> > index 862b47dc9dc90..0fdf5f400d743 100644
> > --- a/arch/arm64/boot/dts/allwinner/sun50i-a64.dtsi
> > +++ b/arch/arm64/boot/dts/allwinner/sun50i-a64.dtsi
> > @@ -671,6 +671,11 @@ i2c1_pins: i2c1-pins {
> >  				function = "i2c1";
> >  			};
> >
> > +			i2c2_pins: i2c2-pins {
> > +				pins = "PE14", "PE15";
> > +				function = "i2c2";
> > +			};
> > +
> 
> Setting it as the default muxing for i2c2 would be great

Right, I checked the datasheet and it looks like this is the only pins where
i2c2 can be muxed to.

I will change it.

regards,
	o.

> Maxime


