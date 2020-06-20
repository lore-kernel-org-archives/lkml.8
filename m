Return-Path: <SRS0=B91b=AB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.3 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_IN_DEF_DKIM_WL autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0428CC433E0
	for <linux-kernel@archiver.kernel.org>; Sat, 20 Jun 2020 00:32:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C924D22A85
	for <linux-kernel@archiver.kernel.org>; Sat, 20 Jun 2020 00:32:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="W++wx9a2"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730926AbgFTAcA (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 19 Jun 2020 20:32:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59100 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730293AbgFTAb5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 19 Jun 2020 20:31:57 -0400
Received: from mail-lj1-x242.google.com (mail-lj1-x242.google.com [IPv6:2a00:1450:4864:20::242])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 739A1C06174E
        for <linux-kernel@vger.kernel.org>; Fri, 19 Jun 2020 17:31:57 -0700 (PDT)
Received: by mail-lj1-x242.google.com with SMTP id i27so13389489ljb.12
        for <linux-kernel@vger.kernel.org>; Fri, 19 Jun 2020 17:31:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=GC0X1A1u34H3gu6Exp5dVJ6e1IpoU2YLjA8YbGTqXlw=;
        b=W++wx9a2bt4hjgiiNkEK90qCv41Wyd+Ab5FPHyTC/GMQMSKbMza18eMbtEhN2IyzgK
         qBNiyVBONw+GDIqeRL2QxuYpOrX1s9HMDL40l46jK1dhlg0qiIRKuQWJAkZKxU+SV5rg
         puck3Xt+CpyX6uh9LETS0yLdXhfErj8MWBlx6osdG1vwLuiG+/9eQvB7uMG7oh2/NiCH
         oYmBSxYBg2i0NGOK5UqwB8LsATuseC4JQ5PtQ0MIw29puHYicw/xwYUXFAjIAL82OTF/
         /cPSPnfmAkBwyXlwHbWMiv2b1sfe1CtGDw7yvhaRDsXnIGZ1sETrvnS3rsqbENvoauFe
         lLxA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=GC0X1A1u34H3gu6Exp5dVJ6e1IpoU2YLjA8YbGTqXlw=;
        b=oAwDzDmqKSed1ckACcToS87xeWa09T8aDRrWfcgIRxjXbXX7jqAUwSJqT0eZQV1F0+
         8JlOjhpdIwMdmBEqD9C/F/K+VfB+552OlgN+O2K6D2bo6hkN+2khlWuXeWdIr9E5bOLy
         U/hE8rsLaPdE3bAVN6PjqexZ61eDlpnfNVUIoE3wfBGsTtdoJaArLHNvvVPlItoy+SHW
         YOAquhERfzKxyQf6S/5UaD7Q/KLV4tfdAsy60z44sWKxee5PjGBAepXDRf+8cDWg11Bm
         XxKVlktOsaguu9PJ6Dz9BjkZHZHa9zPgG40mI6BPlMFoQ66yIilq0ctDst+eP2jMuWES
         4kHg==
X-Gm-Message-State: AOAM531qZeyEzY9L2usfUcdnxD3+pkiLDl1x9mrIGCtlqnvX7ffQFVlO
        D8Njl266sAfg5YNTXzHuCI4yeLPmr/nWDr4txObsyA==
X-Google-Smtp-Source: ABdhPJwpvTKkWRXgxu6zXw3WSGE6mJFBDibW77din/FtDcY/O0Rnc79GZLGHzqU1j9mW/Df+g6149erumhq14TW0lEE=
X-Received: by 2002:a2e:a58a:: with SMTP id m10mr3091893ljp.347.1592613115441;
 Fri, 19 Jun 2020 17:31:55 -0700 (PDT)
MIME-Version: 1.0
References: <20200608230654.828134-1-guro@fb.com> <20200608230654.828134-8-guro@fb.com>
 <CALvZod56d1RDJscJY2mRrhXr7uBn4bxJobuq_xRjDPQUHfWm5A@mail.gmail.com> <20200620002513.GD237539@carbon.dhcp.thefacebook.com>
In-Reply-To: <20200620002513.GD237539@carbon.dhcp.thefacebook.com>
From:   Shakeel Butt <shakeelb@google.com>
Date:   Fri, 19 Jun 2020 17:31:44 -0700
Message-ID: <CALvZod7ny6yVMj3Wy42gGy6NH=KdGbqoFStQ4am_PG2Fwo1fPA@mail.gmail.com>
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

On Fri, Jun 19, 2020 at 5:25 PM Roman Gushchin <guro@fb.com> wrote:
>
> On Fri, Jun 19, 2020 at 09:36:16AM -0700, Shakeel Butt wrote:
> > On Mon, Jun 8, 2020 at 4:07 PM Roman Gushchin <guro@fb.com> wrote:
> > >
> > > Allocate and release memory to store obj_cgroup pointers for each
> > > non-root slab page. Reuse page->mem_cgroup pointer to store a pointer
> > > to the allocated space.
> > >
> > > To distinguish between obj_cgroups and memcg pointers in case
> > > when it's not obvious which one is used (as in page_cgroup_ino()),
> > > let's always set the lowest bit in the obj_cgroup case.
> > >
> >
> > I think the commit message should talk about the potential overhead
> > (i.e an extra pointer for each object) along with the justifications
> > (i.e. less internal fragmentation and potentially more savings than
> > the overhead).
>
> How about adding the following chunk? I don't like forward links in
> commit messages, so maybe putting it into the cover letter?
>
> This commit temporarily increases the memory footprint of the kernel memory
> accounting. To store obj_cgroup pointers we'll need a place for an
> objcg_pointer for each allocated object. However, the following patches
> in the series will enable sharing of slab pages between memory cgroups,
> which will dramatically increase the total slab utilization. And the final
> memory footprint will be significantly smaller than before.
>

This looks good to me.

> >
> > > Signed-off-by: Roman Gushchin <guro@fb.com>
> > > Reviewed-by: Vlastimil Babka <vbabka@suse.cz>
> > > ---
> > >  include/linux/mm_types.h |  5 +++-
> > >  include/linux/slab_def.h |  6 +++++
> > >  include/linux/slub_def.h |  5 ++++
> > >  mm/memcontrol.c          | 17 +++++++++++---
> > >  mm/slab.h                | 49 ++++++++++++++++++++++++++++++++++++++++
> > >  5 files changed, 78 insertions(+), 4 deletions(-)
> > >
> > > diff --git a/include/linux/mm_types.h b/include/linux/mm_types.h
> > > index 64ede5f150dc..0277fbab7c93 100644
> > > --- a/include/linux/mm_types.h
> > > +++ b/include/linux/mm_types.h
> > > @@ -198,7 +198,10 @@ struct page {
> > >         atomic_t _refcount;
> > >
> > >  #ifdef CONFIG_MEMCG
> > > -       struct mem_cgroup *mem_cgroup;
> > > +       union {
> > > +               struct mem_cgroup *mem_cgroup;
> > > +               struct obj_cgroup **obj_cgroups;
> > > +       };
> > >  #endif
> > >
> > >         /*
> > > diff --git a/include/linux/slab_def.h b/include/linux/slab_def.h
> > > index abc7de77b988..ccda7b9669a5 100644
> > > --- a/include/linux/slab_def.h
> > > +++ b/include/linux/slab_def.h
> > > @@ -114,4 +114,10 @@ static inline unsigned int obj_to_index(const struct kmem_cache *cache,
> > >         return reciprocal_divide(offset, cache->reciprocal_buffer_size);
> > >  }
> > >
> > > +static inline int objs_per_slab_page(const struct kmem_cache *cache,
> > > +                                    const struct page *page)
> > > +{
> > > +       return cache->num;
> > > +}
> > > +
> > >  #endif /* _LINUX_SLAB_DEF_H */
> > > diff --git a/include/linux/slub_def.h b/include/linux/slub_def.h
> > > index 30e91c83d401..f87302dcfe8c 100644
> > > --- a/include/linux/slub_def.h
> > > +++ b/include/linux/slub_def.h
> > > @@ -198,4 +198,9 @@ static inline unsigned int obj_to_index(const struct kmem_cache *cache,
> > >         return __obj_to_index(cache, page_address(page), obj);
> > >  }
> > >
> > > +static inline int objs_per_slab_page(const struct kmem_cache *cache,
> > > +                                    const struct page *page)
> > > +{
> > > +       return page->objects;
> > > +}
> > >  #endif /* _LINUX_SLUB_DEF_H */
> > > diff --git a/mm/memcontrol.c b/mm/memcontrol.c
> > > index 7ff66275966c..2020c7542aa1 100644
> > > --- a/mm/memcontrol.c
> > > +++ b/mm/memcontrol.c
> > > @@ -569,10 +569,21 @@ ino_t page_cgroup_ino(struct page *page)
> > >         unsigned long ino = 0;
> > >
> > >         rcu_read_lock();
> > > -       if (PageSlab(page) && !PageTail(page))
> > > +       if (PageSlab(page) && !PageTail(page)) {
> > >                 memcg = memcg_from_slab_page(page);
> > > -       else
> > > -               memcg = READ_ONCE(page->mem_cgroup);
> > > +       } else {
> > > +               memcg = page->mem_cgroup;
> > > +
> > > +               /*
> > > +                * The lowest bit set means that memcg isn't a valid
> > > +                * memcg pointer, but a obj_cgroups pointer.
> > > +                * In this case the page is shared and doesn't belong
> > > +                * to any specific memory cgroup.
> > > +                */
> > > +               if ((unsigned long) memcg & 0x1UL)
> > > +                       memcg = NULL;
> > > +       }
> > > +
> > >         while (memcg && !(memcg->css.flags & CSS_ONLINE))
> > >                 memcg = parent_mem_cgroup(memcg);
> > >         if (memcg)
> > > diff --git a/mm/slab.h b/mm/slab.h
> > > index 8a574d9361c1..a1633ea15fbf 100644
> > > --- a/mm/slab.h
> > > +++ b/mm/slab.h
> > > @@ -319,6 +319,18 @@ static inline struct kmem_cache *memcg_root_cache(struct kmem_cache *s)
> > >         return s->memcg_params.root_cache;
> > >  }
> > >
> > > +static inline struct obj_cgroup **page_obj_cgroups(struct page *page)
> > > +{
> > > +       /*
> > > +        * page->mem_cgroup and page->obj_cgroups are sharing the same
> > > +        * space. To distinguish between them in case we don't know for sure
> > > +        * that the page is a slab page (e.g. page_cgroup_ino()), let's
> > > +        * always set the lowest bit of obj_cgroups.
> > > +        */
> > > +       return (struct obj_cgroup **)
> > > +               ((unsigned long)page->obj_cgroups & ~0x1UL);
> > > +}
> > > +
> > >  /*
> > >   * Expects a pointer to a slab page. Please note, that PageSlab() check
> > >   * isn't sufficient, as it returns true also for tail compound slab pages,
> > > @@ -406,6 +418,26 @@ static __always_inline void memcg_uncharge_slab(struct page *page, int order,
> > >         percpu_ref_put_many(&s->memcg_params.refcnt, nr_pages);
> > >  }
> > >
> > > +static inline int memcg_alloc_page_obj_cgroups(struct page *page,
> > > +                                              struct kmem_cache *s, gfp_t gfp)
> > > +{
> > > +       unsigned int objects = objs_per_slab_page(s, page);
> > > +       void *vec;
> > > +
> > > +       vec = kcalloc(objects, sizeof(struct obj_cgroup *), gfp);
> >
> > Should the above allocation be on the same node as the page?
>
> Yeah, it's a clever idea. The following patch should do the trick.
> Andrew, can you, please, squash this in?
>
> Thank you!
>
>

Reviewed-by: Shakeel Butt <shakeelb@google.com>

> diff --git a/mm/slab.h b/mm/slab.h
> index 0a31600a0f5c..2a036eefbd7e 100644
> --- a/mm/slab.h
> +++ b/mm/slab.h
> @@ -233,7 +233,8 @@ static inline int memcg_alloc_page_obj_cgroups(struct page *page,
>         unsigned int objects = objs_per_slab_page(s, page);
>         void *vec;
>
> -       vec = kcalloc(objects, sizeof(struct obj_cgroup *), gfp);
> +       vec = kcalloc_node(objects, sizeof(struct obj_cgroup *), gfp,
> +                          page_to_nid(page));
>         if (!vec)
>                 return -ENOMEM;
>
