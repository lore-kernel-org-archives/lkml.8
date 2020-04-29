Return-Path: <SRS0=ObIu=6N=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C7A86C83007
	for <linux-kernel@archiver.kernel.org>; Wed, 29 Apr 2020 10:53:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id AEE122072A
	for <linux-kernel@archiver.kernel.org>; Wed, 29 Apr 2020 10:53:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726811AbgD2Kx6 convert rfc822-to-8bit (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 29 Apr 2020 06:53:58 -0400
Received: from mailoutvs10.siol.net ([185.57.226.201]:53107 "EHLO
        mail.siol.net" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726783AbgD2Kx5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Apr 2020 06:53:57 -0400
Received: from localhost (localhost [127.0.0.1])
        by mail.siol.net (Zimbra) with ESMTP id C3AF3521BE9;
        Wed, 29 Apr 2020 12:53:52 +0200 (CEST)
X-Virus-Scanned: amavisd-new at psrvmta12.zcs-production.pri
Received: from mail.siol.net ([127.0.0.1])
        by localhost (psrvmta12.zcs-production.pri [127.0.0.1]) (amavisd-new, port 10032)
        with ESMTP id WTuFh5kUYBaz; Wed, 29 Apr 2020 12:53:52 +0200 (CEST)
Received: from mail.siol.net (localhost [127.0.0.1])
        by mail.siol.net (Zimbra) with ESMTPS id 3A022521DDA;
        Wed, 29 Apr 2020 12:53:52 +0200 (CEST)
Received: from jernej-laptop.localnet (89-212-178-211.dynamic.t-2.net [89.212.178.211])
        (Authenticated sender: jernej.skrabec@siol.net)
        by mail.siol.net (Zimbra) with ESMTPA id E16C2521BE9;
        Wed, 29 Apr 2020 12:53:49 +0200 (CEST)
From:   Jernej =?utf-8?B?xaBrcmFiZWM=?= <jernej.skrabec@siol.net>
To:     Maxime Ripard <maxime@cerno.tech>, Chen-Yu Tsai <wens@csie.org>,
        Robin Murphy <robin.murphy@arm.com>
Cc:     =?ISO-8859-1?Q?Cl=E9ment_P=E9ron?= <peron.clem@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        devicetree <devicetree@vger.kernel.org>,
        Linux-ALSA <alsa-devel@alsa-project.org>,
        Liam Girdwood <lgirdwood@gmail.com>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        linux-sunxi <linux-sunxi@googlegroups.com>,
        Takashi Iwai <tiwai@suse.com>,
        Jaroslav Kysela <perex@perex.cz>,
        Marcus Cooper <codekipper@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>
Subject: Re: [linux-sunxi] Re: Audio sound card name [was [PATCH 4/7] arm64: dts: allwinner: a64: Add HDMI audio]
Date:   Wed, 29 Apr 2020 12:53:49 +0200
Message-ID: <2545943.S5iK65abk1@jernej-laptop>
In-Reply-To: <f9b701d9-0c4e-6e41-1ce8-52adf0f59a2a@arm.com>
References: <20200426120442.11560-1-peron.clem@gmail.com> <20200429081729.qa3gqtl5sof2jhem@gilmour.lan> <f9b701d9-0c4e-6e41-1ce8-52adf0f59a2a@arm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8BIT
Content-Type: text/plain; charset="iso-8859-1"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Dne sreda, 29. april 2020 ob 12:43:06 CEST je Robin Murphy napisal(a):
> On 2020-04-29 9:17 am, Maxime Ripard wrote:
> > On Wed, Apr 29, 2020 at 02:24:00PM +0800, Chen-Yu Tsai wrote:
> >> On Wed, Apr 29, 2020 at 1:11 AM Robin Murphy <robin.murphy@arm.com> 
wrote:
> >>> On 2020-04-28 5:49 pm, Clément Péron wrote:
> >>>> Hi Mark, Rob,
> >>>> 
> >>>> On Tue, 28 Apr 2020 at 18:04, Maxime Ripard <maxime@cerno.tech> wrote:
> >>>>> On Tue, Apr 28, 2020 at 10:54:00AM +0200, Clément Péron wrote:
> >>>>>> Hi Maxime,
> >>>>>> 
> >>>>>> On Tue, 28 Apr 2020 at 10:00, Maxime Ripard <maxime@cerno.tech> 
wrote:
> >>>>>>> On Sun, Apr 26, 2020 at 02:04:39PM +0200, Clément Péron wrote:
> >>>>>>>> From: Marcus Cooper <codekipper@gmail.com>
> >>>>>>>> 
> >>>>>>>> Add a simple-soundcard to link audio between HDMI and I2S.
> >>>>>>>> 
> >>>>>>>> Signed-off-by: Jernej Skrabec <jernej.skrabec@siol.net>
> >>>>>>>> Signed-off-by: Marcus Cooper <codekipper@gmail.com>
> >>>>>>>> Signed-off-by: Clément Péron <peron.clem@gmail.com>
> >>>>>>>> ---
> >>>>>>>> 
> >>>>>>>>    arch/arm64/boot/dts/allwinner/sun50i-a64.dtsi | 21
> >>>>>>>>    +++++++++++++++++++
> >>>>>>>>    1 file changed, 21 insertions(+)
> >>>>>>>> 
> >>>>>>>> diff --git a/arch/arm64/boot/dts/allwinner/sun50i-a64.dtsi
> >>>>>>>> b/arch/arm64/boot/dts/allwinner/sun50i-a64.dtsi index
> >>>>>>>> e56e1e3d4b73..08ab6b5e72a5 100644
> >>>>>>>> --- a/arch/arm64/boot/dts/allwinner/sun50i-a64.dtsi
> >>>>>>>> +++ b/arch/arm64/boot/dts/allwinner/sun50i-a64.dtsi
> >>>>>>>> @@ -102,6 +102,25 @@
> >>>>>>>> 
> >>>>>>>>                 status = "disabled";
> >>>>>>>>         
> >>>>>>>>         };
> >>>>>>>> 
> >>>>>>>> +     hdmi_sound: hdmi-sound {
> >>>>>>>> +             compatible = "simple-audio-card";
> >>>>>>>> +             simple-audio-card,format = "i2s";
> >>>>>>>> +             simple-audio-card,name = "allwinner,hdmi";
> >>>>>>> 
> >>>>>>> I'm not sure what the usual card name should be like though. I would
> >>>>>>> assume that this should be something specific enough so that you're
> >>>>>>> able to differentiate between boards / SoC so that the userspace
> >>>>>>> can choose a different configuration based on it?
> >>>>>> 
> >>>>>> I really don't know what we should use here,
> >>>>>> I just have a look at other SoC:
> >>>>>> rk3328: "HDMI"
> >>>>>> rk3399: "hdmi-sound"
> >>>>>> r8a774c0-cat874: "CAT874 HDMI sound"
> >>>>>> 
> >>>>>> But maybe it's time to introduce proper name:
> >>>>>> What about :
> >>>>>> pat
> >>>>>> sun50i-h6-hdmi
> >>>>> 
> >>>>> It's pretty much what we've been using for the other sound cards we
> >>>>> have, so it makes sense to me.
> >>>> 
> >>>> I have a question regarding the simple-audio-card,name.
> >>>> In this patch, I would like to introduce a simple-audio-card for the
> >>>> Allwinner A64 HDMI.
> >>>> 
> >>>> What should be the preferred name for this sound card?
> >>>> "sun50i-a64-hdmi" ? "allwinner, sun50i-a64-hdmi" ?
> >>> 
> >>> I can at least speak for RK3328, and the reasoning there was that as the
> >>> user looking at what `aplay -l` says, I don't give a hoot about what the
> >>> SoC may be called, I see two cards and I want to know, with the least
> >>> amount of uncertainty, which one will make the sound come out of the
> >>> port that's labelled "HDMI" on the box ;)
> >> 
> >> I agree. The user really doesn't care what SoC the system uses. The only
> >> real requirement is to be able to tell which output the card is related
> >> to, i.e. is it onboard or an external DAC, is it analog or HDMI, etc..
> > 
> > Yeah, but it's exactly the point.
> > 
> > If we also end up with "HDMI" as our card name, then the userspace has no
> > way to tell anymore if it's running from an rk3328 or an allwinner SoC,
> > or something else entirely. And therefore it cannot really configure
> > anything to work out of the box anymore.
> 
> OK, you're a userspace audio application - enlighten me as to what exact
> chip you're running on here, and why you need to know:
> 
> card 0: HDMI [HDA ATI HDMI]
> 
> or how about here?
> 
> card 0: Intel [HDA Intel]
> 
> 
> Furthermore, your argument works both ways - if the equivalent (or in
> common cases like DesignWare IP blocks, exact same) thing across 3
> different SoCs has 3 different names, then it's that much harder for
> userspace that wants to present a consistent behaviour. I don't know
> exactly why LibreELEC have downstream patches that standardise all the
> Rockchip ones to "HDMI", but I can't help noting that they do.
> 
> With simple-audio-card we're talking about trivial interfaces that often
> don't expose any controls at all, so there's unlikely to be much
> 'configuration' for userspace to do beyond choosing which card to output to.

This combination (DesignWare HDMI controller + I2S) is same as on Rockchip. 
Only difference is slightly different version of HDMI controller and different 
I2S core. Not sure what kind of configuration do you have in mind, but all 
these controllers support 2-8 channels, different sample sizes, even 
passthrough mode can be set (but it's not implemented yet). I would say that 
this audio output supports quiet a few possible configurations.

BTW, above patches were thoroughly tested in LibreELEC. The only missing thing 
is extending I2S driver to support channel allocation through DT, but that's 
outside the scope of this series. Currently only 2 channels will work 
correctly.

Best regards,
Jernej



