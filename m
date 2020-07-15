Return-Path: <SRS0=kup7=A2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.5 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,NICE_REPLY_A,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3DE41C433E0
	for <linux-kernel@archiver.kernel.org>; Wed, 15 Jul 2020 11:32:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 238592063A
	for <linux-kernel@archiver.kernel.org>; Wed, 15 Jul 2020 11:32:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728873AbgGOLcD (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 15 Jul 2020 07:32:03 -0400
Received: from [195.135.220.15] ([195.135.220.15]:41842 "EHLO mx2.suse.de"
        rhost-flags-FAIL-FAIL-OK-OK) by vger.kernel.org with ESMTP
        id S1726212AbgGOLcD (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Jul 2020 07:32:03 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id BA70BB5A3;
        Wed, 15 Jul 2020 11:32:04 +0000 (UTC)
Subject: Re: [PATCH v5.4.y, v4.19.y] mm: memcg/slab: fix memory leak at
 non-root kmem_cache destroy
To:     Muchun Song <songmuchun@bytedance.com>, cl@linux.com,
        penberg@kernel.org, rientjes@google.com, iamjoonsoo.kim@lge.com,
        akpm@linux-foundation.org
Cc:     linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        shakeelb@google.com, Roman Gushchin <guro@fb.com>
References: <20200707062754.8383-1-songmuchun@bytedance.com>
From:   Vlastimil Babka <vbabka@suse.cz>
Message-ID: <3d06418e-e75c-e7b8-91cd-ba56283045be@suse.cz>
Date:   Wed, 15 Jul 2020 13:32:00 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20200707062754.8383-1-songmuchun@bytedance.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 7/7/20 8:27 AM, Muchun Song wrote:
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
>      A. It leads to create a non-root kmem_cache for allocating.
>   5) When destroy the memory cgroup created in the step 4), the
>      non-root kmem_cache can never be destroyed.
> 
> If we repeat steps 4) and 5), this will cause a lot of memory leak.
> So only when refcount reach zero, we mark the root kmem_cache as dying.
> 
> Fixes: 92ee383f6daa ("mm: fix race between kmem_cache destroy, create and deactivate")
> Signed-off-by: Muchun Song <songmuchun@bytedance.com>

CC Roman, who worked in this area recently.

Also why is this marked "[PATCH v5.4.y, v4.19.y]"? Has it been fixed otherwise
in 5.5+ ?

> ---
>  mm/slab_common.c | 43 +++++++++++++++++++++++++++++++++++++++++--
>  1 file changed, 41 insertions(+), 2 deletions(-)
> 
> diff --git a/mm/slab_common.c b/mm/slab_common.c
> index 8c1ffbf7de45..83ee6211aec7 100644
> --- a/mm/slab_common.c
> +++ b/mm/slab_common.c
> @@ -258,6 +258,11 @@ static void memcg_unlink_cache(struct kmem_cache *s)
>  		list_del(&s->memcg_params.kmem_caches_node);
>  	}
>  }
> +
> +static inline bool memcg_kmem_cache_dying(struct kmem_cache *s)
> +{
> +	return is_root_cache(s) && s->memcg_params.dying;
> +}
>  #else
>  static inline int init_memcg_params(struct kmem_cache *s,
>  				    struct kmem_cache *root_cache)
> @@ -272,6 +277,11 @@ static inline void destroy_memcg_params(struct kmem_cache *s)
>  static inline void memcg_unlink_cache(struct kmem_cache *s)
>  {
>  }
> +
> +static inline bool memcg_kmem_cache_dying(struct kmem_cache *s)
> +{
> +	return false;
> +}
>  #endif /* CONFIG_MEMCG_KMEM */
>  
>  /*
> @@ -326,6 +336,13 @@ int slab_unmergeable(struct kmem_cache *s)
>  	if (s->refcount < 0)
>  		return 1;
>  
> +	/*
> +	 * If the kmem_cache is dying. We should also skip this
> +	 * kmem_cache.
> +	 */
> +	if (memcg_kmem_cache_dying(s))
> +		return 1;
> +
>  	return 0;
>  }
>  
> @@ -944,8 +961,6 @@ void kmem_cache_destroy(struct kmem_cache *s)
>  	if (unlikely(!s))
>  		return;
>  
> -	flush_memcg_workqueue(s);
> -
>  	get_online_cpus();
>  	get_online_mems();
>  
> @@ -955,6 +970,30 @@ void kmem_cache_destroy(struct kmem_cache *s)
>  	if (s->refcount)
>  		goto out_unlock;
>  
> +#ifdef CONFIG_MEMCG_KMEM
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
> +
> +	if (WARN(s->refcount,
> +		 "kmem_cache_destroy %s: Slab cache is still referenced\n",
> +		 s->name)) {
> +		/*
> +		 * Reset the dying flag setted by flush_memcg_workqueue().
> +		 */
> +		s->memcg_params.dying = false;
> +		goto out_unlock;
> +	}
> +#endif
> +
>  	err = shutdown_memcg_caches(s);
>  	if (!err)
>  		err = shutdown_cache(s);
> 

