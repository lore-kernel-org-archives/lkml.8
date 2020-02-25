Return-Path: <SRS0=NmTw=4N=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 12B4DC35E01
	for <linux-kernel@archiver.kernel.org>; Tue, 25 Feb 2020 18:44:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E794A21556
	for <linux-kernel@archiver.kernel.org>; Tue, 25 Feb 2020 18:44:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731661AbgBYSoi (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 25 Feb 2020 13:44:38 -0500
Received: from shelob.surriel.com ([96.67.55.147]:56500 "EHLO
        shelob.surriel.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731611AbgBYSoh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Feb 2020 13:44:37 -0500
Received: from imladris.surriel.com ([96.67.55.152])
        by shelob.surriel.com with esmtpsa (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256)
        (Exim 4.92.3)
        (envelope-from <riel@shelob.surriel.com>)
        id 1j6fC4-0002Wn-BC; Tue, 25 Feb 2020 13:44:32 -0500
Message-ID: <b3529cfa33f55d47aa2e017c8b0291395c302a02.camel@surriel.com>
Subject: Re: [PATCH 2/2] mm,thp,compaction,cma: allow THP migration for CMA
 allocations
From:   Rik van Riel <riel@surriel.com>
To:     Vlastimil Babka <vbabka@suse.cz>, linux-kernel@vger.kernel.org
Cc:     kernel-team@fb.com, akpm@linux-foundation.org, linux-mm@kvack.org,
        mhocko@kernel.org, mgorman@techsingularity.net,
        rientjes@google.com, aarcange@redhat.com
Date:   Tue, 25 Feb 2020 13:44:31 -0500
In-Reply-To: <05027092-a43e-756f-4fee-78f29a048ca1@suse.cz>
References: <cover.1582321645.git.riel@surriel.com>
         <3289dc5e6c4c3174999598d8293adf8ed3e93b57.1582321645.git.riel@surriel.com>
         <05027092-a43e-756f-4fee-78f29a048ca1@suse.cz>
Content-Type: multipart/signed; micalg="pgp-sha256";
        protocol="application/pgp-signature"; boundary="=-iO9vIcEIcIrv1iZZfjKe"
User-Agent: Evolution 3.34.3 (3.34.3-1.fc31) 
MIME-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--=-iO9vIcEIcIrv1iZZfjKe
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, 2020-02-24 at 16:29 +0100, Vlastimil Babka wrote:
> On 2/21/20 10:53 PM, Rik van Riel wrote:
> > @@ -981,7 +981,9 @@ isolate_migratepages_block(struct
> > compact_control *cc, unsigned long low_pfn,
> >  		if (__isolate_lru_page(page, isolate_mode) !=3D 0)
> >  			goto isolate_fail;
> > =20
> > -		VM_BUG_ON_PAGE(PageCompound(page), page);
> > +		/* The whole page is taken off the LRU; skip the tail
> > pages. */
> > +		if (PageCompound(page))
> > +			low_pfn +=3D compound_nr(page) - 1;
> > =20
> >  		/* Successfully isolated */
> >  		del_page_from_lru_list(page, lruvec, page_lru(page));
>=20
> This continues by:
> inc_node_page_state(page, NR_ISOLATED_ANON +
> page_is_file_cache(page));
>=20
>=20
> I think it now needs to use mod_node_page_state() with
> hpage_nr_pages(page) otherwise the counter will underflow after the
> migration?

You are absolutely right. I have not observed the
underflow, but the functions doing the decrementing
use hpage_nr_pages, and I need to do that as well
on the incrementing side.

Change made.

> > diff --git a/mm/page_alloc.c b/mm/page_alloc.c
> > index a36736812596..38c8ddfcecc8 100644
> > --- a/mm/page_alloc.c
> > +++ b/mm/page_alloc.c
> > @@ -8253,14 +8253,16 @@ struct page *has_unmovable_pages(struct
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
> > +		if (PageTransHuge(page)) {
>=20
> Hmm, PageTransHuge() has VM_BUG_ON() for tail pages, while this code
> is
> written so that it can encounter a tail page and skip the rest of the
> compound page properly. So I would be worried about this.

Good point, a CMA allocation could start partway into a
compound page.=20

> Also PageTransHuge() is basically just a PageHead() so for each
> non-hugetlbfs compound page this will assume it's a THP, while
> correctly
> it should reach the __PageMovable() || PageLRU(page) tests below.
>=20
> So probably this should do something like.
>=20
> if (PageHuge(page) || PageTransCompound(page)) {
> ...
>    if (PageHuge(page) && !hpage_migration_supported)) return page.

So far so good.

>    if (!PageLRU(head) && !__PageMovable(head)) return page

I don't get this one, though. What about a THP that has
not made it onto the LRU list yet for some reason?

I don't think anonymous pages are marked __PageMovable,
are they? It looks like they only have the PAGE_MAPPING_ANON
flag set, not the PAGE_MAPPING_MOVABLE one.

What am I missing?

> ...
>=20
> >  			struct page *head =3D compound_head(page);
> >  			unsigned int skip_pages;
> > =20
> > -			if
> > (!hugepage_migration_supported(page_hstate(head)))
> > +			if (PageHuge(page) &&
> > +			    !hugepage_migration_supported(page_hstate(h
> > ead)))
> >  				return page;
> > =20
> >  			skip_pages =3D compound_nr(head) - (page - head);
> >=20
>=20
>=20
--=20
All Rights Reversed.

--=-iO9vIcEIcIrv1iZZfjKe
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part
Content-Transfer-Encoding: 7bit

-----BEGIN PGP SIGNATURE-----

iQEzBAABCAAdFiEEKR73pCCtJ5Xj3yADznnekoTE3oMFAl5Vaw8ACgkQznnekoTE
3oOMCAf+JXdppj6x3n1YbJueKjvdyjYwy84gbdtOs88pApMBtrjMFwt2cT4LbL08
FBR4LLG/dTPzhR8wlQpnh/gY9q91sbadYQ38T6NO0zcDtqPRnoNE5Jce+b/91Jmk
LOBugJ8u3HA7nrnu/laP8FtmPFWjxj6s2XlKZlvHb9AKCUzCJE3tzizEADkE4y+l
xDcDYX6Ex/rujhIgFBgcrxvaL7ooVv6YvFVL8FIMN/mW7BEknKPcREt7ooUcc1eT
rLMlWk+ClC1Woxnct31SF1JNCG4ynX3m10KgaVH+gKq/r99saHXm59V7PvgoPY1Q
PZUGrdRyv8xJWKrKvnq4dhIcuisgag==
=yJ9b
-----END PGP SIGNATURE-----

--=-iO9vIcEIcIrv1iZZfjKe--

