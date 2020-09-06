Return-Path: <SRS0=pQss=CP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ED947C43461
	for <linux-kernel@archiver.kernel.org>; Sun,  6 Sep 2020 18:38:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B955B20759
	for <linux-kernel@archiver.kernel.org>; Sun,  6 Sep 2020 18:38:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729161AbgIFSiY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 6 Sep 2020 14:38:24 -0400
Received: from jabberwock.ucw.cz ([46.255.230.98]:44526 "EHLO
        jabberwock.ucw.cz" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728969AbgIFSiX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 6 Sep 2020 14:38:23 -0400
Received: by jabberwock.ucw.cz (Postfix, from userid 1017)
        id 04CAC1C0B7C; Sun,  6 Sep 2020 20:38:21 +0200 (CEST)
Date:   Sun, 6 Sep 2020 20:38:20 +0200
From:   Pavel Machek <pavel@denx.de>
To:     Christophe Leroy <christophe.leroy@csgroup.eu>
Cc:     Pavel Machek <pavel@denx.de>,
        David Laight <David.Laight@ACULAB.COM>,
        Christoph Hellwig <hch@lst.de>,
        "arnd@arndb.de" <arnd@arndb.de>,
        "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] /dev/zero: also implement ->read
Message-ID: <20200906183820.GA13290@amd>
References: <20200903155922.1111551-1-hch@lst.de>
 <55d1ecb8-4a0c-fa58-d3cf-bf6796eea7bd@csgroup.eu>
 <3b0b58be4b844162b73db1b108a9b995@AcuMS.aculab.com>
 <20200906182122.GA12295@amd>
 <8c353864-76a9-90bf-fa2f-f7a8231b5487@csgroup.eu>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
        protocol="application/pgp-signature"; boundary="jI8keyz6grp/JLjh"
Content-Disposition: inline
In-Reply-To: <8c353864-76a9-90bf-fa2f-f7a8231b5487@csgroup.eu>
User-Agent: Mutt/1.5.23 (2014-03-12)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--jI8keyz6grp/JLjh
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sun 2020-09-06 20:35:38, Christophe Leroy wrote:
> Hi,
>=20
> Le 06/09/2020 =E0 20:21, Pavel Machek a =E9crit=A0:
> >Hi!
> >
> >>>>Christophe reported a major speedup due to avoiding the iov_iter
> >>>>overhead, so just add this trivial function.  Note that /dev/zero
> >>>>already implements both an iter and non-iter writes so this just
> >>>>makes it more symmetric.
> >>>>
> >>>>Christophe Leroy <christophe.leroy@csgroup.eu>
> >>>>Signed-off-by: Christoph Hellwig <hch@lst.de>
> >>>
> >>>Tested-by: Christophe Leroy <christophe.leroy@csgroup.eu>
> >>
> >>Any idea what has happened to make the 'iter' version so bad?
> >
> >Exactly. Also it would be nice to note how the speedup was measured
> >and what the speedup is.
> >
>=20
> Was measured on an 8xx powerpc running at 132MHz with:
>=20
> 	dd if=3D/dev/zero of=3D/dev/null count=3D1M
>=20
> With the patch, dd displays a throughput of 113.5MB/s
> Without the patch it is 99.9MB/s

Actually... that does not seem like a huge deal. read(/dev/zero) is
not that common operation.

Are you getting similar speedups on normal hardware?

								Pavel
--=20
DENX Software Engineering GmbH,      Managing Director: Wolfgang Denk
HRB 165235 Munich, Office: Kirchenstr.5, D-82194 Groebenzell, Germany

--jI8keyz6grp/JLjh
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iEYEARECAAYFAl9VLJwACgkQMOfwapXb+vKmrgCdEYmZPgQq+HxpSanlG4HVseFn
dbsAnRdejmbhYyMrT06l1+feAucNtasq
=XH8y
-----END PGP SIGNATURE-----

--jI8keyz6grp/JLjh--
