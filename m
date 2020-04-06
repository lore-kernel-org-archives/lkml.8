Return-Path: <SRS0=Zj89=5W=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1F520C2BA1E
	for <linux-kernel@archiver.kernel.org>; Mon,  6 Apr 2020 13:17:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D4B0E22C9E
	for <linux-kernel@archiver.kernel.org>; Mon,  6 Apr 2020 13:17:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=nvidia.com header.i=@nvidia.com header.b="ossNAa4B"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728426AbgDFNRo (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 6 Apr 2020 09:17:44 -0400
Received: from hqnvemgate24.nvidia.com ([216.228.121.143]:11593 "EHLO
        hqnvemgate24.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728176AbgDFNRn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Apr 2020 09:17:43 -0400
Received: from hqpgpgate101.nvidia.com (Not Verified[216.228.121.13]) by hqnvemgate24.nvidia.com (using TLS: TLSv1.2, DES-CBC3-SHA)
        id <B5e8b2b900000>; Mon, 06 Apr 2020 06:16:00 -0700
Received: from hqmail.nvidia.com ([172.20.161.6])
  by hqpgpgate101.nvidia.com (PGP Universal service);
  Mon, 06 Apr 2020 06:17:41 -0700
X-PGP-Universal: processed;
        by hqpgpgate101.nvidia.com on Mon, 06 Apr 2020 06:17:41 -0700
Received: from DRHQMAIL107.nvidia.com (10.27.9.16) by HQMAIL105.nvidia.com
 (172.20.187.12) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Mon, 6 Apr
 2020 13:17:41 +0000
Received: from [10.2.163.253] (172.20.13.39) by DRHQMAIL107.nvidia.com
 (10.27.9.16) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Mon, 6 Apr 2020
 13:17:39 +0000
From:   Zi Yan <ziy@nvidia.com>
To:     "Kirill A. Shutemov" <kirill@shutemov.name>
CC:     <akpm@linux-foundation.org>,
        Andrea Arcangeli <aarcange@redhat.com>,
        "Yang Shi" <yang.shi@linux.alibaba.com>, <linux-mm@kvack.org>,
        <linux-kernel@vger.kernel.org>,
        "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>
Subject: Re: [PATCHv2 8/8] khugepaged: Introduce 'max_ptes_shared' tunable
Date:   Mon, 6 Apr 2020 09:17:38 -0400
X-Mailer: MailMate (1.13.1r5680)
Message-ID: <8C523F05-00B4-40F5-BB07-EE4AACA86E26@nvidia.com>
In-Reply-To: <20200403112928.19742-9-kirill.shutemov@linux.intel.com>
References: <20200403112928.19742-1-kirill.shutemov@linux.intel.com>
 <20200403112928.19742-9-kirill.shutemov@linux.intel.com>
MIME-Version: 1.0
X-Originating-IP: [172.20.13.39]
X-ClientProxiedBy: HQMAIL107.nvidia.com (172.20.187.13) To
 DRHQMAIL107.nvidia.com (10.27.9.16)
Content-Type: multipart/signed;
        boundary="=_MailMate_3C84D458-72E9-49F2-86F8-DF884C3695D6_=";
        micalg=pgp-sha512; protocol="application/pgp-signature"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
        t=1586178960; bh=o7QQbEc+lcVWCXGD8rD0z686yhy4y+uZENc5OMrJ1PQ=;
        h=X-PGP-Universal:From:To:CC:Subject:Date:X-Mailer:Message-ID:
         In-Reply-To:References:MIME-Version:X-Originating-IP:
         X-ClientProxiedBy:Content-Type;
        b=ossNAa4BbhhggiH6Pt9mLF8KQKHM33Sb/r/p7AY5K4Gwz+I/Zho82hUwDk3Mm+/ED
         OLVViEVeTGvWbFHTx5kBAXoQdvBKNtcXOBYlh5KTO6nqiDdbkYaJcIsrGcRp55ENml
         0HTKZszb7I3ZTZI5W3/ttpE8SFcooIs2qT2OtsmBNm1Wv2Lx0TwiAVIfFr2MS05mNf
         63nWm0KWunpJjt1neLCau6bvjy8sY0EDkUK4w5Q5/3fy+DuVVwOCIjNdDn7N0W4OCn
         KvNzQtr1Jlo1vWrK4gl35MvU40svO9/ia6QgmWhKPYAeFww1bjjrQet2bf7J8QaRz5
         m/3+y6FkH4ytg==
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--=_MailMate_3C84D458-72E9-49F2-86F8-DF884C3695D6_=
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On 3 Apr 2020, at 7:29, Kirill A. Shutemov wrote:

> External email: Use caution opening links or attachments
>
>
> ``max_ptes_shared`` speicies how many pages can be shared across multip=
le

s/speicies/specifies

> processes. Exeeding the number woul block the collapse::

s/Exeeding/Exceeding

s/woul/would

>
>         /sys/kernel/mm/transparent_hugepage/khugepaged/max_ptes_shared
>
> A higher value may increase memory footprint for some workloads.
>
> By default, at least half of pages has to be not shared.
>
> Signed-off-by: Kirill A. Shutemov <kirill.shutemov@linux.intel.com>
> ---
>  Documentation/admin-guide/mm/transhuge.rst |  7 ++
>  include/trace/events/huge_memory.h         |  3 +-
>  mm/khugepaged.c                            | 52 ++++++++++++--
>  tools/testing/selftests/vm/khugepaged.c    | 83 ++++++++++++++++++++++=

>  4 files changed, 140 insertions(+), 5 deletions(-)
>
> diff --git a/Documentation/admin-guide/mm/transhuge.rst b/Documentation=
/admin-guide/mm/transhuge.rst
> index bd5714547cee..d16e4f2bb70f 100644
> --- a/Documentation/admin-guide/mm/transhuge.rst
> +++ b/Documentation/admin-guide/mm/transhuge.rst
> @@ -220,6 +220,13 @@ memory. A lower value can prevent THPs from being
>  collapsed, resulting fewer pages being collapsed into
>  THPs, and lower memory access performance.
>
> +``max_ptes_shared`` speicies how many pages can be shared across multi=
ple
> +processes. Exeeding the number woul block the collapse::

s/speicies/specifies

s/Exeeding/Exceeding

s/woul/would
> +
> +       /sys/kernel/mm/transparent_hugepage/khugepaged/max_ptes_shared
> +
> +A higher value may increase memory footprint for some workloads.
> +
>  Boot parameter
>  =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
>
> diff --git a/include/trace/events/huge_memory.h b/include/trace/events/=
huge_memory.h
> index d82a0f4e824d..53532f5925c3 100644
> --- a/include/trace/events/huge_memory.h
> +++ b/include/trace/events/huge_memory.h
> @@ -12,6 +12,8 @@
>         EM( SCAN_SUCCEED,               "succeeded")                   =
 \
>         EM( SCAN_PMD_NULL,              "pmd_null")                    =
 \
>         EM( SCAN_EXCEED_NONE_PTE,       "exceed_none_pte")             =
 \
> +       EM( SCAN_EXCEED_SWAP_PTE,       "exceed_swap_pte")             =
 \
> +       EM( SCAN_EXCEED_SHARED_PTE,     "exceed_shared_pte")           =
 \
>         EM( SCAN_PTE_NON_PRESENT,       "pte_non_present")             =
 \
>         EM( SCAN_PAGE_RO,               "no_writable_page")            =
 \
>         EM( SCAN_LACK_REFERENCED_PAGE,  "lack_referenced_page")        =
 \
> @@ -30,7 +32,6 @@
>         EM( SCAN_DEL_PAGE_LRU,          "could_not_delete_page_from_lru=
")\
>         EM( SCAN_ALLOC_HUGE_PAGE_FAIL,  "alloc_huge_page_failed")      =
 \
>         EM( SCAN_CGROUP_CHARGE_FAIL,    "ccgroup_charge_failed")       =
 \
> -       EM( SCAN_EXCEED_SWAP_PTE,       "exceed_swap_pte")             =
 \
>         EM( SCAN_TRUNCATED,             "truncated")                   =
 \
>         EMe(SCAN_PAGE_HAS_PRIVATE,      "page_has_private")            =
 \
>
> diff --git a/mm/khugepaged.c b/mm/khugepaged.c
> index 49e56e4e30d1..bfb6155f1d69 100644
> --- a/mm/khugepaged.c
> +++ b/mm/khugepaged.c
> @@ -28,6 +28,8 @@ enum scan_result {
>         SCAN_SUCCEED,
>         SCAN_PMD_NULL,
>         SCAN_EXCEED_NONE_PTE,
> +       SCAN_EXCEED_SWAP_PTE,
> +       SCAN_EXCEED_SHARED_PTE,
>         SCAN_PTE_NON_PRESENT,
>         SCAN_PAGE_RO,
>         SCAN_LACK_REFERENCED_PAGE,
> @@ -46,7 +48,6 @@ enum scan_result {
>         SCAN_DEL_PAGE_LRU,
>         SCAN_ALLOC_HUGE_PAGE_FAIL,
>         SCAN_CGROUP_CHARGE_FAIL,
> -       SCAN_EXCEED_SWAP_PTE,
>         SCAN_TRUNCATED,
>         SCAN_PAGE_HAS_PRIVATE,
>  };
> @@ -71,6 +72,7 @@ static DECLARE_WAIT_QUEUE_HEAD(khugepaged_wait);
>   */
>  static unsigned int khugepaged_max_ptes_none __read_mostly;
>  static unsigned int khugepaged_max_ptes_swap __read_mostly;
> +static unsigned int khugepaged_max_ptes_shared __read_mostly;
>
>  #define MM_SLOTS_HASH_BITS 10
>  static __read_mostly DEFINE_HASHTABLE(mm_slots_hash, MM_SLOTS_HASH_BIT=
S);
> @@ -290,15 +292,43 @@ static struct kobj_attribute khugepaged_max_ptes_=
swap_attr =3D
>         __ATTR(max_ptes_swap, 0644, khugepaged_max_ptes_swap_show,
>                khugepaged_max_ptes_swap_store);
>
> +static ssize_t khugepaged_max_ptes_shared_show(struct kobject *kobj,
> +                                            struct kobj_attribute *att=
r,
> +                                            char *buf)
> +{
> +       return sprintf(buf, "%u\n", khugepaged_max_ptes_shared);
> +}
> +
> +static ssize_t khugepaged_max_ptes_shared_store(struct kobject *kobj,
> +                                             struct kobj_attribute *at=
tr,
> +                                             const char *buf, size_t c=
ount)
> +{
> +       int err;
> +       unsigned long max_ptes_shared;
> +
> +       err  =3D kstrtoul(buf, 10, &max_ptes_shared);
> +       if (err || max_ptes_shared > HPAGE_PMD_NR-1)
> +               return -EINVAL;
> +
> +       khugepaged_max_ptes_shared =3D max_ptes_shared;
> +
> +       return count;
> +}
> +
> +static struct kobj_attribute khugepaged_max_ptes_shared_attr =3D
> +       __ATTR(max_ptes_shared, 0644, khugepaged_max_ptes_shared_show,
> +              khugepaged_max_ptes_shared_store);
> +
>  static struct attribute *khugepaged_attr[] =3D {
>         &khugepaged_defrag_attr.attr,
>         &khugepaged_max_ptes_none_attr.attr,
> +       &khugepaged_max_ptes_swap_attr.attr,
> +       &khugepaged_max_ptes_shared_attr.attr,
>         &pages_to_scan_attr.attr,
>         &pages_collapsed_attr.attr,
>         &full_scans_attr.attr,
>         &scan_sleep_millisecs_attr.attr,
>         &alloc_sleep_millisecs_attr.attr,
> -       &khugepaged_max_ptes_swap_attr.attr,
>         NULL,
>  };
>
> @@ -360,6 +390,7 @@ int __init khugepaged_init(void)
>         khugepaged_pages_to_scan =3D HPAGE_PMD_NR * 8;
>         khugepaged_max_ptes_none =3D HPAGE_PMD_NR - 1;
>         khugepaged_max_ptes_swap =3D HPAGE_PMD_NR / 8;
> +       khugepaged_max_ptes_shared =3D HPAGE_PMD_NR / 2;
>
>         return 0;
>  }
> @@ -549,7 +580,7 @@ static int __collapse_huge_page_isolate(struct vm_a=
rea_struct *vma,
>  {
>         struct page *page =3D NULL;
>         pte_t *_pte;
> -       int none_or_zero =3D 0, result =3D 0, referenced =3D 0;
> +       int none_or_zero =3D 0, shared =3D 0, result =3D 0, referenced =
=3D 0;
>         bool writable =3D false;
>
>         for (_pte =3D pte; _pte < pte+HPAGE_PMD_NR;
> @@ -577,6 +608,12 @@ static int __collapse_huge_page_isolate(struct vm_=
area_struct *vma,
>
>                 VM_BUG_ON_PAGE(!PageAnon(page), page);
>
> +               if (page_mapcount(page) > 1 &&
> +                               ++shared > khugepaged_max_ptes_shared) =
{
> +                       result =3D SCAN_EXCEED_SHARED_PTE;
> +                       goto out;
> +               }
> +
>                 if (PageCompound(page)) {
>                         struct page *p;
>                         page =3D compound_head(page);
> @@ -1168,7 +1205,8 @@ static int khugepaged_scan_pmd(struct mm_struct *=
mm,
>  {
>         pmd_t *pmd;
>         pte_t *pte, *_pte;
> -       int ret =3D 0, none_or_zero =3D 0, result =3D 0, referenced =3D=
 0;
> +       int ret =3D 0, result =3D 0, referenced =3D 0;
> +       int none_or_zero =3D 0, shared =3D 0;
>         struct page *page =3D NULL;
>         unsigned long _address;
>         spinlock_t *ptl;
> @@ -1218,6 +1256,12 @@ static int khugepaged_scan_pmd(struct mm_struct =
*mm,
>                         goto out_unmap;
>                 }
>
> +               if (page_mapcount(page) > 1 &&
> +                               ++shared > khugepaged_max_ptes_shared) =
{
> +                       result =3D SCAN_EXCEED_SHARED_PTE;
> +                       goto out_unmap;
> +               }
> +
>                 page =3D compound_head(page);
>
>                 /*
> diff --git a/tools/testing/selftests/vm/khugepaged.c b/tools/testing/se=
lftests/vm/khugepaged.c
> index 3eeff4a0fbc9..9ae119234a39 100644
> --- a/tools/testing/selftests/vm/khugepaged.c
> +++ b/tools/testing/selftests/vm/khugepaged.c
> @@ -77,6 +77,7 @@ struct khugepaged_settings {
>         unsigned int scan_sleep_millisecs;
>         unsigned int max_ptes_none;
>         unsigned int max_ptes_swap;
> +       unsigned int max_ptes_shared;
>         unsigned long pages_to_scan;
>  };
>
> @@ -276,6 +277,7 @@ static void write_settings(struct settings *setting=
s)
>                         khugepaged->scan_sleep_millisecs);
>         write_num("khugepaged/max_ptes_none", khugepaged->max_ptes_none=
);
>         write_num("khugepaged/max_ptes_swap", khugepaged->max_ptes_swap=
);
> +       write_num("khugepaged/max_ptes_shared", khugepaged->max_ptes_sh=
ared);
>         write_num("khugepaged/pages_to_scan", khugepaged->pages_to_scan=
);
>  }
>
> @@ -312,6 +314,7 @@ static void save_settings(void)
>                         read_num("khugepaged/scan_sleep_millisecs"),
>                 .max_ptes_none =3D read_num("khugepaged/max_ptes_none")=
,
>                 .max_ptes_swap =3D read_num("khugepaged/max_ptes_swap")=
,
> +               .max_ptes_shared =3D read_num("khugepaged/max_ptes_shar=
ed"),
>                 .pages_to_scan =3D read_num("khugepaged/pages_to_scan")=
,
>         };
>         success("OK");
> @@ -843,12 +846,90 @@ static void collapse_fork_compound(void)
>                         fail("Fail");
>                 fill_memory(p, 0, page_size);
>
> +               write_num("khugepaged/max_ptes_shared", hpage_pmd_nr - =
1);
>                 if (wait_for_scan("Collapse PTE table full of compound =
pages in child", p))
>                         fail("Timeout");
>                 else if (check_huge(p))
>                         success("OK");
>                 else
>                         fail("Fail");
> +               write_num("khugepaged/max_ptes_shared",
> +                               default_settings.khugepaged.max_ptes_sh=
ared);
> +
> +               validate_memory(p, 0, hpage_pmd_size);
> +               munmap(p, hpage_pmd_size);
> +               exit(exit_status);
> +       }
> +
> +       wait(&wstatus);
> +       exit_status +=3D WEXITSTATUS(wstatus);
> +
> +       printf("Check if parent still has huge page...");
> +       if (check_huge(p))
> +               success("OK");
> +       else
> +               fail("Fail");
> +       validate_memory(p, 0, hpage_pmd_size);
> +       munmap(p, hpage_pmd_size);
> +}
> +
> +static void collapse_max_ptes_shared()
> +{
> +       int max_ptes_shared =3D read_num("khugepaged/max_ptes_shared");=

> +       int wstatus;
> +       void *p;
> +
> +       p =3D alloc_mapping();
> +
> +       printf("Allocate huge page...");
> +       madvise(p, hpage_pmd_size, MADV_HUGEPAGE);
> +       fill_memory(p, 0, hpage_pmd_size);
> +       if (check_huge(p))
> +               success("OK");
> +       else
> +               fail("Fail");
> +
> +       printf("Share huge page over fork()...");
> +       if (!fork()) {
> +               /* Do not touch settings on child exit */
> +               skip_settings_restore =3D true;
> +               exit_status =3D 0;
> +
> +               if (check_huge(p))
> +                       success("OK");
> +               else
> +                       fail("Fail");
> +
> +               printf("Trigger CoW in %d of %d...",
> +                               hpage_pmd_nr - max_ptes_shared - 1, hpa=
ge_pmd_nr);
> +               fill_memory(p, 0, (hpage_pmd_nr - max_ptes_shared - 1) =
* page_size);
> +               if (!check_huge(p))
> +                       success("OK");
> +               else
> +                       fail("Fail");
> +
> +               if (wait_for_scan("Do not collapse with max_ptes_shared=
 exeeded", p))
> +                       fail("Timeout");
> +               else if (!check_huge(p))
> +                       success("OK");
> +               else
> +                       fail("Fail");
> +
> +               printf("Trigger CoW in %d of %d...",
> +                               hpage_pmd_nr - max_ptes_shared, hpage_p=
md_nr);
> +               fill_memory(p, 0, (hpage_pmd_nr - max_ptes_shared) * pa=
ge_size);
> +               if (!check_huge(p))
> +                       success("OK");
> +               else
> +                       fail("Fail");
> +
> +
> +               if (wait_for_scan("Collapse with max_ptes_shared PTEs s=
hared", p))
> +                       fail("Timeout");
> +               else if (check_huge(p))
> +                       success("OK");
> +               else
> +                       fail("Fail");
>
>                 validate_memory(p, 0, hpage_pmd_size);
>                 munmap(p, hpage_pmd_size);
> @@ -877,6 +958,7 @@ int main(void)
>
>         default_settings.khugepaged.max_ptes_none =3D hpage_pmd_nr - 1;=

>         default_settings.khugepaged.max_ptes_swap =3D hpage_pmd_nr / 8;=

> +       default_settings.khugepaged.max_ptes_shared =3D hpage_pmd_nr / =
2;
>         default_settings.khugepaged.pages_to_scan =3D hpage_pmd_nr * 8;=

>
>         save_settings();
> @@ -894,6 +976,7 @@ int main(void)
>         collapse_compound_extreme();
>         collapse_fork();
>         collapse_fork_compound();
> +       collapse_max_ptes_shared();
>
>         restore_settings(0);
>  }
> --
> 2.26.0


=E2=80=94
Best Regards,
Yan Zi

--=_MailMate_3C84D458-72E9-49F2-86F8-DF884C3695D6_=
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQJDBAEBCgAtFiEEh7yFAW3gwjwQ4C9anbJR82th+ooFAl6LK/IPHHppeUBudmlk
aWEuY29tAAoJEJ2yUfNrYfqKMMwQAJGMXMGsV2CSdb/zy+3CyUL148Wl8RpM62Fs
dGRr7L0elnPv7EYwbQV6Z6DL04FYOuUg1M/R+idDt5KaWz1+mlrGLpmMEKsvez+4
u/jLB41/jBHMSzeHjU/4wGWVbRAbTbVBIVXShQ1MVQlqncoabAB0qYepjQT5S87P
Z6ss6ERPkx9zAGJu8R0M0By1+cA+DwnUhJMV6WJXC7nLg8zKszMJRUfTlGR3otgL
v02elp05qbDyPCaMVxd7MNKFgupAg9XnG6nGR/wQUXyV39EH+gGFKyC67R3Xy/83
yMG3Am+bB0OhibgRX8NG7qxwBYzGSrqnfNt/JIf+ShohR8bHqU4fYXfBSHgC6qF+
cdJK658tO7inoxxWP8NlpE3f5lYSOI7ruEQ+r43UZ0Q1jaM/qDaR/Nn71vRc7dJp
kYjdkHbKTT4UsG0hHoQZGT5dUzTEy2W1ymwQDtxvrxC/rGgv2Oe+Bu/Y8N6OKzo8
lik+RtF/vN9GWpFybABAS7+RkT2U6lAoGUwFnmYqDV1L6iHNSlKRiAn9H1IkgUjd
Vxrr0e/EJtlDmsw9EZpRl9MCUHxlDM9fQleGdo+2IWnyU4FEESfX8bl+kbw/1j8+
eX8P+rdxPJ0LhihAh7MxOfZ8FZ6dNRYtoPO+soWIjbASMdqX2ResOQ7MIX9E0swW
ewHavedE
=ShM4
-----END PGP SIGNATURE-----

--=_MailMate_3C84D458-72E9-49F2-86F8-DF884C3695D6_=--
