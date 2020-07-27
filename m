Return-Path: <SRS0=+GcV=BG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A0DE1C433E0
	for <linux-kernel@archiver.kernel.org>; Mon, 27 Jul 2020 12:02:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7E9EE2075D
	for <linux-kernel@archiver.kernel.org>; Mon, 27 Jul 2020 12:02:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728071AbgG0MCn (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 27 Jul 2020 08:02:43 -0400
Received: from jabberwock.ucw.cz ([46.255.230.98]:51656 "EHLO
        jabberwock.ucw.cz" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727775AbgG0MCn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Jul 2020 08:02:43 -0400
Received: by jabberwock.ucw.cz (Postfix, from userid 1017)
        id 913E31C0BE1; Mon, 27 Jul 2020 14:02:40 +0200 (CEST)
Date:   Mon, 27 Jul 2020 14:02:40 +0200
From:   Pavel Machek <pavel@ucw.cz>
To:     Martin Kepplinger <martin.kepplinger@puri.sm>
Cc:     robh@kernel.org, kernel@puri.sm, shawnguo@kernel.org,
        s.hauer@pengutronix.de, kernel@pengutronix.de, festevam@gmail.com,
        linux-imx@nxp.com, mchehab@kernel.org, Anson.Huang@nxp.com,
        agx@sigxcpu.org, angus@akkea.ca, broonie@kernel.org,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        Daniel Baluta <daniel.baluta@nxp.com>
Subject: Re: [PATCH v4 1/3] arm64: dts: Add a device tree for the Librem 5
 phone
Message-ID: <20200727120240.bnivbjbfkjouucg4@duo.ucw.cz>
References: <20200721153225.7593-1-martin.kepplinger@puri.sm>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
        protocol="application/pgp-signature"; boundary="2hoj2bazgzddsthw"
Content-Disposition: inline
In-Reply-To: <20200721153225.7593-1-martin.kepplinger@puri.sm>
User-Agent: NeoMutt/20180716
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--2hoj2bazgzddsthw
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi!

> +	pwmleds {
> +		compatible =3D "pwm-leds";
> +
> +		blue {
> +			label =3D "blue:status";
> +			max-brightness =3D <248>;
> +			pwms =3D <&pwm2 0 50000>;
> +		};
> +
> +		green {
> +			label =3D "green:status";
> +			max-brightness =3D <248>;
> +			pwms =3D <&pwm4 0 50000>;
> +		};
> +
> +		red {
> +			label =3D "red:status";
> +			max-brightness =3D <248>;
> +			pwms =3D <&pwm3 0 50000>;
> +		};
> +	};

Can we postpone this?

1) green:status is not really name used anywhere else

2) this should really use multicolor framework, as it is single LED,
not three of them.

Fixing that in future will be hard :-(.
								Pavel
							=09
--=20
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blo=
g.html

--2hoj2bazgzddsthw
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iF0EARECAB0WIQRPfPO7r0eAhk010v0w5/Bqldv68gUCXx7CYAAKCRAw5/Bqldv6
8kwGAKCjvSashqZQsiQnPTLTZogcToiYPgCgp6uRaz1bOz+Xt/QNSsFRPZJqGzw=
=QEJS
-----END PGP SIGNATURE-----

--2hoj2bazgzddsthw--
