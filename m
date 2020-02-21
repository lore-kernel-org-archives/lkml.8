Return-Path: <SRS0=1210=4J=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EC82AC35641
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Feb 2020 22:31:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B6F57206EF
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Feb 2020 22:31:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=nvidia.com header.i=@nvidia.com header.b="K8OJxhnB"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729151AbgBUWbK (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 21 Feb 2020 17:31:10 -0500
Received: from hqnvemgate26.nvidia.com ([216.228.121.65]:6143 "EHLO
        hqnvemgate26.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726802AbgBUWbK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Feb 2020 17:31:10 -0500
Received: from hqpgpgate101.nvidia.com (Not Verified[216.228.121.13]) by hqnvemgate26.nvidia.com (using TLS: TLSv1.2, DES-CBC3-SHA)
        id <B5e505a1f0000>; Fri, 21 Feb 2020 14:30:55 -0800
Received: from hqmail.nvidia.com ([172.20.161.6])
  by hqpgpgate101.nvidia.com (PGP Universal service);
  Fri, 21 Feb 2020 14:31:08 -0800
X-PGP-Universal: processed;
        by hqpgpgate101.nvidia.com on Fri, 21 Feb 2020 14:31:08 -0800
Received: from [10.2.168.89] (10.124.1.5) by HQMAIL107.nvidia.com
 (172.20.187.13) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Fri, 21 Feb
 2020 22:31:07 +0000
From:   Zi Yan <ziy@nvidia.com>
To:     Rik van Riel <riel@surriel.com>
CC:     <linux-kernel@vger.kernel.org>, <riel@fb.com>,
        <kernel-team@fb.com>, <akpm@linux-foundation.org>,
        <linux-mm@kvack.org>, <mhocko@kernel.org>, <vbabka@suse.cz>,
        <mgorman@techsingularity.net>, <rientjes@google.com>,
        <aarcange@redhat.com>
Subject: Re: [PATCH 2/2] mm,thp,compaction,cma: allow THP migration for CMA
 allocations
Date:   Fri, 21 Feb 2020 17:31:05 -0500
X-Mailer: MailMate (1.13.1r5678)
Message-ID: <FF5B51C0-8D6E-47AB-82C8-020D5C522502@nvidia.com>
In-Reply-To: <3289dc5e6c4c3174999598d8293adf8ed3e93b57.1582321645.git.riel@surriel.com>
References: <cover.1582321645.git.riel@surriel.com>
 <3289dc5e6c4c3174999598d8293adf8ed3e93b57.1582321645.git.riel@surriel.com>
MIME-Version: 1.0
X-Originating-IP: [10.124.1.5]
X-ClientProxiedBy: HQMAIL111.nvidia.com (172.20.187.18) To
 HQMAIL107.nvidia.com (172.20.187.13)
Content-Type: multipart/signed;
        boundary="=_MailMate_134D27D2-AE58-44F8-8819-BA451892FA30_=";
        micalg=pgp-sha1; protocol="application/pgp-signature"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
        t=1582324255; bh=XywVQ4NavmYoVd2KPSSlq8wuG2qzt2sd/INsB7AlKo4=;
        h=X-PGP-Universal:From:To:CC:Subject:Date:X-Mailer:Message-ID:
         In-Reply-To:References:MIME-Version:X-Originating-IP:
         X-ClientProxiedBy:Content-Type;
        b=K8OJxhnB509QELljcqib6w6+KncRpl3YDU9YNgS6YSplMBoRLwrFE6Dl/1uViHxDQ
         dh+RdvSXlZMhsS2YBPO5IobNpfxVaXLLlcqoDgs/g/o3fNSecL079nCThtsNMkIdLP
         Gc0T/RhX63Zsd8zQ/HgL6gyY+TBc9znnZ/QE1LIo5x1M8IJ7ZzlNa9V5EHINnqI7of
         N/tkokZOp+v2+c4nQsJi8xoehJvcYuPVmPbNjxfhEMLrJxFGeyhnAohGQsonz/WRrn
         8Vq2Gv9lq5+IJDUznd7XNjVxl1i3rawyc6AsMOhLtWzH/Ww6p4D7fo9kmdbyNQuC91
         g7snC8Fg0DrkQ==
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--=_MailMate_134D27D2-AE58-44F8-8819-BA451892FA30_=
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On 21 Feb 2020, at 16:53, Rik van Riel wrote:

> The code to implement THP migrations already exists, and the code
> for CMA to clear out a region of memory already exists.
>
> Only a few small tweaks are needed to allow CMA to move THP memory
> when attempting an allocation from alloc_contig_range.
>
> With these changes, migrating THPs from a CMA area works when
> allocating a 1GB hugepage from CMA memory.
>
> Signed-off-by: Rik van Riel <riel@surriel.com>
> ---
>  mm/compaction.c | 16 +++++++++-------
>  mm/page_alloc.c |  6 ++++--
>  2 files changed, 13 insertions(+), 9 deletions(-)
>
> diff --git a/mm/compaction.c b/mm/compaction.c
> index 672d3c78c6ab..f3e05c91df62 100644
> --- a/mm/compaction.c
> +++ b/mm/compaction.c
> @@ -894,12 +894,12 @@ isolate_migratepages_block(struct compact_control=
 *cc, unsigned long low_pfn,
>
>  		/*
>  		 * Regardless of being on LRU, compound pages such as THP and
> -		 * hugetlbfs are not to be compacted. We can potentially save
> -		 * a lot of iterations if we skip them at once. The check is
> -		 * racy, but we can consider only valid values and the only
> -		 * danger is skipping too much.
> +		 * hugetlbfs are not to be compacted most of the time. We can
> +		 * potentially save a lot of iterations if we skip them at
> +		 * once. The check is racy, but we can consider only valid
> +		 * values and the only danger is skipping too much.
>  		 */

Maybe add =E2=80=9Cwe do want to move them when allocating contiguous mem=
ory using CMA=E2=80=9D to help
people understand the context of using cc->alloc_contig?

> -		if (PageCompound(page)) {
> +		if (PageCompound(page) && !cc->alloc_contig) {
>  			const unsigned int order =3D compound_order(page);
>
>  			if (likely(order < MAX_ORDER))
> @@ -969,7 +969,7 @@ isolate_migratepages_block(struct compact_control *=
cc, unsigned long low_pfn,
>  			 * and it's on LRU. It can only be a THP so the order
>  			 * is safe to read and it's 0 for tail pages.
>  			 */
> -			if (unlikely(PageCompound(page))) {
> +			if (unlikely(PageCompound(page) && !cc->alloc_contig)) {
>  				low_pfn +=3D compound_nr(page) - 1;
>  				goto isolate_fail;
>  			}
> @@ -981,7 +981,9 @@ isolate_migratepages_block(struct compact_control *=
cc, unsigned long low_pfn,
>  		if (__isolate_lru_page(page, isolate_mode) !=3D 0)
>  			goto isolate_fail;
>
> -		VM_BUG_ON_PAGE(PageCompound(page), page);
> +		/* The whole page is taken off the LRU; skip the tail pages. */
> +		if (PageCompound(page))
> +			low_pfn +=3D compound_nr(page) - 1;
>
>  		/* Successfully isolated */
>  		del_page_from_lru_list(page, lruvec, page_lru(page));
> diff --git a/mm/page_alloc.c b/mm/page_alloc.c
> index a36736812596..38c8ddfcecc8 100644
> --- a/mm/page_alloc.c
> +++ b/mm/page_alloc.c
> @@ -8253,14 +8253,16 @@ struct page *has_unmovable_pages(struct zone *z=
one, struct page *page,
>
>  		/*
>  		 * Hugepages are not in LRU lists, but they're movable.
> +		 * THPs are on the LRU, but need to be counted as #small pages.
>  		 * We need not scan over tail pages because we don't
>  		 * handle each tail page individually in migration.
>  		 */
> -		if (PageHuge(page)) {
> +		if (PageTransHuge(page)) {
>  			struct page *head =3D compound_head(page);
>  			unsigned int skip_pages;
>
> -			if (!hugepage_migration_supported(page_hstate(head)))
> +			if (PageHuge(page) &&
> +			    !hugepage_migration_supported(page_hstate(head)))
>  				return page;
>
>  			skip_pages =3D compound_nr(head) - (page - head);
> -- =

> 2.24.1

Everything else looks good to me.

Reviewed-by: Zi Yan <ziy@nvidia.com>


--
Best Regards,
Yan Zi

--=_MailMate_134D27D2-AE58-44F8-8819-BA451892FA30_=
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQJDBAEBAgAtFiEEh7yFAW3gwjwQ4C9anbJR82th+ooFAl5QWikPHHppeUBudmlk
aWEuY29tAAoJEJ2yUfNrYfqKvl4QAKngAI1velwcxFzzNgTUWA2r0Ay1hH8O0whc
ydr/RrC3tj17BZFy9E9VEmngnytvpv9f4VmIWfN5AVcebkjI6MNogqmDcPuyj1VN
mss9VdlPYyTkmFQ3xUchlyUV3lBg4xNzmtKCzllLTcXxcNDEB0GGbQBuvVFvcuwQ
cl9DNWGQ5ay9spOEX43KGOU2xQQrxeDuALicdRhaD5GYCRHw4uMx5mHZbtefVNNt
hUnYRu0p8KrP+1zjDlqxDg5QaSUIQcWDaYKKZ9ViarhrOa9wycntCxbhTamdPjmR
kBPY40QXx3t4DWGiuMXGOAsd5UKGAZpuZS1cs/B8At/KDFQXuFJI12TixpbO/xxI
/qcw8fKKqvrWO4Up5h2CnpdsM+xp2nLmVxa7ppsXNAHO0IkZ3cLIj23kEgQJzWxU
UxkizkhYYD/LwAwqfpOcMjv+tZPZpyv+UQ6nDf8dEVP1TBm0DMrKwSQDCdieLsNM
uBC8JZxqjmF2M35q1gb1kPLVGYG5fsnjTYIltXZM2ZtlNIBBZoHzxY3eTL0n09/S
tlCDLCJESTjN2fpqcDjrxObgsoyoTerxLqaecOFppG6M/hcJAJrCdRVmKkFsQe8H
OPy+QtN0S+IGou0c/2SNfctbV2hCWTYQ8BD438JeiOwF/DRhJZh8r4Zy8riuPQa2
lrFvaQYm
=qzsY
-----END PGP SIGNATURE-----

--=_MailMate_134D27D2-AE58-44F8-8819-BA451892FA30_=--
