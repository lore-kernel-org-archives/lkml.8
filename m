Return-Path: <SRS0=s8dx=5M=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E26FBC43331
	for <linux-kernel@archiver.kernel.org>; Fri, 27 Mar 2020 17:23:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 98420206F6
	for <linux-kernel@archiver.kernel.org>; Fri, 27 Mar 2020 17:23:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=nvidia.com header.i=@nvidia.com header.b="T5LOLeqK"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727826AbgC0RXL (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 27 Mar 2020 13:23:11 -0400
Received: from hqnvemgate26.nvidia.com ([216.228.121.65]:4526 "EHLO
        hqnvemgate26.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727774AbgC0RXL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 27 Mar 2020 13:23:11 -0400
Received: from hqpgpgate101.nvidia.com (Not Verified[216.228.121.13]) by hqnvemgate26.nvidia.com (using TLS: TLSv1.2, DES-CBC3-SHA)
        id <B5e7e36710000>; Fri, 27 Mar 2020 10:22:57 -0700
Received: from hqmail.nvidia.com ([172.20.161.6])
  by hqpgpgate101.nvidia.com (PGP Universal service);
  Fri, 27 Mar 2020 10:23:10 -0700
X-PGP-Universal: processed;
        by hqpgpgate101.nvidia.com on Fri, 27 Mar 2020 10:23:10 -0700
Received: from [10.2.174.211] (10.124.1.5) by HQMAIL107.nvidia.com
 (172.20.187.13) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Fri, 27 Mar
 2020 17:23:09 +0000
From:   Zi Yan <ziy@nvidia.com>
To:     "Kirill A. Shutemov" <kirill@shutemov.name>
CC:     <akpm@linux-foundation.org>, <linux-mm@kvack.org>,
        <linux-kernel@vger.kernel.org>,
        "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>
Subject: Re: [PATCH] thp: Simplify splitting PMD mapping huge zero page
Date:   Fri, 27 Mar 2020 13:23:07 -0400
X-Mailer: MailMate (1.13.1r5680)
Message-ID: <1437F525-1510-45CD-A67F-13DF525083B4@nvidia.com>
In-Reply-To: <20200327170353.17734-1-kirill.shutemov@linux.intel.com>
References: <20200327170353.17734-1-kirill.shutemov@linux.intel.com>
MIME-Version: 1.0
X-Originating-IP: [10.124.1.5]
X-ClientProxiedBy: HQMAIL105.nvidia.com (172.20.187.12) To
 HQMAIL107.nvidia.com (172.20.187.13)
Content-Type: multipart/signed;
        boundary="=_MailMate_599EAE79-B2CE-48B1-AF70-8D6DAE5AE4CC_=";
        micalg=pgp-sha512; protocol="application/pgp-signature"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
        t=1585329777; bh=7IbSNg50TfExuqcJifxmze/ksWZPzBseN/j1iA45OAg=;
        h=X-PGP-Universal:From:To:CC:Subject:Date:X-Mailer:Message-ID:
         In-Reply-To:References:MIME-Version:X-Originating-IP:
         X-ClientProxiedBy:Content-Type;
        b=T5LOLeqKpB969Ap/aogowEN9df3SCNdguEhHb23psTlf+iaG/7h8UoxaCZvhHkWHt
         sTf7KNRr+l2bjf2FBqqTtq/oZ8eZC3GWmtJtMQ7ck4dyIKycijtt5GDPCJKA5UipAj
         6zm74kNl0BvuOI7tFu/B9KMqI71edN//D/9E3bCYVNYJY0Am+mf6cyXoxOxOwbMRsH
         gnQOivBLQhYaWdNl58tAWhEpNh1sjkiMusITXH85xlSYQDdr6jz1ugn0Va+mR1mmE8
         lFPvuf7En6+ItoXLXAaDMxPf3JZ6QFkbXk6iezhj1RBqIm/B+NKujq/Lq7NHw5IHQB
         e6X0EDtEdry2Q==
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--=_MailMate_599EAE79-B2CE-48B1-AF70-8D6DAE5AE4CC_=
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On 27 Mar 2020, at 13:03, Kirill A. Shutemov wrote:

> Splitting PMD mapping huge zero page can be simplified a lot: we can
> just unmap it and fallback to PTE handling.

So we will have an extra page fault for the first read to each subpage, b=
ut nothing changes if the first access to a subpage is a write, right? BT=
W, what is the motivation for this code simplification?

Thanks.

>
> Signed-off-by: Kirill A. Shutemov <kirill.shutemov@linux.intel.com>
> ---
>  mm/huge_memory.c | 57 ++++--------------------------------------------=

>  1 file changed, 4 insertions(+), 53 deletions(-)
>
> diff --git a/mm/huge_memory.c b/mm/huge_memory.c
> index 42407e16bd80..ef6a6bcb291f 100644
> --- a/mm/huge_memory.c
> +++ b/mm/huge_memory.c
> @@ -2114,40 +2114,6 @@ void __split_huge_pud(struct vm_area_struct *vma=
, pud_t *pud,
>  }
>  #endif /* CONFIG_HAVE_ARCH_TRANSPARENT_HUGEPAGE_PUD */
>
> -static void __split_huge_zero_page_pmd(struct vm_area_struct *vma,
> -		unsigned long haddr, pmd_t *pmd)
> -{
> -	struct mm_struct *mm =3D vma->vm_mm;
> -	pgtable_t pgtable;
> -	pmd_t _pmd;
> -	int i;
> -
> -	/*
> -	 * Leave pmd empty until pte is filled note that it is fine to delay
> -	 * notification until mmu_notifier_invalidate_range_end() as we are
> -	 * replacing a zero pmd write protected page with a zero pte write
> -	 * protected page.
> -	 *
> -	 * See Documentation/vm/mmu_notifier.rst
> -	 */
> -	pmdp_huge_clear_flush(vma, haddr, pmd);
> -
> -	pgtable =3D pgtable_trans_huge_withdraw(mm, pmd);
> -	pmd_populate(mm, &_pmd, pgtable);
> -
> -	for (i =3D 0; i < HPAGE_PMD_NR; i++, haddr +=3D PAGE_SIZE) {
> -		pte_t *pte, entry;
> -		entry =3D pfn_pte(my_zero_pfn(haddr), vma->vm_page_prot);
> -		entry =3D pte_mkspecial(entry);
> -		pte =3D pte_offset_map(&_pmd, haddr);
> -		VM_BUG_ON(!pte_none(*pte));
> -		set_pte_at(mm, haddr, pte, entry);
> -		pte_unmap(pte);
> -	}
> -	smp_wmb(); /* make pte visible before pmd */
> -	pmd_populate(mm, pmd, pgtable);
> -}
> -
>  static void __split_huge_pmd_locked(struct vm_area_struct *vma, pmd_t =
*pmd,
>  		unsigned long haddr, bool freeze)
>  {
> @@ -2167,7 +2133,7 @@ static void __split_huge_pmd_locked(struct vm_are=
a_struct *vma, pmd_t *pmd,
>
>  	count_vm_event(THP_SPLIT_PMD);
>
> -	if (!vma_is_anonymous(vma)) {
> +	if (!vma_is_anonymous(vma) || is_huge_zero_pmd(*pmd)) {
>  		_pmd =3D pmdp_huge_clear_flush_notify(vma, haddr, pmd);
>  		/*
>  		 * We are going to unmap this huge page. So
> @@ -2175,7 +2141,7 @@ static void __split_huge_pmd_locked(struct vm_are=
a_struct *vma, pmd_t *pmd,
>  		 */
>  		if (arch_needs_pgtable_deposit())
>  			zap_deposited_table(mm, pmd);
> -		if (vma_is_dax(vma))
> +		if (vma_is_dax(vma) || is_huge_zero_pmd(*pmd))
>  			return;
>  		page =3D pmd_page(_pmd);
>  		if (!PageDirty(page) && pmd_dirty(_pmd))
> @@ -2186,17 +2152,6 @@ static void __split_huge_pmd_locked(struct vm_ar=
ea_struct *vma, pmd_t *pmd,
>  		put_page(page);
>  		add_mm_counter(mm, mm_counter_file(page), -HPAGE_PMD_NR);
>  		return;
> -	} else if (is_huge_zero_pmd(*pmd)) {
> -		/*
> -		 * FIXME: Do we want to invalidate secondary mmu by calling
> -		 * mmu_notifier_invalidate_range() see comments below inside
> -		 * __split_huge_pmd() ?
> -		 *
> -		 * We are going from a zero huge page write protected to zero
> -		 * small page also write protected so it does not seems useful
> -		 * to invalidate secondary mmu at this time.
> -		 */
> -		return __split_huge_zero_page_pmd(vma, haddr, pmd);
>  	}
>
>  	/*
> @@ -2339,13 +2294,9 @@ void __split_huge_pmd(struct vm_area_struct *vma=
, pmd_t *pmd,
>  	spin_unlock(ptl);
>  	/*
>  	 * No need to double call mmu_notifier->invalidate_range() callback.
> -	 * They are 3 cases to consider inside __split_huge_pmd_locked():
> +	 * They are 2 cases to consider inside __split_huge_pmd_locked():
>  	 *  1) pmdp_huge_clear_flush_notify() call invalidate_range() obvious=

> -	 *  2) __split_huge_zero_page_pmd() read only zero page and any write=

> -	 *    fault will trigger a flush_notify before pointing to a new page=

> -	 *    (it is fine if the secondary mmu keeps pointing to the old zero=

> -	 *    page in the meantime)
> -	 *  3) Split a huge pmd into pte pointing to the same page. No need
> +	 *  2) Split a huge pmd into pte pointing to the same page. No need
>  	 *     to invalidate secondary tlb entry they are all still valid.
>  	 *     any further changes to individual pte will notify. So no need
>  	 *     to call mmu_notifier->invalidate_range()
> -- =

> 2.26.0


=E2=80=94
Best Regards,
Yan Zi

--=_MailMate_599EAE79-B2CE-48B1-AF70-8D6DAE5AE4CC_=
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQJDBAEBCgAtFiEEh7yFAW3gwjwQ4C9anbJR82th+ooFAl5+NnsPHHppeUBudmlk
aWEuY29tAAoJEJ2yUfNrYfqKvloP/3OleI+cuML2sRkeXDTStmKyMrVOb3bjg0dm
uXOg0nam4LaHF/nohfAJA+soBFt4Rua1OjxvqxhfFrCnYXjV6UOV8k2yBiijZg89
S8XrNdlFwSy3YVs1dt8+ecqDbzTvs7rtAZKGp2aDQus5vb5QCCdeyqxIiSOQOhNA
j9oTQmjik739axtbGYoIQn2iHdmOk/tLJM4oZQCiLqfIJ7rJCpaWG9r+FTQrx/mG
jc+bLUuhBARQIUmYiXlPIn3GAmbti5LvDFIJF4fKqwwAxCU8A2hkexgDmycetFNH
Pe0MhHsh3QAuq7ea2mK7opjP4mNIK0svasaDiheliGRcG8O7CTOYQpNJ1K3tP0++
MmM3By+uYyTheYTgxkB7soXOHFVcuEuPKy1pXWzmcusmGfIjyx+6Y3rz2TnvYAPM
tqHfUFcybw0mHLcDNuTVX+JcjPlWnMSW8OGmAvdkAmzf/x4SGFMhpzZXf+7KuE5q
VmUGALNCA1rqbC5edsxn0M/KvLRT933efF+6NSOSxuDL2hDVtNQPHaXwHx9OjNhA
UeuioUmEK7KcUXg57toch/hbuWrio8oJpndD73vEfU1msRh9FMLovF9IReiLpK2p
ZBKRqWM45ILxheR0esBM2wjgXxvHN+29j81X+ZSOw8EDd5I4vDN1rA1ZltoXxWyS
5rU0k01k
=T2V/
-----END PGP SIGNATURE-----

--=_MailMate_599EAE79-B2CE-48B1-AF70-8D6DAE5AE4CC_=--
