Return-Path: <SRS0=Atmy=73=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E4A47C433E0
	for <linux-kernel@archiver.kernel.org>; Sun, 14 Jun 2020 21:15:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C9405206D7
	for <linux-kernel@archiver.kernel.org>; Sun, 14 Jun 2020 21:15:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727894AbgFNVPW (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 14 Jun 2020 17:15:22 -0400
Received: from jabberwock.ucw.cz ([46.255.230.98]:46786 "EHLO
        jabberwock.ucw.cz" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726896AbgFNVPW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 14 Jun 2020 17:15:22 -0400
Received: by jabberwock.ucw.cz (Postfix, from userid 1017)
        id 6752F1C0BD2; Sun, 14 Jun 2020 23:15:20 +0200 (CEST)
Date:   Sun, 14 Jun 2020 23:15:19 +0200
From:   Pavel Machek <pavel@ucw.cz>
To:     SeongJae Park <sjpark@amazon.com>
Cc:     akpm@linux-foundation.org, apw@canonical.com, joe@perches.com,
        colin.king@canonical.com, sj38.park@gmail.com,
        linux-kernel@vger.kernel.org, SeongJae Park <sjpark@amazon.de>
Subject: Re: [PATCH v3 0/2] Recommend blocklist/allowlist instead of
 blacklist/whitelist
Message-ID: <20200614211519.GA24529@amd>
References: <20200610065223.29894-1-sjpark@amazon.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
        protocol="application/pgp-signature"; boundary="3V7upXqbjpZ4EhLz"
Content-Disposition: inline
In-Reply-To: <20200610065223.29894-1-sjpark@amazon.com>
User-Agent: Mutt/1.5.23 (2014-03-12)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--3V7upXqbjpZ4EhLz
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed 2020-06-10 08:52:21, SeongJae Park wrote:
> From: SeongJae Park <sjpark@amazon.de>
>=20
> This patchset 1) adds support of deprecated terms in the 'checkpatch.pl'
> and 2) set the 'blacklist' and 'whitelist' as deprecated with
> replacement suggestion of 'blocklist' and 'allowlist', because the
> suggestions are incontrovertible, doesn't make people hurt, and more
> self-explanatory.

I don't think this is good idea.
									Pavel
--=20
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blo=
g.html

--3V7upXqbjpZ4EhLz
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iEYEARECAAYFAl7mk2cACgkQMOfwapXb+vLdagCeOR5JKISvWfny5Q5LH9Mf+/9D
bTUAn2juu4+GYlwTPt3BzAFFY/e08oeD
=APHk
-----END PGP SIGNATURE-----

--3V7upXqbjpZ4EhLz--
