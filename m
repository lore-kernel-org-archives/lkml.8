Return-Path: <SRS0=glOU=4X=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2EF85C10DCE
	for <linux-kernel@archiver.kernel.org>; Fri,  6 Mar 2020 22:22:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0A30B20674
	for <linux-kernel@archiver.kernel.org>; Fri,  6 Mar 2020 22:22:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726928AbgCFWWO (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 6 Mar 2020 17:22:14 -0500
Received: from shelob.surriel.com ([96.67.55.147]:43110 "EHLO
        shelob.surriel.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726704AbgCFWWN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 6 Mar 2020 17:22:13 -0500
Received: from imladris.surriel.com ([96.67.55.152])
        by shelob.surriel.com with esmtpsa (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256)
        (Exim 4.92.3)
        (envelope-from <riel@shelob.surriel.com>)
        id 1jALM9-0002eb-Ec; Fri, 06 Mar 2020 17:22:09 -0500
Message-ID: <bdd39d88a7636322d1f0c0b7a3cda8ee3f39b747.camel@surriel.com>
Subject: Re: [PATCH] mm,cma: remove pfn_range_valid_contig
From:   Rik van Riel <riel@surriel.com>
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        kernel-team@fb.com, Anshuman Khandual <anshuman.khandual@arm.com>,
        Mel Gorman <mgorman@techsingularity.net>,
        Vlastimil Babka <vbabka@suse.cz>, Qian Cai <cai@lca.pw>,
        Roman Gushchin <guro@fb.com>
Date:   Fri, 06 Mar 2020 17:22:08 -0500
In-Reply-To: <20200306170647.455a2db3@imladris.surriel.com>
References: <20200306170647.455a2db3@imladris.surriel.com>
Content-Type: multipart/signed; micalg="pgp-sha256";
        protocol="application/pgp-signature"; boundary="=-v499DhLZoYA5eMsPwnq4"
User-Agent: Evolution 3.34.3 (3.34.3-1.fc31) 
MIME-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--=-v499DhLZoYA5eMsPwnq4
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, 2020-03-06 at 17:06 -0500, Rik van Riel wrote:
> The function pfn_range_valid_contig checks whether all memory in the
> target area is free. This causes unnecessary CMA failures, since
> alloc_contig_range will migrate movable memory out of a target range,
> and has its own sanity check early on in has_unmovable_pages, which
> is called from start_isolate_page_range & set_migrate_type_isolate.
>=20
> Relying on that has_unmovable_pages call simplifies the CMA code and
> results in an increased success rate of CMA allocations.

Thinking about this some more, could we get away with
entirely removing alloc_contig_pages, and simply having
the hugetlb code use cma_alloc?

That might be simpler still.

It also seems like it could make the success rate of=20
1GB hugepage allocation much more predictable, because
the kernel will place only movable memory allocations
inside the CMA area, and we would never try to allocate
a 1GB huge page from a 1GB memory area with unmovable
pages.

It would be possible for the code in hugetlb_init() to=20
invoke the cma setup code as needed, to set aside an=20
appropriate amount of memory for movable allocations
(and later CMA 1GB hugepages) only.

Then again, if the allocation reliability ends up
being eg. 90% instead of 100%, we may need some way
to set up the memory pool for CMA hugepage allocation
a little larger, and not size it automatically to the
desired number of hugepages (with nothing to spare).

An explicit hugepage_cma=3DnG option would cover that.

Thoughts?

--=20
All Rights Reversed.

--=-v499DhLZoYA5eMsPwnq4
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part
Content-Transfer-Encoding: 7bit

-----BEGIN PGP SIGNATURE-----

iQEzBAABCAAdFiEEKR73pCCtJ5Xj3yADznnekoTE3oMFAl5izREACgkQznnekoTE
3oNtfQf+JOhaeaxAe2v88M+rVpJmW3EdtDjD/b6mvN6yRCAWlLHKmue+APtFKnxA
qYRpSdGM+qB7/wc8rcnHbcmyKEQQ6zc2+ZO1XPv1COkREcyH0k07SLb3q2ei+TTi
qloOexBM/hfvoCTWwogkrtZPyck9oJJAV0XqeJZKe9RssiLapLbogkjT0wad8rne
cQ3AdSrUDcGljCjXofIh3Fs84YFxb/WTI3PzP2eZZJeOMnIhDCEyp6aae4sMoFpb
C/RrGNQwltSUoh89eJkHtTZ1PAhz2L0wdJ/Jb6NawJhiMaNP7O/LbE2pPaIlfdfg
mcSRhTYzKOk+Obvgh189A+vWpRv/iQ==
=Qwq0
-----END PGP SIGNATURE-----

--=-v499DhLZoYA5eMsPwnq4--

