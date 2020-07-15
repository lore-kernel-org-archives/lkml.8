Return-Path: <SRS0=kup7=A2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.0 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 78F4FC433E1
	for <linux-kernel@archiver.kernel.org>; Wed, 15 Jul 2020 16:31:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5349C2065E
	for <linux-kernel@archiver.kernel.org>; Wed, 15 Jul 2020 16:31:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=bytedance-com.20150623.gappssmtp.com header.i=@bytedance-com.20150623.gappssmtp.com header.b="uyXgsFd5"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726843AbgGOQbo (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 15 Jul 2020 12:31:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42174 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725792AbgGOQbj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Jul 2020 12:31:39 -0400
Received: from mail-pf1-x443.google.com (mail-pf1-x443.google.com [IPv6:2607:f8b0:4864:20::443])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 25CD9C061755
        for <linux-kernel@vger.kernel.org>; Wed, 15 Jul 2020 09:31:39 -0700 (PDT)
Received: by mail-pf1-x443.google.com with SMTP id x72so2321983pfc.6
        for <linux-kernel@vger.kernel.org>; Wed, 15 Jul 2020 09:31:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=53xi7g3puotGB363xy2OEXt6uuc0PRweN+NzFYccYkk=;
        b=uyXgsFd5yE0F3yTWoENRGh6XofWx6qEDC5ysullQoFZ4TlZApXCAZUsSkQJcKJSLpc
         tCaa1RS8UIbn8qmG39/lmXTGJAsqMK9V+gqdtH36JfsHjelGHd5nRvDrHB7cLerbmsgt
         uWp3W/RR1JSDRU9DV0VK1gILcgX0Ia+lybe3xV3anqWkaNdvudr7uhcDgmRG30HchXOs
         X3KfHMRbUj8qhEhhpv0fcLTGzds6B3Erxh0RDvCNf2AkPE9GhPtS7CflJWIMi2oC02LL
         2Ztott/QVRz50ZqOTqld80XF1JCKg58bpPWOr5NkRNO5ZqFL639FKYdYtMau2UNxcQFN
         r2OQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=53xi7g3puotGB363xy2OEXt6uuc0PRweN+NzFYccYkk=;
        b=JxlnE7oZjFXFP9H+jklLAnPMaANc3TfSRs0Swnlco7SzvOn3jlNS/grHEXmA/fxW/E
         tj2Li+zAM4IMc2HqLUzrHArfdY8UDrshTZi0YsHPGmPbKzKJqoOuDopJyLJjJZ3HGSDf
         ZmzGyZ5pAzKt6ottSQRQIdn+QRYVxA2Z16TnID6aA04bOSzB0wBNlKDHXucag/pOMo+V
         fjwAZlyN0cMvmaBhoDbxPrgPj6U1kKrNAGqxCmoq/iVpU2uCSXh6Kt35aJ2qDVSzWdVI
         a1JufRtDu3NLpGXu+YR7RO8U+za4nRDD796bIjksTnUGsk1rh8oJcwGpXkCKhsv+chDe
         3U4A==
X-Gm-Message-State: AOAM533w7YLmpvU7iKRbPEOMQI26QZXSR1cBpJaJJVEX2KbuoU1k9Rvf
        v9DNLMtuIUHoUf0MenXNj3grW7JFGvxw14FOaBB0HA==
X-Google-Smtp-Source: ABdhPJxUGp93WoplWQdqdBEzPCf01zWLhU2TGTWuQ1UTb/Kp9Zv/8T5yRUuQSVR/t1KT3ObYn2nEDfUFQWaP6ZKlbuc=
X-Received: by 2002:a63:cf49:: with SMTP id b9mr446382pgj.31.1594830698604;
 Wed, 15 Jul 2020 09:31:38 -0700 (PDT)
MIME-Version: 1.0
References: <20200707062754.8383-1-songmuchun@bytedance.com>
 <3d06418e-e75c-e7b8-91cd-ba56283045be@suse.cz> <20200715162445.GA4003@carbon.lan>
In-Reply-To: <20200715162445.GA4003@carbon.lan>
From:   Muchun Song <songmuchun@bytedance.com>
Date:   Thu, 16 Jul 2020 00:31:02 +0800
Message-ID: <CAMZfGtXfkCLrCEgkPM7a03OTP=ejZDPbrxBSb=u6raj6vQFLOg@mail.gmail.com>
Subject: Re: [External] Re: [PATCH v5.4.y, v4.19.y] mm: memcg/slab: fix memory
 leak at non-root kmem_cache destroy
To:     Roman Gushchin <guro@fb.com>
Cc:     Vlastimil Babka <vbabka@suse.cz>, Christoph Lameter <cl@linux.com>,
        Pekka Enberg <penberg@kernel.org>,
        David Rientjes <rientjes@google.com>,
        Joonsoo Kim <iamjoonsoo.kim@lge.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Linux Memory Management List <linux-mm@kvack.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Shakeel Butt <shakeelb@google.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jul 16, 2020 at 12:24 AM Roman Gushchin <guro@fb.com> wrote:
>
> On Wed, Jul 15, 2020 at 01:32:00PM +0200, Vlastimil Babka wrote:
> > On 7/7/20 8:27 AM, Muchun Song wrote:
> > > If the kmem_cache refcount is greater than one, we should not
> > > mark the root kmem_cache as dying. If we mark the root kmem_cache
> > > dying incorrectly, the non-root kmem_cache can never be destroyed.
> > > It resulted in memory leak when memcg was destroyed. We can use the
> > > following steps to reproduce.
> > >
> > >   1) Use kmem_cache_create() to create a new kmem_cache named A.
> > >   2) Coincidentally, the kmem_cache A is an alias for kmem_cache B,
> > >      so the refcount of B is just increased.
> > >   3) Use kmem_cache_destroy() to destroy the kmem_cache A, just
> > >      decrease the B's refcount but mark the B as dying.
> > >   4) Create a new memory cgroup and alloc memory from the kmem_cache
> > >      A. It leads to create a non-root kmem_cache for allocating.

Hi Roman,

I am sorry, here is a typo. I mean the step 4) allocates memory from
the kmem_cache
B instead of A.

> > >   5) When destroy the memory cgroup created in the step 4), the
> > >      non-root kmem_cache can never be destroyed.
>
> Hello, Muchun!
>
> If the scenario above is accurate, it means that somebody is allocating
> from the kmem_cache A (or it's memcg counterparts, doesn't matter) after
> calling kmem_cache_destroy()? If so, it's an API violation, and the following
> memory leak is a non-issue on the slab side. No one should allocate memory
> after calling kmem_cache_destroy(). It has to be called after all outstanding
> allocations are freed, and it should be literally the last operation
> with the kmem_cache.
>
> Kmem_cache aliasing/sharing, as well as memcg accounting implementation are
> implementation details and should not affect the picture.
>
> I wonder, did you see the problem in the wild? How does it look like?
> Which kmem_cache is involved? Etc.
>
> BTW, Vlastimil is absolutely right about stable backports and rework planned
> for 5.9, but let's figure out the problem first.
>
> Thank you!
>
> > >
> > > If we repeat steps 4) and 5), this will cause a lot of memory leak.
> > > So only when refcount reach zero, we mark the root kmem_cache as dying.
> > >
> > > Fixes: 92ee383f6daa ("mm: fix race between kmem_cache destroy, create and deactivate")
> > > Signed-off-by: Muchun Song <songmuchun@bytedance.com>
> >
> > CC Roman, who worked in this area recently.
> >
> > Also why is this marked "[PATCH v5.4.y, v4.19.y]"? Has it been fixed otherwise
> > in 5.5+ ?
> >
> > > ---
> > >  mm/slab_common.c | 43 +++++++++++++++++++++++++++++++++++++++++--
> > >  1 file changed, 41 insertions(+), 2 deletions(-)
> > >
> > > diff --git a/mm/slab_common.c b/mm/slab_common.c
> > > index 8c1ffbf7de45..83ee6211aec7 100644
> > > --- a/mm/slab_common.c
> > > +++ b/mm/slab_common.c
> > > @@ -258,6 +258,11 @@ static void memcg_unlink_cache(struct kmem_cache *s)
> > >             list_del(&s->memcg_params.kmem_caches_node);
> > >     }
> > >  }
> > > +
> > > +static inline bool memcg_kmem_cache_dying(struct kmem_cache *s)
> > > +{
> > > +   return is_root_cache(s) && s->memcg_params.dying;
> > > +}
> > >  #else
> > >  static inline int init_memcg_params(struct kmem_cache *s,
> > >                                 struct kmem_cache *root_cache)
> > > @@ -272,6 +277,11 @@ static inline void destroy_memcg_params(struct kmem_cache *s)
> > >  static inline void memcg_unlink_cache(struct kmem_cache *s)
> > >  {
> > >  }
> > > +
> > > +static inline bool memcg_kmem_cache_dying(struct kmem_cache *s)
> > > +{
> > > +   return false;
> > > +}
> > >  #endif /* CONFIG_MEMCG_KMEM */
> > >
> > >  /*
> > > @@ -326,6 +336,13 @@ int slab_unmergeable(struct kmem_cache *s)
> > >     if (s->refcount < 0)
> > >             return 1;
> > >
> > > +   /*
> > > +    * If the kmem_cache is dying. We should also skip this
> > > +    * kmem_cache.
> > > +    */
> > > +   if (memcg_kmem_cache_dying(s))
> > > +           return 1;
> > > +
> > >     return 0;
> > >  }
> > >
> > > @@ -944,8 +961,6 @@ void kmem_cache_destroy(struct kmem_cache *s)
> > >     if (unlikely(!s))
> > >             return;
> > >
> > > -   flush_memcg_workqueue(s);
> > > -
> > >     get_online_cpus();
> > >     get_online_mems();
> > >
> > > @@ -955,6 +970,30 @@ void kmem_cache_destroy(struct kmem_cache *s)
> > >     if (s->refcount)
> > >             goto out_unlock;
> > >
> > > +#ifdef CONFIG_MEMCG_KMEM
> > > +   mutex_unlock(&slab_mutex);
> > > +
> > > +   put_online_mems();
> > > +   put_online_cpus();
> > > +
> > > +   flush_memcg_workqueue(s);
> > > +
> > > +   get_online_cpus();
> > > +   get_online_mems();
> > > +
> > > +   mutex_lock(&slab_mutex);
> > > +
> > > +   if (WARN(s->refcount,
> > > +            "kmem_cache_destroy %s: Slab cache is still referenced\n",
> > > +            s->name)) {
> > > +           /*
> > > +            * Reset the dying flag setted by flush_memcg_workqueue().
> > > +            */
> > > +           s->memcg_params.dying = false;
> > > +           goto out_unlock;
> > > +   }
> > > +#endif
> > > +
> > >     err = shutdown_memcg_caches(s);
> > >     if (!err)
> > >             err = shutdown_cache(s);
> > >
> >



-- 
Yours,
Muchun
