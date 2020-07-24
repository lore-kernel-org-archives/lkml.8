Return-Path: <SRS0=4orP=BD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.5 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D73D9C433E4
	for <linux-kernel@archiver.kernel.org>; Fri, 24 Jul 2020 08:38:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B9AAB20674
	for <linux-kernel@archiver.kernel.org>; Fri, 24 Jul 2020 08:38:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726941AbgGXIi2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 24 Jul 2020 04:38:28 -0400
Received: from jabberwock.ucw.cz ([46.255.230.98]:37208 "EHLO
        jabberwock.ucw.cz" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726753AbgGXIi2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Jul 2020 04:38:28 -0400
Received: by jabberwock.ucw.cz (Postfix, from userid 1017)
        id 614BF1C0BD2; Fri, 24 Jul 2020 10:38:26 +0200 (CEST)
Date:   Fri, 24 Jul 2020 10:38:25 +0200
From:   Pavel Machek <pavel@ucw.cz>
To:     trivial@kernel.org, miquel.raynal@bootlin.com, richard@nod.at,
        vigneshr@ti.com, narmstrong@baylibre.com, nishkadg.linux@gmail.com,
        linux-mtd@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org, linux-oxnas@groups.io,
        linux-kernel@vger.kernel.org
Subject: [PATCH] mtd: rawnand: oxnas: cleanup/simplify code
Message-ID: <20200724083825.GA31437@amd>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
        protocol="application/pgp-signature"; boundary="fUYQa+Pmc3FrFX/N"
Content-Disposition: inline
User-Agent: Mutt/1.5.23 (2014-03-12)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--fUYQa+Pmc3FrFX/N
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Simplify oxnas_nand_probe.

Signed-off-by: Pavel Machek (CIP) <pavel@denx.de>

diff --git a/drivers/mtd/nand/raw/oxnas_nand.c b/drivers/mtd/nand/raw/oxnas=
_nand.c
index 8d0d76ad319d..f44947043e5a 100644
--- a/drivers/mtd/nand/raw/oxnas_nand.c
+++ b/drivers/mtd/nand/raw/oxnas_nand.c
@@ -144,8 +144,7 @@ static int oxnas_nand_probe(struct platform_device *pde=
v)
 		if (err)
 			goto err_cleanup_nand;
=20
-		oxnas->chips[oxnas->nchips] =3D chip;
-		++oxnas->nchips;
+		oxnas->chips[oxnas->nchips++] =3D chip;
 	}
=20
 	/* Exit if no chips found */

--=20
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blo=
g.html

--fUYQa+Pmc3FrFX/N
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iEYEARECAAYFAl8angEACgkQMOfwapXb+vJBYQCgwXVjv8KuArzkxb1gBBAOEO3z
IeMAn2E3CEeCAZ+t6WDFpNLo9z8KWf/n
=VmJN
-----END PGP SIGNATURE-----

--fUYQa+Pmc3FrFX/N--
