Return-Path: <SRS0=iZC5=5S=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 926B0C43331
	for <linux-kernel@archiver.kernel.org>; Thu,  2 Apr 2020 15:52:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 70F5620737
	for <linux-kernel@archiver.kernel.org>; Thu,  2 Apr 2020 15:52:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389617AbgDBPwf (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 2 Apr 2020 11:52:35 -0400
Received: from out4436.biz.mail.alibaba.com ([47.88.44.36]:1098 "EHLO
        out4436.biz.mail.alibaba.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S2389458AbgDBPwf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Apr 2020 11:52:35 -0400
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R141e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=e01e01358;MF=yang.shi@linux.alibaba.com;NM=1;PH=DS;RN=12;SR=0;TI=SMTPD_---0TuR6onf_1585842736;
Received: from US-143344MP.local(mailfrom:yang.shi@linux.alibaba.com fp:SMTPD_---0TuR6onf_1585842736)
          by smtp.aliyun-inc.com(127.0.0.1);
          Thu, 02 Apr 2020 23:52:19 +0800
Subject: Re: [PATCH -V2] /proc/PID/smaps: Add PMD migration entry parsing
To:     Michal Hocko <mhocko@kernel.org>,
        "Huang, Ying" <ying.huang@intel.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, Zi Yan <ziy@nvidia.com>,
        Andrea Arcangeli <aarcange@redhat.com>,
        "Kirill A . Shutemov" <kirill.shutemov@linux.intel.com>,
        Vlastimil Babka <vbabka@suse.cz>,
        Alexey Dobriyan <adobriyan@gmail.com>,
        Konstantin Khlebnikov <khlebnikov@yandex-team.ru>,
        =?UTF-8?B?Su+/vXLvv71tZSBHbGlzc2U=?= <jglisse@redhat.com>
References: <20200402020031.1611223-1-ying.huang@intel.com>
 <20200402064437.GC22681@dhcp22.suse.cz> <87zhbufjyc.fsf@yhuang-dev.intel.com>
 <20200402074411.GH22681@dhcp22.suse.cz>
From:   Yang Shi <yang.shi@linux.alibaba.com>
Message-ID: <30321c02-6dc4-889f-142c-532b47a67f66@linux.alibaba.com>
Date:   Thu, 2 Apr 2020 08:52:12 -0700
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.12; rv:52.0)
 Gecko/20100101 Thunderbird/52.7.0
MIME-Version: 1.0
In-Reply-To: <20200402074411.GH22681@dhcp22.suse.cz>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 4/2/20 12:44 AM, Michal Hocko wrote:
> On Thu 02-04-20 15:03:23, Huang, Ying wrote:
>> Michal Hocko <mhocko@kernel.org> writes:
>>
>>> On Thu 02-04-20 10:00:31, Huang, Ying wrote:
>>>> From: Huang Ying <ying.huang@intel.com>
>>>>
>>>> Now, when read /proc/PID/smaps, the PMD migration entry in page table is simply
>>>> ignored.  To improve the accuracy of /proc/PID/smaps, its parsing and processing
>>>> is added.
>>>>
>>>> Before the patch, for a fully populated 400 MB anonymous VMA, sometimes some THP
>>>> pages under migration may be lost as follows.
>>> Interesting. How did you reproduce this?
>>> [...]
>> I run the pmbench in background to eat memory, then run
>> `/usr/bin/migratepages` and `cat /proc/PID/smaps` every second.  The
>> issue can be reproduced within 60 seconds.
> Please add that information to the changelog. I was probably too
> optimistic about the migration duration because I found it highly
> unlikely to be visible. I was clearly wrong here.

I believe that depends on the page is shared by how many processes. If 
it is not shared then it should just take dozens micro seconds in my 
test FYI.

>
>>>> diff --git a/fs/proc/task_mmu.c b/fs/proc/task_mmu.c
>>>> index 8d382d4ec067..9c72f9ce2dd8 100644
>>>> --- a/fs/proc/task_mmu.c
>>>> +++ b/fs/proc/task_mmu.c
>>>> @@ -546,10 +546,19 @@ static void smaps_pmd_entry(pmd_t *pmd, unsigned long addr,
>>>>   	struct mem_size_stats *mss = walk->private;
>>>>   	struct vm_area_struct *vma = walk->vma;
>>>>   	bool locked = !!(vma->vm_flags & VM_LOCKED);
>>>> -	struct page *page;
>>>> +	struct page *page = NULL;
>>>>   
>>>> -	/* FOLL_DUMP will return -EFAULT on huge zero page */
>>>> -	page = follow_trans_huge_pmd(vma, addr, pmd, FOLL_DUMP);
>>>> +	if (pmd_present(*pmd)) {
>>>> +		/* FOLL_DUMP will return -EFAULT on huge zero page */
>>>> +		page = follow_trans_huge_pmd(vma, addr, pmd, FOLL_DUMP);
>>>> +	} else if (unlikely(thp_migration_supported() && is_swap_pmd(*pmd))) {
>>>> +		swp_entry_t entry = pmd_to_swp_entry(*pmd);
>>>> +
>>>> +		if (is_migration_entry(entry))
>>>> +			page = migration_entry_to_page(entry);
>>>> +		else
>>>> +			VM_WARN_ON_ONCE(1);
>>> Could you explain why do we need this WARN_ON? I haven't really checked
>>> the swap support for THP but cannot we have normal swap pmd entries?
>> I have some patches to add the swap pmd entry support, but they haven't
>> been merged yet.
>>
>> Similar checks are for all THP migration code paths, so I follow the
>> same style.
> I haven't checked other migration code paths but what is the reason to
> add the warning here? Even if this shouldn't happen, smaps is perfectly
> fine to ignore that situation, no?

