Return-Path: <SRS0=Xj+s=AD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.6 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_IN_DEF_DKIM_WL
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8E967C433E1
	for <linux-kernel@archiver.kernel.org>; Mon, 22 Jun 2020 21:04:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6753A2073E
	for <linux-kernel@archiver.kernel.org>; Mon, 22 Jun 2020 21:04:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="anju6xJ8"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730544AbgFVVEo (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 22 Jun 2020 17:04:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34088 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730418AbgFVVEn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 Jun 2020 17:04:43 -0400
Received: from mail-lj1-x244.google.com (mail-lj1-x244.google.com [IPv6:2a00:1450:4864:20::244])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ECFBFC061573
        for <linux-kernel@vger.kernel.org>; Mon, 22 Jun 2020 14:04:42 -0700 (PDT)
Received: by mail-lj1-x244.google.com with SMTP id e4so20974405ljn.4
        for <linux-kernel@vger.kernel.org>; Mon, 22 Jun 2020 14:04:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=fYVGKPR2yU3JPe9oC0azgd3CTmHpa/y89mhXYHW9wOc=;
        b=anju6xJ8xizXgJoCiTCnr62/0hAVWt3tpba4VyB6Uu9GK/quThrDtveIseHGA5X+Hx
         MHhJEkugGqGAwkV9gvcFL823g5O30pgKXNXrG4xWoULSSZzNLLxOtI6FgXpRuA6sf8S2
         XX2bzJ0RDkZCbbWp3CYgUrn64SoCpHtmwPCtIrBFS9D/7vKecrd68meKjXc2bmaRGm1A
         yMglRixHcYUZGT9f0vSdR+PyagzF0x0vh4HwUk4N5ak+B0bz5n2os88+AM9Oe4Nhf0tN
         zAzlI4J0w8zw1CvOFKRuACxatkqhNujZhqsHG6+FQPTjpxgkPTYC7MiWUx+anq6pESfq
         l7hQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=fYVGKPR2yU3JPe9oC0azgd3CTmHpa/y89mhXYHW9wOc=;
        b=T6xYnvh3DVwFvxEC76MTmlXfq0asd0rq3VFb00FjGWr1drGMxXojN9r2nhMnKkNlTI
         FSfzNHX1kRlkd9PiIQ69+Nl9ej0YylslAibB7f25U9Z+ZMiv6uswdxYJCmVxw5y7bdEk
         QUn+tNAbyxiqQGPtceW7yZpSy92qOrK8D7NNPJbWdPRiDYUeBGArzx8473nF+iE4ErU8
         d9NJckt29sMHc+GMKhKziHTzYRAXZPcVudBvW1FJFeWhZnvzVIT4StyyDjnsrhByd8ye
         TaH4B1nSksJSzi0LIw1qpNfroghbZSo8DkqoUDH8iIqJkCgCnBvtH9iRxIGzaOfLImVS
         dROw==
X-Gm-Message-State: AOAM532RadtjCay1sXCDj56rmnffX47jNGM4f9SL1ro7zDRK361LJ2X0
        GdAKxtVzptGOn77SXHgxJWW6N2bARy77XnUsvptgQw==
X-Google-Smtp-Source: ABdhPJz9bNAC+mLgBDdJqkEuTqKjqlvEz9k5KOq+isP5jeWorPFWcbqMRtUoB41EmAVXoOuyUixh03WTuQhHHbZe3n8=
X-Received: by 2002:a2e:960b:: with SMTP id v11mr9655771ljh.77.1592859881138;
 Mon, 22 Jun 2020 14:04:41 -0700 (PDT)
MIME-Version: 1.0
References: <20200608230654.828134-1-guro@fb.com> <20200608230654.828134-18-guro@fb.com>
 <CALvZod5NCCpt2rkyXXr69OnVXb9ew7875vAV=iWZdqJhXcKEWQ@mail.gmail.com> <20200622203739.GD301338@carbon.dhcp.thefacebook.com>
In-Reply-To: <20200622203739.GD301338@carbon.dhcp.thefacebook.com>
From:   Shakeel Butt <shakeelb@google.com>
Date:   Mon, 22 Jun 2020 14:04:29 -0700
Message-ID: <CALvZod5powO1Zph0+iO+=gtNb7=MQqfHwYkdb-+PkaVCGhuf=g@mail.gmail.com>
Subject: Re: [PATCH v6 17/19] mm: memcg/slab: use a single set of kmem_caches
 for all allocations
To:     Roman Gushchin <guro@fb.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Christoph Lameter <cl@linux.com>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Michal Hocko <mhocko@kernel.org>,
        Linux MM <linux-mm@kvack.org>,
        Vlastimil Babka <vbabka@suse.cz>,
        Kernel Team <kernel-team@fb.com>,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jun 22, 2020 at 1:37 PM Roman Gushchin <guro@fb.com> wrote:
>
> On Mon, Jun 22, 2020 at 12:21:28PM -0700, Shakeel Butt wrote:
> > On Mon, Jun 8, 2020 at 4:07 PM Roman Gushchin <guro@fb.com> wrote:
> > >
> > > Instead of having two sets of kmem_caches: one for system-wide and
> > > non-accounted allocations and the second one shared by all accounted
> > > allocations, we can use just one.
> > >
> > > The idea is simple: space for obj_cgroup metadata can be allocated
> > > on demand and filled only for accounted allocations.
> > >
> > > It allows to remove a bunch of code which is required to handle
> > > kmem_cache clones for accounted allocations. There is no more need
> > > to create them, accumulate statistics, propagate attributes, etc.
> > > It's a quite significant simplification.
> > >
> > > Also, because the total number of slab_caches is reduced almost twice
> > > (not all kmem_caches have a memcg clone), some additional memory
> > > savings are expected. On my devvm it additionally saves about 3.5%
> > > of slab memory.
> > >
> > > Suggested-by: Johannes Weiner <hannes@cmpxchg.org>
> > > Signed-off-by: Roman Gushchin <guro@fb.com>
> > > Reviewed-by: Vlastimil Babka <vbabka@suse.cz>
> > > ---
> > [snip]
> > >  static inline void memcg_slab_post_alloc_hook(struct kmem_cache *s,
> > >                                               struct obj_cgroup *objcg,
> > > -                                             size_t size, void **p)
> > > +                                             gfp_t flags, size_t size,
> > > +                                             void **p)
> > >  {
> > >         struct page *page;
> > >         unsigned long off;
> > >         size_t i;
> > >
> > > +       if (!objcg)
> > > +               return;
> > > +
> > > +       flags &= ~__GFP_ACCOUNT;
> > >         for (i = 0; i < size; i++) {
> > >                 if (likely(p[i])) {
> > >                         page = virt_to_head_page(p[i]);
> > > +
> > > +                       if (!page_has_obj_cgroups(page) &&
> >
> > The page is already linked into the kmem_cache, don't you need
> > synchronization for memcg_alloc_page_obj_cgroups().
>
> Hm, yes, in theory we need it. I guess the reason behind why I've never seen any issues
> here is the SLUB percpu partial list.
>
> So in theory we need something like:
>
> diff --git a/mm/slab.h b/mm/slab.h
> index 0a31600a0f5c..44bf57815816 100644
> --- a/mm/slab.h
> +++ b/mm/slab.h
> @@ -237,7 +237,10 @@ static inline int memcg_alloc_page_obj_cgroups(struct page *page,
>         if (!vec)
>                 return -ENOMEM;
>
> -       page->obj_cgroups = (struct obj_cgroup **) ((unsigned long)vec | 0x1UL);
> +       if (cmpxchg(&page->obj_cgroups, 0,
> +                   (struct obj_cgroup **) ((unsigned long)vec | 0x1UL)))
> +               kfree(vec);
> +
>         return 0;
>  }
>
>
> But I wonder if we might put it under #ifdef CONFIG_SLAB?
> Or any other ideas how to make it less expensive?
>
> > What's the reason to remove this from charge_slab_page()?
>
> Because at charge_slab_page() we don't know if we'll ever need
> page->obj_cgroups. Some caches might have only few or even zero
> accounted objects.
>

If slab_pre_alloc_hook() returns a non-NULL objcg then we definitely
need page->obj_cgroups.  The charge_slab_page() happens between
slab_pre_alloc_hook() & slab_post_alloc_hook(), so, we should be able
to tell if page->obj_cgroups is needed.
