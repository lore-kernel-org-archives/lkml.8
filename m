Return-Path: <SRS0=ZArZ=BW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8AFCAC433DF
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Aug 2020 16:29:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6BB4D2076B
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Aug 2020 16:29:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726684AbgHLQ3A (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 12 Aug 2020 12:29:00 -0400
Received: from mx2.suse.de ([195.135.220.15]:40962 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726515AbgHLQ3A (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Aug 2020 12:29:00 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 03110AE07;
        Wed, 12 Aug 2020 16:29:20 +0000 (UTC)
Date:   Wed, 12 Aug 2020 18:28:54 +0200
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
Message-ID: <20200812162854.GA19777@blackbody.suse.cz>
References: <20200623184515.4132564-1-guro@fb.com>
 <20200623184515.4132564-5-guro@fb.com>
 <20200729171039.GA22229@blackbody.suse.cz>
 <20200806211603.195727c03995c3a25ffc6d76@linux-foundation.org>
 <20200807043717.GA1231562@carbon.DHCP.thefacebook.com>
 <20200811144754.GA45201@blackbook>
 <20200811165527.GA1507044@carbon.DHCP.thefacebook.com>
 <20200811183225.GA62582@blackbook>
 <20200811193228.GC1507044@carbon.DHCP.thefacebook.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="2oS5YaxWCcQjTEyO"
Content-Disposition: inline
In-Reply-To: <20200811193228.GC1507044@carbon.DHCP.thefacebook.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--2oS5YaxWCcQjTEyO
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Tue, Aug 11, 2020 at 12:32:28PM -0700, Roman Gushchin <guro@fb.com> wrote:
> If we'll limit init.slice (where systemd seems to reside), as you suggest,
> we'll eventually create trashing in init.slice, followed by OOM.
> I struggle to see how it makes the life of a user better?
> [...]
> The problem is that OOM-killing the accompanying manager won't release
> resources and help to get rid of accumulated cgroups.
I see your point now. I focused on the creator because of the live
memcgs.

When the issue are the dying memcgs (c), they were effectively released
by their creator but are pinned by whatever remained after their life
(LRU pages, slab->obj_cgroups). Since these pins were created _from
within_ such a child (c), they're most readily removable by reclaiming
(hierarchically) close to c. (It'd be achievable by limiting the lowest
common ancestor of manager and its product (typically root) but that is
more clumsy and less effective.)

This is the reasoning that justifies the remote charge.

Thanks!
Michal

--2oS5YaxWCcQjTEyO
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEEoQaUCWq8F2Id1tNia1+riC5qSgFAl80GMIACgkQia1+riC5
qSh2FQ/7BWPW4IIs0OxCwGkMzqA43de67xmmtP3YfCPgCsnei4a1kX60z7VKOaUq
slHtmgKJ5XipIOW33ierySBV3WiYH7jW13cIfM5xneld+iJZ7TLYWfbB6KL8jmpy
4jkRqYXoYN1E/qAOMZ1Xw1wlNcrbM8yUy4seRF5ihXt5y2at/Vze4WGEkfMJ2c5Z
hU0ECsZ/A22BO0DTYhXrziVzWvW5tKxYWHKiP7lk4jw/EQIQaVyeZY5kSoEYe9zi
tJrEceVY0Ig693KkVCEl54tOJ9s+3QisKgTBKybbhf+7+TdRmy+qLGYOhFQE0bI2
R2zRYQPSEkLNsfShLzcqa/sD0KjXYxP3qetffouyVv49RkViaZ6NBsl0Fekg/Hx2
Caxc395K1Opo1gp+H3xwgMfBbeoboNZVnvPFqpigVsDu1XUddQeGL+PKF6c1FEHX
Z3HnpRiTM6t5r0HHRtHzwIDkCnEfRXJxMNxezRvTPEorn9+6vC6w9JNxsvc+flUV
tPDjn9tYvh8CfL0DoeUfu9HlynsS0JMZ2ASRxwATtE19Z05OS5Ij+o/yS5jMt4E2
nCWeJ8v8xujJEQG95WRoVajr9WfFf2DuxiHRRnDZ9fSDu1FT81SS4IRX/lbLwe1f
xxw4SvlDzI53itdajr6khrV1BFAA/3rPceGue25c8uplLZEBx/w=
=oKPI
-----END PGP SIGNATURE-----

--2oS5YaxWCcQjTEyO--
