Return-Path: <SRS0=fzvl=3P=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C6D56C35246
	for <linux-kernel@archiver.kernel.org>; Sun, 26 Jan 2020 17:15:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9E35520702
	for <linux-kernel@archiver.kernel.org>; Sun, 26 Jan 2020 17:15:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727250AbgAZRPI (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 26 Jan 2020 12:15:08 -0500
Received: from jabberwock.ucw.cz ([46.255.230.98]:45202 "EHLO
        jabberwock.ucw.cz" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725944AbgAZRPI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 26 Jan 2020 12:15:08 -0500
Received: by jabberwock.ucw.cz (Postfix, from userid 1017)
        id 46C341C036D; Sun, 26 Jan 2020 18:15:06 +0100 (CET)
Date:   Sun, 26 Jan 2020 18:15:05 +0100
From:   Pavel Machek <pavel@denx.de>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     linux-kernel@vger.kernel.org, stable@vger.kernel.org,
        Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <jakub.kicinski@netronome.com>,
        Sasha Levin <sashal@kernel.org>
Subject: Re: [PATCH 4.19 599/639] net: avoid possible false sharing in
 sk_leave_memory_pressure()
Message-ID: <20200126171505.GD19082@duo.ucw.cz>
References: <20200124093047.008739095@linuxfoundation.org>
 <20200124093204.391643194@linuxfoundation.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
        protocol="application/pgp-signature"; boundary="XvKFcGCOAo53UbWW"
Content-Disposition: inline
In-Reply-To: <20200124093204.391643194@linuxfoundation.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--XvKFcGCOAo53UbWW
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri 2020-01-24 10:32:49, Greg Kroah-Hartman wrote:
> From: Eric Dumazet <edumazet@google.com>
>=20
> [ Upstream commit 503978aca46124cd714703e180b9c8292ba50ba7 ]
>=20
> As mentioned in https://github.com/google/ktsan/wiki/READ_ONCE-and-WRITE_=
ONCE#it-may-improve-performance
> a C compiler can legally transform :
>=20
> if (memory_pressure && *memory_pressure)
>         *memory_pressure =3D 0;
>=20
> to :
>=20
> if (memory_pressure)
>         *memory_pressure =3D 0;

Well, C compiler can do a lot of stuff, and we rely on C compiler
being "sane" -- that is gcc.

Even if compiler did the transformation, that will only result in
slightly slower performance, right?

Is there any evidence this is problem in practice? Should this be in
stable?

Best regards,
								Pavel


> +++ b/net/core/sock.c
> @@ -2179,8 +2179,8 @@ static void sk_leave_memory_pressure(struct sock *s=
k)
>  	} else {
>  		unsigned long *memory_pressure =3D sk->sk_prot->memory_pressure;
> =20
> -		if (memory_pressure && *memory_pressure)
> -			*memory_pressure =3D 0;
> +		if (memory_pressure && READ_ONCE(*memory_pressure))
> +			WRITE_ONCE(*memory_pressure, 0);
>  	}
>  }



--=20
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blo=
g.html

--XvKFcGCOAo53UbWW
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iF0EABECAB0WIQRPfPO7r0eAhk010v0w5/Bqldv68gUCXi3JGQAKCRAw5/Bqldv6
8tXqAJ9xRik6QC4lKIxZJnGR9pEUzJKgpwCgt5fiRlxg/KfBmn58c/mwksuZ8Ms=
=ep4Y
-----END PGP SIGNATURE-----

--XvKFcGCOAo53UbWW--
