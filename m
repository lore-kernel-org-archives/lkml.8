Return-Path: <SRS0=s8dx=5M=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2D434C43331
	for <linux-kernel@archiver.kernel.org>; Fri, 27 Mar 2020 18:55:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F134A20575
	for <linux-kernel@archiver.kernel.org>; Fri, 27 Mar 2020 18:55:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=nvidia.com header.i=@nvidia.com header.b="ZIyaxiqt"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727620AbgC0SzK (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 27 Mar 2020 14:55:10 -0400
Received: from hqnvemgate24.nvidia.com ([216.228.121.143]:12072 "EHLO
        hqnvemgate24.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726738AbgC0SzK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 27 Mar 2020 14:55:10 -0400
Received: from hqpgpgate101.nvidia.com (Not Verified[216.228.121.13]) by hqnvemgate24.nvidia.com (using TLS: TLSv1.2, DES-CBC3-SHA)
        id <B5e7e4bb00000>; Fri, 27 Mar 2020 11:53:36 -0700
Received: from hqmail.nvidia.com ([172.20.161.6])
  by hqpgpgate101.nvidia.com (PGP Universal service);
  Fri, 27 Mar 2020 11:55:09 -0700
X-PGP-Universal: processed;
        by hqpgpgate101.nvidia.com on Fri, 27 Mar 2020 11:55:09 -0700
Received: from [10.2.174.211] (10.124.1.5) by HQMAIL107.nvidia.com
 (172.20.187.13) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Fri, 27 Mar
 2020 18:55:08 +0000
From:   Zi Yan <ziy@nvidia.com>
To:     "Kirill A. Shutemov" <kirill@shutemov.name>
CC:     <akpm@linux-foundation.org>,
        Andrea Arcangeli <aarcange@redhat.com>, <linux-mm@kvack.org>,
        <linux-kernel@vger.kernel.org>,
        "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>
Subject: Re: [PATCH 5/7] khugepaged: Allow to collapse PTE-mapped compound
 pages
Date:   Fri, 27 Mar 2020 14:55:06 -0400
X-Mailer: MailMate (1.13.1r5680)
Message-ID: <D5721ED6-774B-4CD3-8533-4BF9BDB2401E@nvidia.com>
In-Reply-To: <20200327170601.18563-6-kirill.shutemov@linux.intel.com>
References: <20200327170601.18563-1-kirill.shutemov@linux.intel.com>
 <20200327170601.18563-6-kirill.shutemov@linux.intel.com>
MIME-Version: 1.0
X-Originating-IP: [10.124.1.5]
X-ClientProxiedBy: HQMAIL105.nvidia.com (172.20.187.12) To
 HQMAIL107.nvidia.com (172.20.187.13)
Content-Type: multipart/signed;
        boundary="=_MailMate_FD5AA855-FE04-4B04-8942-69FED85DC9DD_=";
        micalg=pgp-sha512; protocol="application/pgp-signature"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
        t=1585335216; bh=db8inRFEgCho5kZGVFCanLkzLlprHBygNGihcIGUiMg=;
        h=X-PGP-Universal:From:To:CC:Subject:Date:X-Mailer:Message-ID:
         In-Reply-To:References:MIME-Version:X-Originating-IP:
         X-ClientProxiedBy:Content-Type;
        b=ZIyaxiqtBQCr/conptCOf99BleVeIjm0n973tA+PpJfQq8pqJ/V8eT/5JucOvazXf
         knsERFAHsz/cFbxH0tQ+OqEyAoAOEDuY8vMK/LuDK1Pxl2LgaM54lHhtm/9Fz6uUZO
         zsBHVlZiKjkiQa5E9tnv/3oH/pwzbmjugN0JvX2AwJr6C31U55v7VG9naQ2vV/ij/S
         wEzpFe7iFc/DT1O6NAgV03lw1B6mIc0cNXSWfX4I4O13mwhT5teQAh/pZMzqTSHPy4
         ocES8drit3FxQYScHdrIVQXEzmeAqBZkZ9VhdC5Arszqfp1cBjuyVzc4GB3ukrb2j/
         xB7gexDzVynzA==
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--=_MailMate_FD5AA855-FE04-4B04-8942-69FED85DC9DD_=
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On 27 Mar 2020, at 13:05, Kirill A. Shutemov wrote:

> We can collapse PTE-mapped compound pages. We only need to avoid
> handling them more than once: lock/unlock page only once if it's presen=
t
> in the PMD range multiple times as it handled on compound level. The
> same goes for LRU isolation and putpack.

s/putpack/putback/

>
> Signed-off-by: Kirill A. Shutemov <kirill.shutemov@linux.intel.com>
> ---
>  mm/khugepaged.c | 41 +++++++++++++++++++++++++++++++----------
>  1 file changed, 31 insertions(+), 10 deletions(-)
>
> diff --git a/mm/khugepaged.c b/mm/khugepaged.c
> index b47edfe57f7b..c8c2c463095c 100644
> --- a/mm/khugepaged.c
> +++ b/mm/khugepaged.c
> @@ -515,6 +515,17 @@ void __khugepaged_exit(struct mm_struct *mm)
>
>  static void release_pte_page(struct page *page)
>  {
> +	/*
> +	 * We need to unlock and put compound page on LRU only once.
> +	 * The rest of the pages have to be locked and not on LRU here.
> +	 */
> +	VM_BUG_ON_PAGE(!PageCompound(page) &&
> +			(!PageLocked(page) && PageLRU(page)), page);
It only checks base pages.

Add

VM_BUG_ON_PAGE(PageCompound(page) && PageLocked(page) && PageLRU(page), p=
age);

to check for compound pages.

> +
> +	if (!PageLocked(page))
> +		return;
> +
> +	page =3D compound_head(page);
>  	dec_node_page_state(page, NR_ISOLATED_ANON + page_is_file_cache(page)=
);
>  	unlock_page(page);
>  	putback_lru_page(page);
> @@ -537,6 +548,7 @@ static int __collapse_huge_page_isolate(struct vm_a=
rea_struct *vma,
>  	pte_t *_pte;
>  	int none_or_zero =3D 0, result =3D 0, referenced =3D 0;
>  	bool writable =3D false;
> +	LIST_HEAD(compound_pagelist);
>
>  	for (_pte =3D pte; _pte < pte+HPAGE_PMD_NR;
>  	     _pte++, address +=3D PAGE_SIZE) {
> @@ -561,13 +573,23 @@ static int __collapse_huge_page_isolate(struct vm=
_area_struct *vma,
>  			goto out;
>  		}
>
> -		/* TODO: teach khugepaged to collapse THP mapped with pte */
> +		VM_BUG_ON_PAGE(!PageAnon(page), page);
> +
>  		if (PageCompound(page)) {
> -			result =3D SCAN_PAGE_COMPOUND;
> -			goto out;
> -		}
> +			struct page *p;
> +			page =3D compound_head(page);
>
> -		VM_BUG_ON_PAGE(!PageAnon(page), page);
> +			/*
> +			 * Check if we have dealt with the compount page

s/compount/compound/

> +			 * already
> +			 */
> +			list_for_each_entry(p, &compound_pagelist, lru) {
> +				if (page =3D=3D  p)
> +					break;
> +			}
> +			if (page =3D=3D  p)
> +				continue;
> +		}
>
>  		/*
>  		 * We can do it before isolate_lru_page because the
> @@ -640,6 +662,9 @@ static int __collapse_huge_page_isolate(struct vm_a=
rea_struct *vma,
>  		    page_is_young(page) || PageReferenced(page) ||
>  		    mmu_notifier_test_young(vma->vm_mm, address))
>  			referenced++;
> +
> +		if (PageCompound(page))
> +			list_add_tail(&page->lru, &compound_pagelist);
>  	}
>  	if (likely(writable)) {
>  		if (likely(referenced)) {

Do we need a list here? There should be at most one compound page we will=
 see here, right?

If a compound page is seen here, can we bail out the loop early? I guess =
not,
because we can a partially mapped compound page at the beginning or the e=
nd of a VMA, right?

> @@ -1185,11 +1210,7 @@ static int khugepaged_scan_pmd(struct mm_struct =
*mm,
>  			goto out_unmap;
>  		}
>
> -		/* TODO: teach khugepaged to collapse THP mapped with pte */
> -		if (PageCompound(page)) {
> -			result =3D SCAN_PAGE_COMPOUND;
> -			goto out_unmap;
> -		}
> +		page =3D compound_head(page);
>
>  		/*
>  		 * Record which node the original page is from and save this
> -- =

> 2.26.0


=E2=80=94
Best Regards,
Yan Zi

--=_MailMate_FD5AA855-FE04-4B04-8942-69FED85DC9DD_=
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQJDBAEBCgAtFiEEh7yFAW3gwjwQ4C9anbJR82th+ooFAl5+TAoPHHppeUBudmlk
aWEuY29tAAoJEJ2yUfNrYfqKQPUP/Asndkpg6Oz1IwSvvKjmXoaCK8VTGM5DmGeZ
KGr8ndYiS9JfOiOCoxX7dpj3XjnpV9t3Xe9Ih6UdDRuBirk+ZX779TVbTbajX+Z4
dkfr84PTx0iag6P4CWp451V3CaDPp5eM9eR68hzU1xhAyJ3Rj3/GjFs0eYASDS7e
lPNkvNS/1I0tBfz125QYOoD4KBxXcTkeJCSIxOWbJ0+k80tASeYoBDSb+xA+zjCV
8xO6k9X4Oqy61VuBMyZvxFoyAnOuKaAKGc6BmKLe254ks/ki5ckDi/6R4Vix+qcy
Ler16LdQOE1oveVg1pPK2r0fSb0JNiaOlzZ5x9G97SCdUh6uCzj0HPq7ljUnK3DA
dwI3IH63JcB1lrIhQJIUOaEiC3QGrd4W04IhUEdDQOa0+l7Ulk01G3ewDFdP1mI3
qFm20DAutMHp3RxL5U08inqsm6s9telXL9mSCKTM5xXnCr1yw5USsRXPAinK9NqG
0EcC5E1YmG9weiCNKshulTpIj7vqQiOCOc/RJdu3Fy10LGZ1ZdO/rLuQPtU3MESv
+8E7+C0UGloFFif6OqxQ1mdr4hG7SEb0peGkrgMe30rwmnvhSZ0ACAu22n3bQE87
A8+jF7OP/BLCRqx1nr8ngFsMWAfb0I8KikHdX3gGT3xQWq38ZnwN7tKl27BJ60pl
UCOwgrSG
=gfhJ
-----END PGP SIGNATURE-----

--=_MailMate_FD5AA855-FE04-4B04-8942-69FED85DC9DD_=--
