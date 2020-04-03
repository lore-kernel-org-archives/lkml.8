Return-Path: <SRS0=4r1w=5T=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1CE8AC2BA19
	for <linux-kernel@archiver.kernel.org>; Fri,  3 Apr 2020 09:41:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E813121473
	for <linux-kernel@archiver.kernel.org>; Fri,  3 Apr 2020 09:41:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2403890AbgDCJl3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 3 Apr 2020 05:41:29 -0400
Received: from jabberwock.ucw.cz ([46.255.230.98]:58474 "EHLO
        jabberwock.ucw.cz" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2403809AbgDCJl1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 Apr 2020 05:41:27 -0400
Received: by jabberwock.ucw.cz (Postfix, from userid 1017)
        id AF6AF1C346D; Fri,  3 Apr 2020 11:41:25 +0200 (CEST)
Date:   Fri, 3 Apr 2020 11:41:10 +0200
From:   Pavel Machek <pavel@ucw.cz>
To:     kernel list <linux-kernel@vger.kernel.org>,
        jani.nikula@linux.intel.com, joonas.lahtinen@linux.intel.com,
        rodrigo.vivi@intel.com, intel-gfx@lists.freedesktop.org,
        airlied@redhat.com
Cc:     tglx@linutronix.de, mingo@redhat.com, bp@alien8.de, hpa@zytor.com
Subject: 5.7-rc0: regression caused by drm tree, hangs while attempting to
 run X
Message-ID: <20200403092634.GA3610@duo.ucw.cz>
References: <20200402213253.GA2691@duo.ucw.cz>
 <20200402213506.GA2767@duo.ucw.cz>
 <20200403073720.GA23229@duo.ucw.cz>
 <20200403091430.GA3845@duo.ucw.cz>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
        protocol="application/pgp-signature"; boundary="VS++wcV0S1rZb1Fb"
Content-Disposition: inline
In-Reply-To: <20200403091430.GA3845@duo.ucw.cz>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--VS++wcV0S1rZb1Fb
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi!

> > > > Hardware is thinkpad x220. I had this crash few days ago. And today=
 I
> > > > have similar-looking one, with slightly newer kernel. (Will post
> > > > as a follow-up).
> >=20
> > As part of quest for working system, I tried 5.7-rc0, based on
> >=20
> > Merge: 50a5de895dbe b4d8ddf8356d
> > Author: Linus Torvalds <torvalds@linux-foundation.org>
> > Date:   Wed Apr 1 18:18:18 2020 -0700
> >=20
> > It hangs in userspace, at a time when X should be starting, and I'm
> > looking at blinking cursor.
> >=20
> > 5.6-rcs worked, I'll test 5.6-final.
>=20
> 5.6-final works.
>=20
> Hmm...
>=20
> commit f365ab31efacb70bed1e821f7435626e0b2528a6
> Merge: 4646de87d325 59e7a8cc2dcf
> Author: Linus Torvalds <torvalds@linux-foundation.org>
> Date:   Wed Apr 1 15:24:20 2020 -0700
>=20
>     Merge tag 'drm-next-2020-04-01' of git://anongit.freedesktop.org/drm/=
drm
>=20
> Let me test 4646de87d32526ee87b46c2e0130413367fb5362...that one works.
>=20
> Ok, so obviously... I should
> test... f365ab31efacb70bed1e821f7435626e0b2528a6

f365ab31efacb70bed1e821f7435626e0b2528a6 is broken, and it is the
first broken merge. next-0403 is also broken.

Any ideas, besides the b-word?

Would c0ca be good commit for testing?=20

commit 700d6ab987f3b5e28b13b5993e5a9a975c5604e2
Merge: c0ca5437c509 2bdd4c28baff
Author: Dave Airlie <airlied@redhat.com>
Date:   Mon Mar 30 15:56:03 2020 +1000

    Merge tag 'drm-intel-next-fixes-2020-03-27' of git://anongit.freedeskto=
p.org
/drm/drm-intel into drm-next

Best regards,
									Pavel
--=20
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blo=
g.html

--VS++wcV0S1rZb1Fb
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iF0EABECAB0WIQRPfPO7r0eAhk010v0w5/Bqldv68gUCXocEtgAKCRAw5/Bqldv6
8jG5AJ0cQm8gqYJQh8MLB/fR5qx2O5lbMgCfd1NG0flmEpWzpcAJRTG8x3BJl4Q=
=fz/o
-----END PGP SIGNATURE-----

--VS++wcV0S1rZb1Fb--
