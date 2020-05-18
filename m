Return-Path: <SRS0=RE5T=7A=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2C4BBC433E1
	for <linux-kernel@archiver.kernel.org>; Mon, 18 May 2020 10:18:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 02B072081A
	for <linux-kernel@archiver.kernel.org>; Mon, 18 May 2020 10:18:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Kopo/21L"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726494AbgERKSx (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 18 May 2020 06:18:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46678 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726180AbgERKSw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 May 2020 06:18:52 -0400
Received: from mail-qk1-x743.google.com (mail-qk1-x743.google.com [IPv6:2607:f8b0:4864:20::743])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 91136C061A0C
        for <linux-kernel@vger.kernel.org>; Mon, 18 May 2020 03:18:52 -0700 (PDT)
Received: by mail-qk1-x743.google.com with SMTP id f189so9504366qkd.5
        for <linux-kernel@vger.kernel.org>; Mon, 18 May 2020 03:18:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=SeQSSJ6tmsyyQwBxZIU0ZhjYI9wUM1h2JniQ2eBNH4E=;
        b=Kopo/21L3C7MudOEHWTkWV41hFq0ooPCTzMCXhC2puPmlUUiozJSeKE1O8UC7zJyXK
         RfwOo42aYdSxrntkDGjY71EyI5JlDrWjEGLhr9YeM2h9LfoehewNIPSHiTPp4xmbcA+/
         MpPx4CPfWbTqbMHa5oPktsU2gvZF7r/GPB1q7Kyl+Y/iTJJrc7BgABfPcDNhcmoZHr2F
         qbSq9plJMy+YKEKVFSIBpVtH9uRj/W5IL2Y6G5sCDwCcnTCCfk4las4JCLK2eC3N2dm5
         +gNFTd2KOLnWO0ksMMNwnbtVd7VZ0T2zyKXxp4WXgCdmVedZtHSJ66F4+VocOmzeCAmZ
         7NRA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=SeQSSJ6tmsyyQwBxZIU0ZhjYI9wUM1h2JniQ2eBNH4E=;
        b=SRWvbqagaXpDc4SntqOu+g4EI1gTnQ1ZfOQR2QJa+l+AUqY+tHa5fgJhKkAT8xiCKs
         7XG/8RFIMMHua6lf9am+nt2BPSk3e7N3CNauLhAwEmSl0qT0DRKM3S9688mIE9PUu6OT
         oB3lin/ZvT/074MIhlrQ2CcwtURuAI20gloKOsPA3Q5Oe/YcUvY8JQOggAneCG2vlkI9
         QIJZ/lQ5ztqN8Feptu9LxXZc96QxPAHAVWTSCiTdngtjUcWSUPAvI0sjhSAewhHDx5B9
         Hb+2PcTF+pBa4upOyOwdwP82y23iSyZg4JETExWyK3tgKDoH43T9joh+yWoBeKR4Soeq
         b9Nw==
X-Gm-Message-State: AOAM530BQmz/IRRWmTr6PHA5f02zRTnSIGDSKk1woJDfTtOTR+kBzQEl
        1S3YMq/abtESwgVuW8MTzDs9hkOgvRLMW95LMTp7FA==
X-Google-Smtp-Source: ABdhPJykjMBtckEPDW2MVoTFnCMJCVBSqp/zeSHD0RUpov0jZbVBUpIt8cohaU1fiFQa9m+77TzvhXCuMxIMfK4+GDY=
X-Received: by 2002:a05:620a:990:: with SMTP id x16mr14681630qkx.256.1589797131499;
 Mon, 18 May 2020 03:18:51 -0700 (PDT)
MIME-Version: 1.0
References: <20200518062730.4665-1-walter-zh.wu@mediatek.com>
In-Reply-To: <20200518062730.4665-1-walter-zh.wu@mediatek.com>
From:   Dmitry Vyukov <dvyukov@google.com>
Date:   Mon, 18 May 2020 12:18:39 +0200
Message-ID: <CACT4Y+YVF2cLdg6qaK+3NcU3kLz2Pys6NWxLAYfity5n5cjirA@mail.gmail.com>
Subject: Re: [PATCH v3 2/4] kasan: record and print the free track
To:     Walter Wu <walter-zh.wu@mediatek.com>
Cc:     Andrey Ryabinin <aryabinin@virtuozzo.com>,
        Alexander Potapenko <glider@google.com>,
        Matthias Brugger <matthias.bgg@gmail.com>,
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

On Mon, May 18, 2020 at 8:27 AM Walter Wu <walter-zh.wu@mediatek.com> wrote:
>
> Move free track from slub alloc meta-data to slub free meta-data in
> order to make struct kasan_free_meta size is 16 bytes. It is a good
> size because it is the minimal redzone size and a good number of
> alignment.
>
> For free track in generic KASAN, we do the modification in struct
> kasan_alloc_meta and kasan_free_meta:
> - remove free track from kasan_alloc_meta.
> - add free track into kasan_free_meta.
>
> [1]https://bugzilla.kernel.org/show_bug.cgi?id=198437
>
> Signed-off-by: Walter Wu <walter-zh.wu@mediatek.com>
> Suggested-by: Dmitry Vyukov <dvyukov@google.com>
> Cc: Andrey Ryabinin <aryabinin@virtuozzo.com>
> Cc: Dmitry Vyukov <dvyukov@google.com>
> Cc: Alexander Potapenko <glider@google.com>
> ---
>  mm/kasan/common.c  | 33 ++++++++++-----------------------
>  mm/kasan/generic.c | 18 ++++++++++++++++++
>  mm/kasan/kasan.h   |  7 +++++++
>  mm/kasan/report.c  | 20 --------------------
>  mm/kasan/tags.c    | 37 +++++++++++++++++++++++++++++++++++++
>  5 files changed, 72 insertions(+), 43 deletions(-)
>
> diff --git a/mm/kasan/common.c b/mm/kasan/common.c
> index 8bc618289bb1..6500bc2bb70c 100644
> --- a/mm/kasan/common.c
> +++ b/mm/kasan/common.c
> @@ -51,7 +51,7 @@ depot_stack_handle_t kasan_save_stack(gfp_t flags)
>         return stack_depot_save(entries, nr_entries, flags);
>  }
>
> -static inline void set_track(struct kasan_track *track, gfp_t flags)
> +void kasan_set_track(struct kasan_track *track, gfp_t flags)
>  {
>         track->pid = current->pid;
>         track->stack = kasan_save_stack(flags);
> @@ -249,9 +249,7 @@ void kasan_cache_create(struct kmem_cache *cache, unsigned int *size,
>         *size += sizeof(struct kasan_alloc_meta);
>
>         /* Add free meta. */
> -       if (IS_ENABLED(CONFIG_KASAN_GENERIC) &&
> -           (cache->flags & SLAB_TYPESAFE_BY_RCU || cache->ctor ||
> -            cache->object_size < sizeof(struct kasan_free_meta))) {
> +       if (IS_ENABLED(CONFIG_KASAN_GENERIC)) {

Why do we need to increase object size unconditionally?
We only store info in free track when the object is free, so I would
assume we still can generally overlap free track and the object
itself. We store free track at the same time we use the quarantine
link, and the quarantine link was overlapped with the object just
fine.
With this change we indeed increase object size, which we do not want
in general.


>                 cache->kasan_info.free_meta_offset = *size;
>                 *size += sizeof(struct kasan_free_meta);
>         }
> @@ -299,24 +297,6 @@ struct kasan_free_meta *get_free_info(struct kmem_cache *cache,
>         return (void *)object + cache->kasan_info.free_meta_offset;
>  }
>
> -
> -static void kasan_set_free_info(struct kmem_cache *cache,
> -               void *object, u8 tag)
> -{
> -       struct kasan_alloc_meta *alloc_meta;
> -       u8 idx = 0;
> -
> -       alloc_meta = get_alloc_info(cache, object);
> -
> -#ifdef CONFIG_KASAN_SW_TAGS_IDENTIFY
> -       idx = alloc_meta->free_track_idx;
> -       alloc_meta->free_pointer_tag[idx] = tag;
> -       alloc_meta->free_track_idx = (idx + 1) % KASAN_NR_FREE_STACKS;
> -#endif
> -
> -       set_track(&alloc_meta->free_track[idx], GFP_NOWAIT);
> -}
> -
>  void kasan_poison_slab(struct page *page)
>  {
>         unsigned long i;
> @@ -396,6 +376,13 @@ void * __must_check kasan_init_slab_obj(struct kmem_cache *cache,
>         alloc_info = get_alloc_info(cache, object);
>         __memset(alloc_info, 0, sizeof(*alloc_info));
>
> +       if (IS_ENABLED(CONFIG_KASAN_GENERIC)) {
> +               struct kasan_free_meta *free_info;
> +
> +               free_info = get_free_info(cache, object);
> +               __memset(free_info, 0, sizeof(*free_info));

If we overlap free track with object, this will not be needed as well, right?

> +       }
> +
>         if (IS_ENABLED(CONFIG_KASAN_SW_TAGS))
>                 object = set_tag(object,
>                                 assign_tag(cache, object, true, false));
> @@ -492,7 +479,7 @@ static void *__kasan_kmalloc(struct kmem_cache *cache, const void *object,
>                 KASAN_KMALLOC_REDZONE);
>
>         if (cache->flags & SLAB_KASAN)
> -               set_track(&get_alloc_info(cache, object)->alloc_track, flags);
> +               kasan_set_track(&get_alloc_info(cache, object)->alloc_track, flags);
>
>         return set_tag(object, tag);
>  }
> diff --git a/mm/kasan/generic.c b/mm/kasan/generic.c
> index 78d8e0a75a8a..988bc095b738 100644
> --- a/mm/kasan/generic.c
> +++ b/mm/kasan/generic.c
> @@ -345,3 +345,21 @@ void kasan_record_aux_stack(void *addr)
>                 alloc_info->rcu_stack[1] = alloc_info->rcu_stack[0];
>         alloc_info->rcu_stack[0] = kasan_save_stack(GFP_NOWAIT);
>  }
> +
> +void kasan_set_free_info(struct kmem_cache *cache,
> +                               void *object, u8 tag)
> +{
> +       struct kasan_free_meta *free_meta;
> +
> +       free_meta = get_free_info(cache, object);
> +       kasan_set_track(&free_meta->free_track, GFP_NOWAIT);
> +}
> +
> +struct kasan_track *kasan_get_free_track(struct kmem_cache *cache,
> +                               void *object, u8 tag)
> +{
> +       struct kasan_free_meta *free_meta;
> +
> +       free_meta = get_free_info(cache, object);
> +       return &free_meta->free_track;
> +}
> diff --git a/mm/kasan/kasan.h b/mm/kasan/kasan.h
> index 870c5dd07756..87ee3626b8b0 100644
> --- a/mm/kasan/kasan.h
> +++ b/mm/kasan/kasan.h
> @@ -127,6 +127,9 @@ struct kasan_free_meta {
>          * Otherwise it might be used for the allocator freelist.
>          */
>         struct qlist_node quarantine_link;
> +#ifdef CONFIG_KASAN_GENERIC
> +       struct kasan_track free_track;
> +#endif
>  };
>
>  struct kasan_alloc_meta *get_alloc_info(struct kmem_cache *cache,
> @@ -168,6 +171,10 @@ void kasan_report_invalid_free(void *object, unsigned long ip);
>  struct page *kasan_addr_to_page(const void *addr);
>
>  depot_stack_handle_t kasan_save_stack(gfp_t flags);
> +void kasan_set_track(struct kasan_track *track, gfp_t flags);
> +void kasan_set_free_info(struct kmem_cache *cache, void *object, u8 tag);
> +struct kasan_track *kasan_get_free_track(struct kmem_cache *cache,
> +                               void *object, u8 tag);
>
>  #if defined(CONFIG_KASAN_GENERIC) && \
>         (defined(CONFIG_SLAB) || defined(CONFIG_SLUB))
> diff --git a/mm/kasan/report.c b/mm/kasan/report.c
> index 5ee66cf7e27c..7e9f9f6d5e85 100644
> --- a/mm/kasan/report.c
> +++ b/mm/kasan/report.c
> @@ -159,26 +159,6 @@ static void describe_object_addr(struct kmem_cache *cache, void *object,
>                 (void *)(object_addr + cache->object_size));
>  }
>
> -static struct kasan_track *kasan_get_free_track(struct kmem_cache *cache,
> -               void *object, u8 tag)
> -{
> -       struct kasan_alloc_meta *alloc_meta;
> -       int i = 0;
> -
> -       alloc_meta = get_alloc_info(cache, object);
> -
> -#ifdef CONFIG_KASAN_SW_TAGS_IDENTIFY
> -       for (i = 0; i < KASAN_NR_FREE_STACKS; i++) {
> -               if (alloc_meta->free_pointer_tag[i] == tag)
> -                       break;
> -       }
> -       if (i == KASAN_NR_FREE_STACKS)
> -               i = alloc_meta->free_track_idx;
> -#endif
> -
> -       return &alloc_meta->free_track[i];
> -}
> -
>  #ifdef CONFIG_KASAN_GENERIC
>  static void print_stack(depot_stack_handle_t stack)
>  {
> diff --git a/mm/kasan/tags.c b/mm/kasan/tags.c
> index 25b7734e7013..201dee5d6ae0 100644
> --- a/mm/kasan/tags.c
> +++ b/mm/kasan/tags.c
> @@ -162,3 +162,40 @@ void __hwasan_tag_memory(unsigned long addr, u8 tag, unsigned long size)
>         kasan_poison_shadow((void *)addr, size, tag);
>  }
>  EXPORT_SYMBOL(__hwasan_tag_memory);
> +
> +void kasan_set_free_info(struct kmem_cache *cache,
> +                               void *object, u8 tag)
> +{
> +       struct kasan_alloc_meta *alloc_meta;
> +       u8 idx = 0;
> +
> +       alloc_meta = get_alloc_info(cache, object);
> +
> +#ifdef CONFIG_KASAN_SW_TAGS_IDENTIFY
> +       idx = alloc_meta->free_track_idx;
> +       alloc_meta->free_pointer_tag[idx] = tag;
> +       alloc_meta->free_track_idx = (idx + 1) % KASAN_NR_FREE_STACKS;
> +#endif
> +
> +       kasan_set_track(&alloc_meta->free_track[idx], GFP_NOWAIT);
> +}
> +
> +struct kasan_track *kasan_get_free_track(struct kmem_cache *cache,
> +                               void *object, u8 tag)
> +{
> +       struct kasan_alloc_meta *alloc_meta;
> +       int i = 0;
> +
> +       alloc_meta = get_alloc_info(cache, object);
> +
> +#ifdef CONFIG_KASAN_SW_TAGS_IDENTIFY
> +       for (i = 0; i < KASAN_NR_FREE_STACKS; i++) {
> +               if (alloc_meta->free_pointer_tag[i] == tag)
> +                       break;
> +       }
> +       if (i == KASAN_NR_FREE_STACKS)
> +               i = alloc_meta->free_track_idx;
> +#endif
> +
> +       return &alloc_meta->free_track[i];
> +}
> --
> 2.18.0
