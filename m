Return-Path: <SRS0=y5Sx=A3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.0 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 86CA2C433E1
	for <linux-kernel@archiver.kernel.org>; Thu, 16 Jul 2020 05:07:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 59A30207CB
	for <linux-kernel@archiver.kernel.org>; Thu, 16 Jul 2020 05:07:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=bytedance-com.20150623.gappssmtp.com header.i=@bytedance-com.20150623.gappssmtp.com header.b="fofvAXsj"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726250AbgGPFHk (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 16 Jul 2020 01:07:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45548 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725270AbgGPFHj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Jul 2020 01:07:39 -0400
Received: from mail-pf1-x441.google.com (mail-pf1-x441.google.com [IPv6:2607:f8b0:4864:20::441])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 238E8C061755
        for <linux-kernel@vger.kernel.org>; Wed, 15 Jul 2020 22:07:39 -0700 (PDT)
Received: by mail-pf1-x441.google.com with SMTP id t11so3107127pfq.11
        for <linux-kernel@vger.kernel.org>; Wed, 15 Jul 2020 22:07:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=8GPivwJ3BvzDVNFEnSW4lmc85cPmf6b72cN22hvZUYk=;
        b=fofvAXsjAQeDG+tGF0nWDpJ3Gj6goapWN+E7Gy+l3IoNgEbJR0JUeJFF+9/Y4sZpam
         taEOX6sCWYT0WDpQB8F/bQx/7RqHJJD/Xx7paqdJ8WWWfTfFs6RWDyyimYBGhMGl/ELD
         rDsXc/6kMXV9V+t9OrxyC/oM2O94xcXTPDN2EjNeKBaVuCDi7RseROfUladUkm7CNZvZ
         P1ntDEDQsItY9+nfhDbyBfq7tvyWxWVwC139tcgQpGVTv+jlNNz+5w38GHXiNZhOTtT7
         K3JvTXqiUL1Y9sqtgBQ+q3neDGd4TsNrZW2N7UGUCvEvBIYEcOTCyA2ycKm9Gt+CxeSA
         4jNg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=8GPivwJ3BvzDVNFEnSW4lmc85cPmf6b72cN22hvZUYk=;
        b=Cp4KQ53qb8lk/Tc20Lqa955Ox31Jnss2s/PFJjLSF4DZlnGmZeQdyS+yx0J5n6Sm5C
         UfgWj+p9WE22dQQFJis+iQE2jncm8Lkq196bBUNr1TeSq1ZKM4G01HLWnLcgmJw+d4oj
         vlE9sXdPzzPUup5KnwGQuRJn5dAspg78pG6ipvOXhNlMhskDaIrAXaG2whfCjuudzGX/
         gTwmqQ1e0OWN7f97AyRhOQDb2H5+gNX6gMLjt6ZqTCc+yaa4bRZdj4jH6aRSqNDxzZWN
         hVluyUMUnCqoqNtQqdk05JZ05VVsyHhniIKycmB5qmGztFo5TfrRdOKyOA7j/PbIY2Go
         HSVw==
X-Gm-Message-State: AOAM533Ve1fxsnQucsoVYc8jhE5JwgoUC+0S4Of78ewPj4bdXEgKEgP0
        KaWWkU/OhuhWdTFup4XWlx5+TTB0PFdkUEiNEoDTYg==
X-Google-Smtp-Source: ABdhPJwvnpGWMdtVF8Udox521YHvT9x3AKHlaInlUppR3KCkZddhzJZ7+477lg+SIVVyEnhT2NX82oNegMHlFHLxvqA=
X-Received: by 2002:aa7:8f03:: with SMTP id x3mr2118981pfr.64.1594876058227;
 Wed, 15 Jul 2020 22:07:38 -0700 (PDT)
MIME-Version: 1.0
References: <20200715165023.29919-1-songmuchun@bytedance.com> <20200715175432.GA6314@carbon.lan>
In-Reply-To: <20200715175432.GA6314@carbon.lan>
From:   Muchun Song <songmuchun@bytedance.com>
Date:   Thu, 16 Jul 2020 13:07:02 +0800
Message-ID: <CAMZfGtVupfg+WiXBvTsnXTZ=bgHxaztEFP1cQ8hnCfXmCUV=gw@mail.gmail.com>
Subject: Re: [External] Re: [PATCH v2] mm: memcg/slab: fix memory leak at
 non-root kmem_cache destroy
To:     Roman Gushchin <guro@fb.com>
Cc:     Vlastimil Babka <vbabka@suse.cz>, Christoph Lameter <cl@linux.com>,
        Pekka Enberg <penberg@kernel.org>,
        David Rientjes <rientjes@google.com>,
        Joonsoo Kim <iamjoonsoo.kim@lge.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Shakeel Butt <shakeelb@google.com>,
        Linux Memory Management List <linux-mm@kvack.org>,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jul 16, 2020 at 1:54 AM Roman Gushchin <guro@fb.com> wrote:
>
> On Thu, Jul 16, 2020 at 12:50:22AM +0800, Muchun Song wrote:
> > If the kmem_cache refcount is greater than one, we should not
> > mark the root kmem_cache as dying. If we mark the root kmem_cache
> > dying incorrectly, the non-root kmem_cache can never be destroyed.
> > It resulted in memory leak when memcg was destroyed. We can use the
> > following steps to reproduce.
> >
> >   1) Use kmem_cache_create() to create a new kmem_cache named A.
> >   2) Coincidentally, the kmem_cache A is an alias for kmem_cache B,
> >      so the refcount of B is just increased.
> >   3) Use kmem_cache_destroy() to destroy the kmem_cache A, just
> >      decrease the B's refcount but mark the B as dying.
> >   4) Create a new memory cgroup and alloc memory from the kmem_cache
> >      B. It leads to create a non-root kmem_cache for allocating memory.
> >   5) When destroy the memory cgroup created in the step 4), the
> >      non-root kmem_cache can never be destroyed.
> >
> > If we repeat steps 4) and 5), this will cause a lot of memory leak.
> > So only when refcount reach zero, we mark the root kmem_cache as dying.
> >
> > Fixes: 92ee383f6daa ("mm: fix race between kmem_cache destroy, create and deactivate")
> > Signed-off-by: Muchun Song <songmuchun@bytedance.com>
> > Reviewed-by: Shakeel Butt <shakeelb@google.com>
> > ---
> >
> > changelog in v2:
> >  1) Fix a confusing typo in the commit log.
>
> Ok, now I see the problem. Thank you for fixing the commit log!
>
> >  2) Remove flush_memcg_workqueue() for !CONFIG_MEMCG_KMEM.
> >  3) Introduce a new helper memcg_set_kmem_cache_dying() to fix a race
> >     condition between flush_memcg_workqueue() and slab_unmergeable().
> >
> >  mm/slab_common.c | 54 +++++++++++++++++++++++++++++++++++++++++++++++-------
> >  1 file changed, 47 insertions(+), 7 deletions(-)
> >
> > diff --git a/mm/slab_common.c b/mm/slab_common.c
> > index 8c1ffbf7de45..c4958116e3fd 100644
> > --- a/mm/slab_common.c
> > +++ b/mm/slab_common.c
> > @@ -258,6 +258,11 @@ static void memcg_unlink_cache(struct kmem_cache *s)
> >               list_del(&s->memcg_params.kmem_caches_node);
> >       }
> >  }
> > +
> > +static inline bool memcg_kmem_cache_dying(struct kmem_cache *s)
> > +{
> > +     return is_root_cache(s) && s->memcg_params.dying;
> > +}
> >  #else
> >  static inline int init_memcg_params(struct kmem_cache *s,
> >                                   struct kmem_cache *root_cache)
> > @@ -272,6 +277,11 @@ static inline void destroy_memcg_params(struct kmem_cache *s)
> >  static inline void memcg_unlink_cache(struct kmem_cache *s)
> >  {
> >  }
> > +
> > +static inline bool memcg_kmem_cache_dying(struct kmem_cache *s)
> > +{
> > +     return false;
> > +}
> >  #endif /* CONFIG_MEMCG_KMEM */
> >
> >  /*
> > @@ -326,6 +336,13 @@ int slab_unmergeable(struct kmem_cache *s)
> >       if (s->refcount < 0)
> >               return 1;
> >
> > +     /*
> > +      * If the kmem_cache is dying. We should also skip this
> > +      * kmem_cache.
> > +      */
> > +     if (memcg_kmem_cache_dying(s))
> > +             return 1;
> > +
> >       return 0;
> >  }
> >
> > @@ -886,12 +903,15 @@ static int shutdown_memcg_caches(struct kmem_cache *s)
> >       return 0;
> >  }
> >
> > -static void flush_memcg_workqueue(struct kmem_cache *s)
> > +static void memcg_set_kmem_cache_dying(struct kmem_cache *s)
> >  {
> >       spin_lock_irq(&memcg_kmem_wq_lock);
> >       s->memcg_params.dying = true;
> >       spin_unlock_irq(&memcg_kmem_wq_lock);
> > +}
> >
> > +static void flush_memcg_workqueue(struct kmem_cache *s)
> > +{
> >       /*
> >        * SLAB and SLUB deactivate the kmem_caches through call_rcu. Make
> >        * sure all registered rcu callbacks have been invoked.
> > @@ -923,10 +943,6 @@ static inline int shutdown_memcg_caches(struct kmem_cache *s)
> >  {
> >       return 0;
> >  }
> > -
> > -static inline void flush_memcg_workqueue(struct kmem_cache *s)
> > -{
> > -}
> >  #endif /* CONFIG_MEMCG_KMEM */
> >
> >  void slab_kmem_cache_release(struct kmem_cache *s)
> > @@ -944,8 +960,6 @@ void kmem_cache_destroy(struct kmem_cache *s)
> >       if (unlikely(!s))
> >               return;
> >
> > -     flush_memcg_workqueue(s);
> > -
> >       get_online_cpus();
> >       get_online_mems();
> >
> > @@ -955,6 +969,32 @@ void kmem_cache_destroy(struct kmem_cache *s)
> >       if (s->refcount)
> >               goto out_unlock;
> >
> > +#ifdef CONFIG_MEMCG_KMEM
> > +     memcg_set_kmem_cache_dying(s);
> > +
> > +     mutex_unlock(&slab_mutex);
>
> Hm, but in theory s->refcount can be increased here?

I have tried my best to read all the codes that operate on s->refcount.
There is only one place which increases the s->refcount, it is the
__kmem_cache_alias(). If the kmem cache is dying, the slab_unmergeable()
can never return true for the dying kmem cache because it is the same slab_mutex
protection, so I think that there is not a problem, right?

> So it doesn't solve the problem completely, but makes it less probable, right?
>
> I wonder if it's possible to (additionally) protect s->refcount with a
> memcg_kmem_wq_lock, so that we can check it in the context of flush_memcg_workqueue()?
>
> > +
> > +     put_online_mems();
> > +     put_online_cpus();
> > +
> > +     flush_memcg_workqueue(s);
> > +
> > +     get_online_cpus();
> > +     get_online_mems();
> > +
> > +     mutex_lock(&slab_mutex);
> > +
> > +     if (WARN(s->refcount,
> > +              "kmem_cache_destroy %s: Slab cache is still referenced\n",
> > +              s->name)) {
> > +             /*
> > +              * Reset the dying flag setted by memcg_set_kmem_cache_dying().
> > +              */
> > +             s->memcg_params.dying = false;
> > +             goto out_unlock;
> > +     }
> > +#endif
> > +
> >       err = shutdown_memcg_caches(s);
> >       if (!err)
> >               err = shutdown_cache(s);
> > --
> > 2.11.0
> >
>
> Other than the problem above your patch looks really good to me, however we should
> be really careful here, as it should in theory be back-ported to a big number
> of old stable kernels. And because it's (hopefully) fixed in 5.9, it's a backport-only
> patch.
>
> So I wonder if we can mitigate the problem by disabling cache sharing for some
> specific kmem_caches instead? Like for all with SLAB_ACCOUNT and maybe for all except
> a hard-coded list (if kmem accounting is enabled). Do you mind sharing any details
> on how this problem reveals itself in the real life?

One day I debug another problem, coincidentally I executed the
following command:

     cat /sys/kernel/debug/memcg_slabinfo | grep deact

And I found an interesting thing, a lot of non-root kmem_cache's
active_objs is zero.
But why are they not destroyed? So I launched a detailed
investigation. Finally I found
out that the reason is that we mark the root kmem_cache as dying
incorrectly. I have
applied this patch on our server for several weeks. And this problem
has disappeared.

>
> Thanks!
>
> PS I'm off the keyboard for the rest of today, will think more and hopefully
> come back with some ideas tomorrow.
>
>


-- 
Yours,
Muchun
