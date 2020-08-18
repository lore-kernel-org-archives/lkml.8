Return-Path: <SRS0=faA3=B4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.3 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,NICE_REPLY_A,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 25E8DC433DF
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Aug 2020 07:23:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id EDDBA205CB
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Aug 2020 07:23:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="BNuA6pPX"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726588AbgHRHXV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 18 Aug 2020 03:23:21 -0400
Received: from us-smtp-2.mimecast.com ([205.139.110.61]:52322 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726420AbgHRHXU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Aug 2020 03:23:20 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1597735397;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
        bh=OcV+C2ZGRLawXS8xBH4LRbibz87NwwD501W1V9YggXk=;
        b=BNuA6pPX3y/WPY9OUKkeuI08ZLWjR2fIzTm+iydYj3RxYmH3TCbaBPLUN/GJwAIG+Nl+A3
        cItwt98oA/88mnPuEUCq2FDkz3MVqOfu2ayQJeGxPnQCYolCQthnFwkUhJxiBNOUfBfybO
        VBlydGsIXGvLhg6ZtRHxJwn74aqAM48=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-204-tZ01xwtXN0KinkOxi7BQqg-1; Tue, 18 Aug 2020 03:23:16 -0400
X-MC-Unique: tZ01xwtXN0KinkOxi7BQqg-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com [10.5.11.12])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id E4EA418B9ED8;
        Tue, 18 Aug 2020 07:23:14 +0000 (UTC)
Received: from [10.36.113.168] (ovpn-113-168.ams2.redhat.com [10.36.113.168])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 72B23756BA;
        Tue, 18 Aug 2020 07:23:13 +0000 (UTC)
Subject: Re: [PATCH] mm/page_reporting: the "page" must not be the list head
To:     Wei Yang <richard.weiyang@linux.alibaba.com>
Cc:     Alexander Duyck <alexander.h.duyck@linux.intel.com>,
        akpm@linux-foundation.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
References: <20200817084836.29216-1-richard.weiyang@linux.alibaba.com>
 <fa97519b-a860-5fea-9511-2237f195caeb@redhat.com>
 <aaa56d83-2444-d74e-025a-508a2be6b772@linux.intel.com>
 <c362eb24-d4bc-82e8-e813-0951ce50b440@redhat.com>
 <20200818030558.GC29756@L-31X9LVDL-1304.local>
From:   David Hildenbrand <david@redhat.com>
Autocrypt: addr=david@redhat.com; prefer-encrypt=mutual; keydata=
 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
 WNyWQQ==
Organization: Red Hat GmbH
Message-ID: <9656b6cb-23c7-7875-85e7-6aeea7c9dc2c@redhat.com>
Date:   Tue, 18 Aug 2020 09:23:12 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20200818030558.GC29756@L-31X9LVDL-1304.local>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 18.08.20 05:05, Wei Yang wrote:
> On Mon, Aug 17, 2020 at 07:07:04PM +0200, David Hildenbrand wrote:
>> On 17.08.20 18:05, Alexander Duyck wrote:
>>>
>>>
>>> On 8/17/2020 2:35 AM, David Hildenbrand wrote:
>>>> On 17.08.20 10:48, Wei Yang wrote:
>>>>> If "page" is the list head, list_for_each_entry_safe() would stop
>>>>> iteration.
>>>>>
>>>>> Signed-off-by: Wei Yang <richard.weiyang@linux.alibaba.com>
>>>>> ---
>>>>>   mm/page_reporting.c | 2 +-
>>>>>   1 file changed, 1 insertion(+), 1 deletion(-)
>>>>>
>>>>> diff --git a/mm/page_reporting.c b/mm/page_reporting.c
>>>>> index 3bbd471cfc81..aaaa3605123d 100644
>>>>> --- a/mm/page_reporting.c
>>>>> +++ b/mm/page_reporting.c
>>>>> @@ -178,7 +178,7 @@ page_reporting_cycle(struct page_reporting_dev_info *prdev, struct zone *zone,
>>>>>   		 * the new head of the free list before we release the
>>>>>   		 * zone lock.
>>>>>   		 */
>>>>> -		if (&page->lru != list && !list_is_first(&page->lru, list))
>>>>> +		if (!list_is_first(&page->lru, list))
>>>>>   			list_rotate_to_front(&page->lru, list);
>>>>>   
>>>>>   		/* release lock before waiting on report processing */
>>>>>
>>>>
>>>> Is this a fix or a cleanup? If it's a fix, can this be reproduced easily
>>>> and what ere the effects?
>>>>
>>>
>>> This should be a clean-up. Since the &page->lru != list will always be true.
>>>
>>
>> Makes sense, maybe we can make that a little bit clearer in the patch
>> description.
>>
> 
> Ok, do you have some suggestion on the description?
> 
>    A clean-up for commit xxx?
> 
> I would appreciate your suggestion :-)
> 

I'd go with something like

"
mm/page_reporting: drop stale list head check in page_reporting_cycle

list_for_each_entry_safe() guarantees that we will never stumble over
the list head; "&page->lru != list" will always evaluate to true. Let's
simplify.
"

to stress that this is a pure simplifcation.

Reviewed-by: David Hildenbrand <david@redhat.com>

>>> If I recall at some point the that was a check for &next->lru != list 
>>> but I think I pulled out an additional conditional check somewhere so 
>>> that we just go through the start of the loop again and iterate over 
>>> reported pages until we are guaranteed to have a non-reported page to 
>>> rotate to the top of the list with the general idea being that we wanted 
>>> the allocator to pull non-reported pages before reported pages.
>>
>> -- 
>> Thanks,
>>
>> David / dhildenb
> 


-- 
Thanks,

David / dhildenb

