Return-Path: <SRS0=PJcK=74=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.7 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EA520C433DF
	for <linux-kernel@archiver.kernel.org>; Mon, 15 Jun 2020 13:34:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C054F207FF
	for <linux-kernel@archiver.kernel.org>; Mon, 15 Jun 2020 13:34:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=bytedance-com.20150623.gappssmtp.com header.i=@bytedance-com.20150623.gappssmtp.com header.b="UujOtmFH"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730643AbgFONeI (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 15 Jun 2020 09:34:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57498 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730558AbgFONd2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 Jun 2020 09:33:28 -0400
Received: from mail-io1-xd43.google.com (mail-io1-xd43.google.com [IPv6:2607:f8b0:4864:20::d43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 73DC0C061A0E
        for <linux-kernel@vger.kernel.org>; Mon, 15 Jun 2020 06:33:27 -0700 (PDT)
Received: by mail-io1-xd43.google.com with SMTP id p20so17757317iop.11
        for <linux-kernel@vger.kernel.org>; Mon, 15 Jun 2020 06:33:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=FEO6ZMRZMhytUnB/3kKw+6H6ed4rrtyosV/mkpSqtDg=;
        b=UujOtmFHkrJ4Wz5fD7nsyCt9oFWmofoQEfArpljrCQ5l62sYWxbBdoU/sk3BLuLTqj
         dTG9GWz9M3dO7c/1cqC/Jl13duq3VAELZb+vXrjVTxd/y9b8nVcOtYzZvuoBtR7zdNCx
         0VhCgEeJtSIl9H0QWkpu+UYQQOqsm2oib1BjLC2UAqUkBwY1w27AahTzHo+p0o6pgJwI
         udReEzsSGRV4UuZCrDebvahaKMiXTjp7cgJuQezwtRLZIJgRGlZEK0yWnDa6pyOc9udn
         w4YV4Jnr1xnrIvwZnD+eDrdVFnZzROHIsd+Jp9yRJm4e75YtJavyzQtWr05IbGOo3TG4
         KfFQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=FEO6ZMRZMhytUnB/3kKw+6H6ed4rrtyosV/mkpSqtDg=;
        b=hLrDK326qIbhjkH9oHxBY4lWoj4XmsAwbj5eT7LL1cHEkQO62ADAo+kIkIefD33AGk
         KTcKV1CSoq8j8I8oqQJkuc7yYujWMUHeXymClRlQJfbI0pdIbaAF6AziahkejjPD1lmz
         wzxV/L2I0zNGryb2SEYAgoW6SlbCq5v6oXT9OmhwXy/VRkM+56Bh4WALMJzVPtpPfIbC
         a+CI4JXXoM0SXh4XAvhM6wwzJyGrd12L8PA5V/UOGlCpJjnVViaml+l28vGsd3xsXaqX
         Q40RTlWrqAKuMLTLA/JTzkllcB6fgaEzRpkNWWNsKuMqaSqCZW4kojmohdZT0Zg1l7oN
         odnw==
X-Gm-Message-State: AOAM532JY8BiTKdqbci4t6QyjzQ6nkAqjA2MEPdAafgGi+mC6Ad4WWiQ
        bjkJ2YZM1lFZfiCuP3G5k2nlt5olgTq9skb0I0aIzjFFSkW8aw==
X-Google-Smtp-Source: ABdhPJw56Zkkow3PhuxcwrXHY5xd13bZ/RAR2ZkJa4qiLDA32ubAJD0lYBCg3c8BFLedeuKUf7vI7NH2UCEyxJbgvWo=
X-Received: by 2002:a02:a805:: with SMTP id f5mr22297740jaj.130.1592228006713;
 Mon, 15 Jun 2020 06:33:26 -0700 (PDT)
MIME-Version: 1.0
References: <20200614063858.85118-1-songmuchun@bytedance.com> <bca5f44c-5e30-17b1-09fc-6330d450433b@suse.cz>
In-Reply-To: <bca5f44c-5e30-17b1-09fc-6330d450433b@suse.cz>
From:   Muchun Song <songmuchun@bytedance.com>
Date:   Mon, 15 Jun 2020 21:32:50 +0800
Message-ID: <CAMZfGtUeUyi5Tg0hv3j=-scFGiZJB5hQs8v5nOfYQ7xXsB2nsQ@mail.gmail.com>
Subject: Re: [External] Re: [PATCH] mm/slab: Add a __GFP_ACCOUNT GFP flag
 check for slab allocation
To:     Vlastimil Babka <vbabka@suse.cz>
Cc:     cl@linux.com, penberg@kernel.org, rientjes@google.com,
        iamjoonsoo.kim@lge.com, Andrew Morton <akpm@linux-foundation.org>,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        Roman Gushchin <guro@fb.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jun 15, 2020 at 9:08 PM Vlastimil Babka <vbabka@suse.cz> wrote:
>
> On 6/14/20 8:38 AM, Muchun Song wrote:
> > When a kmem_cache is initialized with SLAB_ACCOUNT slab flag, we must
> > not call kmem_cache_alloc with __GFP_ACCOUNT GFP flag. In this case,
> > we can be accounted to kmemcg twice. This is not correct. So we add a
>
> Are you sure? How does that happen?
>
> The only place I see these evaluated is this condition in slab_pre_alloc_hook():
>
>         if (memcg_kmem_enabled() &&
>             ((flags & __GFP_ACCOUNT) || (s->flags & SLAB_ACCOUNT)))
>                 return memcg_kmem_get_cache(s);
>
> And it doesn't matter if one or both are set? Am I missing something?
>
> > __GFP_ACCOUNT GFP flag check for slab allocation.
> >
> > We also introduce a new helper named fixup_gfp_flags to do that check.
> > We can reuse the fixup_gfp_flags for SLAB/SLUB.
> >
> > Signed-off-by: Muchun Song <songmuchun@bytedance.com>
> > ---
> >  mm/slab.c | 10 +---------
> >  mm/slab.h | 21 +++++++++++++++++++++
> >  mm/slub.c | 10 +---------
> >  3 files changed, 23 insertions(+), 18 deletions(-)
> >
> > diff --git a/mm/slab.c b/mm/slab.c
> > index 9350062ffc1a..6e0110bef2d6 100644
> > --- a/mm/slab.c
> > +++ b/mm/slab.c
> > @@ -126,8 +126,6 @@
> >
> >  #include <trace/events/kmem.h>
> >
> > -#include     "internal.h"
> > -
> >  #include     "slab.h"
> >
> >  /*
> > @@ -2579,13 +2577,7 @@ static struct page *cache_grow_begin(struct kmem_cache *cachep,
> >        * Be lazy and only check for valid flags here,  keeping it out of the
> >        * critical path in kmem_cache_alloc().
> >        */
> > -     if (unlikely(flags & GFP_SLAB_BUG_MASK)) {
> > -             gfp_t invalid_mask = flags & GFP_SLAB_BUG_MASK;
> > -             flags &= ~GFP_SLAB_BUG_MASK;
> > -             pr_warn("Unexpected gfp: %#x (%pGg). Fixing up to gfp: %#x (%pGg). Fix your code!\n",
> > -                             invalid_mask, &invalid_mask, flags, &flags);
> > -             dump_stack();
> > -     }
> > +     flags = fixup_gfp_flags(cachep, flags);
> >       WARN_ON_ONCE(cachep->ctor && (flags & __GFP_ZERO));
> >       local_flags = flags & (GFP_CONSTRAINT_MASK|GFP_RECLAIM_MASK);
> >
> > diff --git a/mm/slab.h b/mm/slab.h
> > index 815e4e9a94cd..0b91f2a7b033 100644
> > --- a/mm/slab.h
> > +++ b/mm/slab.h
> > @@ -109,6 +109,7 @@ struct memcg_cache_params {
> >  #include <linux/kmemleak.h>
> >  #include <linux/random.h>
> >  #include <linux/sched/mm.h>
> > +#include "internal.h"
> >
> >  /*
> >   * State of the slab allocator.
> > @@ -627,6 +628,26 @@ struct kmem_cache_node {
> >
> >  };
> >
> > +static inline gfp_t fixup_gfp_flags(struct kmem_cache *s, gfp_t flags)
> > +{
> > +     gfp_t invalid_mask = 0;
> > +
> > +     if (unlikely(flags & GFP_SLAB_BUG_MASK))
> > +             invalid_mask |= flags & GFP_SLAB_BUG_MASK;
> > +
> > +     if (unlikely(flags & __GFP_ACCOUNT && s->flags & SLAB_ACCOUNT))
> > +             invalid_mask |= __GFP_ACCOUNT;
> > +
> > +     if (unlikely(invalid_mask)) {
> > +             flags &= ~invalid_mask;
> > +             pr_warn("Unexpected gfp: %#x (%pGg). Fixing up to gfp: %#x (%pGg). Fix your code!\n",
> > +                             invalid_mask, &invalid_mask, flags, &flags);
> > +             dump_stack();
> > +     }
> > +
> > +     return flags;
> > +}
> > +
> >  static inline struct kmem_cache_node *get_node(struct kmem_cache *s, int node)
> >  {
> >       return s->node[node];
> > diff --git a/mm/slub.c b/mm/slub.c
> > index b8f798b50d44..49b5cb7da318 100644
> > --- a/mm/slub.c
> > +++ b/mm/slub.c
> > @@ -37,8 +37,6 @@
> >
> >  #include <trace/events/kmem.h>
> >
> > -#include "internal.h"
> > -
> >  /*
> >   * Lock order:
> >   *   1. slab_mutex (Global Mutex)
> > @@ -1745,13 +1743,7 @@ static struct page *allocate_slab(struct kmem_cache *s, gfp_t flags, int node)
> >
> >  static struct page *new_slab(struct kmem_cache *s, gfp_t flags, int node)
> >  {
> > -     if (unlikely(flags & GFP_SLAB_BUG_MASK)) {
> > -             gfp_t invalid_mask = flags & GFP_SLAB_BUG_MASK;
> > -             flags &= ~GFP_SLAB_BUG_MASK;
> > -             pr_warn("Unexpected gfp: %#x (%pGg). Fixing up to gfp: %#x (%pGg). Fix your code!\n",
> > -                             invalid_mask, &invalid_mask, flags, &flags);
> > -             dump_stack();
> > -     }
> > +     flags = fixup_gfp_flags(s, flags);
> >
> >       return allocate_slab(s,
> >               flags & (GFP_RECLAIM_MASK | GFP_CONSTRAINT_MASK), node);
> >
>

Yeah, you are right. I'm very sorry that I was not thoughtful before.
Please ignore
this patch. Thanks!


-- 
Yours,
Muchun
