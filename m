Return-Path: <SRS0=/IhT=AT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7446EC433E0
	for <linux-kernel@archiver.kernel.org>; Wed,  8 Jul 2020 11:16:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 57F2620786
	for <linux-kernel@archiver.kernel.org>; Wed,  8 Jul 2020 11:16:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728891AbgGHLQx (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 8 Jul 2020 07:16:53 -0400
Received: from mx2.suse.de ([195.135.220.15]:40554 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728633AbgGHLQx (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Jul 2020 07:16:53 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 558D5B166;
        Wed,  8 Jul 2020 11:16:51 +0000 (UTC)
Subject: Re: [PATCH 2/3] mm: slab: rename (un)charge_slab_page() to
 (un)account_slab_page()
To:     Roman Gushchin <guro@fb.com>,
        Andrew Morton <akpm@linux-foundation.org>
Cc:     Johannes Weiner <hannes@cmpxchg.org>,
        Michal Hocko <mhocko@kernel.org>,
        Shakeel Butt <shakeelb@google.com>, linux-mm@kvack.org,
        kernel-team@fb.com, linux-kernel@vger.kernel.org
References: <20200707173612.124425-1-guro@fb.com>
 <20200707173612.124425-2-guro@fb.com>
From:   Vlastimil Babka <vbabka@suse.cz>
Message-ID: <70dedb7e-7402-0297-4ed3-5c0da64d46cd@suse.cz>
Date:   Wed, 8 Jul 2020 13:16:44 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.9.0
MIME-Version: 1.0
In-Reply-To: <20200707173612.124425-2-guro@fb.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 7/7/20 7:36 PM, Roman Gushchin wrote:
> charge_slab_page() and uncharge_slab_page() are not related anymore
> to memcg charging and uncharging. In order to make their names
> less confusing, let's rename them to account_slab_page() and
> unaccount_slab_page() respectively.
> 
> Signed-off-by: Roman Gushchin <guro@fb.com>

Acked-by: Vlastimil Babka <vbabka@suse.cz>

> ---
>  mm/slab.c | 4 ++--
>  mm/slab.h | 8 ++++----
>  mm/slub.c | 4 ++--
>  3 files changed, 8 insertions(+), 8 deletions(-)
> 
> diff --git a/mm/slab.c b/mm/slab.c
> index fafd46877504..300adfb67245 100644
> --- a/mm/slab.c
> +++ b/mm/slab.c
> @@ -1379,7 +1379,7 @@ static struct page *kmem_getpages(struct kmem_cache *cachep, gfp_t flags,
>  		return NULL;
>  	}
>  
> -	charge_slab_page(page, cachep->gfporder, cachep);
> +	account_slab_page(page, cachep->gfporder, cachep);
>  	__SetPageSlab(page);
>  	/* Record if ALLOC_NO_WATERMARKS was set when allocating the slab */
>  	if (sk_memalloc_socks() && page_is_pfmemalloc(page))
> @@ -1403,7 +1403,7 @@ static void kmem_freepages(struct kmem_cache *cachep, struct page *page)
>  
>  	if (current->reclaim_state)
>  		current->reclaim_state->reclaimed_slab += 1 << order;
> -	uncharge_slab_page(page, order, cachep);
> +	unaccount_slab_page(page, order, cachep);
>  	__free_pages(page, order);
>  }
>  
> diff --git a/mm/slab.h b/mm/slab.h
> index 704a65713f81..72ff7cd933db 100644
> --- a/mm/slab.h
> +++ b/mm/slab.h
> @@ -440,15 +440,15 @@ static inline struct kmem_cache *virt_to_cache(const void *obj)
>  	return page->slab_cache;
>  }
>  
> -static __always_inline void charge_slab_page(struct page *page, int order,
> -					     struct kmem_cache *s)
> +static __always_inline void account_slab_page(struct page *page, int order,
> +					      struct kmem_cache *s)
>  {
>  	mod_node_page_state(page_pgdat(page), cache_vmstat_idx(s),
>  			    PAGE_SIZE << order);
>  }
>  
> -static __always_inline void uncharge_slab_page(struct page *page, int order,
> -					       struct kmem_cache *s)
> +static __always_inline void unaccount_slab_page(struct page *page, int order,
> +						struct kmem_cache *s)
>  {
>  	if (memcg_kmem_enabled())
>  		memcg_free_page_obj_cgroups(page);
> diff --git a/mm/slub.c b/mm/slub.c
> index d9b33a935e58..5cffd3fd440b 100644
> --- a/mm/slub.c
> +++ b/mm/slub.c
> @@ -1621,7 +1621,7 @@ static inline struct page *alloc_slab_page(struct kmem_cache *s,
>  		page = __alloc_pages_node(node, flags, order);
>  
>  	if (page)
> -		charge_slab_page(page, order, s);
> +		account_slab_page(page, order, s);
>  
>  	return page;
>  }
> @@ -1844,7 +1844,7 @@ static void __free_slab(struct kmem_cache *s, struct page *page)
>  	page->mapping = NULL;
>  	if (current->reclaim_state)
>  		current->reclaim_state->reclaimed_slab += pages;
> -	uncharge_slab_page(page, order, s);
> +	unaccount_slab_page(page, order, s);
>  	__free_pages(page, order);
>  }
>  
> 

