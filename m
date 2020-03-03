Return-Path: <SRS0=fZJt=4U=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 73920C3F2D7
	for <linux-kernel@archiver.kernel.org>; Tue,  3 Mar 2020 08:33:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3D4B320848
	for <linux-kernel@archiver.kernel.org>; Tue,  3 Mar 2020 08:33:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="BCsU0P0S"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726889AbgCCIdR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 3 Mar 2020 03:33:17 -0500
Received: from us-smtp-1.mimecast.com ([205.139.110.61]:53031 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1725440AbgCCIdR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Mar 2020 03:33:17 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1583224395;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
        bh=68dZNYO3Iiawtz9X1ovo11cfSkgB6VtGOGGfqanzCIM=;
        b=BCsU0P0SAtoVHJ4b8RAxFdjoZQk+AOHoWrwF8ULXannv80WmoR0uOWzn74N6qXlxNa1eTa
        dxQNgEivKq9YMNXAw98dpcygzUGMu8WqxYkNVpoWSsC2kTIicrGPJzD4GKalGAYJUEt8W7
        KSR6qWzNWFz5MIZ3jzAv6Gw4jgMLg9Q=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-30-QA9EKIJSNaq8yGPzp_Jx4Q-1; Tue, 03 Mar 2020 03:33:11 -0500
X-MC-Unique: QA9EKIJSNaq8yGPzp_Jx4Q-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com [10.5.11.14])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id BE140DBA3;
        Tue,  3 Mar 2020 08:33:09 +0000 (UTC)
Received: from [10.36.117.113] (ovpn-117-113.ams2.redhat.com [10.36.117.113])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 90B2F5D9C9;
        Tue,  3 Mar 2020 08:33:07 +0000 (UTC)
Subject: Re: [PATCH v2 3/7] mm/sparse.c: introduce a new function
 clear_subsection_map()
To:     Baoquan He <bhe@redhat.com>
Cc:     linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        akpm@linux-foundation.org, richardw.yang@linux.intel.com,
        osalvador@suse.de, dan.j.williams@intel.com, mhocko@suse.com,
        rppt@linux.ibm.com, robin.murphy@arm.com
References: <20200220043316.19668-1-bhe@redhat.com>
 <20200220043316.19668-4-bhe@redhat.com>
 <dc5ab1b1-65e2-e20f-66aa-b71d739a5b6d@redhat.com>
 <20200301052028.GN24216@MiWiFi-R3L-srv>
 <1346f0c2-7b1f-6feb-5e9b-2854fd0022ba@redhat.com>
 <20200303082204.GA4433@MiWiFi-R3L-srv>
From:   David Hildenbrand <david@redhat.com>
Autocrypt: addr=david@redhat.com; prefer-encrypt=mutual; keydata=
 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
Organization: Red Hat GmbH
Message-ID: <53bba557-149c-54b5-c8d7-27f7b6a55eb0@redhat.com>
Date:   Tue, 3 Mar 2020 09:33:06 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.5.0
MIME-Version: 1.0
In-Reply-To: <20200303082204.GA4433@MiWiFi-R3L-srv>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 03.03.20 09:22, Baoquan He wrote:
> On 03/02/20 at 04:43pm, David Hildenbrand wrote:
>> On 01.03.20 06:20, Baoquan He wrote:
>>> On 02/28/20 at 03:36pm, David Hildenbrand wrote:
>>>> On 20.02.20 05:33, Baoquan He wrote:
>>>>> Wrap the codes which clear subsection map of one memory region from
>>>>> section_deactivate() into clear_subsection_map().
>>>>>
>>>>> Signed-off-by: Baoquan He <bhe@redhat.com>
>>>>> ---
>>>>>  mm/sparse.c | 46 ++++++++++++++++++++++++++++++++++++++--------
>>>>>  1 file changed, 38 insertions(+), 8 deletions(-)
>>>>>
>>>>> diff --git a/mm/sparse.c b/mm/sparse.c
>>>>> index 977b47acd38d..df857ee9330c 100644
>>>>> --- a/mm/sparse.c
>>>>> +++ b/mm/sparse.c
>>>>> @@ -726,14 +726,25 @@ static void free_map_bootmem(struct page *mem=
map)
>>>>>  }
>>>>>  #endif /* CONFIG_SPARSEMEM_VMEMMAP */
>>>>> =20
>>>>> -static void section_deactivate(unsigned long pfn, unsigned long nr=
_pages,
>>>>> -		struct vmem_altmap *altmap)
>>>>> +/**
>>>>> + * clear_subsection_map - Clear subsection map of one memory regio=
n
>>>>> + *
>>>>> + * @pfn - start pfn of the memory range
>>>>> + * @nr_pages - number of pfns to add in the region
>>>>> + *
>>>>> + * This is only intended for hotplug, and clear the related subsec=
tion
>>>>> + * map inside one section.
>>>>> + *
>>>>> + * Return:
>>>>> + * * -EINVAL	- Section already deactived.
>>>>> + * * 0		- Subsection map is emptied.
>>>>> + * * 1		- Subsection map is not empty.
>>>>> + */
>>>>
>>>> Less verbose please (in my preference: none and simplify return hand=
ling)
>>>>
>>>>> +static int clear_subsection_map(unsigned long pfn, unsigned long n=
r_pages)
>>>>>  {
>>>>>  	DECLARE_BITMAP(map, SUBSECTIONS_PER_SECTION) =3D { 0 };
>>>>>  	DECLARE_BITMAP(tmp, SUBSECTIONS_PER_SECTION) =3D { 0 };
>>>>>  	struct mem_section *ms =3D __pfn_to_section(pfn);
>>>>> -	bool section_is_early =3D early_section(ms);
>>>>> -	struct page *memmap =3D NULL;
>>>>>  	unsigned long *subsection_map =3D ms->usage
>>>>>  		? &ms->usage->subsection_map[0] : NULL;
>>>>> =20
>>>>> @@ -744,8 +755,28 @@ static void section_deactivate(unsigned long p=
fn, unsigned long nr_pages,
>>>>>  	if (WARN(!subsection_map || !bitmap_equal(tmp, map, SUBSECTIONS_P=
ER_SECTION),
>>>>>  				"section already deactivated (%#lx + %ld)\n",
>>>>>  				pfn, nr_pages))
>>>>> -		return;
>>>>> +		return -EINVAL;
>>>>> +
>>>>> +	bitmap_xor(subsection_map, map, subsection_map, SUBSECTIONS_PER_S=
ECTION);
>>>>> =20
>>>>> +	if (bitmap_empty(subsection_map, SUBSECTIONS_PER_SECTION))
>>>>> +		return 0;
>>>>> +
>>>>
>>>> Can we please just have a
>>>>
>>>> subsection_map_empty() instead and handle that in the caller?
>>>> (you can then always return true in the !VMEMMAP variant)
>>>
>>> I don't follow. Could you be more specific? or pseudo code please?
>>>
>>> The old code has to handle below case in which subsection_map has bee=
n
>>> cleared. And I introduce clear_subsection_map() to encapsulate all
>>> subsection map realted code so that !VMEMMAP won't have to see it any
>>> more.
>>>
>>
>> Something like this on top would be easier to understand IMHO
>>
>>
>> diff --git a/mm/sparse.c b/mm/sparse.c
>> index dc79b00ddaaa..be5c80e9cfee 100644
>> --- a/mm/sparse.c
>> +++ b/mm/sparse.c
>> @@ -726,20 +726,6 @@ static void free_map_bootmem(struct page *memmap)
>>  }
>>  #endif /* CONFIG_SPARSEMEM_VMEMMAP */
>> =20
>> -/**
>> - * clear_subsection_map - Clear subsection map of one memory region
>> - *
>> - * @pfn - start pfn of the memory range
>> - * @nr_pages - number of pfns to add in the region
>> - *
>> - * This is only intended for hotplug, and clear the related subsectio=
n
>> - * map inside one section.
>> - *
>> - * Return:
>> - * * -EINVAL	- Section already deactived.
>> - * * 0		- Subsection map is emptied.
>> - * * 1		- Subsection map is not empty.
>> - */
>>  static int clear_subsection_map(unsigned long pfn, unsigned long nr_p=
ages)
>>  {
>>  	DECLARE_BITMAP(map, SUBSECTIONS_PER_SECTION) =3D { 0 };
>> @@ -758,11 +744,12 @@ static int clear_subsection_map(unsigned long pf=
n, unsigned long nr_pages)
>>  		return -EINVAL;
>> =20
>>  	bitmap_xor(subsection_map, map, subsection_map, SUBSECTIONS_PER_SECT=
ION);
>> +	return 0;
>> +}
>> =20
>> -	if (bitmap_empty(subsection_map, SUBSECTIONS_PER_SECTION))
>> -		return 0;
>> -
>> -	return 1;
>> +static bool is_subsection_map_empty(unsigned long pfn, unsigned long =
nr_pages)
>> +{
>> +	return bitmap_empty(subsection_map, SUBSECTIONS_PER_SECTION);
>>  }
>> =20
>>  static void section_deactivate(unsigned long pfn, unsigned long nr_pa=
ges,
>> @@ -771,11 +758,8 @@ static void section_deactivate(unsigned long pfn,=
 unsigned long nr_pages,
>>  	struct mem_section *ms =3D __pfn_to_section(pfn);
>>  	bool section_is_early =3D early_section(ms);
>>  	struct page *memmap =3D NULL;
>> -	int rc;
>> -
>> =20
>> -	rc =3D clear_subsection_map(pfn, nr_pages);
>> -	if (IS_ERR_VALUE((unsigned long)rc))
>> +	if (unlikely(clear_subsection_map(pfn, nr_pages)))
>>  		return;
>>  	/*
>>  	 * There are 3 cases to handle across two configurations
>> @@ -794,7 +778,7 @@ static void section_deactivate(unsigned long pfn, =
unsigned long nr_pages,
>>  	 *
>>  	 * For 2/ and 3/ the SPARSEMEM_VMEMMAP=3D{y,n} cases are unified
>>  	 */
>> -	if (!rc) {
>> +	if (is_subsection_map_empty(pfn, nr_pages)) {
>>  		unsigned long section_nr =3D pfn_to_section_nr(pfn);
>=20
> Tried this way, it's not good in this patch. Since ms->usage might be
> freed in this place.
>=20
>                 if (!PageReserved(virt_to_page(ms->usage))) {
>                         kfree(ms->usage);
>                         ms->usage =3D NULL;
>                 }

So your patch #1 is already broken. Just cache the result in patch #1.

bool empty;

...
empty =3D bitmap_empty(subsection_map, SUBSECTIONS_PER_SECTION);
...
if (empty) {
	...
}

--=20
Thanks,

David / dhildenb

