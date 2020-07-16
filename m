Return-Path: <SRS0=y5Sx=A3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BD44AC433E1
	for <linux-kernel@archiver.kernel.org>; Thu, 16 Jul 2020 16:55:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 92AC62074B
	for <linux-kernel@archiver.kernel.org>; Thu, 16 Jul 2020 16:55:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="o5+bUZ3v"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728721AbgGPQzQ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 16 Jul 2020 12:55:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42078 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725867AbgGPQzP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Jul 2020 12:55:15 -0400
Received: from mail-lj1-x242.google.com (mail-lj1-x242.google.com [IPv6:2a00:1450:4864:20::242])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 10374C061755
        for <linux-kernel@vger.kernel.org>; Thu, 16 Jul 2020 09:55:15 -0700 (PDT)
Received: by mail-lj1-x242.google.com with SMTP id f5so8628784ljj.10
        for <linux-kernel@vger.kernel.org>; Thu, 16 Jul 2020 09:55:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=mKJdpx0CeOVwtyGXaWgeY/kol4wsc+xqooO/wamOc4A=;
        b=o5+bUZ3v4sQfvPc4RTG5dFYPFpocspEdMAHBRhI2lFJpfmn4lGvBJEF9ufdBzVJVWT
         oS+3qtTh7eR+O/sHJ90tfd/oKTCSziHdmxaQNakeGk3yAf4CDjdsWgeZT1ylGtS5koSR
         kflkeajJxg/x4JfFy0UhV+FdRIhP+GYApHRPgZrjXNgMZ7KROSsnRoiPo60uXhLPYRc/
         F0M+KnHE/ZuwwXUyAFBSZYgW461KiMhv4Z7sRmf/czDu7XmfMwYOdAGhbqAanl1+DL/P
         oJIAZb+sqCeweatK/r1bJz4kGIv1pWlESdvQQv6u9xu4Ogg1BBJzTQBA60URtzHbkFT2
         cs3w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=mKJdpx0CeOVwtyGXaWgeY/kol4wsc+xqooO/wamOc4A=;
        b=FlOxkcjr7vPX41f3ZgAUITkEVbNOxqJo7rH781SIwENVUZ9y0tT9U4tsLT2/E0y1O5
         0mf6aXRjKuqQ0UqSohqnRaPtiustyivdUbLHmqRoyJJdtWWGMq+ANXX87q4+4SFCIW6P
         BDMbbvO9T6i1890AAaDU1asdLXGKaQW3dfiz/oNOIn+UMR+k4kKThHWeEtRx71joKOL1
         axJYV+gfWtxDmhuB2fWfBGcQ9ylZ7r1YIDvqijtlUsdZ4Htu0ytW0tI01Rdn7pQS8/wI
         cTivNMAn2Np5/hjwbRJeiXtWgc8wxNZnqj6+gFwf4FVnKQyRVH3srzaSZ8khWfFKoVfG
         i24Q==
X-Gm-Message-State: AOAM533UxtDtrw6fpqkla6IjsOJjMIXTLwjDOBPhdryL+qGv+0VXcrhc
        m9wBUl0DiVsectOMfwhmSuVWbz0aeQforCrt6Ijcng==
X-Google-Smtp-Source: ABdhPJxhf4IMl7ZmEQ6ZWz+x0cF075fw/FdUzothOYiC1JSmv6vDIWqyRs0IazGa2NjmMhWeUbm2NMVnSxxSd1Kva0w=
X-Received: by 2002:a2e:9089:: with SMTP id l9mr2543253ljg.431.1594918513149;
 Thu, 16 Jul 2020 09:55:13 -0700 (PDT)
MIME-Version: 1.0
References: <20200623174037.3951353-1-guro@fb.com> <20200623174037.3951353-9-guro@fb.com>
In-Reply-To: <20200623174037.3951353-9-guro@fb.com>
From:   Naresh Kamboju <naresh.kamboju@linaro.org>
Date:   Thu, 16 Jul 2020 22:25:01 +0530
Message-ID: <CA+G9fYs0vDPAL_84oDEVdGdbFEDjAR1RFoVeFTpjN6b2yS+ZPg@mail.gmail.com>
Subject: Re: [PATCH v7 08/19] mm: memcg/slab: save obj_cgroup for non-root
 slab objects
To:     Roman Gushchin <guro@fb.com>, linux-mips@vger.kernel.org
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Christoph Lameter <cl@linux.com>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Michal Hocko <mhocko@kernel.org>,
        Shakeel Butt <shakeelb@google.com>,
        linux-mm <linux-mm@kvack.org>, Vlastimil Babka <vbabka@suse.cz>,
        Kernel Team <kernel-team@fb.com>,
        open list <linux-kernel@vger.kernel.org>,
        lkft-triage@lists.linaro.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 23 Jun 2020 at 23:11, Roman Gushchin <guro@fb.com> wrote:
>
> Store the obj_cgroup pointer in the corresponding place of
> page->obj_cgroups for each allocated non-root slab object.  Make sure tha=
t
> each allocated object holds a reference to obj_cgroup.
>
> Objcg pointer is obtained from the memcg->objcg dereferencing in
> memcg_kmem_get_cache() and passed from pre_alloc_hook to post_alloc_hook.
> Then in case of successful allocation(s) it's getting stored in the
> page->obj_cgroups vector.
>
> The objcg obtaining part look a bit bulky now, but it will be simplified
> by next commits in the series.
>
> Signed-off-by: Roman Gushchin <guro@fb.com>
> Reviewed-by: Vlastimil Babka <vbabka@suse.cz>
> Reviewed-by: Shakeel Butt <shakeelb@google.com>
> ---
>  include/linux/memcontrol.h |  3 +-
>  mm/memcontrol.c            | 14 +++++++--
>  mm/slab.c                  | 18 +++++++-----
>  mm/slab.h                  | 60 ++++++++++++++++++++++++++++++++++----
>  mm/slub.c                  | 14 +++++----
>  5 files changed, 88 insertions(+), 21 deletions(-)
>
> diff --git a/include/linux/memcontrol.h b/include/linux/memcontrol.h
> index f2f9d5d6b7d1..b845e908e76e 100644
> --- a/include/linux/memcontrol.h
> +++ b/include/linux/memcontrol.h
> @@ -1404,7 +1404,8 @@ static inline void memcg_set_shrinker_bit(struct me=
m_cgroup *memcg,
>  }
>  #endif
>
> -struct kmem_cache *memcg_kmem_get_cache(struct kmem_cache *cachep);
> +struct kmem_cache *memcg_kmem_get_cache(struct kmem_cache *cachep,
> +                                       struct obj_cgroup **objcgp);
>  void memcg_kmem_put_cache(struct kmem_cache *cachep);
>
>  #ifdef CONFIG_MEMCG_KMEM
> diff --git a/mm/memcontrol.c b/mm/memcontrol.c
> index 60e3f3ca75ca..5e55c7afc18c 100644
> --- a/mm/memcontrol.c
> +++ b/mm/memcontrol.c
> @@ -2973,7 +2973,8 @@ static inline bool memcg_kmem_bypass(void)
>   * done with it, memcg_kmem_put_cache() must be called to release the
>   * reference.
>   */
> -struct kmem_cache *memcg_kmem_get_cache(struct kmem_cache *cachep)
> +struct kmem_cache *memcg_kmem_get_cache(struct kmem_cache *cachep,
> +                                       struct obj_cgroup **objcgp)
>  {
>         struct mem_cgroup *memcg;
>         struct kmem_cache *memcg_cachep;
> @@ -3029,8 +3030,17 @@ struct kmem_cache *memcg_kmem_get_cache(struct kme=
m_cache *cachep)
>          */
>         if (unlikely(!memcg_cachep))
>                 memcg_schedule_kmem_cache_create(memcg, cachep);
> -       else if (percpu_ref_tryget(&memcg_cachep->memcg_params.refcnt))
> +       else if (percpu_ref_tryget(&memcg_cachep->memcg_params.refcnt)) {
> +               struct obj_cgroup *objcg =3D rcu_dereference(memcg->objcg=
);
> +
> +               if (!objcg || !obj_cgroup_tryget(objcg)) {
> +                       percpu_ref_put(&memcg_cachep->memcg_params.refcnt=
);
> +                       goto out_unlock;
> +               }
> +
> +               *objcgp =3D objcg;
>                 cachep =3D memcg_cachep;
> +       }
>  out_unlock:
>         rcu_read_unlock();
>         return cachep;
> diff --git a/mm/slab.c b/mm/slab.c
> index 4c7013eeacd9..a7cc1336221f 100644
> --- a/mm/slab.c
> +++ b/mm/slab.c
> @@ -3222,9 +3222,10 @@ slab_alloc_node(struct kmem_cache *cachep, gfp_t f=
lags, int nodeid,
>         unsigned long save_flags;
>         void *ptr;
>         int slab_node =3D numa_mem_id();
> +       struct obj_cgroup *objcg =3D NULL;
>
>         flags &=3D gfp_allowed_mask;
> -       cachep =3D slab_pre_alloc_hook(cachep, flags);
> +       cachep =3D slab_pre_alloc_hook(cachep, &objcg, 1, flags);
>         if (unlikely(!cachep))
>                 return NULL;
>
> @@ -3260,7 +3261,7 @@ slab_alloc_node(struct kmem_cache *cachep, gfp_t fl=
ags, int nodeid,
>         if (unlikely(slab_want_init_on_alloc(flags, cachep)) && ptr)
>                 memset(ptr, 0, cachep->object_size);
>
> -       slab_post_alloc_hook(cachep, flags, 1, &ptr);
> +       slab_post_alloc_hook(cachep, objcg, flags, 1, &ptr);
>         return ptr;
>  }
>
> @@ -3301,9 +3302,10 @@ slab_alloc(struct kmem_cache *cachep, gfp_t flags,=
 unsigned long caller)
>  {
>         unsigned long save_flags;
>         void *objp;
> +       struct obj_cgroup *objcg =3D NULL;
>
>         flags &=3D gfp_allowed_mask;
> -       cachep =3D slab_pre_alloc_hook(cachep, flags);
> +       cachep =3D slab_pre_alloc_hook(cachep, &objcg, 1, flags);
>         if (unlikely(!cachep))
>                 return NULL;
>
> @@ -3317,7 +3319,7 @@ slab_alloc(struct kmem_cache *cachep, gfp_t flags, =
unsigned long caller)
>         if (unlikely(slab_want_init_on_alloc(flags, cachep)) && objp)
>                 memset(objp, 0, cachep->object_size);
>
> -       slab_post_alloc_hook(cachep, flags, 1, &objp);
> +       slab_post_alloc_hook(cachep, objcg, flags, 1, &objp);
>         return objp;
>  }
>
> @@ -3443,6 +3445,7 @@ void ___cache_free(struct kmem_cache *cachep, void =
*objp,
>                 memset(objp, 0, cachep->object_size);
>         kmemleak_free_recursive(objp, cachep->flags);
>         objp =3D cache_free_debugcheck(cachep, objp, caller);
> +       memcg_slab_free_hook(cachep, virt_to_head_page(objp), objp);
>
>         /*
>          * Skip calling cache_free_alien() when the platform is not numa.
> @@ -3508,8 +3511,9 @@ int kmem_cache_alloc_bulk(struct kmem_cache *s, gfp=
_t flags, size_t size,
>                           void **p)
>  {
>         size_t i;
> +       struct obj_cgroup *objcg =3D NULL;
>
> -       s =3D slab_pre_alloc_hook(s, flags);
> +       s =3D slab_pre_alloc_hook(s, &objcg, size, flags);
>         if (!s)
>                 return 0;
>
> @@ -3532,13 +3536,13 @@ int kmem_cache_alloc_bulk(struct kmem_cache *s, g=
fp_t flags, size_t size,
>                 for (i =3D 0; i < size; i++)
>                         memset(p[i], 0, s->object_size);
>
> -       slab_post_alloc_hook(s, flags, size, p);
> +       slab_post_alloc_hook(s, objcg, flags, size, p);
>         /* FIXME: Trace call missing. Christoph would like a bulk variant=
 */
>         return size;
>  error:
>         local_irq_enable();
>         cache_alloc_debugcheck_after_bulk(s, flags, i, p, _RET_IP_);
> -       slab_post_alloc_hook(s, flags, i, p);
> +       slab_post_alloc_hook(s, objcg, flags, i, p);
>         __kmem_cache_free_bulk(s, i, p);
>         return 0;
>  }
> diff --git a/mm/slab.h b/mm/slab.h
> index 7d175c2f1a61..c37a50f26e41 100644
> --- a/mm/slab.h
> +++ b/mm/slab.h
> @@ -469,6 +469,41 @@ static inline void memcg_free_page_obj_cgroups(struc=
t page *page)
>         page->obj_cgroups =3D NULL;
>  }
>
> +static inline void memcg_slab_post_alloc_hook(struct kmem_cache *s,
> +                                             struct obj_cgroup *objcg,
> +                                             size_t size, void **p)
> +{
> +       struct page *page;
> +       unsigned long off;
> +       size_t i;
> +
> +       for (i =3D 0; i < size; i++) {
> +               if (likely(p[i])) {
> +                       page =3D virt_to_head_page(p[i]);
> +                       off =3D obj_to_index(s, page, p[i]);
> +                       obj_cgroup_get(objcg);
> +                       page_obj_cgroups(page)[off] =3D objcg;
> +               }
> +       }
> +       obj_cgroup_put(objcg);
> +       memcg_kmem_put_cache(s);
> +}
> +
> +static inline void memcg_slab_free_hook(struct kmem_cache *s, struct pag=
e *page,
> +                                       void *p)
> +{
> +       struct obj_cgroup *objcg;
> +       unsigned int off;
> +
> +       if (!memcg_kmem_enabled() || is_root_cache(s))
> +               return;
> +
> +       off =3D obj_to_index(s, page, p);
> +       objcg =3D page_obj_cgroups(page)[off];
> +       page_obj_cgroups(page)[off] =3D NULL;
> +       obj_cgroup_put(objcg);
> +}
> +
>  extern void slab_init_memcg_params(struct kmem_cache *);
>  extern void memcg_link_cache(struct kmem_cache *s, struct mem_cgroup *me=
mcg);
>
> @@ -528,6 +563,17 @@ static inline void memcg_free_page_obj_cgroups(struc=
t page *page)
>  {
>  }
>
> +static inline void memcg_slab_post_alloc_hook(struct kmem_cache *s,
> +                                             struct obj_cgroup *objcg,
> +                                             size_t size, void **p)
> +{
> +}
> +
> +static inline void memcg_slab_free_hook(struct kmem_cache *s, struct pag=
e *page,
> +                                       void *p)
> +{
> +}
> +
>  static inline void slab_init_memcg_params(struct kmem_cache *s)
>  {
>  }
> @@ -630,7 +676,8 @@ static inline size_t slab_ksize(const struct kmem_cac=
he *s)
>  }
>
>  static inline struct kmem_cache *slab_pre_alloc_hook(struct kmem_cache *=
s,
> -                                                    gfp_t flags)
> +                                                    struct obj_cgroup **=
objcgp,
> +                                                    size_t size, gfp_t f=
lags)
>  {
>         flags &=3D gfp_allowed_mask;
>
> @@ -644,13 +691,14 @@ static inline struct kmem_cache *slab_pre_alloc_hoo=
k(struct kmem_cache *s,
>
>         if (memcg_kmem_enabled() &&
>             ((flags & __GFP_ACCOUNT) || (s->flags & SLAB_ACCOUNT)))
> -               return memcg_kmem_get_cache(s);
> +               return memcg_kmem_get_cache(s, objcgp);
>
>         return s;
>  }
>
> -static inline void slab_post_alloc_hook(struct kmem_cache *s, gfp_t flag=
s,
> -                                       size_t size, void **p)
> +static inline void slab_post_alloc_hook(struct kmem_cache *s,
> +                                       struct obj_cgroup *objcg,
> +                                       gfp_t flags, size_t size, void **=
p)
>  {
>         size_t i;
>
> @@ -662,8 +710,8 @@ static inline void slab_post_alloc_hook(struct kmem_c=
ache *s, gfp_t flags,
>                                          s->flags, flags);
>         }
>
> -       if (memcg_kmem_enabled())
> -               memcg_kmem_put_cache(s);
> +       if (memcg_kmem_enabled() && !is_root_cache(s))
> +               memcg_slab_post_alloc_hook(s, objcg, size, p);
>  }
>
>  #ifndef CONFIG_SLOB
> diff --git a/mm/slub.c b/mm/slub.c
> index aa8d18824e62..25810980a26c 100644
> --- a/mm/slub.c
> +++ b/mm/slub.c
> @@ -2821,8 +2821,9 @@ static __always_inline void *slab_alloc_node(struct=
 kmem_cache *s,
>         struct kmem_cache_cpu *c;
>         struct page *page;
>         unsigned long tid;
> +       struct obj_cgroup *objcg =3D NULL;
>
> -       s =3D slab_pre_alloc_hook(s, gfpflags);
> +       s =3D slab_pre_alloc_hook(s, &objcg, 1, gfpflags);
>         if (!s)
>                 return NULL;
>  redo:
> @@ -2898,7 +2899,7 @@ static __always_inline void *slab_alloc_node(struct=
 kmem_cache *s,
>         if (unlikely(slab_want_init_on_alloc(gfpflags, s)) && object)
>                 memset(object, 0, s->object_size);
>
> -       slab_post_alloc_hook(s, gfpflags, 1, &object);
> +       slab_post_alloc_hook(s, objcg, gfpflags, 1, &object);
>
>         return object;
>  }
> @@ -3103,6 +3104,8 @@ static __always_inline void do_slab_free(struct kme=
m_cache *s,
>         void *tail_obj =3D tail ? : head;
>         struct kmem_cache_cpu *c;
>         unsigned long tid;
> +
> +       memcg_slab_free_hook(s, page, head);
>  redo:
>         /*
>          * Determine the currently cpus per cpu slab.
> @@ -3282,9 +3285,10 @@ int kmem_cache_alloc_bulk(struct kmem_cache *s, gf=
p_t flags, size_t size,
>  {
>         struct kmem_cache_cpu *c;
>         int i;
> +       struct obj_cgroup *objcg =3D NULL;
>
>         /* memcg and kmem_cache debug support */
> -       s =3D slab_pre_alloc_hook(s, flags);
> +       s =3D slab_pre_alloc_hook(s, &objcg, size, flags);
>         if (unlikely(!s))
>                 return false;
>         /*
> @@ -3338,11 +3342,11 @@ int kmem_cache_alloc_bulk(struct kmem_cache *s, g=
fp_t flags, size_t size,
>         }
>
>         /* memcg and kmem_cache debug support */
> -       slab_post_alloc_hook(s, flags, size, p);
> +       slab_post_alloc_hook(s, objcg, flags, size, p);
>         return i;
>  error:
>         local_irq_enable();
> -       slab_post_alloc_hook(s, flags, i, p);
> +       slab_post_alloc_hook(s, objcg, flags, i, p);
>         __kmem_cache_free_bulk(s, i, p);
>         return 0;
>  }
>

I am not sure if this is the related patch or not that is causing
mips architecture build failure on linux -next.

make -sk KBUILD_BUILD_USER=3DTuxBuild -C/linux -j16 ARCH=3Dmips
CROSS_COMPILE=3Dmips-linux-gnu- HOSTCC=3Dgcc CC=3D"sccache
mips-linux-gnu-gcc" O=3Dbuild
#
../mm/slub.c: In function =E2=80=98slab_alloc.constprop=E2=80=99:
../mm/slub.c:2897:30: error: inlining failed in call to always_inline
=E2=80=98slab_alloc.constprop=E2=80=99: recursive inlining
 2897 | static __always_inline void *slab_alloc(struct kmem_cache *s,
      |                              ^~~~~~~~~~
../mm/slub.c:2905:14: note: called from here
 2905 |  void *ret =3D slab_alloc(s, gfpflags, _RET_IP_);
      |              ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
../mm/slub.c: In function =E2=80=98sysfs_slab_alias=E2=80=99:
../mm/slub.c:2897:30: error: inlining failed in call to always_inline
=E2=80=98slab_alloc.constprop=E2=80=99: recursive inlining
 2897 | static __always_inline void *slab_alloc(struct kmem_cache *s,
      |                              ^~~~~~~~~~
../mm/slub.c:2905:14: note: called from here
 2905 |  void *ret =3D slab_alloc(s, gfpflags, _RET_IP_);
      |              ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
../mm/slub.c: In function =E2=80=98sysfs_slab_add=E2=80=99:
../mm/slub.c:2897:30: error: inlining failed in call to always_inline
=E2=80=98slab_alloc.constprop=E2=80=99: recursive inlining
 2897 | static __always_inline void *slab_alloc(struct kmem_cache *s,
      |                              ^~~~~~~~~~
../mm/slub.c:2905:14: note: called from here
 2905 |  void *ret =3D slab_alloc(s, gfpflags, _RET_IP_);
      |              ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~


Full build log link,
https://builds.tuxbuild.com/jBgeEp1SD-bUldWES782yQ/build.log

--=20
Linaro LKFT
https://lkft.linaro.org
