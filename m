Return-Path: <SRS0=4r1w=5T=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A3FF9C2BA17
	for <linux-kernel@archiver.kernel.org>; Fri,  3 Apr 2020 10:29:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7CB0220737
	for <linux-kernel@archiver.kernel.org>; Fri,  3 Apr 2020 10:29:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2403762AbgDCK3f (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 3 Apr 2020 06:29:35 -0400
Received: from jabberwock.ucw.cz ([46.255.230.98]:34630 "EHLO
        jabberwock.ucw.cz" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2390633AbgDCK3d (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 Apr 2020 06:29:33 -0400
Received: by jabberwock.ucw.cz (Postfix, from userid 1017)
        id 10C6A1C3382; Fri,  3 Apr 2020 12:29:32 +0200 (CEST)
Date:   Fri, 3 Apr 2020 12:29:31 +0200
From:   Pavel Machek <pavel@ucw.cz>
To:     kernel list <linux-kernel@vger.kernel.org>,
        jani.nikula@linux.intel.com, joonas.lahtinen@linux.intel.com,
        rodrigo.vivi@intel.com, intel-gfx@lists.freedesktop.org,
        airlied@redhat.com
Cc:     tglx@linutronix.de, mingo@redhat.com, bp@alien8.de, hpa@zytor.com
Subject: Re: 5.7-rc0: regression caused by drm tree, hangs while attempting
 to run X
Message-ID: <20200403102928.GA3539@duo.ucw.cz>
References: <20200402213253.GA2691@duo.ucw.cz>
 <20200402213506.GA2767@duo.ucw.cz>
 <20200403073720.GA23229@duo.ucw.cz>
 <20200403091430.GA3845@duo.ucw.cz>
 <20200403092634.GA3610@duo.ucw.cz>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
        protocol="application/pgp-signature"; boundary="LQksG6bCIzRHxTLp"
Content-Disposition: inline
In-Reply-To: <20200403092634.GA3610@duo.ucw.cz>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--LQksG6bCIzRHxTLp
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi!

> > commit f365ab31efacb70bed1e821f7435626e0b2528a6
> > Merge: 4646de87d325 59e7a8cc2dcf
> > Author: Linus Torvalds <torvalds@linux-foundation.org>
> > Date:   Wed Apr 1 15:24:20 2020 -0700
> >=20
> >     Merge tag 'drm-next-2020-04-01' of
> > git://anongit.freedesktop.org/drm/drm


> Any ideas, besides the b-word?
>=20
> Would c0ca be good commit for testing?
>=20
> commit 700d6ab987f3b5e28b13b5993e5a9a975c5604e2
> Merge: c0ca5437c509 2bdd4c28baff

c0ca is broken.

commit 9001b17698d86f842e2b13e0cafe8021d43209e9
Merge: bda1fb0ed000 217a485c8399

    Merge tag 'drm-intel-next-2020-03-13' of git://anongit.freedesktop.org/=
drm/d
rm-intel into drm-next
   =20
    UAPI Changes:

So bda1fb0ed000 looks like test candidate... and that one works.

I guess 217a485c8399 is reasonable next step... and that
11a48a5a18c63fd7621bb050228cebf13566e4d8 should work ok.=20

Best regards,
								Pavel
--=20
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blo=
g.html

--LQksG6bCIzRHxTLp
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iF0EABECAB0WIQRPfPO7r0eAhk010v0w5/Bqldv68gUCXocQCAAKCRAw5/Bqldv6
8nvXAKC1pB14XrCpXQgcLZgC91Z0PfLfpQCfQgcWXUjqB2jN6klSsbAUNmTfIdY=
=cFVA
-----END PGP SIGNATURE-----

--LQksG6bCIzRHxTLp--
