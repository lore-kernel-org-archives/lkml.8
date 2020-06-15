Return-Path: <SRS0=PJcK=74=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 93365C433E0
	for <linux-kernel@archiver.kernel.org>; Mon, 15 Jun 2020 13:08:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 775782076A
	for <linux-kernel@archiver.kernel.org>; Mon, 15 Jun 2020 13:08:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730215AbgFONIj (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 15 Jun 2020 09:08:39 -0400
Received: from mx2.suse.de ([195.135.220.15]:47024 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729875AbgFONIh (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 Jun 2020 09:08:37 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx2.suse.de (Postfix) with ESMTP id 70E58ACB8;
        Mon, 15 Jun 2020 13:08:39 +0000 (UTC)
Subject: Re: [PATCH] mm/slab: Add a __GFP_ACCOUNT GFP flag check for slab
 allocation
To:     Muchun Song <songmuchun@bytedance.com>, cl@linux.com,
        penberg@kernel.org, rientjes@google.com, iamjoonsoo.kim@lge.com,
        akpm@linux-foundation.org
Cc:     linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        Roman Gushchin <guro@fb.com>
References: <20200614063858.85118-1-songmuchun@bytedance.com>
From:   Vlastimil Babka <vbabka@suse.cz>
Message-ID: <bca5f44c-5e30-17b1-09fc-6330d450433b@suse.cz>
Date:   Mon, 15 Jun 2020 15:08:32 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.9.0
MIME-Version: 1.0
In-Reply-To: <20200614063858.85118-1-songmuchun@bytedance.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 6/14/20 8:38 AM, Muchun Song wrote:
> When a kmem_cache is initialized with SLAB_ACCOUNT slab flag, we must
> not call kmem_cache_alloc with __GFP_ACCOUNT GFP flag. In this case,
> we can be accounted to kmemcg twice. This is not correct. So we add a

Are you sure? How does that happen?

The only place I see these evaluated is this condition in slab_pre_alloc_hook():

        if (memcg_kmem_enabled() &&
            ((flags & __GFP_ACCOUNT) || (s->flags & SLAB_ACCOUNT)))
                return memcg_kmem_get_cache(s);

And it doesn't matter if one or both are set? Am I missing something?

> __GFP_ACCOUNT GFP flag check for slab allocation.
> 
> We also introduce a new helper named fixup_gfp_flags to do that check.
> We can reuse the fixup_gfp_flags for SLAB/SLUB.
> 
> Signed-off-by: Muchun Song <songmuchun@bytedance.com>
> ---
>  mm/slab.c | 10 +---------
>  mm/slab.h | 21 +++++++++++++++++++++
>  mm/slub.c | 10 +---------
>  3 files changed, 23 insertions(+), 18 deletions(-)
> 
> diff --git a/mm/slab.c b/mm/slab.c
> index 9350062ffc1a..6e0110bef2d6 100644
> --- a/mm/slab.c
> +++ b/mm/slab.c
> @@ -126,8 +126,6 @@
>  
>  #include <trace/events/kmem.h>
>  
> -#include	"internal.h"
> -
>  #include	"slab.h"
>  
>  /*
> @@ -2579,13 +2577,7 @@ static struct page *cache_grow_begin(struct kmem_cache *cachep,
>  	 * Be lazy and only check for valid flags here,  keeping it out of the
>  	 * critical path in kmem_cache_alloc().
>  	 */
> -	if (unlikely(flags & GFP_SLAB_BUG_MASK)) {
> -		gfp_t invalid_mask = flags & GFP_SLAB_BUG_MASK;
> -		flags &= ~GFP_SLAB_BUG_MASK;
> -		pr_warn("Unexpected gfp: %#x (%pGg). Fixing up to gfp: %#x (%pGg). Fix your code!\n",
> -				invalid_mask, &invalid_mask, flags, &flags);
> -		dump_stack();
> -	}
> +	flags = fixup_gfp_flags(cachep, flags);
>  	WARN_ON_ONCE(cachep->ctor && (flags & __GFP_ZERO));
>  	local_flags = flags & (GFP_CONSTRAINT_MASK|GFP_RECLAIM_MASK);
>  
> diff --git a/mm/slab.h b/mm/slab.h
> index 815e4e9a94cd..0b91f2a7b033 100644
> --- a/mm/slab.h
> +++ b/mm/slab.h
> @@ -109,6 +109,7 @@ struct memcg_cache_params {
>  #include <linux/kmemleak.h>
>  #include <linux/random.h>
>  #include <linux/sched/mm.h>
> +#include "internal.h"
>  
>  /*
>   * State of the slab allocator.
> @@ -627,6 +628,26 @@ struct kmem_cache_node {
>  
>  };
>  
> +static inline gfp_t fixup_gfp_flags(struct kmem_cache *s, gfp_t flags)
> +{
> +	gfp_t invalid_mask = 0;
> +
> +	if (unlikely(flags & GFP_SLAB_BUG_MASK))
> +		invalid_mask |= flags & GFP_SLAB_BUG_MASK;
> +
> +	if (unlikely(flags & __GFP_ACCOUNT && s->flags & SLAB_ACCOUNT))
> +		invalid_mask |= __GFP_ACCOUNT;
> +
> +	if (unlikely(invalid_mask)) {
> +		flags &= ~invalid_mask;
> +		pr_warn("Unexpected gfp: %#x (%pGg). Fixing up to gfp: %#x (%pGg). Fix your code!\n",
> +				invalid_mask, &invalid_mask, flags, &flags);
> +		dump_stack();
> +	}
> +
> +	return flags;
> +}
> +
>  static inline struct kmem_cache_node *get_node(struct kmem_cache *s, int node)
>  {
>  	return s->node[node];
> diff --git a/mm/slub.c b/mm/slub.c
> index b8f798b50d44..49b5cb7da318 100644
> --- a/mm/slub.c
> +++ b/mm/slub.c
> @@ -37,8 +37,6 @@
>  
>  #include <trace/events/kmem.h>
>  
> -#include "internal.h"
> -
>  /*
>   * Lock order:
>   *   1. slab_mutex (Global Mutex)
> @@ -1745,13 +1743,7 @@ static struct page *allocate_slab(struct kmem_cache *s, gfp_t flags, int node)
>  
>  static struct page *new_slab(struct kmem_cache *s, gfp_t flags, int node)
>  {
> -	if (unlikely(flags & GFP_SLAB_BUG_MASK)) {
> -		gfp_t invalid_mask = flags & GFP_SLAB_BUG_MASK;
> -		flags &= ~GFP_SLAB_BUG_MASK;
> -		pr_warn("Unexpected gfp: %#x (%pGg). Fixing up to gfp: %#x (%pGg). Fix your code!\n",
> -				invalid_mask, &invalid_mask, flags, &flags);
> -		dump_stack();
> -	}
> +	flags = fixup_gfp_flags(s, flags);
>  
>  	return allocate_slab(s,
>  		flags & (GFP_RECLAIM_MASK | GFP_CONSTRAINT_MASK), node);
> 

