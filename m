Return-Path: <SRS0=5Khs=AX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 051C1C433E2
	for <linux-kernel@archiver.kernel.org>; Sun, 12 Jul 2020 08:05:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id DCE332070B
	for <linux-kernel@archiver.kernel.org>; Sun, 12 Jul 2020 08:05:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728525AbgGLIFp (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 12 Jul 2020 04:05:45 -0400
Received: from jabberwock.ucw.cz ([46.255.230.98]:49310 "EHLO
        jabberwock.ucw.cz" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725974AbgGLIFo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 12 Jul 2020 04:05:44 -0400
Received: by jabberwock.ucw.cz (Postfix, from userid 1017)
        id 6327E1C0BD2; Sun, 12 Jul 2020 10:05:42 +0200 (CEST)
Date:   Sun, 12 Jul 2020 10:05:41 +0200
From:   Pavel Machek <pavel@ucw.cz>
To:     Alexander Dahl <ada@thorsis.com>
Cc:     linux-leds@vger.kernel.org, Flavio Suligoi <f.suligoi@asem.it>,
        Jacek Anaszewski <jacek.anaszewski@gmail.com>,
        Dan Murphy <dmurphy@ti.com>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/1] leds: fix spelling mistake
Message-ID: <20200712080541.GE8295@amd>
References: <20200609154929.30248-1-f.suligoi@asem.it>
 <7016474.BTq5bZ2CBy@ada>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
        protocol="application/pgp-signature"; boundary="XuV1QlJbYrcVoo+x"
Content-Disposition: inline
In-Reply-To: <7016474.BTq5bZ2CBy@ada>
User-Agent: Mutt/1.5.23 (2014-03-12)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--XuV1QlJbYrcVoo+x
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed 2020-06-10 08:16:31, Alexander Dahl wrote:
> That one made me laugh. :-)
>=20
> Reviewed-by: Alexander Dahl <ada@thorsis.com>

:-).

Applied.
									Pavel
--=20
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blo=
g.html

--XuV1QlJbYrcVoo+x
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iEYEARECAAYFAl8KxFUACgkQMOfwapXb+vKhYACdF1mQ/YmrWK+el6jnMqLkhl2x
hzYAoJZ8Qx7bF8BCEykgbsWTYDdrcL7h
=jTE3
-----END PGP SIGNATURE-----

--XuV1QlJbYrcVoo+x--
