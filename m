Return-Path: <SRS0=ZArZ=BW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.3 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,NICE_REPLY_A,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BA6EBC433DF
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Aug 2020 10:12:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 920D820781
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Aug 2020 10:12:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=mg.codeaurora.org header.i=@mg.codeaurora.org header.b="WSNnDNT7"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727882AbgHLKMH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 12 Aug 2020 06:12:07 -0400
Received: from mail29.static.mailgun.info ([104.130.122.29]:36563 "EHLO
        mail29.static.mailgun.info" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726453AbgHLKMH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Aug 2020 06:12:07 -0400
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org; q=dns/txt;
 s=smtp; t=1597227125; h=Content-Transfer-Encoding: Content-Type:
 In-Reply-To: MIME-Version: Date: Message-ID: From: References: Cc: To:
 Subject: Sender; bh=+5/WixljfK96eAIq+X+jLgzzz8K50lRlxjTIUy5uZoY=; b=WSNnDNT7RGYHz3nvFL6W2PVEmfYLo/IXC3rnZ08iPXFms1c2M53eyf2WVfS2BqpamezMFWf4
 VtIkcYxF3oQA9i6chbXMt1SYdEdfvFhbRqug6BwBUMcctVhIx8wDHGkupxJy6wwK0O/PRS2l
 o5vx7ObosnahwabDaKnYAHVu7mA=
X-Mailgun-Sending-Ip: 104.130.122.29
X-Mailgun-Sid: WyI0MWYwYSIsICJsaW51eC1rZXJuZWxAdmdlci5rZXJuZWwub3JnIiwgImJlOWU0YSJd
Received: from smtp.codeaurora.org
 (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171]) by
 smtp-out-n14.prod.us-west-2.postgun.com with SMTP id
 5f33c0584c787f237b8cdeaa (version=TLS1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256); Wed, 12 Aug 2020 10:11:36
 GMT
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
        id 3F9A9C43395; Wed, 12 Aug 2020 10:11:36 +0000 (UTC)
Received: from [192.168.1.103] (unknown [183.83.143.239])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: charante)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id DFCA4C433C6;
        Wed, 12 Aug 2020 10:11:32 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org DFCA4C433C6
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; spf=none smtp.mailfrom=charante@codeaurora.org
Subject: Re: [PATCH V2] mm, page_alloc: fix core hung in free_pcppages_bulk()
To:     David Hildenbrand <david@redhat.com>, akpm@linux-foundation.org,
        mhocko@suse.com, vbabka@suse.cz, rientjes@google.com,
        linux-mm@kvack.org
Cc:     linux-kernel@vger.kernel.org, vinmenon@codeaurora.org
References: <1597150703-19003-1-git-send-email-charante@codeaurora.org>
 <fdf574c8-82be-6bde-b73b-c97055f530a8@redhat.com>
 <848b7d60-2995-d9ae-0055-f3864dece11f@codeaurora.org>
 <db7ac714-f508-85a4-1af8-9733e680dc69@redhat.com>
From:   Charan Teja Kalla <charante@codeaurora.org>
Message-ID: <2a2ec65a-ad93-7adc-76a0-246b9b328155@codeaurora.org>
Date:   Wed, 12 Aug 2020 15:41:30 +0530
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.11.0
MIME-Version: 1.0
In-Reply-To: <db7ac714-f508-85a4-1af8-9733e680dc69@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 8/12/2020 3:30 PM, David Hildenbrand wrote:
> On 12.08.20 11:46, Charan Teja Kalla wrote:
>>
>> Thanks David for the inputs.
>>
>> On 8/12/2020 2:35 AM, David Hildenbrand wrote:
>>> On 11.08.20 14:58, Charan Teja Reddy wrote:
>>>> The following race is observed with the repeated online, offline and a
>>>> delay between two successive online of memory blocks of movable zone.
>>>>
>>>> P1						P2
>>>>
>>>> Online the first memory block in
>>>> the movable zone. The pcp struct
>>>> values are initialized to default
>>>> values,i.e., pcp->high = 0 &
>>>> pcp->batch = 1.
>>>>
>>>> 					Allocate the pages from the
>>>> 					movable zone.
>>>>
>>>> Try to Online the second memory
>>>> block in the movable zone thus it
>>>> entered the online_pages() but yet
>>>> to call zone_pcp_update().
>>>> 					This process is entered into
>>>> 					the exit path thus it tries
>>>> 					to release the order-0 pages
>>>> 					to pcp lists through
>>>> 					free_unref_page_commit().
>>>> 					As pcp->high = 0, pcp->count = 1
>>>> 					proceed to call the function
>>>> 					free_pcppages_bulk().
>>>> Update the pcp values thus the
>>>> new pcp values are like, say,
>>>> pcp->high = 378, pcp->batch = 63.
>>>> 					Read the pcp's batch value using
>>>> 					READ_ONCE() and pass the same to
>>>> 					free_pcppages_bulk(), pcp values
>>>> 					passed here are, batch = 63,
>>>> 					count = 1.
>>>>
>>>> 					Since num of pages in the pcp
>>>> 					lists are less than ->batch,
>>>> 					then it will stuck in
>>>> 					while(list_empty(list)) loop
>>>> 					with interrupts disabled thus
>>>> 					a core hung.
>>>>
>>>> Avoid this by ensuring free_pcppages_bulk() is called with proper count
>>>> of pcp list pages.
>>>>
>>>> The mentioned race is some what easily reproducible without [1] because
>>>> pcp's are not updated for the first memory block online and thus there
>>>> is a enough race window for P2 between alloc+free and pcp struct values
>>>> update through onlining of second memory block.
>>>>
>>>> With [1], the race is still exists but it is very much narrow as we
>>>> update the pcp struct values for the first memory block online itself.
>>>>
>>>> [1]: https://patchwork.kernel.org/patch/11696389/
>>>>
>>>
>>> IIUC, this is not limited to the movable zone, it could also happen in
>>> corner cases with the normal zone (e.g., hotplug to a node that only has
>>> DMA memory, or no other memory yet).
>>
>> Yes, this is my understanding too. I explained the above race in terms
>> of just movable zone for which it is observed. We can add the below line
>> in the end in patch commit message:
>> "This is not limited to the movable zone, it could also happen in cases
>> with the normal zone (e.g., hotplug to a node that only has DMA memory,
>> or no other memory yet)."
> 
> Yeah, that makes sense!
> 
>>
>> Just curious, there exists such systems where just a dma zone present
>> and we hot add the normal zone? I am not aware such thing in the
>> embedded world.
> 
> You can easily create such setups using QEMU.
> 
> IIRC, just specify a QEMU guest with 2G initial memory and a single NUMA
> node, or 4G initial memory and two NUMA nodes. Then hotplug memory.
> 
> (IIRC kata containers always start a VM with 2G and then hotplug memory)
>
I see. Thanks for letting me know this.

>>>
>>>> Signed-off-by: Charan Teja Reddy <charante@codeaurora.org>
>>>> ---
>>>>
>>>> v1: https://patchwork.kernel.org/patch/11707637/
>>>>
>>>>  mm/page_alloc.c | 5 +++++
>>>>  1 file changed, 5 insertions(+)
>>>>
>>>> diff --git a/mm/page_alloc.c b/mm/page_alloc.c
>>>> index e4896e6..839039f 100644
>>>> --- a/mm/page_alloc.c
>>>> +++ b/mm/page_alloc.c
>>>> @@ -1304,6 +1304,11 @@ static void free_pcppages_bulk(struct zone *zone, int count,
>>>>  	struct page *page, *tmp;
>>>>  	LIST_HEAD(head);
>>>>  
>>>> +	/*
>>>> +	 * Ensure proper count is passed which otherwise would stuck in the
>>>> +	 * below while (list_empty(list)) loop.
>>>> +	 */
>>>> +	count = min(pcp->count, count);
>>>>  	while (count) {
>>>>  		struct list_head *list;
>>>>  
>>>>
>>>
>>> Fixes: and Cc: stable... tags?
>>
>> Fixes: 5f8dcc21211a ("page-allocator: split per-cpu list into
>> one-list-per-migrate-type")
>> Cc: <stable@vger.kernel.org> [2.6+]
> 
> Did we have memory hotplug support then already?

Yes, it exist.
https://git.kernel.org/pub/scm/linux/kernel/git/next/linux-next.git/tree/mm/memory_hotplug.c?h=v2.6.39

> 
>>
>> I am not sure If I should have to raise V3 including these?
> 
> 
> Maybe Andrew can fixup when applying.

Okay, let Andrew decide on this. Meanwhile If you find that this patch
looks correct, ACK from you helps here.

> 
> 

-- 
The Qualcomm Innovation Center, Inc. is a member of the Code Aurora
Forum, a Linux Foundation Collaborative Project
