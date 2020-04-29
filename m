Return-Path: <SRS0=ObIu=6N=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 56B6EC83007
	for <linux-kernel@archiver.kernel.org>; Wed, 29 Apr 2020 06:24:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3EFE52076B
	for <linux-kernel@archiver.kernel.org>; Wed, 29 Apr 2020 06:24:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726495AbgD2GYQ convert rfc822-to-8bit (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 29 Apr 2020 02:24:16 -0400
Received: from mail-lj1-f196.google.com ([209.85.208.196]:35074 "EHLO
        mail-lj1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726274AbgD2GYQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Apr 2020 02:24:16 -0400
Received: by mail-lj1-f196.google.com with SMTP id g4so1373547ljl.2;
        Tue, 28 Apr 2020 23:24:14 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=UMvE1bKhgPMPyH5g6riW7cDoy79w0qtcoyNsyUsk4iA=;
        b=S9uxe+k/16qFQu6hjteo0ACs8fO4KSYU/oHGAoDYcxZv5L52GmXUJWwABHcMZQ3GwZ
         rHCNVXB7OFY0GlMUPsV5cNTltEedRzihQKxacYXVZ116D1pkhsRCZr9BFWmoTqQpQslg
         EFydtaOFaxy3g9f0yWiCA+xVglb55HEu0gVo0D7hatSGfcYZFAPmsEllv1/wz9KiE5xu
         UktyVQVJEdlziB2L+93+5MvyxDrJNdrlyLsweH4WCXxI1Zjth/9wyC7wue3G/niqMbzy
         oGeqQAZFtS+dDv+S40561wofb6H6SuRQrFM5zxCySdqSsZ4XkhzFeSOa4zugE6T8l4wh
         lHBA==
X-Gm-Message-State: AGi0Pub01OKg2xloT7E+gE6f6tH0gysnhpeA9GeVr+sFpmtbgdGKDM2N
        +YEKu0WhtkN88NEWb9cgfybz5n1BQJEw6A==
X-Google-Smtp-Source: APiQypIJG7mO46ZOSdxWjrbaacCFmFFl74JNW0V4rpwawaB80OvBciJ2Cr1OKKQyQUHiEtBNYc/Zjg==
X-Received: by 2002:a2e:8087:: with SMTP id i7mr18344260ljg.99.1588141452868;
        Tue, 28 Apr 2020 23:24:12 -0700 (PDT)
Received: from mail-lf1-f42.google.com (mail-lf1-f42.google.com. [209.85.167.42])
        by smtp.gmail.com with ESMTPSA id u6sm1432926ljd.68.2020.04.28.23.24.11
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 28 Apr 2020 23:24:11 -0700 (PDT)
Received: by mail-lf1-f42.google.com with SMTP id t11so657206lfe.4;
        Tue, 28 Apr 2020 23:24:11 -0700 (PDT)
X-Received: by 2002:ac2:5238:: with SMTP id i24mr5157585lfl.7.1588141451325;
 Tue, 28 Apr 2020 23:24:11 -0700 (PDT)
MIME-Version: 1.0
References: <20200426120442.11560-1-peron.clem@gmail.com> <20200426120442.11560-5-peron.clem@gmail.com>
 <20200428080020.35qcuylwq2ylmubu@gilmour.lan> <CAJiuCcc2LQ4L36KSfO8iLVFBUO6k+zsZFX+_Ovm_10PoWO4AsA@mail.gmail.com>
 <20200428160417.6q5oab2guaumhhwi@gilmour.lan> <CAJiuCccFFUJJzXwygLQbDK4fGJ61p72Hv7vj3WVP-=z=J1Yj0Q@mail.gmail.com>
 <031ee5d3-8a30-82ee-76db-c0e8a1073046@arm.com>
In-Reply-To: <031ee5d3-8a30-82ee-76db-c0e8a1073046@arm.com>
From:   Chen-Yu Tsai <wens@csie.org>
Date:   Wed, 29 Apr 2020 14:24:00 +0800
X-Gmail-Original-Message-ID: <CAGb2v65rRbRpUTdkTF3hd5LnLQQt19YVOyVzM5te5XNVhQQH=A@mail.gmail.com>
Message-ID: <CAGb2v65rRbRpUTdkTF3hd5LnLQQt19YVOyVzM5te5XNVhQQH=A@mail.gmail.com>
Subject: Re: [linux-sunxi] Re: Audio sound card name [was [PATCH 4/7] arm64:
 dts: allwinner: a64: Add HDMI audio]
To:     =?UTF-8?B?Q2zDqW1lbnQgUMOpcm9u?= <peron.clem@gmail.com>
Cc:     Robin Murphy <robin.murphy@arm.com>,
        Mark Brown <broonie@kernel.org>,
        devicetree <devicetree@vger.kernel.org>,
        Linux-ALSA <alsa-devel@alsa-project.org>,
        Liam Girdwood <lgirdwood@gmail.com>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        linux-sunxi <linux-sunxi@googlegroups.com>,
        Jernej Skrabec <jernej.skrabec@siol.net>,
        Takashi Iwai <tiwai@suse.com>,
        Jaroslav Kysela <perex@perex.cz>,
        Marcus Cooper <codekipper@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        Maxime Ripard <maxime@cerno.tech>,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Apr 29, 2020 at 1:11 AM Robin Murphy <robin.murphy@arm.com> wrote:
>
> On 2020-04-28 5:49 pm, Clément Péron wrote:
> > Hi Mark, Rob,
> >
> > On Tue, 28 Apr 2020 at 18:04, Maxime Ripard <maxime@cerno.tech> wrote:
> >>
> >> On Tue, Apr 28, 2020 at 10:54:00AM +0200, Clément Péron wrote:
> >>> Hi Maxime,
> >>>
> >>> On Tue, 28 Apr 2020 at 10:00, Maxime Ripard <maxime@cerno.tech> wrote:
> >>>>
> >>>> On Sun, Apr 26, 2020 at 02:04:39PM +0200, Clément Péron wrote:
> >>>>> From: Marcus Cooper <codekipper@gmail.com>
> >>>>>
> >>>>> Add a simple-soundcard to link audio between HDMI and I2S.
> >>>>>
> >>>>> Signed-off-by: Jernej Skrabec <jernej.skrabec@siol.net>
> >>>>> Signed-off-by: Marcus Cooper <codekipper@gmail.com>
> >>>>> Signed-off-by: Clément Péron <peron.clem@gmail.com>
> >>>>> ---
> >>>>>   arch/arm64/boot/dts/allwinner/sun50i-a64.dtsi | 21 +++++++++++++++++++
> >>>>>   1 file changed, 21 insertions(+)
> >>>>>
> >>>>> diff --git a/arch/arm64/boot/dts/allwinner/sun50i-a64.dtsi b/arch/arm64/boot/dts/allwinner/sun50i-a64.dtsi
> >>>>> index e56e1e3d4b73..08ab6b5e72a5 100644
> >>>>> --- a/arch/arm64/boot/dts/allwinner/sun50i-a64.dtsi
> >>>>> +++ b/arch/arm64/boot/dts/allwinner/sun50i-a64.dtsi
> >>>>> @@ -102,6 +102,25 @@
> >>>>>                status = "disabled";
> >>>>>        };
> >>>>>
> >>>>> +     hdmi_sound: hdmi-sound {
> >>>>> +             compatible = "simple-audio-card";
> >>>>> +             simple-audio-card,format = "i2s";
> >>>>> +             simple-audio-card,name = "allwinner,hdmi";
> >>>>
> >>>> I'm not sure what the usual card name should be like though. I would assume that
> >>>> this should be something specific enough so that you're able to differentiate
> >>>> between boards / SoC so that the userspace can choose a different configuration
> >>>> based on it?
> >>>
> >>> I really don't know what we should use here,
> >>> I just have a look at other SoC:
> >>> rk3328: "HDMI"
> >>> rk3399: "hdmi-sound"
> >>> r8a774c0-cat874: "CAT874 HDMI sound"
> >>>
> >>> But maybe it's time to introduce proper name:
> >>> What about :
> >>> pat
> >>> sun50i-h6-hdmi
> >>
> >> It's pretty much what we've been using for the other sound cards we have, so it
> >> makes sense to me.
> >
> > I have a question regarding the simple-audio-card,name.
> > In this patch, I would like to introduce a simple-audio-card for the
> > Allwinner A64 HDMI.
> >
> > What should be the preferred name for this sound card?
> > "sun50i-a64-hdmi" ? "allwinner, sun50i-a64-hdmi" ?
>
> I can at least speak for RK3328, and the reasoning there was that as the
> user looking at what `aplay -l` says, I don't give a hoot about what the
> SoC may be called, I see two cards and I want to know, with the least
> amount of uncertainty, which one will make the sound come out of the
> port that's labelled "HDMI" on the box ;)

I agree. The user really doesn't care what SoC the system uses. The only
real requirement is to be able to tell which output the card is related
to, i.e. is it onboard or an external DAC, is it analog or HDMI, etc..

ChenYu
