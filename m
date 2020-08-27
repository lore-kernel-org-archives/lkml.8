Return-Path: <SRS0=OCv1=CF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D5554C433DF
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Aug 2020 07:28:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B964A22BEA
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Aug 2020 07:28:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727903AbgH0H2k (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 27 Aug 2020 03:28:40 -0400
Received: from jabberwock.ucw.cz ([46.255.230.98]:56730 "EHLO
        jabberwock.ucw.cz" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726123AbgH0H2j (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Aug 2020 03:28:39 -0400
Received: by jabberwock.ucw.cz (Postfix, from userid 1017)
        id 7D88B1C0BDF; Thu, 27 Aug 2020 09:28:36 +0200 (CEST)
Date:   Thu, 27 Aug 2020 09:28:36 +0200
From:   Pavel Machek <pavel@ucw.cz>
To:     Harald Arnesen <harald@skogtun.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Dave Airlie <airlied@gmail.com>,
        Jani Nikula <jani.nikula@linux.intel.com>,
        Joonas Lahtinen <joonas.lahtinen@linux.intel.com>,
        Rodrigo Vivi <rodrigo.vivi@intel.com>,
        Daniel Vetter <daniel.vetter@ffwll.ch>,
        Chris Wilson <chris@chris-wilson.co.uk>,
        Matthew Auld <matthew.auld@intel.com>,
        intel-gfx <intel-gfx@lists.freedesktop.org>,
        kernel list <linux-kernel@vger.kernel.org>
Subject: Re: [Intel-gfx] 5.9-rc1: graphics regression moved from -next to
 mainline
Message-ID: <20200827072836.GA21780@amd>
References: <7efa547d-b7a4-b873-f1aa-4f19eb849fa3@skogtun.org>
 <CAHk-=wj3WskPCtHncCWLdaP6xVecLp8bDBTT57vyiU-0=Ld6QQ@mail.gmail.com>
 <d4db4a52-3001-cb02-4888-a9dfd55cdd7c@skogtun.org>
 <656b8f9f-d696-c75d-aef6-2b8b5170f2f6@skogtun.org>
 <CAHk-=wiAK=AiqTD47o-BFFZciQXpEC0SiiDnXLWJUcQtCo-Pig@mail.gmail.com>
 <101bff45-0ebd-8fb6-7c99-963aa4fcc588@skogtun.org>
 <CAPM=9twLvHu_XLJ89GVXpNo=PHPZLJuRpHggkfzvvuVf+xrwoA@mail.gmail.com>
 <0f06d704-c14e-0d86-c8bb-8c7b3a34758a@skogtun.org>
 <CAHk-=wh=MjX6+Bn-ooHT_wf4VTpe7y-5czbAUT=vaAn2VCBNBQ@mail.gmail.com>
 <1aa00cf1-427d-2ad7-8497-b5a007a64d81@skogtun.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
        protocol="application/pgp-signature"; boundary="cNdxnHkX5QqsyA0e"
Content-Disposition: inline
In-Reply-To: <1aa00cf1-427d-2ad7-8497-b5a007a64d81@skogtun.org>
User-Agent: Mutt/1.5.23 (2014-03-12)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--cNdxnHkX5QqsyA0e
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi!

> >> It's a Thinkpad T520.
> >=20
> > Oh, so this is a 64-bit machine? Yeah, that patch to flush vmalloc
> > ranges won't make any difference on x86-64.
> >=20
> > Or are you for some reason running a 32-bit kernel on that thing? Have
> > you tried building a 64-bit one (user-space can be 32-bit, it should
> > all just work. Knock wood).
>=20
> No, I run a 64-bit kernel with 64-bit userspace (Void Linux).
> Config is attached, in case anything is obvious from that.

For the record, I'm running 5.9.0-rc2-next-20200825 w/o further
patches, and it behaves okay on that 32-bit thinkpad x60.

BTW... could we get the test farms to occassionaly boot in 32-bit
mode? Those modern CPUs can still do that :-).

Best regards,
									Pavel
--=20
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blo=
g.html

--cNdxnHkX5QqsyA0e
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iEYEARECAAYFAl9HYKQACgkQMOfwapXb+vI7cQCeKgek3+t3QWuXEdofF5AGGHYn
+bEAoJuudssoh32NRk5xNwp2hciDyvZv
=u+U6
-----END PGP SIGNATURE-----

--cNdxnHkX5QqsyA0e--
