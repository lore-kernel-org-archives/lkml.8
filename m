Return-Path: <SRS0=iZCi=CS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CF864C433E2
	for <linux-kernel@archiver.kernel.org>; Wed,  9 Sep 2020 16:21:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 72F57206B8
	for <linux-kernel@archiver.kernel.org>; Wed,  9 Sep 2020 16:21:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=nvidia.com header.i=@nvidia.com header.b="gR9jl/7e"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731016AbgIIQVx (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 9 Sep 2020 12:21:53 -0400
Received: from hqnvemgate24.nvidia.com ([216.228.121.143]:14539 "EHLO
        hqnvemgate24.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730755AbgIIQUI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Sep 2020 12:20:08 -0400
Received: from hqpgpgate102.nvidia.com (Not Verified[216.228.121.13]) by hqnvemgate24.nvidia.com (using TLS: TLSv1.2, DES-CBC3-SHA)
        id <B5f58e7de0000>; Wed, 09 Sep 2020 07:34:06 -0700
Received: from hqmail.nvidia.com ([172.20.161.6])
  by hqpgpgate102.nvidia.com (PGP Universal service);
  Wed, 09 Sep 2020 07:36:21 -0700
X-PGP-Universal: processed;
        by hqpgpgate102.nvidia.com on Wed, 09 Sep 2020 07:36:21 -0700
Received: from [10.2.173.224] (10.124.1.5) by HQMAIL107.nvidia.com
 (172.20.187.13) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Wed, 9 Sep
 2020 14:36:18 +0000
From:   Zi Yan <ziy@nvidia.com>
To:     "Kirill A. Shutemov" <kirill@shutemov.name>
CC:     <linux-mm@kvack.org>, Roman Gushchin <guro@fb.com>,
        Rik van Riel <riel@surriel.com>,
        "Kirill A . Shutemov" <kirill.shutemov@linux.intel.com>,
        Matthew Wilcox <willy@infradead.org>,
        Shakeel Butt <shakeelb@google.com>,
        Yang Shi <yang.shi@linux.alibaba.com>,
        David Nellans <dnellans@nvidia.com>,
        <linux-kernel@vger.kernel.org>
Subject: Re: [RFC PATCH 05/16] mm: thp: handling 1GB THP reference bit.
Date:   Wed, 9 Sep 2020 10:36:16 -0400
X-Mailer: MailMate (1.13.1r5705)
Message-ID: <95796544-9577-45F1-951E-4F401DD2680E@nvidia.com>
In-Reply-To: <20200909140912.g2s4y22li2xwfttr@box>
References: <20200902180628.4052244-1-zi.yan@sent.com>
 <20200902180628.4052244-6-zi.yan@sent.com>
 <20200909140912.g2s4y22li2xwfttr@box>
MIME-Version: 1.0
X-Originating-IP: [10.124.1.5]
X-ClientProxiedBy: HQMAIL111.nvidia.com (172.20.187.18) To
 HQMAIL107.nvidia.com (172.20.187.13)
Content-Type: multipart/signed;
        boundary="=_MailMate_2E2DEB0F-C3D6-43CD-858A-9FB7721B04C1_=";
        micalg=pgp-sha512; protocol="application/pgp-signature"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
        t=1599662046; bh=/ooPa/4jWwIWpcqMahAswEgohbquIxzTTZKC/Pbuzec=;
        h=X-PGP-Universal:From:To:CC:Subject:Date:X-Mailer:Message-ID:
         In-Reply-To:References:MIME-Version:X-Originating-IP:
         X-ClientProxiedBy:Content-Type;
        b=gR9jl/7eZkwMtYo/VNomtEFTTnOAu+FItha/r17yS25FzGAs3mQiCzF/mhRmnOB/6
         KS+osoGJExM37wT4DIhzpVL2EeZgNQGFym/aVY+17aiNw/OXLpTN6QrGSBU5SPuUGs
         A2GQz6m/rO1Ai6kafmyrwYKac5haplIW3kRGKnwSh5fdrylJLlYdbG+mXgdJUAWv1n
         3EN0seZ2EOxy5Te0jHzUrVtPsBOAYdpp0da6sHAAUiZS95YB9ZAkNybXqJctVIqv9W
         WIvKJQHxOBIS0GkRKFv+bghpgki4s5yv8mG26NxrfudRVsElfTMCNyIiPjQXRBE/rc
         XiLASFm5RYPtw==
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--=_MailMate_2E2DEB0F-C3D6-43CD-858A-9FB7721B04C1_=
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On 9 Sep 2020, at 10:09, Kirill A. Shutemov wrote:

> On Wed, Sep 02, 2020 at 02:06:17PM -0400, Zi Yan wrote:
>> From: Zi Yan <ziy@nvidia.com>
>>
>> Add PUD-level TLB flush ops and teach page_vma_mapped_talk about 1GB
>> THPs.
>>
>> Signed-off-by: Zi Yan <ziy@nvidia.com>
>> ---
>>  arch/x86/include/asm/pgtable.h |  3 +++
>>  arch/x86/mm/pgtable.c          | 13 +++++++++++++
>>  include/linux/mmu_notifier.h   | 13 +++++++++++++
>>  include/linux/pgtable.h        | 14 ++++++++++++++
>>  include/linux/rmap.h           |  1 +
>>  mm/page_vma_mapped.c           | 33 +++++++++++++++++++++++++++++----=

>>  mm/rmap.c                      | 12 +++++++++---
>>  7 files changed, 82 insertions(+), 7 deletions(-)
>>
>> diff --git a/arch/x86/include/asm/pgtable.h b/arch/x86/include/asm/pgt=
able.h
>> index 26255cac78c0..15334f5ba172 100644
>> --- a/arch/x86/include/asm/pgtable.h
>> +++ b/arch/x86/include/asm/pgtable.h
>> @@ -1127,6 +1127,9 @@ extern int pudp_test_and_clear_young(struct vm_a=
rea_struct *vma,
>>  extern int pmdp_clear_flush_young(struct vm_area_struct *vma,
>>  				  unsigned long address, pmd_t *pmdp);
>>
>> +#define __HAVE_ARCH_PUDP_CLEAR_YOUNG_FLUSH
>> +extern int pudp_clear_flush_young(struct vm_area_struct *vma,
>> +				  unsigned long address, pud_t *pudp);
>>
>>  #define pmd_write pmd_write
>>  static inline int pmd_write(pmd_t pmd)
>> diff --git a/arch/x86/mm/pgtable.c b/arch/x86/mm/pgtable.c
>> index 7be73aee6183..e4a2dffcc418 100644
>> --- a/arch/x86/mm/pgtable.c
>> +++ b/arch/x86/mm/pgtable.c
>> @@ -633,6 +633,19 @@ int pmdp_clear_flush_young(struct vm_area_struct =
*vma,
>>
>>  	return young;
>>  }
>> +int pudp_clear_flush_young(struct vm_area_struct *vma,
>> +			   unsigned long address, pud_t *pudp)
>> +{
>> +	int young;
>> +
>> +	VM_BUG_ON(address & ~HPAGE_PUD_MASK);
>> +
>> +	young =3D pudp_test_and_clear_young(vma, address, pudp);
>> +	if (young)
>> +		flush_tlb_range(vma, address, address + HPAGE_PUD_SIZE);
>> +
>> +	return young;
>> +}
>>  #endif
>>
>>  /**
>> diff --git a/include/linux/mmu_notifier.h b/include/linux/mmu_notifier=
=2Eh
>> index b8200782dede..4ffa179e654f 100644
>> --- a/include/linux/mmu_notifier.h
>> +++ b/include/linux/mmu_notifier.h
>> @@ -557,6 +557,19 @@ static inline void mmu_notifier_range_init_migrat=
e(
>>  	__young;							\
>>  })
>>
>> +#define pudp_clear_flush_young_notify(__vma, __address, __pudp)		\
>> +({									\
>> +	int __young;							\
>> +	struct vm_area_struct *___vma =3D __vma;				\
>> +	unsigned long ___address =3D __address;				\
>> +	__young =3D pudp_clear_flush_young(___vma, ___address, __pudp);	\
>> +	__young |=3D mmu_notifier_clear_flush_young(___vma->vm_mm,	\
>> +						  ___address,		\
>> +						  ___address +		\
>> +							PUD_SIZE);	\
>> +	__young;							\
>> +})
>> +
>>  #define ptep_clear_young_notify(__vma, __address, __ptep)		\
>>  ({									\
>>  	int __young;							\
>> diff --git a/include/linux/pgtable.h b/include/linux/pgtable.h
>> index 255275d5b73e..8ef358c386af 100644
>> --- a/include/linux/pgtable.h
>> +++ b/include/linux/pgtable.h
>> @@ -240,6 +240,20 @@ static inline int pmdp_clear_flush_young(struct v=
m_area_struct *vma,
>>  #endif /* CONFIG_TRANSPARENT_HUGEPAGE */
>>  #endif
>>
>> +#ifndef __HAVE_ARCH_PUDP_CLEAR_YOUNG_FLUSH
>> +#ifdef CONFIG_HAVE_ARCH_TRANSPARENT_HUGEPAGE_PUD
>> +extern int pudp_clear_flush_young(struct vm_area_struct *vma,
>> +				  unsigned long address, pud_t *pudp);
>> +#else
>> +int pudp_clear_flush_young(struct vm_area_struct *vma,
>> +				  unsigned long address, pud_t *pudp)
>> +{
>> +	BUILD_BUG();
>> +	return 0;
>> +}
>> +#endif /* CONFIG_HAVE_ARCH_TRANSPARENT_HUGEPAGE_PUD  */
>> +#endif
>> +
>>  #ifndef __HAVE_ARCH_PTEP_GET_AND_CLEAR
>>  static inline pte_t ptep_get_and_clear(struct mm_struct *mm,
>>  				       unsigned long address,
>> diff --git a/include/linux/rmap.h b/include/linux/rmap.h
>> index 3a6adfa70fb0..0af61dd193d2 100644
>> --- a/include/linux/rmap.h
>> +++ b/include/linux/rmap.h
>> @@ -206,6 +206,7 @@ struct page_vma_mapped_walk {
>>  	struct page *page;
>>  	struct vm_area_struct *vma;
>>  	unsigned long address;
>> +	pud_t *pud;
>>  	pmd_t *pmd;
>>  	pte_t *pte;
>>  	spinlock_t *ptl;
>> diff --git a/mm/page_vma_mapped.c b/mm/page_vma_mapped.c
>> index 5e77b269c330..d9d39ec06e21 100644
>> --- a/mm/page_vma_mapped.c
>> +++ b/mm/page_vma_mapped.c
>> @@ -145,9 +145,12 @@ bool page_vma_mapped_walk(struct page_vma_mapped_=
walk *pvmw)
>>  	struct page *page =3D pvmw->page;
>>  	pgd_t *pgd;
>>  	p4d_t *p4d;
>> -	pud_t *pud;
>> +	pud_t pude;
>>  	pmd_t pmde;
>>
>> +	if (!pvmw->pte && !pvmw->pmd && pvmw->pud)
>> +		return not_found(pvmw);
>> +
>>  	/* The only possible pmd mapping has been handled on last iteration =
*/
>>  	if (pvmw->pmd && !pvmw->pte)
>>  		return not_found(pvmw);
>> @@ -174,10 +177,31 @@ bool page_vma_mapped_walk(struct page_vma_mapped=
_walk *pvmw)
>>  	p4d =3D p4d_offset(pgd, pvmw->address);
>>  	if (!p4d_present(*p4d))
>>  		return false;
>> -	pud =3D pud_offset(p4d, pvmw->address);
>> -	if (!pud_present(*pud))
>> +	pvmw->pud =3D pud_offset(p4d, pvmw->address);
>> +
>> +	/*
>> +	 * Make sure the pud value isn't cached in a register by the
>> +	 * compiler and used as a stale value after we've observed a
>> +	 * subsequent update.
>> +	 */
>> +	pude =3D READ_ONCE(*pvmw->pud);
>> +	if (pud_trans_huge(pude)) {
>> +		pvmw->ptl =3D pud_lock(mm, pvmw->pud);
>> +		if (likely(pud_trans_huge(*pvmw->pud))) {
>> +			if (pvmw->flags & PVMW_MIGRATION)
>> +				return not_found(pvmw);
>> +			if (pud_page(*pvmw->pud) !=3D page)
>> +				return not_found(pvmw);
>> +			return true;
>> +		} else {
>> +			/* THP pud was split under us: handle on pmd level */
>> +			spin_unlock(pvmw->ptl);
>> +			pvmw->ptl =3D NULL;
>
> Hm. What makes you sure the pmd table is established here?
>
> I have not looked at PUD THP handling of  MADV_DONTNEED yet, but for PM=
D
> THP can became pmd_none() at any point (unless ptl is locked).

You are right. I need to check pud_present here and only
go to pmd level when pud is present, otherwise just return with not_found=
=2E

Thanks.


>
>> +		}
>> +	} else if (!pud_present(pude))
>>  		return false;
>> -	pvmw->pmd =3D pmd_offset(pud, pvmw->address);
>> +
>> +	pvmw->pmd =3D pmd_offset(pvmw->pud, pvmw->address);
>>  	/*
>>  	 * Make sure the pmd value isn't cached in a register by the
>>  	 * compiler and used as a stale value after we've observed a
>> @@ -213,6 +237,7 @@ bool page_vma_mapped_walk(struct page_vma_mapped_w=
alk *pvmw)
>>  	} else if (!pmd_present(pmde)) {
>>  		return false;
>>  	}
>> +
>>  	if (!map_pte(pvmw))
>>  		goto next_pte;
>>  	while (1) {
>> diff --git a/mm/rmap.c b/mm/rmap.c
>
> Why?
>

The extra newline? Will remove it.

>> index 10195a2421cf..77cec0658b76 100644
>> --- a/mm/rmap.c
>> +++ b/mm/rmap.c
>> @@ -803,9 +803,15 @@ static bool page_referenced_one(struct page *page=
, struct vm_area_struct *vma,
>>  					referenced++;
>>  			}
>>  		} else if (IS_ENABLED(CONFIG_TRANSPARENT_HUGEPAGE)) {
>> -			if (pmdp_clear_flush_young_notify(vma, address,
>> -						pvmw.pmd))
>> -				referenced++;
>> +			if (pvmw.pmd) {
>> +				if (pmdp_clear_flush_young_notify(vma, address,
>> +							pvmw.pmd))
>> +					referenced++;
>> +			} else if (pvmw.pud) {
>> +				if (pudp_clear_flush_young_notify(vma, address,
>> +							pvmw.pud))
>> +					referenced++;
>> +			}
>>  		} else {
>>  			/* unexpected pmd-mapped page? */
>>  			WARN_ON_ONCE(1);
>> -- =

>> 2.28.0
>>
>>
>
> -- =

>  Kirill A. Shutemov


=E2=80=94
Best Regards,
Yan Zi

--=_MailMate_2E2DEB0F-C3D6-43CD-858A-9FB7721B04C1_=
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQJDBAEBCgAtFiEEh7yFAW3gwjwQ4C9anbJR82th+ooFAl9Y6GAPHHppeUBudmlk
aWEuY29tAAoJEJ2yUfNrYfqKYssP/2weFr5uudkF6UYqVHoN3K7Th+bem4+E6XQ0
/2bmTWtPRWbrGT3Fa/os8VayOJl62hEEeP07dpkc6oqxWDmqZMEF+g4mQWO2PcZo
IEMqW58DpMQbUiAxd7QItvilxx8iCZ8FMyPzJCJ68fwdv/CGwXkAsgwi5CE6R+kJ
G4HaGX320EXqf/L3winkzwhpeJuNy1brx9A5U/6XKarqsAUGfplLx2wuLmfUY/+Q
aaLf+yTiaT2RaAP4WJqlJfBFtAVVKQf8BycMpO705ZCPzbYlEIFSw0NMqZdyLs6n
cpy8Q3ZtJwWen6iyxd4/pvfsPtaC7EbabYE9Tft0X0Ssb6zinyNhdgqptcb4x1fM
8JmS0BmTC2OtPdAHaFr1H76tyUyQKARw+xseu4/1FPaO79yA6Uh18M9mF8vYqa7S
omEzz80eU/GbHOV7rAMPk9/6rGROmpJG+Y5r9kChyQIE6ToPAVDvYuB6O1awK3kD
7YhcXkANxuw9WARw9FcoewHOFQ1AtYiHEpJx38UpCo+Sol8KT5lIn8dZDMR00yvp
P9s85lV2hgLr3uKgSWtdZknv5YTNVLrRdY+G77iEvxelLp1NH4e5Rhio5tU2Z0ZJ
PWx7ht4M3hdHMuTqB9LxJ1He1X0Jve5w2iWILMR6jGYzWhaw8fxYBGe1/nJHXVGz
COYrfNPW
=4MSH
-----END PGP SIGNATURE-----

--=_MailMate_2E2DEB0F-C3D6-43CD-858A-9FB7721B04C1_=--
