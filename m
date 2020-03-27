Return-Path: <SRS0=s8dx=5M=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CBDBEC2D0E5
	for <linux-kernel@archiver.kernel.org>; Fri, 27 Mar 2020 18:20:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9C0BB2083E
	for <linux-kernel@archiver.kernel.org>; Fri, 27 Mar 2020 18:20:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=sent.com header.i=@sent.com header.b="K1Aqr2yp";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="PbQgh+kC"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727336AbgC0SUG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 27 Mar 2020 14:20:06 -0400
Received: from out1-smtp.messagingengine.com ([66.111.4.25]:49391 "EHLO
        out1-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726540AbgC0SUG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 27 Mar 2020 14:20:06 -0400
Received: from compute4.internal (compute4.nyi.internal [10.202.2.44])
        by mailout.nyi.internal (Postfix) with ESMTP id 336AE5C0374;
        Fri, 27 Mar 2020 14:20:04 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute4.internal (MEProxy); Fri, 27 Mar 2020 14:20:04 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sent.com; h=from
        :to:cc:subject:date:message-id:in-reply-to:references
        :mime-version:content-type; s=fm3; bh=Ae+wDBwdK9LuAnNK88qLAHv7Ts
        cxadUnsa9d0DLh8LA=; b=K1Aqr2ypgPUxoSNWd1pKXLGidEzowuJu3lydsJtIRM
        AubH/5cGSXVPCjFWJN+ImPAnCX4kLX6yFLPmX0dSZffpbjf8bmD596N9W7obBlVr
        xetMtFCUuXY2ZtwcY3ssSd8Vneon7zaswftv+DYXPUeWKh+NkhjU8ERQk4ncoyKO
        xuU7PXKaCgto4c38UJE0qxTa3Ce/HrG9EaTTdqdpAwwFxjqMOUCfHFO7y+gg5dPF
        cazP77LMOCKKPrRxLZdDB3InO8qHX97PbLZ4How23u2gn/EaLcOX2Pe4dqL4JKwk
        vLjAqmUd+G4bJnM5mCgIYm7yHLI+xeDkPp4/DFxuHs5g==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-type:date:from:in-reply-to
        :message-id:mime-version:references:subject:to:x-me-proxy
        :x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; bh=Ae+wDB
        wdK9LuAnNK88qLAHv7TscxadUnsa9d0DLh8LA=; b=PbQgh+kCMUt5X29+O8lMnD
        kI4Fb0mBs9eqAJ/mNg+fyi7gYYC3M6/tdP3+JcGvEhfNFHcWbNOSwxTr7qB3dM1j
        kUR06vkPHLJwneL96yknbWGuzj1w8MKS23fnxRfbURFBnJnO1yR9BitY4nZ11sMu
        Ix5FxqPUl8ymbqkf2S32UvtRAV7+8evDD0kTCDxE9/FE1AJ4R/9F1KxT0er9j+sy
        6iWvTidcxK52TY/DygzvcNq7pjwrwRjaRERiXHIrk4ekhnPrgvl1+LWtedeiEKkX
        j0IUbXNA9p7lxJ8CmMeZKA0+501xhB5iwbslr9Jgb3vblSxeO9GBxQ05EAP2HA7A
        ==
X-ME-Sender: <xms:00N-XvSG-48PA8WhrTAlLX06i269D1PGdf0_kMQIWpNWGqGghRaSlQ>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedugedrudehledguddtlecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfgh
    necuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmd
    enucfjughrpefhvffufffokfgjfhggtgesghdtmherredtjeenucfhrhhomhepfdgkihcu
    jggrnhdfuceoiihirdihrghnsehsvghnthdrtghomheqnecukfhppeejhedrieejrdelrd
    dutdefnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhep
    iihirdihrghnsehsvghnthdrtghomh
X-ME-Proxy: <xmx:00N-XlCjbOuo29o3qRBhc7IZr4WjyIZKzJ4XQUNmQSeM9a88PaodGQ>
    <xmx:00N-Xv1VZofh3JBSzsK3ZG3ky1fFW5PvcTClURf6QnvCVCUQcg_hRA>
    <xmx:00N-XjX0DlK-s_K3Lodr0rGgX-xwxE2peRBoZD41obcksMkYSuyufw>
    <xmx:1EN-Xl52NjmZEAnilEUqNPAkEEc7YQXWXlQ9qideFK4jlnph0hhCsw>
Received: from [10.2.174.211] (c-75-67-9-103.hsd1.ma.comcast.net [75.67.9.103])
        by mail.messagingengine.com (Postfix) with ESMTPA id BFC2F306C422;
        Fri, 27 Mar 2020 14:20:02 -0400 (EDT)
From:   "Zi Yan" <zi.yan@sent.com>
To:     "Kirill A. Shutemov" <kirill@shutemov.name>
Cc:     akpm@linux-foundation.org,
        "Andrea Arcangeli" <aarcange@redhat.com>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org,
        "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>
Subject: Re: [PATCH 4/7] khugepaged: Allow to callapse a page shared across
 fork
Date:   Fri, 27 Mar 2020 14:19:50 -0400
X-Mailer: MailMate (1.13.1r5680)
Message-ID: <AD80A72A-8FB7-4F89-A2C9-CDD5C616A479@sent.com>
In-Reply-To: <20200327170601.18563-5-kirill.shutemov@linux.intel.com>
References: <20200327170601.18563-1-kirill.shutemov@linux.intel.com>
 <20200327170601.18563-5-kirill.shutemov@linux.intel.com>
MIME-Version: 1.0
Content-Type: multipart/signed;
 boundary="=_MailMate_80997A0A-BCA7-4724-8B72-2A1A1D67B3D7_=";
 micalg=pgp-sha512; protocol="application/pgp-signature"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 3156 and 4880).

--=_MailMate_80997A0A-BCA7-4724-8B72-2A1A1D67B3D7_=
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On 27 Mar 2020, at 13:05, Kirill A. Shutemov wrote:

> The page can be included into collapse as long as it doesn't have extra=

> pins (from GUP or otherwise).
>
> Signed-off-by: Kirill A. Shutemov <kirill.shutemov@linux.intel.com>
> ---
>  mm/khugepaged.c | 28 ++++++++++++++++------------
>  1 file changed, 16 insertions(+), 12 deletions(-)
>
> diff --git a/mm/khugepaged.c b/mm/khugepaged.c
> index 39e0994abeb8..b47edfe57f7b 100644
> --- a/mm/khugepaged.c
> +++ b/mm/khugepaged.c
> @@ -581,18 +581,26 @@ static int __collapse_huge_page_isolate(struct vm=
_area_struct *vma,
>  		}
>
>  		/*
> -		 * cannot use mapcount: can't collapse if there's a gup pin.
> -		 * The page must only be referenced by the scanned process
> -		 * and page swap cache.
> +		 * Check if the page has any GUP (or other external) pins.
> +		 *
> +		 * The page table that maps the page has been already unlinked
> +		 * from the page table tree and this process cannot get
> +		 * additinal pin on the page.
> +		 *
> +		 * New pins can come later if the page is shared across fork,
> +		 * but not for the this process. It is fine. The other process
> +		 * cannot write to the page, only trigger CoW.
>  		 */
> -		if (page_count(page) !=3D 1 + PageSwapCache(page)) {
> +		if (total_mapcount(page) + PageSwapCache(page) !=3D
> +				page_count(page)) {

Do you think having a function for this check would be better? Since the =
check is used three times.

>  			/*
>  			 * Drain pagevec and retry just in case we can get rid
>  			 * of the extra pin, like in swapin case.
>  			 */
>  			lru_add_drain();
>  		}
> -		if (page_count(page) !=3D 1 + PageSwapCache(page)) {
> +		if (total_mapcount(page) + PageSwapCache(page) !=3D
> +				page_count(page)) {
>  			unlock_page(page);
>  			result =3D SCAN_PAGE_COUNT;
>  			goto out;
> @@ -680,7 +688,6 @@ static void __collapse_huge_page_copy(pte_t *pte, s=
truct page *page,
>  		} else {
>  			src_page =3D pte_page(pteval);
>  			copy_user_highpage(page, src_page, address, vma);
> -			VM_BUG_ON_PAGE(page_mapcount(src_page) !=3D 1, src_page);

Maybe replace it with this?

VM_BUG_ON_PAGE(page_mapcount(src_page) + PageSwapCache(src_page) !=3D pag=
e_count(src_page), src_page);


>  			release_pte_page(src_page);
>  			/*
>  			 * ptl mostly unnecessary, but preempt has to
> @@ -1209,12 +1216,9 @@ static int khugepaged_scan_pmd(struct mm_struct =
*mm,
>  			goto out_unmap;
>  		}
>
> -		/*
> -		 * cannot use mapcount: can't collapse if there's a gup pin.
> -		 * The page must only be referenced by the scanned process
> -		 * and page swap cache.
> -		 */
> -		if (page_count(page) !=3D 1 + PageSwapCache(page)) {
> +		/* Check if the page has any GUP (or other external) pins */
> +		if (total_mapcount(page) + PageSwapCache(page) !=3D
> +				page_count(page)) {
>  			result =3D SCAN_PAGE_COUNT;
>  			goto out_unmap;
>  		}
> -- =

> 2.26.0

Thanks.

=E2=80=94
Best Regards,
Yan Zi

--=_MailMate_80997A0A-BCA7-4724-8B72-2A1A1D67B3D7_=
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename=signature.asc
Content-Type: application/pgp-signature; name=signature.asc

-----BEGIN PGP SIGNATURE-----

iQFEBAEBCgAuFiEEOXBxLIohamfZUwd5QYsvEZxOpswFAl5+Q8YQHHppLnlhbkBz
ZW50LmNvbQAKCRBBiy8RnE6mzMUiCACSQ0+eDkMnjyy+ajzLsbTzYN30M5/XuDS4
2iflrQbLK3OZDH5A/L6/3nW5drgfu0AV6opHNrsksfrw+ClQVrI2q19kz0uZJKj5
KqAnN49evZTDdMZd64u4QR320fqNRLPN7tWRQ9Kzj/AwDVLG1GDQgCKfI7q/0CP0
vIG1R6fkmOUz/6dQsqa+RYJJ6Wlg7oFWrSZNHCvHJ7d3N/goS41BQtyiW9n+fcj3
VLjlgy2ljDUc6zOV2zUcR63CgKWxkhSVeIhmhfjJtnX2vKfrOgp6MPP6Pc49MeXx
LQSp0oNZ6q7bPdkn6uJAI0e4qZDyJPQIeQO6vDABx1q1CiAJ1ZBB
=/MsL
-----END PGP SIGNATURE-----

--=_MailMate_80997A0A-BCA7-4724-8B72-2A1A1D67B3D7_=--
