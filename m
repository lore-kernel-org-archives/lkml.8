Return-Path: <SRS0=8dav=5Y=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 64A63C2BA1A
	for <linux-kernel@archiver.kernel.org>; Wed,  8 Apr 2020 15:54:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 268482082F
	for <linux-kernel@archiver.kernel.org>; Wed,  8 Apr 2020 15:54:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=nvidia.com header.i=@nvidia.com header.b="FocfoG9/"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729820AbgDHPx7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 8 Apr 2020 11:53:59 -0400
Received: from hqnvemgate24.nvidia.com ([216.228.121.143]:16286 "EHLO
        hqnvemgate24.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729726AbgDHPx6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Apr 2020 11:53:58 -0400
Received: from hqpgpgate101.nvidia.com (Not Verified[216.228.121.13]) by hqnvemgate24.nvidia.com (using TLS: TLSv1.2, DES-CBC3-SHA)
        id <B5e8df32c0000>; Wed, 08 Apr 2020 08:52:12 -0700
Received: from hqmail.nvidia.com ([172.20.161.6])
  by hqpgpgate101.nvidia.com (PGP Universal service);
  Wed, 08 Apr 2020 08:53:55 -0700
X-PGP-Universal: processed;
        by hqpgpgate101.nvidia.com on Wed, 08 Apr 2020 08:53:55 -0700
Received: from DRHQMAIL107.nvidia.com (10.27.9.16) by HQMAIL111.nvidia.com
 (172.20.187.18) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Wed, 8 Apr
 2020 15:53:55 +0000
Received: from [10.2.163.253] (10.124.1.5) by DRHQMAIL107.nvidia.com
 (10.27.9.16) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Wed, 8 Apr 2020
 15:53:54 +0000
From:   Zi Yan <ziy@nvidia.com>
To:     "Kirill A. Shutemov" <kirill@shutemov.name>
CC:     <akpm@linux-foundation.org>,
        Andrea Arcangeli <aarcange@redhat.com>,
        "Yang Shi" <yang.shi@linux.alibaba.com>, <linux-mm@kvack.org>,
        <linux-kernel@vger.kernel.org>,
        "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>
Subject: Re: [PATCHv2 1/8] khugepaged: Add self test
Date:   Wed, 8 Apr 2020 11:53:52 -0400
X-Mailer: MailMate (1.13.1r5680)
Message-ID: <C66E1309-2069-495B-BACD-7F3282C6EC7D@nvidia.com>
In-Reply-To: <20200408142145.workbzv2n3p27y2w@box>
References: <20200403112928.19742-1-kirill.shutemov@linux.intel.com>
 <20200403112928.19742-2-kirill.shutemov@linux.intel.com>
 <D55D6A3A-47A1-41F5-B939-36EEA740CF72@nvidia.com>
 <20200406152035.ga7hk6jfaqzvlete@box>
 <A8449566-7C9E-464E-92AC-46FDBCDC04AA@nvidia.com>
 <20200408142145.workbzv2n3p27y2w@box>
MIME-Version: 1.0
X-Originating-IP: [10.124.1.5]
X-ClientProxiedBy: HQMAIL101.nvidia.com (172.20.187.10) To
 DRHQMAIL107.nvidia.com (10.27.9.16)
Content-Type: multipart/signed;
        boundary="=_MailMate_7445A6F5-F832-49BC-B34B-07A4A5E1838D_=";
        micalg=pgp-sha512; protocol="application/pgp-signature"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
        t=1586361132; bh=TCStPalWjSQoRuolLsZo2ehRDgpmTmGVtR/rVYFmq4I=;
        h=X-PGP-Universal:From:To:CC:Subject:Date:X-Mailer:Message-ID:
         In-Reply-To:References:MIME-Version:X-Originating-IP:
         X-ClientProxiedBy:Content-Type;
        b=FocfoG9/Uye325XRg3pFiRrNaR/lkoi6qMsXI+/QV77nWDxqvGeNxMbjvGVN+GtII
         W4cR5t/8iapAmVRcbT/vq+j8e4fO/tFStyKWWIuNdpAd3aiOupu6TjDnMDSIyn4aN8
         SuE8fePiqQ9bnUsuEjopDy3ar1YkIG8Nr184FudQ1hjXHv3F//4GWRB24yOVDDLcaW
         cCi4S6o+tUpLPPQhAADjESff5Inpd7uGXe281XhzIJSFkK7KHz82MmRJSznpGVWrNI
         U9GKoH0KxI/LKpDwjhBVwLFJRmn9DdIjSysEsyf6QFIakBp+uz9Sxq5OIfh9W3XMrY
         OkzZBDCffdshg==
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--=_MailMate_7445A6F5-F832-49BC-B34B-07A4A5E1838D_=
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On 8 Apr 2020, at 10:21, Kirill A. Shutemov wrote:

> External email: Use caution opening links or attachments
>
>
> On Mon, Apr 06, 2020 at 02:50:32PM -0400, Zi Yan wrote:
>>       khugepaged-58    [001] ....  9913.990380: mm_khugepaged_scan_pmd=
: mm=3D00000000283d31fc, scan_pfn=3D0x2ae4bd, writable=3D0, referenced=3D=
512, none_or_zero=3D0, status=3Dno_writable_page, unmapped=3D0
>
> Looks like all failures due to lack of writable ptes. That's very stran=
ge
> because we write to the page on fill.
>
> You've mentioned that you run it in VM. I wounder if it can be a
> virtualizaiton artefact. I run tests under KVM and they are fine. What =
is
> your virtualization setup?

My qemu cmd: =E2=80=9Cqemu-system-x86_64 -kernel ~/repos/linux/arch/x86/b=
oot/bzImage -hda ~/qemu-image/vm.qcow2 -append "root=3D/dev/sda1 rw conso=
le=3DttyS0" -pidfile vm.pid -net user,hostfwd=3Dtcp::11022-:22 -net nic -=
numa node,nodeid=3D0 -numa node,nodeid=3D1 -m 20g -smp 8 -cpu host -enabl=
e-kvm -nographic=E2=80=9D

QEMU version is 4.2.0 (Debian 1:4.2-3)

The patches are applied on top of commit a10c9c710f9ecea87b9f4bbb83746789=
3b4bef01 from Linus=E2=80=99s tree.


In addition, I tested it again on a bare metal, then all tests passed exc=
ept =E2=80=9CCollapse with max_ptes_swap pages swapped out=E2=80=9D, whic=
h failed most of time but succeeded occasionally.

When it fails, the tracing info is (seems like the same PTE not writable =
issue):

# sudo ./trace.sh
Save THP and khugepaged settings... OK
Adjust settings... OK
Swapout 64 of 512 pages... OK
Collapse with max_ptes_swap pages swapped out.... Fail
Restore THP and khugepaged settings... OK
# tracer: nop
#
# entries-in-buffer/entries-written: 42/42   #P:48
#
#                              _-----=3D> irqs-off
#                             / _----=3D> need-resched
#                            | / _---=3D> hardirq/softirq
#                            || / _--=3D> preempt-depth
#                            ||| /     delay
#           TASK-PID   CPU#  ||||    TIMESTAMP  FUNCTION
#              | |       |   ||||       |         |
      khugepaged-265   [002] ...1  1007.308366: mm_collapse_huge_page_swa=
pin: mm=3D000000007c6cc479, swapped_in=3D64, referenced=3D448, ret=3D1
      khugepaged-265   [002] ...2  1007.308403: mm_collapse_huge_page_iso=
late: scan_pfn=3D0x1faa6ee, none_or_zero=3D0, referenced=3D60, writable=3D=
0, status=3Dnot_suitable_page_count
      khugepaged-265   [002] ...1  1007.308404: mm_collapse_huge_page: mm=
=3D000000007c6cc479, isolated=3D0, status=3Dfailed
      khugepaged-265   [002] ...1  1007.308405: mm_khugepaged_scan_pmd: m=
m=3D000000007c6cc479, scan_pfn=3D0x1fafa45, writable=3D1, referenced=3D44=
8, none_or_zero=3D0, status=3Dsucceeded, unmapped=3D64
      khugepaged-265   [002] ...1  1007.328249: mm_khugepaged_scan_pmd: m=
m=3D000000007c6cc479, scan_pfn=3D0x1faa6ee, writable=3D0, referenced=3D60=
, none_or_zero=3D0, status=3Dnot_suitable_page_count, unmapped=3D0
      khugepaged-265   [002] ...1  1007.344263: mm_khugepaged_scan_pmd: m=
m=3D000000007c6cc479, scan_pfn=3D0x1faa6ee, writable=3D0, referenced=3D60=
, none_or_zero=3D0, status=3Dnot_suitable_page_count, unmapped=3D0
      khugepaged-265   [002] ...1  1007.360263: mm_khugepaged_scan_pmd: m=
m=3D000000007c6cc479, scan_pfn=3D0x1faa6ee, writable=3D0, referenced=3D60=
, none_or_zero=3D0, status=3Dnot_suitable_page_count, unmapped=3D0
      khugepaged-265   [002] ...1  1007.376241: mm_khugepaged_scan_pmd: m=
m=3D000000007c6cc479, scan_pfn=3D0x1faa6ee, writable=3D0, referenced=3D60=
, none_or_zero=3D0, status=3Dnot_suitable_page_count, unmapped=3D0
      khugepaged-265   [002] ...1  1007.392237: mm_khugepaged_scan_pmd: m=
m=3D000000007c6cc479, scan_pfn=3D0x1faa6ee, writable=3D0, referenced=3D60=
, none_or_zero=3D0, status=3Dnot_suitable_page_count, unmapped=3D0
      khugepaged-265   [002] ...1  1007.408284: mm_khugepaged_scan_pmd: m=
m=3D000000007c6cc479, scan_pfn=3D0x1faa6ee, writable=3D0, referenced=3D60=
, none_or_zero=3D0, status=3Dnot_suitable_page_count, unmapped=3D0
      khugepaged-265   [002] ...1  1007.424302: mm_khugepaged_scan_pmd: m=
m=3D000000007c6cc479, scan_pfn=3D0x1faa6ee, writable=3D0, referenced=3D60=
, none_or_zero=3D0, status=3Dnot_suitable_page_count, unmapped=3D0
      khugepaged-265   [002] ...1  1007.440284: mm_khugepaged_scan_pmd: m=
m=3D000000007c6cc479, scan_pfn=3D0x1faa6ee, writable=3D0, referenced=3D60=
, none_or_zero=3D0, status=3Dnot_suitable_page_count, unmapped=3D0
      khugepaged-265   [002] ...1  1007.456285: mm_khugepaged_scan_pmd: m=
m=3D000000007c6cc479, scan_pfn=3D0x1faa6ee, writable=3D0, referenced=3D60=
, none_or_zero=3D0, status=3Dnot_suitable_page_count, unmapped=3D0
      khugepaged-265   [002] ...1  1007.472280: mm_khugepaged_scan_pmd: m=
m=3D000000007c6cc479, scan_pfn=3D0x1faa6ee, writable=3D0, referenced=3D60=
, none_or_zero=3D0, status=3Dnot_suitable_page_count, unmapped=3D0
      khugepaged-265   [002] ...1  1007.488282: mm_khugepaged_scan_pmd: m=
m=3D000000007c6cc479, scan_pfn=3D0x1faa6ee, writable=3D0, referenced=3D60=
, none_or_zero=3D0, status=3Dnot_suitable_page_count, unmapped=3D0
      khugepaged-265   [002] ...1  1007.504264: mm_khugepaged_scan_pmd: m=
m=3D000000007c6cc479, scan_pfn=3D0x1faa6ee, writable=3D0, referenced=3D60=
, none_or_zero=3D0, status=3Dnot_suitable_page_count, unmapped=3D0
      khugepaged-265   [002] ...1  1007.520293: mm_khugepaged_scan_pmd: m=
m=3D000000007c6cc479, scan_pfn=3D0x1faa6ee, writable=3D0, referenced=3D60=
, none_or_zero=3D0, status=3Dnot_suitable_page_count, unmapped=3D0
      khugepaged-265   [002] ...1  1007.536282: mm_khugepaged_scan_pmd: m=
m=3D000000007c6cc479, scan_pfn=3D0x1faa6ee, writable=3D0, referenced=3D60=
, none_or_zero=3D0, status=3Dnot_suitable_page_count, unmapped=3D0
      khugepaged-265   [002] ...1  1007.552278: mm_khugepaged_scan_pmd: m=
m=3D000000007c6cc479, scan_pfn=3D0x1faa6ee, writable=3D0, referenced=3D60=
, none_or_zero=3D0, status=3Dnot_suitable_page_count, unmapped=3D0
      khugepaged-265   [002] ...1  1007.568302: mm_khugepaged_scan_pmd: m=
m=3D000000007c6cc479, scan_pfn=3D0x1faa6ee, writable=3D0, referenced=3D60=
, none_or_zero=3D0, status=3Dnot_suitable_page_count, unmapped=3D0
      khugepaged-265   [002] ...1  1007.584290: mm_khugepaged_scan_pmd: m=
m=3D000000007c6cc479, scan_pfn=3D0x1faa6ee, writable=3D0, referenced=3D60=
, none_or_zero=3D0, status=3Dnot_suitable_page_count, unmapped=3D0
      khugepaged-265   [002] ...1  1007.600300: mm_khugepaged_scan_pmd: m=
m=3D000000007c6cc479, scan_pfn=3D0x1faa6ee, writable=3D0, referenced=3D60=
, none_or_zero=3D0, status=3Dnot_suitable_page_count, unmapped=3D0
      khugepaged-265   [002] ...1  1007.616292: mm_khugepaged_scan_pmd: m=
m=3D000000007c6cc479, scan_pfn=3D0x1faa6ee, writable=3D0, referenced=3D60=
, none_or_zero=3D0, status=3Dnot_suitable_page_count, unmapped=3D0
      khugepaged-265   [002] ...1  1007.632290: mm_khugepaged_scan_pmd: m=
m=3D000000007c6cc479, scan_pfn=3D0x1faa6ee, writable=3D0, referenced=3D60=
, none_or_zero=3D0, status=3Dnot_suitable_page_count, unmapped=3D0
      khugepaged-265   [002] ...1  1007.648304: mm_khugepaged_scan_pmd: m=
m=3D000000007c6cc479, scan_pfn=3D0x1faa6ee, writable=3D0, referenced=3D60=
, none_or_zero=3D0, status=3Dnot_suitable_page_count, unmapped=3D0
      khugepaged-265   [002] ...1  1007.664305: mm_khugepaged_scan_pmd: m=
m=3D000000007c6cc479, scan_pfn=3D0x1faa6ee, writable=3D0, referenced=3D60=
, none_or_zero=3D0, status=3Dnot_suitable_page_count, unmapped=3D0
      khugepaged-265   [002] ...1  1007.680289: mm_khugepaged_scan_pmd: m=
m=3D000000007c6cc479, scan_pfn=3D0x1faa6ee, writable=3D0, referenced=3D60=
, none_or_zero=3D0, status=3Dnot_suitable_page_count, unmapped=3D0
      khugepaged-265   [002] ...1  1007.696294: mm_khugepaged_scan_pmd: m=
m=3D000000007c6cc479, scan_pfn=3D0x1faa6ee, writable=3D0, referenced=3D60=
, none_or_zero=3D0, status=3Dnot_suitable_page_count, unmapped=3D0
      khugepaged-265   [002] ...1  1007.712294: mm_khugepaged_scan_pmd: m=
m=3D000000007c6cc479, scan_pfn=3D0x1faa6ee, writable=3D0, referenced=3D60=
, none_or_zero=3D0, status=3Dnot_suitable_page_count, unmapped=3D0
      khugepaged-265   [002] ...1  1007.728309: mm_khugepaged_scan_pmd: m=
m=3D000000007c6cc479, scan_pfn=3D0x1faa6ee, writable=3D0, referenced=3D60=
, none_or_zero=3D0, status=3Dnot_suitable_page_count, unmapped=3D0
      khugepaged-265   [002] ...1  1007.744291: mm_khugepaged_scan_pmd: m=
m=3D000000007c6cc479, scan_pfn=3D0x1faa6ee, writable=3D0, referenced=3D60=
, none_or_zero=3D0, status=3Dnot_suitable_page_count, unmapped=3D0
      khugepaged-265   [002] ...1  1007.760288: mm_khugepaged_scan_pmd: m=
m=3D000000007c6cc479, scan_pfn=3D0x1faa6ee, writable=3D0, referenced=3D60=
, none_or_zero=3D0, status=3Dnot_suitable_page_count, unmapped=3D0
      khugepaged-265   [002] ...1  1007.776312: mm_khugepaged_scan_pmd: m=
m=3D000000007c6cc479, scan_pfn=3D0x1faa6ee, writable=3D0, referenced=3D60=
, none_or_zero=3D0, status=3Dnot_suitable_page_count, unmapped=3D0
      khugepaged-265   [002] ...1  1007.792288: mm_khugepaged_scan_pmd: m=
m=3D000000007c6cc479, scan_pfn=3D0x1faa6ee, writable=3D0, referenced=3D60=
, none_or_zero=3D0, status=3Dnot_suitable_page_count, unmapped=3D0
      khugepaged-265   [002] ...1  1007.811482: mm_khugepaged_scan_pmd: m=
m=3D000000006aaca29d, scan_pfn=3D0xffffffffffffffff, writable=3D0, refere=
nced=3D0, none_or_zero=3D0, status=3Dpmd_null, unmapped=3D0
      khugepaged-265   [002] ...1  1007.811482: mm_khugepaged_scan_pmd: m=
m=3D000000006aaca29d, scan_pfn=3D0xffffffffffffffff, writable=3D0, refere=
nced=3D0, none_or_zero=3D0, status=3Dpmd_null, unmapped=3D0
      khugepaged-265   [002] ...1  1007.811483: mm_khugepaged_scan_pmd: m=
m=3D000000006aaca29d, scan_pfn=3D0xffffffffffffffff, writable=3D0, refere=
nced=3D0, none_or_zero=3D0, status=3Dpmd_null, unmapped=3D0
      khugepaged-265   [002] ...1  1007.811483: mm_khugepaged_scan_pmd: m=
m=3D000000006aaca29d, scan_pfn=3D0xffffffffffffffff, writable=3D0, refere=
nced=3D0, none_or_zero=3D0, status=3Dpmd_null, unmapped=3D0
      khugepaged-265   [002] ...1  1007.811483: mm_khugepaged_scan_pmd: m=
m=3D000000006aaca29d, scan_pfn=3D0xffffffffffffffff, writable=3D0, refere=
nced=3D0, none_or_zero=3D0, status=3Dpmd_null, unmapped=3D0
      khugepaged-265   [002] ...1  1007.811484: mm_khugepaged_scan_pmd: m=
m=3D000000006aaca29d, scan_pfn=3D0xffffffffffffffff, writable=3D0, refere=
nced=3D0, none_or_zero=3D0, status=3Dpmd_null, unmapped=3D0
      khugepaged-265   [002] ...1  1007.811502: mm_khugepaged_scan_pmd: m=
m=3D000000005268d9a7, scan_pfn=3D0xffffffffffffffff, writable=3D0, refere=
nced=3D0, none_or_zero=3D0, status=3Dpmd_null, unmapped=3D0
      khugepaged-265   [002] ...1  1007.811502: mm_khugepaged_scan_pmd: m=
m=3D000000005268d9a7, scan_pfn=3D0xffffffffffffffff, writable=3D0, refere=
nced=3D0, none_or_zero=3D0, status=3Dpmd_null, unmapped=3D0


=E2=80=94
Best Regards,
Yan Zi

--=_MailMate_7445A6F5-F832-49BC-B34B-07A4A5E1838D_=
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQJDBAEBCgAtFiEEh7yFAW3gwjwQ4C9anbJR82th+ooFAl6N85APHHppeUBudmlk
aWEuY29tAAoJEJ2yUfNrYfqK0FQP/3NjGS2l6/7iVsG1XQ2EQK+Iw4F6976IsY8J
WzoxVKseKDDbZq4EdBKrsGeHrNzcQNKxyrQr3J4YwkeRbcOR2zGJf37aB7dMTwBV
lpt5R1R4gPVjJQPO1fa3J8k+dGx/KEWZL85+YTyL9u9EvJOxeDgxC7dRHSXawnqA
SBIHzgyOg7VvRKkTQXvSbRLXuBZi3mer0r0zASDWQ8dxkwDpdf45Num+EEGqimqp
whs+1b5jYEN+c6nTMsnm810FAbqJ0PSPa8QJYvbHWk+PWk6d13PBhSP+OgUNgUzO
GLQdW/T2DuI+YP/6l+Z9owYN17gYdhoLBQUlylPrm7tcmUOgV/zv4bwRWqPvz08l
7dPgREU4EujQpCPyqt4roXnzx2cqOqZX+9vI/KWRj5qnmo4oMSXVWkg2KsCUffM0
JbbjlYlWShXmULUnTyyTU38jApaqze3Y+BVJ6nLKveV3hUQf3SdX4zQYHtb8N4lw
V6cCG7ieI63vYZQK+5UcQn5tUVvyKs+fEbGG2/t0XrX7rWKFl8CQL7tz26VN7rrs
UCAxCPJXlq8oqUfQV9DLnO1jnfTWgsIa/Ni+FMepUc+hMkrGS8zakby9DV9erI+t
1Z+tVGISIXYiNZubB3IVl5rbPcT3/gYZBgHJJEpgAkRcSub0VxHe/TNigPfyBkMG
OZSsnFxj
=cqiF
-----END PGP SIGNATURE-----

--=_MailMate_7445A6F5-F832-49BC-B34B-07A4A5E1838D_=--
