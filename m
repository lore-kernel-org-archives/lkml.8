Return-Path: <SRS0=NZ+o=5N=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 08AFBC43331
	for <linux-kernel@archiver.kernel.org>; Sat, 28 Mar 2020 01:17:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C8CD22071B
	for <linux-kernel@archiver.kernel.org>; Sat, 28 Mar 2020 01:17:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=nvidia.com header.i=@nvidia.com header.b="V0Gg/11i"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726937AbgC1BRI (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 27 Mar 2020 21:17:08 -0400
Received: from hqnvemgate24.nvidia.com ([216.228.121.143]:13690 "EHLO
        hqnvemgate24.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726134AbgC1BRI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 27 Mar 2020 21:17:08 -0400
Received: from hqpgpgate102.nvidia.com (Not Verified[216.228.121.13]) by hqnvemgate24.nvidia.com (using TLS: TLSv1.2, DES-CBC3-SHA)
        id <B5e7ea5320000>; Fri, 27 Mar 2020 18:15:30 -0700
Received: from hqmail.nvidia.com ([172.20.161.6])
  by hqpgpgate102.nvidia.com (PGP Universal service);
  Fri, 27 Mar 2020 18:17:03 -0700
X-PGP-Universal: processed;
        by hqpgpgate102.nvidia.com on Fri, 27 Mar 2020 18:17:03 -0700
Received: from [10.2.174.211] (10.124.1.5) by HQMAIL107.nvidia.com
 (172.20.187.13) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Sat, 28 Mar
 2020 01:17:02 +0000
From:   Zi Yan <ziy@nvidia.com>
To:     "Kirill A. Shutemov" <kirill@shutemov.name>
CC:     <akpm@linux-foundation.org>,
        Andrea Arcangeli <aarcange@redhat.com>, <linux-mm@kvack.org>,
        <linux-kernel@vger.kernel.org>,
        "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>
Subject: Re: [PATCH 5/7] khugepaged: Allow to collapse PTE-mapped compound
 pages
Date:   Fri, 27 Mar 2020 21:17:00 -0400
X-Mailer: MailMate (1.13.1r5680)
Message-ID: <B8EBF52B-BC6A-4778-81AA-DDEFC9BF6157@nvidia.com>
In-Reply-To: <20200328003920.xvkt3hp65uccsq7b@box>
References: <20200327170601.18563-1-kirill.shutemov@linux.intel.com>
 <20200327170601.18563-6-kirill.shutemov@linux.intel.com>
 <D5721ED6-774B-4CD3-8533-4BF9BDB2401E@nvidia.com>
 <20200328003920.xvkt3hp65uccsq7b@box>
MIME-Version: 1.0
X-Originating-IP: [10.124.1.5]
X-ClientProxiedBy: HQMAIL105.nvidia.com (172.20.187.12) To
 HQMAIL107.nvidia.com (172.20.187.13)
Content-Type: multipart/signed;
        boundary="=_MailMate_A6A9325E-3C5C-4026-980D-7E7A96A0FC64_=";
        micalg=pgp-sha512; protocol="application/pgp-signature"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
        t=1585358130; bh=DpJltVS9A102yYWmFH08LXdtsHFLKogiW6RLJmyYK+Q=;
        h=X-PGP-Universal:From:To:CC:Subject:Date:X-Mailer:Message-ID:
         In-Reply-To:References:MIME-Version:X-Originating-IP:
         X-ClientProxiedBy:Content-Type;
        b=V0Gg/11iVd3vNckl6s0DHos/w1VpKRjVGfcnzMrcWB+a3gXz2zP3s7wQ0ezwi5VXZ
         xwi/gwz7d7QAwYeYYy1plvu1cqdQJdUIbFbt1zHCVUAG+wizOVGc3lW0cjv2C4fTEX
         8pdtsUDK4BR6GRlS+IaMuSev2x6mN260ZdT/Px8IKPUnhgItwGq+cLt1H7TDBg2DxS
         07GlLqsnEXb9jD2m5AXjx3M6SZtGkMgX4cj1YrhXnCcLXPo70bXl40/JnAnxrQk3iq
         7Fc5DWkUFRZWMG4lbyhi//WFoymz5O61DUYMGMwafZefCgO9Jq1z/536OyU011i67E
         VXp/gdXQokZQA==
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--=_MailMate_A6A9325E-3C5C-4026-980D-7E7A96A0FC64_=
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On 27 Mar 2020, at 20:39, Kirill A. Shutemov wrote:

> External email: Use caution opening links or attachments
>
>
> On Fri, Mar 27, 2020 at 02:55:06PM -0400, Zi Yan wrote:
>> On 27 Mar 2020, at 13:05, Kirill A. Shutemov wrote:
>>
>>> We can collapse PTE-mapped compound pages. We only need to avoid
>>> handling them more than once: lock/unlock page only once if it's pres=
ent
>>> in the PMD range multiple times as it handled on compound level. The
>>> same goes for LRU isolation and putpack.
>>
>> s/putpack/putback/
>>
>>>
>>> Signed-off-by: Kirill A. Shutemov <kirill.shutemov@linux.intel.com>
>>> ---
>>>  mm/khugepaged.c | 41 +++++++++++++++++++++++++++++++----------
>>>  1 file changed, 31 insertions(+), 10 deletions(-)
>>>
>>> diff --git a/mm/khugepaged.c b/mm/khugepaged.c
>>> index b47edfe57f7b..c8c2c463095c 100644
>>> --- a/mm/khugepaged.c
>>> +++ b/mm/khugepaged.c
>>> @@ -515,6 +515,17 @@ void __khugepaged_exit(struct mm_struct *mm)
>>>
>>>  static void release_pte_page(struct page *page)
>>>  {
>>> +   /*
>>> +    * We need to unlock and put compound page on LRU only once.
>>> +    * The rest of the pages have to be locked and not on LRU here.
>>> +    */
>>> +   VM_BUG_ON_PAGE(!PageCompound(page) &&
>>> +                   (!PageLocked(page) && PageLRU(page)), page);
>> It only checks base pages.
>
> That's the point.
>
>> Add
>>
>> VM_BUG_ON_PAGE(PageCompound(page) && PageLocked(page) && PageLRU(page)=
, page);
>>
>> to check for compound pages.
>
> The compound page may be locked here if the function called for the fir=
st
> time for the page and not locked after that (becouse we've unlocked it =
we
> saw it the first time). The same with LRU.
>

For the first time, the compound page is locked and not on LRU, so this V=
M_BUG_ON passes.
For the second time and so on, the compound page is unlocked and on the L=
RU,
so this VM_BUG_ON still passes.

For base page, VM_BUG_ON passes.

Other unexpected situation (a compound page is locked and on LRU) trigger=
s the VM_BU_ON,
but your VM_BUG_ON will not detect this situation, right?



>>> +
>>> +   if (!PageLocked(page))
>>> +           return;
>>> +
>>> +   page =3D compound_head(page);
>>>     dec_node_page_state(page, NR_ISOLATED_ANON + page_is_file_cache(p=
age));
>>>     unlock_page(page);
>>>     putback_lru_page(page);
>>> @@ -537,6 +548,7 @@ static int __collapse_huge_page_isolate(struct vm=
_area_struct *vma,
>>>     pte_t *_pte;
>>>     int none_or_zero =3D 0, result =3D 0, referenced =3D 0;
>>>     bool writable =3D false;
>>> +   LIST_HEAD(compound_pagelist);
>>>
>>>     for (_pte =3D pte; _pte < pte+HPAGE_PMD_NR;
>>>          _pte++, address +=3D PAGE_SIZE) {
>>> @@ -561,13 +573,23 @@ static int __collapse_huge_page_isolate(struct =
vm_area_struct *vma,
>>>                     goto out;
>>>             }
>>>
>>> -           /* TODO: teach khugepaged to collapse THP mapped with pte=
 */
>>> +           VM_BUG_ON_PAGE(!PageAnon(page), page);
>>> +
>>>             if (PageCompound(page)) {
>>> -                   result =3D SCAN_PAGE_COMPOUND;
>>> -                   goto out;
>>> -           }
>>> +                   struct page *p;
>>> +                   page =3D compound_head(page);
>>>
>>> -           VM_BUG_ON_PAGE(!PageAnon(page), page);
>>> +                   /*
>>> +                    * Check if we have dealt with the compount page
>>
>> s/compount/compound/
>>
>
> Thanks.
>
>>> +                    * already
>>> +                    */
>>> +                   list_for_each_entry(p, &compound_pagelist, lru) {=

>>> +                           if (page =3D=3D  p)
>>> +                                   break;
>>> +                   }
>>> +                   if (page =3D=3D  p)
>>> +                           continue;
>>> +           }
>>>
>>>             /*
>>>              * We can do it before isolate_lru_page because the
>>> @@ -640,6 +662,9 @@ static int __collapse_huge_page_isolate(struct vm=
_area_struct *vma,
>>>                 page_is_young(page) || PageReferenced(page) ||
>>>                 mmu_notifier_test_young(vma->vm_mm, address))
>>>                     referenced++;
>>> +
>>> +           if (PageCompound(page))
>>> +                   list_add_tail(&page->lru, &compound_pagelist);
>>>     }
>>>     if (likely(writable)) {
>>>             if (likely(referenced)) {
>>
>> Do we need a list here? There should be at most one compound page we w=
ill see here, right?
>
> Um? It's outside the pte loop. We get here once per PMD range.
>
> 'page' argument to trace_mm_collapse_huge_page_isolate() is misleading:=

> it's just the last page handled in the loop.
>

Throughout the pte loop, we should only see at most one compound page, ri=
ght?

If that is the case, we do not need a list to store that single compound =
page
but can use a struct page pointer that is initialized to NULL and later a=
ssigned
to the discovered compound page, right? I am not saying I want to change =
the code
in this way, but just try to make sure I understand the code correctly.

Thanks.

=E2=80=94
Best Regards,
Yan Zi

--=_MailMate_A6A9325E-3C5C-4026-980D-7E7A96A0FC64_=
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQJDBAEBCgAtFiEEh7yFAW3gwjwQ4C9anbJR82th+ooFAl5+pYwPHHppeUBudmlk
aWEuY29tAAoJEJ2yUfNrYfqKziwQAKFf+CJzn4/OjwNPchOSsJjpsdYlq6hW3eiY
qL//jBwcWi4lhojGdLF7AEdHJYihDJ/TlTpKYJg+65vpykalvu+3L5XxKUHSumDo
Y5exKdY6YCpUEGPzYaLMbjSUwid9QithlEOQVlL7j3fOjg8J8/x5iXISZZyaszVV
oovogmFIhmwQDmM+DuC51MMG6nm+D/N+qSVKDwtjMQiUeepbO/hAW9G48FXJqfU+
cN7xc1nJyc9omqlAAK60G+PE607FsbWGk0S0tmeLGlrzuxqjEJcy08Zq0addE/26
v6JSa2/EYDX3kGlBG+M8PkgOM/rcZp2KJ1oXQvwee734g2muiZN16nedDOyS7Ejk
ZiwN75RB3nGCCV35rISttvdooUaNfPYKGhR5rdPPL2nqRg5/DbZGlY8svk0ANPdV
YtwEDdQ69nnhlxCPbJ0uAb9PnD3iJ9g/ByDDIfMj4kiRRur6mJbXQLw32v/ciilT
jAlZe++yhnHwdIgUiDJNyLsTBSjLX+R1Rf0GUIRbUv7BtrTnps4pwYZYaKrLh7GD
21gSxAcIJC6ezyw8mxdUaLLCU8eWEkoJRB1E+hfEQThwMQ4ndHMJNa+PZ57EsDrV
8qg2K4spAuIMIpiSvC26n4KxsQMiYf2dDTc6vj7l5jux1xxE+J/b3TwGdActIDjB
jtDkqVQg
=1RJq
-----END PGP SIGNATURE-----

--=_MailMate_A6A9325E-3C5C-4026-980D-7E7A96A0FC64_=--
