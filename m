Return-Path: <SRS0=Vo5z=36=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2B0BCC35254
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Feb 2020 18:58:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 04B7C208C4
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Feb 2020 18:58:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727716AbgBJS61 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 10 Feb 2020 13:58:27 -0500
Received: from jabberwock.ucw.cz ([46.255.230.98]:50192 "EHLO
        jabberwock.ucw.cz" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727079AbgBJS6Z (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Feb 2020 13:58:25 -0500
Received: by jabberwock.ucw.cz (Postfix, from userid 1017)
        id 0D4AF1C259A; Mon, 10 Feb 2020 19:58:24 +0100 (CET)
Date:   Mon, 10 Feb 2020 19:58:23 +0100
From:   Pavel Machek <pavel@ucw.cz>
To:     Masahiro Yamada <masahiroy@kernel.org>
Cc:     linux-kbuild@vger.kernel.org, youling257 <youling257@gmail.com>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] scripts/kallsyms: fix memory corruption caused by write
 over-run
Message-ID: <20200210185822.GA420@amd>
References: <20200210161852.842-1-masahiroy@kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
        protocol="application/pgp-signature"; boundary="k1lZvvs/B4yU6o8G"
Content-Disposition: inline
In-Reply-To: <20200210161852.842-1-masahiroy@kernel.org>
User-Agent: Mutt/1.5.23 (2014-03-12)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--k1lZvvs/B4yU6o8G
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue 2020-02-11 01:18:52, Masahiro Yamada wrote:
> scripts/kallsyms crashes because memcpy() writes one more byte than
> allocated.
>=20
> Fixes: 8d60526999aa ("scripts/kallsyms: change table to store (strcut sym=
_entry *)")
> Reported-by: youling257 <youling257@gmail.com>
> Reported-by: Pavel Machek <pavel@ucw.cz>
> Signed-off-by: Masahiro Yamada <masahiroy@kernel.org>


Tested-by: Pavel Machek <pavel@ucw.cz>

Thanks!
								Pavel
							=09
--=20
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blo=
g.html

--k1lZvvs/B4yU6o8G
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iEYEARECAAYFAl5Bp84ACgkQMOfwapXb+vIjYQCfedtM2eZCZ29z9ojkk2B0W2ML
1xcAoKkKc3GstwIw7jiXhejvrEAuVRQe
=ZKh/
-----END PGP SIGNATURE-----

--k1lZvvs/B4yU6o8G--
