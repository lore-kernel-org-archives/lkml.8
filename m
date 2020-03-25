Return-Path: <SRS0=vy7l=5K=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,USER_AGENT_SANE_1
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B3257C2D0E5
	for <linux-kernel@archiver.kernel.org>; Wed, 25 Mar 2020 18:42:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8EB85206F6
	for <linux-kernel@archiver.kernel.org>; Wed, 25 Mar 2020 18:42:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727384AbgCYSm0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 25 Mar 2020 14:42:26 -0400
Received: from out30-57.freemail.mail.aliyun.com ([115.124.30.57]:58180 "EHLO
        out30-57.freemail.mail.aliyun.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727006AbgCYSm0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 Mar 2020 14:42:26 -0400
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R141e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=e01f04397;MF=yang.shi@linux.alibaba.com;NM=1;PH=DS;RN=7;SR=0;TI=SMTPD_---0TtcrnzA_1585161726;
Received: from US-143344MP.local(mailfrom:yang.shi@linux.alibaba.com fp:SMTPD_---0TtcrnzA_1585161726)
          by smtp.aliyun-inc.com(127.0.0.1);
          Thu, 26 Mar 2020 02:42:22 +0800
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
 <99b78cdb-5a4d-e28b-4464-d34ee39e5501@linux.alibaba.com>
 <20200325112623.ur4owwbnow5c5mng@box>
From:   Yang Shi <yang.shi@linux.alibaba.com>
Message-ID: <2c5277bb-69cb-5395-cf35-596e94aa39ff@linux.alibaba.com>
Date:   Wed, 25 Mar 2020 11:42:05 -0700
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.12; rv:52.0)
 Gecko/20100101 Thunderbird/52.7.0
MIME-Version: 1.0
In-Reply-To: <20200325112623.ur4owwbnow5c5mng@box>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 3/25/20 4:26 AM, Kirill A. Shutemov wrote:
> On Tue, Mar 24, 2020 at 10:17:13AM -0700, Yang Shi wrote:
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
>> A follow-up question here. pmdp_collapse_flush() clears pmd entry and does
>> TLB shootdown on x86. I'm supposed the main purpose is to serialize fast gup
>> since it doesn't acquire any lock (mmap_sem, ptl ,etc), but disable
>> interrupt so the TLB shootdown IPI would get blocked. This could guarantee
>> synchronization on x86, but it looks not all architectures do TLB shootdown
>> or implement it via IPI, so how they could serialize with fast gup?
> The main purpose of pmdp_collapse_flush() is to block access to pages
> under collapse, including access via GUP (and its variants).
>
> It's up to architecture to implement it correctly, including TLB flush vs.
> GUP_fast serialization. Genetic way works fine for most architectures.
> Notable exceptions are Power and S390.

Thanks. I was wondering how Power and S390 serialized it. It looks they 
didn't deal with it at all.

>> In addition it looks acquiring pmd lock is not necessary. Before both write
>> mmap_sem and write anon_vma lock are acquired which could serialize page
>> fault and rmap walk, so it looks fast gup is the only one which could run
>> concurrently, but fast gup doesn't acquire ptl at all. It seems the
>> pmd_lock/unlock could be removed.
> This is likely true. And we have a comment there. But taking uncontended
> lock is check, so why not.

Yes, it sounds not harmful.

>

