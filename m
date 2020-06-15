Return-Path: <SRS0=PJcK=74=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3665AC433E0
	for <linux-kernel@archiver.kernel.org>; Mon, 15 Jun 2020 07:41:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1D7F12067B
	for <linux-kernel@archiver.kernel.org>; Mon, 15 Jun 2020 07:41:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728733AbgFOHkR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 15 Jun 2020 03:40:17 -0400
Received: from jabberwock.ucw.cz ([46.255.230.98]:39904 "EHLO
        jabberwock.ucw.cz" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728368AbgFOHjq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 Jun 2020 03:39:46 -0400
Received: by jabberwock.ucw.cz (Postfix, from userid 1017)
        id B09591C0BD2; Mon, 15 Jun 2020 09:39:44 +0200 (CEST)
Date:   Mon, 15 Jun 2020 09:39:44 +0200
From:   Pavel Machek <pavel@ucw.cz>
To:     Joe Perches <joe@perches.com>
Cc:     SeongJae Park <sjpark@amazon.com>, Jiri Slaby <jslaby@suse.cz>,
        Michael Ellerman <mpe@ellerman.id.au>,
        akpm@linux-foundation.org, apw@canonical.com,
        SeongJae Park <sjpark@amazon.de>, colin.king@canonical.com,
        sj38.park@gmail.com, linux-kernel@vger.kernel.org
Subject: Re: Re: [PATCH v4 0/2] Recommend denylist/allowlist instead of
 blacklist/whitelist
Message-ID: <20200615073944.GA4722@duo.ucw.cz>
References: <20200615064631.18910-1-sjpark@amazon.com>
 <404b3a391bd73acfc29f65d14b1586905ee5103c.camel@perches.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
        protocol="application/pgp-signature"; boundary="C7zPtVaVf+AK4Oqc"
Content-Disposition: inline
In-Reply-To: <404b3a391bd73acfc29f65d14b1586905ee5103c.camel@perches.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--C7zPtVaVf+AK4Oqc
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon 2020-06-15 00:00:56, Joe Perches wrote:
> On Mon, 2020-06-15 at 08:46 +0200, SeongJae Park wrote:
> > So, I agree this patch is imperfect for many cases, but better than not=
hing.
>=20
> Not necessarily.
>=20
> Having people strain for unusual equivalents
> to generally well known terms is not good.

Exactly. Plus consistency is good, and having same structure named
blacklist here and naughtyhardwarelist there does not really help.

									Pavel

--=20
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blo=
g.html

--C7zPtVaVf+AK4Oqc
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iF0EABECAB0WIQRPfPO7r0eAhk010v0w5/Bqldv68gUCXuclwAAKCRAw5/Bqldv6
8mwjAKCxz83O9Fbn3AfKav7TPptEE09rbQCguYMIw7nRSfD8Qc1U4L8iVz9n7gw=
=yLwv
-----END PGP SIGNATURE-----

--C7zPtVaVf+AK4Oqc--
