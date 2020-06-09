Return-Path: <SRS0=F/Af=7W=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4A0BBC433E1
	for <linux-kernel@archiver.kernel.org>; Tue,  9 Jun 2020 11:35:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 257652064C
	for <linux-kernel@archiver.kernel.org>; Tue,  9 Jun 2020 11:35:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729048AbgFILfy (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 9 Jun 2020 07:35:54 -0400
Received: from foss.arm.com ([217.140.110.172]:40878 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728051AbgFILfw (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 9 Jun 2020 07:35:52 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id B3CEA1FB;
        Tue,  9 Jun 2020 04:35:50 -0700 (PDT)
Received: from [10.163.79.104] (unknown [10.163.79.104])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id D865C3F66F;
        Tue,  9 Jun 2020 04:35:47 -0700 (PDT)
From:   Anshuman Khandual <anshuman.khandual@arm.com>
Subject: Re: [PATCH V2] mm/vmstat: Add events for THP migration without split
To:     Zi Yan <ziy@nvidia.com>
Cc:     Matthew Wilcox <willy@infradead.org>, linux-mm@kvack.org,
        hughd@google.com, daniel.m.jordan@oracle.com,
        Naoya Horiguchi <n-horiguchi@ah.jp.nec.com>,
        John Hubbard <jhubbard@nvidia.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        linux-kernel@vger.kernel.org
References: <1591243245-23052-1-git-send-email-anshuman.khandual@arm.com>
 <20200604113421.GU19604@bombadil.infradead.org>
 <CBF71911-6BB7-4AA7-AC0F-95AADBB45569@nvidia.com>
 <20200604163657.GV19604@bombadil.infradead.org>
 <2735DD7E-0DBF-428B-AAD8-FC6DAAA9CB1E@nvidia.com>
 <9e4acb98-c9fd-a998-03b3-38947cf61bd9@arm.com>
 <890AA27D-29BA-45A9-B868-5533645D73D5@nvidia.com>
Message-ID: <6401ee03-e6b3-c8f5-58b5-4f615c1b7bfc@arm.com>
Date:   Tue, 9 Jun 2020 17:05:45 +0530
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <890AA27D-29BA-45A9-B868-5533645D73D5@nvidia.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 06/05/2020 07:54 PM, Zi Yan wrote:
> On 4 Jun 2020, at 23:35, Anshuman Khandual wrote:
> 
>> On 06/04/2020 10:19 PM, Zi Yan wrote:
>>> On 4 Jun 2020, at 12:36, Matthew Wilcox wrote:
>>>
>>>> On Thu, Jun 04, 2020 at 09:51:10AM -0400, Zi Yan wrote:
>>>>> On 4 Jun 2020, at 7:34, Matthew Wilcox wrote:
>>>>>> On Thu, Jun 04, 2020 at 09:30:45AM +0530, Anshuman Khandual wrote:
>>>>>>> +Quantifying Migration
>>>>>>> +=====================
>>>>>>> +Following events can be used to quantify page migration.
>>>>>>> +
>>>>>>> +- PGMIGRATE_SUCCESS
>>>>>>> +- PGMIGRATE_FAIL
>>>>>>> +- THP_MIGRATION_SUCCESS
>>>>>>> +- THP_MIGRATION_FAILURE
>>>>>>> +
>>>>>>> +THP_MIGRATION_FAILURE in particular represents an event when a THP could not be
>>>>>>> +migrated as a single entity following an allocation failure and ended up getting
>>>>>>> +split into constituent normal pages before being retried. This event, along with
>>>>>>> +PGMIGRATE_SUCCESS and PGMIGRATE_FAIL will help in quantifying and analyzing THP
>>>>>>> +migration events including both success and failure cases.
>>>>>>
>>>>>> First, I'd suggest running this paragraph through 'fmt'.  That way you
>>>>>> don't have to care about line lengths.
>>>>>>
>>>>>> Second, this paragraph doesn't really explain what I need to know to
>>>>>> understand the meaning of these numbers.  When Linux attempts to migrate
>>>>>> a THP, one of three things can happen:
>>>>>>>>>>>>  - It is migrated as a single THP
>>>>>>  - It is migrated, but had to be split
>>>>>>  - Migration fails
>>>>>>
>>>>>> How do I turn these four numbers into an understanding of how often each
>>>>>> of those three situations happen?  And why do we need four numbers to
>>>>>> report three situations?
>>>>>>
>>>>>> Or is there something else that can happen?  If so, I'd like that explained
>>>>>> here too ;-)
>>>>>
>>>>> PGMIGRATE_SUCCESS and PGMIGRATE_FAIL record a combination of different events,
>>>>> so it is not easy to interpret them. Let me try to explain them.
>>>>
>>>> Thanks!  Very helpful explanation.
>>>>
>>>>> 1. migrating only base pages: PGMIGRATE_SUCCESS and PGMIGRATE_FAIL just mean
>>>>> these base pages are migrated and fail to migrate respectively.
>>>>> THP_MIGRATION_SUCCESS and THP_MIGRATION_FAILURE should be 0 in this case.
>>>>> Simple.
>>>>>
>>>>> 2. migrating only THPs:
>>>>> 	- PGMIGRATE_SUCCESS means THPs that are migrated and base pages
>>>>> 	(from the split of THPs) that are migrated,
>>>>>
>>>>> 	- PGMIGRATE_FAIL means THPs that fail to migrate and base pages that fail to migrated.
>>>>>
>>>>> 	- THP_MIGRATION_SUCCESS means THPs that are migrated.
>>>>>
>>>>> 	- THP_MIGRATION_FAILURE means THPs that are split.
>>>>>
>>>>> So PGMIGRATE_SUCCESS - THP_MIGRATION_SUCCESS means the number of migrated base pages,
>>>>> which are from the split of THPs.
>>>>
>>>> Are you sure about that?  If I split a THP and each of those subpages
>>>> migrates, won't I then see PGMIGRATE_SUCCESS increase by 512?
>>>
>>> That is what I mean. I guess my words did not work. I should have used subpages.
>>>
>>>>
>>>>> When it comes to analyze failed migration, PGMIGRATE_FAIL - THP_MIGRATION_FAILURE
>>>>> means the number of pages that are failed to migrate, but we cannot tell how many
>>>>> are base pages and how many are THPs.
>>>>>
>>>>> 3. migrating base pages and THP:
>>>>>
>>>>> The math should be very similar to the second case, except that
>>>>> a) from PGMIGRATE_SUCCESS - THP_MIGRATION_SUCCESS, we cannot tell how many are pages begin
>>>>> as base pages and how many are pages begin as THPs but become base pages after split;
>>>>> b) from PGMIGRATE_FAIL - THP_MIGRATION_FAILURE, an additional case,
>>>>> base pages that begin as base pages fail to migrate, is mixed into the number and we
>>>>> cannot tell three cases apart.
>>>>
>>>> So why don't we just expose PGMIGRATE_SPLIT?  That would be defined as
>>>> the number of times we succeeded in migrating a THP but had to split it
>>>> to succeed.
>>>
>>> It might need extra code to get that number. Currently, the subpages from split
>>> THPs are appended to the end of the original page list, so we might need a separate
>>> page list for these subpages to count PGMIGRATE_SPLIT. Also what if some of the
>>> subpages fail to migrate? Do we increase PGMIGRATE_SPLIT or not?
>>
>> Thanks Zi, for such a detailed explanation. Ideally, we should separate THP
>> migration from base page migration in terms of statistics. PGMIGRATE_SUCCESS
>> and PGMIGRATE_FAIL should continue to track statistics when migration starts
>> with base pages. But for THP, we should track the following events.
> 
> You mean PGMIGRATE_SUCCESS and PGMIGRATE_FAIL will not track the number of migrated subpages
> from split THPs? Will it cause userspace issues since their semantics are changed?

Yeah, basic idea is to carve out all THP migration related statistics from
the normal page migration. Not sure if that might cause any issue for user
space as you have mentioned. Does /proc/vmstat indicate some sort of an ABI
whose semantics can not really change ? Some more opinions here from others
would be helpful.

The current situation is definitely bit problematic where PGMIGRATE_SUCCESS
increments (+1) both for normal and successful THP migration. Same situation
for PGMIGRATE_FAILURE as well. Hence, there are two clear choices available.

1. THP and normal page migration stats are separate and mutually exclusive

OR

2. THP migration has specific counters but normal page migration counters
   still account for everything in THP migration in terms of normal pages

But IIUC, either way the current PGMIGRATE_SUCCESS or PGMIGRATE_FAIL stats
will change for the user as visible from /proc/vmstat.

> 
>>
>> 1. THP_MIGRATION_SUCCESS 	- THP migration is successful, without split
>> 2. THP_MIGRATION_FAILURE 	- THP could neither be migrated, nor be split
> 
> They make sense to me.> 
>> 3. THP_MIGRATION_SPLIT_SUCCESS  - THP got split and all sub pages migrated
>> 4. THP_MIGRATION_SPLIT_FAILURE  - THP got split but all sub pages could not be migrated
>>
>> THP_MIGRATION_SPLIT_FAILURE could either increment once for a single THP or
>> number of subpages that did not get migrated after split. As you mentioned,
>> this will need some extra code in the core migration. Nonetheless, if these
>> new events look good, will be happy to make required changes.
> 
> Maybe THP_MIGRATION_SPLIT would be simpler? My concern is that whether we need such

Also, it will not require a new migration queue tracking the split THP sub pages.

> detailed information or not. Maybe trace points would be good enough for 3 and 4.

But without a separate queue for split THP subpages, will it be possible to track
(3) and (4) through trace events ? Just wondering, where are the intercept points.

> But if you think it is useful to you, feel free to implement them.

Original idea was that, all stats here should give high level view but new upcoming
trace events should help in details like which particular subpages could not be
migrated resulting in a THP_MIGRATION_SPLIT_FAILURE increment etc.

> 
> BTW, in terms of stats tracking, what do you think of my patch below? I am trying to
> aggregate all stats counting in one place. Feel free to use it if you think it works
> for you.

Assume that, I could take the liberty to add your 'Signed-off-by' in case end up
using this code chunk below. This seems to be going with option (2) as mentioned
before.

> 
> 
> diff --git a/mm/migrate.c b/mm/migrate.c
> index 7bfd0962149e..0f3c60470489 100644
> --- a/mm/migrate.c
> +++ b/mm/migrate.c
> @@ -1429,9 +1429,14 @@ int migrate_pages(struct list_head *from, new_page_t get_new_page,
>                 enum migrate_mode mode, int reason)
>  {
>         int retry = 1;
> +       int thp_retry = 1;
>         int nr_failed = 0;
> +       int nr_thp_failed = 0;
> +       int nr_thp_split = 0;
>         int nr_succeeded = 0;
> +       int nr_thp_succeeded = 0;
>         int pass = 0;
> +       bool is_thp = false;
>         struct page *page;
>         struct page *page2;
>         int swapwrite = current->flags & PF_SWAPWRITE;
> @@ -1440,11 +1445,13 @@ int migrate_pages(struct list_head *from, new_page_t get_new_page,
>         if (!swapwrite)
>                 current->flags |= PF_SWAPWRITE;
> 
> -       for(pass = 0; pass < 10 && retry; pass++) {
> +       for(pass = 0; pass < 10 && (retry || thp_retry); pass++) {

'thp_retry' check might not be necessary here as 'retry' already
contains 'thp_retry'.

>                 retry = 0;
> +               thp_retry = 0;
> 
>                 list_for_each_entry_safe(page, page2, from, lru) {
>  retry:
> +                       is_thp = PageTransHuge(page);
>                         cond_resched();
> 
>                         if (PageHuge(page))
> @@ -1475,15 +1482,20 @@ int migrate_pages(struct list_head *from, new_page_t get_new_page,
>                                         unlock_page(page);
>                                         if (!rc) {
>                                                 list_safe_reset_next(page, page2, lru);
> +                                               nr_thp_split++;
>                                                 goto retry;
>                                         }
>                                 }

Check 'if_thp' and increment 'nr_thp_failed' like 'default' case and
also increment nr_failed by (1 << order) for the THP being migrated.


>                                 nr_failed++;
>                                 goto out;
>                         case -EAGAIN:
> +                               if (is_thp)
> +                                       thp_retry++;
>                                 retry++;
>                                 break;
>                         case MIGRATEPAGE_SUCCESS:
> +                               if (is_thp)
> +                                       nr_thp_succeeded++;

Increment nr_succeeded by (1 << order) for the THP being migrated.

>                                 nr_succeeded++;
>                                 break;
>                         default:
> @@ -1493,18 +1505,27 @@ int migrate_pages(struct list_head *from, new_page_t get_new_page,
>                                  * removed from migration page list and not
>                                  * retried in the next outer loop.
>                                  */
> +                               if (is_thp)
> +                                       nr_thp_failed++;

Increment nr_failed by (1 << order) for the THP being migrated.

>                                 nr_failed++;
>                                 break;
>                         }
>                 }
>         }
>         nr_failed += retry;
> +       nr_thp_failed += thp_retry;
>         rc = nr_failed;

Right, nr_failed already contains nr_thp_failed. Hence need not change.

>         if (nr_succeeded)
>                 count_vm_events(PGMIGRATE_SUCCESS, nr_succeeded);
>         if (nr_failed)
>                 count_vm_events(PGMIGRATE_FAIL, nr_failed);
> +       if (nr_thp_succeeded)
> +               count_vm_events(THP_MIGRATION_SUCCESS, nr_thp_succeeded);
> +       if (nr_thp_failed)
> +               count_vm_events(THP_MIGRATION_FAIL, nr_thp_failed);
> +       if (nr_thp_split)
> +               count_vm_events(THP_MIGRATION_SPLIT, nr_thp_split);
>         trace_mm_migrate_pages(nr_succeeded, nr_failed, mode, reason);

This existing trace event should add stats for THP migration as well.

> 
>         if (!swapwrite)
> 

Regardless, this change set (may be with some more modifications), makes sense if
we decide to go with option (2), where existing normal page migration stats will
cover THP related stats as well. But it will be really great, if we get some more
opinions on this. Meanwhile, will continue looking into it further.

- Anshuman
