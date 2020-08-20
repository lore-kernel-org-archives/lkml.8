Return-Path: <SRS0=YvwE=B6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6CA9DC433E1
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Aug 2020 20:39:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 311012076E
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Aug 2020 20:39:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728426AbgHTUjz (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 20 Aug 2020 16:39:55 -0400
Received: from shelob.surriel.com ([96.67.55.147]:51532 "EHLO
        shelob.surriel.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728415AbgHTUjy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Aug 2020 16:39:54 -0400
Received: from imladris.surriel.com ([96.67.55.152])
        by shelob.surriel.com with esmtpsa  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.94)
        (envelope-from <riel@shelob.surriel.com>)
        id 1k8rLf-0006yz-UW; Thu, 20 Aug 2020 16:39:47 -0400
Message-ID: <ad2a59c680d361847f257cdae576dd479e6ab9ac.camel@surriel.com>
Subject: Re: CFS flat runqueue proposal fixes/update
From:   Rik van Riel <riel@surriel.com>
To:     Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Peter Zijlstra <peterz@infradead.org>
Cc:     Paul Turner <pjt@google.com>,
        "vincent.guittot" <vincent.guittot@linaro.org>, kernel-team@fb.com,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "dietmar.eggeman" <dietmar.eggeman@arm.com>
Date:   Thu, 20 Aug 2020 16:39:47 -0400
In-Reply-To: <0e7a9174-6ed9-752d-dacb-4dce182852cf@arm.com>
References: <1609106d05a6a4a5938233e993548510f599d7d9.camel@surriel.com>
         <0e7a9174-6ed9-752d-dacb-4dce182852cf@arm.com>
Content-Type: multipart/signed; micalg="pgp-sha256";
        protocol="application/pgp-signature"; boundary="=-E3qV2JTgigT6ELVlkBvg"
User-Agent: Evolution 3.34.4 (3.34.4-1.fc31) 
MIME-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--=-E3qV2JTgigT6ELVlkBvg
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, 2020-08-20 at 16:56 +0200, Dietmar Eggemann wrote:
> Hi Rik,
>=20
> On 31/07/2020 09:42, Rik van Riel wrote:
>=20
> [...]
>=20
> > Lets revisit the hierarchy from above, and assign priorities
> > to the cgroups, with the fixed point one being 1000. Lets
> > say cgroups A, A1, and B have priority 1000, while cgroup
> > A2 has priority 1.
> >=20
> >         /\
> >        /  \
> >       A    B
> >      / \    \=20
> >     A1 A2   t3
> >    /     \
> >   t1     t2
> >=20
> > One consequence of this is that when t1, t2, and t3 each
> > get a time slice, the vruntime of tasks t1 and t3 advances
> > at roughly the same speed as the clock time, while the
> > vruntime of task t2 advances 1000x faster.
> >=20
> > This is fine if all three tasks continue to be runnable,
> > since t1, t2 and t3 each get their fair share of CPU time.
> >=20
> > However, if t1 goes to sleep, t2 is the only thing running
> > inside cgroup A, which has the same priority as cgroup B,
> > and tasks t2 and t3 should be getting the same amount of
> > CPU time.
> >=20
> > They eventually will, but not before task t3 has used up
> > enough CPU time to catch up with the enormous vruntime
> > advance that t2 just suffered.
> >=20
> > That needs to be fixed, to get near-immediate convergence,
> > and not convergence after some unknown (potentially long)
> > period of time.
>=20
> I'm trying to understand this issue in detail ...
>=20
> Since t1 and t2 are single tasks in A1 and A2, this taskgroup level
> shouldn't matter for tick preemption after t1 went to sleep?
>=20
> check_preempt_tick() is only invoked for 'cfs_rq->nr_running > 1'
> from
> entity_tick().
>=20
> IMHO, tick preemption is handled between A and B and since they have
> the
> same cpu.weight (cpu.shares) t2 and t3 get the same time slice after
> t1
> went to sleep.
>=20
> I think that here tick preemption happens in the 'if (delta_exec >
> ideal_runtime)' condition w/ delta_exec =3D curr->sum_exec_runtime -
> curr->prev_sum_exec_runtime.
>=20
> Did I miss anything?

The issue happens with a flat runqueue, when t1 goes
to sleep, but t2 and t3 continue running.

We need to make sure the vruntime for t2 has not been
advanced so far into the future that cgroup A is unable
to get its fair share of CPU wihle t1 is sleeping.

--=20
All Rights Reversed.

--=-E3qV2JTgigT6ELVlkBvg
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part
Content-Transfer-Encoding: 7bit

-----BEGIN PGP SIGNATURE-----

iQEzBAABCAAdFiEEKR73pCCtJ5Xj3yADznnekoTE3oMFAl8+35MACgkQznnekoTE
3oNxmQgArqcqvpPxMhn76k0rHtet79OO5oN6c8hx+ubeET7pmVfk4FgdNdfjV3Tr
bjAxwXHlBdQ/ANXIfWTBEzPeGEfryua+DxI1Z8LkMi1uicsULOOr/g8JYFAzdp42
QNeyiHz68rNhN1y6lP2K1x7/4T9iSRrnDamkRyOIcjHplWEk98iT1CoQZf1K7r11
dojYcwjUu38tCSd4nsLK+PUHJC/Mie4Bq1+0If0DrwrNTkiaBh23haniigVynTJK
tTOP4AXheN/j+KEoTge5NYDx/fik0BerCX15XZfvy9YgkbHMCSJ5XhC0o+cnVX+Q
l/WcBsqxttF0vPo1AqxR0Pb38rBPCg==
=5mT9
-----END PGP SIGNATURE-----

--=-E3qV2JTgigT6ELVlkBvg--

