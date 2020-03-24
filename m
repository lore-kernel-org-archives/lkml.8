Return-Path: <SRS0=tn8d=5J=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,USER_AGENT_SANE_1
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8D07DC43331
	for <linux-kernel@archiver.kernel.org>; Tue, 24 Mar 2020 17:17:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6E6B72080C
	for <linux-kernel@archiver.kernel.org>; Tue, 24 Mar 2020 17:17:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727865AbgCXRRW (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 24 Mar 2020 13:17:22 -0400
Received: from out30-132.freemail.mail.aliyun.com ([115.124.30.132]:34506 "EHLO
        out30-132.freemail.mail.aliyun.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727223AbgCXRRW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 Mar 2020 13:17:22 -0400
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R251e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=e01e04357;MF=yang.shi@linux.alibaba.com;NM=1;PH=DS;RN=7;SR=0;TI=SMTPD_---0TtXVszC_1585070234;
Received: from US-143344MP.local(mailfrom:yang.shi@linux.alibaba.com fp:SMTPD_---0TtXVszC_1585070234)
          by smtp.aliyun-inc.com(127.0.0.1);
          Wed, 25 Mar 2020 01:17:17 +0800
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
From:   Yang Shi <yang.shi@linux.alibaba.com>
Message-ID: <99b78cdb-5a4d-e28b-4464-d34ee39e5501@linux.alibaba.com>
Date:   Tue, 24 Mar 2020 10:17:13 -0700
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.12; rv:52.0)
 Gecko/20100101 Thunderbird/52.7.0
MIME-Version: 1.0
In-Reply-To: <20200319104938.vphyajoyz6ob6jtl@box>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 3/19/20 3:49 AM, Kirill A. Shutemov wrote:
> On Wed, Mar 18, 2020 at 10:39:21PM -0700, Yang Shi wrote:
>>
>> On 3/18/20 5:55 PM, Yang Shi wrote:
>>>
>>> On 3/18/20 5:12 PM, Kirill A. Shutemov wrote:
>>>> On Thu, Mar 19, 2020 at 07:19:42AM +0800, Yang Shi wrote:
>>>>> When khugepaged collapses anonymous pages, the base pages would
>>>>> be freed
>>>>> via pagevec or free_page_and_swap_cache().  But, the anonymous page may
>>>>> be added back to LRU, then it might result in the below race:
>>>>>
>>>>>      CPU A                CPU B
>>>>> khugepaged:
>>>>>     unlock page
>>>>>     putback_lru_page
>>>>>       add to lru
>>>>>                  page reclaim:
>>>>>                    isolate this page
>>>>>                    try_to_unmap
>>>>>     page_remove_rmap <-- corrupt _mapcount
>>>>>
>>>>> It looks nothing would prevent the pages from isolating by reclaimer.
>>>> Hm. Why should it?
>>>>
>>>> try_to_unmap() doesn't exclude parallel page unmapping. _mapcount is
>>>> protected by ptl. And this particular _mapcount pin is reachable for
>>>> reclaim as it's not part of usual page table tree. Basically
>>>> try_to_unmap() will never succeeds until we give up the _mapcount on
>>>> khugepaged side.
>>> I don't quite get. What does "not part of usual page table tree" means?
>>>
>>> How's about try_to_unmap() acquires ptl before khugepaged?
> The page table we are dealing with was detached from the process' page
> table tree: see pmdp_collapse_flush(). try_to_unmap() will not see the
> pte.

A follow-up question here. pmdp_collapse_flush() clears pmd entry and 
does TLB shootdown on x86. I'm supposed the main purpose is to serialize 
fast gup since it doesn't acquire any lock (mmap_sem, ptl ,etc), but 
disable interrupt so the TLB shootdown IPI would get blocked. This could 
guarantee synchronization on x86, but it looks not all architectures do 
TLB shootdown or implement it via IPI, so how they could serialize with 
fast gup?

In addition it looks acquiring pmd lock is not necessary. Before both 
write mmap_sem and write anon_vma lock are acquired which could 
serialize page fault and rmap walk, so it looks fast gup is the only one 
which could run concurrently, but fast gup doesn't acquire ptl at all. 
It seems the pmd_lock/unlock could be removed.

>
> try_to_unmap() can only reach the ptl if split ptl is disabled
> (mm->page_table_lock is used), but it still will not be able to reach pte.
>
>>>> I don't see the issue right away.
>>>>
>>>>> The other problem is the page's active or unevictable flag might be
>>>>> still set when freeing the page via free_page_and_swap_cache().
>>>> So what?
>>> The flags may leak to page free path then kernel may complain if
>>> DEBUG_VM is set.
> Could you elaborate on what codepath you are talking about?
>
>>>>> The putback_lru_page() would not clear those two flags if the pages are
>>>>> released via pagevec, it sounds nothing prevents from isolating active
>> Sorry, this is a typo. If the page is freed via pagevec, active and
>> unevictable flag would get cleared before freeing by page_off_lru().
>>
>> But, if the page is freed by free_page_and_swap_cache(), these two flags are
>> not cleared. But, it seems this path is hit rare, the pages are freed by
>> pagevec for the most cases.
>>
>>>>> or unevictable pages.
>>>> Again, why should it? vmscan is equipped to deal with this.
>>> I don't mean vmscan, I mean khugepaged may isolate active and
>>> unevictable pages since it just simply walks page table.
> Why it is wrong? lru_cache_add() only complains if both flags set, it
> shouldn't happen.
>
>>>>> However I didn't really run into these problems, just in theory
>>>>> by visual
>>>>> inspection.
>>>>>
>>>>> And, it also seems unnecessary to have the pages add back to LRU
>>>>> again since
>>>>> they are about to be freed when reaching this point.  So,
>>>>> clearing active
>>>>> and unevictable flags, unlocking and dropping refcount from isolate
>>>>> instead of calling putback_lru_page() as what page cache collapse does.
>>>> Hm? But we do call putback_lru_page() on the way out. I do not follow.
>>> It just calls putback_lru_page() at error path, not success path.
>>> Putting pages back to lru on error path definitely makes sense. Here it
>>> is the success path.
> I agree that putting the apage on LRU just before free the page is
> suboptimal, but I don't see it as a critical issue.
>
>

