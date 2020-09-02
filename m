Return-Path: <SRS0=728o=CL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BE685C433E2
	for <linux-kernel@archiver.kernel.org>; Wed,  2 Sep 2020 19:05:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 867A320758
	for <linux-kernel@archiver.kernel.org>; Wed,  2 Sep 2020 19:05:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=nvidia.com header.i=@nvidia.com header.b="RA6x+9rI"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728252AbgIBTFp (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 2 Sep 2020 15:05:45 -0400
Received: from hqnvemgate25.nvidia.com ([216.228.121.64]:19867 "EHLO
        hqnvemgate25.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726567AbgIBTFn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Sep 2020 15:05:43 -0400
Received: from hqpgpgate102.nvidia.com (Not Verified[216.228.121.13]) by hqnvemgate25.nvidia.com (using TLS: TLSv1.2, DES-CBC3-SHA)
        id <B5f4fecd80001>; Wed, 02 Sep 2020 12:04:56 -0700
Received: from hqmail.nvidia.com ([172.20.161.6])
  by hqpgpgate102.nvidia.com (PGP Universal service);
  Wed, 02 Sep 2020 12:05:43 -0700
X-PGP-Universal: processed;
        by hqpgpgate102.nvidia.com on Wed, 02 Sep 2020 12:05:43 -0700
Received: from [10.2.161.253] (10.124.1.5) by HQMAIL107.nvidia.com
 (172.20.187.13) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Wed, 2 Sep
 2020 19:05:41 +0000
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
Date:   Wed, 2 Sep 2020 15:05:39 -0400
X-Mailer: MailMate (1.13.1r5705)
Message-ID: <C5EFA1CC-311C-47D5-9506-D087D9AE58D1@nvidia.com>
In-Reply-To: <20200902184852.GH24045@ziepe.ca>
References: <20200902180628.4052244-1-zi.yan@sent.com>
 <20200902184053.GF24045@ziepe.ca>
 <E78A0F18-223C-44A8-BCBA-73CF7AF6F8A5@nvidia.com>
 <20200902184852.GH24045@ziepe.ca>
MIME-Version: 1.0
X-Originating-IP: [10.124.1.5]
X-ClientProxiedBy: HQMAIL101.nvidia.com (172.20.187.10) To
 HQMAIL107.nvidia.com (172.20.187.13)
Content-Type: multipart/signed;
        boundary="=_MailMate_6ECD70B9-9BD5-48DB-8389-5AAFEF06D26A_=";
        micalg=pgp-sha512; protocol="application/pgp-signature"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
        t=1599073496; bh=zHnARvftjYKXS8WaABUFmtc3hDOq25NBfmLyot+94zY=;
        h=X-PGP-Universal:From:To:CC:Subject:Date:X-Mailer:Message-ID:
         In-Reply-To:References:MIME-Version:X-Originating-IP:
         X-ClientProxiedBy:Content-Type;
        b=RA6x+9rIILFKif5BaVs9mXrSUtUgx93FsX8N0azOvRh0BIl7xRk235fiFJTUZjlrr
         nGJGMMJYOBZRbu1+x/w94vPfg6Xs2RVZnc3gqTTssEafwX6uDXEv6fa/NLxSJ8YE66
         rRB+do/CQQJFeGTnpBVvDH0EHzgXE6fsqDLHrEXt3WVTJsVs2Tri3/apJrtcHQmSZH
         G34uVIRIz5C0uOD9fxVCbxBQPJuhHPfikC1cVdM+/Xlcfu98+VQG2CmYfI6B5yr4En
         az2yUVug0xtH84Mqqmzpqbfi45QJXAQYe/uLpV3oGS7FdCE+bCn5hyPUNAxjW8UNdO
         vaaRhUl0rg6wA==
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--=_MailMate_6ECD70B9-9BD5-48DB-8389-5AAFEF06D26A_=
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On 2 Sep 2020, at 14:48, Jason Gunthorpe wrote:

> On Wed, Sep 02, 2020 at 02:45:37PM -0400, Zi Yan wrote:
>
>>> Surprised this doesn't touch mm/pagewalk.c ?
>>
>> 1GB PUD page support is present for DAX purpose, so the code is there
>> in mm/pagewalk.c already. I only needed to supply ops->pud_entry when =
using
>> the functions in mm/pagewalk.c. :)
>
> Yes, but doesn't this change what is possible under the mmap_sem
> without the page table locks?
>
> ie I would expect some thing like pmd_trans_unstable() to be required
> as well for lockless walkers. (and I don't think the pmd code is 100%
> right either)
>

Right. I missed that. Thanks for pointing it out.
The code like this, right?

diff --git a/mm/pagewalk.c b/mm/pagewalk.c
index e81640d9f177..4fe6ce4a92eb 100644
--- a/mm/pagewalk.c
+++ b/mm/pagewalk.c
@@ -152,10 +152,11 @@ static int walk_pud_range(p4d_t *p4d, unsigned long=
 addr, unsigned long end,
                    !(ops->pmd_entry || ops->pte_entry))
                        continue;

-               if (walk->vma)
+               if (walk->vma) {
                        split_huge_pud(walk->vma, pud, addr);
-               if (pud_none(*pud))
-                       goto again;
+                       if (pud_trans_unstable(pud))
+                               goto again;
+               }

                err =3D walk_pmd_range(pud, addr, next, walk);
                if (err)


=E2=80=94
Best Regards,
Yan Zi

--=_MailMate_6ECD70B9-9BD5-48DB-8389-5AAFEF06D26A_=
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQJDBAEBCgAtFiEEh7yFAW3gwjwQ4C9anbJR82th+ooFAl9P7QMPHHppeUBudmlk
aWEuY29tAAoJEJ2yUfNrYfqKfqgQALQBCrz1+UeSW7peSX/j0pjbfBikZjb7aGqj
X17uNSXNAJZzoXlWqtMxIlWluoAfZf0XXTk1rmjJYklQKujXFBWfP8ND8Tfm5dN6
31ZeIlD5RgWQcctTYAOGuBwECNjC8jCDHXm2WOiFMzyKhu7rGsQoIiwEeLWwmWUd
aJe1a/AmuhsZoqtAOP1YziuQybio4skTVYtpfW+WKHeoQEVihGmBHjw3q3YjJl93
SQegW1O+rE8OSsnBxTG4aOJl9eNgQep3d65rf/U9K4wVl0gB9QUKZDcjO6FdsPwL
YqyoJvjLMh2x5CSEcpOy3pj8OyyKfLYI+TgQr944Comd8CmhV3CYoREb79PR8qL2
8atGLWmWGuhWr64EOTKa3Ax5hoICHlSxRqIs5h5yLvS9ZUR50+CPAunyT9WUrHwj
VgPX9qFeaIT/np3ScXbwg43IGYH7sIArZjzFn91MZ2Lld+eO1StdhoWG2FLwkFzb
HyC8fKq1t9/j5VjxSmrdqgp5Brn03D287hwXb39CG/D1k/UU/cV4jkByXqAHB/hK
lbvF1S7QxBYppX7nSSTth5ilaA6JmhXSs3tGI4e55wV+00OmlMZ7islXhuEPnEqO
Fd/pH4RBmqPv05+u7zd5skJY+EWUeh9UbiXVtdpAAOyO5i/GoO4xGgb1GLNo2i7Q
8dwyjNIu
=B2Xz
-----END PGP SIGNATURE-----

--=_MailMate_6ECD70B9-9BD5-48DB-8389-5AAFEF06D26A_=--
