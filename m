Return-Path: <SRS0=/IhT=AT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2D7D1C433E2
	for <linux-kernel@archiver.kernel.org>; Wed,  8 Jul 2020 16:00:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 14C1220853
	for <linux-kernel@archiver.kernel.org>; Wed,  8 Jul 2020 16:00:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730579AbgGHQAk convert rfc822-to-8bit (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 8 Jul 2020 12:00:40 -0400
Received: from mailoutvs45.siol.net ([185.57.226.236]:33941 "EHLO
        mail.siol.net" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1730551AbgGHQAi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Jul 2020 12:00:38 -0400
Received: from localhost (localhost [127.0.0.1])
        by mail.siol.net (Zimbra) with ESMTP id E591F5249DF;
        Wed,  8 Jul 2020 18:00:34 +0200 (CEST)
X-Virus-Scanned: amavisd-new at psrvmta12.zcs-production.pri
Received: from mail.siol.net ([127.0.0.1])
        by localhost (psrvmta12.zcs-production.pri [127.0.0.1]) (amavisd-new, port 10032)
        with ESMTP id TGA0pwlFKG2D; Wed,  8 Jul 2020 18:00:34 +0200 (CEST)
Received: from mail.siol.net (localhost [127.0.0.1])
        by mail.siol.net (Zimbra) with ESMTPS id 89FE65249E9;
        Wed,  8 Jul 2020 18:00:34 +0200 (CEST)
Received: from jernej-laptop.localnet (cpe-194-152-20-232.static.triera.net [194.152.20.232])
        (Authenticated sender: jernej.skrabec@siol.net)
        by mail.siol.net (Zimbra) with ESMTPA id 8BE0F5249DF;
        Wed,  8 Jul 2020 18:00:33 +0200 (CEST)
From:   Jernej =?utf-8?B?xaBrcmFiZWM=?= <jernej.skrabec@siol.net>
To:     =?ISO-8859-1?Q?Cl=E9ment_P=E9ron?= <peron.clem@gmail.com>,
        Maxime Ripard <maxime@cerno.tech>
Cc:     Chen-Yu Tsai <wens@csie.org>, Rob Herring <robh+dt@kernel.org>,
        Mark Brown <broonie@kernel.org>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Jaroslav Kysela <perex@perex.cz>,
        Takashi Iwai <tiwai@suse.com>,
        Marcus Cooper <codekipper@gmail.com>,
        alsa-devel@alsa-project.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-sunxi@googlegroups.com
Subject: Re: [PATCH 13/16] arm64: dts: allwinner: a64: Add HDMI audio
Date:   Wed, 08 Jul 2020 18:00:33 +0200
Message-ID: <4131203.q43jsyBQJq@jernej-laptop>
In-Reply-To: <20200706053123.uenb3nrdrckdvao7@gilmour.lan>
References: <20200704113902.336911-1-peron.clem@gmail.com> <20200704113902.336911-14-peron.clem@gmail.com> <20200706053123.uenb3nrdrckdvao7@gilmour.lan>
MIME-Version: 1.0
Content-Transfer-Encoding: 8BIT
Content-Type: text/plain; charset="iso-8859-1"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

Dne ponedeljek, 06. julij 2020 ob 07:31:23 CEST je Maxime Ripard napisal(a):
> On Sat, Jul 04, 2020 at 01:38:59PM +0200, Clément Péron wrote:
> > From: Marcus Cooper <codekipper@gmail.com>
> > 
> > Add a simple-soundcard to link audio between HDMI and I2S.
> > 
> > Signed-off-by: Jernej Skrabec <jernej.skrabec@siol.net>
> > Signed-off-by: Marcus Cooper <codekipper@gmail.com>
> > Signed-off-by: Clément Péron <peron.clem@gmail.com>
> > ---
> > 
> >  arch/arm64/boot/dts/allwinner/sun50i-a64.dtsi | 21 +++++++++++++++++++
> >  1 file changed, 21 insertions(+)
> > 
> > diff --git a/arch/arm64/boot/dts/allwinner/sun50i-a64.dtsi
> > b/arch/arm64/boot/dts/allwinner/sun50i-a64.dtsi index
> > c662f6a170ce..6a321fdc8e90 100644
> > --- a/arch/arm64/boot/dts/allwinner/sun50i-a64.dtsi
> > +++ b/arch/arm64/boot/dts/allwinner/sun50i-a64.dtsi
> > @@ -102,6 +102,25 @@ de: display-engine {
> > 
> >  		status = "disabled";
> >  	
> >  	};
> > 
> > +	hdmi_sound: hdmi-sound {
> > +		compatible = "simple-audio-card";
> > +		simple-audio-card,format = "i2s";
> > +		simple-audio-card,name = "sun50i-a64-hdmi";
> > +		simple-audio-card,mclk-fs = <128>;
> > +		simple-audio-card,frame-inversion;
> > +		status = "disabled";
> > +
> > +		simple-audio-card,codec {
> > +			sound-dai = <&hdmi>;
> > +		};
> > +
> > +		simple-audio-card,cpu {
> > +			sound-dai = <&i2s2>;
> > +			dai-tdm-slot-num = <2>;
> > +			dai-tdm-slot-width = <32>;
> > +		};
> > +	};
> > +
> > 
> >  	osc24M: osc24M_clk {
> >  	
> >  		#clock-cells = <0>;
> >  		compatible = "fixed-clock";
> > 
> > @@ -856,6 +875,7 @@ i2s2: i2s@1c22800 {
> > 
> >  			resets = <&ccu RST_BUS_I2S2>;
> >  			dma-names = "tx";
> >  			dmas = <&dma 27>;
> > 
> > +			allwinner,playback-channels = <8>;
> 
> This isn't documented anywhere

This can be safely dropped. It is just leftover from multi-channel (>2) work, 
which will have to be redesigned anyway.

Best regards,
Jernej


