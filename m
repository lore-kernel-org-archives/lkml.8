Return-Path: <SRS0=nvtT=6P=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	UNPARSEABLE_RELAY,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 905AAC4724C
	for <linux-kernel@archiver.kernel.org>; Fri,  1 May 2020 17:00:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 74DF2206B8
	for <linux-kernel@archiver.kernel.org>; Fri,  1 May 2020 17:00:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729161AbgEARAf (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 1 May 2020 13:00:35 -0400
Received: from out30-42.freemail.mail.aliyun.com ([115.124.30.42]:56731 "EHLO
        out30-42.freemail.mail.aliyun.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1728841AbgEARAf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 May 2020 13:00:35 -0400
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R151e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=e01e01358;MF=yang.shi@linux.alibaba.com;NM=1;PH=DS;RN=7;SR=0;TI=SMTPD_---0TxBvIHa_1588352428;
Received: from US-143344MP.local(mailfrom:yang.shi@linux.alibaba.com fp:SMTPD_---0TxBvIHa_1588352428)
          by smtp.aliyun-inc.com(127.0.0.1);
          Sat, 02 May 2020 01:00:31 +0800
Subject: Re: [v2 linux-next PATCH 2/2] mm: khugepaged: don't have to put being
 freed page back to lru
To:     "Kirill A. Shutemov" <kirill@shutemov.name>
Cc:     kirill.shutemov@linux.intel.com, hughd@google.com,
        aarcange@redhat.com, akpm@linux-foundation.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
References: <1588279279-61908-1-git-send-email-yang.shi@linux.alibaba.com>
 <1588279279-61908-2-git-send-email-yang.shi@linux.alibaba.com>
 <20200501070424.a5uugk7am2yzzx4v@box>
From:   Yang Shi <yang.shi@linux.alibaba.com>
Message-ID: <ef98debf-d82d-4ca8-bdb6-352c459bb7cf@linux.alibaba.com>
Date:   Fri, 1 May 2020 10:00:24 -0700
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.12; rv:52.0)
 Gecko/20100101 Thunderbird/52.7.0
MIME-Version: 1.0
In-Reply-To: <20200501070424.a5uugk7am2yzzx4v@box>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 5/1/20 12:04 AM, Kirill A. Shutemov wrote:
> On Fri, May 01, 2020 at 04:41:19AM +0800, Yang Shi wrote:
>> When khugepaged successfully isolated and copied data from old page to
>> collapsed THP, the old page is about to be freed if its last mapcount
>> is gone.  So putting the page back to lru sounds not that productive in
>> this case since the page might be isolated by vmscan but it can't be
>> reclaimed by vmscan since it can't be unmapped by try_to_unmap() at all.
>>
>> Actually if khugepaged is the last user of this page so it can be freed
>> directly.  So, clearing active and unevictable flags, unlocking and
>> dropping refcount from isolate instead of calling putback_lru_page().
> Any reason putback_lru_page() cannot do it internally? I mean if it is
> page_count() == 1, free the page.

Because it seems putback_lru_page() is just called when the page is 
*not* about to be freed, for example compaction is aborted, migration is 
failed on some pages, etc.

I checked a couple of places, i.e. compaction, migration, vmscan. All 
these places free the page (i.e. old page is migrated to new page 
successfully) via put_page() without putting back to lru. So, it sounds 
free page in putback_lru_page() may never happen.

We could add this, but it sounds khugepaged would be the only path that 
may free page in putback_lru_page(). So, it sounds less confusing to 
follow other users IMHO.

>> Cc: Kirill A. Shutemov <kirill.shutemov@linux.intel.com>
>> Cc: Hugh Dickins <hughd@google.com>
>> Cc: Andrea Arcangeli <aarcange@redhat.com>
>> Signed-off-by: Yang Shi <yang.shi@linux.alibaba.com>
>> ---
>> v2: Check mapcount and skip putback lru if the last mapcount is gone
>>
>>   mm/khugepaged.c | 20 ++++++++++++++------
>>   1 file changed, 14 insertions(+), 6 deletions(-)
>>
>> diff --git a/mm/khugepaged.c b/mm/khugepaged.c
>> index 0c8d30b..1fdd677 100644
>> --- a/mm/khugepaged.c
>> +++ b/mm/khugepaged.c
>> @@ -559,10 +559,18 @@ void __khugepaged_exit(struct mm_struct *mm)
>>   static void release_pte_page(struct page *page)
>>   {
>>   	mod_node_page_state(page_pgdat(page),
>> -			NR_ISOLATED_ANON + page_is_file_lru(page),
>> -			-compound_nr(page));
>> -	unlock_page(page);
>> -	putback_lru_page(page);
>> +		NR_ISOLATED_ANON + page_is_file_lru(page), -compound_nr(page));
>> +
>> +	if (total_mapcount(page)) {
>> +		unlock_page(page);
>> +		putback_lru_page(page);
>> +	} else {
>> +		ClearPageActive(page);
>> +		ClearPageUnevictable(page);
>> +		unlock_page(page);
>> +		/* Drop refcount from isolate */
>> +		put_page(page);
>> +	}
>>   }
>>   
>>   static void release_pte_pages(pte_t *pte, pte_t *_pte,
>> @@ -771,8 +779,6 @@ static void __collapse_huge_page_copy(pte_t *pte, struct page *page,
>>   		} else {
>>   			src_page = pte_page(pteval);
>>   			copy_user_highpage(page, src_page, address, vma);
>> -			if (!PageCompound(src_page))
>> -				release_pte_page(src_page);
>>   			/*
>>   			 * ptl mostly unnecessary, but preempt has to
>>   			 * be disabled to update the per-cpu stats
>> @@ -786,6 +792,8 @@ static void __collapse_huge_page_copy(pte_t *pte, struct page *page,
>>   			pte_clear(vma->vm_mm, address, _pte);
>>   			page_remove_rmap(src_page, false);
>>   			spin_unlock(ptl);
>> +			if (!PageCompound(src_page))
>> +				release_pte_page(src_page);
>>   			free_page_and_swap_cache(src_page);
>>   		}
>>   	}
>> -- 
>> 1.8.3.1
>>
>>

