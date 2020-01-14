Return-Path: <SRS0=z1XV=3D=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 592B9C33CB1
	for <linux-kernel@archiver.kernel.org>; Tue, 14 Jan 2020 11:07:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2C677206D5
	for <linux-kernel@archiver.kernel.org>; Tue, 14 Jan 2020 11:07:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729418AbgANLHx (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 14 Jan 2020 06:07:53 -0500
Received: from foss.arm.com ([217.140.110.172]:50840 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726169AbgANLHx (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Jan 2020 06:07:53 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 46832142F;
        Tue, 14 Jan 2020 03:07:52 -0800 (PST)
Received: from [10.163.1.192] (unknown [10.163.1.192])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id E61483F6C4;
        Tue, 14 Jan 2020 03:07:45 -0800 (PST)
Subject: Re: [PATCH V11 1/5] mm/hotplug: Introduce arch callback validating
 the hot remove range
To:     David Hildenbrand <david@redhat.com>,
        David Hildenbrand <dhildenb@redhat.com>
Cc:     linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, akpm@linux-foundation.org,
        catalin.marinas@arm.com, will@kernel.org, mark.rutland@arm.com,
        cai@lca.pw, logang@deltatee.com, cpandya@codeaurora.org,
        arunks@codeaurora.org, dan.j.williams@intel.com,
        mgorman@techsingularity.net, osalvador@suse.de,
        ard.biesheuvel@arm.com, steve.capper@arm.com, broonie@kernel.org,
        valentin.schneider@arm.com, robin.murphy@arm.com,
        steven.price@arm.com, suzuki.poulose@arm.com, ira.weiny@intel.com
References: <6f0efddc-f124-58ca-28b6-4632469cf992@arm.com>
 <3C3BE5FA-0CFC-4C90-8657-63EF5B680B0B@redhat.com>
 <6b8fb779-31e8-1b63-85a8-9f6c93a04494@arm.com>
 <19194427-1295-3596-2c2c-463c4adf4f35@redhat.com>
 <78f04711-2ca6-280c-d0c2-ab9eea866e59@arm.com>
From:   Anshuman Khandual <anshuman.khandual@arm.com>
Message-ID: <2c4b04d6-6d86-e87a-9b09-b931133a0d9c@arm.com>
Date:   Tue, 14 Jan 2020 16:39:04 +0530
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <78f04711-2ca6-280c-d0c2-ab9eea866e59@arm.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 01/14/2020 07:43 AM, Anshuman Khandual wrote:
> 
> 
> On 01/13/2020 04:07 PM, David Hildenbrand wrote:
>> On 13.01.20 10:50, Anshuman Khandual wrote:
>>>
>>>
>>> On 01/13/2020 02:44 PM, David Hildenbrand wrote:
>>>>
>>>>
>>>>> Am 13.01.2020 um 10:10 schrieb Anshuman Khandual <anshuman.khandual@arm.com>:
>>>>>
>>>>> ﻿
>>>>>
>>>>>> On 01/10/2020 02:12 PM, David Hildenbrand wrote:
>>>>>>> On 10.01.20 04:09, Anshuman Khandual wrote:
>>>>>>> Currently there are two interfaces to initiate memory range hot removal i.e
>>>>>>> remove_memory() and __remove_memory() which then calls try_remove_memory().
>>>>>>> Platform gets called with arch_remove_memory() to tear down required kernel
>>>>>>> page tables and other arch specific procedures. But there are platforms
>>>>>>> like arm64 which might want to prevent removal of certain specific memory
>>>>>>> ranges irrespective of their present usage or movability properties.
>>>>>>
>>>>>> Why? Is this only relevant for boot memory? I hope so, otherwise the
>>>>>> arch code needs fixing IMHO.
>>>>>
>>>>> Right, it is relevant only for the boot memory on arm64 platform. But this
>>>>> new arch callback makes it flexible to reject any given memory range.
>>>>>
>>>>>>
>>>>>> If it's only boot memory, we should disallow offlining instead via a
>>>>>> memory notifier - much cleaner.
>>>>>
>>>>> Dont have much detail understanding of MMU notifier mechanism but from some
>>>>> initial reading, it seems like we need to have a mm_struct for a notifier
>>>>> to monitor various events on the page table. Just wondering how a physical
>>>>> memory range like boot memory can be monitored because it can be used both
>>>>> for for kernel (init_mm) or user space process at same time. Is there some
>>>>> mechanism we could do this ?
>>>>>
>>>>>>
>>>>>>>
>>>>>>> Current arch call back arch_remove_memory() is too late in the process to
>>>>>>> abort memory hot removal as memory block devices and firmware memory map
>>>>>>> entries would have already been removed. Platforms should be able to abort
>>>>>>> the process before taking the mem_hotplug_lock with mem_hotplug_begin().
>>>>>>> This essentially requires a new arch callback for memory range validation.
>>>>>>
>>>>>> I somewhat dislike this very much. Memory removal should never fail if
>>>>>> used sanely. See e.g., __remove_memory(), it will BUG() whenever
>>>>>> something like that would strike.
>>>>>>
>>>>>>>
>>>>>>> This differentiates memory range validation between memory hot add and hot
>>>>>>> remove paths before carving out a new helper check_hotremove_memory_range()
>>>>>>> which incorporates a new arch callback. This call back provides platforms
>>>>>>> an opportunity to refuse memory removal at the very onset. In future the
>>>>>>> same principle can be extended for memory hot add path if required.
>>>>>>>
>>>>>>> Platforms can choose to override this callback in order to reject specific
>>>>>>> memory ranges from removal or can just fallback to a default implementation
>>>>>>> which allows removal of all memory ranges.
>>>>>>
>>>>>> I suspect we want really want to disallow offlining instead. E.g., I
>>>>>
>>>>> If boot memory pages can be prevented from being offlined for sure, then it
>>>>> would indirectly definitely prevent hot remove process as well.
>>>>>
>>>>>> remember s390x does that with certain areas needed for dumping/kexec.
>>>>>
>>>>> Could not find any references to mmu_notifier in arch/s390 or any other arch
>>>>> for that matter apart from KVM (which has an user space component), could you
>>>>> please give some pointers ?
>>>>
>>>> Memory (hotplug) notifier, not MMU notifier :)
>>>
>>> They are so similarly named :)
>>>
>>>>
>>>> Not on my notebook right now, grep for MEM_GOING_OFFLINE, that should be it.
>>>>
>>>
>>> Got it, thanks ! But we will still need boot memory enumeration via MEMBLOCK_BOOT
>>> to reject affected offline requests in the callback.
>>
>> Do you really need that?
>>
>> We have SECTION_IS_EARLY. You could iterate all involved sections (for
>> which you are getting notified) and check if any one of these is marked
>> SECTION_IS_EARLY. then, it was added during boot and not via add_memory().
> 
> Seems to be a better approach than adding a new memblock flag.

These additional changes do the trick and prevent boot memory removal.
Hope this is in line with your earlier suggestion.

diff --git a/arch/arm64/mm/mmu.c b/arch/arm64/mm/mmu.c
index 00f3e1836558..3b59e6a29dea 100644
--- a/arch/arm64/mm/mmu.c
+++ b/arch/arm64/mm/mmu.c
@@ -17,6 +17,7 @@
+++ b/arch/arm64/mm/mmu.c
@@ -17,6 +17,7 @@
 #include <linux/mman.h>
 #include <linux/nodemask.h>
 #include <linux/memblock.h>
+#include <linux/memory.h>
 #include <linux/fs.h>
 #include <linux/io.h>
 #include <linux/mm.h>
@@ -1365,4 +1366,37 @@ void arch_remove_memory(int nid, u64 start, u64 size,
        __remove_pages(start_pfn, nr_pages, altmap);
        __remove_pgd_mapping(swapper_pg_dir, __phys_to_virt(start), size);
 }
+
+static int boot_mem_remove_notifier(struct notifier_block *nb,
+                                   unsigned long action, void *data)
+{
+       unsigned long start_pfn, end_pfn, pfn, section_nr;
+       struct mem_section *ms;
+       struct memory_notify *arg = data;
+
+       start_pfn = arg->start_pfn;
+       end_pfn = start_pfn + arg->nr_pages;
+
+       if (action != MEM_GOING_OFFLINE)
+               return NOTIFY_OK;
+
+       for (pfn = start_pfn; pfn < end_pfn; pfn += PAGES_PER_SECTION) {
+               section_nr = pfn_to_section_nr(pfn);
+               ms = __nr_to_section(section_nr);
+
+               if (early_section(ms))
+                       return NOTIFY_BAD;
+       }
+       return NOTIFY_OK;
+}
+
+static struct notifier_block boot_mem_remove_nb = {
+       .notifier_call = boot_mem_remove_notifier,
+};
+
+static int __init boot_mem_remove_init(void)
+{
+       return register_memory_notifier(&boot_mem_remove_nb);
+}
+device_initcall(boot_mem_remove_init);
 #endif

> 
>>
>>
> 
> 
