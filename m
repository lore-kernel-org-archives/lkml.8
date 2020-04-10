Return-Path: <SRS0=VV4q=52=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	UNPARSEABLE_RELAY,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 81F3EC2BA19
	for <linux-kernel@archiver.kernel.org>; Fri, 10 Apr 2020 00:03:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5C34A20768
	for <linux-kernel@archiver.kernel.org>; Fri, 10 Apr 2020 00:03:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726965AbgDJADG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 9 Apr 2020 20:03:06 -0400
Received: from out30-132.freemail.mail.aliyun.com ([115.124.30.132]:32918 "EHLO
        out30-132.freemail.mail.aliyun.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726327AbgDJADG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Apr 2020 20:03:06 -0400
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R381e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=e01f04397;MF=yang.shi@linux.alibaba.com;NM=1;PH=DS;RN=7;SR=0;TI=SMTPD_---0Tv4dqDG_1586476980;
Received: from US-143344MP.local(mailfrom:yang.shi@linux.alibaba.com fp:SMTPD_---0Tv4dqDG_1586476980)
          by smtp.aliyun-inc.com(127.0.0.1);
          Fri, 10 Apr 2020 08:03:03 +0800
Subject: Re: [PATCHv2 5/8] khugepaged: Allow to callapse a page shared across
 fork
From:   Yang Shi <yang.shi@linux.alibaba.com>
To:     "Kirill A. Shutemov" <kirill@shutemov.name>
Cc:     akpm@linux-foundation.org, Andrea Arcangeli <aarcange@redhat.com>,
        Zi Yan <ziy@nvidia.com>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org,
        "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>
References: <20200403112928.19742-1-kirill.shutemov@linux.intel.com>
 <20200403112928.19742-6-kirill.shutemov@linux.intel.com>
 <b03643ba-8411-8486-737c-1bc29dd10a74@linux.alibaba.com>
 <20200408131044.xzlheacvslrbwrja@box>
 <107630f5-bbde-3f78-23e9-6f6b3113d709@linux.alibaba.com>
Message-ID: <61569ead-2bbd-6d18-c04c-3251218a3fcd@linux.alibaba.com>
Date:   Thu, 9 Apr 2020 17:03:00 -0700
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.12; rv:52.0)
 Gecko/20100101 Thunderbird/52.7.0
MIME-Version: 1.0
In-Reply-To: <107630f5-bbde-3f78-23e9-6f6b3113d709@linux.alibaba.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 4/8/20 11:51 AM, Yang Shi wrote:
>
>
> On 4/8/20 6:10 AM, Kirill A. Shutemov wrote:
>> On Mon, Apr 06, 2020 at 01:50:56PM -0700, Yang Shi wrote:
>>>
>>> On 4/3/20 4:29 AM, Kirill A. Shutemov wrote:
>>>> The page can be included into collapse as long as it doesn't have 
>>>> extra
>>>> pins (from GUP or otherwise).
>>>>
>>>> Signed-off-by: Kirill A. Shutemov <kirill.shutemov@linux.intel.com>
>>>> ---
>>>>    mm/khugepaged.c | 25 ++++++++++++++-----------
>>>>    1 file changed, 14 insertions(+), 11 deletions(-)
>>>>
>>>> diff --git a/mm/khugepaged.c b/mm/khugepaged.c
>>>> index 57ff287caf6b..1e7e6543ebca 100644
>>>> --- a/mm/khugepaged.c
>>>> +++ b/mm/khugepaged.c
>>>> @@ -581,11 +581,18 @@ static int 
>>>> __collapse_huge_page_isolate(struct vm_area_struct *vma,
>>>>            }
>>>>            /*
>>>> -         * cannot use mapcount: can't collapse if there's a gup pin.
>>>> -         * The page must only be referenced by the scanned process
>>>> -         * and page swap cache.
>>>> +         * Check if the page has any GUP (or other external) pins.
>>>> +         *
>>>> +         * The page table that maps the page has been already 
>>>> unlinked
>>>> +         * from the page table tree and this process cannot get
>>>> +         * additinal pin on the page.
>>>> +         *
>>>> +         * New pins can come later if the page is shared across fork,
>>>> +         * but not for the this process. It is fine. The other 
>>>> process
>>>> +         * cannot write to the page, only trigger CoW.
>>>>             */
>>>> -        if (page_count(page) != 1 + PageSwapCache(page)) {
>>>> +        if (total_mapcount(page) + PageSwapCache(page) !=
>>>> +                page_count(page)) {
>>> This check looks fine for base page, but what if the page is 
>>> PTE-mapped THP?
>>> The following patch made this possible.
>>>
>>> If it is PTE-mapped THP and the page is in swap cache, the refcount 
>>> would be
>>> 512 + the number of PTE-mapped pages.
>>>
>>> Shall we do the below change in the following patch?
>>>
>>> extra_pins = PageSwapCache(page) ? nr_ccompound(page) - 1 : 0;
>>> if (total_mapcount(page) + PageSwapCache(page) != page_count(page) -
>>> extra_pins) {
>>> ...
>> Looks like you're right.
>>
>> It would be nice to have a test case to demonstrate the issue.
>>
>> Is there any way to trigger moving the page to swap cache? I don't 
>> see it
>> immediately.
>
> It sounds not easy to trigger since it totally depends on timing, I'm 
> wondering we may have to use MADV_PAGEOUT? Something below off the top 
> of my head may trigger this?
>
>
>     CPU       A                                    CPU    B         
>             CPU    C
> In parent:
> MADV_HUGEPAGE
> page fault to fill with THP
> fork
>                                                     In Child:
> MADV_NOHUGEPAGE
> MADV_DONTNEED (split pmd)
> MADV_PAGEOUT
>                                                             -> 
> add_to_swap
>                                 khugepaged scan parent and try to 
> collapse PTE-mapped
>
>                                                             -> 
> try_to_unmap
>
> When doing MADV_DONTNEED we need make sure head page is unmapped since 
> MADV_PAGEOUT would call page_mapcount(page) to skip shared mapping.

This can't trigger it since MADV_PAGEOUT would isolate the page from lru 
so khugepaged_scan_pmd() can't reach the refcount check at all.

If try_to_unmap() or pageout() fails, the page may stay in swap cache. 
But I didn't think of an easy way to make this happen.

>
>>
>

