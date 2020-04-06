Return-Path: <SRS0=Zj89=5W=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	UNPARSEABLE_RELAY,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 674F0C2BA1A
	for <linux-kernel@archiver.kernel.org>; Mon,  6 Apr 2020 21:29:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3A81A206C3
	for <linux-kernel@archiver.kernel.org>; Mon,  6 Apr 2020 21:29:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726365AbgDFV3n (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 6 Apr 2020 17:29:43 -0400
Received: from out30-43.freemail.mail.aliyun.com ([115.124.30.43]:35840 "EHLO
        out30-43.freemail.mail.aliyun.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726277AbgDFV3n (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Apr 2020 17:29:43 -0400
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R781e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=e01e07425;MF=yang.shi@linux.alibaba.com;NM=1;PH=DS;RN=7;SR=0;TI=SMTPD_---0Tuqa2kI_1586208576;
Received: from US-143344MP.local(mailfrom:yang.shi@linux.alibaba.com fp:SMTPD_---0Tuqa2kI_1586208576)
          by smtp.aliyun-inc.com(127.0.0.1);
          Tue, 07 Apr 2020 05:29:39 +0800
Subject: Re: [PATCHv2 6/8] khugepaged: Allow to collapse PTE-mapped compound
 pages
To:     "Kirill A. Shutemov" <kirill@shutemov.name>,
        akpm@linux-foundation.org, Andrea Arcangeli <aarcange@redhat.com>
Cc:     Zi Yan <ziy@nvidia.com>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org,
        "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>
References: <20200403112928.19742-1-kirill.shutemov@linux.intel.com>
 <20200403112928.19742-7-kirill.shutemov@linux.intel.com>
From:   Yang Shi <yang.shi@linux.alibaba.com>
Message-ID: <10820b6f-f15a-1768-3aca-d0f464185b5e@linux.alibaba.com>
Date:   Mon, 6 Apr 2020 14:29:35 -0700
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.12; rv:52.0)
 Gecko/20100101 Thunderbird/52.7.0
MIME-Version: 1.0
In-Reply-To: <20200403112928.19742-7-kirill.shutemov@linux.intel.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 4/3/20 4:29 AM, Kirill A. Shutemov wrote:
> We can collapse PTE-mapped compound pages. We only need to avoid
> handling them more than once: lock/unlock page only once if it's present
> in the PMD range multiple times as it handled on compound level. The
> same goes for LRU isolation and putback.
>
> Signed-off-by: Kirill A. Shutemov <kirill.shutemov@linux.intel.com>
> ---
>   mm/khugepaged.c | 103 ++++++++++++++++++++++++++++++++----------------
>   1 file changed, 68 insertions(+), 35 deletions(-)
>
> diff --git a/mm/khugepaged.c b/mm/khugepaged.c
> index 1e7e6543ebca..49e56e4e30d1 100644
> --- a/mm/khugepaged.c
> +++ b/mm/khugepaged.c
> @@ -515,23 +515,37 @@ void __khugepaged_exit(struct mm_struct *mm)
>   
>   static void release_pte_page(struct page *page)
>   {
> -	dec_node_page_state(page, NR_ISOLATED_ANON + page_is_file_cache(page));
> +	mod_node_page_state(page_pgdat(page),
> +			NR_ISOLATED_ANON + page_is_file_cache(page),
> +			-compound_nr(page));
>   	unlock_page(page);
>   	putback_lru_page(page);
>   }
>   
> -static void release_pte_pages(pte_t *pte, pte_t *_pte)
> +static void release_pte_pages(pte_t *pte, pte_t *_pte,
> +		struct list_head *compound_pagelist)
>   {
> +	struct page *page, *tmp;
> +
>   	while (--_pte >= pte) {
>   		pte_t pteval = *_pte;
> -		if (!pte_none(pteval) && !is_zero_pfn(pte_pfn(pteval)))
> -			release_pte_page(pte_page(pteval));
> +
> +		page = pte_page(pteval);
> +		if (!pte_none(pteval) && !is_zero_pfn(pte_pfn(pteval)) &&
> +				!PageCompound(page))
> +			release_pte_page(page);
> +	}
> +
> +	list_for_each_entry_safe(page, tmp, compound_pagelist, lru) {
> +		list_del(&page->lru);
> +		release_pte_page(page);
>   	}
>   }
>   
>   static int __collapse_huge_page_isolate(struct vm_area_struct *vma,
>   					unsigned long address,
> -					pte_t *pte)
> +					pte_t *pte,
> +					struct list_head *compound_pagelist)
>   {
>   	struct page *page = NULL;
>   	pte_t *_pte;
> @@ -561,13 +575,21 @@ static int __collapse_huge_page_isolate(struct vm_area_struct *vma,
>   			goto out;
>   		}
>   
> -		/* TODO: teach khugepaged to collapse THP mapped with pte */
> +		VM_BUG_ON_PAGE(!PageAnon(page), page);
> +
>   		if (PageCompound(page)) {
> -			result = SCAN_PAGE_COMPOUND;
> -			goto out;
> -		}
> +			struct page *p;
> +			page = compound_head(page);
>   
> -		VM_BUG_ON_PAGE(!PageAnon(page), page);
> +			/*
> +			 * Check if we have dealt with the compound page
> +			 * already
> +			 */
> +			list_for_each_entry(p, compound_pagelist, lru) {
> +				if (page == p)
> +					goto next;
> +			}
> +		}
>   
>   		/*
>   		 * We can do it before isolate_lru_page because the
> @@ -597,19 +619,15 @@ static int __collapse_huge_page_isolate(struct vm_area_struct *vma,
>   			result = SCAN_PAGE_COUNT;
>   			goto out;
>   		}
> -		if (pte_write(pteval)) {
> -			writable = true;
> -		} else {
> -			if (PageSwapCache(page) &&
> -			    !reuse_swap_page(page, NULL)) {
> -				unlock_page(page);
> -				result = SCAN_SWAP_CACHE_PAGE;
> -				goto out;
> -			}
> +		if (!pte_write(pteval) && PageSwapCache(page) &&
> +				!reuse_swap_page(page, NULL)) {
>   			/*
> -			 * Page is not in the swap cache. It can be collapsed
> -			 * into a THP.
> +			 * Page is in the swap cache and cannot be re-used.
> +			 * It cannot be collapsed into a THP.
>   			 */
> +			unlock_page(page);
> +			result = SCAN_SWAP_CACHE_PAGE;
> +			goto out;
>   		}
>   
>   		/*
> @@ -621,16 +639,23 @@ static int __collapse_huge_page_isolate(struct vm_area_struct *vma,
>   			result = SCAN_DEL_PAGE_LRU;
>   			goto out;
>   		}
> -		inc_node_page_state(page,
> -				NR_ISOLATED_ANON + page_is_file_cache(page));
> +		mod_node_page_state(page_pgdat(page),
> +				NR_ISOLATED_ANON + page_is_file_cache(page),
> +				compound_nr(page));
>   		VM_BUG_ON_PAGE(!PageLocked(page), page);
>   		VM_BUG_ON_PAGE(PageLRU(page), page);
>   
> +		if (PageCompound(page))
> +			list_add_tail(&page->lru, compound_pagelist);
> +next:
>   		/* There should be enough young pte to collapse the page */
>   		if (pte_young(pteval) ||
>   		    page_is_young(page) || PageReferenced(page) ||
>   		    mmu_notifier_test_young(vma->vm_mm, address))
>   			referenced++;
> +
> +		if (pte_write(pteval))
> +			writable = true;
>   	}
>   	if (likely(writable)) {
>   		if (likely(referenced)) {
> @@ -644,7 +669,7 @@ static int __collapse_huge_page_isolate(struct vm_area_struct *vma,
>   	}
>   
>   out:
> -	release_pte_pages(pte, _pte);
> +	release_pte_pages(pte, _pte, compound_pagelist);
>   	trace_mm_collapse_huge_page_isolate(page, none_or_zero,
>   					    referenced, writable, result);
>   	return 0;
> @@ -653,13 +678,14 @@ static int __collapse_huge_page_isolate(struct vm_area_struct *vma,
>   static void __collapse_huge_page_copy(pte_t *pte, struct page *page,
>   				      struct vm_area_struct *vma,
>   				      unsigned long address,
> -				      spinlock_t *ptl)
> +				      spinlock_t *ptl,
> +				      struct list_head *compound_pagelist)
>   {
> +	struct page *src_page, *tmp;
>   	pte_t *_pte;
>   	for (_pte = pte; _pte < pte + HPAGE_PMD_NR;
>   				_pte++, page++, address += PAGE_SIZE) {
>   		pte_t pteval = *_pte;
> -		struct page *src_page;
>   
>   		if (pte_none(pteval) || is_zero_pfn(pte_pfn(pteval))) {
>   			clear_user_highpage(page, address);
> @@ -679,7 +705,6 @@ static void __collapse_huge_page_copy(pte_t *pte, struct page *page,
>   		} else {
>   			src_page = pte_page(pteval);
>   			copy_user_highpage(page, src_page, address, vma);
> -			release_pte_page(src_page);
>   			/*
>   			 * ptl mostly unnecessary, but preempt has to
>   			 * be disabled to update the per-cpu stats
> @@ -693,9 +718,18 @@ static void __collapse_huge_page_copy(pte_t *pte, struct page *page,
>   			pte_clear(vma->vm_mm, address, _pte);
>   			page_remove_rmap(src_page, false);
>   			spin_unlock(ptl);
> -			free_page_and_swap_cache(src_page);
> +			if (!PageCompound(src_page)) {
> +				release_pte_page(src_page);
> +				free_page_and_swap_cache(src_page);
> +			}
>   		}
>   	}
> +
> +	list_for_each_entry_safe(src_page, tmp, compound_pagelist, lru) {
> +		list_del(&src_page->lru);
> +		release_pte_page(src_page);
> +		free_page_and_swap_cache(src_page);
> +	}

It looks this may mess up the PTE-mapped THP's refcount if it has 
multiple PTE-mapped subpages since put_page() is not called for every 
PTE-mapped subpages.

>   }
>   
>   static void khugepaged_alloc_sleep(void)
> @@ -960,6 +994,7 @@ static void collapse_huge_page(struct mm_struct *mm,
>   				   struct page **hpage,
>   				   int node, int referenced)
>   {
> +	LIST_HEAD(compound_pagelist);
>   	pmd_t *pmd, _pmd;
>   	pte_t *pte;
>   	pgtable_t pgtable;
> @@ -1059,7 +1094,8 @@ static void collapse_huge_page(struct mm_struct *mm,
>   	mmu_notifier_invalidate_range_end(&range);
>   
>   	spin_lock(pte_ptl);
> -	isolated = __collapse_huge_page_isolate(vma, address, pte);
> +	isolated = __collapse_huge_page_isolate(vma, address, pte,
> +			&compound_pagelist);
>   	spin_unlock(pte_ptl);
>   
>   	if (unlikely(!isolated)) {
> @@ -1084,7 +1120,8 @@ static void collapse_huge_page(struct mm_struct *mm,
>   	 */
>   	anon_vma_unlock_write(vma->anon_vma);
>   
> -	__collapse_huge_page_copy(pte, new_page, vma, address, pte_ptl);
> +	__collapse_huge_page_copy(pte, new_page, vma, address, pte_ptl,
> +			&compound_pagelist);
>   	pte_unmap(pte);
>   	__SetPageUptodate(new_page);
>   	pgtable = pmd_pgtable(_pmd);
> @@ -1181,11 +1218,7 @@ static int khugepaged_scan_pmd(struct mm_struct *mm,
>   			goto out_unmap;
>   		}
>   
> -		/* TODO: teach khugepaged to collapse THP mapped with pte */
> -		if (PageCompound(page)) {
> -			result = SCAN_PAGE_COMPOUND;
> -			goto out_unmap;
> -		}
> +		page = compound_head(page);
>   
>   		/*
>   		 * Record which node the original page is from and save this

