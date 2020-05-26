Return-Path: <SRS0=fR4S=7I=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4DC59C433E1
	for <linux-kernel@archiver.kernel.org>; Tue, 26 May 2020 10:31:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 338022084C
	for <linux-kernel@archiver.kernel.org>; Tue, 26 May 2020 10:31:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388663AbgEZKbc (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 26 May 2020 06:31:32 -0400
Received: from mx2.suse.de ([195.135.220.15]:60958 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2388355AbgEZKbc (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 May 2020 06:31:32 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx2.suse.de (Postfix) with ESMTP id C4A96ACD5;
        Tue, 26 May 2020 10:31:32 +0000 (UTC)
Subject: Re: [PATCH v3 13/19] mm: memcg/slab: simplify memcg cache creation
To:     Roman Gushchin <guro@fb.com>,
        Andrew Morton <akpm@linux-foundation.org>
Cc:     Johannes Weiner <hannes@cmpxchg.org>,
        Michal Hocko <mhocko@kernel.org>, linux-mm@kvack.org,
        kernel-team@fb.com, linux-kernel@vger.kernel.org
References: <20200422204708.2176080-1-guro@fb.com>
 <20200422204708.2176080-14-guro@fb.com>
From:   Vlastimil Babka <vbabka@suse.cz>
Message-ID: <9a233b26-301a-d99f-e5f3-12452c44dce7@suse.cz>
Date:   Tue, 26 May 2020 12:31:29 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.8.0
MIME-Version: 1.0
In-Reply-To: <20200422204708.2176080-14-guro@fb.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 4/22/20 10:47 PM, Roman Gushchin wrote:
> Because the number of non-root kmem_caches doesn't depend on the
> number of memory cgroups anymore and is generally not very big,
> there is no more need for a dedicated workqueue.
> 
> Also, as there is no more need to pass any arguments to the
> memcg_create_kmem_cache() except the root kmem_cache, it's
> possible to just embed the work structure into the kmem_cache
> and avoid the dynamic allocation of the work structure.
> 
> This will also simplify the synchronization: for each root kmem_cache
> there is only one work. So there will be no more concurrent attempts
> to create a non-root kmem_cache for a root kmem_cache: the second and
> all following attempts to queue the work will fail.
> 
> On the kmem_cache destruction path there is no more need to call the
> expensive flush_workqueue() and wait for all pending works to be
> finished. Instead, cancel_work_sync() can be used to cancel/wait for
> only one work.
> 
> Signed-off-by: Roman Gushchin <guro@fb.com>

Reviewed-by: Vlastimil Babka <vbabka@suse.cz>

> ---
>  include/linux/memcontrol.h |  1 -
>  mm/memcontrol.c            | 48 +-------------------------------------
>  mm/slab.h                  |  2 ++
>  mm/slab_common.c           | 22 +++++++++--------
>  4 files changed, 15 insertions(+), 58 deletions(-)
> 
> diff --git a/include/linux/memcontrol.h b/include/linux/memcontrol.h
> index 698b92d60da5..87e6da5015b3 100644
> --- a/include/linux/memcontrol.h
> +++ b/include/linux/memcontrol.h
> @@ -1440,7 +1440,6 @@ int obj_cgroup_charge(struct obj_cgroup *objcg, gfp_t gfp, size_t size);
>  void obj_cgroup_uncharge(struct obj_cgroup *objcg, size_t size);
>  
>  extern struct static_key_false memcg_kmem_enabled_key;
> -extern struct workqueue_struct *memcg_kmem_cache_wq;
>  
>  extern int memcg_nr_cache_ids;
>  void memcg_get_cache_ids(void);
> diff --git a/mm/memcontrol.c b/mm/memcontrol.c
> index 9fe2433fbe67..55fd42155a37 100644
> --- a/mm/memcontrol.c
> +++ b/mm/memcontrol.c
> @@ -379,8 +379,6 @@ void memcg_put_cache_ids(void)
>   */
>  DEFINE_STATIC_KEY_FALSE(memcg_kmem_enabled_key);
>  EXPORT_SYMBOL(memcg_kmem_enabled_key);
> -
> -struct workqueue_struct *memcg_kmem_cache_wq;
>  #endif
>  
>  static int memcg_shrinker_map_size;
> @@ -2900,39 +2898,6 @@ static void memcg_free_cache_id(int id)
>  	ida_simple_remove(&memcg_cache_ida, id);
>  }
>  
> -struct memcg_kmem_cache_create_work {
> -	struct kmem_cache *cachep;
> -	struct work_struct work;
> -};
> -
> -static void memcg_kmem_cache_create_func(struct work_struct *w)
> -{
> -	struct memcg_kmem_cache_create_work *cw =
> -		container_of(w, struct memcg_kmem_cache_create_work, work);
> -	struct kmem_cache *cachep = cw->cachep;
> -
> -	memcg_create_kmem_cache(cachep);
> -
> -	kfree(cw);
> -}
> -
> -/*
> - * Enqueue the creation of a per-memcg kmem_cache.
> - */
> -static void memcg_schedule_kmem_cache_create(struct kmem_cache *cachep)
> -{
> -	struct memcg_kmem_cache_create_work *cw;
> -
> -	cw = kmalloc(sizeof(*cw), GFP_NOWAIT | __GFP_NOWARN);
> -	if (!cw)
> -		return;
> -
> -	cw->cachep = cachep;
> -	INIT_WORK(&cw->work, memcg_kmem_cache_create_func);
> -
> -	queue_work(memcg_kmem_cache_wq, &cw->work);
> -}
> -
>  /**
>   * memcg_kmem_get_cache: select memcg or root cache for allocation
>   * @cachep: the original global kmem cache
> @@ -2949,7 +2914,7 @@ struct kmem_cache *memcg_kmem_get_cache(struct kmem_cache *cachep)
>  
>  	memcg_cachep = READ_ONCE(cachep->memcg_params.memcg_cache);
>  	if (unlikely(!memcg_cachep)) {
> -		memcg_schedule_kmem_cache_create(cachep);
> +		queue_work(system_wq, &cachep->memcg_params.work);
>  		return cachep;
>  	}
>  
> @@ -7122,17 +7087,6 @@ static int __init mem_cgroup_init(void)
>  {
>  	int cpu, node;
>  
> -#ifdef CONFIG_MEMCG_KMEM
> -	/*
> -	 * Kmem cache creation is mostly done with the slab_mutex held,
> -	 * so use a workqueue with limited concurrency to avoid stalling
> -	 * all worker threads in case lots of cgroups are created and
> -	 * destroyed simultaneously.
> -	 */
> -	memcg_kmem_cache_wq = alloc_workqueue("memcg_kmem_cache", 0, 1);
> -	BUG_ON(!memcg_kmem_cache_wq);
> -#endif
> -
>  	cpuhp_setup_state_nocalls(CPUHP_MM_MEMCQ_DEAD, "mm/memctrl:dead", NULL,
>  				  memcg_hotplug_cpu_dead);
>  
> diff --git a/mm/slab.h b/mm/slab.h
> index 28c582ec997a..a4e115cb8bdc 100644
> --- a/mm/slab.h
> +++ b/mm/slab.h
> @@ -45,12 +45,14 @@ struct kmem_cache {
>   * @memcg_cache: pointer to memcg kmem cache, used by all non-root memory
>   *		cgroups.
>   * @root_caches_node: list node for slab_root_caches list.
> + * @work: work struct used to create the non-root cache.
>   */
>  struct memcg_cache_params {
>  	struct kmem_cache *root_cache;
>  
>  	struct kmem_cache *memcg_cache;
>  	struct list_head __root_caches_node;
> +	struct work_struct work;
>  };
>  #endif /* CONFIG_SLOB */
>  
> diff --git a/mm/slab_common.c b/mm/slab_common.c
> index e9deaafddbb6..10aa2acb84ca 100644
> --- a/mm/slab_common.c
> +++ b/mm/slab_common.c
> @@ -132,10 +132,18 @@ int __kmem_cache_alloc_bulk(struct kmem_cache *s, gfp_t flags, size_t nr,
>  
>  LIST_HEAD(slab_root_caches);
>  
> +static void memcg_kmem_cache_create_func(struct work_struct *work)
> +{
> +	struct kmem_cache *cachep = container_of(work, struct kmem_cache,
> +						 memcg_params.work);
> +	memcg_create_kmem_cache(cachep);
> +}
> +
>  void slab_init_memcg_params(struct kmem_cache *s)
>  {
>  	s->memcg_params.root_cache = NULL;
>  	s->memcg_params.memcg_cache = NULL;
> +	INIT_WORK(&s->memcg_params.work, memcg_kmem_cache_create_func);
>  }
>  
>  static void init_memcg_params(struct kmem_cache *s,
> @@ -584,15 +592,9 @@ static int shutdown_memcg_caches(struct kmem_cache *s)
>  	return 0;
>  }
>  
> -static void flush_memcg_workqueue(struct kmem_cache *s)
> +static void cancel_memcg_cache_creation(struct kmem_cache *s)
>  {
> -	/*
> -	 * SLAB and SLUB create memcg kmem_caches through workqueue and SLUB
> -	 * deactivates the memcg kmem_caches through workqueue. Make sure all
> -	 * previous workitems on workqueue are processed.
> -	 */
> -	if (likely(memcg_kmem_cache_wq))
> -		flush_workqueue(memcg_kmem_cache_wq);
> +	cancel_work_sync(&s->memcg_params.work);
>  }
>  #else
>  static inline int shutdown_memcg_caches(struct kmem_cache *s)
> @@ -600,7 +602,7 @@ static inline int shutdown_memcg_caches(struct kmem_cache *s)
>  	return 0;
>  }
>  
> -static inline void flush_memcg_workqueue(struct kmem_cache *s)
> +static inline void cancel_memcg_cache_creation(struct kmem_cache *s)
>  {
>  }
>  #endif /* CONFIG_MEMCG_KMEM */
> @@ -619,7 +621,7 @@ void kmem_cache_destroy(struct kmem_cache *s)
>  	if (unlikely(!s))
>  		return;
>  
> -	flush_memcg_workqueue(s);
> +	cancel_memcg_cache_creation(s);
>  
>  	get_online_cpus();
>  	get_online_mems();
> 

