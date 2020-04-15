Return-Path: <SRS0=pNjS=57=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 43D17C2BB1D
	for <linux-kernel@archiver.kernel.org>; Wed, 15 Apr 2020 02:43:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1E8CA2076C
	for <linux-kernel@archiver.kernel.org>; Wed, 15 Apr 2020 02:43:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=nvidia.com header.i=@nvidia.com header.b="aCwUsGju"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2407937AbgDOCnn (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 14 Apr 2020 22:43:43 -0400
Received: from hqnvemgate25.nvidia.com ([216.228.121.64]:3230 "EHLO
        hqnvemgate25.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728267AbgDOCne (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Apr 2020 22:43:34 -0400
Received: from hqpgpgate101.nvidia.com (Not Verified[216.228.121.13]) by hqnvemgate25.nvidia.com (using TLS: TLSv1.2, DES-CBC3-SHA)
        id <B5e96749b0000>; Tue, 14 Apr 2020 19:42:35 -0700
Received: from hqmail.nvidia.com ([172.20.161.6])
  by hqpgpgate101.nvidia.com (PGP Universal service);
  Tue, 14 Apr 2020 19:43:33 -0700
X-PGP-Universal: processed;
        by hqpgpgate101.nvidia.com on Tue, 14 Apr 2020 19:43:33 -0700
Received: from DRHQMAIL107.nvidia.com (10.27.9.16) by HQMAIL105.nvidia.com
 (172.20.187.12) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Wed, 15 Apr
 2020 02:43:33 +0000
Received: from [10.2.85.126] (10.124.1.5) by DRHQMAIL107.nvidia.com
 (10.27.9.16) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Wed, 15 Apr
 2020 02:43:32 +0000
Subject: Re: [PATCHv3, RESEND 5/8] khugepaged: Allow to collapse a page shared
 across fork
To:     "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>,
        <akpm@linux-foundation.org>, Andrea Arcangeli <aarcange@redhat.com>
CC:     Zi Yan <ziy@nvidia.com>, Yang Shi <yang.shi@linux.alibaba.com>,
        "Ralph Campbell" <rcampbell@nvidia.com>,
        William Kucharski <william.kucharski@oracle.com>,
        <linux-mm@kvack.org>, <linux-kernel@vger.kernel.org>
References: <20200413125220.663-1-kirill.shutemov@linux.intel.com>
 <20200413125220.663-6-kirill.shutemov@linux.intel.com>
X-Nvconfidentiality: pubic
From:   John Hubbard <jhubbard@nvidia.com>
Message-ID: <ff03254a-2748-c7ed-8191-1fb9ca0ab75d@nvidia.com>
Date:   Tue, 14 Apr 2020 19:43:33 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
MIME-Version: 1.0
In-Reply-To: <20200413125220.663-6-kirill.shutemov@linux.intel.com>
X-Originating-IP: [10.124.1.5]
X-ClientProxiedBy: HQMAIL101.nvidia.com (172.20.187.10) To
 DRHQMAIL107.nvidia.com (10.27.9.16)
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
        t=1586918555; bh=UX3c89jXnjxEiDfb27o44dgboeTUpYrTZv3GY455y70=;
        h=X-PGP-Universal:Subject:To:CC:References:X-Nvconfidentiality:From:
         Message-ID:Date:User-Agent:MIME-Version:In-Reply-To:
         X-Originating-IP:X-ClientProxiedBy:Content-Type:Content-Language:
         Content-Transfer-Encoding;
        b=aCwUsGju17WUeYzku0G8OeZmCZTcMSqmprSsbNXqf9roOiejEqPSnjaGpKPr1m1q6
         jSRLwBPvzuJ2PuD4nu1Fl3HDX7IDyv++z0TakF0SAhD2gkoczj3eKSFT1gGGmABLYL
         oQ/7PBRT7MYsjj2euwVAcAA+639yesGjP60Z3+q9JFCra93oc5KVBVWNtvWrPLtQD2
         l978iF5RESddGAbfLJOGXDdiMOWyEuJKYMznJTjcJFeUClLSaA9v9ET/bYR6nw3mKt
         /Fnb9sjgtm+o+SYta6tUtn5UWrUBN3M6HDydiF4CJ6ivOX72ZjS5FBnhVfup37N95i
         B73hPLWjUiyXw==
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2020-04-13 05:52, Kirill A. Shutemov wrote:
> The page can be included into collapse as long as it doesn't have extra
> pins (from GUP or otherwise).
> 
> Logic to check the refcound is moved to a separate function.
> Note that the function is ready to deal with compound pages. It's
> preparation for the following patch.
> 
> VM_BUG_ON_PAGE() was removed from __collapse_huge_page_copy() as the
> invariant it checks is no longer valid: the source can be mapped
> multiple times now.
> 
> Signed-off-by: Kirill A. Shutemov <kirill.shutemov@linux.intel.com>
> ---
>   mm/khugepaged.c | 41 ++++++++++++++++++++++++++++++-----------
>   1 file changed, 30 insertions(+), 11 deletions(-)


Reviewed-by: John Hubbard <jhubbard@nvidia.com>

thanks,
-- 
John Hubbard
NVIDIA

> 
> diff --git a/mm/khugepaged.c b/mm/khugepaged.c
> index e3e41c2768d8..f9864644c3b7 100644
> --- a/mm/khugepaged.c
> +++ b/mm/khugepaged.c
> @@ -529,6 +529,24 @@ static void release_pte_pages(pte_t *pte, pte_t *_pte)
>   	}
>   }
>   
> +static bool is_refcount_suitable(struct page *page)
> +{
> +	int expected_refcount, refcount;
> +
> +	refcount = page_count(page);
> +	expected_refcount = total_mapcount(page);
> +	if (PageSwapCache(page))
> +		expected_refcount += compound_nr(page);
> +
> +	if (IS_ENABLED(CONFIG_DEBUG_VM) && expected_refcount > refcount) {
> +		pr_err("expected_refcount: %d, refcount: %d\n",
> +				expected_refcount, refcount);
> +		dump_page(page, "Unexpected refcount");
> +	}
> +
> +	return page_count(page) == expected_refcount;
> +}
> +
>   static int __collapse_huge_page_isolate(struct vm_area_struct *vma,
>   					unsigned long address,
>   					pte_t *pte)
> @@ -581,11 +599,17 @@ static int __collapse_huge_page_isolate(struct vm_area_struct *vma,
>   		}
>   
>   		/*
> -		 * cannot use mapcount: can't collapse if there's a gup pin.
> -		 * The page must only be referenced by the scanned process
> -		 * and page swap cache.
> +		 * Check if the page has any GUP (or other external) pins.
> +		 *
> +		 * The page table that maps the page has been already unlinked
> +		 * from the page table tree and this process cannot get
> +		 * an additinal pin on the page.
> +		 *
> +		 * New pins can come later if the page is shared across fork,
> +		 * but not for the this process. It is fine. The other process
> +		 * cannot write to the page, only trigger CoW.
>   		 */
> -		if (page_count(page) != 1 + PageSwapCache(page)) {
> +		if (!is_refcount_suitable(page)) {
>   			unlock_page(page);
>   			result = SCAN_PAGE_COUNT;
>   			goto out;
> @@ -672,7 +696,6 @@ static void __collapse_huge_page_copy(pte_t *pte, struct page *page,
>   		} else {
>   			src_page = pte_page(pteval);
>   			copy_user_highpage(page, src_page, address, vma);
> -			VM_BUG_ON_PAGE(page_mapcount(src_page) != 1, src_page);
>   			release_pte_page(src_page);
>   			/*
>   			 * ptl mostly unnecessary, but preempt has to
> @@ -1201,12 +1224,8 @@ static int khugepaged_scan_pmd(struct mm_struct *mm,
>   			goto out_unmap;
>   		}
>   
> -		/*
> -		 * cannot use mapcount: can't collapse if there's a gup pin.
> -		 * The page must only be referenced by the scanned process
> -		 * and page swap cache.
> -		 */
> -		if (page_count(page) != 1 + PageSwapCache(page)) {
> +		/* Check if the page has any GUP (or other external) pins */
> +		if (!is_refcount_suitable(page)) {
>   			result = SCAN_PAGE_COUNT;
>   			goto out_unmap;
>   		}
> 
