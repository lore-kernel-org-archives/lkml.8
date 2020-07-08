Return-Path: <SRS0=/IhT=AT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 65272C433DF
	for <linux-kernel@archiver.kernel.org>; Wed,  8 Jul 2020 11:16:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4AF8220786
	for <linux-kernel@archiver.kernel.org>; Wed,  8 Jul 2020 11:16:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728853AbgGHLQT (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 8 Jul 2020 07:16:19 -0400
Received: from mx2.suse.de ([195.135.220.15]:38504 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725972AbgGHLQS (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Jul 2020 07:16:18 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 4DCA6B178;
        Wed,  8 Jul 2020 11:16:17 +0000 (UTC)
Subject: Re: [PATCH 1/3] mm: memcg/slab: remove unused argument by
 charge_slab_page()
To:     Roman Gushchin <guro@fb.com>,
        Andrew Morton <akpm@linux-foundation.org>
Cc:     Johannes Weiner <hannes@cmpxchg.org>,
        Michal Hocko <mhocko@kernel.org>,
        Shakeel Butt <shakeelb@google.com>, linux-mm@kvack.org,
        kernel-team@fb.com, linux-kernel@vger.kernel.org
References: <20200707173612.124425-1-guro@fb.com>
From:   Vlastimil Babka <vbabka@suse.cz>
Message-ID: <1d31552e-428a-566a-6160-c8dd6f24f0c2@suse.cz>
Date:   Wed, 8 Jul 2020 13:16:16 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.9.0
MIME-Version: 1.0
In-Reply-To: <20200707173612.124425-1-guro@fb.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 7/7/20 7:36 PM, Roman Gushchin wrote:
> charge_slab_page() is not using the gfp argument anymore,
> remove it.
> 
> Signed-off-by: Roman Gushchin <guro@fb.com>

Acked-by: Vlastimil Babka <vbabka@suse.cz>

> ---
>  mm/slab.c | 2 +-
>  mm/slab.h | 3 +--
>  mm/slub.c | 2 +-
>  3 files changed, 3 insertions(+), 4 deletions(-)
> 
> diff --git a/mm/slab.c b/mm/slab.c
> index 2850fe3c5fb8..fafd46877504 100644
> --- a/mm/slab.c
> +++ b/mm/slab.c
> @@ -1379,7 +1379,7 @@ static struct page *kmem_getpages(struct kmem_cache *cachep, gfp_t flags,
>  		return NULL;
>  	}
>  
> -	charge_slab_page(page, flags, cachep->gfporder, cachep);
> +	charge_slab_page(page, cachep->gfporder, cachep);
>  	__SetPageSlab(page);
>  	/* Record if ALLOC_NO_WATERMARKS was set when allocating the slab */
>  	if (sk_memalloc_socks() && page_is_pfmemalloc(page))
> diff --git a/mm/slab.h b/mm/slab.h
> index ab172dca8ce2..704a65713f81 100644
> --- a/mm/slab.h
> +++ b/mm/slab.h
> @@ -440,8 +440,7 @@ static inline struct kmem_cache *virt_to_cache(const void *obj)
>  	return page->slab_cache;
>  }
>  
> -static __always_inline void charge_slab_page(struct page *page,
> -					     gfp_t gfp, int order,
> +static __always_inline void charge_slab_page(struct page *page, int order,
>  					     struct kmem_cache *s)
>  {
>  	mod_node_page_state(page_pgdat(page), cache_vmstat_idx(s),
> diff --git a/mm/slub.c b/mm/slub.c
> index 6769f5f802e9..d9b33a935e58 100644
> --- a/mm/slub.c
> +++ b/mm/slub.c
> @@ -1621,7 +1621,7 @@ static inline struct page *alloc_slab_page(struct kmem_cache *s,
>  		page = __alloc_pages_node(node, flags, order);
>  
>  	if (page)
> -		charge_slab_page(page, flags, order, s);
> +		charge_slab_page(page, order, s);
>  
>  	return page;
>  }
> 

