Return-Path: <SRS0=iZCi=CS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.2 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8ACB6C43461
	for <linux-kernel@archiver.kernel.org>; Wed,  9 Sep 2020 09:27:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4BE0F2145D
	for <linux-kernel@archiver.kernel.org>; Wed,  9 Sep 2020 09:27:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726970AbgIIJ1b (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 9 Sep 2020 05:27:31 -0400
Received: from jabberwock.ucw.cz ([46.255.230.98]:54496 "EHLO
        jabberwock.ucw.cz" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725826AbgIIJ13 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Sep 2020 05:27:29 -0400
Received: by jabberwock.ucw.cz (Postfix, from userid 1017)
        id 716721C0B87; Wed,  9 Sep 2020 11:27:26 +0200 (CEST)
Date:   Wed, 9 Sep 2020 11:27:25 +0200
From:   Pavel Machek <pavel@ucw.cz>
To:     Alexander Dahl <ada@thorsis.com>
Cc:     linux-leds@vger.kernel.org,
        Jacek Anaszewski <jacek.anaszewski@gmail.com>,
        Alexander Dahl <post@lespocky.de>, devicetree@vger.kernel.org,
        Dan Murphy <dmurphy@ti.com>, Rob Herring <robh+dt@kernel.org>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 0/2] leds: pwm: Make automatic labels work
Message-ID: <20200909092725.GD14289@amd>
References: <20200831210232.28052-1-post@lespocky.de>
 <2019500.FJf2EgCAKA@ada>
 <20200909090033.GD10891@amd>
 <1670070.OCB1Fln39h@ada>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
        protocol="application/pgp-signature"; boundary="uxuisgdDHaNETlh8"
Content-Disposition: inline
In-Reply-To: <1670070.OCB1Fln39h@ada>
User-Agent: Mutt/1.5.23 (2014-03-12)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--uxuisgdDHaNETlh8
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi!

> > > Besides: those suggestions are obviously valid for new bindings.  What
> > > about old bindings (.txt), which had no explicit SPDX tag or license =
note
> > > before? What license would apply there?  Is the .yaml file technically
> > > new, when it was mostly just converted from .txt?
> >=20
> > If it is based on previous .txt binding, you have to respect previous
> > author's license. That probably means GPL-2.0 only.
>=20
> Probably?

I have not checked exact licensing situation of that text, have not
decided if it was copyrightable in the first place, and am not a
lawyer.

So... probably :-).

Best regards,
									Pavel
--=20
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blo=
g.html

--uxuisgdDHaNETlh8
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iEYEARECAAYFAl9Yn/0ACgkQMOfwapXb+vKBNwCaAiwL8PTenU6t8p0eeFTwOAFZ
zDwAnjLM5GgoSjCflS2WRK1odwSIbLDD
=vCS3
-----END PGP SIGNATURE-----

--uxuisgdDHaNETlh8--
