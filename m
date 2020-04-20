Return-Path: <SRS0=QXtz=6E=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CFE11C3A5A0
	for <linux-kernel@archiver.kernel.org>; Mon, 20 Apr 2020 12:56:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id AE8AA206E9
	for <linux-kernel@archiver.kernel.org>; Mon, 20 Apr 2020 12:56:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="cJ4W1US+"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728622AbgDTM4p (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 20 Apr 2020 08:56:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34930 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726416AbgDTM4n (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Apr 2020 08:56:43 -0400
Received: from mail-io1-xd42.google.com (mail-io1-xd42.google.com [IPv6:2607:f8b0:4864:20::d42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E35D4C061A0C;
        Mon, 20 Apr 2020 05:56:42 -0700 (PDT)
Received: by mail-io1-xd42.google.com with SMTP id z2so6436688iol.11;
        Mon, 20 Apr 2020 05:56:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=pcI0qWNc1N4Zlqa5f3AfBQvRhwW8Vt/U+TEuOLUSgd0=;
        b=cJ4W1US+K62mAFMlX3vEoTunFkNtMdkgjMA9cd/b+CXfHHy+KLOwqk2tlEbEwPbuRH
         xSXmkoHN++WSy+dCUUzGCY9SP3HjreMrDx4yidSHof12jzx8gg1S3xdgSKdfPYb+FdIV
         e58IZzVYnDquHfGCiK/uyNtevWXNWmZG79zBz7IhlF5/0YRxcwiucINo/h7GiOA+LjbD
         LngMieEa3T/tmA3/889Ic5nwImTg272p+BuXfPa7v3y+2FG5H44LloARO7mVe6vUzyGj
         kpzB3udH8cimAN/yo/GqL27F79VRBj98oNpDXitS54sCr29fXiiMvwx1b6a0S0Lq8rQz
         pH2Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=pcI0qWNc1N4Zlqa5f3AfBQvRhwW8Vt/U+TEuOLUSgd0=;
        b=oSwUW2SMWfJ1XX94TWxY7L8gw0JZbvnrQcRNwDSgml/phwgMhXp9b8RowHxYNC3sto
         +YMX4Ofv3SiELdhmeBF7CguARQLCEsQfmYloYUV8HqMRUGAL1JAAgjzMa+uGPij+gEqC
         R4UpqhTP0oTuLL3algMgmVF+b1DfZa0QYDgndcljpBLkCOGNAZhqPJfgdBI10RmPwpGE
         bPgUsDuBdMhw1nflMYHgMccSF+dnI+VULywyFFLyYpxG8u4cPN7GMY+N+akfS7NHQfcy
         Us/n04wEOQdI+8gBE3rjh5lFzHfR8cbfXFUgR2kkH36dyBykVoVvLbT/LZXAJtJ/xJ+p
         A3nw==
X-Gm-Message-State: AGi0PuanRruMe3RyeN0FBZBLke6QMNGwarg3eRD4TG6n81hFKCW5QLii
        w71udwyQbWvpDzia9AH5sOi7d0Adl/M8P4VrjMA=
X-Google-Smtp-Source: APiQypJ157MeGNo8bgnTMRGL69DR4CbiKXoMr5w1w97C8gzFpIW/y2Ja9T72EhZhF6SM+EgLpNS1I3CzKErckee77Lc=
X-Received: by 2002:a05:6602:2fcd:: with SMTP id v13mr15163961iow.124.1587387402154;
 Mon, 20 Apr 2020 05:56:42 -0700 (PDT)
MIME-Version: 1.0
References: <20200418224435.23672-1-peron.clem@gmail.com> <20200418224435.23672-5-peron.clem@gmail.com>
 <20200420124452.5vaoyw73n76jwmey@gilmour.lan>
In-Reply-To: <20200420124452.5vaoyw73n76jwmey@gilmour.lan>
From:   =?UTF-8?B?Q2zDqW1lbnQgUMOpcm9u?= <peron.clem@gmail.com>
Date:   Mon, 20 Apr 2020 14:56:31 +0200
Message-ID: <CAJiuCccAFk3X03OV2MhGuqY7YW0HtM_1gJO9cW0=6OoTkSB6gg@mail.gmail.com>
Subject: Re: [PATCH v2 4/7] ASoC: sun4i-i2s: Set sign extend sample
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
        Marcus Cooper <codekipper@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Maxime,

On Mon, 20 Apr 2020 at 14:44, Maxime Ripard <maxime@cerno.tech> wrote:
>
> On Sun, Apr 19, 2020 at 12:44:32AM +0200, Cl=C3=A9ment P=C3=A9ron wrote:
> > From: Marcus Cooper <codekipper@gmail.com>
> >
> > On the newer SoCs such as the H3 and A64 this is set by default
> > to transfer a 0 after each sample in each slot. However the A10
> > and A20 SoCs that this driver was developed on had a default
> > setting where it padded the audio gain with zeros.
> >
> > This isn't a problem whilst we have only support for 16bit audio
> > but with larger sample resolution rates in the pipeline then SEXT
> > bits should be cleared so that they also pad at the LSB. Without
> > this the audio gets distorted.
> >
> > Signed-off-by: Marcus Cooper <codekipper@gmail.com>
> > Signed-off-by: Cl=C3=A9ment P=C3=A9ron <peron.clem@gmail.com>
> > ---
> >  sound/soc/sunxi/sun4i-i2s.c | 22 ++++++++++++++++++++++
> >  1 file changed, 22 insertions(+)
> >
> > diff --git a/sound/soc/sunxi/sun4i-i2s.c b/sound/soc/sunxi/sun4i-i2s.c
> > index a23c9f2a3f8c..618bbc5156f1 100644
> > --- a/sound/soc/sunxi/sun4i-i2s.c
> > +++ b/sound/soc/sunxi/sun4i-i2s.c
> > @@ -48,6 +48,9 @@
> >  #define SUN4I_I2S_FMT0_FMT_I2S                               (0 << 0)
> >
> >  #define SUN4I_I2S_FMT1_REG           0x08
> > +#define SUN4I_I2S_FMT1_REG_SEXT_MASK         BIT(8)
> > +#define SUN4I_I2S_FMT1_REG_SEXT(sext)                        ((sext) <=
< 8)
> > +
> >  #define SUN4I_I2S_FIFO_TX_REG                0x0c
> >  #define SUN4I_I2S_FIFO_RX_REG                0x10
> >
> > @@ -105,6 +108,9 @@
> >  #define SUN8I_I2S_FMT0_BCLK_POLARITY_INVERTED                (1 << 7)
> >  #define SUN8I_I2S_FMT0_BCLK_POLARITY_NORMAL          (0 << 7)
> >
> > +#define SUN8I_I2S_FMT1_REG_SEXT_MASK         GENMASK(5,4)
> > +#define SUN8I_I2S_FMT1_REG_SEXT(sext)                        ((sext) <=
< 4)
> > +
> >  #define SUN8I_I2S_INT_STA_REG                0x0c
> >  #define SUN8I_I2S_FIFO_TX_REG                0x20
> >
> > @@ -663,6 +669,12 @@ static int sun4i_i2s_set_soc_fmt(const struct sun4=
i_i2s *i2s,
> >       }
> >       regmap_update_bits(i2s->regmap, SUN4I_I2S_CTRL_REG,
> >                          SUN4I_I2S_CTRL_MODE_MASK, val);
> > +
> > +     /* Set sign extension to pad out LSB with 0 */
> > +     regmap_update_bits(i2s->regmap, SUN4I_I2S_FMT1_REG,
> > +                        SUN4I_I2S_FMT1_REG_SEXT_MASK,
> > +                        SUN4I_I2S_FMT1_REG_SEXT(0));
> > +
> >       return 0;
> >  }
> >
> > @@ -765,6 +777,11 @@ static int sun8i_i2s_set_soc_fmt(const struct sun4=
i_i2s *i2s,
> >                          SUN8I_I2S_CTRL_BCLK_OUT | SUN8I_I2S_CTRL_LRCK_=
OUT,
> >                          val);
> >
> > +     /* Set sign extension to pad out LSB with 0 */
> > +     regmap_update_bits(i2s->regmap, SUN4I_I2S_FMT1_REG,
> > +                        SUN8I_I2S_FMT1_REG_SEXT_MASK,
> > +                        SUN8I_I2S_FMT1_REG_SEXT(0));
> > +
> >       return 0;
> >  }
> >
> > @@ -867,6 +884,11 @@ static int sun50i_i2s_set_soc_fmt(const struct sun=
4i_i2s *i2s,
> >                          SUN8I_I2S_CTRL_BCLK_OUT | SUN8I_I2S_CTRL_LRCK_=
OUT,
> >                          val);
> >
> > +     /* Set sign extension to pad out LSB with 0 */
> > +     regmap_update_bits(i2s->regmap, SUN4I_I2S_FMT1_REG,
> > +                        SUN8I_I2S_FMT1_REG_SEXT_MASK,
> > +                        SUN8I_I2S_FMT1_REG_SEXT(0));
> > +
>
> If this is an issue only on the A10 / A20, why are you setting it up on t=
he
> other generations too?

To keep coherency between all set_soc_format(), and also avoid this
kind of issue for future generation.
As this doesn't cost much after all, and it avoid to rely on default,
but what do you think ?

Clement

>
> Maxime
