Return-Path: <SRS0=87nF=CT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.2 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B5B17C43461
	for <linux-kernel@archiver.kernel.org>; Thu, 10 Sep 2020 12:28:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7A3D120BED
	for <linux-kernel@archiver.kernel.org>; Thu, 10 Sep 2020 12:28:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730729AbgIJM2u (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 10 Sep 2020 08:28:50 -0400
Received: from jabberwock.ucw.cz ([46.255.230.98]:41986 "EHLO
        jabberwock.ucw.cz" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730487AbgIJMZH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Sep 2020 08:25:07 -0400
Received: by jabberwock.ucw.cz (Postfix, from userid 1017)
        id 0EAE81C0B9C; Thu, 10 Sep 2020 14:25:02 +0200 (CEST)
Date:   Thu, 10 Sep 2020 14:25:01 +0200
From:   Pavel Machek <pavel@ucw.cz>
To:     Marek =?iso-8859-1?Q?Beh=FAn?= <marek.behun@nic.cz>
Cc:     netdev@vger.kernel.org, linux-leds@vger.kernel.org,
        Dan Murphy <dmurphy@ti.com>,
        =?utf-8?Q?Ond=C5=99ej?= Jirman <megous@megous.com>,
        Russell King <linux@armlinux.org.uk>,
        Andrew Lunn <andrew@lunn.ch>, linux-kernel@vger.kernel.org,
        Matthias Schiffer <matthias.schiffer@ew.tq-group.com>,
        "David S. Miller" <davem@davemloft.net>
Subject: Re: [PATCH net-next + mvebu v2 7/7] arm64: dts:
 armada-3720-turris-mox: add nodes for ethernet PHY LEDs
Message-ID: <20200910122501.GD7907@duo.ucw.cz>
References: <20200909162552.11032-1-marek.behun@nic.cz>
 <20200909162552.11032-8-marek.behun@nic.cz>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
        protocol="application/pgp-signature"; boundary="pZs/OQEoSSbxGlYw"
Content-Disposition: inline
In-Reply-To: <20200909162552.11032-8-marek.behun@nic.cz>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--pZs/OQEoSSbxGlYw
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi!

> Add nodes for the green and yellow LEDs that are connected to the
> ethernet PHY chip on Turris MOX A.
>=20
> Signed-off-by: Marek Beh=FAn <marek.behun@nic.cz>
> ---
>  .../dts/marvell/armada-3720-turris-mox.dts    | 23 +++++++++++++++++++
>  1 file changed, 23 insertions(+)
>=20
> diff --git a/arch/arm64/boot/dts/marvell/armada-3720-turris-mox.dts b/arc=
h/arm64/boot/dts/marvell/armada-3720-turris-mox.dts
> index f3a678e0fd99b..6da03b6c69c0a 100644
> --- a/arch/arm64/boot/dts/marvell/armada-3720-turris-mox.dts
> +++ b/arch/arm64/boot/dts/marvell/armada-3720-turris-mox.dts
> @@ -9,6 +9,7 @@
>  #include <dt-bindings/bus/moxtet.h>
>  #include <dt-bindings/gpio/gpio.h>
>  #include <dt-bindings/input/input.h>
> +#include <dt-bindings/leds/common.h>
>  #include "armada-372x.dtsi"
> =20
>  / {
> @@ -273,6 +274,28 @@ &mdio {
> =20
>  	phy1: ethernet-phy@1 {
>  		reg =3D <1>;
> +
> +		leds {
> +			compatible =3D "linux,hw-controlled-leds";

I don't believe this is suitable compatible.

Best regards,
									Pavel
--=20
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blo=
g.html

--pZs/OQEoSSbxGlYw
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iF0EABECAB0WIQRPfPO7r0eAhk010v0w5/Bqldv68gUCX1obHQAKCRAw5/Bqldv6
8ry1AJ0WuyNtKkIiDtHmZME1XJfne9xa4gCcDypSlX3LoleaOOtICEOjPdRFUoo=
=sjN2
-----END PGP SIGNATURE-----

--pZs/OQEoSSbxGlYw--
