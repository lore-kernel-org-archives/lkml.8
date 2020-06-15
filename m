Return-Path: <SRS0=PJcK=74=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DC81BC433DF
	for <linux-kernel@archiver.kernel.org>; Mon, 15 Jun 2020 09:13:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id BBD2120707
	for <linux-kernel@archiver.kernel.org>; Mon, 15 Jun 2020 09:13:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1592212421;
	bh=h/zGVRRAzSvBehgKKBcN1OLvI8BuwmBaO01iJ0fEU0Q=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=HSDgYhWXfOb56W4tsyUzfMqi8TV6JqJ5pKTmf8DXOAYh44hfInXB64fknMK5g6nkm
	 SfiCEC/PQzOu5oXnaZ0HiaClgqCiuD7JOeO9B8ApFHjiOBsjnS9Jewy4wKDL1NnH9L
	 MeKnVONYguVTLIYJCS1lBLBrntJvV2jt6mWUhWd8=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729298AbgFOJNk (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 15 Jun 2020 05:13:40 -0400
Received: from mail-wr1-f66.google.com ([209.85.221.66]:38448 "EHLO
        mail-wr1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729073AbgFOJNj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 Jun 2020 05:13:39 -0400
Received: by mail-wr1-f66.google.com with SMTP id e1so16300158wrt.5
        for <linux-kernel@vger.kernel.org>; Mon, 15 Jun 2020 02:13:38 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=ovYDqOmj0RcWezm825Y7rApyl3DGymdbL53dv7LzD2A=;
        b=HO8p5Ja8sDqRpPLcpbGlRAMk5bZEDqOb+1GiwbhHCEFjwUPcYrTKZK50BSzSwS6rLC
         btZFbNMIlTPoZLtnq1ymYWU5y6jOgTfVo4uGD9G4IsKgEEbXLpvoX7iOBk9eWkeGI55G
         20Z4t9gTCle76P7rMqFyDnB7tJ00fPli4L7M6lNWs0YTdYSM9rUtYst80yjcctU7MEfH
         b+Gz5peCmHXGVrkTNh+MgcAEpKprmJrpSKh8Mdiq5NVUvkbBwdLxzO3qZAbJiXvWdNQX
         ZuNRsiRbOPm/dctMWezBRSWQ2jDnsV287EGDRvkGKLGI9UN4tiJ9QN7p7TBydmwExwie
         BMsg==
X-Gm-Message-State: AOAM533544pPDiNXhWVYJ8J/XioB4Ode32+SQBd3JJ3g4tC+STf8GcZS
        eh/oXcEzKGZRAnd6uKvIPeO/VTCf
X-Google-Smtp-Source: ABdhPJz6Kog9KdDxoSgGTpJDWYP0eNAr4wgdNbABfCWGwzNAmLS8QhURq0jOW8u0wHDKrkn7AA/nsg==
X-Received: by 2002:adf:f4d2:: with SMTP id h18mr28063492wrp.370.1592212417436;
        Mon, 15 Jun 2020 02:13:37 -0700 (PDT)
Received: from localhost (ip-37-188-174-201.eurotel.cz. [37.188.174.201])
        by smtp.gmail.com with ESMTPSA id k14sm22725615wrq.97.2020.06.15.02.13.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 15 Jun 2020 02:13:36 -0700 (PDT)
Date:   Mon, 15 Jun 2020 11:13:35 +0200
From:   Michal Hocko <mhocko@kernel.org>
To:     Muchun Song <songmuchun@bytedance.com>
Cc:     cl@linux.com, penberg@kernel.org, rientjes@google.com,
        iamjoonsoo.kim@lge.com, akpm@linux-foundation.org,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        Roman Gushchin <guro@fb.com>
Subject: Re: [PATCH] mm/slab: Add a __GFP_ACCOUNT GFP flag check for slab
 allocation
Message-ID: <20200615091335.GD25296@dhcp22.suse.cz>
References: <20200614063858.85118-1-songmuchun@bytedance.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200614063858.85118-1-songmuchun@bytedance.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

[Cc Roman]

On Sun 14-06-20 14:38:58, Muchun Song wrote:
> When a kmem_cache is initialized with SLAB_ACCOUNT slab flag, we must
> not call kmem_cache_alloc with __GFP_ACCOUNT GFP flag. In this case,
> we can be accounted to kmemcg twice. This is not correct. So we add a
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
> -- 
> 2.11.0

-- 
Michal Hocko
SUSE Labs
