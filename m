Return-Path: <SRS0=AM+j=AE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 049E0C433E0
	for <linux-kernel@archiver.kernel.org>; Tue, 23 Jun 2020 19:55:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id DE0082080C
	for <linux-kernel@archiver.kernel.org>; Tue, 23 Jun 2020 19:55:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387485AbgFWTzW (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 23 Jun 2020 15:55:22 -0400
Received: from jabberwock.ucw.cz ([46.255.230.98]:43410 "EHLO
        jabberwock.ucw.cz" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1733305AbgFWTzW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 Jun 2020 15:55:22 -0400
Received: by jabberwock.ucw.cz (Postfix, from userid 1017)
        id AB9541C0C0A; Tue, 23 Jun 2020 21:55:20 +0200 (CEST)
Date:   Tue, 23 Jun 2020 21:55:20 +0200
From:   Pavel Machek <pavel@ucw.cz>
To:     Kars Mulder <kerneldev@karsmulder.nl>
Cc:     linux-kernel@vger.kernel.org
Subject: Re: Writing to a const pointer: is this supposed to happen?
Message-ID: <20200623195520.GA24965@duo.ucw.cz>
References: <3986-5ef09780-43-189d6180@550955>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
        protocol="application/pgp-signature"; boundary="NzB8fVQJ5HfG6fxh"
Content-Disposition: inline
In-Reply-To: <3986-5ef09780-43-189d6180@550955>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--NzB8fVQJ5HfG6fxh
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon 2020-06-22 13:35:35, Kars Mulder wrote:
> In the file drivers/usb/core/quirks.c, I noticed a couple of odd things a=
bout the function "quirks_param_set", and I'd like to check whether those a=
re ok according to the kernel programming practices. Here are the relevant =
lines from the function (several lines omitted):
>=20
> 	static int quirks_param_set(const char *val, const struct kernel_param *=
kp) {
> 		char *p, *field;
> 		for (i =3D 0, p =3D (char *)val; p && *p;) {
> 			field =3D strsep(&p, ":");
> 			if (!field)
> 				break;
>=20
> In here a const pointer *val is cast into a non-const pointer and then wr=
itten to by the function strsep, which replaces the first occurrence of the=
 ':' token by a null-byte. Is this allowed?
>=20

Odd, indeed... but not likely to cause immediate problems.

You may want to cc relevant maintainers, or even run git
blame and contact author.

You may also want to wrap your lines at 72 characters or so.

Best regards,
							Pavel

--=20
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blo=
g.html

--NzB8fVQJ5HfG6fxh
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iF0EABECAB0WIQRPfPO7r0eAhk010v0w5/Bqldv68gUCXvJeKAAKCRAw5/Bqldv6
8iMKAKC+zLR8m7hHRmzYWbm+fTGkfuFuMwCeNZZv9sae9gdftIcObnEdY1RREXE=
=exSj
-----END PGP SIGNATURE-----

--NzB8fVQJ5HfG6fxh--
