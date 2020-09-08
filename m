Return-Path: <SRS0=o+hd=CR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DE377C433E2
	for <linux-kernel@archiver.kernel.org>; Tue,  8 Sep 2020 19:55:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A325020768
	for <linux-kernel@archiver.kernel.org>; Tue,  8 Sep 2020 19:55:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=nvidia.com header.i=@nvidia.com header.b="HKgJp6LG"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731260AbgIHTzm (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 8 Sep 2020 15:55:42 -0400
Received: from hqnvemgate25.nvidia.com ([216.228.121.64]:2295 "EHLO
        hqnvemgate25.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730602AbgIHPhV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Sep 2020 11:37:21 -0400
Received: from hqpgpgate101.nvidia.com (Not Verified[216.228.121.13]) by hqnvemgate25.nvidia.com (using TLS: TLSv1.2, DES-CBC3-SHA)
        id <B5f57a4ea0003>; Tue, 08 Sep 2020 08:36:10 -0700
Received: from hqmail.nvidia.com ([172.20.161.6])
  by hqpgpgate101.nvidia.com (PGP Universal service);
  Tue, 08 Sep 2020 08:37:01 -0700
X-PGP-Universal: processed;
        by hqpgpgate101.nvidia.com on Tue, 08 Sep 2020 08:37:01 -0700
Received: from [10.2.173.224] (10.124.1.5) by HQMAIL107.nvidia.com
 (172.20.187.13) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Tue, 8 Sep
 2020 15:36:55 +0000
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
Date:   Tue, 8 Sep 2020 11:36:53 -0400
X-Mailer: MailMate (1.13.1r5705)
Message-ID: <DD3CCCDB-55CA-4981-AF3D-14853C8855C6@nvidia.com>
In-Reply-To: <32e979c4-68c0-f309-d9d7-d274724bd23e@redhat.com>
References: <20200902180628.4052244-1-zi.yan@sent.com>
 <20200903142300.bjq2um5y5nwocvar@box>
 <20200903163020.GG60440@carbon.dhcp.thefacebook.com>
 <8e677ead-206d-08dd-d73e-569bd3803e3b@redhat.com>
 <7E20392E-5ED7-4C22-9555-F3BAABF3CBE9@nvidia.com>
 <32e979c4-68c0-f309-d9d7-d274724bd23e@redhat.com>
MIME-Version: 1.0
X-Originating-IP: [10.124.1.5]
X-ClientProxiedBy: HQMAIL105.nvidia.com (172.20.187.12) To
 HQMAIL107.nvidia.com (172.20.187.13)
Content-Type: multipart/signed;
        boundary="=_MailMate_E36C6348-2757-495F-94C9-CA851200B62D_=";
        micalg=pgp-sha512; protocol="application/pgp-signature"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
        t=1599579370; bh=BY2Rg+OBHhwtMI2gUVd2Yb17wcPMtugiz/i1Civ9ofM=;
        h=X-PGP-Universal:From:To:CC:Subject:Date:X-Mailer:Message-ID:
         In-Reply-To:References:MIME-Version:X-Originating-IP:
         X-ClientProxiedBy:Content-Type;
        b=HKgJp6LGhRt7xFygnKcYbLEYJ7esAW77s9zrEqqsPxVvA5/p49LYYimBpU2aFG7gT
         qG8U/NiZwZPVkEPA5EWGcUSjmMFIe9gc6tFu8Bgn3Sxe2sQ+w5GGH4baZk+Ueitz4l
         nkVSA8fAD15v4m6NPf+b/1cn1nf0uQnh1xclPaYD7N4/hMaCfBR9GhD2QVwjb1hXOS
         U34vE0kgTLi2/hy6SaQRh03HtegYIGIB9NgYZeIv6LZ6NuJQCbyVvL2sZgI9DADuv2
         DOrNT8iOQvxNYB/HPBId1tJfebPXpYWvIGnuh5zGlb6QO/PhW/njZ7p8bZo7p8JY0r
         G2ji/zXBkh54Q==
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--=_MailMate_E36C6348-2757-495F-94C9-CA851200B62D_=
Content-Type: text/plain; charset="UTF-8"; markup=markdown
Content-Transfer-Encoding: quoted-printable

On 8 Sep 2020, at 10:22, David Hildenbrand wrote:

> On 08.09.20 16:05, Zi Yan wrote:
>> On 8 Sep 2020, at 7:57, David Hildenbrand wrote:
>>
>>> On 03.09.20 18:30, Roman Gushchin wrote:
>>>> On Thu, Sep 03, 2020 at 05:23:00PM +0300, Kirill A. Shutemov wrote:
>>>>> On Wed, Sep 02, 2020 at 02:06:12PM -0400, Zi Yan wrote:
>>>>>> From: Zi Yan <ziy@nvidia.com>
>>>>>>
>>>>>> Hi all,
>>>>>>
>>>>>> This patchset adds support for 1GB THP on x86_64. It is on top of
>>>>>> v5.9-rc2-mmots-2020-08-25-21-13.
>>>>>>
>>>>>> 1GB THP is more flexible for reducing translation overhead and inc=
reasing the
>>>>>> performance of applications with large memory footprint without ap=
plication
>>>>>> changes compared to hugetlb.
>>>>>
>>>>> This statement needs a lot of justification. I don't see 1GB THP as=
 viable
>>>>> for any workload. Opportunistic 1GB allocation is very questionable=

>>>>> strategy.
>>>>
>>>> Hello, Kirill!
>>>>
>>>> I share your skepticism about opportunistic 1 GB allocations, howeve=
r it might be useful
>>>> if backed by an madvise() annotations from userspace application. In=
 this case,
>>>> 1 GB THPs might be an alternative to 1 GB hugetlbfs pages, but with =
a more convenient
>>>> interface.
>>>
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
> Thanks for the information - I would have loved to see important
> information like that (esp. how to use) in the cover letter.
>
> So what you propose is (excluding alloc_contig_pages()) really just
> automatically using (previously reserved) 1GB huge pages as 1GB THP
> instead of explicitly using them in an application using hugetlbfs.
> Still, not convinced how helpful that actually is - most certainly you
> really want a mechanism to control this per application (+ maybe make
> the application indicate actual ranges where it makes sense - but then
> you can directly modify the application to use hugetlbfs).
>
> I guess the interesting thing of this approach is that we can
> mix-and-match THP of differing granularity within a single mapping -
> whereby a hugetlbfs allocation would fail in case there isn't sufficien=
t
> 1GB pages available. However, there are no guarantees for applications
> anymore (thinking about RT KVM and similar, we really want gigantic
> pages and cannot tolerate falling back to smaller granularity).

I agree that currently THP allocation does not provide a strong guarantee=

like hugetlbfs, which can pre-allocate pages at boot time. For users like=

RT KVM and such, pre-allocated hugetlb might be the only choice, since
allocating huge pages from CMA (either hugetlb or 1GB THP) would fail
if some pages are pinned and scattered in the CMA that could prevent
huge page allocation.

In other cases, if the user can tolerate fall backs but do not like the
unpredictable huge page formation outcome, we could add an madvise()
option like Michal suggested [1], so the user will know whether he gets
huge pages or not and can act accordingly.


> What are intended use cases/applications that could benefit? I doubt
> databases and virtualization are really a good fit - they know how to
> handle hugetlbfs just fine.

Romand and Jason have provided some use cases [2,3]

[1]https://lore.kernel.org/linux-mm/20200907072014.GD30144@dhcp22.suse.cz=
/
[2]https://lore.kernel.org/linux-mm/20200903162527.GF60440@carbon.dhcp.th=
efacebook.com/
[3]https://lore.kernel.org/linux-mm/20200903165051.GN24045@ziepe.ca/

=E2=80=94
Best Regards,
Yan Zi

--=_MailMate_E36C6348-2757-495F-94C9-CA851200B62D_=
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQJDBAEBCgAtFiEEh7yFAW3gwjwQ4C9anbJR82th+ooFAl9XpRUPHHppeUBudmlk
aWEuY29tAAoJEJ2yUfNrYfqK1uwQAJVBloJOguYF47OGb8jtp7mlxhCe/MZUQlB+
Gn+XYlnQyRoKWPROJc+hHShLKPnYQuNhXsGUwNDj98DOS++8soacHvKyz53sA/7T
0q9F8qlUrRgplmLNZsxJX5mtDikYRt5kZfbCLkVDdNpedO87qk09pGwsR5gi6Z9M
ujmgnMGcwQpxSR9Y631eBtqZ21QlgjCJH0+t+KELoYep+abuzvQ0baGOPmSU6++a
acLzrDFNHeTXv1zQ5dW2IVOrO4PPY/A+fHgktyCcS48iv+O6NcoGl8Sh2SfMkkMS
tzVdzlJFsUHGiLdD2BhexDJtL9qbdXL6jF0H6EjU63wQvEvpxLNio+piYyqJqQC6
R/QvrN1rAKn0TgdGHx7/q7ffKB3uMTnSTac7nH40MDY86/GpN7Xfdzk9/1bp44rr
8tqP0uYlDQbrMPplqumhI+lseY+niR6QIeTcUrmSE9xYwBtOMnCAt99CTpyGzRf5
Yo8N+dmxNv1z9jBSmkFdlXjcYwagkXULtNsLR1WwEu7t7uUMo/gfXEmABPwvrmL0
QzR3w5sl0upew4/HpKbZetSUWIyD8u96BOZG0Q7/MsP39teu9fMP3W0lbR2bRhNZ
bTIjf2Z/U+srI90Z9pX5SvCt7dp6SHbG77BVLU74atUIj7Fvjru61fFw0CacpfeE
mKHjjGVd
=pOHz
-----END PGP SIGNATURE-----

--=_MailMate_E36C6348-2757-495F-94C9-CA851200B62D_=--
