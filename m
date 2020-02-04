Return-Path: <SRS0=t9Lj=3Y=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 38445C3524D
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Feb 2020 08:40:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EE83921744
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Feb 2020 08:40:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="XslDsL/W"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726596AbgBDIkl (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 4 Feb 2020 03:40:41 -0500
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:40699 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726370AbgBDIkk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Feb 2020 03:40:40 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1580805638;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
        bh=1pdnzRCVrmx7pcvbVoyIg0b6WJ8KRxGIZzE6G4LbnVo=;
        b=XslDsL/Wf8t6ZLmyPhY5Whjm+y5iJvTjg6ReTUNg9llBfZQpdAWjhdOEgxAl/WYm1BP8V7
        sl8SAu1EuGeIzRobZ/sxwlpLdqV3sX0NoO1i8ozyyjfk87sqEzyIy8zwi7BcMJNMSWDt/7
        HOM4kGhNYgXuNDnX4E5KKl0ggzDxKUY=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-158-BJQk2wOHOcWdiEIfMWqAoQ-1; Tue, 04 Feb 2020 03:40:34 -0500
X-MC-Unique: BJQk2wOHOcWdiEIfMWqAoQ-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com [10.5.11.16])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 1797A8010E6;
        Tue,  4 Feb 2020 08:40:33 +0000 (UTC)
Received: from [10.36.117.121] (ovpn-117-121.ams2.redhat.com [10.36.117.121])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 4B8045C1B5;
        Tue,  4 Feb 2020 08:40:31 +0000 (UTC)
Subject: Re: [PATCH v1 1/2] mm/page_alloc: fix and rework pfn handling in
 memmap_init_zone()
To:     Alexander Duyck <alexander.duyck@gmail.com>
Cc:     LKML <linux-kernel@vger.kernel.org>, linux-mm <linux-mm@kvack.org>,
        Pavel Tatashin <pasha.tatashin@oracle.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Michal Hocko <mhocko@kernel.org>,
        Oscar Salvador <osalvador@suse.de>,
        "Kirill A . Shutemov" <kirill@shutemov.name>
References: <CAKgT0UdFphMbS04NMRYU=VUmbnVi_purz4UA0cqA3dd7YW-pJA@mail.gmail.com>
 <1583F4CF-6CD8-4AB6-A2F6-60E6AEE5D5B2@redhat.com>
 <CAKgT0UeGZcUfC1m+uFtLgZWKEiRK_CkCvauZYB0VaeVc6uN50Q@mail.gmail.com>
From:   David Hildenbrand <david@redhat.com>
Autocrypt: addr=david@redhat.com; prefer-encrypt=mutual; keydata=
 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
Organization: Red Hat GmbH
Message-ID: <5186091f-4de5-d2cd-1e97-56b078d86886@redhat.com>
Date:   Tue, 4 Feb 2020 09:40:30 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.3.1
MIME-Version: 1.0
In-Reply-To: <CAKgT0UeGZcUfC1m+uFtLgZWKEiRK_CkCvauZYB0VaeVc6uN50Q@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 04.02.20 00:17, Alexander Duyck wrote:
> On Mon, Feb 3, 2020 at 1:44 PM David Hildenbrand <david@redhat.com> wro=
te:
>>
>>
>>
>>> Am 03.02.2020 um 22:35 schrieb Alexander Duyck <alexander.duyck@gmail=
.com>:
>>>
>>> =EF=BB=BFOn Mon, Jan 13, 2020 at 6:40 AM David Hildenbrand <david@red=
hat.com> wrote:
>>>>
>>>> Let's update the pfn manually whenever we continue the loop. This ma=
kes
>>>> the code easier to read but also less error prone (and we can direct=
ly
>>>> fix one issue).
>>>>
>>>> When overlap_memmap_init() returns true, pfn is updated to
>>>> "memblock_region_memory_end_pfn(r)". So it already points at the *ne=
xt*
>>>> pfn to process. Incrementing the pfn another time is wrong, we might
>>>> leave one uninitialized. I spotted this by inspecting the code, so I=
 have
>>>> no idea if this is relevant in practise (with kernelcore=3Dmirror).
>>>>
>>>> Fixes: a9a9e77fbf27 ("mm: move mirrored memory specific code outside=
 of memmap_init_zone")
>>>> Cc: Pavel Tatashin <pasha.tatashin@oracle.com>
>>>> Cc: Andrew Morton <akpm@linux-foundation.org>
>>>> Cc: Michal Hocko <mhocko@kernel.org>
>>>> Cc: Oscar Salvador <osalvador@suse.de>
>>>> Cc: Kirill A. Shutemov <kirill@shutemov.name>
>>>> Signed-off-by: David Hildenbrand <david@redhat.com>
>>>> ---
>>>> mm/page_alloc.c | 9 ++++++---
>>>> 1 file changed, 6 insertions(+), 3 deletions(-)
>>>>
>>>> diff --git a/mm/page_alloc.c b/mm/page_alloc.c
>>>> index a41bd7341de1..a92791512077 100644
>>>> --- a/mm/page_alloc.c
>>>> +++ b/mm/page_alloc.c
>>>> @@ -5905,18 +5905,20 @@ void __meminit memmap_init_zone(unsigned lon=
g size, int nid, unsigned long zone,
>>>>        }
>>>> #endif
>>>>
>>>> -       for (pfn =3D start_pfn; pfn < end_pfn; pfn++) {
>>>> +       for (pfn =3D start_pfn; pfn < end_pfn; ) {
>>>>                /*
>>>>                 * There can be holes in boot-time mem_map[]s handed =
to this
>>>>                 * function.  They do not exist on hotplugged memory.
>>>>                 */
>>>>                if (context =3D=3D MEMMAP_EARLY) {
>>>>                        if (!early_pfn_valid(pfn)) {
>>>> -                               pfn =3D next_pfn(pfn) - 1;
>>>> +                               pfn =3D next_pfn(pfn);
>>>>                                continue;
>>>>                        }
>>>> -                       if (!early_pfn_in_nid(pfn, nid))
>>>> +                       if (!early_pfn_in_nid(pfn, nid)) {
>>>> +                               pfn++;
>>>>                                continue;
>>>> +                       }
>>>>                        if (overlap_memmap_init(zone, &pfn))
>>>>                                continue;
>>>>                        if (defer_init(nid, pfn, end_pfn))
>>>
>>> I'm pretty sure this is a bit broken. The overlap_memmap_init is goin=
g
>>> to return memblock_region_memory_end_pfn instead of the start of the
>>> next region. I think that is going to stick you in a mirrored region
>>> without advancing in that case. You would also need to have that case
>>> do a pfn++ before the continue;
>>
>> Thanks for having a look.
>>
>> Did you read the description regarding this change?
>=20
> Actually I hadn't read it all that closely, so my bad on that. The
> part that had caught my attention though was that
> memblock_region_memory_end is using PFN_DOWN to identify the end of
> the memory region, Given that we probably shouldn't be messing with
> the PFNs that may contain any of this memory it might make more sense
> to use memblock_region_reserved_end_pfn which uses PFN_UP so that we
> exclude all memory that is in the mirrored region just in case
> something doesn't end on a PFN aligned boundary.
>=20
> If we know that the mirrored region is going to always be page size
> aligned then I guess you are good to go. That was the only thing I
> wasn't sure about.

I think we can safely assume this for now. But I *think* we are fine
either way:

We are using memblock_region_memory_end() in all cases I spotted
(especially consistently in overlap_memmap_init()) - so there is never a
mis-match that could result in an endless loop.

Anyhow, having mirrored sub-page regions would be weird either way :)
(just like any zone that would end on sub-pages)

>=20
> Reviewed-by: Alexander Duyck <alexander.h.duyck@linux.intel.com>
>=20

Thanks!

--=20
Thanks,

David / dhildenb

