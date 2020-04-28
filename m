Return-Path: <SRS0=r24B=6M=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 375A7C83007
	for <linux-kernel@archiver.kernel.org>; Tue, 28 Apr 2020 08:56:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0FE0E206B9
	for <linux-kernel@archiver.kernel.org>; Tue, 28 Apr 2020 08:56:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="X0C8oWWC"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726772AbgD1I4A (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 28 Apr 2020 04:56:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38280 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726271AbgD1Iz7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Apr 2020 04:55:59 -0400
Received: from mail-il1-x144.google.com (mail-il1-x144.google.com [IPv6:2607:f8b0:4864:20::144])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CC2FEC03C1A9;
        Tue, 28 Apr 2020 01:55:59 -0700 (PDT)
Received: by mail-il1-x144.google.com with SMTP id c18so4252610ile.5;
        Tue, 28 Apr 2020 01:55:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=TD/lnuFC44QRgJpTGVlf3YDYyxHlyiyz2n23ed9C6mM=;
        b=X0C8oWWC7HBDefztnjqwVNF6CUzQX/XKsvz0/P0Gpxoi0RAKyYdc6pLqlm3Sv5rTOc
         36wrzvNTFC0VZMEIMnFqljO0jppeodCMx+v4ENiTI6GsS3IAOG/gkYK3ur+tQu9hpI0H
         Llm1dng014acptPeaRWLEthJwG5SKroInUG102Tsw37ySBPxiywhJGk6ajpZEz6IvS+l
         qaTqCJu93AB0A2gA2juzpeIyyFVvQ1RyVc9+2IaBbzDpF2G4ZO4oUWfGYp4V+wPkcO7V
         B/JD9Gds7XvfEJZ/qqi9XGjaYOhC8gtnZffMIwTGX2G01fGDH5pEjf/OXAs0tUjTo2eT
         yKsQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=TD/lnuFC44QRgJpTGVlf3YDYyxHlyiyz2n23ed9C6mM=;
        b=rkYyyh/cLfgM5CMAiSV9r17CycebkQPuVP2qLlgIOoE6+185zlDUNsTC0Y85BDPCN+
         RsGHHhOHXI1tlsI1u0WbpQGOLjCmEM+/Jz86psTDjAXSZmyuG5mg1O9Lb84rUEcLh1Dm
         XvjInlKMQY/m9qLzFRyATiXECDvOTAElm8yyIZyzPISG1ybPXdtg2GY1iZvv5YG6Uayg
         7TA4Hx9HzNSLfvV4J8BRI0ZHa+QhZo/Iwak9mEF1+omQLruIbW0dXsx7w+Zhjo037XhC
         CO1zKciWX4HR853GpmW3ZsblvcpEnVTVzedy62o6gyT7VMs5+WJoay6Zq5agjEchSVDY
         ld3w==
X-Gm-Message-State: AGi0PubeaacaBqXHQ3u4ZT+y5gqSvquePoJBEeQyi9QwMygtPheMOsg2
        ilrNt5P2DWsaiyMPnE3VP5Ph087fy5/b7bWrD2Q=
X-Google-Smtp-Source: APiQypI1+9N3ua5Z1bos34+qF798abCjulu/oQUQazj2tzQmHK/vdQIdGibMX1aIFSQg6JHmO/7h5kDmFG/UmZPLrC0=
X-Received: by 2002:a05:6e02:111:: with SMTP id t17mr23768711ilm.59.1588064158991;
 Tue, 28 Apr 2020 01:55:58 -0700 (PDT)
MIME-Version: 1.0
References: <20200426104115.22630-1-peron.clem@gmail.com> <20200426104115.22630-4-peron.clem@gmail.com>
 <20200428081321.ht3el26yqhsnyfm4@gilmour.lan>
In-Reply-To: <20200428081321.ht3el26yqhsnyfm4@gilmour.lan>
From:   =?UTF-8?B?Q2zDqW1lbnQgUMOpcm9u?= <peron.clem@gmail.com>
Date:   Tue, 28 Apr 2020 10:55:47 +0200
Message-ID: <CAJiuCcdVs_drs40Q6537BYfz24F7NmC6B8S5-Lt4V4ggs-FXWA@mail.gmail.com>
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

On Tue, 28 Apr 2020 at 10:13, Maxime Ripard <maxime@cerno.tech> wrote:
>
> Hi,
>
> On Sun, Apr 26, 2020 at 12:41:11PM +0200, Cl=C3=A9ment P=C3=A9ron wrote:
> > From: Jernej Skrabec <jernej.skrabec@siol.net>
> >
> > H6 I2S is very similar to that in H3, except it supports up to 16
> > channels.
> >
> > Signed-off-by: Jernej Skrabec <jernej.skrabec@siol.net>
> > Signed-off-by: Marcus Cooper <codekipper@gmail.com>
> > Signed-off-by: Cl=C3=A9ment P=C3=A9ron <peron.clem@gmail.com>
> > ---
> >  sound/soc/sunxi/sun4i-i2s.c | 227 ++++++++++++++++++++++++++++++++++++
> >  1 file changed, 227 insertions(+)
> >
> > diff --git a/sound/soc/sunxi/sun4i-i2s.c b/sound/soc/sunxi/sun4i-i2s.c
> > index 4198a5410bf9..a23c9f2a3f8c 100644
> > --- a/sound/soc/sunxi/sun4i-i2s.c
> > +++ b/sound/soc/sunxi/sun4i-i2s.c
> > @@ -124,6 +124,21 @@
> >  #define SUN8I_I2S_RX_CHAN_SEL_REG    0x54
> >  #define SUN8I_I2S_RX_CHAN_MAP_REG    0x58
> >
> > +/* Defines required for sun50i-h6 support */
> > +#define SUN50I_H6_I2S_TX_CHAN_SEL_OFFSET_MASK        GENMASK(21, 20)
> > +#define SUN50I_H6_I2S_TX_CHAN_SEL_OFFSET(offset)     ((offset) << 20)
> > +#define SUN50I_H6_I2S_TX_CHAN_SEL_MASK               GENMASK(19, 16)
> > +#define SUN50I_H6_I2S_TX_CHAN_SEL(chan)              ((chan - 1) << 16=
)
> > +#define SUN50I_H6_I2S_TX_CHAN_EN_MASK                GENMASK(15, 0)
> > +#define SUN50I_H6_I2S_TX_CHAN_EN(num_chan)   (((1 << num_chan) - 1))
> > +
> > +#define SUN50I_H6_I2S_TX_CHAN_MAP0_REG       0x44
> > +#define SUN50I_H6_I2S_TX_CHAN_MAP1_REG       0x48
> > +
> > +#define SUN50I_H6_I2S_RX_CHAN_SEL_REG        0x64
> > +#define SUN50I_H6_I2S_RX_CHAN_MAP0_REG       0x68
> > +#define SUN50I_H6_I2S_RX_CHAN_MAP1_REG       0x6C
> > +
> >  struct sun4i_i2s;
> >
> >  /**
> > @@ -469,6 +484,65 @@ static int sun8i_i2s_set_chan_cfg(const struct sun=
4i_i2s *i2s,
> >       return 0;
> >  }
> >
> > +static int sun50i_i2s_set_chan_cfg(const struct sun4i_i2s *i2s,
> > +                                const struct snd_pcm_hw_params *params=
)
> > +{
> > +     unsigned int channels =3D params_channels(params);
> > +     unsigned int slots =3D channels;
> > +     unsigned int lrck_period;
> > +
> > +     if (i2s->slots)
> > +             slots =3D i2s->slots;
> > +
> > +     /* Map the channels for playback and capture */
> > +     regmap_write(i2s->regmap, SUN50I_H6_I2S_TX_CHAN_MAP1_REG, 0x76543=
210);
> > +     regmap_write(i2s->regmap, SUN50I_H6_I2S_RX_CHAN_MAP1_REG, 0x76543=
210);
> > +
> > +     /* Configure the channels */
> > +     regmap_update_bits(i2s->regmap, SUN8I_I2S_TX_CHAN_SEL_REG,
> > +                        SUN50I_H6_I2S_TX_CHAN_SEL_MASK,
> > +                        SUN50I_H6_I2S_TX_CHAN_SEL(channels));
> > +     regmap_update_bits(i2s->regmap, SUN50I_H6_I2S_RX_CHAN_SEL_REG,
> > +                        SUN50I_H6_I2S_TX_CHAN_SEL_MASK,
> > +                        SUN50I_H6_I2S_TX_CHAN_SEL(channels));
> > +
> > +     regmap_update_bits(i2s->regmap, SUN8I_I2S_CHAN_CFG_REG,
> > +                        SUN8I_I2S_CHAN_CFG_TX_SLOT_NUM_MASK,
> > +                        SUN8I_I2S_CHAN_CFG_TX_SLOT_NUM(channels));
> > +     regmap_update_bits(i2s->regmap, SUN8I_I2S_CHAN_CFG_REG,
> > +                        SUN8I_I2S_CHAN_CFG_RX_SLOT_NUM_MASK,
> > +                        SUN8I_I2S_CHAN_CFG_RX_SLOT_NUM(channels));
> > +
> > +     switch (i2s->format & SND_SOC_DAIFMT_FORMAT_MASK) {
> > +     case SND_SOC_DAIFMT_DSP_A:
> > +     case SND_SOC_DAIFMT_DSP_B:
> > +     case SND_SOC_DAIFMT_LEFT_J:
> > +     case SND_SOC_DAIFMT_RIGHT_J:
> > +             lrck_period =3D params_physical_width(params) * slots;
> > +             break;
> > +
> > +     case SND_SOC_DAIFMT_I2S:
> > +             lrck_period =3D params_physical_width(params);
> > +             break;
> > +
> > +     default:
> > +             return -EINVAL;
> > +     }
> > +
> > +     if (i2s->slot_width)
> > +             lrck_period =3D i2s->slot_width;
> > +
> > +     regmap_update_bits(i2s->regmap, SUN4I_I2S_FMT0_REG,
> > +                        SUN8I_I2S_FMT0_LRCK_PERIOD_MASK,
> > +                        SUN8I_I2S_FMT0_LRCK_PERIOD(lrck_period));
> > +
> > +     regmap_update_bits(i2s->regmap, SUN8I_I2S_TX_CHAN_SEL_REG,
> > +                        SUN50I_H6_I2S_TX_CHAN_EN_MASK,
> > +                        SUN50I_H6_I2S_TX_CHAN_EN(channels));
> > +
> > +     return 0;
> > +}
> > +
> >  static int sun4i_i2s_hw_params(struct snd_pcm_substream *substream,
> >                              struct snd_pcm_hw_params *params,
> >                              struct snd_soc_dai *dai)
> > @@ -694,6 +768,108 @@ static int sun8i_i2s_set_soc_fmt(const struct sun=
4i_i2s *i2s,
> >       return 0;
> >  }
> >
> > +static int sun50i_i2s_set_soc_fmt(const struct sun4i_i2s *i2s,
> > +                              unsigned int fmt)
>
> The alignment is off here
>
> > +{
> > +     u32 mode, val;
> > +     u8 offset;
> > +
> > +     /*
> > +      * DAI clock polarity
> > +      *
> > +      * The setup for LRCK contradicts the datasheet, but under a
> > +      * scope it's clear that the LRCK polarity is reversed
> > +      * compared to the expected polarity on the bus.
> > +      */
>
> Did you check this or has it been copy-pasted?

copy-pasted, I will check this.

Thanks,
Clement

>
> Thanks!
> Maxime
