Return-Path: <SRS0=AKQz=7N=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 21476C433E0
	for <linux-kernel@archiver.kernel.org>; Sun, 31 May 2020 21:19:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id F21AD2067B
	for <linux-kernel@archiver.kernel.org>; Sun, 31 May 2020 21:19:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728431AbgEaVT2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 31 May 2020 17:19:28 -0400
Received: from jabberwock.ucw.cz ([46.255.230.98]:47872 "EHLO
        jabberwock.ucw.cz" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727000AbgEaVT1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 31 May 2020 17:19:27 -0400
Received: by jabberwock.ucw.cz (Postfix, from userid 1017)
        id 92FB31C0BD2; Sun, 31 May 2020 23:19:25 +0200 (CEST)
Date:   Sun, 31 May 2020 23:19:25 +0200
From:   Pavel Machek <pavel@ucw.cz>
To:     Sasha Levin <sashal@kernel.org>
Cc:     linux-kernel@vger.kernel.org, stable@vger.kernel.org,
        Roman Mashak <mrv@mojatatu.com>,
        Jamal Hadi Salim <jhs@mojatatu.com>,
        "David S . Miller" <davem@davemloft.net>, netdev@vger.kernel.org
Subject: Re: [PATCH AUTOSEL 5.4 07/26] net sched: fix reporting the
 first-time use timestamp
Message-ID: <20200531211924.GA8465@amd>
References: <20200528115654.1406165-1-sashal@kernel.org>
 <20200528115654.1406165-7-sashal@kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
        protocol="application/pgp-signature"; boundary="ZPt4rx8FFjLCG7dd"
Content-Disposition: inline
In-Reply-To: <20200528115654.1406165-7-sashal@kernel.org>
User-Agent: Mutt/1.5.23 (2014-03-12)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--ZPt4rx8FFjLCG7dd
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi!

> From: Roman Mashak <mrv@mojatatu.com>
>=20
> [ Upstream commit b15e62631c5f19fea9895f7632dae9c1b27fe0cd ]
>=20
> When a new action is installed, firstuse field of 'tcf_t' is explicitly s=
et
> to 0. Value of zero means "new action, not yet used"; as a packet hits the
> action, 'firstuse' is stamped with the current jiffies value.
>=20
> tcf_tm_dump() should return 0 for firstuse if action has not yet been hit.

> @@ -69,7 +69,8 @@ static inline void tcf_tm_dump(struct tcf_t *dtm, const=
 struct tcf_t *stm)
>  {
>  	dtm->install =3D jiffies_to_clock_t(jiffies - stm->install);
>  	dtm->lastuse =3D jiffies_to_clock_t(jiffies - stm->lastuse);
> -	dtm->firstuse =3D jiffies_to_clock_t(jiffies - stm->firstuse);
> +	dtm->firstuse =3D stm->firstuse ?
> +		jiffies_to_clock_t(jiffies - stm->firstuse) : 0;
>  	dtm->expires =3D jiffies_to_clock_t(stm->expires);
>  }

Jiffies start at small negative value (and are expected to overflow
periodically). This code will not work correctly in that case.

Best regards,
								Pavel
--=20
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blo=
g.html

--ZPt4rx8FFjLCG7dd
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iEYEARECAAYFAl7UH1wACgkQMOfwapXb+vI93wCgjZlcrAajKvQ5DpwHYOZlOW73
EpoAniT4tYyzOe0eQg6pBr3aldaQhB/y
=MHlS
-----END PGP SIGNATURE-----

--ZPt4rx8FFjLCG7dd--
