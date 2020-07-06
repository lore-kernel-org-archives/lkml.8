Return-Path: <SRS0=eGSO=AR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C4D44C433E0
	for <linux-kernel@archiver.kernel.org>; Mon,  6 Jul 2020 05:13:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9B01D20715
	for <linux-kernel@archiver.kernel.org>; Mon,  6 Jul 2020 05:13:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=cerno.tech header.i=@cerno.tech header.b="btAgdJ3Z";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="ICNBk3Yq"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728738AbgGFFNh (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 6 Jul 2020 01:13:37 -0400
Received: from new1-smtp.messagingengine.com ([66.111.4.221]:52997 "EHLO
        new1-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726020AbgGFFNg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Jul 2020 01:13:36 -0400
Received: from compute4.internal (compute4.nyi.internal [10.202.2.44])
        by mailnew.nyi.internal (Postfix) with ESMTP id 175C05804EA;
        Mon,  6 Jul 2020 01:13:35 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute4.internal (MEProxy); Mon, 06 Jul 2020 01:13:35 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cerno.tech; h=
        date:from:to:cc:subject:message-id:references:mime-version
        :content-type:in-reply-to; s=fm3; bh=anUAt6HwTkdMO+ZCSBxltX4nxY9
        EZ2ice1KsskMA1Rs=; b=btAgdJ3Z06oWvmL/yyUvxceB3KqEOoRdrIUruDcyT6A
        RiFaHBEjg7DjsTsVBPUNVz1GE/LfKqoWmAI9zDgo4oQJmcPgxs104ioKrJJlFEcG
        /mZongD8HJqSTEC7XF4Y5mPoN4arad0Zel8Fogtj8imP6/O1xN1sCu4PJhVaGszP
        CKb+yrq19wYzt98u0GNqqwwpY6oERAdeQrLvjTPyLFM3V/eWD/yWo/088Gr3ZSkc
        lJN7wScNyb9oBkX7mGhTexir36Pbw5eYh6/6rJRHRo6a2wil9cvHg6PIv1B890bN
        yDPiAXZeN2o2dGaQAol/g55e4PWkqcrB5cyGPgt1V2A==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-type:date:from:in-reply-to
        :message-id:mime-version:references:subject:to:x-me-proxy
        :x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; bh=anUAt6
        HwTkdMO+ZCSBxltX4nxY9EZ2ice1KsskMA1Rs=; b=ICNBk3YqH5wx7URVlrNzKD
        sLF1VP3Pz9fPzU0BIbTU6qXiEsSDWQOZ3fFthRMev4/1DaeqyLKXYGmuacrp4PjG
        fJpH856QUfYeqRPS0Y5oEAD28AlszGXkzxVuELbS4tftg7lZ8n4VzH6oSoaKPfaS
        ZE3J2M2H5bZIjf1DLSSOKyaWPcme5jkqIaee9oFbccP2NddxPwOEYW3sTrnWd/Jy
        NU6imBi6EjNyR8Pq1B4asWL0LaLYTXRJqpmJ5mXW7VY/2UXbAzcCiWV9Rj3G8xzr
        NUQEgfQHtv3lBFztQ1EGPt3egwQ7fQmbY/Sez56n0X0riCEsF+GCrYbHVP4OqaeA
        ==
X-ME-Sender: <xms:_bICX9vf1nnsIQJusIVjo3eLdeXgDIJAQE1tpaPAkyIbKp7cYlfm-g>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeduiedruddvgdeltdcutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenuc
    fjughrpeffhffvuffkfhggtggujgesghdtreertddtvdenucfhrhhomhepofgrgihimhgv
    ucftihhprghrugcuoehmrgigihhmvgestggvrhhnohdrthgvtghhqeenucggtffrrghtth
    gvrhhnpeelkeeghefhuddtleejgfeljeffheffgfeijefhgfeufefhtdevteegheeiheeg
    udenucfkphepledtrdekledrieekrdejieenucevlhhushhtvghrufhiiigvpedtnecurf
    grrhgrmhepmhgrihhlfhhrohhmpehmrgigihhmvgestggvrhhnohdrthgvtghh
X-ME-Proxy: <xmx:_bICX2cudn17VFeHCRxFwpHx4JWQ2T0NrJ35Px6d3XR35O5UMrmTXQ>
    <xmx:_bICXwykVqkstxNaSwnwZNMY2-z1QB0IA2FP4NXzZ-cJpbSedT3q-w>
    <xmx:_bICX0MNOtkBFehGInzGnk_HXB4UdezTNDGVLmbjTlnNhQ9y-P_MqQ>
    <xmx:_7ICX8YESdtTtplY4lLNxVka0nSNL8aYHZlGN7oyYUi5gZUdWMvgaA>
Received: from localhost (lfbn-tou-1-1502-76.w90-89.abo.wanadoo.fr [90.89.68.76])
        by mail.messagingengine.com (Postfix) with ESMTPA id F25E8328005A;
        Mon,  6 Jul 2020 01:13:32 -0400 (EDT)
Date:   Mon, 6 Jul 2020 07:13:30 +0200
From:   Maxime Ripard <maxime@cerno.tech>
To:     Ondrej Jirman <megous@megous.com>
Cc:     linux-sunxi@googlegroups.com, Rob Herring <robh+dt@kernel.org>,
        Chen-Yu Tsai <wens@csie.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Samuel Holland <samuel@sholland.org>,
        Martijn Braam <martijn@brixit.nl>, Luca Weiss <luca@z3ntu.xyz>,
        Bhushan Shah <bshah@kde.org>, Icenowy Zheng <icenowy@aosc.io>,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/3] arm64: dts: allwinner: Add support for PinePhone
 revision 1.2
Message-ID: <20200706051330.bcrgkyx4a6lp3rti@gilmour.lan>
References: <20200703194842.111845-1-megous@megous.com>
 <20200703194842.111845-3-megous@megous.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="mgfb3fgrlm24trpq"
Content-Disposition: inline
In-Reply-To: <20200703194842.111845-3-megous@megous.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--mgfb3fgrlm24trpq
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,

On Fri, Jul 03, 2020 at 09:48:41PM +0200, Ondrej Jirman wrote:
> Revision 1.2 should be the final production version of the PinePhone.
> It has most of the known HW quirks fixed.
>=20
> Interrupt to the magnetometer is routed correctly, in this revision.
>=20
> The bulk of the changes are in how modem and the USB-C HDMI bridge
> chip is powered and where the signals from the modem are connected.
>=20
> Also backlight intensity seemingly behaves differently, than on the
> 1.1 and 1.0 boards, and the PWM duty cycle where backlight starts
> to work is 10% (as tested on 2 1.2 PinePhones I have access to).
>=20
> Signed-off-by: Ondrej Jirman <megous@megous.com>
> ---
>  arch/arm64/boot/dts/allwinner/Makefile        |  1 +
>  .../allwinner/sun50i-a64-pinephone-1.2.dts    | 40 +++++++++++++++++++
>  .../dts/allwinner/sun50i-a64-pinephone.dtsi   |  2 +-
>  3 files changed, 42 insertions(+), 1 deletion(-)
>  create mode 100644 arch/arm64/boot/dts/allwinner/sun50i-a64-pinephone-1.=
2.dts
>=20
> diff --git a/arch/arm64/boot/dts/allwinner/Makefile b/arch/arm64/boot/dts=
/allwinner/Makefile
> index e4d3cd0ac5bb..916d10d5b87c 100644
> --- a/arch/arm64/boot/dts/allwinner/Makefile
> +++ b/arch/arm64/boot/dts/allwinner/Makefile
> @@ -11,6 +11,7 @@ dtb-$(CONFIG_ARCH_SUNXI) +=3D sun50i-a64-pine64-plus.dt=
b sun50i-a64-pine64.dtb
>  dtb-$(CONFIG_ARCH_SUNXI) +=3D sun50i-a64-pinebook.dtb
>  dtb-$(CONFIG_ARCH_SUNXI) +=3D sun50i-a64-pinephone-1.0.dtb
>  dtb-$(CONFIG_ARCH_SUNXI) +=3D sun50i-a64-pinephone-1.1.dtb
> +dtb-$(CONFIG_ARCH_SUNXI) +=3D sun50i-a64-pinephone-1.2.dtb
>  dtb-$(CONFIG_ARCH_SUNXI) +=3D sun50i-a64-pinetab.dtb
>  dtb-$(CONFIG_ARCH_SUNXI) +=3D sun50i-a64-sopine-baseboard.dtb
>  dtb-$(CONFIG_ARCH_SUNXI) +=3D sun50i-a64-teres-i.dtb
> diff --git a/arch/arm64/boot/dts/allwinner/sun50i-a64-pinephone-1.2.dts b=
/arch/arm64/boot/dts/allwinner/sun50i-a64-pinephone-1.2.dts
> new file mode 100644
> index 000000000000..a9f5b670c9b8
> --- /dev/null
> +++ b/arch/arm64/boot/dts/allwinner/sun50i-a64-pinephone-1.2.dts
> @@ -0,0 +1,40 @@
> +// SPDX-License-Identifier: (GPL-2.0+ OR MIT)
> +// Copyright (C) 2020 Ondrej Jirman <megous@megous.com>
> +
> +/dts-v1/;
> +
> +#include "sun50i-a64-pinephone.dtsi"
> +
> +/ {
> +	model =3D "Pine64 PinePhone (1.2)";
> +	compatible =3D "pine64,pinephone-1.2", "allwinner,sun50i-a64";
> +};
> +
> +&backlight {
> +	power-supply =3D <&reg_ldo_io0>;
> +	/*
> +	 * PWM backlight circuit on this PinePhone revision was changed since 1=
=2E0,
> +	 * and the lowest PWM duty cycle that doesn't lead to backlight being o=
ff
> +	 * is around 10%. Duty cycle for the lowest brightness level also varri=
es
> +	 * quite a bit between individual boards, so the lowest value here was
> +	 * chosen as a safe default.
> +	 */
> +	brightness-levels =3D <
> +		5000 5248 5506 5858 6345
> +		6987 7805 8823 10062 11543
> +		13287 15317 17654 20319 23336
> +		26724 30505 34702 39335 44427
> +		50000
> +	>;
> +	num-interpolated-steps =3D <50>;
> +	default-brightness-level =3D <500>;
> +};
> +
> +&lis3mdl {
> +	/*
> +	 * Board revision 1.2 fixed routing of the interrupt to DRDY pin,
> +	 * enable interrupts.
> +	 */
> +	interrupt-parent =3D <&pio>;
> +	interrupts =3D <1 1 IRQ_TYPE_EDGE_RISING>; /* PB1 */
> +};
> diff --git a/arch/arm64/boot/dts/allwinner/sun50i-a64-pinephone.dtsi b/ar=
ch/arm64/boot/dts/allwinner/sun50i-a64-pinephone.dtsi
> index a3b400ff972b..904122711a89 100644
> --- a/arch/arm64/boot/dts/allwinner/sun50i-a64-pinephone.dtsi
> +++ b/arch/arm64/boot/dts/allwinner/sun50i-a64-pinephone.dtsi
> @@ -142,7 +142,7 @@ &i2c1 {
>  	status =3D "okay";
> =20
>  	/* Magnetometer */
> -	lis3mdl@1e {
> +	lis3mdl: lis3mdl@1e {

I just applied all three patches, but the node name here is wrong and
should be the class of the device.

Can you send a follow-up patch renaming the node name to magnetometer?

Thanks!
Maxime

--mgfb3fgrlm24trpq
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRcEzekXsqa64kGDp7j7w1vZxhRxQUCXwKy+gAKCRDj7w1vZxhR
xWQpAP0UJ8ua9RRDvitUXzGNB+CzLgDfm2ZBG+0sB8DI0zw6qgEA5epjlu13pD4d
qO4Nhw+vXAYWlVfUVutE4jFoQ7NYAwM=
=RGRe
-----END PGP SIGNATURE-----

--mgfb3fgrlm24trpq--
