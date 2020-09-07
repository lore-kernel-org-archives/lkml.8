Return-Path: <SRS0=/EmK=CQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6F843C433E2
	for <linux-kernel@archiver.kernel.org>; Mon,  7 Sep 2020 16:20:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3BAA620757
	for <linux-kernel@archiver.kernel.org>; Mon,  7 Sep 2020 16:20:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=nvidia.com header.i=@nvidia.com header.b="U4Z4qxvi"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730439AbgIGQUu (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 7 Sep 2020 12:20:50 -0400
Received: from hqnvemgate25.nvidia.com ([216.228.121.64]:11923 "EHLO
        hqnvemgate25.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730528AbgIGQUd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Sep 2020 12:20:33 -0400
Received: from hqpgpgate101.nvidia.com (Not Verified[216.228.121.13]) by hqnvemgate25.nvidia.com (using TLS: TLSv1.2, DES-CBC3-SHA)
        id <B5f565d910000>; Mon, 07 Sep 2020 09:19:29 -0700
Received: from hqmail.nvidia.com ([172.20.161.6])
  by hqpgpgate101.nvidia.com (PGP Universal service);
  Mon, 07 Sep 2020 09:20:19 -0700
X-PGP-Universal: processed;
        by hqpgpgate101.nvidia.com on Mon, 07 Sep 2020 09:20:19 -0700
Received: from [10.2.173.224] (10.124.1.5) by HQMAIL107.nvidia.com
 (172.20.187.13) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Mon, 7 Sep
 2020 16:20:14 +0000
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
Date:   Mon, 7 Sep 2020 11:11:05 -0400
X-Mailer: MailMate (1.13.1r5705)
Message-ID: <50FA95D1-9222-48C0-9223-C1267E8C7A4A@nvidia.com>
In-Reply-To: <20200907122228.4zlyfysdul3s62me@box>
References: <20200902180628.4052244-1-zi.yan@sent.com>
 <20200902180628.4052244-2-zi.yan@sent.com>
 <20200907122228.4zlyfysdul3s62me@box>
MIME-Version: 1.0
X-Originating-IP: [10.124.1.5]
X-ClientProxiedBy: HQMAIL111.nvidia.com (172.20.187.18) To
 HQMAIL107.nvidia.com (172.20.187.13)
Content-Type: multipart/signed;
        boundary="=_MailMate_C524708B-26F9-4F4E-8D4C-397110CA1F43_=";
        micalg=pgp-sha512; protocol="application/pgp-signature"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
        t=1599495569; bh=XnTErfZJmzsbuFLxuYCSxEnom9P/2j+krPxmhkHI9cY=;
        h=X-PGP-Universal:From:To:CC:Subject:Date:X-Mailer:Message-ID:
         In-Reply-To:References:MIME-Version:X-Originating-IP:
         X-ClientProxiedBy:Content-Type;
        b=U4Z4qxviGFX+btp8OavPkBkMQmHxIBgEyc8CDZ8rE1f+FgYF57mLJMD+CwwzY+fpU
         GoIMxbRjjG5ehaqoXwcXSkP9UeAJ1qeOdpLssGH+U7brJvKD+GPtcqRXN/ldARgIgb
         6EFJgUNo+YeqYU5HNOt2pEdhBzoX3Do88Fut1CH8xvOnLGmfCfi928h1oAewYHNHR3
         3noYaMgLguUaQrOvQCnnmhHeyTc9Bmc4aYRpTAGOhQsXcL52gLG2JYwll0fPq65iRB
         7R0+FUoMkkUQ7Zy90Lb5kVo1wvyO+fzV17aC49OCM1CPyf5oH9LpqDptBYA4AwWBKC
         Jw5E8q/1Qs5HA==
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--=_MailMate_C524708B-26F9-4F4E-8D4C-397110CA1F43_=
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On 7 Sep 2020, at 8:22, Kirill A. Shutemov wrote:

> On Wed, Sep 02, 2020 at 02:06:13PM -0400, Zi Yan wrote:
>> From: Zi Yan <ziy@nvidia.com>
>>
>> When depositing page table pages for 1GB THPs, we need 512 PTE pages +=

>> 1 PMD page. Instead of counting and depositing 513 pages, we can use t=
he
>> PMD page as a leader page and chain the rest 512 PTE pages with ->lru.=

>> This, however, prevents us depositing PMD pages with ->lru, which is
>> currently used by depositing PTE pages for 2MB THPs. So add a new
>> pagechain container for PMD pages.
>>
>> Signed-off-by: Zi Yan <ziy@nvidia.com>
>
> Just deposit it to a linked list in the mm_struct as we do for PMD if
> split ptl disabled.
>

Thank you for checking the patches. Since we don=E2=80=99t have PUD split=
 lock
yet, I store the PMD page table pages in a newly added linked list head
in mm_struct like you suggested above.

I was too vague about my pagechain design for depositing page table pages=

for PUD THPs. Sorry about the confusion. Let me clarify why
I am doing this pagechain here too. I am sure there would be
some other designs and I am happy to change my code.

In my design, I did not store all page table pages in a single list.
I first deposit 512 PTE pages in one PMD page table page=E2=80=99s pmd_hu=
ge_pte
using pgtable_trans_huge_depsit(), then deposit the PMD page to
a newly added linked list in mm_struct. Since pmd_huge_pte shares space
with half of lru in struct page, we cannot use lru to link all PMD
pages together. As a result, I added pagechain. Also in this way,
we can avoid these things:

1. when we withdraw the PMD page during PUD THP split, we don=E2=80=99t n=
eed
to withdraw 513 page, set up one PMD page, then, deposit 512 PTE pages
in that PMD page.

2. we don=E2=80=99t mix PMD page table pages and PTE page table pages in =
a single
list, since they are initialized in different ways. Otherwise, we need
to maintain a subtle rule in the single page table page list that in ever=
y
513 pages, first one is PMD page table page and the rest are PTE page
table pages.

As I am typing, I also realize that my current design does not work
when PMD split lock is disabled, so I will fix it. I would store PMD page=
s
and PTE pages in two separate lists in mm_struct.


Any comments?


=E2=80=94
Best Regards,
Yan Zi

--=_MailMate_C524708B-26F9-4F4E-8D4C-397110CA1F43_=
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQJDBAEBCgAtFiEEh7yFAW3gwjwQ4C9anbJR82th+ooFAl9WTYkPHHppeUBudmlk
aWEuY29tAAoJEJ2yUfNrYfqKaqQP/imSOWGHuhcGwPnoJnxwJjrGbjRZgQhosHFn
GL2NrMdHoCgha78i3hItoR9KE4JvX6U9BmsR45jeJXqFohg+F0WeC1UzbsVwllBL
DbmM9P9w1QDMTDjrH8YyiSMgXM5V/r0XP/dSQjbV9vPZ57BobkYejOuKfphZ/WWz
+p4kzkJWkidYZH+WiiZ1JCmFwrQyDNjA7QRQPoC74Dm6S1KTDbJnajv85e2TQ7Yf
emBemN1xMXypJGLyJ1PgnGrhhzmqWFXRjK6pmuLlqA6iuFwJp2oLE62RI4lTS9ZC
8FVq0Ki5Zkgm8wWsMBfywUGGffLY5c1VnIGtcLrz1/XrFlsbFdBr5mxkegwySmQN
AiCI9ggPtzC6JAvmicnl9u1Uf1XeS90qJLLhE+qqO0odva6TVsFzvssssTd7YfRu
ifjitYOk4pt92YuemT3cNdG6Z7x5iHwd6hNLbZ9NP+BQ+/djUeXL/jVE1GUx6Kos
mzqEBsENb2PxK6+Wakz3gb6kcEcSgqt6dwRSuzmGfCeQVXDqHLUHPS80wlcCC+XX
961AY56aziAImPO6zWcvqlai2REGFhYSNuaTZfUyoGVOuyrszZrtVRSgd26NJX/W
K+w9rhNn1SnknzthASwfXet4UfB+XcS0ZuIj7s+7s5RUKD0nIH6DwYTNVfWBIGg9
av72XkIo
=Wyrp
-----END PGP SIGNATURE-----

--=_MailMate_C524708B-26F9-4F4E-8D4C-397110CA1F43_=--
