Return-Path: <SRS0=kup7=A2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-17.6 required=3.0 tests=BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_IN_DEF_DKIM_WL autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6CC9EC433E7
	for <linux-kernel@archiver.kernel.org>; Wed, 15 Jul 2020 15:21:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 400212065E
	for <linux-kernel@archiver.kernel.org>; Wed, 15 Jul 2020 15:21:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="i+pwuqbj"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726648AbgGOPVE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 15 Jul 2020 11:21:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59442 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725798AbgGOPVD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Jul 2020 11:21:03 -0400
Received: from mail-lf1-x141.google.com (mail-lf1-x141.google.com [IPv6:2a00:1450:4864:20::141])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0B3CAC061755
        for <linux-kernel@vger.kernel.org>; Wed, 15 Jul 2020 08:21:03 -0700 (PDT)
Received: by mail-lf1-x141.google.com with SMTP id k17so1273466lfg.3
        for <linux-kernel@vger.kernel.org>; Wed, 15 Jul 2020 08:21:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=vci3IiDcus1RRvUL7DqGs3W5cYFn2DMJGL0yOJaDB2k=;
        b=i+pwuqbjNy6F6mKzI9aZ/iLrDZ8/ASlBJbGUJl2J22TqFRyEV6tj789yH8T4+HeTOI
         5qT/teD0u5tBybu4UG3wSLStTBjk9CXnUor4e6KvOxlpr9fruuL7+rLlYEq+JT8C2G59
         8Oey4IfF9j2v3GzDCWPL6e0oUM7uNEmW0KbIB2pppfOhNKLnCaLpvoVjF2hLzFQhMa5j
         ICU5bLJ+rC7cX28viLeoN+hQFxT4foIyDY9jre1a2xOmHGZ8m+GzbC9T6rJk8G5kUzz6
         vYVHeLl9ydpWAnAeUzN5ktKTpFOEBc/H4iwKk28D1ELTDNXNX70N/UKnNzku3K1Xy6Oc
         eapw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=vci3IiDcus1RRvUL7DqGs3W5cYFn2DMJGL0yOJaDB2k=;
        b=bY/3o2x2cnag1v6x9O3IbGrGKtRuJM9RK3hFG4UBWFeaedcEF3cbF/kp6FnOpqRKAH
         OfRbAjooUr16HuB3WXdDNYAqNGNeCq3RSKk99QWkNe6+XpVhQZ4VCLsdOMO+65B1cUKB
         71KJhrniXobK1+Y6wzaGEfLX+2m/F/Qw+VAf1KTN21PGrsVQn2xgzFPsEHwnJxb/4ZEQ
         3+PmrJt3bJfzQsXhwaJ3MkDgyJrk9C78gxQy0nI47xyuVcJvYgzUIeOpp+FXS2mP6dWD
         PweHeVdImqdXwIgUDTavCWcC4X8LAZNi6x+Yu1h5JmEHS++fEl3uPhwg3DIz7/ub7IW1
         SnfQ==
X-Gm-Message-State: AOAM532EVkzM35H1M3hYe+uITXE2BbZpXwnF0ExNmVaMeicc7tUt+z1W
        IHClx0Rapgx/tcsNX3QERmVQnlkjGlkNpGW28dTuQg==
X-Google-Smtp-Source: ABdhPJyHpoLsO0QSFy1u9f3M4Z3AxeoWw12ULRW827C+AuECOOtHfXtEPxIw1DOxBPhrckD3XlBV+y7fFCLbhqOObHM=
X-Received: by 2002:a19:e61a:: with SMTP id d26mr5055884lfh.96.1594826461049;
 Wed, 15 Jul 2020 08:21:01 -0700 (PDT)
MIME-Version: 1.0
References: <20200707062754.8383-1-songmuchun@bytedance.com>
In-Reply-To: <20200707062754.8383-1-songmuchun@bytedance.com>
From:   Shakeel Butt <shakeelb@google.com>
Date:   Wed, 15 Jul 2020 08:20:49 -0700
Message-ID: <CALvZod7E7zcEY-rr20wzE6b+EGVNdrnfrBW7F-nKR8dNh-=h1w@mail.gmail.com>
Subject: Re: [PATCH v5.4.y, v4.19.y] mm: memcg/slab: fix memory leak at
 non-root kmem_cache destroy
To:     Muchun Song <songmuchun@bytedance.com>
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

Sorry I missed this email.


On Mon, Jul 6, 2020 at 11:28 PM Muchun Song <songmuchun@bytedance.com> wrote:
>
> If the kmem_cache refcount is greater than one, we should not
> mark the root kmem_cache as dying. If we mark the root kmem_cache
> dying incorrectly, the non-root kmem_cache can never be destroyed.
> It resulted in memory leak when memcg was destroyed. We can use the
> following steps to reproduce.
>
>   1) Use kmem_cache_create() to create a new kmem_cache named A.
>   2) Coincidentally, the kmem_cache A is an alias for kmem_cache B,
>      so the refcount of B is just increased.

I definitely missed the alias kmem cache case.

>   3) Use kmem_cache_destroy() to destroy the kmem_cache A, just
>      decrease the B's refcount but mark the B as dying.
>   4) Create a new memory cgroup and alloc memory from the kmem_cache
>      A. It leads to create a non-root kmem_cache for allocating.

I think in (4) you meant alloc memory from kmem_cache B instead of A.
There should not be any allocation from A after kmem_cache_destroy()
in (3).

>   5) When destroy the memory cgroup created in the step 4), the
>      non-root kmem_cache can never be destroyed.
>
> If we repeat steps 4) and 5), this will cause a lot of memory leak.
> So only when refcount reach zero, we mark the root kmem_cache as dying.
>
> Fixes: 92ee383f6daa ("mm: fix race between kmem_cache destroy, create and deactivate")
> Signed-off-by: Muchun Song <songmuchun@bytedance.com>

The patch looks fine.

Reviewed-by: Shakeel Butt <shakeelb@google.com>

> ---
>  mm/slab_common.c | 43 +++++++++++++++++++++++++++++++++++++++++--
>  1 file changed, 41 insertions(+), 2 deletions(-)
>
> diff --git a/mm/slab_common.c b/mm/slab_common.c
> index 8c1ffbf7de45..83ee6211aec7 100644
> --- a/mm/slab_common.c
> +++ b/mm/slab_common.c
> @@ -258,6 +258,11 @@ static void memcg_unlink_cache(struct kmem_cache *s)
>                 list_del(&s->memcg_params.kmem_caches_node);
>         }
>  }
> +
> +static inline bool memcg_kmem_cache_dying(struct kmem_cache *s)
> +{
> +       return is_root_cache(s) && s->memcg_params.dying;
> +}
>  #else
>  static inline int init_memcg_params(struct kmem_cache *s,
>                                     struct kmem_cache *root_cache)
> @@ -272,6 +277,11 @@ static inline void destroy_memcg_params(struct kmem_cache *s)
>  static inline void memcg_unlink_cache(struct kmem_cache *s)
>  {
>  }
> +
> +static inline bool memcg_kmem_cache_dying(struct kmem_cache *s)
> +{
> +       return false;
> +}
>  #endif /* CONFIG_MEMCG_KMEM */
>
>  /*
> @@ -326,6 +336,13 @@ int slab_unmergeable(struct kmem_cache *s)
>         if (s->refcount < 0)
>                 return 1;
>
> +       /*
> +        * If the kmem_cache is dying. We should also skip this
> +        * kmem_cache.
> +        */
> +       if (memcg_kmem_cache_dying(s))
> +               return 1;
> +
>         return 0;
>  }
>
> @@ -944,8 +961,6 @@ void kmem_cache_destroy(struct kmem_cache *s)
>         if (unlikely(!s))
>                 return;
>
> -       flush_memcg_workqueue(s);
> -
>         get_online_cpus();
>         get_online_mems();
>
> @@ -955,6 +970,30 @@ void kmem_cache_destroy(struct kmem_cache *s)
>         if (s->refcount)
>                 goto out_unlock;
>
> +#ifdef CONFIG_MEMCG_KMEM
> +       mutex_unlock(&slab_mutex);
> +
> +       put_online_mems();
> +       put_online_cpus();
> +
> +       flush_memcg_workqueue(s);
> +
> +       get_online_cpus();
> +       get_online_mems();
> +
> +       mutex_lock(&slab_mutex);
> +
> +       if (WARN(s->refcount,
> +                "kmem_cache_destroy %s: Slab cache is still referenced\n",
> +                s->name)) {
> +               /*
> +                * Reset the dying flag setted by flush_memcg_workqueue().
> +                */
> +               s->memcg_params.dying = false;
> +               goto out_unlock;
> +       }
> +#endif
> +
>         err = shutdown_memcg_caches(s);
>         if (!err)
>                 err = shutdown_cache(s);
> --
> 2.11.0
>
