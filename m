Return-Path: <SRS0=sVLE=55=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 679F9C2BA2B
	for <linux-kernel@archiver.kernel.org>; Mon, 13 Apr 2020 20:48:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 39E1C20656
	for <linux-kernel@archiver.kernel.org>; Mon, 13 Apr 2020 20:48:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=nvidia.com header.i=@nvidia.com header.b="LxzGnQLh"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388589AbgDMUsd (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 13 Apr 2020 16:48:33 -0400
Received: from hqnvemgate24.nvidia.com ([216.228.121.143]:7893 "EHLO
        hqnvemgate24.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388526AbgDMUsY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Apr 2020 16:48:24 -0400
Received: from hqpgpgate101.nvidia.com (Not Verified[216.228.121.13]) by hqnvemgate24.nvidia.com (using TLS: TLSv1.2, DES-CBC3-SHA)
        id <B5e94cfac0000>; Mon, 13 Apr 2020 13:46:36 -0700
Received: from hqmail.nvidia.com ([172.20.161.6])
  by hqpgpgate101.nvidia.com (PGP Universal service);
  Mon, 13 Apr 2020 13:48:23 -0700
X-PGP-Universal: processed;
        by hqpgpgate101.nvidia.com on Mon, 13 Apr 2020 13:48:23 -0700
Received: from DRHQMAIL107.nvidia.com (10.27.9.16) by HQMAIL101.nvidia.com
 (172.20.187.10) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Mon, 13 Apr
 2020 20:48:23 +0000
Received: from [10.2.165.57] (10.124.1.5) by DRHQMAIL107.nvidia.com
 (10.27.9.16) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Mon, 13 Apr
 2020 20:48:23 +0000
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
From:   John Hubbard <jhubbard@nvidia.com>
X-Nvconfidentiality: public
Message-ID: <0efcc512-6f12-1ff0-9885-871172fac766@nvidia.com>
Date:   Mon, 13 Apr 2020 13:48:22 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
MIME-Version: 1.0
In-Reply-To: <20200413125220.663-6-kirill.shutemov@linux.intel.com>
X-Originating-IP: [10.124.1.5]
X-ClientProxiedBy: HQMAIL111.nvidia.com (172.20.187.18) To
 DRHQMAIL107.nvidia.com (10.27.9.16)
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
        t=1586810796; bh=tKhGhAbvW8RVTnTNLMwbdMpfQAv28W2gmBCcQJpVzWA=;
        h=X-PGP-Universal:Subject:To:CC:References:From:X-Nvconfidentiality:
         Message-ID:Date:User-Agent:MIME-Version:In-Reply-To:
         X-Originating-IP:X-ClientProxiedBy:Content-Type:Content-Language:
         Content-Transfer-Encoding;
        b=LxzGnQLhQqXXKxkkyqvtEn205kQHUs73G2qpnQHMJWCGfl1grLQKcwNgCkz9b/pIJ
         gIoKjjBeGyoBDERGXRJB456X67MgNbqonkK3aXug7LlbtngBnflk/jw9ocyc2UwcEi
         swwCcBV8zzzE09EcGBpU9Z0jdBQQkC0qAMvHzgwA+8mbyE7bl5Lflrg0WxHkc62nud
         E6U5xOX4K6gMl4xFSIWQZWSyCqSBUekTNwvNLAKapABGcJuPHU/dIQ/Sfl3Umw6YxD
         aI2k3+7dnMzPF5+1ovaP1eSbZz98HVumb7qxArbjJpR/2BAD9JLCus4Y1rYY3pZOrz
         Da4Fpn2EBZM1Q==
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 4/13/20 5:52 AM, Kirill A. Shutemov wrote:
> The page can be included into collapse as long as it doesn't have extra
> pins (from GUP or otherwise).
> 
> Logic to check the refcound is moved to a separate function.

"refcount"

> Note that the function is ready to deal with compound pages. It's
> preparation for the following patch.

Maybe:

"Added compound_nr(page) to the expected refcount, in order to handle
the compound page case. This is in preparation for the following patch."

(Just to make it clear that this is not just refactoring, but also a
change.)

> 
> VM_BUG_ON_PAGE() was removed from __collapse_huge_page_copy() as the
> invariant it checks is no longer valid: the source can be mapped
> multiple times now.
> 
> Signed-off-by: Kirill A. Shutemov <kirill.shutemov@linux.intel.com>
> ---
>   mm/khugepaged.c | 41 ++++++++++++++++++++++++++++++-----------
>   1 file changed, 30 insertions(+), 11 deletions(-)
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


This looks nice.


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


I see two issues with the pr_err() and the dump_page() call:

1. You probably want to rate limit this, otherwise you'll have a big
problem if lots of pages are pinned!

2. Actually, I don't think you'd want to print anything at all here, even with
rate limiting, because doing so presumes that "unexpected" means "wrong". And I
think this patch doesn't expect to have GUP pins (or pin_user_pages() pins, ha),
but that doesn't mean that they're wrong to have.


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

"but not from this process. The other process"

(It's very hard to figure out what "it is fine" means in this context, so
better to leave it out, imho.)

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

thanks,
-- 
John Hubbard
NVIDIA
