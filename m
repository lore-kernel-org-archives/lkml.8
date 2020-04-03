Return-Path: <SRS0=4r1w=5T=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E0561C43331
	for <linux-kernel@archiver.kernel.org>; Fri,  3 Apr 2020 09:14:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BCA2320721
	for <linux-kernel@archiver.kernel.org>; Fri,  3 Apr 2020 09:14:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390471AbgDCJOd (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 3 Apr 2020 05:14:33 -0400
Received: from jabberwock.ucw.cz ([46.255.230.98]:53190 "EHLO
        jabberwock.ucw.cz" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727803AbgDCJOd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 Apr 2020 05:14:33 -0400
Received: by jabberwock.ucw.cz (Postfix, from userid 1017)
        id 4F9301C3297; Fri,  3 Apr 2020 11:14:31 +0200 (CEST)
Date:   Fri, 3 Apr 2020 11:14:30 +0200
From:   Pavel Machek <pavel@ucw.cz>
To:     kernel list <linux-kernel@vger.kernel.org>,
        jani.nikula@linux.intel.com, joonas.lahtinen@linux.intel.com,
        rodrigo.vivi@intel.com, intel-gfx@lists.freedesktop.org
Cc:     tglx@linutronix.de, mingo@redhat.com, bp@alien8.de, hpa@zytor.com
Subject: Re: 5.7-rc0: hangs while attempting to run X
Message-ID: <20200403091430.GA3845@duo.ucw.cz>
References: <20200402213253.GA2691@duo.ucw.cz>
 <20200402213506.GA2767@duo.ucw.cz>
 <20200403073720.GA23229@duo.ucw.cz>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
        protocol="application/pgp-signature"; boundary="5vNYLRcllDrimb99"
Content-Disposition: inline
In-Reply-To: <20200403073720.GA23229@duo.ucw.cz>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--5vNYLRcllDrimb99
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi!

> > > Hardware is thinkpad x220. I had this crash few days ago. And today I
> > > have similar-looking one, with slightly newer kernel. (Will post
> > > as a follow-up).
>=20
> As part of quest for working system, I tried 5.7-rc0, based on
>=20
> Merge: 50a5de895dbe b4d8ddf8356d
> Author: Linus Torvalds <torvalds@linux-foundation.org>
> Date:   Wed Apr 1 18:18:18 2020 -0700
>=20
> It hangs in userspace, at a time when X should be starting, and I'm
> looking at blinking cursor.
>=20
> 5.6-rcs worked, I'll test 5.6-final.

5.6-final works.

Hmm...

commit f365ab31efacb70bed1e821f7435626e0b2528a6
Merge: 4646de87d325 59e7a8cc2dcf
Author: Linus Torvalds <torvalds@linux-foundation.org>
Date:   Wed Apr 1 15:24:20 2020 -0700

    Merge tag 'drm-next-2020-04-01' of git://anongit.freedesktop.org/drm/drm

Let me test 4646de87d32526ee87b46c2e0130413367fb5362...that one works.

Ok, so obviously... I should
test... f365ab31efacb70bed1e821f7435626e0b2528a6

Now, this is anti-social:

Busywait for request completion limit (ns)
(DRM_I915_MAX_REQUEST_BUSYWAIT) [8000] (NEW)

How should I know what to answer here (or the others)

Interval between heartbeat pulses (ms) (DRM_I915_HEARTBEAT_INTERVAL) [2500]=
 2500
Preempt timeout (ms, jiffy granularity) (DRM_I915_PREEMPT_TIMEOUT) [640] 640

I just took the defaults.. but...=20

Best regards,
									Pavel
--=20
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blo=
g.html

--5vNYLRcllDrimb99
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iF0EABECAB0WIQRPfPO7r0eAhk010v0w5/Bqldv68gUCXob+dgAKCRAw5/Bqldv6
8oIcAJ9FR43pTa8IQWed9VsoTGof0bNbvgCfdDrEabp6lae0rSwI6E3Nc/CaGyQ=
=tPNa
-----END PGP SIGNATURE-----

--5vNYLRcllDrimb99--
