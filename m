Return-Path: <SRS0=Xzqw=5F=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,USER_AGENT_SANE_1
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A29B5C4332B
	for <linux-kernel@archiver.kernel.org>; Fri, 20 Mar 2020 16:34:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7E32320767
	for <linux-kernel@archiver.kernel.org>; Fri, 20 Mar 2020 16:34:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727587AbgCTQea (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 20 Mar 2020 12:34:30 -0400
Received: from out30-43.freemail.mail.aliyun.com ([115.124.30.43]:52179 "EHLO
        out30-43.freemail.mail.aliyun.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727163AbgCTQe3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 Mar 2020 12:34:29 -0400
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R261e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=e01f04391;MF=yang.shi@linux.alibaba.com;NM=1;PH=DS;RN=7;SR=0;TI=SMTPD_---0Tt7jLIR_1584722063;
Received: from US-143344MP.local(mailfrom:yang.shi@linux.alibaba.com fp:SMTPD_---0Tt7jLIR_1584722063)
          by smtp.aliyun-inc.com(127.0.0.1);
          Sat, 21 Mar 2020 00:34:25 +0800
Subject: Re: [PATCH] mm: khugepaged: fix potential page state corruption
To:     "Kirill A. Shutemov" <kirill@shutemov.name>
Cc:     kirill.shutemov@linux.intel.com, hughd@google.com,
        aarcange@redhat.com, akpm@linux-foundation.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
References: <1584573582-116702-1-git-send-email-yang.shi@linux.alibaba.com>
 <20200319001258.creziw6ffw4jvwl3@box>
 <2cdc734c-c222-4b9d-9114-1762b29dafb4@linux.alibaba.com>
 <db660bef-c927-b793-7a79-a88df197a756@linux.alibaba.com>
 <20200319104938.vphyajoyz6ob6jtl@box>
 <e716c8c6-898e-5199-019c-161ea3ec06c3@linux.alibaba.com>
 <20200320114536.brigxjkgjmxyhdu5@box>
From:   Yang Shi <yang.shi@linux.alibaba.com>
Message-ID: <552f0725-42ff-c09d-592c-3e433b71edbb@linux.alibaba.com>
Date:   Fri, 20 Mar 2020 09:34:21 -0700
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.12; rv:52.0)
 Gecko/20100101 Thunderbird/52.7.0
MIME-Version: 1.0
In-Reply-To: <20200320114536.brigxjkgjmxyhdu5@box>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 3/20/20 4:45 AM, Kirill A. Shutemov wrote:
> On Thu, Mar 19, 2020 at 09:57:47AM -0700, Yang Shi wrote:
>>
>> On 3/19/20 3:49 AM, Kirill A. Shutemov wrote:
>>> On Wed, Mar 18, 2020 at 10:39:21PM -0700, Yang Shi wrote:
>>>> On 3/18/20 5:55 PM, Yang Shi wrote:
>>>>> On 3/18/20 5:12 PM, Kirill A. Shutemov wrote:
>>>>>> On Thu, Mar 19, 2020 at 07:19:42AM +0800, Yang Shi wrote:
>>>>>>> When khugepaged collapses anonymous pages, the base pages would
>>>>>>> be freed
>>>>>>> via pagevec or free_page_and_swap_cache().  But, the anonymous page may
>>>>>>> be added back to LRU, then it might result in the below race:
>>>>>>>
>>>>>>>       CPU A                CPU B
>>>>>>> khugepaged:
>>>>>>>      unlock page
>>>>>>>      putback_lru_page
>>>>>>>        add to lru
>>>>>>>                   page reclaim:
>>>>>>>                     isolate this page
>>>>>>>                     try_to_unmap
>>>>>>>      page_remove_rmap <-- corrupt _mapcount
>>>>>>>
>>>>>>> It looks nothing would prevent the pages from isolating by reclaimer.
>>>>>> Hm. Why should it?
>>>>>>
>>>>>> try_to_unmap() doesn't exclude parallel page unmapping. _mapcount is
>>>>>> protected by ptl. And this particular _mapcount pin is reachable for
>>>>>> reclaim as it's not part of usual page table tree. Basically
>>>>>> try_to_unmap() will never succeeds until we give up the _mapcount on
>>>>>> khugepaged side.
>>>>> I don't quite get. What does "not part of usual page table tree" means?
>>>>>
>>>>> How's about try_to_unmap() acquires ptl before khugepaged?
>>> The page table we are dealing with was detached from the process' page
>>> table tree: see pmdp_collapse_flush(). try_to_unmap() will not see the
>>> pte.
>>>
>>> try_to_unmap() can only reach the ptl if split ptl is disabled
>>> (mm->page_table_lock is used), but it still will not be able to reach pte.
>> Aha, got it. Thanks for explaining. I definitely missed this point. Yes,
>> pmdp_collapse_flush() would clear the pmd, then others won't see the page
>> table.
>>
>> However, it looks the vmscan would not stop at try_to_unmap() at all,
>> try_to_unmap() would just return true since pmd_present() should return
>> false in pvmw. Then it would go all the way down to __remove_mapping(), but
>> freezing the page would fail since try_to_unmap() doesn't actually drop the
>> refcount from the pte map.
> No. try_to_unmap() checks mapcount at the end and only returns true if
> it's zero.

Aha, yes, you are right. It does check mapcount. It would not go that far.

>
>> It would not result in any critical problem AFAICT, but suboptimal and it
>> may causes some unnecessary I/O due to swap.
>>
>>>>>> I don't see the issue right away.
>>>>>>
>>>>>>> The other problem is the page's active or unevictable flag might be
>>>>>>> still set when freeing the page via free_page_and_swap_cache().
>>>>>> So what?
>>>>> The flags may leak to page free path then kernel may complain if
>>>>> DEBUG_VM is set.
>>> Could you elaborate on what codepath you are talking about?
>> __put_page ->
>>      __put_single_page ->
>>          free_unref_page ->
>>              put_unref_page_prepare ->
>>                  free_pcp_prepare ->
>>                      free_pages_prepare ->
>>                          free_pages_check
>>
>> This check would just be run when DEBUG_VM is enabled.
> I'm not 100% sure, but I belive these flags will ge cleared on adding into
> lru:
>
>    release_pte_page()
>      putback_lru_page()
>        lru_cache_add()
>         __lru_cache_add()
>           __pagevec_lru_add()
> 	   __pagevec_lru_add_fn()
> 	     __pagevec_lru_add_fn()

No, adding into lru would not clear the flags. But, I finally found 
where they get cleared. They get cleared by:

__put_single_page() ->
     __page_cache_release() ->
         if page is lru
         del_page_from_lru_list(page, lruvec, page_off_lru(page));

page_off_lru() would clear active and unevictable flags.

The name (__page_cache_release) sounds a little bit confusing I 
misunderstood it just would done something for page cache.

So, it looks the code does depend on putting page back to lru to release 
it. Nothing is wrong, just a little bit unproductive IMHO. Sorry for the 
rash patch. And thank you for your time again.

>

