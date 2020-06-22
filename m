Return-Path: <SRS0=Xj+s=AD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.6 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_IN_DEF_DKIM_WL autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2DF4FC433E1
	for <linux-kernel@archiver.kernel.org>; Mon, 22 Jun 2020 22:05:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id F40F920708
	for <linux-kernel@archiver.kernel.org>; Mon, 22 Jun 2020 22:05:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="qSJCCJiO"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730955AbgFVWFo (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 22 Jun 2020 18:05:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43566 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730689AbgFVWFo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 Jun 2020 18:05:44 -0400
Received: from mail-lj1-x242.google.com (mail-lj1-x242.google.com [IPv6:2a00:1450:4864:20::242])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C4378C061573
        for <linux-kernel@vger.kernel.org>; Mon, 22 Jun 2020 15:05:43 -0700 (PDT)
Received: by mail-lj1-x242.google.com with SMTP id z9so21105283ljh.13
        for <linux-kernel@vger.kernel.org>; Mon, 22 Jun 2020 15:05:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Fjks+xycIsjc5Pzu2hz2xgWkMGG8+0ukNqlFtZjxmxU=;
        b=qSJCCJiOyjgrk91v3NNxA/VmLsGRQSAz/5iVqji9qKcUlOk/pjsZvS9JXPG7GrqGi7
         wwfCBzRWznGt+SDrqHW7o9SVhCEWgoPvTMzRcpfxKgFUMg3ZHVrGEjJ86mdyg9uppznk
         sdjRyBwsorbMJBlP0NcjrkgfWJcOoAzUKcmnbaussJnxc4wlLgRF/02ZIo7+81OOBub4
         kHpFEbF20vJqOBIZ8VTq0T0XOnZmZF77NCdVy5TLRyPbeWV2+E95Dp2dQa1RFKOiJiS/
         fe8kcLoklSpT6MMn5M/b2SiiDpclKtoGiKJpDhqKMsNyS9i+WBedKqKnps79tq6TOxdt
         3QZQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Fjks+xycIsjc5Pzu2hz2xgWkMGG8+0ukNqlFtZjxmxU=;
        b=IP5LCE7y6CpQW7svoROK9s+Im1HNjQK6++fz3eFhgG6zr6yWEoQou7lIRem432z6P2
         YQP2A4Yl63ObT5/f9vHeV/z2B7HDNfOimwNjLh1dXbrc3aSx8RN9sAhwZb6UiBo23Iln
         bydOa6YL3JdjYZ+Hc1RGsAejzD1LAqicrzFF+PX73BkRrutmsZSG2UkCCBXjtPpp5EhH
         kAk9Y4UFc8PDdQNCP3gsbhq0YHJX/zJ5Akfx7dNWZIwWsaJrGT3DV80vA37Tx8z1oM4f
         KVKca0xAnE3w3wYZ9DnhBgL7a9soUdWiG/wndufJv3YLHNXldbkcUaQJuN8Zxrv8e3PE
         sUEA==
X-Gm-Message-State: AOAM532UVrb8UyfOBhXFSlC8xgUdmYp2ERezHJqDnveRVtMnegZqT7Tm
        R+22bZvGZ7MLIwNfsjFXX8IK+d85IqgAGU3XU/nHrHU3IGc=
X-Google-Smtp-Source: ABdhPJzNNXQyEwCuuDgZXlLKbFFu91rPI2CZOO+4b9oR50z1vH9qfjV/O0Q580JCmqbYuOfCGPGUux9ML+w2um48pB0=
X-Received: by 2002:a2e:b0e9:: with SMTP id h9mr10007844ljl.460.1592863541924;
 Mon, 22 Jun 2020 15:05:41 -0700 (PDT)
MIME-Version: 1.0
References: <20200608230654.828134-1-guro@fb.com> <20200608230654.828134-18-guro@fb.com>
 <CALvZod5NCCpt2rkyXXr69OnVXb9ew7875vAV=iWZdqJhXcKEWQ@mail.gmail.com>
 <20200622203739.GD301338@carbon.dhcp.thefacebook.com> <CALvZod5powO1Zph0+iO+=gtNb7=MQqfHwYkdb-+PkaVCGhuf=g@mail.gmail.com>
 <20200622211356.GF301338@carbon.dhcp.thefacebook.com> <CALvZod4aEgbP-CPd3=dC3922SGiYBdEMCm_tsGt5xZUx1ekTDQ@mail.gmail.com>
 <20200622215800.GA326762@carbon.DHCP.thefacebook.com>
In-Reply-To: <20200622215800.GA326762@carbon.DHCP.thefacebook.com>
From:   Shakeel Butt <shakeelb@google.com>
Date:   Mon, 22 Jun 2020 15:05:30 -0700
Message-ID: <CALvZod5bi-inSZj99Qb2yL-8QhGqWog6Mj-BmN=v9=nhBuTsvQ@mail.gmail.com>
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

On Mon, Jun 22, 2020 at 2:58 PM Roman Gushchin <guro@fb.com> wrote:
>
> On Mon, Jun 22, 2020 at 02:28:54PM -0700, Shakeel Butt wrote:
> > On Mon, Jun 22, 2020 at 2:15 PM Roman Gushchin <guro@fb.com> wrote:
> > >
> > > On Mon, Jun 22, 2020 at 02:04:29PM -0700, Shakeel Butt wrote:
> > > > On Mon, Jun 22, 2020 at 1:37 PM Roman Gushchin <guro@fb.com> wrote:
> > > > >
> > > > > On Mon, Jun 22, 2020 at 12:21:28PM -0700, Shakeel Butt wrote:
> > > > > > On Mon, Jun 8, 2020 at 4:07 PM Roman Gushchin <guro@fb.com> wrote:
> > > > > > >
> > > > > > > Instead of having two sets of kmem_caches: one for system-wide and
> > > > > > > non-accounted allocations and the second one shared by all accounted
> > > > > > > allocations, we can use just one.
> > > > > > >
> > > > > > > The idea is simple: space for obj_cgroup metadata can be allocated
> > > > > > > on demand and filled only for accounted allocations.
> > > > > > >
> > > > > > > It allows to remove a bunch of code which is required to handle
> > > > > > > kmem_cache clones for accounted allocations. There is no more need
> > > > > > > to create them, accumulate statistics, propagate attributes, etc.
> > > > > > > It's a quite significant simplification.
> > > > > > >
> > > > > > > Also, because the total number of slab_caches is reduced almost twice
> > > > > > > (not all kmem_caches have a memcg clone), some additional memory
> > > > > > > savings are expected. On my devvm it additionally saves about 3.5%
> > > > > > > of slab memory.
> > > > > > >
> > > > > > > Suggested-by: Johannes Weiner <hannes@cmpxchg.org>
> > > > > > > Signed-off-by: Roman Gushchin <guro@fb.com>
> > > > > > > Reviewed-by: Vlastimil Babka <vbabka@suse.cz>
> > > > > > > ---
> > > > > > [snip]
> > > > > > >  static inline void memcg_slab_post_alloc_hook(struct kmem_cache *s,
> > > > > > >                                               struct obj_cgroup *objcg,
> > > > > > > -                                             size_t size, void **p)
> > > > > > > +                                             gfp_t flags, size_t size,
> > > > > > > +                                             void **p)
> > > > > > >  {
> > > > > > >         struct page *page;
> > > > > > >         unsigned long off;
> > > > > > >         size_t i;
> > > > > > >
> > > > > > > +       if (!objcg)
> > > > > > > +               return;
> > > > > > > +
> > > > > > > +       flags &= ~__GFP_ACCOUNT;
> > > > > > >         for (i = 0; i < size; i++) {
> > > > > > >                 if (likely(p[i])) {
> > > > > > >                         page = virt_to_head_page(p[i]);
> > > > > > > +
> > > > > > > +                       if (!page_has_obj_cgroups(page) &&
> > > > > >
> > > > > > The page is already linked into the kmem_cache, don't you need
> > > > > > synchronization for memcg_alloc_page_obj_cgroups().
> > > > >
> > > > > Hm, yes, in theory we need it. I guess the reason behind why I've never seen any issues
> > > > > here is the SLUB percpu partial list.
> > > > >
> > > > > So in theory we need something like:
> > > > >
> > > > > diff --git a/mm/slab.h b/mm/slab.h
> > > > > index 0a31600a0f5c..44bf57815816 100644
> > > > > --- a/mm/slab.h
> > > > > +++ b/mm/slab.h
> > > > > @@ -237,7 +237,10 @@ static inline int memcg_alloc_page_obj_cgroups(struct page *page,
> > > > >         if (!vec)
> > > > >                 return -ENOMEM;
> > > > >
> > > > > -       page->obj_cgroups = (struct obj_cgroup **) ((unsigned long)vec | 0x1UL);
> > > > > +       if (cmpxchg(&page->obj_cgroups, 0,
> > > > > +                   (struct obj_cgroup **) ((unsigned long)vec | 0x1UL)))
> > > > > +               kfree(vec);
> > > > > +
> > > > >         return 0;
> > > > >  }
> > > > >
> > > > >
> > > > > But I wonder if we might put it under #ifdef CONFIG_SLAB?
> > > > > Or any other ideas how to make it less expensive?
> > > > >
> > > > > > What's the reason to remove this from charge_slab_page()?
> > > > >
> > > > > Because at charge_slab_page() we don't know if we'll ever need
> > > > > page->obj_cgroups. Some caches might have only few or even zero
> > > > > accounted objects.
> > > > >
> > > >
> > > > If slab_pre_alloc_hook() returns a non-NULL objcg then we definitely
> > > > need page->obj_cgroups.  The charge_slab_page() happens between
> > > > slab_pre_alloc_hook() & slab_post_alloc_hook(), so, we should be able
> > > > to tell if page->obj_cgroups is needed.
> > >
> > > Yes, but the opposite is not always true: we can reuse the existing page
> > > without allocated page->obj_cgroups. In this case charge_slab_page() is
> > > not involved at all.
> > >
> >
> > Hmm yeah, you are right. I missed that.
> >
> > >
> > > Or do you mean that we can minimize the amount of required synchronization
> > > by allocating some obj_cgroups vectors from charge_slab_page()?
> >
> > One optimization would be to always pre-allocate page->obj_cgroups for
> > kmem_caches with SLAB_ACCOUNT.
>
> Even this is not completely memory overhead-free, because processes belonging
> to the root cgroup and kthreads might allocate from such cache.
>

Yes, not completely memory overhead-free but please note that in the
containerized world, running in the root container is discouraged and
for SLAB_ACCOUNT kmem_caches, processes from root container and
kthreads should be very rare.

>
> Anyway, I think I'll go with cmpxchg() for now and will think about possible
> optimizations later.

I agree to think about optimizations later (particularly such
heuristics based optimizations).
