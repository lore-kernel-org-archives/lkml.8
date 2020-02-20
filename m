Return-Path: <SRS0=NukP=4I=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6386CC11D04
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Feb 2020 13:18:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3758220722
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Feb 2020 13:18:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=nvidia.com header.i=@nvidia.com header.b="eNYosroi"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728205AbgBTNSy (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 20 Feb 2020 08:18:54 -0500
Received: from hqnvemgate24.nvidia.com ([216.228.121.143]:19949 "EHLO
        hqnvemgate24.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727953AbgBTNSy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Feb 2020 08:18:54 -0500
Received: from hqpgpgate102.nvidia.com (Not Verified[216.228.121.13]) by hqnvemgate24.nvidia.com (using TLS: TLSv1.2, DES-CBC3-SHA)
        id <B5e4e86f40000>; Thu, 20 Feb 2020 05:17:41 -0800
Received: from hqmail.nvidia.com ([172.20.161.6])
  by hqpgpgate102.nvidia.com (PGP Universal service);
  Thu, 20 Feb 2020 05:18:53 -0800
X-PGP-Universal: processed;
        by hqpgpgate102.nvidia.com on Thu, 20 Feb 2020 05:18:53 -0800
Received: from [10.2.160.62] (10.124.1.5) by HQMAIL107.nvidia.com
 (172.20.187.13) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Thu, 20 Feb
 2020 13:18:51 +0000
From:   Zi Yan <ziy@nvidia.com>
To:     "Huang, Ying" <ying.huang@intel.com>
CC:     Andrew Morton <akpm@linux-foundation.org>, <linux-mm@kvack.org>,
        <linux-kernel@vger.kernel.org>,
        "Kirill A . Shutemov" <kirill.shutemov@linux.intel.com>,
        Andrea Arcangeli <aarcange@redhat.com>,
        Michal Hocko <mhocko@kernel.org>,
        Vlastimil Babka <vbabka@suse.cz>
Subject: Re: [PATCH] mm: Fix possible PMD dirty bit lost in
 set_pmd_migration_entry()
Date:   Thu, 20 Feb 2020 08:18:49 -0500
X-Mailer: MailMate (1.13.1r5676)
Message-ID: <51A5D10D-0ABA-4FA2-A749-EBF60DB4FEE6@nvidia.com>
In-Reply-To: <20200220075220.2327056-1-ying.huang@intel.com>
References: <20200220075220.2327056-1-ying.huang@intel.com>
MIME-Version: 1.0
X-Originating-IP: [10.124.1.5]
X-ClientProxiedBy: HQMAIL111.nvidia.com (172.20.187.18) To
 HQMAIL107.nvidia.com (172.20.187.13)
Content-Type: multipart/signed;
        boundary="=_MailMate_EFBAB02F-7B4D-42C6-BD8F-4DD342D56792_=";
        micalg=pgp-sha512; protocol="application/pgp-signature"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
        t=1582204661; bh=ia8C50FcJ9IqTIPFRX/pHZ9Hj3Et0GVBStcW+vilTEY=;
        h=X-PGP-Universal:From:To:CC:Subject:Date:X-Mailer:Message-ID:
         In-Reply-To:References:MIME-Version:X-Originating-IP:
         X-ClientProxiedBy:Content-Type;
        b=eNYosroi46W+zx8zsp1OtVS6ILZzDW/iAZHv00QPonKlRd9u/3lAW1OB49/bAfd8Y
         mOuo5+A+VaurchlLr1UD7/hEqc0oNoB2fJKX0vE7r/6AwW9hJur36lpnwcL0ceBTmd
         0pfgWaS+kktCppKn7ibyslh8bv+3nK+1YuNgayW70MTmgLwoQX0MB07HPrGNennver
         j/s/KsjurG0LIOV0746RCTeuJv/R2BOaj9OAySwycML9q5NBDaDw5XBervQUORXOOu
         b7ylJMV5eSckq6nhGwvY3mK6jBG5QzUumXNdHg8Yv42RRa0wUjwbs/HIWpISA+c8NG
         W2GvzTowuUdEQ==
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--=_MailMate_EFBAB02F-7B4D-42C6-BD8F-4DD342D56792_=
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On 20 Feb 2020, at 2:52, Huang, Ying wrote:

> From: Huang Ying <ying.huang@intel.com>
>
> In set_pmd_migration_entry(), pmdp_invalidate() is used to change PMD
> atomically.  But the PMD is read before that with an ordinary memory
> reading.  If the THP (transparent huge page) is written between the
> PMD reading and pmdp_invalidate(), the PMD dirty bit may be lost, and
> cause data corruption.  The race window is quite small, but still
> possible in theory, so need to be fixed.
>
> The race is fixed via using the return value of pmdp_invalidate() to
> get the original content of PMD, which is a read/modify/write atomic
> operation.  So no THP writing can occur in between.
>
> The race has been introduced when the THP migration support is added
> in the commit 616b8371539a ("mm: thp: enable thp migration in generic
> path").  But this fix depends on the commit d52605d7cb30 ("mm: do not
> lose dirty and accessed bits in pmdp_invalidate()").  So it's easy to
> be backported after v4.16.  But the race window is really small, so it
> may be fine not to backport the fix at all.
>
> Signed-off-by: "Huang, Ying" <ying.huang@intel.com>
> Cc: Zi Yan <ziy@nvidia.com>
> Cc: Kirill A. Shutemov <kirill.shutemov@linux.intel.com>
> Cc: Andrea Arcangeli <aarcange@redhat.com>
> Cc: Michal Hocko <mhocko@kernel.org>
> Cc: Vlastimil Babka <vbabka@suse.cz>
> ---
>  mm/huge_memory.c | 3 +--
>  1 file changed, 1 insertion(+), 2 deletions(-)
>
> diff --git a/mm/huge_memory.c b/mm/huge_memory.c
> index 580098e115bd..b1e069e68189 100644
> --- a/mm/huge_memory.c
> +++ b/mm/huge_memory.c
> @@ -3060,8 +3060,7 @@ void set_pmd_migration_entry(struct page_vma_mapp=
ed_walk *pvmw,
>                 return;
>
>         flush_cache_range(vma, address, address + HPAGE_PMD_SIZE);
> -       pmdval =3D *pvmw->pmd;
> -       pmdp_invalidate(vma, address, pvmw->pmd);
> +       pmdval =3D pmdp_invalidate(vma, address, pvmw->pmd);
>         if (pmd_dirty(pmdval))
>                 set_page_dirty(page);
>         entry =3D make_migration_entry(page, pmd_write(pmdval));
> --
> 2.25.0

Looks good to me. Thanks.

Reviewed-by: Zi Yan <ziy@nvidia.com>


=E2=80=94
Best Regards,
Yan Zi

--=_MailMate_EFBAB02F-7B4D-42C6-BD8F-4DD342D56792_=
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQJDBAEBCgAtFiEEh7yFAW3gwjwQ4C9anbJR82th+ooFAl5OhzkPHHppeUBudmlk
aWEuY29tAAoJEJ2yUfNrYfqKjrYP+wRxjEtsawolB0Qpu1nGeCQaY62q6Ow0XfrE
86x1IysDD+KB1PFZskbi3Ju/uwWtnKXNDam1Uh1onWzCs6oBT1vuBuzUkHFRfRa1
B0ZEflHKkCX0Ns1s567TUNBL00uxFUVIcDazppXTozHyDnnAXyD0IeHlJIRasglj
XqZYwFs4QD1LBZsHd6RSzFqP5iOoWdYn4LzMlTWoJF3sxup9ARpthb89gfNlIgMU
xCuHeenQsDLVJtfq48qiK8yVyLTx0DMjCdbz2/VENOJmTvNEalY7F5V/4o/I3GMy
OTQnwu+oy74ovXA6ZFYsvHogqs/M2bzNAfF5UHP7HKNLkn1eMG0XL6q/HXymESoQ
w+yOVRrv+KoyQ8dB+7Vlw8ZXjUTh2LjjWhS2/AhIKkskDO7IiISU9rCFtR4x5twI
+hpmwnjmIIbJxEjcb9AsmAezW64n3ZMduf9SJsdIyumT7K5n3WTjf+1FQiN4TUMF
AjovWJdhIRiY3iPVuBw1khiCB1UO9H4ISWvRWhHEyMuAmht7De9fn9Mo6A5GGHrA
Y9yvHCqSAluoptFDaJwemUvO2WxIEAgoWxeQF5uhjNsUcBu2cnXd2Sm+fARJMZxF
Kabw8mVOu9+bn7LZGnh/QjwsK15lyC4WULedD8Wbhwe0CnOJ53uTCteeKS1daHtr
D5e/tIaV
=T38A
-----END PGP SIGNATURE-----

--=_MailMate_EFBAB02F-7B4D-42C6-BD8F-4DD342D56792_=--
