Return-Path: <SRS0=RI2K=4Q=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 022ADC3F2C6
	for <linux-kernel@archiver.kernel.org>; Fri, 28 Feb 2020 01:21:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D51272468A
	for <linux-kernel@archiver.kernel.org>; Fri, 28 Feb 2020 01:21:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730740AbgB1BVp (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 27 Feb 2020 20:21:45 -0500
Received: from shelob.surriel.com ([96.67.55.147]:46704 "EHLO
        shelob.surriel.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730463AbgB1BVp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Feb 2020 20:21:45 -0500
Received: from imladris.surriel.com ([96.67.55.152])
        by shelob.surriel.com with esmtpsa (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256)
        (Exim 4.92.3)
        (envelope-from <riel@shelob.surriel.com>)
        id 1j7ULS-0002E6-U5; Thu, 27 Feb 2020 20:21:38 -0500
Message-ID: <7800e98e3688c124ac3672284b87d67321e1c29e.camel@surriel.com>
Subject: Re: [PATCH v2 2/2] mm,thp,compaction,cma: allow THP migration for
 CMA allocations
From:   Rik van Riel <riel@surriel.com>
To:     Mike Kravetz <mike.kravetz@oracle.com>,
        linux-kernel@vger.kernel.org
Cc:     kernel-team@fb.com, akpm@linux-foundation.org, linux-mm@kvack.org,
        mhocko@kernel.org, vbabka@suse.cz, mgorman@techsingularity.net,
        rientjes@google.com, aarcange@redhat.com, ziy@nvidia.com
Date:   Thu, 27 Feb 2020 20:21:38 -0500
In-Reply-To: <df83c62f-209f-b1fd-3a5c-c81c82cb2606@oracle.com>
References: <cover.1582321646.git.riel@surriel.com>
         <20200227213238.1298752-2-riel@surriel.com>
         <df83c62f-209f-b1fd-3a5c-c81c82cb2606@oracle.com>
Content-Type: multipart/signed; micalg="pgp-sha256";
        protocol="application/pgp-signature"; boundary="=-GuN/ZXBkrY1Ye2qQ9BQv"
User-Agent: Evolution 3.34.3 (3.34.3-1.fc31) 
MIME-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--=-GuN/ZXBkrY1Ye2qQ9BQv
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, 2020-02-27 at 15:41 -0800, Mike Kravetz wrote:
> On 2/27/20 1:32 PM, Rik van Riel wrote:
> >=20
> > +++ b/mm/page_alloc.c
> > @@ -8253,14 +8253,19 @@ struct page *has_unmovable_pages(struct
> > zone *zone, struct page *page,
> > =20
> >  		/*
> >  		 * Hugepages are not in LRU lists, but they're movable.
> > +		 * THPs are on the LRU, but need to be counted as
> > #small pages.
> >  		 * We need not scan over tail pages because we don't
> >  		 * handle each tail page individually in migration.
> >  		 */
> > -		if (PageHuge(page)) {
> > +		if (PageHuge(page) || PageTransCompound(page)) {
> >  			struct page *head =3D compound_head(page);
> >  			unsigned int skip_pages;
> > =20
> > -			if
> > (!hugepage_migration_supported(page_hstate(head)))
> > +			if (PageHuge(page) &&
> > +			    !hugepage_migration_supported(page_hstate(h
> > ead)))
> > +				return page;
> > +
> > +			if (!PageLRU(head) && !__PageMovable(head))
>=20
> Pretty sure this is going to be true for hugetlb pages.  So, this
> will change
> behavior and make all hugetlb pages look unmovable.  Perhaps, only
> check this
> condition for THP pages?

Does that need to be the following, then?

     if (PageTransHuge(head) && !PageHuge(page) && !PageLRU(head) &&
!__PageMovable(head))
                 return page;

That's an easy one liner I would be happy to send in
if everybody agrees that should fix things :)

--=20
All Rights Reversed.

--=-GuN/ZXBkrY1Ye2qQ9BQv
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part
Content-Transfer-Encoding: 7bit

-----BEGIN PGP SIGNATURE-----

iQEzBAABCAAdFiEEKR73pCCtJ5Xj3yADznnekoTE3oMFAl5YayIACgkQznnekoTE
3oPx0Af/TX+zEkUxcEv+yrrOG4Jv1BzQ8b6pdaygAYaEH2MhPrSDgprArigLLmWl
2eWVDfgfoNPn1FW1//hUCZREJvTFQDd5UgtrXiCVw3qXt66mI0OfQQ6FtSh9yWM1
YV2D7uzDucuGYd16wFVeOs5XkVtNZk1o1TjCWBi1UVMScPU42HROoG3rrZ3kPEtG
JuXCdAPOq3S3s+PwyBushTVe51LNZCSFjA1lv0Y5viT52TgZU+ugySCme7wOnpb1
mT5UMkrUyjhye2TAqr0h3z8gpTYOG7uX5psZRx77l6eG89IedY/0hOAyk0MgwtSz
iqGb8+FoH3rjeRiXsrQ9JHpc/uW3ug==
=zMII
-----END PGP SIGNATURE-----

--=-GuN/ZXBkrY1Ye2qQ9BQv--

