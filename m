Return-Path: <SRS0=sqB7=5R=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 51921C43331
	for <linux-kernel@archiver.kernel.org>; Wed,  1 Apr 2020 02:42:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 15D5E206CC
	for <linux-kernel@archiver.kernel.org>; Wed,  1 Apr 2020 02:42:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=nvidia.com header.i=@nvidia.com header.b="J3ymFXnq"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731641AbgDACmL (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 31 Mar 2020 22:42:11 -0400
Received: from hqnvemgate25.nvidia.com ([216.228.121.64]:11300 "EHLO
        hqnvemgate25.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731556AbgDACmL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 31 Mar 2020 22:42:11 -0400
Received: from hqpgpgate102.nvidia.com (Not Verified[216.228.121.13]) by hqnvemgate25.nvidia.com (using TLS: TLSv1.2, DES-CBC3-SHA)
        id <B5e83ff500000>; Tue, 31 Mar 2020 19:41:20 -0700
Received: from hqmail.nvidia.com ([172.20.161.6])
  by hqpgpgate102.nvidia.com (PGP Universal service);
  Tue, 31 Mar 2020 19:42:09 -0700
X-PGP-Universal: processed;
        by hqpgpgate102.nvidia.com on Tue, 31 Mar 2020 19:42:09 -0700
Received: from [10.2.164.158] (10.124.1.5) by HQMAIL107.nvidia.com
 (172.20.187.13) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Wed, 1 Apr
 2020 02:42:08 +0000
From:   Zi Yan <ziy@nvidia.com>
To:     "Huang, Ying" <ying.huang@intel.com>
CC:     Andrew Morton <akpm@linux-foundation.org>, <linux-mm@kvack.org>,
        <linux-kernel@vger.kernel.org>,
        Andrea Arcangeli <aarcange@redhat.com>,
        "Kirill A . Shutemov" <kirill.shutemov@linux.intel.com>,
        Vlastimil Babka <vbabka@suse.cz>,
        Alexey Dobriyan <adobriyan@gmail.com>,
        Michal Hocko <mhocko@suse.com>,
        Konstantin Khlebnikov <khlebnikov@yandex-team.ru>,
        =?utf-8?b?SsOpcsO0bWU=?= Glisse <jglisse@redhat.com>,
        Yang Shi <yang.shi@linux.alibaba.com>
Subject: Re: [PATCH] /proc/PID/smaps: Add PMD migration entry parsing
Date:   Tue, 31 Mar 2020 22:42:06 -0400
X-Mailer: MailMate (1.13.1r5680)
Message-ID: <C497B0EF-1B3A-4E4E-8888-D74B2CEFE2B3@nvidia.com>
In-Reply-To: <87r1x8hrie.fsf@yhuang-dev.intel.com>
References: <20200331085604.1260162-1-ying.huang@intel.com>
 <965DC015-7D6F-430D-8FB7-A24A814C13BE@nvidia.com>
 <87r1x8hrie.fsf@yhuang-dev.intel.com>
MIME-Version: 1.0
X-Originating-IP: [10.124.1.5]
X-ClientProxiedBy: HQMAIL105.nvidia.com (172.20.187.12) To
 HQMAIL107.nvidia.com (172.20.187.13)
Content-Type: multipart/signed;
        boundary="=_MailMate_609F54C7-92F5-4CF3-8A63-C8BFD6C7063D_=";
        micalg=pgp-sha512; protocol="application/pgp-signature"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
        t=1585708880; bh=Ybh/8CsSStUTOkVu6y5G+HTsQh9b1jV2tVTjSGq68JQ=;
        h=X-PGP-Universal:From:To:CC:Subject:Date:X-Mailer:Message-ID:
         In-Reply-To:References:MIME-Version:X-Originating-IP:
         X-ClientProxiedBy:Content-Type;
        b=J3ymFXnq7Nv2WD72/c52xyS6SILb69MveHQV3nNG0i/5gIYVMryYjTfeYaKQVq09J
         c8ROXUKEZngwoVMriJaAeMQOSNa5lGZi7tkOsA+2rhXl436hgOIOjMIU9SWal7iW6p
         Egfh6nbBWHbOnRrjV/W1XE0gyFPNJR+1BVAsfgofIQJjMv8/ZuQuAahxP6SsTxGbdd
         kK808JMTDQMJ922xK89DIripWBkOBvMEG488xmI9uSrafWw3O2vDhekTxjciKeK/B3
         CZJ7ufGoCkCy8B4Tyk/aCCyqzMX9lgMxXZMA7wJ/OmLhVxg0bchUTXYhplwvHqLyj/
         Arl6YiMI9QaTA==
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--=_MailMate_609F54C7-92F5-4CF3-8A63-C8BFD6C7063D_=
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On 31 Mar 2020, at 22:24, Huang, Ying wrote:

> External email: Use caution opening links or attachments
>
>
> Zi Yan <ziy@nvidia.com> writes:
>
>> On 31 Mar 2020, at 4:56, Huang, Ying wrote:
>>>
>>> From: Huang Ying <ying.huang@intel.com>
>>>
>>> Now, when read /proc/PID/smaps, the PMD migration entry in page table=
 is simply
>>> ignored.  To improve the accuracy of /proc/PID/smaps, its parsing and=
 processing
>>> is added.
>>>
>>> Signed-off-by: "Huang, Ying" <ying.huang@intel.com>
>>> Cc: Andrea Arcangeli <aarcange@redhat.com>
>>> Cc: Kirill A. Shutemov <kirill.shutemov@linux.intel.com>
>>> Cc: Zi Yan <ziy@nvidia.com>
>>> Cc: Vlastimil Babka <vbabka@suse.cz>
>>> Cc: Alexey Dobriyan <adobriyan@gmail.com>
>>> Cc: Michal Hocko <mhocko@suse.com>
>>> Cc: Konstantin Khlebnikov <khlebnikov@yandex-team.ru>
>>> Cc: "J=C3=A9r=C3=B4me Glisse" <jglisse@redhat.com>
>>> Cc: Yang Shi <yang.shi@linux.alibaba.com>
>>> ---
>>>  fs/proc/task_mmu.c | 16 ++++++++++++----
>>>  1 file changed, 12 insertions(+), 4 deletions(-)
>>>
>>> diff --git a/fs/proc/task_mmu.c b/fs/proc/task_mmu.c
>>> index 8d382d4ec067..b5b3aef8cb3b 100644
>>> --- a/fs/proc/task_mmu.c
>>> +++ b/fs/proc/task_mmu.c
>>> @@ -548,8 +548,17 @@ static void smaps_pmd_entry(pmd_t *pmd, unsigned=
 long addr,
>>>         bool locked =3D !!(vma->vm_flags & VM_LOCKED);
>>>         struct page *page;
>>
>> Like Konstantin pointed out in another email, you could initialize pag=
e to NULL here.
>> Plus you do not need the =E2=80=9Celse-return=E2=80=9D below, if you d=
o that.
>
> Yes.  That looks better.  Will change this in the next version.

Thanks.

>
>>>
>>> -       /* FOLL_DUMP will return -EFAULT on huge zero page */
>>> -       page =3D follow_trans_huge_pmd(vma, addr, pmd, FOLL_DUMP);
>>> +       if (pmd_present(*pmd)) {
>>> +               /* FOLL_DUMP will return -EFAULT on huge zero page */=

>>> +               page =3D follow_trans_huge_pmd(vma, addr, pmd, FOLL_D=
UMP);
>>> +       } else if (unlikely(is_swap_pmd(*pmd))) {
>>
>> Should be:
>>           } else if (unlikely(thp_migration_support() && is_swap_pmd(*=
pmd))) {
>>
>> Otherwise, when THP migration is disabled and the PMD is under splitti=
ng, VM_BUG_ON
>> will be triggered.
>
> We hold the PMD page table lock when call smaps_pmd_entry().  How does
> PMD splitting trigger VM_BUG_ON()?

Oh, I missed that. Your original code is right. Thank you for the explana=
tion.



=E2=80=94
Best Regards,
Yan Zi

--=_MailMate_609F54C7-92F5-4CF3-8A63-C8BFD6C7063D_=
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQJDBAEBCgAtFiEEh7yFAW3gwjwQ4C9anbJR82th+ooFAl6D/34PHHppeUBudmlk
aWEuY29tAAoJEJ2yUfNrYfqK/KwP/iLHzfdvfE/GJ21pw75g6t6p67Q3yu/VDstT
OkF4yH4mTvszCwuV7kDxxt6DaV6sobagDNZJCIpoW4WJR+NPxNHP1t3cZ/9/WCzy
D0yetPM3XRp9ejahnVGZQuvT1uUMOO6neL6bndwjctPNBAJk3yxACoP+I36wBVPo
aPhVQO85xEjDtjAbm2r9Ad/wHhe071wamVwRJC552fQoMbga2lb+jhZFLptU0Yls
ZyEuq/KTZ0ZLkAZc8zUbaoDbQif04cJQE2W4ars0bQj7c1X6iUdxCuKfplQ9i/xz
wyss+lye31p8CXiAXnSxzrwlkD6Z5Ynokhp+V25i+oBpxJdUiiAG0IVd13mWky7D
lDQAwvyRK3bgNs0vVdOevs5ZljuBh0QH1cxmmN2Bw8YRxlnYYypUS0VRV7ZdLuwM
ERwVx7/JKL536oIHxq1IOUo03rLX5Wr3Ccnd9kD4GL8PZ5nif4Rcgs899OWw4/R0
C4fRbn/Zp7HHbG+SyqjMTe8pQYVK8mrL7CzSc8QPwJuRhfA1MTDlKKhPzoJ+uyTz
uPIl8dB1JC/FZ27TCWnhaF+6ezhV6MgZIXjevaUPcu8ZrFZSJeuY9JgPYM59NBQe
nVXn1e4v8YU5knJmJMMfSZbyAWWJTcQQ29+NabdTOqcfkfz5UlZEmOkMA/ODSsg/
HfYeAeik
=Hzpe
-----END PGP SIGNATURE-----

--=_MailMate_609F54C7-92F5-4CF3-8A63-C8BFD6C7063D_=--
