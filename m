Return-Path: <SRS0=sqB7=5R=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7F59FC43331
	for <linux-kernel@archiver.kernel.org>; Wed,  1 Apr 2020 06:03:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 26C1220714
	for <linux-kernel@archiver.kernel.org>; Wed,  1 Apr 2020 06:03:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=yandex-team.ru header.i=@yandex-team.ru header.b="YfALPzGA"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731772AbgDAGDv (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 1 Apr 2020 02:03:51 -0400
Received: from forwardcorp1j.mail.yandex.net ([5.45.199.163]:41270 "EHLO
        forwardcorp1j.mail.yandex.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1731721AbgDAGDu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Apr 2020 02:03:50 -0400
Received: from mxbackcorp1j.mail.yandex.net (mxbackcorp1j.mail.yandex.net [IPv6:2a02:6b8:0:1619::162])
        by forwardcorp1j.mail.yandex.net (Yandex) with ESMTP id 9CB872E15AB;
        Wed,  1 Apr 2020 09:03:46 +0300 (MSK)
Received: from myt5-70c90f7d6d7d.qloud-c.yandex.net (myt5-70c90f7d6d7d.qloud-c.yandex.net [2a02:6b8:c12:3e2c:0:640:70c9:f7d])
        by mxbackcorp1j.mail.yandex.net (mxbackcorp/Yandex) with ESMTP id 5s7A5tV1Tc-3jZeji0t;
        Wed, 01 Apr 2020 09:03:46 +0300
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yandex-team.ru; s=default;
        t=1585721026; bh=1bAHvSB3kmRgmi7tuFuA6Fe/PqgZGvIRR5VswNBqy+Q=;
        h=In-Reply-To:Message-ID:From:Date:References:To:Subject:Cc;
        b=YfALPzGAC6zjrqj4KLwLgQrUp2Jgykdgm5P/IsAz49/3PlbuZQCVHf0jt3Y8IDSWG
         2W/G0oynp9cNGWT37lf1aWhTPshOpu2Va5aUs06ssAtNvEMpnqa7bazieO2vVAMD3A
         upWnmJjWk5+mxuYs7aOHiICf/FtpjVsj5vJwYRis=
Authentication-Results: mxbackcorp1j.mail.yandex.net; dkim=pass header.i=@yandex-team.ru
Received: from unknown (unknown [2a02:6b8:b080:7613::1:5])
        by myt5-70c90f7d6d7d.qloud-c.yandex.net (smtpcorp/Yandex) with ESMTPSA id zG2YiQjTrL-3jWWQ0xO;
        Wed, 01 Apr 2020 09:03:45 +0300
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
        (Client certificate not present)
Subject: Re: [PATCH] /proc/PID/smaps: Add PMD migration entry parsing
To:     "Huang, Ying" <ying.huang@intel.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org,
        Andrea Arcangeli <aarcange@redhat.com>,
        "Kirill A . Shutemov" <kirill.shutemov@linux.intel.com>,
        Zi Yan <ziy@nvidia.com>, Vlastimil Babka <vbabka@suse.cz>,
        Alexey Dobriyan <adobriyan@gmail.com>,
        Michal Hocko <mhocko@suse.com>,
        =?UTF-8?B?SsOpcsO0bWUgR2xpc3Nl?= <jglisse@redhat.com>,
        Yang Shi <yang.shi@linux.alibaba.com>
References: <20200331085604.1260162-1-ying.huang@intel.com>
 <49386753-5984-f708-4153-e9c6de632439@yandex-team.ru>
 <87mu7whr88.fsf@yhuang-dev.intel.com>
From:   Konstantin Khlebnikov <khlebnikov@yandex-team.ru>
Message-ID: <a2ee2441-8ac7-84d2-8c7d-e28d80a6c413@yandex-team.ru>
Date:   Wed, 1 Apr 2020 09:03:45 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.1
MIME-Version: 1.0
In-Reply-To: <87mu7whr88.fsf@yhuang-dev.intel.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-CA
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 01/04/2020 05.31, Huang, Ying wrote:
> Konstantin Khlebnikov <khlebnikov@yandex-team.ru> writes:
> 
>> On 31/03/2020 11.56, Huang, Ying wrote:
>>> From: Huang Ying <ying.huang@intel.com>
>>>
>>> Now, when read /proc/PID/smaps, the PMD migration entry in page table is simply
>>> ignored.  To improve the accuracy of /proc/PID/smaps, its parsing and processing
>>> is added.
>>>
>>> Signed-off-by: "Huang, Ying" <ying.huang@intel.com>
>>> Cc: Andrea Arcangeli <aarcange@redhat.com>
>>> Cc: Kirill A. Shutemov <kirill.shutemov@linux.intel.com>
>>> Cc: Zi Yan <ziy@nvidia.com>
>>> Cc: Vlastimil Babka <vbabka@suse.cz>
>>> Cc: Alexey Dobriyan <adobriyan@gmail.com>
>>> Cc: Michal Hocko <mhocko@suse.com>
>>> Cc: Konstantin Khlebnikov <khlebnikov@yandex-team.ru>
>>> Cc: "Jérôme Glisse" <jglisse@redhat.com>
>>> Cc: Yang Shi <yang.shi@linux.alibaba.com>
>>> ---
>>>    fs/proc/task_mmu.c | 16 ++++++++++++----
>>>    1 file changed, 12 insertions(+), 4 deletions(-)
>>>
>>> diff --git a/fs/proc/task_mmu.c b/fs/proc/task_mmu.c
>>> index 8d382d4ec067..b5b3aef8cb3b 100644
>>> --- a/fs/proc/task_mmu.c
>>> +++ b/fs/proc/task_mmu.c
>>> @@ -548,8 +548,17 @@ static void smaps_pmd_entry(pmd_t *pmd, unsigned long addr,
>>>    	bool locked = !!(vma->vm_flags & VM_LOCKED);
>>>    	struct page *page;
>>
>>          struct page *page = NULL;
> 
> Looks good.  Will do this in the next version.
> 
>>>    -	/* FOLL_DUMP will return -EFAULT on huge zero page */
>>> -	page = follow_trans_huge_pmd(vma, addr, pmd, FOLL_DUMP);
>>> +	if (pmd_present(*pmd)) {
>>> +		/* FOLL_DUMP will return -EFAULT on huge zero page */
>>> +		page = follow_trans_huge_pmd(vma, addr, pmd, FOLL_DUMP);
>>> +	} else if (unlikely(is_swap_pmd(*pmd))) {
>>> +		swp_entry_t entry = pmd_to_swp_entry(*pmd);
>>> +
>>> +		VM_BUG_ON(!is_migration_entry(entry));
>>> +		page = migration_entry_to_page(entry);
>>
>>                  if (is_migration_entry(entry))
>>                          page = migration_entry_to_page(entry);
>>
>> Seems safer and doesn't add much code.
> 
> With this, we lose an opportunity to capture some bugs during debugging.
> Right?

You can keep VM_BUG_ON or VM_WARN_ON_ONCE

Off-by-page in statistics isn't a big deal and not a good reason to crash (even debug) kernel.
But for normal build should use safe behaviour if this isn't hard.

> 
> Best Regards,
> Huang, Ying
> 
>>> +	} else {
>>> +		return;
>>> +	}
>>>    	if (IS_ERR_OR_NULL(page))
>>>    		return;
>>>    	if (PageAnon(page))
>>> @@ -578,8 +587,7 @@ static int smaps_pte_range(pmd_t *pmd, unsigned long addr, unsigned long end,
>>>      	ptl = pmd_trans_huge_lock(pmd, vma);
>>>    	if (ptl) {
>>> -		if (pmd_present(*pmd))
>>> -			smaps_pmd_entry(pmd, addr, walk);
>>> +		smaps_pmd_entry(pmd, addr, walk);
>>>    		spin_unlock(ptl);
>>>    		goto out;
>>>    	}
>>>
