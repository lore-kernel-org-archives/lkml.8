Return-Path: <SRS0=maQP=AN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7DD74C433E1
	for <linux-kernel@archiver.kernel.org>; Thu,  2 Jul 2020 07:46:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5C9CE20899
	for <linux-kernel@archiver.kernel.org>; Thu,  2 Jul 2020 07:46:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=cerno.tech header.i=@cerno.tech header.b="onCcasIj";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="uHSAlAsA"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727954AbgGBHqk (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 2 Jul 2020 03:46:40 -0400
Received: from wnew4-smtp.messagingengine.com ([64.147.123.18]:43447 "EHLO
        wnew4-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726362AbgGBHqj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Jul 2020 03:46:39 -0400
Received: from compute4.internal (compute4.nyi.internal [10.202.2.44])
        by mailnew.west.internal (Postfix) with ESMTP id DF820A96;
        Thu,  2 Jul 2020 03:46:36 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute4.internal (MEProxy); Thu, 02 Jul 2020 03:46:38 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cerno.tech; h=
        date:from:to:cc:subject:message-id:references:mime-version
        :content-type:in-reply-to; s=fm3; bh=XD7giw22ZmO7+jioYevux6e4A4V
        ypAB+8F9PcAxqDzg=; b=onCcasIjj6hTu3WPuf4sGp6/uBj/24rWctvNGuHHyQP
        iGIkq5cs6KYY6exKCz3iXR5EdwP6dWkoXl6thsoClOXo4/LeYsT5RJhO0PzS61+a
        u1stq2r53l/8rRv+uHLF+vrJ7aiDaGLerafnb4EMwxsRzKjk7ZySAs/gSDFV8K4O
        //HqGET1kB3hDcCkI4venIwe3XjS67w8J/URT5dRoVrA1K/+OMGIilKnBn8FDEHF
        U4BbTf9XCLWgZf+OK6czrO9sLwZSkAam2l/AG4T5KnMX8H38ooOsDZIyrcYGY+tw
        ObRp5CD9jFWZuFrFXbv46s7zk4YBjLDS9vVcbb620iw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-type:date:from:in-reply-to
        :message-id:mime-version:references:subject:to:x-me-proxy
        :x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; bh=XD7giw
        22ZmO7+jioYevux6e4A4VypAB+8F9PcAxqDzg=; b=uHSAlAsAhoZYXWd6OnEizh
        vO+Xr7Xthpivedv8K2ygyrVsmHnBr+3XxwBk2YyKwXlIe5fQ2X/1ky1a0rqHMDEH
        QMhNhe07CpiOg9iD952KgVdmy+lfI11JNZSSWslE9MbChMlVn4tY2PgAq+N3SyiG
        M4aL4/7pEBw1+9xEE7ycWkT9ewJCBQn/SHAS3iXbceBZjF3QTzJaM6MV2GPeba/i
        so1fHRPqUrkggVHamPlfO5CmRKGIQCUkoe2isukDNSRMB8c8y+TuE9sRkq9GPuYD
        vH5YfOsq4XRwnkHXSpq4pWlF7RD1LgkOBrn4+x6sVMGOEHCv7BDGfL6CmhqSnSuA
        ==
X-ME-Sender: <xms:2pD9Xv_8DEDgYsgU4ENG14E5yt9ldfWo_anPvVHs_qZ0yXLuPdDwOw>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeduiedrtdefgdduvdefucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepfffhvffukfhfgggtuggjsehgtderredttddvnecuhfhrohhmpeforgigihhm
    vgcutfhiphgrrhguuceomhgrgihimhgvsegtvghrnhhordhtvggthheqnecuggftrfgrth
    htvghrnhepleekgeehhfdutdeljefgleejffehfffgieejhffgueefhfdtveetgeehieeh
    gedunecukfhppeeltddrkeelrdeikedrjeeinecuvehluhhsthgvrhfuihiivgeptdenuc
    frrghrrghmpehmrghilhhfrhhomhepmhgrgihimhgvsegtvghrnhhordhtvggthh
X-ME-Proxy: <xmx:2pD9Xrvu3pWSffdJhtROI1t-tC_B5UhUpwTimD6nZuNiPHYJM4DRWA>
    <xmx:2pD9XtD_K1AzkRvfClc7dYbb_S_CavhwwUKrHjcYp2Ed25bJl_kLwQ>
    <xmx:2pD9Xrc3NCP9DxAmkwGyNXTD6neeP4XTj98rN6TMLPcBj82KhsyJAA>
    <xmx:3JD9XpcZA-4T6qtgUGGXqPCajd1anfIY-w08mJT3mAM8ZQXBG1goCZ04Vyg>
Received: from localhost (lfbn-tou-1-1502-76.w90-89.abo.wanadoo.fr [90.89.68.76])
        by mail.messagingengine.com (Postfix) with ESMTPA id D187D3280064;
        Thu,  2 Jul 2020 03:46:33 -0400 (EDT)
Date:   Thu, 2 Jul 2020 09:46:31 +0200
From:   Maxime Ripard <maxime@cerno.tech>
To:     Ondrej Jirman <megous@megous.com>
Cc:     linux-sunxi@googlegroups.com,
        Thierry Reding <thierry.reding@gmail.com>,
        Sam Ravnborg <sam@ravnborg.org>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        Guido =?utf-8?Q?G=C3=BCnther?= <agx@sigxcpu.org>,
        Purism Kernel Team <kernel@puri.sm>,
        Rob Herring <robh+dt@kernel.org>, Chen-Yu Tsai <wens@csie.org>,
        Linus Walleij <linus.walleij@linaro.org>,
        Icenowy Zheng <icenowy@aosc.io>,
        dri-devel@lists.freedesktop.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        Samuel Holland <samuel@sholland.org>,
        Martijn Braam <martijn@brixit.nl>, Luca Weiss <luca@z3ntu.xyz>,
        Bhushan Shah <bshah@kde.org>
Subject: Re: [PATCH v7 12/13] arm64: dts: sun50i-a64-pinephone: Enable LCD
 support on PinePhone
Message-ID: <20200702074631.oj54lreufm3fkhiu@gilmour.lan>
References: <20200701162928.1638874-1-megous@megous.com>
 <20200701162928.1638874-13-megous@megous.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="4seei5k7uul7ogtm"
Content-Disposition: inline
In-Reply-To: <20200701162928.1638874-13-megous@megous.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--4seei5k7uul7ogtm
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Jul 01, 2020 at 06:29:27PM +0200, Ondrej Jirman wrote:
> From: Icenowy Zheng <icenowy@aosc.io>
>=20
> PinePhone uses PWM backlight and a XBD599 LCD panel over DSI for
> display.
>=20
> Backlight levels curve was optimized by Martijn Braam using a
> lux meter.
>=20
> Add its device nodes.
>=20
> Signed-off-by: Icenowy Zheng <icenowy@aosc.io>
> Signed-off-by: Martijn Braam <martijn@brixit.nl>
> Signed-off-by: Ondrej Jirman <megous@megous.com>
> Acked-by: Linus Walleij <linus.walleij@linaro.org>
> ---
>  .../allwinner/sun50i-a64-pinephone-1.1.dts    | 19 ++++++++++
>  .../dts/allwinner/sun50i-a64-pinephone.dtsi   | 35 +++++++++++++++++++
>  2 files changed, 54 insertions(+)
>=20
> diff --git a/arch/arm64/boot/dts/allwinner/sun50i-a64-pinephone-1.1.dts b=
/arch/arm64/boot/dts/allwinner/sun50i-a64-pinephone-1.1.dts
> index 06a775c41664..3e99a87e9ce5 100644
> --- a/arch/arm64/boot/dts/allwinner/sun50i-a64-pinephone-1.1.dts
> +++ b/arch/arm64/boot/dts/allwinner/sun50i-a64-pinephone-1.1.dts
> @@ -9,3 +9,22 @@ / {
>  	model =3D "Pine64 PinePhone Braveheart (1.1)";
>  	compatible =3D "pine64,pinephone-1.1", "allwinner,sun50i-a64";
>  };
> +
> +&backlight {
> +	power-supply =3D <&reg_ldo_io0>;
> +	/*
> +	 * PWM backlight circuit on this PinePhone revision was changed since
> +	 * 1.0, and the lowest PWM duty cycle that doesn't lead to backlight
> +	 * being off is around 20%. Duty cycle for the lowest brightness level
> +	 * also varries quite a bit between individual boards, so the lowest
> +	 * value here was chosen as a safe default.
> +	 */
> +	brightness-levels =3D <
> +		774  793  814  842
> +		882  935  1003 1088
> +		1192 1316 1462 1633
> +		1830 2054 2309 2596
> +		2916 3271 3664 4096>;
> +	num-interpolated-steps =3D <50>;
> +	default-brightness-level =3D <400>;
> +};
> diff --git a/arch/arm64/boot/dts/allwinner/sun50i-a64-pinephone.dtsi b/ar=
ch/arm64/boot/dts/allwinner/sun50i-a64-pinephone.dtsi
> index cefda145c3c9..85a7aa5efd32 100644
> --- a/arch/arm64/boot/dts/allwinner/sun50i-a64-pinephone.dtsi
> +++ b/arch/arm64/boot/dts/allwinner/sun50i-a64-pinephone.dtsi
> @@ -16,6 +16,13 @@ aliases {
>  		serial0 =3D &uart0;
>  	};
> =20
> +	backlight: backlight {
> +		compatible =3D "pwm-backlight";
> +		pwms =3D <&r_pwm 0 50000 PWM_POLARITY_INVERTED>;
> +		enable-gpios =3D <&pio 7 10 GPIO_ACTIVE_HIGH>; /* PH10 */
> +		/* Backlight configuration differs per PinePhone revision. */
> +	};
> +
>  	chosen {
>  		stdout-path =3D "serial0:115200n8";
>  	};
> @@ -84,6 +91,30 @@ &dai {
>  	status =3D "okay";
>  };
> =20
> +&de {
> +	status =3D "okay";
> +};
> +
> +&dphy {
> +	status =3D "okay";
> +};
> +
> +&dsi {
> +	vcc-dsi-supply =3D <&reg_dldo1>;
> +	#address-cells =3D <1>;
> +	#size-cells =3D <0>;
> +	status =3D "okay";

If you're about to send a new version, you can remove #address-cells and
#size-cells too, they're already set in the DTSI.

Maxime

--4seei5k7uul7ogtm
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRcEzekXsqa64kGDp7j7w1vZxhRxQUCXv2Q1wAKCRDj7w1vZxhR
xRU3AP9/RU4o7gJkXULsYLNValRt6TkkGC1AIH6ty1GbeFVv2AD+NJYwDiC9CJxm
iWn2yi4SWp4MZG0IKSMy8iATzq2rVgs=
=mUin
-----END PGP SIGNATURE-----

--4seei5k7uul7ogtm--
