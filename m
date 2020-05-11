Return-Path: <SRS0=ABJN=6Z=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4B6CBC47255
	for <linux-kernel@archiver.kernel.org>; Mon, 11 May 2020 13:00:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 13A1A20736
	for <linux-kernel@archiver.kernel.org>; Mon, 11 May 2020 13:00:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="FNDoh0Xb"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729930AbgEKNA5 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 11 May 2020 09:00:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53842 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1727827AbgEKNA4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 May 2020 09:00:56 -0400
Received: from mail-qv1-xf43.google.com (mail-qv1-xf43.google.com [IPv6:2607:f8b0:4864:20::f43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BF824C061A0C
        for <linux-kernel@vger.kernel.org>; Mon, 11 May 2020 06:00:56 -0700 (PDT)
Received: by mail-qv1-xf43.google.com with SMTP id di6so4383527qvb.10
        for <linux-kernel@vger.kernel.org>; Mon, 11 May 2020 06:00:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=6iIZrDd6XH1XLz+64Z2moZtoJrkxBoPg7cIT5TImjAQ=;
        b=FNDoh0Xbx+W2llYRnkncA+zVSkcxVv1viBD5Avh1g4/QuvgJ4+EoLmeiFyGtGCP11c
         jJDUAjNsbRS7cZKD8pUaXJ55VCGoG/rglmG9VlWPPPVHyfDpMm+z1N5vJPE5F5YZQo12
         ANjad62dX8TLluO0gtTtNUVzOk+MNSYW0uTWwLR2CF1Pm5RC9wnlku8qaPs41gxsoEgc
         uuPblIIJR0QKs57EpqjfeQkeImwDwk3dlYxFmSVV6XOF4Xi/qO16Tr75qA8F32L2UF6h
         g8ivF/n1uwBS+IdeN2Ck+QczvZSUOZF6Ne5KTfSnrQpV/SUHLDl3CGDc2SeC0/mQbTCX
         M6Rw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=6iIZrDd6XH1XLz+64Z2moZtoJrkxBoPg7cIT5TImjAQ=;
        b=T/Zy+VotDV+Rx5lw0Yt4JTBmzYpKh2Sn+kidqa6rk0i8nHx7w334UDUdRdal9w4mBZ
         JuAbx9b8BZFFwx+rD4W32k7fWf5Wibx+mUnTtXx1RonND9vfFrmLHCjZIqcMqI/w6UP/
         3QEZb8SEhANolDtfPC0Pw0XrJXT3Sl/USVV/kuvPX1eWhQdF3M0JK3CnYNEg4Gt+QO43
         ky9C7Vpftr93z4fJBS9sMhOKY2HmgtZ1l5QHzcergG2r05FQw2HG9hjYEoGf3kKj2b1b
         vlHZ4wPLtgaMSNY194uIkl3YFpZC74E16rjLUe3rZpB/D/9BvtLXlyV11GyOdBrISRTe
         gbNg==
X-Gm-Message-State: AGi0PuaWHUmwNjsgcIUVzZMV/zRc3ZhNtg9RSm8d+eN5rzgj5vshd9YI
        HWhy+BIVeQb1cfVu5ERO9Bli6TH1i/T4WGxtWfEs7g==
X-Google-Smtp-Source: APiQypKhDM1WRiILAT6KGCbVC4ZL7KxEMybSiJDW34NhEELPfwDqclEOyNIJj+JfJ5m5T6e4YgUr6sBXYIRmzWH6ctw=
X-Received: by 2002:a0c:db03:: with SMTP id d3mr5440031qvk.80.1589202055213;
 Mon, 11 May 2020 06:00:55 -0700 (PDT)
MIME-Version: 1.0
References: <20200511023111.15310-1-walter-zh.wu@mediatek.com>
 <CACT4Y+beDTzGrDx9uWSjbr67j0encwBa_1PKpyQCejiddLhOxA@mail.gmail.com> <1589201640.21284.8.camel@mtksdccf07>
In-Reply-To: <1589201640.21284.8.camel@mtksdccf07>
From:   Dmitry Vyukov <dvyukov@google.com>
Date:   Mon, 11 May 2020 15:00:43 +0200
Message-ID: <CACT4Y+Y3sYbN6mbWcNDm=FhQx3XJb-e7EGB82oYG-Tyvg2BXKw@mail.gmail.com>
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
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        wsd_upstream <wsd_upstream@mediatek.com>,
        linux-mediatek@lists.infradead.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, May 11, 2020 at 2:54 PM Walter Wu <walter-zh.wu@mediatek.com> wrote:
>
> On Mon, 2020-05-11 at 14:20 +0200, 'Dmitry Vyukov' via kasan-dev wrote:
> > On Mon, May 11, 2020 at 4:31 AM Walter Wu <walter-zh.wu@mediatek.com> wrote:
> > >
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
> >
> > This is not type safe, there is no kasan_track object. And we create a
> > pointer to kasan_track just to carefully not treat it as valid
> > kasan_track in print_track.
> >
>
> Good catch.
>
> > This adds an unnecessary if to print_track. And does not seem to be
> > useful/nice to print:
> >
> > First call_rcu() call stack:
> > (stack is not available)
> >
> > Last call_rcu() call stack:
> > (stack is not available)
> >
> > when no rcu stacks are memorized.
> > Your intention seems to be to reuse 2 lines of code from print_track.
> > I would factor them out into a function:
> >
> > static void print_stack(depot_stack_handle_t stack)
> > {
> >         unsigned long *entries;
> >         unsigned int nr_entries;
> >
> >         nr_entries = stack_depot_fetch(stack, &entries);
> >         stack_trace_print(entries, nr_entries, 0);
> > }
> >
> > And then this can expressed as:
> >
> >         if (IS_ENABLED(CONFIG_KASAN_GENERIC)) {
> >             stack = alloc_info->rcu_stack[0];
> >             if (stack) {
> >                 pr_err("First call_rcu() call stack:\n");
> >                 print_stack(stack);
> >                 pr_err("\n");
> >             }
> >             stack = alloc_info->rcu_stack[1];
> >             if (stack) {
> >                 pr_err("Last call_rcu() call stack:\n");
> >                 print_stack(stack);
> >                 pr_err("\n");
> >             }
> >         }
> >
>
> rcu_stack doesn't exist at report.c, it need at generic.c,
> otherwise it will have build error, unless add the #ifdef GENERIC_KASAN
>
> Maybe we can make kasan_get_aux_stack() return NULL? then print_stack()
> determine whether it will print aux stack.


I would put all this under #ifdef CONFIG_KASAN_GENERIC now.


> > Or with another helper function it becomes:
> >
> >         if (IS_ENABLED(CONFIG_KASAN_GENERIC)) {
> >             print_aux_stack(alloc_info->rcu_stack[0], "First");
> >             print_aux_stack(alloc_info->rcu_stack[1], "Last");
> >         }
> >
> >
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
> > > +#define KASAN_NR_RCU_CALL_STACKS 2
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
> > > --
> > > 2.18.0
> > >
> > > --
> > > You received this message because you are subscribed to the Google Groups "kasan-dev" group.
> > > To unsubscribe from this group and stop receiving emails from it, send an email to kasan-dev+unsubscribe@googlegroups.com.
> > > To view this discussion on the web visit https://groups.google.com/d/msgid/kasan-dev/20200511023111.15310-1-walter-zh.wu%40mediatek.com.
> >
>
> --
> You received this message because you are subscribed to the Google Groups "kasan-dev" group.
> To unsubscribe from this group and stop receiving emails from it, send an email to kasan-dev+unsubscribe@googlegroups.com.
> To view this discussion on the web visit https://groups.google.com/d/msgid/kasan-dev/1589201640.21284.8.camel%40mtksdccf07.
