Return-Path: <SRS0=IaiW=7B=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A9980C433E0
	for <linux-kernel@archiver.kernel.org>; Tue, 19 May 2020 13:00:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7B9A4205CB
	for <linux-kernel@archiver.kernel.org>; Tue, 19 May 2020 13:00:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="eYzcJCuP"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728773AbgESNAd (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 19 May 2020 09:00:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42736 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727077AbgESNAd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 May 2020 09:00:33 -0400
Received: from mail-qk1-x743.google.com (mail-qk1-x743.google.com [IPv6:2607:f8b0:4864:20::743])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B74F4C08C5C0
        for <linux-kernel@vger.kernel.org>; Tue, 19 May 2020 06:00:32 -0700 (PDT)
Received: by mail-qk1-x743.google.com with SMTP id n14so14797152qke.8
        for <linux-kernel@vger.kernel.org>; Tue, 19 May 2020 06:00:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=o0yMq0MI3r0qFODZUM7uYp3B+CDouvIs/eVr6e/i9vY=;
        b=eYzcJCuPfhhRRjmG0F+1hJ83L2VRXAmAPwdIrzlKdaaaeOdC57abfEcg0wZxdFO6KM
         Y9CgvTOmQ0DCCMHQLuzQqPE1K+tAGf+Mdr12bfaFZzJxdNv846oqfnhPV/WCUEeT8KNi
         I9Ghdjdtgn4FeO7iOTNGk4ak4nvvd2DInKYKGnPQzfhpK2YtmMOX7M/aB6CUW9xbm+nt
         aQGDhuqdjiGFZhyfpTQpgbzxo5uFlJwiTPR015ilbL+YEnNMQlNvLVHCCzza3MH5XQTp
         4RDWv3oml6AlZrHgDNjlgkDs/xIcGe8nkxYVOqmxxD0fUe50/efF6Hick9FrUbdxq6sR
         8m5w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=o0yMq0MI3r0qFODZUM7uYp3B+CDouvIs/eVr6e/i9vY=;
        b=eJUD/yUYopVwrx4iV0tYuOh5RwFYbdcufubiiv/xnpCxpk077zH1+Zsg3aUKZecioo
         UjlkQ8MpQsEX5YOmE+E3HLQStceuReic1kWTNWtMGfM423NUWgBYpctIHPi97z0P2Bqq
         Pfxamm2Cf7ljYuhNzGxb3oejZyYY0w+9wGV8g09NcC4DJLwSsXGVCIiJ/PYxnASto1ag
         ofvU6K6/cVy9KU7jCuDwbquHNFxYpX6AE6CYRXTUXZYzutn+9UX81kzC0f1EizfDUpOY
         Pa30TufL07RyFQXKE7tgTO8jL0aBqKTNczIhgoXcJBNszlIpo9Ud/oWPw3Sg9/mGYOK1
         LrXQ==
X-Gm-Message-State: AOAM530W2n/YkDBtXuDn8DAOXd8PYsawhAvBK0/sZXW5hx/b7eSbw6wy
        aYnPf0sj4n20lygtiG8i9lCuih4p5GEMBCJhmvDeYP84rXo=
X-Google-Smtp-Source: ABdhPJy8qLcGh+jfA7uyNUr18AP8N/a2roQsmCjHSBbk8TY6zjFYe8sJ5tjnQGThzgH0RCi7qlcfjjWZrAML02gmFkA=
X-Received: by 2002:a37:9d55:: with SMTP id g82mr18468689qke.407.1589893231394;
 Tue, 19 May 2020 06:00:31 -0700 (PDT)
MIME-Version: 1.0
References: <20200519022517.24182-1-walter-zh.wu@mediatek.com>
In-Reply-To: <20200519022517.24182-1-walter-zh.wu@mediatek.com>
From:   Dmitry Vyukov <dvyukov@google.com>
Date:   Tue, 19 May 2020 15:00:18 +0200
Message-ID: <CACT4Y+aJDO+2kSgNpcvHksfn+bZaFWPoGj3-55-dyjLHcHbFUg@mail.gmail.com>
Subject: Re: [PATCH v4 2/4] kasan: record and print the free track
To:     Walter Wu <walter-zh.wu@mediatek.com>
Cc:     Andrey Ryabinin <aryabinin@virtuozzo.com>,
        Alexander Potapenko <glider@google.com>,
        kasan-dev <kasan-dev@googlegroups.com>,
        Linux-MM <linux-mm@kvack.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        wsd_upstream <wsd_upstream@mediatek.com>,
        linux-mediatek@lists.infradead.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, May 19, 2020 at 4:25 AM Walter Wu <walter-zh.wu@mediatek.com> wrote=
:
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
> [1]https://bugzilla.kernel.org/show_bug.cgi?id=3D198437
>
> Signed-off-by: Walter Wu <walter-zh.wu@mediatek.com>
> Suggested-by: Dmitry Vyukov <dvyukov@google.com>
> Cc: Andrey Ryabinin <aryabinin@virtuozzo.com>
> Cc: Dmitry Vyukov <dvyukov@google.com>
> Cc: Alexander Potapenko <glider@google.com>
> ---
>  mm/kasan/common.c  | 22 ++--------------------
>  mm/kasan/generic.c | 18 ++++++++++++++++++
>  mm/kasan/kasan.h   |  7 +++++++
>  mm/kasan/report.c  | 20 --------------------
>  mm/kasan/tags.c    | 37 +++++++++++++++++++++++++++++++++++++
>  5 files changed, 64 insertions(+), 40 deletions(-)
>
> diff --git a/mm/kasan/common.c b/mm/kasan/common.c
> index 8bc618289bb1..47b53912f322 100644
> --- a/mm/kasan/common.c
> +++ b/mm/kasan/common.c
> @@ -51,7 +51,7 @@ depot_stack_handle_t kasan_save_stack(gfp_t flags)
>         return stack_depot_save(entries, nr_entries, flags);
>  }
>
> -static inline void set_track(struct kasan_track *track, gfp_t flags)
> +void kasan_set_track(struct kasan_track *track, gfp_t flags)
>  {
>         track->pid =3D current->pid;
>         track->stack =3D kasan_save_stack(flags);
> @@ -299,24 +299,6 @@ struct kasan_free_meta *get_free_info(struct kmem_ca=
che *cache,
>         return (void *)object + cache->kasan_info.free_meta_offset;
>  }
>
> -
> -static void kasan_set_free_info(struct kmem_cache *cache,
> -               void *object, u8 tag)
> -{
> -       struct kasan_alloc_meta *alloc_meta;
> -       u8 idx =3D 0;
> -
> -       alloc_meta =3D get_alloc_info(cache, object);
> -
> -#ifdef CONFIG_KASAN_SW_TAGS_IDENTIFY
> -       idx =3D alloc_meta->free_track_idx;
> -       alloc_meta->free_pointer_tag[idx] =3D tag;
> -       alloc_meta->free_track_idx =3D (idx + 1) % KASAN_NR_FREE_STACKS;
> -#endif
> -
> -       set_track(&alloc_meta->free_track[idx], GFP_NOWAIT);
> -}
> -
>  void kasan_poison_slab(struct page *page)
>  {
>         unsigned long i;
> @@ -492,7 +474,7 @@ static void *__kasan_kmalloc(struct kmem_cache *cache=
, const void *object,
>                 KASAN_KMALLOC_REDZONE);
>
>         if (cache->flags & SLAB_KASAN)
> -               set_track(&get_alloc_info(cache, object)->alloc_track, fl=
ags);
> +               kasan_set_track(&get_alloc_info(cache, object)->alloc_tra=
ck, flags);
>
>         return set_tag(object, tag);
>  }
> diff --git a/mm/kasan/generic.c b/mm/kasan/generic.c
> index 3372bdcaf92a..763d8a13e0ac 100644
> --- a/mm/kasan/generic.c
> +++ b/mm/kasan/generic.c
> @@ -344,3 +344,21 @@ void kasan_record_aux_stack(void *addr)
>         alloc_info->aux_stack[1] =3D alloc_info->aux_stack[0];
>         alloc_info->aux_stack[0] =3D kasan_save_stack(GFP_NOWAIT);
>  }
> +
> +void kasan_set_free_info(struct kmem_cache *cache,
> +                               void *object, u8 tag)
> +{
> +       struct kasan_free_meta *free_meta;
> +
> +       free_meta =3D get_free_info(cache, object);
> +       kasan_set_track(&free_meta->free_track, GFP_NOWAIT);
> +}
> +
> +struct kasan_track *kasan_get_free_track(struct kmem_cache *cache,
> +                               void *object, u8 tag)
> +{
> +       struct kasan_free_meta *free_meta;
> +
> +       free_meta =3D get_free_info(cache, object);
> +       return &free_meta->free_track;
> +}
> diff --git a/mm/kasan/kasan.h b/mm/kasan/kasan.h
> index a7391bc83070..ad897ec36545 100644
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
> @@ -168,6 +171,10 @@ void kasan_report_invalid_free(void *object, unsigne=
d long ip);
>  struct page *kasan_addr_to_page(const void *addr);
>
>  depot_stack_handle_t kasan_save_stack(gfp_t flags);
> +void kasan_set_track(struct kasan_track *track, gfp_t flags);
> +void kasan_set_free_info(struct kmem_cache *cache, void *object, u8 tag)=
;
> +struct kasan_track *kasan_get_free_track(struct kmem_cache *cache,
> +                               void *object, u8 tag);
>
>  #if defined(CONFIG_KASAN_GENERIC) && \
>         (defined(CONFIG_SLAB) || defined(CONFIG_SLUB))
> diff --git a/mm/kasan/report.c b/mm/kasan/report.c
> index 6f8f2bf8f53b..96d2657fe70f 100644
> --- a/mm/kasan/report.c
> +++ b/mm/kasan/report.c
> @@ -159,26 +159,6 @@ static void describe_object_addr(struct kmem_cache *=
cache, void *object,
>                 (void *)(object_addr + cache->object_size));
>  }
>
> -static struct kasan_track *kasan_get_free_track(struct kmem_cache *cache=
,
> -               void *object, u8 tag)
> -{
> -       struct kasan_alloc_meta *alloc_meta;
> -       int i =3D 0;
> -
> -       alloc_meta =3D get_alloc_info(cache, object);
> -
> -#ifdef CONFIG_KASAN_SW_TAGS_IDENTIFY
> -       for (i =3D 0; i < KASAN_NR_FREE_STACKS; i++) {
> -               if (alloc_meta->free_pointer_tag[i] =3D=3D tag)
> -                       break;
> -       }
> -       if (i =3D=3D KASAN_NR_FREE_STACKS)
> -               i =3D alloc_meta->free_track_idx;
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
> @@ -162,3 +162,40 @@ void __hwasan_tag_memory(unsigned long addr, u8 tag,=
 unsigned long size)
>         kasan_poison_shadow((void *)addr, size, tag);
>  }
>  EXPORT_SYMBOL(__hwasan_tag_memory);
> +
> +void kasan_set_free_info(struct kmem_cache *cache,
> +                               void *object, u8 tag)
> +{
> +       struct kasan_alloc_meta *alloc_meta;
> +       u8 idx =3D 0;
> +
> +       alloc_meta =3D get_alloc_info(cache, object);
> +
> +#ifdef CONFIG_KASAN_SW_TAGS_IDENTIFY
> +       idx =3D alloc_meta->free_track_idx;
> +       alloc_meta->free_pointer_tag[idx] =3D tag;
> +       alloc_meta->free_track_idx =3D (idx + 1) % KASAN_NR_FREE_STACKS;
> +#endif
> +
> +       kasan_set_track(&alloc_meta->free_track[idx], GFP_NOWAIT);
> +}
> +
> +struct kasan_track *kasan_get_free_track(struct kmem_cache *cache,
> +                               void *object, u8 tag)
> +{
> +       struct kasan_alloc_meta *alloc_meta;
> +       int i =3D 0;
> +
> +       alloc_meta =3D get_alloc_info(cache, object);
> +
> +#ifdef CONFIG_KASAN_SW_TAGS_IDENTIFY
> +       for (i =3D 0; i < KASAN_NR_FREE_STACKS; i++) {
> +               if (alloc_meta->free_pointer_tag[i] =3D=3D tag)
> +                       break;
> +       }
> +       if (i =3D=3D KASAN_NR_FREE_STACKS)
> +               i =3D alloc_meta->free_track_idx;
> +#endif
> +
> +       return &alloc_meta->free_track[i];
> +}

Hi Walter,

FTR I've uploaded this for review purposes here:
https://linux-review.googlesource.com/c/linux/kernel/git/torvalds/linux/+/2=
458

Diff from the previous version is available as:
https://linux-review.googlesource.com/c/linux/kernel/git/torvalds/linux/+/2=
458/1..2

I've tested this locally and with syzkaller. This is =F0=9F=94=A5=F0=9F=94=
=A5=F0=9F=94=A5:

[   80.583021][    C3] Freed by task 0:
[   80.583480][    C3]  kasan_save_stack+0x1b/0x40 mm/kasan/common.c:49
[   80.584056][    C3]  kasan_set_track+0x1c/0x30 mm/kasan/common.c:57
[   80.584617][    C3]  kasan_set_free_info+0x1b/0x30 mm/kasan/generic.c:35=
4
[   80.585221][    C3]  __kasan_slab_free+0xd8/0x120 mm/kasan/common.c:438
[   80.585814][    C3]  __cache_free mm/slab.c:3426 [inline]
[   80.585814][    C3]  kfree+0x10b/0x2b0 mm/slab.c:3757
[   80.586291][    C3]  kasan_rcu_reclaim+0x16/0x43 [test_kasan]
[   80.587009][    C3]  rcu_do_batch kernel/rcu/tree.c:2207 [inline]
[   80.587009][    C3]  rcu_core+0x59f/0x1370 kernel/rcu/tree.c:2434
[   80.587537][    C3]  __do_softirq+0x26c/0x9fa kernel/softirq.c:292
[   80.588085][    C3]
[   80.588367][    C3] Last one call_rcu() call stack:
[   80.589052][    C3]  kasan_save_stack+0x1b/0x40 mm/kasan/common.c:49
[   80.589622][    C3]  kasan_record_aux_stack+0x82/0xb0 mm/kasan/generic.c=
:345
[   80.590254][    C3]  __call_rcu kernel/rcu/tree.c:2672 [inline]
[   80.590254][    C3]  call_rcu+0x14f/0x7f0 kernel/rcu/tree.c:2746
[   80.590782][    C3]  kasan_rcu_uaf+0xe4/0xeb [test_kasan]
[   80.591697][    C3]  kmalloc_tests_init+0xbc/0x1097 [test_kasan]
[   80.592900][    C3]  do_one_initcall+0x10a/0x7d0 init/main.c:1196
[   80.593494][    C3]  do_init_module+0x1e6/0x6d0 kernel/module.c:3539
[   80.594066][    C3]  load_module+0x7464/0x9450 kernel/module.c:3890
[   80.594626][    C3]  __do_sys_init_module+0x1e3/0x220 kernel/module.c:39=
53
[   80.595265][    C3]  do_syscall_64+0xf6/0x7d0 arch/x86/entry/common.c:29=
5
[   80.595822][    C3]  entry_SYSCALL_64_after_hwframe+0x49/0xb3


Overall this looks very good to me.
But there is one aspect that bothers me. In the previous patch you had
code that returned NULL from kasan_get_free_track() if the object is
live (which means free meta is not available, it's occupied by object
data). Now you dropped that code, but I think we still need it.
Otherwise we cast user object data to free meta and print the free
stack/pid from whatever garbage is there. This may lead to very
confusing output and potentially to crashes in stackdepot.

What do you think about this patch on top of your patches?
https://linux-review.googlesource.com/c/linux/kernel/git/torvalds/linux/+/2=
478
This way we very precisely mark the period of time when the object has
free track live and set.
If it looks good to you, feel free to incorporate it into your series.
