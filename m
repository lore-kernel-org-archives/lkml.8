Return-Path: <SRS0=1210=4J=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 42534C35653
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Feb 2020 10:51:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 23D3D2073A
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Feb 2020 10:51:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727239AbgBUKvH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 21 Feb 2020 05:51:07 -0500
Received: from jabberwock.ucw.cz ([46.255.230.98]:52580 "EHLO
        jabberwock.ucw.cz" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726100AbgBUKvG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Feb 2020 05:51:06 -0500
Received: by jabberwock.ucw.cz (Postfix, from userid 1017)
        id E277C1C013E; Fri, 21 Feb 2020 11:51:04 +0100 (CET)
Date:   Fri, 21 Feb 2020 11:51:04 +0100
From:   Pavel Machek <pavel@denx.de>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     linux-kernel@vger.kernel.org, stable@vger.kernel.org,
        Dan Carpenter <dan.carpenter@oracle.com>,
        "J. Bruce Fields" <bfields@redhat.com>,
        Sasha Levin <sashal@kernel.org>
Subject: Re: [PATCH 4.19 011/191] nfsd4: avoid NULL deference on strange COPY
 compounds
Message-ID: <20200221105104.GB14608@duo.ucw.cz>
References: <20200221072250.732482588@linuxfoundation.org>
 <20200221072252.497508893@linuxfoundation.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
        protocol="application/pgp-signature"; boundary="WYTEVAkct0FjGQmd"
Content-Disposition: inline
In-Reply-To: <20200221072252.497508893@linuxfoundation.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--WYTEVAkct0FjGQmd
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi!

> With cross-server COPY we've introduced the possibility that the current
> or saved filehandle might not have fh_dentry/fh_export filled in, but we
> missed a place that assumed it was.  I think this could be triggered by
> a compound like:
>=20
> 	PUTFH(foreign filehandle)
> 	GETATTR
> 	SAVEFH
> 	COPY
>=20
> First, check_if_stalefh_allowed sets no_verify on the first (PUTFH) op.
> Then op_func =3D nfsd4_putfh runs and leaves current_fh->fh_export NULL.
> need_wrongsec_check returns true, since this PUTFH has OP_IS_PUTFH_LIKE
> set and GETATTR does not have OP_HANDLES_WRONGSEC set.
>=20
> We should probably also consider tightening the checks in
> check_if_stalefh_allowed and double-checking that we don't assume the
> filehandle is verified elsewhere in the compound.  But I think this
> fixes the immediate issue.
>=20
> Reported-by: Dan Carpenter <dan.carpenter@oracle.com>
> Fixes: 4e48f1cccab3 "NFSD: allow inter server COPY to have... "

AFAICT 4e48f1cccab3 "NFSD: allow inter server COPY to have... " is not
part of 4.19 series, so this should not be needed in 4.19.

Best regards,

									Pavel
--=20
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blo=
g.html

--WYTEVAkct0FjGQmd
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iF0EABECAB0WIQRPfPO7r0eAhk010v0w5/Bqldv68gUCXk+2GAAKCRAw5/Bqldv6
8hswAJ0R1GPV/moKaqjD73lr/urr6ZXnWQCdG+RLCYLWVzmMmmeSURqgOVOgM7U=
=V2KQ
-----END PGP SIGNATURE-----

--WYTEVAkct0FjGQmd--
