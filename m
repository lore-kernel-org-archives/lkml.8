Return-Path: <SRS0=pQss=CP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CA21DC433E2
	for <linux-kernel@archiver.kernel.org>; Sun,  6 Sep 2020 18:21:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8F6A22078E
	for <linux-kernel@archiver.kernel.org>; Sun,  6 Sep 2020 18:21:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729140AbgIFSV1 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 6 Sep 2020 14:21:27 -0400
Received: from jabberwock.ucw.cz ([46.255.230.98]:43378 "EHLO
        jabberwock.ucw.cz" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728969AbgIFSV0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 6 Sep 2020 14:21:26 -0400
Received: by jabberwock.ucw.cz (Postfix, from userid 1017)
        id 7B16E1C0B7C; Sun,  6 Sep 2020 20:21:23 +0200 (CEST)
Date:   Sun, 6 Sep 2020 20:21:22 +0200
From:   Pavel Machek <pavel@denx.de>
To:     David Laight <David.Laight@ACULAB.COM>
Cc:     'Christophe Leroy' <christophe.leroy@csgroup.eu>,
        Christoph Hellwig <hch@lst.de>,
        "arnd@arndb.de" <arnd@arndb.de>,
        "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] /dev/zero: also implement ->read
Message-ID: <20200906182122.GA12295@amd>
References: <20200903155922.1111551-1-hch@lst.de>
 <55d1ecb8-4a0c-fa58-d3cf-bf6796eea7bd@csgroup.eu>
 <3b0b58be4b844162b73db1b108a9b995@AcuMS.aculab.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
        protocol="application/pgp-signature"; boundary="G4iJoqBmSsgzjUCe"
Content-Disposition: inline
In-Reply-To: <3b0b58be4b844162b73db1b108a9b995@AcuMS.aculab.com>
User-Agent: Mutt/1.5.23 (2014-03-12)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--G4iJoqBmSsgzjUCe
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi!

> > > Christophe reported a major speedup due to avoiding the iov_iter
> > > overhead, so just add this trivial function.  Note that /dev/zero
> > > already implements both an iter and non-iter writes so this just
> > > makes it more symmetric.
> > >
> > > Christophe Leroy <christophe.leroy@csgroup.eu>
> > > Signed-off-by: Christoph Hellwig <hch@lst.de>
> >=20
> > Tested-by: Christophe Leroy <christophe.leroy@csgroup.eu>
>=20
> Any idea what has happened to make the 'iter' version so bad?

Exactly. Also it would be nice to note how the speedup was measured
and what the speedup is.

Best regads,
								Pavel
--=20
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blo=
g.html

--G4iJoqBmSsgzjUCe
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iEYEARECAAYFAl9VKKIACgkQMOfwapXb+vKZlwCdFfFAEv0cdTUQKC8HL8e4o4qF
jgYAmwbYMoMEhknMT1mDu4MFPQbcO3/d
=vvM5
-----END PGP SIGNATURE-----

--G4iJoqBmSsgzjUCe--
