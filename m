Return-Path: <SRS0=8+oI=7O=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D683FC433E0
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Jun 2020 20:59:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B17EE20734
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Jun 2020 20:59:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728607AbgFAU7o (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 1 Jun 2020 16:59:44 -0400
Received: from jabberwock.ucw.cz ([46.255.230.98]:57366 "EHLO
        jabberwock.ucw.cz" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727096AbgFAU7n (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 Jun 2020 16:59:43 -0400
Received: by jabberwock.ucw.cz (Postfix, from userid 1017)
        id 802891C0BD2; Mon,  1 Jun 2020 22:59:41 +0200 (CEST)
Date:   Mon, 1 Jun 2020 22:59:39 +0200
From:   Pavel Machek <pavel@denx.de>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     linux-kernel@vger.kernel.org, stable@vger.kernel.org,
        Jamal Hadi Salim <jhs@mojatatu.com>,
        Roman Mashak <mrv@mojatatu.com>,
        "David S. Miller" <davem@davemloft.net>
Subject: Re: [PATCH 4.19 10/95] net sched: fix reporting the first-time use
 timestamp
Message-ID: <20200601205939.GB17898@amd>
References: <20200601174020.759151073@linuxfoundation.org>
 <20200601174022.499707903@linuxfoundation.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
        protocol="application/pgp-signature"; boundary="Fba/0zbH8Xs+Fj9o"
Content-Disposition: inline
In-Reply-To: <20200601174022.499707903@linuxfoundation.org>
User-Agent: Mutt/1.5.23 (2014-03-12)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--Fba/0zbH8Xs+Fj9o
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi!

On Mon 2020-06-01 19:53:10, Greg Kroah-Hartman wrote:
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
>=20
> Fixes: 48d8ee1694dd ("net sched actions: aggregate dumping of actions tim=
einfo")

Jiffies start at small negative value (and are expected to overflow
periodically). This code will not work correctly in that case.

Best regards,
                                                                Pavel
							=09

> +++ b/include/net/act_api.h
> @@ -67,7 +67,8 @@ static inline void tcf_tm_dump(struct tc
>  {
>  	dtm->install =3D jiffies_to_clock_t(jiffies - stm->install);
>  	dtm->lastuse =3D jiffies_to_clock_t(jiffies - stm->lastuse);
> -	dtm->firstuse =3D jiffies_to_clock_t(jiffies - stm->firstuse);
> +	dtm->firstuse =3D stm->firstuse ?
> +		jiffies_to_clock_t(jiffies - stm->firstuse) : 0;
>  	dtm->expires =3D jiffies_to_clock_t(stm->expires);
>  }
> =20
>=20

--=20
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blo=
g.html

--Fba/0zbH8Xs+Fj9o
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iEYEARECAAYFAl7VbDsACgkQMOfwapXb+vK84wCgrJBmQBgNFIvdOpFwrLDbK49o
hLIAn3ag43nkPnE978OqUI8dzfCFySWP
=PdzJ
-----END PGP SIGNATURE-----

--Fba/0zbH8Xs+Fj9o--
