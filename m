Return-Path: <SRS0=faA3=B4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.1 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,NICE_REPLY_A,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2B2F6C433DF
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Aug 2020 06:29:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0755920825
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Aug 2020 06:29:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726630AbgHRG3a (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 18 Aug 2020 02:29:30 -0400
Received: from foss.arm.com ([217.140.110.172]:36758 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726381AbgHRG3a (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Aug 2020 02:29:30 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id BF71B1FB;
        Mon, 17 Aug 2020 23:29:29 -0700 (PDT)
Received: from [10.163.65.199] (unknown [10.163.65.199])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 8DB503F71F;
        Mon, 17 Aug 2020 23:29:27 -0700 (PDT)
Subject: Re: [PATCH] mm/hotplug: Enumerate memory range offlining failure
 reasons
To:     Michal Hocko <mhocko@suse.com>
Cc:     linux-mm@kvack.org, akpm@linux-foundation.org,
        David Hildenbrand <david@redhat.com>,
        Dan Williams <dan.j.williams@intel.com>,
        linux-kernel@vger.kernel.org
References: <1597724522-31545-1-git-send-email-anshuman.khandual@arm.com>
 <20200818060547.GH28270@dhcp22.suse.cz>
From:   Anshuman Khandual <anshuman.khandual@arm.com>
Message-ID: <f178d1f0-af86-6a29-5646-a8f2dc9912f5@arm.com>
Date:   Tue, 18 Aug 2020 11:58:49 +0530
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <20200818060547.GH28270@dhcp22.suse.cz>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 08/18/2020 11:35 AM, Michal Hocko wrote:
> On Tue 18-08-20 09:52:02, Anshuman Khandual wrote:
>> Currently a debug message is printed describing the reason for memory range
>> offline failure. This just enumerates existing reason codes which improves
>> overall readability and makes it cleaner. This does not add any functional
>> change.
> 
> Wasn't something like that posted already? To be honest I do not think

There was a similar one regarding bad page reason.

https://patchwork.kernel.org/patch/11464713/

> this is worth the additional LOC. We are talking about few strings used
> at a single place. I really do not see any simplification, constants are
> sometimes even longer than the strings they are describing.

I am still trying to understand why enumerating all potential offline
failure reasons in a single place (i.e via enum) is not a better idea
than strings scattered across the function. Besides being cleaner, it
classifies, organizes and provide a structure to the set of reasons.
It is not just about string replacement with constants.

> 
>> Cc: Andrew Morton <akpm@linux-foundation.org>
>> Cc: David Hildenbrand <david@redhat.com>
>> Cc: Michal Hocko <mhocko@suse.com>
>> Cc: Dan Williams <dan.j.williams@intel.com>
>> Cc: linux-mm@kvack.org
>> Cc: linux-kernel@vger.kernel.org
>> Signed-off-by: Anshuman Khandual <anshuman.khandual@arm.com>
>> ---
>> This is based on 5.9-rc1
>>
>>  include/linux/memory.h | 28 ++++++++++++++++++++++++++++
>>  mm/memory_hotplug.c    | 18 +++++++++---------
>>  2 files changed, 37 insertions(+), 9 deletions(-)
>>
>> diff --git a/include/linux/memory.h b/include/linux/memory.h
>> index 439a89e758d8..4b52d706edc1 100644
>> --- a/include/linux/memory.h
>> +++ b/include/linux/memory.h
>> @@ -44,6 +44,34 @@ int set_memory_block_size_order(unsigned int order);
>>  #define	MEM_CANCEL_ONLINE	(1<<4)
>>  #define	MEM_CANCEL_OFFLINE	(1<<5)
>>  
>> +/*
>> + * Memory offline failure reasons
>> + */
>> +enum offline_failure_reason {
>> +	OFFLINE_FAILURE_MEMHOLES,
>> +	OFFLINE_FAILURE_MULTIZONE,
>> +	OFFLINE_FAILURE_ISOLATE,
>> +	OFFLINE_FAILURE_NOTIFIER,
>> +	OFFLINE_FAILURE_SIGNAL,
>> +	OFFLINE_FAILURE_UNMOVABLE,
>> +	OFFLINE_FAILURE_DISSOLVE,
>> +};
>> +
>> +static const char *const offline_failure_names[] = {
>> +	[OFFLINE_FAILURE_MEMHOLES]	= "memory holes",
>> +	[OFFLINE_FAILURE_MULTIZONE]	= "multizone range",
>> +	[OFFLINE_FAILURE_ISOLATE]	= "failure to isolate range",
>> +	[OFFLINE_FAILURE_NOTIFIER]	= "notifier failure",
>> +	[OFFLINE_FAILURE_SIGNAL]	= "signal backoff",
>> +	[OFFLINE_FAILURE_UNMOVABLE]	= "unmovable page",
>> +	[OFFLINE_FAILURE_DISSOLVE]	= "failure to dissolve huge pages",
>> +};
>> +
>> +static inline const char *offline_failure(enum offline_failure_reason reason)
>> +{
>> +	return offline_failure_names[reason];
>> +}
>> +
>>  struct memory_notify {
>>  	unsigned long start_pfn;
>>  	unsigned long nr_pages;
>> diff --git a/mm/memory_hotplug.c b/mm/memory_hotplug.c
>> index e9d5ab5d3ca0..b3fa36a09d7f 100644
>> --- a/mm/memory_hotplug.c
>> +++ b/mm/memory_hotplug.c
>> @@ -1484,7 +1484,7 @@ static int __ref __offline_pages(unsigned long start_pfn,
>>  	unsigned long flags;
>>  	struct zone *zone;
>>  	struct memory_notify arg;
>> -	char *reason;
>> +	enum offline_failure_reason reason;
>>  
>>  	mem_hotplug_begin();
>>  
>> @@ -1500,7 +1500,7 @@ static int __ref __offline_pages(unsigned long start_pfn,
>>  			      count_system_ram_pages_cb);
>>  	if (nr_pages != end_pfn - start_pfn) {
>>  		ret = -EINVAL;
>> -		reason = "memory holes";
>> +		reason = OFFLINE_FAILURE_MEMHOLES;
>>  		goto failed_removal;
>>  	}
>>  
>> @@ -1509,7 +1509,7 @@ static int __ref __offline_pages(unsigned long start_pfn,
>>  	zone = test_pages_in_a_zone(start_pfn, end_pfn);
>>  	if (!zone) {
>>  		ret = -EINVAL;
>> -		reason = "multizone range";
>> +		reason = OFFLINE_FAILURE_MULTIZONE;
>>  		goto failed_removal;
>>  	}
>>  	node = zone_to_nid(zone);
>> @@ -1519,7 +1519,7 @@ static int __ref __offline_pages(unsigned long start_pfn,
>>  				       MIGRATE_MOVABLE,
>>  				       MEMORY_OFFLINE | REPORT_FAILURE);
>>  	if (ret < 0) {
>> -		reason = "failure to isolate range";
>> +		reason = OFFLINE_FAILURE_ISOLATE;
>>  		goto failed_removal;
>>  	}
>>  	nr_isolate_pageblock = ret;
>> @@ -1531,7 +1531,7 @@ static int __ref __offline_pages(unsigned long start_pfn,
>>  	ret = memory_notify(MEM_GOING_OFFLINE, &arg);
>>  	ret = notifier_to_errno(ret);
>>  	if (ret) {
>> -		reason = "notifier failure";
>> +		reason = OFFLINE_FAILURE_NOTIFIER;
>>  		goto failed_removal_isolated;
>>  	}
>>  
>> @@ -1540,7 +1540,7 @@ static int __ref __offline_pages(unsigned long start_pfn,
>>  		do {
>>  			if (signal_pending(current)) {
>>  				ret = -EINTR;
>> -				reason = "signal backoff";
>> +				reason = OFFLINE_FAILURE_SIGNAL;
>>  				goto failed_removal_isolated;
>>  			}
>>  
>> @@ -1558,7 +1558,7 @@ static int __ref __offline_pages(unsigned long start_pfn,
>>  		} while (!ret);
>>  
>>  		if (ret != -ENOENT) {
>> -			reason = "unmovable page";
>> +			reason = OFFLINE_FAILURE_UNMOVABLE;
>>  			goto failed_removal_isolated;
>>  		}
>>  
>> @@ -1569,7 +1569,7 @@ static int __ref __offline_pages(unsigned long start_pfn,
>>  		 */
>>  		ret = dissolve_free_huge_pages(start_pfn, end_pfn);
>>  		if (ret) {
>> -			reason = "failure to dissolve huge pages";
>> +			reason = OFFLINE_FAILURE_DISSOLVE;
>>  			goto failed_removal_isolated;
>>  		}
>>  		/* check again */
>> @@ -1627,7 +1627,7 @@ static int __ref __offline_pages(unsigned long start_pfn,
>>  	pr_debug("memory offlining [mem %#010llx-%#010llx] failed due to %s\n",
>>  		 (unsigned long long) start_pfn << PAGE_SHIFT,
>>  		 ((unsigned long long) end_pfn << PAGE_SHIFT) - 1,
>> -		 reason);
>> +		 offline_failure(reason));
>>  	/* pushback to free area */
>>  	mem_hotplug_done();
>>  	return ret;
>> -- 
>> 2.20.1
>>
> 
