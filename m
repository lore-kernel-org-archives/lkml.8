Return-Path: <SRS0=o+hd=CR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.0 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,NICE_REPLY_A,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C166AC43461
	for <linux-kernel@archiver.kernel.org>; Tue,  8 Sep 2020 09:27:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8589621D90
	for <linux-kernel@archiver.kernel.org>; Tue,  8 Sep 2020 09:27:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="LmBRHPWw"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728975AbgIHJ1F (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 8 Sep 2020 05:27:05 -0400
Received: from us-smtp-1.mimecast.com ([207.211.31.81]:30888 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1728137AbgIHJ1B (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Sep 2020 05:27:01 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1599557218;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
        bh=lwRt7b3CFyWkHsCA2hORCcwdjpwbDIsCkfLNP0joDNo=;
        b=LmBRHPWwhvq19z9p0VOQa5g9vQWYIuHdk2bNTL2aDkW366fe/sFzdhht7pUwTF7baphbi5
        HYeDt5fgSGroCACed+erEfF+vvL8Bfcp2eLZr1W3c5TYVt099eZYRlPJYTLukHUJ7llY8V
        iVziFUdfF8jYZ+mSvM1wwuL5JhzeLQU=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-175-Zdbvtn4DO-qWDuRUx6bJHw-1; Tue, 08 Sep 2020 05:26:54 -0400
X-MC-Unique: Zdbvtn4DO-qWDuRUx6bJHw-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com [10.5.11.14])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id E07C0801FC6;
        Tue,  8 Sep 2020 09:26:52 +0000 (UTC)
Received: from [10.36.115.46] (ovpn-115-46.ams2.redhat.com [10.36.115.46])
        by smtp.corp.redhat.com (Postfix) with ESMTP id D883E5D9E2;
        Tue,  8 Sep 2020 09:26:50 +0000 (UTC)
Subject: Re: [PATCH v3 2/2] mm: drain per-cpu pages outside of
 isolate_migratepages_range
To:     Michal Hocko <mhocko@suse.com>,
        Pavel Tatashin <pasha.tatashin@soleen.com>
Cc:     linux-kernel@vger.kernel.org, akpm@linux-foundation.org,
        linux-mm@kvack.org, osalvador@suse.de, richard.weiyang@gmail.com,
        vbabka@suse.cz, rientjes@google.com
References: <20200904151448.100489-1-pasha.tatashin@soleen.com>
 <20200904151448.100489-3-pasha.tatashin@soleen.com>
 <20200907073237.GG30144@dhcp22.suse.cz>
From:   David Hildenbrand <david@redhat.com>
Autocrypt: addr=david@redhat.com; prefer-encrypt=mutual; keydata=
 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
 WNyWQQ==
Organization: Red Hat GmbH
Message-ID: <29b37895-5824-be62-9d11-5e920069b03c@redhat.com>
Date:   Tue, 8 Sep 2020 11:26:49 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.11.0
MIME-Version: 1.0
In-Reply-To: <20200907073237.GG30144@dhcp22.suse.cz>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

>> Signed-off-by: Pavel Tatashin <pasha.tatashin@soleen.com>
> 
> I believe we should be going an opposite direction and define a more
> understandable and usable semantic for start_isolate_page_range. We do
> not want callers to scratch their heads to call all caches they might
> need to flush.

I still prefer temporarily disabling PCP, or using a different mechanism
to teach PCP to no work on isolated pageblocks (while the latter seems
to be harder to achieve). I can spot that Vlastimil already tried to
implement it - I'll have a look shortly.

Having that said, this patch improves the situation in case we cannot
get temporarily disabling of PCP implemented - instead of flushing at
random place, we flush at less random places :)

But it is far from ideal. It's just another of the special cases that
developed over time and instead of properly fixing it, we work around it.

Note: I think the flush semantics of drain_all_pages() is very different
from lru_add_drain_all(). The latter does not mess with isolated page
that have just been freed (as it's not part of the core buddy / buddy
extension).

> 
>> ---
>>  mm/memory_hotplug.c | 15 +--------------
>>  mm/page_alloc.c     |  2 ++
>>  mm/page_isolation.c | 40 ++++++++++++----------------------------
>>  3 files changed, 15 insertions(+), 42 deletions(-)
>>
>> diff --git a/mm/memory_hotplug.c b/mm/memory_hotplug.c
>> index b11a269e2356..5a2ed1a94555 100644
>> --- a/mm/memory_hotplug.c
>> +++ b/mm/memory_hotplug.c
>> @@ -1536,6 +1536,7 @@ static int __ref __offline_pages(unsigned long start_pfn,
>>  	}
>>  
>>  	do {
>> +		drain_all_pages(zone);
>>  		pfn = start_pfn;
>>  		do {
>>  			if (signal_pending(current)) {
>> @@ -1575,20 +1576,6 @@ static int __ref __offline_pages(unsigned long start_pfn,
>>  		/* check again */
>>  		ret = walk_system_ram_range(start_pfn, end_pfn - start_pfn,
>>  					    NULL, check_pages_isolated_cb);
>> -		/*
>> -		 * per-cpu pages are drained in start_isolate_page_range, but if
>> -		 * there are still pages that are not free, make sure that we
>> -		 * drain again, because when we isolated range we might
>> -		 * have raced with another thread that was adding pages to pcp
>> -		 * list.
>> -		 *
>> -		 * Forward progress should be still guaranteed because
>> -		 * pages on the pcp list can only belong to MOVABLE_ZONE
>> -		 * because has_unmovable_pages explicitly checks for
>> -		 * PageBuddy on freed pages on other zones.
>> -		 */
>> -		if (ret)
>> -			drain_all_pages(zone);
>>  	} while (ret);
>>  
>>  	/* Ok, all of our target is isolated.
>> diff --git a/mm/page_alloc.c b/mm/page_alloc.c
>> index fab5e97dc9ca..6d6a501a103e 100644
>> --- a/mm/page_alloc.c
>> +++ b/mm/page_alloc.c
>> @@ -8462,6 +8462,8 @@ int alloc_contig_range(unsigned long start, unsigned long end,
>>  	if (ret < 0)
>>  		return ret;
>>  
>> +	drain_all_pages(cc.zone);
>> +
>>  	/*
>>  	 * In case of -EBUSY, we'd like to know which page causes problem.
>>  	 * So, just fall through. test_pages_isolated() has a tracepoint
>> diff --git a/mm/page_isolation.c b/mm/page_isolation.c
>> index 63a3db10a8c0..8dfa6c6c668d 100644
>> --- a/mm/page_isolation.c
>> +++ b/mm/page_isolation.c
>> @@ -19,8 +19,8 @@ static int set_migratetype_isolate(struct page *page, int migratetype, int isol_
>>  {
>>  	struct page *unmovable = NULL;
>>  	struct zone *zone;
>> -	unsigned long flags;
>> -	int ret = -EBUSY;
>> +	unsigned long flags, nr_pages;
>> +	int ret = -EBUSY, mt;
>>  
>>  	zone = page_zone(page);
>>  
>> @@ -39,24 +39,18 @@ static int set_migratetype_isolate(struct page *page, int migratetype, int isol_
>>  	 * We just check MOVABLE pages.
>>  	 */
>>  	unmovable = has_unmovable_pages(zone, page, migratetype, isol_flags);
>> -	if (!unmovable) {
>> -		unsigned long nr_pages;
>> -		int mt = get_pageblock_migratetype(page);
>> -
>> -		set_pageblock_migratetype(page, MIGRATE_ISOLATE);
>> -		zone->nr_isolate_pageblock++;
>> -		nr_pages = move_freepages_block(zone, page, MIGRATE_ISOLATE,
>> -									NULL);
>> -
>> -		__mod_zone_freepage_state(zone, -nr_pages, mt);
>> -		ret = 0;
>> -	}
>> +	if (unmovable)
>> +		goto out;
>>  
>> +	mt = get_pageblock_migratetype(page);
>> +	set_pageblock_migratetype(page, MIGRATE_ISOLATE);
>> +	zone->nr_isolate_pageblock++;
>> +	nr_pages = move_freepages_block(zone, page, MIGRATE_ISOLATE, NULL);
>> +	__mod_zone_freepage_state(zone, -nr_pages, mt);
>> +	ret = 0;
>>  out:
>>  	spin_unlock_irqrestore(&zone->lock, flags);
>> -	if (!ret) {
>> -		drain_all_pages(zone);
>> -	} else {
>> +	if (ret) {
>>  		WARN_ON_ONCE(zone_idx(zone) == ZONE_MOVABLE);
>>  

There are patches in -mm/-next by me that already cleanup/reshuffle that
code heavily, so better just keep the changes minimal or built up on top
of -next.

>>  		if ((isol_flags & REPORT_FAILURE) && unmovable)
>> @@ -170,14 +164,6 @@ __first_valid_page(unsigned long pfn, unsigned long nr_pages)
>>   * pageblocks we may have modified and return -EBUSY to caller. This
>>   * prevents two threads from simultaneously working on overlapping ranges.
>>   *
>> - * Please note that there is no strong synchronization with the page allocator
>> - * either. Pages might be freed while their page blocks are marked ISOLATED.
>> - * In some cases pages might still end up on pcp lists and that would allow
>> - * for their allocation even when they are in fact isolated already. Depending
>> - * on how strong of a guarantee the caller needs drain_all_pages might be needed
>> - * (e.g. __offline_pages will need to call it after check for isolated range for
>> - * a next retry).
>> - *
>>   * Return: the number of isolated pageblocks on success and -EBUSY if any part
>>   * of range cannot be isolated.
>>   */
>> @@ -192,9 +178,7 @@ int start_isolate_page_range(unsigned long start_pfn, unsigned long end_pfn,
>>  	BUG_ON(!IS_ALIGNED(start_pfn, pageblock_nr_pages));
>>  	BUG_ON(!IS_ALIGNED(end_pfn, pageblock_nr_pages));
>>  
>> -	for (pfn = start_pfn;
>> -	     pfn < end_pfn;
>> -	     pfn += pageblock_nr_pages) {
>> +	for (pfn = start_pfn; pfn < end_pfn; pfn += pageblock_nr_pages) {

unnecessary code churn.

>>  		page = __first_valid_page(pfn, pageblock_nr_pages);
>>  		if (page) {
>>  			if (set_migratetype_isolate(page, migratetype, flags)) {
>> -- 
>> 2.25.1
>>
> 


-- 
Thanks,

David / dhildenb

