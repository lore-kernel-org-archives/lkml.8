Return-Path: <SRS0=SbvM=AM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 51AE5C433DF
	for <linux-kernel@archiver.kernel.org>; Wed,  1 Jul 2020 18:03:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 324DF20748
	for <linux-kernel@archiver.kernel.org>; Wed,  1 Jul 2020 18:03:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731171AbgGASC6 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 1 Jul 2020 14:02:58 -0400
Received: from mx2.suse.de ([195.135.220.15]:47118 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726449AbgGASC6 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Jul 2020 14:02:58 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 7D55EAB98;
        Wed,  1 Jul 2020 18:02:56 +0000 (UTC)
Subject: Re: [PATCH v6 2/6] mm/vmscan: protect the workingset on anonymous LRU
To:     js1304@gmail.com, Andrew Morton <akpm@linux-foundation.org>
Cc:     linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        Johannes Weiner <hannes@cmpxchg.org>,
        Michal Hocko <mhocko@kernel.org>,
        Hugh Dickins <hughd@google.com>,
        Minchan Kim <minchan@kernel.org>,
        Mel Gorman <mgorman@techsingularity.net>, kernel-team@lge.com,
        Joonsoo Kim <iamjoonsoo.kim@lge.com>
References: <1592371583-30672-1-git-send-email-iamjoonsoo.kim@lge.com>
 <1592371583-30672-3-git-send-email-iamjoonsoo.kim@lge.com>
From:   Vlastimil Babka <vbabka@suse.cz>
Message-ID: <4591b38d-fdd0-e2e6-bf11-6e5669575736@suse.cz>
Date:   Wed, 1 Jul 2020 20:02:51 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.9.0
MIME-Version: 1.0
In-Reply-To: <1592371583-30672-3-git-send-email-iamjoonsoo.kim@lge.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 6/17/20 7:26 AM, js1304@gmail.com wrote:
> From: Joonsoo Kim <iamjoonsoo.kim@lge.com>

Hi, how about a more descriptive subject, such as

mm/vmscan: add new anonymous pages to inactive LRU list

> In current implementation, newly created or swap-in anonymous page
> is started on active list. Growing active list results in rebalancing
> active/inactive list so old pages on active list are demoted to inactive
> list. Hence, the page on active list isn't protected at all.
> 
> Following is an example of this situation.
> 
> Assume that 50 hot pages on active list. Numbers denote the number of
> pages on active/inactive list (active | inactive).
> 
> 1. 50 hot pages on active list
> 50(h) | 0
> 
> 2. workload: 50 newly created (used-once) pages
> 50(uo) | 50(h)
> 
> 3. workload: another 50 newly created (used-once) pages
> 50(uo) | 50(uo), swap-out 50(h)
> 
> This patch tries to fix this issue.
> Like as file LRU, newly created or swap-in anonymous pages will be
> inserted to the inactive list. They are promoted to active list if
> enough reference happens. This simple modification changes the above
> example as following.
> 
> 1. 50 hot pages on active list
> 50(h) | 0
> 
> 2. workload: 50 newly created (used-once) pages
> 50(h) | 50(uo)
> 
> 3. workload: another 50 newly created (used-once) pages
> 50(h) | 50(uo), swap-out 50(uo)
> 
> As you can see, hot pages on active list would be protected.
> 
> Note that, this implementation has a drawback that the page cannot
> be promoted and will be swapped-out if re-access interval is greater than
> the size of inactive list but less than the size of total(active+inactive).
> To solve this potential issue, following patch will apply workingset
> detection that is applied to file LRU some day before.

detection similar to the one that's already applied to file LRU.

> v6: Before this patch, all anon pages (inactive + active) are considered
> as workingset. However, with this patch, only active pages are considered
> as workingset. So, file refault formula which uses the number of all
> anon pages is changed to use only the number of active anon pages.

a "v6" note is more suitable for a diffstat area than commit log, but it's good
to mention this so drop the 'v6:'?

> Acked-by: Johannes Weiner <hannes@cmpxchg.org>
> Signed-off-by: Joonsoo Kim <iamjoonsoo.kim@lge.com>

Acked-by: Vlastimil Babka <vbabka@suse.cz>

One more nit below.

> --- a/mm/swap.c
> +++ b/mm/swap.c
> @@ -476,23 +476,24 @@ void lru_cache_add(struct page *page)
>  EXPORT_SYMBOL(lru_cache_add);
>  
>  /**
> - * lru_cache_add_active_or_unevictable
> + * lru_cache_add_inactive_or_unevictable
>   * @page:  the page to be added to LRU
>   * @vma:   vma in which page is mapped for determining reclaimability
>   *
> - * Place @page on the active or unevictable LRU list, depending on its
> + * Place @page on the inactive or unevictable LRU list, depending on its
>   * evictability.  Note that if the page is not evictable, it goes
>   * directly back onto it's zone's unevictable list, it does NOT use a
>   * per cpu pagevec.
>   */
> -void lru_cache_add_active_or_unevictable(struct page *page,
> +void lru_cache_add_inactive_or_unevictable(struct page *page,
>  					 struct vm_area_struct *vma)
>  {
> +	bool unevictable;
> +
>  	VM_BUG_ON_PAGE(PageLRU(page), page);
>  
> -	if (likely((vma->vm_flags & (VM_LOCKED | VM_SPECIAL)) != VM_LOCKED))
> -		SetPageActive(page);
> -	else if (!TestSetPageMlocked(page)) {
> +	unevictable = (vma->vm_flags & (VM_LOCKED | VM_SPECIAL)) == VM_LOCKED;
> +	if (unevictable && !TestSetPageMlocked(page)) {

I guess this could be "if (unlikely(unevictable) && ..." to match the previous
if (likely(evictable)) else ...

>  		/*
>  		 * We use the irq-unsafe __mod_zone_page_stat because this
>  		 * counter is not modified from interrupt context, and the pte
> diff --git a/mm/swapfile.c b/mm/swapfile.c
> index c047789..38f6433 100644
