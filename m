Return-Path: <SRS0=aedO=3O=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A64F4C35244
	for <linux-kernel@archiver.kernel.org>; Sat, 25 Jan 2020 19:13:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8141E20880
	for <linux-kernel@archiver.kernel.org>; Sat, 25 Jan 2020 19:13:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727285AbgAYTNf (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 25 Jan 2020 14:13:35 -0500
Received: from jabberwock.ucw.cz ([46.255.230.98]:45278 "EHLO
        jabberwock.ucw.cz" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726448AbgAYTNf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 25 Jan 2020 14:13:35 -0500
Received: by jabberwock.ucw.cz (Postfix, from userid 1017)
        id 979671C213B; Sat, 25 Jan 2020 20:13:33 +0100 (CET)
Date:   Sat, 25 Jan 2020 20:13:33 +0100
From:   Pavel Machek <pavel@denx.de>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     linux-kernel@vger.kernel.org, stable@vger.kernel.org,
        Vladimir Oltean <olteanv@gmail.com>,
        Claudiu Manoil <claudiu.manoil@nxp.com>,
        Li Yang <leoyang.li@nxp.com>, Shawn Guo <shawnguo@kernel.org>,
        Sasha Levin <sashal@kernel.org>
Subject: Re: [PATCH 4.19 320/639] ARM: dts: ls1021: Fix SGMII PCS link
 remaining down after PHY disconnect
Message-ID: <20200125191333.GG14064@duo.ucw.cz>
References: <20200124093047.008739095@linuxfoundation.org>
 <20200124093127.122646308@linuxfoundation.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
        protocol="application/pgp-signature"; boundary="eMnpOGXCMazMAbfp"
Content-Disposition: inline
In-Reply-To: <20200124093127.122646308@linuxfoundation.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--eMnpOGXCMazMAbfp
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi!

> [ Upstream commit c7861adbe37f576931650ad8ef805e0c47564b9a ]
>=20
> Each eTSEC MAC has its own TBI (SGMII) PCS and private MDIO bus.
> But due to a DTS oversight, both SGMII-compatible MACs of the LS1021 SoC
> are pointing towards the same internal PCS. Therefore nobody is
> controlling the internal PCS of eTSEC0.
>=20
> Upon initial ndo_open, the SGMII link is ok by virtue of U-boot
> initialization. But upon an ifdown/ifup sequence, the code path from
> ndo_open -> init_phy -> gfar_configure_serdes does not get executed for
> the PCS of eTSEC0 (and is executed twice for MAC eTSEC1). So the SGMII
> link remains down for eTSEC0. On the LS1021A-TWR board, to signal this
> failure condition, the PHY driver keeps printing
> '803x_aneg_done: SGMII link is not ok'.
>=20
> Also, it changes compatible of mdio0 to "fsl,etsec2-mdio" to match
> mdio1 device.

It actually changes compatible of both devices.

> +++ b/arch/arm/boot/dts/ls1021a.dtsi
> @@ -584,7 +584,7 @@
>  		};
> =20
>  		mdio0: mdio@2d24000 {
> -			compatible =3D "gianfar";
> +			compatible =3D "fsl,etsec2-mdio";
>  			device_type =3D "mdio";
>  			#address-cells =3D <1>;
>  			#size-cells =3D <0>;
> @@ -592,6 +592,15 @@
>  			      <0x0 0x2d10030 0x0 0x4>;
>  		};
> =20
> +		mdio1: mdio@2d64000 {
> +			compatible =3D "fsl,etsec2-mdio";


And they trigger different code in the driver:

                .type =3D "mdio",
                .compatible =3D "gianfar",
                .data =3D &(struct fsl_pq_mdio_data) {
		...
                        .get_tbipa =3D get_gfar_tbipa_from_mdio,
                },

		.compatible =3D "fsl,etsec2-mdio",
                .data =3D &(struct fsl_pq_mdio_data) {
		...
                        .get_tbipa =3D get_etsec_tbipa,
                },

Are you sure that is good idea for both mainline and stable?

Best regards,
									Pavel
--=20
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blo=
g.html

--eMnpOGXCMazMAbfp
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iF0EABECAB0WIQRPfPO7r0eAhk010v0w5/Bqldv68gUCXiyTXQAKCRAw5/Bqldv6
8lthAJsFS4MIGcrzWmnFBIdYp4eiyOFHegCdG8BpkQDKgCgDkHc7nkBzU9L3m3M=
=mao9
-----END PGP SIGNATURE-----

--eMnpOGXCMazMAbfp--
