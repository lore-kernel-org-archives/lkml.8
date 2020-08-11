Return-Path: <SRS0=vr6t=BV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EB512C433DF
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Aug 2020 22:01:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id BFE49206C3
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Aug 2020 22:01:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726691AbgHKWBN (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 11 Aug 2020 18:01:13 -0400
Received: from jabberwock.ucw.cz ([46.255.230.98]:40158 "EHLO
        jabberwock.ucw.cz" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726164AbgHKWBM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Aug 2020 18:01:12 -0400
Received: by jabberwock.ucw.cz (Postfix, from userid 1017)
        id 923501C0BDD; Wed, 12 Aug 2020 00:01:09 +0200 (CEST)
Date:   Wed, 12 Aug 2020 00:01:09 +0200
From:   Pavel Machek <pavel@ucw.cz>
To:     Dan Murphy <dmurphy@ti.com>
Cc:     jacek.anaszewski@gmail.com, robh@kernel.org, marek.behun@nic.cz,
        devicetree@vger.kernel.org, linux-leds@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH v32 2/6] leds: lp50xx: Add the LP50XX family of the RGB
 LED driver
Message-ID: <20200811220109.GA9105@amd>
References: <20200722153146.8767-1-dmurphy@ti.com>
 <20200722153146.8767-3-dmurphy@ti.com>
 <20200811105413.r2m2f7bubuz55rrt@duo.ucw.cz>
 <935119fa-6d1f-8e99-51f9-87966b4d03ad@ti.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
        protocol="application/pgp-signature"; boundary="bp/iNruPH9dso1Pn"
Content-Disposition: inline
In-Reply-To: <935119fa-6d1f-8e99-51f9-87966b4d03ad@ti.com>
User-Agent: Mutt/1.5.23 (2014-03-12)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--bp/iNruPH9dso1Pn
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi!

> >Actually... This is quite impressive ammount of code to
> >zero-initialize few registers. Could the regmap be told to set the
> >range to zero, or use loops to reduce ammount of code?
>=20
> I am not aware of any regmap calls that will set a range of registers to a
> certain value.
>=20
> Well it depends on where we want to create the default cache values.
>=20
> Either we run through a for..loop during driver probe and delay device st=
art
> up or we keep the simple arrays and increase the driver total size.

for loop will be better.

Plus, REGCACHE_RBTREE is very likely overkill.

Best regards,

									Pavel
--=20
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blo=
g.html

--bp/iNruPH9dso1Pn
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iEYEARECAAYFAl8zFSUACgkQMOfwapXb+vK33gCgrVIt/hl85rI2VflMhqe49hC3
SUAAoLKaey4VLSsVlT+fhgXrveQQu/tp
=eaXI
-----END PGP SIGNATURE-----

--bp/iNruPH9dso1Pn--
