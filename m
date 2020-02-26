Return-Path: <SRS0=/Zd0=4O=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A1BC7C4BA1E
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Feb 2020 17:53:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 77C30206E6
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Feb 2020 17:53:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727066AbgBZRxV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 26 Feb 2020 12:53:21 -0500
Received: from shelob.surriel.com ([96.67.55.147]:32920 "EHLO
        shelob.surriel.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726765AbgBZRxV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Feb 2020 12:53:21 -0500
Received: from imladris.surriel.com ([96.67.55.152])
        by shelob.surriel.com with esmtpsa (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256)
        (Exim 4.92.3)
        (envelope-from <riel@shelob.surriel.com>)
        id 1j70s0-0008P5-Ix; Wed, 26 Feb 2020 12:53:16 -0500
Message-ID: <bd867dba881347a21757fba908f48a6e23e72439.camel@surriel.com>
Subject: Re: [PATCH 2/2] mm,thp,compaction,cma: allow THP migration for CMA
 allocations
From:   Rik van Riel <riel@surriel.com>
To:     Vlastimil Babka <vbabka@suse.cz>, linux-kernel@vger.kernel.org
Cc:     kernel-team@fb.com, akpm@linux-foundation.org, linux-mm@kvack.org,
        mhocko@kernel.org, mgorman@techsingularity.net,
        rientjes@google.com, aarcange@redhat.com
Date:   Wed, 26 Feb 2020 12:53:16 -0500
In-Reply-To: <81c8d2fa-a8ae-82b8-f359-bba055fbff68@suse.cz>
References: <cover.1582321645.git.riel@surriel.com>
         <3289dc5e6c4c3174999598d8293adf8ed3e93b57.1582321645.git.riel@surriel.com>
         <05027092-a43e-756f-4fee-78f29a048ca1@suse.cz>
         <b3529cfa33f55d47aa2e017c8b0291395c302a02.camel@surriel.com>
         <81c8d2fa-a8ae-82b8-f359-bba055fbff68@suse.cz>
Content-Type: multipart/signed; micalg="pgp-sha256";
        protocol="application/pgp-signature"; boundary="=-t9zdfWG5XcRqe4x+Yg9s"
User-Agent: Evolution 3.34.3 (3.34.3-1.fc31) 
MIME-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--=-t9zdfWG5XcRqe4x+Yg9s
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, 2020-02-26 at 10:48 +0100, Vlastimil Babka wrote:
> On 2/25/20 7:44 PM, Rik van Riel wrote:
> > > Also PageTransHuge() is basically just a PageHead() so for each
> > > non-hugetlbfs compound page this will assume it's a THP, while
> > > correctly
> > > it should reach the __PageMovable() || PageLRU(page) tests below.
> > >=20
> > > So probably this should do something like.
> > >=20
> > > if (PageHuge(page) || PageTransCompound(page)) {
> > > ...
> > >    if (PageHuge(page) && !hpage_migration_supported)) return
> > > page.
> >=20
> > So far so good.
> >=20
> > >    if (!PageLRU(head) && !__PageMovable(head)) return page
> >=20
> > I don't get this one, though. What about a THP that has
> > not made it onto the LRU list yet for some reason?
>=20
> Uh, is it any different from base pages which have to pass the same
> check? I
> guess the caller could do e.g. lru_add_drain_all() first.

You are right, it is not different.

As for lru_add_drain_all(), I wonder at what point that
should happen?

It appears that the order in which things are done does
not really provide a good moment:
1) decide to attempt allocating a range of memory
2) scan each page block for unmovable pages
3) if no unmovable pages are found, mark the page block
   MIGRATE_ISOLATE

I wonder if we should do things the opposite way, first
marking the page block MIGRATE_ISOLATE (to prevent new
allocations), then scanning it, and calling lru_add_drain_all
if we encounter a page that looks like it could benefit from
that.

If we still see unmovable pages after that, it is cheap
enough to set the page block back to its previous state.

> > I don't think anonymous pages are marked __PageMovable,
> > are they? It looks like they only have the PAGE_MAPPING_ANON
> > flag set, not the PAGE_MAPPING_MOVABLE one.
> >=20
> > What am I missing?
>=20
> My point is that we should not accept compound pages that are neither
> a
> migratable hugetlbfs page nor a THP, as movable.

I have merged your suggestions into my code base. Thank
you for pointing out that 4kB pages have the exact same
restrictions as THPs, and why.

I'll run some tests and will post v2 of the series soon.

--=20
All Rights Reversed.

--=-t9zdfWG5XcRqe4x+Yg9s
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part
Content-Transfer-Encoding: 7bit

-----BEGIN PGP SIGNATURE-----

iQEzBAABCAAdFiEEKR73pCCtJ5Xj3yADznnekoTE3oMFAl5WsIwACgkQznnekoTE
3oPmYQf+IdLWdhToGGwYGNtVh1aGC98lpNsEf625QKc/kFP9s8eF9D3sc5lfh+a5
h+2sSpxBcMnGrdxfyvJBcbo5GN9UH2KANFxub4CiglZ4ev/OaQ02LQzw8SaDcGcr
L2Lb1ZdNak+o9LRcmRlZ6MIkImc4jDDC6EQ0p+xS/zZfurrvKypGi+upQy8TngQs
FxuNXPIikQyZk3kFY6HAilHTxYy39x0EzYVy4sp3cbU+sZHiH1ZXh8rQ8ZaXTquK
oQV2hEvXHpfgpQTS0qtb4nmXBSF98TAXUv5XCbNl3rhqUSBWPAM1U9YLk7tk6VJk
MSm2iBqF82eba7RdYdJGkjnpeDfc4Q==
=F0AS
-----END PGP SIGNATURE-----

--=-t9zdfWG5XcRqe4x+Yg9s--

