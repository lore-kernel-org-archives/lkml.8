Return-Path: <SRS0=BsgQ=65=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E213BC433DF
	for <linux-kernel@archiver.kernel.org>; Fri, 15 May 2020 04:04:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C8C9A2065F
	for <linux-kernel@archiver.kernel.org>; Fri, 15 May 2020 04:04:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725995AbgEOEEb (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 15 May 2020 00:04:31 -0400
Received: from foss.arm.com ([217.140.110.172]:48226 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725616AbgEOEEa (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 May 2020 00:04:30 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id A82351042;
        Thu, 14 May 2020 21:04:29 -0700 (PDT)
Received: from [192.168.0.129] (unknown [172.31.20.19])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 96C0F3F305;
        Thu, 14 May 2020 21:04:27 -0700 (PDT)
Subject: Re: [RFC] mm/vmstat: Add events for THP migration without split
To:     John Hubbard <jhubbard@nvidia.com>, linux-mm@kvack.org
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>,
        Zi Yan <ziy@nvidia.com>, linux-kernel@vger.kernel.org
References: <1589257372-29576-1-git-send-email-anshuman.khandual@arm.com>
 <8be2c517-ba87-400b-dfbe-461bd6065c2d@nvidia.com>
From:   Anshuman Khandual <anshuman.khandual@arm.com>
Message-ID: <9cac0480-210c-28de-259e-c17c88e8c899@arm.com>
Date:   Fri, 15 May 2020 09:33:54 +0530
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <8be2c517-ba87-400b-dfbe-461bd6065c2d@nvidia.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 05/14/2020 11:59 PM, John Hubbard wrote:
> On 2020-05-11 21:22, Anshuman Khandual wrote:
>> Add the following new trace events which will help in validating
>> migration events involving PMD based THP pages.
>> 
>> 1. THP_PMD_MIGRATION_ENTRY_SET 2. THP_PMD_MIGRATION_ENTRY_REMOVE
>> 
>> There are no clear method to confirm whether a THP migration
>> happened with out involving it's split. These trace events along
>> with PGMIGRATE_SUCCESS and PGMIGRATE_FAILURE will provide
>> additional insights. After this change,
>> 
> 
> 
> Hi Anshuman,
> 
> It's very nice to see this work, and I think that reporting a bit
> more about THP migration stats is going to make development and
> performance debugging a lot more efficient (and pleasant).

That is definitely one of the motivations for these events here.

> 
> 
>> A single 2M THP (2K base page) when migrated
>> 
>> 1. Without split
>> 
>> ................ pgmigrate_success 1 pgmigrate_fail 0 
>> ................ thp_pmd_migration_entry_set 1 
>> thp_pmd_migration_entry_remove 1 ................
>> 
> 
> I do think we should decouple the trace event name(s) just a *little*
> more, from the mechanisms used to migrate THPs. In other words, let's
> report the number of THP migration successes, and name it
> accordingly--rather than "set" and "remove", which are pretty
> low-level and furthermore depend on today's exact code.

Agreed, the events are low level and follows the implementation very
closely. Hence posted as a RFC instead, as I was not very sure about
these events.

> 
> Maybe Zi Yan's recommended name is exactly right, in fact:
> 
> THP_PMD_MIGRATION_SUCCESS

Will also add another THP_PMD_MIGRATION_FAILURE even in migrate_pages()
when a huge page could not be allocated and THP gets split.
