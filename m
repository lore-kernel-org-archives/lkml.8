Return-Path: <SRS0=bl3x=A7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F3386C433E1
	for <linux-kernel@archiver.kernel.org>; Mon, 20 Jul 2020 06:14:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id CAD972080D
	for <linux-kernel@archiver.kernel.org>; Mon, 20 Jul 2020 06:14:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726715AbgGTGOn (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 20 Jul 2020 02:14:43 -0400
Received: from foss.arm.com ([217.140.110.172]:38290 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725845AbgGTGOn (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Jul 2020 02:14:43 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 95946106F;
        Sun, 19 Jul 2020 23:14:42 -0700 (PDT)
Received: from [10.163.84.37] (unknown [10.163.84.37])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id EA27B3F718;
        Sun, 19 Jul 2020 23:14:36 -0700 (PDT)
From:   Anshuman Khandual <anshuman.khandual@arm.com>
Subject: Re: [PATCH v3] mm/hugetlb: split hugetlb_cma in nodes with memory
To:     Mike Kravetz <mike.kravetz@oracle.com>,
        Will Deacon <will@kernel.org>
Cc:     Roman Gushchin <guro@fb.com>,
        Barry Song <song.bao.hua@hisilicon.com>,
        Catalin Marinas <catalin.marinas@arm.com>, x86@kernel.org,
        linux-kernel@vger.kernel.org, linuxarm@huawei.com,
        linux-mm@kvack.org, Ingo Molnar <mingo@redhat.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Jonathan Cameron <jonathan.cameron@huawei.com>,
        "H.Peter Anvin" <hpa@zytor.com>, Borislav Petkov <bp@alien8.de>,
        akpm@linux-foundation.org, Mike Rapoport <rppt@linux.ibm.com>,
        linux-arm-kernel@lists.infradead.org
References: <20200710120950.37716-1-song.bao.hua@hisilicon.com>
 <359ea1d0-b1fd-d09f-d28a-a44655834277@oracle.com>
 <20200715081822.GA5683@willie-the-truck>
 <5724f1f8-63a6-ee0f-018c-06fb259b6290@oracle.com>
 <20200716081243.GA6561@willie-the-truck>
 <a867c7a2-e89b-2015-4895-f30f7aeb07cb@oracle.com>
 <81103d30-f4fd-8807-03f9-d131da5097bd@arm.com>
 <20200717083608.GA8293@willie-the-truck>
 <921bc084-fbde-7975-d6d3-842ee22a38d7@arm.com>
 <c2e4d47b-940b-481c-c155-a34c3e853e85@oracle.com>
Message-ID: <ce7fb330-52a6-8078-eeb8-c1f863850016@arm.com>
Date:   Mon, 20 Jul 2020 11:44:04 +0530
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <c2e4d47b-940b-481c-c155-a34c3e853e85@oracle.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 07/17/2020 11:07 PM, Mike Kravetz wrote:
> On 7/17/20 2:51 AM, Anshuman Khandual wrote:
>>
>>
>> On 07/17/2020 02:06 PM, Will Deacon wrote:
>>> On Fri, Jul 17, 2020 at 10:32:53AM +0530, Anshuman Khandual wrote:
>>>>
>>>>
>>>> On 07/16/2020 11:55 PM, Mike Kravetz wrote:
>>>>> >From 17c8f37afbf42fe7412e6eebb3619c6e0b7e1c3c Mon Sep 17 00:00:00 2001
>>>>> From: Mike Kravetz <mike.kravetz@oracle.com>
>>>>> Date: Tue, 14 Jul 2020 15:54:46 -0700
>>>>> Subject: [PATCH] hugetlb: move cma reservation to code setting up gigantic
>>>>>  hstate
>>>>>
>>>>> Instead of calling hugetlb_cma_reserve() directly from arch specific
>>>>> code, call from hugetlb_add_hstate when adding a gigantic hstate.
>>>>> hugetlb_add_hstate is either called from arch specific huge page setup,
>>>>> or as the result of hugetlb command line processing.  In either case,
>>>>> this is late enough in the init process that all numa memory information
>>>>> should be initialized.  And, it is early enough to still use early
>>>>> memory allocator.
>>>>
>>>> This assumes that hugetlb_add_hstate() is called from the arch code at
>>>> the right point in time for the generic HugeTLB to do the required CMA
>>>> reservation which is not ideal. I guess it must have been a reason why
>>>> CMA reservation should always called by the platform code which knows
>>>> the boot sequence timing better.
>>>
>>> Ha, except we've moved it around two or three times already in the last
>>> month or so, so I'd say we don't have a clue when to call it in the arch
>>> code.
>>
>> The arch dependency is not going way with this change either. Just that
>> its getting transferred to hugetlb_add_hstate() which gets called from
>> arch_initcall() in every architecture.
>>
>> The perfect timing here happens to be because of arch_initcall() instead.
>> This is probably fine, as long as
>>
>> 0. hugetlb_add_hstate() is always called at arch_initcall()
> 
> In another reply, I give reasoning why it would be safe to call even later
> at hugetlb command line processing time.

Understood, but there is a time window in which CMA reservation is available
irrespective of whether it is called from arch or generic code. Finding this
right time window and ensuring that N_MEMORY nodemask is initialized, easier
done in the platform code.

> 
>> 1. N_MEMORY mask is guaranteed to be initialized at arch_initcall()
> 
> This is a bit more difficult to guarantee.  I find the init sequence hard to
> understand.  Looking at the arm code, arch_initcall(hugetlbpage_init)
> happens after N_MEMORY mask is setup.  I can't imagine any arch code setting
> up huge pages before N_MEMORY.  But, I suppose it is possible and we would
> need to somehow guarantee this.

Ensuring that N_MEMORY nodemask is initialized from the generic code is even
more difficult.

> 
>> 2. CMA reservation is available to be called at arch_initcall()
> 
> Since I am pretty sure we can delay the reservation until hugetlb command
> line processing time, it would be great if it was always done there.

But moving hugetlb CMA reservation completely during command line processing
has got another concern of mixing with existing memblock based pre-allocation.

> Unfortunately, I can not immediately think of an easy way to do this.
> 

It is rationale to move CMA reservation stuff into generic HugeTLB but there
are some challenges which needs to be solved comprehensively. The patch here
from Barry does solve a short term problem (N_ONLINE ---> N_MEMORY) for now
which IMHO should be considered. Moving CMA reservation into generic HugeTLB
would require some more thoughts and can be attempted later.
