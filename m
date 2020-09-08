Return-Path: <SRS0=o+hd=CR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 16508C43461
	for <linux-kernel@archiver.kernel.org>; Tue,  8 Sep 2020 19:50:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D338F207DE
	for <linux-kernel@archiver.kernel.org>; Tue,  8 Sep 2020 19:50:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=nvidia.com header.i=@nvidia.com header.b="IVSzWb0N"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732367AbgIHTu1 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 8 Sep 2020 15:50:27 -0400
Received: from hqnvemgate24.nvidia.com ([216.228.121.143]:17744 "EHLO
        hqnvemgate24.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730811AbgIHPur (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Sep 2020 11:50:47 -0400
Received: from hqpgpgate101.nvidia.com (Not Verified[216.228.121.13]) by hqnvemgate24.nvidia.com (using TLS: TLSv1.2, DES-CBC3-SHA)
        id <B5f57a7ad0000>; Tue, 08 Sep 2020 08:47:57 -0700
Received: from hqmail.nvidia.com ([172.20.161.6])
  by hqpgpgate101.nvidia.com (PGP Universal service);
  Tue, 08 Sep 2020 08:50:11 -0700
X-PGP-Universal: processed;
        by hqpgpgate101.nvidia.com on Tue, 08 Sep 2020 08:50:11 -0700
Received: from [10.2.173.224] (10.124.1.5) by HQMAIL107.nvidia.com
 (172.20.187.13) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Tue, 8 Sep
 2020 15:50:05 +0000
From:   Zi Yan <ziy@nvidia.com>
To:     Matthew Wilcox <willy@infradead.org>
CC:     David Hildenbrand <david@redhat.com>, Roman Gushchin <guro@fb.com>,
        "Kirill A. Shutemov" <kirill@shutemov.name>, <linux-mm@kvack.org>,
        "Rik van Riel" <riel@surriel.com>,
        "Kirill A . Shutemov" <kirill.shutemov@linux.intel.com>,
        Shakeel Butt <shakeelb@google.com>,
        "Yang Shi" <yang.shi@linux.alibaba.com>,
        David Nellans <dnellans@nvidia.com>,
        <linux-kernel@vger.kernel.org>
Subject: Re: [RFC PATCH 00/16] 1GB THP support on x86_64
Date:   Tue, 8 Sep 2020 11:50:03 -0400
X-Mailer: MailMate (1.13.1r5705)
Message-ID: <ED165EDF-0B06-4857-B92A-A9AD8B7B5603@nvidia.com>
In-Reply-To: <20200908142758.GF27537@casper.infradead.org>
References: <20200902180628.4052244-1-zi.yan@sent.com>
 <20200903142300.bjq2um5y5nwocvar@box>
 <20200903163020.GG60440@carbon.dhcp.thefacebook.com>
 <8e677ead-206d-08dd-d73e-569bd3803e3b@redhat.com>
 <7E20392E-5ED7-4C22-9555-F3BAABF3CBE9@nvidia.com>
 <20200908142758.GF27537@casper.infradead.org>
MIME-Version: 1.0
X-Originating-IP: [10.124.1.5]
X-ClientProxiedBy: HQMAIL105.nvidia.com (172.20.187.12) To
 HQMAIL107.nvidia.com (172.20.187.13)
Content-Type: multipart/signed;
        boundary="=_MailMate_E353A99C-21B4-44AC-A534-76899F22AA9E_=";
        micalg=pgp-sha512; protocol="application/pgp-signature"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
        t=1599580077; bh=5Y3AtZ5y0BxzRZh9nWpGpshKd2sNX9a56t17hma0SLg=;
        h=X-PGP-Universal:From:To:CC:Subject:Date:X-Mailer:Message-ID:
         In-Reply-To:References:MIME-Version:X-Originating-IP:
         X-ClientProxiedBy:Content-Type;
        b=IVSzWb0NwL9gV7u2Tmo0EYDh3vHPACAUsUeewRr3ApO22XiMMP6gTVsBFCbDGqe8f
         aeNYDRnY1ZGzpa9BA6HCVX+5jMTwjo3NWy0WGYVRHbLmWXGZcR4tPjvwnuHyRyu+Ee
         6by+7ENoXf2LrwsqtJnisW7eI9Ls0lI3spkby2EhyThQx4kfsXl5JKxluGgM3Y19I0
         UaXm1d61PPkQ8GygM9KD5sSiUDeHJVihT06wn3GyccafJM2y0o/58ZguEDitexQHrP
         4bWjAvP+a7Jw7WpPjPXmzzC/C0ADtwi6eEncbZ+vd4v/uRoUCEt4oWgdXBhbHBFeKH
         gAVopH2kxSOTA==
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--=_MailMate_E353A99C-21B4-44AC-A534-76899F22AA9E_=
Content-Type: text/plain; charset="UTF-8"; markup=markdown
Content-Transfer-Encoding: quoted-printable

On 8 Sep 2020, at 10:27, Matthew Wilcox wrote:

> On Tue, Sep 08, 2020 at 10:05:11AM -0400, Zi Yan wrote:
>> On 8 Sep 2020, at 7:57, David Hildenbrand wrote:
>>> I have concerns if we would silently use 1~GB THPs in most scenarios
>>> where be would have used 2~MB THP. I'd appreciate a trigger to
>>> explicitly enable that - MADV_HUGEPAGE is not sufficient because some=

>>> applications relying on that assume that the THP size will be 2~MB
>>> (especially, if you want sparse, large VMAs).
>>
>> This patchset is not intended to silently use 1GB THP in place of 2MB =
THP.
>> First of all, there is a knob /sys/kernel/mm/transparent_hugepage/enab=
le_1GB
>> to enable 1GB THP explicitly. Also, 1GB THP is allocated from a reserv=
ed CMA
>> region (although I had alloc_contig_pages as a fallback, which can be =
removed
>> in next version), so users need to add hugepage_cma=3DnG kernel parame=
ter to
>> enable 1GB THP allocation. If a finer control is necessary, we can add=

>> a new MADV_HUGEPAGE_1GB for 1GB THP.
>
> I think we do need that flag.  Machines don't run a single workload
> (arguably with VMs, we're getting closer to going back to the single
> workload per machine, but that's a different matter).  So if there's
> one app that wants 2MB pages and one that wants 1GB pages, we need to
> be able to distinguish them.
>
> I could also see there being an app which benefits from 1GB for
> one mapping and prefers 2GB for a different mapping, so I think the
> per-mapping madvise flag is best.
>
> I'm a little wary of encoding the size of an x86 PUD in the Linux API
> though.  Probably best to follow the example set in
> include/uapi/asm-generic/hugetlb_encode.h, but I don't love it.  I
> don't have a better suggestion though.

Using hugeltb_encode.h makes sense to me. I will add it in the next versi=
on.

Thanks for the suggestion.


=E2=80=94
Best Regards,
Yan Zi

--=_MailMate_E353A99C-21B4-44AC-A534-76899F22AA9E_=
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQJDBAEBCgAtFiEEh7yFAW3gwjwQ4C9anbJR82th+ooFAl9XqCsPHHppeUBudmlk
aWEuY29tAAoJEJ2yUfNrYfqK7ZgP/2b6pm1R2b/HxqJJOJrbv3Z/ALVfMhcIFUNb
kQZsSGuKjbg4UeJ9pcGdBl/3OwP7Dq7+o9WvvGmJZsRRLcu5Ha8tMzO8oLqC653z
PC+x+bj1S/ppbhbASW/qFfiqhOd53bCpwJPHFNq3DRtHtThPnVbWDKsD6KpD0tkb
qDQrX0clkqwaj/NpkKhyG+1wLV4Ak3jDKMjdnbBIySY66x3JlVdcYic+IB/UE5fz
+OvpdkSJ6pCU3VLc/ExQKwjfxALmPfe1ZpadHqyXKt6fXjWhL1Z7pGrv7+kLlrt9
XnCIZXKKOnhVz+5kIfqH+/KXDS3pdJuxUXg3F9um4p1JA1td7gsV0nKW2uP8ItB+
hwP1/GfoZDaS4dGfpI+nW75I6KmA2X19evmQXD26WEAweoMfa7E+jWgasyMgI5EK
wyLzD9FUXO5yWe5UMG6dK7VW0LuglxZe/14HD3Jlq6P113dJGTLKbfaqklj6OOca
WewVnIpSws9VODfQoykO30TdUvCkKzeFTZqHXFq4VRv4yr/M/T2opT4fUNwUdkSI
mzjEr8f7LSuyZXKYLVkIUoIz5SBfUdTO76LJGQLvBE+0ZZoF2LbwIhdtAEy+43tq
ABpvIqEIc0nX+7mRTZI4HN/qYFoBI+FMoe/uWmXFMc1Eq9rouODB+PpahTPYvJmm
MUFEYKGA
=MdJ0
-----END PGP SIGNATURE-----

--=_MailMate_E353A99C-21B4-44AC-A534-76899F22AA9E_=--
