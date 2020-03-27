Return-Path: <SRS0=s8dx=5M=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E50DFC2D0ED
	for <linux-kernel@archiver.kernel.org>; Fri, 27 Mar 2020 17:30:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BD70620B1F
	for <linux-kernel@archiver.kernel.org>; Fri, 27 Mar 2020 17:30:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=nvidia.com header.i=@nvidia.com header.b="X4Adxfb9"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727393AbgC0Raa (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 27 Mar 2020 13:30:30 -0400
Received: from hqnvemgate25.nvidia.com ([216.228.121.64]:17902 "EHLO
        hqnvemgate25.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727125AbgC0Raa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 27 Mar 2020 13:30:30 -0400
Received: from hqpgpgate101.nvidia.com (Not Verified[216.228.121.13]) by hqnvemgate25.nvidia.com (using TLS: TLSv1.2, DES-CBC3-SHA)
        id <B5e7e38060002>; Fri, 27 Mar 2020 10:29:42 -0700
Received: from hqmail.nvidia.com ([172.20.161.6])
  by hqpgpgate101.nvidia.com (PGP Universal service);
  Fri, 27 Mar 2020 10:30:29 -0700
X-PGP-Universal: processed;
        by hqpgpgate101.nvidia.com on Fri, 27 Mar 2020 10:30:29 -0700
Received: from [10.2.174.211] (10.124.1.5) by HQMAIL107.nvidia.com
 (172.20.187.13) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Fri, 27 Mar
 2020 17:30:28 +0000
From:   Zi Yan <ziy@nvidia.com>
To:     "Kirill A. Shutemov" <kirill@shutemov.name>
CC:     <akpm@linux-foundation.org>,
        Andrea Arcangeli <aarcange@redhat.com>, <linux-mm@kvack.org>,
        <linux-kernel@vger.kernel.org>,
        "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>
Subject: Re: [PATCH 2/7] khugepaged: Do not stop collapse if less than half
 PTEs are referenced
Date:   Fri, 27 Mar 2020 13:30:26 -0400
X-Mailer: MailMate (1.13.1r5680)
Message-ID: <82E3CA05-2AE5-4FB4-860E-F334A99E69FD@nvidia.com>
In-Reply-To: <20200327170601.18563-3-kirill.shutemov@linux.intel.com>
References: <20200327170601.18563-1-kirill.shutemov@linux.intel.com>
 <20200327170601.18563-3-kirill.shutemov@linux.intel.com>
MIME-Version: 1.0
X-Originating-IP: [10.124.1.5]
X-ClientProxiedBy: HQMAIL105.nvidia.com (172.20.187.12) To
 HQMAIL107.nvidia.com (172.20.187.13)
Content-Type: multipart/signed;
        boundary="=_MailMate_B74C0D56-6018-4515-9BF0-1EF7BAD28B3B_=";
        micalg=pgp-sha512; protocol="application/pgp-signature"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
        t=1585330182; bh=vBdCIoLeE0Y5Jf2pHeWx2jEGBq4SgdB78rYKGEE2XvY=;
        h=X-PGP-Universal:From:To:CC:Subject:Date:X-Mailer:Message-ID:
         In-Reply-To:References:MIME-Version:X-Originating-IP:
         X-ClientProxiedBy:Content-Type;
        b=X4Adxfb9ZsdOWD+ku69YVAVAFrl5K9mzefdbiOrygqFB+xEDlN4vj9/0l62vFp7/2
         cf3mhY4mtW56XUnucc7T1S3gTVEAbFQ5s+0saWaguqd4kuF23EX+XTvagmSNGw1dtj
         zn3FG6DRYBOOEylqM5+G6tcR2cFAeEnyZqXOIIkIEsT4Wj+koJTdKrvMx4ZTmsJ+Ie
         PpaOH+O30xCTKoDk6z5VFqfcz2mm7mLoiYQAibFpiTUN619jkuaEMjS/fJfSmDxn37
         lf50dtyQrzLttSdDgC+4hSyj4rAugo47PetOlQM39jWLRK8QmEkKJVALifryOmHpQZ
         DIN3M/x8OtB9Q==
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--=_MailMate_B74C0D56-6018-4515-9BF0-1EF7BAD28B3B_=
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On 27 Mar 2020, at 13:05, Kirill A. Shutemov wrote:

> __collapse_huge_page_swapin() check number of referenced PTE to decide
> if the memory range is hot enough to justify swapin.
>
> The problem is that it stops collapse altogether if there's not enough
> refereced pages, not only swappingin.
>
> Signed-off-by: Kirill A. Shutemov <kirill.shutemov@linux.intel.com>
> Fixes: 0db501f7a34c ("mm, thp: convert from optimistic swapin collapsin=
g to conservative")
> ---
>  mm/khugepaged.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
>
> diff --git a/mm/khugepaged.c b/mm/khugepaged.c
> index 99bab7e4d05b..14d7afc90786 100644
> --- a/mm/khugepaged.c
> +++ b/mm/khugepaged.c
> @@ -905,7 +905,8 @@ static bool __collapse_huge_page_swapin(struct mm_s=
truct *mm,
>  	/* we only decide to swapin, if there is enough young ptes */
>  	if (referenced < HPAGE_PMD_NR/2) {
>  		trace_mm_collapse_huge_page_swapin(mm, swapped_in, referenced, 0);
> -		return false;
> +		/* Do not block collapse, only skip swapping in */
> +		return true;
>  	}
>  	vmf.pte =3D pte_offset_map(pmd, address);
>  	for (; vmf.address < address + HPAGE_PMD_NR*PAGE_SIZE;
> -- =

> 2.26.0

Make sense.

Reviewed-by: Zi Yan <ziy@nvidia.com>

=E2=80=94
Best Regards,
Yan Zi

--=_MailMate_B74C0D56-6018-4515-9BF0-1EF7BAD28B3B_=
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQJDBAEBCgAtFiEEh7yFAW3gwjwQ4C9anbJR82th+ooFAl5+ODIPHHppeUBudmlk
aWEuY29tAAoJEJ2yUfNrYfqK9dQP/36AU1eLyLdcEEc6sSwHwvUDPYoUaxIcFuSM
+Gwc8frVB9juhqzRQkor/SgZGAL0otYiXx49kJSGk0SwWnugZ38Y7vs2XHB9+b86
lUP3CNrMpqbKu3h3QQ0oKR34jQKZME8bLXmSKpGDRJHcHTgVndBrNmzlfqDwR79+
tG68aNQTLpCatQN242AE7pF9zzca+t4FRJCCoBw257vcFe+YhXOIcLpPPvfshTq0
663f1FtjTyjQ3GzwOJx0yz+X9tE5hYmSrf4OsntedPyNWJI7y2SY9ZF/xAjN5wXl
tOBzeJOyoZ168nJGGrEDWXs1K2GBedFqc+jriMXFk0LGVXHmYaMlcOMw3egjmLec
4wlOEMM5DHecGAINlMb5p+Ztg9xHAWtAgXDkWu6Fhk2xhtUT+aqDJ4VXqJlfCXdI
19rjiZWJxLYsb72bLYFwuGX41EvKiJFMwIm6sojB57UBC4+K0F8TjucxbiEbVXSv
0mdQM8wv29SpbxGKcEog4e8c0mWT596D97tOdkwvI283nAPLPtNKRGic5SXopBZK
gEe9nHruK+DhRoSZ5ZTZIeNjyRigo4G7N5mRS9L+M7Wveg4kiWO3FyYAh66ER5Ee
nwTnJOeY0iHQu4dhUSZnVgD54u2EU2UZwKyPc6RJ6ZtCuLUGpIbO9xCp8rkECR+Q
Vzn6qF9t
=VYnS
-----END PGP SIGNATURE-----

--=_MailMate_B74C0D56-6018-4515-9BF0-1EF7BAD28B3B_=--
