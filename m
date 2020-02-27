Return-Path: <SRS0=BMk7=4P=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_2
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9C9D8C3F2C2
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Feb 2020 23:17:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 78EDF246A4
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Feb 2020 23:17:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729960AbgB0XRG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 27 Feb 2020 18:17:06 -0500
Received: from 17.mo5.mail-out.ovh.net ([46.105.56.132]:46086 "EHLO
        17.mo5.mail-out.ovh.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729656AbgB0XRG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Feb 2020 18:17:06 -0500
Received: from player789.ha.ovh.net (unknown [10.110.115.188])
        by mo5.mail-out.ovh.net (Postfix) with ESMTP id A72E9270979
        for <linux-kernel@vger.kernel.org>; Thu, 27 Feb 2020 22:59:06 +0100 (CET)
Received: from sk2.org (37-164-65-132.coucou-networks.fr [37.164.65.132])
        (Authenticated sender: steve@sk2.org)
        by player789.ha.ovh.net (Postfix) with ESMTPSA id CCCB8FE2C9FC;
        Thu, 27 Feb 2020 21:58:59 +0000 (UTC)
Date:   Thu, 27 Feb 2020 22:58:57 +0100
From:   Stephen Kitt <steve@sk2.org>
To:     Jonathan Corbet <corbet@lwn.net>
Cc:     Mauro Carvalho Chehab <mchehab+samsung@kernel.org>,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3] docs: add a script to check sysctl docs
Message-ID: <20200227225857.2339e365@heffalump.sk2.org>
In-Reply-To: <20200225033710.312450f6@lwn.net>
References: <20200219153442.10205-1-steve@sk2.org>
        <20200225033710.312450f6@lwn.net>
X-Mailer: Claws Mail 3.17.3 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 boundary="Sig_/iabzgcEpPE08BniDcQO5cOd"; protocol="application/pgp-signature"
X-Ovh-Tracer-Id: 4299248798125149573
X-VR-SPAMSTATE: OK
X-VR-SPAMSCORE: -100
X-VR-SPAMCAUSE: gggruggvucftvghtrhhoucdtuddrgedugedrleeigdduheegucetufdoteggodetrfdotffvucfrrhhofhhilhgvmecuqfggjfdpvefjgfevmfevgfenuceurghilhhouhhtmecuhedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujfgurhepfffhvffukfgjfhfogggtsehgtderreertdejnecuhfhrohhmpefuthgvphhhvghnucfmihhtthcuoehsthgvvhgvsehskhdvrdhorhhgqeenucfkpheptddrtddrtddrtddpfeejrdduieegrdeihedrudefvdenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhhouggvpehsmhhtphdqohhuthdphhgvlhhopehplhgrhigvrhejkeelrdhhrgdrohhvhhdrnhgvthdpihhnvghtpedtrddtrddtrddtpdhmrghilhhfrhhomhepshhtvghvvgesshhkvddrohhrghdprhgtphhtthhopehlihhnuhigqdhkvghrnhgvlhesvhhgvghrrdhkvghrnhgvlhdrohhrgh
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/iabzgcEpPE08BniDcQO5cOd
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On Tue, 25 Feb 2020 03:37:10 -0700, Jonathan Corbet <corbet@lwn.net> wrote:

> On Wed, 19 Feb 2020 16:34:42 +0100
> Stephen Kitt <steve@sk2.org> wrote:
>=20
> > This script allows sysctl documentation to be checked against the
> > kernel source code, to identify missing or obsolete entries. Running
> > it against 5.5 shows for example that sysctl/kernel.rst has two
> > obsolete entries and is missing 52 entries.
> >=20
> > Signed-off-by: Stephen Kitt <steve@sk2.org>
> > ---
> > Changes since v2:
> > * drop UTF-8 characters
> > * fix license identifier
> > * fix example invocation to include path as well as table
> >=20
> > v2 was the initial submission (in v2 of the sysctl/kernel.rst patch
> > set). =20
>=20
> This seems like a useful thing to have, so I've applied it.  It would be
> rather more useful, though, with a bit of ... wait for it ...
> documentation.  Even just an example command line in the header comments
> would be a good place to start.  Care to send a followup? :)

The committed script has this:

+# Example invocation:
+#	scripts/check-sysctl-docs -vtable=3D"kernel" \
+#		Documentation/admin-guide/sysctl/kernel.rst \
+#		$(git grep -l register_sysctl_)
+#
+# Specify -vdebug=3D1 to see debugging information

but I agree that it needs more documentation ;-). In particular, I need to
explain what the script expects in terms of document layout...

Where would be the best place? In admin-guide/sysctl/index.rst, as a =E2=80=
=9Chow to
maintain these files=E2=80=9D section, or in a separate document, or in the=
 script
headers?

Regards,

Stephen

--Sig_/iabzgcEpPE08BniDcQO5cOd
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCgAdFiEEnPVX/hPLkMoq7x0ggNMC9Yhtg5wFAl5YO6EACgkQgNMC9Yht
g5zFMw//T2PrZ+7J7+bTixO0z9YWeVi3Gnw7mAmtku0aQIZBGmuwnEn6xmF5E2fQ
AGNXCyi04TgHQ7LqjYEcO2v6PM3pLXC5iaJnMOQ1xcls2lPd+BQtHcs/bP6lMwuC
GX745J5Bi7R9iLqbEmU/UMYc7wUW6ZqZpfqWXxUpyOuTlQ7sw98cbi3ud/NqhH/t
UsAQ8sVg7wfuksXMRZgU0RKHyJTHJ53Snvj3N79FRZbwqHyyFnfGNTtLC+/IdsNs
zl+qOVZ7bDq53PSuTC+Rlht491ZhFhA1t2s7R3iE1bPhSJX2d8xoXZNhM8BYART2
su4Ur7GVGxInKoSHi9gttD63fqBWZH/TOZLsUnsBvV3BAXSv6HNXxJeuqTmRZl5I
a6N6ozk6jjGh1dP/v863rG0n7J4Q6ggpkiSf0zFh2ertHvQBOlJNGnOmB9qiMxNx
sktNIMerSh49dojPnXng4Tm0t6pO3dQp+YNNXd71wzr2Vt9vpU16RN7aTXI2/z8J
nOL4q61dXkMHc3K9lU7TjeNyczICHkwbdjsarOPZHDDdXtaf2l+KApSnhtDzGLMh
j4N0LvakNJybShCiLciQfhNjGs0CGWkljUyfQs7IS94pnZW8SCUVrby9RG0aMbdD
2SzIAvZhkSAdHMz1lYxZ0a4IOYZshqeGxpec7qjY+JBsYdDuknw=
=ebj0
-----END PGP SIGNATURE-----

--Sig_/iabzgcEpPE08BniDcQO5cOd--
