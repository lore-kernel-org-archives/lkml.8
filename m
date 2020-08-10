Return-Path: <SRS0=LKJ9=BU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 365ECC433DF
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Aug 2020 22:38:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1A84A206DA
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Aug 2020 22:38:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727025AbgHJWii (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 10 Aug 2020 18:38:38 -0400
Received: from mga09.intel.com ([134.134.136.24]:56079 "EHLO mga09.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726634AbgHJWii (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Aug 2020 18:38:38 -0400
IronPort-SDR: a1A/08u2v2FSWMpu0q+KBPGZ9tCOP/lDA0JF4BN1uGPKmhRnlGSxNadcXJjJCMK/QciDvRnwzK
 Uj3uXiWre1OQ==
X-IronPort-AV: E=McAfee;i="6000,8403,9709"; a="154751715"
X-IronPort-AV: E=Sophos;i="5.75,458,1589266800"; 
   d="scan'208";a="154751715"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Aug 2020 15:38:37 -0700
IronPort-SDR: 0QKD+19C+grAxelnAk46SqzS1R3He5SpNsN/YSWBr8+PtyF0oB28kxYB8nwn0yZ9uVZSeZJaT3
 McWV68CA2VvA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.75,458,1589266800"; 
   d="scan'208";a="334378867"
Received: from linux.intel.com ([10.54.29.200])
  by orsmga007.jf.intel.com with ESMTP; 10 Aug 2020 15:38:37 -0700
Received: from [10.254.81.180] (kliang2-MOBL.ccr.corp.intel.com [10.254.81.180])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by linux.intel.com (Postfix) with ESMTPS id 8E961580223;
        Mon, 10 Aug 2020 15:38:36 -0700 (PDT)
Subject: Re: [PATCH V6 01/16] perf/core: Add PERF_SAMPLE_DATA_PAGE_SIZE
To:     Dave Hansen <dave.hansen@intel.com>, peterz@infradead.org,
        acme@kernel.org, mingo@redhat.com, linux-kernel@vger.kernel.org
Cc:     mark.rutland@arm.com, alexander.shishkin@linux.intel.com,
        jolsa@redhat.com, eranian@google.com, ak@linux.intel.com,
        kirill.shutemov@linux.intel.com
References: <20200810212436.8026-1-kan.liang@linux.intel.com>
 <20200810212436.8026-2-kan.liang@linux.intel.com>
 <b5422d70-f5d3-f2eb-0b39-4efd050d8828@intel.com>
From:   "Liang, Kan" <kan.liang@linux.intel.com>
Message-ID: <298cfc4d-4a9b-7886-1006-09f2bc24d789@linux.intel.com>
Date:   Mon, 10 Aug 2020 18:38:35 -0400
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.11.0
MIME-Version: 1.0
In-Reply-To: <b5422d70-f5d3-f2eb-0b39-4efd050d8828@intel.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 8/10/2020 5:47 PM, Dave Hansen wrote:
> On 8/10/20 2:24 PM, Kan Liang wrote:
>> +static u64 __perf_get_page_size(struct mm_struct *mm, unsigned long addr)
>> +{
>> +	struct page *page;
>> +	pgd_t *pgd;
>> +	p4d_t *p4d;
>> +	pud_t *pud;
>> +	pmd_t *pmd;
>> +	pte_t *pte;
>> +
>> +	pgd = pgd_offset(mm, addr);
>> +	if (pgd_none(*pgd))
>> +		return 0;
>> +
>> +	p4d = p4d_offset(pgd, addr);
>> +	if (!p4d_present(*p4d))
>> +		return 0;
>> +
>> +#if (defined(CONFIG_HUGETLB_PAGE) || defined(CONFIG_TRANSPARENT_HUGEPAGE))
>> +	if (p4d_leaf(*p4d)) {
>> +		page = p4d_page(*p4d);
>> +
>> +		if (PageCompound(page))
>> +			return page_size(compound_head(page));
>> +
>> +		return P4D_SIZE;
>> +	}
>> +#endif
>> +
>> +	pud = pud_offset(p4d, addr);
>> +	if (!pud_present(*pud))
>> +		return 0;
>> +
>> +#if (defined(CONFIG_HUGETLB_PAGE) || defined(CONFIG_TRANSPARENT_HUGEPAGE))
>> +	if (pud_leaf(*pud)) {
>> +		page = pud_page(*pud);
>> +
>> +		if (PageCompound(page))
>> +			return page_size(compound_head(page));
>> +
>> +		return PUD_SIZE;
>> +	}
>> +#endif
>> +
>> +	pmd = pmd_offset(pud, addr);
>> +	if (!pmd_present(*pmd))
>> +		return 0;
>> +
>> +#if (defined(CONFIG_HUGETLB_PAGE) || defined(CONFIG_TRANSPARENT_HUGEPAGE))
>> +	if (pmd_leaf(*pmd)) {
>> +		page = pmd_page(*pmd);
>> +
>> +		if (PageCompound(page))
>> +			return page_size(compound_head(page));
>> +
>> +		return PMD_SIZE;
>> +	}
>> +#endif
>> +
>> +	pte = pte_offset_map(pmd, addr);
>> +	if (!pte_present(*pte)) {
>> +		pte_unmap(pte);
>> +		return 0;
>> +	}
>> +
>> +	pte_unmap(pte);
>> +	return PAGE_SIZE;
>> +}
> 
> It's probably best if we very carefully define up front what is getting
> reported here.  For instance, I believe we already have some fun cases
> with huge tmpfs where a compound page is mapped with 4k PTEs.  Kirill
> also found a few drivers doing this as well.  I think there were also
> some weird cases for ARM hugetlbfs where there were multiple hardware
> page table entries mapping a single hugetlbfs page.  These would be
> cases where compound_head() size would be greater than the size of the
> leaf paging structure entry.
> 
> This is also why we have KerelPageSize and MMUPageSize in /proc/$pid/smaps.
> 
> So, is this returning the kernel software page size or the MMU size?
> 

This tries to return the kernel software page size. I will add a commit 
to the function. For the above cases, I think they can be detected by 
PageCompound(page). The current code should already cover them. Is my 
understanding correct?

Thanks,
Kan

