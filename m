Return-Path: <SRS0=gmpU=CI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.7 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,NICE_REPLY_A,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 430F7C433E6
	for <linux-kernel@archiver.kernel.org>; Sun, 30 Aug 2020 08:31:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1EE5F20720
	for <linux-kernel@archiver.kernel.org>; Sun, 30 Aug 2020 08:31:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728671AbgH3Ibp (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 30 Aug 2020 04:31:45 -0400
Received: from out30-132.freemail.mail.aliyun.com ([115.124.30.132]:45870 "EHLO
        out30-132.freemail.mail.aliyun.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726078AbgH3Ibo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 30 Aug 2020 04:31:44 -0400
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R141e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=e01f04427;MF=alex.shi@linux.alibaba.com;NM=1;PH=DS;RN=4;SR=0;TI=SMTPD_---0U7FazRR_1598776298;
Received: from IT-FVFX43SYHV2H.local(mailfrom:alex.shi@linux.alibaba.com fp:SMTPD_---0U7FazRR_1598776298)
          by smtp.aliyun-inc.com(127.0.0.1);
          Sun, 30 Aug 2020 16:31:39 +0800
Subject: Re: [PATCH 1/2] mm: use
 add_page_to_lru_list()/page_lru()/page_off_lru()
To:     Yu Zhao <yuzhao@google.com>
Cc:     linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        Andrew Morton <akpm@linux-foundation.org>
References: <20200827234202.4027996-1-yuzhao@google.com>
 <20200829181213.GA838419@google.com>
From:   Alex Shi <alex.shi@linux.alibaba.com>
Message-ID: <fd72fd71-e049-f3e1-9e51-52eab6088cd4@linux.alibaba.com>
Date:   Sun, 30 Aug 2020 16:31:38 +0800
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:68.0)
 Gecko/20100101 Thunderbird/68.7.0
MIME-Version: 1.0
In-Reply-To: <20200829181213.GA838419@google.com>
Content-Type: text/plain; charset=gbk
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



ÔÚ 2020/8/30 ÉÏÎç2:12, Yu Zhao Ð´µÀ:
> On Thu, Aug 27, 2020 at 05:42:01PM -0600, Yu Zhao wrote:
>> This is a trivial but worth having clean-up patch. There should be
>> no side effects except page->lru is temporarily poisoned after it's
>> deleted but before it's added to the new list in move_pages_to_lru()
>> (which is not a problem).
>>
>> Signed-off-by: Yu Zhao <yuzhao@google.com>
> 
> Hi Alex, I just realized your
>   [v18,08/32] mm/vmscan: remove unnecessary lruvec adding
> at
>   https://patchwork.kernel.org/patch/11733123/
> also touches move_pages_to_lru(). I agree it's better not to add
> a page we are going to free to the list in the first place. The
> rest in this patch would be too trivial to be a separate one (on
> top of yours).
> 
> So would you mind taking of the clean-up too in your series? I'll
> drop this one then. Thanks.
> 
>> ---
>>  mm/swap.c   |  4 +---
>>  mm/vmscan.c | 14 ++++----------
>>  2 files changed, 5 insertions(+), 13 deletions(-)
>>
>> diff --git a/mm/swap.c b/mm/swap.c
>> index 40bf20a75278..2735ecf0f566 100644
>> --- a/mm/swap.c
>> +++ b/mm/swap.c
>> @@ -597,11 +597,9 @@ static void lru_lazyfree_fn(struct page *page, struct lruvec *lruvec,
>>  {
>>  	if (PageLRU(page) && PageAnon(page) && PageSwapBacked(page) &&
>>  	    !PageSwapCache(page) && !PageUnevictable(page)) {
>> -		bool active = PageActive(page);
>>  		int nr_pages = thp_nr_pages(page);
>>  
>> -		del_page_from_lru_list(page, lruvec,
>> -				       LRU_INACTIVE_ANON + active);
>> +		del_page_from_lru_list(page, lruvec, page_lru(page));
>>  		ClearPageActive(page);
>>  		ClearPageReferenced(page);
>>  		/*
>> diff --git a/mm/vmscan.c b/mm/vmscan.c
>> index 99e1796eb833..b479ced26cd3 100644
>> --- a/mm/vmscan.c
>> +++ b/mm/vmscan.c
>> @@ -1845,13 +1845,12 @@ static unsigned noinline_for_stack move_pages_to_lru(struct lruvec *lruvec,
>>  	int nr_pages, nr_moved = 0;
>>  	LIST_HEAD(pages_to_free);
>>  	struct page *page;
>> -	enum lru_list lru;
>>  
>>  	while (!list_empty(list)) {
>>  		page = lru_to_page(list);
>>  		VM_BUG_ON_PAGE(PageLRU(page), page);
>> +		list_del(&page->lru);
>>  		if (unlikely(!page_evictable(page))) {
>> -			list_del(&page->lru);
>>  			spin_unlock_irq(&pgdat->lru_lock);
>>  			putback_lru_page(page);
>>  			spin_lock_irq(&pgdat->lru_lock);
>> @@ -1860,16 +1859,10 @@ static unsigned noinline_for_stack move_pages_to_lru(struct lruvec *lruvec,
>>  		lruvec = mem_cgroup_page_lruvec(page, pgdat);
>>  
>>  		SetPageLRU(page);
>> -		lru = page_lru(page);
>> -
>> -		nr_pages = thp_nr_pages(page);
>> -		update_lru_size(lruvec, lru, page_zonenum(page), nr_pages);
>> -		list_move(&page->lru, &lruvec->lists[lru]);
>> +		add_page_to_lru_list(page, lruvec, page_lru(page));
>>  
>>  		if (put_page_testzero(page)) {
>> -			__ClearPageLRU(page);


it's interesting to know the PageLRU left has no bad impact in real life. 
it justs seems a path confliction with my that patch. 

>> -			__ClearPageActive(page);
>> -			del_page_from_lru_list(page, lruvec, lru);
>> +			del_page_from_lru_list(page, lruvec, page_off_lru(page));
>>  
>>  			if (unlikely(PageCompound(page))) {
>>  				spin_unlock_irq(&pgdat->lru_lock);
>> @@ -1878,6 +1871,7 @@ static unsigned noinline_for_stack move_pages_to_lru(struct lruvec *lruvec,
>>  			} else
>>  				list_add(&page->lru, &pages_to_free);
>>  		} else {
>> +			nr_pages = thp_nr_pages(page);
>>  			nr_moved += nr_pages;
>>  			if (PageActive(page))
>>  				workingset_age_nonresident(lruvec, nr_pages);
>> -- 
>> 2.28.0.402.g5ffc5be6b7-goog
>>
