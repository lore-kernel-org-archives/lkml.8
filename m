Return-Path: <SRS0=eGSO=AR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 09D91C433DF
	for <linux-kernel@archiver.kernel.org>; Mon,  6 Jul 2020 05:15:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id DE9FE2070B
	for <linux-kernel@archiver.kernel.org>; Mon,  6 Jul 2020 05:15:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=cerno.tech header.i=@cerno.tech header.b="fUP73GgK";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="jxl0tQ6a"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728762AbgGFFPk (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 6 Jul 2020 01:15:40 -0400
Received: from new1-smtp.messagingengine.com ([66.111.4.221]:51321 "EHLO
        new1-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726020AbgGFFPk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Jul 2020 01:15:40 -0400
Received: from compute4.internal (compute4.nyi.internal [10.202.2.44])
        by mailnew.nyi.internal (Postfix) with ESMTP id 1552E5804F4;
        Mon,  6 Jul 2020 01:15:39 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute4.internal (MEProxy); Mon, 06 Jul 2020 01:15:39 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cerno.tech; h=
        date:from:to:cc:subject:message-id:references:mime-version
        :content-type:in-reply-to; s=fm3; bh=b5/fr/3pZ2lvhcvw66DkfYYaQeM
        z9RO3BLgfQtk5ldY=; b=fUP73GgKQmPif25nwLKLJn7DbQ/yGhZmMobQ0l4+xde
        vSdwfdxaO3dJSg7YnaoNgf2uXib7AFdUjt5cvf0lt2q7lifC72qTohIwaatsPPLv
        o1o3MqzH8RWw4sJlN8XdY8GgU/CbYFRlBt4iJ92n5gW8YeJ++1zzqfJ0aPfJnP3Z
        UZ3aZQ2bNf8ta13KOfS398RQzEmvo7igJSHpdimnASrusYlwXfSRWnrnLMTgxvDY
        pLNRV11uMYPiDx9sXQr/Rp9NxTkqkWpmhD1Hfe1B05hxMu9F9qRrrjDk96AvfycZ
        pNK4AiwYOJKVAD8py0d6f39iwdaZ6qaJ/zPw6eIFsQw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-type:date:from:in-reply-to
        :message-id:mime-version:references:subject:to:x-me-proxy
        :x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; bh=b5/fr/
        3pZ2lvhcvw66DkfYYaQeMz9RO3BLgfQtk5ldY=; b=jxl0tQ6abU73Y1kgsMMnD3
        kU4djisQ5UKvt71Rzy0Tze47aFuQSCpgOUccSVQOL4e2I1hzLJkeBOXrJNtLCSB7
        1Lgj1wrMi7IpcFS4Zs6K3VN3ee/V3cN+AGrEIjCjcpjqKDJqmfleLM6F0GR5kBqk
        kbGoUUyPIWfeHrz6IXtrq4K+BlKbSWoxRq4NzIr3VikAufMk2wkJ1A4OiHIEiWty
        UUAvJ9gU5YiJhBLcKME1J7lt5pO9fn64JBEtsrQgk8k3y4YKiyCZPfP4+HZQUYVf
        t8n07X2mdex9NA93MB0Ek4CL41HqzDv815KkG1OwzmSg1kQKFfy6uLYflLtu2oMA
        ==
X-ME-Sender: <xms:ebMCX7NuF30_7l9cCHDm2A02Zy7881nM90wq2KRb4N8nAYwgO-RpNQ>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeduiedruddvgdeludcutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenuc
    fjughrpeffhffvuffkfhggtggujgesghdtreertddtudenucfhrhhomhepofgrgihimhgv
    ucftihhprghrugcuoehmrgigihhmvgestggvrhhnohdrthgvtghhqeenucggtffrrghtth
    gvrhhnpeduvdduhfekkeehgffftefflefgffdtheffudffgeevteffheeuiedvvdejvdfg
    veenucfkphepledtrdekledrieekrdejieenucevlhhushhtvghrufhiiigvpedtnecurf
    grrhgrmhepmhgrihhlfhhrohhmpehmrgigihhmvgestggvrhhnohdrthgvtghh
X-ME-Proxy: <xmx:ebMCX18Qad9zkuTzMPeq5buYIIF1SZzJSWTiJYg1UO1PSZfL46VqIg>
    <xmx:ebMCX6SqZfVMtFjqleVO5xe8o7e9k0meWu7aWYhYr83P_ODbUVDS5g>
    <xmx:ebMCX_trrJ8ajYhr5clpmE_yK02QVfVunS4AwDZSVGvzFNV9mCE7og>
    <xmx:e7MCX0VOOJC-6PJzjKENxUhT1T-uPIBRDqU7U4vYtkCC2cEMdZKcXw>
Received: from localhost (lfbn-tou-1-1502-76.w90-89.abo.wanadoo.fr [90.89.68.76])
        by mail.messagingengine.com (Postfix) with ESMTPA id A184230653F0;
        Mon,  6 Jul 2020 01:15:37 -0400 (EDT)
Date:   Mon, 6 Jul 2020 07:15:35 +0200
From:   Maxime Ripard <maxime@cerno.tech>
To:     =?utf-8?B?Q2zDqW1lbnQgUMOpcm9u?= <peron.clem@gmail.com>
Cc:     Chen-Yu Tsai <wens@csie.org>, Rob Herring <robh+dt@kernel.org>,
        Mark Brown <broonie@kernel.org>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Jaroslav Kysela <perex@perex.cz>,
        Takashi Iwai <tiwai@suse.com>,
        Marcus Cooper <codekipper@gmail.com>,
        Jernej Skrabec <jernej.skrabec@siol.net>,
        alsa-devel@alsa-project.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-sunxi@googlegroups.com
Subject: Re: [PATCH 01/16] ASoC: sun4i-i2s: Add support for H6 I2S
Message-ID: <20200706051535.bdg7pxnsdo6mzmqq@gilmour.lan>
References: <20200704113902.336911-1-peron.clem@gmail.com>
 <20200704113902.336911-2-peron.clem@gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="t3nnxkhnwrf5ighs"
Content-Disposition: inline
In-Reply-To: <20200704113902.336911-2-peron.clem@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--t3nnxkhnwrf5ighs
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,

On Sat, Jul 04, 2020 at 01:38:47PM +0200, Cl=E9ment P=E9ron wrote:
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
> index d0a8d5810c0a..9690389cb68e 100644
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
> @@ -466,6 +481,65 @@ static int sun8i_i2s_set_chan_cfg(const struct sun4i=
_i2s *i2s,
>  	return 0;
>  }
> =20
> +static int sun50i_i2s_set_chan_cfg(const struct sun4i_i2s *i2s,
> +				   const struct snd_pcm_hw_params *params)

We should have sun50i_h6 as prefix. The A64 is also part of the sun50i
family and supported through the sun8i callbacks, so it's pretty
confusing if you don't have the soc name in there.

Maxime

--t3nnxkhnwrf5ighs
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRcEzekXsqa64kGDp7j7w1vZxhRxQUCXwKzdwAKCRDj7w1vZxhR
xfxGAQCshGGwznq/CeE0k77Y+AnV9plA1fYToH5o5w6MMZvDEQD/alZa28wl4rhA
GY2AfRBbwU3iFQayelpzXAsJMzLoPAo=
=29OL
-----END PGP SIGNATURE-----

--t3nnxkhnwrf5ighs--
