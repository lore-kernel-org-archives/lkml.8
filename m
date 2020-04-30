Return-Path: <SRS0=SogR=6O=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	UNPARSEABLE_RELAY,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A2591C83000
	for <linux-kernel@archiver.kernel.org>; Thu, 30 Apr 2020 00:42:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 834C820757
	for <linux-kernel@archiver.kernel.org>; Thu, 30 Apr 2020 00:42:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726501AbgD3AmD (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 29 Apr 2020 20:42:03 -0400
Received: from out30-132.freemail.mail.aliyun.com ([115.124.30.132]:47598 "EHLO
        out30-132.freemail.mail.aliyun.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726309AbgD3AmC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Apr 2020 20:42:02 -0400
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R211e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=e01f04428;MF=yang.shi@linux.alibaba.com;NM=1;PH=DS;RN=6;SR=0;TI=SMTPD_---0Tx31E2F_1588207304;
Received: from US-143344MP.local(mailfrom:yang.shi@linux.alibaba.com fp:SMTPD_---0Tx31E2F_1588207304)
          by smtp.aliyun-inc.com(127.0.0.1);
          Thu, 30 Apr 2020 08:41:58 +0800
Subject: Re: [linux-next PATCH 2/2] mm: khugepaged: don't have to put being
 freed page back to lru
To:     kirill.shutemov@linux.intel.com, hughd@google.com,
        aarcange@redhat.com, akpm@linux-foundation.org
Cc:     linux-mm@kvack.org, linux-kernel@vger.kernel.org
References: <1588200982-69492-1-git-send-email-yang.shi@linux.alibaba.com>
 <1588200982-69492-2-git-send-email-yang.shi@linux.alibaba.com>
From:   Yang Shi <yang.shi@linux.alibaba.com>
Message-ID: <c0691ef4-31c9-f0dd-ec23-94e86bc12794@linux.alibaba.com>
Date:   Wed, 29 Apr 2020 17:41:40 -0700
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.12; rv:52.0)
 Gecko/20100101 Thunderbird/52.7.0
MIME-Version: 1.0
In-Reply-To: <1588200982-69492-2-git-send-email-yang.shi@linux.alibaba.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 4/29/20 3:56 PM, Yang Shi wrote:
> When khugepaged successfully isolated and copied data from base page to
> collapsed THP, the base page is about to be freed.  So putting the page
> back to lru sounds not that productive since the page might be isolated
> by vmscan but it can't be reclaimed by vmscan since it can't be unmapped
> by try_to_unmap() at all.
>
> Actually khugepaged is the last user of this page so it can be freed
> directly.  So, clearing active and unevictable flags, unlocking and
> dropping refcount from isolate instead of calling putback_lru_page().

Please disregard the patch. I just remembered Kirill added collapse 
shared pages support. If the pages are shared then they have to be put 
back to lru since they may be still mapped by other processes. So we 
need check the mapcount if we would like to skip lru.

And I spotted the other issue. The release_pte_page() calls 
mod_node_page_state() unconditionally, it was fine before. But, due to 
the support for collapsing shared pages we need check if the last 
mapcount is gone or not.

Andrew, would you please remove this patch from -mm tree? I will send 
one or two rectified patches. Sorry for the inconvenience.

>
> Cc: Kirill A. Shutemov <kirill.shutemov@linux.intel.com>
> Cc: Hugh Dickins <hughd@google.com>
> Cc: Andrea Arcangeli <aarcange@redhat.com>
> Signed-off-by: Yang Shi <yang.shi@linux.alibaba.com>
> ---
>   mm/khugepaged.c | 15 +++++++++++++--
>   1 file changed, 13 insertions(+), 2 deletions(-)
>
> diff --git a/mm/khugepaged.c b/mm/khugepaged.c
> index 0c8d30b..c131a90 100644
> --- a/mm/khugepaged.c
> +++ b/mm/khugepaged.c
> @@ -559,6 +559,17 @@ void __khugepaged_exit(struct mm_struct *mm)
>   static void release_pte_page(struct page *page)
>   {
>   	mod_node_page_state(page_pgdat(page),
> +		NR_ISOLATED_ANON + page_is_file_lru(page), -compound_nr(page));
> +	ClearPageActive(page);
> +	ClearPageUnevictable(page);
> +	unlock_page(page);
> +	/* Drop refcount from isolate */
> +	put_page(page);
> +}
> +
> +static void release_pte_page_to_lru(struct page *page)
> +{
> +	mod_node_page_state(page_pgdat(page),
>   			NR_ISOLATED_ANON + page_is_file_lru(page),
>   			-compound_nr(page));
>   	unlock_page(page);
> @@ -576,12 +587,12 @@ static void release_pte_pages(pte_t *pte, pte_t *_pte,
>   		page = pte_page(pteval);
>   		if (!pte_none(pteval) && !is_zero_pfn(pte_pfn(pteval)) &&
>   				!PageCompound(page))
> -			release_pte_page(page);
> +			release_pte_page_to_lru(page);
>   	}
>   
>   	list_for_each_entry_safe(page, tmp, compound_pagelist, lru) {
>   		list_del(&page->lru);
> -		release_pte_page(page);
> +		release_pte_page_to_lru(page);
>   	}
>   }
>   

