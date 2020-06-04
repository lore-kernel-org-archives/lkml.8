Return-Path: <SRS0=TsDl=7R=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3A8CBC433E0
	for <linux-kernel@archiver.kernel.org>; Thu,  4 Jun 2020 13:28:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 11CBE20772
	for <linux-kernel@archiver.kernel.org>; Thu,  4 Jun 2020 13:28:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728578AbgFDN2Q (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 4 Jun 2020 09:28:16 -0400
Received: from jabberwock.ucw.cz ([46.255.230.98]:52780 "EHLO
        jabberwock.ucw.cz" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728224AbgFDN2O (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 Jun 2020 09:28:14 -0400
Received: by jabberwock.ucw.cz (Postfix, from userid 1017)
        id 1337D1C0BD2; Thu,  4 Jun 2020 15:28:13 +0200 (CEST)
Date:   Thu, 4 Jun 2020 15:28:12 +0200
From:   Pavel Machek <pavel@ucw.cz>
To:     Arnd Bergmann <arnd@arndb.de>
Cc:     Nathan Chancellor <natechancellor@gmail.com>,
        Jacek Anaszewski <jacek.anaszewski@gmail.com>,
        Bryan Wu <bryan.wu@canonical.com>,
        "G.Shark Jeong" <gshark.jeong@gmail.com>,
        Dan Murphy <dmurphy@ti.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        linux-leds@vger.kernel.org,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        clang-built-linux <clang-built-linux@googlegroups.com>
Subject: Re: [PATCH] leds: lm355x: avoid enum conversion warning
Message-ID: <20200604132812.GE7222@duo.ucw.cz>
References: <20200505141928.923428-1-arnd@arndb.de>
 <20200506024416.GB415100@ubuntu-s3-xlarge-x86>
 <CAK8P3a3wqiXAx2GuKJjY90qLGNnyBNTst6LW7n6tRDvzvBQVVQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
        protocol="application/pgp-signature"; boundary="6Vw0j8UKbyX0bfpA"
Content-Disposition: inline
In-Reply-To: <CAK8P3a3wqiXAx2GuKJjY90qLGNnyBNTst6LW7n6tRDvzvBQVVQ@mail.gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--6Vw0j8UKbyX0bfpA
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi!

> > > -             reg_val =3D pdata->pass_mode;
> > > +             reg_val =3D (u32)pdata->pass_mode;
> >
> > Is this cast needed? I don't think there should be warning from going
> > from an enumerated type to unsigned int.
>=20
> This cast is not needed for warnings, I added it for consistency because
> it seemed odd to cast only four of the five enums. I can remove if though
> if you think it's clearer without the cast.
>=20
> There may also be a different solution in completely removing the
> lm355x_chip_init() function, as it was added at a time when we
> were converting the last board files into devicetree, and there has
> never been a board file defining lm355x_platform_data.
>=20
> There is unfortunately no DT support either in it, so I assume we
> could just remove the driver completely, or change it to use a
> DT binding similar to
> Documentation/devicetree/bindings/leds/leds-lm36*.txt
>=20
> LED maintainers, any opinions on this?

I believe it is too soon to remove the driver; even if new user will
have to add DT support, that is less work than starting from scratch.

I guess I'll just apply your patch to squelch the warnings.

Best regards,
									Pavel

--=20
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blo=
g.html

--6Vw0j8UKbyX0bfpA
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iF0EABECAB0WIQRPfPO7r0eAhk010v0w5/Bqldv68gUCXtj27AAKCRAw5/Bqldv6
8rdgAJ9MAJAO/I3UCldFlxGuyELWJijwGQCfe0ewM9qL+UT069hN0lTCCUW29vQ=
=WXqM
-----END PGP SIGNATURE-----

--6Vw0j8UKbyX0bfpA--
