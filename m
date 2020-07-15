Return-Path: <SRS0=kup7=A2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.0 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5B619C433E0
	for <linux-kernel@archiver.kernel.org>; Wed, 15 Jul 2020 15:14:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3028D20658
	for <linux-kernel@archiver.kernel.org>; Wed, 15 Jul 2020 15:14:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=bytedance-com.20150623.gappssmtp.com header.i=@bytedance-com.20150623.gappssmtp.com header.b="lXIVAkey"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726633AbgGOPN7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 15 Jul 2020 11:13:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58332 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725932AbgGOPN7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Jul 2020 11:13:59 -0400
Received: from mail-pf1-x442.google.com (mail-pf1-x442.google.com [IPv6:2607:f8b0:4864:20::442])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 16F52C061755
        for <linux-kernel@vger.kernel.org>; Wed, 15 Jul 2020 08:13:59 -0700 (PDT)
Received: by mail-pf1-x442.google.com with SMTP id m9so2235729pfh.0
        for <linux-kernel@vger.kernel.org>; Wed, 15 Jul 2020 08:13:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=0r5bb0ZMWMeJxc6MpJgS1kjFqz/n/TBIUkKDAK8VCUM=;
        b=lXIVAkeyGU3/B9G+hN1tCKgp85EQHsHi8oOUtcSkVV9Z0LcFVkKyWbelTBYEI6TU1m
         bhOBvmTOrlemvaEshedkWQ9SfdcZGA//kuKxWWiJIKG0uQw0Ijfi/LZoVEGx1aK0Sj+d
         Sy8cyeK/K0QL9vQatJhzlSw4YxH4SIDq91ibsAZyc9BI3s8dzw7ubsByrvKmSmjnr2Uj
         710q8G5KWB+2mFkHJ1dNQISBcekeHsukednXGe8l9KZnul1rnJJ92TXao6hLiGtAQeBE
         Zx+K5CPbG3lgsoY4TTkXF2tM7tsNqwcmjtw2n1+0yift8fEdwoqGsZXooTiShVTbH4ft
         CCXg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=0r5bb0ZMWMeJxc6MpJgS1kjFqz/n/TBIUkKDAK8VCUM=;
        b=Cx/NgD0Yn3uqgrnoeqWRvMibqd7Itlow1QlKigjvBc6oSc6Hx3SiPobOXfi0JX+eoG
         C/JnE5C+9qRokJBM3XoC/gbqdsogei3stIVFCuj4l5fdUYr9qDey5yVLXtVg/B3AHwJw
         6/7XUkasEzc7OW7GVtA3DGCUXZm2Q8+nk00xexWJQgfu2jeVGy+zrJai32S7j1AB8+Dz
         RxggvORGcn8bVN5fq+9Q+1S3ttDxyRTR06uV2/8EFf0hPfa+IQ4nFD3nuv82nJRQOCLk
         pybv5hGeqjOzhX5BOCsFB0PH8W+4pt9z/JRUWSOJAp4AK1Br2ZJ4BiZXJp5NeH40IlHm
         gRiA==
X-Gm-Message-State: AOAM533Ho+kPWZYt69+U0lHdmvuIaLr+oUQMwU1htuErY1jS3tBbLWcH
        xzB48oE4iHf6mw1745mbJSGVRQ1fF8pC20B9UQsOGQ==
X-Google-Smtp-Source: ABdhPJwaqBwFm70w6USx9FK6Q52mOCQdGHjx14sdVsxuDJX8FDJYRZUjwKajpLIuZPmZUIxALRCJQ+Ps3mhkf19NyDA=
X-Received: by 2002:aa7:858c:: with SMTP id w12mr9910141pfn.143.1594826038426;
 Wed, 15 Jul 2020 08:13:58 -0700 (PDT)
MIME-Version: 1.0
References: <20200707062754.8383-1-songmuchun@bytedance.com> <3d06418e-e75c-e7b8-91cd-ba56283045be@suse.cz>
In-Reply-To: <3d06418e-e75c-e7b8-91cd-ba56283045be@suse.cz>
From:   Muchun Song <songmuchun@bytedance.com>
Date:   Wed, 15 Jul 2020 23:13:22 +0800
Message-ID: <CAMZfGtXK9yQOJy7BPnTBzhG4tithRs=9R4O3rDg1Rjz0zUFKnQ@mail.gmail.com>
Subject: Re: [External] Re: [PATCH v5.4.y, v4.19.y] mm: memcg/slab: fix memory
 leak at non-root kmem_cache destroy
To:     Vlastimil Babka <vbabka@suse.cz>
Cc:     Christoph Lameter <cl@linux.com>,
        Pekka Enberg <penberg@kernel.org>,
        David Rientjes <rientjes@google.com>,
        Joonsoo Kim <iamjoonsoo.kim@lge.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Linux Memory Management List <linux-mm@kvack.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Shakeel Butt <shakeelb@google.com>,
        Roman Gushchin <guro@fb.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jul 15, 2020 at 7:32 PM Vlastimil Babka <vbabka@suse.cz> wrote:
>
> On 7/7/20 8:27 AM, Muchun Song wrote:
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
> >      A. It leads to create a non-root kmem_cache for allocating.
> >   5) When destroy the memory cgroup created in the step 4), the
> >      non-root kmem_cache can never be destroyed.
> >
> > If we repeat steps 4) and 5), this will cause a lot of memory leak.
> > So only when refcount reach zero, we mark the root kmem_cache as dying.
> >
> > Fixes: 92ee383f6daa ("mm: fix race between kmem_cache destroy, create and deactivate")
> > Signed-off-by: Muchun Song <songmuchun@bytedance.com>
>
> CC Roman, who worked in this area recently.
>
> Also why is this marked "[PATCH v5.4.y, v4.19.y]"? Has it been fixed otherwise
> in 5.5+ ?

Because the memcg slab/slub is reworked by Roman since v5.8.
Therefore, this problem exists in v5.7 and below.

>
> > ---
> >  mm/slab_common.c | 43 +++++++++++++++++++++++++++++++++++++++++--
> >  1 file changed, 41 insertions(+), 2 deletions(-)
> >
> > diff --git a/mm/slab_common.c b/mm/slab_common.c
> > index 8c1ffbf7de45..83ee6211aec7 100644
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
> > @@ -944,8 +961,6 @@ void kmem_cache_destroy(struct kmem_cache *s)
> >       if (unlikely(!s))
> >               return;
> >
> > -     flush_memcg_workqueue(s);
> > -
> >       get_online_cpus();
> >       get_online_mems();
> >
> > @@ -955,6 +970,30 @@ void kmem_cache_destroy(struct kmem_cache *s)
> >       if (s->refcount)
> >               goto out_unlock;
> >
> > +#ifdef CONFIG_MEMCG_KMEM
> > +     mutex_unlock(&slab_mutex);
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
> > +              * Reset the dying flag setted by flush_memcg_workqueue().
> > +              */
> > +             s->memcg_params.dying = false;
> > +             goto out_unlock;
> > +     }
> > +#endif
> > +
> >       err = shutdown_memcg_caches(s);
> >       if (!err)
> >               err = shutdown_cache(s);
> >
>


--
Yours,
Muchun
