Return-Path: <SRS0=8lgJ=7H=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6B68FC433DF
	for <linux-kernel@archiver.kernel.org>; Mon, 25 May 2020 16:11:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4FC60207D8
	for <linux-kernel@archiver.kernel.org>; Mon, 25 May 2020 16:11:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391211AbgEYQK7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 25 May 2020 12:10:59 -0400
Received: from mx2.suse.de ([195.135.220.15]:53166 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2388556AbgEYQK6 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 May 2020 12:10:58 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx2.suse.de (Postfix) with ESMTP id D9A41AEC9;
        Mon, 25 May 2020 16:10:58 +0000 (UTC)
Subject: Re: [PATCH v3 09/19] mm: memcg/slab: charge individual slab objects
 instead of pages
To:     Roman Gushchin <guro@fb.com>,
        Andrew Morton <akpm@linux-foundation.org>
Cc:     Johannes Weiner <hannes@cmpxchg.org>,
        Michal Hocko <mhocko@kernel.org>, linux-mm@kvack.org,
        kernel-team@fb.com, linux-kernel@vger.kernel.org
References: <20200422204708.2176080-1-guro@fb.com>
 <20200422204708.2176080-10-guro@fb.com>
From:   Vlastimil Babka <vbabka@suse.cz>
Message-ID: <75328f78-117b-5042-f42e-5ef01dd93086@suse.cz>
Date:   Mon, 25 May 2020 18:10:55 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.8.0
MIME-Version: 1.0
In-Reply-To: <20200422204708.2176080-10-guro@fb.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 4/22/20 10:46 PM, Roman Gushchin wrote:
> Switch to per-object accounting of non-root slab objects.
> 
> Charging is performed using obj_cgroup API in the pre_alloc hook.
> Obj_cgroup is charged with the size of the object and the size
> of metadata: as now it's the size of an obj_cgroup pointer.
> If the amount of memory has been charged successfully, the actual
> allocation code is executed. Otherwise, -ENOMEM is returned.
> 
> In the post_alloc hook if the actual allocation succeeded,
> corresponding vmstats are bumped and the obj_cgroup pointer is saved.
> Otherwise, the charge is canceled.
> 
> On the free path obj_cgroup pointer is obtained and used to uncharge
> the size of the releasing object.
> 
> Memcg and lruvec counters are now representing only memory used
> by active slab objects and do not include the free space. The free
> space is shared and doesn't belong to any specific cgroup.
> 
> Global per-node slab vmstats are still modified from (un)charge_slab_page()
> functions. The idea is to keep all slab pages accounted as slab pages
> on system level.
> 
> Signed-off-by: Roman Gushchin <guro@fb.com>

Reviewed-by: Vlastimil Babka <vbabka@suse.cz>

Suggestion below:

> @@ -568,32 +548,33 @@ static __always_inline int charge_slab_page(struct page *page,
>  					    gfp_t gfp, int order,
>  					    struct kmem_cache *s)
>  {
> -	int ret;
> -
> -	if (is_root_cache(s)) {
> -		mod_node_page_state(page_pgdat(page), cache_vmstat_idx(s),
> -				    PAGE_SIZE << order);
> -		return 0;
> -	}
> +#ifdef CONFIG_MEMCG_KMEM
> +	if (!is_root_cache(s)) {

This could also benefit from memcg_kmem_enabled() static key test AFAICS. Maybe
even have a wrapper for both tests together?

> +		int ret;
>  
> -	ret = memcg_alloc_page_obj_cgroups(page, gfp, objs_per_slab(s));
> -	if (ret)
> -		return ret;
> +		ret = memcg_alloc_page_obj_cgroups(page, gfp, objs_per_slab(s));

You created memcg_alloc_page_obj_cgroups() empty variant for !CONFIG_MEMCG_KMEM
but now the only caller is under CONFIG_MEMCG_KMEM.

> +		if (ret)
> +			return ret;
>  
> -	return memcg_charge_slab(page, gfp, order, s);
> +		percpu_ref_get_many(&s->memcg_params.refcnt, 1 << order);

Perhaps moving this refcount into memcg_alloc_page_obj_cgroups() (maybe the name
should be different then) will allow you to not add #ifdef CONFIG_MEMCG_KMEM in
this function.

Maybe this is all moot after patch 12/19, will find out :)

> +	}
> +#endif
> +	mod_node_page_state(page_pgdat(page), cache_vmstat_idx(s),
> +			    PAGE_SIZE << order);
> +	return 0;
>  }
>  
>  static __always_inline void uncharge_slab_page(struct page *page, int order,
>  					       struct kmem_cache *s)
>  {
> -	if (is_root_cache(s)) {
> -		mod_node_page_state(page_pgdat(page), cache_vmstat_idx(s),
> -				    -(PAGE_SIZE << order));
> -		return;
> +#ifdef CONFIG_MEMCG_KMEM
> +	if (!is_root_cache(s)) {

Everything from above also applies here.

> +		memcg_free_page_obj_cgroups(page);
> +		percpu_ref_put_many(&s->memcg_params.refcnt, 1 << order);
>  	}
> -
> -	memcg_free_page_obj_cgroups(page);
> -	memcg_uncharge_slab(page, order, s);
> +#endif
> +	mod_node_page_state(page_pgdat(page), cache_vmstat_idx(s),
> +			    -(PAGE_SIZE << order));
>  }
>  
>  static inline struct kmem_cache *cache_from_obj(struct kmem_cache *s, void *x)


