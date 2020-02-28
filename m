Return-Path: <SRS0=RI2K=4Q=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 79F05C3F2D2
	for <linux-kernel@archiver.kernel.org>; Fri, 28 Feb 2020 14:32:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5752A246A8
	for <linux-kernel@archiver.kernel.org>; Fri, 28 Feb 2020 14:32:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727075AbgB1Oc2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 28 Feb 2020 09:32:28 -0500
Received: from shelob.surriel.com ([96.67.55.147]:49700 "EHLO
        shelob.surriel.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726694AbgB1Oc1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Feb 2020 09:32:27 -0500
Received: from imladris.surriel.com ([96.67.55.152])
        by shelob.surriel.com with esmtpsa (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256)
        (Exim 4.92.3)
        (envelope-from <riel@shelob.surriel.com>)
        id 1j7gge-0006Uf-MS; Fri, 28 Feb 2020 09:32:20 -0500
Message-ID: <47198271414db19cecbfa1a6ea685577dad3a72c.camel@surriel.com>
Subject: Re: [PATCH v2 2/2] mm,thp,compaction,cma: allow THP migration for
 CMA allocations
From:   Rik van Riel <riel@surriel.com>
To:     Vlastimil Babka <vbabka@suse.cz>,
        Mike Kravetz <mike.kravetz@oracle.com>,
        linux-kernel@vger.kernel.org
Cc:     kernel-team@fb.com, akpm@linux-foundation.org, linux-mm@kvack.org,
        mhocko@kernel.org, mgorman@techsingularity.net,
        rientjes@google.com, aarcange@redhat.com, ziy@nvidia.com
Date:   Fri, 28 Feb 2020 09:32:04 -0500
In-Reply-To: <67185d77-87aa-400d-475c-4435d8b7be11@suse.cz>
References: <cover.1582321646.git.riel@surriel.com>
         <20200227213238.1298752-2-riel@surriel.com>
         <df83c62f-209f-b1fd-3a5c-c81c82cb2606@oracle.com>
         <7800e98e3688c124ac3672284b87d67321e1c29e.camel@surriel.com>
         <67185d77-87aa-400d-475c-4435d8b7be11@suse.cz>
Content-Type: multipart/signed; micalg="pgp-sha256";
        protocol="application/pgp-signature"; boundary="=-y/7ndlqWhwsZ6DQBptKq"
User-Agent: Evolution 3.34.3 (3.34.3-1.fc31) 
MIME-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--=-y/7ndlqWhwsZ6DQBptKq
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, 2020-02-28 at 09:25 +0100, Vlastimil Babka wrote:
> On 2/28/20 2:21 AM, Rik van Riel wrote:
> > On Thu, 2020-02-27 at 15:41 -0800, Mike Kravetz wrote:
> > > On 2/27/20 1:32 PM, Rik van Riel wrote:
> > > > +++ b/mm/page_alloc.c
> > > > @@ -8253,14 +8253,19 @@ struct page *has_unmovable_pages(struct
> > > > zone *zone, struct page *page,
> > > > =20
> > > >  		/*
> > > >  		 * Hugepages are not in LRU lists, but they're
> > > > movable.
> > > > +		 * THPs are on the LRU, but need to be counted
> > > > as
> > > > #small pages.
> > > >  		 * We need not scan over tail pages because we
> > > > don't
> > > >  		 * handle each tail page individually in
> > > > migration.
> > > >  		 */
> > > > -		if (PageHuge(page)) {
> > > > +		if (PageHuge(page) || PageTransCompound(page))
> > > > {
> > > >  			struct page *head =3D
> > > > compound_head(page);
> > > >  			unsigned int skip_pages;
> > > > =20
> > > > -			if
> > > > (!hugepage_migration_supported(page_hstate(head)))
> > > > +			if (PageHuge(page) &&
> > > > +			    !hugepage_migration_supported(page_
> > > > hstate(h
> > > > ead)))
> > > > +				return page;
> > > > +
> > > > +			if (!PageLRU(head) &&
> > > > !__PageMovable(head))
> > >=20
> > > Pretty sure this is going to be true for hugetlb pages.  So, this
> > > will change
> > > behavior and make all hugetlb pages look unmovable.  Perhaps,
> > > only
> > > check this
> > > condition for THP pages?
>=20
> Oh right you are.
>=20
> > Does that need to be the following, then?
> >=20
> >      if (PageTransHuge(head) && !PageHuge(page) && !PageLRU(head)
> > &&
> > !__PageMovable(head))
> >                  return page;
>=20
> I would instead make it an "else if" to the "if (PageHuge(page)...)"
> above.

That was my first thought too, but that could break on
pages that are PageHuge when hugepage_migration_supported
returns true.

--=20
All Rights Reversed.

--=-y/7ndlqWhwsZ6DQBptKq
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part
Content-Transfer-Encoding: 7bit

-----BEGIN PGP SIGNATURE-----

iQEzBAABCAAdFiEEKR73pCCtJ5Xj3yADznnekoTE3oMFAl5ZJGQACgkQznnekoTE
3oNXLwgAqvXeuLmGzd0RhDnDwPGxGSbF9BXHxPUdd4pkgLQ19YJDy4KjiqJ4Qygn
OywW3UgFi9K9FwKZsbA3ZIID8+mm1H9qmTAaTMlzq7ItnexGARXvynJcmiUWt1lb
OgLKf4dnLT3k6naB2ebO6S+Qkxro08JwIhKbA3ATCZkJcGRSNZDqIsvL8PPHf0+3
Z+TLUyvEEQnmqRUCVcgrBPXsSig0Uh2zq3V0BmdCSK4q9/UdKgyd9xrxueJtkj3R
q4zyOEvB01b0lCR6Wue6FCDPLaEKq3NZ44dw/VYFFy+q6Qs+Poy7g1UGz22vAoWo
OnJFOG6XoOg2MbLlKhVuZvkIdDg7uQ==
=Lf9E
-----END PGP SIGNATURE-----

--=-y/7ndlqWhwsZ6DQBptKq--

