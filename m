Return-Path: <SRS0=OrIQ=3R=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 544CAC32771
	for <linux-kernel@archiver.kernel.org>; Tue, 28 Jan 2020 02:40:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 23E3C2467B
	for <linux-kernel@archiver.kernel.org>; Tue, 28 Jan 2020 02:40:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726294AbgA1CkP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 27 Jan 2020 21:40:15 -0500
Received: from mx2.suse.de ([195.135.220.15]:39004 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726080AbgA1CkP (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Jan 2020 21:40:15 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx2.suse.de (Postfix) with ESMTP id 1A89DAE44;
        Tue, 28 Jan 2020 02:40:12 +0000 (UTC)
Message-ID: <09b279683e1b5ba1759ac3e9f644d290564902d3.camel@suse.com>
Subject: Re: [RFC PATCH v4 00/19] Core scheduling v4
From:   Dario Faggioli <dfaggioli@suse.com>
To:     Vineeth Remanan Pillai <vpillai@digitalocean.com>,
        Tim Chen <tim.c.chen@linux.intel.com>
Cc:     Nishanth Aravamudan <naravamudan@digitalocean.com>,
        Julien Desfossez <jdesfossez@digitalocean.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Paul Turner <pjt@google.com>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Linux List Kernel Mailing <linux-kernel@vger.kernel.org>,
        =?ISO-8859-1?Q?Fr=E9d=E9ric?= Weisbecker <fweisbec@gmail.com>,
        Kees Cook <keescook@chromium.org>,
        Greg Kerr <kerrnel@google.com>, Phil Auld <pauld@redhat.com>,
        Aaron Lu <aaron.lwe@gmail.com>,
        Aubrey Li <aubrey.intel@gmail.com>,
        Valentin Schneider <valentin.schneider@arm.com>,
        Mel Gorman <mgorman@techsingularity.net>,
        Pawan Gupta <pawan.kumar.gupta@linux.intel.com>,
        Paolo Bonzini <pbonzini@redhat.com>
Date:   Tue, 28 Jan 2020 03:40:09 +0100
In-Reply-To: <CANaguZAz+mw1Oi8ecZt+JuCWbf=g5UvKrdSvAeM82Z1c+9oWAw@mail.gmail.com>
References: <cover.1572437285.git.vpillai@digitalocean.com>
         <5e3cea14-28d1-bf1e-cabe-fb5b48fdeadc@linux.intel.com>
         <3c3c56c1-b8dc-652c-535e-74f6dcf45560@linux.intel.com>
         <CANaguZAz+mw1Oi8ecZt+JuCWbf=g5UvKrdSvAeM82Z1c+9oWAw@mail.gmail.com>
Organization: SUSE
Content-Type: multipart/signed; micalg="pgp-sha256";
        protocol="application/pgp-signature"; boundary="=-0QOLAV3RIX/hw2NT7iyf"
User-Agent: Evolution 3.34.3 
MIME-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--=-0QOLAV3RIX/hw2NT7iyf
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, 2020-01-14 at 10:40 -0500, Vineeth Remanan Pillai wrote:
> On Mon, Jan 13, 2020 at 8:12 PM Tim Chen <tim.c.chen@linux.intel.com>
>=20
> > As a side effect of the fix, each core can now operate in core-
> > scheduling
> > mode or non core-scheduling mode, depending on how many online SMT
> > threads it has.
> >=20
> > Vineet, are you guys planning to refresh v4 and update it to
> > v5?  Aubrey posted
> > a port to the latest kernel earlier.
> >=20
> We are investigating a performance issue
> with
> high overcommit io intensive workload and also we are trying to see
> if
> we can add synchronization during VMEXITs so that a guest vm cannot
> run
> run alongside with host kernel.=20
>
So, about this VMEXIT sync thing. I do agree that we should at least
try and do it (and assess performance).

I was wondering, however, what we think about core-scheduling + address
space isolation (or whatever it is/will be called). More specifically,
whether such a solution wouldn't be considered an equally safe setup
(at least for the virt use-cases, of course).

Basically, core-scheduling would prevent VM-to-VM attacks while ASI
would mitigate VM-to-hypervisor attacks.

Of course, such a solution would need to be fully implemented and
evaluated too... I just wanted to toss it around, mostly to know what
you think about it and whether or not it is already on your radar.

Thanks and Regards
--=20
Dario Faggioli, Ph.D
http://about.me/dario.faggioli
Virtualization Software Engineer
SUSE Labs, SUSE https://www.suse.com/
-------------------------------------------------------------------
<<This happens because _I_ choose it to happen!>> (Raistlin Majere)


--=-0QOLAV3RIX/hw2NT7iyf
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part
Content-Transfer-Encoding: 7bit

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEES5ssOj3Vhr0WPnOLFkJ4iaW4c+4FAl4vnwoACgkQFkJ4iaW4
c+5h/A//UHsF2sGkTJI/L4vFvNv5Hy4kB6RugQqLpfePV5pELOgB65JHwdeuafHM
re5e/wkFSvLWTokxZZrGvQAoBmN4BrlsMgc5qMrH5zMxpAaKjq75ZbAPc45IdKXs
gIUQMUKQvCKPEEDi5r2oPKvqTdUBoo7MOE3apcqf8KUYKQJLSqINAAPblW1WWP3W
Cj5pnlEf0X1JsM0U+NTKw11zKyDPY0TdkF4d/CK9W5J7BpnMuBYg5zsPzuBFbE/N
xhjYjeLIXqdxWfdqquE5QYqvuKh2eHWM8Kd82ki4azOZCMIimTB3sQ1VrQ2ezUOh
HiLYzj5JoW+PiXfSEvUKuTxIt+PniY8o4B4G2Oeu0D884huT9vZGz3Nx8i4A1njY
98bQBJpk5qJ08rq/m89gjVqXgcKBDuD0JI1UZUGO9fszChA2txxzFqkzMysd87tQ
tOnOcGlIvZuB8XuJ21wzmwKmpNfqW0DnytooxVcr3qf+KKymYTrMtyBmycOOKSfh
1DDW4JkShbJZJseB7gr5lg9k4D/LQw+Iz2Bq0iV4WlcmK7rW28VVnQ0GNEmIoSt1
xeCQV2b85VAQAQYrFBiFQJsEsz6VYnhJoyOrHUX6rFC8StwI1qgj+Ldqr7SBVWKB
sZOMEv+Igdn2eGdxU1U5VGCuWMfooi3LyG58brF1lHC4bUgCBgY=
=xIKT
-----END PGP SIGNATURE-----

--=-0QOLAV3RIX/hw2NT7iyf--

