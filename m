Return-Path: <SRS0=9JlO=3L=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 63CB5C33CB6
	for <linux-kernel@archiver.kernel.org>; Wed, 22 Jan 2020 17:42:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 40C6A24656
	for <linux-kernel@archiver.kernel.org>; Wed, 22 Jan 2020 17:42:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1579714943;
	bh=ZwK1GS5yK1MyB/aRUXx77+g9jMMXlUdwoNTp+7I4lYU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=CM344V3kOD+L7Ln2J3I/T/YxD9hj2GN/Omqfk97tqV6ywk0N3oDVbkLwx49m9QOqe
	 nPobqshqKaDhosCG7YqsIj1gY2sMg4p4UTkc4hTBkVl348Nc3aJFKgtD3qSiuz4Z03
	 x4v3nDZVwIekbNhompSTh5edWK1Xjg0kd4ApuiUw=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729117AbgAVRmW (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 22 Jan 2020 12:42:22 -0500
Received: from mail.kernel.org ([198.145.29.99]:42666 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725802AbgAVRmW (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Jan 2020 12:42:22 -0500
Received: from localhost (lfbn-tou-1-1502-76.w90-89.abo.wanadoo.fr [90.89.68.76])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 6C76924125;
        Wed, 22 Jan 2020 17:42:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1579714940;
        bh=ZwK1GS5yK1MyB/aRUXx77+g9jMMXlUdwoNTp+7I4lYU=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=zVcgfL6eiwVI0Le6A/KPOCt79RTF0cN03WNDgsZYCmlGbhwhv5b1pCEdlOipyxjGE
         /8FjjTMoUP79g6eMxcItXsMa7GgKfh6UGuSHWEmsRNE/Jj8Xrw3vStTdXFTgWyqx2x
         dELl4mOFA0XMYrXyzkkCXF0mWhRTsbYh/fA1xMGk=
Date:   Wed, 22 Jan 2020 18:42:18 +0100
From:   Maxime Ripard <mripard@kernel.org>
To:     Jernej =?utf-8?Q?=C5=A0krabec?= <jernej.skrabec@siol.net>
Cc:     wens@csie.org, robh+dt@kernel.org, mark.rutland@arm.com,
        linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/3] arm64: dts: allwinner: h6: tanix-tx6: enable emmc
Message-ID: <20200122174218.g4aan24f2pihjkpw@gilmour.lan>
References: <20200115193441.172902-1-jernej.skrabec@siol.net>
 <20200117181427.hy7qsyxwomsl3v2q@gilmour.lan>
 <3332569.R56niFO833@jernej-laptop>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="2y2zbwn5zkttwz5b"
Content-Disposition: inline
In-Reply-To: <3332569.R56niFO833@jernej-laptop>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--2y2zbwn5zkttwz5b
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,

On Fri, Jan 17, 2020 at 07:18:58PM +0100, Jernej =C5=A0krabec wrote:
> Dne petek, 17. januar 2020 ob 19:14:27 CET je Maxime Ripard napisal(a):
> > On Wed, Jan 15, 2020 at 08:34:41PM +0100, Jernej Skrabec wrote:
> > > Tanix TX6 has 32 GiB eMMC. Add a node for it.
> > >
> > > Signed-off-by: Jernej Skrabec <jernej.skrabec@siol.net>
> > > ---
> > >
> > >  .../dts/allwinner/sun50i-h6-tanix-tx6.dts     | 20 +++++++++++++++++=
++
> > >  1 file changed, 20 insertions(+)
> > >
> > > diff --git a/arch/arm64/boot/dts/allwinner/sun50i-h6-tanix-tx6.dts
> > > b/arch/arm64/boot/dts/allwinner/sun50i-h6-tanix-tx6.dts index
> > > 83e6cb0e59ce..8cbf4e4a761e 100644
> > > --- a/arch/arm64/boot/dts/allwinner/sun50i-h6-tanix-tx6.dts
> > > +++ b/arch/arm64/boot/dts/allwinner/sun50i-h6-tanix-tx6.dts
> > > @@ -31,6 +31,13 @@ hdmi_con_in: endpoint {
> > >
> > >  		};
> > >
> > >  	};
> > >
> > > +	reg_vcc1v8: vcc1v8 {
> > > +		compatible =3D "regulator-fixed";
> > > +		regulator-name =3D "vcc1v8";
> > > +		regulator-min-microvolt =3D <1800000>;
> > > +		regulator-max-microvolt =3D <1800000>;
> > > +	};
> > > +
> > >
> > >  	reg_vcc3v3: vcc3v3 {
> > >
> > >  		compatible =3D "regulator-fixed";
> > >  		regulator-name =3D "vcc3v3";
> > >
> > > @@ -78,6 +85,15 @@ &mmc0 {
> > >
> > >  	status =3D "okay";
> > >
> > >  };
> > >
> > > +&mmc2 {
> > > +	vmmc-supply =3D <&reg_vcc3v3>;
> > > +	vqmmc-supply =3D <&reg_vcc1v8>;
> > > +	non-removable;
> > > +	cap-mmc-hw-reset;
> > > +	bus-width =3D <8>;
> > > +	status =3D "okay";
> > > +};
> > > +
> > >
> > >  &ohci0 {
> > >
> > >  	status =3D "okay";
> > >
> > >  };
> > >
> > > @@ -86,6 +102,10 @@ &ohci3 {
> > >
> > >  	status =3D "okay";
> > >
> > >  };
> > >
> > > +&pio {
> > > +	vcc-pc-supply =3D <&reg_vcc1v8>;
> > > +};
> > > +
> >
> > Can you list all of the regulators for the H6 while you're at it (in a
> > preliminary patch, ideally)?
>
> Not sure what you mean. This box has only fixed regulators. I deducted ab=
ove
> from the fact that port C is mostly dedicated to eMMC, so it has to use s=
ame
> regulator as vqmmc. Other than that, I don't know.

If you don't really know, then setting all of them to 3.3v makes the
most sense. It should be described anyway.

Maxime

--2y2zbwn5zkttwz5b
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRcEzekXsqa64kGDp7j7w1vZxhRxQUCXiiJegAKCRDj7w1vZxhR
xcAZAP4vv4yjYsoEsxEn+hYjAeStYl6dLzr0TziDbUtV7pwXYQD/Z1zx4f5U7HAb
Jnn7ma32yEkphTh/TgQGVeWHaRuDjQM=
=1iAL
-----END PGP SIGNATURE-----

--2y2zbwn5zkttwz5b--
