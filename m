Return-Path: <SRS0=qBN/=CU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-17.4 required=3.0 tests=BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_IN_DEF_DKIM_WL autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E2E30C43461
	for <linux-kernel@archiver.kernel.org>; Fri, 11 Sep 2020 14:44:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id AC346222E7
	for <linux-kernel@archiver.kernel.org>; Fri, 11 Sep 2020 14:44:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Byv0FemA"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726269AbgIKOn1 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 11 Sep 2020 10:43:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39580 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726145AbgIKNEA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Sep 2020 09:04:00 -0400
Received: from mail-qt1-x844.google.com (mail-qt1-x844.google.com [IPv6:2607:f8b0:4864:20::844])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 595AFC0613ED
        for <linux-kernel@vger.kernel.org>; Fri, 11 Sep 2020 06:03:58 -0700 (PDT)
Received: by mail-qt1-x844.google.com with SMTP id p65so7753615qtd.2
        for <linux-kernel@vger.kernel.org>; Fri, 11 Sep 2020 06:03:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=UXp+wN/Ry6nApS13CcvCEGTyxqKSfC2ghriIPUG6Irg=;
        b=Byv0FemAT1MqVzcqIMdOkPE+ga6b61o5HDNfELLV3TxwpZ6hfopL2LOtz8Yo2RXznG
         7D1Z6WcXezyHaJ7wIKNBkt6Y27wwuKCztLDzOOfZ7GNsWdw56kcfMNjQAm82rpE/c/bg
         DK0zEwQMQ25MFX9CF11cUDGUW6NWwbbfynJJSTjkTH8GeWfsAkxro4JKXxayh6LvKmfZ
         XcUQ+H0bJIIeDJcXD4F4sqgazyBvdc3SF/ixkj8D/MtWhlWAO99pskVogw0+mwzethdH
         gzXlzYxmeavjrIvAO5jDLb0mVYymb0AptZktGxZNuyWnn6gRLkEFgPMItuSn3JdkUgfr
         yRBQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=UXp+wN/Ry6nApS13CcvCEGTyxqKSfC2ghriIPUG6Irg=;
        b=WzBTEUuR7ed8YpnY4OhaoDKQkVitvwRgiL/qOCvB9wjGhJLoYHNBRwdm/s/L9I1pF1
         c7gl76YXRm2MPTUebxOZsBw9ptBPTM+3KsqSmt+ZKgfCcLn3zFr+HvDR4zL9dmtZ4QOF
         bKtYakMvrK1h30VgV3eduQnD0vqArDaxZ8v2Ldl0h4FG8i6JD5lWc3jL2Nrh3CklJPWc
         qM6k8f+WUwoYGN/xujD2w1gHSWPdPZKYA3Ss545TMNF1VOUdhJm+x6YqskTjaz71XaEc
         DmE3Yo9OmPFWAQNYRotNhNoMBSMSSS3XhNDcCxPuNw6YQh2U+iojqLfrQVlhPe4Y+rTf
         Lhrg==
X-Gm-Message-State: AOAM531Sue6N6rFOVgKLLh9/iFACl0/AFY6m1kGEeKh31gycYSwv0UG+
        LxK/pqAxp53mu+HSQmwa7Tm1F98VGWP9/AodUT3UHw==
X-Google-Smtp-Source: ABdhPJxrVCH57CVfp1175OPiNhGvetEllsVJBj/B4eeSkXBeyz0Oiej2impuZk++RSNeZKJdRCmf8es+QgFN6yCtelg=
X-Received: by 2002:ac8:4806:: with SMTP id g6mr1747161qtq.380.1599829437150;
 Fri, 11 Sep 2020 06:03:57 -0700 (PDT)
MIME-Version: 1.0
References: <20200907134055.2878499-1-elver@google.com> <20200907134055.2878499-5-elver@google.com>
 <CACT4Y+aXNmQzp6J+mP+ELj8kUHmRPkibc1--KtV9a3ud_X8miw@mail.gmail.com> <CANpmjNNGZ-bnzzG+nbnCMCNCWGxakJ3wq+pmDjsD5LyWmwmyoQ@mail.gmail.com>
In-Reply-To: <CANpmjNNGZ-bnzzG+nbnCMCNCWGxakJ3wq+pmDjsD5LyWmwmyoQ@mail.gmail.com>
From:   Dmitry Vyukov <dvyukov@google.com>
Date:   Fri, 11 Sep 2020 15:03:45 +0200
Message-ID: <CACT4Y+ZGASbeN-O9yzYo6TP_43x-XTpTQ7smK5viM5+E6i5JyQ@mail.gmail.com>
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

On Fri, Sep 11, 2020 at 2:24 PM Marco Elver <elver@google.com> wrote:
> > > From: Alexander Potapenko <glider@google.com>
> > >
> > > Inserts KFENCE hooks into the SLAB allocator.
> > >
> > > We note the addition of the 'orig_size' argument to slab_alloc*()
> > > functions, to be able to pass the originally requested size to KFENCE.
> > > When KFENCE is disabled, there is no additional overhead, since these
> > > functions are __always_inline.
> > >
> > > Co-developed-by: Marco Elver <elver@google.com>
> > > Signed-off-by: Marco Elver <elver@google.com>
> > > Signed-off-by: Alexander Potapenko <glider@google.com>
> > > ---
> > >  mm/slab.c        | 46 ++++++++++++++++++++++++++++++++++------------
> > >  mm/slab_common.c |  6 +++++-
> > >  2 files changed, 39 insertions(+), 13 deletions(-)
> > >
> > > diff --git a/mm/slab.c b/mm/slab.c
> > > index 3160dff6fd76..30aba06ae02b 100644
> > > --- a/mm/slab.c
> > > +++ b/mm/slab.c
> > > @@ -100,6 +100,7 @@
> > >  #include       <linux/seq_file.h>
> > >  #include       <linux/notifier.h>
> > >  #include       <linux/kallsyms.h>
> > > +#include       <linux/kfence.h>
> > >  #include       <linux/cpu.h>
> > >  #include       <linux/sysctl.h>
> > >  #include       <linux/module.h>
> > > @@ -3206,7 +3207,7 @@ static void *____cache_alloc_node(struct kmem_cache *cachep, gfp_t flags,
> > >  }
> > >
> > >  static __always_inline void *
> > > -slab_alloc_node(struct kmem_cache *cachep, gfp_t flags, int nodeid,
> > > +slab_alloc_node(struct kmem_cache *cachep, gfp_t flags, int nodeid, size_t orig_size,
> > >                    unsigned long caller)
> > >  {
> > >         unsigned long save_flags;
> > > @@ -3219,6 +3220,10 @@ slab_alloc_node(struct kmem_cache *cachep, gfp_t flags, int nodeid,
> > >         if (unlikely(!cachep))
> > >                 return NULL;
> > >
> > > +       ptr = kfence_alloc(cachep, orig_size, flags);
> > > +       if (unlikely(ptr))
> > > +               goto out_hooks;
> > > +
> > >         cache_alloc_debugcheck_before(cachep, flags);
> > >         local_irq_save(save_flags);
> > >
> > > @@ -3251,6 +3256,7 @@ slab_alloc_node(struct kmem_cache *cachep, gfp_t flags, int nodeid,
> > >         if (unlikely(slab_want_init_on_alloc(flags, cachep)) && ptr)
> > >                 memset(ptr, 0, cachep->object_size);
> > >
> > > +out_hooks:
> > >         slab_post_alloc_hook(cachep, objcg, flags, 1, &ptr);
> > >         return ptr;
> > >  }
> > > @@ -3288,7 +3294,7 @@ __do_cache_alloc(struct kmem_cache *cachep, gfp_t flags)
> > >  #endif /* CONFIG_NUMA */
> > >
> > >  static __always_inline void *
> > > -slab_alloc(struct kmem_cache *cachep, gfp_t flags, unsigned long caller)
> > > +slab_alloc(struct kmem_cache *cachep, gfp_t flags, size_t orig_size, unsigned long caller)
> > >  {
> > >         unsigned long save_flags;
> > >         void *objp;
> > > @@ -3299,6 +3305,10 @@ slab_alloc(struct kmem_cache *cachep, gfp_t flags, unsigned long caller)
> > >         if (unlikely(!cachep))
> > >                 return NULL;
> > >
> > > +       objp = kfence_alloc(cachep, orig_size, flags);
> > > +       if (unlikely(objp))
> > > +               goto leave;
> > > +
> > >         cache_alloc_debugcheck_before(cachep, flags);
> > >         local_irq_save(save_flags);
> > >         objp = __do_cache_alloc(cachep, flags);
> > > @@ -3309,6 +3319,7 @@ slab_alloc(struct kmem_cache *cachep, gfp_t flags, unsigned long caller)
> > >         if (unlikely(slab_want_init_on_alloc(flags, cachep)) && objp)
> > >                 memset(objp, 0, cachep->object_size);
> > >
> > > +leave:
> > >         slab_post_alloc_hook(cachep, objcg, flags, 1, &objp);
> > >         return objp;
> > >  }
> > > @@ -3414,6 +3425,11 @@ static void cache_flusharray(struct kmem_cache *cachep, struct array_cache *ac)
> > >  static __always_inline void __cache_free(struct kmem_cache *cachep, void *objp,
> > >                                          unsigned long caller)
> > >  {
> > > +       if (kfence_free(objp)) {
> > > +               kmemleak_free_recursive(objp, cachep->flags);
> > > +               return;
> > > +       }
> > > +
> > >         /* Put the object into the quarantine, don't touch it for now. */
> > >         if (kasan_slab_free(cachep, objp, _RET_IP_))
> > >                 return;
> > > @@ -3479,7 +3495,7 @@ void ___cache_free(struct kmem_cache *cachep, void *objp,
> > >   */
> > >  void *kmem_cache_alloc(struct kmem_cache *cachep, gfp_t flags)
> > >  {
> > > -       void *ret = slab_alloc(cachep, flags, _RET_IP_);
> > > +       void *ret = slab_alloc(cachep, flags, cachep->object_size, _RET_IP_);
> >
> >
> > It's kinda minor, but since we are talking about malloc fast path:
> > will passing 0 instead of cachep->object_size (here and everywhere
> > else) and then using cachep->object_size on the slow path if 0 is
> > passed as size improve codegen?
>
> It doesn't save us much, maybe 1 instruction based on what I'm looking
> at right now. The main worry I have is that the 'orig_size' argument
> is now part of slab_alloc, and changing its semantics may cause
> problems in future if it's no longer just passed to kfence_alloc().
> Today, we can do the 'size = size ?: cache->object_size' trick inside
> kfence_alloc(), but at the cost breaking the intuitive semantics of
> slab_alloc's orig_size argument for future users. Is it worth it?

I don't have an answer to this question. I will leave this to others.
If nobody has strong support for changing semantics, let's leave it as
is. Maybe keep in mind as potential ballast.
FWIW most likely misuse of 0 size for other future purposes should
manifest itself in a quite straightforward way.
