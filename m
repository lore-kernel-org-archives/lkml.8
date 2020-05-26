Return-Path: <SRS0=fR4S=7I=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 94B12C433DF
	for <linux-kernel@archiver.kernel.org>; Tue, 26 May 2020 11:49:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5D4C420663
	for <linux-kernel@archiver.kernel.org>; Tue, 26 May 2020 11:49:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="N0SPsqQA"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731987AbgEZLtq (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 26 May 2020 07:49:46 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:20832 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1731922AbgEZLtp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 May 2020 07:49:45 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1590493783;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
        bh=fd4XOACyr4xsyXwEu+Vp3/BMK/Pwe3Tj9/LWxO0oGb4=;
        b=N0SPsqQAXmErNA/Sf6BBDWcB6OslMU0yZ7cQs39E6iE0hZOCKrXDbv46IAvKPTLxGYMZk6
        KvAO4/oUKnngc/1EJQ6q6zm6tuQIFwOfzR8WRawt+ZD0N/rkJQN6nNY5oyMQoMWfpSiUfI
        dGIjvuC86+6xC4N4z3y1hVBFFkJH3GE=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-110-NR6K8aPTO463p8pm8iJajQ-1; Tue, 26 May 2020 07:49:41 -0400
X-MC-Unique: NR6K8aPTO463p8pm8iJajQ-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com [10.5.11.12])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 9429B107ACCA;
        Tue, 26 May 2020 11:49:39 +0000 (UTC)
Received: from [10.36.114.130] (ovpn-114-130.ams2.redhat.com [10.36.114.130])
        by smtp.corp.redhat.com (Postfix) with ESMTP id A188160CCC;
        Tue, 26 May 2020 11:49:37 +0000 (UTC)
Subject: Re: [PATCH] mm/compaction: Fix the incorrect hole in
 fast_isolate_freepages()
To:     Mike Rapoport <rppt@linux.ibm.com>, Baoquan He <bhe@redhat.com>
Cc:     mgorman@suse.de, linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        akpm@linux-foundation.org, cai@lca.pw, mhocko@kernel.org
References: <20200521014407.29690-1-bhe@redhat.com>
 <20200521092612.GP1059226@linux.ibm.com>
 <20200521155225.GA20045@MiWiFi-R3L-srv>
 <20200521171836.GU1059226@linux.ibm.com>
 <20200522070114.GE26955@MiWiFi-R3L-srv>
 <20200522072524.GF26955@MiWiFi-R3L-srv>
 <20200522142053.GW1059226@linux.ibm.com>
 <20200526084543.GG26955@MiWiFi-R3L-srv>
 <20200526113244.GH13212@linux.ibm.com>
From:   David Hildenbrand <david@redhat.com>
Autocrypt: addr=david@redhat.com; prefer-encrypt=mutual; keydata=
 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
Organization: Red Hat GmbH
Message-ID: <01beec81-565f-d335-5eff-22693fc09c0e@redhat.com>
Date:   Tue, 26 May 2020 13:49:36 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
MIME-Version: 1.0
In-Reply-To: <20200526113244.GH13212@linux.ibm.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 26.05.20 13:32, Mike Rapoport wrote:
> Hello Baoquan,
> 
> On Tue, May 26, 2020 at 04:45:43PM +0800, Baoquan He wrote:
>> On 05/22/20 at 05:20pm, Mike Rapoport wrote:
>>> Hello Baoquan,
>>>
>>> On Fri, May 22, 2020 at 03:25:24PM +0800, Baoquan He wrote:
>>>> On 05/22/20 at 03:01pm, Baoquan He wrote:
>>>>>
>>>>> So let's add these unavailable ranges into memblock and reserve them
>>>>> in init_unavailable_range() instead. With this change, they will be added
>>>>> into appropriate node and zone in memmap_init(), and initialized in
>>>>> reserve_bootmem_region() just like any other memblock reserved regions.
>>>>
>>>> Seems this is not right. They can't get nid in init_unavailable_range().
>>>> Adding e820 ranges may let them get nid. But the hole range won't be
>>>> added to memblock, and still has the issue.
>>>>
>>>> Nack this one for now, still considering.
>>>
>>> Why won't we add  the e820 reserved ranges to memblock.memory during
>>> early boot as I suggested?
>>>
>>> diff --git a/arch/x86/kernel/e820.c b/arch/x86/kernel/e820.c
>>> index c5399e80c59c..b0940c618ed9 100644
>>> --- a/arch/x86/kernel/e820.c
>>> +++ b/arch/x86/kernel/e820.c
>>> @@ -1301,8 +1301,11 @@ void __init e820__memblock_setup(void)
>>>  		if (end != (resource_size_t)end)
>>>  			continue;
>>>  
>>> -		if (entry->type == E820_TYPE_SOFT_RESERVED)
>>> +		if (entry->type == E820_TYPE_SOFT_RESERVED ||
>>> +		    entry->type == E820_TYPE_RESERVED) {
>>> +			memblock_add(entry->addr, entry->size);
>>>  			memblock_reserve(entry->addr, entry->size);
>>> +		}
>>>  
>>>  		if (entry->type != E820_TYPE_RAM && entry->type != E820_TYPE_RESERVED_KERN)
>>>  			continue;
>>>
>>> The setting of node later  in numa_init() will assign the proper node
>>> for these regions as it does for the usable memory.
>>
>> Yes, if it's only related to e820 reserved region, this truly works.
>>
>> However, it also has ACPI table regions. That's why I changed to call
>> the problematic area as firmware reserved ranges later.
>>
>> Bisides, you can see below line, there's another reserved region which only
>> occupies one page in one memory seciton. If adding to memblock.memory, we also
>> will build struct mem_section and the relevant struct pages for the whole
>> section. And then the holes around that page will be added and initialized in
>> init_unavailable_mem(). numa_init() will assign proper node for memblock.memory
>> and memblock.reserved, but won't assign proper node for the holes.
>>
>> ~~~
>> [    0.000000] BIOS-e820: [mem 0x00000000fed80000-0x00000000fed80fff] reserved
>> ~~~
>>
>> So I still think we should not add firmware reserved range into
>> memblock for fixing this issue.
>>
>> And, the fix in the original patch seems necessary. You can see in
>> compaction code, the migration source is chosen from LRU pages or
>> movable pages, the migration target has to be got from Buddy. However,
>> only the min_pfn in fast_isolate_freepages(), it's calculated by
>> distance between cc->free_pfn - cc->migrate_pfn, we can't guarantee it's
>> safe, then use it as the target to handle.
> 
> I do not object to your original fix with careful check for pfn validity.
> 
> But I still think that the memory reserved by the firmware is still
> memory and it should be added to memblock.memory. This way the memory

If it's really memory that could be read/written, I think I agree.

> map will be properly initialized from the very beginning and we won't
> need init_unavailable_mem() and alike workarounds and. Obviously, the patch

I remember init_unavailable_mem() is necessary for holes within
sections, where we actually *don't* have memory, but we still have have
a valid memmap (full section) that we have to initialize.

See the example from 4b094b7851bf ("mm/page_alloc.c: initialize memmap
of unavailable memory directly"). Our main memory ends within a section,
so we have to initialize the remaining parts because the whole section
will be marked valid/online.

Any way to improve this handling is appreciated. In that patch I also
spelled out that we might want to mark such holes via a new page type,
e.g., PageHole(). Such a page is a memory hole, but has a valid memmap.
Any content in the memmap (zone/node) should be ignored.

But it's all quite confusing, especially across architectures and ...

> above is not enough, but it's a small step in this direction.
> 
> I believe that improving the early memory initialization would make many
> things simpler and more robust, but that's a different story :)

... I second that.

-- 
Thanks,

David / dhildenb

