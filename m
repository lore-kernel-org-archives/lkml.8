Return-Path: <SRS0=bl3x=A7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6C95DC433E1
	for <linux-kernel@archiver.kernel.org>; Mon, 20 Jul 2020 06:22:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4320920758
	for <linux-kernel@archiver.kernel.org>; Mon, 20 Jul 2020 06:22:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726856AbgGTGW5 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 20 Jul 2020 02:22:57 -0400
Received: from foss.arm.com ([217.140.110.172]:39128 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725805AbgGTGW4 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Jul 2020 02:22:56 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id A5F20106F;
        Sun, 19 Jul 2020 23:22:55 -0700 (PDT)
Received: from [10.163.84.37] (unknown [10.163.84.37])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 1EDF43F718;
        Sun, 19 Jul 2020 23:22:49 -0700 (PDT)
From:   Anshuman Khandual <anshuman.khandual@arm.com>
Subject: Re: [PATCH v3] mm/hugetlb: split hugetlb_cma in nodes with memory
To:     Mike Kravetz <mike.kravetz@oracle.com>,
        Will Deacon <will@kernel.org>, Roman Gushchin <guro@fb.com>
Cc:     Barry Song <song.bao.hua@hisilicon.com>,
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
 <1efdfe52-abdb-3931-742c-70e4a170e403@oracle.com>
Message-ID: <11b03fcd-c210-032c-16d2-79ada41e0349@arm.com>
Date:   Mon, 20 Jul 2020 11:52:21 +0530
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <1efdfe52-abdb-3931-742c-70e4a170e403@oracle.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 07/17/2020 10:32 PM, Mike Kravetz wrote:
> On 7/16/20 10:02 PM, Anshuman Khandual wrote:
>>
>>
>> On 07/16/2020 11:55 PM, Mike Kravetz wrote:
>>> >From 17c8f37afbf42fe7412e6eebb3619c6e0b7e1c3c Mon Sep 17 00:00:00 2001
>>> From: Mike Kravetz <mike.kravetz@oracle.com>
>>> Date: Tue, 14 Jul 2020 15:54:46 -0700
>>> Subject: [PATCH] hugetlb: move cma reservation to code setting up gigantic
>>>  hstate
>>>
>>> Instead of calling hugetlb_cma_reserve() directly from arch specific
>>> code, call from hugetlb_add_hstate when adding a gigantic hstate.
>>> hugetlb_add_hstate is either called from arch specific huge page setup,
>>> or as the result of hugetlb command line processing.  In either case,
>>> this is late enough in the init process that all numa memory information
>>> should be initialized.  And, it is early enough to still use early
>>> memory allocator.
>>
>> This assumes that hugetlb_add_hstate() is called from the arch code at
>> the right point in time for the generic HugeTLB to do the required CMA
>> reservation which is not ideal. I guess it must have been a reason why
>> CMA reservation should always called by the platform code which knows
>> the boot sequence timing better.
> 
> Actually, the code does not make the assumption that hugetlb_add_hstate
> is called from arch specific huge page setup.  It can even be called later
> at the time of hugetlb command line processing.

Yes, now that hugetlb_cma_reserve() has been moved into hugetlb_add_hstate().
But then there is an explicit warning while trying to mix both the command
line options i.e hugepagesz= and hugetlb_cma=. The proposed code here have
not changed that behavior and hence the following warning should have been
triggered here as well.

1) hugepagesz_setup()
	hugetlb_add_hstate()
		 hugetlb_cma_reserve()

2) hugepages_setup()
	hugetlb_hstate_alloc_pages()	when order >= MAX_ORDER

	if (hstate_is_gigantic(h)) {
        	if (IS_ENABLED(CONFIG_CMA) && hugetlb_cma[0]) {
                	pr_warn_once("HugeTLB: hugetlb_cma is enabled, skip boot time allocation\n");
			break;
                }
		if (!alloc_bootmem_huge_page(h))
                break;
	}

Nonetheless, it does not make sense to mix both memblock and CMA based huge
page pre-allocations. But looking at this again, could this warning be ever
triggered till now ? Unless, a given platform calls hugetlb_cma_reserve()
before _setup("hugepages=", hugepages_setup). Anyways, there seems to be
good reasons to keep both memblock and CMA based pre-allocations in place.
But mixing them together (as done in the proposed code here) does not seem
to be right.

> 
> My 'reasoning' is that gigantic pages can currently be preallocated from
> bootmem/memblock_alloc at the time of command line processing.  Therefore,
> we should be able to reserve bootmem for CMA at the same time.  Is there
> something wrong with this reasoning?  I tested this on x86 by removing the
> call to hugetlb_add_hstate from arch specific code and instead forced the
> call at command line processing time.  The ability to reserve CMA was the
> same.

There is no problem with that reasoning. __setup() triggered function should
be able perform CMA reservation. But as pointed out before, it does not make
sense to mix both CMA reservation and memblock based pre-allocation.

> 
> Yes, the CMA reservation interface says it should be called from arch
> specific code.  However, if we currently depend on the ability to do
> memblock_alloc at hugetlb command line processing time for gigantic page
> preallocation, then I think we can do the CMA reservation here as well.

IIUC, CMA reservation and memblock alloc have some differences in terms of
how the memory can be used later on, will have to dig deeper on this. But
the comment section near cma_declare_contiguous_nid() is a concern.

 * This function reserves memory from early allocator. It should be
 * called by arch specific code once the early allocator (memblock or bootmem)
 * has been activated and all other subsystems have already allocated/reserved
 * memory. This function allows to create custom reserved areas.

> 
> Thinking about it some more, I suppose there could be some arch code that
> could call hugetlb_add_hstate too early in the boot process.  But, I do
> not think we have an issue with calling it too late.
> 

Calling it too late might have got the page allocator initialized completely
and then CMA reservation would not be possible afterwards. Also calling it
too early would prevent other subsystems which might need memory reservation
in specific physical ranges.
