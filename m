Return-Path: <SRS0=Q7wL=5E=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1EF7DC4332D
	for <linux-kernel@archiver.kernel.org>; Thu, 19 Mar 2020 16:56:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E701B2080C
	for <linux-kernel@archiver.kernel.org>; Thu, 19 Mar 2020 16:56:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727928AbgCSQ4o (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 19 Mar 2020 12:56:44 -0400
Received: from shelob.surriel.com ([96.67.55.147]:56784 "EHLO
        shelob.surriel.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727146AbgCSQ4o (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Mar 2020 12:56:44 -0400
Received: from imladris.surriel.com ([96.67.55.152])
        by shelob.surriel.com with esmtpsa (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256)
        (Exim 4.92.3)
        (envelope-from <riel@shelob.surriel.com>)
        id 1jEyTD-0007SS-8f; Thu, 19 Mar 2020 12:56:35 -0400
Message-ID: <3f75f55dc6a9b4dfd3c6ac808c370bfd91d1554a.camel@surriel.com>
Subject: Re: [PATCH] mm: hugetlb: fix hugetlb_cma_reserve() if CONFIG_NUMA
 isn't set
From:   Rik van Riel <riel@surriel.com>
To:     Michal Hocko <mhocko@kernel.org>, Roman Gushchin <guro@fb.com>,
        Aslan Bakirov <aslan@fb.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>, linux-mm@kvack.org,
        kernel-team@fb.com, linux-kernel@vger.kernel.org,
        Andreas Schaufler <andreas.schaufler@gmx.de>,
        Mike Kravetz <mike.kravetz@oracle.com>,
        Guido =?ISO-8859-1?Q?G=FCnther?= <agx@sigxcpu.org>,
        Naresh Kamboju <naresh.kamboju@linaro.org>
Date:   Thu, 19 Mar 2020 12:56:34 -0400
In-Reply-To: <20200319161644.GH20800@dhcp22.suse.cz>
References: <20200318153424.3202304-1-guro@fb.com>
         <20200318161625.GR21362@dhcp22.suse.cz>
         <20200318175529.GA6263@carbon.dhcp.thefacebook.com>
         <20200319161644.GH20800@dhcp22.suse.cz>
Content-Type: multipart/signed; micalg="pgp-sha256";
        protocol="application/pgp-signature"; boundary="=-xqGcAAkovkjaAH5al2Q2"
User-Agent: Evolution 3.34.3 (3.34.3-1.fc31) 
MIME-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--=-xqGcAAkovkjaAH5al2Q2
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, 2020-03-19 at 17:16 +0100, Michal Hocko wrote:
>=20
> This is not the first time HAVE_MEMBLOCK_NODE_MAP has been
> problematic.
> I might be missing something but I really do not get why do we really
> need it these days. As for !NUMA, I suspect we can make it generate
> the
> right thing when !NUMA.

We're working on a different fix now.

It looks like cma_declare_contiguous calls memblock_phys_alloc_range,
which calls memblock_alloc_range_nid, which takes a NUMA node as one
of its arguments.

Aslan is looking at simply adding a cma_declare_contiguous_nid, which
also takes a NUMA node ID as an argument. At that point we can simply
leave CMA free to allocate from anywhere in each NUMA node, which by
default already happens from the top down.

That should be the nicer long term fix to this issue.

--=20
All Rights Reversed.

--=-xqGcAAkovkjaAH5al2Q2
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part
Content-Transfer-Encoding: 7bit

-----BEGIN PGP SIGNATURE-----

iQEzBAABCAAdFiEEKR73pCCtJ5Xj3yADznnekoTE3oMFAl5zpEIACgkQznnekoTE
3oOzXwf+KFp0GJtUWncQg/fSVDlVuX0CDEUh2qJkjwZG8CXXZ7RetNSgWwJBh6NZ
0/3UTuEFRIvJ+URQ1dSxSD7wxtuJxv7b0E+NR7Q0OgmhMbtxeCyLtecwazcM2nym
4THHUWVFI1gvV22eMA25Olw5os/GrC09+LvQdr3U+fPkk6IJplWgcSfXAII04YLG
6uLoIV0cSwfjBAPmdj4uOji9u/m+urLqCnMRA0GGHAV0GfAG9jHOcYNiDqO6phjE
39RRgL0D4k5WaCTIcxCSfHJ9GotJBi2zFapBFB5YkYAjXU+PcaATxV08LgSyz6lK
/aw2p4uFDgxdBFEXYjdHyHP6+XVZeA==
=29Xz
-----END PGP SIGNATURE-----

--=-xqGcAAkovkjaAH5al2Q2--

