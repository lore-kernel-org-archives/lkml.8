Return-Path: <SRS0=F+sq=6U=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8842FC38A24
	for <linux-kernel@archiver.kernel.org>; Wed,  6 May 2020 09:50:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 584CA2070B
	for <linux-kernel@archiver.kernel.org>; Wed,  6 May 2020 09:50:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="WpjHBPWX"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729214AbgEFJuj (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 6 May 2020 05:50:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34680 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1729188AbgEFJui (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 May 2020 05:50:38 -0400
Received: from mail-qv1-xf43.google.com (mail-qv1-xf43.google.com [IPv6:2607:f8b0:4864:20::f43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E9AB7C061A0F
        for <linux-kernel@vger.kernel.org>; Wed,  6 May 2020 02:50:37 -0700 (PDT)
Received: by mail-qv1-xf43.google.com with SMTP id p13so361209qvt.12
        for <linux-kernel@vger.kernel.org>; Wed, 06 May 2020 02:50:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=j5iMU2d4N/4y18awBTt8gjljQLvXQSdia/Cv9QIxeQc=;
        b=WpjHBPWXGTysRpxifjir4tXVCuKqA1X+l/deTz186nKbtDUTwu3h5569FI40ufr7Y0
         jelE3jp7G8bz9axcn6AXPJXy6yfrpiDVcXv0zhsWqOhRjsO3WgmfH7ZCZnmkigqa4CSc
         q5bLcMsoWaA+5a+SMWP7taOFMyIwdHJvpRFbVP4FxIiipCJgab6ceIi695Dt4wA+u3yL
         GbRaFkMKtyllv59YmxI8lsW8o+eq1DZmYfTlIEYNwMT1+thAJ7nAoGws0qpEBQnuZFMb
         iJi5Q5bF59al+NHZaNPO/j/U3J1D8HIFH/czkNrVkDGUd8O1qc/wX+u/6bj+EjX1BhxR
         oB5w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=j5iMU2d4N/4y18awBTt8gjljQLvXQSdia/Cv9QIxeQc=;
        b=SN2PMTDOHug0qfFzLQhpDzM8gfF1/i0qr3x7vkfxCqQiT6mNrIGuQ+ZdeNuy2qnmKn
         v26SrABxEIlEzT+t0xU4ICWP3cPWp7PhggCZHborcP59PqOV1V6l4TddnwG/pjeqbYoh
         JfH+PBBF6B30P7fPZLwO9KX8iXJwssLrPUFVX+h5w7TpXFM6CdSPtH7MplbSuTiGz21R
         ftpWqXzBFKaFbkfCcHUjiouXUJFX6K0eeeg5sG0Oy5pPQiJ3ksa1d5X2aiCD5qZirAaF
         Wx5gm1UtYKmiHd2iuP4Qy4u75iRVhYq4JnaDfqeUMqHaxmzplruNB2JxNLA9yq8oZ7//
         q7Zg==
X-Gm-Message-State: AGi0PuYds8x1K4OqGKKjeZTZBrGk7nDPfeMwLNKxvQtcyjdlHH2ubk4P
        lVwy7UPZjI6YBjMl2e0E47xsWAE6snBLy3ovLFIR2Q==
X-Google-Smtp-Source: APiQypJznpPYxdfEFeeA/QM+9LIu8pWPgSCbjVVq0Lf5+We9+p6YyIWg00C4LnkrqUZfh4/TEvzyLyHWExLaxty7q4s=
X-Received: by 2002:ad4:5a48:: with SMTP id ej8mr7241682qvb.122.1588758636814;
 Wed, 06 May 2020 02:50:36 -0700 (PDT)
MIME-Version: 1.0
References: <20200506052155.14515-1-walter-zh.wu@mediatek.com>
In-Reply-To: <20200506052155.14515-1-walter-zh.wu@mediatek.com>
From:   Dmitry Vyukov <dvyukov@google.com>
Date:   Wed, 6 May 2020 11:50:25 +0200
Message-ID: <CACT4Y+ajKJpwNXd1V17bOT_ZShXm8h2eepxx_g4hAqk78SxCDA@mail.gmail.com>
Subject: Re: [PATCH 2/3] kasan: record and print the free track
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

On Wed, May 6, 2020 at 7:22 AM Walter Wu <walter-zh.wu@mediatek.com> wrote:
>
> We add new KASAN_RCU_STACK_RECORD configuration option. It will move
> free track from slub meta-data (struct kasan_alloc_meta) into freed object.
> Because we hope this options doesn't enlarge slub meta-data size.
>
> This option doesn't enlarge struct kasan_alloc_meta size.
> - add two call_rcu() call stack into kasan_alloc_meta, size is 8 bytes.
> - remove free track from kasan_alloc_meta, size is 8 bytes.
>
> This option is only suitable for generic KASAN, because we move free track
> into the freed object, so free track is valid information only when it
> exists in quarantine. If the object is in-use state, then the KASAN report
> doesn't print call_rcu() free track information.
>
> [1]https://bugzilla.kernel.org/show_bug.cgi?id=198437
>
> Signed-off-by: Walter Wu <walter-zh.wu@mediatek.com>
> Cc: Andrey Ryabinin <aryabinin@virtuozzo.com>
> Cc: Dmitry Vyukov <dvyukov@google.com>
> Cc: Alexander Potapenko <glider@google.com>
> ---
>  mm/kasan/common.c | 10 +++++++++-
>  mm/kasan/report.c | 24 +++++++++++++++++++++---
>  2 files changed, 30 insertions(+), 4 deletions(-)
>
> diff --git a/mm/kasan/common.c b/mm/kasan/common.c
> index 32d422bdf127..13ec03e225a7 100644
> --- a/mm/kasan/common.c
> +++ b/mm/kasan/common.c
> @@ -321,8 +321,15 @@ void kasan_record_callrcu(void *addr)
>                 /* record last call_rcu() call stack */
>                 alloc_info->rcu_free_stack[1] = save_stack(GFP_NOWAIT);
>  }
> -#endif
>
> +static void kasan_set_free_info(struct kmem_cache *cache,
> +               void *object, u8 tag)
> +{
> +       /* store free track into freed object */
> +       set_track((struct kasan_track *)(object + BYTES_PER_WORD), GFP_NOWAIT);
> +}
> +
> +#else
>  static void kasan_set_free_info(struct kmem_cache *cache,
>                 void *object, u8 tag)
>  {
> @@ -339,6 +346,7 @@ static void kasan_set_free_info(struct kmem_cache *cache,
>
>         set_track(&alloc_meta->free_track[idx], GFP_NOWAIT);
>  }
> +#endif
>
>  void kasan_poison_slab(struct page *page)
>  {
> diff --git a/mm/kasan/report.c b/mm/kasan/report.c
> index 7aaccc70b65b..f2b0c6b9dffa 100644
> --- a/mm/kasan/report.c
> +++ b/mm/kasan/report.c
> @@ -175,8 +175,23 @@ static void kasan_print_rcu_free_stack(struct kasan_alloc_meta *alloc_info)
>         print_track(&free_track, "Last call_rcu() call stack", true);
>         pr_err("\n");
>  }
> -#endif
>
> +static struct kasan_track *kasan_get_free_track(struct kmem_cache *cache,
> +               void *object, u8 tag, const void *addr)
> +{
> +       u8 *shadow_addr = (u8 *)kasan_mem_to_shadow(addr);
> +
> +       /*
> +        * Only the freed object can get free track,
> +        * because free track information is stored to freed object.
> +        */
> +       if (*shadow_addr == KASAN_KMALLOC_FREE)
> +               return (struct kasan_track *)(object + BYTES_PER_WORD);

Humm... the other patch defines BYTES_PER_WORD as 4... I would assume
seeing 8 (or sizeof(long)) here. Why 4?
Have you tested all 4 modes (RCU/no-RCU x SLAB/SLUB)? As far as I
remember one of the allocators stored something in the object.

Also, does this work with objects with ctors and slabs destroyed by
rcu? kasan_track may smash other things in these cases.
Have you looked at the KASAN implementation when free_track was
removed? That may have useful details :)


> +       else
> +               return NULL;
> +}
> +
> +#else
>  static struct kasan_track *kasan_get_free_track(struct kmem_cache *cache,
>                 void *object, u8 tag, const void *addr)
>  {
> @@ -196,6 +211,7 @@ static struct kasan_track *kasan_get_free_track(struct kmem_cache *cache,
>
>         return &alloc_meta->free_track[i];
>  }
> +#endif
>
>  static void describe_object(struct kmem_cache *cache, void *object,
>                                 const void *addr, u8 tag)
> @@ -208,8 +224,10 @@ static void describe_object(struct kmem_cache *cache, void *object,
>                 print_track(&alloc_info->alloc_track, "Allocated", false);
>                 pr_err("\n");
>                 free_track = kasan_get_free_track(cache, object, tag, addr);
> -               print_track(free_track, "Freed", false);
> -               pr_err("\n");
> +               if (free_track) {
> +                       print_track(free_track, "Freed", false);
> +                       pr_err("\n");
> +               }
>  #ifdef CONFIG_KASAN_RCU_STACK_RECORD
>                 kasan_print_rcu_free_stack(alloc_info);
>  #endif
> --
> 2.18.0
>
> --
> You received this message because you are subscribed to the Google Groups "kasan-dev" group.
> To unsubscribe from this group and stop receiving emails from it, send an email to kasan-dev+unsubscribe@googlegroups.com.
> To view this discussion on the web visit https://groups.google.com/d/msgid/kasan-dev/20200506052155.14515-1-walter-zh.wu%40mediatek.com.
