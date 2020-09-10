Return-Path: <SRS0=87nF=CT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 75D0AC43461
	for <linux-kernel@archiver.kernel.org>; Thu, 10 Sep 2020 11:08:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2071820C09
	for <linux-kernel@archiver.kernel.org>; Thu, 10 Sep 2020 11:08:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730359AbgIJLI0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 10 Sep 2020 07:08:26 -0400
Received: from foss.arm.com ([217.140.110.172]:33124 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730635AbgIJK7j (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Sep 2020 06:59:39 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 11EFA31B;
        Thu, 10 Sep 2020 03:59:19 -0700 (PDT)
Received: from [10.163.71.250] (unknown [10.163.71.250])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 2D2963F68F;
        Thu, 10 Sep 2020 03:59:15 -0700 (PDT)
From:   Anshuman Khandual <anshuman.khandual@arm.com>
Subject: Re: [PATCH] arm64/mm: add fallback option to allocate virtually
 contiguous memory
To:     David Hildenbrand <david@redhat.com>,
        Sudarshan Rajagopalan <sudaraja@codeaurora.org>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Cc:     Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Logan Gunthorpe <logang@deltatee.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Steven Price <steven.price@arm.com>
References: <01010174769e2b68-a6f3768e-aef8-43c7-b357-a8cb1e17d3eb-000000@us-west-2.amazonses.com>
 <0475e813-cb95-0992-39e4-593bfd5cdbf8@arm.com>
 <372df305-3bff-bf8e-e2a3-a03932df58d5@redhat.com>
Message-ID: <f772d6ea-001b-be8f-843a-1e56c316814f@arm.com>
Date:   Thu, 10 Sep 2020 16:28:43 +0530
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <372df305-3bff-bf8e-e2a3-a03932df58d5@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 09/10/2020 01:38 PM, David Hildenbrand wrote:
> On 10.09.20 08:45, Anshuman Khandual wrote:
>> Hello Sudarshan,
>>
>> On 09/10/2020 11:35 AM, Sudarshan Rajagopalan wrote:
>>> When section mappings are enabled, we allocate vmemmap pages from physically
>>> continuous memory of size PMD_SZIE using vmemmap_alloc_block_buf(). Section> mappings are good to reduce TLB pressure. But when system is highly fragmented
>>> and memory blocks are being hot-added at runtime, its possible that such
>>> physically continuous memory allocations can fail. Rather than failing the
>>
>> Did you really see this happen on a system ?
>>
>>> memory hot-add procedure, add a fallback option to allocate vmemmap pages from
>>> discontinuous pages using vmemmap_populate_basepages().
>>
>> Which could lead to a mixed page size mapping in the VMEMMAP area.
> 
> Right, with gives you a slight performance hit - nobody really cares,
> especially if it happens in corner cases only.

On performance impact, will probably let Catalin and others comment from
arm64 platform perspective, because I might not have all information here.
But will do some more audit regarding possible impact of a mixed page size
vmemmap mapping.

> 
> At least x86_64 (see vmemmap_populate_hugepages()) and s390x (added
> recently by me) implement that behavior.
> 
> Assume you run in a virtualized environment where your hypervisor tries
> to do some smart dynamic guest resizing - like monitoring the guest
> memory consumption and adding more memory on demand. You much rather
> want hotadd to succeed (in these corner cases) that failing just because
> you weren't able to grab a huge page in one instance.
> 
> Examples include XEN balloon, Hyper-V balloon, and virtio-mem. We might
> see some of these for arm64 as well (if don't already do).

Makes sense.

> 
>> Allocation failure in vmemmap_populate() should just cleanly fail
>> the memory hot add operation, which can then be retried. Why the
>> retry has to be offloaded to kernel ?
> 
> (not sure what "offloaded to kernel" really means here - add_memory() is

Offloaded here referred to the responsibility to retry or just fallback.
If the situation can be resolved by user retrying hot add operation till
it succeeds, compared to kernel falling back on allocating normal pages.

> also just triggered from the kernel) I disagree, we should try our best
> to add memory and make it available, especially when short on memory
> already.

Okay.
