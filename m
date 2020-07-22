Return-Path: <SRS0=5pK+=BB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1FE69C433E2
	for <linux-kernel@archiver.kernel.org>; Wed, 22 Jul 2020 08:56:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E96882077D
	for <linux-kernel@archiver.kernel.org>; Wed, 22 Jul 2020 08:56:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="C21JPhyO"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731046AbgGVI4P (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 22 Jul 2020 04:56:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56492 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726254AbgGVI4O (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Jul 2020 04:56:14 -0400
Received: from mail-io1-xd41.google.com (mail-io1-xd41.google.com [IPv6:2607:f8b0:4864:20::d41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4902AC0619DC;
        Wed, 22 Jul 2020 01:56:14 -0700 (PDT)
Received: by mail-io1-xd41.google.com with SMTP id a12so1712668ion.13;
        Wed, 22 Jul 2020 01:56:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=Ln57g9kGaw+MdOcgZwEqa5A1Z1hG/VwmmjB0ZBbadOM=;
        b=C21JPhyOHrIydO6NKi2q8Pphvs5J6wYTWsjI/WilYhnPzBRUEUfbi3sZvNyRqe31sV
         fgkeFWZBGgS9jnNWkNnjcMWavgqiICtwVoD7e1HaBn6rV1E5ZAJXfVf+PB+5TOt8av9G
         kOGFqXG5tHd2MT64x2UE0la5J9oRsm2cKm0DDw5yOiEpM9SHQgMGa1ZOSIwOQvwP4bll
         HS8dQfM9mlpIzy3H9cGIcb21dhsDiYruiQ2Zkgy58Y1bS/0Oz+zcXQU1CfdPToqMKCOT
         ME2/FGgge3o5FdgljJmUPBe8WzJ8M21UjM2IWJrvpE6GLkYt64B6M8uUAsdFlsm2dB2t
         pkvA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=Ln57g9kGaw+MdOcgZwEqa5A1Z1hG/VwmmjB0ZBbadOM=;
        b=p+O6pCPgUC7jzosDs8AAMCwyzCzeNRq/G6dix2QBVwNmzSyl+SA1y6Av3owjDcZk+0
         5uOCW/DXuEGDd2NmMRbLoEZ9iapDtWm+36OkzBZiZxwo8HNa10bTtC40UYAt7caOc6TC
         ShfQBKfeuOwBMyALSm6jkHZTnN2fSNtZSxRJReLRYqCj/Qb8SnwzBjs8emDdZgz6x1dm
         hz+xauC202pSOd9aljctv2aVz3DbvuTrdyW5TmteITaH4PGNVXydiCX5daso4dRMQRT5
         siiDXblLQyGZEV3gcPKQBStv5yon/dGZzcgaYEVKSC3M9Q8RMjX+4HCfiQ8rmj7LAZjM
         /A5A==
X-Gm-Message-State: AOAM532W38kwfyXTKZwziGr/zW39WgcC+okL1ztCjj6/2P8mbeSV1GKj
        QXR/zM+vWqFxpyNMcZrdJNu38k53tvYyx7r4SJYSKRQm6Z8=
X-Google-Smtp-Source: ABdhPJzBn3F4eF5x3FCOg62em2mFuXAaZLS2uGn9dAJTbouuZ36/w0i6SG+5OMOsXp3zAFeZBBv2MzyHd/bLklA870c=
X-Received: by 2002:a5e:8805:: with SMTP id l5mr652782ioj.124.1595408173330;
 Wed, 22 Jul 2020 01:56:13 -0700 (PDT)
MIME-Version: 1.0
References: <20200704113902.336911-1-peron.clem@gmail.com> <20200704113902.336911-2-peron.clem@gmail.com>
 <72a6fddf-5e84-f050-2eee-74178d457789@sholland.org>
In-Reply-To: <72a6fddf-5e84-f050-2eee-74178d457789@sholland.org>
From:   =?UTF-8?B?Q2zDqW1lbnQgUMOpcm9u?= <peron.clem@gmail.com>
Date:   Wed, 22 Jul 2020 10:56:02 +0200
Message-ID: <CAJiuCcej5Drwz_jfF=uHNRG+w_c_SfbyJt7jyck5d_phVh-oLw@mail.gmail.com>
Subject: Re: [linux-sunxi] [PATCH 01/16] ASoC: sun4i-i2s: Add support for H6 I2S
To:     Samuel Holland <samuel@sholland.org>
Cc:     Maxime Ripard <mripard@kernel.org>, Chen-Yu Tsai <wens@csie.org>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Brown <broonie@kernel.org>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Jaroslav Kysela <perex@perex.cz>,
        Takashi Iwai <tiwai@suse.com>,
        Marcus Cooper <codekipper@gmail.com>,
        Jernej Skrabec <jernej.skrabec@siol.net>,
        Linux-ALSA <alsa-devel@alsa-project.org>,
        devicetree <devicetree@vger.kernel.org>,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        linux-sunxi <linux-sunxi@googlegroups.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Samuel,

On Fri, 10 Jul 2020 at 07:44, Samuel Holland <samuel@sholland.org> wrote:
>
> On 7/4/20 6:38 AM, Cl=C3=A9ment P=C3=A9ron wrote:
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
> > index d0a8d5810c0a..9690389cb68e 100644
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
> > @@ -466,6 +481,65 @@ static int sun8i_i2s_set_chan_cfg(const struct sun=
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
>
> According to the manual, LEFT_J and RIGHT_J should use the same calculati=
on as
> I2S, not the one for PCM/DSP.
>
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
>
> From the description in the manual, this looks off by one. The number of =
BCLKs
> per LRCK is LRCK_PERIOD + 1.
>
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
> > @@ -691,6 +765,108 @@ static int sun8i_i2s_set_soc_fmt(const struct sun=
4i_i2s *i2s,
> >       return 0;
> >  }
> >
> > +static int sun50i_i2s_set_soc_fmt(const struct sun4i_i2s *i2s,
> > +                               unsigned int fmt)
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
> This comment makes us sound a lot more confident than I think we actually=
 are.

That's a comment that needs to be checked using a Logic analyzer (that
I don't have).
It's a copy paste from the previous generation.
But this seems wrong as we need to specify
"simple-audio-card,frame-inversion;" in the device-tree.

Regards,
Clement

>
> Regards,
> Samuel
