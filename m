Return-Path: <SRS0=pNjS=57=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	UNPARSEABLE_RELAY,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9B61DC3815B
	for <linux-kernel@archiver.kernel.org>; Wed, 15 Apr 2020 20:32:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8109820774
	for <linux-kernel@archiver.kernel.org>; Wed, 15 Apr 2020 20:32:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2636963AbgDOUcY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 15 Apr 2020 16:32:24 -0400
Received: from out30-133.freemail.mail.aliyun.com ([115.124.30.133]:35900 "EHLO
        out30-133.freemail.mail.aliyun.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S2438404AbgDOUbn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Apr 2020 16:31:43 -0400
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R201e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=e01e07484;MF=yang.shi@linux.alibaba.com;NM=1;PH=DS;RN=9;SR=0;TI=SMTPD_---0TvdzT39_1586982696;
Received: from US-143344MP.local(mailfrom:yang.shi@linux.alibaba.com fp:SMTPD_---0TvdzT39_1586982696)
          by smtp.aliyun-inc.com(127.0.0.1);
          Thu, 16 Apr 2020 04:31:39 +0800
Subject: Re: [PATCHv3, RESEND 2/8] khugepaged: Do not stop collapse if less
 than half PTEs are referenced
To:     "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>,
        akpm@linux-foundation.org, Andrea Arcangeli <aarcange@redhat.com>
Cc:     Zi Yan <ziy@nvidia.com>, Ralph Campbell <rcampbell@nvidia.com>,
        John Hubbard <jhubbard@nvidia.com>,
        William Kucharski <william.kucharski@oracle.com>,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org
References: <20200413125220.663-1-kirill.shutemov@linux.intel.com>
 <20200413125220.663-3-kirill.shutemov@linux.intel.com>
From:   Yang Shi <yang.shi@linux.alibaba.com>
Message-ID: <902cad73-c3ef-c274-7483-c948167639e9@linux.alibaba.com>
Date:   Wed, 15 Apr 2020 13:31:33 -0700
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.12; rv:52.0)
 Gecko/20100101 Thunderbird/52.7.0
MIME-Version: 1.0
In-Reply-To: <20200413125220.663-3-kirill.shutemov@linux.intel.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 4/13/20 5:52 AM, Kirill A. Shutemov wrote:
> __collapse_huge_page_swapin() checks the number of referenced PTE to
> decide if the memory range is hot enough to justify swapin.
>
> We have few problems with the approach:
>
>   - It is way too late: we can do the check much earlier and safe time.
>     khugepaged_scan_pmd() already knows if we have any pages to swap in
>     and number of referenced page.
>
>   - It stops collapse altogether if there's not enough referenced pages,
>     not only swappingin.
>
> Fix it by making the right check early. We also can avoid additional
> page table scanning if khugepaged_scan_pmd() haven't found any swap
> entries.
>
> Signed-off-by: Kirill A. Shutemov <kirill.shutemov@linux.intel.com>
> Fixes: 0db501f7a34c ("mm, thp: convert from optimistic swapin collapsing to conservative")
> ---
>   mm/khugepaged.c | 25 ++++++++++---------------
>   1 file changed, 10 insertions(+), 15 deletions(-)

Acked-by: Yang Shi <yang.shi@linux.alibaba.com>

Just a nit below.

>
> diff --git a/mm/khugepaged.c b/mm/khugepaged.c
> index 99bab7e4d05b..5968ec5ddd6b 100644
> --- a/mm/khugepaged.c
> +++ b/mm/khugepaged.c
> @@ -902,11 +902,6 @@ static bool __collapse_huge_page_swapin(struct mm_struct *mm,
>   		.pgoff = linear_page_index(vma, address),
>   	};
>   
> -	/* we only decide to swapin, if there is enough young ptes */
> -	if (referenced < HPAGE_PMD_NR/2) {
> -		trace_mm_collapse_huge_page_swapin(mm, swapped_in, referenced, 0);
> -		return false;
> -	}
>   	vmf.pte = pte_offset_map(pmd, address);
>   	for (; vmf.address < address + HPAGE_PMD_NR*PAGE_SIZE;
>   			vmf.pte++, vmf.address += PAGE_SIZE) {
> @@ -946,7 +941,7 @@ static bool __collapse_huge_page_swapin(struct mm_struct *mm,
>   static void collapse_huge_page(struct mm_struct *mm,
>   				   unsigned long address,
>   				   struct page **hpage,
> -				   int node, int referenced)
> +				   int node, int referenced, int unmapped)
>   {
>   	pmd_t *pmd, _pmd;
>   	pte_t *pte;
> @@ -1003,7 +998,8 @@ static void collapse_huge_page(struct mm_struct *mm,
>   	 * If it fails, we release mmap_sem and jump out_nolock.
>   	 * Continuing to collapse causes inconsistency.
>   	 */
> -	if (!__collapse_huge_page_swapin(mm, vma, address, pmd, referenced)) {
> +	if (unmapped && !__collapse_huge_page_swapin(mm, vma, address,
> +				pmd, referenced)) {
>   		mem_cgroup_cancel_charge(new_page, memcg, true);
>   		up_read(&mm->mmap_sem);
>   		goto out_nolock;
> @@ -1214,22 +1210,21 @@ static int khugepaged_scan_pmd(struct mm_struct *mm,
>   		    mmu_notifier_test_young(vma->vm_mm, address))
>   			referenced++;
>   	}
> -	if (writable) {
> -		if (referenced) {
> +	if (!writable) {
> +		result = SCAN_PAGE_RO;
> +	} else if (!referenced || (unmapped && referenced < HPAGE_PMD_NR/2)) {
> +		result = SCAN_LACK_REFERENCED_PAGE;
> +	} else {
>   			result = SCAN_SUCCEED;
>   			ret = 1;

Shall fix the indentation for the above two statements?

> -		} else {
> -			result = SCAN_LACK_REFERENCED_PAGE;
> -		}
> -	} else {
> -		result = SCAN_PAGE_RO;
>   	}
>   out_unmap:
>   	pte_unmap_unlock(pte, ptl);
>   	if (ret) {
>   		node = khugepaged_find_target_node();
>   		/* collapse_huge_page will return with the mmap_sem released */
> -		collapse_huge_page(mm, address, hpage, node, referenced);
> +		collapse_huge_page(mm, address, hpage, node,
> +				referenced, unmapped);
>   	}
>   out:
>   	trace_mm_khugepaged_scan_pmd(mm, page, writable, referenced,

