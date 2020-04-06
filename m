Return-Path: <SRS0=Zj89=5W=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 079B7C2BA1A
	for <linux-kernel@archiver.kernel.org>; Mon,  6 Apr 2020 21:30:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CC493206C3
	for <linux-kernel@archiver.kernel.org>; Mon,  6 Apr 2020 21:30:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=nvidia.com header.i=@nvidia.com header.b="p/z31+jz"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726416AbgDFVaJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 6 Apr 2020 17:30:09 -0400
Received: from hqnvemgate24.nvidia.com ([216.228.121.143]:4644 "EHLO
        hqnvemgate24.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725933AbgDFVaJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Apr 2020 17:30:09 -0400
Received: from hqpgpgate101.nvidia.com (Not Verified[216.228.121.13]) by hqnvemgate24.nvidia.com (using TLS: TLSv1.2, DES-CBC3-SHA)
        id <B5e8b9efb0000>; Mon, 06 Apr 2020 14:28:27 -0700
Received: from hqmail.nvidia.com ([172.20.161.6])
  by hqpgpgate101.nvidia.com (PGP Universal service);
  Mon, 06 Apr 2020 14:30:08 -0700
X-PGP-Universal: processed;
        by hqpgpgate101.nvidia.com on Mon, 06 Apr 2020 14:30:08 -0700
Received: from DRHQMAIL107.nvidia.com (10.27.9.16) by HQMAIL109.nvidia.com
 (172.20.187.15) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Mon, 6 Apr
 2020 21:30:08 +0000
Received: from [10.2.60.145] (172.20.13.39) by DRHQMAIL107.nvidia.com
 (10.27.9.16) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Mon, 6 Apr 2020
 21:30:07 +0000
Subject: Re: [PATCHv2 5/8] khugepaged: Allow to callapse a page shared across
 fork
To:     "Kirill A. Shutemov" <kirill@shutemov.name>,
        <akpm@linux-foundation.org>, Andrea Arcangeli <aarcange@redhat.com>
CC:     Zi Yan <ziy@nvidia.com>, Yang Shi <yang.shi@linux.alibaba.com>,
        <linux-mm@kvack.org>, <linux-kernel@vger.kernel.org>,
        "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>
References: <20200403112928.19742-1-kirill.shutemov@linux.intel.com>
 <20200403112928.19742-6-kirill.shutemov@linux.intel.com>
X-Nvconfidentiality: public
From:   John Hubbard <jhubbard@nvidia.com>
Message-ID: <5a57635b-ed75-8f09-6f0c-5623f557fc55@nvidia.com>
Date:   Mon, 6 Apr 2020 14:30:07 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.6.0
MIME-Version: 1.0
In-Reply-To: <20200403112928.19742-6-kirill.shutemov@linux.intel.com>
X-Originating-IP: [172.20.13.39]
X-ClientProxiedBy: HQMAIL107.nvidia.com (172.20.187.13) To
 DRHQMAIL107.nvidia.com (10.27.9.16)
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
        t=1586208507; bh=LBAGWn1YAE5YWfeZ7nIgtxQX8b6/AI2BeWNRvWT0J+o=;
        h=X-PGP-Universal:Subject:To:CC:References:X-Nvconfidentiality:From:
         Message-ID:Date:User-Agent:MIME-Version:In-Reply-To:
         X-Originating-IP:X-ClientProxiedBy:Content-Type:Content-Language:
         Content-Transfer-Encoding;
        b=p/z31+jzqY/wgSr589kzTamsXjx6DdgS8Alysxj3pJ4/edz839OXXMVDJ5F5cbz8f
         zH7YqoqxJ5zQtVSHwfmyy0xFcSQqO5vvG+33+T+Pyh5b60TpZjrBTylyJNfzG1+h+6
         T7sE09x7nglK1ySqN42fcw9ZMTigsXrl0dfKH8wwfBMvy21k/fz0/x2AW/k7toWpzq
         j7BAd4xM+JYoia+rIXvZTt58eLYh3v7/NkJXtM8NXCho9bGz9cYRkor2gT7dZ30l/F
         sXF1yS7xBcDYU8JPKStAZGb85hkByOdjWfa/q5y+LcjQWSeZ7JnvRQXY8xD4XqiY0Q
         0qX6R9jv/zoWA==
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 4/3/20 4:29 AM, Kirill A. Shutemov wrote:
> The page can be included into collapse as long as it doesn't have extra
> pins (from GUP or otherwise).

Hi Kirill,

s/callapse/collapse/ in the Subject line.

The commit message should mention that you're also removing a
VM_BUG_ON_PAGE().

> 
> Signed-off-by: Kirill A. Shutemov <kirill.shutemov@linux.intel.com>
> ---
>   mm/khugepaged.c | 25 ++++++++++++++-----------
>   1 file changed, 14 insertions(+), 11 deletions(-)
> 
> diff --git a/mm/khugepaged.c b/mm/khugepaged.c
> index 57ff287caf6b..1e7e6543ebca 100644
> --- a/mm/khugepaged.c
> +++ b/mm/khugepaged.c
> @@ -581,11 +581,18 @@ static int __collapse_huge_page_isolate(struct vm_area_struct *vma,
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
> +		 * additinal pin on the page.


I'd recommend this wording instead, for the last two lines:

		 * from the page table tree. Therefore, this page will not
		 * normally receive any additional pins.


> +		 *
> +		 * New pins can come later if the page is shared across fork,
> +		 * but not for the this process. It is fine. The other process
> +		 * cannot write to the page, only trigger CoW.
>   		 */
> -		if (page_count(page) != 1 + PageSwapCache(page)) {
> +		if (total_mapcount(page) + PageSwapCache(page) !=
> +				page_count(page)) {


I think it's time to put that logic ( "does this page have any extra references")
into a small function. It's already duplicated once below. And the documentation is
duplicated as well.

I took a quick peek at this patch because, after adding pin_user_pages*() APIs earlier
to complement get_user_pages*(), I had a moment of doubt here: what if I'd done  it in
a way that required additional logic here? Fortunately, that's not the case: all
pin_user_pages() calls on huge pages take a "primary/real" refcount, in addition
to scribbling into the compound_pincount_ptr() area. whew. :)



>   			unlock_page(page);
>   			result = SCAN_PAGE_COUNT;
>   			goto out;
> @@ -672,7 +679,6 @@ static void __collapse_huge_page_copy(pte_t *pte, struct page *page,
>   		} else {
>   			src_page = pte_page(pteval);
>   			copy_user_highpage(page, src_page, address, vma);
> -			VM_BUG_ON_PAGE(page_mapcount(src_page) != 1, src_page);
>   			release_pte_page(src_page);
>   			/*
>   			 * ptl mostly unnecessary, but preempt has to
> @@ -1206,12 +1212,9 @@ static int khugepaged_scan_pmd(struct mm_struct *mm,
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
> +		if (total_mapcount(page) + PageSwapCache(page) !=
> +				page_count(page)) {>   			result = SCAN_PAGE_COUNT;
>   			goto out_unmap;
>   		}
> 



thanks,
-- 
John Hubbard
NVIDIA
