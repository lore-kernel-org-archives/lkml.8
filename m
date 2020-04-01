Return-Path: <SRS0=sqB7=5R=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3FEA4C43331
	for <linux-kernel@archiver.kernel.org>; Wed,  1 Apr 2020 02:31:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 19B5020578
	for <linux-kernel@archiver.kernel.org>; Wed,  1 Apr 2020 02:31:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731664AbgDACbJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 31 Mar 2020 22:31:09 -0400
Received: from mga07.intel.com ([134.134.136.100]:36242 "EHLO mga07.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731554AbgDACbI (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 31 Mar 2020 22:31:08 -0400
IronPort-SDR: 4oOl8ZmwFHBm4g9LriFHcZ1bHkszQo4xyT7KG6Q3oj2VTjYeGVlCn+N0f1wUbWY8d7TC6DwCv0
 f3mR160P9J0g==
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 31 Mar 2020 19:31:07 -0700
IronPort-SDR: mkxQL4GfjaPiHJkDgxEa8ej+AOXIVcRb79zvXmIGjlpTDcfnWQKS/u2c2Zc07tH0TNGk8wkKX4
 s27I35EhfIOQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.72,330,1580803200"; 
   d="scan'208";a="237910614"
Received: from yhuang-dev.sh.intel.com (HELO yhuang-dev) ([10.239.159.23])
  by orsmga007.jf.intel.com with ESMTP; 31 Mar 2020 19:31:04 -0700
From:   "Huang\, Ying" <ying.huang@intel.com>
To:     Konstantin Khlebnikov <khlebnikov@yandex-team.ru>
Cc:     Andrew Morton <akpm@linux-foundation.org>, <linux-mm@kvack.org>,
        <linux-kernel@vger.kernel.org>,
        Andrea Arcangeli <aarcange@redhat.com>,
        "Kirill A . Shutemov" <kirill.shutemov@linux.intel.com>,
        Zi Yan <ziy@nvidia.com>, Vlastimil Babka <vbabka@suse.cz>,
        Alexey Dobriyan <adobriyan@gmail.com>,
        Michal Hocko <mhocko@suse.com>,
        =?utf-8?B?SsOp?= =?utf-8?B?csO0bWU=?= Glisse 
        <jglisse@redhat.com>, Yang Shi <yang.shi@linux.alibaba.com>
Subject: Re: [PATCH] /proc/PID/smaps: Add PMD migration entry parsing
References: <20200331085604.1260162-1-ying.huang@intel.com>
        <49386753-5984-f708-4153-e9c6de632439@yandex-team.ru>
Date:   Wed, 01 Apr 2020 10:31:03 +0800
In-Reply-To: <49386753-5984-f708-4153-e9c6de632439@yandex-team.ru> (Konstantin
        Khlebnikov's message of "Tue, 31 Mar 2020 12:51:38 +0300")
Message-ID: <87mu7whr88.fsf@yhuang-dev.intel.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Konstantin Khlebnikov <khlebnikov@yandex-team.ru> writes:

> On 31/03/2020 11.56, Huang, Ying wrote:
>> From: Huang Ying <ying.huang@intel.com>
>>
>> Now, when read /proc/PID/smaps, the PMD migration entry in page table is simply
>> ignored.  To improve the accuracy of /proc/PID/smaps, its parsing and processing
>> is added.
>>
>> Signed-off-by: "Huang, Ying" <ying.huang@intel.com>
>> Cc: Andrea Arcangeli <aarcange@redhat.com>
>> Cc: Kirill A. Shutemov <kirill.shutemov@linux.intel.com>
>> Cc: Zi Yan <ziy@nvidia.com>
>> Cc: Vlastimil Babka <vbabka@suse.cz>
>> Cc: Alexey Dobriyan <adobriyan@gmail.com>
>> Cc: Michal Hocko <mhocko@suse.com>
>> Cc: Konstantin Khlebnikov <khlebnikov@yandex-team.ru>
>> Cc: "Jérôme Glisse" <jglisse@redhat.com>
>> Cc: Yang Shi <yang.shi@linux.alibaba.com>
>> ---
>>   fs/proc/task_mmu.c | 16 ++++++++++++----
>>   1 file changed, 12 insertions(+), 4 deletions(-)
>>
>> diff --git a/fs/proc/task_mmu.c b/fs/proc/task_mmu.c
>> index 8d382d4ec067..b5b3aef8cb3b 100644
>> --- a/fs/proc/task_mmu.c
>> +++ b/fs/proc/task_mmu.c
>> @@ -548,8 +548,17 @@ static void smaps_pmd_entry(pmd_t *pmd, unsigned long addr,
>>   	bool locked = !!(vma->vm_flags & VM_LOCKED);
>>   	struct page *page;
>
>         struct page *page = NULL;

Looks good.  Will do this in the next version.

>>   -	/* FOLL_DUMP will return -EFAULT on huge zero page */
>> -	page = follow_trans_huge_pmd(vma, addr, pmd, FOLL_DUMP);
>> +	if (pmd_present(*pmd)) {
>> +		/* FOLL_DUMP will return -EFAULT on huge zero page */
>> +		page = follow_trans_huge_pmd(vma, addr, pmd, FOLL_DUMP);
>> +	} else if (unlikely(is_swap_pmd(*pmd))) {
>> +		swp_entry_t entry = pmd_to_swp_entry(*pmd);
>> +
>> +		VM_BUG_ON(!is_migration_entry(entry));
>> +		page = migration_entry_to_page(entry);
>
>                 if (is_migration_entry(entry))
>                         page = migration_entry_to_page(entry);
>
> Seems safer and doesn't add much code.

With this, we lose an opportunity to capture some bugs during debugging.
Right?

Best Regards,
Huang, Ying

>> +	} else {
>> +		return;
>> +	}
>>   	if (IS_ERR_OR_NULL(page))
>>   		return;
>>   	if (PageAnon(page))
>> @@ -578,8 +587,7 @@ static int smaps_pte_range(pmd_t *pmd, unsigned long addr, unsigned long end,
>>     	ptl = pmd_trans_huge_lock(pmd, vma);
>>   	if (ptl) {
>> -		if (pmd_present(*pmd))
>> -			smaps_pmd_entry(pmd, addr, walk);
>> +		smaps_pmd_entry(pmd, addr, walk);
>>   		spin_unlock(ptl);
>>   		goto out;
>>   	}
>>
