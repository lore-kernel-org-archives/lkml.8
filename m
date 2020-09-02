Return-Path: <SRS0=728o=CL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1AC42C433E7
	for <linux-kernel@archiver.kernel.org>; Wed,  2 Sep 2020 18:45:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id DF9E02072A
	for <linux-kernel@archiver.kernel.org>; Wed,  2 Sep 2020 18:45:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=nvidia.com header.i=@nvidia.com header.b="HidPatEV"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728181AbgIBSpo (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 2 Sep 2020 14:45:44 -0400
Received: from hqnvemgate25.nvidia.com ([216.228.121.64]:17507 "EHLO
        hqnvemgate25.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726821AbgIBSpn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Sep 2020 14:45:43 -0400
Received: from hqpgpgate101.nvidia.com (Not Verified[216.228.121.13]) by hqnvemgate25.nvidia.com (using TLS: TLSv1.2, DES-CBC3-SHA)
        id <B5f4fe8280000>; Wed, 02 Sep 2020 11:44:56 -0700
Received: from hqmail.nvidia.com ([172.20.161.6])
  by hqpgpgate101.nvidia.com (PGP Universal service);
  Wed, 02 Sep 2020 11:45:42 -0700
X-PGP-Universal: processed;
        by hqpgpgate101.nvidia.com on Wed, 02 Sep 2020 11:45:42 -0700
Received: from [10.2.161.253] (172.20.13.39) by HQMAIL107.nvidia.com
 (172.20.187.13) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Wed, 2 Sep
 2020 18:45:39 +0000
From:   Zi Yan <ziy@nvidia.com>
To:     Jason Gunthorpe <jgg@ziepe.ca>
CC:     <linux-mm@kvack.org>, Roman Gushchin <guro@fb.com>,
        Rik van Riel <riel@surriel.com>,
        "Kirill A . Shutemov" <kirill.shutemov@linux.intel.com>,
        Matthew Wilcox <willy@infradead.org>,
        Shakeel Butt <shakeelb@google.com>,
        Yang Shi <yang.shi@linux.alibaba.com>,
        David Nellans <dnellans@nvidia.com>,
        <linux-kernel@vger.kernel.org>
Subject: Re: [RFC PATCH 00/16] 1GB THP support on x86_64
Date:   Wed, 2 Sep 2020 14:45:37 -0400
X-Mailer: MailMate (1.13.1r5705)
Message-ID: <E78A0F18-223C-44A8-BCBA-73CF7AF6F8A5@nvidia.com>
In-Reply-To: <20200902184053.GF24045@ziepe.ca>
References: <20200902180628.4052244-1-zi.yan@sent.com>
 <20200902184053.GF24045@ziepe.ca>
MIME-Version: 1.0
X-Originating-IP: [172.20.13.39]
X-ClientProxiedBy: HQMAIL107.nvidia.com (172.20.187.13) To
 HQMAIL107.nvidia.com (172.20.187.13)
Content-Type: multipart/signed;
        boundary="=_MailMate_2F2B3416-A5DE-4322-A84C-F8139756DD79_=";
        micalg=pgp-sha512; protocol="application/pgp-signature"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
        t=1599072296; bh=y9oE8iZ55HjKzceLsP5ipwDJah2sL4mvCa3WDcY7xAQ=;
        h=X-PGP-Universal:From:To:CC:Subject:Date:X-Mailer:Message-ID:
         In-Reply-To:References:MIME-Version:X-Originating-IP:
         X-ClientProxiedBy:Content-Type;
        b=HidPatEVEs7s5gQ5AsArTZQ4qy+yrC+EHfGhJXbrwf/a2A76hcdTzChKausXlS+Dt
         4F8pKvYMcnwiDAGoNDYVDDfD7Vvlb1d5RoyY8tzS6XyU4oUTmk8uP+YXtCmuPxZg7N
         YTfHADZUaMGN7MZPfKL8eExibjhN2Pk8yjtOIhlmT9BOtUJffyNRbM4gBhAkDMIJqj
         W8JVoka+4HX/vI6xn9ktzjPgOLz02tnSz1LWKaqzOBSe+ATlxxVVOAhB5yPCyBmt3u
         kF5PnmTEO3/5iu0k2hIS5e1ZuOH16S4eE3Br62tBDCR+n98qAWFERMNGatdklOXKMO
         y0OekvAYDXXIw==
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--=_MailMate_2F2B3416-A5DE-4322-A84C-F8139756DD79_=
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On 2 Sep 2020, at 14:40, Jason Gunthorpe wrote:

> On Wed, Sep 02, 2020 at 02:06:12PM -0400, Zi Yan wrote:
>> From: Zi Yan <ziy@nvidia.com>
>>
>> Hi all,
>>
>> This patchset adds support for 1GB THP on x86_64. It is on top of
>> v5.9-rc2-mmots-2020-08-25-21-13.
>>
>> 1GB THP is more flexible for reducing translation overhead and increas=
ing the
>> performance of applications with large memory footprint without applic=
ation
>> changes compared to hugetlb.
>>
>> Design
>> =3D=3D=3D=3D=3D=3D=3D
>>
>> 1GB THP implementation looks similar to exiting THP code except some n=
ew designs
>> for the additional page table level.
>>
>> 1. Page table deposit and withdraw using a new pagechain data structur=
e:
>>    instead of one PTE page table page, 1GB THP requires 513 page table=
 pages
>>    (one PMD page table page and 512 PTE page table pages) to be deposi=
ted
>>    at the page allocaiton time, so that we can split the page later. C=
urrently,
>>    the page table deposit is using ->lru, thus only one page can be de=
posited.
>>    A new pagechain data structure is added to enable multi-page deposi=
t.
>>
>> 2. Triple mapped 1GB THP : 1GB THP can be mapped by a combination of P=
UD, PMD,
>>    and PTE entries. Mixing PUD an PTE mapping can be achieved with exi=
sting
>>    PageDoubleMap mechanism. To add PMD mapping, PMDPageInPUD and
>>    sub_compound_mapcount are introduced. PMDPageInPUD is the 512-align=
ed base
>>    page in a 1GB THP and sub_compound_mapcount counts the PMD mapping =
by using
>>    page[N*512 + 3].compound_mapcount.
>>
>> 3. Using CMA allocaiton for 1GB THP: instead of bump MAX_ORDER, it is =
more sane
>>    to use something less intrusive. So all 1GB THPs are allocated from=
 reserved
>>    CMA areas shared with hugetlb. At page splitting time, the bitmap f=
or the 1GB
>>    THP is cleared as the resulting pages can be freed via normal page =
free path.
>>    We can fall back to alloc_contig_pages for 1GB THP if necessary.
>>
>>
>> Patch Organization
>> =3D=3D=3D=3D=3D=3D=3D
>>
>> Patch 01 adds the new pagechain data structure.
>>
>> Patch 02 to 13 adds 1GB THP support in variable places.
>>
>> Patch 14 tries to use alloc_contig_pages for 1GB THP allocaiton.
>>
>> Patch 15 moves hugetlb_cma reservation to cma.c and rename it to hugep=
age_cma.
>>
>> Patch 16 use hugepage_cma reservation for 1GB THP allocation.
>>
>>
>> Any suggestions and comments are welcome.
>>
>>
>> Zi Yan (16):
>>   mm: add pagechain container for storing multiple pages.
>>   mm: thp: 1GB anonymous page implementation.
>>   mm: proc: add 1GB THP kpageflag.
>>   mm: thp: 1GB THP copy on write implementation.
>>   mm: thp: handling 1GB THP reference bit.
>>   mm: thp: add 1GB THP split_huge_pud_page() function.
>>   mm: stats: make smap stats understand PUD THPs.
>>   mm: page_vma_walk: teach it about PMD-mapped PUD THP.
>>   mm: thp: 1GB THP support in try_to_unmap().
>>   mm: thp: split 1GB THPs at page reclaim.
>>   mm: thp: 1GB THP follow_p*d_page() support.
>>   mm: support 1GB THP pagemap support.
>>   mm: thp: add a knob to enable/disable 1GB THPs.
>>   mm: page_alloc: >=3DMAX_ORDER pages allocation an deallocation.
>>   hugetlb: cma: move cma reserve function to cma.c.
>>   mm: thp: use cma reservation for pud thp allocation.
>
> Surprised this doesn't touch mm/pagewalk.c ?

1GB PUD page support is present for DAX purpose, so the code is there
in mm/pagewalk.c already. I only needed to supply ops->pud_entry when usi=
ng
the functions in mm/pagewalk.c. :)

=E2=80=94
Best Regards,
Yan Zi

--=_MailMate_2F2B3416-A5DE-4322-A84C-F8139756DD79_=
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQJDBAEBCgAtFiEEh7yFAW3gwjwQ4C9anbJR82th+ooFAl9P6FEPHHppeUBudmlk
aWEuY29tAAoJEJ2yUfNrYfqKMrUP/iTxpN0PeYlOlqlXAbWuUCTO/NzpRBfiToB1
WHyGmOy2Df2pPe5SO1kRuhwOWkoPFAxZ1Q8C0xYd1paBDpN0nT4/pyrFifZ5JlE2
FhuzLkqeFhKdVayMxZUG5CryBwZvTXzqTahPvmOHc8XnUzFFJXqKogQ303tLYbAA
Od1FxuQ2c5emgK5brlHDVt4HC5K/MLwiWJdvzqCBu+J518rvo3InOjYqxwsHCyta
5SRndl44Q+FKzyL0LjC5dbELPTxbKIJJEa6lvS1vu2HLHac7bDoGBMZn4HS90GgG
GoLE18u0jtiThZ33cWgxx0o7muQEzC6nLJyKwRfOyoZCLZITmrl5abR2tklpvyiR
in5ancbl6/SKj7105Ens7b0KW3KSainLeVXEWD7jjXUuAa9ZfBJR1x/HJLM5f5gg
/UH7QxN4OOQkME4Y1/tfF+LoEZ+4kGxcEAarWKOQntHshhFR0cSbMTAS96bp2qXv
d9CcJBOfJsgESjtE91icBGN9gKNuctPm80tniAwZhpO6OOxc+8KAKYtaXSrbNBqE
13PEcXpgBOgD0M8kfumTREhka/NMvFIguzG+0rxYoD5XSpx2OXi3/hysorns7yBA
n2u6m4k7xZgcIFTnmoRIcfpvQTRV7i0Tx8wVD8YXcwghq+3S9201klGJPCQ5cUXF
XPCpw/PX
=Bg7n
-----END PGP SIGNATURE-----

--=_MailMate_2F2B3416-A5DE-4322-A84C-F8139756DD79_=--
