Return-Path: <SRS0=ABJN=6Z=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BB109C54E8D
	for <linux-kernel@archiver.kernel.org>; Mon, 11 May 2020 14:19:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8F3D620736
	for <linux-kernel@archiver.kernel.org>; Mon, 11 May 2020 14:19:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="FpIqnthq"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730432AbgEKOTt (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 11 May 2020 10:19:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38020 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726173AbgEKOTt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 May 2020 10:19:49 -0400
Received: from mail-qk1-x742.google.com (mail-qk1-x742.google.com [IPv6:2607:f8b0:4864:20::742])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C5891C061A0C
        for <linux-kernel@vger.kernel.org>; Mon, 11 May 2020 07:19:47 -0700 (PDT)
Received: by mail-qk1-x742.google.com with SMTP id n14so9849552qke.8
        for <linux-kernel@vger.kernel.org>; Mon, 11 May 2020 07:19:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=jwYtW81/ygzueOYMSAUrciWMI3nlvA3U3h7VebjOjDI=;
        b=FpIqnthqKF6E1nISw5GZZh3DtLh1jggOsu/LZg/KsCwXgytz8jgcdAODXSqltynbVP
         oU8PoTIDbTOaHqoiCMQ7JsPkbF3Md+xoZqtwpbt2qsS0SVr1l1szMyTO5sgsxlpOpTyn
         LgOpm0F+qu3xHCvowehNBVtHO+BX2nzdfCbsq7KD3xbYE1VdKDNsDc+jS57o1g4+Q3Mh
         JPsl1F0PZyLgptdp14qMNh6v+8q4ZEXWPirSD9KL1vO7f9z5kjeq0hrCgpouSs7F9m7K
         MazERd4z8Vs9UN9GaFQLkCU+Ks02ir7N2sC3AWOy1NhXQUOMJowTYPlPCjjQKBCwXYJj
         AfYQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=jwYtW81/ygzueOYMSAUrciWMI3nlvA3U3h7VebjOjDI=;
        b=aB+ezRZQlRHlZOzKTOZSFAkl6CudSefjRcWJShGpx2HO21+hO5QSU//nrOaqwVCJEJ
         iglyrkUnsVp5lgMYYwJBU+9XDH05AvduEQy1oXtxGzion/F+1gv6wTrJ6E9mlwUvhx1P
         C4dDu1upYb82nElyqhRXXWVttVtnped9JaJxVgdjj5L5+AND5ObDoWRlOul1qEbM+C1j
         +f9HCYuX3y3OEQ7apoRUUCn10uPXLSX66dihMP0Q9NQNN3nqEyOpH1pvHfwPDPZP6Z7X
         jRg9PaerkSHC9HzfHpu7EHc8wcvblfIOwmmPSLUAZcF4v9xRYBzt33idnOC/8p0UK+SX
         Kdig==
X-Gm-Message-State: AGi0PuayZ4hfMaIno7+gWVrfAaLFweG2mdSh4q3mWW4NvhDKLu4nUEkK
        R3NGjrrNyp+/Dqzd09R4/kb3oXgraWtTN+2/sxBN+Q==
X-Google-Smtp-Source: APiQypIH1miSFLYzpZvavTEDFqwR+yYPqlsx9M/06lTpRbDRXGn+u5f/FXgEP1uLFEQLt/xiVaW00GBa8fZ9ZGPzbEA=
X-Received: by 2002:ae9:f401:: with SMTP id y1mr16758561qkl.8.1589206786606;
 Mon, 11 May 2020 07:19:46 -0700 (PDT)
MIME-Version: 1.0
References: <20200511023111.15310-1-walter-zh.wu@mediatek.com>
 <CACT4Y+YWNwTSoheJhc3nMdQi9m719F3PzpGo3TfRY3zAg9EwuQ@mail.gmail.com>
 <CACT4Y+bO1Zg_jgFHbOWgp7fLAADOQ_-AZmjEHz0WG7=oyOt4Gg@mail.gmail.com> <1589203771.21284.22.camel@mtksdccf07>
In-Reply-To: <1589203771.21284.22.camel@mtksdccf07>
From:   Dmitry Vyukov <dvyukov@google.com>
Date:   Mon, 11 May 2020 16:19:34 +0200
Message-ID: <CACT4Y+aOkuH6Dn+L+wv1qVOLgXyCY_Ck4hecAMw3DgyBgC9qHw@mail.gmail.com>
Subject: Re: [PATCH v2 1/3] rcu/kasan: record and print call_rcu() call stack
To:     Walter Wu <walter-zh.wu@mediatek.com>
Cc:     Andrey Ryabinin <aryabinin@virtuozzo.com>,
        Alexander Potapenko <glider@google.com>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        "Paul E . McKenney" <paulmck@kernel.org>,
        Josh Triplett <josh@joshtriplett.org>,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        Lai Jiangshan <jiangshanlai@gmail.com>,
        Joel Fernandes <joel@joelfernandes.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        kasan-dev <kasan-dev@googlegroups.com>,
        Linux-MM <linux-mm@kvack.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, May 11, 2020 at 3:29 PM Walter Wu <walter-zh.wu@mediatek.com> wrote:
> > > This feature will record first and last call_rcu() call stack and
> > > print two call_rcu() call stack in KASAN report.
> > >
> > > When call_rcu() is called, we store the call_rcu() call stack into
> > > slub alloc meta-data, so that KASAN report can print rcu stack.
> > >
> > > It doesn't increase the cost of memory consumption. Because we don't
> > > enlarge struct kasan_alloc_meta size.
> > > - add two call_rcu() call stack into kasan_alloc_meta, size is 8 bytes.
> > > - remove free track from kasan_alloc_meta, size is 8 bytes.
> > >
> > > [1]https://bugzilla.kernel.org/show_bug.cgi?id=198437
> > > [2]https://groups.google.com/forum/#!searchin/kasan-dev/better$20stack$20traces$20for$20rcu%7Csort:date/kasan-dev/KQsjT_88hDE/7rNUZprRBgAJ
> > >
> > > Signed-off-by: Walter Wu <walter-zh.wu@mediatek.com>
> > > Suggested-by: Dmitry Vyukov <dvyukov@google.com>
> > > Cc: Andrey Ryabinin <aryabinin@virtuozzo.com>
> > > Cc: Dmitry Vyukov <dvyukov@google.com>
> > > Cc: Alexander Potapenko <glider@google.com>
> > > Cc: Andrew Morton <akpm@linux-foundation.org>
> > > Cc: Paul E. McKenney <paulmck@kernel.org>
> > > Cc: Josh Triplett <josh@joshtriplett.org>
> > > Cc: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
> > > Cc: Lai Jiangshan <jiangshanlai@gmail.com>
> > > Cc: Joel Fernandes <joel@joelfernandes.org>
> > > ---
> > >  include/linux/kasan.h |  2 ++
> > >  kernel/rcu/tree.c     |  3 +++
> > >  lib/Kconfig.kasan     |  2 ++
> > >  mm/kasan/common.c     |  4 ++--
> > >  mm/kasan/generic.c    | 29 +++++++++++++++++++++++++++++
> > >  mm/kasan/kasan.h      | 19 +++++++++++++++++++
> > >  mm/kasan/report.c     | 21 +++++++++++++++++----
> > >  7 files changed, 74 insertions(+), 6 deletions(-)
> > >
> > > diff --git a/include/linux/kasan.h b/include/linux/kasan.h
> > > index 31314ca7c635..23b7ee00572d 100644
> > > --- a/include/linux/kasan.h
> > > +++ b/include/linux/kasan.h
> > > @@ -174,11 +174,13 @@ static inline size_t kasan_metadata_size(struct kmem_cache *cache) { return 0; }
> > >
> > >  void kasan_cache_shrink(struct kmem_cache *cache);
> > >  void kasan_cache_shutdown(struct kmem_cache *cache);
> > > +void kasan_record_aux_stack(void *ptr);
> > >
> > >  #else /* CONFIG_KASAN_GENERIC */
> > >
> > >  static inline void kasan_cache_shrink(struct kmem_cache *cache) {}
> > >  static inline void kasan_cache_shutdown(struct kmem_cache *cache) {}
> > > +static inline void kasan_record_aux_stack(void *ptr) {}
> > >
> > >  #endif /* CONFIG_KASAN_GENERIC */
> > >
> > > diff --git a/kernel/rcu/tree.c b/kernel/rcu/tree.c
> > > index 06548e2ebb72..de872b6cc261 100644
> > > --- a/kernel/rcu/tree.c
> > > +++ b/kernel/rcu/tree.c
> > > @@ -57,6 +57,7 @@
> > >  #include <linux/slab.h>
> > >  #include <linux/sched/isolation.h>
> > >  #include <linux/sched/clock.h>
> > > +#include <linux/kasan.h>
> > >  #include "../time/tick-internal.h"
> > >
> > >  #include "tree.h"
> > > @@ -2694,6 +2695,8 @@ __call_rcu(struct rcu_head *head, rcu_callback_t func)
> > >                 trace_rcu_callback(rcu_state.name, head,
> > >                                    rcu_segcblist_n_cbs(&rdp->cblist));
> > >
> > > +       kasan_record_aux_stack(head);
> > > +
> > >         /* Go handle any RCU core processing required. */
> > >         if (IS_ENABLED(CONFIG_RCU_NOCB_CPU) &&
> > >             unlikely(rcu_segcblist_is_offloaded(&rdp->cblist))) {
> > > diff --git a/lib/Kconfig.kasan b/lib/Kconfig.kasan
> > > index 81f5464ea9e1..56a89291f1cc 100644
> > > --- a/lib/Kconfig.kasan
> > > +++ b/lib/Kconfig.kasan
> > > @@ -58,6 +58,8 @@ config KASAN_GENERIC
> > >           For better error detection enable CONFIG_STACKTRACE.
> > >           Currently CONFIG_KASAN_GENERIC doesn't work with CONFIG_DEBUG_SLAB
> > >           (the resulting kernel does not boot).
> > > +         Currently CONFIG_KASAN_GENERIC will print first and last call_rcu()
> > > +         call stack. It doesn't increase the cost of memory consumption.
> > >
> > >  config KASAN_SW_TAGS
> > >         bool "Software tag-based mode"
> > > diff --git a/mm/kasan/common.c b/mm/kasan/common.c
> > > index 2906358e42f0..8bc618289bb1 100644
> > > --- a/mm/kasan/common.c
> > > +++ b/mm/kasan/common.c
> > > @@ -41,7 +41,7 @@
> > >  #include "kasan.h"
> > >  #include "../slab.h"
> > >
> > > -static inline depot_stack_handle_t save_stack(gfp_t flags)
> > > +depot_stack_handle_t kasan_save_stack(gfp_t flags)
> > >  {
> > >         unsigned long entries[KASAN_STACK_DEPTH];
> > >         unsigned int nr_entries;
> > > @@ -54,7 +54,7 @@ static inline depot_stack_handle_t save_stack(gfp_t flags)
> > >  static inline void set_track(struct kasan_track *track, gfp_t flags)
> > >  {
> > >         track->pid = current->pid;
> > > -       track->stack = save_stack(flags);
> > > +       track->stack = kasan_save_stack(flags);
> > >  }
> > >
> > >  void kasan_enable_current(void)
> > > diff --git a/mm/kasan/generic.c b/mm/kasan/generic.c
> > > index 56ff8885fe2e..b86880c338e2 100644
> > > --- a/mm/kasan/generic.c
> > > +++ b/mm/kasan/generic.c
> > > @@ -325,3 +325,32 @@ DEFINE_ASAN_SET_SHADOW(f2);
> > >  DEFINE_ASAN_SET_SHADOW(f3);
> > >  DEFINE_ASAN_SET_SHADOW(f5);
> > >  DEFINE_ASAN_SET_SHADOW(f8);
> > > +
> > > +void kasan_record_aux_stack(void *addr)
> > > +{
> > > +       struct page *page = kasan_addr_to_page(addr);
> > > +       struct kmem_cache *cache;
> > > +       struct kasan_alloc_meta *alloc_info;
> > > +       void *object;
> > > +
> > > +       if (!(page && PageSlab(page)))
> > > +               return;
> > > +
> > > +       cache = page->slab_cache;
> > > +       object = nearest_obj(cache, page, addr);
> > > +       alloc_info = get_alloc_info(cache, object);
> > > +
> > > +       if (!alloc_info->rcu_stack[0])
> > > +               /* record first call_rcu() call stack */
> > > +               alloc_info->rcu_stack[0] = kasan_save_stack(GFP_NOWAIT);
> > > +       else
> > > +               /* record last call_rcu() call stack */
> > > +               alloc_info->rcu_stack[1] = kasan_save_stack(GFP_NOWAIT);
> > > +}
> > > +
> > > +struct kasan_track *kasan_get_aux_stack(struct kasan_alloc_meta *alloc_info,
> > > +                                               u8 idx)
> > > +{
> > > +       return container_of(&alloc_info->rcu_stack[idx],
> > > +                                               struct kasan_track, stack);
> > > +}
> > > diff --git a/mm/kasan/kasan.h b/mm/kasan/kasan.h
> > > index e8f37199d885..1cc1fb7b0de3 100644
> > > --- a/mm/kasan/kasan.h
> > > +++ b/mm/kasan/kasan.h
> > > @@ -96,15 +96,28 @@ struct kasan_track {
> > >         depot_stack_handle_t stack;
> > >  };
> > >
> > > +#ifdef CONFIG_KASAN_GENERIC
> > > +#define SIZEOF_PTR sizeof(void *)
> >
> > Please move this to generic.c closer to kasan_set_free_info.
> > Unnecessary in the header.
> >
> > > +#define KASAN_NR_RCU_CALL_STACKS 2
> >
> > Since KASAN_NR_RCU_CALL_STACKS is only used once below, you could as
> > well use 2 instead of it.
> > Reduces level of indirection and cognitive load.
> >
> > > +#else /* CONFIG_KASAN_GENERIC */
> > >  #ifdef CONFIG_KASAN_SW_TAGS_IDENTIFY
> > >  #define KASAN_NR_FREE_STACKS 5
> > >  #else
> > >  #define KASAN_NR_FREE_STACKS 1
> > >  #endif
> > > +#endif /* CONFIG_KASAN_GENERIC */
> > >
> > >  struct kasan_alloc_meta {
> > >         struct kasan_track alloc_track;
> > > +#ifdef CONFIG_KASAN_GENERIC
> > > +       /*
> > > +        * call_rcu() call stack is stored into struct kasan_alloc_meta.
> > > +        * The free stack is stored into freed object.
> > > +        */
> > > +       depot_stack_handle_t rcu_stack[KASAN_NR_RCU_CALL_STACKS];
> > > +#else
> > >         struct kasan_track free_track[KASAN_NR_FREE_STACKS];
> > > +#endif
> > >  #ifdef CONFIG_KASAN_SW_TAGS_IDENTIFY
> > >         u8 free_pointer_tag[KASAN_NR_FREE_STACKS];
> > >         u8 free_track_idx;
> > > @@ -159,16 +172,22 @@ void kasan_report_invalid_free(void *object, unsigned long ip);
> > >
> > >  struct page *kasan_addr_to_page(const void *addr);
> > >
> > > +depot_stack_handle_t kasan_save_stack(gfp_t flags);
> > > +
> > >  #if defined(CONFIG_KASAN_GENERIC) && \
> > >         (defined(CONFIG_SLAB) || defined(CONFIG_SLUB))
> > >  void quarantine_put(struct kasan_free_meta *info, struct kmem_cache *cache);
> > >  void quarantine_reduce(void);
> > >  void quarantine_remove_cache(struct kmem_cache *cache);
> > > +struct kasan_track *kasan_get_aux_stack(struct kasan_alloc_meta *alloc_info,
> > > +                       u8 idx);
> > >  #else
> > >  static inline void quarantine_put(struct kasan_free_meta *info,
> > >                                 struct kmem_cache *cache) { }
> > >  static inline void quarantine_reduce(void) { }
> > >  static inline void quarantine_remove_cache(struct kmem_cache *cache) { }
> > > +static inline struct kasan_track *kasan_get_aux_stack(
> > > +                       struct kasan_alloc_meta *alloc_info, u8 idx) { return NULL; }
> > >  #endif
> > >
> > >  #ifdef CONFIG_KASAN_SW_TAGS
> > > diff --git a/mm/kasan/report.c b/mm/kasan/report.c
> > > index 80f23c9da6b0..f16a1a210815 100644
> > > --- a/mm/kasan/report.c
> > > +++ b/mm/kasan/report.c
> > > @@ -105,9 +105,13 @@ static void end_report(unsigned long *flags)
> > >         kasan_enable_current();
> > >  }
> > >
> > > -static void print_track(struct kasan_track *track, const char *prefix)
> > > +static void print_track(struct kasan_track *track, const char *prefix,
> > > +                                               bool is_callrcu)
> > >  {
> > > -       pr_err("%s by task %u:\n", prefix, track->pid);
> > > +       if (is_callrcu)
> > > +               pr_err("%s:\n", prefix);
> > > +       else
> > > +               pr_err("%s by task %u:\n", prefix, track->pid);
> > >         if (track->stack) {
> > >                 unsigned long *entries;
> > >                 unsigned int nr_entries;
> > > @@ -187,11 +191,20 @@ static void describe_object(struct kmem_cache *cache, void *object,
> > >         if (cache->flags & SLAB_KASAN) {
> > >                 struct kasan_track *free_track;
> > >
> > > -               print_track(&alloc_info->alloc_track, "Allocated");
> > > +               print_track(&alloc_info->alloc_track, "Allocated", false);
> > >                 pr_err("\n");
> > >                 free_track = kasan_get_free_track(cache, object, tag);
> > > -               print_track(free_track, "Freed");
> > > +               print_track(free_track, "Freed", false);
> > >                 pr_err("\n");
> > > +
> > > +               if (IS_ENABLED(CONFIG_KASAN_GENERIC)) {
> > > +                       free_track = kasan_get_aux_stack(alloc_info, 0);
> > > +                       print_track(free_track, "First call_rcu() call stack", true);
> > > +                       pr_err("\n");
> > > +                       free_track = kasan_get_aux_stack(alloc_info, 1);
> > > +                       print_track(free_track, "Last call_rcu() call stack", true);
> > > +                       pr_err("\n");
> > > +               }
> > >         }
> > >
> > >         describe_object_addr(cache, object, addr);
>
> Some higher level comments.
>
> 1. I think we need to put the free track into kasan_free_meta as it
> was before. It looks like exactly the place for it. We have logic to
> properly place it and to do the casts.
>
>
> If the free track put kasan_free_meta, then it increase slab meta size?
> Our original goal does not enlarge it.

Are you sure it will increase object size?
I think we overlap kasan_free_meta with the object as well. The only
case we don't overlap kasan_free_meta with the object are
SLAB_TYPESAFE_BY_RCU || cache->ctor. But these are rare and it should
only affect small objects with small redzones.
And I think now we simply have a bug for these objects, we check
KASAN_KMALLOC_FREE and then assume object contains free stack, but for
objects with ctor, they still contain live object data, we don't store
free stack in them.
Such objects can be both free and still contain user data.


> 2. We need to zero aux stacks when we reallocate the object. Otherwise
> we print confusing garbage.
>
> My local has an UT about use-after-free and rcu, but it is hard to test the printing confusing garbage, because we may need to get the same object(old pointer and new pointer). In generic KASAN is not easy to get it.
>
> 3. __kasan_slab_free now contains a window of inconsistency when it
> marked the object as KASAN_KMALLOC_FREE, but did not store the free
> track yet. If another thread prints a report now, it will print random
> garbage.
>
>
> It is possible, but the window is so tiny. It sets free track immediately after write the KASAN_KMALLOC_FREE.

It is small. But (1) why do we want to allow it at all, (2) there is
actually a more serious problem. If we mark an object as
KASAN_KMALLOC_FREE, but don't do kasan_set_free_info (because object
has ctor), now we will treat live object data as free track. We need
to fix it anyway.




> 4. We need some tests. At least (2) should be visible on tests.
>
>
> Ok.
