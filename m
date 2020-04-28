Return-Path: <SRS0=r24B=6M=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 360DDC83000
	for <linux-kernel@archiver.kernel.org>; Tue, 28 Apr 2020 08:02:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 13D32206D7
	for <linux-kernel@archiver.kernel.org>; Tue, 28 Apr 2020 08:02:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=cerno.tech header.i=@cerno.tech header.b="rPrCkZZl";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="fMrR8klV"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726770AbgD1ICR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 28 Apr 2020 04:02:17 -0400
Received: from new1-smtp.messagingengine.com ([66.111.4.221]:33353 "EHLO
        new1-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726616AbgD1ICM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Apr 2020 04:02:12 -0400
Received: from compute4.internal (compute4.nyi.internal [10.202.2.44])
        by mailnew.nyi.internal (Postfix) with ESMTP id 65BEE58031B;
        Tue, 28 Apr 2020 04:02:11 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute4.internal (MEProxy); Tue, 28 Apr 2020 04:02:11 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cerno.tech; h=
        date:from:to:cc:subject:message-id:references:mime-version
        :content-type:in-reply-to; s=fm2; bh=rgw/xMhvmtBFVnJEJieJuuX6oqE
        JNwtIrwF23ef3G7c=; b=rPrCkZZlKnK/4lvcnBnc5GbS1IXoysk2ALvP6IoJ3pO
        X7TY4hEjjaw/Vu5Sfj2cld0y7gpcMITeylr7N29uEzIwTmQPa4pM4YH1YuIWZIrF
        FFvs5xeWzyMORxjjWL4gyYDs8oPq0hp71SssLZWhy4lngd/CtD6kiOVvOUElc68i
        +OdhjqRZfLhye13LPThW6kxc4/QzkCzeFh9QadqrxH42EFMu1WWS0mHj7PnTv1lP
        gmqYLYPw3Rb5Yafh4JbyiqkDX7VM0BmdwGW9cjPuuoBwlQx8TAij7sxIdPtuQ1hW
        8ylbIJbYT/3TmpLGD2/FwCGTAKnLy1B4/qz1sBCZnFw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-type:date:from:in-reply-to
        :message-id:mime-version:references:subject:to:x-me-proxy
        :x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; bh=rgw/xM
        hvmtBFVnJEJieJuuX6oqEJNwtIrwF23ef3G7c=; b=fMrR8klVr6SLP+PoH7M9vZ
        WiZ4vuAsb3YryyOMTs1cKZc2SNQXMGkSux3MsnM5yezkRj7+LptPjiSgTMxU8f0i
        +2IEiHr7I4FTdSwLvxFwX4d8NNnjZIca3/AOdkzwTBXX9eJLuoVACh49Z8UtLZ3n
        lchiJYs5v9erT0rPHWdJGvLFk/RfZdANEv1iGLdQYI8ztm3Z6PmTTOZxo5gnECqa
        I+2+tPpROkkjBfsOP+3+Pxaos7CR8wZXuE6CAuj4pgRYdblGScxo//mgeGVKiWTl
        0sCk9RU3DmqYlZrQKNTEqXFculOs3nuZ4zYCzdwGHDpXGoXsyU5rK/RqBpZh0kjA
        ==
X-ME-Sender: <xms:AuOnXgcGCuDMch6YM8lSZxKuJBJqQNakEroCMWRotKCW98kqNsyVtQ>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeduhedriedtgdduvdefucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepfffhvffukfhfgggtuggjsehgtderredttddunecuhfhrohhmpeforgigihhm
    vgcutfhiphgrrhguuceomhgrgihimhgvsegtvghrnhhordhtvggthheqnecukfhppeeltd
    drkeelrdeikedrjeeinecuvehluhhsthgvrhfuihiivgepudenucfrrghrrghmpehmrghi
    lhhfrhhomhepmhgrgihimhgvsegtvghrnhhordhtvggthh
X-ME-Proxy: <xmx:AuOnXrkmideO35ESHUCljugD81INszOX0Np_il6r7qfw5634zI8dNw>
    <xmx:AuOnXqDwuu7c1NbDMhZ7kKkcRx8F3EKSg6xszfDHI-xVVak5KvxjQA>
    <xmx:AuOnXleygGlaT7k0NHSa9CaIelT_5SB_A3dBY6_IyKIStZcTSd1ZEg>
    <xmx:A-OnXj7zoCfq_gjZ4KwWaLsGpWqEar0zZ23KM9qOd5WqVbFkBj5mKA>
Received: from localhost (lfbn-tou-1-1502-76.w90-89.abo.wanadoo.fr [90.89.68.76])
        by mail.messagingengine.com (Postfix) with ESMTPA id 5B0083280063;
        Tue, 28 Apr 2020 04:02:10 -0400 (EDT)
Date:   Tue, 28 Apr 2020 10:02:09 +0200
From:   Maxime Ripard <maxime@cerno.tech>
To:     =?utf-8?B?Q2zDqW1lbnQgUMOpcm9u?= <peron.clem@gmail.com>
Cc:     Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        Rob Herring <robh+dt@kernel.org>, Chen-Yu Tsai <wens@csie.org>,
        Jaroslav Kysela <perex@perex.cz>,
        Takashi Iwai <tiwai@suse.com>, alsa-devel@alsa-project.org,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, Marcus Cooper <codekipper@gmail.com>
Subject: Re: [PATCH v3 1/7] ASoC: sun4i-i2s: Adjust LRCLK width
Message-ID: <20200428080209.2n7eeaksfze7jicn@gilmour.lan>
References: <20200426104115.22630-1-peron.clem@gmail.com>
 <20200426104115.22630-2-peron.clem@gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="qwt7wotkij5dx55c"
Content-Disposition: inline
In-Reply-To: <20200426104115.22630-2-peron.clem@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--qwt7wotkij5dx55c
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sun, Apr 26, 2020 at 12:41:09PM +0200, Cl=E9ment P=E9ron wrote:
> From: Marcus Cooper <codekipper@gmail.com>
>=20
> Some codecs such as i2s based HDMI audio and the Pine64 DAC require
> a different amount of bit clocks per frame than what is calculated
> by the sample width. Use the values obtained by the tdm slot bindings
> to adjust the LRCLK width accordingly.
>=20
> Signed-off-by: Marcus Cooper <codekipper@gmail.com>
> Signed-off-by: Cl=E9ment P=E9ron <peron.clem@gmail.com>
> ---
>  sound/soc/sunxi/sun4i-i2s.c | 3 +++
>  1 file changed, 3 insertions(+)
>=20
> diff --git a/sound/soc/sunxi/sun4i-i2s.c b/sound/soc/sunxi/sun4i-i2s.c
> index d0a8d5810c0a..4198a5410bf9 100644
> --- a/sound/soc/sunxi/sun4i-i2s.c
> +++ b/sound/soc/sunxi/sun4i-i2s.c
> @@ -455,6 +455,9 @@ static int sun8i_i2s_set_chan_cfg(const struct sun4i_=
i2s *i2s,
>  		return -EINVAL;
>  	}
> =20
> +	if (i2s->slot_width)
> +		lrck_period =3D i2s->slot_width;
> +

Acked-by: Maxime Ripard <maxime@cerno.tech>

Thanks!
Maxime

--qwt7wotkij5dx55c
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRcEzekXsqa64kGDp7j7w1vZxhRxQUCXqfjAQAKCRDj7w1vZxhR
xW9rAP9E5eTw2YKxU5C8kBBozs78d4lLnoBuIYyVxy8RIdQnUgD/ZqU2MRZZPXQ/
K2A3JMxDdOeMf5EQwLUdDtKXLCralQ4=
=F0Hq
-----END PGP SIGNATURE-----

--qwt7wotkij5dx55c--
