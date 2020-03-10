Return-Path: <SRS0=K2g5=43=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 15D39C10DCE
	for <linux-kernel@archiver.kernel.org>; Tue, 10 Mar 2020 20:15:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B8A2D222C3
	for <linux-kernel@archiver.kernel.org>; Tue, 10 Mar 2020 20:15:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727317AbgCJUPX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 10 Mar 2020 16:15:23 -0400
Received: from shelob.surriel.com ([96.67.55.147]:50416 "EHLO
        shelob.surriel.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726545AbgCJUPX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Mar 2020 16:15:23 -0400
Received: from imladris.surriel.com ([96.67.55.152])
        by shelob.surriel.com with esmtpsa (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256)
        (Exim 4.92.3)
        (envelope-from <riel@shelob.surriel.com>)
        id 1jBlHa-0001Mz-JN; Tue, 10 Mar 2020 16:15:18 -0400
Message-ID: <4147bc1d429a4336dcb45a6cb2657d082f35ab25.camel@surriel.com>
Subject: Re: [PATCH v2] mm: hugetlb: optionally allocate gigantic hugepages
 using cma
From:   Rik van Riel <riel@surriel.com>
To:     Mike Kravetz <mike.kravetz@oracle.com>,
        Michal Hocko <mhocko@kernel.org>, Roman Gushchin <guro@fb.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Johannes Weiner <hannes@cmpxchg.org>, linux-mm@kvack.org,
        kernel-team@fb.com, linux-kernel@vger.kernel.org
Date:   Tue, 10 Mar 2020 16:15:18 -0400
In-Reply-To: <57494a9c-5c24-20b6-0bda-dac8bbb6f731@oracle.com>
References: <20200310002524.2291595-1-guro@fb.com>
         <5cfa9031-fc15-2bcc-adb9-9779285ef0f7@oracle.com>
         <20200310180558.GD85000@carbon.dhcp.thefacebook.com>
         <4b78a8a9-7b5a-eb62-acaa-2677e615bea1@oracle.com>
         <20200310191906.GA96999@carbon.dhcp.thefacebook.com>
         <20200310193622.GC8447@dhcp22.suse.cz>
         <43e2e8443288260aa305f39ba566f81bf065d010.camel@surriel.com>
         <57494a9c-5c24-20b6-0bda-dac8bbb6f731@oracle.com>
Content-Type: multipart/signed; micalg="pgp-sha256";
        protocol="application/pgp-signature"; boundary="=-C3ENaGOY3Fk1eu6XYAt6"
User-Agent: Evolution 3.34.3 (3.34.3-1.fc31) 
MIME-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--=-C3ENaGOY3Fk1eu6XYAt6
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, 2020-03-10 at 13:11 -0700, Mike Kravetz wrote:
> On 3/10/20 12:46 PM, Rik van Riel wrote:
> >=20
> > How would that work for architectures that have multiple
> > possible hugetlbfs gigantic page sizes, where the admin
> > can allocate different numbers of differently sized pages
> > after bootup?
>=20
> For hugetlb page reservations at boot today, pairs specifying size
> and
> quantity are put on the command line.  For example,
> hugepagesz=3D2M hugepages=3D512 hugepagesz=3D1G hugepages=3D64
>=20
> We could do something similiar for CMA.
> hugepagesz=3D512M hugepages_cma=3D256 hugepagesz=3D1G hugepages_cma=3D64
>=20
> That would make things much more complicated (implies separate CMA
> reservations per size) and may be overkill for the first
> implementation.
>=20
> Perhaps we limit CMA reservations to one gigantic huge page
> size.  The
> architectures would need to define the default and there could be a
> command line option to override.  Something like,
> default_cmapagesz=3D  analogous to today's default_hugepagesz=3D.  Then
> hugepages_cma=3D is only associated with that default gigantic huge
> page
> size.
>=20
> The more I think about it, the more I like limiting CMA reservations
> to
> only one gigantic huge page size (per arch).

Why, though?

The cma_alloc function can return allocations of different
sizes at the same time.

There is no limitation in the underlying code that would stop
a user from allocating hugepages of different sizes through
sysfs.

Allowing the system administrator to allocate a little extra
memory for the CMA pool could also allow us to work around
initial issues of compaction/migration failing to move some
of the pages, while we play whack-a-mole with the last corner
cases.

--=20
All Rights Reversed.

--=-C3ENaGOY3Fk1eu6XYAt6
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part
Content-Transfer-Encoding: 7bit

-----BEGIN PGP SIGNATURE-----

iQEzBAABCAAdFiEEKR73pCCtJ5Xj3yADznnekoTE3oMFAl5n9VYACgkQznnekoTE
3oN42ggAnLgkVOVgm54Qtqfu1IihZSXHTfyMBPLFs4nCFUBBMpzt+QZJkCYXzGZW
kUnRyYQcTPalw5uwdKeL97uWxvARnR04kx6qA7cvocvEC8Xw4EYPPH0RPKXXHG1f
qRa9bpR+TvYckp/FmYiWME2oMD3S0wxXdXEUOsgnooOxCHJ7SScSdcx+06MgbVDh
49qboipysfbgTzuKFXmto/TxKWS/8LyRWaeAVwBnDyHn8XYfhsI9xa7xBsvnxAjI
qacZRHqa+DcV8//wOPAp0YZ6fD86FQI42Dzqmm0l3N+k8wtXITh6SRdKo7ODUGQc
h+B3ysCd32l+vOsITPwcvgiHRhbU7g==
=IuCs
-----END PGP SIGNATURE-----

--=-C3ENaGOY3Fk1eu6XYAt6--

