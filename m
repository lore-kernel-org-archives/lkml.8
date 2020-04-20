Return-Path: <SRS0=QXtz=6E=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0E09FC3815B
	for <linux-kernel@archiver.kernel.org>; Mon, 20 Apr 2020 12:51:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id DE9BA20735
	for <linux-kernel@archiver.kernel.org>; Mon, 20 Apr 2020 12:51:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=cerno.tech header.i=@cerno.tech header.b="ZM90db3v";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="sDMoe/wD"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729550AbgDTMvC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 20 Apr 2020 08:51:02 -0400
Received: from wout2-smtp.messagingengine.com ([64.147.123.25]:50963 "EHLO
        wout2-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1729141AbgDTMu5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Apr 2020 08:50:57 -0400
Received: from compute4.internal (compute4.nyi.internal [10.202.2.44])
        by mailout.west.internal (Postfix) with ESMTP id 467AB457;
        Mon, 20 Apr 2020 08:50:56 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute4.internal (MEProxy); Mon, 20 Apr 2020 08:50:56 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cerno.tech; h=
        date:from:to:cc:subject:message-id:references:mime-version
        :content-type:in-reply-to; s=fm2; bh=tBOAlHqUjXoeb6fAkzGVdh0v8Dq
        4mrwbDL50ipwyYfc=; b=ZM90db3vCr9XtIH1GMdN+sK2FnPLtn3Qc0kasZSG/Px
        jF/8Y6lt9gWqPgFppBzrFwpst4InLd6Hu4NVgU7XfWgT1TfuwpQksCKHEU97NHvG
        tYzCi2Koj2eUbxYG5vpLjg5GhA7pODW4BHNK8oWSDX24sfREIzocc7E5rRv4iBWf
        cX/TcA85AMAzbf310UIJQJU5qRRcyw9AwJaTH5KOhLWVv4iX8OuYjALH+D1HlNG3
        BWgfpOhNcZ0RXbHWlna4eQkaPTIGph3GZzh1bMoGxSPxrTilg4rAW7Xeabf2UEAz
        bhqyJmM76arzp1EdmHdDwnVhEsmi1h/a/ZoKr5tx5QA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-type:date:from:in-reply-to
        :message-id:mime-version:references:subject:to:x-me-proxy
        :x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; bh=tBOAlH
        qUjXoeb6fAkzGVdh0v8Dq4mrwbDL50ipwyYfc=; b=sDMoe/wDwHoQpIqtDFp7/0
        skscWuXgRGF7dAvgXoGqIFmrG/PkxZphE+yJjpEtIgxo8D5SUghRxdbFR//JKJcg
        MaC7gui5PSB4eJmgQ8dQKHcjtnzFmPB+GWavgJihDFEo4qmHRjhjLem+ZxEHBORo
        QPKi/2WGiVC1KJPMjhrrHUby6H0+4K6tBklri98lREwT4eWoMbFZ/RyyP6akuZ8J
        5fDYp1ufjmxRnGr9KFRhw4wUVKkB+aZOKw4T7Bhu7z4YCgWE9kuX2jlrZpiAfRRH
        pNJR2LqpNmnZIza9WB+xs/qf9JTPowMHumvBJXld6dDKhGuNe0XXKgSeAVn2JHLA
        ==
X-ME-Sender: <xms:r5qdXgkF3FOSW1pgDJ4gDRl6TgmfqU9oLai7Fx6_f33TCDMN8ezZKg>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeduhedrgeefgdehjecutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenuc
    fjughrpeffhffvuffkfhggtggujgesghdtreertddtvdenucfhrhhomhepofgrgihimhgv
    ucftihhprghrugcuoehmrgigihhmvgestggvrhhnohdrthgvtghhqeenucfkphepledtrd
    ekledrieekrdejieenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhl
    fhhrohhmpehmrgigihhmvgestggvrhhnohdrthgvtghh
X-ME-Proxy: <xmx:r5qdXsfdwWyT63VBq93b3u3N9Et1z9QVzfjhVhZ2zMmV7feIpRtPXA>
    <xmx:r5qdXqYlO3Dpygwd_tFB87AxvzcmDnwuDVVR9FHU8JgsInGO8zftGw>
    <xmx:r5qdXgbiqBCAqRRYx-k2Ci4KlN7WcA1WUDZU8zkJw8EoNLIJAmtn2w>
    <xmx:r5qdXgkUAlMVbC8j0r1B2GZ-c7ZFW3ZqDuOP8cptLqGFouGa93XcBA>
Received: from localhost (lfbn-tou-1-1502-76.w90-89.abo.wanadoo.fr [90.89.68.76])
        by mail.messagingengine.com (Postfix) with ESMTPA id 3A3A73065C04;
        Mon, 20 Apr 2020 08:50:55 -0400 (EDT)
Date:   Mon, 20 Apr 2020 14:50:54 +0200
From:   Maxime Ripard <maxime@cerno.tech>
To:     Priit Laes <plaes@plaes.org>
Cc:     Chen-Yu Tsai <wens@csie.org>, Rob Herring <robh+dt@kernel.org>,
        linux-kernel@vger.kernel.org, linux-clk@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
        linux-sunxi@googlegroups.com
Subject: Re: [PATCH 2/4] clk: sunxi-ng: a20: export a regmap to access the
 GMAC register
Message-ID: <20200420125054.k3mnegy6mjgq2lcd@gilmour.lan>
References: <20200417221730.555954-1-plaes@plaes.org>
 <20200417221730.555954-3-plaes@plaes.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="ahl7sjwrudp4rb5o"
Content-Disposition: inline
In-Reply-To: <20200417221730.555954-3-plaes@plaes.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--ahl7sjwrudp4rb5o
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sat, Apr 18, 2020 at 01:17:28AM +0300, Priit Laes wrote:
> Only GMAC register is allowed to be written, read access to registers
> is not restricted.
>=20
> Export a regmap of the CCU.
>=20
> Signed-off-by: Priit Laes <plaes@plaes.org>
> ---
>  drivers/clk/sunxi-ng/ccu-sun4i-a10.c | 31 ++++++++++++++++++++++++++++
>  1 file changed, 31 insertions(+)
>=20
> diff --git a/drivers/clk/sunxi-ng/ccu-sun4i-a10.c b/drivers/clk/sunxi-ng/=
ccu-sun4i-a10.c
> index 839e9d5a1cff..cba51c2c7eba 100644
> --- a/drivers/clk/sunxi-ng/ccu-sun4i-a10.c
> +++ b/drivers/clk/sunxi-ng/ccu-sun4i-a10.c
> @@ -1426,6 +1426,30 @@ static const struct sunxi_ccu_desc sun7i_a20_ccu_d=
esc =3D {
>  	.num_resets	=3D ARRAY_SIZE(sunxi_a10_a20_ccu_resets),
>  };
> =20
> +/*
> + * Add regmap for the GMAC driver (dwmac-sun8i) to allow access to
> + * GMAC configuration register.
> + */
> +
> +#define SUN7I_A20_GMAC_CFG_REG 0x164
> +static bool sun7i_a20_ccu_regmap_accessible_reg(struct device *dev,
> +						unsigned int reg)
> +{
> +	if (reg =3D=3D SUN7I_A20_GMAC_CFG_REG)
> +		return true;
> +	return false;
> +}
> +
> +static struct regmap_config sun7i_a20_ccu_regmap_config =3D {
> +	.reg_bits	=3D 32,
> +	.val_bits	=3D 32,
> +	.reg_stride	=3D 4,
> +	.max_register	=3D 0x1f4, /* clk_out_b */

As far as I know, clk_out_b is a register that is also modified through that
clock driver. How do you handle the concurrent accesses?

Maxime

--ahl7sjwrudp4rb5o
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRcEzekXsqa64kGDp7j7w1vZxhRxQUCXp2argAKCRDj7w1vZxhR
xeXVAQDmNQz5L1EFRPYLu4y1O4Nl7C6aA+PFGDx33HStDUQvbAD/SCdOUUmrs/D3
9HUgc0icssQhh/jpfcpB8M/MW4Fefg0=
=eu9x
-----END PGP SIGNATURE-----

--ahl7sjwrudp4rb5o--
