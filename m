Return-Path: <SRS0=pNjS=57=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	UNPARSEABLE_RELAY,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9DE5EC2BA2B
	for <linux-kernel@archiver.kernel.org>; Wed, 15 Apr 2020 20:39:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 83D7420787
	for <linux-kernel@archiver.kernel.org>; Wed, 15 Apr 2020 20:39:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2442091AbgDOUj1 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 15 Apr 2020 16:39:27 -0400
Received: from out30-131.freemail.mail.aliyun.com ([115.124.30.131]:45002 "EHLO
        out30-131.freemail.mail.aliyun.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S2438172AbgDOUjY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Apr 2020 16:39:24 -0400
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R201e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=e01e07488;MF=yang.shi@linux.alibaba.com;NM=1;PH=DS;RN=9;SR=0;TI=SMTPD_---0TvduEle_1586983159;
Received: from US-143344MP.local(mailfrom:yang.shi@linux.alibaba.com fp:SMTPD_---0TvduEle_1586983159)
          by smtp.aliyun-inc.com(127.0.0.1);
          Thu, 16 Apr 2020 04:39:21 +0800
Subject: Re: [PATCHv3, RESEND 5/8] khugepaged: Allow to collapse a page shared
 across fork
To:     "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>,
        akpm@linux-foundation.org, Andrea Arcangeli <aarcange@redhat.com>
Cc:     Zi Yan <ziy@nvidia.com>, Ralph Campbell <rcampbell@nvidia.com>,
        John Hubbard <jhubbard@nvidia.com>,
        William Kucharski <william.kucharski@oracle.com>,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org
References: <20200413125220.663-1-kirill.shutemov@linux.intel.com>
 <20200413125220.663-6-kirill.shutemov@linux.intel.com>
From:   Yang Shi <yang.shi@linux.alibaba.com>
Message-ID: <a50c62d2-f51c-12f8-4d21-730715fb4a71@linux.alibaba.com>
Date:   Wed, 15 Apr 2020 13:39:16 -0700
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.12; rv:52.0)
 Gecko/20100101 Thunderbird/52.7.0
MIME-Version: 1.0
In-Reply-To: <20200413125220.663-6-kirill.shutemov@linux.intel.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 4/13/20 5:52 AM, Kirill A. Shutemov wrote:
> The page can be included into collapse as long as it doesn't have extra
> pins (from GUP or otherwise).
>
> Logic to check the refcound is moved to a separate function.

s/refcound/refcount

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

Just a minor typo problem.

Acked-by: Yang Shi <yang.shi@linux.alibaba.com>

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

