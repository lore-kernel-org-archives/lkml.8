Return-Path: <SRS0=z1XV=3D=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7BD89C33CB1
	for <linux-kernel@archiver.kernel.org>; Tue, 14 Jan 2020 10:49:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4764224676
	for <linux-kernel@archiver.kernel.org>; Tue, 14 Jan 2020 10:49:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="hwMwIiDk"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729169AbgANKt3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 14 Jan 2020 05:49:29 -0500
Received: from us-smtp-1.mimecast.com ([205.139.110.61]:49841 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1727556AbgANKt3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Jan 2020 05:49:29 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1578998966;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
        bh=3XJ9z0G23+7hUgVCWf1+OOEhkYy92P/AjrFQFnXozng=;
        b=hwMwIiDkacUpavwnQITiRc2aB4RANsw37ZPjKujAr6DPIqT8wgo4pTdebDxlCKiN3cvT9E
        uFQdxRyK5xxVZhfIH3mvdQFzSNdiSfLpr0BZF2zDF7p5JAaHYgFTej+bEpEjcYwe+Qqm9Z
        XpZp3Hqe6TwvyHdZZAHwR+IfKuQPeEY=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-166-yjVHJFFTMHmmH-XxxQ4Xhg-1; Tue, 14 Jan 2020 05:49:23 -0500
X-MC-Unique: yjVHJFFTMHmmH-XxxQ4Xhg-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com [10.5.11.16])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 9B685801FA0;
        Tue, 14 Jan 2020 10:49:21 +0000 (UTC)
Received: from [10.36.117.154] (ovpn-117-154.ams2.redhat.com [10.36.117.154])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 2E4885C1B0;
        Tue, 14 Jan 2020 10:49:20 +0000 (UTC)
Subject: Re: [PATCH v1 2/2] mm: factor out next_present_section_nr()
To:     "Kirill A. Shutemov" <kirill@shutemov.name>
Cc:     linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        Andrew Morton <akpm@linux-foundation.org>,
        Michal Hocko <mhocko@kernel.org>,
        Oscar Salvador <osalvador@suse.de>
References: <0B77E39C-BD38-4A61-AB28-3578B519952F@redhat.com>
 <C40ACB72-F8C7-4F9B-B3F3-00FBC0C44406@redhat.com>
 <20200114104119.pybggnb4b2mq45wr@box>
From:   David Hildenbrand <david@redhat.com>
Autocrypt: addr=david@redhat.com; prefer-encrypt=mutual; keydata=
 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
Organization: Red Hat GmbH
Message-ID: <4de17591-e2c4-daff-e4b2-d03dd8792d0f@redhat.com>
Date:   Tue, 14 Jan 2020 11:49:19 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.3.1
MIME-Version: 1.0
In-Reply-To: <20200114104119.pybggnb4b2mq45wr@box>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 14.01.20 11:41, Kirill A. Shutemov wrote:
> On Tue, Jan 14, 2020 at 12:02:00AM +0100, David Hildenbrand wrote:
>>
>>
>>> Am 13.01.2020 um 23:57 schrieb David Hildenbrand <dhildenb@redhat.com=
>:
>>>
>>> =EF=BB=BF
>>>
>>>>> Am 13.01.2020 um 23:41 schrieb Kirill A. Shutemov <kirill@shutemov.=
name>:
>>>>>
>>>>> =EF=BB=BFOn Mon, Jan 13, 2020 at 03:40:35PM +0100, David Hildenbran=
d wrote:
>>>>> Let's move it to the header and use the shorter variant from
>>>>> mm/page_alloc.c (the original one will also check
>>>>> "__highest_present_section_nr + 1", which is not necessary). While =
at it,
>>>>> make the section_nr in next_pfn() const.
>>>>>
>>>>> In next_pfn(), we now return section_nr_to_pfn(-1) instead of -1 on=
ce
>>>>> we exceed __highest_present_section_nr, which doesn't make a differ=
ence in
>>>>> the caller as it is big enough (>=3D all sane end_pfn).
>>>>>
>>>>> Cc: Andrew Morton <akpm@linux-foundation.org>
>>>>> Cc: Michal Hocko <mhocko@kernel.org>
>>>>> Cc: Oscar Salvador <osalvador@suse.de>
>>>>> Cc: Kirill A. Shutemov <kirill@shutemov.name>
>>>>> Signed-off-by: David Hildenbrand <david@redhat.com>
>>>>> ---
>>>>> include/linux/mmzone.h | 10 ++++++++++
>>>>> mm/page_alloc.c        | 11 ++---------
>>>>> mm/sparse.c            | 10 ----------
>>>>> 3 files changed, 12 insertions(+), 19 deletions(-)
>>>>>
>>>>> diff --git a/include/linux/mmzone.h b/include/linux/mmzone.h
>>>>> index c2bc309d1634..462f6873905a 100644
>>>>> --- a/include/linux/mmzone.h
>>>>> +++ b/include/linux/mmzone.h
>>>>> @@ -1379,6 +1379,16 @@ static inline int pfn_present(unsigned long =
pfn)
>>>>>   return present_section(__nr_to_section(pfn_to_section_nr(pfn)));
>>>>> }
>>>>>
>>>>> +static inline unsigned long next_present_section_nr(unsigned long =
section_nr)
>>>>> +{
>>>>> +    while (++section_nr <=3D __highest_present_section_nr) {
>>>>> +        if (present_section_nr(section_nr))
>>>>> +            return section_nr;
>>>>> +    }
>>>>> +
>>>>> +    return -1;
>>>>> +}
>>>>> +
>>>>> /*
>>>>> * These are _only_ used during initialisation, therefore they
>>>>> * can use __initdata ...  They could have names to indicate
>>>>> diff --git a/mm/page_alloc.c b/mm/page_alloc.c
>>>>> index a92791512077..26e8044e9848 100644
>>>>> --- a/mm/page_alloc.c
>>>>> +++ b/mm/page_alloc.c
>>>>> @@ -5852,18 +5852,11 @@ overlap_memmap_init(unsigned long zone, uns=
igned long *pfn)
>>>>> /* Skip PFNs that belong to non-present sections */
>>>>> static inline __meminit unsigned long next_pfn(unsigned long pfn)
>>>>> {
>>>>> -    unsigned long section_nr;
>>>>> +    const unsigned long section_nr =3D pfn_to_section_nr(++pfn);
>>>>>
>>>>> -    section_nr =3D pfn_to_section_nr(++pfn);
>>>>>   if (present_section_nr(section_nr))
>>>>>       return pfn;
>>>>> -
>>>>> -    while (++section_nr <=3D __highest_present_section_nr) {
>>>>> -        if (present_section_nr(section_nr))
>>>>> -            return section_nr_to_pfn(section_nr);
>>>>> -    }
>>>>> -
>>>>> -    return -1;
>>>>> +    return section_nr_to_pfn(next_present_section_nr(section_nr));
>>>>
>>>> This changes behaviour in the corner case: if next_present_section_n=
r()
>>>> returns -1, we call section_nr_to_pfn() for it. It's unlikely would =
give
>>>> any valid pfn, but I can't say for sure for all archs. I guess the w=
orst
>>>> case scenrio would be endless loop over the same secitons/pfns.
>>>>
>>>> Have you considered the case?
>>>
>>> Yes, see the patch description. We return -1 << PFN_SECTION_SHIFT, so=
 a number close to the end of the address space (0xfff...000). (Will doub=
le check tomorrow if any 32bit arch could be problematic here)
>>
>> ... but thinking again, 0xfff... is certainly an invalid PFN, so this =
should work just fine.
>>
>> (biggest possible pfn is -1 >> PFN_SHIFT)
>>
>> But it=E2=80=98s late in Germany, will double check tomorrow :)
>=20
> If the end_pfn happens the be more than -1UL << PFN_SECTION_SHIFT we ar=
e
> screwed: the pfn is invalid, next_present_section_nr() returns -1, the
> next iterartion is on the same pfn and we have endless loop.
>=20
> The question is whether we can prove end_pfn is always less than
> -1UL << PFN_SECTION_SHIFT in any configuration of any arch.
>=20
> It is not obvious for me.

memmap_init_zone() is called for a physical memory region: pfn + size
(nr_pages)

The highest possible PFN you can have is "-1(unsigned long) >>
PFN_SHIFT". So even if you would want to add the very last section, the
PFN would still be smaller than -1UL << PFN_SECTION_SHIFT.

--=20
Thanks,

David / dhildenb

