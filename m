Return-Path: <SRS0=Fjb+=5D=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	UNPARSEABLE_RELAY,USER_AGENT_SANE_1 autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 865E2C4332E
	for <linux-kernel@archiver.kernel.org>; Wed, 18 Mar 2020 23:47:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 675C62076C
	for <linux-kernel@archiver.kernel.org>; Wed, 18 Mar 2020 23:47:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727127AbgCRXrx (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 18 Mar 2020 19:47:53 -0400
Received: from out30-54.freemail.mail.aliyun.com ([115.124.30.54]:55879 "EHLO
        out30-54.freemail.mail.aliyun.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726647AbgCRXrx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Mar 2020 19:47:53 -0400
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R111e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=e01f04455;MF=yang.shi@linux.alibaba.com;NM=1;PH=DS;RN=7;SR=0;TI=SMTPD_---0Tt-1t37_1584575263;
Received: from US-143344MP.local(mailfrom:yang.shi@linux.alibaba.com fp:SMTPD_---0Tt-1t37_1584575263)
          by smtp.aliyun-inc.com(127.0.0.1);
          Thu, 19 Mar 2020 07:47:46 +0800
Subject: Re: [PATCH] mm: khugepaged: fix potential page state corruption
To:     "Kirill A. Shutemov" <kirill@shutemov.name>
Cc:     kirill.shutemov@linux.intel.com, hughd@google.com,
        aarcange@redhat.com, akpm@linux-foundation.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
References: <1584573582-116702-1-git-send-email-yang.shi@linux.alibaba.com>
 <20200318234036.aw3awl25gxrjd2jl@box>
From:   Yang Shi <yang.shi@linux.alibaba.com>
Message-ID: <b7891211-a08a-453f-83c4-76889d6ec9fe@linux.alibaba.com>
Date:   Wed, 18 Mar 2020 16:47:42 -0700
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.12; rv:52.0)
 Gecko/20100101 Thunderbird/52.7.0
MIME-Version: 1.0
In-Reply-To: <20200318234036.aw3awl25gxrjd2jl@box>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 3/18/20 4:40 PM, Kirill A. Shutemov wrote:
> On Thu, Mar 19, 2020 at 07:19:42AM +0800, Yang Shi wrote:
>> When khugepaged collapses anonymous pages, the base pages would be freed
>> via pagevec or free_page_and_swap_cache().  But, the anonymous page may
>> be added back to LRU, then it might result in the below race:
>>
>> 	CPU A				CPU B
>> khugepaged:
>>    unlock page
>>    putback_lru_page
>>      add to lru
>> 				page reclaim:
>> 				  isolate this page
>> 				  try_to_unmap
>>    page_remove_rmap <-- corrupt _mapcount
>>
>> It looks nothing would prevent the pages from isolating by reclaimer.
>>
>> The other problem is the page's active or unevictable flag might be
>> still set when freeing the page via free_page_and_swap_cache().  The
>> putback_lru_page() would not clear those two flags if the pages are
>> released via pagevec, it sounds nothing prevents from isolating active
>> or unevictable pages.
>>
>> However I didn't really run into these problems, just in theory by visual
>> inspection.
>>
>> And, it also seems unnecessary to have the pages add back to LRU again since
>> they are about to be freed when reaching this point.  So, clearing active
>> and unevictable flags, unlocking and dropping refcount from isolate
>> instead of calling putback_lru_page() as what page cache collapse does.
>>
>> Cc: Kirill A. Shutemov <kirill.shutemov@linux.intel.com>
>> Cc: Hugh Dickins <hughd@google.com>
>> Cc: Andrea Arcangeli <aarcange@redhat.com>
>> Signed-off-by: Yang Shi <yang.shi@linux.alibaba.com>
>> ---
>>   mm/khugepaged.c | 10 +++++++++-
>>   1 file changed, 9 insertions(+), 1 deletion(-)
>>
>> diff --git a/mm/khugepaged.c b/mm/khugepaged.c
>> index b679908..f42fa4e 100644
>> --- a/mm/khugepaged.c
>> +++ b/mm/khugepaged.c
>> @@ -673,7 +673,6 @@ static void __collapse_huge_page_copy(pte_t *pte, struct page *page,
>>   			src_page = pte_page(pteval);
>>   			copy_user_highpage(page, src_page, address, vma);
>>   			VM_BUG_ON_PAGE(page_mapcount(src_page) != 1, src_page);
>> -			release_pte_page(src_page);
>>   			/*
>>   			 * ptl mostly unnecessary, but preempt has to
>>   			 * be disabled to update the per-cpu stats
>> @@ -687,6 +686,15 @@ static void __collapse_huge_page_copy(pte_t *pte, struct page *page,
>>   			pte_clear(vma->vm_mm, address, _pte);
>>   			page_remove_rmap(src_page, false);
>>   			spin_unlock(ptl);
>> +
>> +			dec_node_page_state(src_page,
>> +				NR_ISOLATED_ANON + page_is_file_cache(src_page));
>> +			ClearPageActive(src_page);
>> +			ClearPageUnevictable(src_page);
>> +			unlock_page(src_page);
>> +			/* Drop refcount from isolate */
>> +			put_page(src_page);
>> +
>>   			free_page_and_swap_cache(src_page);
>>   		}
>>   	}
> I will look at this closer tomorrow, but looks like an easier fix is to
> move release_pte_page() under ptl that we take just after it.

Thanks, Kirill. However, it looks putting the page back to lru is not 
necessary. And, it also sounds not very efficient to do this under ptl 
IMHO since it may spins to wait for lru lock.

>

