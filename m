Return-Path: <SRS0=1210=4J=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 75E01C35641
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Feb 2020 22:35:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 52FFC206EF
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Feb 2020 22:35:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728792AbgBUWfW (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 21 Feb 2020 17:35:22 -0500
Received: from shelob.surriel.com ([96.67.55.147]:46516 "EHLO
        shelob.surriel.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726731AbgBUWfW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Feb 2020 17:35:22 -0500
Received: from imladris.surriel.com ([96.67.55.152])
        by shelob.surriel.com with esmtpsa (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256)
        (Exim 4.92.3)
        (envelope-from <riel@shelob.surriel.com>)
        id 1j5GtD-0003s1-6Q; Fri, 21 Feb 2020 17:35:19 -0500
Message-ID: <67d927c6161b15664b4a912ad34fc3a147109760.camel@surriel.com>
Subject: Re: [PATCH 2/2] mm,thp,compaction,cma: allow THP migration for CMA
 allocations
From:   Rik van Riel <riel@surriel.com>
To:     Zi Yan <ziy@nvidia.com>
Cc:     linux-kernel@vger.kernel.org, kernel-team@fb.com,
        akpm@linux-foundation.org, linux-mm@kvack.org, mhocko@kernel.org,
        vbabka@suse.cz, mgorman@techsingularity.net, rientjes@google.com,
        aarcange@redhat.com
Date:   Fri, 21 Feb 2020 17:35:15 -0500
In-Reply-To: <FF5B51C0-8D6E-47AB-82C8-020D5C522502@nvidia.com>
References: <cover.1582321645.git.riel@surriel.com>
         <3289dc5e6c4c3174999598d8293adf8ed3e93b57.1582321645.git.riel@surriel.com>
         <FF5B51C0-8D6E-47AB-82C8-020D5C522502@nvidia.com>
Content-Type: multipart/signed; micalg="pgp-sha256";
        protocol="application/pgp-signature"; boundary="=-N3fCwb3Sg4Ms25pOkexS"
User-Agent: Evolution 3.34.3 (3.34.3-1.fc31) 
MIME-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--=-N3fCwb3Sg4Ms25pOkexS
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, 2020-02-21 at 17:31 -0500, Zi Yan wrote:
> On 21 Feb 2020, at 16:53, Rik van Riel wrote:
>=20
> > +++ b/mm/compaction.c
> > @@ -894,12 +894,12 @@ isolate_migratepages_block(struct
> > compact_control *cc, unsigned long low_pfn,
> >=20
> >  		/*
> >  		 * Regardless of being on LRU, compound pages such as
> > THP and
> > -		 * hugetlbfs are not to be compacted. We can
> > potentially save
> > -		 * a lot of iterations if we skip them at once. The
> > check is
> > -		 * racy, but we can consider only valid values and the
> > only
> > -		 * danger is skipping too much.
> > +		 * hugetlbfs are not to be compacted most of the time.
> > We can
> > +		 * potentially save a lot of iterations if we skip them
> > at
> > +		 * once. The check is racy, but we can consider only
> > valid
> > +		 * values and the only danger is skipping too much.
> >  		 */
>=20
> Maybe add =E2=80=9Cwe do want to move them when allocating contiguous mem=
ory
> using CMA=E2=80=9D to help
> people understand the context of using cc->alloc_contig?

I can certainly do that.

I'll wait for feedback from other people to see if
more changes are wanted, and plan to post v2 by
Tuesday or so :)

--=20
All Rights Reversed.

--=-N3fCwb3Sg4Ms25pOkexS
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part
Content-Transfer-Encoding: 7bit

-----BEGIN PGP SIGNATURE-----

iQEzBAABCAAdFiEEKR73pCCtJ5Xj3yADznnekoTE3oMFAl5QWyMACgkQznnekoTE
3oNG4Qf+NIlz59enImNBYGxlLc+a6Zw6OUfHlPKtL3xXWApRER8KxyzqehnAaDHD
2SyRCoaOObt30qL9telaoqfinbnZP57ud4cpuUrhZ6R/EPYvhWmPzOCuy/ON8n1q
J3+SPHSHIdpO0yLqECbkjh8yqqcgeH4MRzvAkUlJ5sl7zLzMUcXLM4lAMRIPP3bE
t3GEAVk32mZlYWVowBgYbqTXOPdvha/nJpqpQVOHqLXKDxho/GgXmBzBxqk/JTPd
HOHmd9VCOgdmMiylg+s+WVaEP4iGJkE+QrtywHtKVwvYCyOdcTp5d6vAK0Dv85a3
2CU5VojKKKWQL74efpSrnIrmMdGGqQ==
=/pq0
-----END PGP SIGNATURE-----

--=-N3fCwb3Sg4Ms25pOkexS--

