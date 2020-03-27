Return-Path: <SRS0=s8dx=5M=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3ACBAC43331
	for <linux-kernel@archiver.kernel.org>; Fri, 27 Mar 2020 21:45:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 07444206DB
	for <linux-kernel@archiver.kernel.org>; Fri, 27 Mar 2020 21:45:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=nvidia.com header.i=@nvidia.com header.b="nWcdx6M8"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727702AbgC0VpB (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 27 Mar 2020 17:45:01 -0400
Received: from hqnvemgate25.nvidia.com ([216.228.121.64]:4035 "EHLO
        hqnvemgate25.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727473AbgC0VpA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 27 Mar 2020 17:45:00 -0400
Received: from hqpgpgate102.nvidia.com (Not Verified[216.228.121.13]) by hqnvemgate25.nvidia.com (using TLS: TLSv1.2, DES-CBC3-SHA)
        id <B5e7e73ad0000>; Fri, 27 Mar 2020 14:44:13 -0700
Received: from hqmail.nvidia.com ([172.20.161.6])
  by hqpgpgate102.nvidia.com (PGP Universal service);
  Fri, 27 Mar 2020 14:45:00 -0700
X-PGP-Universal: processed;
        by hqpgpgate102.nvidia.com on Fri, 27 Mar 2020 14:45:00 -0700
Received: from [10.2.174.211] (10.124.1.5) by HQMAIL107.nvidia.com
 (172.20.187.13) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Fri, 27 Mar
 2020 21:44:58 +0000
From:   Zi Yan <ziy@nvidia.com>
To:     Yang Shi <shy828301@gmail.com>
CC:     "Kirill A. Shutemov" <kirill@shutemov.name>,
        Andrew Morton <akpm@linux-foundation.org>,
        Andrea Arcangeli <aarcange@redhat.com>,
        Linux MM <linux-mm@kvack.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>
Subject: Re: [PATCH 4/7] khugepaged: Allow to callapse a page shared across
 fork
Date:   Fri, 27 Mar 2020 17:44:56 -0400
X-Mailer: MailMate (1.13.1r5680)
Message-ID: <2498F20B-DD98-4244-AD60-58D4A771ADF6@nvidia.com>
In-Reply-To: <CAHbLzkrLxB93xs78xejsBsZ=-b+oqNao6a5Bydi8-6+wpzjKQg@mail.gmail.com>
References: <20200327170601.18563-1-kirill.shutemov@linux.intel.com>
 <20200327170601.18563-5-kirill.shutemov@linux.intel.com>
 <AD80A72A-8FB7-4F89-A2C9-CDD5C616A479@sent.com>
 <CAHbLzkrLxB93xs78xejsBsZ=-b+oqNao6a5Bydi8-6+wpzjKQg@mail.gmail.com>
MIME-Version: 1.0
X-Originating-IP: [10.124.1.5]
X-ClientProxiedBy: HQMAIL111.nvidia.com (172.20.187.18) To
 HQMAIL107.nvidia.com (172.20.187.13)
Content-Type: multipart/signed;
        boundary="=_MailMate_32016954-B99D-44CD-BE67-01B33907190B_=";
        micalg=pgp-sha512; protocol="application/pgp-signature"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
        t=1585345453; bh=qA5lmaOWEHFjoxmorFbt1s5u6NyUnRdUFtf4I6cXnoU=;
        h=X-PGP-Universal:From:To:CC:Subject:Date:X-Mailer:Message-ID:
         In-Reply-To:References:MIME-Version:X-Originating-IP:
         X-ClientProxiedBy:Content-Type;
        b=nWcdx6M8e9j1TNLR9McyGrPkWGclNr6z0+9PBsv79WZ0b3SpI0g1v6W0HiX+UW2PS
         9hj4/lC160GsWbB9cGyYNSsKMIkhQAskYKWzEfMiZ2RdZzS4V1ng4BQjLr9ZrMIxsb
         oZAPoyKfG6FkOwHZPeuivq/gtem9iEDO0r5VgQlIdI3832L3F5QisiikxG74PUabGo
         4Unwir9PR56t5meMGJVNb564wBGuvcyz9KjbO+IhFKajySFlh15X1VlIypD049zycO
         Jpvgz0TN4J2RsBd4k7DzI7689iU9Ekb333w0pF+cyHoXMfWluQ6F2WLwhW8P3DtrkP
         06mOxZNMctmeg==
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--=_MailMate_32016954-B99D-44CD-BE67-01B33907190B_=
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<snip>
>>>                       /*
>>>                        * Drain pagevec and retry just in case we can =
get rid
>>>                        * of the extra pin, like in swapin case.
>>>                        */
>>>                       lru_add_drain();
>>>               }
>>> -             if (page_count(page) !=3D 1 + PageSwapCache(page)) {
>>> +             if (total_mapcount(page) + PageSwapCache(page) !=3D
>>> +                             page_count(page)) {
>>>                       unlock_page(page);
>>>                       result =3D SCAN_PAGE_COUNT;
>>>                       goto out;
>>> @@ -680,7 +688,6 @@ static void __collapse_huge_page_copy(pte_t *pte,=
 struct page *page,
>>>               } else {
>>>                       src_page =3D pte_page(pteval);
>>>                       copy_user_highpage(page, src_page, address, vma=
);
>>> -                     VM_BUG_ON_PAGE(page_mapcount(src_page) !=3D 1, =
src_page);
>>
>> Maybe replace it with this?
>>
>> VM_BUG_ON_PAGE(page_mapcount(src_page) + PageSwapCache(src_page) !=3D =
page_count(src_page), src_page);
>
> I don't think this is correct either. If a THP is PTE mapped its
> refcount would be bumped by the number of PTE mapped subpages. But
> page_mapcount() would just return the mapcount of that specific
> subpage. So, total_mapcount() should be used, but the same check has
> been done before reaching here.

Yes, you are right. Thanks.

Please disregard this comment.

=E2=80=94
Best Regards,
Yan Zi

--=_MailMate_32016954-B99D-44CD-BE67-01B33907190B_=
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQJDBAEBCgAtFiEEh7yFAW3gwjwQ4C9anbJR82th+ooFAl5+c9gPHHppeUBudmlk
aWEuY29tAAoJEJ2yUfNrYfqKsyAP/i12fyBS2ituC3rfVid/bDImAZfQY5ZmUwOi
hRZzsfdXxw3M5eF79z39HPGCeh8pOOJdu5wK+Ug/20GchAj/V1F/VplnoUF+nSwv
nRRXUo7QkMk/6KYxCeWWytbE7xiOb4POzGcYsnh25pE9hAQ3yweW5WQXidNyHjGo
Ba20hGQj6GTWx9wnaNHqOcAIMzG1a+dRymRp8jARqtB+lw7FP1hJrbzh2yy0meyB
svBAGL8KKSI7RSb50T2PxZIjlZgnLtiTnUm8/tDZJ9smF0TImggTxDaBpOp8YHqU
rq0obnu7MYwkPQjYKjYgVX3u6+d07hgUrAZKAPEgNCIzQr0KKrJ5AZFA7U4ZznWx
YyZG11RxdxyJRnmtbUv3/mPJ54sAOqnOIhz/h6Wg0bZrOcA0XoY9tg80Tc/bh7zS
MHr/JCVCquPbFgAj+RvsCl0YNo8Y/l+49xQIZt3wbRZe56l3e1wTOgAkBGEtrd5G
yd2WHSP6oAXgE0WM4RJLnusrBUut2bQ6CyDsvhLMOiNzSKuK03LuuMGv8+9+eZuG
qcwCLbe2Rc3+OO4fD0tpQIJzOAOl+VV0ztSGhZss4ZPMl7szNSrUERcQytEH5Tc+
UbeAicfvNIAW+vE2faH6rls+AeWKltVZavBI3wWxASTrvydhHwPYkmcF3BrkrRzH
eKtMEysU
=wx8b
-----END PGP SIGNATURE-----

--=_MailMate_32016954-B99D-44CD-BE67-01B33907190B_=--
