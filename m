Return-Path: <SRS0=QXtz=6E=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9D21FC3815B
	for <linux-kernel@archiver.kernel.org>; Mon, 20 Apr 2020 12:59:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7C0E620738
	for <linux-kernel@archiver.kernel.org>; Mon, 20 Apr 2020 12:59:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=cerno.tech header.i=@cerno.tech header.b="t/XOmMYQ";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="OdaLG8aC"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728286AbgDTM70 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 20 Apr 2020 08:59:26 -0400
Received: from wout2-smtp.messagingengine.com ([64.147.123.25]:54075 "EHLO
        wout2-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1728078AbgDTM7X (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Apr 2020 08:59:23 -0400
Received: from compute4.internal (compute4.nyi.internal [10.202.2.44])
        by mailout.west.internal (Postfix) with ESMTP id 0B0C52F2;
        Mon, 20 Apr 2020 08:59:21 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute4.internal (MEProxy); Mon, 20 Apr 2020 08:59:22 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cerno.tech; h=
        date:from:to:cc:subject:message-id:references:mime-version
        :content-type:in-reply-to; s=fm2; bh=Z4Tx++3ZiTnOn+3/RNXgeV13mzY
        czYnd6hnaCAv6DxU=; b=t/XOmMYQJv7YFcnsTVIYHEhbPvHuvMrvIfpfUglv4yC
        pWRgDVBdxfzJQvjsLV3/ksnCZuLGab+iKs3XRDR5Wf1hrdrZ88Dfqh0SkXBFyZ7b
        WNVVbJyvnA7CQQSjuif+8TL1QyCy1B0RSEFakcGubek2nG4RhqfNd3BbBURm2ghI
        3P7jcJZhpc9zMe3fLpD4Up6dqujQuCXg1Kru3v+GonZ+rrj4PIMTVLXJ7DLUqAEh
        85boYT4Jx2Ohe/zEr6luqckz5gDU9cy2ZrAnExq5bl3Wd4j6tES3mvR17EHPCM6T
        svYYepcg4yI2CEbyhv92+LhlwtPUke+gJT52TRzEo/Q==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-type:date:from:in-reply-to
        :message-id:mime-version:references:subject:to:x-me-proxy
        :x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; bh=Z4Tx++
        3ZiTnOn+3/RNXgeV13mzYczYnd6hnaCAv6DxU=; b=OdaLG8aCJmXh7rG4CSRUqF
        4FiigsUn6otSH2vWMkFc3CpVemP3dEXEWL0I1QywaZdTOpNnFnYqDeBqN11fJG1o
        smoQJpBGP0A8GzHLwhRNJ7XNNdycXXHoyTPwNOh3FuHK+u9UlhKcI8fi9T7SM7zV
        Se39pa61EkaACX5uO1ggA0+WIwOybGH9kH9BWZtpBh9XSrUaWZvNbp7ViE9nCRNo
        wsneUcvbVXTq2Nzb5QByxvmUbI6tRLKVy5IpluocEtPbVOPPUWdImDhhzPoxPYk5
        H5rNF/zJ3x6uw3+L4hNBeG35HXYmQWi+RkgY0sknv+G2Khr1KwdpK2hyDrJnxwlw
        ==
X-ME-Sender: <xms:qZydXkWOP9VFnj_bMXgrmtEhJk5Yxl6WycU11XNhdDyXkH1vEgdnNA>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeduhedrgeefgdehkecutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenuc
    fjughrpeffhffvuffkfhggtggujgesghdtreertddtvdenucfhrhhomhepofgrgihimhgv
    ucftihhprghrugcuoehmrgigihhmvgestggvrhhnohdrthgvtghhqeenucfkphepledtrd
    ekledrieekrdejieenucevlhhushhtvghrufhiiigvpedunecurfgrrhgrmhepmhgrihhl
    fhhrohhmpehmrgigihhmvgestggvrhhnohdrthgvtghh
X-ME-Proxy: <xmx:qZydXs2GooQrliKtdJGCuEaQlJe6YIXOVxqh8NP2GgxkxH-C9wPiKw>
    <xmx:qZydXjaA9koIQRTh0YItL0TdRxY7pbBKFhtm_hxVx_qmi89LcDfw7w>
    <xmx:qZydXnok7HbV5kG-bom49qpFyTDPsN0jpV5A-t-B-YJGBsNgq_Lvxw>
    <xmx:qZydXhnAID3tdIYtMuaKHVCA1Y7TScwjZCevTJjvL_5OEtOnmGkwaQ>
Received: from localhost (lfbn-tou-1-1502-76.w90-89.abo.wanadoo.fr [90.89.68.76])
        by mail.messagingengine.com (Postfix) with ESMTPA id CB79C3065C16;
        Mon, 20 Apr 2020 08:59:20 -0400 (EDT)
Date:   Mon, 20 Apr 2020 14:59:19 +0200
From:   Maxime Ripard <maxime@cerno.tech>
To:     Priit Laes <plaes@plaes.org>
Cc:     Chen-Yu Tsai <wens@csie.org>, Rob Herring <robh+dt@kernel.org>,
        linux-kernel@vger.kernel.org, linux-clk@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
        linux-sunxi@googlegroups.com
Subject: Re: [PATCH 4/4] ARM: dts: sun7i: Use syscon-based implementation for
 gmac
Message-ID: <20200420125919.3bqosps7nzwvmasn@gilmour.lan>
References: <20200417221730.555954-1-plaes@plaes.org>
 <20200417221730.555954-5-plaes@plaes.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="lxwfdky4v247xqnt"
Content-Disposition: inline
In-Reply-To: <20200417221730.555954-5-plaes@plaes.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--lxwfdky4v247xqnt
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sat, Apr 18, 2020 at 01:17:30AM +0300, Priit Laes wrote:
> Use syscon-based approach to access gmac clock configuration
> register, instead of relying on a custom clock driver.
>=20
> As a bonus, we can now drop the custom clock implementation
> and dummy clocks making sun7i fully CCU-compatible.
>=20
> Signed-off-by: Priit Laes <plaes@plaes.org>
> ---
>  arch/arm/boot/dts/sun7i-a20.dtsi | 36 +++-----------------------------
>  1 file changed, 3 insertions(+), 33 deletions(-)
>=20
> diff --git a/arch/arm/boot/dts/sun7i-a20.dtsi b/arch/arm/boot/dts/sun7i-a=
20.dtsi
> index ffe1d10a1a84..750962a94fad 100644
> --- a/arch/arm/boot/dts/sun7i-a20.dtsi
> +++ b/arch/arm/boot/dts/sun7i-a20.dtsi
> @@ -219,37 +219,6 @@ osc32k: clk-32k {
>  			clock-frequency =3D <32768>;
>  			clock-output-names =3D "osc32k";
>  		};
> -
> -		/*
> -		 * The following two are dummy clocks, placeholders
> -		 * used in the gmac_tx clock. The gmac driver will
> -		 * choose one parent depending on the PHY interface
> -		 * mode, using clk_set_rate auto-reparenting.
> -		 *
> -		 * The actual TX clock rate is not controlled by the
> -		 * gmac_tx clock.
> -		 */
> -		mii_phy_tx_clk: clk-mii-phy-tx {
> -			#clock-cells =3D <0>;
> -			compatible =3D "fixed-clock";
> -			clock-frequency =3D <25000000>;
> -			clock-output-names =3D "mii_phy_tx";
> -		};
> -
> -		gmac_int_tx_clk: clk-gmac-int-tx {
> -			#clock-cells =3D <0>;
> -			compatible =3D "fixed-clock";
> -			clock-frequency =3D <125000000>;
> -			clock-output-names =3D "gmac_int_tx";
> -		};
> -
> -		gmac_tx_clk: clk@1c20164 {
> -			#clock-cells =3D <0>;
> -			compatible =3D "allwinner,sun7i-a20-gmac-clk";
> -			reg =3D <0x01c20164 0x4>;
> -			clocks =3D <&mii_phy_tx_clk>, <&gmac_int_tx_clk>;
> -			clock-output-names =3D "gmac_tx";
> -		};
>  	};
> =20
> =20
> @@ -1511,11 +1480,12 @@ mali: gpu@1c40000 {
> =20
>  		gmac: ethernet@1c50000 {
>  			compatible =3D "allwinner,sun7i-a20-gmac";
> +			syscon =3D <&ccu>;
>  			reg =3D <0x01c50000 0x10000>;
>  			interrupts =3D <GIC_SPI 85 IRQ_TYPE_LEVEL_HIGH>;
>  			interrupt-names =3D "macirq";
> -			clocks =3D <&ccu CLK_AHB_GMAC>, <&gmac_tx_clk>;
> -			clock-names =3D "stmmaceth", "allwinner_gmac_tx";
> +			clocks =3D <&ccu CLK_AHB_GMAC>;
> +			clock-names =3D "stmmaceth";

I guess you also need to update the binding so that it considers it valid?

Maxime

--lxwfdky4v247xqnt
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRcEzekXsqa64kGDp7j7w1vZxhRxQUCXp2cpwAKCRDj7w1vZxhR
xV8eAPwMjpw8ngiA7+PMTh3y1+0bYmvhl8gwYCzmS3VzAT3r4QEAhXCLgzR7Iy1z
EImQYxxDHoP0F/irj6QPAyoSRxOrswc=
=URSt
-----END PGP SIGNATURE-----

--lxwfdky4v247xqnt--
