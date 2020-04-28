Return-Path: <SRS0=r24B=6M=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 512A7C83007
	for <linux-kernel@archiver.kernel.org>; Tue, 28 Apr 2020 08:13:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 304C82073E
	for <linux-kernel@archiver.kernel.org>; Tue, 28 Apr 2020 08:13:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=cerno.tech header.i=@cerno.tech header.b="Ow9QCQxH";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="QILMzCzy"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726742AbgD1IN0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 28 Apr 2020 04:13:26 -0400
Received: from new1-smtp.messagingengine.com ([66.111.4.221]:47573 "EHLO
        new1-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726562AbgD1INZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Apr 2020 04:13:25 -0400
Received: from compute4.internal (compute4.nyi.internal [10.202.2.44])
        by mailnew.nyi.internal (Postfix) with ESMTP id A17D25800D6;
        Tue, 28 Apr 2020 04:13:24 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute4.internal (MEProxy); Tue, 28 Apr 2020 04:13:24 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cerno.tech; h=
        date:from:to:cc:subject:message-id:references:mime-version
        :content-type:in-reply-to; s=fm2; bh=aNL6gNiksq4r4UbKFxC+u35ZMwz
        PjR4FLCxhPYO1ZHQ=; b=Ow9QCQxHMFqXBKP/9h6hzsznq8rDy5fQ9VO1YndVbr2
        a2Wm5YZ1aD4n8/JWVtd6i9LOavWI2m0lzfAPVQehZBo9TdQ1JbyWPb/wke5DIWCw
        k4RngA6/Wet2p7sMEfz5Ubwh96s4UuTXcolqQsqCUeSr/d1lWzYBd8FQtyxZwrbN
        CP8SOiJjdkP0xUs7zWO4iDG0X7bqRFJQR3ujI6P3298oywHmT5XLg6x3iYXMWezf
        5HAG/8drt6KTqjuqofDo0BZAaGf5whP2XHKJ2o+BYz6eZETWsuJz7BFOfy07Ey/C
        P2JjxdBHPrtglVT2hDcV1aWNjtXtP8754ANHLDV6kSw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-type:date:from:in-reply-to
        :message-id:mime-version:references:subject:to:x-me-proxy
        :x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; bh=aNL6gN
        iksq4r4UbKFxC+u35ZMwzPjR4FLCxhPYO1ZHQ=; b=QILMzCzyEaCrJJhYtR1Zps
        H/3ckqluppkUdd/xt9zDocbPx7ZFeUa0AWxWGSet25a3HWuuHvFnVjVTeNfMx4FS
        XcFP/6b1JeBk2AYVPiMiDHMCxcM/z/3pbWZ6pLFpCnUXzeyQ2KqDj1S2pS8KdN1r
        mfLa7g+CXY9pA5mIbbo/+TzpAOi3aoDbM8d42qX3tJl3YjNTKKIHQ9fLByPf7llQ
        M0tO59Qc6fzFSbgIoYvGheDzZp+f469p+7/bvSnOZcst1Qy2n7v8h4KVQQh2QTe4
        W+PSYNiAcOPF/C/FupRh/RtCp5ex4o5NaS8SO0eHPH2k26IlkfXQwbY0bVxdjLog
        ==
X-ME-Sender: <xms:o-WnXloq0ZC0sxFTMmAjuGzZHSppskXtXJGzTpYnNhIA_LxoTSKTig>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeduhedriedugddtudcutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenuc
    fjughrpeffhffvuffkfhggtggujgesghdtreertddtudenucfhrhhomhepofgrgihimhgv
    ucftihhprghrugcuoehmrgigihhmvgestggvrhhnohdrthgvtghhqeenucfkphepledtrd
    ekledrieekrdejieenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhl
    fhhrohhmpehmrgigihhmvgestggvrhhnohdrthgvtghh
X-ME-Proxy: <xmx:o-WnXj_Rvm0CbMeCkMsaC4ldOE2sJQTnHXqhLW6uEL94k6TMeHE68w>
    <xmx:o-WnXk-7UMGZwzPs2zSwi-YSGziaoWNibn7ZWWHYEx2M1zPq7Oew7A>
    <xmx:o-WnXitaEN9iqXogA8et9-gamTdv22Fg51U40qpYXV3sGXMFiZnreg>
    <xmx:pOWnXlxbTY2BlSQh_Rqc6-znSdCS9T2adHEgLupYOgqxTXUcxi0jWw>
Received: from localhost (lfbn-tou-1-1502-76.w90-89.abo.wanadoo.fr [90.89.68.76])
        by mail.messagingengine.com (Postfix) with ESMTPA id C214D3280068;
        Tue, 28 Apr 2020 04:13:22 -0400 (EDT)
Date:   Tue, 28 Apr 2020 10:13:21 +0200
From:   Maxime Ripard <maxime@cerno.tech>
To:     =?utf-8?B?Q2zDqW1lbnQgUMOpcm9u?= <peron.clem@gmail.com>
Cc:     Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        Rob Herring <robh+dt@kernel.org>, Chen-Yu Tsai <wens@csie.org>,
        Jaroslav Kysela <perex@perex.cz>,
        Takashi Iwai <tiwai@suse.com>, alsa-devel@alsa-project.org,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org,
        Jernej Skrabec <jernej.skrabec@siol.net>,
        Marcus Cooper <codekipper@gmail.com>
Subject: Re: [PATCH v3 3/7] ASoC: sun4i-i2s: Add support for H6 I2S
Message-ID: <20200428081321.ht3el26yqhsnyfm4@gilmour.lan>
References: <20200426104115.22630-1-peron.clem@gmail.com>
 <20200426104115.22630-4-peron.clem@gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="7bvfzopuk76upvmv"
Content-Disposition: inline
In-Reply-To: <20200426104115.22630-4-peron.clem@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--7bvfzopuk76upvmv
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,

On Sun, Apr 26, 2020 at 12:41:11PM +0200, Cl=E9ment P=E9ron wrote:
> From: Jernej Skrabec <jernej.skrabec@siol.net>
>=20
> H6 I2S is very similar to that in H3, except it supports up to 16
> channels.
>=20
> Signed-off-by: Jernej Skrabec <jernej.skrabec@siol.net>
> Signed-off-by: Marcus Cooper <codekipper@gmail.com>
> Signed-off-by: Cl=E9ment P=E9ron <peron.clem@gmail.com>
> ---
>  sound/soc/sunxi/sun4i-i2s.c | 227 ++++++++++++++++++++++++++++++++++++
>  1 file changed, 227 insertions(+)
>=20
> diff --git a/sound/soc/sunxi/sun4i-i2s.c b/sound/soc/sunxi/sun4i-i2s.c
> index 4198a5410bf9..a23c9f2a3f8c 100644
> --- a/sound/soc/sunxi/sun4i-i2s.c
> +++ b/sound/soc/sunxi/sun4i-i2s.c
> @@ -124,6 +124,21 @@
>  #define SUN8I_I2S_RX_CHAN_SEL_REG	0x54
>  #define SUN8I_I2S_RX_CHAN_MAP_REG	0x58
> =20
> +/* Defines required for sun50i-h6 support */
> +#define SUN50I_H6_I2S_TX_CHAN_SEL_OFFSET_MASK	GENMASK(21, 20)
> +#define SUN50I_H6_I2S_TX_CHAN_SEL_OFFSET(offset)	((offset) << 20)
> +#define SUN50I_H6_I2S_TX_CHAN_SEL_MASK		GENMASK(19, 16)
> +#define SUN50I_H6_I2S_TX_CHAN_SEL(chan)		((chan - 1) << 16)
> +#define SUN50I_H6_I2S_TX_CHAN_EN_MASK		GENMASK(15, 0)
> +#define SUN50I_H6_I2S_TX_CHAN_EN(num_chan)	(((1 << num_chan) - 1))
> +
> +#define SUN50I_H6_I2S_TX_CHAN_MAP0_REG	0x44
> +#define SUN50I_H6_I2S_TX_CHAN_MAP1_REG	0x48
> +
> +#define SUN50I_H6_I2S_RX_CHAN_SEL_REG	0x64
> +#define SUN50I_H6_I2S_RX_CHAN_MAP0_REG	0x68
> +#define SUN50I_H6_I2S_RX_CHAN_MAP1_REG	0x6C
> +
>  struct sun4i_i2s;
> =20
>  /**
> @@ -469,6 +484,65 @@ static int sun8i_i2s_set_chan_cfg(const struct sun4i=
_i2s *i2s,
>  	return 0;
>  }
> =20
> +static int sun50i_i2s_set_chan_cfg(const struct sun4i_i2s *i2s,
> +				   const struct snd_pcm_hw_params *params)
> +{
> +	unsigned int channels =3D params_channels(params);
> +	unsigned int slots =3D channels;
> +	unsigned int lrck_period;
> +
> +	if (i2s->slots)
> +		slots =3D i2s->slots;
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
> +		lrck_period =3D params_physical_width(params) * slots;
> +		break;
> +
> +	case SND_SOC_DAIFMT_I2S:
> +		lrck_period =3D params_physical_width(params);
> +		break;
> +
> +	default:
> +		return -EINVAL;
> +	}
> +
> +	if (i2s->slot_width)
> +		lrck_period =3D i2s->slot_width;
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
> @@ -694,6 +768,108 @@ static int sun8i_i2s_set_soc_fmt(const struct sun4i=
_i2s *i2s,
>  	return 0;
>  }
> =20
> +static int sun50i_i2s_set_soc_fmt(const struct sun4i_i2s *i2s,
> +				 unsigned int fmt)

The alignment is off here

> +{
> +	u32 mode, val;
> +	u8 offset;
> +
> +	/*
> +	 * DAI clock polarity
> +	 *
> +	 * The setup for LRCK contradicts the datasheet, but under a
> +	 * scope it's clear that the LRCK polarity is reversed
> +	 * compared to the expected polarity on the bus.
> +	 */

Did you check this or has it been copy-pasted?

Thanks!
Maxime

--7bvfzopuk76upvmv
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRcEzekXsqa64kGDp7j7w1vZxhRxQUCXqfloQAKCRDj7w1vZxhR
xbV7AQCtzcyuXWod6ueBp9bCOgBmzvi9IbRXyMUpg8mupkFJzQD/YCKUuoTYmeh+
WHfw3z1Sgn4sv5c7EKyNffkPSqGpeQA=
=uH8m
-----END PGP SIGNATURE-----

--7bvfzopuk76upvmv--
