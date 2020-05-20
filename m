Return-Path: <SRS0=sqqi=7C=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 73DEDC433DF
	for <linux-kernel@archiver.kernel.org>; Wed, 20 May 2020 03:32:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 483E4207E8
	for <linux-kernel@archiver.kernel.org>; Wed, 20 May 2020 03:32:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728674AbgETDcp (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 19 May 2020 23:32:45 -0400
Received: from foss.arm.com ([217.140.110.172]:46564 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726432AbgETDcp (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 May 2020 23:32:45 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id BAA5630E;
        Tue, 19 May 2020 20:32:44 -0700 (PDT)
Received: from [10.163.75.101] (unknown [10.163.75.101])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id C8F2E3F52E;
        Tue, 19 May 2020 20:32:42 -0700 (PDT)
Subject: Re: [RFC V2] mm/vmstat: Add events for PMD based THP migration
 without split
To:     John Hubbard <jhubbard@nvidia.com>, linux-mm@kvack.org
Cc:     Naoya Horiguchi <n-horiguchi@ah.jp.nec.com>,
        Zi Yan <ziy@nvidia.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        linux-kernel@vger.kernel.org
References: <1589784156-28831-1-git-send-email-anshuman.khandual@arm.com>
 <67be2597-c019-63c1-b551-d4571a44f1a5@nvidia.com>
From:   Anshuman Khandual <anshuman.khandual@arm.com>
Message-ID: <88aa238d-9de1-9f6a-a3b0-51fbe073090d@arm.com>
Date:   Wed, 20 May 2020 09:02:07 +0530
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <67be2597-c019-63c1-b551-d4571a44f1a5@nvidia.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 05/19/2020 01:40 AM, John Hubbard wrote:
> On 2020-05-17 23:42, Anshuman Khandual wrote:
> ...
>> diff --git a/include/linux/vm_event_item.h b/include/linux/vm_event_item.h
>> index ffef0f279747..23d8f9884c2b 100644
>> --- a/include/linux/vm_event_item.h
>> +++ b/include/linux/vm_event_item.h
>> @@ -91,6 +91,10 @@ enum vm_event_item { PGPGIN, PGPGOUT, PSWPIN, PSWPOUT,
>>           THP_ZERO_PAGE_ALLOC_FAILED,
>>           THP_SWPOUT,
>>           THP_SWPOUT_FALLBACK,
>> +#ifdef CONFIG_ARCH_ENABLE_THP_MIGRATION
> 
> 
> Hi Anshuman,
> 
> These new events look great to me. I have some nits below, plus one
> lightly controversial suggestion which I'd really like to have someone
> more experienced weigh in on, which is:
> 
> How about not being quite so granular on the THP config options, and
> just guarding these events with the overall CONFIG_TRANSPARENT_HUGEPAGE
> option, instead of the sub-option CONFIG_ARCH_ENABLE_THP_MIGRATION?
> 
> I tentatively think it's harmless and not really misleading to have
> /proc/vmstat showing this in all THP-enabled configurations:
> 
> thp_pmd_migration_success 0
> thp_pmd_migration_failure 0
> 
> ...if THP is enabled, and *whether or not* _THP_MIGRATION is enabled.
> And this simplifies things a bit. Given how the .config options can get,
> I think simplifying would be nice.
> 
> However, I'm ready to be corrected on that, if it's a bad idea for
> other API reasons perhaps.  Can anyone please comment?

There is no THP migration events to track unless it is enabled. Why to
show these statistics (as 0) when its not even possible. If the config
simplicity is the only intended rationale here, it might not be the
case either. These events and their tracking would still need to be
wrapped with CONFIG_TRANSPARENT_HUGEPAGE otherwise.

If your concern is more towards CONFIG_ARCH_ENABLE_THP_MIGRATION being
unsuitable or with complex dependencies, then that is something how THP
migration feature itself is implemented currently and adding VM events
does not address that. A possible patch in the future patch could solve
all these (together).

But sure, let's hear it for what others have to say on this.

> 
> 
>> +        THP_PMD_MIGRATION_SUCCESS,
>> +        THP_PMD_MIGRATION_FAILURE,
>> +#endif
>>   #endif
>>   #ifdef CONFIG_MEMORY_BALLOON
>>           BALLOON_INFLATE,
>> diff --git a/mm/migrate.c b/mm/migrate.c
>> index 7160c1556f79..5325700a3e90 100644
>> --- a/mm/migrate.c
>> +++ b/mm/migrate.c
>> @@ -1170,6 +1170,18 @@ static int __unmap_and_move(struct page *page, struct page *newpage,
>>   #define ICE_noinline
>>   #endif
>>   +#ifdef CONFIG_ARCH_ENABLE_THP_MIGRATION
>> +static inline void thp_migration_success(bool success)
> 
> 
> I think this should be named
> 
>     thp_pmd_migration_success()
> 
> , since that's what you're really counting. Or, you could
> name the events THP_MIGRATION_SUCCESS|FAILURE. Either way,
> just so the function name matches the events it's counting.

Makes sense but IMHO we should keep _pmd_ to be more specific.
Will change the name here as thp_pmd_migration_success().

> 
> 
>> +{
>> +    if (success)
>> +        count_vm_event(THP_PMD_MIGRATION_SUCCESS);
>> +    else
>> +        count_vm_event(THP_PMD_MIGRATION_FAILURE);
>> +}
>> +#else
>> +static inline void thp_migration_success(bool success) { }
> 
> 
> This whole ifdef clause would disappear if my suggestion above is

We will have to protect these with CONFIG_TRANSPARENT_HUGEPAGE as
the events are still conditionally available.

> accepted. However, if not, then I believe the convention for this
> kind of situation is:
> 
> static inline void thp_migration_success(bool success)
> {
> }

AFAIK, we have examples both ways but will change if this is preferred.
