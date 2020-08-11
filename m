Return-Path: <SRS0=vr6t=BV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0F6B9C433E1
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Aug 2020 13:12:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D9C002076B
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Aug 2020 13:12:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=mg.codeaurora.org header.i=@mg.codeaurora.org header.b="Ci5vsjKL"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728710AbgHKNM1 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 11 Aug 2020 09:12:27 -0400
Received: from mail29.static.mailgun.info ([104.130.122.29]:26531 "EHLO
        mail29.static.mailgun.info" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1728557AbgHKNM0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Aug 2020 09:12:26 -0400
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org; q=dns/txt;
 s=smtp; t=1597151545; h=Content-Transfer-Encoding: Content-Type:
 In-Reply-To: MIME-Version: Date: Message-ID: From: References: Cc: To:
 Subject: Sender; bh=mkjpPslcWtdG0991XuCFpnkQYQbbvoo58rcO36lv23E=; b=Ci5vsjKL17ivRT5xR0sTo4CahYtcCiNIbmPKyxDhINpAH3hsR2y7Uv5SzdJezSFJDzMIcAmF
 O/YzgWff/VNGKQVOuDhuUjqt9jf9wTIXkgT7WYjsGLzaGiYwbeir8FVHMJV3jQGdZLKcjBbp
 HUDJjrPA0JZzCByEd5+xWlSxZE4=
X-Mailgun-Sending-Ip: 104.130.122.29
X-Mailgun-Sid: WyI0MWYwYSIsICJsaW51eC1rZXJuZWxAdmdlci5rZXJuZWwub3JnIiwgImJlOWU0YSJd
Received: from smtp.codeaurora.org
 (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171]) by
 smtp-out-n17.prod.us-east-1.postgun.com with SMTP id
 5f3299252b87d660496edb73 (version=TLS1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256); Tue, 11 Aug 2020 13:12:05
 GMT
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
        id 27614C43395; Tue, 11 Aug 2020 13:12:05 +0000 (UTC)
Received: from [192.168.1.103] (unknown [183.83.143.239])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: charante)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id D04A6C433C6;
        Tue, 11 Aug 2020 13:12:01 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org D04A6C433C6
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; spf=none smtp.mailfrom=charante@codeaurora.org
Subject: Re: [PATCH] mm, page_alloc: fix core hung in free_pcppages_bulk()
To:     David Hildenbrand <david@redhat.com>, akpm@linux-foundation.org,
        mhocko@suse.com, vbabka@suse.cz, linux-mm@kvack.org
Cc:     linux-kernel@vger.kernel.org, vinmenon@codeaurora.org
References: <1597075833-16736-1-git-send-email-charante@codeaurora.org>
 <3b07d2a6-8ce7-5957-8ca5-a8d977852e14@redhat.com>
From:   Charan Teja Kalla <charante@codeaurora.org>
Message-ID: <3e16448a-ea3b-99c0-13b0-a5a31c9b5582@codeaurora.org>
Date:   Tue, 11 Aug 2020 18:41:59 +0530
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.11.0
MIME-Version: 1.0
In-Reply-To: <3b07d2a6-8ce7-5957-8ca5-a8d977852e14@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Thanks David for the comments.

On 8/11/2020 1:59 PM, David Hildenbrand wrote:
> On 10.08.20 18:10, Charan Teja Reddy wrote:
>> The following race is observed with the repeated online, offline and a
>> delay between two successive online of memory blocks of movable zone.
>>
>> P1						P2
>>
>> Online the first memory block in
>> the movable zone. The pcp struct
>> values are initialized to default
>> values,i.e., pcp->high = 0 &
>> pcp->batch = 1.
>>
>> 					Allocate the pages from the
>> 					movable zone.
>>
>> Try to Online the second memory
>> block in the movable zone thus it
>> entered the online_pages() but yet
>> to call zone_pcp_update().
>> 					This process is entered into
>> 					the exit path thus it tries
>> 					to release the order-0 pages
>> 					to pcp lists through
>> 					free_unref_page_commit().
>> 					As pcp->high = 0, pcp->count = 1
>> 					proceed to call the function
>> 					free_pcppages_bulk().
>> Update the pcp values thus the
>> new pcp values are like, say,
>> pcp->high = 378, pcp->batch = 63.
>> 					Read the pcp's batch value using
>> 					READ_ONCE() and pass the same to
>> 					free_pcppages_bulk(), pcp values
>> 					passed here are, batch = 63,
>> 					count = 1.
>>
>> 					Since num of pages in the pcp
>> 					lists are less than ->batch,
>> 					then it will stuck in
>> 					while(list_empty(list)) loop
>> 					with interrupts disabled thus
>> 					a core hung.
>>
>> Avoid this by ensuring free_pcppages_bulk() called with proper count of
>> pcp list pages.
>>
>> The mentioned race is some what easily reproducible without [1] because
>> pcp's are not updated for the first memory block online and thus there
>> is a enough race window for P2 between alloc+free and pcp struct values
>> update through onlining of second memory block.
>>
>> With [1], the race is still exists but it is very much narrow as we
>> update the pcp struct values for the first memory block online itself.
>>
>> [1]: https://patchwork.kernel.org/patch/11696389/
>>
>> Signed-off-by: Charan Teja Reddy <charante@codeaurora.org>
>> ---
>>  mm/page_alloc.c | 16 ++++++++++++++--
>>  1 file changed, 14 insertions(+), 2 deletions(-)
>>
>> diff --git a/mm/page_alloc.c b/mm/page_alloc.c
>> index e4896e6..25e7e12 100644
>> --- a/mm/page_alloc.c
>> +++ b/mm/page_alloc.c
>> @@ -3106,6 +3106,7 @@ static void free_unref_page_commit(struct page *page, unsigned long pfn)
>>  	struct zone *zone = page_zone(page);
>>  	struct per_cpu_pages *pcp;
>>  	int migratetype;
>> +	int high;
>>  
>>  	migratetype = get_pcppage_migratetype(page);
>>  	__count_vm_event(PGFREE);
>> @@ -3128,8 +3129,19 @@ static void free_unref_page_commit(struct page *page, unsigned long pfn)
>>  	pcp = &this_cpu_ptr(zone->pageset)->pcp;
>>  	list_add(&page->lru, &pcp->lists[migratetype]);
>>  	pcp->count++;
>> -	if (pcp->count >= pcp->high) {
>> -		unsigned long batch = READ_ONCE(pcp->batch);
>> +	high = READ_ONCE(pcp->high);
>> +	if (pcp->count >= high) {
>> +		int batch;
>> +
>> +		batch = READ_ONCE(pcp->batch);
>> +		/*
>> +		 * For non-default pcp struct values, high is always
>> +		 * greater than the batch. If high < batch then pass
>> +		 * proper count to free the pcp's list pages.
>> +		 */
>> +		if (unlikely(high < batch))
>> +			batch = min(pcp->count, batch);
>> +
>>  		free_pcppages_bulk(zone, batch, pcp);
>>  	}
>>  }
>>
> 
> I was wondering if we should rather set all pageblocks to
> MIGRATE_ISOLATE in online_pages() before doing the online_pages_range()
> call, and do undo_isolate_page_range() after onlining is done.
> 
> move_pfn_range_to_zone()->memmap_init_zone() marks all pageblocks
> MIGRATE_MOVABLE, and as that function is used also during boot, we could
> supply a parameter to configure this.
> 
> This would prevent another race from happening: Having pages exposed to
> the buddy ready for allocation in online_pages_range() before the
> sections are marked online.

Yeah this is another bug. And idea of isolate first, online and undoing
the isolation after zonelist and pcp struct update should work even for
the mentioned issue. This needs to go as a separate fix?

However, IMO, issue in free_pcppages_bulk() should be fixed by checking
if sane count value is passed. NO?
Posted V2: https://patchwork.kernel.org/patch/11709225/

> 
> This would avoid any pages from getting allocated before we're
> completely done onlining.
> 
> We would need MIGRATE_ISOLATE/CONFIG_MEMORY_ISOLATION also for
> CONFIG_MEMORY_HOTPLUG.
> 

-- 
The Qualcomm Innovation Center, Inc. is a member of the Code Aurora
Forum, a Linux Foundation Collaborative Project
