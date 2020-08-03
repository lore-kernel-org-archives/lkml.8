Return-Path: <SRS0=5bHT=BN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,NICE_REPLY_A,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DB48FC433DF
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Aug 2020 07:57:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A564B2072A
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Aug 2020 07:57:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="SZQb5Iej"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725996AbgHCH5Z (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 3 Aug 2020 03:57:25 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:24851 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1725855AbgHCH5Y (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Aug 2020 03:57:24 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1596441441;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
        bh=YsEVOqkJW/oTNRsB+ZnzJtwcdtRv9fcwMonQbRbGySg=;
        b=SZQb5Iejxrn0MifxdLJUUyLPt5Oo/f6zQ/KayM2jRUvlzpAnIOPtbiukWyG0+jXXy/crCR
        FNlXmIqFRxT3cEIzDNA6gO3j9jMp+ggVFsOpSj9soWkLWPRZ6GpylHlScdDrRZz2usgPrJ
        68uBoEX80B+n4SstsbCuCP55AH8Pq/I=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-258-yT3vOgw3OxS6L8V5aSyXdA-1; Mon, 03 Aug 2020 03:57:17 -0400
X-MC-Unique: yT3vOgw3OxS6L8V5aSyXdA-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com [10.5.11.15])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 1197E800685;
        Mon,  3 Aug 2020 07:57:16 +0000 (UTC)
Received: from [10.36.112.252] (ovpn-112-252.ams2.redhat.com [10.36.112.252])
        by smtp.corp.redhat.com (Postfix) with ESMTP id A077671904;
        Mon,  3 Aug 2020 07:57:12 +0000 (UTC)
Subject: Re: [PATCH] mm: sort freelist by rank number
To:     pullip.cho@samsung.com, akpm@linux-foundation.org
Cc:     linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        hyesoo.yu@samsung.com, janghyuck.kim@samsung.com
References: <CGME20200803061805epcas2p20faeeff0b31b23d1bc4464972285b561@epcas2p2.samsung.com>
 <1596435031-41837-1-git-send-email-pullip.cho@samsung.com>
From:   David Hildenbrand <david@redhat.com>
Autocrypt: addr=david@redhat.com; prefer-encrypt=mutual; keydata=
 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
 WNyWQQ==
Organization: Red Hat GmbH
Message-ID: <5f41af0f-4593-3441-12f4-5b0f7e6999ac@redhat.com>
Date:   Mon, 3 Aug 2020 09:57:10 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <1596435031-41837-1-git-send-email-pullip.cho@samsung.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 03.08.20 08:10, pullip.cho@samsung.com wrote:
> From: Cho KyongHo <pullip.cho@samsung.com>
> 
> LPDDR5 introduces rank switch delay. If three successive DRAM accesses
> happens and the first and the second ones access one rank and the last
> access happens on the other rank, the latency of the last access will
> be longer than the second one.
> To address this panelty, we can sort the freelist so that a specific
> rank is allocated prior to another rank. We expect the page allocator
> can allocate the pages from the same rank successively with this
> change. It will hopefully improves the proportion of the consecutive
> memory accesses to the same rank.

This certainly needs performance numbers to justify ... and I am sorry,
"hopefully improves" is not a valid justification :)

I can imagine that this works well initially, when there hasn't been a
lot of memory fragmentation going on. But quickly after your system is
under stress, I doubt this will be very useful. Proof me wrong. ;)

... I dislike this manual setting of "dram_rank_granule". Yet another mm
feature that can only be enabled by a magic command line parameter where
users have to guess the right values.

(side note, there have been similar research approaches to improve
energy consumption by switching off ranks when not needed).

> 
> Signed-off-by: Cho KyongHo <pullip.cho@samsung.com>
> ---
>  mm/Kconfig      |  23 +++++++++++
>  mm/compaction.c |   6 +--
>  mm/internal.h   |  11 ++++++
>  mm/page_alloc.c | 119 +++++++++++++++++++++++++++++++++++++++++++++++++-------
>  mm/shuffle.h    |   6 ++-
>  5 files changed, 144 insertions(+), 21 deletions(-)
> 
> diff --git a/mm/Kconfig b/mm/Kconfig
> index 6c97488..789c02b 100644
> --- a/mm/Kconfig
> +++ b/mm/Kconfig
> @@ -868,4 +868,27 @@ config ARCH_HAS_HUGEPD
>  config MAPPING_DIRTY_HELPERS
>          bool
>  
> +config RANK_SORTED_FREELIST
> +	bool "Prefer allocating free pages in a half of DRAM ranks"
> +
> +	help
> +	  Rank switch delay in DRAM access become larger in LPDDR5 than before.
> +	  If two successive memory accesses happen on different ranks in LPDDR5,
> +	  the latency of the second access becomes longer due to the rank switch
> +	  overhead. This is a power-performance tradeoff achieved in LPDDR5.
> +	  By default, sorting freelist by rank number is disabled even though
> +	  RANK_SORTED_FREELIST is set to y. To enable, set "dram_rank_granule"
> +	  boot argument to a larger or an equal value to pageblock_nr_pages. The
> +	  values should be the exact the rank interleaving granule that your
> +	  system is using. The rank interleaving granule is 2^(the lowest CS bit
> +	  number). CS stands for Chip Select and is also called SS which stands
> +	  for Slave Select.
> +	  This is not beneficial to single rank memory system. Also this is not
> +	  necessary to quad rank and octal rank memory systems because they are
> +	  not in LPDDR5 specifications.
> +
> +	  This is marked experimental because this disables freelist shuffling
> +	  (SHUFFLE_PAGE_ALLOCATOR). Also you should set the correct rank
> +	  interleaving granule.
> +
>  endmenu
> diff --git a/mm/compaction.c b/mm/compaction.c
> index 061dacf..bee9567 100644
> --- a/mm/compaction.c
> +++ b/mm/compaction.c
> @@ -1218,8 +1218,7 @@ move_freelist_head(struct list_head *freelist, struct page *freepage)
>  
>  	if (!list_is_last(freelist, &freepage->lru)) {
>  		list_cut_before(&sublist, freelist, &freepage->lru);
> -		if (!list_empty(&sublist))
> -			list_splice_tail(&sublist, freelist);
> +		freelist_splice_tail(&sublist, freelist);
>  	}
>  }
>  
> @@ -1236,8 +1235,7 @@ move_freelist_tail(struct list_head *freelist, struct page *freepage)
>  
>  	if (!list_is_first(freelist, &freepage->lru)) {
>  		list_cut_position(&sublist, freelist, &freepage->lru);
> -		if (!list_empty(&sublist))
> -			list_splice_tail(&sublist, freelist);
> +		freelist_splice_tail(&sublist, freelist);
>  	}
>  }
>  
> diff --git a/mm/internal.h b/mm/internal.h
> index 10c6776..c945b3d 100644
> --- a/mm/internal.h
> +++ b/mm/internal.h
> @@ -266,6 +266,17 @@ int find_suitable_fallback(struct free_area *area, unsigned int order,
>  
>  #endif
>  
> +#ifdef CONFIG_RANK_SORTED_FREELIST
> +void freelist_splice_tail(struct list_head *sublist, struct list_head *freelist);
> +#else
> +#include <linux/list.h>
> +static inline
> +void freelist_splice_tail(struct list_head *sublist, struct list_head *freelist)
> +{
> +	if (!list_empty(sublist))
> +		list_splice_tail(sublist, freelist);
> +}
> +#endif
>  /*
>   * This function returns the order of a free page in the buddy system. In
>   * general, page_zone(page)->lock must be held by the caller to prevent the
> diff --git a/mm/page_alloc.c b/mm/page_alloc.c
> index 2824e116..7823a3b 100644
> --- a/mm/page_alloc.c
> +++ b/mm/page_alloc.c
> @@ -854,6 +854,69 @@ compaction_capture(struct capture_control *capc, struct page *page,
>  }
>  #endif /* CONFIG_COMPACTION */
>  
> +#ifdef CONFIG_RANK_SORTED_FREELIST
> +static unsigned long dram_rank_nr_pages __read_mostly;
> +
> +static inline bool preferred_rank_enabled(void)
> +{
> +	return dram_rank_nr_pages >= pageblock_nr_pages;
> +}
> +
> +static int __init dram_rank_granule(char *buf)
> +{
> +	unsigned long val = (unsigned long)(memparse(buf, NULL) / PAGE_SIZE);
> +
> +	if (val < pageblock_nr_pages) {
> +		pr_err("too small rank granule %lu\n", val);
> +		return -EINVAL;
> +	}
> +
> +	dram_rank_nr_pages = val;
> +
> +	return 0;
> +}
> +
> +early_param("dram_rank_granule", dram_rank_granule);
> +
> +static inline bool __preferred_rank(struct page *page)
> +{
> +	return !(page_to_pfn(page) & dram_rank_nr_pages);
> +}
> +
> +static inline bool preferred_rank(struct page *page)
> +{
> +	return !preferred_rank_enabled() || __preferred_rank(page);
> +}
> +
> +void freelist_splice_tail(struct list_head *sublist, struct list_head *freelist)
> +{
> +	while (!list_empty(sublist)) {
> +		struct page *page;
> +
> +		page = list_first_entry(sublist, struct page, lru);
> +		if (!preferred_rank_enabled() || !__preferred_rank(page))
> +			list_move_tail(&page->lru, freelist);
> +		else
> +			list_move(&page->lru, freelist);
> +	}
> +}
> +#else
> +static inline bool __preferred_rank(struct page *page)
> +{
> +	return true;
> +}
> +
> +static inline bool preferred_rank(struct page *page)
> +{
> +	return true;
> +}
> +
> +static inline bool preferred_rank_enabled(void)
> +{
> +	return false;
> +}
> +#endif
> +
>  /* Used for pages not on another list */
>  static inline void add_to_free_list(struct page *page, struct zone *zone,
>  				    unsigned int order, int migratetype)
> @@ -880,7 +943,10 @@ static inline void move_to_free_list(struct page *page, struct zone *zone,
>  {
>  	struct free_area *area = &zone->free_area[order];
>  
> -	list_move(&page->lru, &area->free_list[migratetype]);
> +	if (preferred_rank(page))
> +		list_move(&page->lru, &area->free_list[migratetype]);
> +	else
> +		list_move_tail(&page->lru, &area->free_list[migratetype]);
>  }
>  
>  static inline void del_page_from_free_list(struct page *page, struct zone *zone,
> @@ -1029,7 +1095,9 @@ static inline void __free_one_page(struct page *page,
>  done_merging:
>  	set_page_order(page, order);
>  
> -	if (is_shuffle_order(order))
> +	if (preferred_rank_enabled())
> +		to_tail = !__preferred_rank(page);
> +	else if (is_shuffle_order(order))
>  		to_tail = shuffle_pick_tail();
>  	else
>  		to_tail = buddy_merge_likely(pfn, buddy_pfn, page, order);
> @@ -2257,20 +2325,29 @@ static __always_inline
>  struct page *__rmqueue_smallest(struct zone *zone, unsigned int order,
>  						int migratetype)
>  {
> +	int retry = preferred_rank_enabled() ? 2 : 1;
>  	unsigned int current_order;
>  	struct free_area *area;
>  	struct page *page;
>  
> -	/* Find a page of the appropriate size in the preferred list */
> -	for (current_order = order; current_order < MAX_ORDER; ++current_order) {
> -		area = &(zone->free_area[current_order]);
> -		page = get_page_from_free_area(area, migratetype);
> -		if (!page)
> -			continue;
> -		del_page_from_free_list(page, zone, current_order);
> -		expand(zone, page, order, current_order, migratetype);
> -		set_pcppage_migratetype(page, migratetype);
> -		return page;
> +	while (retry-- > 0) {
> +		/* Find a page of the appropriate size in the preferred list */
> +		for (current_order = order; current_order < MAX_ORDER; ++current_order) {
> +			area = &zone->free_area[current_order];
> +			page = get_page_from_free_area(area, migratetype);
> +			if (!page)
> +				continue;
> +			/*
> +			 * In the first try, search for a page in the preferred
> +			 * rank upward even though a free page is found.
> +			 */
> +			if (retry > 0 && !preferred_rank(page))
> +				continue;
> +			del_page_from_free_list(page, zone, current_order);
> +			expand(zone, page, order, current_order, migratetype);
> +			set_pcppage_migratetype(page, migratetype);
> +			return page;
> +		}
>  	}
>  
>  	return NULL;
> @@ -2851,8 +2928,14 @@ static int rmqueue_bulk(struct zone *zone, unsigned int order,
>  		 * head, thus also in the physical page order. This is useful
>  		 * for IO devices that can merge IO requests if the physical
>  		 * pages are ordered properly.
> +		 * However, preferred_rank_enabled() is true, we always sort
> +		 * freelists in the buddy and the pcp in the order of rank
> +		 * number for the performance reason.
>  		 */
> -		list_add_tail(&page->lru, list);
> +		if (preferred_rank_enabled() && __preferred_rank(page))
> +			list_add(&page->lru, list);
> +		else
> +			list_add_tail(&page->lru, list);
>  		alloced++;
>  		if (is_migrate_cma(get_pcppage_migratetype(page)))
>  			__mod_zone_page_state(zone, NR_FREE_CMA_PAGES,
> @@ -3136,7 +3219,10 @@ static void free_unref_page_commit(struct page *page, unsigned long pfn)
>  	}
>  
>  	pcp = &this_cpu_ptr(zone->pageset)->pcp;
> -	list_add(&page->lru, &pcp->lists[migratetype]);
> +	if (preferred_rank(page))
> +		list_add(&page->lru, &pcp->lists[migratetype]);
> +	else
> +		list_add_tail(&page->lru, &pcp->lists[migratetype]);
>  	pcp->count++;
>  	if (pcp->count >= pcp->high) {
>  		unsigned long batch = READ_ONCE(pcp->batch);
> @@ -8813,7 +8899,10 @@ static void break_down_buddy_pages(struct zone *zone, struct page *page,
>  			continue;
>  
>  		if (current_buddy != target) {
> -			add_to_free_list(current_buddy, zone, high, migratetype);
> +			if (preferred_rank(current_buddy))
> +				add_to_free_list(current_buddy, zone, high, migratetype);
> +			else
> +				add_to_free_list_tail(current_buddy, zone, high, migratetype);
>  			set_page_order(current_buddy, high);
>  			page = next_page;
>  		}
> diff --git a/mm/shuffle.h b/mm/shuffle.h
> index 71b784f..59cbfde 100644
> --- a/mm/shuffle.h
> +++ b/mm/shuffle.h
> @@ -12,7 +12,8 @@ extern void __shuffle_free_memory(pg_data_t *pgdat);
>  extern bool shuffle_pick_tail(void);
>  static inline void shuffle_free_memory(pg_data_t *pgdat)
>  {
> -	if (!static_branch_unlikely(&page_alloc_shuffle_key))
> +	if (!static_branch_unlikely(&page_alloc_shuffle_key) ||
> +	    preferred_rank_enabled())
>  		return;
>  	__shuffle_free_memory(pgdat);
>  }
> @@ -20,7 +21,8 @@ static inline void shuffle_free_memory(pg_data_t *pgdat)
>  extern void __shuffle_zone(struct zone *z);
>  static inline void shuffle_zone(struct zone *z)
>  {
> -	if (!static_branch_unlikely(&page_alloc_shuffle_key))
> +	if (!static_branch_unlikely(&page_alloc_shuffle_key) ||
> +	    preferred_rank_enabled())
>  		return;
>  	__shuffle_zone(z);
>  }
> 


-- 
Thanks,

David / dhildenb

