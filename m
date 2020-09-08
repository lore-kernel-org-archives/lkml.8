Return-Path: <SRS0=o+hd=CR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7E0DBC43461
	for <linux-kernel@archiver.kernel.org>; Tue,  8 Sep 2020 19:44:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3ECE4207DE
	for <linux-kernel@archiver.kernel.org>; Tue,  8 Sep 2020 19:44:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=nvidia.com header.i=@nvidia.com header.b="cz0Ywt8M"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731453AbgIHToF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 8 Sep 2020 15:44:05 -0400
Received: from hqnvemgate24.nvidia.com ([216.228.121.143]:17947 "EHLO
        hqnvemgate24.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730856AbgIHPvt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Sep 2020 11:51:49 -0400
Received: from hqpgpgate101.nvidia.com (Not Verified[216.228.121.13]) by hqnvemgate24.nvidia.com (using TLS: TLSv1.2, DES-CBC3-SHA)
        id <B5f578f180000>; Tue, 08 Sep 2020 07:03:04 -0700
Received: from hqmail.nvidia.com ([172.20.161.6])
  by hqpgpgate101.nvidia.com (PGP Universal service);
  Tue, 08 Sep 2020 07:05:18 -0700
X-PGP-Universal: processed;
        by hqpgpgate101.nvidia.com on Tue, 08 Sep 2020 07:05:18 -0700
Received: from [10.2.173.224] (10.124.1.5) by HQMAIL107.nvidia.com
 (172.20.187.13) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Tue, 8 Sep
 2020 14:05:13 +0000
From:   Zi Yan <ziy@nvidia.com>
To:     David Hildenbrand <david@redhat.com>
CC:     Roman Gushchin <guro@fb.com>,
        "Kirill A. Shutemov" <kirill@shutemov.name>, <linux-mm@kvack.org>,
        Rik van Riel <riel@surriel.com>,
        "Kirill A . Shutemov" <kirill.shutemov@linux.intel.com>,
        Matthew Wilcox <willy@infradead.org>,
        Shakeel Butt <shakeelb@google.com>,
        Yang Shi <yang.shi@linux.alibaba.com>,
        David Nellans <dnellans@nvidia.com>,
        <linux-kernel@vger.kernel.org>
Subject: Re: [RFC PATCH 00/16] 1GB THP support on x86_64
Date:   Tue, 8 Sep 2020 10:05:11 -0400
X-Mailer: MailMate (1.13.1r5705)
Message-ID: <7E20392E-5ED7-4C22-9555-F3BAABF3CBE9@nvidia.com>
In-Reply-To: <8e677ead-206d-08dd-d73e-569bd3803e3b@redhat.com>
References: <20200902180628.4052244-1-zi.yan@sent.com>
 <20200903142300.bjq2um5y5nwocvar@box>
 <20200903163020.GG60440@carbon.dhcp.thefacebook.com>
 <8e677ead-206d-08dd-d73e-569bd3803e3b@redhat.com>
MIME-Version: 1.0
X-Originating-IP: [10.124.1.5]
X-ClientProxiedBy: HQMAIL105.nvidia.com (172.20.187.12) To
 HQMAIL107.nvidia.com (172.20.187.13)
Content-Type: multipart/signed;
        boundary="=_MailMate_90CC73A7-32C1-445F-AAA5-E7CCB35F7A6C_=";
        micalg=pgp-sha512; protocol="application/pgp-signature"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
        t=1599573784; bh=sW9KId6qYj04nbAWRRDvrHLiEzlbizoIW4qM/PwXqwg=;
        h=X-PGP-Universal:From:To:CC:Subject:Date:X-Mailer:Message-ID:
         In-Reply-To:References:MIME-Version:X-Originating-IP:
         X-ClientProxiedBy:Content-Type;
        b=cz0Ywt8Mwv3cM4M2AvyHpYoNV+DHk7c0S4/gaIXD/jbjNb4yTxJEBxaVRamWmG7UO
         K3Ad6fiT7syZBbx1qonwx5UZ4kkRUhjDGMl9pKDKnMDWDIqSn0RUkHSVI6Hy/CC3xv
         639Ol2ZjAoJM8XpPddcpnDF+o0AzL1zVLXesaL5AJrntIMcKgqoPGSKuGJrcDlnEFj
         8DTi/BuUPdeCoRezYEg1m+6D6GtjJT5t1pue/mD7eu2E8RTXsbQCInapXLklElmMOi
         L3T2633QNom7mc3rqDm2dCOrjsNGUpERK5isP+WLOMbDyzaILAPBFFlGnqr9xF7SEl
         Vi0SDpXCEgJ1w==
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--=_MailMate_90CC73A7-32C1-445F-AAA5-E7CCB35F7A6C_=
Content-Type: text/plain; charset="UTF-8"; markup=markdown
Content-Transfer-Encoding: quoted-printable

On 8 Sep 2020, at 7:57, David Hildenbrand wrote:

> On 03.09.20 18:30, Roman Gushchin wrote:
>> On Thu, Sep 03, 2020 at 05:23:00PM +0300, Kirill A. Shutemov wrote:
>>> On Wed, Sep 02, 2020 at 02:06:12PM -0400, Zi Yan wrote:
>>>> From: Zi Yan <ziy@nvidia.com>
>>>>
>>>> Hi all,
>>>>
>>>> This patchset adds support for 1GB THP on x86_64. It is on top of
>>>> v5.9-rc2-mmots-2020-08-25-21-13.
>>>>
>>>> 1GB THP is more flexible for reducing translation overhead and incre=
asing the
>>>> performance of applications with large memory footprint without appl=
ication
>>>> changes compared to hugetlb.
>>>
>>> This statement needs a lot of justification. I don't see 1GB THP as v=
iable
>>> for any workload. Opportunistic 1GB allocation is very questionable
>>> strategy.
>>
>> Hello, Kirill!
>>
>> I share your skepticism about opportunistic 1 GB allocations, however =
it might be useful
>> if backed by an madvise() annotations from userspace application. In t=
his case,
>> 1 GB THPs might be an alternative to 1 GB hugetlbfs pages, but with a =
more convenient
>> interface.
>
> I have concerns if we would silently use 1~GB THPs in most scenarios
> where be would have used 2~MB THP. I'd appreciate a trigger to
> explicitly enable that - MADV_HUGEPAGE is not sufficient because some
> applications relying on that assume that the THP size will be 2~MB
> (especially, if you want sparse, large VMAs).

This patchset is not intended to silently use 1GB THP in place of 2MB THP=
=2E
First of all, there is a knob /sys/kernel/mm/transparent_hugepage/enable_=
1GB
to enable 1GB THP explicitly. Also, 1GB THP is allocated from a reserved =
CMA
region (although I had alloc_contig_pages as a fallback, which can be rem=
oved
in next version), so users need to add hugepage_cma=3DnG kernel parameter=
 to
enable 1GB THP allocation. If a finer control is necessary, we can add
a new MADV_HUGEPAGE_1GB for 1GB THP.


=E2=80=94
Best Regards,
Yan Zi

--=_MailMate_90CC73A7-32C1-445F-AAA5-E7CCB35F7A6C_=
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQJDBAEBCgAtFiEEh7yFAW3gwjwQ4C9anbJR82th+ooFAl9Xj5cPHHppeUBudmlk
aWEuY29tAAoJEJ2yUfNrYfqKiFgP/2j/lRwfL410/Fcmx92+Cm4VFsGln6IyW0bn
yBSO/B6CqjIZBcxLkbUHy1mfCAAT+y+p2JLyNyCF7AY00yVTiyQdtPtbuA61vAWB
SZQkKEA1iOCN758VrDxsjF724WyWvnfPR5eGAAiYKvAaU/j8/nhE/UgRVq8JyCHn
KtK/1D9V2ud+XnT05HZusqmhG0o/1ejsJjMVoxWOuNfrf4ZjDZC325s/WRBbKhLc
4lNElDUvOndvG+yy+f0DbNzYFSeU47y4N8y+WIhUyeNUBL3zpPuY74eoZ1awl4mN
a4DDL8aU1GWgeuNTTQzxzMJd90mvJns2GRf1btNKlzWZYCj8LrZGXZ6aonp14TIh
3RfkOKkz9k2OQkm7j3HpSg/pp6T+IcEVuid296hQcumaeRCQSCS8IhERve2WxBeB
tgVMfwXLkaMuENmXLgMTtUjvOJSvJvvZTovc2KJibyOXWTBqCpX5l5p0YElw2ZK3
GrTZMEaIvtJ3BksM2aLfLygMQfgFUMm+e2qtxRKQFD/TEZI/cwNK6aSL46qey0OU
VFGXvnRCvzMS9gggT0yTTcVkbfNgRzrk5J3Jj6wPqckpgpHiciZTrs1Z/dj3gn73
mNpwfpD2qdLiZpLEubiuPX0p/ixSsZzWXA1ByyWyLBNS9bv3bmOt15HarDD9+Pga
xzn2iS/U
=5FkR
-----END PGP SIGNATURE-----

--=_MailMate_90CC73A7-32C1-445F-AAA5-E7CCB35F7A6C_=--
