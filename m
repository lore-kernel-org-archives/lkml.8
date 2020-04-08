Return-Path: <SRS0=8dav=5Y=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	UNPARSEABLE_RELAY,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 91AF4C2D0F4
	for <linux-kernel@archiver.kernel.org>; Wed,  8 Apr 2020 18:43:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6E45B2072F
	for <linux-kernel@archiver.kernel.org>; Wed,  8 Apr 2020 18:43:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729272AbgDHSnE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 8 Apr 2020 14:43:04 -0400
Received: from out30-133.freemail.mail.aliyun.com ([115.124.30.133]:41845 "EHLO
        out30-133.freemail.mail.aliyun.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726860AbgDHSnE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Apr 2020 14:43:04 -0400
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R171e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=e01e04357;MF=yang.shi@linux.alibaba.com;NM=1;PH=DS;RN=7;SR=0;TI=SMTPD_---0Tv.3hCG_1586371377;
Received: from US-143344MP.local(mailfrom:yang.shi@linux.alibaba.com fp:SMTPD_---0Tv.3hCG_1586371377)
          by smtp.aliyun-inc.com(127.0.0.1);
          Thu, 09 Apr 2020 02:43:00 +0800
Subject: Re: [PATCHv2 4/8] khugepaged: Drain LRU add pagevec after swapin
To:     "Kirill A. Shutemov" <kirill@shutemov.name>
Cc:     akpm@linux-foundation.org, Andrea Arcangeli <aarcange@redhat.com>,
        Zi Yan <ziy@nvidia.com>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org,
        "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>
References: <20200403112928.19742-1-kirill.shutemov@linux.intel.com>
 <20200403112928.19742-5-kirill.shutemov@linux.intel.com>
 <620a61ed-be87-f60e-f562-379cd3adbe08@linux.alibaba.com>
 <20200408130532.ktztqf5fabo3x3cd@box>
From:   Yang Shi <yang.shi@linux.alibaba.com>
Message-ID: <4b63e949-16bc-f239-89ec-93898cb4d772@linux.alibaba.com>
Date:   Wed, 8 Apr 2020 11:42:55 -0700
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.12; rv:52.0)
 Gecko/20100101 Thunderbird/52.7.0
MIME-Version: 1.0
In-Reply-To: <20200408130532.ktztqf5fabo3x3cd@box>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 4/8/20 6:05 AM, Kirill A. Shutemov wrote:
> On Mon, Apr 06, 2020 at 11:29:11AM -0700, Yang Shi wrote:
>>
>> On 4/3/20 4:29 AM, Kirill A. Shutemov wrote:
>>> __collapse_huge_page_isolate() may fail due to extra pin in the LRU add
>>> pagevec. It's petty common for swapin case: we swap in pages just to
>>> fail due to the extra pin.
>>>
>>> Drain LRU add pagevec on sucessfull swapin.
>>>
>>> Signed-off-by: Kirill A. Shutemov <kirill.shutemov@linux.intel.com>
>>> ---
>>>    mm/khugepaged.c | 5 +++++
>>>    1 file changed, 5 insertions(+)
>>>
>>> diff --git a/mm/khugepaged.c b/mm/khugepaged.c
>>> index fdc10ffde1ca..57ff287caf6b 100644
>>> --- a/mm/khugepaged.c
>>> +++ b/mm/khugepaged.c
>>> @@ -940,6 +940,11 @@ static bool __collapse_huge_page_swapin(struct mm_struct *mm,
>>>    	}
>>>    	vmf.pte--;
>>>    	pte_unmap(vmf.pte);
>>> +
>>> +	/* Drain LRU add pagevec to remove extra pin on the swapped in pages */
>>> +	if (swapped_in)
>>> +		lru_add_drain();
>> There is already lru_add_drain() called in swap readahead path, please see
>> swap_vma_readahead() and swap_cluster_readahead().
> But not for synchronous case. See SWP_SYNCHRONOUS_IO branch in
> do_swap_page().

Aha, yes. I missed the synchronous case.

>
> Maybe we should drain it in swap_readpage() or in do_swap_page() after
> swap_readpage()? I donno.

It may be better to keep it as is. Draining lru for every page for 
synchronous case in do_swap_page() path sounds not very productive. 
Doing it in khugepaged seems acceptable. We just drain lru cache again 
for non-synchronous case, but the cache may be already empty so it 
should take very short time since nothing to drain.

>

