Return-Path: <SRS0=WByN=3C=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 21444C33CAB
	for <linux-kernel@archiver.kernel.org>; Mon, 13 Jan 2020 09:10:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 01836206D7
	for <linux-kernel@archiver.kernel.org>; Mon, 13 Jan 2020 09:10:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726134AbgAMJKP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 13 Jan 2020 04:10:15 -0500
Received: from foss.arm.com ([217.140.110.172]:35952 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725268AbgAMJKO (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Jan 2020 04:10:14 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id A23501063;
        Mon, 13 Jan 2020 01:10:11 -0800 (PST)
Received: from [10.162.43.142] (p8cg001049571a15.blr.arm.com [10.162.43.142])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id E7B9A3F534;
        Mon, 13 Jan 2020 01:10:05 -0800 (PST)
Subject: Re: [PATCH V11 1/5] mm/hotplug: Introduce arch callback validating
 the hot remove range
To:     David Hildenbrand <david@redhat.com>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        akpm@linux-foundation.org, catalin.marinas@arm.com, will@kernel.org
Cc:     mark.rutland@arm.com, cai@lca.pw, logang@deltatee.com,
        cpandya@codeaurora.org, arunks@codeaurora.org,
        dan.j.williams@intel.com, mgorman@techsingularity.net,
        osalvador@suse.de, ard.biesheuvel@arm.com, steve.capper@arm.com,
        broonie@kernel.org, valentin.schneider@arm.com,
        Robin.Murphy@arm.com, steven.price@arm.com, suzuki.poulose@arm.com,
        ira.weiny@intel.com
References: <1578625755-11792-1-git-send-email-anshuman.khandual@arm.com>
 <1578625755-11792-2-git-send-email-anshuman.khandual@arm.com>
 <80ab5f55-77ef-4719-52fc-2b23c0ecb866@redhat.com>
From:   Anshuman Khandual <anshuman.khandual@arm.com>
Message-ID: <6f0efddc-f124-58ca-28b6-4632469cf992@arm.com>
Date:   Mon, 13 Jan 2020 14:41:23 +0530
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <80ab5f55-77ef-4719-52fc-2b23c0ecb866@redhat.com>
Content-Type: text/plain; charset=windows-1252
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 01/10/2020 02:12 PM, David Hildenbrand wrote:
> On 10.01.20 04:09, Anshuman Khandual wrote:
>> Currently there are two interfaces to initiate memory range hot removal i.e
>> remove_memory() and __remove_memory() which then calls try_remove_memory().
>> Platform gets called with arch_remove_memory() to tear down required kernel
>> page tables and other arch specific procedures. But there are platforms
>> like arm64 which might want to prevent removal of certain specific memory
>> ranges irrespective of their present usage or movability properties.
> 
> Why? Is this only relevant for boot memory? I hope so, otherwise the
> arch code needs fixing IMHO.

Right, it is relevant only for the boot memory on arm64 platform. But this
new arch callback makes it flexible to reject any given memory range.

> 
> If it's only boot memory, we should disallow offlining instead via a
> memory notifier - much cleaner.

Dont have much detail understanding of MMU notifier mechanism but from some
initial reading, it seems like we need to have a mm_struct for a notifier
to monitor various events on the page table. Just wondering how a physical
memory range like boot memory can be monitored because it can be used both
for for kernel (init_mm) or user space process at same time. Is there some
mechanism we could do this ?

> 
>>
>> Current arch call back arch_remove_memory() is too late in the process to
>> abort memory hot removal as memory block devices and firmware memory map
>> entries would have already been removed. Platforms should be able to abort
>> the process before taking the mem_hotplug_lock with mem_hotplug_begin().
>> This essentially requires a new arch callback for memory range validation.
> 
> I somewhat dislike this very much. Memory removal should never fail if
> used sanely. See e.g., __remove_memory(), it will BUG() whenever
> something like that would strike.
> 
>>
>> This differentiates memory range validation between memory hot add and hot
>> remove paths before carving out a new helper check_hotremove_memory_range()
>> which incorporates a new arch callback. This call back provides platforms
>> an opportunity to refuse memory removal at the very onset. In future the
>> same principle can be extended for memory hot add path if required.
>>
>> Platforms can choose to override this callback in order to reject specific
>> memory ranges from removal or can just fallback to a default implementation
>> which allows removal of all memory ranges.
> 
> I suspect we want really want to disallow offlining instead. E.g., I

If boot memory pages can be prevented from being offlined for sure, then it
would indirectly definitely prevent hot remove process as well.

> remember s390x does that with certain areas needed for dumping/kexec.

Could not find any references to mmu_notifier in arch/s390 or any other arch
for that matter apart from KVM (which has an user space component), could you
please give some pointers ?

> 
> Somebody who added memory via add_memory() should always be able to
> remove the memory via remove_memory() again. Only boot memory can be
> treated in a special way, but boot memory is initially always online.
> 
