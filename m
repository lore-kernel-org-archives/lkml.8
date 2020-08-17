Return-Path: <SRS0=ysYr=B3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.2 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3DCA5C433DF
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Aug 2020 20:42:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 06E1020674
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Aug 2020 20:42:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726819AbgHQUm0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 17 Aug 2020 16:42:26 -0400
Received: from jabberwock.ucw.cz ([46.255.230.98]:41060 "EHLO
        jabberwock.ucw.cz" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726366AbgHQUm0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Aug 2020 16:42:26 -0400
Received: by jabberwock.ucw.cz (Postfix, from userid 1017)
        id 72D761C0BB8; Mon, 17 Aug 2020 22:42:24 +0200 (CEST)
Date:   Mon, 17 Aug 2020 22:42:24 +0200
From:   Pavel Machek <pavel@ucw.cz>
To:     Al Viro <viro@zeniv.linux.org.uk>
Cc:     Michael Witten <mfwitten@gmail.com>,
        Masahiro Yamada <masahiroy@kernel.org>,
        Michal Marek <michal.lkml@markovi.net>,
        Cong Wang <xiyou.wangcong@gmail.com>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Sam Ravnborg <sam@ravnborg.org>, linux-kernel@vger.kernel.org,
        linux-kbuild@vger.kernel.org
Subject: Re: [PATCH] Makefile: Yes. Finally remove
 '-Wdeclaration-after-statement'
Message-ID: <20200817204223.GB12414@amd>
References: <c6fda26e8d134264b04fadc3386d6c32@gmail.com>
 <20200816175303.GB1236603@ZenIV.linux.org.uk>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
        protocol="application/pgp-signature"; boundary="7ZAtKRhVyVSsbBD2"
Content-Disposition: inline
In-Reply-To: <20200816175303.GB1236603@ZenIV.linux.org.uk>
User-Agent: Mutt/1.5.23 (2014-03-12)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--7ZAtKRhVyVSsbBD2
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi!

> > This is not just a matter of style; this is a matter of semantics,
> > especially with regard to:
> >=20
> >   * const Correctness.
> >     A const-declared variable must be initialized when defined.
> >=20
> >   * Conditional Compilation.
> >     When there is complex interaction between compile-time
> >     configuration options, it's essential to be able to
> >     make declarations where needed; otherwise unnecessary
> >     gymnastics are required to silence the compiler.
> >=20
> > Gentleman... Just let people say exactly what they mean to say.
=2E.

> You obviously need every bit of help in that task, judging by the amount
> of clarity (or thoughts, for that matter) visible in the spew above...
>=20
> NAK.  And as for letting people say exactly what they mean to say...
> I am tempted to take you on that invitation, but that would be cruel
> to gregkh - he would have to reply to inevitable screeds about
> CoC-violating postings on l-k.

We should really get rid of CoC, because I'd really like to see you
_not_ resist that temptation.

But... he's right.

With rust-like programming style with widespread consts, this warning
has to go. And it is causing additional/ugly #ifdefs in some cases.

Maybe author can show examples in kernel .c where disabling the
warning would lead to nicer code. I believe we should give it a try.

									Pavel
--=20
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blo=
g.html

--7ZAtKRhVyVSsbBD2
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iEYEARECAAYFAl86668ACgkQMOfwapXb+vKdLgCeM7I9T+gZhlBf4I1nSkvcW2MI
8ZgAnikWeuZvOEK0jwROd5gNOu0CroIp
=DRKP
-----END PGP SIGNATURE-----

--7ZAtKRhVyVSsbBD2--
