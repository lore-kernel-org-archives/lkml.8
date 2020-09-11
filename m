Return-Path: <SRS0=qBN/=CU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-17.4 required=3.0 tests=BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_IN_DEF_DKIM_WL autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 03130C433E2
	for <linux-kernel@archiver.kernel.org>; Fri, 11 Sep 2020 07:17:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B099620731
	for <linux-kernel@archiver.kernel.org>; Fri, 11 Sep 2020 07:17:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="CM1Z1fWR"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725774AbgIKHRb (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 11 Sep 2020 03:17:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42742 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725536AbgIKHR2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Sep 2020 03:17:28 -0400
Received: from mail-qt1-x842.google.com (mail-qt1-x842.google.com [IPv6:2607:f8b0:4864:20::842])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D08A1C061756
        for <linux-kernel@vger.kernel.org>; Fri, 11 Sep 2020 00:17:27 -0700 (PDT)
Received: by mail-qt1-x842.google.com with SMTP id c18so7111650qtw.5
        for <linux-kernel@vger.kernel.org>; Fri, 11 Sep 2020 00:17:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=gVSrJh8rChLGd4eP0NihtPJ1y8qJuAg60MCfyTLhE9Y=;
        b=CM1Z1fWRXhM8rah2fVEz5/vLlQR7J0AZSq0B3zjd5oFrpc7uCFzWPZI9ZRRzqgLRrl
         4lgP+9C5+2kTla9iHkuh6LOwvbvu7T/ONeaLU2+nfcrcaVCFbMpOGovfIoYnF6/w0PHD
         1CejgKTfH7zj9vXP7tNdYtrMxBAdrDCUSYIl86cWdl8w+4I88p3ocRY1Xs4SbhCsRKiY
         cCT0JlmYyVSGWWnRLNSisMhN/TV8IJaTqaNXX2MrzlNduw2xopLKnfLbUPHAfcQQM4y1
         7kBlwqNs6Dg3ukTqyoOp7K8YEFZLOqNl/jL5n6ZtUxBgSz84uTTO5m9gL3VPJNbn5AXp
         cQzg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=gVSrJh8rChLGd4eP0NihtPJ1y8qJuAg60MCfyTLhE9Y=;
        b=J2+PunAeAxfmspPw0nt6pd1UhHYDjC1ZBkA0Ng9CkUW+Ezr8ZqZmkBHTCa/M4m86bB
         B6/Rxmu+u7R5WInJ3aYr+cqcJvmRvgYsd4FBYAjWcYNEyArKb7hVoR8Q9uvBN/LIIn9F
         vH4jGLlKL15Z+JegqpkDgGIq4+0sCHMwceL1tO6cMXAv62D4sMZALxgDRmb56geF8oaI
         pv6fMW3ENYvOOKipaq9fYXV3F6DkRzEHpRDbVNpBPUC7222UiCdUPPyt/DjOIy82+mcT
         AzGULDpaQS4Epe6/iMc+lH5LuTqfQ0wcsK3Q+fq9E40yqbTd91KNYBljEBi4Oq0aAHNk
         WBvA==
X-Gm-Message-State: AOAM5334+TQTRYoBMSf0kBYyx+HpiE+O/snhbOI7QZUsK1FqQaBF9mNo
        6BBsYKma1vlSwf4vHWW0qEwIJEe60qALD8+mk2Cr8Q==
X-Google-Smtp-Source: ABdhPJy4n68d2GrQ/UKBjsgoTcyQaWZOgZGHHcJofg+8FOTgrre1kyDMcODPLvczBMZOWjWulZdaQWOY4HVAQ7a/ZGU=
X-Received: by 2002:aed:26a7:: with SMTP id q36mr642989qtd.57.1599808645941;
 Fri, 11 Sep 2020 00:17:25 -0700 (PDT)
MIME-Version: 1.0
References: <20200907134055.2878499-1-elver@google.com> <20200907134055.2878499-5-elver@google.com>
In-Reply-To: <20200907134055.2878499-5-elver@google.com>
From:   Dmitry Vyukov <dvyukov@google.com>
Date:   Fri, 11 Sep 2020 09:17:14 +0200
Message-ID: <CACT4Y+aXNmQzp6J+mP+ELj8kUHmRPkibc1--KtV9a3ud_X8miw@mail.gmail.com>
Subject: Re: [PATCH RFC 04/10] mm, kfence: insert KFENCE hooks for SLAB
To:     Marco Elver <elver@google.com>
Cc:     Alexander Potapenko <glider@google.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Christoph Lameter <cl@linux.com>,
        David Rientjes <rientjes@google.com>,
        Joonsoo Kim <iamjoonsoo.kim@lge.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Pekka Enberg <penberg@kernel.org>,
        "H. Peter Anvin" <hpa@zytor.com>,
        "Paul E. McKenney" <paulmck@kernel.org>,
        Andrey Konovalov <andreyknvl@google.com>,
        Andrey Ryabinin <aryabinin@virtuozzo.com>,
        Andy Lutomirski <luto@kernel.org>,
        Borislav Petkov <bp@alien8.de>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Eric Dumazet <edumazet@google.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Ingo Molnar <mingo@redhat.com>, Jann Horn <jannh@google.com>,
        Jonathan Corbet <corbet@lwn.net>,
        Kees Cook <keescook@chromium.org>,
        Peter Zijlstra <peterz@infradead.org>, Qian Cai <cai@lca.pw>,
        Thomas Gleixner <tglx@linutronix.de>,
        Will Deacon <will@kernel.org>,
        "the arch/x86 maintainers" <x86@kernel.org>,
        "open list:DOCUMENTATION" <linux-doc@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        kasan-dev <kasan-dev@googlegroups.com>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        Linux-MM <linux-mm@kvack.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Sep 7, 2020 at 3:41 PM Marco Elver <elver@google.com> wrote:
>
> From: Alexander Potapenko <glider@google.com>
>
> Inserts KFENCE hooks into the SLAB allocator.
>
> We note the addition of the 'orig_size' argument to slab_alloc*()
> functions, to be able to pass the originally requested size to KFENCE.
> When KFENCE is disabled, there is no additional overhead, since these
> functions are __always_inline.
>
> Co-developed-by: Marco Elver <elver@google.com>
> Signed-off-by: Marco Elver <elver@google.com>
> Signed-off-by: Alexander Potapenko <glider@google.com>
> ---
>  mm/slab.c        | 46 ++++++++++++++++++++++++++++++++++------------
>  mm/slab_common.c |  6 +++++-
>  2 files changed, 39 insertions(+), 13 deletions(-)
>
> diff --git a/mm/slab.c b/mm/slab.c
> index 3160dff6fd76..30aba06ae02b 100644
> --- a/mm/slab.c
> +++ b/mm/slab.c
> @@ -100,6 +100,7 @@
>  #include       <linux/seq_file.h>
>  #include       <linux/notifier.h>
>  #include       <linux/kallsyms.h>
> +#include       <linux/kfence.h>
>  #include       <linux/cpu.h>
>  #include       <linux/sysctl.h>
>  #include       <linux/module.h>
> @@ -3206,7 +3207,7 @@ static void *____cache_alloc_node(struct kmem_cache *cachep, gfp_t flags,
>  }
>
>  static __always_inline void *
> -slab_alloc_node(struct kmem_cache *cachep, gfp_t flags, int nodeid,
> +slab_alloc_node(struct kmem_cache *cachep, gfp_t flags, int nodeid, size_t orig_size,
>                    unsigned long caller)
>  {
>         unsigned long save_flags;
> @@ -3219,6 +3220,10 @@ slab_alloc_node(struct kmem_cache *cachep, gfp_t flags, int nodeid,
>         if (unlikely(!cachep))
>                 return NULL;
>
> +       ptr = kfence_alloc(cachep, orig_size, flags);
> +       if (unlikely(ptr))
> +               goto out_hooks;
> +
>         cache_alloc_debugcheck_before(cachep, flags);
>         local_irq_save(save_flags);
>
> @@ -3251,6 +3256,7 @@ slab_alloc_node(struct kmem_cache *cachep, gfp_t flags, int nodeid,
>         if (unlikely(slab_want_init_on_alloc(flags, cachep)) && ptr)
>                 memset(ptr, 0, cachep->object_size);
>
> +out_hooks:
>         slab_post_alloc_hook(cachep, objcg, flags, 1, &ptr);
>         return ptr;
>  }
> @@ -3288,7 +3294,7 @@ __do_cache_alloc(struct kmem_cache *cachep, gfp_t flags)
>  #endif /* CONFIG_NUMA */
>
>  static __always_inline void *
> -slab_alloc(struct kmem_cache *cachep, gfp_t flags, unsigned long caller)
> +slab_alloc(struct kmem_cache *cachep, gfp_t flags, size_t orig_size, unsigned long caller)
>  {
>         unsigned long save_flags;
>         void *objp;
> @@ -3299,6 +3305,10 @@ slab_alloc(struct kmem_cache *cachep, gfp_t flags, unsigned long caller)
>         if (unlikely(!cachep))
>                 return NULL;
>
> +       objp = kfence_alloc(cachep, orig_size, flags);
> +       if (unlikely(objp))
> +               goto leave;
> +
>         cache_alloc_debugcheck_before(cachep, flags);
>         local_irq_save(save_flags);
>         objp = __do_cache_alloc(cachep, flags);
> @@ -3309,6 +3319,7 @@ slab_alloc(struct kmem_cache *cachep, gfp_t flags, unsigned long caller)
>         if (unlikely(slab_want_init_on_alloc(flags, cachep)) && objp)
>                 memset(objp, 0, cachep->object_size);
>
> +leave:
>         slab_post_alloc_hook(cachep, objcg, flags, 1, &objp);
>         return objp;
>  }
> @@ -3414,6 +3425,11 @@ static void cache_flusharray(struct kmem_cache *cachep, struct array_cache *ac)
>  static __always_inline void __cache_free(struct kmem_cache *cachep, void *objp,
>                                          unsigned long caller)
>  {
> +       if (kfence_free(objp)) {
> +               kmemleak_free_recursive(objp, cachep->flags);
> +               return;
> +       }
> +
>         /* Put the object into the quarantine, don't touch it for now. */
>         if (kasan_slab_free(cachep, objp, _RET_IP_))
>                 return;
> @@ -3479,7 +3495,7 @@ void ___cache_free(struct kmem_cache *cachep, void *objp,
>   */
>  void *kmem_cache_alloc(struct kmem_cache *cachep, gfp_t flags)
>  {
> -       void *ret = slab_alloc(cachep, flags, _RET_IP_);
> +       void *ret = slab_alloc(cachep, flags, cachep->object_size, _RET_IP_);


It's kinda minor, but since we are talking about malloc fast path:
will passing 0 instead of cachep->object_size (here and everywhere
else) and then using cachep->object_size on the slow path if 0 is
passed as size improve codegen?


>         trace_kmem_cache_alloc(_RET_IP_, ret,
>                                cachep->object_size, cachep->size, flags);
> @@ -3512,7 +3528,7 @@ int kmem_cache_alloc_bulk(struct kmem_cache *s, gfp_t flags, size_t size,
>
>         local_irq_disable();
>         for (i = 0; i < size; i++) {
> -               void *objp = __do_cache_alloc(s, flags);
> +               void *objp = kfence_alloc(s, s->object_size, flags) ?: __do_cache_alloc(s, flags);
>
>                 if (unlikely(!objp))
>                         goto error;
> @@ -3545,7 +3561,7 @@ kmem_cache_alloc_trace(struct kmem_cache *cachep, gfp_t flags, size_t size)
>  {
>         void *ret;
>
> -       ret = slab_alloc(cachep, flags, _RET_IP_);
> +       ret = slab_alloc(cachep, flags, size, _RET_IP_);
>
>         ret = kasan_kmalloc(cachep, ret, size, flags);
>         trace_kmalloc(_RET_IP_, ret,
> @@ -3571,7 +3587,7 @@ EXPORT_SYMBOL(kmem_cache_alloc_trace);
>   */
>  void *kmem_cache_alloc_node(struct kmem_cache *cachep, gfp_t flags, int nodeid)
>  {
> -       void *ret = slab_alloc_node(cachep, flags, nodeid, _RET_IP_);
> +       void *ret = slab_alloc_node(cachep, flags, nodeid, cachep->object_size, _RET_IP_);
>
>         trace_kmem_cache_alloc_node(_RET_IP_, ret,
>                                     cachep->object_size, cachep->size,
> @@ -3589,7 +3605,7 @@ void *kmem_cache_alloc_node_trace(struct kmem_cache *cachep,
>  {
>         void *ret;
>
> -       ret = slab_alloc_node(cachep, flags, nodeid, _RET_IP_);
> +       ret = slab_alloc_node(cachep, flags, nodeid, size, _RET_IP_);
>
>         ret = kasan_kmalloc(cachep, ret, size, flags);
>         trace_kmalloc_node(_RET_IP_, ret,
> @@ -3650,7 +3666,7 @@ static __always_inline void *__do_kmalloc(size_t size, gfp_t flags,
>         cachep = kmalloc_slab(size, flags);
>         if (unlikely(ZERO_OR_NULL_PTR(cachep)))
>                 return cachep;
> -       ret = slab_alloc(cachep, flags, caller);
> +       ret = slab_alloc(cachep, flags, size, caller);
>
>         ret = kasan_kmalloc(cachep, ret, size, flags);
>         trace_kmalloc(caller, ret,
> @@ -4138,18 +4154,24 @@ void __check_heap_object(const void *ptr, unsigned long n, struct page *page,
>                          bool to_user)
>  {
>         struct kmem_cache *cachep;
> -       unsigned int objnr;
> +       unsigned int objnr = 0;
>         unsigned long offset;
> +       bool is_kfence = is_kfence_address(ptr);
>
>         ptr = kasan_reset_tag(ptr);
>
>         /* Find and validate object. */
>         cachep = page->slab_cache;
> -       objnr = obj_to_index(cachep, page, (void *)ptr);
> -       BUG_ON(objnr >= cachep->num);
> +       if (!is_kfence) {
> +               objnr = obj_to_index(cachep, page, (void *)ptr);
> +               BUG_ON(objnr >= cachep->num);
> +       }
>
>         /* Find offset within object. */
> -       offset = ptr - index_to_obj(cachep, page, objnr) - obj_offset(cachep);
> +       if (is_kfence_address(ptr))
> +               offset = ptr - kfence_object_start(ptr);
> +       else
> +               offset = ptr - index_to_obj(cachep, page, objnr) - obj_offset(cachep);
>
>         /* Allow address range falling entirely within usercopy region. */
>         if (offset >= cachep->useroffset &&
> diff --git a/mm/slab_common.c b/mm/slab_common.c
> index f9ccd5dc13f3..6e35e273681a 100644
> --- a/mm/slab_common.c
> +++ b/mm/slab_common.c
> @@ -12,6 +12,7 @@
>  #include <linux/memory.h>
>  #include <linux/cache.h>
>  #include <linux/compiler.h>
> +#include <linux/kfence.h>
>  #include <linux/module.h>
>  #include <linux/cpu.h>
>  #include <linux/uaccess.h>
> @@ -448,6 +449,9 @@ static int shutdown_cache(struct kmem_cache *s)
>         /* free asan quarantined objects */
>         kasan_cache_shutdown(s);
>
> +       if (!kfence_shutdown_cache(s))
> +               return -EBUSY;
> +
>         if (__kmem_cache_shutdown(s) != 0)
>                 return -EBUSY;
>
> @@ -1171,7 +1175,7 @@ size_t ksize(const void *objp)
>         if (unlikely(ZERO_OR_NULL_PTR(objp)) || !__kasan_check_read(objp, 1))
>                 return 0;
>
> -       size = __ksize(objp);
> +       size = kfence_ksize(objp) ?: __ksize(objp);
>         /*
>          * We assume that ksize callers could use whole allocated area,
>          * so we need to unpoison this area.
> --
> 2.28.0.526.ge36021eeef-goog
>
