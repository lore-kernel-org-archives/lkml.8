Return-Path: <SRS0=728o=CL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 95A72C433E7
	for <linux-kernel@archiver.kernel.org>; Wed,  2 Sep 2020 20:29:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 71FB8207EA
	for <linux-kernel@archiver.kernel.org>; Wed,  2 Sep 2020 20:29:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=nvidia.com header.i=@nvidia.com header.b="UlBR3FG5"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726771AbgIBU3w (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 2 Sep 2020 16:29:52 -0400
Received: from hqnvemgate26.nvidia.com ([216.228.121.65]:2822 "EHLO
        hqnvemgate26.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726226AbgIBU3v (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Sep 2020 16:29:51 -0400
Received: from hqpgpgate101.nvidia.com (Not Verified[216.228.121.13]) by hqnvemgate26.nvidia.com (using TLS: TLSv1.2, DES-CBC3-SHA)
        id <B5f5000b00000>; Wed, 02 Sep 2020 13:29:36 -0700
Received: from hqmail.nvidia.com ([172.20.161.6])
  by hqpgpgate101.nvidia.com (PGP Universal service);
  Wed, 02 Sep 2020 13:29:50 -0700
X-PGP-Universal: processed;
        by hqpgpgate101.nvidia.com on Wed, 02 Sep 2020 13:29:50 -0700
Received: from [10.2.161.253] (172.20.13.39) by HQMAIL107.nvidia.com
 (172.20.187.13) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Wed, 2 Sep
 2020 20:29:47 +0000
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
Date:   Wed, 2 Sep 2020 16:29:46 -0400
X-Mailer: MailMate (1.13.1r5705)
Message-ID: <C12C60A2-43EA-4AD3-9077-FFB61CCC964C@nvidia.com>
In-Reply-To: <20200902195739.GI24045@ziepe.ca>
References: <20200902180628.4052244-1-zi.yan@sent.com>
 <20200902184053.GF24045@ziepe.ca>
 <E78A0F18-223C-44A8-BCBA-73CF7AF6F8A5@nvidia.com>
 <20200902184852.GH24045@ziepe.ca>
 <C5EFA1CC-311C-47D5-9506-D087D9AE58D1@nvidia.com>
 <20200902195739.GI24045@ziepe.ca>
MIME-Version: 1.0
X-Originating-IP: [172.20.13.39]
X-ClientProxiedBy: HQMAIL107.nvidia.com (172.20.187.13) To
 HQMAIL107.nvidia.com (172.20.187.13)
Content-Type: multipart/signed;
        boundary="=_MailMate_0F9721AF-59A2-4F1F-84D6-26E9CBFFF0C7_=";
        micalg=pgp-sha512; protocol="application/pgp-signature"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
        t=1599078576; bh=GpHPYB1gS6qMjgfjjB2zkmvO3GismXrLdGUFN1+sYQ4=;
        h=X-PGP-Universal:From:To:CC:Subject:Date:X-Mailer:Message-ID:
         In-Reply-To:References:MIME-Version:X-Originating-IP:
         X-ClientProxiedBy:Content-Type;
        b=UlBR3FG5VVB+m7Kh0n22MMWoBCvylenwxI8qKQy4FZjdzSPPpj6tpT5wB5oOE60SH
         JWD27ogvztYveglSv8ssSUUHgBdNR6hWUtmdzD0nQTGughEN0rVuCavuZ4nFfWQW5/
         Ayu7+BS58BWDUEuCylfWvXHhvjaJ3Fut0MO8xfRY7AuaWomQxXKfMKr22Qp8079dOk
         y4D/P0ncpld3kwbH2oMzGjiyrzW08UnhlgBbrbiyKP7Mt6yy8+7k6OGVlA31BunVSU
         ITEGUZ2CGoSItN2ongkRE+o4UWziBIC0s2QuAy7NtaemYzRhP6TZRzyDQ0mxY2LC0Z
         DWEfiQ1MbX7JA==
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--=_MailMate_0F9721AF-59A2-4F1F-84D6-26E9CBFFF0C7_=
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On 2 Sep 2020, at 15:57, Jason Gunthorpe wrote:

> On Wed, Sep 02, 2020 at 03:05:39PM -0400, Zi Yan wrote:
>> On 2 Sep 2020, at 14:48, Jason Gunthorpe wrote:
>>
>>> On Wed, Sep 02, 2020 at 02:45:37PM -0400, Zi Yan wrote:
>>>
>>>>> Surprised this doesn't touch mm/pagewalk.c ?
>>>>
>>>> 1GB PUD page support is present for DAX purpose, so the code is ther=
e
>>>> in mm/pagewalk.c already. I only needed to supply ops->pud_entry whe=
n using
>>>> the functions in mm/pagewalk.c. :)
>>>
>>> Yes, but doesn't this change what is possible under the mmap_sem
>>> without the page table locks?
>>>
>>> ie I would expect some thing like pmd_trans_unstable() to be required=

>>> as well for lockless walkers. (and I don't think the pmd code is 100%=

>>> right either)
>>>
>>
>> Right. I missed that. Thanks for pointing it out.
>> The code like this, right?
>
> Technically all those *pud's are racy too, the design here with the
> _unstable function call always seemed weird. I strongly suspect it
> should mirror how get_user_pages_fast works for lockless walking

You mean READ_ONCE on page table entry pointer first, then use the value
for the rest of the loop? I am not quite familiar with this racy check
part of the code and happy to hear more about it.


=E2=80=94
Best Regards,
Yan Zi

--=_MailMate_0F9721AF-59A2-4F1F-84D6-26E9CBFFF0C7_=
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQJDBAEBCgAtFiEEh7yFAW3gwjwQ4C9anbJR82th+ooFAl9QALoPHHppeUBudmlk
aWEuY29tAAoJEJ2yUfNrYfqKMoUP/0YDqdUWR4QJQvyNiGEdl6Cf9Rs2/agY2YwP
ZnErHG6+CxMWciGGm4F8UY0tlEwdSVpMGsTK7vDt267uqOpdplXIqM6+MXoTS1Bc
PnAyv6Pkmb4MDyOl93qw+b3vkFUc8rYemRfygoTiAjHq/HXMBsW6of6JuGaS5F36
LyiC7wxlnZ25ZO1oquTStn56LSLmhoka/Pz4HCF+oNm/1oSZaXWv6UQFgwd5RfJt
FqwkxorMiI34z08M85oJQL5BX8f0FufmTjYgSkKy2oJs3Hd8lERjv5RCKptpMXaY
c46GsjF31xVaAU160N2wvrBlzGiqXZOi68J2M7inI02AHkO7J+SC8GV2ssR+kKrB
aXrfX1FIwmGJLRnubYyJWtn0gOAXV9f1rQRsmjb1r+OT29CR8JCTjxpuOugqeei3
1jl4j4sppck37tjXdm8XE9kfHBAEULxYXxbupkZXqc8Aqu8kRbQDdYrD8nammB6h
Msk7SRsV7UbOmwIHPYVvOS5U83RYxbVaLaYseLZWiWvGoikWCpU4JYBCQ0FW4xNL
8Y1rovrBYB7vQUjGkbaGXKuxOF5VUeLVHIq8S2uVEqn48NW1R/GEznZgabtf1wjM
6I+PI3GQ7IunfjDj80T/a2FPQQ1BFTjYOQaCP/F8vylb1yjnKgmJTRRCVbqs8Bs7
Yf09muCw
=A7I9
-----END PGP SIGNATURE-----

--=_MailMate_0F9721AF-59A2-4F1F-84D6-26E9CBFFF0C7_=--
