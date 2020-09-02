Return-Path: <SRS0=728o=CL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DF1BBC433E2
	for <linux-kernel@archiver.kernel.org>; Wed,  2 Sep 2020 16:57:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B1B5E20767
	for <linux-kernel@archiver.kernel.org>; Wed,  2 Sep 2020 16:57:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728298AbgIBQ5e (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 2 Sep 2020 12:57:34 -0400
Received: from mx2.suse.de ([195.135.220.15]:44928 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726310AbgIBQ5Y (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Sep 2020 12:57:24 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id A76B3AC61;
        Wed,  2 Sep 2020 16:57:21 +0000 (UTC)
Message-ID: <a80babf130a45841e166fa155f84afc19b4257d3.camel@suse.com>
Subject: Re: [RFC PATCH v7 17/23] kernel/entry: Add support for core-wide
 protection of kernel-mode
From:   Dario Faggioli <dfaggioli@suse.com>
To:     Thomas Gleixner <tglx@linutronix.de>,
        Joel Fernandes <joel@joelfernandes.org>
Cc:     Julien Desfossez <jdesfossez@digitalocean.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Vineeth Pillai <viremana@linux.microsoft.com>,
        Tim Chen <tim.c.chen@linux.intel.com>,
        Aaron Lu <aaron.lwe@gmail.com>,
        Aubrey Li <aubrey.intel@gmail.com>,
        Dhaval Giani <dhaval.giani@oracle.com>,
        Chris Hyser <chris.hyser@oracle.com>,
        Nishanth Aravamudan <naravamudan@digitalocean.com>,
        mingo@kernel.org, pjt@google.com, torvalds@linux-foundation.org,
        linux-kernel@vger.kernel.org, fweisbec@gmail.com,
        keescook@chromium.org, kerrnel@google.com,
        Phil Auld <pauld@redhat.com>,
        Valentin Schneider <valentin.schneider@arm.com>,
        Mel Gorman <mgorman@techsingularity.net>,
        Pawan Gupta <pawan.kumar.gupta@linux.intel.com>,
        Paolo Bonzini <pbonzini@redhat.com>, vineeth@bitbyteword.org,
        Chen Yu <yu.c.chen@intel.com>,
        Christian Brauner <christian.brauner@ubuntu.com>,
        Agata Gruza <agata.gruza@intel.com>,
        Antonio Gomez Iglesias <antonio.gomez.iglesias@intel.com>,
        graf@amazon.com, konrad.wilk@oracle.com, rostedt@goodmis.org,
        derkling@google.com, benbjiang@tencent.com,
        Aubrey Li <aubrey.li@linux.intel.com>,
        Tim Chen <tim.c.chen@intel.com>,
        "Paul E . McKenney" <paulmck@kernel.org>
Date:   Wed, 02 Sep 2020 18:57:17 +0200
In-Reply-To: <87h7sgk41y.fsf@nanos.tec.linutronix.de>
References: <cover.1598643276.git.jdesfossez@digitalocean.com>
         <2a4398b55fe258ea53fb1fbc727063298f7eea8f.1598643276.git.jdesfossez@digitalocean.com>
         <87y2lth4qa.fsf@nanos.tec.linutronix.de>
         <20200901165052.GA1662854@google.com>
         <875z8xl0zh.fsf@nanos.tec.linutronix.de>
         <20200902012905.GB1703315@google.com>
         <87h7sgk41y.fsf@nanos.tec.linutronix.de>
Content-Type: multipart/signed; micalg="pgp-sha256";
        protocol="application/pgp-signature"; boundary="=-ySYxwoHQiyztLulfiemT"
User-Agent: Evolution 3.36.4 (by Flathub.org) 
MIME-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--=-ySYxwoHQiyztLulfiemT
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, 2020-09-02 at 09:53 +0200, Thomas Gleixner wrote:
> On Tue, Sep 01 2020 at 21:29, Joel Fernandes wrote:
> > On Tue, Sep 01, 2020 at 10:02:10PM +0200, Thomas Gleixner wrote:
> > >=20
> > Or, are you saying users may want 'core scheduling' enabled but may
> > want to
> > leave out the kernel protection?
>=20
> Core scheduling per se without all the protection muck, i.e. a
> relaxed
> version which tries to gang schedule threads of a process on a core
> if
> feasible has advantages to some workloads.
>=20
Indeed! For at least two reasons, IMO:

1) what Thomas is saying already. I.e., even on a CPU which has HT but
is not affected by any of the (known!) speculation issues, one may want
to use Core Scheduling _as_a_feature_. For instance, for avoiding
threads from different processes, or vCPUs from different VMs, sharing
cores (e.g., for better managing their behavior/performance, or for
improved fairness of billing/accounting). And in this case, this
mechanism for protecting the kernel from the userspace on the other
thread may not be necessary or interesting;

2) protection of the kernel from the other thread running in userspace
may be achieved in different ways. This is one, sure. ASI will probably
be another. Hence if/when we'll have both, this and ASI, it would be
cool to be able to configure the system in such a way that there is
only one active, to avoid paying the price of both! :-)

Regards
--=20
Dario Faggioli, Ph.D
http://about.me/dario.faggioli
Virtualization Software Engineer
SUSE Labs, SUSE https://www.suse.com/
-------------------------------------------------------------------
<<This happens because _I_ choose it to happen!>> (Raistlin Majere)

--=-ySYxwoHQiyztLulfiemT
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part
Content-Transfer-Encoding: 7bit

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEES5ssOj3Vhr0WPnOLFkJ4iaW4c+4FAl9Pzu0ACgkQFkJ4iaW4
c+5Uig//Zz4phJ7kxpx1v3NQaxstvr3exfY8FEXFKeBL2j1kywA5resjyR9BrHPN
bVQXH6T1EGC7PJa4g38PCU8Hi1v67g8kWqVC1wNCBQrx5kcRaEcEmPjNiD3i3IMQ
FSD9MUwNx9yHvuT9BsykHQCp5A2YK/AgjO4o3JhgB+QUcjr0rdG3sOoDNdA8DA47
TDNRYz0FXgnugNBDChtCecH0LF1Q/Y4FFlAo32k02oTw22BjM01rfs+FR+H2Kghi
C7q+B6jfi9IME3y0pXpZTj8OERiopy5AcBYVxrKEfGWNGRAhhhlfOtADFtLGt0uz
PW9c1mpS2FsWPNNoxtAqSppbV7jJ3lh36gQ9phtTtPxW5PLrLShstjTPT2a8ZxOw
DTcQOU7I10p/tV6mczi3TZKb7k1CdEzerp/ZVDd/L9xG9KD0Zep961kx21Zrm/KS
Ek4fNUvXpWfNqmyq2jBeZukFdsP6EBpuJJ/FYNsjjt0P5qw5fIZ/c35OM8IR4V5G
TaClfyJq0jtlI0i8vxdK8NyRowjksuKbbXLP/9MzN6Wci1Ks2oShKWxosikWQazF
uLrXMg0J62AV6SNcqbS9yLIcclh8bj37EchqFRMz/sWCovWlth0+TWBRxSa9J1eu
xthi9DOp7f4jfFRpN1jHFSC6G+IOFwzu6l4IZab+7VH+euXmC7o=
=o5lY
-----END PGP SIGNATURE-----

--=-ySYxwoHQiyztLulfiemT--

