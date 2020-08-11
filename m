Return-Path: <SRS0=vr6t=BV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.6 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,NICE_REPLY_A,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9EB1EC433DF
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Aug 2020 13:14:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 778972083B
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Aug 2020 13:14:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="BnE1+jAT"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728727AbgHKNOE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 11 Aug 2020 09:14:04 -0400
Received: from us-smtp-1.mimecast.com ([205.139.110.61]:35924 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1728557AbgHKNOD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Aug 2020 09:14:03 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1597151641;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
        bh=3YRQJ2+lzZIXLaeYkCxE+RwakrrNJdjMAWYcA7yqgDk=;
        b=BnE1+jAT7ZNvd7rr49doo6glZ7x1l2q8u1VNQ65E9hSFyg8vtLqF23jOnuu7I3HEuXABJH
        lUxYBH7pGPwE2Zt1WY0Keyc6VZVStZuWGP9j9qCFuMPH7g2RoLNJbG7sTNPnkyRt04HQek
        iYHyFfX4Gw/yv6PrR+SEm1tpXocCPQk=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-368-puKvqKhsMTC0BjO2WMxy2Q-1; Tue, 11 Aug 2020 09:13:57 -0400
X-MC-Unique: puKvqKhsMTC0BjO2WMxy2Q-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com [10.5.11.22])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 3FB918017F4;
        Tue, 11 Aug 2020 13:13:56 +0000 (UTC)
Received: from [10.36.113.73] (ovpn-113-73.ams2.redhat.com [10.36.113.73])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 9A01E10013C4;
        Tue, 11 Aug 2020 13:13:54 +0000 (UTC)
Subject: Re: [PATCH] mm, page_alloc: fix core hung in free_pcppages_bulk()
To:     Charan Teja Kalla <charante@codeaurora.org>,
        akpm@linux-foundation.org, mhocko@suse.com, vbabka@suse.cz,
        linux-mm@kvack.org
Cc:     linux-kernel@vger.kernel.org, vinmenon@codeaurora.org
References: <1597075833-16736-1-git-send-email-charante@codeaurora.org>
 <3b07d2a6-8ce7-5957-8ca5-a8d977852e14@redhat.com>
 <3e16448a-ea3b-99c0-13b0-a5a31c9b5582@codeaurora.org>
From:   David Hildenbrand <david@redhat.com>
Autocrypt: addr=david@redhat.com; prefer-encrypt=mutual; keydata=
 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
 WNyWQQ==
Organization: Red Hat GmbH
Message-ID: <f3147c23-8ea8-c262-8dcc-7982d822db41@redhat.com>
Date:   Tue, 11 Aug 2020 15:13:53 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <3e16448a-ea3b-99c0-13b0-a5a31c9b5582@codeaurora.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 11.08.20 15:11, Charan Teja Kalla wrote:
> Thanks David for the comments.
> 
> On 8/11/2020 1:59 PM, David Hildenbrand wrote:
>> On 10.08.20 18:10, Charan Teja Reddy wrote:
>>> The following race is observed with the repeated online, offline and a
>>> delay between two successive online of memory blocks of movable zone.
>>>
>>> P1						P2
>>>
>>> Online the first memory block in
>>> the movable zone. The pcp struct
>>> values are initialized to default
>>> values,i.e., pcp->high = 0 &
>>> pcp->batch = 1.
>>>
>>> 					Allocate the pages from the
>>> 					movable zone.
>>>
>>> Try to Online the second memory
>>> block in the movable zone thus it
>>> entered the online_pages() but yet
>>> to call zone_pcp_update().
>>> 					This process is entered into
>>> 					the exit path thus it tries
>>> 					to release the order-0 pages
>>> 					to pcp lists through
>>> 					free_unref_page_commit().
>>> 					As pcp->high = 0, pcp->count = 1
>>> 					proceed to call the function
>>> 					free_pcppages_bulk().
>>> Update the pcp values thus the
>>> new pcp values are like, say,
>>> pcp->high = 378, pcp->batch = 63.
>>> 					Read the pcp's batch value using
>>> 					READ_ONCE() and pass the same to
>>> 					free_pcppages_bulk(), pcp values
>>> 					passed here are, batch = 63,
>>> 					count = 1.
>>>
>>> 					Since num of pages in the pcp
>>> 					lists are less than ->batch,
>>> 					then it will stuck in
>>> 					while(list_empty(list)) loop
>>> 					with interrupts disabled thus
>>> 					a core hung.
>>>
>>> Avoid this by ensuring free_pcppages_bulk() called with proper count of
>>> pcp list pages.
>>>
>>> The mentioned race is some what easily reproducible without [1] because
>>> pcp's are not updated for the first memory block online and thus there
>>> is a enough race window for P2 between alloc+free and pcp struct values
>>> update through onlining of second memory block.
>>>
>>> With [1], the race is still exists but it is very much narrow as we
>>> update the pcp struct values for the first memory block online itself.
>>>
>>> [1]: https://patchwork.kernel.org/patch/11696389/
>>>
>>> Signed-off-by: Charan Teja Reddy <charante@codeaurora.org>
>>> ---
>>>  mm/page_alloc.c | 16 ++++++++++++++--
>>>  1 file changed, 14 insertions(+), 2 deletions(-)
>>>
>>> diff --git a/mm/page_alloc.c b/mm/page_alloc.c
>>> index e4896e6..25e7e12 100644
>>> --- a/mm/page_alloc.c
>>> +++ b/mm/page_alloc.c
>>> @@ -3106,6 +3106,7 @@ static void free_unref_page_commit(struct page *page, unsigned long pfn)
>>>  	struct zone *zone = page_zone(page);
>>>  	struct per_cpu_pages *pcp;
>>>  	int migratetype;
>>> +	int high;
>>>  
>>>  	migratetype = get_pcppage_migratetype(page);
>>>  	__count_vm_event(PGFREE);
>>> @@ -3128,8 +3129,19 @@ static void free_unref_page_commit(struct page *page, unsigned long pfn)
>>>  	pcp = &this_cpu_ptr(zone->pageset)->pcp;
>>>  	list_add(&page->lru, &pcp->lists[migratetype]);
>>>  	pcp->count++;
>>> -	if (pcp->count >= pcp->high) {
>>> -		unsigned long batch = READ_ONCE(pcp->batch);
>>> +	high = READ_ONCE(pcp->high);
>>> +	if (pcp->count >= high) {
>>> +		int batch;
>>> +
>>> +		batch = READ_ONCE(pcp->batch);
>>> +		/*
>>> +		 * For non-default pcp struct values, high is always
>>> +		 * greater than the batch. If high < batch then pass
>>> +		 * proper count to free the pcp's list pages.
>>> +		 */
>>> +		if (unlikely(high < batch))
>>> +			batch = min(pcp->count, batch);
>>> +
>>>  		free_pcppages_bulk(zone, batch, pcp);
>>>  	}
>>>  }
>>>
>>
>> I was wondering if we should rather set all pageblocks to
>> MIGRATE_ISOLATE in online_pages() before doing the online_pages_range()
>> call, and do undo_isolate_page_range() after onlining is done.
>>
>> move_pfn_range_to_zone()->memmap_init_zone() marks all pageblocks
>> MIGRATE_MOVABLE, and as that function is used also during boot, we could
>> supply a parameter to configure this.
>>
>> This would prevent another race from happening: Having pages exposed to
>> the buddy ready for allocation in online_pages_range() before the
>> sections are marked online.
> 
> Yeah this is another bug. And idea of isolate first, online and undoing
> the isolation after zonelist and pcp struct update should work even for
> the mentioned issue. This needs to go as a separate fix?

Yeah, also requires more work to be done. Will add it to my list of TODOs.

> 
> However, IMO, issue in free_pcppages_bulk() should be fixed by checking
> if sane count value is passed. NO?
> Posted V2: https://patchwork.kernel.org/patch/11709225/

Yeah, I'm fine with fixing this issue that can actually be reproduced.


-- 
Thanks,

David / dhildenb

