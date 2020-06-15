Return-Path: <SRS0=PJcK=74=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 53CA0C433E0
	for <linux-kernel@archiver.kernel.org>; Mon, 15 Jun 2020 16:46:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2EB032078A
	for <linux-kernel@archiver.kernel.org>; Mon, 15 Jun 2020 16:46:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731080AbgFOQqe (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 15 Jun 2020 12:46:34 -0400
Received: from mx2.suse.de ([195.135.220.15]:35756 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728585AbgFOQqe (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 Jun 2020 12:46:34 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx2.suse.de (Postfix) with ESMTP id BDEF7AC22;
        Mon, 15 Jun 2020 16:46:35 +0000 (UTC)
Subject: Re: [PATCH 1/3] mm/slub: Fix slabs_node return value when
 CONFIG_SLUB_DEBUG disabled
To:     Muchun Song <songmuchun@bytedance.com>, cl@linux.com,
        penberg@kernel.org, rientjes@google.com, iamjoonsoo.kim@lge.com,
        akpm@linux-foundation.org
Cc:     linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        Roman Gushchin <guro@fb.com>
References: <20200614123923.99189-1-songmuchun@bytedance.com>
 <20200614123923.99189-2-songmuchun@bytedance.com>
From:   Vlastimil Babka <vbabka@suse.cz>
Message-ID: <fb5dc63d-4d54-c393-eac6-414993cda595@suse.cz>
Date:   Mon, 15 Jun 2020 18:46:27 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.9.0
MIME-Version: 1.0
In-Reply-To: <20200614123923.99189-2-songmuchun@bytedance.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 6/14/20 2:39 PM, Muchun Song wrote:
> The slabs_node() always return zero when CONFIG_SLUB_DEBUG is disabled.
> But some codes determine whether slab is empty by checking the return
> value of slabs_node(). As you know, the result is not correct. This
> problem can be reproduce by the follow code(and boot system with the
> cmdline of "slub_nomerge"):
> 
>   void *objs[32];
>   struct kmem_cache *cache = kmem_cache_create("kmem-test", 128, 0,
> 			0, 0);
> 
>   if (cache) {
>   	int i;
> 
> 	/* Make a full slab */
>   	for (i = 0; i < ARRAY_SIZE(objs); i++)
> 		objs[i] = kmem_cache_alloc(cache, GFP_KERNEL_ACCOUNT);
> 
> 	/*
>   	 * This really should fail because the slab cache still has
>   	 * objects. But we did destroy the @cache because of zero
>   	 * returned by slabs_node().
>   	 */
>   	kmem_cache_destroy(cache);
>   }

Hmm, the whole SLUB subsystem (or even kernel) has some trust in the other
individual subsystems doing the right thing. I.e. if allocate an object once and
free it twice, bad things will happen. If you are debugging such a problem, you
enable SLUB_DEBUG (and the boot parameter).

This particular situation is the same - SLUB trusts its users to free their
objects before calling kmem_cache_destroy(). If they don't and just leak them,
then they stay leaked and nothing worse will happen (I'd expect). If they
destroy the cache and later try to e.g. free the objects, then there will most
likely be a crash.

And yeah, if you are debugging such thing, you will compile with SLUB_DEBUG and
make sure there's slub_nomerge (or you won't catch it anyway).

Hmm, but there's one exception in __kmem_cache_shrink() where the caller wants
to know if all slabs were discarded. kmem_cache_shrink() passes that to its
callers, but seems nobody cares about the return value.

The only caller that seems to care is __kmemcg_cache_deactivate_after_rcu():

        if (!__kmem_cache_shrink(s))
                sysfs_slab_remove(s);

Perhaps that will go away with memcg rework? (CC Roman). If yes, we also have
the option to stop returning the value in kmem_cache_shrink() (as nobody seems
to care), and then slabs_node() remains a debug only thing.

> To fix it, we can move the nr_slabs of kmem_cache_node out of the
> CONFIG_SLUB_DEBUG. So we can get the corrent value returned by the
> slabs_node().
> 
> With this patch applied, we will get a warning message and stack
> trace in the dmesg.
> 
> Signed-off-by: Muchun Song <songmuchun@bytedance.com>
> ---
>  mm/slab.h |  2 +-
>  mm/slub.c | 80 +++++++++++++++++++++++++++++++++------------------------------
>  2 files changed, 43 insertions(+), 39 deletions(-)
> 
> diff --git a/mm/slab.h b/mm/slab.h
> index 0b91f2a7b033..062d4542b7e2 100644
> --- a/mm/slab.h
> +++ b/mm/slab.h
> @@ -619,8 +619,8 @@ struct kmem_cache_node {
>  #ifdef CONFIG_SLUB
>  	unsigned long nr_partial;
>  	struct list_head partial;
> -#ifdef CONFIG_SLUB_DEBUG
>  	atomic_long_t nr_slabs;
> +#ifdef CONFIG_SLUB_DEBUG
>  	atomic_long_t total_objects;
>  	struct list_head full;
>  #endif
> diff --git a/mm/slub.c b/mm/slub.c
> index 49b5cb7da318..1a3e6a5b7287 100644
> --- a/mm/slub.c
> +++ b/mm/slub.c
> @@ -1070,39 +1070,14 @@ static void remove_full(struct kmem_cache *s, struct kmem_cache_node *n, struct
>  	list_del(&page->slab_list);
>  }
>  
> -/* Tracking of the number of slabs for debugging purposes */
> -static inline unsigned long slabs_node(struct kmem_cache *s, int node)
> +/* Tracking of the number of objects for debugging purposes */
> +static inline void inc_objects_node(struct kmem_cache_node *n, int objects)
>  {
> -	struct kmem_cache_node *n = get_node(s, node);
> -
> -	return atomic_long_read(&n->nr_slabs);
> +	atomic_long_add(objects, &n->total_objects);
>  }
>  
> -static inline unsigned long node_nr_slabs(struct kmem_cache_node *n)
> +static inline void dec_objects_node(struct kmem_cache_node *n, int objects)
>  {
> -	return atomic_long_read(&n->nr_slabs);
> -}
> -
> -static inline void inc_slabs_node(struct kmem_cache *s, int node, int objects)
> -{
> -	struct kmem_cache_node *n = get_node(s, node);
> -
> -	/*
> -	 * May be called early in order to allocate a slab for the
> -	 * kmem_cache_node structure. Solve the chicken-egg
> -	 * dilemma by deferring the increment of the count during
> -	 * bootstrap (see early_kmem_cache_node_alloc).
> -	 */
> -	if (likely(n)) {
> -		atomic_long_inc(&n->nr_slabs);
> -		atomic_long_add(objects, &n->total_objects);
> -	}
> -}
> -static inline void dec_slabs_node(struct kmem_cache *s, int node, int objects)
> -{
> -	struct kmem_cache_node *n = get_node(s, node);
> -
> -	atomic_long_dec(&n->nr_slabs);
>  	atomic_long_sub(objects, &n->total_objects);
>  }
>  
> @@ -1413,15 +1388,8 @@ slab_flags_t kmem_cache_flags(unsigned int object_size,
>  
>  #define disable_higher_order_debug 0
>  
> -static inline unsigned long slabs_node(struct kmem_cache *s, int node)
> -							{ return 0; }
> -static inline unsigned long node_nr_slabs(struct kmem_cache_node *n)
> -							{ return 0; }
> -static inline void inc_slabs_node(struct kmem_cache *s, int node,
> -							int objects) {}
> -static inline void dec_slabs_node(struct kmem_cache *s, int node,
> -							int objects) {}
> -
> +static inline void inc_objects_node(struct kmem_cache_node *n, int objects) {}
> +static inline void dec_objects_node(struct kmem_cache_node *n, int objects) {}
>  static bool freelist_corrupted(struct kmem_cache *s, struct page *page,
>  			       void *freelist, void *nextfree)
>  {
> @@ -1429,6 +1397,42 @@ static bool freelist_corrupted(struct kmem_cache *s, struct page *page,
>  }
>  #endif /* CONFIG_SLUB_DEBUG */
>  
> +static inline unsigned long slabs_node(struct kmem_cache *s, int node)
> +{
> +	struct kmem_cache_node *n = get_node(s, node);
> +
> +	return atomic_long_read(&n->nr_slabs);
> +}
> +
> +static inline unsigned long node_nr_slabs(struct kmem_cache_node *n)
> +{
> +	return atomic_long_read(&n->nr_slabs);
> +}
> +
> +static inline void inc_slabs_node(struct kmem_cache *s, int node, int objects)
> +{
> +	struct kmem_cache_node *n = get_node(s, node);
> +
> +	/*
> +	 * May be called early in order to allocate a slab for the
> +	 * kmem_cache_node structure. Solve the chicken-egg
> +	 * dilemma by deferring the increment of the count during
> +	 * bootstrap (see early_kmem_cache_node_alloc).
> +	 */
> +	if (likely(n)) {
> +		atomic_long_inc(&n->nr_slabs);
> +		inc_objects_node(n, objects);
> +	}
> +}
> +
> +static inline void dec_slabs_node(struct kmem_cache *s, int node, int objects)
> +{
> +	struct kmem_cache_node *n = get_node(s, node);
> +
> +	atomic_long_dec(&n->nr_slabs);
> +	dec_objects_node(n, objects);
> +}
> +
>  /*
>   * Hooks for other subsystems that check memory allocations. In a typical
>   * production configuration these hooks all should produce no code at all.
> 

