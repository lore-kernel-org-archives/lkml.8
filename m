Return-Path: <SRS0=87nF=CT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5A3B6C43461
	for <linux-kernel@archiver.kernel.org>; Thu, 10 Sep 2020 13:41:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1A72020809
	for <linux-kernel@archiver.kernel.org>; Thu, 10 Sep 2020 13:41:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730694AbgIJNhs (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 10 Sep 2020 09:37:48 -0400
Received: from shelob.surriel.com ([96.67.55.147]:49224 "EHLO
        shelob.surriel.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727770AbgIJNdb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Sep 2020 09:33:31 -0400
Received: from imladris.surriel.com ([96.67.55.152])
        by shelob.surriel.com with esmtpsa  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.94)
        (envelope-from <riel@shelob.surriel.com>)
        id 1kGMh2-0006FE-1B; Thu, 10 Sep 2020 09:32:52 -0400
Message-ID: <b3dc8cca3689ea69491370449801ffe8d828c66c.camel@surriel.com>
Subject: Re: [RFC PATCH 00/16] 1GB THP support on x86_64
From:   Rik van Riel <riel@surriel.com>
To:     Michal Hocko <mhocko@suse.com>,
        David Hildenbrand <david@redhat.com>
Cc:     Zi Yan <ziy@nvidia.com>, Roman Gushchin <guro@fb.com>,
        "Kirill A. Shutemov" <kirill@shutemov.name>, linux-mm@kvack.org,
        "Kirill A . Shutemov" <kirill.shutemov@linux.intel.com>,
        Matthew Wilcox <willy@infradead.org>,
        Shakeel Butt <shakeelb@google.com>,
        Yang Shi <yang.shi@linux.alibaba.com>,
        David Nellans <dnellans@nvidia.com>,
        linux-kernel@vger.kernel.org, Vlastimil Babka <vbabka@suse.cz>,
        Mel Gorman <mgorman@suse.de>
Date:   Thu, 10 Sep 2020 09:32:51 -0400
In-Reply-To: <20200910073213.GC28354@dhcp22.suse.cz>
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
         <20200910073213.GC28354@dhcp22.suse.cz>
Content-Type: multipart/signed; micalg="pgp-sha256";
        protocol="application/pgp-signature"; boundary="=-G7jPvQFniVHuvttGpe5D"
User-Agent: Evolution 3.34.4 (3.34.4-1.fc31) 
MIME-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--=-G7jPvQFniVHuvttGpe5D
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, 2020-09-10 at 09:32 +0200, Michal Hocko wrote:
> [Cc Vlastimil and Mel - the whole email thread starts
>  http://lkml.kernel.org/r/20200902180628.4052244-1-zi.yan@sent.com
>  but this particular subthread has diverged a bit and you might find
> it
>  interesting]
>=20
> On Wed 09-09-20 15:43:55, David Hildenbrand wrote:
> >=20
> > I am not sure I like the trend towards CMA that we are seeing,
> > reserving
> > huge buffers for specific users (and eventually even doing it
> > automatically).
> >=20
> > What we actually want is ZONE_MOVABLE with relaxed guarantees, such
> > that
> > anybody who requires large, unmovable allocations can use it.
> >=20
> > I once played with the idea of having ZONE_PREFER_MOVABLE, which
> > a) Is the primary choice for movable allocations
> > b) Is allowed to contain unmovable allocations (esp., gigantic
> > pages)
> > c) Is the fallback for ZONE_NORMAL for unmovable allocations,
> > instead of
> > running out of memory
>=20
> I might be missing something but how can this work longterm? Or put
> in
> another words why would this work any better than existing
> fragmentation
> avoidance techniques that page allocator implements already -=20

One big difference is reclaim. If ZONE_NORMAL runs low on
free memory, page reclaim would kick in and evict some
movable/reclaimable things, to free up more space for
unmovable allocations.

The current fragmentation avoidance techniques don't do
things like reclaim, or proactively migrating movable
pages out of unmovable page blocks to prevent unmovable
allocations in currently movable page blocks.

> My suspicion is that a separate zone would work in a similar fashion.
> As
> long as there is a lot of free memory then zone will be effectively
> MOVABLE. Similar applies to normal zone when unmovable allocations
> are
> in minority. As long as the Normal zone gets full of unmovable
> objects
> they start overflowing to ZONE_PREFER_MOVABLE and it will resemble
> page
> block stealing when unmovable objects start spreading over movable
> page
> blocks.

You are right, with the difference being reclaim and/or
migration, which could make a real difference in limiting
the number of pageblocks that have unmovable allocations.

--=20
All Rights Reversed.

--=-G7jPvQFniVHuvttGpe5D
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part
Content-Transfer-Encoding: 7bit

-----BEGIN PGP SIGNATURE-----

iQEzBAABCAAdFiEEKR73pCCtJ5Xj3yADznnekoTE3oMFAl9aKwMACgkQznnekoTE
3oMhTwf6AoqGVXG7ULgvW3VwQU3fHYeVY7XdxCw0eYfEWQ5mmjdh7pMVL4+9IEJS
OhK3nlbmC63C3TYpa1asQUSy6hAx0Apo/E7Cx9VJkP2+3oVkbP6ibqtZmJh4X1IQ
9HbBHX8YOxpUXl3/RHARzTo4cnwYrgQTLpumSG0B+207FmQc7zLoNsfXGXsLFPrP
I/KKiSDlQ4asbeHlQU/PW87xXNCWCyjbZedPPx98WIgQE3LeRvWD3ZhlwtEQEJXP
Xsy1hT0aKsjg9dFpWFPClDs8f+EV+gcNIqidHMXrPAIUMySGL+C/VBHKeg2ioSyB
Qu4W/1woZ6HdiWlE4jweWiTy+6RAug==
=m/ZB
-----END PGP SIGNATURE-----

--=-G7jPvQFniVHuvttGpe5D--

