Return-Path: <SRS0=3e5Q=77=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 993D4C433E0
	for <linux-kernel@archiver.kernel.org>; Thu, 18 Jun 2020 19:59:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 70BC520890
	for <linux-kernel@archiver.kernel.org>; Thu, 18 Jun 2020 19:59:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="XULNvT6F"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730254AbgFRT7M (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 18 Jun 2020 15:59:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49668 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728960AbgFRT7L (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 18 Jun 2020 15:59:11 -0400
Received: from mail-pf1-x442.google.com (mail-pf1-x442.google.com [IPv6:2607:f8b0:4864:20::442])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 171CCC06174E
        for <linux-kernel@vger.kernel.org>; Thu, 18 Jun 2020 12:59:11 -0700 (PDT)
Received: by mail-pf1-x442.google.com with SMTP id x22so3302637pfn.3
        for <linux-kernel@vger.kernel.org>; Thu, 18 Jun 2020 12:59:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=NuIms7ommfKNKxJYbi/ct0xZ5cyuMM901AG7daGbWL0=;
        b=XULNvT6F92FMMo9iyGJL8CF1BrkikQRi+FenTCQRI9Nph7bQeW+eq/JuXmuwdcA+eZ
         79o050QP4XtZyV6/mWWkThRN8kcPefW8G15jv7i1nXql7Zd9ci6J8u8DLufpYxbHI211
         i0cTyNAiVznYGfgi/wP+ZdQJV5Whii4Q3zkfU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=NuIms7ommfKNKxJYbi/ct0xZ5cyuMM901AG7daGbWL0=;
        b=IBJGIMFVy3GoSbZ5pRQS32UZUXDqMFoXp3D8mpppiqrTrpDzyFe9HjxdHFpPt3W5gU
         adEPTb4tetPX2KjpOMhy6sLXnvUpzPNzK4jZT6T970q8dAe5HzZ9gXvJFOryFXZUDsOO
         qZkXhDi1nAdT4vUv924BhX1UxTrFN/gkNSNYjamIPLk7qHsEiB+57mJLioDwMB9oObZr
         aUfs7L/OMGa1L9ivR+7LdXpPYn+hPI9aWeff23IuJ0MKy3hMxNCmC1dA9PV/2MppXURj
         Pwbrjnt7BtWIIIyCxUExGtgXsOMJoIENzx4MtIHZx/BIH3+dSkQiDqrueplj38Rdr6q+
         tv5w==
X-Gm-Message-State: AOAM5317kbMUepPr5e024O9GKL9KKeGRp+iNcLPGZgW+9knrVNEtQJFA
        hE5fG8FwETfP7+mVf7t1hAuxGw==
X-Google-Smtp-Source: ABdhPJz8XLWgrYM9tZwWuzWZXNBVoCNCfIeJy5xlziV9Uulng6I95BwzU3ViDlUUdPlC+3YzNRh85g==
X-Received: by 2002:a62:1444:: with SMTP id 65mr4909033pfu.294.1592510350493;
        Thu, 18 Jun 2020 12:59:10 -0700 (PDT)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id u4sm3578649pfl.102.2020.06.18.12.59.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 18 Jun 2020 12:59:09 -0700 (PDT)
Date:   Thu, 18 Jun 2020 12:59:08 -0700
From:   Kees Cook <keescook@chromium.org>
To:     Vlastimil Babka <vbabka@suse.cz>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Christoph Lameter <cl@linux.com>,
        Pekka Enberg <penberg@kernel.org>,
        David Rientjes <rientjes@google.com>,
        Joonsoo Kim <iamjoonsoo.kim@lge.com>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, kernel-team@android.com,
        vinmenon@codeaurora.org, Matthew Garrett <mjg59@google.com>,
        Roman Gushchin <guro@fb.com>, Jann Horn <jannh@google.com>,
        Vijayanand Jitta <vjitta@codeaurora.org>
Subject: Re: [PATCH 9/9] mm, slab/slub: move and improve cache_from_obj()
Message-ID: <202006181258.55DA8F6@keescook>
References: <20200610163135.17364-1-vbabka@suse.cz>
 <20200610163135.17364-10-vbabka@suse.cz>
 <202006171039.FBDF2D7F4A@keescook>
 <afeda7ac-748b-33d8-a905-56b708148ad5@suse.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <afeda7ac-748b-33d8-a905-56b708148ad5@suse.cz>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jun 18, 2020 at 12:10:38PM +0200, Vlastimil Babka wrote:
> 
> On 6/17/20 7:49 PM, Kees Cook wrote:
> > On Wed, Jun 10, 2020 at 06:31:35PM +0200, Vlastimil Babka wrote:
> >> The function cache_from_obj() was added by commit b9ce5ef49f00 ("sl[au]b:
> >> always get the cache from its page in kmem_cache_free()") to support kmemcg,
> >> where per-memcg cache can be different from the root one, so we can't use
> >> the kmem_cache pointer given to kmem_cache_free().
> >> 
> >> Prior to that commit, SLUB already had debugging check+warning that could be
> >> enabled to compare the given kmem_cache pointer to one referenced by the slab
> >> page where the object-to-be-freed resides. This check was moved to
> >> cache_from_obj(). Later the check was also enabled for SLAB_FREELIST_HARDENED
> >> configs by commit 598a0717a816 ("mm/slab: validate cache membership under
> >> freelist hardening").
> >> 
> >> These checks and warnings can be useful especially for the debugging, which can
> >> be improved. Commit 598a0717a816 changed the pr_err() with WARN_ON_ONCE() to
> >> WARN_ONCE() so only the first hit is now reported, others are silent. This
> >> patch changes it to WARN() so that all errors are reported.
> >> 
> >> It's also useful to print SLUB allocation/free tracking info for the offending
> >> object, if tracking is enabled. We could export the SLUB print_tracking()
> >> function and provide an empty one for SLAB, or realize that both the debugging
> >> and hardening cases in cache_from_obj() are only supported by SLUB anyway. So
> >> this patch moves cache_from_obj() from slab.h to separate instances in slab.c
> >> and slub.c, where the SLAB version only does the kmemcg lookup and even could
> > 
> > Oops. I made a mistake when I applied CONFIG_SLAB_FREELIST_HARDENED
> > here, I was thinking of SLAB_FREELIST_RANDOM's coverage (SLUB and SLAB),
> > and I see now that I never updated CONFIG_SLAB_FREELIST_HARDENED to
> > cover SLAB and SLOB.
> > 
> > The point being: I still want the sanity check for the SLAB case under
> > hardening. This needs to stay a common function. The whole point is
> > to catch corruption from the wrong kmem_cache * being associated with
> > an object, and that's agnostic of slab/slub/slob.
> > 
> > So, I'll send a follow-up to this patch to actually do what I had
> > originally intended for 598a0717a816 ("mm/slab: validate cache membership
> > under freelist hardening"), which wasn't intended to be SLUB-specific.
> 
> To prvent the churn of your patch moving the cache_from_obj() back to slab.h, I
> think it's best if we modify my patch. The patch below should be squashed into
> the current version in mmots, with the commit log used for the whole result.
> 
> This will cause conflicts while reapplying Roman's
> mm-memcg-slab-use-a-single-set-of-kmem_caches-for-all-allocations.patch which
> can be fixed by
> a) throwing away the conflicting hunks for cache_from_obj() in slab.c and slub.c
> b) applying this hunk instead:
> 
> --- a/mm/slab.h
> +++ b/mm/slab.h
> @@ -455,12 +455,11 @@ static inline struct kmem_cache *cache_from_obj(struct kmem_cache *s, void *x)
>  	struct kmem_cache *cachep;
>  
>  	if (!IS_ENABLED(CONFIG_SLAB_FREELIST_HARDENED) &&
> -	    !memcg_kmem_enabled() &&
>  	    !kmem_cache_debug_flags(s, SLAB_CONSISTENCY_CHECKS))
>  		return s;
>  
>  	cachep = virt_to_cache(x);
> -	if (WARN(cachep && !slab_equal_or_root(cachep, s),
> +	if (WARN(cachep && cachep != s,
>  		  "%s: Wrong slab cache. %s but object is from %s\n",
>  		  __func__, s->name, cachep->name))
>  		print_tracking(cachep, x);
> 
> The fixup patch itself:
> ----8<----
> From b8df607d92b37e5329ce7bda62b2b364cc249893 Mon Sep 17 00:00:00 2001
> From: Vlastimil Babka <vbabka@suse.cz>
> Date: Thu, 18 Jun 2020 11:52:03 +0200
> Subject: [PATCH] mm, slab/slub: improve error reporting and overhead of
>  cache_from_obj()
> 
> The function cache_from_obj() was added by commit b9ce5ef49f00 ("sl[au]b:
> always get the cache from its page in kmem_cache_free()") to support
> kmemcg, where per-memcg cache can be different from the root one, so we
> can't use the kmem_cache pointer given to kmem_cache_free().
> 
> Prior to that commit, SLUB already had debugging check+warning that could
> be enabled to compare the given kmem_cache pointer to one referenced by
> the slab page where the object-to-be-freed resides.  This check was moved
> to cache_from_obj().  Later the check was also enabled for
> SLAB_FREELIST_HARDENED configs by commit 598a0717a816 ("mm/slab: validate
> cache membership under freelist hardening").
> 
> These checks and warnings can be useful especially for the debugging,
> which can be improved.  Commit 598a0717a816 changed the pr_err() with
> WARN_ON_ONCE() to WARN_ONCE() so only the first hit is now reported,
> others are silent.  This patch changes it to WARN() so that all errors are
> reported.
> 
> It's also useful to print SLUB allocation/free tracking info for the offending
> object, if tracking is enabled. Thus, export the SLUB print_tracking() function
> and provide an empty one for SLAB.
> 
> For SLUB we can also benefit from the static key check in
> kmem_cache_debug_flags(), but we need to move this function to slab.h and
> declare the static key there.
> 
> [1] https://lore.kernel.org/r/20200608230654.828134-18-guro@fb.com
> 
> Signed-off-by: Vlastimil Babka <vbabka@suse.cz>

Acked-by: Kees Cook <keescook@chromium.org>

I will rebase my fix for SLAB_FREELIST_HARDENED coverage on this.

Thanks!

-- 
Kees Cook
