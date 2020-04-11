Return-Path: <SRS0=xbEg=53=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 479BEC2BA2B
	for <linux-kernel@archiver.kernel.org>; Sat, 11 Apr 2020 07:51:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1B61A20732
	for <linux-kernel@archiver.kernel.org>; Sat, 11 Apr 2020 07:51:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726090AbgDKHvW (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 11 Apr 2020 03:51:22 -0400
Received: from jabberwock.ucw.cz ([46.255.230.98]:52458 "EHLO
        jabberwock.ucw.cz" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725899AbgDKHvW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 11 Apr 2020 03:51:22 -0400
Received: by jabberwock.ucw.cz (Postfix, from userid 1017)
        id 88B711C6109; Sat, 11 Apr 2020 09:51:20 +0200 (CEST)
Date:   Sat, 11 Apr 2020 09:51:20 +0200
From:   Pavel Machek <pavel@ucw.cz>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Chris Wilson <chris@chris-wilson.co.uk>,
        Dave Airlie <airlied@redhat.com>,
        intel-gfx@lists.freedesktop.org,
        Jani Nikula <jani.nikula@linux.intel.com>,
        Joonas Lahtinen <joonas.lahtinen@linux.intel.com>,
        kernel list <linux-kernel@vger.kernel.org>,
        matthew.auld@intel.com, Rodrigo Vivi <rodrigo.vivi@intel.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        Peter Anvin <hpa@zytor.com>
Subject: Re: Linus, please revert 7dc8f11437: regression in 5.7-rc0, hangs
 while attempting to run X
Message-ID: <20200411075119.GA16837@amd.ucw.cz>
References: <20200407072047.GA18532@amd.ucw.cz>
 <158624426770.4794.6070200474948860768@build.alporthouse.com>
 <20200407074841.GB18673@amd.ucw.cz>
 <CAHk-=wixvbCie+EQ-vTPdyrzmdopM_BQc=uetneuSSa7PtCt2g@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
        protocol="application/pgp-signature"; boundary="pWyiEgJYm5f9v55/"
Content-Disposition: inline
In-Reply-To: <CAHk-=wixvbCie+EQ-vTPdyrzmdopM_BQc=uetneuSSa7PtCt2g@mail.gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--pWyiEgJYm5f9v55/
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi!

> > > Beyond the fix already submitted?
> >
> > I did not get that one, can I have a pointer?
>=20
> What's the status of this one?

I tried updating my kernel on April 3, that one did not work, but it
did not include 721017cf4bd8.

> I'm assuming the fix is commit 721017cf4bd8 ("drm/i915/gem: Ignore
> readonly failures when updating relics"), but didn't see a reply to
> the query or a confirmation of things working..

I pulled latest tree from Linus, and this one has 721017cf4bd8. Let my
try to revert my revert, and test... yes, this one seems okay.

Something changed in the X, now it seems that only one monitor is used
for login, not both... but it now works.

Best regards,
								Pavel

PS: Hmm. This is not helpful. I guess this is "N".

*
* VDPA drivers
*
VDPA drivers (VDPA_MENU) [N/y/?] (NEW) ?

There is no help available for this option.
Symbol: VDPA_MENU [=3Dn]
Type  : bool
Defined at drivers/vdpa/Kconfig:9
  Prompt: VDPA drivers
  Location:
    -> Device Drivers

*
* VHOST drivers
*
VHOST drivers (VHOST_MENU) [Y/n/?] (NEW) ?

There is no help available for this option.
Symbol: VHOST_MENU [=3Dy]
Type  : bool
Defined at drivers/vhost/Kconfig:21
  Prompt: VHOST drivers
  Location:
    -> Device Drivers


> Btw, Chris, that __put_user() not testing the error should at least
> have a comment. We don't have a working "__must_check" for those
> things (because they are subtle macros, not functions), but if we did,
> we'd get a compiler warning for not checking the error value.

Best regards,
								Pavel


--=20
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blo=
g.html

--pWyiEgJYm5f9v55/
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iF0EABECAB0WIQRPfPO7r0eAhk010v0w5/Bqldv68gUCXpF29wAKCRAw5/Bqldv6
8rLbAJ9+qb+examYdcgoosM2keLFuc5dEACgoiaicqZxc1Pwd7HChqIdJieOojI=
=Kt+J
-----END PGP SIGNATURE-----

--pWyiEgJYm5f9v55/--
