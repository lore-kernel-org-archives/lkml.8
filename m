Return-Path: <SRS0=VV4q=52=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 44238C2BB86
	for <linux-kernel@archiver.kernel.org>; Fri, 10 Apr 2020 15:03:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1633E20A8B
	for <linux-kernel@archiver.kernel.org>; Fri, 10 Apr 2020 15:03:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=nvidia.com header.i=@nvidia.com header.b="Q2Y6PoDD"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726679AbgDJPDP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 10 Apr 2020 11:03:15 -0400
Received: from hqnvemgate26.nvidia.com ([216.228.121.65]:1862 "EHLO
        hqnvemgate26.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726049AbgDJPDO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Apr 2020 11:03:14 -0400
Received: from hqpgpgate101.nvidia.com (Not Verified[216.228.121.13]) by hqnvemgate26.nvidia.com (using TLS: TLSv1.2, DES-CBC3-SHA)
        id <B5e908aa40000>; Fri, 10 Apr 2020 08:03:00 -0700
Received: from hqmail.nvidia.com ([172.20.161.6])
  by hqpgpgate101.nvidia.com (PGP Universal service);
  Fri, 10 Apr 2020 08:03:13 -0700
X-PGP-Universal: processed;
        by hqpgpgate101.nvidia.com on Fri, 10 Apr 2020 08:03:13 -0700
Received: from DRHQMAIL107.nvidia.com (10.27.9.16) by HQMAIL101.nvidia.com
 (172.20.187.10) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Fri, 10 Apr
 2020 15:03:13 +0000
Received: from [10.2.174.146] (10.124.1.5) by DRHQMAIL107.nvidia.com
 (10.27.9.16) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Fri, 10 Apr
 2020 15:03:11 +0000
From:   Zi Yan <ziy@nvidia.com>
To:     "Kirill A. Shutemov" <kirill@shutemov.name>
CC:     <akpm@linux-foundation.org>,
        Andrea Arcangeli <aarcange@redhat.com>,
        "Yang Shi" <yang.shi@linux.alibaba.com>, <linux-mm@kvack.org>,
        <linux-kernel@vger.kernel.org>,
        "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>
Subject: Re: [PATCHv2 1/8] khugepaged: Add self test
Date:   Fri, 10 Apr 2020 11:03:09 -0400
X-Mailer: MailMate (1.13.1r5680)
Message-ID: <511724CE-3FF3-4535-BDB1-D4B9ACE9F3DA@nvidia.com>
In-Reply-To: <20200410145804.fczyvec4pngpep6t@box>
References: <20200403112928.19742-1-kirill.shutemov@linux.intel.com>
 <20200403112928.19742-2-kirill.shutemov@linux.intel.com>
 <D55D6A3A-47A1-41F5-B939-36EEA740CF72@nvidia.com>
 <20200410114739.b2ndracbyhsdmanv@box>
 <DF6A7119-D6D6-4679-A4B6-9A7570984D97@nvidia.com>
 <20200410145804.fczyvec4pngpep6t@box>
MIME-Version: 1.0
X-Originating-IP: [10.124.1.5]
X-ClientProxiedBy: HQMAIL101.nvidia.com (172.20.187.10) To
 DRHQMAIL107.nvidia.com (10.27.9.16)
Content-Type: multipart/signed;
        boundary="=_MailMate_F5C90A71-D4C8-4685-BD1F-D7672BFC44C2_=";
        micalg=pgp-sha512; protocol="application/pgp-signature"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
        t=1586530980; bh=t7Roxh2dq5kHW/gcPZo2nKgAR8NeX0t1Xl/1SxTSRnY=;
        h=X-PGP-Universal:From:To:CC:Subject:Date:X-Mailer:Message-ID:
         In-Reply-To:References:MIME-Version:X-Originating-IP:
         X-ClientProxiedBy:Content-Type;
        b=Q2Y6PoDD/Xck4L6x6EN4ohXjDTKTNoxJGUA0bFh/oZpKDJNOA4Q4rpjS32ygsmJxs
         GjYUtcXrg6HOkNTYl2sTcLgQtAaIQVObKy4DARbg88rar8ZxXPGrBQ4J86BRno6JOA
         BLbJqeg11v2zT8lbpFwYW7Ru9oZpe4XodL8Ju2T2zyHEP4lJ2XQytbQa9Wv3RvO8V7
         ybCYBS9OPUMtC6wH6bCVk40wp7a6d8NSgeoBMkv49n4+lSePyM/sqi9jTQjKKKzC9r
         q0+A6y4FOa2mSsnAt48aox6MmX9jnEmrJtNQeWPJRCXXcGFueQ45ocnKnqTgEtriqG
         l+kKOFeBio5+Q==
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--=_MailMate_F5C90A71-D4C8-4685-BD1F-D7672BFC44C2_=
Content-Type: text/plain; charset="UTF-8"; markup=markdown
Content-Transfer-Encoding: quoted-printable

On 10 Apr 2020, at 10:58, Kirill A. Shutemov wrote:

> External email: Use caution opening links or attachments
>
>
> On Fri, Apr 10, 2020 at 10:36:58AM -0400, Zi Yan wrote:
>> On 10 Apr 2020, at 7:47, Kirill A. Shutemov wrote:
>>
>>> External email: Use caution opening links or attachments
>>>
>>>
>>> On Mon, Apr 06, 2020 at 10:59:52AM -0400, Zi Yan wrote:
>>>> I ran this test with all patches from this series applied to Linus=E2=
=80=99s tree, but still see several failures. Is it expected?
>>>> The config file is attached. Let me know if I miss anything. BTW, I =
am running in a VM.
>>>>
>>>> Thanks.
>>>>
>>>> The output:
>>>>
>>>> =E2=9E=9C  ~ sudo ./khugepaged
>>>> Save THP and khugepaged settings... OK
>>>> Adjust settings... OK
>>>> Allocate huge page on fault... OK
>>>> Split huge PMD on MADV_DONTNEED... OK
>>>> Collapse fully populated PTE table.... Fail
>>>
>>> I was able to reproduce the issue. And it's fun failure mode.
>>>
>>> How did you get the test case inside the VM? Copy-paste source using =
'cat'
>>> or something similar inside the VM?
>>
>> First of all, the failure above was from a bare metal and was the only=

>> failure I saw, whereas I saw more failures in my VM. The test program
>> was not messed up in either environment.
>
> Hm. In the quote you are saying "BTW, I am running in a VM".

Sorry, misread the email thread. I was referring to another my email on r=
unning
tests on a bare metal, where only =E2=80=9CCollapse with max_ptes_swap pa=
ges swapped out=E2=80=9D
failed.

Here is the link to the email:
https://lore.kernel.org/linux-mm/C66E1309-2069-495B-BACD-7F3282C6EC7D@nvi=
dia.com/

>
>>
>> For VM failures I mentioned before, I used scp to copy the source code=

>> into the VM. My VM has its port 22 forwarded to host=E2=80=99s port 11=
022. =E2=80=9C-net
>> user,hostfwd=3Dtcp::11022-:22=E2=80=9D. I also copied a binary into my=
 VM and saw
>> the same failures.
>>
>> I kinda think the failures are not related to your patches but somethi=
ng else.
>>
>>>
>>> It screwed up CHECK_HUGE_FMT and CHECK_SWAP_FMT for me. Double back s=
lash
>>> was converted to single. As result check_huge() and check_swap() gave=
 the
>>> false-negative result all the time.
>>
>> It was not my case, since CHECK_HUGE_FMT and CHECK_SWAP_FMT from my
>> khugepaged.c match your patch code.
>>
>>>
>>> Could you check that the source of the test-case is not mangled and
>>> re-test if it is.
>>
>> I can confirm that the test-case is not mangled. I think it must be my=

>> VM setup or kernel configuration.
>>
>> Do you mind sharing your .config file with me and which kernel commit
>> you apply the patches on top of in your setup? I can look into it and
>> check what the problem is.
>
> My config is attached.

Thanks.

=E2=80=94
Best Regards,
Yan Zi

--=_MailMate_F5C90A71-D4C8-4685-BD1F-D7672BFC44C2_=
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQJDBAEBCgAtFiEEh7yFAW3gwjwQ4C9anbJR82th+ooFAl6Qiq0PHHppeUBudmlk
aWEuY29tAAoJEJ2yUfNrYfqKYxMQAK7hFwrejSYKpOivQJfnpv1snqqWVAdbAWDy
cnBOv+l2qhuaiBfO45u8UlIsOGBFG7VFvmlrPI/l0ti3wJZj+E8jV4PJgrDCzuWc
I10V4p7VC3Z/MLkPl2F4f4yi8s0rXQiDatpBIawN0L2+QjIDtv5wSj5Rte3QkTLs
dwZtKMASSgpI8PORBbl3tiuihrq+Z2ISlshUfqVjlC4SmTixZx5aQrs0QAKJbNkN
oSuM6QKzwlxdoCnhMfm+jO0uOC7Aj3LNSrTGfVBk3UgEKvSOEur40VPnhKhS/0F2
Jzl2B+Hd2svSO0Z5QY595pwhiOobVm6POSOUmJg5Vx1UQLAlCyeInYNWDye4y8oh
zPcJcxYYmgjxbX8f15JZP7IEXYdLrhmeuMrr3ErbU3r2f89agBLsXsiEzLv2CAde
Bg2Z533gRHVFf3+jqeVkolh+L4GQBFvsfTjl3u/irpahAvwTwhCUCWONbqj0S7hu
hzekJJwpxHaqWA+nk3vOXM9RJ6Zoof9zt9mwO4caD/I+UCGovdkgy7p46lQiZAAM
F+7oxuetbRjLO6Kq2Hbxxph2J2dR5P0lLQHZ2MXpBLqF91l7nBnKKQwVUXa9ccmT
bnEOZitGEN7HEqdePReo7oQMXPLT9rzwFgMIPSDJjpfB1do7nWhbyfGujnes5jrl
BySuU9pe
=ix0J
-----END PGP SIGNATURE-----

--=_MailMate_F5C90A71-D4C8-4685-BD1F-D7672BFC44C2_=--
