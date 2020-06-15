Return-Path: <SRS0=PJcK=74=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 42AE4C433DF
	for <linux-kernel@archiver.kernel.org>; Mon, 15 Jun 2020 06:12:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 150E4206E2
	for <linux-kernel@archiver.kernel.org>; Mon, 15 Jun 2020 06:12:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728323AbgFOGMK (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 15 Jun 2020 02:12:10 -0400
Received: from jabberwock.ucw.cz ([46.255.230.98]:56664 "EHLO
        jabberwock.ucw.cz" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728163AbgFOGMK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 Jun 2020 02:12:10 -0400
Received: by jabberwock.ucw.cz (Postfix, from userid 1017)
        id 863431C0BD2; Mon, 15 Jun 2020 08:12:08 +0200 (CEST)
Date:   Mon, 15 Jun 2020 08:12:08 +0200
From:   Pavel Machek <pavel@ucw.cz>
To:     Jiri Slaby <jslaby@suse.cz>
Cc:     Michael Ellerman <mpe@ellerman.id.au>,
        SeongJae Park <sjpark@amazon.com>,
        Joe Perches <joe@perches.com>, akpm@linux-foundation.org,
        apw@canonical.com, SeongJae Park <sjpark@amazon.de>,
        colin.king@canonical.com, sj38.park@gmail.com,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v4 0/2] Recommend denylist/allowlist instead of
 blacklist/whitelist
Message-ID: <20200615061208.GA31489@amd>
References: <20200611073804.10225-1-sjpark@amazon.com>
 <38ac91ab-ced3-8a4f-b825-4503fdcddeb8@suse.cz>
 <877dwcfitg.fsf@mpe.ellerman.id.au>
 <20200614212911.GB24529@amd>
 <19ac7f0d-613f-9c8c-8045-e785155fd2e4@suse.cz>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
        protocol="application/pgp-signature"; boundary="HlL+5n6rz5pIUxbD"
Content-Disposition: inline
In-Reply-To: <19ac7f0d-613f-9c8c-8045-e785155fd2e4@suse.cz>
User-Agent: Mutt/1.5.23 (2014-03-12)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--HlL+5n6rz5pIUxbD
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon 2020-06-15 06:21:43, Jiri Slaby wrote:
> On 14. 06. 20, 23:29, Pavel Machek wrote:

> >> It's not like blacklist / whitelist are even good to begin with, it's
> >> not obvious which is which, you have to learn that black is bad and
> >> white is good.
> >>
> >> Blocklist (or denylist?) and allowlist are actually more descriptive a=
nd
> >> less likely to cause confusion.
> >=20
> > You do not understand how word "blacklist" is used inside the kernel,
> > do you? Do a quick grep.
>=20
> And now, do the same for "blocklist".
>=20
> And is "denylist" a proper word? As grep gives zarro results...
>=20
> It's not that easy to find alternatives. OTOH, admittedly, "blacklist"
> is used improperly in some contexts. Some synonyms fit better.

Well, many of the uses is "list of hardware that needs particular
workaround" or "list of hardware that is broken in some
way"... Neither 'blocklist' nor 'denylist' fit that usage.

Best regards,
							Pavel
--=20
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blo=
g.html

--HlL+5n6rz5pIUxbD
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iEYEARECAAYFAl7nETgACgkQMOfwapXb+vLAFQCfaV+RvcVMWAndDcGFxqr3rLup
STcAn0J4kZos/bvffljlxvc2aHLwdzy3
=1ptF
-----END PGP SIGNATURE-----

--HlL+5n6rz5pIUxbD--
