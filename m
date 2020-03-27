Return-Path: <SRS0=s8dx=5M=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4FA58C43331
	for <linux-kernel@archiver.kernel.org>; Fri, 27 Mar 2020 17:34:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 21FA620714
	for <linux-kernel@archiver.kernel.org>; Fri, 27 Mar 2020 17:34:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=nvidia.com header.i=@nvidia.com header.b="ebzslUKX"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727549AbgC0ReY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 27 Mar 2020 13:34:24 -0400
Received: from hqnvemgate24.nvidia.com ([216.228.121.143]:13001 "EHLO
        hqnvemgate24.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726937AbgC0ReY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 27 Mar 2020 13:34:24 -0400
Received: from hqpgpgate101.nvidia.com (Not Verified[216.228.121.13]) by hqnvemgate24.nvidia.com (using TLS: TLSv1.2, DES-CBC3-SHA)
        id <B5e7e38c20003>; Fri, 27 Mar 2020 10:32:50 -0700
Received: from hqmail.nvidia.com ([172.20.161.6])
  by hqpgpgate101.nvidia.com (PGP Universal service);
  Fri, 27 Mar 2020 10:34:23 -0700
X-PGP-Universal: processed;
        by hqpgpgate101.nvidia.com on Fri, 27 Mar 2020 10:34:23 -0700
Received: from [10.2.174.211] (10.124.1.5) by HQMAIL107.nvidia.com
 (172.20.187.13) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Fri, 27 Mar
 2020 17:34:22 +0000
From:   Zi Yan <ziy@nvidia.com>
To:     "Kirill A. Shutemov" <kirill@shutemov.name>
CC:     <akpm@linux-foundation.org>,
        Andrea Arcangeli <aarcange@redhat.com>, <linux-mm@kvack.org>,
        <linux-kernel@vger.kernel.org>,
        "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>
Subject: Re: [PATCH 3/7] khugepaged: Drain LRU add pagevec to get rid of extra
 pins
Date:   Fri, 27 Mar 2020 13:34:20 -0400
X-Mailer: MailMate (1.13.1r5680)
Message-ID: <D4EBA00D-BD65-4B7A-8C39-75DE43BD8CB8@nvidia.com>
In-Reply-To: <20200327170601.18563-4-kirill.shutemov@linux.intel.com>
References: <20200327170601.18563-1-kirill.shutemov@linux.intel.com>
 <20200327170601.18563-4-kirill.shutemov@linux.intel.com>
MIME-Version: 1.0
X-Originating-IP: [10.124.1.5]
X-ClientProxiedBy: HQMAIL105.nvidia.com (172.20.187.12) To
 HQMAIL107.nvidia.com (172.20.187.13)
Content-Type: multipart/signed;
        boundary="=_MailMate_E59B323E-9281-4760-BAF4-CA84DE210BFD_=";
        micalg=pgp-sha512; protocol="application/pgp-signature"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
        t=1585330370; bh=1Kx7XFAxdNBJeQ7qXAogTDkyGlkntLnrYXkf/zEAh0A=;
        h=X-PGP-Universal:From:To:CC:Subject:Date:X-Mailer:Message-ID:
         In-Reply-To:References:MIME-Version:X-Originating-IP:
         X-ClientProxiedBy:Content-Type;
        b=ebzslUKXeeikdCK/q6yyaqLJUTvJHGnx/huzwE71+D46UVasN0UiglnTkNc9RMWF7
         0IZzqlllFfd82qjM51OZDHSclcUH0nFSJ4euMIxFo8YPY1O28WenjLVwXpaE6t1L5i
         JJDzElt3FdRPgHLUUChazgLCr9Q5Ci8N7QPv/qT9tBans+GCdK4yEbB5YQtDziv1kX
         y39BMgS7zQMGpPWwFkjg0y3Pv8WMnXu7BELHKywHblUppzGzBauVw25iudM/LPyzvL
         rQlL012T+iRuUZhrc9ibYB93uZYCcrFjxRUAfs8byZZ9Ug0RjAxw1d/CJKMlHjk49f
         3BsE70JBT+3kQ==
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--=_MailMate_E59B323E-9281-4760-BAF4-CA84DE210BFD_=
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On 27 Mar 2020, at 13:05, Kirill A. Shutemov wrote:

> __collapse_huge_page_isolate() may fail due to extra pin in the LRU add=

> pagevec. It's petty common for swapin case: we swap in pages just to
> fail due to the extra pin.
>
> Signed-off-by: Kirill A. Shutemov <kirill.shutemov@linux.intel.com>
> ---
>  mm/khugepaged.c | 8 ++++++++
>  1 file changed, 8 insertions(+)
>
> diff --git a/mm/khugepaged.c b/mm/khugepaged.c
> index 14d7afc90786..39e0994abeb8 100644
> --- a/mm/khugepaged.c
> +++ b/mm/khugepaged.c
> @@ -585,11 +585,19 @@ static int __collapse_huge_page_isolate(struct vm=
_area_struct *vma,
>  		 * The page must only be referenced by the scanned process
>  		 * and page swap cache.
>  		 */
> +		if (page_count(page) !=3D 1 + PageSwapCache(page)) {
> +			/*
> +			 * Drain pagevec and retry just in case we can get rid
> +			 * of the extra pin, like in swapin case.
> +			 */
> +			lru_add_drain();
> +		}
>  		if (page_count(page) !=3D 1 + PageSwapCache(page)) {
>  			unlock_page(page);
>  			result =3D SCAN_PAGE_COUNT;
>  			goto out;
>  		}
> +
>  		if (pte_write(pteval)) {
>  			writable =3D true;
>  		} else {
> -- =

> 2.26.0

Looks good to me. Is the added empty line intentional?

Reviewed-by: Zi Yan <ziy@nvidia.com>

=E2=80=94
Best Regards,
Yan Zi

--=_MailMate_E59B323E-9281-4760-BAF4-CA84DE210BFD_=
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQJDBAEBCgAtFiEEh7yFAW3gwjwQ4C9anbJR82th+ooFAl5+ORwPHHppeUBudmlk
aWEuY29tAAoJEJ2yUfNrYfqK9MMP/1nsFKGD1peS8idFNCM1mo3r5sZA9Kf8jcYH
MIQYUcwgprJn9PVaL9DI605sISqVsS8D6LrlVKfv14MerGlOYJ4360QvjUNJrgeb
GhNjVjzpP0AB0BcDtAemFW/ECT3x2/rP4+sVfr2iceJmbj5cybqb0GwAbvOcC3Dg
E2a73gBMuXV8nEyXsl5h/Za2PU31aX5z2A42/67dMJVFTXpPppQNzvXsXHjxEoBL
AzX9Y8B3SE+OY7mnchWcDWRmtGL4jDOpChdIhZE6lfebmDFzk9+59nEo8+QPQwpP
pjFKq04kkwgALNp4aoAJp6DFpGDhJoN+xHYAxUQWxmVCCEJqg4QSHOL/rpaIDZ8m
0z4KdWe36F+ligELPjh1C5lKcprk6y2HJCJ9ET3OeSEfd+j6Ngdblzv4CFI16fU8
A36VAiEHu3rEW0Z2MpGy4c5LGndKBiByo1pblaZha0gwNQ0QM6FYc4nHHj9Kvv/6
gAs1JEasDtEEKqw+gUYtp/yD9c9xgY3FJLXMszXhw9l0KV7X2TtKbasYF3VrANDM
R1BN7sVngTJZghkU6uhFZQpbFzBEpQ+nMp9hZfQmpP4pJR5NNJBYcg3aWrFPsRu8
xYy6W84AystU6VYzcpI5Q0r36acVOOa6Mmlm/H/92i5PB8LDBYs033Nkr4cLNV2B
I2iJHWwr
=HkBS
-----END PGP SIGNATURE-----

--=_MailMate_E59B323E-9281-4760-BAF4-CA84DE210BFD_=--
