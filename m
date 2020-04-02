Return-Path: <SRS0=iZC5=5S=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EA3F5C43331
	for <linux-kernel@archiver.kernel.org>; Thu,  2 Apr 2020 01:42:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B32B920721
	for <linux-kernel@archiver.kernel.org>; Thu,  2 Apr 2020 01:42:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732783AbgDBBma (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 1 Apr 2020 21:42:30 -0400
Received: from mga09.intel.com ([134.134.136.24]:56444 "EHLO mga09.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726319AbgDBBma (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Apr 2020 21:42:30 -0400
IronPort-SDR: Ux0MT8tDp2uxmJRg8HIao4L222IaPNPyHZ4T5ZY8Vt7Q7F4t58ej46GcqulXR7h26LHlS58c2x
 08AWvbt7Ua8Q==
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Apr 2020 18:42:29 -0700
IronPort-SDR: Ow836iTrqGNe8ovWPKJP9uTb7WN4JK52gO/5s6TP5LGjeNhen6vF9xRq+FLhg3iniFRcZd+hHz
 OI0wFbSzty1A==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.72,333,1580803200"; 
   d="scan'208";a="252839081"
Received: from yhuang-dev.sh.intel.com (HELO yhuang-dev) ([10.239.159.23])
  by orsmga006.jf.intel.com with ESMTP; 01 Apr 2020 18:42:26 -0700
From:   "Huang\, Ying" <ying.huang@intel.com>
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     <linux-mm@kvack.org>, <linux-kernel@vger.kernel.org>,
        Andrea Arcangeli <aarcange@redhat.com>,
        "Kirill A . Shutemov" <kirill.shutemov@linux.intel.com>,
        Zi Yan <ziy@nvidia.com>, Vlastimil Babka <vbabka@suse.cz>,
        Alexey Dobriyan <adobriyan@gmail.com>,
        Michal Hocko <mhocko@suse.com>,
        Konstantin Khlebnikov <khlebnikov@yandex-team.ru>,
        jglisse@redhat.com, Yang Shi <yang.shi@linux.alibaba.com>
Subject: Re: [PATCH] /proc/PID/smaps: Add PMD migration entry parsing
References: <20200331085604.1260162-1-ying.huang@intel.com>
        <20200401160432.855bba5b210c7b4bbf6c56ef@linux-foundation.org>
Date:   Thu, 02 Apr 2020 09:42:26 +0800
In-Reply-To: <20200401160432.855bba5b210c7b4bbf6c56ef@linux-foundation.org>
        (Andrew Morton's message of "Wed, 1 Apr 2020 16:04:32 -0700")
Message-ID: <87h7y2hddp.fsf@yhuang-dev.intel.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=ascii
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Andrew Morton <akpm@linux-foundation.org> writes:

> On Tue, 31 Mar 2020 16:56:04 +0800 "Huang, Ying" <ying.huang@intel.com> wrote:
>
>> From: Huang Ying <ying.huang@intel.com>
>> 
>> Now, when read /proc/PID/smaps, the PMD migration entry in page table is simply
>> ignored.  To improve the accuracy of /proc/PID/smaps, its parsing and processing
>> is added.
>
> It would be helpful to show the before-and-after output in the changelog.

OK.

>> --- a/fs/proc/task_mmu.c
>> +++ b/fs/proc/task_mmu.c
>> @@ -548,8 +548,17 @@ static void smaps_pmd_entry(pmd_t *pmd, unsigned long addr,
>>  	bool locked = !!(vma->vm_flags & VM_LOCKED);
>>  	struct page *page;
>>  
>> -	/* FOLL_DUMP will return -EFAULT on huge zero page */
>> -	page = follow_trans_huge_pmd(vma, addr, pmd, FOLL_DUMP);
>> +	if (pmd_present(*pmd)) {
>> +		/* FOLL_DUMP will return -EFAULT on huge zero page */
>> +		page = follow_trans_huge_pmd(vma, addr, pmd, FOLL_DUMP);
>> +	} else if (unlikely(is_swap_pmd(*pmd))) {
>> +		swp_entry_t entry = pmd_to_swp_entry(*pmd);
>> +
>> +		VM_BUG_ON(!is_migration_entry(entry));
>
> I don't think this justifies nuking the kernel.  A
> WARN()-and-recover would be better.

Yes.  Will change this in the next version.

Best Regards,
Huang, Ying

>> +		page = migration_entry_to_page(entry);
>> +	} else {
>> +		return;
>> +	}
>>  	if (IS_ERR_OR_NULL(page))
>>  		return;
>>  	if (PageAnon(page))
>> @@ -578,8 +587,7 @@ static int smaps_pte_range(pmd_t *pmd, unsigned long addr, unsigned long end,
>>  
>>  	ptl = pmd_trans_huge_lock(pmd, vma);
>>  	if (ptl) {
>> -		if (pmd_present(*pmd))
>> -			smaps_pmd_entry(pmd, addr, walk);
>> +		smaps_pmd_entry(pmd, addr, walk);
>>  		spin_unlock(ptl);
>>  		goto out;
>>  	}
