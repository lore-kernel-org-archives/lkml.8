Return-Path: <SRS0=ysYr=B3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,NICE_REPLY_A,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5443AC433DF
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Aug 2020 18:16:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2CA7920716
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Aug 2020 18:16:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390710AbgHQSQA (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 17 Aug 2020 14:16:00 -0400
Received: from mga05.intel.com ([192.55.52.43]:53457 "EHLO mga05.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2388227AbgHQQFx (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Aug 2020 12:05:53 -0400
IronPort-SDR: 97H/yG7LXi9tASIhyOHKtSnrZZ+jGXQa6Lemfh/hFK3XKH90G1znYBcjbmzt3m3QNk58gfDwxd
 Pzmi8YyRIfAw==
X-IronPort-AV: E=McAfee;i="6000,8403,9716"; a="239565311"
X-IronPort-AV: E=Sophos;i="5.76,324,1592895600"; 
   d="scan'208";a="239565311"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Aug 2020 09:05:50 -0700
IronPort-SDR: b8piYg15sWkJ3OMGV0crCNCfJtLE6bGfWamuDGzxHzL2LbpcHrOjtc6g0p6L/SA8rS+G2qAyUx
 5PDuvqN25s8g==
X-IronPort-AV: E=Sophos;i="5.76,324,1592895600"; 
   d="scan'208";a="440912281"
Received: from ahduyck-mobl1.amr.corp.intel.com (HELO [10.251.23.62]) ([10.251.23.62])
  by orsmga004-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Aug 2020 09:05:49 -0700
Subject: Re: [PATCH] mm/page_reporting: the "page" must not be the list head
To:     David Hildenbrand <david@redhat.com>,
        Wei Yang <richard.weiyang@linux.alibaba.com>,
        akpm@linux-foundation.org
Cc:     linux-mm@kvack.org, linux-kernel@vger.kernel.org
References: <20200817084836.29216-1-richard.weiyang@linux.alibaba.com>
 <fa97519b-a860-5fea-9511-2237f195caeb@redhat.com>
From:   Alexander Duyck <alexander.h.duyck@linux.intel.com>
Message-ID: <aaa56d83-2444-d74e-025a-508a2be6b772@linux.intel.com>
Date:   Mon, 17 Aug 2020 09:05:32 -0700
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.11.0
MIME-Version: 1.0
In-Reply-To: <fa97519b-a860-5fea-9511-2237f195caeb@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 8/17/2020 2:35 AM, David Hildenbrand wrote:
> On 17.08.20 10:48, Wei Yang wrote:
>> If "page" is the list head, list_for_each_entry_safe() would stop
>> iteration.
>>
>> Signed-off-by: Wei Yang <richard.weiyang@linux.alibaba.com>
>> ---
>>   mm/page_reporting.c | 2 +-
>>   1 file changed, 1 insertion(+), 1 deletion(-)
>>
>> diff --git a/mm/page_reporting.c b/mm/page_reporting.c
>> index 3bbd471cfc81..aaaa3605123d 100644
>> --- a/mm/page_reporting.c
>> +++ b/mm/page_reporting.c
>> @@ -178,7 +178,7 @@ page_reporting_cycle(struct page_reporting_dev_info *prdev, struct zone *zone,
>>   		 * the new head of the free list before we release the
>>   		 * zone lock.
>>   		 */
>> -		if (&page->lru != list && !list_is_first(&page->lru, list))
>> +		if (!list_is_first(&page->lru, list))
>>   			list_rotate_to_front(&page->lru, list);
>>   
>>   		/* release lock before waiting on report processing */
>>
> 
> Is this a fix or a cleanup? If it's a fix, can this be reproduced easily
> and what ere the effects?
> 

This should be a clean-up. Since the &page->lru != list will always be true.

If I recall at some point the that was a check for &next->lru != list 
but I think I pulled out an additional conditional check somewhere so 
that we just go through the start of the loop again and iterate over 
reported pages until we are guaranteed to have a non-reported page to 
rotate to the top of the list with the general idea being that we wanted 
the allocator to pull non-reported pages before reported pages.

