Return-Path: <SRS0=kup7=A2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.0 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EEA2BC433E0
	for <linux-kernel@archiver.kernel.org>; Wed, 15 Jul 2020 15:28:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id BC97320663
	for <linux-kernel@archiver.kernel.org>; Wed, 15 Jul 2020 15:28:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=bytedance-com.20150623.gappssmtp.com header.i=@bytedance-com.20150623.gappssmtp.com header.b="DwcwzyBk"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726766AbgGOP2s (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 15 Jul 2020 11:28:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60642 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725770AbgGOP2r (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Jul 2020 11:28:47 -0400
Received: from mail-pl1-x642.google.com (mail-pl1-x642.google.com [IPv6:2607:f8b0:4864:20::642])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C97CEC061755
        for <linux-kernel@vger.kernel.org>; Wed, 15 Jul 2020 08:28:47 -0700 (PDT)
Received: by mail-pl1-x642.google.com with SMTP id b9so2531769plx.6
        for <linux-kernel@vger.kernel.org>; Wed, 15 Jul 2020 08:28:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=yg6NTbSkGtSEF4rrYCXrVAXjXqS7dlpNJawysR5Obt4=;
        b=DwcwzyBkeoGAVivAhQIX1ILJZAxzWHTRHzq3hDK4Qct5A+85N306PVgPU5TI6sH4p4
         RtyGFzG2R6Be01CKNJYrfPZtNBBKBfm6m1ePOfDM2q2mcARomxu4KqDiPGvNu0NobTEQ
         q9TOOuTzjdJRVR/MQfHeyKMkIAT6m2R96v3Lb16YObODRKQq3nq8O2wL8bqaR0Nv6bN7
         E4Ka3VtU4XiZSARo9NI77LC52iu5fIcCgwo9d/Qyw+vPSiRZnfS/iBwS9jXQwOXuvWj5
         Ny3TWLMHxGi4WUokqI8hPmYhT1AwcTo52U8eNamM6+ZhdrKWBJhruGdBGa69NxabCMAP
         DlwQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=yg6NTbSkGtSEF4rrYCXrVAXjXqS7dlpNJawysR5Obt4=;
        b=AH2m7bbVxe5WYSct/I6Lprpo1k8ag0qoVOWb13MdlsgpHFtMPz7r5H6osseDeH4XdX
         fsLOe26tWJ13wVHM5bJr1lkVkQnlJtVBKaTBCDyZXQncAdx91sUoYhDOL5c+ZXGDnMuw
         glMQd/QAIIgsdxzXL8iBqexDvbqnqk3v5b4kBTO/5MTIRE+xQrW/9Qrl2akrZMDQGJrT
         eIzE5HqLgYzz8ST5TvgWihn2DswXlHoWGCLyH5nnal6bEHBh/u1Qdc220UNdOnNGUU1D
         CsgKNXqwG190O7ecxFLVrt5T3cbaT0lKVQ/5p9P/9YroD4kkVZyCCG9+kxrCc+Ri4lUa
         bOeA==
X-Gm-Message-State: AOAM532fGTQV5ofglABEvnfre1H2wq6HM3sVb432G/60g5GlYTZrrJPT
        zs5IKFiFGipyqA1X+q6LHdE7kNyF4wW8Lh0n7v03yw==
X-Google-Smtp-Source: ABdhPJzOId+r2GHh+iy3UX+vzodA8HqQiE7YfGpNGY3GDVnFlCAkVKSS1N/bVbhlDqE77Ph6vB/UW5Wxa6+kogN0LFk=
X-Received: by 2002:a17:90a:20e9:: with SMTP id f96mr171461pjg.13.1594826927168;
 Wed, 15 Jul 2020 08:28:47 -0700 (PDT)
MIME-Version: 1.0
References: <20200707062754.8383-1-songmuchun@bytedance.com> <CALvZod7E7zcEY-rr20wzE6b+EGVNdrnfrBW7F-nKR8dNh-=h1w@mail.gmail.com>
In-Reply-To: <CALvZod7E7zcEY-rr20wzE6b+EGVNdrnfrBW7F-nKR8dNh-=h1w@mail.gmail.com>
From:   Muchun Song <songmuchun@bytedance.com>
Date:   Wed, 15 Jul 2020 23:28:11 +0800
Message-ID: <CAMZfGtUjVzxpuLpBzhgZtoTQ7mJSNU=FgHHDtD+Zx7kgFo7NaA@mail.gmail.com>
Subject: Re: [External] Re: [PATCH v5.4.y, v4.19.y] mm: memcg/slab: fix memory
 leak at non-root kmem_cache destroy
To:     Shakeel Butt <shakeelb@google.com>
Cc:     Christoph Lameter <cl@linux.com>,
        Pekka Enberg <penberg@kernel.org>,
        David Rientjes <rientjes@google.com>,
        Joonsoo Kim <iamjoonsoo.kim@lge.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Linux MM <linux-mm@kvack.org>,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jul 15, 2020 at 11:21 PM Shakeel Butt <shakeelb@google.com> wrote:
>
> Sorry I missed this email.
>
>
> On Mon, Jul 6, 2020 at 11:28 PM Muchun Song <songmuchun@bytedance.com> wrote:
> >
> > If the kmem_cache refcount is greater than one, we should not
> > mark the root kmem_cache as dying. If we mark the root kmem_cache
> > dying incorrectly, the non-root kmem_cache can never be destroyed.
> > It resulted in memory leak when memcg was destroyed. We can use the
> > following steps to reproduce.
> >
> >   1) Use kmem_cache_create() to create a new kmem_cache named A.
> >   2) Coincidentally, the kmem_cache A is an alias for kmem_cache B,
> >      so the refcount of B is just increased.
>
> I definitely missed the alias kmem cache case.
>
> >   3) Use kmem_cache_destroy() to destroy the kmem_cache A, just
> >      decrease the B's refcount but mark the B as dying.
> >   4) Create a new memory cgroup and alloc memory from the kmem_cache
> >      A. It leads to create a non-root kmem_cache for allocating.
>
> I think in (4) you meant alloc memory from kmem_cache B instead of A.
> There should not be any allocation from A after kmem_cache_destroy()
> in (3).

Yeah, here is a typo. I will fix it in the next version patch.

>
> >   5) When destroy the memory cgroup created in the step 4), the
> >      non-root kmem_cache can never be destroyed.
> >
> > If we repeat steps 4) and 5), this will cause a lot of memory leak.
> > So only when refcount reach zero, we mark the root kmem_cache as dying.
> >
> > Fixes: 92ee383f6daa ("mm: fix race between kmem_cache destroy, create and deactivate")
> > Signed-off-by: Muchun Song <songmuchun@bytedance.com>
>
> The patch looks fine.
>
> Reviewed-by: Shakeel Butt <shakeelb@google.com>
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
> >                 list_del(&s->memcg_params.kmem_caches_node);
> >         }
> >  }
> > +
> > +static inline bool memcg_kmem_cache_dying(struct kmem_cache *s)
> > +{
> > +       return is_root_cache(s) && s->memcg_params.dying;
> > +}
> >  #else
> >  static inline int init_memcg_params(struct kmem_cache *s,
> >                                     struct kmem_cache *root_cache)
> > @@ -272,6 +277,11 @@ static inline void destroy_memcg_params(struct kmem_cache *s)
> >  static inline void memcg_unlink_cache(struct kmem_cache *s)
> >  {
> >  }
> > +
> > +static inline bool memcg_kmem_cache_dying(struct kmem_cache *s)
> > +{
> > +       return false;
> > +}
> >  #endif /* CONFIG_MEMCG_KMEM */
> >
> >  /*
> > @@ -326,6 +336,13 @@ int slab_unmergeable(struct kmem_cache *s)
> >         if (s->refcount < 0)
> >                 return 1;
> >
> > +       /*
> > +        * If the kmem_cache is dying. We should also skip this
> > +        * kmem_cache.
> > +        */
> > +       if (memcg_kmem_cache_dying(s))
> > +               return 1;
> > +
> >         return 0;
> >  }
> >
> > @@ -944,8 +961,6 @@ void kmem_cache_destroy(struct kmem_cache *s)
> >         if (unlikely(!s))
> >                 return;
> >
> > -       flush_memcg_workqueue(s);
> > -
> >         get_online_cpus();
> >         get_online_mems();
> >
> > @@ -955,6 +970,30 @@ void kmem_cache_destroy(struct kmem_cache *s)
> >         if (s->refcount)
> >                 goto out_unlock;
> >
> > +#ifdef CONFIG_MEMCG_KMEM
> > +       mutex_unlock(&slab_mutex);
> > +
> > +       put_online_mems();
> > +       put_online_cpus();
> > +
> > +       flush_memcg_workqueue(s);
> > +
> > +       get_online_cpus();
> > +       get_online_mems();
> > +
> > +       mutex_lock(&slab_mutex);
> > +
> > +       if (WARN(s->refcount,
> > +                "kmem_cache_destroy %s: Slab cache is still referenced\n",
> > +                s->name)) {
> > +               /*
> > +                * Reset the dying flag setted by flush_memcg_workqueue().
> > +                */
> > +               s->memcg_params.dying = false;
> > +               goto out_unlock;
> > +       }
> > +#endif
> > +
> >         err = shutdown_memcg_caches(s);
> >         if (!err)
> >                 err = shutdown_cache(s);
> > --
> > 2.11.0
> >



-- 
Yours,
Muchun
