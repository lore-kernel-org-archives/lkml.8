Return-Path: <SRS0=Zj89=5W=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3D9C5C2BA19
	for <linux-kernel@archiver.kernel.org>; Mon,  6 Apr 2020 13:11:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F200C22447
	for <linux-kernel@archiver.kernel.org>; Mon,  6 Apr 2020 13:11:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=nvidia.com header.i=@nvidia.com header.b="XvOfKEqf"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728355AbgDFNLc (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 6 Apr 2020 09:11:32 -0400
Received: from hqnvemgate24.nvidia.com ([216.228.121.143]:11392 "EHLO
        hqnvemgate24.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728018AbgDFNLb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Apr 2020 09:11:31 -0400
Received: from hqpgpgate101.nvidia.com (Not Verified[216.228.121.13]) by hqnvemgate24.nvidia.com (using TLS: TLSv1.2, DES-CBC3-SHA)
        id <B5e8b2a1d0000>; Mon, 06 Apr 2020 06:09:49 -0700
Received: from hqmail.nvidia.com ([172.20.161.6])
  by hqpgpgate101.nvidia.com (PGP Universal service);
  Mon, 06 Apr 2020 06:11:30 -0700
X-PGP-Universal: processed;
        by hqpgpgate101.nvidia.com on Mon, 06 Apr 2020 06:11:30 -0700
Received: from DRHQMAIL107.nvidia.com (10.27.9.16) by HQMAIL111.nvidia.com
 (172.20.187.18) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Mon, 6 Apr
 2020 13:11:30 +0000
Received: from [10.2.163.253] (172.20.13.39) by DRHQMAIL107.nvidia.com
 (10.27.9.16) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Mon, 6 Apr 2020
 13:11:29 +0000
From:   Zi Yan <ziy@nvidia.com>
To:     "Kirill A. Shutemov" <kirill@shutemov.name>
CC:     <akpm@linux-foundation.org>,
        Andrea Arcangeli <aarcange@redhat.com>,
        "Yang Shi" <yang.shi@linux.alibaba.com>, <linux-mm@kvack.org>,
        <linux-kernel@vger.kernel.org>,
        "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>
Subject: Re: [PATCHv2 4/8] khugepaged: Drain LRU add pagevec after swapin
Date:   Mon, 6 Apr 2020 09:11:27 -0400
X-Mailer: MailMate (1.13.1r5680)
Message-ID: <592329FA-69D0-4801-A5DF-F9CC8A3FE305@nvidia.com>
In-Reply-To: <20200403112928.19742-5-kirill.shutemov@linux.intel.com>
References: <20200403112928.19742-1-kirill.shutemov@linux.intel.com>
 <20200403112928.19742-5-kirill.shutemov@linux.intel.com>
MIME-Version: 1.0
X-Originating-IP: [172.20.13.39]
X-ClientProxiedBy: HQMAIL107.nvidia.com (172.20.187.13) To
 DRHQMAIL107.nvidia.com (10.27.9.16)
Content-Type: multipart/signed;
        boundary="=_MailMate_C83B2B7B-6470-4A8C-8DF4-B63554AB4EDB_=";
        micalg=pgp-sha512; protocol="application/pgp-signature"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
        t=1586178589; bh=QhAGqQow2xf9gnlQ1LeKiIdjJMWRPSwZu94uUdZ5Lv8=;
        h=X-PGP-Universal:From:To:CC:Subject:Date:X-Mailer:Message-ID:
         In-Reply-To:References:MIME-Version:X-Originating-IP:
         X-ClientProxiedBy:Content-Type;
        b=XvOfKEqfNNOwCwscu+tUNJB3/812aq7VuEM+uFSpu1FKVXJfUeIM8uPIcx+Viyz6v
         hgfV4fibPMtQfUz7hprNtlKr0ACsRR9Wmiuzy2AefSfgnHbZrDFEi2BCDaMgXUwNxf
         BA1TS/U6aDv+K5lC5OKoyJiXnBLHuSGx8V9IoIrtL9CHLIANDph5c0le5N6V533ZmF
         wqTxXyZr26ZjuEwhJ0k2yKObpYdeqbBv5e30MTtQAEsXa58kWYyjI5s/0KCJtvk7M+
         2uKzKv58mHlf8wgNNrNEGZauIfcSwg1mkLhlO08KX3+m4EK7z4KLQzkozpFtLoar55
         x4KvzevsZU5Hw==
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--=_MailMate_C83B2B7B-6470-4A8C-8DF4-B63554AB4EDB_=
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On 3 Apr 2020, at 7:29, Kirill A. Shutemov wrote:

> External email: Use caution opening links or attachments
>
>
> __collapse_huge_page_isolate() may fail due to extra pin in the LRU add=

> pagevec. It's petty common for swapin case: we swap in pages just to

s/petty/pretty

> fail due to the extra pin.
>
> Drain LRU add pagevec on sucessfull swapin.

s/sucessfull/successful

>
> Signed-off-by: Kirill A. Shutemov <kirill.shutemov@linux.intel.com>
> ---
>  mm/khugepaged.c | 5 +++++
>  1 file changed, 5 insertions(+)
>
> diff --git a/mm/khugepaged.c b/mm/khugepaged.c
> index fdc10ffde1ca..57ff287caf6b 100644
> --- a/mm/khugepaged.c
> +++ b/mm/khugepaged.c
> @@ -940,6 +940,11 @@ static bool __collapse_huge_page_swapin(struct mm_=
struct *mm,
>         }
>         vmf.pte--;
>         pte_unmap(vmf.pte);
> +
> +       /* Drain LRU add pagevec to remove extra pin on the swapped in =
pages */
> +       if (swapped_in)
> +               lru_add_drain();
> +
>         trace_mm_collapse_huge_page_swapin(mm, swapped_in, referenced, =
1);
>         return true;
>  }
> --
> 2.26.0


=E2=80=94
Best Regards,
Yan Zi

--=_MailMate_C83B2B7B-6470-4A8C-8DF4-B63554AB4EDB_=
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQJDBAEBCgAtFiEEh7yFAW3gwjwQ4C9anbJR82th+ooFAl6LKn8PHHppeUBudmlk
aWEuY29tAAoJEJ2yUfNrYfqKKxYQAIDwUi/sWEd4E5TrOi0JeGwSlI9dP3EFZQPt
joKck2BSsIirc6FgoyDMhOmstJ422Qa44vbD1eODystiAPJr2Kiv8QPGeKWBfWP0
jt6cnItoFE03xHxXw6sTjrM2LVMpjowgb6jcoHzI11QCi6GLcVTxyYJrA2pFuBhJ
6+Ku8ur5IHsLm1SQv3e6kmvdbrRWLyAe898CtGOuqJz7S1/sC69lK1lkc0PLGwDP
XhMxxwcgVnVMG5zouRHnGkMZ/GnIvxvkgcGe4EXVGTQXpB3Whbgw4wtzEOl3SHW9
RmRxNGREx3R5mfUwzidrPRjFPPKGMCkmNHwjawVYyViENPuH+uMZsx1p7TtrcefR
dFbUESbNowbd3r1DD0n1fbN/9QeMnTZTJorRNl7dZdYe5txB0AvBBhHSJCmcw84C
YyZ/wRpC9xv86FXuW4letu2H/J0zUJii/lQyanUWT1CorOzEi1nwRBm0iHQi2alM
0eCqxM5VyuEuhyfUAddlegZST1iL6ouVu4X2sZ6vUAXKtXgtggB0xFkyuDSw8J+e
a35pwnDJroqOFVImtZh+sfkq//ELFU4djvY+q2imm6pzoUgepCptAT29Mx9VbdOb
NgGl/SSSZ1GpayWTr0J27s+bBgadoseAV5BaB1dJzW3lFjZj5poRiSTSJ8EfY7Gf
Bz/36+gY
=q3D5
-----END PGP SIGNATURE-----

--=_MailMate_C83B2B7B-6470-4A8C-8DF4-B63554AB4EDB_=--
