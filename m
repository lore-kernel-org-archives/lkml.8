Return-Path: <SRS0=KWFo=BR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7A044C433DF
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Aug 2020 17:06:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 51B5D2086A
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Aug 2020 17:06:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="mkcM7xiA"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726806AbgHGRGk (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 7 Aug 2020 13:06:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41370 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725993AbgHGRGY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 Aug 2020 13:06:24 -0400
Received: from mail-oi1-x243.google.com (mail-oi1-x243.google.com [IPv6:2607:f8b0:4864:20::243])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5AE11C061756
        for <linux-kernel@vger.kernel.org>; Fri,  7 Aug 2020 10:06:24 -0700 (PDT)
Received: by mail-oi1-x243.google.com with SMTP id b22so2513657oic.8
        for <linux-kernel@vger.kernel.org>; Fri, 07 Aug 2020 10:06:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=zGNzDMtgwMSgmAFRgpJLjT+o9IjR2c/1gKwHb2BF5us=;
        b=mkcM7xiAr1mKAplxqn3ZtnE28sHWjgu9S2jonviQ0A/GgDiuPJcJu8n5mYZKSqeg62
         XFnrM25HsdtwGejqHweh0u5gYipMzT/sslDbPepKyF96lgo23lXbzFpm8J6aAqdXTaBB
         LivvQQ5TVN0acp8SUhi58JBkIEMlVzfC5X0pCOkppQtUf1a5sp8hlokXl4gt/VbvboPG
         xH4yvtiZnNF5POxb1RLFnlKwo3BGFdGYiCav7MPMHNuhZmgCICDFWgTSOVaSaJce4uRb
         IMW0GKY6+IMjdShYjQDLdjx1ur0WetJ9/8d6o7KAAt5c0qsxwYzaoAcL5qq8Tw2xBtjp
         /luA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=zGNzDMtgwMSgmAFRgpJLjT+o9IjR2c/1gKwHb2BF5us=;
        b=oaFRq2wN0K6Rlr+ZN43zJF8q55LaKNWKqaGvj+yrfGBYpqdCPK7BKn7WGwYIxSgK0l
         v+vecIqjqRjOOP5KtGDoqVMBplrymcLqhqCjH7ISBMUS02bfICq8G1oCh+xXm+g7TGNg
         WOnkr4Hg5m9c1i/lep+A54ILDneZC8S5qsriAd3NbDD441nkAZyXioRCUnnH/HaTFMLA
         M0IPtwBT3+ILfjYE2DKip/zxfdBuY4mOdJKbiTh4murjllsHpHJi7lElvJIc3Zv/VSW2
         9tqG+1gYUevPNgrIO3AmHmIsPN+j3T0Tf/u4cd64NzhOwRtoLxIT/GrCZ0J0VgmOJq78
         AUug==
X-Gm-Message-State: AOAM531F4QZAAleaW7fk/+vNx8PuqfwKv0RfQwYYTrMTfFxF49O1dj3K
        NaRjAGhFj5hZDwbGHZ4Z7GLElIirQlErHMfF9mI=
X-Google-Smtp-Source: ABdhPJwBqA8Q3xycvj7gFKodm4kb+mYefqzWRYBMX0W3aFwtrkeCewYAkBKUgyxljt0RIHrc98TNjSQlqO7DcO50PO8=
X-Received: by 2002:aca:4a96:: with SMTP id x144mr12050482oia.163.1596819981235;
 Fri, 07 Aug 2020 10:06:21 -0700 (PDT)
MIME-Version: 1.0
References: <20200807160627.GA1420741@elver.google.com>
In-Reply-To: <20200807160627.GA1420741@elver.google.com>
From:   Pekka Enberg <penberg@gmail.com>
Date:   Fri, 7 Aug 2020 20:06:02 +0300
Message-ID: <CAOJsxLGikg5OsM6v6nHsQbktvWKsy7ccA99OcknLWJpSqH0+pg@mail.gmail.com>
Subject: Re: Odd-sized kmem_cache_alloc and slub_debug=Z
To:     Marco Elver <elver@google.com>
Cc:     Alexander Potapenko <glider@google.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        David Rientjes <rientjes@google.com>,
        Joonsoo Kim <iamjoonsoo.kim@lge.com>,
        Christoph Lameter <cl@linux.com>,
        Kees Cook <keescook@chromium.org>, kasan-dev@googlegroups.com,
        LKML <linux-kernel@vger.kernel.org>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Marco,

On Fri, Aug 7, 2020 at 7:07 PM Marco Elver <elver@google.com> wrote:
> I found that the below debug-code using kmem_cache_alloc(), when using
> slub_debug=Z, results in the following crash:
>
>         general protection fault, probably for non-canonical address 0xcccccca41caea170: 0000 [#1] PREEMPT SMP PTI
>         CPU: 0 PID: 0 Comm: swapper/0 Not tainted 5.8.0+ #1
>         Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS 1.13.0-1 04/01/2014
>         RIP: 0010:freelist_dereference mm/slub.c:272 [inline]
>         RIP: 0010:get_freepointer mm/slub.c:278 [inline]
>         RIP: 0010:deactivate_slab+0x54/0x460 mm/slub.c:2111
>         Code: 8b bc c7 e0 00 00 00 48 85 d2 0f 84 00 01 00 00 49 89 d5 31 c0 48 89 44 24 08 66 66 2e 0f 1f 84 00 00 00 00 00 90 44 8b 43 20 <4b> 8b 44 05 00 48 85 c0 0f 84 1e 01 00 00 4c 89 ed 49 89 c5 8b 43
>         RSP: 0000:ffffffffa7e03e18 EFLAGS: 00010046
>         RAX: 0000000000000000 RBX: ffffa3a41c972340 RCX: 0000000000000000
>         RDX: cccccca41caea160 RSI: ffffe7c6a072ba80 RDI: ffffa3a41c972340
>         RBP: ffffa3a41caea008 R08: 0000000000000010 R09: ffffa3a41caea01d
>         R10: ffffffffa7f8dc50 R11: ffffffffa68f44c0 R12: ffffa3a41c972340
>         R13: cccccca41caea160 R14: ffffe7c6a072ba80 R15: ffffa3a41c96d540
>         FS:  0000000000000000(0000) GS:ffffa3a41fc00000(0000) knlGS:0000000000000000
>         CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
>         CR2: ffffa3a051c01000 CR3: 000000045140a001 CR4: 0000000000770ef0
>         DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
>         DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
>         PKRU: 00000000
>         Call Trace:
>          ___slab_alloc+0x336/0x340 mm/slub.c:2690
>          __slab_alloc mm/slub.c:2714 [inline]
>          slab_alloc_node mm/slub.c:2788 [inline]
>          slab_alloc mm/slub.c:2832 [inline]
>          kmem_cache_alloc+0x135/0x200 mm/slub.c:2837
>          start_kernel+0x3d6/0x44e init/main.c:1049
>          secondary_startup_64+0xb6/0xc0 arch/x86/kernel/head_64.S:243
>
> Any ideas what might be wrong?
>
> This does not crash when redzones are not enabled.
>
> Thanks,
> -- Marco
>
> ------ >8 ------
>
> diff --git a/init/main.c b/init/main.c
> index 15bd0efff3df..f4aa5bb3f2ec 100644
> --- a/init/main.c
> +++ b/init/main.c
> @@ -1041,6 +1041,16 @@ asmlinkage __visible void __init start_kernel(void)
>         sfi_init_late();
>         kcsan_init();
>
> +       /* DEBUG CODE */
> +       {
> +               struct kmem_cache *c = kmem_cache_create("test", 21, 1, 0, NULL);
> +               char *buf;
> +               BUG_ON(!c);
> +               buf = kmem_cache_alloc(c, GFP_KERNEL);
> +               kmem_cache_free(c, buf);
> +               kmem_cache_destroy(c);
> +       }
> +
>         /* Do the rest non-__init'ed, we're now alive */
>         arch_call_rest_init();

Anything interesting in your .config? The fault does not reproduce
with 5.8.0 + x86-64 defconfig.

- Pekka
