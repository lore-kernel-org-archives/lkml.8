Return-Path: <SRS0=LUA0=7L=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A9E73C433E0
	for <linux-kernel@archiver.kernel.org>; Fri, 29 May 2020 16:28:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 89E4720C09
	for <linux-kernel@archiver.kernel.org>; Fri, 29 May 2020 16:28:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727807AbgE2Q2x (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 29 May 2020 12:28:53 -0400
Received: from jabberwock.ucw.cz ([46.255.230.98]:35432 "EHLO
        jabberwock.ucw.cz" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725821AbgE2Q2w (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 29 May 2020 12:28:52 -0400
Received: by jabberwock.ucw.cz (Postfix, from userid 1017)
        id 31A621C0388; Fri, 29 May 2020 18:28:51 +0200 (CEST)
Date:   Fri, 29 May 2020 18:28:50 +0200
From:   Pavel Machek <pavel@ucw.cz>
To:     Martin Kepplinger <martin.kepplinger@puri.sm>
Cc:     robh@kernel.org, kernel@puri.sm, shawnguo@kernel.org,
        s.hauer@pengutronix.de, kernel@pengutronix.de, festevam@gmail.com,
        linux-imx@nxp.com, mchehab@kernel.org, Anson.Huang@nxp.com,
        agx@sigxcpu.org, angus@akkea.ca, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH 1/2] arm64: dts: Add a device tree for the Librem5 phone
Message-ID: <20200529162850.GC3709@amd>
References: <20200514155737.12160-1-martin.kepplinger@puri.sm>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
        protocol="application/pgp-signature"; boundary="69pVuxX8awAiJ7fD"
Content-Disposition: inline
In-Reply-To: <20200514155737.12160-1-martin.kepplinger@puri.sm>
User-Agent: Mutt/1.5.23 (2014-03-12)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--69pVuxX8awAiJ7fD
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi!

> From: "Angus Ainslie (Purism)" <angus@akkea.ca>
>=20
> Add a devicetree description for the Librem 5 phone. The early batches
> that have been sold are supported as well as the mass-produced device
> available later this year, see https://puri.sm/products/librem-5/
>=20
> This boots to a working console with working WWAN modem, wifi usdhc,
> IMU sensor device, proximity sensor, haptic motor, gpio keys, GNSS and LE=
Ds.
>=20
> Signed-off-by: Martin Kepplinger <martin.kepplinger@puri.sm>
> Signed-off-by: Angus Ainslie (Purism) <angus@akkea.ca>
> Signed-off-by: Guido G=FCnther <agx@sigxcpu.org>


> +		blue {
> +			label =3D "phone:blue:front";
> +			label =3D "phone:green:front";
> +			label =3D "phone:red:front";

Droid 4 uses "status-led:{red,green,blue}". Could this use same
naming?

> +			label =3D "lm3560:flash";
> +			label =3D "lm3560:torch";

This is one LED, right? I'm pretty sure we don't want lm3560 in the
name... "main-camera:flash" would be better. Even better would be
something that's already in use.

> +			label =3D "white:backlight_cluster";

Make this ":backlight", please. Again, we want something that's
already used.

Best regards,
									Pavel
--=20
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blo=
g.html

--69pVuxX8awAiJ7fD
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iEYEARECAAYFAl7ROEIACgkQMOfwapXb+vI8+QCdF8wNC5jeYX5/Wh8OaSGtEnXx
/fIAn1pviKJxbywSaQ66KE3evYxXdC/i
=B/bw
-----END PGP SIGNATURE-----

--69pVuxX8awAiJ7fD--
