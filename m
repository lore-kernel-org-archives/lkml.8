Return-Path: <SRS0=tZRF=4Z=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 607D3C10DCE
	for <linux-kernel@archiver.kernel.org>; Sun,  8 Mar 2020 13:23:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 336AC20828
	for <linux-kernel@archiver.kernel.org>; Sun,  8 Mar 2020 13:23:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726330AbgCHNXO (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 8 Mar 2020 09:23:14 -0400
Received: from shelob.surriel.com ([96.67.55.147]:45650 "EHLO
        shelob.surriel.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726259AbgCHNXO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 8 Mar 2020 09:23:14 -0400
Received: from imladris.surriel.com ([96.67.55.152])
        by shelob.surriel.com with esmtpsa (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256)
        (Exim 4.92.3)
        (envelope-from <riel@shelob.surriel.com>)
        id 1jAvtb-00042O-AD; Sun, 08 Mar 2020 09:23:07 -0400
Message-ID: <2f3e2cde7b94dfdb8e1f0532d1074e07ef675bc4.camel@surriel.com>
Subject: Re: [PATCH]  mm,page_alloc,cma: conditionally prefer cma pageblocks
 for movable allocations
From:   Rik van Riel <riel@surriel.com>
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        kernel-team@fb.com, Roman Gushchin <guro@fb.com>,
        Qian Cai <cai@lca.pw>, Vlastimil Babka <vbabka@suse.cz>,
        Mel Gorman <mgorman@techsingularity.net>,
        Anshuman Khandual <anshuman.khandual@arm.com>
Date:   Sun, 08 Mar 2020 09:23:06 -0400
In-Reply-To: <20200307143849.a2fcb81a9626dad3ee46471f@linux-foundation.org>
References: <20200306150102.3e77354b@imladris.surriel.com>
         <20200307143849.a2fcb81a9626dad3ee46471f@linux-foundation.org>
Content-Type: multipart/signed; micalg="pgp-sha256";
        protocol="application/pgp-signature"; boundary="=-Zfoz2TVd9hG/2oLi3xrD"
User-Agent: Evolution 3.34.3 (3.34.3-1.fc31) 
MIME-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--=-Zfoz2TVd9hG/2oLi3xrD
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sat, 2020-03-07 at 14:38 -0800, Andrew Morton wrote:
> On Fri, 6 Mar 2020 15:01:02 -0500 Rik van Riel <riel@surriel.com>
> wrote:

> > --- a/mm/page_alloc.c
> > +++ b/mm/page_alloc.c
> > @@ -2711,6 +2711,18 @@ __rmqueue(struct zone *zone, unsigned int
> > order, int migratetype,
> >  {
> >  	struct page *page;
> > =20
> > +	/*
> > +	 * Balance movable allocations between regular and CMA areas by
> > +	 * allocating from CMA when over half of the zone's free memory
> > +	 * is in the CMA area.
> > +	 */
> > +	if (migratetype =3D=3D MIGRATE_MOVABLE &&
> > +	    zone_page_state(zone, NR_FREE_CMA_PAGES) >
> > +	    zone_page_state(zone, NR_FREE_PAGES) / 2) {
> > +		page =3D __rmqueue_cma_fallback(zone, order);
> > +		if (page)
> > +			return page;
> > +	}
> >  retry:
> >  	page =3D __rmqueue_smallest(zone, order, migratetype);
> >  	if (unlikely(!page)) {
>=20
> __rmqueue() is a hot path (as much as any per-page operation can be a
> hot path).  What is the impact here?

That is a good question. For MIGRATE_MOVABLE allocations,
most allocations seem to be order 0, which go through the
per cpu pages array, and rmqueue_pcplist, or be order 9.

For order 9 allocations, other things seem likely to dominate
the allocation anyway, while for order 0 allocations the
pcp list should take away the sting?

What I do not know is how much impact this change would
have on other allocations, like order 3 or order 4 network
buffer allocations from irq context...

Are there cases in particular that we should be testing?

--=20
All Rights Reversed.

--=-Zfoz2TVd9hG/2oLi3xrD
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part
Content-Transfer-Encoding: 7bit

-----BEGIN PGP SIGNATURE-----

iQEzBAABCAAdFiEEKR73pCCtJ5Xj3yADznnekoTE3oMFAl5k8boACgkQznnekoTE
3oNzDgf/b23t5rPuQYzgUxsXx9l2rT+R+nlh3KEN+PXzObY/1EEk69KwFipsvq63
iNRVN55lIjGtBWyvwEbqh1ZLV1vO2k0uTfJ7z5HfVCJrlyyOdnMGZJcxE+9ifsSJ
MKXMaXMy0U29MoqLFq/8Z1QizRRTk6/nr6X7mirpECfKqrCLTfg9Esixde9aIcQc
vbIZDo9rwEvUG5Ig226VOLBO75mAOJrvXUUZ0ctrs51vnhjLYEhvNNhHIOP3Qlv2
2bE0oXgRBvD29ka8CbjYrljeD8clZ2xKJ2DVb/ZZWUlqFV+vTGUnHuEE9lvIYD8D
bYGt2r05+IMc7thEzDEqKa3QY8N87w==
=HNtA
-----END PGP SIGNATURE-----

--=-Zfoz2TVd9hG/2oLi3xrD--

