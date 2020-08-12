Return-Path: <SRS0=ZArZ=BW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-17.6 required=3.0 tests=BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_IN_DEF_DKIM_WL autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7164AC433E0
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Aug 2020 14:13:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3E58620885
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Aug 2020 14:13:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="ZyrDNv/E"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726778AbgHLON1 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 12 Aug 2020 10:13:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44050 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726749AbgHLONX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Aug 2020 10:13:23 -0400
Received: from mail-oi1-x241.google.com (mail-oi1-x241.google.com [IPv6:2607:f8b0:4864:20::241])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5A4F7C061383
        for <linux-kernel@vger.kernel.org>; Wed, 12 Aug 2020 07:13:23 -0700 (PDT)
Received: by mail-oi1-x241.google.com with SMTP id 25so1948872oir.0
        for <linux-kernel@vger.kernel.org>; Wed, 12 Aug 2020 07:13:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Eny7GtW3fheHTjAaLnI+U+IUiSf5L2wZMby5TEt/uUU=;
        b=ZyrDNv/EFXrsfT2cLSeHIYizOdkcvsp1j7OBQ1aowLsdKMYwu3Erh3AfIT0w3ioDCQ
         KfZPUlQPzSoP+nUFYYYO75TVc/gwd5Pb29VR2AvJEi/zoQ05+n/MwJ7Ce5uYS3rN6mC5
         cXGuavRO/u9qGk+OlTcMvNTTf0BH+S3ny3O8O6wGekHkSvY7XaEXxoreGvasTdQuVLLN
         9k5KaqttiFGfMl0dKXpl/MS6KmuVwDc0i/TlFUM9bFFdvPTgN2wKkSauEFJWPUhuv+Sh
         JgKs2SJ/+byaCu7G78QKTwAlQ2T+UHsNjxsoHrSWI9ihc6q1Ecwt9WthXZ8Q5RUtMJ98
         Ybrg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Eny7GtW3fheHTjAaLnI+U+IUiSf5L2wZMby5TEt/uUU=;
        b=f2PGY7AxR0JIoFdYzXvDScctQTIvDOTsEIY8eAujSsNFRIyLCi0SLeZVpH+s4nHStw
         pyokEDKFfOEBRckMX3c3J1WM4CZ6fZlrJ7QrIW/ndwkzV+V2mE7b3b0Yz3cxi3UyrANJ
         Bk4++tuFQuV248Lzxgxv2lH0Dhjckm8krwV4jdxa+1IQ2uqWEVFk+eXHozuXbIB8VBks
         ZMtxa5R+YwyU+vK3YuMwtn+pKj3JLO8txUL/bujEjHSLEVFm41iConyLv7j+ngWuwmzQ
         gvCdlIdLlCye33m6I8TBsy3+RSxPnVT7wJrPbPiji1r8quVhaJdJxmaqeNX0eO+Xrd99
         z6ZA==
X-Gm-Message-State: AOAM532HDpb2npIo1NivZa1Yuno7KUv2dhX5GND/JLF6krYeiRv9g/k8
        7Y2Jj5esiLU9VwR5yVgrVvJXfRpmABUT6ZS+VAQCsQ==
X-Google-Smtp-Source: ABdhPJw85SLSUV6JhAygRCX/l0A0lj6KIvRKkfbUSL+xaRgnaDhfrkRyLSy4hvJ32Tjv/Nn70me/rXN2+2i6JwfXQLM=
X-Received: by 2002:aca:d4d5:: with SMTP id l204mr7728838oig.70.1597241602391;
 Wed, 12 Aug 2020 07:13:22 -0700 (PDT)
MIME-Version: 1.0
References: <20200810072313.529-1-walter-zh.wu@mediatek.com>
In-Reply-To: <20200810072313.529-1-walter-zh.wu@mediatek.com>
From:   Marco Elver <elver@google.com>
Date:   Wed, 12 Aug 2020 16:13:09 +0200
Message-ID: <CANpmjNO9=JBcSV-nif9a=4Zt7gTCp6e5c2jVXMCSFgP3v2P9-w@mail.gmail.com>
Subject: Re: [PATCH 1/5] timer: kasan: record and print timer stack
To:     Walter Wu <walter-zh.wu@mediatek.com>
Cc:     Andrey Ryabinin <aryabinin@virtuozzo.com>,
        Alexander Potapenko <glider@google.com>,
        Dmitry Vyukov <dvyukov@google.com>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        John Stultz <john.stultz@linaro.org>,
        Stephen Boyd <sboyd@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        kasan-dev <kasan-dev@googlegroups.com>,
        Linux Memory Management List <linux-mm@kvack.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        wsd_upstream <wsd_upstream@mediatek.com>,
        linux-mediatek@lists.infradead.org,
        Thomas Gleixner <tglx@linutronix.de>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 10 Aug 2020 at 09:23, Walter Wu <walter-zh.wu@mediatek.com> wrote:
> This patch records the last two timer queueing stacks and prints
> up to 2 timer stacks in KASAN report. It is useful for programmers
> to solve use-after-free or double-free memory timer issues.
>
> When timer_setup() or timer_setup_on_stack() is called, then it
> prepares to use this timer and sets timer callback, we store
> this call stack in order to print it in KASAN report.
>
> Signed-off-by: Walter Wu <walter-zh.wu@mediatek.com>
> Cc: Andrey Ryabinin <aryabinin@virtuozzo.com>
> Cc: Dmitry Vyukov <dvyukov@google.com>
> Cc: Alexander Potapenko <glider@google.com>
> Cc: Thomas Gleixner <tglx@linutronix.de>
> Cc: John Stultz <john.stultz@linaro.org>
> Cc: Stephen Boyd <sboyd@kernel.org>
> Cc: Andrew Morton <akpm@linux-foundation.org>
> ---
>  include/linux/kasan.h |  2 ++
>  kernel/time/timer.c   |  2 ++
>  mm/kasan/generic.c    | 21 +++++++++++++++++++++
>  mm/kasan/kasan.h      |  4 +++-
>  mm/kasan/report.c     | 11 +++++++++++
>  5 files changed, 39 insertions(+), 1 deletion(-)

I'm commenting on the code here, but it also applies to patch 2/5, as
it's almost a copy-paste.

In general, I'd say the solution to get this feature is poorly
designed, resulting in excessive LOC added. The logic added already
exists for the aux stacks.

> diff --git a/include/linux/kasan.h b/include/linux/kasan.h
> index 23b7ee00572d..763664b36dc6 100644
> --- a/include/linux/kasan.h
> +++ b/include/linux/kasan.h
> @@ -175,12 +175,14 @@ static inline size_t kasan_metadata_size(struct kmem_cache *cache) { return 0; }
>  void kasan_cache_shrink(struct kmem_cache *cache);
>  void kasan_cache_shutdown(struct kmem_cache *cache);
>  void kasan_record_aux_stack(void *ptr);
> +void kasan_record_tmr_stack(void *ptr);
>
>  #else /* CONFIG_KASAN_GENERIC */
>
>  static inline void kasan_cache_shrink(struct kmem_cache *cache) {}
>  static inline void kasan_cache_shutdown(struct kmem_cache *cache) {}
>  static inline void kasan_record_aux_stack(void *ptr) {}
> +static inline void kasan_record_tmr_stack(void *ptr) {}

It appears that the 'aux' stack is currently only used for call_rcu
stacks, but this interface does not inherently tie it to call_rcu. The
only thing tying it to call_rcu is the fact that the report calls out
call_rcu.

>  /**
> diff --git a/mm/kasan/generic.c b/mm/kasan/generic.c
> index 4b3cbad7431b..f35dcec990ab 100644
> --- a/mm/kasan/generic.c
> +++ b/mm/kasan/generic.c
> @@ -347,6 +347,27 @@ void kasan_record_aux_stack(void *addr)
>         alloc_info->aux_stack[0] = kasan_save_stack(GFP_NOWAIT);
>  }
>
> +void kasan_record_tmr_stack(void *addr)
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
> +       /*
> +        * record the last two timer stacks.
> +        */
> +       alloc_info->tmr_stack[1] = alloc_info->tmr_stack[0];
> +       alloc_info->tmr_stack[0] = kasan_save_stack(GFP_NOWAIT);
> +}

The solution here is, unfortunately, poorly designed. This is a
copy-paste of the kasan_record_aux_stack() function.

>  void kasan_set_free_info(struct kmem_cache *cache,
>                                 void *object, u8 tag)
>  {
> diff --git a/mm/kasan/kasan.h b/mm/kasan/kasan.h
> index ef655a1c6e15..c50827f388a3 100644
> --- a/mm/kasan/kasan.h
> +++ b/mm/kasan/kasan.h
> @@ -108,10 +108,12 @@ struct kasan_alloc_meta {
>         struct kasan_track alloc_track;
>  #ifdef CONFIG_KASAN_GENERIC
>         /*
> -        * call_rcu() call stack is stored into struct kasan_alloc_meta.
> +        * call_rcu() call stack and timer queueing stack are stored
> +        * into struct kasan_alloc_meta.
>          * The free stack is stored into struct kasan_free_meta.
>          */
>         depot_stack_handle_t aux_stack[2];
> +       depot_stack_handle_t tmr_stack[2];
>  #else
>         struct kasan_track free_track[KASAN_NR_FREE_STACKS];
>  #endif
> diff --git a/mm/kasan/report.c b/mm/kasan/report.c
> index fed3c8fdfd25..6fa3bfee381f 100644
> --- a/mm/kasan/report.c
> +++ b/mm/kasan/report.c
> @@ -191,6 +191,17 @@ static void describe_object(struct kmem_cache *cache, void *object,
>                         print_stack(alloc_info->aux_stack[1]);
>                         pr_err("\n");
>                 }
> +
> +               if (alloc_info->tmr_stack[0]) {
> +                       pr_err("Last timer stack:\n");
> +                       print_stack(alloc_info->tmr_stack[0]);
> +                       pr_err("\n");
> +               }
> +               if (alloc_info->tmr_stack[1]) {
> +                       pr_err("Second to last timer stack:\n");
> +                       print_stack(alloc_info->tmr_stack[1]);
> +                       pr_err("\n");
> +               }

Why can't we just use the aux stack for everything, and simply change
the message printed in the report. After all, the stack trace will
include all the information to tell if it's call_rcu, timer, or
workqueue.

The reporting code would simply have to be changed to say something
like "Last potentially related work creation:" -- because what the
"aux" thing is trying to abstract are stack traces to work creations
that took an address that is closely related. Whether or not you want
to call it "work" is up to you, but that's the most generic term I
could think of right now (any better terms?).

Another argument for this consolidation is that it's highly unlikely
that aux_stack[a] && tmr_stack[b] && wq_stack[c], and you need to
print all the stacks. If you are worried we need more aux stacks, just
make the array size 3+ (but I think it's not necessary).

Thanks,
-- Marco
