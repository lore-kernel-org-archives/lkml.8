Return-Path: <SRS0=BsgQ=65=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DE501C433DF
	for <linux-kernel@archiver.kernel.org>; Fri, 15 May 2020 03:51:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B82F12065F
	for <linux-kernel@archiver.kernel.org>; Fri, 15 May 2020 03:51:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728277AbgEODvW (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 14 May 2020 23:51:22 -0400
Received: from foss.arm.com ([217.140.110.172]:48118 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726665AbgEODvW (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 May 2020 23:51:22 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id C82741042;
        Thu, 14 May 2020 20:51:21 -0700 (PDT)
Received: from [192.168.0.129] (unknown [172.31.20.19])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 0B4B83F305;
        Thu, 14 May 2020 20:51:19 -0700 (PDT)
Subject: Re: [RFC] mm/vmstat: Add events for THP migration without split
To:     Zi Yan <ziy@nvidia.com>
Cc:     linux-mm@kvack.org, Andrew Morton <akpm@linux-foundation.org>,
        "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>,
        linux-kernel@vger.kernel.org
References: <1589257372-29576-1-git-send-email-anshuman.khandual@arm.com>
 <67C72AD3-120C-4825-B67B-AECD4245EC4E@nvidia.com>
From:   Anshuman Khandual <anshuman.khandual@arm.com>
Message-ID: <7b4504c8-8583-d426-fef1-4c14986798c3@arm.com>
Date:   Fri, 15 May 2020 09:20:43 +0530
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <67C72AD3-120C-4825-B67B-AECD4245EC4E@nvidia.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 05/14/2020 07:58 PM, Zi Yan wrote:
> On 12 May 2020, at 0:22, Anshuman Khandual wrote:
> 
>> Add the following new trace events which will help in validating migration
>> events involving PMD based THP pages.
>>
>> 1. THP_PMD_MIGRATION_ENTRY_SET
>> 2. THP_PMD_MIGRATION_ENTRY_REMOVE
>>
>> There are no clear method to confirm whether a THP migration happened with
>> out involving it's split. These trace events along with PGMIGRATE_SUCCESS
>> and PGMIGRATE_FAILURE will provide additional insights. After this change,
>>
>> A single 2M THP (2K base page) when migrated
>>
>> 1. Without split
>>
>> ................
>> pgmigrate_success 1
>> pgmigrate_fail 0
>> ................
>> thp_pmd_migration_entry_set 1
>> thp_pmd_migration_entry_remove 1
>> ................
>>
>> 2. With split
>>
>> ................
>> pgmigrate_success 512
>> pgmigrate_fail 0
>> ................
>> thp_pmd_migration_entry_set 0
>> thp_pmd_migration_entry_remove 0
>> ................
>>
>> pgmigrate_success as 1 instead of 512, provides a hint for possible THP
>> migration event. But then it gets mixed with normal page migrations over
>> time. These additional trace events provide required co-relation.
> 
> To track successful THP migrations, the code below should work, right?
> 
> diff --git a/mm/migrate.c b/mm/migrate.c
> index b1092876e537..d394f5331288 100644
> --- a/mm/migrate.c
> +++ b/mm/migrate.c
> @@ -1220,6 +1220,8 @@ static ICE_noinline int unmap_and_move(new_page_t get_new_page,
>          * we want to retry.
>          */
>         if (rc == MIGRATEPAGE_SUCCESS) {
> +               if (PageTransHuge(newpage))
> +                       count_vm_event(THP_PMD_MIGRATION_SUCCESS);

Thats right.

>                 put_page(page);
>                 if (reason == MR_MEMORY_FAILURE) {
>                         /*

Another THP_PMD_MIGRATION_FAILURE event in migrate_pages() when the THP gets
split as a huge page could not be allocated. Both THP_PMD_MIGRATION_SUCCESS
and THP_PMD_MIGRATION_FAILURE will provide a better understanding regarding
THP migration events on the system.

> 
> Maybe you could give more details on why you want to add the THP migration event and
> how you are going to use the event in your use case. That would be very helpful to this
> code review. Are you going to do anything if you see THP migration failures?

Not at the moment. Like other VM events these new ones will provide required
statistics (and better understanding) on THP migration which can be used to
improve it further. Follows the same good old principle, if we cannot measure
we cannot improve.
