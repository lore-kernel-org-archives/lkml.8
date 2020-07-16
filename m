Return-Path: <SRS0=y5Sx=A3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.5 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,NICE_REPLY_A,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4560EC43616
	for <linux-kernel@archiver.kernel.org>; Thu, 16 Jul 2020 17:21:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2AF92207CB
	for <linux-kernel@archiver.kernel.org>; Thu, 16 Jul 2020 17:21:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729375AbgGPRVu (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 16 Jul 2020 13:21:50 -0400
Received: from mx2.suse.de ([195.135.220.15]:34556 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728126AbgGPRVt (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Jul 2020 13:21:49 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 16602AC36;
        Thu, 16 Jul 2020 17:21:51 +0000 (UTC)
Subject: Re: [PATCH v3] mm: memcg/slab: fix memory leak at non-root kmem_cache
 destroy
To:     Muchun Song <songmuchun@bytedance.com>, guro@fb.com, cl@linux.com,
        penberg@kernel.org, rientjes@google.com, iamjoonsoo.kim@lge.com,
        akpm@linux-foundation.org, shakeelb@google.com
Cc:     linux-mm@kvack.org, linux-kernel@vger.kernel.org
References: <20200716165103.83462-1-songmuchun@bytedance.com>
From:   Vlastimil Babka <vbabka@suse.cz>
Message-ID: <a1e6a270-e7e2-78f0-62dd-c7e9ad1b2903@suse.cz>
Date:   Thu, 16 Jul 2020 19:21:42 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20200716165103.83462-1-songmuchun@bytedance.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 7/16/20 6:51 PM, Muchun Song wrote:
> If the kmem_cache refcount is greater than one, we should not
> mark the root kmem_cache as dying. If we mark the root kmem_cache
> dying incorrectly, the non-root kmem_cache can never be destroyed.
> It resulted in memory leak when memcg was destroyed. We can use the
> following steps to reproduce.
> 
>   1) Use kmem_cache_create() to create a new kmem_cache named A.
>   2) Coincidentally, the kmem_cache A is an alias for kmem_cache B,
>      so the refcount of B is just increased.
>   3) Use kmem_cache_destroy() to destroy the kmem_cache A, just
>      decrease the B's refcount but mark the B as dying.
>   4) Create a new memory cgroup and alloc memory from the kmem_cache
>      B. It leads to create a non-root kmem_cache for allocating memory.
>   5) When destroy the memory cgroup created in the step 4), the
>      non-root kmem_cache can never be destroyed.
> 
> If we repeat steps 4) and 5), this will cause a lot of memory leak.
> So only when refcount reach zero, we mark the root kmem_cache as dying.
> 
> Fixes: 92ee383f6daa ("mm: fix race between kmem_cache destroy, create and deactivate")
> Signed-off-by: Muchun Song <songmuchun@bytedance.com>
> Reviewed-by: Shakeel Butt <shakeelb@google.com>
> Acked-by: Roman Gushchin <guro@fb.com>

Cc: <stable@vger.kernel.org>

And it will need to go before the series that starts with
mm-memcg-factor-out-memcg-and-lruvec-level-changes-out-of-__mod_lruvec_state.patch

most likely causing some collisions there to be fixed up...

> ---
> 
> changelog in v3:
>  1) Simplify the code suggested by Roman.
> 
> changelog in v2:
>  1) Fix a confusing typo in the commit log.
>  2) Remove flush_memcg_workqueue() for !CONFIG_MEMCG_KMEM.
>  3) Introduce a new helper memcg_set_kmem_cache_dying() to fix a race
>     condition between flush_memcg_workqueue() and slab_unmergeable().
> 
>  mm/slab_common.c | 35 ++++++++++++++++++++++++++++-------
>  1 file changed, 28 insertions(+), 7 deletions(-)
> 
> diff --git a/mm/slab_common.c b/mm/slab_common.c
> index 37d48a56431d..fe8b68482670 100644
> --- a/mm/slab_common.c
> +++ b/mm/slab_common.c
> @@ -326,6 +326,14 @@ int slab_unmergeable(struct kmem_cache *s)
>  	if (s->refcount < 0)
>  		return 1;
>  
> +#ifdef CONFIG_MEMCG_KMEM
> +	/*
> +	 * Skip the dying kmem_cache.
> +	 */
> +	if (s->memcg_params.dying)
> +		return 1;
> +#endif
> +
>  	return 0;
>  }
>  
> @@ -886,12 +894,15 @@ static int shutdown_memcg_caches(struct kmem_cache *s)
>  	return 0;
>  }
>  
> -static void flush_memcg_workqueue(struct kmem_cache *s)
> +static void memcg_set_kmem_cache_dying(struct kmem_cache *s)
>  {
>  	spin_lock_irq(&memcg_kmem_wq_lock);
>  	s->memcg_params.dying = true;
>  	spin_unlock_irq(&memcg_kmem_wq_lock);
> +}
>  
> +static void flush_memcg_workqueue(struct kmem_cache *s)
> +{
>  	/*
>  	 * SLAB and SLUB deactivate the kmem_caches through call_rcu. Make
>  	 * sure all registered rcu callbacks have been invoked.
> @@ -923,10 +934,6 @@ static inline int shutdown_memcg_caches(struct kmem_cache *s)
>  {
>  	return 0;
>  }
> -
> -static inline void flush_memcg_workqueue(struct kmem_cache *s)
> -{
> -}
>  #endif /* CONFIG_MEMCG_KMEM */
>  
>  void slab_kmem_cache_release(struct kmem_cache *s)
> @@ -944,8 +951,6 @@ void kmem_cache_destroy(struct kmem_cache *s)
>  	if (unlikely(!s))
>  		return;
>  
> -	flush_memcg_workqueue(s);
> -
>  	get_online_cpus();
>  	get_online_mems();
>  
> @@ -955,6 +960,22 @@ void kmem_cache_destroy(struct kmem_cache *s)
>  	if (s->refcount)
>  		goto out_unlock;
>  
> +#ifdef CONFIG_MEMCG_KMEM
> +	memcg_set_kmem_cache_dying(s);
> +
> +	mutex_unlock(&slab_mutex);
> +
> +	put_online_mems();
> +	put_online_cpus();
> +
> +	flush_memcg_workqueue(s);
> +
> +	get_online_cpus();
> +	get_online_mems();
> +
> +	mutex_lock(&slab_mutex);
> +#endif
> +
>  	err = shutdown_memcg_caches(s);
>  	if (!err)
>  		err = shutdown_cache(s);
> 

