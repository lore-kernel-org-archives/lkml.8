Return-Path: <SRS0=mvbx=AL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.6 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 75987C433E0
	for <linux-kernel@archiver.kernel.org>; Tue, 30 Jun 2020 14:34:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 49FA820672
	for <linux-kernel@archiver.kernel.org>; Tue, 30 Jun 2020 14:34:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="raCbWFaC"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388983AbgF3Oe3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 30 Jun 2020 10:34:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54436 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726576AbgF3Oe1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Jun 2020 10:34:27 -0400
Received: from mail-lf1-x141.google.com (mail-lf1-x141.google.com [IPv6:2a00:1450:4864:20::141])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1C593C061755
        for <linux-kernel@vger.kernel.org>; Tue, 30 Jun 2020 07:34:27 -0700 (PDT)
Received: by mail-lf1-x141.google.com with SMTP id c21so11540541lfb.3
        for <linux-kernel@vger.kernel.org>; Tue, 30 Jun 2020 07:34:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=OPTfcG4gw86cqf+bXWQHwjUpVxHs9rAeEYQveC2K6mI=;
        b=raCbWFaCuFz4Sv4IKRxwMOi1UoN4AaBakxHisHY4kRbxVJPgmZHmux4KQJiNdv8mZr
         y0kvthOS2ycFUYlgUu1PnMMJElEa22KVSDvQu8kwT9mC0/PNiOKxOydniH2AeTK4VlWE
         C+lTLxHRX204/iQzKGZL+zH1/i0hnvVTjmJY52GEFz5c6ZuPaVUC4F4hENPnwXD2ctyy
         HNzKyT4FfwJqAGHTs4Xab9Li7TSPOHrP4W+QOMGS1Ra7a44eL8xrt7e9j0NNnsah26TK
         1j/qJ3MnVVO+UWtoR001X7XUOh6ckEeFSP91/fCRWCCwuIaojNszspnw1L+j7TPzMEH3
         Olkg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=OPTfcG4gw86cqf+bXWQHwjUpVxHs9rAeEYQveC2K6mI=;
        b=X6oIQu6DMZEdnHtJeDUVpHnDS53ZDNGGYgUTMsXAV4YIXAjCYbHf+mLttn9X/vA4pY
         eLfKItYKzeUvazo0sS4gby3yw/7B0wwvAwBnVPs8H05rn38lj9BrWyLekOpz6THdVxhg
         G5kyUrNJ5Ll3d9SZ2DengOcYgRXFh0BQHRcdAcFAtb5Gms9U1LGtBngIFJTdi10OVTe+
         xt6f0EOyYr/yol8dXwa12rrQhYc52b9/d9wZRVQ5C6PPeu4hX7AGfXZgIJABKiW49H87
         wgiCnaKOGULhvPk0HzuRo5G79m9oEg4ODLoF4uL7al4j96htJSBU9Eco6GdYpnQa4yTL
         Ymjw==
X-Gm-Message-State: AOAM5333YOwddFqdS6ggpxeaJpJJ9vW6tjf5+yDnuVr/j4VTULhOrXgi
        fJKTP8vHc7elo2cA9PLQxFvCbk0LL7JaZ9cGWPladw==
X-Google-Smtp-Source: ABdhPJxEtQ7b02opM+OEEbWfolNyhOMBpHCPwD4P+ZAcfj6npZoypHyKE8ttqJgbJ7zIyfUazosjvRwtQzPrKeh6m6E=
X-Received: by 2002:a19:be53:: with SMTP id o80mr1417943lff.33.1593527665209;
 Tue, 30 Jun 2020 07:34:25 -0700 (PDT)
MIME-Version: 1.0
References: <20200630004413.1423733-1-shakeelb@google.com> <20200630032353.GA26969@carbon.dhcp.thefacebook.com>
In-Reply-To: <20200630032353.GA26969@carbon.dhcp.thefacebook.com>
From:   Shakeel Butt <shakeelb@google.com>
Date:   Tue, 30 Jun 2020 07:34:13 -0700
Message-ID: <CALvZod6BMBuJrw2SnaUR8gWUzoX1NYnTC0=XbMYM+B_F4O5sUQ@mail.gmail.com>
Subject: Re: [PATCH] mm: memcontrol: account kernel stack per node
To:     Roman Gushchin <guro@fb.com>
Cc:     Johannes Weiner <hannes@cmpxchg.org>,
        Michal Hocko <mhocko@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Linux MM <linux-mm@kvack.org>,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jun 29, 2020 at 8:24 PM Roman Gushchin <guro@fb.com> wrote:
>
> On Mon, Jun 29, 2020 at 05:44:13PM -0700, Shakeel Butt wrote:
> > Currently the kernel stack is being accounted per-zone. There is no need
> > to do that. In addition due to being per-zone, memcg has to keep a
> > separate MEMCG_KERNEL_STACK_KB. Make the stat per-node and deprecate
> > MEMCG_KERNEL_STACK_KB as memcg_stat_item is an extension of
> > node_stat_item.
> >
> > Signed-off-by: Shakeel Butt <shakeelb@google.com>
> > ---
> >  drivers/base/node.c        |  4 ++--
> >  fs/proc/meminfo.c          |  4 ++--
> >  include/linux/memcontrol.h |  2 --
> >  include/linux/mmzone.h     |  8 ++++----
> >  kernel/fork.c              | 29 ++++++++++-------------------
> >  kernel/scs.c               |  2 +-
> >  mm/memcontrol.c            |  2 +-
> >  mm/page_alloc.c            | 16 ++++++++--------
> >  mm/vmstat.c                |  8 ++++----
> >  9 files changed, 32 insertions(+), 43 deletions(-)
> >
> > diff --git a/drivers/base/node.c b/drivers/base/node.c
> > index 0cf13e31603c..508b80f6329b 100644
> > --- a/drivers/base/node.c
> > +++ b/drivers/base/node.c
> > @@ -440,9 +440,9 @@ static ssize_t node_read_meminfo(struct device *dev,
> >                      nid, K(node_page_state(pgdat, NR_FILE_MAPPED)),
> >                      nid, K(node_page_state(pgdat, NR_ANON_MAPPED)),
> >                      nid, K(i.sharedram),
> > -                    nid, sum_zone_node_page_state(nid, NR_KERNEL_STACK_KB),
> > +                    nid, node_page_state(pgdat, NR_KERNEL_STACK_KB),
> >  #ifdef CONFIG_SHADOW_CALL_STACK
> > -                    nid, sum_zone_node_page_state(nid, NR_KERNEL_SCS_KB),
> > +                    nid, node_page_state(pgdat, NR_KERNEL_SCS_KB),
> >  #endif
> >                      nid, K(sum_zone_node_page_state(nid, NR_PAGETABLE)),
> >                      nid, 0UL,
> > diff --git a/fs/proc/meminfo.c b/fs/proc/meminfo.c
> > index f262bff3ca31..887a5532e449 100644
> > --- a/fs/proc/meminfo.c
> > +++ b/fs/proc/meminfo.c
> > @@ -101,10 +101,10 @@ static int meminfo_proc_show(struct seq_file *m, void *v)
> >       show_val_kb(m, "SReclaimable:   ", sreclaimable);
> >       show_val_kb(m, "SUnreclaim:     ", sunreclaim);
> >       seq_printf(m, "KernelStack:    %8lu kB\n",
> > -                global_zone_page_state(NR_KERNEL_STACK_KB));
> > +                global_node_page_state(NR_KERNEL_STACK_KB));
> >  #ifdef CONFIG_SHADOW_CALL_STACK
> >       seq_printf(m, "ShadowCallStack:%8lu kB\n",
> > -                global_zone_page_state(NR_KERNEL_SCS_KB));
> > +                global_node_page_state(NR_KERNEL_SCS_KB));
> >  #endif
> >       show_val_kb(m, "PageTables:     ",
> >                   global_zone_page_state(NR_PAGETABLE));
> > diff --git a/include/linux/memcontrol.h b/include/linux/memcontrol.h
> > index ba1e42715ecf..a3ddb236898e 100644
> > --- a/include/linux/memcontrol.h
> > +++ b/include/linux/memcontrol.h
> > @@ -33,8 +33,6 @@ enum memcg_stat_item {
> >       MEMCG_SWAP = NR_VM_NODE_STAT_ITEMS,
> >       MEMCG_SOCK,
> >       MEMCG_PERCPU_B,
> > -     /* XXX: why are these zone and not node counters? */
> > -     MEMCG_KERNEL_STACK_KB,
> >       MEMCG_NR_STAT,
> >  };
> >
> > diff --git a/include/linux/mmzone.h b/include/linux/mmzone.h
> > index 8e859444927a..b79f73ce8b57 100644
> > --- a/include/linux/mmzone.h
> > +++ b/include/linux/mmzone.h
> > @@ -153,10 +153,6 @@ enum zone_stat_item {
> >       NR_ZONE_WRITE_PENDING,  /* Count of dirty, writeback and unstable pages */
> >       NR_MLOCK,               /* mlock()ed pages found and moved off LRU */
> >       NR_PAGETABLE,           /* used for pagetables */
> > -     NR_KERNEL_STACK_KB,     /* measured in KiB */
> > -#if IS_ENABLED(CONFIG_SHADOW_CALL_STACK)
> > -     NR_KERNEL_SCS_KB,       /* measured in KiB */
> > -#endif
> >       /* Second 128 byte cacheline */
> >       NR_BOUNCE,
> >  #if IS_ENABLED(CONFIG_ZSMALLOC)
> > @@ -201,6 +197,10 @@ enum node_stat_item {
> >       NR_KERNEL_MISC_RECLAIMABLE,     /* reclaimable non-slab kernel pages */
> >       NR_FOLL_PIN_ACQUIRED,   /* via: pin_user_page(), gup flag: FOLL_PIN */
> >       NR_FOLL_PIN_RELEASED,   /* pages returned via unpin_user_page() */
> > +     NR_KERNEL_STACK_KB,     /* measured in KiB */
> > +#if IS_ENABLED(CONFIG_SHADOW_CALL_STACK)
> > +     NR_KERNEL_SCS_KB,       /* measured in KiB */
> > +#endif
> >       NR_VM_NODE_STAT_ITEMS
> >  };
> >
> > diff --git a/kernel/fork.c b/kernel/fork.c
> > index 73fdfa9674b5..ee5393350ef7 100644
> > --- a/kernel/fork.c
> > +++ b/kernel/fork.c
> > @@ -278,7 +278,7 @@ static inline void free_thread_stack(struct task_struct *tsk)
> >
> >               for (i = 0; i < THREAD_SIZE / PAGE_SIZE; i++) {
> >                       mod_memcg_page_state(vm->pages[i],
> > -                                          MEMCG_KERNEL_STACK_KB,
> > +                                          NR_KERNEL_STACK_KB,
> >                                            -(int)(PAGE_SIZE / 1024));
>
> Hello, Shakeel!
>
> Thank you for the cleanup, it makes total sense to me.
>
> However I have some concerns: mod_memcg_page_state() does change only memcg's counters,
> but not lruvec counters. So to make it per-node per-memcg (aka  lruvec)
> we need to use mod_lruvec_state(), otherwise we won't have global per-node values.
>
> >
> >                       memcg_kmem_uncharge_page(vm->pages[i], 0);
> > @@ -381,32 +381,23 @@ static void account_kernel_stack(struct task_struct *tsk, int account)
> >  {
> >       void *stack = task_stack_page(tsk);
> >       struct vm_struct *vm = task_stack_vm_area(tsk);
> > +     struct page *page;
> >
> >       BUILD_BUG_ON(IS_ENABLED(CONFIG_VMAP_STACK) && PAGE_SIZE % 1024 != 0);
> >
> >       if (vm) {
> > -             int i;
> > -
> >               BUG_ON(vm->nr_pages != THREAD_SIZE / PAGE_SIZE);
> > +             page = vm->pages[0];
> >
> > -             for (i = 0; i < THREAD_SIZE / PAGE_SIZE; i++) {
> > -                     mod_zone_page_state(page_zone(vm->pages[i]),
> > -                                         NR_KERNEL_STACK_KB,
> > -                                         PAGE_SIZE / 1024 * account);
> > -             }
> >       } else {
> > -             /*
> > -              * All stack pages are in the same zone and belong to the
> > -              * same memcg.
> > -              */
> > -             struct page *first_page = virt_to_page(stack);
> > -
> > -             mod_zone_page_state(page_zone(first_page), NR_KERNEL_STACK_KB,
> > -                                 THREAD_SIZE / 1024 * account);
> > -
> > -             mod_memcg_obj_state(stack, MEMCG_KERNEL_STACK_KB,
> > +             page = virt_to_page(stack);
> > +             mod_memcg_obj_state(stack, NR_KERNEL_STACK_KB,
> >                                   account * (THREAD_SIZE / 1024));
> >       }
> > +
> > +     /* All stack pages are in the same node. */
> > +     mod_node_page_state(page_pgdat(page), NR_KERNEL_STACK_KB,
> > +                         THREAD_SIZE / 1024 * account);
> >  }
>
> And then we probably don't need a separate change for memcg- and per-node counters.
>

Yes, I thought about combining memcg and per-node counters but got
worried that the cached stacks for CONFIG_VMAP_STACK would not be
accounted for in the per-node global counters but I see that we
already don't account for them in both counters. I will further
simplify these. Thanks for the suggestion.

Shakeel
