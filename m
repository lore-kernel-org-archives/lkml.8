Return-Path: <SRS0=iZCi=CS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4DF27C43461
	for <linux-kernel@archiver.kernel.org>; Wed,  9 Sep 2020 17:19:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0E717206D4
	for <linux-kernel@archiver.kernel.org>; Wed,  9 Sep 2020 17:19:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730994AbgIIRTG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 9 Sep 2020 13:19:06 -0400
Received: from shelob.surriel.com ([96.67.55.147]:45678 "EHLO
        shelob.surriel.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726440AbgIIP12 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Sep 2020 11:27:28 -0400
Received: from imladris.surriel.com ([96.67.55.152])
        by shelob.surriel.com with esmtpsa  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.94)
        (envelope-from <riel@shelob.surriel.com>)
        id 1kG0TE-0004A3-Qr; Wed, 09 Sep 2020 09:49:08 -0400
Message-ID: <4923e178c12f38148a2620ba31fcded349e555fb.camel@surriel.com>
Subject: Re: [RFC PATCH 00/16] 1GB THP support on x86_64
From:   Rik van Riel <riel@surriel.com>
To:     David Hildenbrand <david@redhat.com>,
        Michal Hocko <mhocko@suse.com>
Cc:     Zi Yan <ziy@nvidia.com>, Roman Gushchin <guro@fb.com>,
        "Kirill A. Shutemov" <kirill@shutemov.name>, linux-mm@kvack.org,
        "Kirill A . Shutemov" <kirill.shutemov@linux.intel.com>,
        Matthew Wilcox <willy@infradead.org>,
        Shakeel Butt <shakeelb@google.com>,
        Yang Shi <yang.shi@linux.alibaba.com>,
        David Nellans <dnellans@nvidia.com>,
        linux-kernel@vger.kernel.org
Date:   Wed, 09 Sep 2020 09:49:08 -0400
In-Reply-To: <6135d2c5-2a74-6ca8-4b3b-8ceb25c0d4b1@redhat.com>
References: <20200902180628.4052244-1-zi.yan@sent.com>
         <20200903142300.bjq2um5y5nwocvar@box>
         <20200903163020.GG60440@carbon.dhcp.thefacebook.com>
         <8e677ead-206d-08dd-d73e-569bd3803e3b@redhat.com>
         <7E20392E-5ED7-4C22-9555-F3BAABF3CBE9@nvidia.com>
         <20200908143503.GE26850@dhcp22.suse.cz>
         <7ed82cb06074b30c2956638082c515fb179f69a3.camel@surriel.com>
         <20200909070445.GA7348@dhcp22.suse.cz>
         <054d02f3b34d9946905929ff268b685c91494b3e.camel@surriel.com>
         <6135d2c5-2a74-6ca8-4b3b-8ceb25c0d4b1@redhat.com>
Content-Type: multipart/signed; micalg="pgp-sha256";
        protocol="application/pgp-signature"; boundary="=-wpHNEj3y3TgmHwDLJS21"
User-Agent: Evolution 3.34.4 (3.34.4-1.fc31) 
MIME-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--=-wpHNEj3y3TgmHwDLJS21
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, 2020-09-09 at 15:43 +0200, David Hildenbrand wrote:
> On 09.09.20 15:19, Rik van Riel wrote:
> > On Wed, 2020-09-09 at 09:04 +0200, Michal Hocko wrote:
> >=20
> > > That CMA has to be pre-reserved, right? That requires a
> > > configuration.
> >=20
> > To some extent, yes.
> >=20
> > However, because that pool can be used for movable
> > 4kB and 2MB
> > pages as well as for 1GB pages, it would be easy to just set
> > the size of that pool to eg. 1/3 or even 1/2 of memory for every
> > system.
> >=20
> > It isn't like the pool needs to be the exact right size. We
> > just need to avoid the "highmem problem" of having too little
> > memory for kernel allocations.
> >=20
>=20
> I am not sure I like the trend towards CMA that we are seeing,
> reserving
> huge buffers for specific users (and eventually even doing it
> automatically).
>=20
> What we actually want is ZONE_MOVABLE with relaxed guarantees, such
> that
> anybody who requires large, unmovable allocations can use it.
>=20
> I once played with the idea of having ZONE_PREFER_MOVABLE, which
> a) Is the primary choice for movable allocations
> b) Is allowed to contain unmovable allocations (esp., gigantic pages)
> c) Is the fallback for ZONE_NORMAL for unmovable allocations, instead
> of
> running out of memory
>=20
> If someone messes up the zone ratio, issues known from zone
> imbalances
> are avoided - large allocations simply become less likely to succeed.
> In
> contrast to ZONE_MOVABLE, memory offlining is not guaranteed to work.

I really like that idea. This will be easier to deal with than
a "just the right size" CMA area, and seems like it would be
pretty forgiving in both directions.

Keeping unmovable allocations
contained to one part of memory
should also make compaction within the ZONE_PREFER_MOVABLE area
a lot easier than compaction for higher order allocations is
today.

I suspect your proposal solves a lot of issues at once.

For (c) from your proposal, we could even claim a whole
2MB or even 1GB area at once for unmovable allocations,
keeping those contained in a limited amount of physical
memory again, to make life easier on compaction.

--=20
All Rights Reversed.

--=-wpHNEj3y3TgmHwDLJS21
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part
Content-Transfer-Encoding: 7bit

-----BEGIN PGP SIGNATURE-----

iQEzBAABCAAdFiEEKR73pCCtJ5Xj3yADznnekoTE3oMFAl9Y3VQACgkQznnekoTE
3oMMdwgAkZ9yHAJX87rT4KEdtozUgeiv+oJmpMGrFoxuLJusQjDHWmoH/cZxeUKa
LAyR1o25+vHitFDI8jwBSrK/koD7+aA7g4IWD1yvm+MzMLRE1y3O2mpdT5Py2P/R
p3zFYlMWaVnons/88lpBVXg4s25BUo1l8oU3Zpo1nIbW6gAW0GLT4k3HrgT1eMoU
q9FGjN5fg/COFrfFMkxXheD6g3V6AwSo/7/4jSccaeyxOmyf9D+hiCLYkWOFNvg7
9oz/5K3dekoWR88c5C6hTrr69D32grG8SRk6iqsGAa7CG/HoYFnePOLN7BcI7Wp5
BJ18+VOF8ozRMrFAuvBoSH3ZVOmPhg==
=+JlE
-----END PGP SIGNATURE-----

--=-wpHNEj3y3TgmHwDLJS21--

