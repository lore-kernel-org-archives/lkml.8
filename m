Return-Path: <SRS0=5Khs=AX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2B746C433DF
	for <linux-kernel@archiver.kernel.org>; Sun, 12 Jul 2020 08:13:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 13F8D2070B
	for <linux-kernel@archiver.kernel.org>; Sun, 12 Jul 2020 08:13:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728428AbgGLINi (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 12 Jul 2020 04:13:38 -0400
Received: from jabberwock.ucw.cz ([46.255.230.98]:49698 "EHLO
        jabberwock.ucw.cz" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725974AbgGLINh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 12 Jul 2020 04:13:37 -0400
Received: by jabberwock.ucw.cz (Postfix, from userid 1017)
        id 229E41C0BDD; Sun, 12 Jul 2020 10:13:35 +0200 (CEST)
Date:   Sun, 12 Jul 2020 10:13:34 +0200
From:   Pavel Machek <pavel@ucw.cz>
To:     Jacek Anaszewski <jacek.anaszewski@gmail.com>
Cc:     Kai-Heng Feng <kai.heng.feng@canonical.com>,
        anthony.wong@canonical.com, Dan Murphy <dmurphy@ti.com>,
        "open list:LED SUBSYSTEM" <linux-leds@vger.kernel.org>,
        open list <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v2] leds: core: Flush scheduled work for system suspend
Message-ID: <20200712081334.GG8295@amd>
References: <20200702054500.11251-1-kai.heng.feng@canonical.com>
 <a5a931e5-771d-3356-89c2-b0e49f74161c@gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
        protocol="application/pgp-signature"; boundary="bO4vSxwwZtUjUWHo"
Content-Disposition: inline
In-Reply-To: <a5a931e5-771d-3356-89c2-b0e49f74161c@gmail.com>
User-Agent: Mutt/1.5.23 (2014-03-12)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--bO4vSxwwZtUjUWHo
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi!

> >  EXPORT_SYMBOL_GPL(led_classdev_suspend);
> >
>=20
> Acked-by: Jacek Anaszewski <jacek.anaszewski@gmail.com>
>=20
> Pavel, this needs to go to stable as well, so let's add the tag:
>=20
> Fixes: 81fe8e5b73e3 ("leds: core: Add led_set_brightness_nosleep{nopm}
> functions")

Applied, and I added the tag (thanks).

Documentation says stable is for "very bad" bugs, but ... stable
maintainers ignore documenation.

Best regards,
									Pavel
--=20
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blo=
g.html

--bO4vSxwwZtUjUWHo
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iEYEARECAAYFAl8Kxi4ACgkQMOfwapXb+vKyJwCggYNk+9VwnZivV5ib2hpZ19vH
HEEAnizCftZ9JV+k+qMVo0cR6amAGgm/
=zBnL
-----END PGP SIGNATURE-----

--bO4vSxwwZtUjUWHo--
