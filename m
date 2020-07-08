Return-Path: <SRS0=/IhT=AT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 54E40C433E0
	for <linux-kernel@archiver.kernel.org>; Wed,  8 Jul 2020 16:18:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3584120786
	for <linux-kernel@archiver.kernel.org>; Wed,  8 Jul 2020 16:18:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730514AbgGHQSB convert rfc822-to-8bit (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 8 Jul 2020 12:18:01 -0400
Received: from mailoutvs24.siol.net ([185.57.226.215]:40617 "EHLO
        mail.siol.net" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1730093AbgGHQSA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Jul 2020 12:18:00 -0400
Received: from localhost (localhost [127.0.0.1])
        by mail.siol.net (Postfix) with ESMTP id 4A96C524C57;
        Wed,  8 Jul 2020 18:17:58 +0200 (CEST)
X-Virus-Scanned: amavisd-new at psrvmta10.zcs-production.pri
Received: from mail.siol.net ([127.0.0.1])
        by localhost (psrvmta10.zcs-production.pri [127.0.0.1]) (amavisd-new, port 10032)
        with ESMTP id oLEpCQVAM4I0; Wed,  8 Jul 2020 18:17:57 +0200 (CEST)
Received: from mail.siol.net (localhost [127.0.0.1])
        by mail.siol.net (Postfix) with ESMTPS id D452E524C76;
        Wed,  8 Jul 2020 18:17:57 +0200 (CEST)
Received: from jernej-laptop.localnet (cpe-194-152-20-232.static.triera.net [194.152.20.232])
        (Authenticated sender: jernej.skrabec@siol.net)
        by mail.siol.net (Postfix) with ESMTPA id 47E03524BD7;
        Wed,  8 Jul 2020 18:17:57 +0200 (CEST)
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
Subject: Re: [PATCH 08/16] arm64: dts: allwinner: h6: Add HDMI audio node
Date:   Wed, 08 Jul 2020 18:17:57 +0200
Message-ID: <4073007.RJdR9ZcIkj@jernej-laptop>
In-Reply-To: <20200706052937.ygjjllrsj7rvynkq@gilmour.lan>
References: <20200704113902.336911-1-peron.clem@gmail.com> <20200704113902.336911-9-peron.clem@gmail.com> <20200706052937.ygjjllrsj7rvynkq@gilmour.lan>
MIME-Version: 1.0
Content-Transfer-Encoding: 8BIT
Content-Type: text/plain; charset="iso-8859-1"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

Dne ponedeljek, 06. julij 2020 ob 07:29:37 CEST je Maxime Ripard napisal(a):
> Hi,
> 
> On Sat, Jul 04, 2020 at 01:38:54PM +0200, Clément Péron wrote:
> > From: Jernej Skrabec <jernej.skrabec@siol.net>
> > 
> > Add a simple-soundcard to link audio between HDMI and I2S.
> > 
> > Signed-off-by: Jernej Skrabec <jernej.skrabec@siol.net>
> > Signed-off-by: Marcus Cooper <codekipper@gmail.com>
> > Signed-off-by: Clément Péron <peron.clem@gmail.com>
> > ---
> > 
> >  arch/arm64/boot/dts/allwinner/sun50i-h6.dtsi | 33 ++++++++++++++++++++
> >  1 file changed, 33 insertions(+)
> > 
> > diff --git a/arch/arm64/boot/dts/allwinner/sun50i-h6.dtsi
> > b/arch/arm64/boot/dts/allwinner/sun50i-h6.dtsi index
> > 78b1361dfbb9..ae169d07b939 100644
> > --- a/arch/arm64/boot/dts/allwinner/sun50i-h6.dtsi
> > +++ b/arch/arm64/boot/dts/allwinner/sun50i-h6.dtsi
> > @@ -67,6 +67,25 @@ de: display-engine {
> > 
> >  		status = "disabled";
> >  	
> >  	};
> > 
> > +	hdmi_sound: hdmi-sound {
> > +		compatible = "simple-audio-card";
> > +		simple-audio-card,format = "i2s";
> > +		simple-audio-card,name = "sun50i-h6-hdmi";
> > +		simple-audio-card,mclk-fs = <128>;
> > +		simple-audio-card,frame-inversion;
> 
> Have you figured that one out?
> 
> > +		status = "disabled";
> > +
> > +		simple-audio-card,codec {
> > +			sound-dai = <&hdmi>;
> > +		};
> > +
> > +		simple-audio-card,cpu {
> > +			sound-dai = <&i2s1>;
> > +			dai-tdm-slot-num = <2>;
> > +			dai-tdm-slot-width = <32>;
> 
> I'm not sure why you need to use the TDM stuff here. IIRC the HDMI
> controller can output on up to 6 channels, so how would that work out?

dai-tdm-slot-width is needed to override automatic slot width selection. It 
should always be 32 for HDMI, no matter what is actual physical sample width. 
In this case this property is abused to set width also for I2S mode of 
operation. IMO there is no sense to duplicate code because I2S variant would 
work exactly the same, except name would be different.

I'm not sure about dai-tdm-slot-num. Marcus, can you explain the need for this 
property?

Would it be better to implement separate link driver instead of using simple-
card to hide all this properties into the code?

Best regards,
Jernej



