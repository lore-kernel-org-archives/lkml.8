Return-Path: <SRS0=dFdc=BX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.6 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,NICE_REPLY_A,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 63FCAC433DF
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Aug 2020 09:32:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3C8322078D
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Aug 2020 09:32:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="PIgjjOxB"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726529AbgHMJco (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 13 Aug 2020 05:32:44 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:59275 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726174AbgHMJcl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Aug 2020 05:32:41 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1597311159;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
        bh=w4hDk5O4cLqclPPzDPgUV9x6V2jQVgXzGdPu1p1kZlQ=;
        b=PIgjjOxBBnAbrGdnAS3wpbAtGsdgyAUFVYLRPkbAKxCc47r+AGaBH+oVJ249EnCAa/olKc
        CpQthghfzTN+87wn2YsUk66ePtrYkOy7CDD7+gK0HmNE4aCLsNhCaJyzAKF6CBfTKLuBRW
        BRWNTICWaW8TqzvAjFczW01VFJec2kA=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-198-GED3t4HTPv-cVoJGXeNXJw-1; Thu, 13 Aug 2020 05:32:35 -0400
X-MC-Unique: GED3t4HTPv-cVoJGXeNXJw-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com [10.5.11.11])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id CE55480183C;
        Thu, 13 Aug 2020 09:32:33 +0000 (UTC)
Received: from [10.36.113.43] (ovpn-113-43.ams2.redhat.com [10.36.113.43])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 04B6E600C5;
        Thu, 13 Aug 2020 09:32:31 +0000 (UTC)
Subject: Re: [PATCH V2] mm, page_alloc: fix core hung in free_pcppages_bulk()
To:     Charan Teja Kalla <charante@codeaurora.org>,
        akpm@linux-foundation.org, mhocko@suse.com, vbabka@suse.cz,
        rientjes@google.com, linux-mm@kvack.org
Cc:     linux-kernel@vger.kernel.org, vinmenon@codeaurora.org
References: <1597150703-19003-1-git-send-email-charante@codeaurora.org>
 <fdf574c8-82be-6bde-b73b-c97055f530a8@redhat.com>
 <848b7d60-2995-d9ae-0055-f3864dece11f@codeaurora.org>
 <db7ac714-f508-85a4-1af8-9733e680dc69@redhat.com>
 <2a2ec65a-ad93-7adc-76a0-246b9b328155@codeaurora.org>
From:   David Hildenbrand <david@redhat.com>
Autocrypt: addr=david@redhat.com; prefer-encrypt=mutual; keydata=
 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
 WNyWQQ==
Organization: Red Hat GmbH
Message-ID: <f93c8e92-f641-0776-653b-ca37e64c7156@redhat.com>
Date:   Thu, 13 Aug 2020 11:32:31 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <2a2ec65a-ad93-7adc-76a0-246b9b328155@codeaurora.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 12.08.20 12:11, Charan Teja Kalla wrote:
> 
> 
> On 8/12/2020 3:30 PM, David Hildenbrand wrote:
>> On 12.08.20 11:46, Charan Teja Kalla wrote:
>>>
>>> Thanks David for the inputs.
>>>
>>> On 8/12/2020 2:35 AM, David Hildenbrand wrote:
>>>> On 11.08.20 14:58, Charan Teja Reddy wrote:
>>>>> The following race is observed with the repeated online, offline and a
>>>>> delay between two successive online of memory blocks of movable zone.
>>>>>
>>>>> P1						P2
>>>>>
>>>>> Online the first memory block in
>>>>> the movable zone. The pcp struct
>>>>> values are initialized to default
>>>>> values,i.e., pcp->high = 0 &
>>>>> pcp->batch = 1.
>>>>>
>>>>> 					Allocate the pages from the
>>>>> 					movable zone.
>>>>>
>>>>> Try to Online the second memory
>>>>> block in the movable zone thus it
>>>>> entered the online_pages() but yet
>>>>> to call zone_pcp_update().
>>>>> 					This process is entered into
>>>>> 					the exit path thus it tries
>>>>> 					to release the order-0 pages
>>>>> 					to pcp lists through
>>>>> 					free_unref_page_commit().
>>>>> 					As pcp->high = 0, pcp->count = 1
>>>>> 					proceed to call the function
>>>>> 					free_pcppages_bulk().
>>>>> Update the pcp values thus the
>>>>> new pcp values are like, say,
>>>>> pcp->high = 378, pcp->batch = 63.
>>>>> 					Read the pcp's batch value using
>>>>> 					READ_ONCE() and pass the same to
>>>>> 					free_pcppages_bulk(), pcp values
>>>>> 					passed here are, batch = 63,
>>>>> 					count = 1.
>>>>>
>>>>> 					Since num of pages in the pcp
>>>>> 					lists are less than ->batch,
>>>>> 					then it will stuck in
>>>>> 					while(list_empty(list)) loop
>>>>> 					with interrupts disabled thus
>>>>> 					a core hung.
>>>>>
>>>>> Avoid this by ensuring free_pcppages_bulk() is called with proper count
>>>>> of pcp list pages.
>>>>>
>>>>> The mentioned race is some what easily reproducible without [1] because
>>>>> pcp's are not updated for the first memory block online and thus there
>>>>> is a enough race window for P2 between alloc+free and pcp struct values
>>>>> update through onlining of second memory block.
>>>>>
>>>>> With [1], the race is still exists but it is very much narrow as we
>>>>> update the pcp struct values for the first memory block online itself.
>>>>>
>>>>> [1]: https://patchwork.kernel.org/patch/11696389/
>>>>>
>>>>
>>>> IIUC, this is not limited to the movable zone, it could also happen in
>>>> corner cases with the normal zone (e.g., hotplug to a node that only has
>>>> DMA memory, or no other memory yet).
>>>
>>> Yes, this is my understanding too. I explained the above race in terms
>>> of just movable zone for which it is observed. We can add the below line
>>> in the end in patch commit message:
>>> "This is not limited to the movable zone, it could also happen in cases
>>> with the normal zone (e.g., hotplug to a node that only has DMA memory,
>>> or no other memory yet)."
>>
>> Yeah, that makes sense!
>>
>>>
>>> Just curious, there exists such systems where just a dma zone present
>>> and we hot add the normal zone? I am not aware such thing in the
>>> embedded world.
>>
>> You can easily create such setups using QEMU.
>>
>> IIRC, just specify a QEMU guest with 2G initial memory and a single NUMA
>> node, or 4G initial memory and two NUMA nodes. Then hotplug memory.
>>
>> (IIRC kata containers always start a VM with 2G and then hotplug memory)
>>
> I see. Thanks for letting me know this.
> 
>>>>
>>>>> Signed-off-by: Charan Teja Reddy <charante@codeaurora.org>
>>>>> ---
>>>>>
>>>>> v1: https://patchwork.kernel.org/patch/11707637/
>>>>>
>>>>>  mm/page_alloc.c | 5 +++++
>>>>>  1 file changed, 5 insertions(+)
>>>>>
>>>>> diff --git a/mm/page_alloc.c b/mm/page_alloc.c
>>>>> index e4896e6..839039f 100644
>>>>> --- a/mm/page_alloc.c
>>>>> +++ b/mm/page_alloc.c
>>>>> @@ -1304,6 +1304,11 @@ static void free_pcppages_bulk(struct zone *zone, int count,
>>>>>  	struct page *page, *tmp;
>>>>>  	LIST_HEAD(head);
>>>>>  
>>>>> +	/*
>>>>> +	 * Ensure proper count is passed which otherwise would stuck in the
>>>>> +	 * below while (list_empty(list)) loop.
>>>>> +	 */
>>>>> +	count = min(pcp->count, count);
>>>>>  	while (count) {
>>>>>  		struct list_head *list;
>>>>>  
>>>>>
>>>>
>>>> Fixes: and Cc: stable... tags?
>>>
>>> Fixes: 5f8dcc21211a ("page-allocator: split per-cpu list into
>>> one-list-per-migrate-type")
>>> Cc: <stable@vger.kernel.org> [2.6+]
>>
>> Did we have memory hotplug support then already?
> 
> Yes, it exist.
> https://git.kernel.org/pub/scm/linux/kernel/git/next/linux-next.git/tree/mm/memory_hotplug.c?h=v2.6.39

Okay, so I guess these tags make sense.

> 
>>
>>>
>>> I am not sure If I should have to raise V3 including these?
>>
>>
>> Maybe Andrew can fixup when applying.
> 
> Okay, let Andrew decide on this. Meanwhile If you find that this patch
> looks correct, ACK from you helps here.


Sure, I think this is good enough as a simple fix.

Acked-by: David Hildenbrand <david@redhat.com>


-- 
Thanks,

David / dhildenb

