Return-Path: <SRS0=6o4L=5Q=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 97C2BC43331
	for <linux-kernel@archiver.kernel.org>; Tue, 31 Mar 2020 12:24:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6028E207FF
	for <linux-kernel@archiver.kernel.org>; Tue, 31 Mar 2020 12:24:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=nvidia.com header.i=@nvidia.com header.b="UiGH3n97"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730789AbgCaMYM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 31 Mar 2020 08:24:12 -0400
Received: from hqnvemgate26.nvidia.com ([216.228.121.65]:6794 "EHLO
        hqnvemgate26.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730426AbgCaMYM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 31 Mar 2020 08:24:12 -0400
Received: from hqpgpgate102.nvidia.com (Not Verified[216.228.121.13]) by hqnvemgate26.nvidia.com (using TLS: TLSv1.2, DES-CBC3-SHA)
        id <B5e83365e0000>; Tue, 31 Mar 2020 05:23:58 -0700
Received: from hqmail.nvidia.com ([172.20.161.6])
  by hqpgpgate102.nvidia.com (PGP Universal service);
  Tue, 31 Mar 2020 05:24:11 -0700
X-PGP-Universal: processed;
        by hqpgpgate102.nvidia.com on Tue, 31 Mar 2020 05:24:11 -0700
Received: from [10.2.164.158] (10.124.1.5) by HQMAIL107.nvidia.com
 (172.20.187.13) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Tue, 31 Mar
 2020 12:24:10 +0000
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
Date:   Tue, 31 Mar 2020 08:24:07 -0400
X-Mailer: MailMate (1.13.1r5680)
Message-ID: <965DC015-7D6F-430D-8FB7-A24A814C13BE@nvidia.com>
In-Reply-To: <20200331085604.1260162-1-ying.huang@intel.com>
References: <20200331085604.1260162-1-ying.huang@intel.com>
MIME-Version: 1.0
X-Originating-IP: [10.124.1.5]
X-ClientProxiedBy: HQMAIL105.nvidia.com (172.20.187.12) To
 HQMAIL107.nvidia.com (172.20.187.13)
Content-Type: multipart/signed;
        boundary="=_MailMate_85308AA5-45D1-4C6D-BAF5-CE2631331002_=";
        micalg=pgp-sha512; protocol="application/pgp-signature"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
        t=1585657438; bh=PPwQyOFKi9zrHE/L9fEkuM+VhRZNrN9myCGw8wdnk1M=;
        h=X-PGP-Universal:From:To:CC:Subject:Date:X-Mailer:Message-ID:
         In-Reply-To:References:MIME-Version:X-Originating-IP:
         X-ClientProxiedBy:Content-Type;
        b=UiGH3n97LVz4V644+6Kze0an81ZfgYGVvB8/y1FZFFyoRJupFBxJXXdcvS13aaBh1
         Dt1INRKIvAyrz0XlETAt+Pp9GLLQz0OxctwbbzH5Zi7chyFNxfDzZ5G460MtO2pGnc
         a0WKLAmT4sne6m4vSTHAuTfxHBKjVcp8oQgNPDbGlbrqsAFDTICiuJIK1amPnA04oi
         OT589PTjeRB++ysC0/y4j/LpOQakl19CaNb8X3wU8vS4dbgquzlJIvFegiGVaXh+iV
         GvK+8skyeSom/WxFvaLZFb2EnN6b2AYAdflvZXF2XhexIEWVRba/nGk6VPRnmP8eQD
         UYeiI0jBR3JNQ==
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--=_MailMate_85308AA5-45D1-4C6D-BAF5-CE2631331002_=
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On 31 Mar 2020, at 4:56, Huang, Ying wrote:
>
> From: Huang Ying <ying.huang@intel.com>
>
> Now, when read /proc/PID/smaps, the PMD migration entry in page table i=
s simply
> ignored.  To improve the accuracy of /proc/PID/smaps, its parsing and p=
rocessing
> is added.
>
> Signed-off-by: "Huang, Ying" <ying.huang@intel.com>
> Cc: Andrea Arcangeli <aarcange@redhat.com>
> Cc: Kirill A. Shutemov <kirill.shutemov@linux.intel.com>
> Cc: Zi Yan <ziy@nvidia.com>
> Cc: Vlastimil Babka <vbabka@suse.cz>
> Cc: Alexey Dobriyan <adobriyan@gmail.com>
> Cc: Michal Hocko <mhocko@suse.com>
> Cc: Konstantin Khlebnikov <khlebnikov@yandex-team.ru>
> Cc: "J=C3=A9r=C3=B4me Glisse" <jglisse@redhat.com>
> Cc: Yang Shi <yang.shi@linux.alibaba.com>
> ---
>  fs/proc/task_mmu.c | 16 ++++++++++++----
>  1 file changed, 12 insertions(+), 4 deletions(-)
>
> diff --git a/fs/proc/task_mmu.c b/fs/proc/task_mmu.c
> index 8d382d4ec067..b5b3aef8cb3b 100644
> --- a/fs/proc/task_mmu.c
> +++ b/fs/proc/task_mmu.c
> @@ -548,8 +548,17 @@ static void smaps_pmd_entry(pmd_t *pmd, unsigned l=
ong addr,
>         bool locked =3D !!(vma->vm_flags & VM_LOCKED);
>         struct page *page;

Like Konstantin pointed out in another email, you could initialize page t=
o NULL here.
Plus you do not need the =E2=80=9Celse-return=E2=80=9D below, if you do t=
hat.

>
> -       /* FOLL_DUMP will return -EFAULT on huge zero page */
> -       page =3D follow_trans_huge_pmd(vma, addr, pmd, FOLL_DUMP);
> +       if (pmd_present(*pmd)) {
> +               /* FOLL_DUMP will return -EFAULT on huge zero page */
> +               page =3D follow_trans_huge_pmd(vma, addr, pmd, FOLL_DUM=
P);
> +       } else if (unlikely(is_swap_pmd(*pmd))) {

Should be:
          } else if (unlikely(thp_migration_support() && is_swap_pmd(*pmd=
))) {

Otherwise, when THP migration is disabled and the PMD is under splitting,=
 VM_BUG_ON
will be triggered.

> +               swp_entry_t entry =3D pmd_to_swp_entry(*pmd);
> +
> +               VM_BUG_ON(!is_migration_entry(entry));
> +               page =3D migration_entry_to_page(entry);
> +       } else {
> +               return;
> +       }
>         if (IS_ERR_OR_NULL(page))
>                 return;
>         if (PageAnon(page))
> @@ -578,8 +587,7 @@ static int smaps_pte_range(pmd_t *pmd, unsigned lon=
g addr, unsigned long end,
>
>         ptl =3D pmd_trans_huge_lock(pmd, vma);
>         if (ptl) {
> -               if (pmd_present(*pmd))
> -                       smaps_pmd_entry(pmd, addr, walk);
> +               smaps_pmd_entry(pmd, addr, walk);
>                 spin_unlock(ptl);
>                 goto out;
>         }
> --
> 2.25.0

Everything else looks good to me. Thanks.

With the fixes mentioned above, you can add
Reviewed-by: Zi Yan <ziy@nvidia.com>


=E2=80=94
Best Regards,
Yan Zi

--=_MailMate_85308AA5-45D1-4C6D-BAF5-CE2631331002_=
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQJDBAEBCgAtFiEEh7yFAW3gwjwQ4C9anbJR82th+ooFAl6DNmcPHHppeUBudmlk
aWEuY29tAAoJEJ2yUfNrYfqKl9QP/2Zw0UxaDo15swYxpIYtysk8aEMpW+Ha0A6T
IoiOuVxoGeSbxA3IjlRO4pR6xuamux1RfWpGYzJQwAnb2xccHhsgGUWlywT2ODWi
5Is4p87v6K7yQyNMFO23zZLiR7QZQ7wBbJo+zMOwqV3MNkSnNrRgUJGCY62tc5B1
agSYbuPn4gESFLcIGxNrpETmU6tDes+gABSB3PPX6855/Jg8dfD80jRzW4cjPNGJ
ktCAaAUfL1+8OjJwOPlZDif4ZHgEVwfeRj9jD7n0pFBblEW1s3Zj3+YkBwD/E0Uo
zpGegbYSB6jmuWt9tEBjb1Lp93NPjO2NBcecToJWMSZ+r5bazzKYrPM660Cz4rw2
zxIcUO1V5QEkFrqxW+hvT3bm/2aKlSKto1NQScgfblno9+t+NiKqeeCKqef1rRKA
LnOuTgLkXNsT6Dx2rU3Vf31HdWm9IK2ybvq4dg2SFh4dec84vAoZago2xhIe5FN8
ir8IjD+VFaT6/hReLEMmair1E/zqFfHWKXJZG5xsyCsbQEgxQccInGHAHBseMcU2
0sNkts9sMxSfR06B99MtUx80kWc1t7Qfahb5HEw0k1wJzS43D7si5d4I9RGPVPhI
PKoxZPWYFmmIUk0Ejts0qYmyjowr1lbFrZiO770yBHo51bxEhflJFEyGadV8s5Cw
+zrVWv6E
=Lk4+
-----END PGP SIGNATURE-----

--=_MailMate_85308AA5-45D1-4C6D-BAF5-CE2631331002_=--
