Return-Path: <SRS0=F+sq=6U=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.3 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_IN_DEF_DKIM_WL autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5ED9AC28CBC
	for <linux-kernel@archiver.kernel.org>; Wed,  6 May 2020 09:46:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 223B62070B
	for <linux-kernel@archiver.kernel.org>; Wed,  6 May 2020 09:46:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="r2QvspJv"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729176AbgEFJq6 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 6 May 2020 05:46:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34096 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726935AbgEFJq6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 May 2020 05:46:58 -0400
Received: from mail-qt1-x842.google.com (mail-qt1-x842.google.com [IPv6:2607:f8b0:4864:20::842])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C5306C061A0F
        for <linux-kernel@vger.kernel.org>; Wed,  6 May 2020 02:46:57 -0700 (PDT)
Received: by mail-qt1-x842.google.com with SMTP id l18so931767qtp.0
        for <linux-kernel@vger.kernel.org>; Wed, 06 May 2020 02:46:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=hQDZDB87ZUXhKCgcvIzYKrqSoBdqgJ7jZ3dXjUfyxD0=;
        b=r2QvspJvLUHvUJfQakhRiXru7zxUcQWBFwhTrpPUvyRi6gwqZIPFd3WeV09iauoC7L
         dP+/mOfO10zyLNKnByZor75Vv08yH7XOsalgzBHpSE80gLq3b7+9K3fR9AaNdAn4GXxT
         fUGIgnAmflws/HHYnJGuIjK7+twqjhDiR9B9e27wLyRo4fsy+ANzgvqPxtUOReOeu0dR
         XQIjiRRNC4l/GR2C42fRlQC8tKdXGSLr1MMmAw88YmTavegLRkvWYc3uVZmYxqkq89vl
         RcYvHYSRHAAszuleEas4Boj86zJeGHfzRwpSSEYIfmY+X4UabuRQNDbiXH8ifsfHvGen
         gpoQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=hQDZDB87ZUXhKCgcvIzYKrqSoBdqgJ7jZ3dXjUfyxD0=;
        b=jcx3Qx3OCyrHVmvDJdvKdDppcEvmJP9MBcKBOIiBDO/2POKNs+peEOEitpb8/byIUm
         40yutnS1LVJrhZ0f4VFIlSyHqocSO2ZcRuRvoZY/2kWrgLxwlQ6q5t9YF9Ov7YRiQW56
         ITrV8Se+3sxIrYt/1FB/NdJZQMn0zW53lFmxyRUFeUBUb/L+H/8EdqT8bMG6oPsUWjyW
         gd5Whf2weYJ/JGGURMqAH+tlRRp+Oq8ZYr06lno6AwGPBZMxIjnsRD5ZYxVtKB+UKVy3
         2iEHfcgvh327hzudMl6tfRaB1B9Qb2n90hB08tSy1XKVPqGuMXa36yk7P2zV5/ovdCqd
         LIDw==
X-Gm-Message-State: AGi0PuYjcTJHBnnvrqtyq1lwtVAznCZTcy9mzPC7B9ycJQHhQquMfmLN
        jHXQZplHZAoqY8K7D3C0hNaBP0OIG4A7ofKn/eKe8Q==
X-Google-Smtp-Source: APiQypLYyNNg47AB9MsR3Z+AOf3qGz6D2kPboq+MDxAun8KMRzabM7rmgZ5AC1J342iaRccS+hb/MKdDdXcxKUQN8rU=
X-Received: by 2002:ac8:5209:: with SMTP id r9mr6854313qtn.57.1588758416707;
 Wed, 06 May 2020 02:46:56 -0700 (PDT)
MIME-Version: 1.0
References: <20200506052046.14451-1-walter-zh.wu@mediatek.com>
In-Reply-To: <20200506052046.14451-1-walter-zh.wu@mediatek.com>
From:   Dmitry Vyukov <dvyukov@google.com>
Date:   Wed, 6 May 2020 11:46:45 +0200
Message-ID: <CACT4Y+beyYmoTn8GR_Y_Ca5XypxpRac-9ttu=zTtS-J-BYTfMA@mail.gmail.com>
Subject: Re: [PATCH 1/3] rcu/kasan: record and print call_rcu() call stack
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

On Wed, May 6, 2020 at 7:21 AM Walter Wu <walter-zh.wu@mediatek.com> wrote:
>
> When call_rcu() is called, we store the call_rcu() call stack into
> slub alloc meta-data, so that KASAN report prints call_rcu() information.
>
> We add new KASAN_RCU_STACK_RECORD configuration option. It will record
> first and last call_rcu() call stack and KASAN report will print two
> call_rcu() call stack.
>
> This option doesn't increase the cost of memory consumption. Because
> we don't enlarge struct kasan_alloc_meta size.
> - add two call_rcu() call stack into kasan_alloc_meta, size is 8 bytes.
> - remove free track from kasan_alloc_meta, size is 8 bytes.
>
> [1]https://bugzilla.kernel.org/show_bug.cgi?id=198437
>
> Signed-off-by: Walter Wu <walter-zh.wu@mediatek.com>
> Suggested-by: Dmitry Vyukov <dvyukov@google.com>
> Cc: Andrey Ryabinin <aryabinin@virtuozzo.com>
> Cc: Dmitry Vyukov <dvyukov@google.com>
> Cc: Alexander Potapenko <glider@google.com>
> Cc: Andrew Morton <akpm@linux-foundation.org>
> Cc: Paul E. McKenney <paulmck@kernel.org>
> Cc: Josh Triplett <josh@joshtriplett.org>
> Cc: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
> Cc: Lai Jiangshan <jiangshanlai@gmail.com>
> Cc: Joel Fernandes <joel@joelfernandes.org>
> ---
>  include/linux/kasan.h |  7 +++++++
>  kernel/rcu/tree.c     |  4 ++++
>  lib/Kconfig.kasan     | 11 +++++++++++
>  mm/kasan/common.c     | 23 +++++++++++++++++++++++
>  mm/kasan/kasan.h      | 12 ++++++++++++
>  mm/kasan/report.c     | 33 +++++++++++++++++++++++++++------
>  6 files changed, 84 insertions(+), 6 deletions(-)
>
> diff --git a/include/linux/kasan.h b/include/linux/kasan.h
> index 31314ca7c635..5eeece6893cd 100644
> --- a/include/linux/kasan.h
> +++ b/include/linux/kasan.h
> @@ -96,6 +96,12 @@ size_t kasan_metadata_size(struct kmem_cache *cache);
>  bool kasan_save_enable_multi_shot(void);
>  void kasan_restore_multi_shot(bool enabled);
>
> +#ifdef CONFIG_KASAN_RCU_STACK_RECORD
> +void kasan_record_callrcu(void *ptr);

The issue also mentions workqueue and timer stacks.
Have you considered supporting them as well? What was your motivation
for doing only rcu?

Looking at the first report for "workqueue use-after-free":
https://syzkaller.appspot.com/bug?extid=9cba1e478f91aad39876
This is exactly the same situation as for call_rcu, just a workqueue
is used to invoke a callback that frees the object.

If you don't want to do all at the same time, I would at least
name/branch everything inside of KASAN more generally (I think in the
issue I called it "aux" (auxiliary), or maybe something like
"additional"). But then call this kasan_record_aux_stack() only from
rcu for now. But then later we can separately decide and extend to
other callers.
It just feels wrong to have KASAN over-specialized for rcu only in this way.
And I think if the UAF is really caused by call_rcu callback, then it
sill will be recorded as last stack most of the time because rcu
callbacks are invoked relatively fast and there should not be much
else happening with the object since it's near end of life already.




> +#else
> +static inline void kasan_record_callrcu(void *ptr) {}
> +#endif
> +
>  #else /* CONFIG_KASAN */
>
>  static inline void kasan_unpoison_shadow(const void *address, size_t size) {}
> @@ -165,6 +171,7 @@ static inline void kasan_remove_zero_shadow(void *start,
>
>  static inline void kasan_unpoison_slab(const void *ptr) { }
>  static inline size_t kasan_metadata_size(struct kmem_cache *cache) { return 0; }
> +static inline void kasan_record_callrcu(void *ptr) {}
>
>  #endif /* CONFIG_KASAN */
>
> diff --git a/kernel/rcu/tree.c b/kernel/rcu/tree.c
> index 06548e2ebb72..145c79becf7b 100644
> --- a/kernel/rcu/tree.c
> +++ b/kernel/rcu/tree.c
> @@ -57,6 +57,7 @@
>  #include <linux/slab.h>
>  #include <linux/sched/isolation.h>
>  #include <linux/sched/clock.h>
> +#include <linux/kasan.h>
>  #include "../time/tick-internal.h"
>
>  #include "tree.h"
> @@ -2694,6 +2695,9 @@ __call_rcu(struct rcu_head *head, rcu_callback_t func)
>                 trace_rcu_callback(rcu_state.name, head,
>                                    rcu_segcblist_n_cbs(&rdp->cblist));
>
> +       if (IS_ENABLED(CONFIG_KASAN_RCU_STACK_RECORD))

The if is not necessary, this function is no-op when not enabled.

> +               kasan_record_callrcu(head);
> +
>         /* Go handle any RCU core processing required. */
>         if (IS_ENABLED(CONFIG_RCU_NOCB_CPU) &&
>             unlikely(rcu_segcblist_is_offloaded(&rdp->cblist))) {
> diff --git a/lib/Kconfig.kasan b/lib/Kconfig.kasan
> index 81f5464ea9e1..022934049cc2 100644
> --- a/lib/Kconfig.kasan
> +++ b/lib/Kconfig.kasan
> @@ -158,6 +158,17 @@ config KASAN_VMALLOC
>           for KASAN to detect more sorts of errors (and to support vmapped
>           stacks), but at the cost of higher memory usage.
>
> +config KASAN_RCU_STACK_RECORD
> +       bool "Record and print call_rcu() call stack"
> +       depends on KASAN_GENERIC
> +       help
> +         By default, the KASAN report doesn't print call_rcu() call stack.
> +         It is very difficult to analyze memory issues(e.g., use-after-free).
> +
> +         Enabling this option will print first and last call_rcu() call stack.
> +         It doesn't enlarge slub alloc meta-data size, so it doesn't increase
> +         the cost of memory consumption.
> +
>  config TEST_KASAN
>         tristate "Module for testing KASAN for bug detection"
>         depends on m && KASAN
> diff --git a/mm/kasan/common.c b/mm/kasan/common.c
> index 2906358e42f0..32d422bdf127 100644
> --- a/mm/kasan/common.c
> +++ b/mm/kasan/common.c
> @@ -299,6 +299,29 @@ struct kasan_free_meta *get_free_info(struct kmem_cache *cache,
>         return (void *)object + cache->kasan_info.free_meta_offset;
>  }
>
> +#ifdef CONFIG_KASAN_RCU_STACK_RECORD
> +void kasan_record_callrcu(void *addr)
> +{
> +       struct page *page = kasan_addr_to_page(addr);
> +       struct kmem_cache *cache;
> +       struct kasan_alloc_meta *alloc_info;
> +       void *object;
> +
> +       if (!(page && PageSlab(page)))
> +               return;
> +
> +       cache = page->slab_cache;
> +       object = nearest_obj(cache, page, addr);
> +       alloc_info = get_alloc_info(cache, object);
> +
> +       if (!alloc_info->rcu_free_stack[0])
> +               /* record first call_rcu() call stack */
> +               alloc_info->rcu_free_stack[0] = save_stack(GFP_NOWAIT);
> +       else
> +               /* record last call_rcu() call stack */
> +               alloc_info->rcu_free_stack[1] = save_stack(GFP_NOWAIT);
> +}
> +#endif
>
>  static void kasan_set_free_info(struct kmem_cache *cache,
>                 void *object, u8 tag)
> diff --git a/mm/kasan/kasan.h b/mm/kasan/kasan.h
> index e8f37199d885..adc105b9cd07 100644
> --- a/mm/kasan/kasan.h
> +++ b/mm/kasan/kasan.h
> @@ -96,15 +96,27 @@ struct kasan_track {
>         depot_stack_handle_t stack;
>  };
>
> +#ifdef CONFIG_KASAN_RCU_STACK_RECORD
> +#define BYTES_PER_WORD 4
> +#define KASAN_NR_RCU_FREE_STACKS 2
> +#else /* CONFIG_KASAN_RCU_STACK_RECORD */
>  #ifdef CONFIG_KASAN_SW_TAGS_IDENTIFY
>  #define KASAN_NR_FREE_STACKS 5
>  #else
>  #define KASAN_NR_FREE_STACKS 1
>  #endif
> +#endif /* CONFIG_KASAN_RCU_STACK_RECORD */
>
>  struct kasan_alloc_meta {
>         struct kasan_track alloc_track;
> +#ifdef CONFIG_KASAN_RCU_STACK_RECORD
> +       /* call_rcu() call stack is stored into kasan_alloc_meta.
> +        * free stack is stored into freed object.
> +        */
> +       depot_stack_handle_t rcu_free_stack[KASAN_NR_RCU_FREE_STACKS];
> +#else
>         struct kasan_track free_track[KASAN_NR_FREE_STACKS];
> +#endif
>  #ifdef CONFIG_KASAN_SW_TAGS_IDENTIFY
>         u8 free_pointer_tag[KASAN_NR_FREE_STACKS];
>         u8 free_track_idx;
> diff --git a/mm/kasan/report.c b/mm/kasan/report.c
> index 80f23c9da6b0..7aaccc70b65b 100644
> --- a/mm/kasan/report.c
> +++ b/mm/kasan/report.c
> @@ -105,9 +105,13 @@ static void end_report(unsigned long *flags)
>         kasan_enable_current();
>  }
>
> -static void print_track(struct kasan_track *track, const char *prefix)
> +static void print_track(struct kasan_track *track, const char *prefix,
> +                                               bool is_callrcu)
>  {
> -       pr_err("%s by task %u:\n", prefix, track->pid);
> +       if (is_callrcu)
> +               pr_err("%s:\n", prefix);
> +       else
> +               pr_err("%s by task %u:\n", prefix, track->pid);
>         if (track->stack) {
>                 unsigned long *entries;
>                 unsigned int nr_entries;
> @@ -159,8 +163,22 @@ static void describe_object_addr(struct kmem_cache *cache, void *object,
>                 (void *)(object_addr + cache->object_size));
>  }
>
> +#ifdef CONFIG_KASAN_RCU_STACK_RECORD
> +static void kasan_print_rcu_free_stack(struct kasan_alloc_meta *alloc_info)
> +{
> +       struct kasan_track free_track;
> +
> +       free_track.stack  = alloc_info->rcu_free_stack[0];
> +       print_track(&free_track, "First call_rcu() call stack", true);
> +       pr_err("\n");
> +       free_track.stack  = alloc_info->rcu_free_stack[1];
> +       print_track(&free_track, "Last call_rcu() call stack", true);
> +       pr_err("\n");
> +}
> +#endif
> +
>  static struct kasan_track *kasan_get_free_track(struct kmem_cache *cache,
> -               void *object, u8 tag)
> +               void *object, u8 tag, const void *addr)
>  {
>         struct kasan_alloc_meta *alloc_meta;
>         int i = 0;
> @@ -187,11 +205,14 @@ static void describe_object(struct kmem_cache *cache, void *object,
>         if (cache->flags & SLAB_KASAN) {
>                 struct kasan_track *free_track;
>
> -               print_track(&alloc_info->alloc_track, "Allocated");
> +               print_track(&alloc_info->alloc_track, "Allocated", false);
>                 pr_err("\n");
> -               free_track = kasan_get_free_track(cache, object, tag);
> -               print_track(free_track, "Freed");
> +               free_track = kasan_get_free_track(cache, object, tag, addr);
> +               print_track(free_track, "Freed", false);
>                 pr_err("\n");
> +#ifdef CONFIG_KASAN_RCU_STACK_RECORD
> +               kasan_print_rcu_free_stack(alloc_info);
> +#endif
>         }
>
>         describe_object_addr(cache, object, addr);
> --
> 2.18.0
>
> --
> You received this message because you are subscribed to the Google Groups "kasan-dev" group.
> To unsubscribe from this group and stop receiving emails from it, send an email to kasan-dev+unsubscribe@googlegroups.com.
> To view this discussion on the web visit https://groups.google.com/d/msgid/kasan-dev/20200506052046.14451-1-walter-zh.wu%40mediatek.com.
