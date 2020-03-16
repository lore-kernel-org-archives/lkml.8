Return-Path: <SRS0=ltrd=5B=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 467A7C10DCE
	for <linux-kernel@archiver.kernel.org>; Mon, 16 Mar 2020 01:08:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2213E205ED
	for <linux-kernel@archiver.kernel.org>; Mon, 16 Mar 2020 01:08:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729355AbgCPBI6 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 15 Mar 2020 21:08:58 -0400
Received: from shelob.surriel.com ([96.67.55.147]:42250 "EHLO
        shelob.surriel.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729300AbgCPBI5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 15 Mar 2020 21:08:57 -0400
Received: from imladris.surriel.com ([96.67.55.152])
        by shelob.surriel.com with esmtpsa (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256)
        (Exim 4.92.3)
        (envelope-from <riel@shelob.surriel.com>)
        id 1jDeFN-0005ir-MR; Sun, 15 Mar 2020 21:08:49 -0400
Message-ID: <3f9ebf02d5ac99b4a53323cc81097ab7d176be13.camel@surriel.com>
Subject: Re: [PATCH v2] mm: hugetlb: optionally allocate gigantic hugepages
 using cma
From:   Rik van Riel <riel@surriel.com>
To:     Michal Hocko <mhocko@kernel.org>, Roman Gushchin <guro@fb.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Johannes Weiner <hannes@cmpxchg.org>, linux-mm@kvack.org,
        kernel-team@fb.com, linux-kernel@vger.kernel.org,
        Mike Kravetz <mike.kravetz@oracle.com>
Date:   Sun, 15 Mar 2020 21:08:33 -0400
In-Reply-To: <20200310173738.GW8447@dhcp22.suse.cz>
References: <20200310002524.2291595-1-guro@fb.com>
         <20200310084544.GY8447@dhcp22.suse.cz>
         <20200310172559.GA85000@carbon.dhcp.thefacebook.com>
         <20200310173738.GW8447@dhcp22.suse.cz>
Content-Type: multipart/signed; micalg="pgp-sha256";
        protocol="application/pgp-signature"; boundary="=-+u87rxUVjLaTU0VDKPMi"
User-Agent: Evolution 3.34.3 (3.34.3-1.fc31) 
MIME-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--=-+u87rxUVjLaTU0VDKPMi
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, 2020-03-10 at 18:37 +0100, Michal Hocko wrote:
> On Tue 10-03-20 10:25:59, Roman Gushchin wrote:
> > Well, so far I was focused on a particular case when the target cma
> > size
> > is significantly smaller than the total RAM size (~5-10%). What is
> > the right
> > thing to do here? Fallback to the current behavior if the requested
> > size is
> > more than x% of total memory? 1/2? How do you think?
>=20
> I would start by excluding restricted kernel zones (<ZONE_NORMAL).
> Cutting off 1G of ZONE_DMA32 might be a real problem.

It looks like memblock_find_in_range_node(), which
is called from memblock_alloc_range_nid(), will already
do top-down allocation inside each node.

However, looking at that code some more, it has some
limitations that we might not want. Specifically, if
we want to allocate for example a 16GB CMA area, but
the node in question only has a 15GB available area
in one spot and a 1GB available area in another spot,
for example due to memory holes, the allocation will fail.

I wonder if it makes sense to have separate cma_declare_contiguous
calls for each 1GB page we set up. That way it will be easier
to round-robin between the ZONE_NORMAL zones in each node, and
also to avoid the ZONE_DMA32 and other special nodes on systems
where those are a relatively small part of memory.

I'll whip up a patch to do that.

--=20
All Rights Reversed.

--=-+u87rxUVjLaTU0VDKPMi
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part
Content-Transfer-Encoding: 7bit

-----BEGIN PGP SIGNATURE-----

iQEzBAABCAAdFiEEKR73pCCtJ5Xj3yADznnekoTE3oMFAl5u0ZIACgkQznnekoTE
3oPPIAgAu8XZaCLZ5HW+T4PLxfETerxBSrPeZn9gpSZLvFabnLwe9JPpHvIjZEyi
32fVVSzapIM1+tJSJ0InE1CY6MGX3s5mJvX8a9UHUwY2VAuR3HDGGlcDEWkvaReg
t44rluEuM43p5oX87gCAGUMeXcyVOMqt3SzVajTXWTZ9wlXBUpaNbxJjXvQkeTAG
6Sl6Ao9p5b2lhYd0r2csib0l7GjuqgnwNS8vI//XnNUF9mOXJi5BmHhOhwvloX45
PEcQAny6febdVnVZSXxzGfbIW45kUSiNlIPOh5iBBzarbFLlH3UskWG6/gbnFnai
PVxAnfzvpxSD+I8F9OLv5NFP7eGGKA==
=RGk4
-----END PGP SIGNATURE-----

--=-+u87rxUVjLaTU0VDKPMi--

