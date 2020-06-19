Return-Path: <SRS0=bWCJ=AA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.3 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_IN_DEF_DKIM_WL autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C59D3C433DF
	for <linux-kernel@archiver.kernel.org>; Fri, 19 Jun 2020 16:36:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 97BAC20809
	for <linux-kernel@archiver.kernel.org>; Fri, 19 Jun 2020 16:36:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="DbocgXRZ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2395124AbgFSQge (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 19 Jun 2020 12:36:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42310 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2389195AbgFSQga (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 19 Jun 2020 12:36:30 -0400
Received: from mail-lj1-x244.google.com (mail-lj1-x244.google.com [IPv6:2a00:1450:4864:20::244])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1E9CAC06174E
        for <linux-kernel@vger.kernel.org>; Fri, 19 Jun 2020 09:36:29 -0700 (PDT)
Received: by mail-lj1-x244.google.com with SMTP id s1so12258278ljo.0
        for <linux-kernel@vger.kernel.org>; Fri, 19 Jun 2020 09:36:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=QXN51CGxDknjhoSnGghsda3CY0tY3mhD+S0p6xHxxXc=;
        b=DbocgXRZEYq3/oxxE0Wsj4jVA5sPIW0H8ZgE/QU8efnRZf2k+uVbm9H9M3ZwLCkdtc
         POt/KIqJuT8hKztMAlZUFhwx3ogMwDhdRJCaPgJEpvM1TvdCSFSHp18UG66bLXGZ/s9l
         lRkUjMpWDN87riuy2suLV4bGKRkMER4WXLj3kTVH9FwDkX93hcw1NBytiefA6mLcpp1m
         VLkSP+WaLX31gJ33nreRvqwbuMa5wxAuWMPkb5CtuKDrMNAncI6gFSDcIVQr4RM1o3mC
         YCgWgHIUrixGUq670+PNYmW41WgoHDi9ZLvdj7L1D6gJ771wFEf8R3kWhky/2Naur+dX
         9U1g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=QXN51CGxDknjhoSnGghsda3CY0tY3mhD+S0p6xHxxXc=;
        b=EpN3jm9cvxRXPEEGYtqz72oYG6dM0xRwSDzGqCvEoj08d9TzfODkj7nR+hDxMcGNmK
         iJBOERoitlSBBNnQLD5FkedImYQJxNEpm1wuHr1MIMcWzohYgQk8X+hJ95/0gDTHW1qk
         41J2e9Gs+FfVaZSEPoYQLYylzjR0sI+ursnwNgvwUU35Ko42CfOaNzCa7F62KnJ4IEIE
         RoEEYlexboEC64WzNRn7RqTGEd3z0rTACogr1eF2+Cx75Wa23dqxfrIK3bO7Y+ci5jtc
         8POFnCLPNs8N8K6zoaWqbku19O1lz06EcevvsROgsg+Ee02m7P8+5uSZlLaCgMyZE/r8
         7tig==
X-Gm-Message-State: AOAM530b3y96IkV4VMgYEpPE5c/hx6KYFpRYmz9jYKtf593DdT2U16Yh
        nmZASbTbt3/bzQbJu2MWVoMdDieJTvqhuTWWt+qixA==
X-Google-Smtp-Source: ABdhPJy0rLGEVvjUkIOYGlz0THbuHkwvljwI58cpeQsga4Brvy3PHXpWC1nZKs5hSFiyRzvyoILAKDMXHYjkRxb6eYk=
X-Received: by 2002:a2e:910c:: with SMTP id m12mr2399610ljg.332.1592584587184;
 Fri, 19 Jun 2020 09:36:27 -0700 (PDT)
MIME-Version: 1.0
References: <20200608230654.828134-1-guro@fb.com> <20200608230654.828134-8-guro@fb.com>
In-Reply-To: <20200608230654.828134-8-guro@fb.com>
From:   Shakeel Butt <shakeelb@google.com>
Date:   Fri, 19 Jun 2020 09:36:16 -0700
Message-ID: <CALvZod56d1RDJscJY2mRrhXr7uBn4bxJobuq_xRjDPQUHfWm5A@mail.gmail.com>
Subject: Re: [PATCH v6 07/19] mm: memcg/slab: allocate obj_cgroups for
 non-root slab pages
To:     Roman Gushchin <guro@fb.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Christoph Lameter <cl@linux.com>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Michal Hocko <mhocko@kernel.org>,
        Linux MM <linux-mm@kvack.org>,
        Vlastimil Babka <vbabka@suse.cz>,
        Kernel Team <kernel-team@fb.com>,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jun 8, 2020 at 4:07 PM Roman Gushchin <guro@fb.com> wrote:
>
> Allocate and release memory to store obj_cgroup pointers for each
> non-root slab page. Reuse page->mem_cgroup pointer to store a pointer
> to the allocated space.
>
> To distinguish between obj_cgroups and memcg pointers in case
> when it's not obvious which one is used (as in page_cgroup_ino()),
> let's always set the lowest bit in the obj_cgroup case.
>

I think the commit message should talk about the potential overhead
(i.e an extra pointer for each object) along with the justifications
(i.e. less internal fragmentation and potentially more savings than
the overhead).

> Signed-off-by: Roman Gushchin <guro@fb.com>
> Reviewed-by: Vlastimil Babka <vbabka@suse.cz>
> ---
>  include/linux/mm_types.h |  5 +++-
>  include/linux/slab_def.h |  6 +++++
>  include/linux/slub_def.h |  5 ++++
>  mm/memcontrol.c          | 17 +++++++++++---
>  mm/slab.h                | 49 ++++++++++++++++++++++++++++++++++++++++
>  5 files changed, 78 insertions(+), 4 deletions(-)
>
> diff --git a/include/linux/mm_types.h b/include/linux/mm_types.h
> index 64ede5f150dc..0277fbab7c93 100644
> --- a/include/linux/mm_types.h
> +++ b/include/linux/mm_types.h
> @@ -198,7 +198,10 @@ struct page {
>         atomic_t _refcount;
>
>  #ifdef CONFIG_MEMCG
> -       struct mem_cgroup *mem_cgroup;
> +       union {
> +               struct mem_cgroup *mem_cgroup;
> +               struct obj_cgroup **obj_cgroups;
> +       };
>  #endif
>
>         /*
> diff --git a/include/linux/slab_def.h b/include/linux/slab_def.h
> index abc7de77b988..ccda7b9669a5 100644
> --- a/include/linux/slab_def.h
> +++ b/include/linux/slab_def.h
> @@ -114,4 +114,10 @@ static inline unsigned int obj_to_index(const struct kmem_cache *cache,
>         return reciprocal_divide(offset, cache->reciprocal_buffer_size);
>  }
>
> +static inline int objs_per_slab_page(const struct kmem_cache *cache,
> +                                    const struct page *page)
> +{
> +       return cache->num;
> +}
> +
>  #endif /* _LINUX_SLAB_DEF_H */
> diff --git a/include/linux/slub_def.h b/include/linux/slub_def.h
> index 30e91c83d401..f87302dcfe8c 100644
> --- a/include/linux/slub_def.h
> +++ b/include/linux/slub_def.h
> @@ -198,4 +198,9 @@ static inline unsigned int obj_to_index(const struct kmem_cache *cache,
>         return __obj_to_index(cache, page_address(page), obj);
>  }
>
> +static inline int objs_per_slab_page(const struct kmem_cache *cache,
> +                                    const struct page *page)
> +{
> +       return page->objects;
> +}
>  #endif /* _LINUX_SLUB_DEF_H */
> diff --git a/mm/memcontrol.c b/mm/memcontrol.c
> index 7ff66275966c..2020c7542aa1 100644
> --- a/mm/memcontrol.c
> +++ b/mm/memcontrol.c
> @@ -569,10 +569,21 @@ ino_t page_cgroup_ino(struct page *page)
>         unsigned long ino = 0;
>
>         rcu_read_lock();
> -       if (PageSlab(page) && !PageTail(page))
> +       if (PageSlab(page) && !PageTail(page)) {
>                 memcg = memcg_from_slab_page(page);
> -       else
> -               memcg = READ_ONCE(page->mem_cgroup);
> +       } else {
> +               memcg = page->mem_cgroup;
> +
> +               /*
> +                * The lowest bit set means that memcg isn't a valid
> +                * memcg pointer, but a obj_cgroups pointer.
> +                * In this case the page is shared and doesn't belong
> +                * to any specific memory cgroup.
> +                */
> +               if ((unsigned long) memcg & 0x1UL)
> +                       memcg = NULL;
> +       }
> +
>         while (memcg && !(memcg->css.flags & CSS_ONLINE))
>                 memcg = parent_mem_cgroup(memcg);
>         if (memcg)
> diff --git a/mm/slab.h b/mm/slab.h
> index 8a574d9361c1..a1633ea15fbf 100644
> --- a/mm/slab.h
> +++ b/mm/slab.h
> @@ -319,6 +319,18 @@ static inline struct kmem_cache *memcg_root_cache(struct kmem_cache *s)
>         return s->memcg_params.root_cache;
>  }
>
> +static inline struct obj_cgroup **page_obj_cgroups(struct page *page)
> +{
> +       /*
> +        * page->mem_cgroup and page->obj_cgroups are sharing the same
> +        * space. To distinguish between them in case we don't know for sure
> +        * that the page is a slab page (e.g. page_cgroup_ino()), let's
> +        * always set the lowest bit of obj_cgroups.
> +        */
> +       return (struct obj_cgroup **)
> +               ((unsigned long)page->obj_cgroups & ~0x1UL);
> +}
> +
>  /*
>   * Expects a pointer to a slab page. Please note, that PageSlab() check
>   * isn't sufficient, as it returns true also for tail compound slab pages,
> @@ -406,6 +418,26 @@ static __always_inline void memcg_uncharge_slab(struct page *page, int order,
>         percpu_ref_put_many(&s->memcg_params.refcnt, nr_pages);
>  }
>
> +static inline int memcg_alloc_page_obj_cgroups(struct page *page,
> +                                              struct kmem_cache *s, gfp_t gfp)
> +{
> +       unsigned int objects = objs_per_slab_page(s, page);
> +       void *vec;
> +
> +       vec = kcalloc(objects, sizeof(struct obj_cgroup *), gfp);

Should the above allocation be on the same node as the page?

> +       if (!vec)
> +               return -ENOMEM;
> +
> +       page->obj_cgroups = (struct obj_cgroup **) ((unsigned long)vec | 0x1UL);
> +       return 0;
> +}
> +
> +static inline void memcg_free_page_obj_cgroups(struct page *page)
> +{
> +       kfree(page_obj_cgroups(page));
> +       page->obj_cgroups = NULL;
> +}
> +
>  extern void slab_init_memcg_params(struct kmem_cache *);
>  extern void memcg_link_cache(struct kmem_cache *s, struct mem_cgroup *memcg);
>
> @@ -455,6 +487,16 @@ static inline void memcg_uncharge_slab(struct page *page, int order,
>  {
>  }
>
> +static inline int memcg_alloc_page_obj_cgroups(struct page *page,
> +                                              struct kmem_cache *s, gfp_t gfp)
> +{
> +       return 0;
> +}
> +
> +static inline void memcg_free_page_obj_cgroups(struct page *page)
> +{
> +}
> +
>  static inline void slab_init_memcg_params(struct kmem_cache *s)
>  {
>  }
> @@ -481,12 +523,18 @@ static __always_inline int charge_slab_page(struct page *page,
>                                             gfp_t gfp, int order,
>                                             struct kmem_cache *s)
>  {
> +       int ret;
> +
>         if (is_root_cache(s)) {
>                 mod_node_page_state(page_pgdat(page), cache_vmstat_idx(s),
>                                     PAGE_SIZE << order);
>                 return 0;
>         }
>
> +       ret = memcg_alloc_page_obj_cgroups(page, s, gfp);
> +       if (ret)
> +               return ret;
> +
>         return memcg_charge_slab(page, gfp, order, s);
>  }
>
> @@ -499,6 +547,7 @@ static __always_inline void uncharge_slab_page(struct page *page, int order,
>                 return;
>         }
>
> +       memcg_free_page_obj_cgroups(page);
>         memcg_uncharge_slab(page, order, s);
>  }
>
> --
> 2.25.4
>
