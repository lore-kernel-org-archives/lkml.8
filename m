Return-Path: <SRS0=y5Sx=A3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.0 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 82F23C433E2
	for <linux-kernel@archiver.kernel.org>; Thu, 16 Jul 2020 16:29:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5D065207CB
	for <linux-kernel@archiver.kernel.org>; Thu, 16 Jul 2020 16:29:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=bytedance-com.20150623.gappssmtp.com header.i=@bytedance-com.20150623.gappssmtp.com header.b="G8dRf1F/"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729320AbgGPQ3r (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 16 Jul 2020 12:29:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38116 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728845AbgGPQ3p (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Jul 2020 12:29:45 -0400
Received: from mail-pj1-x1042.google.com (mail-pj1-x1042.google.com [IPv6:2607:f8b0:4864:20::1042])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 658D6C061755
        for <linux-kernel@vger.kernel.org>; Thu, 16 Jul 2020 09:29:45 -0700 (PDT)
Received: by mail-pj1-x1042.google.com with SMTP id mn17so5077961pjb.4
        for <linux-kernel@vger.kernel.org>; Thu, 16 Jul 2020 09:29:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=8sii6qA/Fo/lmtLCZPsqwtv2rJ2Am9QsQ34HB4X7rHY=;
        b=G8dRf1F/asebkWrl2ZsXJTzaKswNBHH+xVUJZdfXA4LWUpKrE/2QzEJiKd7prNYP8b
         9M+2HqZkm7xt0x2ZmQ1jvzYHSBN5UifEspjeHcj72F2QG2Q/3zL6vPn0RDp9HI0k82tE
         3l2Sr9ntxQI6wJxuZUEu7PHmcdaouLnVkwkjG1UzjzhTxe/5VkzWLI9Qd8ypFzkdeSj1
         GiOS6CqszVRTA5+llUpP+jrEJ+WD7jCcU3d+/LEykFBiC194oeCKhugNLgN3Exc/0gza
         gD2vVsh38GWT3Mz0t5I1GV07j2Q5+FjV1024SDofFZaYibz9JbSVj4bYnzHFxXnYiU8S
         zL6w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=8sii6qA/Fo/lmtLCZPsqwtv2rJ2Am9QsQ34HB4X7rHY=;
        b=rsdMZfFAOC+d1LiQheAJJXiazON+YJoBvAzM46ZlZ4p46xJ75BShANX+o6dvLZDS4d
         QHPxSW5IWTMZ/gCAKqYzcafBoYh3Dk6tTFGX6eSrJri9odkZLaxA65q02VwqIgVk17MF
         DDSBtPfb4zw4JSiEG3heJhMQ0z7ENw6gKXpGq2KYcJI4NoIDDqjPfI2LrPFGOQ6sdfbR
         +isniGeeDIUhJZpOrbcv4oEAgQ8/amUchFY+Vf71SL3s3hRPC1HZPEbPUNN+G+l1zZRx
         T8y8mcoynj9sRokVV4iIHgE/m1EwkhAha5VugywWz4R1wPXKvMWdOnw+HaiNdd5Dxl2A
         U/WQ==
X-Gm-Message-State: AOAM531OxNV0dU1ajF+vEdND2WACgLhZSzA7UYXTzMdLtampDr8hEhaw
        iUnweOI3mRP2UglnnF+MTHN/DAklbx/rzRZpdLYWtw==
X-Google-Smtp-Source: ABdhPJzo2W3F8theUGxIB3CD3r99Gj4zL39ZEoW/K3rCDP47KLPBo3jst8qX8ApU/OOzN7WK4x9f9vhPzMZ2TN8VEcI=
X-Received: by 2002:a17:90a:20e9:: with SMTP id f96mr5825276pjg.13.1594916984677;
 Thu, 16 Jul 2020 09:29:44 -0700 (PDT)
MIME-Version: 1.0
References: <20200715165023.29919-1-songmuchun@bytedance.com>
 <20200715175432.GA6314@carbon.lan> <CAMZfGtVupfg+WiXBvTsnXTZ=bgHxaztEFP1cQ8hnCfXmCUV=gw@mail.gmail.com>
 <20200716154633.GA15421@carbon.DHCP.thefacebook.com> <CAMZfGtVMY3DqH4XxwkfY0AekD9EFvAN2xaavRUjxYK_s3yA89w@mail.gmail.com>
 <20200716161507.GA4217@carbon.lan>
In-Reply-To: <20200716161507.GA4217@carbon.lan>
From:   Muchun Song <songmuchun@bytedance.com>
Date:   Fri, 17 Jul 2020 00:29:06 +0800
Message-ID: <CAMZfGtU2xKiMeHcn=c5Hrm1UKiGN7e+OKzaVaqW0Pwa3a96OOw@mail.gmail.com>
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

On Fri, Jul 17, 2020 at 12:16 AM Roman Gushchin <guro@fb.com> wrote:
>
> On Thu, Jul 16, 2020 at 11:54:37PM +0800, Muchun Song wrote:
> > On Thu, Jul 16, 2020 at 11:46 PM Roman Gushchin <guro@fb.com> wrote:
> > >
> > > On Thu, Jul 16, 2020 at 01:07:02PM +0800, Muchun Song wrote:
> > > > On Thu, Jul 16, 2020 at 1:54 AM Roman Gushchin <guro@fb.com> wrote:
> > > > >
> > > > > On Thu, Jul 16, 2020 at 12:50:22AM +0800, Muchun Song wrote:
> > > > > > If the kmem_cache refcount is greater than one, we should not
> > > > > > mark the root kmem_cache as dying. If we mark the root kmem_cache
> > > > > > dying incorrectly, the non-root kmem_cache can never be destroyed.
> > > > > > It resulted in memory leak when memcg was destroyed. We can use the
> > > > > > following steps to reproduce.
> > > > > >
> > > > > >   1) Use kmem_cache_create() to create a new kmem_cache named A.
> > > > > >   2) Coincidentally, the kmem_cache A is an alias for kmem_cache B,
> > > > > >      so the refcount of B is just increased.
> > > > > >   3) Use kmem_cache_destroy() to destroy the kmem_cache A, just
> > > > > >      decrease the B's refcount but mark the B as dying.
> > > > > >   4) Create a new memory cgroup and alloc memory from the kmem_cache
> > > > > >      B. It leads to create a non-root kmem_cache for allocating memory.
> > > > > >   5) When destroy the memory cgroup created in the step 4), the
> > > > > >      non-root kmem_cache can never be destroyed.
> > > > > >
> > > > > > If we repeat steps 4) and 5), this will cause a lot of memory leak.
> > > > > > So only when refcount reach zero, we mark the root kmem_cache as dying.
> > > > > >
> > > > > > Fixes: 92ee383f6daa ("mm: fix race between kmem_cache destroy, create and deactivate")
> > > > > > Signed-off-by: Muchun Song <songmuchun@bytedance.com>
> > > > > > Reviewed-by: Shakeel Butt <shakeelb@google.com>
> > > > > > ---
> > > > > >
> > > > > > changelog in v2:
> > > > > >  1) Fix a confusing typo in the commit log.
> > > > >
> > > > > Ok, now I see the problem. Thank you for fixing the commit log!
> > > > >
> > > > > >  2) Remove flush_memcg_workqueue() for !CONFIG_MEMCG_KMEM.
> > > > > >  3) Introduce a new helper memcg_set_kmem_cache_dying() to fix a race
> > > > > >     condition between flush_memcg_workqueue() and slab_unmergeable().
> > > > > >
> > > > > >  mm/slab_common.c | 54 +++++++++++++++++++++++++++++++++++++++++++++++-------
> > > > > >  1 file changed, 47 insertions(+), 7 deletions(-)
> > > > > >
> > > > > > diff --git a/mm/slab_common.c b/mm/slab_common.c
> > > > > > index 8c1ffbf7de45..c4958116e3fd 100644
> > > > > > --- a/mm/slab_common.c
> > > > > > +++ b/mm/slab_common.c
> > > > > > @@ -258,6 +258,11 @@ static void memcg_unlink_cache(struct kmem_cache *s)
> > > > > >               list_del(&s->memcg_params.kmem_caches_node);
> > > > > >       }
> > > > > >  }
> > > > > > +
> > > > > > +static inline bool memcg_kmem_cache_dying(struct kmem_cache *s)
> > > > > > +{
> > > > > > +     return is_root_cache(s) && s->memcg_params.dying;
> > > > > > +}
> > > > > >  #else
> > > > > >  static inline int init_memcg_params(struct kmem_cache *s,
> > > > > >                                   struct kmem_cache *root_cache)
> > > > > > @@ -272,6 +277,11 @@ static inline void destroy_memcg_params(struct kmem_cache *s)
> > > > > >  static inline void memcg_unlink_cache(struct kmem_cache *s)
> > > > > >  {
> > > > > >  }
> > > > > > +
> > > > > > +static inline bool memcg_kmem_cache_dying(struct kmem_cache *s)
> > > > > > +{
> > > > > > +     return false;
> > > > > > +}
> > > > > >  #endif /* CONFIG_MEMCG_KMEM */
> > > > > >
> > > > > >  /*
> > > > > > @@ -326,6 +336,13 @@ int slab_unmergeable(struct kmem_cache *s)
> > > > > >       if (s->refcount < 0)
> > > > > >               return 1;
> > > > > >
> > > > > > +     /*
> > > > > > +      * If the kmem_cache is dying. We should also skip this
> > > > > > +      * kmem_cache.
> > > > > > +      */
> > > > > > +     if (memcg_kmem_cache_dying(s))
> > > > > > +             return 1;
> > > > > > +
> > > > > >       return 0;
> > > > > >  }
> > > > > >
> > > > > > @@ -886,12 +903,15 @@ static int shutdown_memcg_caches(struct kmem_cache *s)
> > > > > >       return 0;
> > > > > >  }
> > > > > >
> > > > > > -static void flush_memcg_workqueue(struct kmem_cache *s)
> > > > > > +static void memcg_set_kmem_cache_dying(struct kmem_cache *s)
> > > > > >  {
> > > > > >       spin_lock_irq(&memcg_kmem_wq_lock);
> > > > > >       s->memcg_params.dying = true;
> > > > > >       spin_unlock_irq(&memcg_kmem_wq_lock);
> > > > > > +}
> > > > > >
> > > > > > +static void flush_memcg_workqueue(struct kmem_cache *s)
> > > > > > +{
> > > > > >       /*
> > > > > >        * SLAB and SLUB deactivate the kmem_caches through call_rcu. Make
> > > > > >        * sure all registered rcu callbacks have been invoked.
> > > > > > @@ -923,10 +943,6 @@ static inline int shutdown_memcg_caches(struct kmem_cache *s)
> > > > > >  {
> > > > > >       return 0;
> > > > > >  }
> > > > > > -
> > > > > > -static inline void flush_memcg_workqueue(struct kmem_cache *s)
> > > > > > -{
> > > > > > -}
> > > > > >  #endif /* CONFIG_MEMCG_KMEM */
> > > > > >
> > > > > >  void slab_kmem_cache_release(struct kmem_cache *s)
> > > > > > @@ -944,8 +960,6 @@ void kmem_cache_destroy(struct kmem_cache *s)
> > > > > >       if (unlikely(!s))
> > > > > >               return;
> > > > > >
> > > > > > -     flush_memcg_workqueue(s);
> > > > > > -
> > > > > >       get_online_cpus();
> > > > > >       get_online_mems();
> > > > > >
> > > > > > @@ -955,6 +969,32 @@ void kmem_cache_destroy(struct kmem_cache *s)
> > > > > >       if (s->refcount)
> > > > > >               goto out_unlock;
> > > > > >
> > > > > > +#ifdef CONFIG_MEMCG_KMEM
> > > > > > +     memcg_set_kmem_cache_dying(s);
> > > > > > +
> > > > > > +     mutex_unlock(&slab_mutex);
> > > > >
> > > > > Hm, but in theory s->refcount can be increased here?
> > > >
> > > > I have tried my best to read all the codes that operate on s->refcount.
> > > > There is only one place which increases the s->refcount, it is the
> > > > __kmem_cache_alias(). If the kmem cache is dying, the slab_unmergeable()
> > > > can never return true for the dying kmem cache because it is the same slab_mutex
> > > > protection, so I think that there is not a problem, right?
> > >
> > > So the problem is that you're checking s->refcount under slab_mutex,
> > > then you're releasing the mutex and then set the dying bit. But nothing prevents
> >
> > Maybe you miss something. The dying bit is set in the
> > memcg_set_kmem_cache_dying()
> > which is under the slab_mutex protection.  So I think there is no problem.
>
> I'm sorry, I haven't noticed that you've fixed the race in v2.
> But then we can probably drop the WARN() and resetting the dying flag part, right?
>
> And because it's a backport-only patch I'd try to make it smaller
> (e.g. avoid introducing new helpers, etc) to simplify the back-porting to old kernels.

I agree with you. I will simplify the code.

> But it's up to you (and Andrew).
>
> Please, feel free to add
> Acked-by: Roman Gushchin <guro@fb.com>
> after dropping the dying flag reset part.

Ok, I will do that. Thanks.

>
> Thank you!



-- 
Yours,
Muchun
