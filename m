Return-Path: <SRS0=5pK+=BB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A193AC433ED
	for <linux-kernel@archiver.kernel.org>; Wed, 22 Jul 2020 09:13:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7A5B720729
	for <linux-kernel@archiver.kernel.org>; Wed, 22 Jul 2020 09:13:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Mx2/1kIG"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731452AbgGVJNH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 22 Jul 2020 05:13:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59088 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726807AbgGVJNE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Jul 2020 05:13:04 -0400
Received: from mail-io1-xd43.google.com (mail-io1-xd43.google.com [IPv6:2607:f8b0:4864:20::d43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3DCB7C0619DE;
        Wed, 22 Jul 2020 02:13:04 -0700 (PDT)
Received: by mail-io1-xd43.google.com with SMTP id q74so1816469iod.1;
        Wed, 22 Jul 2020 02:13:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=GyRxF7Nof4yvmm5C8pDQESbIZ2Mb/0gJOYuusdB+OgQ=;
        b=Mx2/1kIGiCwUiHFEbOMhkQg4CliDGUiVAllGZzv0Oif92RcttjgR05avimrQxoXIJ0
         0gaCFik8zJerDazAUHv0vUUQqxKWXGMwe/Otbmurne5Nm7ruHSAApJOKV+r0hjwE7TLz
         VOv+yRs4EekMAs7UGvNpLANa/y1UAMIYnPTETwJ278KxbwK0fqFrDDcUYk1xj3Datxc7
         vF7GeckAAERSiGBaY2iCdJeeneAw8jJ3IWxS8+Hep2ZZ++ybL7iugEP9AW/rlQUJh8Eu
         YcwM6XOyQMSMfZ3WZ0LvYR01xa57ntIqnqwGYq2JxI3K53IrYBMoY4ZpkOMbrEyCp19Y
         vKGg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=GyRxF7Nof4yvmm5C8pDQESbIZ2Mb/0gJOYuusdB+OgQ=;
        b=bgOvxGFI7qiOuR3P56cDnVe2hxkFoY33iZQQLSrEypL8jg+WpwPJUyRClv2/27KRYq
         YWfKKZkrXlzSYe1Cjm5hkV/CMAD9JWszLp5/FFIyV3kDowT1bpUWMWmroR/ZuM66xqw4
         rnE5kYtznfVJwK+UiIA5TWeiaPThqY2NQdHxnKjpa5gxb4TWwVIpW5xB37tNHOKQs0sN
         hdvQwr41rdK6apV2jmJ6NNFctqsV1Mtbb24KsdM0elLRVg9XrB9vOu42t2Dd9LeQqwCF
         RtIsKPe4fpb0AVBqJY4flXNHU6SRuD3qjJ2+TQK9t6v9iExnLLPYvTfoEAuA0YQ8YKHc
         Jf9A==
X-Gm-Message-State: AOAM533sdwxe+Dhi0cteCJZplwunLDl2fPgVXSdgIVUKieeL7l2+YL3k
        hh2XpIYorVqVRoKACsfNric9BM8hFs2+sXshUIs=
X-Google-Smtp-Source: ABdhPJyTId2XFONSYkCoGNyYVU88WuRW4ffDfWIXU00zBnQi1qoRUepZig8tIhJdxOfDJmY9ul/cc5Jc+caVjBW78XQ=
X-Received: by 2002:a6b:ba06:: with SMTP id k6mr3766124iof.101.1595409183349;
 Wed, 22 Jul 2020 02:13:03 -0700 (PDT)
MIME-Version: 1.0
References: <20200704113902.336911-1-peron.clem@gmail.com> <20200704113902.336911-5-peron.clem@gmail.com>
 <2910ec3c-25f1-d617-54a8-db6d21acb742@sholland.org>
In-Reply-To: <2910ec3c-25f1-d617-54a8-db6d21acb742@sholland.org>
From:   =?UTF-8?B?Q2zDqW1lbnQgUMOpcm9u?= <peron.clem@gmail.com>
Date:   Wed, 22 Jul 2020 11:12:51 +0200
Message-ID: <CAJiuCccO1cj0_tT=Swad8+cv4Pi_Daq=__3YU+NLeU1Kc-rNNQ@mail.gmail.com>
Subject: Re: [linux-sunxi] [PATCH 04/16] ASoC: sun4i-i2s: Set sign extend sample
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
> > From: Marcus Cooper <codekipper@gmail.com>
> >
> > On the newer SoCs such as the H3 and A64 this is set by default
> > to transfer a 0 after each sample in each slot. However the A10
> > and A20 SoCs that this driver was developed on had a default
> > setting where it padded the audio gain with zeros.
> >
> > This isn't a problem while we have only support for 16bit audio
> > but with larger sample resolution rates in the pipeline then SEXT
> > bits should be cleared so that they also pad at the LSB. Without
> > this the audio gets distorted.
> >
> > Set sign extend sample for all the sunxi generations even if they
> > are not affected. This will keep coherency and avoid relying on
> > default.
> >
> > Signed-off-by: Marcus Cooper <codekipper@gmail.com>
> > Signed-off-by: Cl=C3=A9ment P=C3=A9ron <peron.clem@gmail.com>
> > ---
> >  sound/soc/sunxi/sun4i-i2s.c | 22 ++++++++++++++++++++++
> >  1 file changed, 22 insertions(+)
> >
> > diff --git a/sound/soc/sunxi/sun4i-i2s.c b/sound/soc/sunxi/sun4i-i2s.c
> > index 8bae97efea30..f78167e152ce 100644
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
> > +#define SUN8I_I2S_FMT1_REG_SEXT_MASK         GENMASK(5, 4)
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
>
> This is just a note; I'm not suggesting a change here:
>
> This does nothing, because SUN4I_I2S_FMT1_REG only affects PCM mode, whic=
h is
> not implemented in the driver for the sun4i generation of hardware. PCM m=
ode
> requires setting bit 4 of SUN4I_I2S_CTRL_REG, and then configuring
> SUN4I_I2S_FMT1_REG instead of SUN4I_I2S_FMT0_REG.

Thanks for the catch,
So i will drop it for sun4i.

Regards,
Clement

>
> Regards,
> Samuel
