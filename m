Return-Path: <SRS0=VwT+=6S=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 389BDC47247
	for <linux-kernel@archiver.kernel.org>; Mon,  4 May 2020 19:43:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1883620705
	for <linux-kernel@archiver.kernel.org>; Mon,  4 May 2020 19:43:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="SjHLuiCK"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727825AbgEDTnS (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 4 May 2020 15:43:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44930 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726111AbgEDTnR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 May 2020 15:43:17 -0400
Received: from mail-il1-x143.google.com (mail-il1-x143.google.com [IPv6:2607:f8b0:4864:20::143])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A2F51C061A0E;
        Mon,  4 May 2020 12:43:17 -0700 (PDT)
Received: by mail-il1-x143.google.com with SMTP id m5so244355ilj.10;
        Mon, 04 May 2020 12:43:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=hToGumS7+rYCBAzwPejy/9G9W5aA7qrCKK0guqtnFic=;
        b=SjHLuiCKKUrEzDejZi1OKuJXwdceb+8LNelIll16QEO5qNEjAPQAAsvUxeDszeDR/N
         85+LZzWTsXE8zTa4pkn2s41g8hVSUlTYqbPn3WiM/h785rym9Jxa2Zugy26zWHlmEEWH
         8bmLR8SahzhouwKRk/8mEVPY/9kafpSmS4nBCBPYAeq63JDA3MLxr0THEWQF0//zgRAJ
         d9KQvHnphi+qyo79q9vQ71zi3ww8qqR+RX0+7KIGTtVAoQMsujxB3B/hGBkRaCXQv8EN
         dfcj7gPxu1CcV/uTPSRRS9jkJMxmYHLOwtV1mvVJUxBRDBA0qPtMAI3R+/sa18yiSjZm
         mqZQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=hToGumS7+rYCBAzwPejy/9G9W5aA7qrCKK0guqtnFic=;
        b=iKzvLXalnZDh6irMm9eXjLre+IJ/Dbkiwun1q6gxMtTiCcfEx+Bg6e/8NvXxq5cR4+
         cH4QhuYgneMSrYVouMczgRmOEnyGPx1fgU/eIJxA/ZS+zbQ5jGfMyi0XdsctatzTPOQj
         r4xku399T3n+HakQ4jmNxFvCD2K1BGblUcVVKy77qnvBairXoY9kmlTnyUuDrK5HBw9I
         IbYrdOs0LIA6EjPKW4/jGar/ceQW0B5COlk2H/MVwXU6GpE7N/252DeLj6paNpLkWjco
         A0qEPN81yvjpLtl63YqVS29lD0e/5wv8N8FxL1gvxIRmYSa69XHUoOj2eeroHW1uqc/L
         J3zA==
X-Gm-Message-State: AGi0PuZ9pNYvdtukYYSrXh/TAUU0exmrW/tdfBKVgw8RdWL/90aWXYuQ
        TW4wFa7RUOgn1xDwD2t55ckLBL1nYQGBxhkp/Oo=
X-Google-Smtp-Source: APiQypJrGXhhqW08yoaeDnDtx/i0JRfzWEst7LvKzsZZk7VobrfRGOVAQHzOHOnx7KngiHH3GuCSo8vUVjpnh9WKeuw=
X-Received: by 2002:a92:3a48:: with SMTP id h69mr55241ila.150.1588621396983;
 Mon, 04 May 2020 12:43:16 -0700 (PDT)
MIME-Version: 1.0
References: <20200426104115.22630-1-peron.clem@gmail.com> <20200426104115.22630-4-peron.clem@gmail.com>
 <20200428081321.ht3el26yqhsnyfm4@gilmour.lan> <CAJiuCcdVs_drs40Q6537BYfz24F7NmC6B8S5-Lt4V4ggs-FXWA@mail.gmail.com>
 <20200429123529.y24dpy63wxq7uvkt@gilmour.lan> <CAJiuCcfXqizcq_JuXRCsqEqM2562cr1SGJ0pmy07jcJxAXojOw@mail.gmail.com>
 <20200430084600.samghw4zxb5zdbez@gilmour.lan> <CAJiuCcf_LHrJ6QdZgH8HyN6TRiT+GiD+t4UggFCrz-VwVHXV6w@mail.gmail.com>
 <20200504120942.lnrxnnmykqnvw3fb@gilmour.lan>
In-Reply-To: <20200504120942.lnrxnnmykqnvw3fb@gilmour.lan>
From:   =?UTF-8?B?Q2zDqW1lbnQgUMOpcm9u?= <peron.clem@gmail.com>
Date:   Mon, 4 May 2020 21:43:05 +0200
Message-ID: <CAJiuCceF340FiLvyeXNZtvqftQMAmk=MtFDLT_9696ix+eH1Yw@mail.gmail.com>
Subject: Re: [PATCH v3 3/7] ASoC: sun4i-i2s: Add support for H6 I2S
To:     Maxime Ripard <maxime@cerno.tech>
Cc:     Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        Rob Herring <robh+dt@kernel.org>, Chen-Yu Tsai <wens@csie.org>,
        Jaroslav Kysela <perex@perex.cz>,
        Takashi Iwai <tiwai@suse.com>,
        Linux-ALSA <alsa-devel@alsa-project.org>,
        devicetree <devicetree@vger.kernel.org>,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Jernej Skrabec <jernej.skrabec@siol.net>,
        Marcus Cooper <codekipper@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Maxime,

On Mon, 4 May 2020 at 14:09, Maxime Ripard <maxime@cerno.tech> wrote:
>
> Hi Clement,
>
> On Thu, Apr 30, 2020 at 04:00:14PM +0200, Cl=C3=A9ment P=C3=A9ron wrote:
> > On Thu, 30 Apr 2020 at 10:46, Maxime Ripard <maxime@cerno.tech> wrote:
> > > On Wed, Apr 29, 2020 at 06:33:00PM +0200, Cl=C3=A9ment P=C3=A9ron wro=
te:
> > > > On Wed, 29 Apr 2020 at 14:35, Maxime Ripard <maxime@cerno.tech> wro=
te:
> > > > >
> > > > > On Tue, Apr 28, 2020 at 10:55:47AM +0200, Cl=C3=A9ment P=C3=A9ron=
 wrote:
> > > > > > > > +static int sun50i_i2s_set_soc_fmt(const struct sun4i_i2s *=
i2s,
> > > > > > > > +                              unsigned int fmt)
> > > > > > >
> > > > > > > The alignment is off here
> > > > > > >
> > > > > > > > +{
> > > > > > > > +     u32 mode, val;
> > > > > > > > +     u8 offset;
> > > > > > > > +
> > > > > > > > +     /*
> > > > > > > > +      * DAI clock polarity
> > > > > > > > +      *
> > > > > > > > +      * The setup for LRCK contradicts the datasheet, but =
under a
> > > > > > > > +      * scope it's clear that the LRCK polarity is reverse=
d
> > > > > > > > +      * compared to the expected polarity on the bus.
> > > > > > > > +      */
> > > > > > >
> > > > > > > Did you check this or has it been copy-pasted?
> > > > > >
> > > > > > copy-pasted, I will check this.
> > > > >
> > > > > It's not going to be easy to do this if you only have a board wit=
h HDMI. If you
> > > > > can't test that easily, just remove the comment (or make it expli=
cit that you
> > > > > copy pasted it?), no comment is better than a wrong one.
> > > >
> > > > I have talked with Marcus Cooper it may be able to test this this w=
eek-end.
> > > > Also this can explain why we need the "
> > > > simple-audio-card,frame-inversion;" in the device-tree.
> > > >
> > > > If think this fix has been introduced by you, correct? Could you sa=
y
> > > > on which SoC did you see this issue?
> > >
> > > This was seen on an H3
> >
> > Just two more questions:
> > - Did you observe this issue on both TDM and I2S mode?
> > - On which DAI node?
>
> This is fairly fuzzy now and I don't remember if I tested it in I2S. Let'=
s
> assume I didn't. And similarly, I'm not sure what the exact controller wa=
s, but
> it was one of the regular controllers (so not either connected to the cod=
ec or
> the HDMI, one that goes out of the SoC).
>
> We had pretty much the same issue on the A33 in I2S for the codec though:
> https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit=
/sound/soc/sunxi/sun8i-codec.c?id=3D18c1bf35c1c09bca05cf70bc984a4764e0b0372=
b
>
> I didn't think of it that way then, but it might very well have been the =
i2s
> controller suffering the same issue.
>
> > Since recent change in sun4i-i2s.c, we had to introduce the
> > "simple-audio-card,frame-inversion" in LibreElec tree.
>
> Do you have a link to that commit ? I couldn't find anything on libreelec=
's
> github repo.

These commits:
https://github.com/LibreELEC/LibreELEC.tv/blob/master/projects/Allwinner/de=
vices/A64/patches/linux/04-Add-frame-inversion-to-correct-multi-channel-aud=
io.patch
https://github.com/LibreELEC/LibreELEC.tv/blob/master/projects/Allwinner/de=
vices/H3/patches/linux/17-Add-frame-inversion-to-correct-multi-channel-audi=
o.patch
https://github.com/LibreELEC/LibreELEC.tv/blob/master/projects/Allwinner/de=
vices/H6/patches/linux/16-Add-frame-inversion-to-correct-multi-channel-audi=
o.patch

>
> > H3 boards are quite common in LibreElec community so I think:
> >  - This fix is only needed in TDM mode
> >  - Or this fix is not required for the HDMI DAI node (HDMI DAI is a
> > little bit different compare to other DAI but I think the first guess
> > is more likely)
>
> Given what we know about the A33, I'd be inclined to say the latter. I'd =
don't
> have the tools to check anymore, but if you have even a cheap logical ana=
lyzer,
> i2s being pretty slow you can definitely see it.

Me neither but maybe Marcus will be able to check this.
Thanks for all these informations.

>
> Maxime
