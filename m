Return-Path: <SRS0=f73W=7K=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DEEF3C433E0
	for <linux-kernel@archiver.kernel.org>; Thu, 28 May 2020 09:08:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id AF6DC20B80
	for <linux-kernel@archiver.kernel.org>; Thu, 28 May 2020 09:08:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="DWHxcvFC"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728158AbgE1JIu (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 28 May 2020 05:08:50 -0400
Received: from us-smtp-1.mimecast.com ([207.211.31.81]:33300 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1728081AbgE1JIs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 May 2020 05:08:48 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1590656926;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
        bh=sl6q2oBzl3TsV25+GGbxCvWY88Pm8p6Z7eQ3/LH/cUk=;
        b=DWHxcvFCYN2/rNGNwAlN3hfpJcs7oYqDI5DEhNbf8aTfl0EJmsXpO86DaDON7Gh1QJaVeZ
        OYVxttb50cM4q3ttgejoQVsZ0IXqzvlGKjP9tJUZvRdtFYKcg0G9FW1mbDJyVNnPU4ZzmW
        lgPSEL4PfylGTtDBrg06YDuTYUSWfPI=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-37-DWq_gMhDOqG10yTCeTMvIQ-1; Thu, 28 May 2020 05:08:42 -0400
X-MC-Unique: DWq_gMhDOqG10yTCeTMvIQ-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com [10.5.11.14])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 2ECBA460;
        Thu, 28 May 2020 09:08:41 +0000 (UTC)
Received: from [10.36.114.114] (ovpn-114-114.ams2.redhat.com [10.36.114.114])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 2100E5D9EF;
        Thu, 28 May 2020 09:08:38 +0000 (UTC)
Subject: Re: [PATCH] mm/compaction: Fix the incorrect hole in
 fast_isolate_freepages()
To:     Baoquan He <bhe@redhat.com>
Cc:     Mike Rapoport <rppt@linux.ibm.com>, mgorman@suse.de,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        akpm@linux-foundation.org, cai@lca.pw, mhocko@kernel.org,
        steve.wahl@hpe.com
References: <20200521014407.29690-1-bhe@redhat.com>
 <20200521092612.GP1059226@linux.ibm.com>
 <20200521155225.GA20045@MiWiFi-R3L-srv>
 <20200521171836.GU1059226@linux.ibm.com>
 <20200522070114.GE26955@MiWiFi-R3L-srv>
 <20200522072524.GF26955@MiWiFi-R3L-srv>
 <20200522142053.GW1059226@linux.ibm.com>
 <20200526084543.GG26955@MiWiFi-R3L-srv>
 <20200526113244.GH13212@linux.ibm.com>
 <01beec81-565f-d335-5eff-22693fc09c0e@redhat.com>
 <20200528090731.GI20045@MiWiFi-R3L-srv>
From:   David Hildenbrand <david@redhat.com>
Autocrypt: addr=david@redhat.com; prefer-encrypt=mutual; keydata=
 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
Organization: Red Hat GmbH
Message-ID: <78919796-0c26-35f0-55fa-305932b7f992@redhat.com>
Date:   Thu, 28 May 2020 11:08:38 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
MIME-Version: 1.0
In-Reply-To: <20200528090731.GI20045@MiWiFi-R3L-srv>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 28.05.20 11:07, Baoquan He wrote:
> On 05/26/20 at 01:49pm, David Hildenbrand wrote:
>> On 26.05.20 13:32, Mike Rapoport wrote:
>>> Hello Baoquan,
>>>
>>> On Tue, May 26, 2020 at 04:45:43PM +0800, Baoquan He wrote:
>>>> On 05/22/20 at 05:20pm, Mike Rapoport wrote:
>>>>> Hello Baoquan,
>>>>>
>>>>> On Fri, May 22, 2020 at 03:25:24PM +0800, Baoquan He wrote:
>>>>>> On 05/22/20 at 03:01pm, Baoquan He wrote:
>>>>>>>
>>>>>>> So let's add these unavailable ranges into memblock and reserve them
>>>>>>> in init_unavailable_range() instead. With this change, they will be added
>>>>>>> into appropriate node and zone in memmap_init(), and initialized in
>>>>>>> reserve_bootmem_region() just like any other memblock reserved regions.
>>>>>>
>>>>>> Seems this is not right. They can't get nid in init_unavailable_range().
>>>>>> Adding e820 ranges may let them get nid. But the hole range won't be
>>>>>> added to memblock, and still has the issue.
>>>>>>
>>>>>> Nack this one for now, still considering.
>>>>>
>>>>> Why won't we add  the e820 reserved ranges to memblock.memory during
>>>>> early boot as I suggested?
>>>>>
>>>>> diff --git a/arch/x86/kernel/e820.c b/arch/x86/kernel/e820.c
>>>>> index c5399e80c59c..b0940c618ed9 100644
>>>>> --- a/arch/x86/kernel/e820.c
>>>>> +++ b/arch/x86/kernel/e820.c
>>>>> @@ -1301,8 +1301,11 @@ void __init e820__memblock_setup(void)
>>>>>  		if (end != (resource_size_t)end)
>>>>>  			continue;
>>>>>  
>>>>> -		if (entry->type == E820_TYPE_SOFT_RESERVED)
>>>>> +		if (entry->type == E820_TYPE_SOFT_RESERVED ||
>>>>> +		    entry->type == E820_TYPE_RESERVED) {
>>>>> +			memblock_add(entry->addr, entry->size);
>>>>>  			memblock_reserve(entry->addr, entry->size);
>>>>> +		}
>>>>>  
>>>>>  		if (entry->type != E820_TYPE_RAM && entry->type != E820_TYPE_RESERVED_KERN)
>>>>>  			continue;
>>>>>
>>>>> The setting of node later  in numa_init() will assign the proper node
>>>>> for these regions as it does for the usable memory.
>>>>
>>>> Yes, if it's only related to e820 reserved region, this truly works.
>>>>
>>>> However, it also has ACPI table regions. That's why I changed to call
>>>> the problematic area as firmware reserved ranges later.
>>>>
>>>> Bisides, you can see below line, there's another reserved region which only
>>>> occupies one page in one memory seciton. If adding to memblock.memory, we also
>>>> will build struct mem_section and the relevant struct pages for the whole
>>>> section. And then the holes around that page will be added and initialized in
>>>> init_unavailable_mem(). numa_init() will assign proper node for memblock.memory
>>>> and memblock.reserved, but won't assign proper node for the holes.
>>>>
>>>> ~~~
>>>> [    0.000000] BIOS-e820: [mem 0x00000000fed80000-0x00000000fed80fff] reserved
>>>> ~~~
>>>>
>>>> So I still think we should not add firmware reserved range into
>>>> memblock for fixing this issue.
>>>>
>>>> And, the fix in the original patch seems necessary. You can see in
>>>> compaction code, the migration source is chosen from LRU pages or
>>>> movable pages, the migration target has to be got from Buddy. However,
>>>> only the min_pfn in fast_isolate_freepages(), it's calculated by
>>>> distance between cc->free_pfn - cc->migrate_pfn, we can't guarantee it's
>>>> safe, then use it as the target to handle.
>>>
>>> I do not object to your original fix with careful check for pfn validity.
>>>
>>> But I still think that the memory reserved by the firmware is still
>>> memory and it should be added to memblock.memory. This way the memory
>>
>> If it's really memory that could be read/written, I think I agree.
> 
> I would say some of them may not be allowed to be read/written, if I
> understand it correctly. I roughly went through the x86 init code, there
> are some places where mem region is marked as E820_TYPE_RESERVED so that
> they are not touched after initialization. E.g:
> 
> 1) pfn 0
> In trim_bios_range(), we set the pfn 0 as E820_TYPE_RESERVED. You can
> see the code comment, this is a BIOS owned area, but not kernel RAM.
> 
> 2)GART reserved region
> In early_gart_iommu_check(), GART IOMMU firmware will reserve a region
> in an area, firmware designer won't map system RAM into that area.
> 
> And also intel_graphics_stolen(), arch_rmrr_sanity_check(), these
> regions are not system RAM backed area, reading from or writting into
> these area may cause error.
> 
> Futhermore, there's a KASLR bug found by HPE, its triggering and root
> cause are written into below commit log. You can see that accessing to
> firmware reserved region caused BIOS to halt system when cpu doing
> speculative.
> 
> commit 2aa85f246c181b1fa89f27e8e20c5636426be624
> Author: Steve Wahl <steve.wahl@hpe.com>
> Date:   Tue Sep 24 16:03:55 2019 -0500
> 
>     x86/boot/64: Make level2_kernel_pgt pages invalid outside kernel area
> 
>     Our hardware (UV aka Superdome Flex) has address ranges marked
>     reserved by the BIOS. Access to these ranges is caught as an error,
>     causing the BIOS to halt the system.
> 
>>
>>> map will be properly initialized from the very beginning and we won't
>>> need init_unavailable_mem() and alike workarounds and. Obviously, the patch
>>
>> I remember init_unavailable_mem() is necessary for holes within
>> sections, where we actually *don't* have memory, but we still have have
>> a valid memmap (full section) that we have to initialize.
>>
>> See the example from 4b094b7851bf ("mm/page_alloc.c: initialize memmap
>> of unavailable memory directly"). Our main memory ends within a section,
>> so we have to initialize the remaining parts because the whole section
>> will be marked valid/online.
> 
> Yes, memory hole need be handled in init_unavailable_mem(). Since we
> have created struct page for them, need initialize them. We can't
> discard init_unavailable_mem() for now.
> 
>>
>> Any way to improve this handling is appreciated. In that patch I also
>> spelled out that we might want to mark such holes via a new page type,
>> e.g., PageHole(). Such a page is a memory hole, but has a valid memmap.
>> Any content in the memmap (zone/node) should be ignored.
> 
> As I said at above, I am a little conservative to add all those regions of
> E820_TYPE_RESERVED into memblock.memory and memblock.reserved, because
> most of them are firmware reserved region, they may be not backed by normal
> RAM.
> 
> I was thinking to step back to use mm_zero_struct_page() inside
> init_unavailable_range() as below. But it doesn't differ much
> from __init_single_page(), except of the _refcount and mapcount.
> Zeroing struct page equals to putting them into node 0, zero 0.
> 
> diff --git a/mm/page_alloc.c b/mm/page_alloc.c
> index 3973b5fdfe3f..4e4b72cf5283 100644
> --- a/mm/page_alloc.c
> +++ b/mm/page_alloc.c
> @@ -6901,7 +6901,7 @@ static u64 __init init_unavailable_range(unsigned long spfn, unsigned long epfn)
>                  * (in memblock.reserved but not in memblock.memory) will
>                  * get re-initialized via reserve_bootmem_region() later.
>                  */
> -               __init_single_page(pfn_to_page(pfn), pfn, 0, 0);
> +               mm_zero_struct_page(pfn_to_page(pfn));
>                 __SetPageReserved(pfn_to_page(pfn));
>                 pgcnt++;
>         }
> 
> About adding these unavailable ranges into node/zone, in the old code,
> it just happened to add them into expected node/zone. You can see in
> early_pfn_in_nid(), if no nid found from memblock, the returned '-1'
> will make it true ironically. But that is not saying the bad thing
> always got good result. If the last zone of node 0 is DMA32 zone, the
> deferred init will skip the only chance to add some of unavailable
> rnages into expected node/zone. Means they were not always added into
> appropriate node/zone before, the change of iterating memblock.memory in
> memmap_init() dones't introduce regression.
> 
> static inline bool __meminit early_pfn_in_nid(unsigned long pfn, int node)
> {
>         int nid;
> 
>         nid = __early_pfn_to_nid(pfn, &early_pfnnid_cache);
>         if (nid >= 0 && nid != node)
>                 return false;
>         return true;
> }
> 
> So if no anybody need access them after boot, not adding them into any
> node/zone sounds better. Otherwise, better add them in the appropriate
> node/zone.

Yes, the node/zone is just completely irrelevant for these pages I'd say.

As I said, maybe we can flag these memmaps somehow as "while this is an
initialized memmap, the node/zone is garbage and this memmap should just
be ignored completely in any kind of node/zone aware code".


-- 
Thanks,

David / dhildenb

