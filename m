Return-Path: <SRS0=5pK+=BB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4086FC433E3
	for <linux-kernel@archiver.kernel.org>; Wed, 22 Jul 2020 12:49:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 23B4B206C1
	for <linux-kernel@archiver.kernel.org>; Wed, 22 Jul 2020 12:49:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732371AbgGVMtc (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 22 Jul 2020 08:49:32 -0400
Received: from jabberwock.ucw.cz ([46.255.230.98]:54018 "EHLO
        jabberwock.ucw.cz" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726161AbgGVMtb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Jul 2020 08:49:31 -0400
Received: by jabberwock.ucw.cz (Postfix, from userid 1017)
        id 8E2601C0BD8; Wed, 22 Jul 2020 14:49:28 +0200 (CEST)
Date:   Wed, 22 Jul 2020 14:49:28 +0200
From:   Pavel Machek <pavel@ucw.cz>
To:     "Alexander A. Klimov" <grandmaster@al2klimov.de>
Cc:     jacek.anaszewski@gmail.com, dmurphy@ti.com, robh+dt@kernel.org,
        linux-leds@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] leds: Replace HTTP links with HTTPS ones
Message-ID: <20200722124928.3gya2v3g6g2mdgia@duo.ucw.cz>
References: <20200713145115.35121-1-grandmaster@al2klimov.de>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
        protocol="application/pgp-signature"; boundary="kj5yxf4eo4ywrkfx"
Content-Disposition: inline
In-Reply-To: <20200713145115.35121-1-grandmaster@al2klimov.de>
User-Agent: NeoMutt/20180716
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--kj5yxf4eo4ywrkfx
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi!

> Rationale:
> Reduces attack surface on kernel devs opening the links for MITM
> as HTTPS traffic is much harder to manipulate.
>=20
> Deterministic algorithm:
> For each file:
>   If not .svg:
>     For each line:
>       If doesn't contain `\bxmlns\b`:
>         For each link, `\bhttp://[^# \t\r\n]*(?:\w|/)`:
> 	  If neither `\bgnu\.org/license`, nor `\bmozilla\.org/MPL\b`:
>             If both the HTTP and HTTPS versions
>             return 200 OK and serve the same content:
>               Replace HTTP with HTTPS.
>=20
> Signed-off-by: Alexander A. Klimov <grandmaster@al2klimov.de>

Thanks, applied.
								Pavel
--=20
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blo=
g.html

--kj5yxf4eo4ywrkfx
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iF0EARECAB0WIQRPfPO7r0eAhk010v0w5/Bqldv68gUCXxg12AAKCRAw5/Bqldv6
8kj8AKC0kAL1fOx5tgtV1gIAvHOIwWwj6QCgsq0+6+rj1i2Lvg6b7fEjCUEEzxc=
=XAWI
-----END PGP SIGNATURE-----

--kj5yxf4eo4ywrkfx--
