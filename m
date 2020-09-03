Return-Path: <SRS0=vQOp=CM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E074FC433E9
	for <linux-kernel@archiver.kernel.org>; Thu,  3 Sep 2020 14:34:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C1D8D2071B
	for <linux-kernel@archiver.kernel.org>; Thu,  3 Sep 2020 14:34:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729125AbgICOee (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 3 Sep 2020 10:34:34 -0400
Received: from mx2.suse.de ([195.135.220.15]:48752 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729322AbgICOdu (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Sep 2020 10:33:50 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 3B393B58F;
        Thu,  3 Sep 2020 13:43:23 +0000 (UTC)
Message-ID: <561110efffc3f6bf57894bf39861b39e1ec87845.camel@suse.com>
Subject: Re: [RFC PATCH v7 17/23] kernel/entry: Add support for core-wide
 protection of kernel-mode
From:   Dario Faggioli <dfaggioli@suse.com>
To:     Joel Fernandes <joel@joelfernandes.org>
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Julien Desfossez <jdesfossez@digitalocean.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Vineeth Pillai <viremana@linux.microsoft.com>,
        Tim Chen <tim.c.chen@linux.intel.com>,
        Aaron Lu <aaron.lwe@gmail.com>,
        Aubrey Li <aubrey.intel@gmail.com>,
        Dhaval Giani <dhaval.giani@oracle.com>,
        Chris Hyser <chris.hyser@oracle.com>,
        Nishanth Aravamudan <naravamudan@digitalocean.com>,
        Ingo Molnar <mingo@kernel.org>, Paul Turner <pjt@google.com>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Frederic Weisbecker <fweisbec@gmail.com>,
        Kees Cook <keescook@chromium.org>,
        Greg Kerr <kerrnel@google.com>, Phil Auld <pauld@redhat.com>,
        Valentin Schneider <valentin.schneider@arm.com>,
        Mel Gorman <mgorman@techsingularity.net>,
        Pawan Gupta <pawan.kumar.gupta@linux.intel.com>,
        Paolo Bonzini <pbonzini@redhat.com>, vineeth@bitbyteword.org,
        Chen Yu <yu.c.chen@intel.com>,
        Christian Brauner <christian.brauner@ubuntu.com>,
        Agata Gruza <agata.gruza@intel.com>,
        Antonio Gomez Iglesias <antonio.gomez.iglesias@intel.com>,
        graf@amazon.com, konrad.wilk@oracle.com,
        Steven Rostedt <rostedt@goodmis.org>,
        Patrick Bellasi <derkling@google.com>,
        =?UTF-8?Q?benbjiang=28=E8=92=8B=E5=BD=AA=29?= 
        <benbjiang@tencent.com>, Aubrey Li <aubrey.li@linux.intel.com>,
        Tim Chen <tim.c.chen@intel.com>,
        "Paul E . McKenney" <paulmck@kernel.org>
Date:   Thu, 03 Sep 2020 15:43:19 +0200
In-Reply-To: <CAEXW_YRQiC_0edO5L2vVmL0NcfeZaRt4WYoyrcKmzbFcQP3PvA@mail.gmail.com>
References: <cover.1598643276.git.jdesfossez@digitalocean.com>
         <2a4398b55fe258ea53fb1fbc727063298f7eea8f.1598643276.git.jdesfossez@digitalocean.com>
         <87y2lth4qa.fsf@nanos.tec.linutronix.de>
         <20200901165052.GA1662854@google.com>
         <875z8xl0zh.fsf@nanos.tec.linutronix.de>
         <20200902012905.GB1703315@google.com>
         <87h7sgk41y.fsf@nanos.tec.linutronix.de>
         <a80babf130a45841e166fa155f84afc19b4257d3.camel@suse.com>
         <CAEXW_YRQiC_0edO5L2vVmL0NcfeZaRt4WYoyrcKmzbFcQP3PvA@mail.gmail.com>
Content-Type: multipart/signed; micalg="pgp-sha256";
        protocol="application/pgp-signature"; boundary="=-u3iHHAldM+mQ4zS+I0no"
User-Agent: Evolution 3.36.4 (by Flathub.org) 
MIME-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--=-u3iHHAldM+mQ4zS+I0no
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, 2020-09-03 at 00:34 -0400, Joel Fernandes wrote:
> On Wed, Sep 2, 2020 at 12:57 PM Dario Faggioli <dfaggioli@suse.com>
> wrote:
> > 2) protection of the kernel from the other thread running in
> > userspace
> > may be achieved in different ways. This is one, sure. ASI will
> > probably
> > be another. Hence if/when we'll have both, this and ASI, it would
> > be
> > cool to be able to configure the system in such a way that there is
> > only one active, to avoid paying the price of both! :-)
>=20
> Actually, no. Part of ASI will involve exactly what this patch does -
> IPI-pausing siblings but ASI does so when they have no choice but to
> switch away from the "limited kernel" mapping, into the full host
> kernel mapping. I am not sure if they have yet implemented that part
> but they do talk of it in [1] and in their pretty LPC slides.  It is
> just that ASI tries to avoid that scenario of kicking all siblings
> out
> of guest mode.  So, maybe this patch can be a stepping stone to ASI.
>
Ah, sure! I mean, it of course depends on how things get mixed
together, which we still don't know. :-)

I know that ASI wants to do this very same thing some times. I just
wanted to say that we need/want only one mechanism for doing that, in
place at any given time.

If that mechanism will be this one, and ASI then uses it (e.g., in a
scenario where for whatever reason one wants ASI with the kicking but
not Core Scheduling), then great, I agree, and everything does makes
sense.

> Why do you feel that ASI on its own offers some magical protection
> that eliminates the need for this patch?
>=20
I don't. I was just trying to think at different use cases, how they
mix and match, etc. But as you're suggesting (and as Thomas has shown
very clearly in another reply to this email), the thing that makes the
most sense is to have one mechanism for the kicking, used by anyone
that needs it. :-)

Thanks and Regards
--=20
Dario Faggioli, Ph.D
http://about.me/dario.faggioli
Virtualization Software Engineer
SUSE Labs, SUSE https://www.suse.com/
-------------------------------------------------------------------
<<This happens because _I_ choose it to happen!>> (Raistlin Majere)

--=-u3iHHAldM+mQ4zS+I0no
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part
Content-Transfer-Encoding: 7bit

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEES5ssOj3Vhr0WPnOLFkJ4iaW4c+4FAl9Q8vcACgkQFkJ4iaW4
c+5YFw/8DNj8gL/7OQ+hKTi4bd076a6jYdA0RHw6nKTO/ITc90dUEr7FLAzuPP4X
IdRYVx779rR0RlUvbzLYSOswI17hlcJY+gXBd0RpC2lFhRwySZUiq1GMIOXnqxjs
M9+g8z3c2Mv1Iv+aMUlW/A34BgPgAkEvTiEp/6bhMJWYXAdrd8G0BONc4F/CTB69
XyFDTSVmbgMG0puD0jO8h3C+s8P6A8jUfo8j4AIKE1ayzORjCOcy/iHUVZEBlkJC
XP0e4oonZIflyWKqsEh+Ozi1hN2GbUXyBY42BEOi++q5WfqJo1f6sg2t3s7k9HXg
z7tXs62+DxPeygeOFfKxtJa1lSIu6g6uMV6AzYraMNecKu/iO9V6XAww5g6lkgZl
jzvZHdb7s7+kGkymKxxnlVxYZGoAa2H1eschTSwvV1P06L3710PQ7nj2TKR/7BAk
Bynvt7b/D0coxkxvYEoyS5oazV9z97Nncpp35n0iK/H+2IcmZiRDYFVX10HD0PrB
Pmx5FzkNbgmsYzM3uYilRcgYFj+g8Z/evQ8ksPRqo5HBzM7erw13urGLNl5bpJ67
uqGTLEC80e4dYElBxJHz3j+WxL8lEmv1ZN2A9zGglPpPaGk5AGVa46YfXt/b1nNf
wYTncBiXGWjalAGnh3SmkeUkgl4F1m8ioY0+aeyHdM7Jf9byvj8=
=e7D3
-----END PGP SIGNATURE-----

--=-u3iHHAldM+mQ4zS+I0no--

