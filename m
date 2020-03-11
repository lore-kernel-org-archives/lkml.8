Return-Path: <SRS0=Ktsx=44=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A319FC10DCE
	for <linux-kernel@archiver.kernel.org>; Wed, 11 Mar 2020 01:17:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7287F20727
	for <linux-kernel@archiver.kernel.org>; Wed, 11 Mar 2020 01:17:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727925AbgCKBRT (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 10 Mar 2020 21:17:19 -0400
Received: from out30-131.freemail.mail.aliyun.com ([115.124.30.131]:43914 "EHLO
        out30-131.freemail.mail.aliyun.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727484AbgCKBRT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Mar 2020 21:17:19 -0400
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R381e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=e01e04407;MF=richard.weiyang@linux.alibaba.com;NM=1;PH=DS;RN=6;SR=0;TI=SMTPD_---0TsFZ44m_1583889435;
Received: from localhost(mailfrom:richard.weiyang@linux.alibaba.com fp:SMTPD_---0TsFZ44m_1583889435)
          by smtp.aliyun-inc.com(127.0.0.1);
          Wed, 11 Mar 2020 09:17:15 +0800
Date:   Wed, 11 Mar 2020 09:17:15 +0800
From:   Wei Yang <richard.weiyang@linux.alibaba.com>
To:     Tim Chen <tim.c.chen@linux.intel.com>
Cc:     Wei Yang <richard.weiyang@gmail.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Wei Yang <richard.weiyang@linux.alibaba.com>,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] mm/swap_slots.c: don't reset the cache slot after use
Message-ID: <20200311011715.GA47198@L-31X9LVDL-1304.local>
Reply-To: Wei Yang <richard.weiyang@linux.alibaba.com>
References: <20200309090940.34130-1-richard.weiyang@linux.alibaba.com>
 <20200309174854.b6b8c7f019c3dde048c28f94@linux-foundation.org>
 <005f7454-16db-e8b5-dde2-8f2ddaa42932@linux.intel.com>
 <20200310222002.lr2vurqfk6jvfo2z@master>
 <d851c5c9-7fc0-0959-e5c9-1a62f0341cb7@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <d851c5c9-7fc0-0959-e5c9-1a62f0341cb7@linux.intel.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Mar 10, 2020 at 04:03:07PM -0700, Tim Chen wrote:
>On 3/10/20 3:20 PM, Wei Yang wrote:
>> On Tue, Mar 10, 2020 at 11:13:13AM -0700, Tim Chen wrote:
>>> On 3/9/20 5:48 PM, Andrew Morton wrote:
>>>> On Mon,  9 Mar 2020 17:09:40 +0800 Wei Yang <richard.weiyang@linux.alibaba.com> wrote:
>>>>
>>>>> Currently we would clear the cache slot if it is used. While this is not
>>>>> necessary, since this entry would not be used until refilled.
>>>>>
>>>>> Leave it untouched and assigned the value directly to entry which makes
>>>>> the code little more neat.
>>>>>
>>>>> Also this patch merges the else and if, since this is the only case we
>>>>> refill and repeat swap cache.
>>>>
>>>> cc Tim, who can hopefully remember how this code works ;)
>>>>
>>>>> --- a/mm/swap_slots.c
>>>>> +++ b/mm/swap_slots.c
>>>>> @@ -309,7 +309,7 @@ int free_swap_slot(swp_entry_t entry)
>>>>>  
>>>>>  swp_entry_t get_swap_page(struct page *page)
>>>>>  {
>>>>> -	swp_entry_t entry, *pentry;
>>>>> +	swp_entry_t entry;
>>>>>  	struct swap_slots_cache *cache;
>>>>>  
>>>>>  	entry.val = 0;
>>>>> @@ -336,13 +336,10 @@ swp_entry_t get_swap_page(struct page *page)
>>>>>  		if (cache->slots) {
>>>>>  repeat:
>>>>>  			if (cache->nr) {
>>>>> -				pentry = &cache->slots[cache->cur++];
>>>>> -				entry = *pentry;
>>>>> -				pentry->val = 0;
>>>
>>> The cache entry was cleared after assignment for defensive programming,  So there's
>>> little chance I will be using a slot that has been assigned to someone else.
>>> When I wrote swap_slots.c, this code was new and I want to make sure
>>> that if something went wrong, and I assigned a swap slot that I shouldn't,
>>> I will be able to detect quickly as I will only be stepping on entry 0.
>>>
>>> Otherwise such bug will be harder to detect as we will have two users of some random
>>> swap slot stepping on each other.
>>>
>>> I'm okay if we want to get rid of this logic, now that the code has been
>>> working correctly long enough.  But I think is good hygiene to clear the
>>> cached entry after it has been assigned. 
>>>
>> 
>> This is fine to keep the logic, while I am wondering whether we need to do
>> this through pointer. cache->slots[] contain the value, we can get and reset
>> without pointer.
>> 
>> The following code looks more obvious about the logic.
>> 
>> 		entry = cache->slots[cache->cur];
>> 		cache->slots[cache->cur++].val = 0;
>
>Yes, this looks pretty good.

Thanks, I would rephrase v2.

>
>Thanks.
>
>Tim

-- 
Wei Yang
Help you, Help me
