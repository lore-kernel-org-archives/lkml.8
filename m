Return-Path: <SRS0=PJcK=74=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3967FC433E1
	for <linux-kernel@archiver.kernel.org>; Mon, 15 Jun 2020 08:12:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0C910204EC
	for <linux-kernel@archiver.kernel.org>; Mon, 15 Jun 2020 08:12:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=cerno.tech header.i=@cerno.tech header.b="c6TQB5IO";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="nzprzlOT"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728878AbgFOIMz (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 15 Jun 2020 04:12:55 -0400
Received: from out2-smtp.messagingengine.com ([66.111.4.26]:45887 "EHLO
        out2-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1728411AbgFOIMx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 Jun 2020 04:12:53 -0400
Received: from compute4.internal (compute4.nyi.internal [10.202.2.44])
        by mailout.nyi.internal (Postfix) with ESMTP id CB05F5C00A7;
        Mon, 15 Jun 2020 04:12:51 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute4.internal (MEProxy); Mon, 15 Jun 2020 04:12:51 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cerno.tech; h=
        date:from:to:cc:subject:message-id:references:mime-version
        :content-type:in-reply-to; s=fm3; bh=sAfu4p+QiVeNnuEcI3dCQR633pL
        v27vuwHggq/8UNPk=; b=c6TQB5IO+se7UhdTaUAAm4AbOCSU6oH94xlzR17ZRJb
        xRk/LYcxyMqmX31VFketon1w65JvTnh1QmJgvNYGgc3JZf/civgef/BhH6F6ssgC
        yyYEwB2zOgcJWLdOOcBCjd9TgjtoCzuKMe6ulDs6VaKR7h14G54ZYfPp9nHxZDxt
        Xlu2xiIq3P7DTkUnoksJMoVP6g/xspJz/9z1oR1KBoGC6Arg3fENLqOlP5lzt8c+
        ssCii8sXngs57wOfyieDj6h8jpKEWeSEO7mmcg1IZd4Wivscwv8OjrlCwzmreM7c
        mGIcMf33UDWXKPGmvmVEoilZBCA6XbcOmCo+qTa1QNQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-type:date:from:in-reply-to
        :message-id:mime-version:references:subject:to:x-me-proxy
        :x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; bh=sAfu4p
        +QiVeNnuEcI3dCQR633pLv27vuwHggq/8UNPk=; b=nzprzlOTjayaOK/LwLkSb5
        FSgNJVEawb7PUpqqIFw7UxZGT7jbuTX1kNgoU7+atS0elw71SRYxtxMPdcbChBxi
        uQBdzSLAwbEKrdjMAW/BujZETNnj44U31L3DmKVO3fZAMHH6+gg3VCPaOWXmTUsH
        KcLAZYSXS0lTCitesZDGH2NF4HhUHvATpO/Gz3xtVbPLKUnwR5EyruEcVrrcbcyG
        4EcAu9kt2hDwBcuVLLc2N2+H9Mg1DeokOS3QPfthUX0Lfq+O9dyGVUsywqva7/d7
        P/0ublXIRqEK7v5zgZEo5B2bApv86qbJ7HFjnC/9bjhkUabpgbAMfiLL3yQy6pXg
        ==
X-ME-Sender: <xms:gy3nXrNPwdpt83ykIxo4DVy-YXFVhIf4yaOFm5bTsV7rrXHMc_az0Q>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeduhedrudeikecutefuodetggdotefrodftvfcurf
    hrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecuuegr
    ihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjug
    hrpeffhffvuffkfhggtggujgesghdtreertddtvdenucfhrhhomhepofgrgihimhgvucft
    ihhprghrugcuoehmrgigihhmvgestggvrhhnohdrthgvtghhqeenucggtffrrghtthgvrh
    hnpeelkeeghefhuddtleejgfeljeffheffgfeijefhgfeufefhtdevteegheeiheeguden
    ucfkphepledtrdekledrieekrdejieenucevlhhushhtvghrufhiiigvpedtnecurfgrrh
    grmhepmhgrihhlfhhrohhmpehmrgigihhmvgestggvrhhnohdrthgvtghh
X-ME-Proxy: <xmx:gy3nXl_d48xf74ugtZHDOi92LxftFaHPR_ruLHOHLvVDeiQPsRkgBg>
    <xmx:gy3nXqTz3GKvwThxRh_Z-TY8Nag74qeO70zgmnVhUC_dsWefUyAqRg>
    <xmx:gy3nXvuADLO1-9us_vHUwf8292XL9qxGp6ycUHTIdysiI-aIH-5NLw>
    <xmx:gy3nXv4ap4YyrLEtJUG8liu0zAs1Cop1-vz1Hj9WzdT9KfJ0V3-Xvg>
Received: from localhost (lfbn-tou-1-1502-76.w90-89.abo.wanadoo.fr [90.89.68.76])
        by mail.messagingengine.com (Postfix) with ESMTPA id E7D923280059;
        Mon, 15 Jun 2020 04:12:50 -0400 (EDT)
Date:   Mon, 15 Jun 2020 10:12:49 +0200
From:   Maxime Ripard <maxime@cerno.tech>
To:     Diego Rondini <diego.rondini@kynetics.com>
Cc:     Rob Herring <robh+dt@kernel.org>, Chen-Yu Tsai <wens@csie.org>,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, linux-sunxi@googlegroups.com
Subject: Re: [PATCH 1/2] ARM: dts: orange-pi-zero-plus2: enable USB OTG port
Message-ID: <20200615081249.zx6caiirp72jywui@gilmour.lan>
References: <20200528204712.552964-1-diego.rondini@kynetics.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="tpgcvphjqdudnw7t"
Content-Disposition: inline
In-Reply-To: <20200528204712.552964-1-diego.rondini@kynetics.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--tpgcvphjqdudnw7t
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi Diego,

On Thu, May 28, 2020 at 10:47:11PM +0200, Diego Rondini wrote:
> Enable support for USB OTG port on Orange Pi Zero Plus 2 (both H3 and H5
> variants). As, according to the board schematics, the USB OTG port cannot
> provide power to external devices, we set dr_mode to peripheral.
>=20
> Signed-off-by: Diego Rondini <diego.rondini@kynetics.com>

Sorry for the time it took to review it. I initially thought it was ok
and wanted to wait until -rc1 was out to apply it, but...

> ---
>  .../boot/dts/sun8i-h3-orangepi-zero-plus2.dts | 23 +++++++++++++++++++
>  .../sun50i-h5-orangepi-zero-plus2.dts         | 23 +++++++++++++++++++
>  2 files changed, 46 insertions(+)
>=20
> diff --git a/arch/arm/boot/dts/sun8i-h3-orangepi-zero-plus2.dts b/arch/ar=
m/boot/dts/sun8i-h3-orangepi-zero-plus2.dts
> index b8f46e2802fd3..4376767699a47 100644
> --- a/arch/arm/boot/dts/sun8i-h3-orangepi-zero-plus2.dts
> +++ b/arch/arm/boot/dts/sun8i-h3-orangepi-zero-plus2.dts
> @@ -137,3 +137,26 @@ &uart0 {
>  	pinctrl-0 =3D <&uart0_pa_pins>;
>  	status =3D "okay";
>  };
> +
> +&usbphy {
> +	status =3D "okay";
> +};
> +
> +&usb_otg {
> +	/*
> +	 * According to schematics CN1 MicroUSB port can be used to take
> +	 * external 5V to power up the board VBUS. On the contrary CN1 MicroUSB
> +	 * port cannot provide power externally even if the board is powered
> +	 * via GPIO pins. It thus makes sense to force peripheral mode.
> +	 */
> +	dr_mode =3D "peripheral";
> +	status =3D "okay";
> +};
> +
> +&ehci0 {
> +	status =3D "okay";
> +};
> +
> +&ohci0 {
> +	status =3D "okay";
> +};

Nodes should be ordered alphabetically here.

> diff --git a/arch/arm64/boot/dts/allwinner/sun50i-h5-orangepi-zero-plus2.=
dts b/arch/arm64/boot/dts/allwinner/sun50i-h5-orangepi-zero-plus2.dts
> index c95a68541309c..d8192a7483e9e 100644
> --- a/arch/arm64/boot/dts/allwinner/sun50i-h5-orangepi-zero-plus2.dts
> +++ b/arch/arm64/boot/dts/allwinner/sun50i-h5-orangepi-zero-plus2.dts
> @@ -103,3 +103,26 @@ &uart1 {
>  	pinctrl-0 =3D <&uart1_pins>, <&uart1_rts_cts_pins>;
>  	status =3D "okay";
>  };
> +
> +&usbphy {
> +	status =3D "okay";
> +};
> +
> +&usb_otg {
> +	/*
> +	 * According to schematics CN1 MicroUSB port can be used to take
> +	 * external 5V to power up the board VBUS. On the contrary CN1 MicroUSB
> +	 * port cannot provide power externally even if the board is powered
> +	 * via GPIO pins. It thus makes sense to force peripheral mode.
> +	 */
> +	dr_mode =3D "peripheral";
> +	status =3D "okay";
> +};
> +
> +&ehci0 {
> +	status =3D "okay";
> +};
> +
> +&ohci0 {
> +	status =3D "okay";
> +};

And here too.

Sorry for not spotting this earlier.

Maxime

--tpgcvphjqdudnw7t
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRcEzekXsqa64kGDp7j7w1vZxhRxQUCXuctgQAKCRDj7w1vZxhR
xWnzAQCSvSidJmcewISQiPCQTATc2AKJsvFQJCKjT31JrlJGjQEAqor0s+oGJb62
aUklO6rMf2UikngeBjD1cdXEn04sEw8=
=RVYf
-----END PGP SIGNATURE-----

--tpgcvphjqdudnw7t--
