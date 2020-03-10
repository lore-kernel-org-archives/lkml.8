Return-Path: <SRS0=K2g5=43=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 67CBDC18E5A
	for <linux-kernel@archiver.kernel.org>; Tue, 10 Mar 2020 20:38:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2EE8821655
	for <linux-kernel@archiver.kernel.org>; Tue, 10 Mar 2020 20:38:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726480AbgCJUiK (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 10 Mar 2020 16:38:10 -0400
Received: from shelob.surriel.com ([96.67.55.147]:50480 "EHLO
        shelob.surriel.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726265AbgCJUiJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Mar 2020 16:38:09 -0400
Received: from imladris.surriel.com ([96.67.55.152])
        by shelob.surriel.com with esmtpsa (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256)
        (Exim 4.92.3)
        (envelope-from <riel@shelob.surriel.com>)
        id 1jBldd-0001bs-E1; Tue, 10 Mar 2020 16:38:05 -0400
Message-ID: <c3b1e383989b9422b3fb6e3e6f7ebf733f23ad7a.camel@surriel.com>
Subject: Re: [PATCH v2] mm: hugetlb: optionally allocate gigantic hugepages
 using cma
From:   Rik van Riel <riel@surriel.com>
To:     Mike Kravetz <mike.kravetz@oracle.com>,
        Michal Hocko <mhocko@kernel.org>, Roman Gushchin <guro@fb.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Johannes Weiner <hannes@cmpxchg.org>, linux-mm@kvack.org,
        kernel-team@fb.com, linux-kernel@vger.kernel.org
Date:   Tue, 10 Mar 2020 16:38:04 -0400
In-Reply-To: <c20a0d81-341f-caac-0e47-f8753fbb6dbe@oracle.com>
References: <20200310002524.2291595-1-guro@fb.com>
         <5cfa9031-fc15-2bcc-adb9-9779285ef0f7@oracle.com>
         <20200310180558.GD85000@carbon.dhcp.thefacebook.com>
         <4b78a8a9-7b5a-eb62-acaa-2677e615bea1@oracle.com>
         <20200310191906.GA96999@carbon.dhcp.thefacebook.com>
         <20200310193622.GC8447@dhcp22.suse.cz>
         <43e2e8443288260aa305f39ba566f81bf065d010.camel@surriel.com>
         <57494a9c-5c24-20b6-0bda-dac8bbb6f731@oracle.com>
         <4147bc1d429a4336dcb45a6cb2657d082f35ab25.camel@surriel.com>
         <c20a0d81-341f-caac-0e47-f8753fbb6dbe@oracle.com>
Content-Type: multipart/signed; micalg="pgp-sha256";
        protocol="application/pgp-signature"; boundary="=-YLfLpufuUfbzXS9k6KF4"
User-Agent: Evolution 3.34.3 (3.34.3-1.fc31) 
MIME-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--=-YLfLpufuUfbzXS9k6KF4
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, 2020-03-10 at 13:29 -0700, Mike Kravetz wrote:
> On 3/10/20 1:15 PM, Rik van Riel wrote:
> > On Tue, 2020-03-10 at 13:11 -0700, Mike Kravetz wrote:
> > > the more I think about it, the more I like limiting CMA
> > > reservations
> > > to
> > > only one gigantic huge page size (per arch).
> >=20
> > Why, though?
> >=20
> > The cma_alloc function can return allocations of different
> > sizes at the same time.
> >=20
> > There is no limitation in the underlying code that would stop
> > a user from allocating hugepages of different sizes through
> > sysfs.
>=20
> True, there is no technical reason.
>=20
> I was only trying to simplify the setup and answer the outstanding
> questions.
> - What alignment to use for reservations?

Alignment can be the largest hugepage size the system
supports, assuming the amount of memory set aside is
at least this large?

> - What is minimum size of reservations?

One good thing is that it isn't really a reservation,
since the memory can still be used for things like page
cache and anonymous memory, so if too much is reserved
the memory does not go to waste.

One of my follow-up projects to Roman's project will be
to get THP & khugepaged to effectively use memory in the
hugepage CMA area, too.

That way when a system is running a workload that is not
using 1GB hugetlbfs pages, that easily defragmentable memory
pool will still bring some benefits to the workload.

> If only one gigantic page size is supported, the answer is
> simple.  In any
> case, I think input from arch specific code will be needed.

Agreed.

--=20
All Rights Reversed.

--=-YLfLpufuUfbzXS9k6KF4
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part
Content-Transfer-Encoding: 7bit

-----BEGIN PGP SIGNATURE-----

iQEzBAABCAAdFiEEKR73pCCtJ5Xj3yADznnekoTE3oMFAl5n+q0ACgkQznnekoTE
3oOHkgf/ZQ1I2L6OIxzLSO8V0GshyzL880uu043u4Yft+nSOgmxUpRkjFxKLue3b
sy1O/oBTgPLJ6LkpZuMFyRaw6uPL2qMt7JIPwKu9LdmvhHAh5Sm8H6sYZ2rEc5oD
WuQnXMmTrRZRdP9Z3AsBMH6hh+ztzQEVA9UV+q+aP4pmzxoQYbDstnw8cdPaqk2M
grlFDjqdlxg3nebwc3uzkdVjOEtzg9VQCde6Vgud7B7S1JdvDeswdXxuQiRu1Fy3
ag0WQgjjOokgQlA7QTgxGdHmKUDweFef/zbiMfFYPwWaqRmkXEr/4hkOaN9WO5v/
Hdc/arJQ3gyKCwX4Y+RQhA/gErKsig==
=Hi/q
-----END PGP SIGNATURE-----

--=-YLfLpufuUfbzXS9k6KF4--

