Return-Path: <SRS0=g5yc=BI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6127DC433E0
	for <linux-kernel@archiver.kernel.org>; Wed, 29 Jul 2020 17:10:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3F47A206D4
	for <linux-kernel@archiver.kernel.org>; Wed, 29 Jul 2020 17:10:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726650AbgG2RKp (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 29 Jul 2020 13:10:45 -0400
Received: from mx2.suse.de ([195.135.220.15]:48132 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726336AbgG2RKo (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Jul 2020 13:10:44 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id BC4DDB61F;
        Wed, 29 Jul 2020 17:10:54 +0000 (UTC)
Date:   Wed, 29 Jul 2020 19:10:39 +0200
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
Message-ID: <20200729171039.GA22229@blackbody.suse.cz>
References: <20200623184515.4132564-1-guro@fb.com>
 <20200623184515.4132564-5-guro@fb.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="DocE+STaALJfprDB"
Content-Disposition: inline
In-Reply-To: <20200623184515.4132564-5-guro@fb.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--DocE+STaALJfprDB
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hello.

On Tue, Jun 23, 2020 at 11:45:14AM -0700, Roman Gushchin <guro@fb.com> wrot=
e:
> Because the size of memory cgroup internal structures can dramatically
> exceed the size of object or page which is pinning it in the memory, it's
> not a good idea to simple ignore it.  It actually breaks the isolation
> between cgroups.
No doubt about accounting the memory if it's significant amount.

> Let's account the consumed percpu memory to the parent cgroup.
Why did you choose charging to the parent of the created cgroup?

Should the charge go the cgroup _that is creating_ the new memcg?

One reason is that there are the throttling mechanisms for memory limits
and those are better exercised when the actor and its memory artefact
are the same cgroup, aren't they?

The second reason is based on the example Dlegation Containment
(Documentation/admin-guide/cgroup-v2.rst)

> For an example, let's assume cgroups C0 and C1 have been delegated to
> user U0 who created C00, C01 under C0 and C10 under C1 as follows and
> all processes under C0 and C1 belong to U0::
>=20
>   ~~~~~~~~~~~~~ - C0 - C00
>   ~ cgroup    ~      \ C01
>   ~ hierarchy ~
>   ~~~~~~~~~~~~~ - C1 - C10

Thanks to permissions a task running in C0 creating a cgroup in C1 would
deplete C1's supply victimizing tasks inside C1.

Thanks,
Michal

--DocE+STaALJfprDB
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEEoQaUCWq8F2Id1tNia1+riC5qSgFAl8hrYkACgkQia1+riC5
qShtTA//dhKi3k9H0xpR/7khFKk2fKfBTbe4ytbNMi6D2tazOviab/BzzzLP3CGl
TmEuiPjCMDa6wt8KolxhzyI4eSqGA3dRtMeh4NKNnuns3LvGpPT4rm+RgTq03rRO
b/KpXc8YFjhVvCRzp9JmvA15M4OrgIBCZikh5flY5AKEGmTcijop2gtOCeT7AzM8
Uo3jsO/D8lYGuWLfhb6ZNvvgqB5WcyfQWdWcSMq2LAxr3iVI3EJv5HQIkkVtE5e9
jpn+rDhgxzEk59IqzBSu7SQXuHTCfZWnQYSKMw4d64ld0cDPtOpx1ZkWhEWyqduI
nvN119dUu8ChTwjg+l1ihkcrgQSyyKZnkTMBm7lx0/cOSKjquL9JB2wgnA7kLUHn
D/WtbhcBTyal+OvlHRpFslgIV85w1keW7qooqusCglFFKDMANvEakmcH56MWSpjH
Z5AfaYqjkmLoCyBHJqGYkMH8i3uDGtiyzG/WklPcVFdgk1oUzGLXIJNzTTZ//4hj
ixm5bQFWowvtxdh6UOal1f2RCDb9hXviZ7Pnjey4yEi9Rehi/twxGSsHELNSTjxL
/AGhNpF4WAX+Q4ZYsItchDkCxdGxzsa8lIbqAjx/9vgFHkZ/zk9dZKwNNpSP0jat
JTlq2XBwqdlwvOK+JjWXCUSCzbXalVyBPaXgWT86TXwZ5TD5mp0=
=4DMX
-----END PGP SIGNATURE-----

--DocE+STaALJfprDB--
