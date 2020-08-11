Return-Path: <SRS0=vr6t=BV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 25632C433DF
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Aug 2020 14:48:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 097722078E
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Aug 2020 14:48:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728907AbgHKOsB (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 11 Aug 2020 10:48:01 -0400
Received: from mx2.suse.de ([195.135.220.15]:47112 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728794AbgHKOsA (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Aug 2020 10:48:00 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id CB4FAACDF;
        Tue, 11 Aug 2020 14:48:19 +0000 (UTC)
Date:   Tue, 11 Aug 2020 16:47:54 +0200
From:   Michal =?iso-8859-1?Q?Koutn=FD?= <mkoutny@suse.com>
To:     Roman Gushchin <guro@fb.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Dennis Zhou <dennis@kernel.org>, Tejun Heo <tj@kernel.org>,
        Christoph Lameter <cl@linux.com>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Michal Hocko <mhocko@kernel.org>,
        Shakeel Butt <shakeelb@google.com>, linux-mm@kvack.org,
        kernel-team@fb.com, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 4/5] mm: memcg: charge memcg percpu memory to the
 parent cgroup
Message-ID: <20200811144754.GA45201@blackbook>
References: <20200623184515.4132564-1-guro@fb.com>
 <20200623184515.4132564-5-guro@fb.com>
 <20200729171039.GA22229@blackbody.suse.cz>
 <20200806211603.195727c03995c3a25ffc6d76@linux-foundation.org>
 <20200807043717.GA1231562@carbon.DHCP.thefacebook.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="lrZ03NoBR/3+SXJZ"
Content-Disposition: inline
In-Reply-To: <20200807043717.GA1231562@carbon.DHCP.thefacebook.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--lrZ03NoBR/3+SXJZ
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Aug 06, 2020 at 09:37:17PM -0700, Roman Gushchin <guro@fb.com> wrot=
e:
> In general, yes. But in this case I think it wouldn't be a good idea:
> most often cgroups are created by a centralized daemon (systemd),
> which is usually located in the root cgroup. Even if it's located not in
> the root cgroup, limiting it's memory will likely affect the whole system,
> even if only one specific limit was reached.
The generic scheme would be (assuming the no internal process
constraint, in the root too)

` root or delegated root
  ` manager-cgroup (systemd, docker, ...)
  ` [aggregation group(s)]
    ` job-group-1
    ` ...
    ` job-group-n

> If there is a containerized workload, which creates sub-cgroups,
> charging it's parent cgroup is perfectly effective.
No dispute about this in either approaches.

> And the opposite, if we'll charge the cgroup of a process, who created
> a cgroup, we'll not cover the most common case: systemd creating
> cgroups for all services in the system.
What I mean is that systemd should be charged for the cgroup creation.
Or more generally, any container/cgroup manager should be charged.
Consider a leak when it wouldn't remove spent cgroups, IMO the effect
(throttling, reclaim) should be exercised on such a culprit.

I don't think the existing workload (job-group-i above) should
unnecessarily suffer when only manager is acting up. Is that different
=66rom your idea?

> Right, but it's quite unusual for tasks from one cgroup to create sub-cgr=
oups
> in completely different cgroup. In this particular case there are tons of=
 other
> ways how a task from C00 can hurt C1.
I agree with that.


If I haven't overlooked anything, this should be first case when
cgroup-related structures are accounted (please correct me).
So this is setting a precendent, if others show useful to be accounted
in the future too. I'm thinking about cpu_cgroup_css_alloc() that can
also allocate a lot (with big CPU count). The current approach would lead
situations where matching cpu and memory csses needn't to exist and that
would need special handling.


> On Thu, Aug 06, 2020 at 09:16:03PM -0700, Andrew Morton wrote:
> > These week-old issues appear to be significant.  Roman?  Or someone
> > else?
Despite my concerns, I don't think this is fundamental and can't be
changed later so it doesn't prevent the inclusion in 5.9 RC1.

Regards,
Michal

--lrZ03NoBR/3+SXJZ
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEEoQaUCWq8F2Id1tNia1+riC5qSgFAl8yr5UACgkQia1+riC5
qSgqkg/+MCv3Rc5uG81ZfD7sWfTTfN12Pj2O+whAoYgOXvsv+JD1PsezvdVdwb3C
oNH/HYMbJBNUkrz/9/pq53kJIIzq2UQ+cEbEatMy8T0kjImYn0Ark4JEF+R43egy
gaYf26ABfNYxu+r+/aOPdnWx2yL9aeK3o0L9jyWxJhe6EqThSi+9eONCwA/j1fsZ
/xhlhoojWC2hRVD18xG3xk3pIRCaYqYPq+NBNamnYiUcwrJ3/lE1VDawjWALSG+D
3PvxjphzJok0Ou+5Nxzh14jfYyXtPMkitHsq3+wA/nEjJWsbxY3AA9E8LG5gkMbe
g5SG3N7clGWF+MqfHoGjIF6LUreF5mD+dDWGkovs9vWmA5WRAMZh9RhxFKD6QyXd
7437kkZxWWiut9AkWkp2iXqLjT1gY65lRHFIiELXIid71k0tVKNUe6Xy8OlVSOPv
yFHC5EhDeWwwEI2FBCtlPP+7nwd0o5tZreYuyCyC1hroDWWiGa23z6u7Uin9pjON
/qPGHkKid2E9EK6tS47cblvSXdpzO1Gc37hVZjrPsx2esdhumlQkZGJsgFh1kmRD
v2Q8BZDTLnxdWzVFFpeHO4gToni/MbwHYYf98JjF8YLMtn2duZtecevAPUkAtpAM
cxIITurK9Jwak8cIlPhtJaySEoHmWKI4MQrvgERh30m0Af3pqqY=
=N0tJ
-----END PGP SIGNATURE-----

--lrZ03NoBR/3+SXJZ--
