Return-Path: <SRS0=5pK+=BB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 005C3C433E4
	for <linux-kernel@archiver.kernel.org>; Wed, 22 Jul 2020 07:11:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D7AB220709
	for <linux-kernel@archiver.kernel.org>; Wed, 22 Jul 2020 07:11:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731615AbgGVHLI (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 22 Jul 2020 03:11:08 -0400
Received: from jabberwock.ucw.cz ([46.255.230.98]:51584 "EHLO
        jabberwock.ucw.cz" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727096AbgGVHLI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Jul 2020 03:11:08 -0400
Received: by jabberwock.ucw.cz (Postfix, from userid 1017)
        id 2B3751C0BF1; Wed, 22 Jul 2020 09:11:05 +0200 (CEST)
Date:   Wed, 22 Jul 2020 09:10:55 +0200
From:   Pavel Machek <pavel@ucw.cz>
To:     Dan Murphy <dmurphy@ti.com>
Cc:     jacek.anaszewski@gmail.com, robh@kernel.org, marek.behun@nic.cz,
        devicetree@vger.kernel.org, linux-leds@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH v31 03/12] leds: lp50xx: Add the LP50XX family of the RGB
 LED driver
Message-ID: <20200722071055.GA8984@amd>
References: <20200716182007.18389-1-dmurphy@ti.com>
 <20200716182007.18389-4-dmurphy@ti.com>
 <20200721210554.GC5966@amd>
 <c774fab9-124b-da2e-6f7c-614f34322942@ti.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
        protocol="application/pgp-signature"; boundary="OXfL5xGRrasGEqWY"
Content-Disposition: inline
In-Reply-To: <c774fab9-124b-da2e-6f7c-614f34322942@ti.com>
User-Agent: Mutt/1.5.23 (2014-03-12)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--OXfL5xGRrasGEqWY
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi!

> >>+			ret =3D fwnode_property_read_u32_array(child,
> >>+							     "reg",
> >>+							     led_banks,
> >>+							     ret);
> >Move this to subfunction to reduce the indentation? (Or, just refactor
> >it somehow).
>=20
> Actually I can just put it all on the same line since the 80 character
> requirement is relaxed.

No.

You have too long and too complex function, with too many blocks
inside each other. Please fix it.

									Pavel
--=20
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blo=
g.html

--OXfL5xGRrasGEqWY
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iEYEARECAAYFAl8X5n8ACgkQMOfwapXb+vIx7QCeJ+80yzhE3zdJ33JsSBF1CbS9
i0EAn1cgjVdwOdcgTvETrwYx8ha/r9B5
=x2Vm
-----END PGP SIGNATURE-----

--OXfL5xGRrasGEqWY--
