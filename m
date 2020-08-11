Return-Path: <SRS0=vr6t=BV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 427CBC433DF
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Aug 2020 18:32:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2568320774
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Aug 2020 18:32:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726114AbgHKScc (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 11 Aug 2020 14:32:32 -0400
Received: from mx2.suse.de ([195.135.220.15]:59904 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725862AbgHKScc (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Aug 2020 14:32:32 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 87132AC82;
        Tue, 11 Aug 2020 18:32:51 +0000 (UTC)
Date:   Tue, 11 Aug 2020 20:32:25 +0200
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
Message-ID: <20200811183225.GA62582@blackbook>
References: <20200623184515.4132564-1-guro@fb.com>
 <20200623184515.4132564-5-guro@fb.com>
 <20200729171039.GA22229@blackbody.suse.cz>
 <20200806211603.195727c03995c3a25ffc6d76@linux-foundation.org>
 <20200807043717.GA1231562@carbon.DHCP.thefacebook.com>
 <20200811144754.GA45201@blackbook>
 <20200811165527.GA1507044@carbon.DHCP.thefacebook.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="k1lZvvs/B4yU6o8G"
Content-Disposition: inline
In-Reply-To: <20200811165527.GA1507044@carbon.DHCP.thefacebook.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--k1lZvvs/B4yU6o8G
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Aug 11, 2020 at 09:55:27AM -0700, Roman Gushchin <guro@fb.com> wrot=
e:
> As I said, there are 2 problems with charging systemd (or a similar daemo=
n):
> 1) It often belongs to the root cgroup.
This doesn't hold for systemd (if we agree that systemd is the most
common case).

> 2) OOMing or failing some random memory allocations is a bad way
>    to "communicate" a memory shortage to the daemon.
>    What we really want is to prevent creating a huge number of cgroups
There's cgroup.max.descendants for that...

>    (including dying cgroups) in some specific sub-tree(s).
=2E..oh, so is this limiting the number of cgroups or limiting resources
used?

>    OOMing the daemon or returning -ENOMEM to some random syscalls
>    will not help us to reach the goal and likely will bring a bad
>    experience to a user.
If we reach the situation when memory for cgroup operations is tight,
it'll disappoint the user either way.
My premise is that a running workload is more valuable than the
accompanying manager.

> In a generic case I don't see how we can charge the cgroup which
> creates cgroups without solving these problems first.
In my understanding, "onbehalveness" is a concept useful for various
kernel threads doing deferred work. Here it's promoted to user processes
managing cgroups.

> And if there is a very special case where we have to limit it,
> we can just add an additional layer:
>=20
> ` root or delegated root
>    ` manager-parent-cgroup-with-a-limit
>      ` manager-cgroup (systemd, docker, ...)
>    ` [aggregation group(s)]
>      ` job-group-1
>      ` ...
>      ` job-group-n
If the charge goes to the parent of created cgroup (job-cgroup-i here),
then the layer adds nothing. Am I missing something?

> I'd definitely charge the parent cgroup in all similar cases.
(This would mandate the controllers on the unified hierarchy, which is
fine IMO.) Then the order of enabling controllers on a subtree (e.g.
cpu,memory vs memory,cpu) by the manager would yield different charging.
This seems wrong^W confusing to me.=20


Thanks,
Michal

--k1lZvvs/B4yU6o8G
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEEoQaUCWq8F2Id1tNia1+riC5qSgFAl8y5DUACgkQia1+riC5
qShkEQ/+Nm08BsWmxXI72rR1oe/Tct4+M6N4pnmGnkh53373/NHFMIFRIVPANXyO
bgafqQlVbpSnTT6wemU9fj/DCZp/CCR3fepcT7aoauQacOlPvlf579Hrhj7RU8hI
h3PwqWwoUD9iK1V1hHZk+kEysHQx3y4N7UQfav4LtjlIqnHvzb9VfK8hjARtR1R+
i2t15zS9EEscmctY5Fx1uvnjzbpllj6MSJH8fhOi/5axW8b5pCfrvZ4pFUnB2t9Q
CuKwWSidDmg9+Q+/xegZ12h3t+X+a/T+O+g9uH2D0R/28VexpI0MpzaOtpsXlQIb
V4CPOGK9Glx3iPNc4IAPl1NHcusink/2RWBHKRkzCPS8gTywLKDFrilAtQ11y010
C0jjixQXO8of8OmktELfaqV7XUNgDru8TFpCQMAJOuyZ8Kt+1MxywRfNlieIsChJ
NaMtXA6N72GrIIC+IFK1W+e4rTeuAnrolBg+KG7cgSAF1HgopyfyQvskaIlJcSzb
qxawQebRsJx52Wz3NmHuHabefaua2n6Zuw8k/Ac0GBum4D7vxvmgpuKPXQjhqs5l
plYP7ueHP3gxRSW32ho0sHtW9qB7+cReHPXN/FFTye7ICZ50N4bT4oWQpZh8vNBM
ws9M9jzGjB+9QKDeECIDA7s0H9XJDMKVkXIS4RbdhLe2twuexOs=
=4/65
-----END PGP SIGNATURE-----

--k1lZvvs/B4yU6o8G--
