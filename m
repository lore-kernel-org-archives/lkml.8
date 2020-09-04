Return-Path: <SRS0=2gBQ=CN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.0 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,NICE_REPLY_A,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F08BEC43461
	for <linux-kernel@archiver.kernel.org>; Fri,  4 Sep 2020 03:17:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C0327206D4
	for <linux-kernel@archiver.kernel.org>; Fri,  4 Sep 2020 03:17:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=sholland.org header.i=@sholland.org header.b="m0e4m83U";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="tqOQwF6A"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729626AbgIDDRB (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 3 Sep 2020 23:17:01 -0400
Received: from wnew1-smtp.messagingengine.com ([64.147.123.26]:50743 "EHLO
        wnew1-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1729528AbgIDDQ4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Sep 2020 23:16:56 -0400
Received: from compute3.internal (compute3.nyi.internal [10.202.2.43])
        by mailnew.west.internal (Postfix) with ESMTP id 1BAEB11DB;
        Thu,  3 Sep 2020 23:16:55 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute3.internal (MEProxy); Thu, 03 Sep 2020 23:16:56 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sholland.org; h=
        subject:to:cc:references:from:message-id:date:mime-version
        :in-reply-to:content-type:content-transfer-encoding; s=fm3; bh=+
        z1Kb4Um0CPctRz1L04iCmmEs7XyrQXGEhgGFCnYXJQ=; b=m0e4m83UmKy2lFD5u
        ePD7rpLOYh69eKx1kFwv4Kbp302ri/dLo7IxUPS0JqPCZtDBggv0wL6nbVLh3/aE
        L9uTid45kqLHBi0S84K60BSZlGbfNVa6+m67fKgGA79ZJ06CnCNMe2iOapDFJwYr
        QnjntpmDTUk1DuSSUCH+oHW6IG10IFXSum7NjNfn+MAeIVqo0CRPK9mXK/04JGif
        QcHgtEZ3D4Q4wUNfDrj8coNZ21PYdCf5W3z19hluqM5G4R5SYRdaVZgGVcVgrTIt
        SgpZZCvp1TKK0BwJ3hbNCIg83MbeHHsDhIiuflAqBpVRhYSAWLgo77MSUb1rAl0+
        ufd/w==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-transfer-encoding:content-type
        :date:from:in-reply-to:message-id:mime-version:references
        :subject:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender
        :x-sasl-enc; s=fm3; bh=+z1Kb4Um0CPctRz1L04iCmmEs7XyrQXGEhgGFCnYX
        JQ=; b=tqOQwF6Atg707GjaJqRaOCQROw4uI+GNBekdYdvysmtg2n8RE1+yb8nhx
        w+jQgMCSa40UhH4MmWhxy6C4tfsKcfuLNiN+k4GZKwSmBqLACw05xeVHh0ByJW9Z
        QCI3nBWv0rgbO8awBgY8wQhMKUy9LAfusHHknn7eGOx/cqZtkY65MuI4Ah25MjAr
        eB3Vnj7pE7AtWoZXd7KeSE5pJitOPl5jp2ULeBXpKRLceji+TDctSH7UeJrY0eWO
        EypHbEaUzH92vE1P9cbf9GO9inXCAjgBx20IFyDykdD72BTD1AzccT9f9NYG0f5x
        R8Fcg2Fz+qfx7G8HBY4Vm6/X+KmxQ==
X-ME-Sender: <xms:o7FRX-8zRMmqJWZ-9TI67rgp60tHb6ciPFwJfWYCHL3jQELz0M2BFA>
    <xme:o7FRX-vy_GLnnTRsh2BeSf1YkGP-Sa4FGFYnajdB4kGJRfd7ZsAGdsAH43Dyi1vqt
    -6rFf2qH3PfgUaOeg>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeduiedrudegvddgieelucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepuffvfhfhkffffgggjggtgfesthekredttdefjeenucfhrhhomhepufgrmhhu
    vghlucfjohhllhgrnhguuceoshgrmhhuvghlsehshhholhhlrghnugdrohhrgheqnecugg
    ftrfgrthhtvghrnhepgfelkeduveejtdejhfeiledvhfeggeeiieeklefhfeefffffffeg
    udetteelieejnecukfhppeejtddrudefhedrudegkedrudehudenucevlhhushhtvghruf
    hiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehsrghmuhgvlhesshhhohhllhgr
    nhgurdhorhhg
X-ME-Proxy: <xmx:o7FRX0Do9hlsmovC_eU8IjPC4yX2w7VYw3JtLcODYobgN6AmiyRaYA>
    <xmx:o7FRX2fPrcLmw2038-z5eWKP0faG9BaDV3KXCe1HXyh_UOe0F-IEqA>
    <xmx:o7FRXzOdj80tW9trTBakrHx8Fz0N-khbEnFBPs-Q3NYa92YQhYBTZQ>
    <xmx:prFRXwnEx2XycvrSkeVGpuIk9czO4mZkAI66oivPbjbrKtv8K9_sDPi5Dt4>
Received: from [192.168.50.169] (70-135-148-151.lightspeed.stlsmo.sbcglobal.net [70.135.148.151])
        by mail.messagingengine.com (Postfix) with ESMTPA id B4D9E328005D;
        Thu,  3 Sep 2020 23:16:50 -0400 (EDT)
Subject: Re: [PATCH v2 02/20] ASoC: sun4i-i2s: Add support for H6 I2S
To:     =?UTF-8?B?Q2zDqW1lbnQgUMOpcm9u?= <peron.clem@gmail.com>,
        Maxime Ripard <mripard@kernel.org>,
        Chen-Yu Tsai <wens@csie.org>, Rob Herring <robh+dt@kernel.org>,
        Mark Brown <broonie@kernel.org>,
        Liam Girdwood <lgirdwood@gmail.com>
Cc:     devicetree@vger.kernel.org,
        Jernej Skrabec <jernej.skrabec@siol.net>,
        alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org,
        Takashi Iwai <tiwai@suse.com>,
        Marcus Cooper <codekipper@gmail.com>,
        linux-sunxi@googlegroups.com, linux-arm-kernel@lists.infradead.org
References: <20200903203034.1057334-1-peron.clem@gmail.com>
 <20200903203034.1057334-3-peron.clem@gmail.com>
From:   Samuel Holland <samuel@sholland.org>
Message-ID: <7259829d-142e-b518-52a7-6fef388b27d2@sholland.org>
Date:   Thu, 3 Sep 2020 22:16:50 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.6.0
MIME-Version: 1.0
In-Reply-To: <20200903203034.1057334-3-peron.clem@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Clément,

On 9/3/20 3:30 PM, Clément Péron wrote:
> From: Jernej Skrabec <jernej.skrabec@siol.net>
> 
> H6 I2S is very similar to that in H3, except it supports up to 16
> channels.
> 
> Signed-off-by: Jernej Skrabec <jernej.skrabec@siol.net>
> Signed-off-by: Marcus Cooper <codekipper@gmail.com>
> Signed-off-by: Clément Péron <peron.clem@gmail.com>
> ---
>  sound/soc/sunxi/sun4i-i2s.c | 221 ++++++++++++++++++++++++++++++++++++
>  1 file changed, 221 insertions(+)
> 
> diff --git a/sound/soc/sunxi/sun4i-i2s.c b/sound/soc/sunxi/sun4i-i2s.c
> index fabff7bcccbc..acf24f512f2c 100644
> --- a/sound/soc/sunxi/sun4i-i2s.c
> +++ b/sound/soc/sunxi/sun4i-i2s.c

[snip]

> @@ -474,6 +489,65 @@ static int sun8i_i2s_set_chan_cfg(const struct sun4i_i2s *i2s,
>  	return 0;
>  }
>  
> +static int sun50i_h6_i2s_set_chan_cfg(const struct sun4i_i2s *i2s,
> +				      const struct snd_pcm_hw_params *params)
> +{
> +	unsigned int channels = params_channels(params);
> +	unsigned int slots = channels;
> +	unsigned int lrck_period;
> +
> +	if (i2s->slots)
> +		slots = i2s->slots;
> +
> +	/* Map the channels for playback and capture */
> +	regmap_write(i2s->regmap, SUN50I_H6_I2S_TX_CHAN_MAP1_REG, 0x76543210);
> +	regmap_write(i2s->regmap, SUN50I_H6_I2S_RX_CHAN_MAP1_REG, 0x76543210);
> +
> +	/* Configure the channels */
> +	regmap_update_bits(i2s->regmap, SUN8I_I2S_TX_CHAN_SEL_REG,
> +			   SUN50I_H6_I2S_TX_CHAN_SEL_MASK,
> +			   SUN50I_H6_I2S_TX_CHAN_SEL(channels));
> +	regmap_update_bits(i2s->regmap, SUN50I_H6_I2S_RX_CHAN_SEL_REG,
> +			   SUN50I_H6_I2S_TX_CHAN_SEL_MASK,
> +			   SUN50I_H6_I2S_TX_CHAN_SEL(channels));
> +
> +	regmap_update_bits(i2s->regmap, SUN8I_I2S_CHAN_CFG_REG,
> +			   SUN8I_I2S_CHAN_CFG_TX_SLOT_NUM_MASK,
> +			   SUN8I_I2S_CHAN_CFG_TX_SLOT_NUM(channels));
> +	regmap_update_bits(i2s->regmap, SUN8I_I2S_CHAN_CFG_REG,
> +			   SUN8I_I2S_CHAN_CFG_RX_SLOT_NUM_MASK,
> +			   SUN8I_I2S_CHAN_CFG_RX_SLOT_NUM(channels));
> +
> +	switch (i2s->format & SND_SOC_DAIFMT_FORMAT_MASK) {
> +	case SND_SOC_DAIFMT_DSP_A:
> +	case SND_SOC_DAIFMT_DSP_B:
> +	case SND_SOC_DAIFMT_LEFT_J:
> +	case SND_SOC_DAIFMT_RIGHT_J:

These cases don't match the documentation: LEFT_J and RIGHT_J are documented to
behave like I2S (lrck_period == slot_width), not like DSP_A/B (lrck_period ==
slot_width * slots).

> +		lrck_period = params_physical_width(params) * slots;
> +		break;
> +
> +	case SND_SOC_DAIFMT_I2S:
> +		lrck_period = params_physical_width(params);
> +		break;
> +
> +	default:
> +		return -EINVAL;
> +	}
> +
> +	if (i2s->slot_width)
> +		lrck_period = i2s->slot_width;

Here, i2s->slot_width is the number of bits for each slot, but in PCM mode, you
need to multiply by the number of slots, like above.

Also, there is already logic in sun4i_i2s_hw_params to use i2s->slot_width and
i2s->slots. You could avoid the duplication by passing slot_width/slots as
parameters to set_chan_cfg.

Regards,
Samuel

> +
> +	regmap_update_bits(i2s->regmap, SUN4I_I2S_FMT0_REG,
> +			   SUN8I_I2S_FMT0_LRCK_PERIOD_MASK,
> +			   SUN8I_I2S_FMT0_LRCK_PERIOD(lrck_period));
> +
> +	regmap_update_bits(i2s->regmap, SUN8I_I2S_TX_CHAN_SEL_REG,
> +			   SUN50I_H6_I2S_TX_CHAN_EN_MASK,
> +			   SUN50I_H6_I2S_TX_CHAN_EN(channels));
> +
> +	return 0;
> +}
> +
>  static int sun4i_i2s_hw_params(struct snd_pcm_substream *substream,
>  			       struct snd_pcm_hw_params *params,
>  			       struct snd_soc_dai *dai)

[snip]
