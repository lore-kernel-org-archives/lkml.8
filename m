Return-Path: <SRS0=fR4S=7I=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5DDB4C433DF
	for <linux-kernel@archiver.kernel.org>; Tue, 26 May 2020 10:13:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3F7E1207ED
	for <linux-kernel@archiver.kernel.org>; Tue, 26 May 2020 10:13:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388524AbgEZKND (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 26 May 2020 06:13:03 -0400
Received: from mx2.suse.de ([195.135.220.15]:36132 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2388339AbgEZKNC (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 May 2020 06:13:02 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx2.suse.de (Postfix) with ESMTP id 39E51B1C1;
        Tue, 26 May 2020 10:13:04 +0000 (UTC)
Subject: Re: [PATCH v3 12/19] mm: memcg/slab: use a single set of kmem_caches
 for all accounted allocations
To:     Roman Gushchin <guro@fb.com>,
        Andrew Morton <akpm@linux-foundation.org>
Cc:     Johannes Weiner <hannes@cmpxchg.org>,
        Michal Hocko <mhocko@kernel.org>, linux-mm@kvack.org,
        kernel-team@fb.com, linux-kernel@vger.kernel.org
References: <20200422204708.2176080-1-guro@fb.com>
 <20200422204708.2176080-13-guro@fb.com>
From:   Vlastimil Babka <vbabka@suse.cz>
Message-ID: <4d9e18ea-3100-8311-e969-a376096a0b60@suse.cz>
Date:   Tue, 26 May 2020 12:12:59 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.8.0
MIME-Version: 1.0
In-Reply-To: <20200422204708.2176080-13-guro@fb.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 4/22/20 10:47 PM, Roman Gushchin wrote:
> This is fairly big but mostly red patch, which makes all accounted
> slab allocations use a single set of kmem_caches instead of
> creating a separate set for each memory cgroup.
> 
> Because the number of non-root kmem_caches is now capped by the number
> of root kmem_caches, there is no need to shrink or destroy them
> prematurely. They can be perfectly destroyed together with their
> root counterparts. This allows to dramatically simplify the
> management of non-root kmem_caches and delete a ton of code.
> 
> This patch performs the following changes:
> 1) introduces memcg_params.memcg_cache pointer to represent the
>    kmem_cache which will be used for all non-root allocations
> 2) reuses the existing memcg kmem_cache creation mechanism
>    to create memcg kmem_cache on the first allocation attempt
> 3) memcg kmem_caches are named <kmemcache_name>-memcg,
>    e.g. dentry-memcg
> 4) simplifies memcg_kmem_get_cache() to just return memcg kmem_cache
>    or schedule it's creation and return the root cache
> 5) removes almost all non-root kmem_cache management code
>    (separate refcounter, reparenting, shrinking, etc)
> 6) makes slab debugfs to display root_mem_cgroup css id and never
>    show :dead and :deact flags in the memcg_slabinfo attribute.
> 
> Following patches in the series will simplify the kmem_cache creation.
> 
> Signed-off-by: Roman Gushchin <guro@fb.com>
> ---
>  include/linux/memcontrol.h |   5 +-
>  include/linux/slab.h       |   5 +-
>  mm/memcontrol.c            | 163 +++-----------
>  mm/slab.c                  |  16 +-
>  mm/slab.h                  | 145 ++++---------
>  mm/slab_common.c           | 426 ++++---------------------------------
>  mm/slub.c                  |  38 +---
>  7 files changed, 128 insertions(+), 670 deletions(-)

Nice stats.

Reviewed-by: Vlastimil Babka <vbabka@suse.cz>

> @@ -548,17 +502,14 @@ static __always_inline int charge_slab_page(struct page *page,
>  					    gfp_t gfp, int order,
>  					    struct kmem_cache *s)
>  {
> -#ifdef CONFIG_MEMCG_KMEM

Ah, indeed. Still, less churn if ref manipulation was done in
memcg_alloc/free_page_obj() ?

>  	if (!is_root_cache(s)) {
>  		int ret;
>  
>  		ret = memcg_alloc_page_obj_cgroups(page, gfp, objs_per_slab(s));
>  		if (ret)
>  			return ret;
> -
> -		percpu_ref_get_many(&s->memcg_params.refcnt, 1 << order);
>  	}
> -#endif
> +
>  	mod_node_page_state(page_pgdat(page), cache_vmstat_idx(s),
>  			    PAGE_SIZE << order);
>  	return 0;
