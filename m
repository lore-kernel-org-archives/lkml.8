Return-Path: <SRS0=YvwE=B6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.2 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6034DC433E1
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Aug 2020 09:24:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3E43422D02
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Aug 2020 09:24:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726871AbgHTJYG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 20 Aug 2020 05:24:06 -0400
Received: from jabberwock.ucw.cz ([46.255.230.98]:57024 "EHLO
        jabberwock.ucw.cz" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726781AbgHTJXz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Aug 2020 05:23:55 -0400
Received: by jabberwock.ucw.cz (Postfix, from userid 1017)
        id 273591C0BD6; Thu, 20 Aug 2020 11:23:50 +0200 (CEST)
Date:   Thu, 20 Aug 2020 11:23:49 +0200
From:   Pavel Machek <pavel@ucw.cz>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Dave Airlie <airlied@gmail.com>,
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
Message-ID: <20200820092349.GA3792@amd>
References: <20200817161132.GA4711@amd>
 <CAHk-=wh6_eWwvpL=AhOeY0btf_dkpu+0joNzPZWfbBWgAeAhMA@mail.gmail.com>
 <CAPM=9tw8LVWsuA6m_nkUDgm00iz2txYRNZY0b0WWZbyiUVzLEw@mail.gmail.com>
 <CAHk-=wg34bw1ude07nC_XCPOJHZ21-v6117p4574d5S7iP4gxw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
        protocol="application/pgp-signature"; boundary="EeQfGwPcQSOJBaQU"
Content-Disposition: inline
In-Reply-To: <CAHk-=wg34bw1ude07nC_XCPOJHZ21-v6117p4574d5S7iP4gxw@mail.gmail.com>
User-Agent: Mutt/1.5.23 (2014-03-12)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--EeQfGwPcQSOJBaQU
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi!

> > I think there's been some discussion about reverting that change for
> > other reasons, but it's quite likely the culprit.
>=20
> Hmm. It reverts cleanly, but the end result doesn't work, because of
> other changes.
>=20
> Reverting all of
>=20
>    763fedd6a216 ("drm/i915: Remove i915_gem_object_get_dirty_page()")
>    7ac2d2536dfa ("drm/i915/gem: Delete unused code")
>    9e0f9464e2ab ("drm/i915/gem: Async GPU relocations only")
>=20
> seems to at least build.
>=20
> Pavel, does doing those three reverts make things work for you?

Yes, it seems they make things work. (Chris asked for new patch to be
tested, so I am switching to his kernel, but it survived longer than
it usually does.)

Thanks and best regards,
								Pavel
--=20
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blo=
g.html

--EeQfGwPcQSOJBaQU
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iEYEARECAAYFAl8+QSUACgkQMOfwapXb+vJNIwCeI5looH84mvmfbwh947kCWZjp
DrYAoMLxcp9yPQh16oheciyRdFHfmJdf
=/piO
-----END PGP SIGNATURE-----

--EeQfGwPcQSOJBaQU--
