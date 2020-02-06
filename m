Return-Path: <SRS0=za8s=32=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 86982C352A2
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Feb 2020 09:48:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4FAED21775
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Feb 2020 09:48:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="UD/HSqt0"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728414AbgBFJsN (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 6 Feb 2020 04:48:13 -0500
Received: from us-smtp-1.mimecast.com ([205.139.110.61]:34760 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1727920AbgBFJsN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Feb 2020 04:48:13 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1580982491;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
        bh=b3Sa16O6S7mYTsGVq79uxSNEMYFXULKLZGjVdxPt36I=;
        b=UD/HSqt0ZfmMNdEQRczgvFuYAZP+zN6Q60cxSTZnaeBP3vlIseP+d3a3FZOl5UdSYHDpI2
        g2912ZyCH1uC603qri/5SijABV35OR0CNK3c6ZitN2Z5JUqVWQs9fwqyjA7IbIEUBDXBKn
        aAEvEBT7b5fb32tf9picxgZarIMGmUQ=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-208-DgSIUVOvM4a6fguYk1Jz7g-1; Thu, 06 Feb 2020 04:48:09 -0500
X-MC-Unique: DgSIUVOvM4a6fguYk1Jz7g-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com [10.5.11.16])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id E6CB61083E81;
        Thu,  6 Feb 2020 09:48:07 +0000 (UTC)
Received: from [10.36.117.188] (ovpn-117-188.ams2.redhat.com [10.36.117.188])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 330355C1B0;
        Thu,  6 Feb 2020 09:48:03 +0000 (UTC)
Subject: Re: [PATCH] mm/hotplug: Adjust shrink_zone_span() to keep the old
 logic
To:     Baoquan He <bhe@redhat.com>
Cc:     linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        akpm@linux-foundation.org, richardw.yang@linux.intel.com,
        mhocko@suse.com, osalvador@suse.de
References: <20200206053912.1211-1-bhe@redhat.com>
 <7ecaf36f-9f70-05bd-05fc-6dec82b7d559@redhat.com>
 <20200206093530.GO8965@MiWiFi-R3L-srv>
From:   David Hildenbrand <david@redhat.com>
Autocrypt: addr=david@redhat.com; prefer-encrypt=mutual; keydata=
 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
Organization: Red Hat GmbH
Message-ID: <f2b6b83d-8a96-2aef-f132-f66d7009df9c@redhat.com>
Date:   Thu, 6 Feb 2020 10:48:02 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.3.1
MIME-Version: 1.0
In-Reply-To: <20200206093530.GO8965@MiWiFi-R3L-srv>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 06.02.20 10:35, Baoquan He wrote:
> On 02/06/20 at 09:50am, David Hildenbrand wrote:
>> On 06.02.20 06:39, Baoquan He wrote:
>>> In commit 950b68d9178b ("mm/memory_hotplug: don't check for "all holes"
>>> in shrink_zone_span()"), the zone->zone_start_pfn/->spanned_pages
>>> resetting is moved into the if()/else if() branches, if the zone becomes
>>> empty. However the 2nd resetting code block may cause misunderstanding.
>>>
>>> So take the resetting codes out of the conditional checking and handling
>>> branches just as the old code does, the find_smallest_section_pfn()and
>>> find_biggest_section_pfn() searching have done the the same thing as
>>> the old for loop did, the logic is kept the same as the old code. This
>>> can remove the possible confusion.
>>>
>>> Signed-off-by: Baoquan He <bhe@redhat.com>
>>> ---
>>>  mm/memory_hotplug.c | 14 ++++++--------
>>>  1 file changed, 6 insertions(+), 8 deletions(-)
>>>
>>> diff --git a/mm/memory_hotplug.c b/mm/memory_hotplug.c
>>> index 089b6c826a9e..475d0d68a32c 100644
>>> --- a/mm/memory_hotplug.c
>>> +++ b/mm/memory_hotplug.c
>>> @@ -398,7 +398,7 @@ static unsigned long find_biggest_section_pfn(int nid, struct zone *zone,
>>>  static void shrink_zone_span(struct zone *zone, unsigned long start_pfn,
>>>  			     unsigned long end_pfn)
>>>  {
>>> -	unsigned long pfn;
>>> +	unsigned long pfn = zone->zone_start_pfn;
>>>  	int nid = zone_to_nid(zone);
>>>  
>>>  	zone_span_writelock(zone);
>>> @@ -414,9 +414,6 @@ static void shrink_zone_span(struct zone *zone, unsigned long start_pfn,
>>>  		if (pfn) {
>>>  			zone->spanned_pages = zone_end_pfn(zone) - pfn;
>>>  			zone->zone_start_pfn = pfn;
>>> -		} else {
>>> -			zone->zone_start_pfn = 0;
>>> -			zone->spanned_pages = 0;
>>>  		}
>>>  	} else if (zone_end_pfn(zone) == end_pfn) {
>>>  		/*
>>> @@ -429,10 +426,11 @@ static void shrink_zone_span(struct zone *zone, unsigned long start_pfn,
>>>  					       start_pfn);
>>>  		if (pfn)
>>>  			zone->spanned_pages = pfn - zone->zone_start_pfn + 1;
>>> -		else {
>>> -			zone->zone_start_pfn = 0;
>>> -			zone->spanned_pages = 0;
>>> -		}
>>> +	}
>>> +
>>> +	if (!pfn) {
>>> +		zone->zone_start_pfn = 0;
>>> +		zone->spanned_pages = 0;
>>>  	}
>>>  	zone_span_writeunlock(zone);
>>>  }
>>>
>>
>> So, what if your zone starts at pfn 0? Unlikely that we can actually
>> offline that, but still it is more confusing than the old code IMHO.
>> Then I prefer to drop the second else case as discussed instead.
> 
> Hmm, pfn is initialized as zone->zone_start_pfn, does it matter?
> The impossible empty zone won't go wrong if it really happen.
> 

If you offline any memory block that belongs to the lowest zone
(zone->zone_start_pfn == 0) but does not fall on a boundary (so that you
can actually shrink), you would mark the whole zone offline. That's
broken unless I am missing something.

-- 
Thanks,

David / dhildenb

