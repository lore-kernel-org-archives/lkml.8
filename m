Return-Path: <SRS0=za8s=32=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B5782C352A2
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Feb 2020 23:44:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 943A620730
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Feb 2020 23:44:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727305AbgBFXo1 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 6 Feb 2020 18:44:27 -0500
Received: from mga11.intel.com ([192.55.52.93]:59739 "EHLO mga11.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726543AbgBFXo0 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Feb 2020 18:44:26 -0500
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
X-Amp-File-Uploaded: False
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by fmsmga102.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 06 Feb 2020 15:44:25 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.70,411,1574150400"; 
   d="scan'208";a="225191059"
Received: from richard.sh.intel.com (HELO localhost) ([10.239.159.54])
  by orsmga008.jf.intel.com with ESMTP; 06 Feb 2020 15:44:23 -0800
Date:   Fri, 7 Feb 2020 07:44:40 +0800
From:   Wei Yang <richardw.yang@linux.intel.com>
To:     David Hildenbrand <david@redhat.com>
Cc:     Baoquan He <bhe@redhat.com>, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org, akpm@linux-foundation.org,
        richardw.yang@linux.intel.com, mhocko@suse.com, osalvador@suse.de
Subject: Re: [PATCH] mm/hotplug: Adjust shrink_zone_span() to keep the old
 logic
Message-ID: <20200206234440.GA14560@richard>
Reply-To: Wei Yang <richardw.yang@linux.intel.com>
References: <20200206053912.1211-1-bhe@redhat.com>
 <7ecaf36f-9f70-05bd-05fc-6dec82b7d559@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <7ecaf36f-9f70-05bd-05fc-6dec82b7d559@redhat.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Feb 06, 2020 at 09:50:07AM +0100, David Hildenbrand wrote:
>On 06.02.20 06:39, Baoquan He wrote:
>> In commit 950b68d9178b ("mm/memory_hotplug: don't check for "all holes"
>> in shrink_zone_span()"), the zone->zone_start_pfn/->spanned_pages
>> resetting is moved into the if()/else if() branches, if the zone becomes
>> empty. However the 2nd resetting code block may cause misunderstanding.
>> 
>> So take the resetting codes out of the conditional checking and handling
>> branches just as the old code does, the find_smallest_section_pfn()and
>> find_biggest_section_pfn() searching have done the the same thing as
>> the old for loop did, the logic is kept the same as the old code. This
>> can remove the possible confusion.
>> 
>> Signed-off-by: Baoquan He <bhe@redhat.com>
>> ---
>>  mm/memory_hotplug.c | 14 ++++++--------
>>  1 file changed, 6 insertions(+), 8 deletions(-)
>> 
>> diff --git a/mm/memory_hotplug.c b/mm/memory_hotplug.c
>> index 089b6c826a9e..475d0d68a32c 100644
>> --- a/mm/memory_hotplug.c
>> +++ b/mm/memory_hotplug.c
>> @@ -398,7 +398,7 @@ static unsigned long find_biggest_section_pfn(int nid, struct zone *zone,
>>  static void shrink_zone_span(struct zone *zone, unsigned long start_pfn,
>>  			     unsigned long end_pfn)
>>  {
>> -	unsigned long pfn;
>> +	unsigned long pfn = zone->zone_start_pfn;
>>  	int nid = zone_to_nid(zone);
>>  
>>  	zone_span_writelock(zone);
>> @@ -414,9 +414,6 @@ static void shrink_zone_span(struct zone *zone, unsigned long start_pfn,
>>  		if (pfn) {
>>  			zone->spanned_pages = zone_end_pfn(zone) - pfn;
>>  			zone->zone_start_pfn = pfn;
>> -		} else {
>> -			zone->zone_start_pfn = 0;
>> -			zone->spanned_pages = 0;
>>  		}
>>  	} else if (zone_end_pfn(zone) == end_pfn) {
>>  		/*
>> @@ -429,10 +426,11 @@ static void shrink_zone_span(struct zone *zone, unsigned long start_pfn,
>>  					       start_pfn);
>>  		if (pfn)
>>  			zone->spanned_pages = pfn - zone->zone_start_pfn + 1;
>> -		else {
>> -			zone->zone_start_pfn = 0;
>> -			zone->spanned_pages = 0;
>> -		}
>> +	}
>> +
>> +	if (!pfn) {
>> +		zone->zone_start_pfn = 0;
>> +		zone->spanned_pages = 0;
>>  	}
>>  	zone_span_writeunlock(zone);
>>  }
>> 
>
>So, what if your zone starts at pfn 0? Unlikely that we can actually
>offline that, but still it is more confusing than the old code IMHO.
>Then I prefer to drop the second else case as discussed instead.
>

Sorry, I just catch up with this thread.

If zone starts at 0, find_smallest_section_pfn() will be called only when we
want to remove the first section [0, secion_size].

Then find_smallest_section_pfn() return value has two possibilities:

 * a non-0 section pfn if it still has
 * 0 if the zone is empty

This looks good to me.

Or I may misunderstand your point, would you mind sharing more light on your
finding?

Thanks :-)

>-- 
>Thanks,
>
>David / dhildenb

-- 
Wei Yang
Help you, Help me
