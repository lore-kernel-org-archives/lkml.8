Return-Path: <SRS0=bWCJ=AA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1B582C433E0
	for <linux-kernel@archiver.kernel.org>; Fri, 19 Jun 2020 19:02:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E172C20EDD
	for <linux-kernel@archiver.kernel.org>; Fri, 19 Jun 2020 19:02:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="hTeyg9KI"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389667AbgFSTCv (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 19 Jun 2020 15:02:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36772 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2389482AbgFSTCu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 19 Jun 2020 15:02:50 -0400
Received: from mail-pf1-x443.google.com (mail-pf1-x443.google.com [IPv6:2607:f8b0:4864:20::443])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 77FACC06174E
        for <linux-kernel@vger.kernel.org>; Fri, 19 Jun 2020 12:02:50 -0700 (PDT)
Received: by mail-pf1-x443.google.com with SMTP id d66so4810095pfd.6
        for <linux-kernel@vger.kernel.org>; Fri, 19 Jun 2020 12:02:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=y88OIJPCn3bdGjlWNOS2D2hXU5xfD9J8tKoU+uD6w5g=;
        b=hTeyg9KIqP3ZcTjLGl0cQApNQXJmHKQ2r8FidUL/ofMjK/xz9GbDvkVrJvimevAfcK
         WB9qVWbZc4ty2PuOgfWXQaYRV61KiQiiWjHLayh1dXApyZr7YKFWhMjOg4LxHovwwFAc
         kyMlcq36D8NvEa/CTDaxJNeeue3gcuCZcK7Bg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=y88OIJPCn3bdGjlWNOS2D2hXU5xfD9J8tKoU+uD6w5g=;
        b=nDd2cvSKnKTcJFRE2L+5nZGXjstfm8fzmFh+YrXwjELKoAjuK9Cxxk0J90rRsqNEo1
         ZlApgwsZkm2lmcZWRH1jwpoCiSOR12GvtXcqSh/rYY69aKtXBCeFDwR45Nr8IOd0OMpd
         9ANlMhwm840oYVehYYpRWD1wtlWurfZngYK0H7oIcsWrTxxnaNncx1Wu83iG17hekJlf
         GNjCbOWe9TDXOzdpfigtUG+UqnpgI1sn8Z+2DQLoroLNFhT4B0uRE70tSZRYB8IDVw8T
         tbCx6eGGNe71zhwavusGd26mi59YnB170bu8B7raqax+XalK55c20h/Ikb4sazOufGMC
         JVYw==
X-Gm-Message-State: AOAM533eJyYK+Z5xmlEr0GWlXSRNvxp/uq6G/eaexky6Rj1baie32Lvp
        G4il24QfdX7mbO7A9dbJZtnGGQ==
X-Google-Smtp-Source: ABdhPJwB9RinVh5E47GeHYSZms715oYMTalXTkTjLEmR5JFVuO2zR0zFZcdB9rPzV2tdyK+OIoZT9g==
X-Received: by 2002:aa7:81c4:: with SMTP id c4mr9962563pfn.188.1592593369591;
        Fri, 19 Jun 2020 12:02:49 -0700 (PDT)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id k2sm5669389pgm.11.2020.06.19.12.02.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 19 Jun 2020 12:02:48 -0700 (PDT)
Date:   Fri, 19 Jun 2020 12:02:47 -0700
From:   Kees Cook <keescook@chromium.org>
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     Vlastimil Babka <vbabka@suse.cz>, Roman Gushchin <guro@fb.com>,
        Christoph Lameter <cl@linux.com>,
        Pekka Enberg <penberg@kernel.org>,
        David Rientjes <rientjes@google.com>,
        Joonsoo Kim <iamjoonsoo.kim@lge.com>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, kernel-team@android.com,
        vinmenon@codeaurora.org, Matthew Garrett <mjg59@google.com>,
        Jann Horn <jannh@google.com>,
        Vijayanand Jitta <vjitta@codeaurora.org>
Subject: Re: [PATCH 9/9] mm, slab/slub: move and improve cache_from_obj()
Message-ID: <202006191201.C30D8AAFB@keescook>
References: <20200610163135.17364-1-vbabka@suse.cz>
 <20200610163135.17364-10-vbabka@suse.cz>
 <202006171039.FBDF2D7F4A@keescook>
 <afeda7ac-748b-33d8-a905-56b708148ad5@suse.cz>
 <20200618200553.GE110603@carbon.dhcp.thefacebook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200618200553.GE110603@carbon.dhcp.thefacebook.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jun 18, 2020 at 01:05:53PM -0700, Roman Gushchin wrote:
> On Thu, Jun 18, 2020 at 12:10:38PM +0200, Vlastimil Babka wrote:
> > To prvent the churn of your patch moving the cache_from_obj() back to slab.h, I
> > think it's best if we modify my patch. The patch below should be squashed into
> > the current version in mmots, with the commit log used for the whole result.
> > 
> > This will cause conflicts while reapplying Roman's
> > mm-memcg-slab-use-a-single-set-of-kmem_caches-for-all-allocations.patch which
> > can be fixed by
> > a) throwing away the conflicting hunks for cache_from_obj() in slab.c and slub.c
> > b) applying this hunk instead:
> > 
> > --- a/mm/slab.h
> > +++ b/mm/slab.h
> > @@ -455,12 +455,11 @@ static inline struct kmem_cache *cache_from_obj(struct kmem_cache *s, void *x)
> >  	struct kmem_cache *cachep;
> >  
> >  	if (!IS_ENABLED(CONFIG_SLAB_FREELIST_HARDENED) &&
> > -	    !memcg_kmem_enabled() &&
> >  	    !kmem_cache_debug_flags(s, SLAB_CONSISTENCY_CHECKS))
> >  		return s;
> >  
> >  	cachep = virt_to_cache(x);
> > -	if (WARN(cachep && !slab_equal_or_root(cachep, s),
> > +	if (WARN(cachep && cachep != s,
> >  		  "%s: Wrong slab cache. %s but object is from %s\n",
> >  		  __func__, s->name, cachep->name))
> >  		print_tracking(cachep, x);
> > 
> > The fixup patch itself:
> > ----8<----
> > From b8df607d92b37e5329ce7bda62b2b364cc249893 Mon Sep 17 00:00:00 2001
> > From: Vlastimil Babka <vbabka@suse.cz>
> > Date: Thu, 18 Jun 2020 11:52:03 +0200
> > Subject: [PATCH] mm, slab/slub: improve error reporting and overhead of
> >  cache_from_obj()

Andrew, do you need this separately, or can you extract this fixup from
this thread?

-Kees

> > 
> > The function cache_from_obj() was added by commit b9ce5ef49f00 ("sl[au]b:
> > always get the cache from its page in kmem_cache_free()") to support
> > kmemcg, where per-memcg cache can be different from the root one, so we
> > can't use the kmem_cache pointer given to kmem_cache_free().
> > 
> > Prior to that commit, SLUB already had debugging check+warning that could
> > be enabled to compare the given kmem_cache pointer to one referenced by
> > the slab page where the object-to-be-freed resides.  This check was moved
> > to cache_from_obj().  Later the check was also enabled for
> > SLAB_FREELIST_HARDENED configs by commit 598a0717a816 ("mm/slab: validate
> > cache membership under freelist hardening").
> > 
> > These checks and warnings can be useful especially for the debugging,
> > which can be improved.  Commit 598a0717a816 changed the pr_err() with
> > WARN_ON_ONCE() to WARN_ONCE() so only the first hit is now reported,
> > others are silent.  This patch changes it to WARN() so that all errors are
> > reported.
> > 
> > It's also useful to print SLUB allocation/free tracking info for the offending
> > object, if tracking is enabled. Thus, export the SLUB print_tracking() function
> > and provide an empty one for SLAB.
> > 
> > For SLUB we can also benefit from the static key check in
> > kmem_cache_debug_flags(), but we need to move this function to slab.h and
> > declare the static key there.
> > 
> > [1] https://lore.kernel.org/r/20200608230654.828134-18-guro@fb.com
> > 
> > Signed-off-by: Vlastimil Babka <vbabka@suse.cz>
> 
> Acked-by: Roman Gushchin <guro@fb.com>
> 
> Thanks!
> 
> > ---
> >  mm/slab.c |  8 --------
> >  mm/slab.h | 45 +++++++++++++++++++++++++++++++++++++++++++++
> >  mm/slub.c | 38 +-------------------------------------
> >  3 files changed, 46 insertions(+), 45 deletions(-)
> > 
> > diff --git a/mm/slab.c b/mm/slab.c
> > index 6134c4c36d4c..9350062ffc1a 100644
> > --- a/mm/slab.c
> > +++ b/mm/slab.c
> > @@ -3672,14 +3672,6 @@ void *__kmalloc_track_caller(size_t size, gfp_t flags, unsigned long caller)
> >  }
> >  EXPORT_SYMBOL(__kmalloc_track_caller);
> >  
> > -static inline struct kmem_cache *cache_from_obj(struct kmem_cache *s, void *x)
> > -{
> > -	if (memcg_kmem_enabled())
> > -		return virt_to_cache(x);
> > -	else
> > -		return s;
> > -}
> > -
> >  /**
> >   * kmem_cache_free - Deallocate an object
> >   * @cachep: The cache the allocation was from.
> > diff --git a/mm/slab.h b/mm/slab.h
> > index a2696d306b62..a9f5ba9ce9a7 100644
> > --- a/mm/slab.h
> > +++ b/mm/slab.h
> > @@ -275,6 +275,34 @@ static inline int cache_vmstat_idx(struct kmem_cache *s)
> >  		NR_SLAB_RECLAIMABLE : NR_SLAB_UNRECLAIMABLE;
> >  }
> >  
> > +#ifdef CONFIG_SLUB_DEBUG
> > +#ifdef CONFIG_SLUB_DEBUG_ON
> > +DECLARE_STATIC_KEY_TRUE(slub_debug_enabled);
> > +#else
> > +DECLARE_STATIC_KEY_FALSE(slub_debug_enabled);
> > +#endif
> > +extern void print_tracking(struct kmem_cache *s, void *object);
> > +#else
> > +static inline void print_tracking(struct kmem_cache *s, void *object)
> > +{
> > +}
> > +#endif
> > +
> > +/*
> > + * Returns true if any of the specified slub_debug flags is enabled for the
> > + * cache. Use only for flags parsed by setup_slub_debug() as it also enables
> > + * the static key.
> > + */
> > +static inline bool kmem_cache_debug_flags(struct kmem_cache *s, slab_flags_t flags)
> > +{
> > +	VM_WARN_ON_ONCE(!(flags & SLAB_DEBUG_FLAGS));
> > +#ifdef CONFIG_SLUB_DEBUG
> > +	if (static_branch_unlikely(&slub_debug_enabled))
> > +		return s->flags & flags;
> > +#endif
> > +	return false;
> > +}
> > +
> >  #ifdef CONFIG_MEMCG_KMEM
> >  
> >  /* List of all root caches. */
> > @@ -503,6 +531,23 @@ static __always_inline void uncharge_slab_page(struct page *page, int order,
> >  	memcg_uncharge_slab(page, order, s);
> >  }
> >  
> > +static inline struct kmem_cache *cache_from_obj(struct kmem_cache *s, void *x)
> > +{
> > +	struct kmem_cache *cachep;
> > +
> > +	if (!IS_ENABLED(CONFIG_SLAB_FREELIST_HARDENED) &&
> > +	    !memcg_kmem_enabled() &&
> > +	    !kmem_cache_debug_flags(s, SLAB_CONSISTENCY_CHECKS))
> > +		return s;
> > +
> > +	cachep = virt_to_cache(x);
> > +	if (WARN(cachep && !slab_equal_or_root(cachep, s),
> > +		  "%s: Wrong slab cache. %s but object is from %s\n",
> > +		  __func__, s->name, cachep->name))
> > +		print_tracking(cachep, x);
> > +	return cachep;
> > +}
> > +
> >  static inline size_t slab_ksize(const struct kmem_cache *s)
> >  {
> >  #ifndef CONFIG_SLUB
> > diff --git a/mm/slub.c b/mm/slub.c
> > index 202fb423d195..0e635a8aa340 100644
> > --- a/mm/slub.c
> > +++ b/mm/slub.c
> > @@ -122,21 +122,6 @@ DEFINE_STATIC_KEY_FALSE(slub_debug_enabled);
> >  #endif
> >  #endif
> >  
> > -/*
> > - * Returns true if any of the specified slub_debug flags is enabled for the
> > - * cache. Use only for flags parsed by setup_slub_debug() as it also enables
> > - * the static key.
> > - */
> > -static inline bool kmem_cache_debug_flags(struct kmem_cache *s, slab_flags_t flags)
> > -{
> > -	VM_WARN_ON_ONCE(!(flags & SLAB_DEBUG_FLAGS));
> > -#ifdef CONFIG_SLUB_DEBUG
> > -	if (static_branch_unlikely(&slub_debug_enabled))
> > -		return s->flags & flags;
> > -#endif
> > -	return false;
> > -}
> > -
> >  static inline bool kmem_cache_debug(struct kmem_cache *s)
> >  {
> >  	return kmem_cache_debug_flags(s, SLAB_DEBUG_FLAGS);
> > @@ -653,7 +638,7 @@ static void print_track(const char *s, struct track *t, unsigned long pr_time)
> >  #endif
> >  }
> >  
> > -static void print_tracking(struct kmem_cache *s, void *object)
> > +void print_tracking(struct kmem_cache *s, void *object)
> >  {
> >  	unsigned long pr_time = jiffies;
> >  	if (!(s->flags & SLAB_STORE_USER))
> > @@ -1525,10 +1510,6 @@ static bool freelist_corrupted(struct kmem_cache *s, struct page *page,
> >  {
> >  	return false;
> >  }
> > -
> > -static void print_tracking(struct kmem_cache *s, void *object)
> > -{
> > -}
> >  #endif /* CONFIG_SLUB_DEBUG */
> >  
> >  /*
> > @@ -3180,23 +3161,6 @@ void ___cache_free(struct kmem_cache *cache, void *x, unsigned long addr)
> >  }
> >  #endif
> >  
> > -static inline struct kmem_cache *cache_from_obj(struct kmem_cache *s, void *x)
> > -{
> > -	struct kmem_cache *cachep;
> > -
> > -	if (!IS_ENABLED(CONFIG_SLAB_FREELIST_HARDENED) &&
> > -	    !memcg_kmem_enabled() &&
> > -	    !kmem_cache_debug_flags(s, SLAB_CONSISTENCY_CHECKS))
> > -		return s;
> > -
> > -	cachep = virt_to_cache(x);
> > -	if (WARN(cachep && !slab_equal_or_root(cachep, s),
> > -		  "%s: Wrong slab cache. %s but object is from %s\n",
> > -		  __func__, s->name, cachep->name))
> > -		print_tracking(cachep, x);
> > -	return cachep;
> > -}
> > -
> >  void kmem_cache_free(struct kmem_cache *s, void *x)
> >  {
> >  	s = cache_from_obj(s, x);
> > -- 
> > 2.27.0
> > 
> > 

-- 
Kees Cook
