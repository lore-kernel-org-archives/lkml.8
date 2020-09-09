Return-Path: <SRS0=iZCi=CS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D465BC43461
	for <linux-kernel@archiver.kernel.org>; Wed,  9 Sep 2020 16:07:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7C1DE20768
	for <linux-kernel@archiver.kernel.org>; Wed,  9 Sep 2020 16:07:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=nvidia.com header.i=@nvidia.com header.b="XwW8NRZF"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730570AbgIIQHl (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 9 Sep 2020 12:07:41 -0400
Received: from hqnvemgate25.nvidia.com ([216.228.121.64]:11390 "EHLO
        hqnvemgate25.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730261AbgIIQFV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Sep 2020 12:05:21 -0400
Received: from hqpgpgate101.nvidia.com (Not Verified[216.228.121.13]) by hqnvemgate25.nvidia.com (using TLS: TLSv1.2, DES-CBC3-SHA)
        id <B5f58e3420001>; Wed, 09 Sep 2020 07:14:26 -0700
Received: from hqmail.nvidia.com ([172.20.161.6])
  by hqpgpgate101.nvidia.com (PGP Universal service);
  Wed, 09 Sep 2020 07:15:10 -0700
X-PGP-Universal: processed;
        by hqpgpgate101.nvidia.com on Wed, 09 Sep 2020 07:15:10 -0700
Received: from [10.2.173.224] (10.124.1.5) by HQMAIL107.nvidia.com
 (172.20.187.13) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Wed, 9 Sep
 2020 14:15:07 +0000
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
Subject: Re: [RFC PATCH 01/16] mm: add pagechain container for storing
 multiple pages.
Date:   Wed, 9 Sep 2020 10:15:05 -0400
X-Mailer: MailMate (1.13.1r5705)
Message-ID: <1970690D-DA0B-4C46-BE0C-66F33D881653@nvidia.com>
In-Reply-To: <20200909134622.xkuzx5nf4xq2vudh@box>
References: <20200902180628.4052244-1-zi.yan@sent.com>
 <20200902180628.4052244-2-zi.yan@sent.com>
 <20200907122228.4zlyfysdul3s62me@box>
 <50FA95D1-9222-48C0-9223-C1267E8C7A4A@nvidia.com>
 <20200909134622.xkuzx5nf4xq2vudh@box>
MIME-Version: 1.0
X-Originating-IP: [10.124.1.5]
X-ClientProxiedBy: HQMAIL111.nvidia.com (172.20.187.18) To
 HQMAIL107.nvidia.com (172.20.187.13)
Content-Type: multipart/signed;
        boundary="=_MailMate_D0E4833B-CB0F-4F80-8EC1-E6EF8EC8C2B3_=";
        micalg=pgp-sha512; protocol="application/pgp-signature"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
        t=1599660866; bh=GOFHZK2XhOsa4oTcM5/sgtSmF1DP7Z0sECRgUhmrQ1E=;
        h=X-PGP-Universal:From:To:CC:Subject:Date:X-Mailer:Message-ID:
         In-Reply-To:References:MIME-Version:X-Originating-IP:
         X-ClientProxiedBy:Content-Type;
        b=XwW8NRZF70tCHfYaM4JRWXa89N4P400FcNkY5mm/pAF945976KQ0xMSAZE88jAPwB
         2JgeqJLArFv2Vv9lqxAOQIwGrp1pu4q6p2USrCQAJGbz65Zs+CvzDt+/li91LRK0Pv
         yui0706T2RZGj86cVWTCuhLDKHCjFI78xNG47AX8ELXYrTzI/HEhjgfy4N8ZpK3gQ4
         odTGXbwZuGi4HcBkH/Vyqcqrk2vm59gesd0/8atDspD4nOELWXf30hB8F32lhFv/YF
         D2s2yG7AN6DK5sDrtOo+syRmpxIwcmIu2golb+PJhyGFQBZs/trHQs8KjAEBT4uCvD
         dUGenyBovp0nw==
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--=_MailMate_D0E4833B-CB0F-4F80-8EC1-E6EF8EC8C2B3_=
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On 9 Sep 2020, at 9:46, Kirill A. Shutemov wrote:

> On Mon, Sep 07, 2020 at 11:11:05AM -0400, Zi Yan wrote:
>> On 7 Sep 2020, at 8:22, Kirill A. Shutemov wrote:
>>
>>> On Wed, Sep 02, 2020 at 02:06:13PM -0400, Zi Yan wrote:
>>>> From: Zi Yan <ziy@nvidia.com>
>>>>
>>>> When depositing page table pages for 1GB THPs, we need 512 PTE pages=
 +
>>>> 1 PMD page. Instead of counting and depositing 513 pages, we can use=
 the
>>>> PMD page as a leader page and chain the rest 512 PTE pages with ->lr=
u.
>>>> This, however, prevents us depositing PMD pages with ->lru, which is=

>>>> currently used by depositing PTE pages for 2MB THPs. So add a new
>>>> pagechain container for PMD pages.
>>>>
>>>> Signed-off-by: Zi Yan <ziy@nvidia.com>
>>>
>>> Just deposit it to a linked list in the mm_struct as we do for PMD if=

>>> split ptl disabled.
>>>
>>
>> Thank you for checking the patches. Since we don=E2=80=99t have PUD sp=
lit lock
>> yet, I store the PMD page table pages in a newly added linked list hea=
d
>> in mm_struct like you suggested above.
>>
>> I was too vague about my pagechain design for depositing page table pa=
ges
>> for PUD THPs. Sorry about the confusion. Let me clarify why
>> I am doing this pagechain here too. I am sure there would be
>> some other designs and I am happy to change my code.
>>
>> In my design, I did not store all page table pages in a single list.
>> I first deposit 512 PTE pages in one PMD page table page=E2=80=99s pmd=
_huge_pte
>> using pgtable_trans_huge_depsit(), then deposit the PMD page to
>> a newly added linked list in mm_struct. Since pmd_huge_pte shares spac=
e
>> with half of lru in struct page, we cannot use lru to link all PMD
>> pages together. As a result, I added pagechain. Also in this way,
>> we can avoid these things:
>>
>> 1. when we withdraw the PMD page during PUD THP split, we don=E2=80=99=
t need
>> to withdraw 513 page, set up one PMD page, then, deposit 512 PTE pages=

>> in that PMD page.
>>
>> 2. we don=E2=80=99t mix PMD page table pages and PTE page table pages =
in a single
>> list, since they are initialized in different ways. Otherwise, we need=

>> to maintain a subtle rule in the single page table page list that in e=
very
>> 513 pages, first one is PMD page table page and the rest are PTE page
>> table pages.
>>
>> As I am typing, I also realize that my current design does not work
>> when PMD split lock is disabled, so I will fix it. I would store PMD p=
ages
>> and PTE pages in two separate lists in mm_struct.
>>
>>
>> Any comments?
>
> Okay, fair enough.
>
> Although, I think you can get away without a new data structure. We don=
't
> need double-linked list to deposit page tables. You can rework PTE tabl=
es
> deposit code to have single-linked list and use one pointer of ->lru (w=
ith
> proper name) and make PMD tables deposit to use the other one. This way=

> you can avoid conflict for ->lru.
>
> Does it make sense?

Yes. Thanks. Will do this in the next version. I think the single linked =
list
from llist.h can be used.

=E2=80=94
Best Regards,
Yan Zi

--=_MailMate_D0E4833B-CB0F-4F80-8EC1-E6EF8EC8C2B3_=
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQJCBAEBCgAtFiEEh7yFAW3gwjwQ4C9anbJR82th+ooFAl9Y42kPHHppeUBudmlk
aWEuY29tAAoJEJ2yUfNrYfqK2g8P9RpqkmfY2NIK9W9h7ldxxXgvwvVbCq2xVMI9
Xj+clVhDb7PbGdN7RP7sgtkNy9woJWAKcAWo+wzILT7KmfN0oFj0ZNTgnyil/MH4
wmKRrFY6bY911Kwjx62Z+xY2E0rXg0MX1Ang7ols8X2uhO1qA2TRwgjw3fwyEzyK
237whK8BW40W0nDUi6NPyqhWRZtvEygrEXqiNV7FxZsKqB0F14HAfHGzzSu2B8pB
E6z0d9X2G6OSn+/Y5UgHmUiXDTuGviTCKPOi4LaA1IYQBSUiUBo8SoxBEjMUdGEC
KKtUmo32tWbi+WFMoG+3u/eO32k6cyYrmpnEu+Bv9dHaqZL1IHlqQsimbV/ik1Td
gQKoNhp3UtGwo1i5BW3MvnF1HMxUlgWQAHLcwl/9DzbKMHCfA67SHxVfI9fsa45b
uxSqfB525/bwT8VePK4qbBjgfkIMeAbt1wrklr3uSPrAlY1AqhbStpzthb2oWaGI
lLzdXGlbKWJHZVrq11mIu5BIc2a3s3YRB8/Rz6s/gJF6OXbidCuTZop9iuIG8ZGS
Qo19XYCIY1wg4NtL6ZRGPQnPIYoOu32A4XUCg90TmqYb2kGqhG+YNAHMJvr87zDG
Dw4e1KeGOK3+05GMnGb5jn5MM9pJuw/8htWmaUwL4GaiPUxDEs+wZ95plYa1PIk+
m8GltQI=
=jndG
-----END PGP SIGNATURE-----

--=_MailMate_D0E4833B-CB0F-4F80-8EC1-E6EF8EC8C2B3_=--
