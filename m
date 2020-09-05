Return-Path: <SRS0=flm+=CO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9BA36C433E2
	for <linux-kernel@archiver.kernel.org>; Sat,  5 Sep 2020 09:44:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3E956206B8
	for <linux-kernel@archiver.kernel.org>; Sat,  5 Sep 2020 09:44:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="P7SZq3di"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728431AbgIEJoo (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 5 Sep 2020 05:44:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39588 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726372AbgIEJom (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 5 Sep 2020 05:44:42 -0400
Received: from mail-io1-xd41.google.com (mail-io1-xd41.google.com [IPv6:2607:f8b0:4864:20::d41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 60AC9C061244;
        Sat,  5 Sep 2020 02:44:42 -0700 (PDT)
Received: by mail-io1-xd41.google.com with SMTP id r9so9552432ioa.2;
        Sat, 05 Sep 2020 02:44:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=MRAOg+eYaa2rEsb3DX+nTvExN1Y8ZloMTYBxu2WO+Og=;
        b=P7SZq3diaIqpOcHQNTbt285fzLsPKCXGaGACEZpnnaDtyRNjG7brmP+FENF8JvhrQh
         K4VgQs8XIqs2AyysPXUUVASiC9DV8Bs2StFORdMsYxe96+bOL/nd0Dx8h6o5tODfc18T
         CCWlvEgZFp/lgB8lGeAV41IucRWGlJyPDBlc0tpxTfMfcimJJNjTK1qI1K222nfE2Zcg
         fm9sUFsCplDn3sSMwuFTYgKecfqBxTCDFJUq7r/DHqx0ZjSGg82n/o9T1+bBRS1BuE06
         W6GIYrnA+9f8uLqBuRliozk12JNtRc+f9R5+Hk2Bh0EX83qW8F/OhI1YcScDzC7bVjHs
         uZOQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=MRAOg+eYaa2rEsb3DX+nTvExN1Y8ZloMTYBxu2WO+Og=;
        b=psTR9Jho5kFuB0Cyf0nuOWxG3oMlA/+PHlxZ5nSv8dB2dVCQ4UDNoR2H00yt/atexm
         swK7Yh/xAfzTS2/aBfdJWa4RvzvuPAfnlN014o66QBpjY3mna72tgnrXTBCDAsDyWXBF
         2o+9DVPWXhafqxGBRnyBkRHvTasyBmP1kPlKlqLnhL4QWFCVDeVdtlum9fUlp6RRrOP5
         onTn1BDc8VTt97fLoxn8xbU++uWgz73RNhl1SOrbPUJrxMHNWdF0oAMOVt7k1RDyc8od
         96Nd8X7p3bWcS8LNMvp3bqEOGBvRicXnAQYwVin85dUhAGxpfVi1j+o5TjHB+KfBIDHR
         owWA==
X-Gm-Message-State: AOAM5310wkaNKm10XbU3ESBSw5PX2u7WFFl3RGopT8Z0H1qOJ0E2H8r8
        RIXJ8XNC8nPTZA3iCeFDgx3ek66JMfyuw0e7IC4=
X-Google-Smtp-Source: ABdhPJyXfvK1S863k7/77Ze1ILkQ4pn0uoDYrNx4ieLIKuFYPgjXVZsg68a5vnb//UDFJVFIlHWJ43gpZjQFmNJGfcE=
X-Received: by 2002:a6b:e017:: with SMTP id z23mr10805226iog.101.1599299081475;
 Sat, 05 Sep 2020 02:44:41 -0700 (PDT)
MIME-Version: 1.0
References: <20200903203034.1057334-1-peron.clem@gmail.com>
 <20200903203034.1057334-3-peron.clem@gmail.com> <7259829d-142e-b518-52a7-6fef388b27d2@sholland.org>
In-Reply-To: <7259829d-142e-b518-52a7-6fef388b27d2@sholland.org>
From:   =?UTF-8?B?Q2zDqW1lbnQgUMOpcm9u?= <peron.clem@gmail.com>
Date:   Sat, 5 Sep 2020 11:44:30 +0200
Message-ID: <CAJiuCcew35XzvA0gW=rq57RE3Oqxsa6y1UyeBJ+1HPoK4fyWgQ@mail.gmail.com>
Subject: Re: [PATCH v2 02/20] ASoC: sun4i-i2s: Add support for H6 I2S
To:     Samuel Holland <samuel@sholland.org>
Cc:     Maxime Ripard <mripard@kernel.org>, Chen-Yu Tsai <wens@csie.org>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Brown <broonie@kernel.org>,
        Liam Girdwood <lgirdwood@gmail.com>,
        devicetree <devicetree@vger.kernel.org>,
        Jernej Skrabec <jernej.skrabec@siol.net>,
        Linux-ALSA <alsa-devel@alsa-project.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Takashi Iwai <tiwai@suse.com>,
        Marcus Cooper <codekipper@gmail.com>,
        linux-sunxi <linux-sunxi@googlegroups.com>,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Samuel,

On Fri, 4 Sep 2020 at 05:16, Samuel Holland <samuel@sholland.org> wrote:
>
> Cl=C3=A9ment,
>
> On 9/3/20 3:30 PM, Cl=C3=A9ment P=C3=A9ron wrote:
> > From: Jernej Skrabec <jernej.skrabec@siol.net>
> >
> > H6 I2S is very similar to that in H3, except it supports up to 16
> > channels.
> >
> > Signed-off-by: Jernej Skrabec <jernej.skrabec@siol.net>
> > Signed-off-by: Marcus Cooper <codekipper@gmail.com>
> > Signed-off-by: Cl=C3=A9ment P=C3=A9ron <peron.clem@gmail.com>
> > ---
> >  sound/soc/sunxi/sun4i-i2s.c | 221 ++++++++++++++++++++++++++++++++++++
> >  1 file changed, 221 insertions(+)
> >
> > diff --git a/sound/soc/sunxi/sun4i-i2s.c b/sound/soc/sunxi/sun4i-i2s.c
> > index fabff7bcccbc..acf24f512f2c 100644
> > --- a/sound/soc/sunxi/sun4i-i2s.c
> > +++ b/sound/soc/sunxi/sun4i-i2s.c
>
> [snip]
>
> > @@ -474,6 +489,65 @@ static int sun8i_i2s_set_chan_cfg(const struct sun=
4i_i2s *i2s,
> >       return 0;
> >  }
> >
> > +static int sun50i_h6_i2s_set_chan_cfg(const struct sun4i_i2s *i2s,
> > +                                   const struct snd_pcm_hw_params *par=
ams)
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
> These cases don't match the documentation: LEFT_J and RIGHT_J are documen=
ted to
> behave like I2S (lrck_period =3D=3D slot_width), not like DSP_A/B (lrck_p=
eriod =3D=3D
> slot_width * slots).
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
>
> Here, i2s->slot_width is the number of bits for each slot, but in PCM mod=
e, you
you mean TDM here right?

> need to multiply by the number of slots, like above.
>
> Also, there is already logic in sun4i_i2s_hw_params to use i2s->slot_widt=
h and
> i2s->slots. You could avoid the duplication by passing slot_width/slots a=
s
> parameters to set_chan_cfg.

Thanks for the catch, I will fix this.

Regards,
Clement

>
> Regards,
> Samuel
>
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
>
> [snip]
