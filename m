Return-Path: <SRS0=RcPI=7S=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8226AC433DF
	for <linux-kernel@archiver.kernel.org>; Fri,  5 Jun 2020 03:36:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 678692074B
	for <linux-kernel@archiver.kernel.org>; Fri,  5 Jun 2020 03:36:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728411AbgFEDgF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 4 Jun 2020 23:36:05 -0400
Received: from foss.arm.com ([217.140.110.172]:50340 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728398AbgFEDgF (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 Jun 2020 23:36:05 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 419201FB;
        Thu,  4 Jun 2020 20:36:04 -0700 (PDT)
Received: from [10.163.77.89] (unknown [10.163.77.89])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 291A13F52E;
        Thu,  4 Jun 2020 20:36:00 -0700 (PDT)
Subject: Re: [PATCH V2] mm/vmstat: Add events for THP migration without split
To:     Zi Yan <ziy@nvidia.com>, Matthew Wilcox <willy@infradead.org>
Cc:     linux-mm@kvack.org, hughd@google.com, daniel.m.jordan@oracle.com,
        Naoya Horiguchi <n-horiguchi@ah.jp.nec.com>,
        John Hubbard <jhubbard@nvidia.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        linux-kernel@vger.kernel.org
References: <1591243245-23052-1-git-send-email-anshuman.khandual@arm.com>
 <20200604113421.GU19604@bombadil.infradead.org>
 <CBF71911-6BB7-4AA7-AC0F-95AADBB45569@nvidia.com>
 <20200604163657.GV19604@bombadil.infradead.org>
 <2735DD7E-0DBF-428B-AAD8-FC6DAAA9CB1E@nvidia.com>
From:   Anshuman Khandual <anshuman.khandual@arm.com>
Message-ID: <9e4acb98-c9fd-a998-03b3-38947cf61bd9@arm.com>
Date:   Fri, 5 Jun 2020 09:05:01 +0530
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <2735DD7E-0DBF-428B-AAD8-FC6DAAA9CB1E@nvidia.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 06/04/2020 10:19 PM, Zi Yan wrote:
> On 4 Jun 2020, at 12:36, Matthew Wilcox wrote:
> 
>> On Thu, Jun 04, 2020 at 09:51:10AM -0400, Zi Yan wrote:
>>> On 4 Jun 2020, at 7:34, Matthew Wilcox wrote:
>>>> On Thu, Jun 04, 2020 at 09:30:45AM +0530, Anshuman Khandual wrote:
>>>>> +Quantifying Migration
>>>>> +=====================
>>>>> +Following events can be used to quantify page migration.
>>>>> +
>>>>> +- PGMIGRATE_SUCCESS
>>>>> +- PGMIGRATE_FAIL
>>>>> +- THP_MIGRATION_SUCCESS
>>>>> +- THP_MIGRATION_FAILURE
>>>>> +
>>>>> +THP_MIGRATION_FAILURE in particular represents an event when a THP could not be
>>>>> +migrated as a single entity following an allocation failure and ended up getting
>>>>> +split into constituent normal pages before being retried. This event, along with
>>>>> +PGMIGRATE_SUCCESS and PGMIGRATE_FAIL will help in quantifying and analyzing THP
>>>>> +migration events including both success and failure cases.
>>>>
>>>> First, I'd suggest running this paragraph through 'fmt'.  That way you
>>>> don't have to care about line lengths.
>>>>
>>>> Second, this paragraph doesn't really explain what I need to know to
>>>> understand the meaning of these numbers.  When Linux attempts to migrate
>>>> a THP, one of three things can happen:
>>>>
>>>>  - It is migrated as a single THP
>>>>  - It is migrated, but had to be split
>>>>  - Migration fails
>>>>
>>>> How do I turn these four numbers into an understanding of how often each
>>>> of those three situations happen?  And why do we need four numbers to
>>>> report three situations?
>>>>
>>>> Or is there something else that can happen?  If so, I'd like that explained
>>>> here too ;-)
>>>
>>> PGMIGRATE_SUCCESS and PGMIGRATE_FAIL record a combination of different events,
>>> so it is not easy to interpret them. Let me try to explain them.
>>
>> Thanks!  Very helpful explanation.
>>
>>> 1. migrating only base pages: PGMIGRATE_SUCCESS and PGMIGRATE_FAIL just mean
>>> these base pages are migrated and fail to migrate respectively.
>>> THP_MIGRATION_SUCCESS and THP_MIGRATION_FAILURE should be 0 in this case.
>>> Simple.
>>>
>>> 2. migrating only THPs:
>>> 	- PGMIGRATE_SUCCESS means THPs that are migrated and base pages
>>> 	(from the split of THPs) that are migrated,
>>>
>>> 	- PGMIGRATE_FAIL means THPs that fail to migrate and base pages that fail to migrated.
>>>
>>> 	- THP_MIGRATION_SUCCESS means THPs that are migrated.
>>>
>>> 	- THP_MIGRATION_FAILURE means THPs that are split.
>>>
>>> So PGMIGRATE_SUCCESS - THP_MIGRATION_SUCCESS means the number of migrated base pages,
>>> which are from the split of THPs.
>>
>> Are you sure about that?  If I split a THP and each of those subpages
>> migrates, won't I then see PGMIGRATE_SUCCESS increase by 512?
> 
> That is what I mean. I guess my words did not work. I should have used subpages.
> 
>>
>>> When it comes to analyze failed migration, PGMIGRATE_FAIL - THP_MIGRATION_FAILURE
>>> means the number of pages that are failed to migrate, but we cannot tell how many
>>> are base pages and how many are THPs.
>>>
>>> 3. migrating base pages and THP:
>>>
>>> The math should be very similar to the second case, except that
>>> a) from PGMIGRATE_SUCCESS - THP_MIGRATION_SUCCESS, we cannot tell how many are pages begin
>>> as base pages and how many are pages begin as THPs but become base pages after split;
>>> b) from PGMIGRATE_FAIL - THP_MIGRATION_FAILURE, an additional case,
>>> base pages that begin as base pages fail to migrate, is mixed into the number and we
>>> cannot tell three cases apart.
>>
>> So why don't we just expose PGMIGRATE_SPLIT?  That would be defined as
>> the number of times we succeeded in migrating a THP but had to split it
>> to succeed.
> 
> It might need extra code to get that number. Currently, the subpages from split
> THPs are appended to the end of the original page list, so we might need a separate
> page list for these subpages to count PGMIGRATE_SPLIT. Also what if some of the
> subpages fail to migrate? Do we increase PGMIGRATE_SPLIT or not?

Thanks Zi, for such a detailed explanation. Ideally, we should separate THP
migration from base page migration in terms of statistics. PGMIGRATE_SUCCESS
and PGMIGRATE_FAIL should continue to track statistics when migration starts
with base pages. But for THP, we should track the following events.

1. THP_MIGRATION_SUCCESS 	- THP migration is successful, without split
2. THP_MIGRATION_FAILURE 	- THP could neither be migrated, nor be split
3. THP_MIGRATION_SPLIT_SUCCESS  - THP got split and all sub pages migrated
4. THP_MIGRATION_SPLIT_FAILURE  - THP got split but all sub pages could not be migrated

THP_MIGRATION_SPLIT_FAILURE could either increment once for a single THP or
number of subpages that did not get migrated after split. As you mentioned,
this will need some extra code in the core migration. Nonetheless, if these
new events look good, will be happy to make required changes.
