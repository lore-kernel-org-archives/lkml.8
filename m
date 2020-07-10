Return-Path: <SRS0=2Lxt=AV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 07EC6C433E3
	for <linux-kernel@archiver.kernel.org>; Fri, 10 Jul 2020 19:22:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D56122078D
	for <linux-kernel@archiver.kernel.org>; Fri, 10 Jul 2020 19:22:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727925AbgGJTWl convert rfc822-to-8bit (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 10 Jul 2020 15:22:41 -0400
Received: from mailoutvs32.siol.net ([185.57.226.223]:57978 "EHLO
        mail.siol.net" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726867AbgGJTWl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Jul 2020 15:22:41 -0400
Received: from localhost (localhost [127.0.0.1])
        by mail.siol.net (Postfix) with ESMTP id 9A60B522763;
        Fri, 10 Jul 2020 21:22:37 +0200 (CEST)
X-Virus-Scanned: amavisd-new at psrvmta10.zcs-production.pri
Received: from mail.siol.net ([127.0.0.1])
        by localhost (psrvmta10.zcs-production.pri [127.0.0.1]) (amavisd-new, port 10032)
        with ESMTP id gejh6xTW37uc; Fri, 10 Jul 2020 21:22:37 +0200 (CEST)
Received: from mail.siol.net (localhost [127.0.0.1])
        by mail.siol.net (Postfix) with ESMTPS id 1D556522762;
        Fri, 10 Jul 2020 21:22:37 +0200 (CEST)
Received: from jernej-laptop.localnet (89-212-178-211.dynamic.t-2.net [89.212.178.211])
        (Authenticated sender: jernej.skrabec@siol.net)
        by mail.siol.net (Postfix) with ESMTPA id 0D90A522763;
        Fri, 10 Jul 2020 21:22:35 +0200 (CEST)
From:   Jernej =?utf-8?B?xaBrcmFiZWM=?= <jernej.skrabec@siol.net>
To:     peron.clem@gmail.com, Maxime Ripard <mripard@kernel.org>,
        Chen-Yu Tsai <wens@csie.org>, Rob Herring <robh+dt@kernel.org>,
        Mark Brown <broonie@kernel.org>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Samuel Holland <samuel@sholland.org>
Cc:     Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>,
        Marcus Cooper <codekipper@gmail.com>,
        alsa-devel@alsa-project.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-sunxi@googlegroups.com
Subject: Re: [linux-sunxi] [PATCH 01/16] ASoC: sun4i-i2s: Add support for H6 I2S
Date:   Fri, 10 Jul 2020 21:22:34 +0200
Message-ID: <3787973.dVgI16VYFl@jernej-laptop>
In-Reply-To: <72a6fddf-5e84-f050-2eee-74178d457789@sholland.org>
References: <20200704113902.336911-1-peron.clem@gmail.com> <20200704113902.336911-2-peron.clem@gmail.com> <72a6fddf-5e84-f050-2eee-74178d457789@sholland.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8BIT
Content-Type: text/plain; charset="iso-8859-1"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Samuel!

Dne petek, 10. julij 2020 ob 07:44:33 CEST je Samuel Holland napisal(a):
> On 7/4/20 6:38 AM, Clément Péron wrote:
> > From: Jernej Skrabec <jernej.skrabec@siol.net>
> > 
> > H6 I2S is very similar to that in H3, except it supports up to 16
> > channels.
> > 
> > Signed-off-by: Jernej Skrabec <jernej.skrabec@siol.net>
> > Signed-off-by: Marcus Cooper <codekipper@gmail.com>
> > Signed-off-by: Clément Péron <peron.clem@gmail.com>
> > ---
> > 
> >  sound/soc/sunxi/sun4i-i2s.c | 227 ++++++++++++++++++++++++++++++++++++
> >  1 file changed, 227 insertions(+)
> > 
> > diff --git a/sound/soc/sunxi/sun4i-i2s.c b/sound/soc/sunxi/sun4i-i2s.c
> > index d0a8d5810c0a..9690389cb68e 100644
> > --- a/sound/soc/sunxi/sun4i-i2s.c
> > +++ b/sound/soc/sunxi/sun4i-i2s.c
> > @@ -124,6 +124,21 @@
> > 
> >  #define SUN8I_I2S_RX_CHAN_SEL_REG	0x54
> >  #define SUN8I_I2S_RX_CHAN_MAP_REG	0x58
> > 
> > +/* Defines required for sun50i-h6 support */
> > +#define SUN50I_H6_I2S_TX_CHAN_SEL_OFFSET_MASK	GENMASK(21, 20)
> > +#define SUN50I_H6_I2S_TX_CHAN_SEL_OFFSET(offset)	((offset) << 20)
> > +#define SUN50I_H6_I2S_TX_CHAN_SEL_MASK		GENMASK(19, 16)
> > +#define SUN50I_H6_I2S_TX_CHAN_SEL(chan)		((chan - 1) << 16)
> > +#define SUN50I_H6_I2S_TX_CHAN_EN_MASK		GENMASK(15, 0)
> > +#define SUN50I_H6_I2S_TX_CHAN_EN(num_chan)	(((1 << num_chan) - 1))
> > +
> > +#define SUN50I_H6_I2S_TX_CHAN_MAP0_REG	0x44
> > +#define SUN50I_H6_I2S_TX_CHAN_MAP1_REG	0x48
> > +
> > +#define SUN50I_H6_I2S_RX_CHAN_SEL_REG	0x64
> > +#define SUN50I_H6_I2S_RX_CHAN_MAP0_REG	0x68
> > +#define SUN50I_H6_I2S_RX_CHAN_MAP1_REG	0x6C
> > +
> > 
> >  struct sun4i_i2s;
> >  
> >  /**
> > 
> > @@ -466,6 +481,65 @@ static int sun8i_i2s_set_chan_cfg(const struct
> > sun4i_i2s *i2s,> 
> >  	return 0;
> >  
> >  }
> > 
> > +static int sun50i_i2s_set_chan_cfg(const struct sun4i_i2s *i2s,
> > +				   const struct snd_pcm_hw_params 
*params)
> > +{
> > +	unsigned int channels = params_channels(params);
> > +	unsigned int slots = channels;
> > +	unsigned int lrck_period;
> > +
> > +	if (i2s->slots)
> > +		slots = i2s->slots;
> > +
> > +	/* Map the channels for playback and capture */
> > +	regmap_write(i2s->regmap, SUN50I_H6_I2S_TX_CHAN_MAP1_REG, 
0x76543210);
> > +	regmap_write(i2s->regmap, SUN50I_H6_I2S_RX_CHAN_MAP1_REG, 
0x76543210);
> > +
> > +	/* Configure the channels */
> > +	regmap_update_bits(i2s->regmap, SUN8I_I2S_TX_CHAN_SEL_REG,
> > +			   SUN50I_H6_I2S_TX_CHAN_SEL_MASK,
> > +			   SUN50I_H6_I2S_TX_CHAN_SEL(channels));
> > +	regmap_update_bits(i2s->regmap, SUN50I_H6_I2S_RX_CHAN_SEL_REG,
> > +			   SUN50I_H6_I2S_TX_CHAN_SEL_MASK,
> > +			   SUN50I_H6_I2S_TX_CHAN_SEL(channels));
> > +
> > +	regmap_update_bits(i2s->regmap, SUN8I_I2S_CHAN_CFG_REG,
> > +			   SUN8I_I2S_CHAN_CFG_TX_SLOT_NUM_MASK,
> > +			   
SUN8I_I2S_CHAN_CFG_TX_SLOT_NUM(channels));
> > +	regmap_update_bits(i2s->regmap, SUN8I_I2S_CHAN_CFG_REG,
> > +			   SUN8I_I2S_CHAN_CFG_RX_SLOT_NUM_MASK,
> > +			   
SUN8I_I2S_CHAN_CFG_RX_SLOT_NUM(channels));
> > +
> > +	switch (i2s->format & SND_SOC_DAIFMT_FORMAT_MASK) {
> > +	case SND_SOC_DAIFMT_DSP_A:
> > +	case SND_SOC_DAIFMT_DSP_B:
> > +	case SND_SOC_DAIFMT_LEFT_J:
> 
> > +	case SND_SOC_DAIFMT_RIGHT_J:
> According to the manual, LEFT_J and RIGHT_J should use the same calculation
> as I2S, not the one for PCM/DSP.
> 
> > +		lrck_period = params_physical_width(params) * slots;
> > +		break;
> > +
> > +	case SND_SOC_DAIFMT_I2S:
> > +		lrck_period = params_physical_width(params);
> > +		break;
> > +
> > +	default:
> > +		return -EINVAL;
> > +	}
> > +
> > +	if (i2s->slot_width)
> > +		lrck_period = i2s->slot_width;
> > +
> > +	regmap_update_bits(i2s->regmap, SUN4I_I2S_FMT0_REG,
> > +			   SUN8I_I2S_FMT0_LRCK_PERIOD_MASK,
> > +			   SUN8I_I2S_FMT0_LRCK_PERIOD(lrck_period));
> 
> From the description in the manual, this looks off by one. The number of
> BCLKs per LRCK is LRCK_PERIOD + 1.

Are you sure? Macro SUN8I_I2S_FMT0_LRCK_PERIOD() is defined as follows:

#define SUN8I_I2S_FMT0_LRCK_PERIOD(period)	((period - 1) << 8)

which already lowers value by 1.

Best regards,
Jernej

> 
> > +
> > +	regmap_update_bits(i2s->regmap, SUN8I_I2S_TX_CHAN_SEL_REG,
> > +			   SUN50I_H6_I2S_TX_CHAN_EN_MASK,
> > +			   SUN50I_H6_I2S_TX_CHAN_EN(channels));
> > +
> > +	return 0;
> > +}
> > +
> > 
> >  static int sun4i_i2s_hw_params(struct snd_pcm_substream *substream,
> >  
> >  			       struct snd_pcm_hw_params *params,
> >  			       struct snd_soc_dai *dai)
> > 
> > @@ -691,6 +765,108 @@ static int sun8i_i2s_set_soc_fmt(const struct
> > sun4i_i2s *i2s,> 
> >  	return 0;
> >  
> >  }
> > 
> > +static int sun50i_i2s_set_soc_fmt(const struct sun4i_i2s *i2s,
> > +				  unsigned int fmt)
> > +{
> > +	u32 mode, val;
> > +	u8 offset;
> > +
> > +	/*
> > +	 * DAI clock polarity
> > +	 *
> > +	 * The setup for LRCK contradicts the datasheet, but under a
> > +	 * scope it's clear that the LRCK polarity is reversed
> > +	 * compared to the expected polarity on the bus.
> > +	 */
> 
> This comment makes us sound a lot more confident than I think we actually
> are.
> 
> Regards,
> Samuel




