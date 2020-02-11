Return-Path: <SRS0=PxPh=37=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4E592C352A3
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Feb 2020 14:01:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1CE5E214DB
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Feb 2020 14:01:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="GF9oZg7Z"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729740AbgBKOBs (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 11 Feb 2020 09:01:48 -0500
Received: from us-smtp-2.mimecast.com ([207.211.31.81]:45674 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1728857AbgBKOBr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Feb 2020 09:01:47 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1581429705;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
        bh=nFLpPJkgVueHSLYrO0cmInQWApCLH3bfoTimE/eH7FA=;
        b=GF9oZg7ZvX15IRLqv5dRG82c3ic+Q+w91nPk8Z08NsOuMwnKOyc70MCAe/2ii87NYIYUsU
        twCuoEcO+WIyN4CXARmNpi3Y4/7Ju0d0wZeLtYbxeDvoOL3dp/FXwQGOO+p9gzbb+HPCLD
        cHypQujnzwXVJ/lGflK0qdQNnzRNueE=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-263-W9H-8s6-ONCkO4I7p0HkSA-1; Tue, 11 Feb 2020 09:01:40 -0500
X-MC-Unique: W9H-8s6-ONCkO4I7p0HkSA-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com [10.5.11.13])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id B45FF1083835;
        Tue, 11 Feb 2020 14:01:38 +0000 (UTC)
Received: from [10.36.117.14] (ovpn-117-14.ams2.redhat.com [10.36.117.14])
        by smtp.corp.redhat.com (Postfix) with ESMTP id DF82D90CFF;
        Tue, 11 Feb 2020 14:01:36 +0000 (UTC)
Subject: Re: [Patch v2] mm/sparsemem: get address to page struct instead of
 address to pfn
To:     Wei Yang <richardw.yang@linux.intel.com>
Cc:     akpm@linux-foundation.org, osalvador@suse.de,
        dan.j.williams@intel.com, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, Baoquan He <bhe@redhat.com>
References: <20200210005048.10437-1-richardw.yang@linux.intel.com>
 <90742479-cbb1-4ea9-c20c-53a1df34b806@redhat.com>
 <20200210231623.GC32495@richard>
From:   David Hildenbrand <david@redhat.com>
Autocrypt: addr=david@redhat.com; prefer-encrypt=mutual; keydata=
 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
Organization: Red Hat GmbH
Message-ID: <e36cd022-c1f1-a7e8-8888-5bf5b4cd993d@redhat.com>
Date:   Tue, 11 Feb 2020 15:01:35 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.1
MIME-Version: 1.0
In-Reply-To: <20200210231623.GC32495@richard>
Content-Type: text/plain; charset=windows-1252
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 11.02.20 00:16, Wei Yang wrote:
> On Mon, Feb 10, 2020 at 10:00:47AM +0100, David Hildenbrand wrote:
>> On 10.02.20 01:50, Wei Yang wrote:
>>> memmap should be the address to page struct instead of address to pfn.
>>>
>>
>> "mm/sparsemem: fix wrong address in ms->section_mem_map with sub-sections
>>
>> We want to store the address of the memmap, not the address of the first
>> pfn.
>>
>> E.g., we can have both (boot) system memory and devmem residing in a
>> single section. Once we hot-add the devmem part, the address stored in
>> ms->section_mem_map would be wrong, and kdump would not be able to
>> dump the right memory.
>> "
>>
>> ? See below
>>
>>> As mentioned by David, if system memory and devmem sit within a
>>> section, the mismatch address would lead kdump to dump unexpected
>>> memory.
>>>
>>> Since sub-section only works for SPARSEMEM_VMEMMAP, pfn_to_page() is
>>> valid to get the page struct address at this point.
>>>
>>> Fixes: ba72b4c8cf60 ("mm/sparsemem: support sub-section hotplug")
>>> Signed-off-by: Wei Yang <richardw.yang@linux.intel.com>
>>> CC: Dan Williams <dan.j.williams@intel.com>
>>> CC: David Hildenbrand <david@redhat.com>
>>> CC: Baoquan He <bhe@redhat.com>
>>>
>>> ---
>>> v2:
>>>   * adjust comment to mention the mismatch data would affect kdump
>>>
>>> ---
>>>  mm/sparse.c | 2 +-
>>>  1 file changed, 1 insertion(+), 1 deletion(-)
>>>
>>> diff --git a/mm/sparse.c b/mm/sparse.c
>>> index 586d85662978..4862ec2cfbc0 100644
>>> --- a/mm/sparse.c
>>> +++ b/mm/sparse.c
>>> @@ -887,7 +887,7 @@ int __meminit sparse_add_section(int nid, unsigned long start_pfn,
>>>  
>>>  	/* Align memmap to section boundary in the subsection case */
>>>  	if (section_nr_to_pfn(section_nr) != start_pfn)
>>> -		memmap = pfn_to_kaddr(section_nr_to_pfn(section_nr));
>>> +		memmap = pfn_to_page(section_nr_to_pfn(section_nr));
>>
>> I think this whole code should be reworked.
>>
>> Callee returns a pointer. Caller: Nah, I know it better.
>>
>> Just nasty.
>>
>>
>> Can we do something like this instead:
>>
>>
>> diff --git a/mm/sparse-vmemmap.c b/mm/sparse-vmemmap.c
>> index 200aef686722..c5091feef29e 100644
>> --- a/mm/sparse-vmemmap.c
>> +++ b/mm/sparse-vmemmap.c
>> @@ -266,5 +266,5 @@ struct page * __meminit
>> __populate_section_memmap(unsigned long pfn,
>>        if (vmemmap_populate(start, end, nid, altmap))
>>                return NULL;
>>
>> -       return pfn_to_page(pfn);
>> +       return pfn_to_page(SECTION_ALIGN_DOWN(pfn));
>> }
>> diff --git a/mm/sparse.c b/mm/sparse.c
>> index c184b69460b7..21902d7931e4 100644
>> --- a/mm/sparse.c
>> +++ b/mm/sparse.c
>> @@ -788,6 +788,10 @@ static void section_deactivate(unsigned long pfn,
>> unsigned long nr_pages,
>>                depopulate_section_memmap(pfn, nr_pages, altmap);
>> }
>>
>> +/*
>> + * Returns the memmap of the first pfn of the section (not of
>> + * sub-sections).
>> + */
>> static struct page * __meminit section_activate(int nid, unsigned long pfn,
>>                unsigned long nr_pages, struct vmem_altmap *altmap)
>> {
>> @@ -882,9 +886,6 @@ int __meminit sparse_add_section(int nid, unsigned
>> long start_pfn,
>>        set_section_nid(section_nr, nid);
>>        section_mark_present(ms);
>>
>> -       /* Align memmap to section boundary in the subsection case */
>> -       if (section_nr_to_pfn(section_nr) != start_pfn)
>> -               memmap = pfn_to_kaddr(section_nr_to_pfn(section_nr));
>>        sparse_init_one_section(ms, section_nr, memmap, ms->usage, 0);
>>
>>        return 0;
>>
>>
>> Untested, of course :)
> 
> I think you get some point. As you mentioned in the following reply, we need
> to adjust poisoning after this change.

We can just poison after setting up the section (IOW, move it further down).

> 
> This looks like a trade off between two options. I don't have a strong
> preference.

I clearly prefer if *section*_activate() returns the memmap of the
section. This code is just confusing. But I can send a cleanup on top if
you want to keep it like that for now.


-- 
Thanks,

David / dhildenb

